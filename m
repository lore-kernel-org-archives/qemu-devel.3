Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15E2C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 12:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfIN6-00084L-Jl; Tue, 04 Feb 2025 07:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tfIMv-00083A-Do
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:49:34 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tfIMs-0001t7-Tt
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:49:33 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-216728b1836so93703685ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 04:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738673369; x=1739278169; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=leYTDB3Y7IMqg8/jD+Q0hk1mFBlJ4oBULZH5c6k36o0=;
 b=ALGomWOAX64KiuG+61ib9ZBX0/HFZeFz/dLoenJnEBJBSvv9iwy/NTDOhAZGywFVng
 EVxqOYnWcTVYjOYoA/QPUra1L7fNM2mHNm1Ih4Nj4+BCALOwByjNaDVTyLsXHv1b9Pbf
 T4pVTbamCRN7GTFOkSGy/gTNI62Hq+uxusvUqZdtiBw6ukPapIxxrVoknccuQxR94rUr
 /Cik5MUfUXDogkcWxZNbJKWI0fB7Sq1csfOp30ylEZEXxza9MkycF67NC6H2wa1VfrzB
 OZNTTsHbudkXz9bKNwsyfmh5VUoCO+50Yv4+GdnCih0ThU0VdhiEKYX++IyBTVHTJ7w5
 +I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738673369; x=1739278169;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=leYTDB3Y7IMqg8/jD+Q0hk1mFBlJ4oBULZH5c6k36o0=;
 b=V2+/G2a1aAVpv22f1uGIPTMJcN+HDwYHD4L2l0UK5Dg3qLVf6RHGYh9dm0unayK6FB
 FlPUNkaWatNkmQO2aeAQBiY5Kb4qfcmt1KDFOR7rlySJTo2V+1iCa4K2YYXDmmDE3iWv
 6WyfFvPVrZZ1R6uwFkKLTINDwfU73vhqMJ/YoosDNdQUIv0+9XG88XqgsH1rwpV+sLYp
 SUDv8GPkY3MyLieIBY7n+kYA+gy2OF2+MeuG83Y4jIDN4V7vP8bMzmY7lue8/b6MhCSs
 KMSOCfE1oO40AplX3QDKMq9NEvqYhsbcC6i6VzzzRzIh8xrxpCpVWRZEUIls78DqnoCA
 IgKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX9U8YPX2yqopDEYDKDk3HJsJdY9EsxX8zi8PQ0bh+g5iRac+3kk4B4CMF5h5gpqNSm3Cu3HC7TRE8@nongnu.org
X-Gm-Message-State: AOJu0YxwI60acK2GwtclDzA1M8pRyeCFZtYqCV7xkH/M4tSGngV6O+wn
 LdRGduiNpptbqS+CrqKAopHXjCUSj2PVOsPDkXtsuNRCq1aMv87G6g4WtQ==
X-Gm-Gg: ASbGncubyS5iFFT+edvT9gT3HPkwx9Efm2XP3/46JSlVj1MapVnyV2u4E9pC9bUNTIc
 lQ1N7Q6UM51YZaP7uklp+Fv92xqAS2EkbYQr0ifOvCkUkqnIn+Dv+jMD8nbCi4EyQG7F3DGYmfW
 NICsv7z5W3s1SA/2PWOACgDuyikSS429oBLjvEqPv1jAQnXzCeCj0kBKPj/ThqxpggfJm85OJBT
 Va83AeU5PvttiS1ws4Y/I192l8brIVW6n2wESRvbJZOwcvYNIpDq65TaBr2
X-Google-Smtp-Source: AGHT+IGro/gDu26ewb/kGoKXSFEmG/l6y/y8+oZgkvYn0sBSu26fUJp7sg7ROXLvGw8Vg3CIm5cFAA==
X-Received: by 2002:a05:6a00:99b:b0:728:9d19:d2ea with SMTP id
 d2e1a72fcca58-72fd0c0b844mr39050974b3a.13.1738673368605; 
 Tue, 04 Feb 2025 04:49:28 -0800 (PST)
