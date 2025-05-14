Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B974C3ABC5
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 06:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF64i-00047q-ML; Wed, 14 May 2025 02:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uF64h-00047h-5F
 for qemu-devel@nongnu.org; Wed, 14 May 2025 02:58:43 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uF64e-0002Sr-OP
 for qemu-devel@nongnu.org; Wed, 14 May 2025 02:58:42 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22d95f0dda4so74847735ad.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 23:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747205918; x=1747810718;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VSFp+RXw6HN9au3WOIq7H6c+SMWJI/Bam2L1ETV9WJs=;
 b=yjYkOtrKgcfzdo0mn61Qd0uyfADC02SuauI2jb13gJ+ecxcVS1Shj1d+neA5FE+BJ9
 jCWsU8eLRFolmayazOGI0O10PWYhRE0VGSRdLsMfeOdn0uiH1ooTFVXysNSNIAbhRgRh
 IDS3dQOLFgm2J2HGkx2jIsmR23Zv9WuUy8JNk746Eiu4oLPjhy5oLLNPVIYK4L1DVqnQ
 u/+yi3KgRb+iySJE4UfkskTy/NgiH802x6Q+IyXa+xO2yCkg3c4f7l41mwPgHyCHW+0y
 frLnz2IoZizipop+6eSPu9vJxg3ArqGnwxbC5xHE3eoKaVkip96VxXzlPuP25GSv3thN
 jd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747205918; x=1747810718;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VSFp+RXw6HN9au3WOIq7H6c+SMWJI/Bam2L1ETV9WJs=;
 b=sGDvsbbbAIF+KeLlLViZDARmRhIwczg/QhmBsl+2xU1uKz9ZBZzqwFVZGqXuLhYRGo
 Yt8m9N+/6yGpE6NglygAt7E5plkyiVpAVGYLfjKzNoFnYJHKYlTU0rmavvbdHGTSr9Sf
 ChCV0BAuvn9wbhIlJlHcZiYY6D0CiLo62UMyHO+LjYp48+ZIlAc2svymwfiowSgfFyN+
 cwic8djKd8+gmsad4CLi26tDluDDMPEOGv5UUCqv4qVYQKtufQO+TzMy+EktHGEKf4jh
 p+mAJJYpXqV+wi3vHm4eUkjyr+Xlc6E3KCyTd0YLBWDRYOjFkruwlXTna285AsH0G/5P
 fkMw==
X-Gm-Message-State: AOJu0Yy6NwwvlrOtnnvNqoMfAeZ2BvNJ3uBY9+xekWe614WljCMAzDU9
 8gBL30PqM5xnmQOIciSnqk0Thkiv5oLIv51hHg5PJo/vxMzTIblXQG4h1BRyLWU=
X-Gm-Gg: ASbGnctVTO78pAhNas8clQKHvBI/WRpeUmcVUeKoLaqmM/qazdjL3botHzp8bFKjsGI
 Xrcse8baQmWAUw6QtvBeQbJ1vkHEpYzvLvdjMNR38/KqblZ6e2PO9MF7OOI48Z9towymCzZc9Y9
 jBPgBUnCq0rocG9M36asA2fQA4BOiewS/CjiTOA13gbcz0tNyCGdVL0RNLItpntoZjEtVupv859
 1ILuwH1KSVl8LjbkLxVWmDC2pbsl7K2PyteYWjN8vrnWzvFD3vlJxVan2JjkvLwAy7+/3+XNwwk
 Ij/jSkOLs+V+36OWyAlXL2SV1nntqv0MlB5PrR3qdbZ1igYE3AdScQ9eDbFSOzeY
X-Google-Smtp-Source: AGHT+IG8d/t3S0SCmuhrMj1hHh9/OsNd9KheKfpl9cg19P1CqTQAdtselDyDk/6PfsBMs/g9xkx5bw==
X-Received: by 2002:a17:903:3baf:b0:22e:5df9:8f67 with SMTP id
 d9443c01a7336-23198129730mr38912685ad.34.1747205918503; 
 Tue, 13 May 2025 23:58:38 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7743633sm92600335ad.103.2025.05.13.23.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 23:58:38 -0700 (PDT)
Message-ID: <f3d10b18-9755-46af-9623-fb0ed7d99c51@daynix.com>
Date: Wed, 14 May 2025 15:58:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: Add queues for RSS during migration
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 devel@daynix.com
References: <20250510-n-v1-1-19ee26ac3ca6@daynix.com>
 <CACGkMEt7xoX-HvV1mOo=zqpyV0se2ELBMvNV-uGpKUZPQ-PB2A@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEt7xoX-HvV1mOo=zqpyV0se2ELBMvNV-uGpKUZPQ-PB2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/05/14 14:05, 'Jason Wang' via devel wrote:
> On Sat, May 10, 2025 at 3:24 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> virtio_net_pre_load_queues() inspects vdev->guest_features to tell if
>> VIRTIO_NET_F_RSS or VIRTIO_NET_F_MQ is enabled to infer the required
>> number of queues. This works for VIRTIO_NET_F_MQ but it doesn't for
>> VIRTIO_NET_F_RSS because only the lowest 32 bits of vdev->guest_features
>> is set at the point and VIRTIO_NET_F_RSS uses bit 60 while
>> VIRTIO_NET_F_MQ uses bit 22.
>>
>> Instead of inferring the required number of queues from
>> vdev->guest_features, use the number loaded from the vm state.
>>
>> Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizing")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/hw/virtio/virtio.h |  2 +-
>>   hw/net/virtio-net.c        | 11 ++++-------
>>   hw/virtio/virtio.c         | 14 +++++++-------
>>   3 files changed, 12 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index 638691028050..af52580c1e63 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
>> @@ -211,7 +211,7 @@ struct VirtioDeviceClass {
>>       int (*start_ioeventfd)(VirtIODevice *vdev);
>>       void (*stop_ioeventfd)(VirtIODevice *vdev);
>>       /* Called before loading queues. Useful to add queues before loading. */
>> -    int (*pre_load_queues)(VirtIODevice *vdev);
>> +    int (*pre_load_queues)(VirtIODevice *vdev, uint32_t n);
> 
> This turns out to be tricky as it has a lot of assumptions as
> described in the changelog (e.g only lower 32bit of guest_features is
> correct etc when calling this function).

The problem is that I missed the following comment in
hw/virtio/virtio.c:
     /*
      * Temporarily set guest_features low bits - needed by
      * virtio net load code testing for VIRTIO_NET_F_CTRL_GUEST_OFFLOADS
      * VIRTIO_NET_F_GUEST_ANNOUNCE and VIRTIO_NET_F_CTRL_VQ.
      *
      * Note: devices should always test host features in future - don't 
create
      * new dependencies like this.
      */
     vdev->guest_features = features;

This problem is specific to guest_features so avoiding it should give us 
a reliable solution.

> 
> Looking at the commit that introduces this which is 9379ea9db3c that says:
> 
> """
> Otherwise the loaded queues will not have handlers and elements
> in them will not be processed.
> """
> 
> I fail to remember what it means or what happens if we don't do 9379ea9db3c.

The packets and control commands in the queues except the first queue 
will not be processed because they do not have handle_output set.

Regards,
Akihiko Odaki

