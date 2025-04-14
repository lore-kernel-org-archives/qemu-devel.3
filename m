Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5EAC369B5
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 09:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4FzZ-0006TU-J5; Mon, 14 Apr 2025 05:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1u4FzY-0006T9-4d
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:20:36 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1u4FzV-0002Go-IY
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:20:35 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ff784dc055so3977283a91.1
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 02:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744622432; x=1745227232; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HvO86qEPqZnqfsB6EfINW+R6nz1/F1f+XZ/TINrS4k8=;
 b=RjxPeruy5pK9QrGp68MdpPvsg8+UJWcaZOscYQyxKpfyhDkMExzbf0r3aEGz/sjNr+
 SkBiEFpn8SeX7Ox1wiTr0Qt5uXV/Tzo0n8DYyH2RrYmVJn/JrQk+oolHXdJCwH4yuAJF
 5g3JXjvk5u/ybeq/wIiqyzhAMqD5m6csMvylJUh3YEfNJNsQY6PLHUC0dPHxVnw+lMkw
 v46uYIuwauAuKOmDbkVWNolwgrT8mjXm3QBCsoiDZ8wO4brlmmBiPjx6WcjDVOlYUGxB
 elDPZcVu+phECkj91Lq2fFgNQioUEaAxnvEHO9BUDx/ATc9iwPLL/1biDlic1sMu8TrP
 bNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744622432; x=1745227232;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvO86qEPqZnqfsB6EfINW+R6nz1/F1f+XZ/TINrS4k8=;
 b=MZYCCy1nmpvp+LsErfZTHugLFp+WlwzV6GL21vSZxMMkQjmZyNPGfxUsqEwuZ/DhiN
 2+Qoeyh+fYhy4fw7bubXUqqMisdGiN54Y11gpmX7V1/2zsN8WC8L6JngKI7hBJJtwVp/
 ZxLFXem0QCLN/EeRgHxet4mM2y2Zjd1wPtah/TbK0GYcmRAa27qtigNmvpgdzXVl2kl0
 0SI2ZQe4lOGVREqYw7ITKeGit8+nzhWZFZwIUiR71wRvvXccHcEE/OEgPTX1iDuiqw4S
 NkfIVZ8j3qUgt+O4yDd6NBudLx/KyMc9p0O8sTj6Kx8ChNdfCFRJJwLLx+N6XlaHYc2d
 gHBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO9TE8wQc1iNbgajmnKwEJrlYWTWLwtrdL/gh4/0K+ceKDDOnHlgGLl7s05vmvgI215QOAVeDU1Z+C@nongnu.org
X-Gm-Message-State: AOJu0YzV9r9QDET3I9aP2F/Q/HmiEypnOvORWJVK9WOzHFSzsm1QO7ts
 1PkOe9iHvIPHBx+ZiugQXKaPHM9OoNL3WfnrwmohdAVhxnHrGfHVheegfA==
X-Gm-Gg: ASbGncus29k3Rpj/yVE1aOh6iblBp9RwHtTl9dqvkKLFdtsCVoilRY6DdN+owNpocji
 GcUYFZ/Vxf3TMSY+eW2wqHeuG0YOc1RRIMEGdlwmGV5Ec/I2c5ciZ1LQDatE9M1GzsQ/mMC4ZRq
 2m3O8i40JYmhOTb2LtrpmhTjkuhfwYd9iPCqHbxg2i/2/u6D05YyISa1RPXi+XBZJIjDq1U9oQi
 HFoo1TWIztJADNfo2SQIepol6U3JApaIyki4Qliyhrh7o+aIcM1gjL5p8bf16imf1j3+BkkPXgZ
 J7ntHQ4IJVT6xJXGTLuQzBkClBF05pDQp4FaPufG1oHqcDQjgkZq4zZBOWNYgeTiKngTfBE5jvu
 OR/EU3AqS
X-Google-Smtp-Source: AGHT+IHWpUh8gdcHCBlLrelnYJ8dfDXLjVVhWb5dOz640nS8EpcK3aafodm/whd9+4/RgOR2mIF7cA==
X-Received: by 2002:a17:90b:4b44:b0:2fe:84d6:cdf9 with SMTP id
 98e67ed59e1d1-308237e17f2mr11991191a91.26.1744622431551; 
 Mon, 14 Apr 2025 02:20:31 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c45:45a3:affe:4635:b6b6:1a76?
 ([2401:4900:1c45:45a3:affe:4635:b6b6:1a76])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a71fsm10621201a91.8.2025.04.14.02.20.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 02:20:31 -0700 (PDT)
Message-ID: <f1354888-74fb-44d8-8b48-c6a6a13db1a7@gmail.com>
Date: Mon, 14 Apr 2025 14:50:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 0/7] Add packed format to shadow virtqueue
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 sahilcdq@proton.me, Jason Wang <jasowang@redhat.com>
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <CAJaqyWdXat-ugJHEcZyB5dbTuwGgvrO2+DdDd9YneS0=j-99NA@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWdXat-ugJHEcZyB5dbTuwGgvrO2+DdDd9YneS0=j-99NA@mail.gmail.com>
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

