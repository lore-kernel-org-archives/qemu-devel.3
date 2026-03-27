Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947E210F2843
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w692M-0005gm-Mk; Fri, 27 Mar 2026 11:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w6924-0005dd-EY
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 11:23:33 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w6920-0006Jk-FE
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 11:23:30 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2c107ef474fso3864335eec.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 08:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774625006; x=1775229806; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PzJcmu/U65FU4wQTMalP+dP1gUaMd8JFyXaRRb0LPKo=;
 b=OofQAQRWVprCDkZ98kqt4LWTVLuqdlJSbc8BahfMER4WSlmzY/U+eN9fK9eVt1VUcB
 RvDCs1DPfpG1bcOGmC7d+CScnAU3nZfZM5ZwC1FfQTR/Yti2S1pzOo7TfsTYYOKVswSw
 /SBNR4Y309fdHsnpL5SzgneoQn0e3MePhIePy2byzKBJ0zC9EvHcvYpWNdeLJzCPPVa7
 YcIu6aXIIhtM3cO+Od7RwRTsGt6Lt+sf3NNIJPBp9UAEpifKR7dqNSfhFxsest8rfvd3
 OPLhjfZVyfB3sp/1eid9YPNKxwE7D30z0OhhPqmd9JgYIiewHCCxXBQaieNcct542Eqh
 JiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774625006; x=1775229806;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PzJcmu/U65FU4wQTMalP+dP1gUaMd8JFyXaRRb0LPKo=;
 b=IO8NXIHwEmsJTqfn4vCtqL/rmYxL755fjyVzTimFp/hRd6lqLv6T9HNitLMzPhAqBJ
 OvOobBjSQlrqMKut84JFMgZ+PAJZQ2y1BESqThBoQ0U+oU3yPGrjlRY/lTTi0kOs47tU
 CwKE/OFsKXmqOwE9wxpe0nWlvS+Wg/qBxHQ6pmRmMuLTU+lucpcV2HxT1RDsScNfz7Dn
 eiAFPENtm/X3ivYPiHRdWYjOtaRxRvJ1B2EXEpZXD1MUEwWZjAIUqNZQLujSTsrsuoBW
 OskcV8tamdXxmF2uxILfCMbxs3tKUg6IU2EfphyYy1l6yiNEC4ez7Al5uutLyhImlTZg
 UOaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvduR0Iup4EzvSQ+XYAeyasDactQ0bda+g0OrPu5cdInQzd5m+BReSsg4/6wgEjb5YqIiF8l3kH1Gh@nongnu.org
X-Gm-Message-State: AOJu0YxV1GMZ8vKjuE5RE8j7gPmaaQSlp8BPvh91F1dNtBcduXSoesRx
 5RIViSL4M2ryy7B9rz2dny6eau/33Q3eqJLrfQK/1QsZulZWEVL1IGYm
X-Gm-Gg: ATEYQzyWYZMdg9Ac5565qCByynvranwxJf7KxwLgDhnULgxqfXRb8+NYNWs/ayvNQv3
 ihpE4+WvIf69l8VWc/XI6JzP0Kq4pLqtN6PjVpstVZQzNQkD55CkOygW0ADt/fFmv6Cwo8SSfY8
 IaVlF7UaA6wus/r3DZePMPEGqeobN53IXE7iVCrCF4UWPbvZbRd1MCR3EnXHYjpjRGVHfjg2d03
 MfjGkZHyjPFYWfCR0+93MM2kV7+Gtjbwe0uPL8lhaAvsAJlqBnHQIGnlrcqtCqvnZ3ECy42j3g9
 0sFUpD1R28alVALxp1KEPb2QqoFO3BdZSEwdUTpyJrnYw4BYz+XDVE6QqTg1uoNEKYGTt/EkT5X
 OJP1Z1qL3CbhWmaGMod03GYorQOBjkz2guUE9Jit/yChYEIY0Kubkp7KLcxh+8Td9t9jriEibU9
 u0KPUAW48lxBuoera8j8dYmgZiu1vCuGcTc34QPqDdNjgtIlzcXUNHTmRY7mc0HB1ziH/GUseT3
 //0b4OHY9sJ2uuNUhuaPavP1Jk7/pc=
X-Received: by 2002:a05:7300:3254:b0:2c0:d92c:2c68 with SMTP id
 5a478bee46e88-2c185fad9e0mr1793181eec.31.1774625006061; 
 Fri, 27 Mar 2026 08:23:26 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16ec4934asm5319735eec.8.2026.03.27.08.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 08:23:25 -0700 (PDT)
Date: Fri, 27 Mar 2026 23:22:49 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 07/15] target/riscv: Use glib2 instead of
 strcasecmp/strncasecmp
Message-ID: <acagsTxLwZYmZaf-@ZEVORN-PC.localdomain>
References: <20260327134401.270186-1-kkostiuk@redhat.com>
 <20260327134401.270186-8-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327134401.270186-8-kkostiuk@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 27, 2026 at 03:43:53PM +0200, Kostiantyn Kostiuk wrote:
> This is a change in semantics. g_ascii_strcasecmp() doesn't honour
> locale but strcasecmp() does. But this is OK for at least one reason:
>  (1) QEMU always runs with the C locale so there's not an actual
>      behaviour change here
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> 
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  target/riscv/monitor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index a9d3111444..bca04a7580 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -303,7 +303,7 @@ static bool reg_is_vreg(const char *name)
>      }
>  
>      for (int i = 0; i < 32; i++) {
> -        if (strcasecmp(name, riscv_rvv_regnames[i]) == 0) {
> +        if (g_ascii_strcasecmp(name, riscv_rvv_regnames[i]) == 0) {
>              return true;
>          }
>      }
> @@ -358,7 +358,7 @@ int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
>              continue;
>          }
>  
> -        if (strcasecmp(csr_ops[csrno].name, name) != 0) {
> +        if (g_ascii_strcasecmp(csr_ops[csrno].name, name) != 0) {
>              continue;
>          }
>  
> -- 
> 2.52.0
> 
> 

