Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9B4C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 07:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udlJj-0000QV-RR; Mon, 21 Jul 2025 03:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1udlJ1-0008HX-9l
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1udlIz-0003sY-54
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753084283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfpZ8gcc+ZYVPj5ccd/ihdhMUkW/vUU+QE13ff268u8=;
 b=TSQOSuZM3+zNo0JIG8mZ/j74VCQQ8Aw8Mxlvj7QcCy4/EQiw3i43Y67jPRxn+LIjdf/KKt
 7NLRifw/2Oqqc4s/MgBesPgHqMMToHFkOIsGwTtrnK4tDpiGR5zlwyAa86dtTt9fzzU8re
 89xoIj28d7txkqW/o+OsDn02PHp8y/k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-SCMZWFYDO9eyTP-rvqf5qA-1; Mon, 21 Jul 2025 03:51:21 -0400
X-MC-Unique: SCMZWFYDO9eyTP-rvqf5qA-1
X-Mimecast-MFC-AGG-ID: SCMZWFYDO9eyTP-rvqf5qA_1753084280
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-456267c79deso12754125e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 00:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753084280; x=1753689080;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bfpZ8gcc+ZYVPj5ccd/ihdhMUkW/vUU+QE13ff268u8=;
 b=M++PmjfOx0G6JIu2oQNFoOH9e7JMwa4u+yL9hUlELLo58D8DfzJ1kNHVhRb0p6z3vk
 Hndy86GKNqBP73Z4D31hzKlQkXaQToo5Ej9CgHtXuWSsbzmbPhiCvm3va5jxoIVDP7Oy
 F6+I5Ld/hL3RwysA0bCFmERqSZOY7/VapmdZ8t+Dtfgqb9de4epw/xShFsGojgbj0fI6
 l92+j9OlVNaCWyLgCJFzWbIrkoFPTDi2n90kuP99dar+nV9ZocCXQm1Gpy6ZhbOKdcKO
 jp/tXwomka2m6RoSnr50aV57DKoLn+NO8YJ6QMHLD1eLIeOxqZMu29UuhxUxa+RdihlA
 rEyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMxqOpdOZbv9Bq6/1+YJoiK8Co52csYcTeK/VE/1WmYkXOdcEwjc+u3YkfHqNoSxHwoLhZKkAZm7Ch@nongnu.org
X-Gm-Message-State: AOJu0YypeFOMX0EWbzce5J8QYm/fbEbqlxW4DPIBMSRa7nHjay4PSjx0
 O+ak08uHkN3qv/eBeNN/7wqRmHEly0HU5NcOZ3dfXXkfEKVNinHLzqOoQLOg1yGFCziu3wZ3yMl
 Wy6ojKFAhKgdqIXvpTDOM+D1sNZG19/YTEDqJyVFzUSU/iR6Xxm1W0SS2
X-Gm-Gg: ASbGnctcLcXIVu44tFcdMX5bFD2mz0Cjp80c2h723vQvWVPq1kd3mo8EIVpdF6faWus
 8BMYmVS0/pdhcjZu12Q8NrQx8JAyOMCs2YoWZmMW84cjtF/wQTBVvwHNWmpUxaq4Oipa/EAieGw
 MmGmUFu5+spLmp/mhpEwV8i95qQ3IMs0z9gW/Bozb7xiFw2D+xniXdt417NGc93XZk16ES23BH4
 GACNbPw/isnsiloB/TuU511DWNQUNpy10eLopxjeEtkDEBL0mlFKZpjCip6i+M5kpFeg+xiudg9
 rTuaG6uB7hp4u1XH/RaoVAcJLaDzJhgZkdMWS4lGI8SWAJlF5aIGcW/JWCr67j6+caz8NsiFQu2
 1KIjyzVeaF5Q=
X-Received: by 2002:a05:600c:3481:b0:43c:fcbc:9680 with SMTP id
 5b1f17b1804b1-4562e3c4b8bmr151721735e9.25.1753084280341; 
 Mon, 21 Jul 2025 00:51:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExcKfWe+gtgjgwjcteSUfjKGdaKDdqK9edMQXxqshAu2xNUKahPerhJtZtYRJtZL0KuwupWA==
X-Received: by 2002:a05:600c:3481:b0:43c:fcbc:9680 with SMTP id
 5b1f17b1804b1-4562e3c4b8bmr151721495e9.25.1753084279834; 
 Mon, 21 Jul 2025 00:51:19 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-456278a4460sm132792705e9.1.2025.07.21.00.51.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 00:51:19 -0700 (PDT)
Message-ID: <5ff3f19a-8c01-4df8-a034-5d81184bd225@redhat.com>
Date: Mon, 21 Jul 2025 09:51:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 04/13] virtio: serialize extended features state
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
 <88978e62d3eb7a58d7d647c7ee29f074ccc99bc0.1752828082.git.pabeni@redhat.com>
 <2e3a7cbd-1055-4888-9577-3344d42ea050@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2e3a7cbd-1055-4888-9577-3344d42ea050@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

 7/20/25 12:44 PM, Akihiko Odaki wrote:
> On 2025/07/18 17:52, Paolo Abeni wrote:
>> @@ -3333,26 +3362,23 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>>           vdev->device_endian = virtio_default_endian();
>>       }
>>   
>> -    if (virtio_64bit_features_needed(vdev)) {
>> -        /*
>> -         * Subsection load filled vdev->guest_features.  Run them
>> -         * through virtio_set_features to sanity-check them against
>> -         * host_features.
>> -         */
>> -        uint64_t features64 = vdev->guest_features;
>> -        if (virtio_set_features_nocheck_maybe_co(vdev, features64) < 0) {
>> -            error_report("Features 0x%" PRIx64 " unsupported. "
>> -                         "Allowed features: 0x%" PRIx64,
>> -                         features64, vdev->host_features);
>> -            return -1;
>> -        }
>> -    } else {
>> -        if (virtio_set_features_nocheck_maybe_co(vdev, features) < 0) {
>> -            error_report("Features 0x%x unsupported. "
>> -                         "Allowed features: 0x%" PRIx64,
>> -                         features, vdev->host_features);
>> -            return -1;
>> -        }
>> +    /*
>> +     * Avoid silently breaking migration should the feature space increase
>> +     * even more in the (far away) future
>> +     */
>> +    QEMU_BUILD_BUG_ON(VIRTIO_FEATURES_DWORDS != 2);
> 
> This should be moved to around virtio_128bit_features_needed() and 
> vmstate_virtio_128bit_features as they make assumptions on the feature 
> space while virtio_load() doesn't.

Please allow me the following dumb question to try to avoid more
iterations for small changes. I guess moving the above inside
virtio_128bit_features_needed() would suffice?

Thanks,

Paolo


