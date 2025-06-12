Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F5DC71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 07:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPcI8-00029C-8c; Thu, 12 Jun 2025 03:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPcI6-00028m-8Z
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 03:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPcI4-0004Ow-En
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 03:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749713038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IPijbdgWcMLZ2mvcdYN8gBu2OftU4vblfep1zTswxOc=;
 b=hI5fz7nTJ3C6OtvY57Btq0nqziUswGi+MTLBRCQJw5JnpHr/66D2bGvRXCo/ZALvK4XrR5
 3HTKVLe1R9L4sUGgIt9GYMG74JXqUYZeABINLT441WNv2E/1ZVZ57xVl5Az6OPO3xywChE
 yyRXc/1jD9AsA9O7UxJsRwncbYYlyV0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-47knhUrbOu6VKDbYh4xVAw-1; Thu, 12 Jun 2025 03:23:57 -0400
X-MC-Unique: 47knhUrbOu6VKDbYh4xVAw-1
X-Mimecast-MFC-AGG-ID: 47knhUrbOu6VKDbYh4xVAw_1749713036
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f55ea44dso286276f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 00:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749713036; x=1750317836;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IPijbdgWcMLZ2mvcdYN8gBu2OftU4vblfep1zTswxOc=;
 b=SVE58snimyBNcWwHJowUWyBEPW9q1mu58cjz8DDh7JVgYy/R0wagnMEIhS6pbK40O9
 Gi0MO7lXAo7JzbdmX7GozotiP50f/9mWiXkFKkyMvosiC6PAjtu1s79Q//3SQD+vPhfT
 IOQ2qYVo1vxw+ooNRmgZsjiBG7Q77MyVZmlgvQNTywYkwci9jUbA7xl4FwZ+0HEvFFAT
 OYd8TMAAOK1Y5JH5udPSXT9kMX4ByW36nnJZooGeTeazhpUw2P85wQ2WTwL5tdm6w7Si
 W2AWiSGcmqeEihe13D9hQjIAJHtpgRzWtdX8t0MbQZDPmLmd1dHHJ5Bz1ZN7Idsjhg77
 OlLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9+30fqwRoBGYgXl+pJjBAcD3/vH+cvLxRqG2UxaNh9Ur75qTdrdo2KrKUJWN0GhcIbVWdNIgKVnMO@nongnu.org
X-Gm-Message-State: AOJu0Ywqc4zL1vsd0968V01r3CGaAcwuqRfS8tcndvyYTFYS+0Ep0fDi
 7QGZb0J3I6nG7n3h5wJzLr2B2nv6gUPqopWlkShJO2qrKvI93g6Phz23q6tBblT5CjRX2EI6Xfh
 l6dp3hgD2X2pMY7dqYskEZMo6o8aqgIFND2AQ1bFsQdPOo+2Qou2K1KFj
X-Gm-Gg: ASbGncu+fxWnnnWsmT3MOnGerHVM4AwpMtlUkrPho+RTcbA6kF9CuLgPE1V2NqY3GKQ
 VJFrSJ1yZT2HmOqQFb1aEfr+NntwZNixWF+8001hUivv3P1QB/Ol0dytoewiagxKVgr39/SSFiT
 UQN0tifiJrzZeOJYLRdiQjrCEYaR/Gb49VU2iY097Ky5RCwzcWU5PCi2qehoTHFpUUh2B3cnwzx
 9BU9AFsHFC+dKTWizSmo3ThqiS7bTBiSG7POckWlkpW6EDY7syKKQmsEeRPlOqw9UQxzqLVgLhf
 wTTCHwrzLV+n53ZdADjk4GD0+4j44MhfMzGVz2leXGxisScab3EpU+CA8Wbw
X-Received: by 2002:a5d:584b:0:b0:3a5:266f:e6fb with SMTP id
 ffacd0b85a97d-3a561374b1emr1455044f8f.44.1749713035798; 
 Thu, 12 Jun 2025 00:23:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyZmY1iwCRPqv/VT+QT8R8Y3833uPzb9tSIwLgr8f6SEYY1WjLn9ew9N3zLr4fMgUuELhm2w==
X-Received: by 2002:a5d:584b:0:b0:3a5:266f:e6fb with SMTP id
 ffacd0b85a97d-3a561374b1emr1455020f8f.44.1749713035435; 
 Thu, 12 Jun 2025 00:23:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561976805sm1104460f8f.2.2025.06.12.00.23.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Jun 2025 00:23:54 -0700 (PDT)
Message-ID: <c95a3209-7517-4d70-b7a1-2aab1202f601@redhat.com>
Date: Thu, 12 Jun 2025 09:23:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 00/38] Live update: vfio and iommufd
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <0330df5e-8a9d-4fdf-bee8-a864eedac24d@redhat.com>
 <effe22b4-c6e4-41c2-b3e2-d03160560f86@redhat.com>
 <b6e11593-cd1b-4d51-9c17-37ccefccd094@redhat.com>
 <573aa339-1c40-43b4-997d-c3e4996caaec@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <573aa339-1c40-43b4-997d-c3e4996caaec@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/11/25 16:39, Steven Sistare wrote:
> On 6/11/2025 10:25 AM, Cédric Le Goater wrote:
>> On 6/10/25 19:39, Cédric Le Goater wrote:
>>>> Steve,
>>>>
>>>> For the next vfio PR, I plan to take patches 1-17 when patch 10 is
>>>> updated. The rest is for later in this cycle
>>>
>>> Applied 1-17 to vfio-next. Waiting for an Ack from Michael.
>>
>> I am planing to send a PR with this first part to get more visibility.
>> There is a slight risk of merging useless changes since CPR is not
>> fully reviewed. My optimistic nature tells me it should reach QEMU 10.1
>> and we have time to adjust.
>>
>> Please feel free to intervene if you prefer the series to be fully
>> approved/reviewed before merging.
> 
> A partial merge is fine with me.


Now merged. I am waiting for some feedback on the IOMMUFD part.

Thanks,

C.

  


