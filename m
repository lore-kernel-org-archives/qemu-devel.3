Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66756C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taV4i-0007Mq-Ld; Wed, 22 Jan 2025 02:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1taV4d-0007ML-Aa
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:22:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1taV4b-0002fV-Oy
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737530568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LH+OK/xgFEmNA2T5DnHkbVFR5H8XtVO2mD7L2PXaXCg=;
 b=Ii5mC/xMpcBEJ44IPkIVxRuz6+WCmiO5/FkUWHuxlG64mePR7xxZYQHpG/CL8OzRFLojkW
 1VhMeR5yrmObWzrOX5lxSt2UR2CC+FTej1/22h351cz7ZrFtuKeAdgVR+Q61a+yZG94djG
 Xv9JAvzJfAougFAtvir+akUJsm8Xmc0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-uTxwQdLxOtGKGaWxmUHKSw-1; Wed, 22 Jan 2025 02:22:45 -0500
X-MC-Unique: uTxwQdLxOtGKGaWxmUHKSw-1
X-Mimecast-MFC-AGG-ID: uTxwQdLxOtGKGaWxmUHKSw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-386333ea577so2576989f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 23:22:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737530564; x=1738135364;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LH+OK/xgFEmNA2T5DnHkbVFR5H8XtVO2mD7L2PXaXCg=;
 b=qrBTeubjelkI8F4iUFpek0sQ0snfYYEi2L8aY1O9NYArOqNibxwhImjlEHHroyKjgu
 3J68Z1WkO92FabcyCCgD8LOSuat95dVQg5zBR3vyNQvcdfn6pfZrG4AGwC1ETBAdJynI
 A8w1lVSudcBI6K8P4w4kx6lmVFyjjKzGeEq2ogjkG/S0nGlMDqMMqFoXxUVVAthNqHbB
 sUoTPfa2SJi1WP2IhuEwhdxhqV8FMkUS4vc5bJPeHQuUSWfg9w48lpMR1inEWQTrJCgX
 mbG5XRK7SVYpGNksoPntDhQmU5+qpUmgpXYljAtkB6ql+t8uthk2jxl2bMRP7TT+er5S
 XEPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9mUC8Ry8u0jV5JIaKOEzOiF2+Ghk3kNiz+l6UihH3O1px4OwRyCJp/6qn1tg9Am82R623ueEiA/uD@nongnu.org
X-Gm-Message-State: AOJu0Yw7HFn2RmDAT9JVHtX3dIqua9e7xvQVa58vdJj4asRPLtuqRNS6
 hvpfCUY8Rl2VkCape1UcG4GQ5LFORi0ZtLfDo7XPxFvIoSOqWLF58bI63ueMBlcFMSz8RrubhxA
 ixNSV6YraP6sXbv46DgbCNG25HxF8Z8FRh4q1KhcVKY6YJAREanLz
X-Gm-Gg: ASbGncs/5jhbet0G+/NGCFLqZhS4szvjimnz7aslwmNgsDSkIkNQ5FhgcqS3FO6C5vo
 MpugRU+REmVI0C1/Y9jgSt515jEwzF3XAByUB395Y9LX6TWvE0M5kYrJNV6TFO5ccdl/AiaCNZr
 y0jtXgAp1LCRzCQmeKuzPFYsu63/pkl8F2FKA5p6D6vs8GNMmaGQRpZafqLWjsosLTVw0WgKf4A
 SAdJsi0jK4HtYM22nIisBZXzKOgUlkVXnAEnlOmQ6UHN4nhuN0/buV2qWqAVFc8LG3TSdEDnw0R
 qiEpXQYazVu5viYy+nTrgO1229qNW0XV
X-Received: by 2002:adf:8b45:0:b0:385:ee59:44f1 with SMTP id
 ffacd0b85a97d-38bf5787274mr12619345f8f.20.1737530564331; 
 Tue, 21 Jan 2025 23:22:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5Cuy6nS4gdAo8ePJtfMm3Z/NwNPrMW5FYJ+IfoH2mi6p2KyAgBbW5FVpH/qMwo/z78VkFCQ==
X-Received: by 2002:adf:8b45:0:b0:385:ee59:44f1 with SMTP id
 ffacd0b85a97d-38bf5787274mr12619328f8f.20.1737530563966; 
 Tue, 21 Jan 2025 23:22:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf321505asm15276528f8f.7.2025.01.21.23.22.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 23:22:43 -0800 (PST)
Message-ID: <cc49ba5a-9fd0-446e-9774-f1ee1fb8a850@redhat.com>
Date: Wed, 22 Jan 2025 08:22:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] aspeed: pre-PR for QEMU 10.0
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <troy_lee@aspeedtech.com>, Steven Lee <steven_lee@aspeedtech.com>
References: <20250120095820.516511-1-clg@redhat.com>
 <SI2PR06MB5041DEDC7F75EA997D4ECCFDFCE12@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <3bf8a71a-f2a8-41a8-bddc-45d220a953eb@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <3bf8a71a-f2a8-41a8-bddc-45d220a953eb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
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

On 1/22/25 08:08, Cédric Le Goater wrote:
> On 1/22/25 04:35, Jamin Lin wrote:
>> Hi Cedric,
>>
>>> -----Original Message-----
>>> From: Cédric Le Goater <clg@redhat.com>
>>> Sent: Monday, January 20, 2025 5:58 PM
>>> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org
>>> Cc: Joel Stanley <joel@jms.id.au>; Andrew Jeffery
>>> <andrew@codeconstruct.com.au>; Troy Lee <troy_lee@aspeedtech.com>;
>>> Jamin Lin <jamin_lin@aspeedtech.com>; Steven Lee
>>> <steven_lee@aspeedtech.com>; Cédric Le Goater <clg@redhat.com>
>>> Subject: [PATCH 0/9] aspeed: pre-PR for QEMU 10.0
>>>
>> Sorry, I do not see this patch series in the following links.
> I guess the mailing list had issues when I sent it. Will resend.

There you are :

https://lore.kernel.org/qemu-devel/20250122070909.1138598-1-clg@redhat.com/

Could you please take a look at the last 3 patches ? Thanks,

C.



