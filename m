Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5512C282D1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp705-0003oa-H1; Mon, 03 Mar 2025 09:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp6zY-0003lt-2l
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:42:01 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp6zU-0004rk-VE
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:41:58 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4399a1eada3so41524715e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 06:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741012915; x=1741617715; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XqWCyQZGXvvOk3yf2weg9jbsEb0Zj2a4mfDjDC7wr0c=;
 b=WlEXIy/I2QLhRPPFkVaH6HmSnhXMMVhY3nyF86tsX4I+vE8LLQfkv/xKxUbct33MGf
 pem5qBal60/gCVKceSg0as7CcRaji9Lc806FiFUu3cwOUXO811VB9hlPzY1SnusLOhqd
 8bk/NC1SGfwkl4dgHx9Dbm6Au7ksPXX2ZPQViZCB+GqeqfgUen7+Uw/6PPe3qHBltmt5
 7bKzOuMpLdocsLfLj7p2NB9X2AadLQZSzBs2surx4pm+lhR+JPXDm455IaHC+vTYmCGX
 0Z3sp4F8GCYyPriBjXt31DqLOHQvEaIO9nPIAv96Suj3FLISENzRCf0VisD29itE+nim
 Q82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741012915; x=1741617715;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XqWCyQZGXvvOk3yf2weg9jbsEb0Zj2a4mfDjDC7wr0c=;
 b=GQShaZzUeNDe/jfIl8yk7WwEXe7ai0P9KgyxcfYnCQdfLjr3JW5NzDPP7kSz9PKSBN
 yjo6hICLgpzuARfmvg30PCCuTo7G1wTTV2Fa9WqdONsq2s/o+8wGElawNAovns6VqKq1
 0UytEP/wnBTrREDHvv6kJJV71oaOJnwGO9edet1a3bebQREYCqDtgzRvm5SONECV3VaB
 5hr3aFlfrUhYOEW3Y+vKds8GWguZFoznCFskXc8r35mfGsmdrkBEjwRd7bFzlf2u09VE
 FfH0j+Exk2NJFFWT7wmNsHaun1Zegb9m2RVbF1o1ZEG5ewO+YTVBUv31WBtVj4XAt0j5
 sOuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU+6/L1e7cCIfkSMeoFbkCSrR+3g8qAFrYPskneeb+N10Zt5GHaqRzNCYS9eTjdxZ2XC7CyhenX2Nf@nongnu.org
X-Gm-Message-State: AOJu0YwnwBAwYir3wtvZLkkCBGEeNj7bokpC4a0XtbAHrCjrBvJl9vbU
 /Reot4tm5dprXtuFI7oV1sUl5rrI4d8IjawXzub5SIhu3Hj9Xqfx2y1FuvPa1FiKTAyeW4pkcEk
 Cm3fPBQ==
X-Gm-Gg: ASbGncuIBmuP8L+/c+JIG02QTLmNG5zDuUSBI7N4tyUGL/oYJ8x9Jh7njoJZYCnQI62
 QRqWlDyAJQB/fXwL3oftgVXrZWPrXK8RvlzWJBds2f9PdiHqJFAr96DZ9nxYvxxwWMqU5HGRYyN
 iCuVzN+jAEM+LvbYYUiUJEyjgw0vjgfolsn3vdmgjpRFw0kiEI/y8ic5anBYtn88bRtteWTSpBL
 YjHRiU/VBNRhB/4qJktN9E7YMjhGaSJPpDwLknn4P5l9FKRmZLxzsD++OD7FtHhzXcQKgwUiKw+
 6i6ZzNNj6VLsOHownE8xRk710vwKTZt58gdRQ/kTgO5r0+TOptjQlikdXoxbEadXP3CdB2jKe3Q
 EqoiLhEMgmmO6
X-Google-Smtp-Source: AGHT+IHXa+gonvSDbtkQR6bPsFgdQcuJ796EwGIpgCyi3iO1WiRMoSY9sROxc91pJhgEONYvTl7cHg==
X-Received: by 2002:a05:600c:a08:b0:439:60ef:ce94 with SMTP id
 5b1f17b1804b1-43ba697f10amr96194315e9.21.1741012914997; 
 Mon, 03 Mar 2025 06:41:54 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bbcd83914sm53359165e9.29.2025.03.03.06.41.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 06:41:54 -0800 (PST)
Message-ID: <5db7ef43-4e27-4221-8c0b-5112333882b8@linaro.org>
Date: Mon, 3 Mar 2025 15:41:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/misc/macio/gpio.c: Add constants for register bits
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250224141026.3B36C4E6010@zero.eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250224141026.3B36C4E6010@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/2/25 15:10, BALATON Zoltan wrote:
> Add named constants for register bit values that should make it easier
> to understand what these mean.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/misc/macio/gpio.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)

Patch queued, thanks!

