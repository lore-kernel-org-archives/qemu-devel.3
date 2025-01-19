Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBD5C02183
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 06:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZOw9-0007Ni-7b; Sun, 19 Jan 2025 01:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tZOw7-0007Na-Vd
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 01:37:32 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tZOw4-0000vR-I0
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 01:37:31 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2efe25558ddso4489203a91.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 22:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737268646; x=1737873446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7sQBIgXEiLANJhlim3vKF4R3oDjp5/lsrAq0dDIpc6A=;
 b=CeKZ5RViyyzJpU21KQrDvtvZCzejAbjJi39ndk6zPX8g5kBrAcLY2x5DQBFjORRHVA
 ygd+nCdSiryLNR/DnIbazEMhUlArUX8BCdoUgjudA/v5xSdEGoualfoKFh6asKeq2mb/
 n+sfEwu05w4zLc3xCjuJcYCkee6WYFI7PPUdgIXqM8GauZLSdHnrx6J2oZqVUPkWm7Lt
 5ubf79LOOT3mfi8NWM0VmclZ5DlBEJTGslqD4LBdwzWd4er1chjcBu8NQYDiiDQzHQeA
 193/EhW5Ihc5SG56136KtB9N1kvYByKr2yKZxzFgN4lcTsfd8XpCgLRBCxjMgbW7gvsN
 zDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737268646; x=1737873446;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7sQBIgXEiLANJhlim3vKF4R3oDjp5/lsrAq0dDIpc6A=;
 b=GsQLJHKN21ogXW/qRHOA0/z/aBJbzMh8EzK12MXPrTKZRlH4GU1UK4ppsSpcsMH70W
 P3H/AEioJAVrqtPtIZjeRlOtYtxnQphsNEgXZheoqrHblMQX6sChCvAHk14OYCQkGroo
 u2yHYaeywNtZa8mfnNf+zpkaBFufA5+ri39TBRusOXNj/XbNiuWI4hqetFcnPcWBqFD+
 RDTD+fftjRj0EElIdDXB7oQYYOnk3NGJ+Y5Z9jvmxpfnvgpNhjk88r7tf+o/dHLjwyY5
 ssetsiusS0zhJl1w06HSs2++UAsn8/mHw4OwAYWA2DPvoPZPhjEDHJEHFrMPL2GaiZmu
 LMwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJkyoEl3kDPkQZnR00/4ZmdmfgG7sizM289F8hQ67MNdstMq4HGwFgjCqyKg7fgXX9ZZAlmmGcnJTW@nongnu.org
X-Gm-Message-State: AOJu0YzatgoDsYNMXnPzuqaN+tMsxE3OQGe0/mY84bugLvzqIIGNU2vS
 vMcphGRFFxd2Ln8R2Mc4rZ+qEb/odJNhsFQgejfDrEbxCK075NsrnYmHtw==
X-Gm-Gg: ASbGncsIlcs6vH12UfmeohzfC0MweTu/0AxS1omjwq+h+4c7pKSDQfF7nvwZv42s955
 wLjS/Nu1fxuWgS+BRKumwABwGInfz51dFTMuZ2iZhAE4KdygyjkAAxal8r18PK+FfUb9ecAI5HY
 YOfbY3lE0TmNqrdIejD1ilySDrIKNdDEL8YIkmhYfF95P3m0Ve31oso8kfxV0kqnmu9Xcf/Sm7u
 Zv/e0KacGtienEt3y5VOZ7GClirMLT/yyabXqM=
X-Google-Smtp-Source: AGHT+IGTw7iCmllZOGqcvsJU4+KFgRDFEWnUfYjYEIofKfML2HzXBWRZTtVqG1tv0fcHZJ0pRkzLVw==
X-Received: by 2002:a17:90b:270c:b0:2ee:8031:cdbc with SMTP id
 98e67ed59e1d1-2f782d2c9a1mr10613198a91.23.1737268645868; 
 Sat, 18 Jan 2025 22:37:25 -0800 (PST)
Received: from [192.168.1.18] ([223.233.82.97])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f72c191e2fsm9103846a91.19.2025.01.18.22.37.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2025 22:37:24 -0800 (PST)
Message-ID: <4ee57bd3-5ea0-49a7-969e-c3fe902d8246@gmail.com>
Date: Sun, 19 Jan 2025 12:07:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWftS8angT2=XUUFiR_5yjxNOmV4WXHe3cxkb4t6KbQdDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=icegambit91@gmail.com; helo=mail-pj1-x102d.google.com
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

