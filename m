Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F39C3601A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 09:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0zfg-0002MN-Qm; Sat, 05 Apr 2025 05:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0zfc-0002Ei-Gl
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 05:18:32 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0zfV-0008M9-Io
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 05:18:30 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2255003f4c6so26478815ad.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 02:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743844702; x=1744449502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CwDVB2zqCipfAqxeZiYPIYy9g2myx+HcuNJ5Z7jMIS8=;
 b=Z53oxZUwSEqIY+F4GbRdyvwYXVaRTbPgAbKvtvtMDZS7sblmGCvXo+ZK7v6xsqvDiQ
 jU7qmLusWfclHW4TbATLc6THDu4LnGX2GK8mBQhwJVoEiso50bfRP8oBayaLvrkjfZ9F
 Eh83I+g2goEzYwd2XmHy9weBIVXcI/BWlBwvUu23PavJ/qFHOcd4zAxTtdo5kFNYbqrK
 Xl8BzTgM+MxK5b3tBZGW5sFDpqeuRGPzujH+kalAWQcHpN+Muk2tQXhCAah2Ri4WRJKm
 UhPVaToZ8C/gCl7Q93oYKN4IcdoxoRy3xYD9M+G1mUnVQ2I4sjUtB8/bvVfLkQrGcmTN
 P0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743844702; x=1744449502;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CwDVB2zqCipfAqxeZiYPIYy9g2myx+HcuNJ5Z7jMIS8=;
 b=pD6oUQoviKqGEWGclM84kuq3U7mBfqbrGolmmN5UHzMFeWv5JtPz8TfmPkhM1s5TOT
 +SpBJyyS9OiAHrdTT3WLEwTWsNXVZDCDuqi8RW1SAQ8Is6Hvk1ftoCtEGJb1nbG102tc
 GeICF9bl0fffbrh3K9nBcBrCJQOkkNAM0f4oTsneZo9TgpDICHBy4kpJQQuPAXTwpveB
 PuUhte9PNTMRUFGQxOFE7iIMJr2Xq2HNcEOHnRLelpFfrRn+VzGoLF6rkOsCHS8gp9T9
 hFhrawRamJMAuPNX2E8Zt63N0KT8paNse48T8TWJ+9C7xnHRiUymsUNo4bkHvHHKcsqx
 rQUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVgRy5mBxGlb2nc+34n9jRIZ/Rgigv2ONrF6GEI/KTe4tBqkXLJssL/D+Yjwpq/hD+qdeqvLJQZJJk@nongnu.org
X-Gm-Message-State: AOJu0Yxu5KHj09xINUbd5OOPIrn42obymmk82cOsA2YHUqDFKah4jgND
 CisouWVMGl9aSluL0t5i4fRP80Q4Zrm4j0pYL9M7mIVGpZGlCPY6BZtLQcLP0EE=
X-Gm-Gg: ASbGncsnl3+IrkRXPGMDz4Llz63yEiCufQe4H3qV4DYB66ghmD3YTlwfM676w/rIVrh
 pa/5mUiO7XDYQ+B9YqyUVz5I4/vN22uT9xLrFRevdn+Db6qpgZKRkNLSu1Rkk+VmsQAe8ddBCCs
 EyYD8hpgM6osi5dVOFlA7LlXJaCtMgxhbJxoDrz/VO4q1magIfACO1t+XEor1DNgoVi6+t2EZCM
 BgnPLGTKQEy0aH97afU7xRBt6cDIhcf8idJ+lFkrLLUsyoSWcxWdsMknWOIpqVx3+tu7vqXr2Tz
 lytO70oy0VyQ8x5hbV1VaQ6iNcIJStMmRCOgTMSAd60dcrJDczLlA47EKTcl
X-Google-Smtp-Source: AGHT+IH2YvloWLMM6NZ2ws7N++/Y89ElHtyynUgzwUTCdsFTTFHmLuxyUIMLlvg5LN5BSti/36bJxw==
X-Received: by 2002:a17:903:1209:b0:224:76f:9e4a with SMTP id
 d9443c01a7336-22a8a05b5cdmr85417545ad.14.1743844702561; 
 Sat, 05 Apr 2025 02:18:22 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297866dcd6sm45788425ad.189.2025.04.05.02.18.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 02:18:21 -0700 (PDT)
Message-ID: <8ede9d37-1194-48ad-b053-9145dd414895@ventanamicro.com>
Date: Sat, 5 Apr 2025 06:18:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] target/riscv: rvv: Apply vext_check_input_eew to
 vector slide instructions(OPIVI/OPIVX)
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 antonb@tenstorrent.com
References: <20250329144446.2619306-1-max.chou@sifive.com>
 <20250329144446.2619306-8-max.chou@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250329144446.2619306-8-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 3/29/25 11:44 AM, Max Chou wrote:
> Handle the overlap of source registers with different EEWs.
> 
> Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
> Co-authored-by: Max Chou <max.chou@sifive.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---


With your co-authored-by tag removed:

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/insn_trans/trans_rvv.c.inc | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 2282b89801c..f397ae46446 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -639,7 +639,9 @@ static bool vext_check_slide(DisasContext *s, int vd, int vs2,
>   {
>       bool ret = require_align(vs2, s->lmul) &&
>                  require_align(vd, s->lmul) &&
> -               require_vm(vm, vd);
> +               require_vm(vm, vd) &&
> +               vext_check_input_eew(s, -1, 0, vs2, s->sew, vm);
> +
>       if (is_over) {
>           ret &= (vd != vs2);
>       }


