Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6985BCCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 01:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIzJo-00044B-BT; Tue, 11 Nov 2025 20:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vIzJl-00042T-9l
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 20:06:37 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vIzJj-0000Uq-PJ
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 20:06:37 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-640e9f5951aso349347a12.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 17:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762909593; x=1763514393; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvhMcUh+UpChbQh8PclRGyUbOeZNkjouJKlydi97Kug=;
 b=bEMtIoaOmkD3Mwh58mRwJ/+PNKYe5MYhImrrwLi6vx10+nTkv0RJ48yIFZPiNb2yBT
 EyIUT9WEoVCyKRul5NPc8d4u5bpjQvAUcXmRv1wjeRlBl2/CEp2eHVvB7E035GDBevuP
 MuiG8C0nIdVqTCHkO2/donfHEY8ZdO0R/tmkkUU+Hmk+eacSlPwEMH2PFDuZoqHAuq1S
 HVU41lDxTtUiXfJhRY/hAd8b9gEcrXkC/e9B3ilSB89lHnVqBa7PF9PwDdQqwegFEqfQ
 dY/iHNOtJHRUVc3rFobAmiTO+K4zi+v2tQUO1U+Azu5YBxHkuRE8Xq7ApwXlFdi9k0L/
 DkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762909593; x=1763514393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XvhMcUh+UpChbQh8PclRGyUbOeZNkjouJKlydi97Kug=;
 b=lVhirLP2yzmOWgKgrI8iL7v1PaAGDzfJznLML9eEaYTv4MnW4mEojuD/WED3w4eLHA
 Q2sUd49qS6yrnW1bYuXNCtD5tiEAz3kTSHD7hiFkxkfuDoD6HCfcnhwR3wc2v5LOnptQ
 8YYHWAE+/8foYBIXDuDwrEzP4RO/LSdYeFtGEpIS4ywDTGz5oBW9g6KDBu4GAgNqzWGM
 v66QA++YJJv0UIC9Egl16eBoMwlidA/Fwkln1awxoGkK4MlMqqUQ6cwTtVOb0syrrMpQ
 v7nUExvPrpSC1Lv8TErhiUNCS22Pvf3Ai82ONgFy6/n0AqTMBM1dUyNzzSWpDBX9iNEd
 AOKw==
X-Gm-Message-State: AOJu0Yz/UX6Y7fZJyPsyVgwk8yqpUxBXqmiJVYLPTepNxaekEL7ofAG3
 Uj3JrTYsaHd1QXr3EIzws3uHeSSG6JB0BKYZA/7q7Nl/kGcH1+awkA3f2W3siqWMGzi6szMn1no
 szK2i5MKyEv6+IoqMS/NX362ZZ2haRjEadw==
X-Gm-Gg: ASbGnctk0k+3haZdzG7ML5jidwYMwp/xeHDolE4w1FaLz7PKtf3E6kGe5yH+3UlL1QV
 /yRM9NlRBZpBKcUh8/wgNV5VfQQ8VMic+LpnJ6fzNcSAbpOXRbFe4hHvBy75xzrNWRBXVPOeM/f
 /SyjKRf/ayJ2+gM9BcvUaL4U69WWSifaxTsQziWyXDfq2ze1Z8gKsmM77j+SopACJr9kqw45LXn
 K8Px3YlhHxPXFzlJh9ejbZ2xyR4OrjOPDrw4ULIqK3OjvJIYa5CeTpp2IRweEHUqxQKQcA9a03M
 HVMq2jJ8Z1elN2Y=
X-Google-Smtp-Source: AGHT+IHwiNkthort9wNDYNcLBlZfx6ZsNZlqD5hnI7FfjZLSF6rnpgGNCSmEJhUuwC9vhqtvHnu88bzXVWWrQU0EAjg=
X-Received: by 2002:a17:907:c1a:b0:b73:1b97:5ddd with SMTP id
 a640c23a62f3a-b731d1bff6bmr568082666b.8.1762909593125; Tue, 11 Nov 2025
 17:06:33 -0800 (PST)
MIME-Version: 1.0
References: <20251029-n-novikov-aplic_aia_ro-v1-0-39fec74c918a@syntacore.com>
In-Reply-To: <20251029-n-novikov-aplic_aia_ro-v1-0-39fec74c918a@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Nov 2025 11:06:06 +1000
X-Gm-Features: AWmQ_bkZr7QiJOliWWv6UZQYjUkEazNRc3D--mIs0nhUrkqptE3eFde97147qkw
Message-ID: <CAKmqyKPtufR8H4YiBrVerg9TGPVKfMRxnq1ZGQoUc0rQRd2W8Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/intc/riscv_aplic: Expand AIA target[i] source
 handling and refactor related code
To: Nikita Novikov <n.novikov@syntacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Oct 29, 2025 at 5:20=E2=80=AFPM Nikita Novikov <n.novikov@syntacore=
.com> wrote:
>
> During the debug of APLIC I faced with the problem with target[i]
> registers of source i. According to RISC-V AIA spec v1.0 ratificated on
> the 12-th of March, 2025, the section 4.5.2 ("Source configurations")
> says, than register target[i] shall be read-only zero when interrupt sour=
ce i
> is inactive in this domain. A source is inactive if it is delegated to a =
child
> domain or its source mode is INACTIVE. Currently we checks the source sta=
tus
> only using sm =3D=3D INACTIVE, but we do not check whether the source is
> delegated.
>
> This series of patches expands current active source checking and reduces
> code the associated code dublication.
>
> Signed-off-by: Nikita Novikov <n.novikov@syntacore.com>
> ---
> Nikita Novikov (2):
>       hw/intc/riscv_aplic: Expand inactive source handling for AIA target=
[i]
>       hw/intc/riscv_aplic: Factor out source_active() and remove duplicat=
e checks

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/intc/riscv_aplic.c | 66 ++++++++++++++++++++++-----------------------=
------
>  1 file changed, 29 insertions(+), 37 deletions(-)
> ---
> base-commit: d1bf06e8cc8197a2b18dbde820d957a51899d374
> change-id: 20251028-n-novikov-aplic_aia_ro-1baa353cd672
>
> Best regards,
> --
> Nikita Novikov <n.novikov@syntacore.com>
>
>

