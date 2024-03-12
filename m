Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD890C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3Nc-0005I5-Mi; Tue, 12 Mar 2024 10:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3Na-0005Du-LC
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:45:22 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk3NZ-0000br-2c
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:45:22 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc3b4b9b62so159515ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710254719; x=1710859519; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cwKDSzqnXghxcTmZb0pyVMVbwyKmGGJFYQP6blP+7LU=;
 b=OyV2s8DxJS5CxjhrIvj/2r4UiUADEJrxqgf9p2LyylNJ1LNd9TT17xo5oyDJA0ooUX
 YVw3MEd2DasGMjDtW5VnLXEWB1Iu5PS+3ZER3qJQajs3tRs3aApS/9LEdnb0V47v/N2I
 gtk8pymWI3GQa7thidGcVp2iWjwTgkKRyo382BUQBUYjCHhjBx/s8m98L0Mmk8aa5S7D
 r3s/3iZsDEfjWRshklLkbstYfR98lHxIuZsjd2tbaELLhr3oMipSKppskDIYd3Ns2A0J
 QLLBCUmC0oVmDLi8vMDVONFyiOp8N2JI2xYy4dEALDEA8oa4ZQ6jHIRXtZoZDgUMUj0P
 93vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710254719; x=1710859519;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cwKDSzqnXghxcTmZb0pyVMVbwyKmGGJFYQP6blP+7LU=;
 b=Eh8EDSR/977Ob7jTKDYP/ktoz2z3Me5OTD9alvYIxRhLou7io6zkDFHO1k8G/gcUIW
 HeOMHx5Ldw2tuT7Hyypaa5uw6KXbfOexjXFxxu1jzJP4dTvsat3eP3cxbhbFr2s8/TLN
 QkxrRnBPuel4p8CMY7ch2jrpMs+APKQjfL1gMPWq0Pv6YULaTQOOIkHkERHSkc5e3ZrY
 SswCMcU09DJnZRqOu8AmnjMxnp+HOitOm+RTX5Zn8RhQ57Xbnv9Y9lUCVNKbbEP6D/xd
 VmYrIWlCiAHnfg1nBLCOcCKzHwnSGOLkYb7izGrFIhIgFFqVoOgepsug+AxJyHU476ZZ
 f7Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb4Z+6KsxKZ4rEa3xXKtt41WWjuXWzCnE8XA/ldWR4A6jzLoK2owrD/xgA8Hbq2p01MDQkF1F5sLWvc/JvB+7sWIfMw1g=
X-Gm-Message-State: AOJu0YwU9nb0vktPikNftMUi4bIsQeaanlxYTqls3zCrGw910NXZKilF
 2S4LHKU9HjAQwG32iStw4oYj4NH2kcox2wfBrwUUVs16atNjxEUYBmb+XbOW+RQ=
X-Google-Smtp-Source: AGHT+IES2wF2gqyHoXtSi5U9xOaYo71eKhsfGIYKTKt0Kb/KlaVimpsc3HAyD5ygt8nZb3pZWwpURg==
X-Received: by 2002:a17:902:ea01:b0:1dc:c10b:1745 with SMTP id
 s1-20020a170902ea0100b001dcc10b1745mr15033419plg.16.1710254718995; 
 Tue, 12 Mar 2024 07:45:18 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 f10-20020a170902ce8a00b001dda336de37sm3745667plg.240.2024.03.12.07.45.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 07:45:18 -0700 (PDT)
Message-ID: <8d2f2722-4cba-4b52-86d6-78d4a7214bd5@linaro.org>
Date: Tue, 12 Mar 2024 04:45:15 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Move floating-point arithmetic instructions
 to decodetree.
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: danielhb413@gmail.com, clg@kaod.org, harshpb@linux.ibm.com,
 sbhat@linux.ibm.com
References: <20240307110318.170319-1-rathc@linux.ibm.com>
 <CZRO4Y67CBPV.2IAKB80EFDKEY@wheely>
 <0c7c6be1-12fb-4267-9d41-bd51637d104a@linaro.org>
 <CZRU903MDUJ1.6S9RSO5A4RDG@wheely>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CZRU903MDUJ1.6S9RSO5A4RDG@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/12/24 04:24, Nicholas Piggin wrote:
>> Beware -- GETPC() may only be called from the outermost helper.
> 
> Ah, because it's using __builtin_return_address. Good to know.
> Using always_inline and a comment should do the trick then.

No, seriously just don't do it.

Pass an argument 'uintptr_t ra' to these helpers instead.  This should be especially easy 
given the macro you want to drive this.


r~

