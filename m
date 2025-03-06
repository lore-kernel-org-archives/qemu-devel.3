Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1B0C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 05:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq3jt-0007MJ-Sa; Thu, 06 Mar 2025 00:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tq3jr-0007IT-Io
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 00:25:43 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tq3jo-0006SJ-B1
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 00:25:43 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22337bc9ac3so3969485ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 21:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741238737; x=1741843537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=4s5i2i4WafqvxidGv3pbDfABsZjoRBkkfWKcCjnXTDQ=;
 b=ODZO/YCtvUiRo0W58RC0Nq6JQVsOlkADB2rPO3m3T/kicl3++Q9V6rH8WTJAAozZ07
 bp+i3EGgPydXgH/tzMzgsXvkvC6oXuhQKTT32DbCLY2jhe6CKKM8XwIiG+pFot/YYbH3
 JI73ZReoniN2YZYm0lGNdysNjyi3xfoF0VbCnl3GgpRrZyPFpNFT6yb+JanLpX7yzOtV
 eBuVSsNXltwCOeN2uzCqZDhGLqohfmAwSmd1u1058G/gTsaILbt5446kcowQ3hjb5oHY
 ar68MuRf+CcgpO6g8fKdw53YUA8TINlr2hDK8Pj5da81UwKdiaEfU1D13oel/dCp4ymV
 b+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741238737; x=1741843537;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4s5i2i4WafqvxidGv3pbDfABsZjoRBkkfWKcCjnXTDQ=;
 b=fQxQWJi/9NF1Vd/hujRWFMb68CwvWNnFKKFU/O9tEtz4zbxkJ3lChAWHWbveZJ/Ppc
 rxh21o5q2Gy7XPi3YOMs7to9m479+9pyGM68ufF68D7qVeFIkHKLMxVhTqrQJeuZH0sX
 KWrfn45bWbcQze2Ruox8ei8O5188C5JUGioYdGPjxwrONfKYNFEKFgQsSAMcCITGiiq2
 gIYW51ikntRxT4Uki4a0BVtJgR5JvM+jwRZTJDUykmY6kaL4/hunj/jQkd4XDYr4YZsq
 n0TqzcxGnpxL7Jl6ReVKZp9uQnvL+Q9DOQgUtXlyQhBxTLIcDR3AcRzZRG+CWAfoDyWc
 vl4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPUlSgr+8SI3vWYkFm+Yxsts/kF6+oTvA0X7vgRNSYAc56QYqr3+MONdkxQjCU55dk0cCVQYjc0eFh@nongnu.org
X-Gm-Message-State: AOJu0YxarMN+X6Gj3YVFCmqofC2Qzyc00cUvClWLawa4pB1pFqmrwPIW
 qvyOiI7DBO9S5zvJ3Ap5xmtYUfv1+HmzRy4fuAm1VaJW4fpOXV0TFdS5Xw==
X-Gm-Gg: ASbGncvAsWTqO0B3TF+tKsF3ViDI3sMnVIlyN6jSOV2Bfck1mNuvuLhG7yeetpzERh8
 QMdMZB7ZoTn6zeMQ5XJBmeFOsKRo3zqNkoTwBRav643rihZseO8esDeKjG72smZd+bqRP2XdwpQ
 Hp5Zi2JPenN4uI1ZHEOZmWdcvfdamLXyhwubd/nog8gD7Z03mpoQJK7c2Kog1MQ2BAozwX4DASf
 WSCWHRdR6hizAz6Ng3wjlhgTXHQC1/zqThQYI2367JHsqYkXFleF376Aua7p/+BwUuXBBTYTX4B
 e2KUNZMYH2Y15duEi1Gt/bULhv8tn/T7JB/221YqFg0ehxadnvNXXas/nx9GtgfVHkhg82m0G1Z
 PSGlyWHUeuQ==
X-Google-Smtp-Source: AGHT+IHC0C7mHZ7yGmgYGIcyR2yoJqM5hJoMCo3lewcBjsxk2ou9IytYv5wgazm8GpdEeTcBpUlEOQ==
X-Received: by 2002:a17:902:d2c1:b0:223:47d9:1964 with SMTP id
 d9443c01a7336-223f1cf3530mr102845995ad.34.1741238735728; 
 Wed, 05 Mar 2025 21:25:35 -0800 (PST)
