Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60FAC47DB3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 12:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVsj2-0006cd-NB; Fri, 02 Feb 2024 07:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVsiw-0006cD-Cs
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 07:32:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVsiu-0001q0-FW
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 07:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706877163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2p5pd3G+z6QYJ8oqmskHcWdaaV+Dm9kCEVNr29n9FCM=;
 b=KNoxmNQYNxgHMnL1on9Zyr1qe8RMzo2LohYmSRm6OFIwrcvhA6wzc7DzARWOmVBebbi3NM
 JoLrAkdONhqZyyW3gCh2SsUt/KTm8MGCF6bNB8OkVsZl0NXL29o7UOvJiS1GMVIOK69wa/
 lI7MwLk5/tQ8vEQUdCYy+WcCVpqw3OE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-SGaxT_GaOq2phHoMueQZqA-1; Fri, 02 Feb 2024 07:32:42 -0500
X-MC-Unique: SGaxT_GaOq2phHoMueQZqA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33b26c3d744so99884f8f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 04:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706877161; x=1707481961;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2p5pd3G+z6QYJ8oqmskHcWdaaV+Dm9kCEVNr29n9FCM=;
 b=Prj6t4SDujhGtsqDqLuATmlqGczA+8i9VpYSiErFV9Rr944/jltXRe8vF10hgoxRAO
 UABr/zK5Gt2tHlxzEiLkh3reLRqxrkCfoDJ4N99XboHy+zpDuAXd1oLX059Rm7D4kX0C
 1Pf2sYq3H+lS0A3q+96dFvWebU118XLvKGiCpyNZkUuOImCZ6KvG+LY7SJEEvCz0Q2iE
 nnJhg8ZXMxJ4SJ/bXuyPrdr6c3Cjidt/7jLcdAlntnSuAMFrXgUjuYT6nyqxARvnHvx1
 EKq99j9JEgsq7rp0bkNKimDnzwq776b05Dk93vFn5zyM59sM0i/TGz1jbHxyGWWkOgs0
 xPng==
X-Gm-Message-State: AOJu0YxyIA00DHGo5xJ9kIqmT+bvagIxA0Lglrx8cHpSMuf62MEWcF5a
 0hdkJHkSfQjZqg1CeWZWksq109NsjmE77JvSqYLudNXSPKXfTovSYAodWmjQWCkie2UUlgaFHQN
 y8goJuSpPvjAj37dLDnzge9sg5bxpJi9gb7v0WNsgxkh/a5HsH9Uy
X-Received: by 2002:a5d:5609:0:b0:33b:279a:b4a5 with SMTP id
 l9-20020a5d5609000000b0033b279ab4a5mr289788wrv.14.1706877161131; 
 Fri, 02 Feb 2024 04:32:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjB7AANCPhSokDYGZqyRv6g5Lxj6GqRg4UD+HUc00Gfh+DTibY+cVEnuRNJtfrxYi85CvYUA==
X-Received: by 2002:a5d:5609:0:b0:33b:279a:b4a5 with SMTP id
 l9-20020a5d5609000000b0033b279ab4a5mr289768wrv.14.1706877160827; 
 Fri, 02 Feb 2024 04:32:40 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVHeiXD6Jxbb1b5sKpWYEdaDQwH4dEbDDMlH4SAg4WeUoTzcKpQw3Dh4n932NO7M8sNcSd7TshZP7Xqqf4V2ssjbHxtkBfkqRoD3FjkG2Laq4A0Kiu/RJhdDbBCQw==
Received: from ?IPV6:2003:cf:d73b:4129:e7a9:2cbc:bf9c:487a?
 (p200300cfd73b4129e7a92cbcbf9c487a.dip0.t-ipconnect.de.
 [2003:cf:d73b:4129:e7a9:2cbc:bf9c:487a])
 by smtp.gmail.com with ESMTPSA id
 jn22-20020a05600c6b1600b0040ef63a162dsm7243222wmb.26.2024.02.02.04.32.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Feb 2024 04:32:40 -0800 (PST)
Message-ID: <82f1a65f-9821-480a-b2d2-cb5d6bf55c5b@redhat.com>
Date: Fri, 2 Feb 2024 13:32:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/33] scsi: only access SCSIDevice->requests from one
 thread
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20231221212339.164439-1-kwolf@redhat.com>
 <20231221212339.164439-12-kwolf@redhat.com>
 <73e752b2-a037-4b10-a903-56fa6ad75c6e@redhat.com>
 <Za_zAj11uwavd2va@redhat.com>
 <08a66849-f190-4756-9b01-666f0d66afb6@redhat.com>
 <ZbOxI9Ar-YDn51Z0@redhat.com>
 <4c4173f2-b8fc-4c6f-88e1-8c31c4411837@redhat.com>
 <20240131203537.GC396296@fedora>
 <0a3e8d2a-add1-432b-b6b9-456ee0b17882@redhat.com>
 <20240201142817.GA516672@fedora>
 <6cb18310-c0cf-4747-a71d-540adba262cf@redhat.com>
In-Reply-To: <6cb18310-c0cf-4747-a71d-540adba262cf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 01.02.24 16:25, Hanna Czenczek wrote:
> On 01.02.24 15:28, Stefan Hajnoczi wrote:

[...]

>> Did you find a scenario where the virtio-scsi AioContext is different
>> from the scsi-hd BB's Aiocontext?
>
> Technically, that’s the reason for this thread, specifically that 
> virtio_scsi_hotunplug() switches the BB back to the main context while 
> scsi_device_for_each_req_async_bh() is running.  Yes, we can fix that 
> specific case via the in-flight counter, but I’m wondering whether 
> there’s really any merit in requiring the BB to always be in 
> virtio-scsi’s context, or whether it would make more sense to schedule 
> everything in virtio-scsi’s context.  Now that BBs/BDSs can receive 
> requests from any context, that is.

Now that I know that wouldn’t be easy, let me turn this around: As far 
as I understand, scsi_device_for_each_req_async_bh() should still run in 
virtio-scsi’s context, but that’s hard, so we take the BB’s context, 
which we therefore require to be the same one. Further, (again AFAIU,) 
virtio-scsi’s context cannot change (only set in 
virtio_scsi_dataplane_setup(), which is run in 
virtio_scsi_device_realize()).  Therefore, why does the 
scsi_device_for_each_req_async() code accommodate for BB context changes?

Hanna