On 3/26/25 1:05 PM, Eugenio Perez Martin wrote:
> On Mon, Mar 24, 2025 at 2:59 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>> I managed to fix a few issues while testing this patch series.
>> There is still one issue that I am unable to resolve. I thought
>> I would send this patch series for review in case I have missed
>> something.
>>
>> The issue is that this patch series does not work every time. I
>> am able to ping L0 from L2 and vice versa via packed SVQ when it
>> works.
> 
> So we're on a very good track then!
> 
>> When this doesn't work, both VMs throw a "Destination Host
>> Unreachable" error. This is sometimes (not always) accompanied
>> by the following kernel error (thrown by L2-kernel):
>>
>> virtio_net virtio1: output.0:id 1 is not a head!
>>
> 
> How many packets have been sent or received before hitting this? If
> the answer to that is "the vq size", maybe there is a bug in the code
> that handles the wraparound of the packed vq, as the used and avail
> flags need to be twisted. You can count them in the SVQ code.

I did a lot more testing. This issue is quite unpredictable in terms
of the time at which it appears after booting L2. So far, it almost
always appears after booting L2. Even when pinging works, this issue
appears after several seconds of pinging.

The total number of svq descriptors varied in every test run. But in
every case, all 256 indices were filled in the descriptor region for
vq with vq_idx = 0. This is the RX vq, right? This was filled while L2
was booting. In the case when the ctrl vq is disabled, I am not sure
what is responsible for filling the vqs in the data plane during
booting.

=====
The issue is hit most frequently when the following command is run
in L0:
$ ip addr add 111.1.1.1/24 dev tap0
$ ip link set tap0 up

or, running the following in L2:
# ip addr add 111.1.1.2/24 dev eth0

The other vq (vq_idx=1) is not filled completely before the issue is
hit. I have been noting down the numbers and here is an example:

295 descriptors were added individually to the queues i.e., there were no chains (vhost_svq_add_packed)
|_ 256 additions in vq_idx = 0, all with unique ids
     |---- 27 descriptors (ids 0 through 26) were received later from the device (vhost_svq_get_buf_packed)
|_ 39 additions in vq_idx = 1
     |_ 13 descriptors had id = 0
     |_ 26 descriptors had id = 1
     |---- All descriptors were received at some point from the device (vhost_svq_get_buf_packed)

There was one case in which vq_idx=0 had wrapped around. I verified
that flags were set appropriately during the wrap (avail and used flags
were flipped as expected).

=====
The next common situation where this issue is hit is during startup.
Before L2 can finish booting successfully, this error is thrown:

virtio_net virtio1: output.0:id 0 is not a head!

258 descriptors were added individually to the queues during startup (there were no chains) (vhost_svq_add_packed)
|_ 256 additions in vq_idx = 0, all with unique ids
    |---- None of them were received by the device (vhost_svq_get_buf_packed)
|_ 2 additions in vq_idx = 1
    |_ id = 0 in index 0
    |_ id = 1 in index 1
    |---- Both descriptors were received at some point during startup from the device (vhost_svq_get_buf_packed)

=====
Another case is after several seconds of pinging L0 from L2.

[   99.034114] virtio_net virtio1: output.0:id 0 is not a head!

366 descriptors were added individually to the queues i.e., there were no chains (vhost_svq_add_packed)
|_ 289 additions in vq_idx = 0, wrap-around was observed with avail and used flags inverted for 33 descriptors
|   |---- 40 descriptors (ids 0 through 39) were received from the device (vhost_svq_get_buf_packed)
|_ 77 additions in vq_idx = 1
     |_ 76 descriptors had id = 0
     |_ 1 descriptor had id = 1
     |---- all 77 descriptors were received at some point from the device (vhost_svq_get_buf_packed)

I am not entirely sure now if there's an issue in the packed vq
implementation in QEMU or if this is being caused due to some sort
of race condition in linux.

"id is not a head" is being thrown because vq->packed.desc_state[id].data
doesn't exist for the corresponding id in Linux [1]. But QEMU seems to have
stored some data for this id via vhost_svq_add() [2]. Linux sets the value
of vq->packed.desc_state[id].data in its version of virtqueue_add_packed() [3].