On 1/7/25 1:35 PM, Eugenio Perez Martin wrote:
> On Fri, Jan 3, 2025 at 2:06 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>
>> Hi,
>>
>> On 12/20/24 12:28 PM, Eugenio Perez Martin wrote:
>>> On Thu, Dec 19, 2024 at 8:37 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 12/17/24 1:20 PM, Eugenio Perez Martin wrote:
>>>>> On Tue, Dec 17, 2024 at 6:45 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>>>>> On 12/16/24 2:09 PM, Eugenio Perez Martin wrote:
>>>>>>> On Sun, Dec 15, 2024 at 6:27 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>>>>>>> On 12/10/24 2:57 PM, Eugenio Perez Martin wrote:
>>>>>>>>> On Thu, Dec 5, 2024 at 9:34 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>>>>>>>>> [...]
>>>>>>>>>> I have been following the "Hands on vDPA: what do you do
>>>>>>>>>> when you ain't got the hardware v2 (Part 2)" [1] blog to
>>>>>>>>>> test my changes. To boot the L1 VM, I ran:
>>>>>>>>>>
>>>>>>>>>> sudo ./qemu/build/qemu-system-x86_64 \
>>>>>>>>>> -enable-kvm \
>>>>>>>>>> -drive file=//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=disk,if=virtio \
>>>>>>>>>> -net nic,model=virtio \
>>>>>>>>>> -net user,hostfwd=tcp::2222-:22 \
>>>>>>>>>> -device intel-iommu,snoop-control=on \
>>>>>>>>>> -device virtio-net-pci,netdev=net0,disable-legacy=on,disable-modern=off,iommu_platform=on,guest_uso4=off,guest_uso6=off,host_uso=off,guest_announce=off,ctrl_vq=on,ctrl_rx=on,packed=on,event_idx=off,bus=pcie.0,addr=0x4 \
>>>>>>>>>> -netdev tap,id=net0,script=no,downscript=no \
>>>>>>>>>> -nographic \
>>>>>>>>>> -m 8G \
>>>>>>>>>> -smp 4 \
>>>>>>>>>> -M q35 \
>>>>>>>>>> -cpu host 2>&1 | tee vm.log
>>>>>>>>>>
>>>>>>>>>> Without "guest_uso4=off,guest_uso6=off,host_uso=off,
>>>>>>>>>> guest_announce=off" in "-device virtio-net-pci", QEMU
>>>>>>>>>> throws "vdpa svq does not work with features" [2] when
>>>>>>>>>> trying to boot L2.
>>>>>>>>>>
>>>>>>>>>> The enums added in commit #2 in this series is new and
>>>>>>>>>> wasn't in the earlier versions of the series. Without
>>>>>>>>>> this change, x-svq=true throws "SVQ invalid device feature
>>>>>>>>>> flags" [3] and x-svq is consequently disabled.
>>>>>>>>>>
>>>>>>>>>> The first issue is related to running traffic in L2
>>>>>>>>>> with vhost-vdpa.
>>>>>>>>>>
>>>>>>>>>> In L0:
>>>>>>>>>>
>>>>>>>>>> $ ip addr add 111.1.1.1/24 dev tap0
>>>>>>>>>> $ ip link set tap0 up
>>>>>>>>>> $ ip addr show tap0
>>>>>>>>>> 4: tap0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 1000
>>>>>>>>>>          link/ether d2:6d:b9:61:e1:9a brd ff:ff:ff:ff:ff:ff
>>>>>>>>>>          inet 111.1.1.1/24 scope global tap0
>>>>>>>>>>             valid_lft forever preferred_lft forever
>>>>>>>>>>          inet6 fe80::d06d:b9ff:fe61:e19a/64 scope link proto kernel_ll
>>>>>>>>>>             valid_lft forever preferred_lft forever
>>>>>>>>>>
>>>>>>>>>> I am able to run traffic in L2 when booting without
>>>>>>>>>> x-svq.
>>>>>>>>>>
>>>>>>>>>> In L1:
>>>>>>>>>>
>>>>>>>>>> $ ./qemu/build/qemu-system-x86_64 \
>>>>>>>>>> -nographic \
>>>>>>>>>> -m 4G \
>>>>>>>>>> -enable-kvm \
>>>>>>>>>> -M q35 \
>>>>>>>>>> -drive file=//root/L2.qcow2,media=disk,if=virtio \
>>>>>>>>>> -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=vhost-vdpa0 \
>>>>>>>>>> -device virtio-net-pci,netdev=vhost-vdpa0,disable-legacy=on,disable-modern=off,ctrl_vq=on,ctrl_rx=on,event_idx=off,bus=pcie.0,addr=0x7 \
>>>>>>>>>> -smp 4 \
>>>>>>>>>> -cpu host \
>>>>>>>>>> 2>&1 | tee vm.log
>>>>>>>>>>
>>>>>>>>>> In L2:
>>>>>>>>>>
>>>>>>>>>> # ip addr add 111.1.1.2/24 dev eth0
>>>>>>>>>> # ip addr show eth0
>>>>>>>>>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
>>>>>>>>>>          link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
>>>>>>>>>>          altname enp0s7
>>>>>>>>>>          inet 111.1.1.2/24 scope global eth0
>>>>>>>>>>             valid_lft forever preferred_lft forever
>>>>>>>>>>          inet6 fe80::9877:de30:5f17:35f9/64 scope link noprefixroute
>>>>>>>>>>             valid_lft forever preferred_lft forever
>>>>>>>>>>
>>>>>>>>>> # ip route
>>>>>>>>>> 111.1.1.0/24 dev eth0 proto kernel scope link src 111.1.1.2
>>>>>>>>>>
>>>>>>>>>> # ping 111.1.1.1 -w3
>>>>>>>>>> PING 111.1.1.1 (111.1.1.1) 56(84) bytes of data.
>>>>>>>>>> 64 bytes from 111.1.1.1: icmp_seq=1 ttl=64 time=0.407 ms
>>>>>>>>>> 64 bytes from 111.1.1.1: icmp_seq=2 ttl=64 time=0.671 ms
>>>>>>>>>> 64 bytes from 111.1.1.1: icmp_seq=3 ttl=64 time=0.291 ms
>>>>>>>>>>
>>>>>>>>>> --- 111.1.1.1 ping statistics ---
>>>>>>>>>> 3 packets transmitted, 3 received, 0% packet loss, time 2034ms
>>>>>>>>>> rtt min/avg/max/mdev = 0.291/0.456/0.671/0.159 ms
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> But if I boot L2 with x-svq=true as shown below, I am unable
>>>>>>>>>> to ping the host machine.
>>>>>>>>>>
>>>>>>>>>> $ ./qemu/build/qemu-system-x86_64 \
>>>>>>>>>> -nographic \
>>>>>>>>>> -m 4G \
>>>>>>>>>> -enable-kvm \
>>>>>>>>>> -M q35 \
>>>>>>>>>> -drive file=//root/L2.qcow2,media=disk,if=virtio \
>>>>>>>>>> -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,x-svq=true,id=vhost-vdpa0 \
>>>>>>>>>> -device virtio-net-pci,netdev=vhost-vdpa0,disable-legacy=on,disable-modern=off,ctrl_vq=on,ctrl_rx=on,event_idx=off,bus=pcie.0,addr=0x7 \
>>>>>>>>>> -smp 4 \
>>>>>>>>>> -cpu host \
>>>>>>>>>> 2>&1 | tee vm.log
>>>>>>>>>>
>>>>>>>>>> In L2:
>>>>>>>>>>
>>>>>>>>>> # ip addr add 111.1.1.2/24 dev eth0
>>>>>>>>>> # ip addr show eth0
>>>>>>>>>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
>>>>>>>>>>          link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
>>>>>>>>>>          altname enp0s7
>>>>>>>>>>          inet 111.1.1.2/24 scope global eth0
>>>>>>>>>>             valid_lft forever preferred_lft forever
>>>>>>>>>>          inet6 fe80::9877:de30:5f17:35f9/64 scope link noprefixroute
>>>>>>>>>>             valid_lft forever preferred_lft forever
>>>>>>>>>>
>>>>>>>>>> # ip route
>>>>>>>>>> 111.1.1.0/24 dev eth0 proto kernel scope link src 111.1.1.2
>>>>>>>>>>
>>>>>>>>>> # ping 111.1.1.1 -w10
>>>>>>>>>> PING 111.1.1.1 (111.1.1.1) 56(84) bytes of data.
>>>>>>>>>>      From 111.1.1.2 icmp_seq=1 Destination Host Unreachable
>>>>>>>>>> ping: sendmsg: No route to host
>>>>>>>>>>      From 111.1.1.2 icmp_seq=2 Destination Host Unreachable
>>>>>>>>>>      From 111.1.1.2 icmp_seq=3 Destination Host Unreachable
>>>>>>>>>>
>>>>>>>>>> --- 111.1.1.1 ping statistics ---
>>>>>>>>>> 3 packets transmitted, 0 received, +3 errors, 100% packet loss, time 2076ms
>>>>>>>>>> pipe 3
>>>>>>>>>>
>>>>>>>>>> The other issue is related to booting L2 with "x-svq=true"
>>>>>>>>>> and "packed=on".
>>>>>>>>>>
>>>>>>>>>> In L1:
>>>>>>>>>>
>>>>>>>>>> $ ./qemu/build/qemu-system-x86_64 \
>>>>>>>>>> -nographic \
>>>>>>>>>> -m 4G \
>>>>>>>>>> -enable-kvm \
>>>>>>>>>> -M q35 \
>>>>>>>>>> -drive file=//root/L2.qcow2,media=disk,if=virtio \
>>>>>>>>>> -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=vhost-vdpa0,x-svq=true \
>>>>>>>>>> -device virtio-net-pci,netdev=vhost-vdpa0,disable-legacy=on,disable-modern=off,guest_uso4=off,guest_uso6=off,host_uso=off,guest_announce=off,ctrl_vq=on,ctrl_rx=on,event_idx=off,packed=on,bus=pcie.0,addr=0x7 \
>>>>>>>>>> -smp 4 \
>>>>>>>>>> -cpu host \
>>>>>>>>>> 2>&1 | tee vm.log
>>>>>>>>>>
>>>>>>>>>> The kernel throws "virtio_net virtio1: output.0:id 0 is not
>>>>>>>>>> a head!" [4].
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> So this series implements the descriptor forwarding from the guest to
>>>>>>>>> the device in packed vq. We also need to forward the descriptors from
>>>>>>>>> the device to the guest. The device writes them in the SVQ ring.
>>>>>>>>>
>>>>>>>>> The functions responsible for that in QEMU are
>>>>>>>>> hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_flush, which is called by
>>>>>>>>> the device when used descriptors are written to the SVQ, which calls
>>>>>>>>> hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_get_buf. We need to do
>>>>>>>>> modifications similar to vhost_svq_add: Make them conditional if we're
>>>>>>>>> in split or packed vq, and "copy" the code from Linux's
>>>>>>>>> drivers/virtio/virtio_ring.c:virtqueue_get_buf.
>>>>>>>>>
>>>>>>>>> After these modifications you should be able to ping and forward
>>>>>>>>> traffic. As always, It is totally ok if it needs more than one
>>>>>>>>> iteration, and feel free to ask any question you have :).
>>>>>>>>>
>>>>>>>>
>>>>>>>> I misunderstood this part. While working on extending
>>>>>>>> hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_get_buf() [1]
>>>>>>>> for packed vqs, I realized that this function and
>>>>>>>> vhost_svq_flush() already support split vqs. However, I am
>>>>>>>> unable to ping L0 when booting L2 with "x-svq=true" and
>>>>>>>> "packed=off" or when the "packed" option is not specified
>>>>>>>> in QEMU's command line.
>>>>>>>>
>>>>>>>> I tried debugging these functions for split vqs after running
>>>>>>>> the following QEMU commands while following the blog [2].
>>>>>>>>
>>>>>>>> Booting L1:
>>>>>>>>
>>>>>>>> $ sudo ./qemu/build/qemu-system-x86_64 \
>>>>>>>> -enable-kvm \
>>>>>>>> -drive file=//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=disk,if=virtio \
>>>>>>>> -net nic,model=virtio \
>>>>>>>> -net user,hostfwd=tcp::2222-:22 \
>>>>>>>> -device intel-iommu,snoop-control=on \
>>>>>>>> -device virtio-net-pci,netdev=net0,disable-legacy=on,disable-modern=off,iommu_platform=on,guest_uso4=off,guest_uso6=off,host_uso=off,guest_announce=off,ctrl_vq=on,ctrl_rx=on,packed=off,event_idx=off,bus=pcie.0,addr=0x4 \
>>>>>>>> -netdev tap,id=net0,script=no,downscript=no \
>>>>>>>> -nographic \
>>>>>>>> -m 8G \
>>>>>>>> -smp 4 \
>>>>>>>> -M q35 \
>>>>>>>> -cpu host 2>&1 | tee vm.log
>>>>>>>>
>>>>>>>> Booting L2:
>>>>>>>>
>>>>>>>> # ./qemu/build/qemu-system-x86_64 \
>>>>>>>> -nographic \
>>>>>>>> -m 4G \
>>>>>>>> -enable-kvm \
>>>>>>>> -M q35 \
>>>>>>>> -drive file=//root/L2.qcow2,media=disk,if=virtio \
>>>>>>>> -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,x-svq=true,id=vhost-vdpa0 \
>>>>>>>> -device virtio-net-pci,netdev=vhost-vdpa0,disable-legacy=on,disable-modern=off,ctrl_vq=on,ctrl_rx=on,event_idx=off,bus=pcie.0,addr=0x7 \
>>>>>>>> -smp 4 \
>>>>>>>> -cpu host \
>>>>>>>> 2>&1 | tee vm.log
>>>>>>>>
>>>>>>>> I printed out the contents of VirtQueueElement returned
>>>>>>>> by vhost_svq_get_buf() in vhost_svq_flush() [3].
>>>>>>>> I noticed that "len" which is set by "vhost_svq_get_buf"
>>>>>>>> is always set to 0 while VirtQueueElement.len is non-zero.
>>>>>>>> I haven't understood the difference between these two "len"s.
>>>>>>>>
>>>>>>>
>>>>>>> VirtQueueElement.len is the length of the buffer, while the len of
>>>>>>> vhost_svq_get_buf is the bytes written by the device. In the case of
>>>>>>> the tx queue, VirtQueuelen is the length of the tx packet, and the
>>>>>>> vhost_svq_get_buf is always 0 as the device does not write. In the
>>>>>>> case of rx, VirtQueueElem.len is the available length for a rx frame,
>>>>>>> and the vhost_svq_get_buf len is the actual length written by the
>>>>>>> device.
>>>>>>>
>>>>>>> To be 100% accurate a rx packet can span over multiple buffers, but
>>>>>>> SVQ does not need special code to handle this.
>>>>>>>
>>>>>>> So vhost_svq_get_buf should return > 0 for rx queue (svq->vq->index ==
>>>>>>> 0), and 0 for tx queue (svq->vq->index % 2 == 1).
>>>>>>>
>>>>>>> Take into account that vhost_svq_get_buf only handles split vq at the
>>>>>>> moment! It should be renamed or splitted into vhost_svq_get_buf_split.
>>>>>>
>>>>>> In L1, there are 2 virtio network devices.
>>>>>>
>>>>>> # lspci -nn | grep -i net
>>>>>> 00:02.0 Ethernet controller [0200]: Red Hat, Inc. Virtio network device [1af4:1000]
>>>>>> 00:04.0 Ethernet controller [0200]: Red Hat, Inc. Virtio 1.0 network device [1af4:1041] (rev 01)
>>>>>>
>>>>>> I am using the second one (1af4:1041) for testing my changes and have
>>>>>> bound this device to the vp_vdpa driver.
>>>>>>
>>>>>> # vdpa dev show -jp
>>>>>> {
>>>>>>         "dev": {
>>>>>>             "vdpa0": {
>>>>>>                 "type": "network",
>>>>>>                 "mgmtdev": "pci/0000:00:04.0",
>>>>>>                 "vendor_id": 6900,
>>>>>>                 "max_vqs": 3,
>>>>>
>>>>> How is max_vqs=3? For this to happen L0 QEMU should have
>>>>> virtio-net-pci,...,queues=3 cmdline argument.
>>>
>>> Ouch! I totally misread it :(. Everything is correct, max_vqs should
>>> be 3. I read it as the virtio_net queues, which means queue *pairs*,
>>> as it includes rx and tx queue.
>>
>> Understood :)
>>
>>>>
>>>> I am not sure why max_vqs is 3. I haven't set the value of queues to 3
>>>> in the cmdline argument. Is max_vqs expected to have a default value
>>>> other than 3?
>>>>
>>>> In the blog [1] as well, max_vqs is 3 even though there's no queues=3
>>>> argument.
>>>>
>>>>> It's clear the guest is not using them, we can add mq=off
>>>>> to simplify the scenario.
>>>>
>>>> The value of max_vqs is still 3 after adding mq=off. The whole
>>>> command that I run to boot L0 is:
>>>>
>>>> $ sudo ./qemu/build/qemu-system-x86_64 \
>>>> -enable-kvm \
>>>> -drive file=//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=disk,if=virtio \
>>>> -net nic,model=virtio \
>>>> -net user,hostfwd=tcp::2222-:22 \
>>>> -device intel-iommu,snoop-control=on \
>>>> -device virtio-net-pci,netdev=net0,disable-legacy=on,disable-modern=off,iommu_platform=on,guest_uso4=off,guest_uso6=off,host_uso=off,guest_announce=off,mq=off,ctrl_vq=on,ctrl_rx=on,packed=off,event_idx=off,bus=pcie.0,addr=0x4 \
>>>> -netdev tap,id=net0,script=no,downscript=no \
>>>> -nographic \
>>>> -m 8G \
>>>> -smp 4 \
>>>> -M q35 \
>>>> -cpu host 2>&1 | tee vm.log
>>>>
>>>> Could it be that 2 of the 3 vqs are used for the dataplane and
>>>> the third vq is the control vq?
>>>>
>>>>>>                 "max_vq_size": 256
>>>>>>             }
>>>>>>         }
>>>>>> }
>>>>>>
>>>>>> The max number of vqs is 3 with the max size being 256.
>>>>>>
>>>>>> Since, there are 2 virtio net devices, vhost_vdpa_svqs_start [1]
>>>>>> is called twice. For each of them. it calls vhost_svq_start [2]
>>>>>> v->shadow_vqs->len number of times.
>>>>>>
>>>>>
>>>>> Ok I understand this confusion, as the code is not intuitive :). Take
>>>>> into account you can only have svq in vdpa devices, so both
>>>>> vhost_vdpa_svqs_start are acting on the vdpa device.
>>>>>
>>>>> You are seeing two calls to vhost_vdpa_svqs_start because virtio (and
>>>>> vdpa) devices are modelled internally as two devices in QEMU: One for
>>>>> the dataplane vq, and other for the control vq. There are historical
>>>>> reasons for this, but we use it in vdpa to always shadow the CVQ while
>>>>> leaving dataplane passthrough if x-svq=off and the virtio & virtio-net
>>>>> feature set is understood by SVQ.
>>>>>
>>>>> If you break at vhost_vdpa_svqs_start with gdb and go higher in the
>>>>> stack you should reach vhost_net_start, that starts each vhost_net
>>>>> device individually.
>>>>>
>>>>> To be 100% honest, each dataplain *queue pair* (rx+tx) is modelled
>>>>> with a different vhost_net device in QEMU, but you don't need to take
>>>>> that into account implementing the packed vq :).
>>>>
>>>> Got it, this makes sense now.
>>>>
>>>>>> Printing the values of dev->vdev->name, v->shadow_vqs->len and
>>>>>> svq->vring.num in vhost_vdpa_svqs_start gives:
>>>>>>
>>>>>> name: virtio-net
>>>>>> len: 2
>>>>>> num: 256
>>>>>> num: 256
>>>>>
>>>>> First QEMU's vhost_net device, the dataplane.
>>>>>
>>>>>> name: virtio-net
>>>>>> len: 1
>>>>>> num: 64
>>>>>>
>>>>>
>>>>> Second QEMU's vhost_net device, the control virtqueue.
>>>>
>>>> Ok, if I understand this correctly, the control vq doesn't
>>>> need separate queues for rx and tx.
>>>>
>>>
>>> That's right. Since CVQ has one reply per command, the driver can just
>>> send ro+rw descriptors to the device. In the case of RX, the device
>>> needs a queue with only-writable descriptors, as neither the device or
>>> the driver knows how many packets will arrive.
>>
>> Got it, this makes sense now.
>>
>>>>>> I am not sure how to match the above log lines to the
>>>>>> right virtio-net device since the actual value of num
>>>>>> can be less than "max_vq_size" in the output of "vdpa
>>>>>> dev show".
>>>>>>
>>>>>
>>>>> Yes, the device can set a different vq max per vq, and the driver can
>>>>> negotiate a lower vq size per vq too.
>>>>>
>>>>>> I think the first 3 log lines correspond to the virtio
>>>>>> net device that I am using for testing since it has
>>>>>> 2 vqs (rx and tx) while the other virtio-net device
>>>>>> only has one vq.
>>>>>>
>>>>>> When printing out the values of svq->vring.num,
>>>>>> used_elem.len and used_elem.id in vhost_svq_get_buf,
>>>>>> there are two sets of output. One set corresponds to
>>>>>> svq->vring.num = 64 and the other corresponds to
>>>>>> svq->vring.num = 256.
>>>>>>
>>>>>> For svq->vring.num = 64, only the following line
>>>>>> is printed repeatedly:
>>>>>>
>>>>>> size: 64, len: 1, i: 0
>>>>>>
>>>>>
>>>>> This is with packed=off, right? If this is testing with packed, you
>>>>> need to change the code to accommodate it. Let me know if you need
>>>>> more help with this.
>>>>
>>>> Yes, this is for packed=off. For the time being, I am trying to
>>>> get L2 to communicate with L0 using split virtqueues and x-svq=true.
>>>>
>>>
>>> Got it.
>>>
>>>>> In the CVQ the only reply is a byte, indicating if the command was
>>>>> applied or not. This seems ok to me.
>>>>
>>>> Understood.
>>>>
>>>>> The queue can also recycle ids as long as they are not available, so
>>>>> that part seems correct to me too.
>>>>
>>>> I am a little confused here. The ids are recycled when they are
>>>> available (i.e., the id is not already in use), right?
>>>>
>>>
>>> In virtio, available is that the device can use them. And used is that
>>> the device returned to the driver. I think you're aligned it's just it
>>> is better to follow the virtio nomenclature :).
>>
>> Got it.
>>
>>>>>> For svq->vring.num = 256, the following line is
>>>>>> printed 20 times,
>>>>>>
>>>>>> size: 256, len: 0, i: 0
>>>>>>
>>>>>> followed by:
>>>>>>
>>>>>> size: 256, len: 0, i: 1
>>>>>> size: 256, len: 0, i: 1
>>>>>>
>>>>>
>>>>> This makes sense for the tx queue too. Can you print the VirtQueue index?
>>>>
>>>> For svq->vring.num = 64, the vq index is 2. So the following line
>>>> (svq->vring.num, used_elem.len, used_elem.id, svq->vq->queue_index)
>>>> is printed repeatedly:
>>>>
>>>> size: 64, len: 1, i: 0, vq idx: 2
>>>>
>>>> For svq->vring.num = 256, the following line is repeated several
>>>> times:
>>>>
>>>> size: 256, len: 0, i: 0, vq idx: 1
>>>>
>>>> This is followed by:
>>>>
>>>> size: 256, len: 0, i: 1, vq idx: 1
>>>>
>>>> In both cases, queue_index is 1. To get the value of queue_index,
>>>> I used "virtio_get_queue_index(svq->vq)" [2].
>>>>
>>>> Since the queue_index is 1, I guess this means this is the tx queue
>>>> and the value of len (0) is correct. However, nothing with
>>>> queue_index % 2 == 0 is printed by vhost_svq_get_buf() which means
>>>> the device is not sending anything to the guest. Is this correct?
>>>>
>>>
>>> Yes, that's totally correct.
>>>
>>> You can set -netdev tap,...,vhost=off in L0 qemu and trace (or debug
>>> with gdb) it to check what is receiving. You should see calls to
>>> hw/net/virtio-net.c:virtio_net_flush_tx. The corresponding function to
>>> receive is virtio_net_receive_rcu, I recommend you trace too just it
>>> in case you see any strange call to it.
>>>
>>
>> I added "vhost=off" to -netdev tap in L0's qemu command. I followed all
>> the steps in the blog [1] up till the point where L2 is booted. Before
>> booting L2, I had no issues pinging L0 from L1.
>>
>> For each ping, the following trace lines were printed by QEMU:
>>
>> virtqueue_alloc_element elem 0x5d041024f560 size 56 in_num 0 out_num 1
>> virtqueue_pop vq 0x5d04109b0ce8 elem 0x5d041024f560 in_num 0 out_num 1
>> virtqueue_fill vq 0x5d04109b0ce8 elem 0x5d041024f560 len 0 idx 0
>> virtqueue_flush vq 0x5d04109b0ce8 count 1
>> virtio_notify vdev 0x5d04109a8d50 vq 0x5d04109b0ce8
>> virtqueue_alloc_element elem 0x5d041024f560 size 56 in_num 1 out_num 0
>> virtqueue_pop vq 0x5d04109b0c50 elem 0x5d041024f560 in_num 1 out_num 0
>> virtqueue_fill vq 0x5d04109b0c50 elem 0x5d041024f560 len 110 idx 0
>> virtqueue_flush vq 0x5d04109b0c50 count 1
>> virtio_notify vdev 0x5d04109a8d50 vq 0x5d04109b0c50
>>
>> The first 5 lines look like they were printed when an echo request was
>> sent to L0 and the next 5 lines were printed when an echo reply was
>> received.
>>
>> After booting L2, I set up the tap device's IP address in L0 and the
>> vDPA port's IP address in L2.
>>
>> When trying to ping L0 from L2, I only see the following lines being
>> printed:
>>
>> virtqueue_alloc_element elem 0x5d041099ffd0 size 56 in_num 0 out_num 1
>> virtqueue_pop vq 0x5d0410d87168 elem 0x5d041099ffd0 in_num 0 out_num 1
>> virtqueue_fill vq 0x5d0410d87168 elem 0x5d041099ffd0 len 0 idx 0
>> virtqueue_flush vq 0x5d0410d87168 count 1
>> virtio_notify vdev 0x5d0410d79a10 vq 0x5d0410d87168
>>
>> There's no reception. I used wireshark to inspect the packets that are
>> being sent and received through the tap device in L0.
>>
>> When pinging L0 from L2, I see one of the following two outcomes:
>>
>> Outcome 1:
>> ----------
>> L2 broadcasts ARP packets and L0 replies to L2.
>>
>> Source             Destination        Protocol    Length    Info
>> 52:54:00:12:34:57  Broadcast          ARP         42        Who has 111.1.1.1? Tell 111.1.1.2
>> d2:6d:b9:61:e1:9a  52:54:00:12:34:57  ARP         42        111.1.1.1 is at d2:6d:b9:61:e1:9a
>>
>> Outcome 2 (less frequent):
>> --------------------------
>> L2 sends an ICMP echo request packet to L0 and L0 sends a reply,
>> but the reply is not received by L2.
>>
>> Source             Destination        Protocol    Length    Info
>> 111.1.1.2          111.1.1.1          ICMP        98        Echo (ping) request  id=0x0006, seq=1/256, ttl=64
>> 111.1.1.1          111.1.1.2          ICMP        98        Echo (ping) reply    id=0x0006, seq=1/256, ttl=64
>>
>> When pinging L2 from L0 I get the following output in
>> wireshark:
>>
>> Source             Destination        Protocol    Length    Info
>> 111.1.1.1          111.1.1.2          ICMP        100       Echo (ping) request  id=0x002c, seq=2/512, ttl=64 (no response found!)
>>
>> I do see a lot of traced lines being printed (by the QEMU instance that
>> was started in L0) with in_num > 1, for example:
>>
>> virtqueue_alloc_element elem 0x5d040fdbad30 size 56 in_num 1 out_num 0
>> virtqueue_pop vq 0x5d04109b0c50 elem 0x5d040fdbad30 in_num 1 out_num 0
>> virtqueue_fill vq 0x5d04109b0c50 elem 0x5d040fdbad30 len 76 idx 0
>> virtqueue_flush vq 0x5d04109b0c50 count 1
>> virtio_notify vdev 0x5d04109a8d50 vq 0x5d04109b0c50
>>
> 
> So L0 is able to receive data from L2. We're halfway there, Good! :).
> 
>> It looks like L1 is receiving data from L0 but this is not related to
>> the pings that are sent from L2. I haven't figured out what data is
>> actually being transferred in this case. It's not necessary for all of
>> the data that L1 receives from L0 to be passed to L2, is it?
>>
> 
> It should be noise, yes.
> 

