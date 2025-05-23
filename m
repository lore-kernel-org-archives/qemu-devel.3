Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589CEC3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 06:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uILpm-0005VP-4O; Fri, 23 May 2025 02:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uILpe-0005V6-9h
 for qemu-devel@nongnu.org; Fri, 23 May 2025 02:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uILpa-0006sD-SQ
 for qemu-devel@nongnu.org; Fri, 23 May 2025 02:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747981470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kGqE1k7rmPDZ8VNp6gbjW2HvTyjUQyLmBNcKJUM6gPg=;
 b=Ve3zcATQq9KMuGJJ5k7EVJlnCZKOtFyft3luCDAApSNu/fbdA5IYhsyP0dwIDGJYwqOpaR
 +fRQJsYYjAP8jczzWe/o4Tfvu6wpNUKkdrzLbeuY8z2WKng4HUaNNZJi1h6/Oz0Glbcj4H
 mDbUCRTqorCLxPI+3BfJqpwNtuhdHTA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-JiJRr_7gM7-WVPWtQR5PYA-1; Fri, 23 May 2025 02:24:28 -0400
X-MC-Unique: JiJRr_7gM7-WVPWtQR5PYA-1
X-Mimecast-MFC-AGG-ID: JiJRr_7gM7-WVPWtQR5PYA_1747981467
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a360d01518so5535556f8f.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 23:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747981467; x=1748586267;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kGqE1k7rmPDZ8VNp6gbjW2HvTyjUQyLmBNcKJUM6gPg=;
 b=p5MtfioxtmgKo3LK7vbP0m82rEmqM3WAxRFRzziAnyWP/W8XjnfRoI6AO0s+xDAkxs
 ILh/kO+YrQzn+tL18Wvxq6lJPX9Zw34c8PweXhRPZ7p0ScVjG7xJfDgDstjAMJpqFA9Z
 RSsVJDGmPZn5cXNoejQFoxMIhiNJQzQoY1NZJZriYUp8lb3uQBokQQvBCf6hKSE+AZvU
 3Iuc67xoDLaBMPZqSv8/6Gd85ZWSrTQ/0GKqzD8MIWxy59eYLW5/pOUB0WE/oZG2USdl
 Bw7H0TGOPe5qZyvDH2V7Sl3fah3YIZxc4DANWR+Cnkoo+k0kMbdGDluWD0MjmsWQzD1Q
 Wkag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNlPh07dbjQ7C6ZFObGITYQ86ElhVIJwzKr0F0tzzgiga30RbzAPtTOhPQ7xLOtJGi/cbVWQOrcKj0@nongnu.org
X-Gm-Message-State: AOJu0YyO/9c6IAF5V/SAy4UiAmf4yCK57dmlro5FA7albTeKWMHuaaQ+
 QOil9OrfO6HNxHArgrymPNOBUt83aNfvtdZa3OB1trQYn6e9KLqSZeGf7n8bZ7nB/1WYqUVF5Gx
 pMs4e3RKmesxnP/La0uLXWOA1U2AXN5Fa/zSArg+v6cv2CeeqQO5P1JPH
X-Gm-Gg: ASbGncsPl7agBM4G6tFmKXdXL2PDxXiB2hx6ocmy0uFjABr1GlBnycmW/CwzqED5pxv
 YthRCb0ZFFdMgtctzZON8q1Xm0GPiFiv55Sqrwp02GxSn9hbHS0qBfvOGjZNeEYD0vR+SuWpHdx
 jhKma0GvR13ZhGEHXJyWttc6HhGhw8oblcy4A07ME4weDRMzwNL6oSCy2LXcuDwEEYqE5w5UCT4
 +npcPqa2f9bDmfkSlDT4qJAFTVJjxG8G3MavguoSz+aeaY4LKM5tdviVUraez6u26IQj4H7UggU
 fbws6SLXsASLKu+AIewxWFpfNE1W0gnZ9PD6Y58ULMcb3u+VbA==
X-Received: by 2002:a05:6000:3106:b0:3a3:6fe9:ca1d with SMTP id
 ffacd0b85a97d-3a36fe9ca92mr15924953f8f.58.1747981467262; 
 Thu, 22 May 2025 23:24:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH78NHyK0Wn5VMHxeArndDum2iPvHpPoDmcYeTtm8vJ8BZq77kisSijbBu2C7TrguPq+wg9jA==
X-Received: by 2002:a05:6000:3106:b0:3a3:6fe9:ca1d with SMTP id
 ffacd0b85a97d-3a36fe9ca92mr15924929f8f.58.1747981466903; 
 Thu, 22 May 2025 23:24:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca5a8c4sm25114934f8f.27.2025.05.22.23.24.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 23:24:26 -0700 (PDT)
Message-ID: <7570ec21-9f28-4a07-b8fc-e3775683c3be@redhat.com>
Date: Fri, 23 May 2025 08:24:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/container: pass MemoryRegion to DMA operations
To: Steven Sistare <steven.sistare@oracle.com>,
 John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20250521215534.2688540-1-john.levon@nutanix.com>
 <9c08a275-79ed-4192-bc6c-53c3c9f60916@redhat.com>
 <29454dcd-2eb7-4cef-83f2-659fdddeacf4@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <29454dcd-2eb7-4cef-83f2-659fdddeacf4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/22/25 19:30, Steven Sistare wrote:
> On 5/22/2025 1:20 PM, Cédric Le Goater wrote:
>> On 5/21/25 23:55, John Levon wrote:
>>> Pass through the MemoryRegion to DMA operation handlers of vfio
>>> containers. The vfio-user container will need this later, to translate
>>> the vaddr into an offset for the dma map vfio-user message; CPR will
>>> also will need this.
>>>
>>> Originally-by: John Johnson <john.g.johnson@oracle.com>
>>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>>> Signed-off-by: John Levon <john.levon@nutanix.com>
>>> ---
>>>   include/hw/vfio/vfio-container-base.h | 9 +++++----
>>>   hw/vfio/container-base.c              | 4 ++--
>>>   hw/vfio/container.c                   | 3 ++-
>>>   hw/vfio/iommufd.c                     | 3 ++-
>>>   hw/vfio/listener.c                    | 6 +++---
>>>   5 files changed, 14 insertions(+), 11 deletions(-)
>>
>> Steven,
>>
>> Can you base the live update series on this patch ?
> 
> Yes, its already on my todo list for V4.

Could you add your R-b ?

Thanks,

C.