Received: from ?IPV6:2401:4900:1c42:5466:5485:c174:232:a75a?
 ([2401:4900:1c42:5466:5485:c174:232:a75a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a7f9e0sm3371965ad.113.2025.03.05.21.25.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 21:25:35 -0800 (PST)
Message-ID: <a4dbfe72-853c-4eff-b2cb-90b363eee9c0@gmail.com>
Date: Thu, 6 Mar 2025 10:55:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 0/5] Add packed virtqueue to shadow virtqueue
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
References: <20241205203430.76251-1-sahilcdq@proton.me>
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
 <360803dd-f1e0-48a3-8917-2477d8a821a9@gmail.com>
 <69a7da95-c050-4a22-b295-ff3c2eb34fb4@gmail.com>
 <CAJaqyWf4OLVmZn+g7B6X97QFUjRV9K=u-Bkr_OhRKUSsJgd6tg@mail.gmail.com>
 <37880ee7-74c4-47c3-93ce-c2a8b177fc10@gmail.com>
 <CAJaqyWdkMNgXOGCXRCm9y+hOuR1eiNghpKeoiGHrXjzvW5+Grg@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWdkMNgXOGCXRCm9y+hOuR1eiNghpKeoiGHrXjzvW5+Grg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x633.google.com
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

Sorry for the delay in my response. There was a lot to absorb in the
previous mail and I thought I would spend some more time exploring
this.

On 2/11/25 1:27 PM, Eugenio Perez Martin wrote:
> On Mon, Feb 10, 2025 at 5:25 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>> On 2/10/25 7:53 PM, Eugenio Perez Martin wrote:
>>> On Mon, Feb 10, 2025 at 11:58 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>>> On 2/6/25 8:47 PM, Sahil Siddiq wrote:
>>>>> On 2/6/25 12:42 PM, Eugenio Perez Martin wrote:
>>>>>> On Thu, Feb 6, 2025 at 6:26 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>>>>>> On 2/4/25 11:45 PM, Eugenio Perez Martin wrote:
>>>>>>>> PS: Please note that you can check packed_vq SVQ implementation
>>>>>>>> already without CVQ, as these features are totally orthogonal :).
>>>>>>>>
>>>>>>>
>>>>>>> Right. Now that I can ping with the ctrl features turned off, I think
>>>>>>> this should take precedence. There's another issue specific to the
>>>>>>> packed virtqueue case. It causes the kernel to crash. I have been
>>>>>>> investigating this and the situation here looks very similar to what's
>>>>>>> explained in Jason Wang's mail [2]. My plan of action is to apply his
>>>>>>> changes in L2's kernel and check if that resolves the problem.
>>>>>>>
>>>>>>> The details of the crash can be found in this mail [3].
>>>>>>>
>>>>>>
>>>>>> If you're testing this series without changes, I think that is caused
>>>>>> by not implementing the packed version of vhost_svq_get_buf.
>>>>>>
>>>>>> https://lists.nongnu.org/archive/html/qemu-devel/2024-12/msg01902.html
>>>>>>
>>>>>
>>>>> Oh, apologies, I think I had misunderstood your response in the linked mail.
>>>>> Until now, I thought they were unrelated. In that case, I'll implement the
>>>>> packed version of vhost_svq_get_buf. Hopefully that fixes it :).
>>>>>
>>>>
>>>> I noticed one thing while testing some of the changes that I have made.
>>>> I haven't finished making the relevant changes to all the functions which
>>>> will have to handle split and packed vq differently. L2's kernel crashes
>>>> when I launch L0-QEMU with ctrl_vq=on,ctrl_rx=on.
>>>
>>> Interesting, is a similar crash than this? (NULL ptr deference on
>>> virtnet_set_features)?
>>>
>>> https://issues.redhat.com/browse/RHEL-391
>> I am not able to access this bug report (even with a Red Hat account). It
>> says it may have been deleted or I don't have the permission to view it.
>>
>> It's hard to tell if this is the same issue. I don't think it is the same
>> issue though since I don't see any such indication in the logs. The kernel
>> throws the following:
>>
>> [   23.047503] virtio_net virtio1: output.0:id 0 is not a head!
> 
> This is a common error when modifying code of the dataplane, it is
> unlikely to do deep changes and not see this error :). It indicates
> that your code is marking the descriptor id 0 as used when the guest
> didn't make it available.