Understood.

>>>>>> For svq->vring.num = 256, the following line is
>>>>>> printed 20 times,
>>>>>>
>>>>>> size: 256, len: 0, i: 0
>>>>>>
>>>>>> followed by:
>>>>>>
>>>>>> size: 256, len: 0, i: 1
>>>>>> size: 256, len: 0, i: 1
>>>>>>
>>>>>
>>>>> This makes sense for the tx queue too. Can you print the VirtQueue index?
>>>>
>>>> For svq->vring.num = 64, the vq index is 2. So the following line
>>>> (svq->vring.num, used_elem.len, used_elem.id, svq->vq->queue_index)
>>>> is printed repeatedly:
>>>>
>>>> size: 64, len: 1, i: 0, vq idx: 2
>>>>
>>>> For svq->vring.num = 256, the following line is repeated several
>>>> times:
>>>>
>>>> size: 256, len: 0, i: 0, vq idx: 1
>>>>
>>>> This is followed by:
>>>>
>>>> size: 256, len: 0, i: 1, vq idx: 1
>>>>
>>>> In both cases, queue_index is 1.
>>
>> I also noticed that there are now some lines with svq->vring.num = 256
>> where len > 0. These lines were printed by the QEMU instance running
>> in L1, so this corresponds to data that was received by L2.
>>
>> svq->vring.num  used_elem.len  used_elem.id  svq->vq->queue_index
>> size: 256       len: 82        i: 0          vq idx: 0
>> size: 256       len: 82        i: 1          vq idx: 0
>> size: 256       len: 82        i: 2          vq idx: 0
>> size: 256       len: 54        i: 3          vq idx: 0
>>
>> I still haven't figured out what data was received by L2 but I am
>> slightly confused as to why this data was received by L2 but not
>> the ICMP echo replies sent by L0.
>>
> 
> We're on a good track, let's trace it deeper. I guess these are
> printed from vhost_svq_flush, right? Do virtqueue_fill,
> virtqueue_flush, and event_notifier_set(&svq->svq_call) run properly,
> or do you see anything strange with gdb / tracing?
> 

