Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CE6C0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 00:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdewK-000789-1o; Thu, 30 Jan 2025 19:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdewI-00077u-7Z; Thu, 30 Jan 2025 19:31:18 -0500
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdewG-00059H-O7; Thu, 30 Jan 2025 19:31:17 -0500
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-51640f7bbd3so467223e0c.2; 
 Thu, 30 Jan 2025 16:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738283475; x=1738888275; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PoeEDhGBBOdjh6ZT/msKo0/36txpP1py5hALGYifhVo=;
 b=MapzqC9LSDMMOOKNZ3gvvfVfdw9KQNEC5VA0ilMUbnpc0l39w5lR7IkBYxn1SVHPzU
 S177LWL4ukI6PjsxYujkMCg+TAD3wTSINoZ3iufgE2DEFmjL7p06pj4GS8St686a8N4C
 FXI35t+HSH3vIaLGw0816RzIlRTXQFrlDrBTkp8Et1OyU1yHU4saSAi7NUYY+5Gm3UQr
 U5eiK189knDF8UKOshf6pknUtlXwV7WcElCh5KQE4/4LEvnQnkBXxqlXNqrGVGH3HqZc
 xI88+GoawCKU/dxrj7irJ5v31fdeecW1MYvOMGLxY+Nwwlr1865IQ+Gs5+eA/muotoPX
 gvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738283475; x=1738888275;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PoeEDhGBBOdjh6ZT/msKo0/36txpP1py5hALGYifhVo=;
 b=f4rTihKd+qh3Q4Hu53SpNRowT3sQ2sgcO4SCX6uGfsFFd4SChQycuLZ1x1rzAtE0Yi
 vBQIlR3J+8iAS5k4QEVFrim/7qh1zcMHL4C133SmItReStPWo/WH2Evybv1fap9L6LXu
 tubkRabu0uuKF/Wh5qJRkLwikGYSvt52f7/RoEyQttayMFTX4EfsOj8+CphiDUfF7Q6+
 iEtAhYI4gy+PwFqKsdaPbnl/ZOEyolywJxlV+BQxLZmwCQiCmriDRIM0xDsduNOEMN6U
 bXPE7nX3kl27w2vqiVnbUDzUBX3yDSJ5ggkXsKHOyok1XbJjNGHRI5BWtqTZWfgzsFF0
 Wj2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNVTUwpmMQKxnKLhXtn5KVNpVB1gfqN/vy4EQHSKJnGtOzV0MAEW6pXao6BsPm6HJMXHy8kSljCIlE@nongnu.org
X-Gm-Message-State: AOJu0YyuStYx5U0f0Bz1BPVMCvAUVxagj1HIAHdnQUHQ4V1lxvR47PqZ
 FbokCgLykeB5I8Y0XeBJI0B/26RrcLKQzwlJdEvGVkuH/vqXbOFQxdMxTAya90IUZxObeLfByy+
 hRUlFBugJ6yVzLz4yLsc2ZBBRs/M=
X-Gm-Gg: ASbGncsy8GOLC7452tfHqLuf1kkHslGhmbUmjwYbbODB8LZuQudhoHeFn5W8Q7nIROz
 F/xPKRCROvGI150MSwYvPWZ9/3/PkPVkGQeI6vHzZMLMu/ssq/X8v0LDiM7qnVKC17HI/zU3a6v
 M2f4SOlG3+LerDBdV59tB76mvQYpQ=
X-Google-Smtp-Source: AGHT+IHb5KQEyylKPqJ/ZnpSEMOoU2C/pTq5DfYZXhw2Gipa3YVBVXGwtFB6RLTYiB0jqVquVDDA7FmZEafxhkIj/M0=
X-Received: by 2002:a05:6122:c92:b0:516:c0b:8bfe with SMTP id
 71dfb90a1353d-51e9e30a69cmr7551688e0c.1.1738283475041; Thu, 30 Jan 2025
 16:31:15 -0800 (PST)
MIME-Version: 1.0
References: <20250115141730.30858-1-jason.chien@sifive.com>
 <CADr__8onD=_FYyp03y+-fB5wq_8kiOrfydWx9_3BWwpWntpKfA@mail.gmail.com>
In-Reply-To: <CADr__8onD=_FYyp03y+-fB5wq_8kiOrfydWx9_3BWwpWntpKfA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Jan 2025 10:30:49 +1000
X-Gm-Features: AWEUYZlzV9bWazRSUxMzvTaq8lVspOZ_BHq8ufG0DVsiWsFF8Q-gWM6yG1xHKIc
Message-ID: <CAKmqyKPhqS3M8=E_jJNhcPcpFUjGvEWZS1e5Kb3=Ni-0zk_qoQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] hw/riscv/riscv-iommu: Remove redundant struct
 members
To: Jason Chien <jason.chien@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Jan 22, 2025 at 6:11=E2=80=AFPM Jason Chien <jason.chien@sifive.com=
> wrote:
>
> Ping
>
> Jason Chien <jason.chien@sifive.com> =E6=96=BC 2025=E5=B9=B41=E6=9C=8815=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:17=E5=AF=AB=E9=81=93=EF=
=BC=9A
>>
>> Initially, the IOMMU would create a thread, but this thread was removed =
in
>> the merged version. The struct members for thread control should have be=
en
>> removed as well, but they were not removed in commit 0c54acb8243
>> ("hw/riscv: add RISC-V IOMMU base emulation").
>>
>> Signed-off-by: Jason Chien <jason.chien@sifive.com>
>> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Please use a cover letter for multiple patches in the future:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#include-a-me=
aningful-cover-letter

Thanks!

Applied to riscv-to-apply.next

Alistair

>> ---
>>  hw/riscv/riscv-iommu.h | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
>> index 9424989df4..fa8a50fa24 100644
>> --- a/hw/riscv/riscv-iommu.h
>> +++ b/hw/riscv/riscv-iommu.h
>> @@ -58,11 +58,6 @@ struct RISCVIOMMUState {
>>      /* interrupt notifier */
>>      void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
>>
>> -    /* IOMMU State Machine */
>> -    QemuThread core_proc; /* Background processing thread */
>> -    QemuCond core_cond;   /* Background processing wake up signal */
>> -    unsigned core_exec;   /* Processing thread execution actions */
>> -
>>      /* IOMMU target address space */
>>      AddressSpace *target_as;
>>      MemoryRegion *target_mr;
>> --
>> 2.43.2
>>

