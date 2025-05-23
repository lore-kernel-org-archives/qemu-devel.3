Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AE1C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 14:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uITf7-0002wX-Tl; Fri, 23 May 2025 10:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uITf4-0002w9-80
 for qemu-devel@nongnu.org; Fri, 23 May 2025 10:46:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uITf2-0001Ld-8a
 for qemu-devel@nongnu.org; Fri, 23 May 2025 10:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748011569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/iTjQkCEyC9doMbWEBR3sKq/619DPTRzHoZazqF7rWY=;
 b=brnxIpccgAZdx5oG4xkL6PPRyK75O37oNtMRKNC14sTIAUbEVO83zzlpdQLxHwtcYL+lRF
 w+PD85G4+LwnAl6ywT3J/VhIa9sXbSoZv53d+JYhVG2SEDyiywvlol6sM7FPMDxUoWaYN3
 syQje5b+ldAPJOzbCyyghtXQFrlY0GE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-mdLzMYEHMkqQJMLN9-f4lg-1; Fri, 23 May 2025 10:46:07 -0400
X-MC-Unique: mdLzMYEHMkqQJMLN9-f4lg-1
X-Mimecast-MFC-AGG-ID: mdLzMYEHMkqQJMLN9-f4lg_1748011567
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6f8aaba2f62so423006d6.1
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 07:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748011567; x=1748616367;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/iTjQkCEyC9doMbWEBR3sKq/619DPTRzHoZazqF7rWY=;
 b=ZrE+VX13l7qEK3VNrk+czOff5s6IVQWVjpQZQ1TuDyd8pptiIvHUF2he01TGXdaGpi
 8L3+eFOg/G09NeUgsD1ImoOSMRQ3vfrIIuO2M953DH7VZ443oyq9uBcJW5JywssJClF7
 /+kF+PNrDqnB51sZBcMEZqiu7WxwdvzqyuUBYy/YvUn71tcwPfdP5FMNrnD0ihnJEZFO
 wGUchzKheSHd+NOZ+WQGkBxgDOe1oM9eUexVHcv8M5KIO2Oh/hVjYaeuT1BjxJ/NXiqO
 z/bbY7KpGyjrMrOAgGt7YEvqXtGsOCfenXkh+6JT7zfkFE82DCxK8NFVahwoxNsD8V2I
 OH/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwD+FEPmkyiNQDgDANhVX+AEiVdYpb/rIxghK8NWYs9APuZjQ8jSRRx3p/4SZdw15kGjwyi7djrAoh@nongnu.org
X-Gm-Message-State: AOJu0YwmS7R5Wl04RirYSCc0UiI4E4KnlHlMQg2cyrkaV7PgRj6mY2IL
 PN8CVuWJKuJFcDEfdSfDVGqIGXj2gNRpXaGxvZzAnxSo+51wYg55XpQEFXHmQFZpH7l5NGf90bf
 u8dKaeUsdpHmFZfuwb1yhluPAGmG6wVLqqJxGMBBsziriUUrBW/Vw2yDV
X-Gm-Gg: ASbGncvI7wg5iI9ytSXX0o/DzIHYHYFh/t1x8k94kaSFGbAA7TarEH+C0xm7BY4Tc7b
 WPrhzVZ0A2Yv7OlvXqwQ2UvOqv3HFLl8ONJUiUarfBu7CEzPBYBxWjWZcLn2z66N9JFiPO6ex2e
 4fkzjMrlUaoHGwQxPq3cRBio8JZsdZef9oYeGkx1REwaP9CiFLVntaWWfff5lTZuKHKcgHt7dJ3
 nsyKatTT3VizntcDIyKJH30hBEGZn1IuTOteFiyTbC4s19vRAluG681bSNAgt19nIO+cLqHf52S
 5SWNRwX1kTp1xNSjSek=
