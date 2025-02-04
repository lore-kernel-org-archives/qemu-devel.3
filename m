Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE27C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKS1-0006Gb-M7; Tue, 04 Feb 2025 10:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfKRJ-000633-GQ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:02:19 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfKRE-0003L7-HC
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:02:13 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso39384905e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738681326; x=1739286126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7hBbAyfdFlWZKWjGeCsN+593namTQhr2DVRjBZ3YQ1Y=;
 b=a2xIOh6ImMj4GVXMh1ZcrRMa0WCYwtjBYVppZbeguYmuHVwkwblangSIy854ti4YK0
 AFKNdPuTnFgoW8Sua+u55XdisgUMqv9XbQHfSVPXobtudH4CTPE/8IEq5fDlwIepigR2
 t6touVyIXmp96FIaKjXD48ybNx+NdirDuNtWtvG7nkrrXL+kiJBTTlFYZwB+VRRpWR9b
 VDYIjAnJmo8GYPAYeOubSIksKSh/+6sYK11hCOLyXcncXjXP7DC6isf3ooh6OuIOtnc9
 AE5GcFWsHzTYIY3QDuYHTnR7pPsJZfKbBhbziANgnubpEMCWylhjH4eoVKhCREOFq86D
 mX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738681326; x=1739286126;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7hBbAyfdFlWZKWjGeCsN+593namTQhr2DVRjBZ3YQ1Y=;
 b=Qx21C8pb7z6nJ2AcT8+OS4IoZOfv2voitjOKk4X2LiG/qdMwBk3Ac4Hs9K1nVE/aYx
 r6qQKao4mpq7LfDKFWYhqWqRScN8bIbyeb3LM8TdTFuzCDuSWX6Ts2o9Wv+8pYl4Yq61
 p4cpPuUK8Z0iwF48/BOok8y8kyfjuyBsF8gdyYvLSH2vN8zuJeG19MTZRHW4B0F/by2W
 Ydn+R6g8GVOCVEHrJg4BObS7lGNLlPZxGA1/qSGzcIoJ3cmhZ+ik5wAauJDjkDBqNx3d
 TUzqFdnBf5eEhK/4qTLsfMR2UzCV/KKZQ4Z3Eo3VZXFlY9zWjWLq1v7jPdSJc1Kzm5X2
 4GtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQmQcHpcgWvK8avjv7g0asZjTVYB5ik5swpb2RWm2FF6KUdJpekE3Dbqq0Y5FL85BXjEs4lFulSTiq@nongnu.org
X-Gm-Message-State: AOJu0YwWWampeVFy3v+W5SlCiMLLWUC76cIWuHi6iyl01taHbOHIlyP1
 enaICx9iadOUo9Fw9EA1KIWqBVDKjmkbyK96Tiqh08peew+dCRgVTLfebyGCIr4=
X-Gm-Gg: ASbGncvWOv6JFsTI4WknlUZt1RPgUv2UdoFV5GKapceQpYLUhYeotFfkNQIlqVnRfdr
 mw5ohs0fQQly+hoz1CchwCnIwG/S/AU4NjRulJjmYNYA0uopxygNZgJLO09Spt5u5euuqHdzpQG
 zi30J2sLJT+0DZNk+c9CRu4gALjpJgkNLsXESSM5Q9pik2c1cU/47SvTCUMni2B1lGxkfqSr67N
 XSWonLqG99q/WQo4zbZN0UA/TMuD5XWeGBfFlbMaFV9m5Sv7pWt51rxLT6cSsbAU0zIRk19tj6k
 xE9pHJVnZh87tspeA7Eb/IFAHR2aqrx1h4Fd1x0+AyvTQ71nolcvR8kNNRI=
X-Google-Smtp-Source: AGHT+IFzN0+wrsOFUvSoDLtnu6ybE6LYyzEKPLUS6RjnRr1ENqghKbU/ZqrmGjac5M0soKc+6Ijh0g==
X-Received: by 2002:a05:600c:3583:b0:42c:bb96:340e with SMTP id
 5b1f17b1804b1-438dc4349dbmr223569495e9.31.1738681325301; 
 Tue, 04 Feb 2025 07:02:05 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23deedfsm196834455e9.16.2025.02.04.07.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 07:02:04 -0800 (PST)
Message-ID: <a72c6e98-38be-4af6-bc21-43071d8e98dc@linaro.org>
Date: Tue, 4 Feb 2025 16:02:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINER: Add a maintainer for CPR
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
References: <20250204082859.846886-1-clg@redhat.com>
 <71b208c1-c61a-4498-8200-0850548f4d74@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <71b208c1-c61a-4498-8200-0850548f4d74@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 4/2/25 14:29, Paolo Bonzini wrote:
> On 2/4/25 09:28, Cédric Le Goater wrote:
>> The CPR feature was added in QEMU 9.0 and it lacks a maintainer.
>> Propose the main contributor to become one.
> 
> Why can't changes go through the migration tree?  The only addition 
> seems to be hw/vfio/cpr*.

This patch isn't about removing these files from migration/ maintenance,
as no X: tag are added, but to add an extra pair of eyes reviewing the
particular CPR changes.

As I welcome having more designated reviewers, as long as Steve is OK:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Paolo
> 
>> Cc: Steve Sistare <steven.sistare@oracle.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   MAINTAINERS | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index db8c41fbe0f9..efb9da02f142 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2943,6 +2943,15 @@ F: include/qemu/co-shared-resource.h
>>   T: git https://gitlab.com/jsnow/qemu.git jobs
>>   T: git https://gitlab.com/vsementsov/qemu.git block
>> +CheckPoint and Restart (CPR)
>> +M: Steve Sistare <steven.sistare@oracle.com>
>> +S: Supported
>> +F: hw/vfio/cpr*
>> +F: include/migration/cpr.h
>> +F: migration/cpr*
>> +F: tests/qtest/migration/cpr*
>> +F: docs/devel/migration/CPR.rst
>> +
>>   Compute Express Link
>>   M: Jonathan Cameron <jonathan.cameron@huawei.com>
>>   R: Fan Ni <fan.ni@samsung.com>
> 
> 