Right, I explored this a little further. I noticed that there were
a few issues in my implementation with the way packed vqs were being
handled (apart from the lack of implementation of
vhost_svq_get_buf_packed). After making the relevant changes and
implementing vhost_svq_get_buf_packed, I couldn't see this issue
anymore.

> If this is happening in control virtqueue, I'd check if the code is
> setting the flags as used in ring[1] when it shouldn't. But my bet is
> that the rx queue is the wrong one.

The flags were one of the issues. I hadn't initialized "avail_used_flags"
correctly. Rectifying them seems to have solved this issue. However, I see
two new issues (described further below).

>> [   49.173243] watchdog: BUG: soft lockup - CPU#1 stuck for 25s! [NetworkManager:782]
>> [   49.174167] Modules linked in: rfkill intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core intel_vsec pmt_telemetry pmt_class kvg
>> [   49.188258] CPU: 1 PID: 782 Comm: NetworkManager Not tainted 6.8.7-200.fc39.x86_64 #1
>> [   49.193196] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>> [   49.193196] RIP: 0010:virtqueue_get_buf+0x0/0x20
>>
> 
> Two possibilities about this part:
> a) You're spending "too long" in the debugger in QEMU. From the kernel
> POV, the function virtqueue_get_buf is taking too long to complete so
> it detects it as a lockup. You can check this scenario by not running
> QEMU under GDB or disabling all breakpoints. You can ignore this
> message if you don't find the error this way. If you still see the
> message, goto possibility b.
> 
> b) The kernel has a bug that makes it softlockup in virtqueue_get_buf.
> The kernel should not soft lockup even if your changes were malicious
> :(, so it is something to be fixed. If you have the time, can you test
> with the latest upstream kernel?

I wasn't running QEMU under GDB, so there may indeed be an issue in the
kernel. While I don't see a soft lockup at this exact point after making
the above described changes, I do see a soft lockup issue in another part
of virtio-net.

When testing my implementation with the control feature bits turned on,
the kernel throws the following warning while booting.

[    9.046478] net eth0: Failed to disable allmulti mode.

This is printed as a dev_warn() in drivers/net/virtio_net.c:virtnet_rx_mode_work [1].
The kernel doesn't continue booting beyond this point and after a few seconds,
it reports a soft lockup.

>> Maybe I was incorrect in stating that the kernel crashes. It's more like
>> the kernel is stuck in a loop (according to these blog posts on soft
>> lockup [1][2]).
>>
>> In the above trace, RIP is in virtqueue_get_buf() [3]. This is what
>> calls virtqueue_get_buf_ctx_packed() [4] which throws the error.
>>
>> What I don't understand is why vq->packed.desc_state[id].data [5] is
>> NULL when the control features are turned on, but doesn't seem to be
>> NULL when the control features are turned off.
> 
> Due to the net subsystem lock, CVQ handling is not as robust / secure
> against this error as the dataplane queues. There is an ongoing effort
> to make it more robust, so maybe this is something to fix in that
> line.
> 
> Can you put the whole backtrace that prints the kernel?

I haven't tested these changes with the latest kernel yet. I think this would be
a good time to test against the latest kernel. I'll update my kernel.

Here's the backtrace that is printed in the kernel that I currently have installed
(6.8.5-201.fc39.x86_64), in case this is relevant.

[   65.214308] watchdog: BUG: soft lockup - CPU#0 stuck for 51s! [NetworkManage]
[   65.215933] Modules linked in: rfkill intel_rapl_msr intel_rapl_common intelg
[   65.238465] CPU: 0 PID: 784 Comm: NetworkManager Tainted: G             L   1
[   65.242530] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14
[   65.248474] RIP: 0010:virtnet_send_command+0x17c/0x1e0 [virtio_net]
[   65.251505] Code: 74 24 48 e8 f6 b1 40 c1 85 c0 78 60 48 8b 7b 08 e8 29 92 43
[   65.260475] RSP: 0018:ffffb8038073f298 EFLAGS: 00000246
[   65.260475] RAX: 0000000000000000 RBX: ffff8ea600f389c0 RCX: ffffb8038073f29c
[   65.265165] RDX: 0000000000008003 RSI: 0000000000000000 RDI: ffff8ea60cead300
[   65.269528] RBP: ffffb8038073f2c0 R08: 0000000000000001 R09: ffff8ea600f389c0
[   65.272532] R10: 0000000000000030 R11: 0000000000000002 R12: 0000000000000002
[   65.274483] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   65.278518] FS:  00007f2dd66f2540(0000) GS:ffff8ea67bc00000(0000) knlGS:00000
[   65.280653] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   65.284492] CR2: 00005593d46e5868 CR3: 000000010d310001 CR4: 0000000000770ef0
[   65.286464] PKRU: 55555554
[   65.288524] Call Trace:
[   65.291470]  <IRQ>
[   65.291470]  ? watchdog_timer_fn+0x1e6/0x270
[   65.293464]  ? __pfx_watchdog_timer_fn+0x10/0x10
[   65.296496]  ? __hrtimer_run_queues+0x10f/0x2b0
[   65.297578]  ? hrtimer_interrupt+0xf8/0x230
[   65.300472]  ? __sysvec_apic_timer_interrupt+0x4d/0x140
[   65.301680]  ? sysvec_apic_timer_interrupt+0x6d/0x90
[   65.305464]  </IRQ>
[   65.305464]  <TASK>
[   65.305464]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   65.308705]  ? virtnet_send_command+0x17c/0x1e0 [virtio_net]
[   65.312466]  ? virtnet_send_command+0x176/0x1e0 [virtio_net]
[   65.314465]  virtnet_set_rx_mode+0xd8/0x340 [virtio_net]
[   65.317466]  __dev_mc_add+0x79/0x80
[   65.318462]  igmp_group_added+0x1f2/0x210
[   65.320541]  ____ip_mc_inc_group+0x15b/0x250
[   65.323522]  ip_mc_up+0x4f/0xb0
[   65.324491]  inetdev_event+0x27a/0x700
[   65.325469]  ? _raw_spin_unlock_irqrestore+0xe/0x40
[   65.329462]  notifier_call_chain+0x5a/0xd0
[   65.331717]  __dev_notify_flags+0x5c/0xf0
[   65.332491]  dev_change_flags+0x54/0x70
[   65.334508]  do_setlink+0x375/0x12d0
[   65.336554]  ? __nla_validate_parse+0x61/0xd50
[   65.338510]  __rtnl_newlink+0x668/0xa30
[   65.340733]  ? security_unix_may_send+0x21/0x50
[   65.342620]  rtnl_newlink+0x47/0x70
[   65.344556]  rtnetlink_rcv_msg+0x14f/0x3c0
[   65.346509]  ? avc_has_perm_noaudit+0x6b/0xf0
[   65.348470]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   65.350533]  netlink_rcv_skb+0x58/0x110
[   65.352482]  netlink_unicast+0x1a3/0x290
[   65.354547]  netlink_sendmsg+0x223/0x490
[   65.356480]  ____sys_sendmsg+0x396/0x3d0
[   65.357482]  ? copy_msghdr_from_user+0x7d/0xc0
[   65.360488]  ___sys_sendmsg+0x9a/0xe0
[   65.360488]  __sys_sendmsg+0x7a/0xd0
[   65.364591]  do_syscall_64+0x83/0x170
[   65.365485]  ? syscall_exit_to_user_mode+0x83/0x230
[   65.368475]  ? do_syscall_64+0x90/0x170
[   65.370477]  ? _raw_spin_unlock+0xe/0x30
[   65.372498]  ? proc_sys_call_handler+0xfc/0x2e0
[   65.374474]  ? kvm_clock_get_cycles+0x18/0x30
[   65.376475]  ? ktime_get_ts64+0x47/0xe0
[   65.378457]  ? posix_get_monotonic_timespec+0x65/0xa0
[   65.380535]  ? put_timespec64+0x3e/0x70
[   65.382458]  ? syscall_exit_to_user_mode+0x83/0x230
[   65.384542]  ? do_syscall_64+0x90/0x170
[   65.384542]  ? do_syscall_64+0x90/0x170
[   65.387505]  ? ksys_write+0xd8/0xf0
[   65.388670]  ? syscall_exit_to_user_mode+0x83/0x230
[   65.390522]  ? do_syscall_64+0x90/0x170
[   65.390522]  ? syscall_exit_to_user_mode+0x83/0x230
[   65.394472]  ? do_syscall_64+0x90/0x170
[   65.396532]  ? syscall_exit_to_user_mode+0x83/0x230
[   65.398519]  ? do_syscall_64+0x90/0x170
[   65.400486]  ? do_user_addr_fault+0x304/0x670
[   65.400486]  ? clear_bhb_loop+0x55/0xb0
[   65.404531]  ? clear_bhb_loop+0x55/0xb0
[   65.405471]  ? clear_bhb_loop+0x55/0xb0
[   65.408520]  entry_SYSCALL_64_after_hwframe+0x78/0x80
[   65.408520] RIP: 0033:0x7f2dd7810a1b
[   65.413467] Code: 48 89 e5 48 83 ec 20 89 55 ec 48 89 75 f0 89 7d f8 e8 09 3b
[   65.420593] RSP: 002b:00007ffcff6bd520 EFLAGS: 00000293 ORIG_RAX: 0000000000e
[   65.425554] RAX: ffffffffffffffda RBX: 00005593d4679a90 RCX: 00007f2dd7810a1b
[   65.428519] RDX: 0000000000000000 RSI: 00007ffcff6bd560 RDI: 000000000000000d
[   65.430509] RBP: 00007ffcff6bd540 R08: 0000000000000000 R09: 0000000000000000
[   65.434723] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000000a
[   65.438526] R13: 00005593d4679a90 R14: 0000000000000001 R15: 0000000000000000
[   65.440555]  </TASK>
[   71.028432] rcu: INFO: rcu_preempt self-detected stall on CPU
[   71.028432] rcu:     0-....: (1 GPs behind) idle=7764/1/0x4000000000000000 s9
[   71.036518] rcu:     (t=60010 jiffies g=2193 q=1947 ncpus=4)
[   71.041707] CPU: 0 PID: 784 Comm: NetworkManager Tainted: G             L   1
[   71.050455] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14
[   71.055661] RIP: 0010:virtnet_send_command+0x17c/0x1e0 [virtio_net]
[   71.059518] Code: 74 24 48 e8 f6 b1 40 c1 85 c0 78 60 48 8b 7b 08 e8 29 92 43
[   71.065526] RSP: 0018:ffffb8038073f298 EFLAGS: 00000246
[   71.067651] RAX: 0000000000000000 RBX: ffff8ea600f389c0 RCX: ffffb8038073f29c
[   71.069472] RDX: 0000000000008003 RSI: 0000000000000000 RDI: ffff8ea60cead300
[   71.071461] RBP: ffffb8038073f2c0 R08: 0000000000000001 R09: ffff8ea600f389c0
[   71.075455] R10: 0000000000000030 R11: 0000000000000002 R12: 0000000000000002
[   71.078461] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   71.079579] FS:  00007f2dd66f2540(0000) GS:ffff8ea67bc00000(0000) knlGS:00000
[   71.083577] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   71.083577] CR2: 00005593d46e5868 CR3: 000000010d310001 CR4: 0000000000770ef0
[   71.087582] PKRU: 55555554
[   71.090472] Call Trace:
[   71.091452]  <IRQ>
[   71.091452]  ? rcu_dump_cpu_stacks+0xc4/0x100
[   71.095487]  ? rcu_sched_clock_irq+0x32e/0x1040
[   71.095487]  ? task_tick_fair+0x40/0x3f0
[   71.100466]  ? trigger_load_balance+0x73/0x360
[   71.100466]  ? update_process_times+0x74/0xb0
[   71.103539]  ? tick_sched_handle+0x21/0x60
[   71.107494]  ? tick_nohz_highres_handler+0x6f/0x90
[   71.107572]  ? __pfx_tick_nohz_highres_handler+0x10/0x10
[   71.111477]  ? __hrtimer_run_queues+0x10f/0x2b0
[   71.111477]  ? hrtimer_interrupt+0xf8/0x230
[   71.116489]  ? __sysvec_apic_timer_interrupt+0x4d/0x140
[   71.119526]  ? sysvec_apic_timer_interrupt+0x6d/0x90
[   71.119526]  </IRQ>
[   71.124489]  <TASK>
[   71.124489]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   71.127499]  ? virtnet_send_command+0x17c/0x1e0 [virtio_net]
[   71.127499]  ? virtnet_send_command+0x176/0x1e0 [virtio_net]
[   71.132613]  virtnet_set_rx_mode+0xd8/0x340 [virtio_net]
[   71.136474]  __dev_mc_add+0x79/0x80
[   71.136474]  igmp_group_added+0x1f2/0x210
[   71.139469]  ____ip_mc_inc_group+0x15b/0x250
[   71.140473]  ip_mc_up+0x4f/0xb0
[   71.143492]  inetdev_event+0x27a/0x700
[   71.144486]  ? _raw_spin_unlock_irqrestore+0xe/0x40
[   71.147600]  notifier_call_chain+0x5a/0xd0
[   71.148918]  __dev_notify_flags+0x5c/0xf0
[   71.151634]  dev_change_flags+0x54/0x70
[   71.153529]  do_setlink+0x375/0x12d0
[   71.155476]  ? __nla_validate_parse+0x61/0xd50
[   71.157541]  __rtnl_newlink+0x668/0xa30
[   71.159503]  ? security_unix_may_send+0x21/0x50
[   71.161954]  rtnl_newlink+0x47/0x70
[   71.163680]  rtnetlink_rcv_msg+0x14f/0x3c0
[   71.165468]  ? avc_has_perm_noaudit+0x6b/0xf0
[   71.167506]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   71.170499]  netlink_rcv_skb+0x58/0x110
[   71.171461]  netlink_unicast+0x1a3/0x290
[   71.174477]  netlink_sendmsg+0x223/0x490
[   71.175472]  ____sys_sendmsg+0x396/0x3d0
[   71.175472]  ? copy_msghdr_from_user+0x7d/0xc0
[   71.179465]  ___sys_sendmsg+0x9a/0xe0
[   71.179465]  __sys_sendmsg+0x7a/0xd0
[   71.182526]  do_syscall_64+0x83/0x170
[   71.183522]  ? syscall_exit_to_user_mode+0x83/0x230
[   71.183522]  ? do_syscall_64+0x90/0x170
[   71.187502]  ? _raw_spin_unlock+0xe/0x30
[   71.187502]  ? proc_sys_call_handler+0xfc/0x2e0
[   71.191500]  ? kvm_clock_get_cycles+0x18/0x30
[   71.191500]  ? ktime_get_ts64+0x47/0xe0
[   71.195472]  ? posix_get_monotonic_timespec+0x65/0xa0
[   71.195472]  ? put_timespec64+0x3e/0x70
[   71.198593]  ? syscall_exit_to_user_mode+0x83/0x230
[   71.199571]  ? do_syscall_64+0x90/0x170
[   71.202457]  ? do_syscall_64+0x90/0x170
[   71.203463]  ? ksys_write+0xd8/0xf0
[   71.203463]  ? syscall_exit_to_user_mode+0x83/0x230
[   71.207464]  ? do_syscall_64+0x90/0x170
[   71.207464]  ? syscall_exit_to_user_mode+0x83/0x230
[   71.211460]  ? do_syscall_64+0x90/0x170
[   71.211460]  ? syscall_exit_to_user_mode+0x83/0x230
[   71.211460]  ? do_syscall_64+0x90/0x170
[   71.216481]  ? do_user_addr_fault+0x304/0x670
[   71.216481]  ? clear_bhb_loop+0x55/0xb0
[   71.220472]  ? clear_bhb_loop+0x55/0xb0
[   71.220472]  ? clear_bhb_loop+0x55/0xb0
[   71.223704]  entry_SYSCALL_64_after_hwframe+0x78/0x80
[   71.225564] RIP: 0033:0x7f2dd7810a1b
[   71.227495] Code: 48 89 e5 48 83 ec 20 89 55 ec 48 89 75 f0 89 7d f8 e8 09 3b
[   71.235475] RSP: 002b:00007ffcff6bd520 EFLAGS: 00000293 ORIG_RAX: 0000000000e
[   71.239515] RAX: ffffffffffffffda RBX: 00005593d4679a90 RCX: 00007f2dd7810a1b
[   71.241643] RDX: 0000000000000000 RSI: 00007ffcff6bd560 RDI: 000000000000000d
[   71.245469] RBP: 00007ffcff6bd540 R08: 0000000000000000 R09: 0000000000000000
[   71.247467] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000000a
[   71.251479] R13: 00005593d4679a90 R14: 0000000000000001 R15: 0000000000000000
[   71.251479]  </TASK>

