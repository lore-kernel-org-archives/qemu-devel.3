Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6948C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 12:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFY0q-0006mx-4g; Thu, 15 May 2025 08:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uFTWh-0008Uk-EB
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:01:11 -0400
Received: from www62.your-server.de ([213.133.104.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel@iogearbox.net>)
 id 1uFTWd-0008Hm-O2
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=fPqe/p3OanfghkAvpdvI9qrN0wxJL4H3kiaNy0aFhaY=; b=bNrJXW6uKthSaFFnaLfCEFkhI+
 A1AJfT9XetN0y3fOIALbLnVocZSPjg+VPfVqrHn/aaFlz7Aa74mtNhssgWoQ2M/CgcR3LZb5gcGDu
 7Yt2V5puy49gxKqK6qqHb8JMNK9zCwjRHBGG3qUrxY8MiVpJHDqpOsi2WERy+ILR/IPl/UxOQ83Z/
 Z+mJ5ajd5hTe/8Ipr1WLMP2Xmt/Xd+EPZKJFc2owRZdHkVbBG/aTFHDXWgHVv2U6gzX1ReDV39RA7
 hVkUvbxA/QwIuU4f2DC7TIM2ti6AfvOvCK1eM7frToCrO7Qav6hRWW/aZwvABRl/i876SA/E4Ob4w
 DMFis+yQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <daniel@iogearbox.net>)
 id 1uFTWT-000D8Q-2d; Thu, 15 May 2025 10:00:57 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <daniel@iogearbox.net>)
 id 1uFTWT-0002m1-1Y; Thu, 15 May 2025 10:00:57 +0200
Message-ID: <5b624484-dae9-4ff1-9c84-5b13b46abd2d@iogearbox.net>
Date: Thu, 15 May 2025 10:00:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/af-xdp: Support pinned map path for AF_XDP sockets
To: Ilya Maximets <i.maximets@ovn.org>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Anton Protopopov <aspsk@isovalent.com>
References: <20250508123436.461030-1-daniel@iogearbox.net>
 <f044b02b-3b7a-4a64-ab38-3298f96955a9@ovn.org>
 <0d7285c0-15dc-4dcd-9436-b9134f07242d@iogearbox.net>
 <18f6aae8-2fa2-4fb6-a518-67e982623a5e@ovn.org>
 <e61edfd9-8979-4ef4-b1a5-28dfd802cba6@iogearbox.net>
 <03180a8b-bd9e-40c1-8711-bddf04d84aa3@ovn.org>
