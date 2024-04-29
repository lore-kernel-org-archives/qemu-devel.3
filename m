Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF86C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 21:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Y8h-00052D-9r; Mon, 29 Apr 2024 17:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Y8e-00051q-3h
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:02:16 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Y8c-00076j-BC
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:02:15 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e86d56b3bcso45494295ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 14:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714424532; x=1715029332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QUhAQsTANPTo0/S/CGAyOW1gVOPkz+End0QAVZBRXsI=;
 b=CEzD5PuBxYQ85D8LPGSO2Nh1FUKomzMxK2X6g36ARtT1oHxudY/gpyuFG85maHOuO+
 UsyZUtCJGxTGPLBb+ieMamxZqmW7kvF/x1U4HrsYJauW+Vnhyfp4NZCn+UW9VuTOOtoJ
 wnjRJCk6W9mbzmwwlKkxa75UPDogOrJmYKsA2Qi75+JZmuPa+fAwycm2rWWC+gYMibSm
 dPhroI58dlfFqL5Wt4J3Fkb296av25dDI3rE51S+5qDaN6HyfLPTeWHCimLXsQIltqpO
 3cvebLHqBlUk2NUQ3369IS6299fm5VzJWxYPVKBytDAKXBTlf36LIYr0GZnqmdd54bg0
 v2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714424532; x=1715029332;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QUhAQsTANPTo0/S/CGAyOW1gVOPkz+End0QAVZBRXsI=;
 b=uOthKM9o405u47EOEOXiP3W1ZSKuZzHAWRSP1CzDyUvbjc5IhB2nSHZi6CzffVyDFB
 DSxyejdi4xo6qTJiUj8IOc4egHIeFPcz9TTFzoxyia6IHJ8S2jHmMnlAB5RfEqojaA4n
 wIGRr3YdYG69CGceSK9Sw8v/6Xpw1TGZmB25OSDTx82Hq5J1rUVI7/RiwAsBZyigldac
 dzRcXtrRDq5jvjsy9NZ0ePYsQ/fGt/8DEFi6UEWQc6IUIik2wfCMxDXg2+f8UENNUYlm
 fH5U1Ied9wBOEmzgzgZX8sMgWepp32p1ebKUcl6cUFbQ3tkP/34Uhbn/pVZgNnd0Rm09
 M/7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2Dgxz5hGPwcZSlXZQLzRpguZcdpkdMBMTMqY5l7TQ2D5kUUpKxWSoeqZkxuy9b6xrBrQP9uzJdK5Ac8DXXbm6UOKkw00=
X-Gm-Message-State: AOJu0YyDEzkNhD7euUQbvqtex7H445B2YliqttrxI2SnWoBJihOYWbQQ
 5nHdgVP+SLBhcuryvQxjYJauqobMQ3lXY879sE8rKD9IQoJxrwR2hHoATUfgwf2FULL8/q57Ost
 G
X-Google-Smtp-Source: AGHT+IH8UJoq+ALE0Zjb8TFlFzNFWLNzBQEFKVjFrI2W0DACgTfw5jOasEcPeijS7/xv0zH3N6IUqQ==
X-Received: by 2002:a17:902:cf06:b0:1eb:1485:9d2e with SMTP id
 i6-20020a170902cf0600b001eb14859d2emr996321plg.30.1714424532464; 
 Mon, 29 Apr 2024 14:02:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a170902694600b001e20afa1038sm20873032plt.8.2024.04.29.14.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 14:02:11 -0700 (PDT)
Message-ID: <f38d59f4-3cf9-470e-962a-c888970b5a21@linaro.org>
Date: Mon, 29 Apr 2024 14:02:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/41] target/sparc: Implement VIS4
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <7b5e744c-7fc5-4bf2-9602-1d2cc97913be@ilande.co.uk>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7b5e744c-7fc5-4bf2-9602-1d2cc97913be@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 4/29/24 13:52, Mark Cave-Ayland wrote:
> No objections here about the remainder of the series, other than that I don't have an 
> easy/obvious way to test the new instructions...

I was thinking about adding support to RISU, but the gcc compile farm sparc machines have 
been down for ages, so no way to generate the reference traces.


r~


