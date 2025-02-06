Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC43C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg3dp-0005lf-J6; Thu, 06 Feb 2025 10:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tg3dn-0005lG-HF
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:18:07 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tg3dl-0002h3-2z
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:18:07 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21f0bc811dbso32152895ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 07:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738855083; x=1739459883; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=o2RtRTszNRXCaZXV9xeyCuavW503FEW0474pGi9FoOo=;
 b=Q1oe+ROTAhRaDi2KvXkvuxlD2Q3IcLccD0+OlXs2gyKlDb08ZJnFPLXKMNxnQclrpq
 vBB3A7ODdiqsZDwJm9LQf8e4vh51rOpXK42Moa22xhv/UHU5kCs/lA1XuGKxfJqlfrXL
 0hKqdQdkeqgWgSWG7+bHLmphWhstHrukKNGPJVvoOVd9eLVg+OwnoyDdZqWA77v6fY/4
 jrwfr7jPqXlwmYtlw72FWD5E6X3/ZkG33xJ9/EbIdm87RQIUL4iJpdkPJCfVxSa2vEnL
 mhlSzqwaj7FxIocL7jp+sJ9sxM4V+yQgCnQ2XQkc6ttszbuRMOkBt8RdyjlwzmiiIPlc
 e/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738855083; x=1739459883;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o2RtRTszNRXCaZXV9xeyCuavW503FEW0474pGi9FoOo=;
 b=CuLeTfAs/kr7ysErWAWH+dUtrfLdVQlcMwLXD5F2SK8lOusuSWXRhJPGBTrLEhsTHv
 UXTydQBBurxyesIJH+WhmN8VyKGe+M82f6vzvCXBktq9tSZtKePC3Avtgv+uv2e/pVU0
 qbuTrZKVHnAqcB0A2JsgUwgifmfzCwpUg2ZqO958aNyarcacOT93Y0HLSQoeDtQTgodY
 xnJGYNbDrc+LM+sQOXQKgwqIsXf67qa0nPcEHtPEeenuH1Txtc2qyOaCaeotJk+niyiK
 xyIhjbL/e1pPG00gZyHXOsEynEV6GVYNy8yBe5rHQ78d0Pfu6dZODOedcdpvX/HqY+0m
 98Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgLqt/lkcrLC54nhCNhFw+Oz+cuLpTJALwwCQvT8p6fX6PzxenH/1W1Ph3PhPzXO7hl4/BXbyhaDlQ@nongnu.org
X-Gm-Message-State: AOJu0Yy9GMCNVTvTVnkBRWzT0A3COovmBVVYIkDRhvG7u5I2XJv7oWiL
 1d1ixNxfvTtPGF61yWWraTfdoEOAGGU4VUgZuk7h8ue5Mmc3PLZu
X-Gm-Gg: ASbGnctRsSVUbnuakAt9JMK+r9h78Wmaz5qZXxIlg1yVgA3RA4IAhgfN+Ic+/N0wZzM
 AgZaujQdt9EQ895WJCt4Go4Whf8IqVev6v/HyS28qiTAKnRDL/g7/NT4OGBHEzZGpwIEtRfcvUH
 itRJNMdBmlY4pXnhZux2KzmCD8BxS4+RGwUa8R/tpziLAnWNP1hbV86RL1lP6U0l///ylbXPMdv
 oS9BML82BeQEcuKozNDG0aUsLVoOXF1GTHA+Q1/VDmrhUXXtrGooZ2ajSmB
X-Google-Smtp-Source: AGHT+IGqdCu/gWtf8MSGss7W/5jkV1OGlavPimxezwsCzPXdeI9ZXV0X235XP//fLjfHg2P9esD2oQ==
X-Received: by 2002:a05:6a00:400b:b0:728:15fd:dabb with SMTP id
 d2e1a72fcca58-73042adac6bmr7580091b3a.8.1738855082395; 
 Thu, 06 Feb 2025 07:18:02 -0800 (PST)
