Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C8BC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubiUs-0002Vm-Ki; Tue, 15 Jul 2025 12:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ubhop-0001e6-MG
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:43:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ubhon-0004dz-0u
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752594223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EVVEV06Cr3MWb3YGwMKwm90D771RfLGEYdYgZysRI0c=;
 b=Zry0ZiIliyJXPKVMcK97kE35C5qhR/WOqfVy1a5554M5Y8dy/12+6Ks7fq3v5jltYDqBTT
 h6ZkCCLuD+MwiMo8oYH62zHur8D2JMIe6hUM0n1PD2uFMVFmAb07ROpm9rXVsNk2c/SU6n
 7I+pNQ1kN9muHiUdVLtAPRf0EF/kN+c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-l2Yw_fOAN0mgkwB20HTSdA-1; Tue, 15 Jul 2025 11:43:41 -0400
X-MC-Unique: l2Yw_fOAN0mgkwB20HTSdA-1
X-Mimecast-MFC-AGG-ID: l2Yw_fOAN0mgkwB20HTSdA_1752594221
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45624f0be48so7385765e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 08:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752594220; x=1753199020;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EVVEV06Cr3MWb3YGwMKwm90D771RfLGEYdYgZysRI0c=;
 b=iu44bwxsy9pt33icYggvsfzMpJPavwONgNyb50pTDZ4RD95o+YOxebbva+vBM5yiHE
 +EgUhRpWIaTNTe6mpFYl9uICzbovbmtbIUZhCBS3pkJw1A8PARcWb7tC0zVuQ7LUONKE
 SiFMSJSfJ3hU2N6YO+g/2ygrthsVnc+kY9d1uTSe7a6IGXjITxZR8AEZe4IXuQHT/kgP
 PpdCb9gmRQkqGORPA5jDKI59BtkVyOEvGb3soBJISMsN2R3zeFT+/Y0hIczNxpJzQvwU
 lmrMHWm2BmaqQ5o2O65ukcMvZZ665++Y7wzjGc4xGlkAJr5O3daQuE6yVgr19MQKHaMQ
 738w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrr1C0k8lTRjygfsG4zcJpHyyaWCFhD7DaAUmMUMRTRIO397tAHVuUcZCmoSiOsLnqt4A0Q9yPK80X@nongnu.org
X-Gm-Message-State: AOJu0YxmzTUarF7lDXF/Xl0VsrUp2SOQ9+jMwGDQIa8hX5WBjtx9tBrB
 SqwkrwhMa2aOnmXswDj4a/mp224mBtJcCk53zGV74zqL8BkysgBkNkNOiuSthSoD5Z5+OuLveie
 U/WrXORbyZyg+W6Fw+KCHte04hNJTOU8PGNGtRLTI4xHodVYd0zvyMxGqNcplJFys
X-Gm-Gg: ASbGnctGFioIuJC3E2Pjnkqk7PSz9BH8O9/qFMwaucV129+UIaEkshiRcrapouJV3AU
 199EgvZiFXxjdPdzARwkxmFkjm+1jiImPQs8gHGcQO8JlUSz/StEY5gALLgnHLQUW0Y5N6AmCuy
 Drj7JM8svBxVo3Wi6PfYF+8yqAjI1OQuVp5ss1QoNFX77SYFU5QTQJ2T7XtIIIj3gP6WrzoHaYY
 c7bdu0Z/eK/lEA4r+z+K3JHXqKrDaO4ND1Z0ELnukqXak3RRcR+KCAfcZt2LkX1wFWbhtQ2SPiT
 uRy4j1iUdr5TkPgUE8zhQtcxA6rGW04B5yJOoQob/GQdflVhwClXc5nCh8LDEcqCxkOYUAFEBN4
 4M2aY6WAH5a4=
