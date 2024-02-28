Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4CBC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 23:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfT4G-0004Li-AR; Wed, 28 Feb 2024 18:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfT4E-0004LN-MH
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 18:10:26 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfT4D-0005bE-5S
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 18:10:26 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dca3951ad9so3322815ad.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 15:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709161823; x=1709766623; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R/iapAsCSFQsA7/1+PUhSsUM8WUIqY8pXhaEMASUFrk=;
 b=theCTlaNlTmgeeNTl1vmE6YW6axWNyihloGwj7E7DXuIUNoBIV/VF7ivCP27rdH9BT
 5TheR019PMuMokssqkSFCn0QyoBN0P8U/W3/ufb9aMV76OtXwxen6cPlGxy9YneldMjy
 1NCSncYa65IM74DCpbTnpcN8gnLD9uX2TAGwUD7Z143KGprXKX2Ja4NlrmYIiyYoudyC
 Qz6JVamjOhnpRbv9s+SNBl9ku7dMg9kNrq1YvRHG7xAjlILDHc4V5S43J0Ice/bwr8wX
 TncRrTXROzbbbBAr9Iz0Rq7JIc5j5gCclSlDwkGtVWeXeNpnoccPtS1J7LrTsQwDpQ8h
 oPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709161823; x=1709766623;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R/iapAsCSFQsA7/1+PUhSsUM8WUIqY8pXhaEMASUFrk=;
 b=WfAgLrliVZt1YMy8mkj7Si6JYxkfG2ZJme4Nnjdl82LTCKQZUDc114DTBK+INaAMzN
 lFEov+7s/ogE//lK9sP1BAtAWvWD5scQQTOdVPbJjVLD7L3q6oh214pilbI7kfCmjllo
 9BCgnP5065LuHV6R/yPIf9pg3j28Plmjs1JyYH84dtCaQo4j9e+3O2p0dd3hIyRhB9eY
 xirgCAyhZAHSmFJa9k0T29ISO4M9c+Jc1eb08K7RM7bz1QFFzwHoFCfxbE5u89QjoZRt
 2cfFPNrUyV2/R+RQJaoxKfd960Gj8a80NMPmBayWVA9hgFqB4fP2zbIVrGhQxJd4Dorv
 jRVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFOpPG7nrF6v5M2nKEKLlYpMdPabpiuvY7x/vDBlJAdEa9Qy8+h/mwf/aBhoQmzMG3Q+MSOPR/yRtUIH77rv/G93mq5yU=
X-Gm-Message-State: AOJu0YwC1TH/jXZkujCkz4Va+KfX2QcLLck3R8uTbBl/ET+CijjO7gCs
 B/3iEcjKW9NrPABQI396+/G84Wh9NiAsCUHJpFVZGVkF5P0om3iDK9+/2x33mdw=
X-Google-Smtp-Source: AGHT+IGUtu6qYhC2rYhNr/tLkTDuKHQdK8It+W95aa+a6vpCnUnMyW+ZmMh54IoLK0275qgK5cg/5g==
X-Received: by 2002:a17:902:650c:b0:1dc:b173:f27b with SMTP id
 b12-20020a170902650c00b001dcb173f27bmr358850plk.32.1709161823308; 
 Wed, 28 Feb 2024 15:10:23 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 kn11-20020a170903078b00b001d6f29c12f7sm3797754plb.135.2024.02.28.15.10.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 15:10:22 -0800 (PST)
Message-ID: <4362aeec-ae18-4515-a3ec-6aba811e17d1@linaro.org>
Date: Wed, 28 Feb 2024 13:10:19 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tcg/optimize: optimize TSTNE using smask and zmask
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240228111151.287738-1-pbonzini@redhat.com>
 <20240228111151.287738-5-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240228111151.287738-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 2/28/24 01:11, Paolo Bonzini wrote:
> -    /* TSTNE x,sign -> LT x,0 */
> -    if (arg_is_const_val(*p2, (ctx->type == TCG_TYPE_I32
> -                               ? INT32_MIN : INT64_MIN))) {
> +    /* TSTNE x,i -> LT x,0 if i only includes sign bit copies */
> +    if (arg_is_const(*p2) && (arg_info(*p2)->val & ~i1->s_mask) == 0) {

This is a good idea, but s_mask isn't defined like you think -- it is *repetitions* of the 
sign bit, but not including the sign bit itself.  For INT64_MIN, s_mask == 0.

So for TSTNE min,min, (min & ~0) != 0, so the test won't pass.

r~