Received: from [192.168.1.18] ([223.233.85.39])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048bf13d7sm1444944b3a.99.2025.02.06.07.17.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 07:18:01 -0800 (PST)
Message-ID: <360803dd-f1e0-48a3-8917-2477d8a821a9@gmail.com>
Date: Thu, 6 Feb 2025 20:47:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 0/5] Add packed virtqueue to shadow virtqueue
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
References: <20241205203430.76251-1-sahilcdq@proton.me>
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
 <dd634f4f-1539-44dd-8f97-6d1173dcd626@gmail.com>
 <CAJaqyWe3qTJhQrkP2gkmCeand_63O_R6ZNvWSgGJQpE-3Qz3aw@mail.gmail.com>
 <5ada25cb-405e-4587-b230-b6a3ce7dbdc2@gmail.com>
 <CAJaqyWfkOwC_-3N66Gq2EM+eXz7hNv3n+W_2W6XtJZ0iS8PQPw@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWfkOwC_-3N66Gq2EM+eXz7hNv3n+W_2W6XtJZ0iS8PQPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x631.google.com
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

On 2/6/25 12:42 PM, Eugenio Perez Martin wrote:
> On Thu, Feb 6, 2025 at 6:26 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>
>> Hi,
>>
>> On 2/4/25 11:40 PM, Eugenio Perez Martin wrote:
>>> On Tue, Feb 4, 2025 at 1:49 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>>> On 1/31/25 12:27 PM, Eugenio Perez Martin wrote:
>>>>> On Fri, Jan 31, 2025 at 6:04 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>>>>> On 1/24/25 1:04 PM, Eugenio Perez Martin wrote:
>>>>>>> On Fri, Jan 24, 2025 at 6:47 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>>>>>>> On 1/21/25 10:07 PM, Eugenio Perez Martin wrote:
>>>>>>>>> On Sun, Jan 19, 2025 at 7:37 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>>>>>>>>> On 1/7/25 1:35 PM, Eugenio Perez Martin wrote:
>>>>>>>>>> [...]
>>>>>>>>>> Apologies for the delay in replying. It took me a while to figure
>>>>>>>>>> this out, but I have now understood why this doesn't work. L1 is
>>>>>>>>>> unable to receive messages from L0 because they get filtered out
>>>>>>>>>> by hw/net/virtio-net.c:receive_filter [1]. There's an issue with
>>>>>>>>>> the MAC addresses.
>>>>>>>>>>
>>>>>>>>>> In L0, I have:
>>>>>>>>>>
>>>>>>>>>> $ ip a show tap0
>>>>>>>>>> 6: tap0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 1000
>>>>>>>>>>           link/ether d2:6d:b9:61:e1:9a brd ff:ff:ff:ff:ff:ff
>>>>>>>>>>           inet 111.1.1.1/24 scope global tap0
>>>>>>>>>>              valid_lft forever preferred_lft forever
>>>>>>>>>>           inet6 fe80::d06d:b9ff:fe61:e19a/64 scope link proto kernel_ll
>>>>>>>>>>              valid_lft forever preferred_lft forever
>>>>>>>>>>
>>>>>>>>>> In L1:
>>>>>>>>>>
>>>>>>>>>> # ip a show eth0
>>>>>>>>>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
>>>>>>>>>>           link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
>>>>>>>>>>           altname enp0s2
>>>>>>>>>>           inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic noprefixroute eth0
>>>>>>>>>>              valid_lft 83455sec preferred_lft 83455sec
>>>>>>>>>>           inet6 fec0::7bd2:265e:3b8e:5acc/64 scope site dynamic noprefixroute
>>>>>>>>>>              valid_lft 86064sec preferred_lft 14064sec
>>>>>>>>>>           inet6 fe80::50e7:5bf6:fff8:a7b0/64 scope link noprefixroute
>>>>>>>>>>              valid_lft forever preferred_lft forever
>>>>>>>>>>
>>>>>>>>>> I'll call this L1-eth0.
>>>>>>>>>>
>>>>>>>>>> In L2:
>>>>>>>>>> # ip a show eth0
>>>>>>>>>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP gro0
>>>>>>>>>>           link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
>>>>>>>>>>           altname enp0s7
>>>>>>>>>>           inet 111.1.1.2/24 scope global eth0
>>>>>>>>>>              valid_lft forever preferred_lft forever
>>>>>>>>>>
>>>>>>>>>> I'll call this L2-eth0.
>>>>>>>>>>
>>>>>>>>>> Apart from eth0, lo is the only other device in both L1 and L2.
>>>>>>>>>>
>>>>>>>>>> A frame that L1 receives from L0 has L2-eth0's MAC address (LSB = 57)
>>>>>>>>>> as its destination address. When booting L2 with x-svq=false, the
>>>>>>>>>> value of n->mac in VirtIONet is also L2-eth0. So, L1 accepts
>>>>>>>>>> the frames and passes them on to L2 and pinging works [2].
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> So this behavior is interesting by itself. But L1's kernel net system
>>>>>>>>> should not receive anything. As I read it, even if it receives it, it
>>>>>>>>> should not forward the frame to L2 as it is in a different subnet. Are
>>>>>>>>> you able to read it using tcpdump on L1?
>>>>>>>>
>>>>>>>> I ran "tcpdump -i eth0" in L1. It didn't capture any of the packets
>>>>>>>> that were directed at L2 even though L2 was able to receive them.
>>>>>>>> Similarly, it didn't capture any packets that were sent from L2 to
>>>>>>>> L0. This is when L2 is launched with x-svq=false.
>>>>>>>> [...]
>>>>>>>> With x-svq=true, forcibly setting the LSB of n->mac to 0x57 in
>>>>>>>> receive_filter allows L2 to receive packets from L0. I added
>>>>>>>> the following line just before line 1771 [1] to check this out.
>>>>>>>>
>>>>>>>> n->mac[5] = 0x57;
>>>>>>>>
>>>>>>>
>>>>>>> That's very interesting. Let me answer all the gdb questions below and
>>>>>>> we can debug it deeper :).
>>>>>>>
>>>>>>
>>>>>> Thank you for the primer on using gdb with QEMU. I am able to debug
>>>>>> QEMU now.
>>>>>>
>>>>>>>>> Maybe we can make the scenario clearer by telling which virtio-net
>>>>>>>>> device is which with virtio_net_pci,mac=XX:... ?
>>>>>>>>>
>>>>>>>>>> However, when booting L2 with x-svq=true, n->mac is set to L1-eth0
>>>>>>>>>> (LSB = 56) in virtio_net_handle_mac() [3].
>>>>>>>>>
>>>>>>>>> Can you tell with gdb bt if this function is called from net or the
>>>>>>>>> SVQ subsystem?
>>>>>>>>
>>>>>>
>>>>>> It looks like the function is being called from net.
>>>>>>
>>>>>> (gdb) bt
>>>>>> #0  virtio_net_handle_mac (n=0x15622425e, cmd=85 'U', iov=0x555558865980, iov_cnt=1476792840) at ../hw/net/virtio-net.c:1098
>>>>>> #1  0x0000555555e5920b in virtio_net_handle_ctrl_iov (vdev=0x555558fdacd0, in_sg=0x5555580611f8, in_num=1, out_sg=0x555558061208,
>>>>>>          out_num=1) at ../hw/net/virtio-net.c:1581
>>>>>> #2  0x0000555555e593a0 in virtio_net_handle_ctrl (vdev=0x555558fdacd0, vq=0x555558fe7730) at ../hw/net/virtio-net.c:1610
>>>>>> #3  0x0000555555e9a7d8 in virtio_queue_notify_vq (vq=0x555558fe7730) at ../hw/virtio/virtio.c:2484
>>>>>> #4  0x0000555555e9dffb in virtio_queue_host_notifier_read (n=0x555558fe77a4) at ../hw/virtio/virtio.c:3869
>>>>>> #5  0x000055555620329f in aio_dispatch_handler (ctx=0x555557d9f840, node=0x7fffdca7ba80) at ../util/aio-posix.c:373
>>>>>> #6  0x000055555620346f in aio_dispatch_handlers (ctx=0x555557d9f840) at ../util/aio-posix.c:415
>>>>>> #7  0x00005555562034cb in aio_dispatch (ctx=0x555557d9f840) at ../util/aio-posix.c:425
>>>>>> #8  0x00005555562242b5 in aio_ctx_dispatch (source=0x555557d9f840, callback=0x0, user_data=0x0) at ../util/async.c:361
>>>>>> #9  0x00007ffff6d86559 in ?? () from /usr/lib/libglib-2.0.so.0
>>>>>> #10 0x00007ffff6d86858 in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.0
>>>>>> #11 0x0000555556225bf9 in glib_pollfds_poll () at ../util/main-loop.c:287
>>>>>> #12 0x0000555556225c87 in os_host_main_loop_wait (timeout=294672) at ../util/main-loop.c:310
>>>>>> #13 0x0000555556225db6 in main_loop_wait (nonblocking=0) at ../util/main-loop.c:589
>>>>>> #14 0x0000555555c0c1a3 in qemu_main_loop () at ../system/runstate.c:835
>>>>>> #15 0x000055555612bd8d in qemu_default_main (opaque=0x0) at ../system/main.c:48
>>>>>> #16 0x000055555612be3d in main (argc=23, argv=0x7fffffffe508) at ../system/main.c:76
>>>>>>
>>>>>> virtio_queue_notify_vq at hw/virtio/virtio.c:2484 [2] calls
>>>>>> vq->handle_output(vdev, vq). I see "handle_output" is a function
>>>>>> pointer and in this case it seems to be pointing to
>>>>>> virtio_net_handle_ctrl.
>>>>>>
>>>>>>>>>> [...]
>>>>>>>>>> With x-svq=true, I see that n->mac is set by virtio_net_handle_mac()
>>>>>>>>>> [3] when L1 receives VIRTIO_NET_CTRL_MAC_ADDR_SET. With x-svq=false,
>>>>>>>>>> virtio_net_handle_mac() doesn't seem to be getting called. I haven't
>>>>>>>>>> understood how the MAC address is set in VirtIONet when x-svq=false.
>>>>>>>>>> Understanding this might help see why n->mac has different values
>>>>>>>>>> when x-svq is false vs when it is true.
>>>>>>>>>
>>>>>>>>> Ok this makes sense, as x-svq=true is the one that receives the set
>>>>>>>>> mac message. You should see it in L0's QEMU though, both in x-svq=on
>>>>>>>>> and x-svq=off scenarios. Can you check it?
>>>>>>>>
>>>>>>>> L0's QEMU seems to be receiving the "set mac" message only when L1
>>>>>>>> is launched with x-svq=true. With x-svq=off, I don't see any call
>>>>>>>> to virtio_net_handle_mac with cmd == VIRTIO_NET_CTRL_MAC_ADDR_SET
>>>>>>>> in L0.
>>>>>>>>
>>>>>>>
>>>>>>> Ok this is interesting. Let's disable control virtqueue to start with
>>>>>>> something simpler:
>>>>>>> device virtio-net-pci,netdev=net0,ctrl_vq=off,...
>>>>>>>
>>>>>>> QEMU will start complaining about features that depend on ctrl_vq,
>>>>>>> like ctrl_rx. Let's disable all of them and check this new scenario.
>>>>>>>
>>>>>>
>>>>>> I am still investigating this part. I set ctrl_vq=off and ctrl_rx=off.
>>>>>> I didn't get any errors as such about features that depend on ctrl_vq.
>>>>>> However, I did notice that after booting L2 (x-svq=true as well as
>>>>>> x-svq=false), no eth0 device was created. There was only a "lo" interface
>>>>>> in L2. An eth0 interface is present only when L1 (L0 QEMU) is booted
>>>>>> with ctrl_vq=on and ctrl_rx=on.
>>>>>>
>>>>>
>>>>> Any error messages on the nested guest's dmesg?
>>>>
>>>> Oh, yes, there were error messages in the output of dmesg related to
>>>> ctrl_vq. After adding the following args, there were no error messages
>>>> in dmesg.
>>>>
>>>> -device virtio-net-pci,ctrl_vq=off,ctrl_rx=off,ctrl_vlan=off,ctrl_mac_addr=off
>>>>
>>>> I see that the eth0 interface is also created. I am able to ping L0
>>>> from L2 and vice versa as well (even with x-svq=true). This is because
>>>> n->promisc is set when these features are disabled and receive_filter() [1]
>>>> always returns 1.
>>>>
>>>>> Is it fixed when you set the same mac address on L0
>>>>> virtio-net-pci and L1's?
>>>>>
>>>>
>>>> I didn't have to set the same mac address in this case since promiscuous
>>>> mode seems to be getting enabled which allows pinging to work.
>>>>
>>>> There is another concept that I am a little confused about. In the case
>>>> where L2 is booted with x-svq=false (and all ctrl features such as ctrl_vq,
>>>> ctrl_rx, etc. are on), I am able to ping L0 from L2. When tracing
>>>> receive_filter() in L0-QEMU, I see the values of n->mac and the destination
>>>> mac address in the ICMP packet match [2].
>>>>
>>>
>>> SVQ makes an effort to set the mac address at the beginning of
>>> operation. The L0 interpret it as "filter out all MACs except this
>>> one". But SVQ cannot set the mac if ctrl_mac_addr=off, so the nic
>>> receives all packets and the guest kernel needs to filter out by
>>> itself.
>>>
>>>> I haven't understood what n->mac refers to over here. MAC addresses are
>>>> globally unique and so the mac address of the device in L1 should be
>>>> different from that in L2.
>>>
>>> With vDPA, they should be the same device even if they are declared in
>>> different cmdlines or layers of virtualizations. If it were a physical
>>> NIC, QEMU should declare the MAC of the physical NIC too.
>>
>> Understood. I guess the issue with x-svq=true is that the MAC address
>> set in L0-QEMU's n->mac is different from the device in L2. That's why
>> the packets get filtered out with x-svq=true but pinging works with
>> x-svq=false.
>>
> 
> Right!
> 
> 
>>> There is a thread in QEMU maul list where how QEMU should influence
>>> the control plane is discussed, and maybe it would be easier if QEMU
>>> just checks the device's MAC and ignores cmdline. But then, that
>>> behavior would be surprising for the rest of vhosts like vhost-kernel.
>>> Or just emit a warning if the MAC is different than the one that the
>>> device reports.
>>>
>>
>> Got it.
>>
>>>> But I see L0-QEMU's n->mac is set to the mac
>>>> address of the device in L2 (allowing receive_filter to accept the packet).
>>>>
>>>
>>> That's interesting, can you check further what does receive_filter and
>>> virtio_net_receive_rcu do with gdb? As long as virtio_net_receive_rcu
>>> flushes the packet on the receive queue, SVQ should receive it.
>>>
>> The control flow irrespective of the value of x-svq is the same up till
>> the MAC address comparison in receive_filter() [1]. For x-svq=true,
>> the equality check between n->mac and the packet's destination MAC address
>> fails and the packet is filtered out. It is not flushed to the receive
>> queue. With x-svq=false, this is not the case.
>>
>> On 2/4/25 11:45 PM, Eugenio Perez Martin wrote:
>>> PS: Please note that you can check packed_vq SVQ implementation
>>> already without CVQ, as these features are totally orthogonal :).
>>>
>>
>> Right. Now that I can ping with the ctrl features turned off, I think
>> this should take precedence. There's another issue specific to the
>> packed virtqueue case. It causes the kernel to crash. I have been
>> investigating this and the situation here looks very similar to what's
>> explained in Jason Wang's mail [2]. My plan of action is to apply his
>> changes in L2's kernel and check if that resolves the problem.
>>
>> The details of the crash can be found in this mail [3].
>>
> 
> If you're testing this series without changes, I think that is caused
> by not implementing the packed version of vhost_svq_get_buf.
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2024-12/msg01902.html
> 

Oh, apologies, I think I had misunderstood your response in the linked mail.
Until now, I thought they were unrelated. In that case, I'll implement the
packed version of vhost_svq_get_buf. Hopefully that fixes it :).

Thanks,
Sahil