When I test my changes with the control feature bits turned off, I see another
issue. The kernel boots successfully in this case, but I noticed that no new
elements in the dataplane are added to the virtqueue. This is because, in
hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_translate_addr() [2], when gpas
is not null and QEMU tries to retrieve the IOVA address from the GPA->IOVA
tree, the result of map is NULL in the following line [3]:

map = vhost_iova_tree_find_gpa(svq->iova_tree, &needle)

Due to this, vhost_svq_vring_write_descs() [4] simply returns false and nothing
is added to the virtqueue.

This issue is present even for split virtqueues, when I test my changes with
"packed=off". However, I don't see any issues when I build QEMU from the master
branch. I think the issue might lie in how memory is being allocated to the
virtqueues in my implementation, but I am not sure. I have a few ideas regarding
how this can be debugged. I'll let you know if I find anything else.

>>> [...]
>>>> There's another thing that I am confused about regarding the current
>>>> implementation (in the master branch).
>>>>
>>>> In hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_vring_write_descs() [1],
>>>> svq->free_head saves the descriptor in the specified format using
>>>> "le16_to_cpu" (line 171).
>>>
>>> Good catch, this should be le16_to_cpu actually. But code wise is the
>>> same, so we have no visible error. Do you want to send a patch to fix
>>> it?
>>>
>> Sorry, I am still a little confused here. Did you mean cpu_to_le16
>> by any chance? Based on what I have understood, if it is to be used
>> by the host machine, then it should be cpu_to_le16.
>>
>> I can send a patch once this is clear, or can even integrate it in
>> this patch series since this patch series refactors that function
>> anyway.
>>
> 
> Ok, I don't know how I read the function to answer you that :(. Let me
> start from scratch,
> 
> In line 171, we're copying data from QEMU internals, that are not in
> the guest memory, to other QEMU internals. So no cpu_to_le* or
> le*to_cpu is needed.

Understood.

>>>> On the other hand, the value of i is stored
>>>> in the native endianness using "cpu_to_le16" (line 168). If "i" is to be
>>>> stored in the native endianness (little endian in this case), then
>>>> should svq->free_head first be converted to little endian before being
>>>> assigned to "i" at the start of the function (line 142)?
>>>>
>>>
> 
> No endianness conversion is needed here for the same reason, all is
> internal to QEMU and not intended to be seen by the guest.
> 

Got it. This makes sense now.

Thanks,
Sahil

[1] https://github.com/torvalds/linux/blob/master/drivers/net/virtio_net.c#L3712
[2] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-shadow-virtqueue.c#L83
[3] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-shadow-virtqueue.c#L104
[4] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-shadow-virtqueue.c#L171