Received: from [192.168.1.18] ([223.233.85.39])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe69ba3e4sm10381479b3a.85.2025.02.04.04.49.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 04:49:28 -0800 (PST)
Message-ID: <dd634f4f-1539-44dd-8f97-6d1173dcd626@gmail.com>
Date: Tue, 4 Feb 2025 18:19:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sahil Siddiq <icegambit91@gmail.com>
Subject: Re: [RFC v4 0/5] Add packed virtqueue to shadow virtqueue
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
References: <20241205203430.76251-1-sahilcdq@proton.me>
 <CAJaqyWerdWk5S0Sxt4oMUCc8FQJTxopyvhtyOV6ocbXmJ_p7Dw@mail.gmail.com>
 <f95a9e51-6aa1-4aeb-959e-99e9b31109be@gmail.com>
 <CAJaqyWdx6GGrQ8-Pm9k9jE11djdk3B1OHda+uGTQqYbq5tyX7w@mail.gmail.com>
 <d747027b-4c59-4f01-bb36-b9a00aa7d3a9@gmail.com>
 <CAJaqyWeKW3VVATqdWMrRUxCZxsrCUur7uwiyDqk2Y2W1wqZusQ@mail.gmail.com>
 <9b20ffc4-b55b-42c8-9847-a677c30c0051@gmail.com>
 <CAJaqyWf_9btBAtZ1TrUDpCh-eTD47ELHO5jxWJW3gOAZO0tMCw@mail.gmail.com>
 <f670a48e-73ab-4027-9d2b-d4fafa54cd16@gmail.com>
 <CAJaqyWftS8angT2=XUUFiR_5yjxNOmV4WXHe3cxkb4t6KbQdDw@mail.gmail.com>
 <4ee57bd3-5ea0-49a7-969e-c3fe902d8246@gmail.com>
 <CAJaqyWf9g_yAb6oYf_bJ5st9owKOzJDKbcWh6k+ZYZ3-mRSaVg@mail.gmail.com>
 <b5e90abd-9fa0-4ab8-9ad2-2b673f1c0784@gmail.com>
 <CAJaqyWcgEefe8EKeuY_hxPuPfdOk6yPiFw1gaY5fvKYc7vPo5g@mail.gmail.com>
 <91d6b4b3-be87-462c-9a0a-4f3fc8ebe4c1@gmail.com>
 <CAJaqyWfL9sWRgk-zMyW_+K0dAp18iDNw1AxJLoLHoSN=GA5_sg@mail.gmail.com>
Content-Language: en-US
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWfL9sWRgk-zMyW_+K0dAp18iDNw1AxJLoLHoSN=GA5_sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi,

On 1/31/25 12:27 PM, Eugenio Perez Martin wrote:
> On Fri, Jan 31, 2025 at 6:04 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>> On 1/24/25 1:04 PM, Eugenio Perez Martin wrote:
>>> On Fri, Jan 24, 2025 at 6:47 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>>> On 1/21/25 10:07 PM, Eugenio Perez Martin wrote:
>>>>> On Sun, Jan 19, 2025 at 7:37 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>>>>> On 1/7/25 1:35 PM, Eugenio Perez Martin wrote:
>>>>>> [...]
>>>>>> Apologies for the delay in replying. It took me a while to figure
>>>>>> this out, but I have now understood why this doesn't work. L1 is
>>>>>> unable to receive messages from L0 because they get filtered out
>>>>>> by hw/net/virtio-net.c:receive_filter [1]. There's an issue with
>>>>>> the MAC addresses.
>>>>>>
>>>>>> In L0, I have:
>>>>>>
>>>>>> $ ip a show tap0
>>>>>> 6: tap0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 1000
>>>>>>         link/ether d2:6d:b9:61:e1:9a brd ff:ff:ff:ff:ff:ff
>>>>>>         inet 111.1.1.1/24 scope global tap0
>>>>>>            valid_lft forever preferred_lft forever
>>>>>>         inet6 fe80::d06d:b9ff:fe61:e19a/64 scope link proto kernel_ll
>>>>>>            valid_lft forever preferred_lft forever
>>>>>>
>>>>>> In L1:
>>>>>>
>>>>>> # ip a show eth0
>>>>>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
>>>>>>         link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
>>>>>>         altname enp0s2
>>>>>>         inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic noprefixroute eth0
>>>>>>            valid_lft 83455sec preferred_lft 83455sec
>>>>>>         inet6 fec0::7bd2:265e:3b8e:5acc/64 scope site dynamic noprefixroute
>>>>>>            valid_lft 86064sec preferred_lft 14064sec
>>>>>>         inet6 fe80::50e7:5bf6:fff8:a7b0/64 scope link noprefixroute
>>>>>>            valid_lft forever preferred_lft forever
>>>>>>
>>>>>> I'll call this L1-eth0.
>>>>>>
>>>>>> In L2:
>>>>>> # ip a show eth0
>>>>>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP gro0
>>>>>>         link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
>>>>>>         altname enp0s7
>>>>>>         inet 111.1.1.2/24 scope global eth0
>>>>>>            valid_lft forever preferred_lft forever
>>>>>>
>>>>>> I'll call this L2-eth0.
>>>>>>
>>>>>> Apart from eth0, lo is the only other device in both L1 and L2.
>>>>>>
>>>>>> A frame that L1 receives from L0 has L2-eth0's MAC address (LSB = 57)
>>>>>> as its destination address. When booting L2 with x-svq=false, the
>>>>>> value of n->mac in VirtIONet is also L2-eth0. So, L1 accepts
>>>>>> the frames and passes them on to L2 and pinging works [2].
>>>>>>
>>>>>
>>>>> So this behavior is interesting by itself. But L1's kernel net system
>>>>> should not receive anything. As I read it, even if it receives it, it
>>>>> should not forward the frame to L2 as it is in a different subnet. Are
>>>>> you able to read it using tcpdump on L1?
>>>>
>>>> I ran "tcpdump -i eth0" in L1. It didn't capture any of the packets
>>>> that were directed at L2 even though L2 was able to receive them.
>>>> Similarly, it didn't capture any packets that were sent from L2 to
>>>> L0. This is when L2 is launched with x-svq=false.
>>>>
>>>
>>> That's right. The virtio dataplane goes directly from L0 to L2, you
>>> should not be able to see any packets in the net of L1.
>>
>> I am a little confused here. Since vhost=off is set in L0's QEMU
>> (which is used to boot L1), I am able to inspect the packets when
>> tracing/debugging receive_filter in hw/net/virtio-net.c. [1] Does
>> this mean the dataplane from L0 to L2 passes through L0's QEMU
>> (so L0 QEMU is aware of what's going on), but bypasses L1 completely
>> so L1's kernel does not know what packets are being sent/received.
>>
> 
> That's right. We're saving processing power and context switches that way :).

