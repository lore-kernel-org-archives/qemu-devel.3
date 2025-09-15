Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24C6CAC58E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 04:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy0j4-000659-LD; Mon, 15 Sep 2025 00:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uy0df-00057R-2X
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 00:16:29 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uy0dV-0004TO-7g
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 00:16:26 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b042cc39551so622562466b.0
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 21:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757909771; x=1758514571; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uiP2a+PQHrai/8lzBHIJPwicEm/+mdnWjTR+mliZyWY=;
 b=cR7mnC4mqGxJ+pGx8g5Yqff5a656Bfunvk2SUwSI6pQ6WpbrFAZZLHknVRF0rJC7mY
 7Tm8UT5z9yNkr6Qt6bFyORNiEKdSByDnfjQxQuNihZaK7+zZXFtFkefYL739b+YmWJ8H
 MJLnx2D7lHY++3AEyBZMbNhRxy/cvDnZ06DF8j6wlXc+9hgalf+XEOVcg9N4v9vMuqoS
 9KqIzRhR2dJ6C1bo6kvvfqYNPXmXuG4EmlGA/0SMBZBa0B7jlwtAKIcSy9XTSEXwEiuf
 aYaVLdiqnV3z4/J+ZdiTtDZ7MsS1bFpjYhs0HKz8Vhd/6wExkaDvEE6+qZei6KCNlaJs
 +z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757909771; x=1758514571;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uiP2a+PQHrai/8lzBHIJPwicEm/+mdnWjTR+mliZyWY=;
 b=eOWTLQaSoF8lmZIB5EvWCkL219wjblcUqzXcstxN6NkXK6IexNNJ8HkSHAqKtjiC1I
 CL+RMyfwFWVOfltihws3OptJMEz789I/amkRxG6snJtWz2wzjN3VcONkHl0jNZ2CjdPu
 FSg3v1MIpX7n55izrwbi6C0ZX/FWEhoy3VvjuobdHfWVovahwsc3otMeMB1QZ0bv4tCw
 TBPmYAIJnkLUN5O/xgjHRfCXuNFNUiKHu4NTpIW/SDNmKLwjhT/0/Co3h8L6bfa+Cnh4
 LB5cDGwlRK0MXDADmrsydvqcty4rvWXopfAypf3lFi+oMr6N0xF6j9p8RZWryuC8NddB
 9MNQ==
X-Gm-Message-State: AOJu0Yx3/ct9wZx+Egjt4RpjauviZVrnwafu/mBGergrKfZe+EEeDbbq
 rokuBPGb0PHJm/P+8CDLWeWNQrtkgXETElUey18FRYN8JiDVdJ5036fT1P7BboA4Y7RDfMmmQkP
 Z6jWatHnvy8Q0Jhi/z/Mw/6d/zHlUjtZifQ==
X-Gm-Gg: ASbGncsD3IpeJf0C0aTSDF4KtnsAWxx7L4FixE6x/WG7bVq6SXicuAvxFnjhNCNK13r
 onm1SumFCUqHdFug4dgM95YHpc1mGVbY+p8JLO2srU0WqKI2eNe3yt7kI3/nEAxpqPhCTVBkTkU
 SltnoOlAZ4ERhvFkg0dOHEwfwTxm/fuX3DpV1G4QdmPGk0aXt7/ud8Tctuiz0A36b19kzH+snTT
 3mj9WRnEU+ShqEONLxObn5BVs6Au3/hwTvTxg==
X-Google-Smtp-Source: AGHT+IHpUmeo8u3894+hkt5PK10gZVkp5DN0SvPvBdhLFSVAfQdGwPcUzEXWYLgtUQ8903yWGqJsbFpm5tsQof3BB1s=
X-Received: by 2002:a17:907:980c:b0:b07:6444:a6dc with SMTP id
 a640c23a62f3a-b07c3878986mr1149830266b.56.1757909771382; Sun, 14 Sep 2025
 21:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250911-timers-v3-0-60508f640050@linux.alibaba.com>
 <20250911-timers-v3-1-60508f640050@linux.alibaba.com>
In-Reply-To: <20250911-timers-v3-1-60508f640050@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Sep 2025 14:15:44 +1000
X-Gm-Features: Ac12FXzsckx6ShqPZ0kxvTCOndJBIxhS2-h73VvQ0fwi39G3nuLwtOSV47KjXhA
Message-ID: <CAKmqyKNSzwrvB-DnLZrMvA-he00CqNPkqKg_e4-U2Vcp52XVYg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] hw/intc: Save time_delta in RISC-V mtimer VMState
To: TANG Tiancheng <lyndra@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 11, 2025 at 7:58=E2=80=AFPM TANG Tiancheng <lyndra@linux.alibab=
a.com> wrote:
>
> In QEMU's RISC-V ACLINT timer model, 'mtime' is not stored directly as a
> state variable. It is computed on demand as:
>
>     mtime =3D rtc_r + time_delta
>
> where:
> - 'rtc_r' is the current VM virtual time (in ticks) obtained via
>   cpu_riscv_read_rtc_raw() from QEMU_CLOCK_VIRTUAL.
> - 'time_delta' is an offset applied when the guest writes a new 'mtime'
>   value via riscv_aclint_mtimer_write():
>
>     time_delta =3D value - rtc_r
>
> Under this design, 'rtc_r' is assumed to be monotonically increasing
> during VM execution. Even if the guest writes an 'mtime' value smaller
> than the current one (making 'time_delta' negative in signed arithmetic,
> or underflow in unsigned arithmetic), the computed 'mtime' remains
> correct because 'rtc_r_new > rtc_r_old':
>
>     mtime_new =3D rtc_r_new + (value - rtc_r_old)
>
> However, this monotonicity assumption breaks on snapshot load.
>
> Before restoring a snapshot, QEMU resets the guest, which calls
> riscv_aclint_mtimer_reset_enter() to set 'mtime' to 0 and recompute
> 'time_delta' as:
>
>     time_delta =3D 0 - rtc_r_reset
>
> Here, the time_delta differs from the value that was present when the
> snapshot was saved. As a result, subsequent reads produce a fixed offset
> from the true mtime.
>
> This can be observed with the 'date' command inside the guest: after load=
ing
> a snapshot, the reported time appears "frozen" at the save point, and onl=
y
> resumes correctly after the guest has run long enough to compensate for t=
he
> erroneous offset.
>
> The fix is to treat 'time_delta' as part of the device's migratable
> state and save/restore it via vmstate. This preserves the correct
> relation between 'rtc_r' and 'mtime' across snapshot save/load, ensuring
> 'mtime' continues incrementing from the precise saved value after
> restore.
>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/riscv_aclint.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
> index 4623cfa029365c6cbdead4bd4a9f0d8b9e88b939..318a9c8248432a8cd4c3f3fa9=
90739917ecf7ca1 100644
> --- a/hw/intc/riscv_aclint.c
> +++ b/hw/intc/riscv_aclint.c
> @@ -323,9 +323,10 @@ static void riscv_aclint_mtimer_reset_enter(Object *=
obj, ResetType type)
>
>  static const VMStateDescription vmstate_riscv_mtimer =3D {
>      .name =3D "riscv_mtimer",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .fields =3D (const VMStateField[]) {
> +            VMSTATE_UINT64(time_delta, RISCVAclintMTimerState),
>              VMSTATE_VARRAY_UINT32(timecmp, RISCVAclintMTimerState,
>                                    num_harts, 0,
>                                    vmstate_info_uint64, uint64_t),
>
> --
> 2.43.0
>
>