Content-Language: en-US
Autocrypt: addr=daniel@iogearbox.net; keydata=
 xsFNBGNAkI0BEADiPFmKwpD3+vG5nsOznvJgrxUPJhFE46hARXWYbCxLxpbf2nehmtgnYpAN
 2HY+OJmdspBntWzGX8lnXF6eFUYLOoQpugoJHbehn9c0Dcictj8tc28MGMzxh4aK02H99KA8
 VaRBIDhmR7NJxLWAg9PgneTFzl2lRnycv8vSzj35L+W6XT7wDKoV4KtMr3Szu3g68OBbp1TV
 HbJH8qe2rl2QKOkysTFRXgpu/haWGs1BPpzKH/ua59+lVQt3ZupePpmzBEkevJK3iwR95TYF
 06Ltpw9ArW/g3KF0kFUQkGXYXe/icyzHrH1Yxqar/hsJhYImqoGRSKs1VLA5WkRI6KebfpJ+
 RK7Jxrt02AxZkivjAdIifFvarPPu0ydxxDAmgCq5mYJ5I/+BY0DdCAaZezKQvKw+RUEvXmbL
 94IfAwTFA1RAAuZw3Rz5SNVz7p4FzD54G4pWr3mUv7l6dV7W5DnnuohG1x6qCp+/3O619R26
 1a7Zh2HlrcNZfUmUUcpaRPP7sPkBBLhJfqjUzc2oHRNpK/1mQ/+mD9CjVFNz9OAGD0xFzNUo
 yOFu/N8EQfYD9lwntxM0dl+QPjYsH81H6zw6ofq+jVKcEMI/JAgFMU0EnxrtQKH7WXxhO4hx
 3DFM7Ui90hbExlFrXELyl/ahlll8gfrXY2cevtQsoJDvQLbv7QARAQABzSZEYW5pZWwgQm9y
 a21hbm4gPGRhbmllbEBpb2dlYXJib3gubmV0PsLBkQQTAQoAOxYhBCrUdtCTcZyapV2h+93z
 cY/jfzlXBQJjQJCNAhsDBQkHhM4ACAsJCAcNDAsKBRUKCQgLAh4BAheAAAoJEN3zcY/jfzlX
 dkUQAIFayRgjML1jnwKs7kvfbRxf11VI57EAG8a0IvxDlNKDcz74mH66HMyhMhPqCPBqphB5
 ZUjN4N5I7iMYB/oWUeohbuudH4+v6ebzzmgx/EO+jWksP3gBPmBeeaPv7xOvN/pPDSe/0Ywp
 dHpl3Np2dS6uVOMnyIsvmUGyclqWpJgPoVaXrVGgyuer5RpE/a3HJWlCBvFUnk19pwDMMZ8t
 0fk9O47HmGh9Ts3O8pGibfdREcPYeGGqRKRbaXvcRO1g5n5x8cmTm0sQYr2xhB01RJqWrgcj
 ve1TxcBG/eVMmBJefgCCkSs1suriihfjjLmJDCp9XI/FpXGiVoDS54TTQiKQinqtzP0jv+TH
 1Ku+6x7EjLoLH24ISGyHRmtXJrR/1Ou22t0qhCbtcT1gKmDbTj5TcqbnNMGWhRRTxgOCYvG0
 0P2U6+wNj3HFZ7DePRNQ08bM38t8MUpQw4Z2SkM+jdqrPC4f/5S8JzodCu4x80YHfcYSt+Jj
 ipu1Ve5/ftGlrSECvy80ZTKinwxj6lC3tei1bkI8RgWZClRnr06pirlvimJ4R0IghnvifGQb
 M1HwVbht8oyUEkOtUR0i0DMjk3M2NoZ0A3tTWAlAH8Y3y2H8yzRrKOsIuiyKye9pWZQbCDu4
 ZDKELR2+8LUh+ja1RVLMvtFxfh07w9Ha46LmRhpCzsFNBGNAkI0BEADJh65bNBGNPLM7cFVS
 nYG8tqT+hIxtR4Z8HQEGseAbqNDjCpKA8wsxQIp0dpaLyvrx4TAb/vWIlLCxNu8Wv4W1JOST
 wI+PIUCbO/UFxRy3hTNlb3zzmeKpd0detH49bP/Ag6F7iHTwQQRwEOECKKaOH52tiJeNvvyJ
 pPKSKRhmUuFKMhyRVK57ryUDgowlG/SPgxK9/Jto1SHS1VfQYKhzMn4pWFu0ILEQ5x8a0RoX
 k9p9XkwmXRYcENhC1P3nW4q1xHHlCkiqvrjmWSbSVFYRHHkbeUbh6GYuCuhqLe6SEJtqJW2l
 EVhf5AOp7eguba23h82M8PC4cYFl5moLAaNcPHsdBaQZznZ6NndTtmUENPiQc2EHjHrrZI5l
 kRx9hvDcV3Xnk7ie0eAZDmDEbMLvI13AvjqoabONZxra5YcPqxV2Biv0OYp+OiqavBwmk48Z
 P63kTxLddd7qSWbAArBoOd0wxZGZ6mV8Ci/ob8tV4rLSR/UOUi+9QnkxnJor14OfYkJKxot5
 hWdJ3MYXjmcHjImBWplOyRiB81JbVf567MQlanforHd1r0ITzMHYONmRghrQvzlaMQrs0V0H
 5/sIufaiDh7rLeZSimeVyoFvwvQPx5sXhjViaHa+zHZExP9jhS/WWfFE881fNK9qqV8pi+li
 2uov8g5yD6hh+EPH6wARAQABwsF8BBgBCgAmFiEEKtR20JNxnJqlXaH73fNxj+N/OVcFAmNA
 kI0CGwwFCQeEzgAACgkQ3fNxj+N/OVfFMhAA2zXBUzMLWgTm6iHKAPfz3xEmjtwCF2Qv/TT3
 KqNUfU3/0VN2HjMABNZR+q3apm+jq76y0iWroTun8Lxo7g89/VDPLSCT0Nb7+VSuVR/nXfk8
 R+OoXQgXFRimYMqtP+LmyYM5V0VsuSsJTSnLbJTyCJVu8lvk3T9B0BywVmSFddumv3/pLZGn
 17EoKEWg4lraXjPXnV/zaaLdV5c3Olmnj8vh+14HnU5Cnw/dLS8/e8DHozkhcEftOf+puCIl
 Awo8txxtLq3H7KtA0c9kbSDpS+z/oT2S+WtRfucI+WN9XhvKmHkDV6+zNSH1FrZbP9FbLtoE
 T8qBdyk//d0GrGnOrPA3Yyka8epd/bXA0js9EuNknyNsHwaFrW4jpGAaIl62iYgb0jCtmoK/
 rCsv2dqS6Hi8w0s23IGjz51cdhdHzkFwuc8/WxI1ewacNNtfGnorXMh6N0g7E/r21pPeMDFs
 rUD9YI1Je/WifL/HbIubHCCdK8/N7rblgUrZJMG3W+7vAvZsOh/6VTZeP4wCe7Gs/cJhE2gI
 DmGcR+7rQvbFQC4zQxEjo8fNaTwjpzLM9NIp4vG9SDIqAm20MXzLBAeVkofixCsosUWUODxP
 owLbpg7pFRJGL9YyEHpS7MGPb3jSLzucMAFXgoI8rVqoq6si2sxr2l0VsNH5o3NgoAgJNIg=
