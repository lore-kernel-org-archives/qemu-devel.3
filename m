Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696CBC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 20:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Y5t-000414-Ct; Mon, 29 Apr 2024 16:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Y5k-0003zS-E0
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 16:59:19 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Y5i-0006UX-Mr
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 16:59:16 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ed627829e6so6092044b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 13:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714424352; x=1715029152; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F88ZtpNZ/tRTSbkG496sMnQAv+sjfNxQoliMXdnsIJk=;
 b=AGzoiwFT33P5TI2T//m3/Zlerus6I8rEes0TPs+BNlC3iuGZqVHzS4sLD1/JUF6B/p
 uxxC9XCnM43SLV5K5TXsk9L6c6ry6w0aX5/rjoXoHjv0d+H9iGXyw2yajVWB543d+1t4
 ySaEe6EAjllwnVWxA4HViDmsIMgMgb//aKFtmnOdLKoNg+Pnqq/LOaMI0JlkmAgWSyNg
 hTK8L0koMGfYehrsmurM1TkvpLHMsAVO1L+eWZH1bPRe7GZ4C08Yiqd9cDC9plIpPh2D
 ewW8rn0axl/dkQC8uGJpUut3JOohFLbLS7MdHatn8O9nIwWozRp0XrTjnjNNXGr6Unxx
 cYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714424352; x=1715029152;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F88ZtpNZ/tRTSbkG496sMnQAv+sjfNxQoliMXdnsIJk=;
 b=WpFr6lxKBa1aWdzyNSKYRMA4tdBQpKei2Pbd4v/ZMIEzYTvlj7FWkfDRoyqtfwZplq
 wzhnx9CLyrTgsbU34ghNsegwTMfMRKY1K93PwOaMnTxP/1qlltYbj4ucud7yLaU2rLIT
 IVzL2ZNv2g6sxgtnnv8BGrmDntYBWTH7CBTD4rj5IYiRmeOz4VR2ImVoOGBx2AUp+iDE
 oW0pJYDxYNqNsHStxiJAhjcawMgKprVzbudkodkSM40iHZzZGRcD2iZxvD3Bctqso75U
 GaB6CRFwrCoq+hlg1WTLXT936gRXlaeHTr2wWVsqv6gDzDCce2DUKleZgdGtOBhQ3I/g
 a9Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcssrl/RbryOuyjcVOstTbtDnzLXw2ZZZCKuu77z3rN/dbodejQZQCIIEM68Nq+Wc5vm0fS5HzxNdsbVFWUy1UIYn8PDM=
X-Gm-Message-State: AOJu0Yz/KnMtZsRS0pP1rlMRT15eZXqXG9PiWADUbk5lsVwoXkmrfiS9
 93Fuf/4AR4KBmWbVgwN7lUaSZ0ZzDh+owkGKI4U/XUxyW4jyDpqe3aJdxwLv35PiCt2jkm9esU0
 K
X-Google-Smtp-Source: AGHT+IEgsR+zAeYjejlsH8QUGRjh+aAtJtowFzETE9bty7ORzFwGSfldQMchF4yzXUK/Cd3avpEqAQ==
X-Received: by 2002:a05:6a00:4f8f:b0:6ea:86f2:24fb with SMTP id
 ld15-20020a056a004f8f00b006ea86f224fbmr16601470pfb.25.1714424352533; 
 Mon, 29 Apr 2024 13:59:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 lr34-20020a056a0073a200b006e4e93f4f17sm19729031pfb.117.2024.04.29.13.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 13:59:12 -0700 (PDT)
Message-ID: <29ebfe76-d3c3-456b-86b0-7a371125844f@linaro.org>
Date: Mon, 29 Apr 2024 13:59:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Hexagon: add PC alignment check and exception
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 qemu-devel@nongnu.org
Cc: bcain@quicinc.com, sidneym@quicinc.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
References: <e559b521d1920f804df10244c8c07564431aeba5.1714419461.git.quic_mathbern@quicinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e559b521d1920f804df10244c8c07564431aeba5.1714419461.git.quic_mathbern@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 4/29/24 12:40, Matheus Tavares Bernardino wrote:
> @@ -144,6 +148,9 @@ static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
>           hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
>       }
>       *flags = hex_flags;
> +    if (*pc & PCALIGN_MASK) {
> +        hexagon_raise_exception_err(env, HEX_EXCP_PC_NOT_ALIGNED, 0);
> +    }
>   }

With the test here ...

> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 47a870f42d..26e6809976 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -346,8 +346,9 @@ static void mark_implicit_pred_writes(DisasContext *ctx)
>   static bool pkt_raises_exception(Packet *pkt)
>   {
>       if (check_for_attrib(pkt, A_LOAD) ||
> -        check_for_attrib(pkt, A_STORE)) {
> -        return true;
> +        check_for_attrib(pkt, A_STORE) ||
> +        check_for_attrib(pkt, A_COF)) {
> +            return true;
>       }

... you don't need a change here, because we don't raise the exception from within the packet.


> +run-unaligned_pc run-unaligned_pc_endloop run-unaligned_pc_multi_cof:
> +	$(call run-test, $<, $(QEMU) $< 2> $<.stderr,"$< on $(TARGET_NAME)"); \
> +	if [ $$? -ne 1 ] ; then \
> +		return 1; \
> +	fi
> +	$(call quiet-command, \
> +		grep -q "exception 0x1e" $<.stderr, \
> +		"GREP", "exception 0x1e");

What's missing in the patch set is handling this exception in 
linux-user/hexagon/cpu_loop.c.  This would correspond to misaligned_instruction() in the 
kernel.

At which point you could improve the test case to set up a signal handler in C, generate 
the exception, and test for correct values in the signal frame.


r~


PS: I think the kernel could be improved to use

    force_sig_fault(SIGBUS, BUS_ADRALN, regs->r31);
instead of
    force_sig(SIGBUS);

and similarly for misaligned_data_{load,store}.


