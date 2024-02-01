Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949A0C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 15:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVZJr-0001go-Qt; Thu, 01 Feb 2024 10:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVZJq-0001gS-KQ
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 10:49:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVZJp-0003fg-57
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 10:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706802574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l9llPGtEZFdQn+xADpDowAxYSr0kXL5lHYoJBsRWXt4=;
 b=KG6cqo0a91Iw90D99nU0MA5f/tpvG6qP32AYWouOcAwtxehgWbS3Icgfpqm5aCBBt5Hhjf
 xwmMwaq6T7+cc4Zqx2DzFPXJYqB8+j/XeBvP4XGAA2dMOfWwv8ETs2pGYqaFxANYkN7tFz
 lZOWT4jKnrM3U+Y7N2K77g22JoCsxVE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-aO3zNVklMNqCGj0Z1FI5Zg-1; Thu, 01 Feb 2024 10:49:33 -0500
X-MC-Unique: aO3zNVklMNqCGj0Z1FI5Zg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40fb505c97aso5920215e9.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 07:49:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706802572; x=1707407372;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l9llPGtEZFdQn+xADpDowAxYSr0kXL5lHYoJBsRWXt4=;
 b=X+SLffo/FdhX1Quh+E57d223c2k5rACmsVMQyOv+92zo42WX6H8VhByeoYVhsGRx8H
 q5Y7O1LlnwjvQiOM9ZMyYKLXHPb4v+xhznLO8NnVQc1rlPnCpp7mX5JN4bdfQKGqG8oo
 t4FzbZN36rgSD/hVe7X26CRAqHHnvx3VkDRN5+U5rjgJmeS9+cSy176JXPItQ9wHQAug
 9c7iSLwVVPL2pbwooPmi0E8O+zAG3zh3ytYitR8DteNBlEjtGKM57ANhJgK/24SZmsAs
 neP9j4PUVm1IpRb9nVA8c/wr7KwUoPmi7xtOHw1cv60AHXff5f9IDA6ecmYjFV4vLF9A
 gm4Q==
X-Gm-Message-State: AOJu0YwmRftjuiJsc1A7Sk5szvHuaymf7fJqxvPOmRw43r5Dc/YqLx8s
 NEj3Jv6EIWSXf/NeNyb3zKhFULFsGcarSpPDICiV8rzcATpU3YVuf3myPUuZgedGRHca7S3uu4L
 UdPtM5kTjlnVfAD9dlI/4U1tewNzXwtXdfBnePpT2oJecKYV90Oy4
X-Received: by 2002:adf:e88e:0:b0:33a:e56f:1ddb with SMTP id
 d14-20020adfe88e000000b0033ae56f1ddbmr3628732wrm.46.1706802572251; 
 Thu, 01 Feb 2024 07:49:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGxQkYKXG63n3X+1P6pnyejL0nA7VGBqa6APmRoAEWYlNeyfgqfWRn5B3+GtFoHWVnMnXdDw==
X-Received: by 2002:adf:e88e:0:b0:33a:e56f:1ddb with SMTP id
 d14-20020adfe88e000000b0033ae56f1ddbmr3628718wrm.46.1706802571995; 
 Thu, 01 Feb 2024 07:49:31 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXFnku9DDfpK7qwVY9xtdlgIHfKQ+RzZcOYS3UwaHYlRBk1rDid/9r7Ifn1XG9ueYUAXvfDa2EHUs84238mMz5IaFyTMx18ofzlpif1af8XAI0oMNEZp6bq1bb50g==
Received: from ?IPV6:2003:cf:d73b:4144:8f0d:1c55:f035:1a2b?
 (p200300cfd73b41448f0d1c55f0351a2b.dip0.t-ipconnect.de.
 [2003:cf:d73b:4144:8f0d:1c55:f035:1a2b])
 by smtp.gmail.com with ESMTPSA id
 bp20-20020a5d5a94000000b0033af280ec84sm10483812wrb.26.2024.02.01.07.49.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Feb 2024 07:49:31 -0800 (PST)
Message-ID: <16ff4b66-54c7-4253-a564-7b9391f1bbb7@redhat.com>
Date: Thu, 1 Feb 2024 16:49:30 +0100
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 01.02.24 16:25, Hanna Czenczek wrote:

[...]

> It just seems simpler to me to not rely on the BB's context at all.

Hm, I now see the problem is that the processing (and scheduling) is 
largely done in generic SCSI code, which doesn’t have access to 
virtio-scsi’s context, only to that of the BB.  That makes my idea quite 
impossible. :/