In-Reply-To: <03180a8b-bd9e-40c1-8711-bddf04d84aa3@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27637/Wed May 14 10:35:50 2025)
Received-SPF: pass client-ip=213.133.104.62; envelope-from=daniel@iogearbox.net;
 helo=www62.your-server.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 15 May 2025 08:48:34 -0400
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
Reply-to:  Daniel Borkmann <daniel@iogearbox.net>
From:  Daniel Borkmann via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/14/25 9:02 PM, Ilya Maximets wrote:
> On 5/12/25 4:23 PM, Daniel Borkmann wrote:
>> On 5/12/25 2:03 PM, Ilya Maximets wrote:
>>> On 5/9/25 4:05 PM, Daniel Borkmann wrote:
>>>> On 5/9/25 12:53 AM, Ilya Maximets wrote:
>>>>> On 5/8/25 2:34 PM, Daniel Borkmann wrote:
>>>>>> Extend inhibit=on setting with the option to specify a pinned XSK map
>>>>>> path along with a starting index (default 0) to push the created XSK
>>>>>> sockets into. Example usage:
>>>>>>
>>>>>>      # ./build/qemu-system-x86_64 [...] \
>>>>>>        -netdev af-xdp,ifname=eth0,id=net0,mode=native,queues=2,inhibit=on,map-path=/sys/fs/bpf/foo,map-start-index=2
>>>>>>        -device virtio-net-pci,netdev=net0 [...]
>>>>>>
>>>>>> This is useful for the case where an existing XDP program with XSK map
>>>>>> is present on the AF_XDP supported phys device and the XSK map not yet
>>>>>> populated. Qemu will then push the XSK sockets into the specified map.
>>>>>
>>>>> Thanks for the patch!
>>>>>
>>>>> Could you, please, explain the use case a little more?  Is this patch
>>>>> aiming to improve usability?  Do you have a specific use case in mind?
>>>>
>>>> The use case we have is basically that the phys NIC has an XDP program
>>>> already attached which redirects into xsk map (e.g. installed from separate
>>>> control plane), the xsk map got pinned during that process into bpf fs,
>>>> and now qemu is launched, it creates the xsk sockets and then places them
>>>> into the map by gathering the map fd from the pinned bpf fs file.
>>>
>>> OK.  That's what I thought.  Would be good to expand the commit message
>>> a bit explaining the use case.
>>
>> Ack, I already adjusted locally. Planning to send v2 ~today with your feedback
>> incorporated. Much appreciated!
>>
>>>>> The main idea behind 'inhibit' is that the qemu doesn't need to have a lot
>>>>> of privileges to use the pre-loaded program and the pre-created sockets.
>>>>> But creating the sockets and setting them into a map doesn't allow us to
>>>>> run without privileges, IIUC.  May be worth mentioning at least in the
>>>>> commit message.
>>>>
>>>> Yes, privileges for above use case are still needed. Will clarify in the
>>>> description.
>>>
>>> OK.
>>>
>>>>> Also, isn't map-start-index the same thing as start-queue ?  Do we need
>>>>> both of them?
>>>>
>>>> I'd say yes given it does not have to be an exact mapping wrt queue index
>>>> to map slot. The default is 0 though and I expect this to be the most used
>>>> scenario.
>>>
>>> I'm still not sure about this.  For example, libxdp treats queue id as a map
>>> index.  And this value is actually not being used much in libxdp when the
>>> program load is inhibited.  I see that with a custom XDP program the indexes
>>> inside the map may not directly correspond to queues in the device, and, in
>>> fact, may have no relation to the actual queues in the device at all.
>>
>> Right, that's correct.
>>
>>> However, we're still calling them "queues" from the QEMU interface (as in the
>>> "queues" parameter of the net/af-xdp device), and QEMU will just treat every
>>> slot in the BPF map as separate queues, as this BPF map is essentially the
>>> network device that QEMU is working with, it doesn't actually know what's
>>> behind it.
>>>
>>> So, I think, it should be appropriate to simplify the interface and
>>> just use existing start-queue configuration knob for this.
>>>
>>> What do you think?
>>
>> I was thinking of an example like the below (plainly taken from the XDP example
>> programs at github.com/xdp-project/bpf-examples).
>>
>>     struct {
>> 	__uint(type, BPF_MAP_TYPE_XSKMAP);
>> 	__uint(max_entries, MAX_SOCKS);
>> 	__uint(key_size, sizeof(int));
>> 	__uint(value_size, sizeof(int));
>>     } xsks_map SEC(".maps");
>>
>>     int num_socks = 0;
>>     static unsigned int rr;
>>
>>     SEC("xdp_sock") int xdp_sock_prog(struct xdp_md *ctx)
>>     {
>> 	rr = (rr + 1) & (num_socks - 1);
>> 	return bpf_redirect_map(&xsks_map, rr, XDP_DROP);
>>     }
>>
>> If we'd just reuse the start-queue configuration knob for this, then it wouldn't
>> work. So I think having the flexibility of where to place the sockets in the map
>> would make sense. But I can also drop that part of you think it does not warrant
>> the extra knob and align to start-queue then the map always needs to be of the
>> same size as the combined NIC queues.
> 
> I'm a little confused here.  The 'start-queue' is not used for anything important,
> AFAICT, in case of inhibit=on.  So, why re-using it instead of adding a new
> config option reduces the number of available use cases?

Hm, maybe I'm missing something, but we use inhibit=on and do /not/ pass sock-fds as
a parameter and instead fully rely on qemu to create all related af_xdp sockets. So
the start-queue /is/ relevant for the underlying NIC queue selection as we pass the
queue_id to xsk_socket__create().

Thanks,
Daniel

