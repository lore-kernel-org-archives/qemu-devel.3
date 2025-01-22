Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAE9C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taVJI-0004zn-NC; Wed, 22 Jan 2025 02:38:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1taVJH-0004zE-LN
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:37:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1taVJG-0007ik-2g
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737531477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JpX22bMwZ7uKfI6ptKwXi2HQWN8LXPebIGIRCOU9Kvg=;
 b=OVvBT9uDkhNkwz5AC/Y8x1vk5V6CUhQIwHhSeQv1/AAJNaspPW9kUC402ACm5ufN94GYBC
 +pKB/02NjAnq5UdciuDmWQlz6fcsm6JeSm365VAYvZCk1vUIfkBZG4ewCYuCiOJiE7fhtU
 8s2X4/uUqsRaPe6GKvkn+J5fY0U5KyY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-IXEEOGvbP_KmH5upjiDycg-1; Wed, 22 Jan 2025 02:37:52 -0500
X-MC-Unique: IXEEOGvbP_KmH5upjiDycg-1
X-Mimecast-MFC-AGG-ID: IXEEOGvbP_KmH5upjiDycg
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385ed79291eso235927f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 23:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737531471; x=1738136271;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JpX22bMwZ7uKfI6ptKwXi2HQWN8LXPebIGIRCOU9Kvg=;
 b=u3ARgR+5QBfg+ooWm5UIXBZappgy3LkW/nPTh4WgDB1N9Mx6nRNmxwvxfBV6hS8F4V
 s//nd1fQqQFtaMFV1YIgqTpeAA5E+UzzYOvtJtSv3iIlpyRLxWo1GMbhnlI9dEmstPJM
 MfWJ1NWF7gDbEn+VZTzRlJaMWNoqfOx0vHgqVlfdaTvLmfwJOqdf7H7k8XkFtEFxbrWE
 uElCXYqI5jcJ01tatTofuRvZH8Nm1gaqFnwE8rvuGELyZYcldaqoS69hlhoO9Z3/aq5/
 bqXpgvEeEJ08r9EgjDcgWymKWgc6ieagpYJhvPQk5KYbJBZxjUadrZZWudNAw20BQS9e
 BegQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1QkpMuWPfLOhcErCVoGlLXVZWUQ3bA1JnHi+yoettCqM6g3F8wGYOwe7/1ZzoZB6kfJyE9icsmr5p@nongnu.org
X-Gm-Message-State: AOJu0YxwR98jHShl3//cVNCBhTJ2jPnTYMBtEMZwWq1vVqgKDuDJ4KIi
 qgovdbpV+40HnX3RrqpImdTYqDNaDi6W823lnUUzlGy7Xa87j4zQGR3xcwLIaycScAiIKbvQDX1
 Iu4lljOPs/A7rqUdRNaLD/cZeVV/jPBLvpm0JEcZPH2R+dK2laNtE
X-Gm-Gg: ASbGncvLvx5GbOKU8yyNBfQ7HWVq/ewDua1XM/2Jfv58YFlQ2cQhGFA4ErloJYwMKAf
 Qj43s7EXWJ7P/cbjcxXA0HmFofkM+/0obGvcUiuILMcZP1Zwp07Od/xlR7DkS6Z62HTW7SuTxpE
 CnSAbVJx3u1EiEnJcQGtbcNVtdkWClLLXgzwElfvK8VVU2yfgESbvhEOfg4h8VKochORoUMGMfC
 GGpFWjsJY2uXixzVTAEIfHF3FqThoyKcLQfJVbleQNBXe/q3HHbxFP9mHC2klhbrzPJlpYABGoQ
 sr5OvJ36S9CCOXqemZAmQluY0hOXpOgZ
X-Received: by 2002:a05:6000:1a88:b0:386:3672:73e7 with SMTP id
 ffacd0b85a97d-38bec4fb6abmr20469949f8f.9.1737531471274; 
 Tue, 21 Jan 2025 23:37:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPLZtG8OJAVLAB+tuvkEPVvoGOGfgQdX2FaZoH5/v3H0jXw5gg/ZCEmC46Yf3txShGq90hHQ==
X-Received: by 2002:a05:6000:1a88:b0:386:3672:73e7 with SMTP id
 ffacd0b85a97d-38bec4fb6abmr20469932f8f.9.1737531470936; 
 Tue, 21 Jan 2025 23:37:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322ad74sm15688974f8f.56.2025.01.21.23.37.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 23:37:49 -0800 (PST)
Message-ID: <80de6b2a-c0e5-4484-925a-b4de081c5d6a@redhat.com>
Date: Wed, 22 Jan 2025 08:37:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] test/functional: Update the Aspeed aarch64 test
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <troy_lee@aspeedtech.com>, Steven Lee <steven_lee@aspeedtech.com>
References: <20250122070909.1138598-1-clg@redhat.com>
 <20250122070909.1138598-8-clg@redhat.com>
 <SI2PR06MB5041EE7E3762D569F0E13B2EFCE12@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <SI2PR06MB5041EE7E3762D569F0E13B2EFCE12@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/22/25 08:28, Jamin Lin wrote:
> Hi Cedric,
> 
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Wednesday, January 22, 2025 3:09 PM
>> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: Joel Stanley <joel@jms.id.au>; Andrew Jeffery
>> <andrew@codeconstruct.com.au>; Troy Lee <troy_lee@aspeedtech.com>;
>> Jamin Lin <jamin_lin@aspeedtech.com>; Steven Lee
>> <steven_lee@aspeedtech.com>; Cédric Le Goater <clg@redhat.com>
>> Subject: [PATCH 7/9] test/functional: Update the Aspeed aarch64 test
>>
>> Bumped SDK version to v09.03. v09.04 is available but not yet supported in
>> QEMU.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   tests/functional/test_aarch64_aspeed.py | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/functional/test_aarch64_aspeed.py
>> b/tests/functional/test_aarch64_aspeed.py
>> index 141d86385936..6a9ae2a34956 100755
>> --- a/tests/functional/test_aarch64_aspeed.py
>> +++ b/tests/functional/test_aarch64_aspeed.py
>> @@ -27,14 +27,14 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
>>           wait_for_console_pattern(self, '## Loading kernel from FIT Image')
>>           wait_for_console_pattern(self, 'Starting kernel ...')
>>
>> -    ASSET_SDK_V902_AST2700 = Asset(
>> -
>> 'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.02/ast
>> 2700-default-obmc.tar.gz',
>> -
>> 'ac969c2602f4e6bdb69562ff466b89ae3fe1d86e1f6797bb7969d787f82116a7')
>> +    ASSET_SDK_V903_AST2700 = Asset(
>> +
>> 'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.03/ast
>> 2700-default-obmc.tar.gz',
>> +
>> +
>> '91225f50d255e2905ba8d8e0c80b71b9d157c3609770c7a740cd786370d85a77'
>> )
>>
>>       def test_aarch64_ast2700_evb_sdk_v09_02(self):
> Do we need to change v09_03?

Indeed ! Will fix.

> 
> Others looks good to me.
> 
> Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>

Thanks,

C.