Apologies for the delay in replying. It took me a while to figure
this out, but I have now understood why this doesn't work. L1 is
unable to receive messages from L0 because they get filtered out
by hw/net/virtio-net.c:receive_filter [1]. There's an issue with
the MAC addresses.

In L0, I have:

$ ip a show tap0
6: tap0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 1000
     link/ether d2:6d:b9:61:e1:9a brd ff:ff:ff:ff:ff:ff
     inet 111.1.1.1/24 scope global tap0
        valid_lft forever preferred_lft forever
     inet6 fe80::d06d:b9ff:fe61:e19a/64 scope link proto kernel_ll
        valid_lft forever preferred_lft forever

In L1:

# ip a show eth0
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
     link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
     altname enp0s2
     inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic noprefixroute eth0
        valid_lft 83455sec preferred_lft 83455sec
     inet6 fec0::7bd2:265e:3b8e:5acc/64 scope site dynamic noprefixroute
        valid_lft 86064sec preferred_lft 14064sec
     inet6 fe80::50e7:5bf6:fff8:a7b0/64 scope link noprefixroute
        valid_lft forever preferred_lft forever

I'll call this L1-eth0.

In L2:
# ip a show eth0
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP gro0
     link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
     altname enp0s7
     inet 111.1.1.2/24 scope global eth0
        valid_lft forever preferred_lft forever