>> This error is not thrown always, but when it is thrown, the id
>> varies. This is invariably followed by a soft lockup:
>> [...]
>> [  284.662292] Call Trace:
>> [  284.662292]  <IRQ>
>> [  284.662292]  ? watchdog_timer_fn+0x1e6/0x270
>> [  284.662292]  ? __pfx_watchdog_timer_fn+0x10/0x10
>> [  284.662292]  ? __hrtimer_run_queues+0x10f/0x2b0
>> [  284.662292]  ? hrtimer_interrupt+0xf8/0x230
>> [  284.662292]  ? __sysvec_apic_timer_interrupt+0x4d/0x140
>> [  284.662292]  ? sysvec_apic_timer_interrupt+0x39/0x90
>> [  284.662292]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
>> [  284.662292]  ? virtqueue_enable_cb_delayed+0x115/0x150
>> [  284.662292]  start_xmit+0x2a6/0x4f0 [virtio_net]
>> [  284.662292]  ? netif_skb_features+0x98/0x300
>> [  284.662292]  dev_hard_start_xmit+0x61/0x1d0
>> [  284.662292]  sch_direct_xmit+0xa4/0x390
>> [  284.662292]  __dev_queue_xmit+0x84f/0xdc0
>> [  284.662292]  ? nf_hook_slow+0x42/0xf0
>> [  284.662292]  ip_finish_output2+0x2b8/0x580
>> [  284.662292]  igmp_ifc_timer_expire+0x1d5/0x430
>> [  284.662292]  ? __pfx_igmp_ifc_timer_expire+0x10/0x10
>> [  284.662292]  call_timer_fn+0x21/0x130
>> [  284.662292]  ? __pfx_igmp_ifc_timer_expire+0x10/0x10
>> [  284.662292]  __run_timers+0x21f/0x2b0
>> [  284.662292]  run_timer_softirq+0x1d/0x40
>> [  284.662292]  __do_softirq+0xc9/0x2c8
>> [  284.662292]  __irq_exit_rcu+0xa6/0xc0
>> [  284.662292]  sysvec_apic_timer_interrupt+0x72/0x90
>> [  284.662292]  </IRQ>
>> [  284.662292]  <TASK>
>> [  284.662292]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
>> [  284.662292] RIP: 0010:pv_native_safe_halt+0xf/0x20
>> [  284.662292] Code: 22 d7 c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 53 75 3f 00 fb f4 <c3> cc c0
>> [  284.662292] RSP: 0018:ffffb8f0000b3ed8 EFLAGS: 00000212
>> [  284.662292] RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000000
>> [  284.662292] RDX: 4000000000000000 RSI: 0000000000000083 RDI: 00000000000289ec
>> [  284.662292] RBP: ffff96f200810000 R08: 0000000000000000 R09: 0000000000000001
>> [  284.662292] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
>> [  284.662292] R13: 0000000000000000 R14: ffff96f200810000 R15: 0000000000000000
>> [  284.662292]  default_idle+0x9/0x20
>> [  284.662292]  default_idle_call+0x2c/0xe0
>> [  284.662292]  do_idle+0x226/0x270
>> [  284.662292]  cpu_startup_entry+0x2a/0x30
>> [  284.662292]  start_secondary+0x11e/0x140
>> [  284.662292]  secondary_startup_64_no_verify+0x184/0x18b
>> [  284.662292]  </TASK>
>>
>> The soft lockup seems to happen in
>> drivers/net/virtio_net.c:start_xmit() [1].
>>
> 
> Maybe it gets stuck in the do {} while(...
> !virtqueue_enable_cb_delayed()) ? you can add a printk in
> virtqueue_enable_cb_delayed return and check if it matches with the
> speed you're sending or receiving ping. For example, if ping is each
> second, you should not see a lot of traces.
> 
> If this does not work I'd try never disabling notifications, both in
> the kernel and SVQ, and check if that works.

In order to disable notifications, will something have to be commented
out in the implementation?

>> [...]
>> QEMU command to boot L1:
>>
>> $ sudo ./qemu/build/qemu-system-x86_64 \
>> -enable-kvm \
>> -drive file=//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=disk,if=virtio \
>> -net nic,model=virtio \
>> -net user,hostfwd=tcp::2222-:22 \
>> -device intel-iommu,snoop-control=on \
>> -device virtio-net-pci,netdev=net0,disable-legacy=on,disable-modern=off,iommu_platform=on,guest_uso4=off,guest_uso6=off,host_uso=off,guest_announce=off,mq=off,ctrl_vq=off,ctrl_rx=off,ctrl_vlan=off,ctrl_mac_addr=off,packed=on,event_idx=off,bus=pcie.0,addr=0x4 \
>> -netdev tap,id=net0,script=no,downscript=no,vhost=off \
>> -nographic \
>> -m 8G \
>> -smp 4 \
>> -M q35 \
>> -cpu host 2>&1 | tee vm.log
>>

I have added "-device virtio-net-pci,indirect_desc=off,queue_reset=off"
to the L0 QEMU command to boot L1.

Thanks,
Sahil

[1] https://github.com/torvalds/linux/blob/master/drivers/virtio/virtio_ring.c#L1762
[2] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-shadow-virtqueue.c#L290
[3] https://github.com/torvalds/linux/blob/master/drivers/virtio/virtio_ring.c#L1564