X-Received: by 2002:a0c:e652:0:b0:6f8:b01d:f59c with SMTP id
 6a1803df08f44-6fa935cd750mr45536936d6.20.1748011566961; 
 Fri, 23 May 2025 07:46:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAmRBuPAmlnXAVqvkM+uMdfeuG/YSGtr3i17tIzIQ41BpuOff/bbxfD5oSw7GsHy4r3+j/cQ==
X-Received: by 2002:a0c:e652:0:b0:6f8:b01d:f59c with SMTP id
 6a1803df08f44-6fa935cd750mr45536496d6.20.1748011566591; 
 Fri, 23 May 2025 07:46:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f8b097a93csm114766386d6.114.2025.05.23.07.46.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 07:46:06 -0700 (PDT)
Message-ID: <b68a7715-d8f8-41e0-a4b7-6277b0972f1d@redhat.com>
Date: Fri, 23 May 2025 16:46:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 15/16] net: implement tnl feature offloading
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
 <3ee26dacd91d6c12ae4fc64bc42890553739a2fe.1747825544.git.pabeni@redhat.com>
 <0aba4f0d-f6e8-4c46-a183-eebb401c13a2@daynix.com>
 <3277a9a5-10a7-49a9-901d-cdeef503b1d1@redhat.com>
 <6520193c-0a14-4641-8e5f-f9084d264f1c@daynix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <6520193c-0a14-4641-8e5f-f9084d264f1c@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
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

On 5/23/25 1:35 PM, Akihiko Odaki wrote:
> On 2025/05/23 19:40, Paolo Abeni wrote:
>> On 5/23/25 10:16 AM, Akihiko Odaki wrote:
>>> On 2025/05/21 20:34, Paolo Abeni wrote:
>>>> @@ -890,6 +915,12 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
>>>>           .ufo  = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)),
>>>>           .uso4 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO4)),
>>>>           .uso6 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)),
>>>> +#ifdef CONFIG_INT128
>>>> +       .tnl  = !!(n->curr_guest_offloads &
>>>> +                  (1ULL << VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO)),
>>>> +       .tnl_csum = !!(n->curr_guest_offloads &
>>>> +                      (1ULL << VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO_CSUM)),
>>>
>>> "[PATCH RFC 14/16] net: bundle all offloads in a single struct" added a
>>> struct for offloading, but how about passing n->curr_guest_offloads as
>>> is instead?
>>>
>>> It loses some type safety and makes it prone to have unknown bits, but
>>> omitting duplicate these bit operations may outweigh the downside.
>>
>> I *think* that one of the relevant point about the current interface is
>> that qemu_set_offload() abstracts from the virtio specifics, as it's
>> also used by other drivers. Forcing them to covert the to-be-configured
>> offloads to a virtio specific bitmask sound incorrect to me. Possibly I
>> misread your suggestion?
>>
> 
> virtio is also an interface, and we can reuse it for QEMU-internal 
> interfaces too if it is appropriate.
> 
> That said, the feature bitmask defined by virtio is inappropriate for 
> for qemu_set_offload() because it also contains other features not 
> related to guest offloading. We need an alternative interface, and the 
> current qemu_set_offload() just passes each flag separately.
> 
> Now, "[PATCH RFC 12/16] virtio-net: implement extended features 
> support." is adding another format that derives from virtio for guest 
> offloading. This format only contains bits related to guest offloading 
> by definition and suits well with qemu_set_offload().
> 
> Bit names like VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO will imply that it 
> derives from the virtio spec I think this is actually an improvement; 
> the virtio spec have been the definitive document of the offloading 
> features of tuntap, and some features even used the virtio header (so 
> e1000e and igb parse and build virtio headers). These bit names make 
> this relationship between tuntap and the virtio spec explicit.

Let me check we are on the same page. You are suggesting the following:

- change set_offload() signature to:
typedef void (SetOffload)(NetClientState *, uint64_t);

- define VIRTIO_NET_O_GUEST_<offload> masks for known/supported offload
in include/net/net.h (including TSO, USO, etc...)

- adapt the drivers to the above interface.

- move this patch as series pre-req.

Am I correct?

Thanks,

Paolo