I'll call this L2-eth0.

Apart from eth0, lo is the only other device in both L1 and L2.

A frame that L1 receives from L0 has L2-eth0's MAC address (LSB = 57)
as its destination address. When booting L2 with x-svq=false, the
value of n->mac in VirtIONet is also L2-eth0. So, L1 accepts
the frames and passes them on to L2 and pinging works [2].

However, when booting L2 with x-svq=true, n->mac is set to L1-eth0
(LSB = 56) in virtio_net_handle_mac() [3]. n->mac_table.macs also
does not seem to have L2-eth0's MAC address. Due to this,
receive_filter() filters out all the frames [4] that were meant for
L2-eth0.

With x-svq=true, I see that n->mac is set by virtio_net_handle_mac()
[3] when L1 receives VIRTIO_NET_CTRL_MAC_ADDR_SET. With x-svq=false,
virtio_net_handle_mac() doesn't seem to be getting called. I haven't
understood how the MAC address is set in VirtIONet when x-svq=false.
Understanding this might help see why n->mac has different values
when x-svq is false vs when it is true.

Thanks,
Sahil

[1] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/net/virtio-net.c#L1944
[2] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/net/virtio-net.c#L1775
[3] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/net/virtio-net.c#L1108
[4] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/net/virtio-net.c#L1770-1786


