Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC36C52D7D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 00:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf6rd-00036r-Qr; Fri, 16 Aug 2024 20:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sf6rY-00035x-Vr
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 20:00:09 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sf6rW-0001sU-Rd
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 20:00:08 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2020ac89cabso10279225ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 17:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723852804; x=1724457604; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hThVIS0NMDVyIHD+K67zvnuEC7Gg05r1u9JYA+DTPYw=;
 b=HlaGyiQDhHfpzgG2UIEAn1vDorDBIq6RTA3t4x6PTiAHTJeWRpGcaW9PdVFW6UH8fW
 xFphueTCzUERv/cjolPv4SGwUhqeBWjlN4vWF5CKyJ/D7Bm2zekU3di4hvdeS9zY9/03
 20NMW4Raemv7j+rB/rq/DeOLE/j8dHZtZFcv0CbqpXiFm3DFFtEAm7du7tx+vKo23xBq
 Ln+uuFQh2y4wiZOpjB9CvboSfCHfJRG5eJ0SEIpQwEsxP8kuAJFzZji0X/1eIOFWT08S
 Skpzx7wK3lk22q+BkbpKlQwwIl1LSC/XmSMsLOgIKV2aNsyCOJRY/vrg4tVL92EN/XbP
 UPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723852804; x=1724457604;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hThVIS0NMDVyIHD+K67zvnuEC7Gg05r1u9JYA+DTPYw=;
 b=NvHhhmWu6WNiw0yZCKGNHxhxEEzyyp9wxdqtu1n2MpZdkAIZIRbgAfQ2sPB0YPEt23
 1zYH/XOpYmq65uPGod/FMuq/FHnmh1qO21YqBbFOY6Pa2hfI84HC5Fjx8SGiPG+lFuht
 4rNjl5cw9E1K000yHw5r2EgkdniZc5wmytqpNm8rWOlXR+oJ8qSmkFafvsjLp7srVQ+b
 mjpWS89IEwtFPy9n9QaiaDKhjmpNJare/X8e0CM/XamGOBgbM1Y1GAIGDuZqm0mGdtYb
 4B8NTgP12xN8kVQrFDl0LZ7TcbiF8ZFcEtciDpkGfsfvn1N4TYjAdsGlxvGlIESZGab6
 Vvng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbFLoJtoWoy0elsa6Q+oshp5gzYmXETEUfHV1Zn0mjY+yFWB+vFTTHV9/hrwUUfL61Rakz+TCuRPUJhzb9/X7jM7CmGJo=
X-Gm-Message-State: AOJu0Yw8PcKreEslw04v1rhGqevlxHJHLmhfk/qnMbx1Gvu3xWO2UGya
 V7gg+NyBfFRr5CmsTeyAfcVewMNA4W39C4RmUkjjnJRB/K4T4zZgohFOJF8Aj55/pt4lKQpWFfY
 l7fM=
X-Google-Smtp-Source: AGHT+IE5z+4od9pW4s6FiAs2YjwtRbHZpqujN8HtScJOySlEeDGch/WK5ITxCfl2d8VCZyZEzIt8Ow==
X-Received: by 2002:a17:903:2343:b0:1ff:622c:277d with SMTP id
 d9443c01a7336-20203f314a0mr48278585ad.46.1723852803369; 
 Fri, 16 Aug 2024 17:00:03 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f02fb465sm30434975ad.51.2024.08.16.17.00.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 17:00:02 -0700 (PDT)
Message-ID: <a1bb747e-f2b1-4eec-97cd-0c7614623aed@linaro.org>
Date: Sat, 17 Aug 2024 09:59:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v3 0/6] target/sparc: emulate floating point queue
 when raising fp traps
To: Carl Hauser <chauser@pullman.com>, qemu-devel@nongnu.org
References: <20240816072311.353234-1-richard.henderson@linaro.org>
 <501c22c3-d8e3-4439-a958-549e9a772ffd@pullman.com>
 <2c1d0942-1428-47a7-bd37-29c16d596761@pullman.com>
 <092fdfde-7305-467c-9131-6f5d2128c58f@linaro.org>
 <a06ebc2a-e67b-49d9-91a8-ae2a7a1d8b9d@pullman.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a06ebc2a-e67b-49d9-91a8-ae2a7a1d8b9d@pullman.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 8/17/24 08:58, Carl Hauser wrote:
> Yes, but ...
> 
> isn't the state of dc->fsr_qne at translation time irrelevant?

No, because patch 4 made it part of the hashed TB state.
It's checked and verified, generating a new TB if state does not match.

> And changing it at 
> translation time (line 4593) is dangerous (because it pertains to runtime, not translation 
> time); i.e. why is 0 stored at both translation time (4593) and at runtime (4591)?

That keeps the translation time state in sync with the runtime state until the end of the TB.


r~

