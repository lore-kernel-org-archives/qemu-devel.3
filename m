Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32C4C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 21:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXTH8-0005em-SQ; Tue, 06 Feb 2024 16:46:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXTH7-0005eA-5t
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:46:41 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXTH5-0007Fu-Hb
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:46:40 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso52342945ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 13:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707255998; x=1707860798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0QJX/S9IomovOBIoF/s3BNY4iWxBvuykWx4Cyek5lUA=;
 b=NoG6w9cR1ZZTcIo8Ub/wExQILYo56/J0DmpA5sIiyufvD8mkJG6WUEf9BK6nk7smBL
 evySXk5Nuhmm2MU/Bn8/fC/L/uWG5R89lrTHy5qqgZSHmhbZOiYv0nxobgjTggRr5WuL
 sCSEySA+qTfcdq37odrZiTVLwz7g+GC/KVQZf3oT/eFwHky7YALTyC1UlTlX/LAHYHyv
 bsMu9YIM8u0wYY6cQVjtEZiC699ITuLRnCH+1iQ6M4ubR9WLOGJIvJKDyZkOJvvbi8MO
 zfY5BVoll8Z7T3Or5F7Yo3W2mgXD30/6HCsGU9tVND/Fie/9oSToo3qqNwAqznuiPfno
 rQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707255998; x=1707860798;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0QJX/S9IomovOBIoF/s3BNY4iWxBvuykWx4Cyek5lUA=;
 b=jMQxXvzF1pGd00RCX1Ye2CsY4t2g/oXaDl07FZspRqGLqrGo//6T2xLueg+NikpvZt
 fwqEM8Tvnp6QofpDug67387jhELbHsGCyP4BOZSBLQh82yLf8bISIaHmeW2SJCQk5cib
 tkUq/ureXPNtYPl3UcmUo0oK3VMiWsgrI1UoweqIRdFmrIzh7g8OsnHmEX7SWTU1SPqL
 HGzSc86St4VNuJc8rbNj3g3pPwJHuAMEFoMR2Z5QEKoO/7iOP2CRXDYf+GhmK/9eblbi
 B65E+aLCW5s+SAq41b2/MkHpDdp7WLw0vz6G7lmas/gUByvOBcBME2kr7nU8JxYEld/p
 vWfg==
X-Gm-Message-State: AOJu0YzG2GAqsntj3l5bo02WMy5U5ZulLXIsozUn9Lw9ZyLgDIzdXDXl
 ErVqP1si7BZBVth4xLRq+ftY0mH1eN/1KAm87LklK/8yT4YiuchDVJmdGV6utqk=
X-Google-Smtp-Source: AGHT+IGMFMv3KG844sSbaI+FPyuu85AX33L0Ow6mzBUllHemdiKew49+OF82muxi5cq6RTO0MSQBGA==
X-Received: by 2002:a17:902:654e:b0:1d7:4b27:4ac3 with SMTP id
 d14-20020a170902654e00b001d74b274ac3mr3002296pln.31.1707255997999; 
 Tue, 06 Feb 2024 13:46:37 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVM0M3RF9vFliwSGAxXCxMvF1Jr5KVcksiEUSVQdD+Znh7pVC+dyqxuejmFMDIS8o8Tlkwm00xYtPeCYHrUdN2WsW7PbdvMv1BvchT8ru9spRA8x+kVtftYhqQ=
Received: from [192.168.0.100] ([43.252.112.200])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a170902ed8b00b001d940ae8ffasm2382196plj.6.2024.02.06.13.46.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 13:46:37 -0800 (PST)
Message-ID: <7f812de0-c343-4d77-97c0-7bd8349db76b@linaro.org>
Date: Wed, 7 Feb 2024 07:46:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] target/arm: Allow access to SPSR_hyp from hyp mode
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240206132931.38376-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/6/24 23:29, Peter Maydell wrote:
> Architecturally, the AArch32 MSR/MRS to/from banked register
> instructions are UNPREDICTABLE for attempts to access a banked
> register that the guest could access in a more direct way (e.g.
> using this insn to access r8_fiq when already in FIQ mode).  QEMU has
> chosen to UNDEF on all of these.
> 
> However, for the case of accessing SPSR_hyp from hyp mode, it turns
> out that real hardware permits this, with the same effect as if the
> guest had directly written to SPSR. Further, there is some
> guest code out there that assumes it can do this, because it
> happens to work on hardware: an example Cortex-R52 startup code
> fragment uses this, and it got copied into various other places,
> including Zephyr. Zephyr was fixed to not use this:
>   https://github.com/zephyrproject-rtos/zephyr/issues/47330
> but other examples are still out there, like the selftest
> binary for the MPS3-AN536.
> 
> For convenience of being able to run guest code, permit
> this UNPREDICTABLE access instead of UNDEFing it.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> Last time this came up I preferred the "keep QEMU behaviour
> as it is, try to get the guest code fixed" approach:
>   https://www.mail-archive.com/qemu-devel@nongnu.org/msg899970.html
> but as this is the second time I lean a bit more towards
> behaving like the hardware.
> ---
>   target/arm/tcg/op_helper.c | 43 ++++++++++++++++++++++++++------------
>   target/arm/tcg/translate.c | 19 +++++++++++------
>   2 files changed, 43 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