X-Received: by 2002:a05:6000:178c:b0:3a6:d92f:b7a0 with SMTP id
 ffacd0b85a97d-3b5f359d05fmr12157625f8f.58.1752594220233; 
 Tue, 15 Jul 2025 08:43:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQdixTkib7IKderVRJRpNZBQyOcCCqBywj9UR7izGUcjMQdWUcilMbnriF7fEvi4gh/vD27w==
X-Received: by 2002:a05:6000:178c:b0:3a6:d92f:b7a0 with SMTP id
 ffacd0b85a97d-3b5f359d05fmr12157605f8f.58.1752594219735; 
 Tue, 15 Jul 2025 08:43:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26daasm15773872f8f.91.2025.07.15.08.43.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 08:43:39 -0700 (PDT)
Message-ID: <b0ff2033-b8ab-4cee-833c-83e70951a9d9@redhat.com>
Date: Tue, 15 Jul 2025 17:43:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 08/13] qmp: update virtio features map to support
 extended features
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 kvm@vger.kernel.org
References: <cover.1752229731.git.pabeni@redhat.com>
 <5f5a6718fa5ae82d5cd3b73523deea41089ffeb5.1752229731.git.pabeni@redhat.com>
 <aab8c434-364e-4305-9d8b-943eb0c98406@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aab8c434-364e-4305-9d8b-943eb0c98406@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 7/15/25 9:59 AM, Akihiko Odaki wrote:
> On 2025/07/11 22:02, Paolo Abeni wrote:
>> @@ -785,11 +821,12 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>>           status->vhost_dev->nvqs = hdev->nvqs;
>>           status->vhost_dev->vq_index = hdev->vq_index;
>>           status->vhost_dev->features =
>> -            qmp_decode_features(vdev->device_id, hdev->features);
>> +            qmp_decode_features(vdev->device_id, hdev->features_array);
>>           status->vhost_dev->acked_features =
>> -            qmp_decode_features(vdev->device_id, hdev->acked_features);
>> +            qmp_decode_features(vdev->device_id, hdev->acked_features_array);
>>           status->vhost_dev->backend_features =
>> -            qmp_decode_features(vdev->device_id, hdev->backend_features);
>> +            qmp_decode_features(vdev->device_id, hdev->backend_features_array);
>> +
>>           status->vhost_dev->protocol_features =
>>               qmp_decode_protocols(hdev->protocol_features);
>>           status->vhost_dev->max_queues = hdev->max_queues;
>> diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
>> index 245a446a56..e0a1e49035 100644
>> --- a/hw/virtio/virtio-qmp.h
>> +++ b/hw/virtio/virtio-qmp.h
>> @@ -18,6 +18,7 @@
>>   VirtIODevice *qmp_find_virtio_device(const char *path);
>>   VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
>>   VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
>> -VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap);
>> +VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id,
>> +                                          const uint64_t *bitmap);
>>   
>>   #endif
>> diff --git a/qapi/virtio.json b/qapi/virtio.json
>> index 73df718a26..f0442e144b 100644
>> --- a/qapi/virtio.json
>> +++ b/qapi/virtio.json
>> @@ -488,14 +488,18 @@
>>   #     unique features)
>>   #
>>   # @unknown-dev-features: Virtio device features bitmap that have not
>> -#     been decoded
>> +#     been decoded (lower 64 bit)
>> +#
>> +# @unknown-dev-features-dword2: Virtio device features bitmap that have not
>> +#     been decoded (bits 65-128)
>>   #
>>   # Since: 7.2
>>   ##
>>   { 'struct': 'VirtioDeviceFeatures',
>>     'data': { 'transports': [ 'str' ],
>>               '*dev-features': [ 'str' ],
>> -            '*unknown-dev-features': 'uint64' } }
>> +            '*unknown-dev-features': 'uint64',
>> +            '*unknown-dev-features-dword2': 'uint64' } }
> 
> Let's omit "dword" for consistency with unknown-dev-features, which is 
> also uint64 but don't have the keyword.

Ok. Can I infer that is actually legit to update a qapi struct
definition? It's not clear to me it such change violates any qemu
assumptions.

/P


