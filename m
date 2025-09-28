Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9833ACAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 23:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v30eX-0007BK-FQ; Sun, 28 Sep 2025 19:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v30eU-0007Ad-NW
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 19:17:58 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v30eM-0001md-LZ
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 19:17:56 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b3d5088259eso109044866b.1
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 16:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759101461; x=1759706261; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wxomtfJoCZ9M1T84R6Qc60DCH+eZudgpalAPz+NzvPg=;
 b=T/nzWpdluUscb0ljbTdJ5L+eP/35/sY8Da2EbjCjVjDhyf7xr3UTor+Wve0JfdjACL
 YNmyxKYBQre8bKt97tm8z7iVf4iqsKVpb38nxMLHJBPAvlkSWAzdFx8UkUrkhDYglSbP
 STEYr5eiDrmNgczA96Za5MJlqfKM2SBY2R0frdZWJ2DqH6Jrc+z9rivH3JcQgJNYYiza
 rFPymi0fwCk3lezfF/vf48LPGCwfv+Xz61BVu7zpOSWmD35nAu5/yF/OQXkKHZE0JTeT
 ZvEOwClDjTxqQIoEbE6qVPR/pde40FqbPTjMhJuxVyoeaCD9P6Spi/cNkS0U3y+9mN/4
 qaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759101461; x=1759706261;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wxomtfJoCZ9M1T84R6Qc60DCH+eZudgpalAPz+NzvPg=;
 b=XffdtqrFhbPYLz4xw/Q94EXPam42l0sHu0u4jwDVle3JC1m0x4aJ4mJBy5dEzISR8T
 NZSxfWX8GQUS6kqE/Ph0OzVx8DIzBqx9fYvVMMH/SDdOF0OmpRr1BSyjvHo7qSZrAAMs
 IS8OB4tqLvM/vQPQR2rsGqvfPz3aCshpAV03ThjIhj1UkjLTTEgnbVYPzxi+yEsnkM52
 IpesAGSAvAJPmuvp3lyWyb88ZBIDRZqqmilw7zJxXabv5mfJxoW/+FTn8AWFDB7KSV/E
 YcYEwLGofVVOcgYM08U8ZpdKdTG/EnpQqlWCyV3imZQqlJYsjS3hWeGy//VULFan2Kwj
 s2cg==
X-Gm-Message-State: AOJu0YwREN6fdkgdC4wGJcUnaviFKzvh/nvWybDfGDstwkDL7ZpKTbPB
 gi0WyK8bcd1kYmJvQMIJKgqmQIrMfUWaI+nDQ7Lb3okyJFn1+ajhhJ69LwlUqRpSKvHgJ2oBdxk
 mRZJx+JFhkfAyaz/GPGEgWVnZCzdrcMI=
X-Gm-Gg: ASbGncvaBAfgdpqfaQiVNzuSpUTGr/6utySMNkbTCShaOqcyAyi683aVTnezkSgFsyH
 hKi+dqgs4btQQsYiJR5f0vRby/TIuLisyyJCpyGAbqYoKAYEZbFDQW0dnUbYtTeIECI+PeLJNWD
 4ovs4uDzexExIc8GHJiLnwkAdKLsXjET8gGPiOkxreQq/lSjUShdLgwQEm2ezq8xmcPb6JAti+T
 /yjiNQUL4e7TgipnR5hrVUleWRIFMPepEN5yeOg9cxnDHJe
X-Google-Smtp-Source: AGHT+IH24gK1GUCVPzlKhT7LBeqpojKULRjlBVv7P/OzPC+A0M2xCOzm2lBGUW3QSTOxKMZgbWubkeZo3gI1yF6DxtA=
X-Received: by 2002:a17:906:b6cf:b0:b3c:76a4:deb6 with SMTP id
 a640c23a62f3a-b3c76a5197cmr353698666b.25.1759101460572; Sun, 28 Sep 2025
 16:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250924164515.51782-1-philmd@linaro.org>
In-Reply-To: <20250924164515.51782-1-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 09:17:14 +1000
X-Gm-Features: AS18NWCh_CR5zQwx571dTBqLnLhT-_1gOve0L8wVrvoBV3RKDlG07d7YIA3q1v0
Message-ID: <CAKmqyKObSFtLFoJTscD4YNUdDjBbPCRwmZRvRKzJbwdhNCA1eA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/kvm: Use riscv_cpu_is_32bit() when handling
 SBI_DBCN reg
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Sep 25, 2025 at 2:47=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Use the existing riscv_cpu_is_32bit() helper to check for 32-bit CPU.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 5c19062c19b..187c2c9501e 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1588,7 +1588,7 @@ static void kvm_riscv_handle_sbi_dbcn(CPUState *cs,=
 struct kvm_run *run)
>           * Handle the case where a 32 bit CPU is running in a
>           * 64 bit addressing env.
>           */
> -        if (riscv_cpu_mxl(&cpu->env) =3D=3D MXL_RV32) {
> +        if (riscv_cpu_is_32bit(cpu)) {
>              addr |=3D (uint64_t)run->riscv_sbi.args[2] << 32;
>          }
>
> --
> 2.51.0
>
>

