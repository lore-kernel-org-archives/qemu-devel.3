Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3554C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 04:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9cVS-0004wz-Kv; Tue, 29 Apr 2025 00:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9cVO-0004wp-Uu
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 00:23:39 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9cVL-0001eb-Ta
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 00:23:38 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so642598466b.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 21:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1745900614; x=1746505414; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LAXlAtPGJwDWF60WvcD+w8wIUKAYpGZYJ6F44kFLy9M=;
 b=Q0Qt8/GjYIK2VX9FE+ZIM5XN4DGbrXZX7ueGRs6oUGfF/qflD/XKPxrpD7OwMmEFf4
 x/ki/AQ/oLlwn5GaifmUeVXmyeTALF8HpnAFkR1RKC4IawHiFZm60yl0c6Y0ju/xkzDd
 7RrvWalG7mNgG3yG6zYBwPtGu1vsSb9pDkSvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745900614; x=1746505414;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LAXlAtPGJwDWF60WvcD+w8wIUKAYpGZYJ6F44kFLy9M=;
 b=f9rkfKkaNKD3//G1SiHKhLz9ajEai+yZhirAtYtWc6bOIAc1LOCxqBec3YGDilxTo5
 Mlukyn624z/4PUok648kth1TnXRNnwXUEWr+BDfF7u/QrTYgpW2EraCBGqLpNkIbYnSW
 9P2WiP8IdGtc077RuDX24CJ1JvBLmVW9vgg7A4UplIfvPPi4KjVE/wxdoZqEcFbDaw46
 8CjNh9ch0t3Gf7hXPxGgDloiiw8uvbywvZyE/2hm/rw0H6K5+8re3wHAqCET/df0f99L
 hznH2xXXw5uzzu4ypzujyjpkcPFMABsgstMDzM4xLFd/SALuDq/bWECfW9Uzu4FIGZ9+
 Iqvw==
X-Gm-Message-State: AOJu0YwbwzEpXnYnuRETgHX5lbw6CC/ANtKODmz6I/pA33ZbMgEjoJP/
 pVGBSIzgnjPJ8GCKgIXZ/6ecuJvFgYoQVg2Zyc/UGM0x0L40lWZ7XjQmwknYYNQdopQvPoF1irv
 rjLPAfT3V+GgCXB9vC9W1jJIVMh4=
X-Gm-Gg: ASbGncuRkFfduqKVlgM9JLJGvJFkJ37oU/nZqztcRBI0jkKDejAa6nGjLsEJcPrnWlq
 xgGmbbDGbcPOmGifCxJPhvl71NDt3PR+qaYt2C3FfCy1cYCPqh90Wd3LbzuUhwJF8LxDTPEAYjs
 /DzVI56PyU4LRX3G7mzs12RA==
X-Google-Smtp-Source: AGHT+IFiHKeiP4AmG5wPoXM/i8I6fjVlE0D2oMFJECv40m+rhA976I/QxDqiYNG4SfIHxU/1PR4LnFnT6tRG7usTeFk=
X-Received: by 2002:a17:907:1c18:b0:ac2:a42a:999b with SMTP id
 a640c23a62f3a-acec4ed4b9emr189306966b.52.1745900613477; Mon, 28 Apr 2025
 21:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250428073442.315770-1-pbonzini@redhat.com>
 <20250428073442.315770-23-pbonzini@redhat.com>
In-Reply-To: <20250428073442.315770-23-pbonzini@redhat.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 29 Apr 2025 13:53:20 +0930
X-Gm-Features: ATxdqUGdM-eoruqhOibyokScm8W76ty5Sdz_iXLX49A8eKTQwuKZegk20Vcfplk
Message-ID: <CACPK8Xer1VL-=eSwZ=4cLDu6SqohejLs28=_hp44W04Dz_S5ug@mail.gmail.com>
Subject: Re: [PATCH 22/26] target/riscv: convert TT C906 to RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

On Mon, 28 Apr 2025 at 17:10, Paolo Bonzini <pbonzini@redhat.com> wrote:

I think a typo has snuck into the subject here. s/TT/Thead/

>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/riscv/cpu.c | 61 +++++++++++++++++++++-------------------------
>  1 file changed, 28 insertions(+), 33 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5045ebc0b70..f3af9643af4 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -500,38 +500,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
>  #endif
>
>  #if defined(TARGET_RISCV64)
> -static void rv64_thead_c906_cpu_init(Object *obj)