Got it. I have understood this part. In a previous mail (also present above):

>>>>> On Sun, Jan 19, 2025 at 7:37 AM Sahil Siddiq wrote:
>>>>>> A frame that L1 receives from L0 has L2-eth0's MAC address (LSB = 57)
>>>>>> as its destination address. When booting L2 with x-svq=false, the
>>>>>> value of n->mac in VirtIONet is also L2-eth0. So, L1 accepts
>>>>>> the frames and passes them on to L2 and pinging works [2].
>>>>>>

I was a little unclear in my explanation. I meant to say the frame received by
L0-QEMU (which is running L1).

>>>> With x-svq=true, forcibly setting the LSB of n->mac to 0x57 in
>>>> receive_filter allows L2 to receive packets from L0. I added
>>>> the following line just before line 1771 [1] to check this out.
>>>>
>>>> n->mac[5] = 0x57;
>>>>
>>>
>>> That's very interesting. Let me answer all the gdb questions below and
>>> we can debug it deeper :).
>>>
>>
>> Thank you for the primer on using gdb with QEMU. I am able to debug
>> QEMU now.
>>
>>>>> Maybe we can make the scenario clearer by telling which virtio-net
>>>>> device is which with virtio_net_pci,mac=XX:... ?
>>>>>
>>>>>> However, when booting L2 with x-svq=true, n->mac is set to L1-eth0
>>>>>> (LSB = 56) in virtio_net_handle_mac() [3].
>>>>>
>>>>> Can you tell with gdb bt if this function is called from net or the
>>>>> SVQ subsystem?
>>>>
>>
>> It looks like the function is being called from net.
>>
>> (gdb) bt
>> #0  virtio_net_handle_mac (n=0x15622425e, cmd=85 'U', iov=0x555558865980, iov_cnt=1476792840) at ../hw/net/virtio-net.c:1098
>> #1  0x0000555555e5920b in virtio_net_handle_ctrl_iov (vdev=0x555558fdacd0, in_sg=0x5555580611f8, in_num=1, out_sg=0x555558061208,
>>        out_num=1) at ../hw/net/virtio-net.c:1581
>> #2  0x0000555555e593a0 in virtio_net_handle_ctrl (vdev=0x555558fdacd0, vq=0x555558fe7730) at ../hw/net/virtio-net.c:1610
>> #3  0x0000555555e9a7d8 in virtio_queue_notify_vq (vq=0x555558fe7730) at ../hw/virtio/virtio.c:2484
>> #4  0x0000555555e9dffb in virtio_queue_host_notifier_read (n=0x555558fe77a4) at ../hw/virtio/virtio.c:3869
>> #5  0x000055555620329f in aio_dispatch_handler (ctx=0x555557d9f840, node=0x7fffdca7ba80) at ../util/aio-posix.c:373
>> #6  0x000055555620346f in aio_dispatch_handlers (ctx=0x555557d9f840) at ../util/aio-posix.c:415
>> #7  0x00005555562034cb in aio_dispatch (ctx=0x555557d9f840) at ../util/aio-posix.c:425
>> #8  0x00005555562242b5 in aio_ctx_dispatch (source=0x555557d9f840, callback=0x0, user_data=0x0) at ../util/async.c:361
>> #9  0x00007ffff6d86559 in ?? () from /usr/lib/libglib-2.0.so.0
>> #10 0x00007ffff6d86858 in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.0
>> #11 0x0000555556225bf9 in glib_pollfds_poll () at ../util/main-loop.c:287
>> #12 0x0000555556225c87 in os_host_main_loop_wait (timeout=294672) at ../util/main-loop.c:310
>> #13 0x0000555556225db6 in main_loop_wait (nonblocking=0) at ../util/main-loop.c:589
>> #14 0x0000555555c0c1a3 in qemu_main_loop () at ../system/runstate.c:835
>> #15 0x000055555612bd8d in qemu_default_main (opaque=0x0) at ../system/main.c:48
>> #16 0x000055555612be3d in main (argc=23, argv=0x7fffffffe508) at ../system/main.c:76
>>
>> virtio_queue_notify_vq at hw/virtio/virtio.c:2484 [2] calls
>> vq->handle_output(vdev, vq). I see "handle_output" is a function
>> pointer and in this case it seems to be pointing to
>> virtio_net_handle_ctrl.
>>
>>>>>> [...]
>>>>>> With x-svq=true, I see that n->mac is set by virtio_net_handle_mac()
>>>>>> [3] when L1 receives VIRTIO_NET_CTRL_MAC_ADDR_SET. With x-svq=false,
>>>>>> virtio_net_handle_mac() doesn't seem to be getting called. I haven't
>>>>>> understood how the MAC address is set in VirtIONet when x-svq=false.
>>>>>> Understanding this might help see why n->mac has different values
>>>>>> when x-svq is false vs when it is true.
>>>>>
>>>>> Ok this makes sense, as x-svq=true is the one that receives the set
>>>>> mac message. You should see it in L0's QEMU though, both in x-svq=on
>>>>> and x-svq=off scenarios. Can you check it?
>>>>
>>>> L0's QEMU seems to be receiving the "set mac" message only when L1
>>>> is launched with x-svq=true. With x-svq=off, I don't see any call
>>>> to virtio_net_handle_mac with cmd == VIRTIO_NET_CTRL_MAC_ADDR_SET
>>>> in L0.
>>>>
>>>
>>> Ok this is interesting. Let's disable control virtqueue to start with
>>> something simpler:
>>> device virtio-net-pci,netdev=net0,ctrl_vq=off,...
>>>
>>> QEMU will start complaining about features that depend on ctrl_vq,
>>> like ctrl_rx. Let's disable all of them and check this new scenario.
>>>
>>
>> I am still investigating this part. I set ctrl_vq=off and ctrl_rx=off.
>> I didn't get any errors as such about features that depend on ctrl_vq.
>> However, I did notice that after booting L2 (x-svq=true as well as
>> x-svq=false), no eth0 device was created. There was only a "lo" interface
>> in L2. An eth0 interface is present only when L1 (L0 QEMU) is booted
>> with ctrl_vq=on and ctrl_rx=on.
>>
> 
> Any error messages on the nested guest's dmesg?

