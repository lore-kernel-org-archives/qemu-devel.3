Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BD8C7115D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 08:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTcGB-0006F1-4r; Mon, 23 Jun 2025 04:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uTcG8-0006EX-OG
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:10:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uTcG6-0006XT-C0
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750666227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=z/G8R9KgRlW786UvzNeVbL7F/Oa3LtmSpMCATJg/C4w=;
 b=P4CDi3G7K1b2ooKXTt4J1qvoMYWQDG75ZDL/fJvyISajNzUrxIw5kZW13E/EXOZySFRbVp
 w73PPe/Hgf0ZwxbhrWHB225B3v+4iaPTAjjHq4UNto3auCHRW/FRrYKzfdkbz3ubv4FJ2E
 zluX0L1Y2vaAs3/Y5YTQcsSu3BxD9L4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-yAIFmOSZMeK66ndk74Ovlw-1; Mon, 23 Jun 2025 04:10:25 -0400
X-MC-Unique: yAIFmOSZMeK66ndk74Ovlw-1
X-Mimecast-MFC-AGG-ID: yAIFmOSZMeK66ndk74Ovlw_1750666224
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a50816ccc6so2416250f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 01:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750666224; x=1751271024;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/G8R9KgRlW786UvzNeVbL7F/Oa3LtmSpMCATJg/C4w=;
 b=mLnDv/3kAO3CrpiJggqsQSpe+LBFQHbIY2NTwTYgnLjfqrJFSVAXMn1uxW38h5oUe/
 i3D5AliKCe35l8erytXTkAh03pL+U2+uW23NOdPpT3hiQwKKST332HylqDySLqWsFMPL
 rqOnyw/UkDIDAulGXlhtrGh+IgROu/BoEoNVYs+yCA5fK/mNDA3a3JLieXwWPx01ORBd
 Ak7fGOGQd02k1/QKKMQxCSwKCkxGgRMwrU4hgfdz4vmSfSEHS+CYfWSF/rItVtBdfZ+/
 xIbqtnk53Sd+QFUb/NVKvu2ls4mfL7dl+yVFBuUuoS0IPa9lBNivCg+sb5VpNE88ahsw
 1mZQ==
X-Gm-Message-State: AOJu0YwHKyNxkpCZaOpKXD3vNTwUOdeTNjAm41bIffBPnj9xee2oyikm
 5MrQhkuBhIdwBYIU86qyhBJNiaF9cvXuJBCUVNbdonxzUDpD7C2bXEEc4QAkmwYmvZZW7RY70IL
 kVvo63j7TCsfqK1I8t/0yw9M1zRnvOsa+9KvzOCiVldE00pZJlkpuX0BU
X-Gm-Gg: ASbGncu750eW9DnRnHQxM6DI3vs6T6XDh+JeJP1+0wqZkYvI4FOxKpD+kSnH0jvFUMe
 I+mLKvCnyIpquOLAqeezXCYTt8ACv5+FhBOJhVd2FDoHzM+QSkD8CmJ0hEEoICXVIkWzwAFpGsV
 cxckFyDWp7M8ZLxQ/JW1aQdPQECI9nX5QSvd5leX9h22oSW/5CHdlv3B4CiEDVynZUkyIXccd+p
 6vjHhSwegffXlE3VTDoPz2Q5kKAfo3Y9bRlROfJBoWTZGplpj26Rmx5bO3vXBEpBfAs2PZkpgqe
 AdELs8HEM5LpJZswfzjc2gWY6PSVh69aMuBg2F7jGImEuz2TVMrtxkMQkOvYfA==
X-Received: by 2002:adf:9dd1:0:b0:3a4:f655:8c4d with SMTP id
 ffacd0b85a97d-3a6d131787bmr7709448f8f.27.1750666224285; 
 Mon, 23 Jun 2025 01:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPAS+6ua/GIQB41nMRPnYl4724wUmxPEKf0KmxV0lwboVbD2h0KDZRTctiOPD5DW+QWIEwSw==
X-Received: by 2002:adf:9dd1:0:b0:3a4:f655:8c4d with SMTP id
 ffacd0b85a97d-3a6d131787bmr7709413f8f.27.1750666223829; 
 Mon, 23 Jun 2025 01:10:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f18215sm8642468f8f.29.2025.06.23.01.10.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 01:10:23 -0700 (PDT)
Message-ID: <b1a9b090-e8f2-4e80-943a-001db1229707@redhat.com>
Date: Mon, 23 Jun 2025 10:10:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] net: Add passt netdev backend
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250618083930.451313-1-lvivier@redhat.com>
 <CACGkMEv1r+-MUpoPZ2Va-b-dkjB2prHYhtZEtUB7-s1CZCBFdA@mail.gmail.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <CACGkMEv1r+-MUpoPZ2Va-b-dkjB2prHYhtZEtUB7-s1CZCBFdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 23/06/2025 10:03, Jason Wang wrote:
> On Wed, Jun 18, 2025 at 4:39 PM Laurent Vivier <lvivier@redhat.com> wrote:
>>
>> This series introduces support for passt as a new network backend for
>> QEMU.
>>
>> passt is a modern, unprivileged, user-mode networking solution that
>> provides guest connectivity by launching an external helper process. This
>> series adds the core backend and integrates it with vhost-user for
>> high-performance, accelerated networking.
>>
>> The series is structured to first improve the general networking code
>> before adding the new feature. The first patch extracts from the stream
>> backend the functions that will be reused in the passt backend. The
>> following patches are a preparatory refactoring to decouple the generic
>> vhost layer from specific backend implementations (tap, vhost-user, etc.).
>> This is achieved by replacing hardcoded type checks with a callback-based
>> system in NetClientInfo, making the vhost infrastructure more modular and
>> extensible.
>>
>> With the refactoring in place, subsequent patches introduce the passt
>> backend itself, reusing the generic stream handling logic. The final
>> patch adds vhost-user support to passt, which plugs cleanly into the
>> newly refactored vhost layer.
>>
>> Some benchmarks:
>>
>>   Reference '-net user':
>>
>>    -net user,hostfwd=tcp::10001-:10001
>>
>>      iperf3 -c localhost -p 10001  -t 60 -4
>>
>>      [ ID] Interval           Transfer     Bitrate         Retr
>>      [  5]   0.00-60.00  sec  14.2 GBytes  2.03 Gbits/sec    1            sender
>>      [  5]   0.00-60.00  sec  14.2 GBytes  2.03 Gbits/sec                  receiver
>>
>>   New backend '-netdev passt'
>>
>>    -netdev passt,vhost-user=off,tcp-ports=10001
>>
>>      iperf3 -c localhost -p 10001  -t 60 -4
>>
>>      [ ID] Interval           Transfer     Bitrate         Retr
>>      [  5]   0.00-60.00  sec  27.1 GBytes  3.88 Gbits/sec    0            sender
>>      [  5]   0.00-60.03  sec  27.1 GBytes  3.88 Gbits/sec                  receiver
>>
>>    -netdev passt,vhost-user=on,tcp-ports=10001
>>
>>      iperf3 -c localhost -p 10001  -t 60 -4
>>
>>      [ ID] Interval           Transfer     Bitrate         Retr
>>      [  5]   0.00-60.00  sec   224 GBytes  32.1 Gbits/sec    4            sender
>>      [  5]   0.00-60.05  sec   224 GBytes  32.0 Gbits/sec                  receiver
> 
> Do we have latency numbers of even PPS?

Could you propose tools and tests I can run to have these numbers?

Thanks,
Laurent


