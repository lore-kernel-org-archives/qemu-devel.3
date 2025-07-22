Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B69C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 07:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ue7Z8-0002LK-Vu; Tue, 22 Jul 2025 03:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ue7Yr-0002EC-9w
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 03:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ue7Yo-0007Ce-78
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 03:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753169832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0MQ7x154NqVP9nFw8weJMNUpYTZP5zp+wi4jYAH2iL4=;
 b=DyWpqrAKW37SNWyPWcCNMOdt/H/UQUMAtGuhfO1m1602fK9lGkZ2lcht0VkqIXbWj9iI9u
 RquvgQVanU2145tZipnyn1bZvtB/biocuAWS3JbmjOZuuOxFyPpnn4MTjxQoeYbcHOpP2z
 5BwzNoVH7M5X83xzLnXVtv3mt55FhDk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-1Ma6zurgNdm4QAXMgwf4nA-1; Tue, 22 Jul 2025 03:37:09 -0400
X-MC-Unique: 1Ma6zurgNdm4QAXMgwf4nA-1
X-Mimecast-MFC-AGG-ID: 1Ma6zurgNdm4QAXMgwf4nA_1753169828
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4563f15f226so9476895e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 00:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753169828; x=1753774628;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0MQ7x154NqVP9nFw8weJMNUpYTZP5zp+wi4jYAH2iL4=;
 b=T3Gff7LmGI62UbGVeD83GzUeOlHGtWk1ou1+uL8HD5JIjMQWFCIItzaD8yi9hILBza
 ABycAQ1eF0erpDcQcWQ2Zg9Kw0Ce/WSoJwhYtKpMOpIPF3nV6AF1gRwtmf08h6KKRraV
 NaETiaKldqBCStfQu60yRZcJLDME3vqXv9xEHcdX0Vxy3AlutRpbA793g+tB8y/d2ky9
 Bc/SXfduYRXWjN1RmKLbTimrEPwGBeVQ0Gv+ybRF/DFpzEvUYKNvuG1IFo7KOv4q/rlb
 DMA+GDsu7xpjdD9cHc1EpE+53r1XM7+9cLI89aVm//XBeZ+NrOa8wJ2m8C8OZR9Xx7mR
 5XLw==
X-Gm-Message-State: AOJu0YxOGHA8RAEOAAta3tDSqW4dq+2fUq6nZi53VkUf16SXBVp/dp1c
 /r1+w80/Ls53neIsWjC+Ka+7oPbFDfb/1W3DNrgIBCHZrvo5SlnQs2Ede3cP4jCmYy9e22Q8e2p
 jZ9d3dACSq0uMB7F0I/WuBWFjU9RlZ9x+LXtMkVn2FPmswPfTgQiPz8K1
X-Gm-Gg: ASbGnctdBbhJ0ofUlqYGC4smc0jQUo0lIsHauncIPpJBWFztIXaLbAqI7cMYTcz8ciB
 wZvHYUI32j8tVLme3li5WW8JWrd1DS4nK52dRzWIYSsriqG9AlRdsEZHP/tmUzET8dpM6Ms19eW
 0+RXSj7TLL3UBISyoAqDae3im7RyxBBugOd8O98F7fQ967RQIatl2jupB2h1RlJh2aWcTlW+6g0
 hsgxNNJVKhQbitO9PvDSu0ou76jWDgvXIv8wCcr/xneSg/+8vW8OiextCdP9RQxjqB/aGFn9Bpv
 vASIMkGYpzSkVotX+YCGETS5ECHk4wlZg9sbsDkmU76YkjZSczBMLoxyGxiP6xl5UQcXIVEUaCk
 lmUw96vt37Qw=
X-Received: by 2002:a05:600c:45d0:b0:43d:46de:b0eb with SMTP id
 5b1f17b1804b1-4563b8ab992mr158404675e9.12.1753169827941; 
 Tue, 22 Jul 2025 00:37:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQNq0W649JZWPVqN8AoInR9v0a//jDbkfXX5ItPqtII60WCTv/GYlvxMRCwMC/2t5HNVXQ+w==
X-Received: by 2002:a05:600c:45d0:b0:43d:46de:b0eb with SMTP id
 5b1f17b1804b1-4563b8ab992mr158404315e9.12.1753169827480; 
 Tue, 22 Jul 2025 00:37:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2b803sm12303133f8f.19.2025.07.22.00.37.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jul 2025 00:37:07 -0700 (PDT)
Message-ID: <6a1e2b06-4f4f-45b7-8875-ecb60f74aa8d@redhat.com>
Date: Tue, 22 Jul 2025 09:37:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 06/13] virtio-pci: implement support for extended
 features
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
 <253cd85bc76ded8259fc9d12ed3764e2507bcb75.1752828082.git.pabeni@redhat.com>
 <CACGkMEvBr0dQdNqtYNdOT+oN13aOWh1Hob7C6NLbSKCcEDPtLg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEvBr0dQdNqtYNdOT+oN13aOWh1Hob7C6NLbSKCcEDPtLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/22/25 5:28 AM, Jason Wang wrote:
> On Fri, Jul 18, 2025 at 4:53 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> Extend the features configuration space to 128 bits, and allow the
>> common read/write operation to access all of it.
>>
>> On migration, save the 128 bit version of the features only if the
>> upper bits are non zero. Relay reset to clear all the feature
>> space before load.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> This is a guest noticeable behaviour change. I wonder if we need a
> command line option to enable and disable this feature for migration
> compatibility.

This point is not clear to me, could you please elaborate a bit more? do
you mean we need i.e. a DEFINE_PROP_BOOL() or the like to enable the 128
bit space usage?

Thanks,

Paolo


