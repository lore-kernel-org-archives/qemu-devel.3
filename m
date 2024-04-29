Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0300C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 12:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1QRO-0008E3-JW; Mon, 29 Apr 2024 08:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1QRH-00081d-NV
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:49:00 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1QRG-0006Et-6H
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:48:59 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ed9fc77bbfso3411605b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 05:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714394937; x=1714999737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GsJuR6GGvaTMMx34EVlYOdNKKGalRy/Bp5InBfH7rsg=;
 b=F9kk4R4QFCLvsfN+J5C7kUwRzeM0/dwpfJQALT/4UAAY/4wW2ddNeqrl5zM6xIte0L
 ZSNTkQU0Vsm2W0OwGBJOFxucN70QZWcEpfq9TWjitC+H6jTA/zK4TgBaneSmldslCwDy
 3M58JoPYO8yLkNZHfaRlkpOd86KmiHXxRmQjbCdazMLGJSgqtKR5cTAP2ZOHdZ16jwnm
 cJyLAoNK4MJWTU0wxIuS62kPt74RrkYo8TPevPnqdu7eSxV5Nx+ciCWLkOKMFAbLpixR
 ycUODXJh2gFisHdRVtjR3vhj0bg5jIxYkixVq9TVstcDCxu1+VYnux6PEk1Bbfr7PTOO
 dJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714394937; x=1714999737;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GsJuR6GGvaTMMx34EVlYOdNKKGalRy/Bp5InBfH7rsg=;
 b=gosmlnKRmU4sDDxzdShv2dRxyrwMLFXlTObevPiW7H770DvQej9c1/Z1TFLjjwklU8
 hvC/m25ULxZxCitGhfP24oeZvU4mIxvwORBWN6xWPGLmzfsh11Tiimkxdo1aR8UPbeAp
 7ovN7Rcb8X5J/J8xpreDoxwmXKGo9VToUJcLRJkDBJ9jbPuR/kSIKiGCdmbrLBt08UR8
 G7AXz8hGFjauBS5hQb/QGGY71t+hqW3VDWa2fhM8sk0reeGTC7F0GOOkksz7VmSvsD4f
 HgRYQobOLzpjdzkkTEztB95ckQYafiKRnt/vgRRTM4IBxzMf92WqBPowwzwZ0EqAyO47
 qiOg==
X-Gm-Message-State: AOJu0Yy1L/zrzXFel3QFG51aWY8tmpIvSsa34mDMZ+bVxbQZh3fXtpbR
 +aOMABm38a/QBPr16FPwQb9Rs74HF94noBbVCQ6Pn9xYAYtAYo4uEngv4tb7bZ4Mt17HET5aD8Q
 C
X-Google-Smtp-Source: AGHT+IG6f9D7J2OJvvlFk8+INw4wcASrIDy/OP4QkSy/MJ9iVX80CXAcSBdUVfwF+coqwIR5oCU/Rg==
X-Received: by 2002:a05:6a21:918a:b0:1ae:4c81:87d with SMTP id
 tp10-20020a056a21918a00b001ae4c81087dmr9062003pzb.14.1714394936680; 
 Mon, 29 Apr 2024 05:48:56 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p39-20020a056a000a2700b006f3ea8a57edsm4410677pfh.133.2024.04.29.05.48.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 05:48:56 -0700 (PDT)
Message-ID: <0f948647-4f71-4c81-923f-e4187adbbd8c@linaro.org>
Date: Mon, 29 Apr 2024 05:48:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/ppc: Move VMX integer logical instructions to
 decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240429051317.289426-1-rathc@linux.ibm.com>
 <20240429051317.289426-3-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240429051317.289426-3-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/28/24 22:13, Chinmay Rath wrote:
> Moving the following instructions to decodetree specification:
> 
> 	v{and, andc, nand, or, orc, nor, xor, eqv}	: VX-form
> 
> The changes were verified by validating that the tcp ops generated by those
> instructions remain the same, which were captured with the '-d in_asm,op' flag.
> 
> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
> ---
>   target/ppc/insn32.decode            | 11 +++++++++++
>   target/ppc/translate/vmx-impl.c.inc | 22 ++++++++++------------
>   target/ppc/translate/vmx-ops.c.inc  | 15 ---------------
>   3 files changed, 21 insertions(+), 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