Oh, yes, there were error messages in the output of dmesg related to
ctrl_vq. After adding the following args, there were no error messages
in dmesg.

-device virtio-net-pci,ctrl_vq=off,ctrl_rx=off,ctrl_vlan=off,ctrl_mac_addr=off

I see that the eth0 interface is also created. I am able to ping L0
from L2 and vice versa as well (even with x-svq=true). This is because
n->promisc is set when these features are disabled and receive_filter() [1]
always returns 1.

> Is it fixed when you set the same mac address on L0
> virtio-net-pci and L1's?
> 

I didn't have to set the same mac address in this case since promiscuous
mode seems to be getting enabled which allows pinging to work.

There is another concept that I am a little confused about. In the case
where L2 is booted with x-svq=false (and all ctrl features such as ctrl_vq,
ctrl_rx, etc. are on), I am able to ping L0 from L2. When tracing
receive_filter() in L0-QEMU, I see the values of n->mac and the destination
mac address in the ICMP packet match [2].

I haven't understood what n->mac refers to over here. MAC addresses are
globally unique and so the mac address of the device in L1 should be
different from that in L2. But I see L0-QEMU's n->mac is set to the mac
address of the device in L2 (allowing receive_filter to accept the packet).

Thanks,
Sahil

[1] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/net/virtio-net.c#L1745
[2] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/net/virtio-net.c#L1775

