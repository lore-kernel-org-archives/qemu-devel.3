Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49F1C88E77
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 08:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkIJt-0001Wb-2J; Mon, 26 Jan 2026 03:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vkIJh-0001SC-Vf
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 03:51:27 -0500
Received: from smtpout2.mo529.mail-out.ovh.net ([79.137.123.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vkIJg-00087k-CD
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 03:51:25 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.143])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4f02MB5l2Xz5vqJ;
 Mon, 26 Jan 2026 08:51:18 +0000 (UTC)
Received: from kaod.org (37.59.142.105) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 26 Jan
 2026 09:51:17 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G00694d57b8c-6b9d-44de-a431-44090a01bf0e,
 329AED9B4B2025A2B6FD845E756CD38D93ED9099) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <a9e4c563-3f49-488a-9bc5-b8e64884520e@kaod.org>
Date: Mon, 26 Jan 2026 09:51:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/1] hw/i2c/aspeed: Introduce 'bus-label' to customize
 bus naming
To: Markus Armbruster <armbru@redhat.com>
CC: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 <troy_lee@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20260112083054.4151945-1-kane_chen@aspeedtech.com>
 <5e72f6d4-6914-4797-85f6-6131af0d1349@linaro.org>
 <7b67c00a-2bf3-4a25-aae4-9d4dd932486a@kaod.org> <877btdn0gv.fsf@pond.sub.org>
 <ba5b61db-64ad-495d-90f4-03e5553bf38e@kaod.org> <875x8win97.fsf@pond.sub.org>
 <62cc752e-fd06-48c9-9aa8-badbea8562dd@kaod.org> <87ms25er5x.fsf@pond.sub.org>
 <cf5124a1-e4ed-444c-8221-29f625c281cd@kaod.org> <87h5scday4.fsf@pond.sub.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <87h5scday4.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: af17a998-a8ac-4a9d-8ca1-c4070c154131
X-Ovh-Tracer-Id: 3100165396613663617
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGbK5p/SrB3BQFJAtRqFyeeOwVKuWG/917wY/vSG7ZaB1WyPDHsX8oDhguPgmifZVzKKHMV3KqUZ3RtTZ/v0+msIQkzSp1KuRcVJJZ0KGlKmiDXBjSp2UTtxl4yXjtq5N89Ca8KWcWp7scXSrcYyU9CA03hOfzmQWmQlTBGT+ykvP9TgDiTadvNocyK55GhtGL8WeEzAAtQ9mGcS0AkTzsY4ePFoHTrjsEomsHfZ0nSxyA8vIVIrWSNWo1DcHnYRgkcQbASHa20dcHefRG2ZRLYumVHsW8n4yoUImVTuyc6izDocpjSlS/xmqAki21GCocUwqCXC9SMe+rghZ94QjlCEZAQkMsdbgOB8GDZ3E33+N8XVOECMTVX2lPrBrM5fLNPKKvNeOsUvSzYDKfj23dJVgMpA845oGAUTwR9MvnRd+w1EMKLyILaNjhqw98k1GPFRPLB96z5xOEmDyKGlwgbVIbN5ZonQMMq9GUSsbbFvBDN9Wt9Yf1Gp9dDQQTPIDGzar5pCgjVZb5hDC1lgUjIVaHX4LjMQVgYv1z0/l5Jv3RPWnGM8t64PsIT9HVwFAbHtwTMgXcf+XbDMQCZxX+J0YyUpSPkWiSu7NsdyK3BxpMKJhK9XFrKqeFhFYq+8uR236pYMcNiEzh5d4iG6hIa79eLJ266/F/u7+efqDgLOQ
DKIM-Signature: a=rsa-sha256; bh=kU6NmTpsXRu7a5oPm468eFviZfGzL4lpaolyTo1Jh3Y=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1769417479; v=1;
 b=Y0ve3knza/+q0NQroby0gfKqCXiILaAwu57Y2DB5ljzv4oJ9H7m8bLHTRmm/dSW4E7tDSTG1
 ZVm1k2LQQEi0db0yUQ/PBPm1MWb0nokvLmNPIC7DxggO7jN6t1TEkqL4YFpubs6wxZNSNApPWV/
 YuNdroGi6sEBxXV+BXpxQVGlHl1yvq03ZHdCY0WF6naQOnIqLlE4i32cTWPJIuRkwIm7xqEBtkz
 oVTIRb0NLVj8fyiVq5HDDMrT0aXyIT22wuUJHQ3ejjeNLzrtF5pmbL2eJxZ6wRQE10tvpWQ8slm
 SwnS7TUpnnMmz5pzn64Xo0wPtUzTdXdwXIvpI6Ak/M0Sg==
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout2.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

>>>> That's why I regret not letting QEMU taking care of the naming with :
>>>>
>>>>      s->bus = i2c_init_bus(dev, NULL);
>>>>
>>>> This would break the user interface though. This is still an option.
>>>
>>> Since the devices providing these i2c buses have no qdev ID, these buses
>>> would then be named i2c.N, where N counts up from 0.  I think.  See "Bus
>>> names are defined as follows" below.
>>>
>>> Good enough?
>>
>> Good enough to avoid the bus naming conflict, not good enough
>> to easily identify a bus in the machine topology and it's also
>> breaking the user interface ... too many cons to be a good
>> choice.
> 
> How is it breaking the user interface?

Sorry I might have misunderstood your comment.
  
> Mind, I didn't mean to propose changing existing bus names, i.e. the bus
> names "aspeed.i2c.bus.N" of the i2c bus objects at
> /machine/soc/i2c/bus[N]/aspeed.i2c_init_bus.N.  Only the bus names of
> the new i2c bus objects at
> /machine/soc/ioexp[M]/ioexp-i2c[0]/bus[N]/NEW-BUS-OBJECT.

Yeah that's fine. This is would be a good addition if possible.

Thanks,

C.

