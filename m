Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A16C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 21:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqIfl-0004Q4-2k; Thu, 06 Mar 2025 16:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqIfg-0004NR-0z
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 16:22:24 -0500
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqIfd-0003Lt-V3
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 16:22:23 -0500
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7c3b44dabe0so132715785a.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 13:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741296138; x=1741900938; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gu7rwj5pG/jfdM/VvCq5W2Bw9SEVDUL3DNnAHy2EfuM=;
 b=necgxjIpU3PIyPnDHBtPAQYC+uVmTacTiZME1PFHvy66jnI6+DAzfZrJsR1SOfU6dl
 PSGHTIr+bTofE42DdC9O1p2nGZXFnZ77OVY8PyR6BuNisBe2Iggs4drUjjR3hPyvmn8K
 h3YnbmTU9dUa45r5jbwSWZOtX1RN8bb/+tycI2nWypXBb0omhKs+mDjCxriJ7vwrXWDH
 EmgFVpZ9tiT0fBc2Y+ctzHY4uD5npMiDwyKpYtRrZeiXKy9oOmYaNiNb0YdcakK7ZrmY
 khB0OS0ofRGlo+sxC0DeVYujTWIO8QS5nlP2cQyscAg8KV7SEUiZs5++UjYuAEp8XvnD
 StAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741296138; x=1741900938;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gu7rwj5pG/jfdM/VvCq5W2Bw9SEVDUL3DNnAHy2EfuM=;
 b=mJ7MDy9G6RbEqosdXndYlxtL6peyBnBw7irEnY+QFZDlw0xpOZz8vRlnSQ9s1nl3oR
 LbGPMJ6Ar/rqcoJH6NPEo3r230JRN4y427NlFwVsCkBAkxA3BAh2d/jH2ECbJOPb5Akn
 zKr940LuOUEVw8hrQTqz62cH/pjPO9cjkaJ4Sx1B4AH6pngeEO2hEdAexU4PrkDR5HzG
 b2MsVh6OExgqWXqfAvyE7uJ/1mIrTyEueuFNyUmF4SZWsTgQMmp5Lvhjw1a+WNaZrod0
 +iDFFaDWJOfGmJVF7WIF2BuEX4QEqivAhyOg142QKhui/ioeDhZkPD/fL2yJYbZu/CgL
 j6pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWncYBgZV+UiSJaXhRV0N7d3QVifCxV4AY/kY6nMJIMCpM0NWiC9meN5oqw1hBv7ynf3pTBh00KmTul@nongnu.org
X-Gm-Message-State: AOJu0YxDamaruiOBm2zw9V4jrhDgVf0a+4dE83z5YQBoVe1gMM3wTP+3
 k8IASqdaw1za4zdcpGX7541V5xJFTVnlH7VPIgKm+RQsamTkWsZs
X-Gm-Gg: ASbGnct3Z159DJaIXJ64nUxsH9ZdBu/pipMY4BLUjiNN4bmZl7FD4Et3kS5C6rZ83TF
 SlXDrdQJ2ocqLHP5ICPr4O82owthNDKyn+jeo+IvCurcu1q26M6g71cp5OyIccehledsAi1Jxaw
 qrJPwSO1RkzuT+Jj+39IRQZJyZH2P53hxmR9kXV04jEIapxThFwk7nbQYuVFdeNysft5KCCfniI
 ROZMvyFTmF1nijTSVMiiA5mETTlbjAE6coT1qUoqVFYlJbvzmcERDrMxO/a8UBBRIK7I36/IiHZ
 jhlxh5iEF6TnPy1ZmmOpnyJMH1JZ4xL6+DNQZZIf+x/kuMb4poFgdprSkPytJXo=
X-Google-Smtp-Source: AGHT+IFfYyCSlypkiHpfGicKvCuR9oFqdrhqbBQAwq+FAE6ZXXmcBmBVcMnFSx8iwPskLhhWSwRi8g==
X-Received: by 2002:a05:620a:27c4:b0:7c3:c814:5919 with SMTP id
 af79cd13be357-7c4e1668c3amr108919485a.11.1741296138023; 
 Thu, 06 Mar 2025 13:22:18 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:f449:4838:1970:9d05])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c3e54ffa16sm137818085a.67.2025.03.06.13.22.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Mar 2025 13:22:17 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-8-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-8-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 07/38] target/hexagon: Add a placeholder fp exception
Date: Thu, 6 Mar 2025 15:22:16 -0600
Message-ID: <023701db8edd$d6b081d0$84118570$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgIBrulxtOruAzA=
X-Antivirus: Norton (VPS 250306-6, 3/6/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x72a.google.com
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
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 07/38] target/hexagon: Add a placeholder fp exception
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/arch.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/target/hexagon/arch.c b/target/hexagon/arch.c index
> d053d68487..87c2f6a53f 100644
> --- a/target/hexagon/arch.c
> +++ b/target/hexagon/arch.c
> @@ -208,6 +208,11 @@ void arch_fpop_start(CPUHexagonState *env)
>   * model it in qemu user mode.
>   */
>  #define RAISE_FP_EXCEPTION   do {} while (0)
> +#else
> + /*
> +  * To be implemented.
> +  */
> +#define RAISE_FP_EXCEPTION   do { g_assert_not_reached(); } while (0)
>  #endif
> 
>  #define SOFTFLOAT_TEST_FLAG(FLAG, MYF, MYE) \
> --
> 2.34.1

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>




