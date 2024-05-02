Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDA7C25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 16:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ZHg-0004ss-Hm; Thu, 02 May 2024 12:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s2ZHc-0004ok-Pv
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:27:46 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s2ZHa-0000U9-Qg
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:27:44 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6ee575da779so2161322a34.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 09:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714667261; x=1715272061; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=T+E8Tzi2RVag6tt6kJqCvt6bXIUB1LsyMzSKaphzHDo=;
 b=R43nz/HA1S0H/X/WlDB6sH4BuDZBnbgumf/wbm6gDhaIziLLFglemnLHRuOMHlAfBg
 OPzRfSeTVWYn8DN3CStRv6ebaoiotVMeBxxcthwc4xE7TDgJutmscV6QX1I/8ahi/coe
 KbOupnE6ua5WL0Da4kgu8I0/If+qrzCb2qlWtEinEF76mnvN9iqj/CW2b12EnDKSCN85
 iE+X5KL/teei2a0EHHk8Hx3emBBxUU1h2dZPSw8Rt4cLqZFWivucn7xZjDwU/icrqTOi
 0Elip+494HCtxL+j3PxD2EiGiZMm92tE3AKP52W4v9fnzMizMTYMqJmCXWAnEVurwDZ/
 hBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714667261; x=1715272061;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T+E8Tzi2RVag6tt6kJqCvt6bXIUB1LsyMzSKaphzHDo=;
 b=SiVAgJ8nm8PBBVFKpJMZayDUuy6yif18x2FKbq0bgWx/ucW8058TC87MeRh3duEHa0
 ZIHC+k0T+sWNaUDuzsnyOMItC6HNX6x4E3BsXhHZkKub2pYsfj7scAPqeOJpEBo3Phm2
 xnX8R6wOQHuG5U0BnnQOnH+eSYP9TTLaHRJTjiGhxX+fulnx2/TTW7eYChP84LO7D7ks
 H8ZqkcHDApbgxBZQVdYe/4SeUin/fzn2B6to5OJXFN8jDFyAtdZxz1xe/wjepsNhfCEH
 rUiPDtHIHq95f9eCe9yUWWu79kXk9FOjq6+DapizjpweZw6pATgIBwbC94Wu7Y614B0+
 RYxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9gfxKS1xSxEZYd7HW/cwUyJi9Ads4oCy4hPTPUZ78fjuvVEgeFoqQMq+VI/RK/NBZnWrTAUEKjEjMtUDUuFHNRusNOIU=
X-Gm-Message-State: AOJu0YzOcHkIwqp/QQ2TR2IioSIm0j+31rTi75FwoesrfBZmkXdz/ulM
 gFtsW33NxfrrPvMrbJ3wYAP7TpgfmFtjb7BhoGqpNGi9CFVk8h9c
X-Google-Smtp-Source: AGHT+IHFm+uow9hWThgjgCLr6MyfigmsyVPqiNL0kB6wK+6LYNLmnaKhjj5rMMKvpDciyaYnt0nlkg==
X-Received: by 2002:a05:6830:139a:b0:6ee:23dd:71c9 with SMTP id
 d26-20020a056830139a00b006ee23dd71c9mr431175otq.11.1714667261096; 
 Thu, 02 May 2024 09:27:41 -0700 (PDT)
Received: from DESKTOPUU50BPD ([64.157.241.90])
 by smtp.gmail.com with ESMTPSA id
 cr13-20020a056830670d00b006ee576e9732sm244883otb.79.2024.05.02.09.27.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 May 2024 09:27:40 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Matheus Tavares Bernardino'" <quic_mathbern@quicinc.com>,
 <qemu-devel@nongnu.org>
Cc: <bcain@quicinc.com>, <sidneym@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <richard.henderson@linaro.org>, "'Laurent Vivier'" <laurent@vivier.eu>
References: <4073a0bafcb239623b719d3304955fd8603428b2.1714661573.git.quic_mathbern@quicinc.com>
In-Reply-To: <4073a0bafcb239623b719d3304955fd8603428b2.1714661573.git.quic_mathbern@quicinc.com>
Subject: RE: [PATCH v4] Hexagon: add PC alignment check and exception
Date: Thu, 2 May 2024 11:27:46 -0500
Message-ID: <049201da9cad$ab7ecc60$027c6520$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH/8nC8DLM5SZobZkJ1FLH/44hLjbE5dXCQ
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Sent: Thursday, May 2, 2024 9:55 AM
> To: qemu-devel@nongnu.org
> Cc: bcain@quicinc.com; sidneym@quicinc.com; ale@rev.ng; anjo@rev.ng;
> ltaylorsimpson@gmail.com; richard.henderson@linaro.org; Laurent Vivier
> <laurent@vivier.eu>
> Subject: [PATCH v4] Hexagon: add PC alignment check and exception
> 
> The Hexagon Programmer's Reference Manual says that the exception 0x1e
> should be raised upon an unaligned program counter. Let's implement that
> and also add some tests.
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v3: https://lore.kernel.org/qemu-
> devel/5c90567ec28723865e144f386b36f5b676b7a5d3.1714486874.git.quic_ma
> thbern@quicinc.com/
> 
> Changes in v4:
> - Added missing regs to clobber list as mentioned by Taylor.
> - Avoided undefined behavior on package with multiple branches
>   (at test_multi_cof), as suggested offline by Brian.
> 


> a/tests/tcg/hexagon/unaligned_pc_multi_cof.S
> b/tests/tcg/hexagon/unaligned_pc_multi_cof.S
> new file mode 100644
> index 0000000000..10accd0057
> --- /dev/null
> +++ b/tests/tcg/hexagon/unaligned_pc_multi_cof.S
> @@ -0,0 +1,5 @@
> +.org 0x3
> +.global test_multi_cof_unaligned
> +test_multi_cof_unaligned:
> +	nop
> +	jumpr r31

You should be able to put this as an inline asm block with the .org
directive in unaligned_pc.c (outside of any function).

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



