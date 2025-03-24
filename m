Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD36C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 13:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twiGB-0004od-5L; Mon, 24 Mar 2025 09:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiG8-0004nr-S1
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:54:33 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiG5-0003JT-Qs
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:54:32 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-226185948ffso81867475ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 06:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742824467; x=1743429267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=QyyBGBZmKNXHzFHuKyQZqACMIbfxCHqLM4zhB4ADgn0=;
 b=bisfbhB+YIkHOkf2y2uSmgOhl8sl9mTpekAWjxy8G/wWKCHNEPWdFTG6YdgP/VOEhq
 5KsDoQJ9k/tzZrwaqA2qz3VKpP/hLoyW27WsWbJXlCG5LRHo2L3HjixYEEQavLhKURxf
 eqY/xIrwdEQF6zI+sqkXfENtttJzEybtczU2z1W6Cz81HmgNIi64Zli/pYJ3vQpIOyF/
 VPjmZsG+I90gVn+9Zeen6cFbCkeJPj0hrmwY+rykwEjVRQNNFHzFCZeA/i6FxNIUqQAs
 QxDbTBSkT7+SzF0z8n7mSHDJKqDiMCmewdjbOqtsvCinc9G/d2mN/D2BPvETEkvP1LxX
 Ihdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742824467; x=1743429267;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QyyBGBZmKNXHzFHuKyQZqACMIbfxCHqLM4zhB4ADgn0=;
 b=MwK3GOWobUyd3Ob81DbziTGp0aqpgQDWxywg9sTGkuuz5lXgfOQO4f1Kh6CgeVQRhp
 W4WCQmhRPkeOrRDq4n89yKB1XjYJkWfblEi5Lriz8tfN3LVGpPCJJkCpwq0OyDhiEWOX
 R4P+ccVtf+raLidxDvLhbvlrZN9xaBcsJfYVu9ogGB9cjIKAe4/Z+L6uACORFeeDgPBt
 CfcmcojaYc+sKLXFO8QZF5ZU/iwZPh1B1CCt+xzV17u/Kfon9e2d8+q7lZdiJaowQPXj
 fUgTwe2RdeFI+Zdqao+mW1BXQ7HjYAdJLkXaw2+IzVckjmcBZzGECyjgzME2GKe4ho9t
 Q9DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn6M0KoAjrRY9WRuRvZcjO6O/Sne1AV1CYclh2KUV7lI8jtOphSu8fEFuRRfAmbGezsm52/U417fCA@nongnu.org
X-Gm-Message-State: AOJu0YzcVYcW9ph4dMGTEmfJXe3qBI0KHYYAa9B3g2e4IiXFvwk1ndmu
 hKDaot31y+KApW/RRD85udUF5jeqOPVh6z5keJl69AqsVsiftH8n
X-Gm-Gg: ASbGncv8SRO7v78NrXnI6QRSiajm7tHEqE/cqljfzqtdxjjam02PWhAe3GARHxtch6f
 52+T1nGkVDeQYlmdNo9MGCY8VAMFoZQ9CqUeFS7cjlVO4kErLxCL2q35/pLd95rIabcx0vOF4eP
 B1zVbZ348tjWCn/+UW8lRUlRlxmY7L5WcnoWMquPbZiHH60L4Xlyy5troQMPvMr7I3cTnlBWgzL
 xOLrI28N8ulxBdJjRyWI1BI3hbJXjolC1Cz7FKO1R8XAdYFBFL8a23efxpU8BsG8OGmG7n8YFVY
 7er1c4nLBfIeqzMnlnYOwvP5ykHth6RpKDyhbEYIchdjy8k4lg8eWAp/m2ZWXWZio35vwadNOuy
 AkafSli99BEhf
X-Google-Smtp-Source: AGHT+IG+m9TNzUfeGl9Y4yqzcliKQRPG8A6ajWJ0WQhYm94p/F2i4B6rko825EO4qU4jKizHQJPRrg==
X-Received: by 2002:a05:6a00:808:b0:736:476b:fcd3 with SMTP id
 d2e1a72fcca58-73905a50278mr24597816b3a.24.1742824467184; 
 Mon, 24 Mar 2025 06:54:27 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d?
 ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390618dd29sm7886749b3a.167.2025.03.24.06.54.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 06:54:26 -0700 (PDT)
Message-ID: <a64c04c7-680f-403d-ad60-6a20876d56f9@gmail.com>
Date: Mon, 24 Mar 2025 19:24:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 0/5] Add packed virtqueue to shadow virtqueue
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
References: <20241205203430.76251-1-sahilcdq@proton.me>
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
 <a4dbfe72-853c-4eff-b2cb-90b363eee9c0@gmail.com>
 <CAJaqyWfV=7XyuXa-U1MvNkaaMg14616DSq0tHe4i-6-AkxFX=g@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWfV=7XyuXa-U1MvNkaaMg14616DSq0tHe4i-6-AkxFX=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x634.google.com
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

On 3/6/25 12:53 PM, Eugenio Perez Martin wrote:
> On Thu, Mar 6, 2025 at 6:26 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>> [...]
>> On 2/11/25 1:27 PM, Eugenio Perez Martin wrote:
>>> [...]
>>>> [   49.173243] watchdog: BUG: soft lockup - CPU#1 stuck for 25s! [NetworkManager:782]
>>>> [   49.174167] Modules linked in: rfkill intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core intel_vsec pmt_telemetry pmt_class kvg
>>>> [   49.188258] CPU: 1 PID: 782 Comm: NetworkManager Not tainted 6.8.7-200.fc39.x86_64 #1
>>>> [   49.193196] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>>>> [   49.193196] RIP: 0010:virtqueue_get_buf+0x0/0x20
>>>>
>>>
>>> Two possibilities about this part:
>>> a) You're spending "too long" in the debugger in QEMU. From the kernel
>>> POV, the function virtqueue_get_buf is taking too long to complete so
>>> it detects it as a lockup. You can check this scenario by not running
>>> QEMU under GDB or disabling all breakpoints. You can ignore this
>>> message if you don't find the error this way. If you still see the
>>> message, goto possibility b.
>>>
>>> b) The kernel has a bug that makes it softlockup in virtqueue_get_buf.
>>> The kernel should not soft lockup even if your changes were malicious
>>> :(, so it is something to be fixed. If you have the time, can you test
>>> with the latest upstream kernel?
>>
>> I wasn't running QEMU under GDB, so there may indeed be an issue in the
>> kernel. While I don't see a soft lockup at this exact point after making
>> the above described changes, I do see a soft lockup issue in another part
>> of virtio-net.
>>
>> When testing my implementation with the control feature bits turned on,
>> the kernel throws the following warning while booting.
>>
>> [    9.046478] net eth0: Failed to disable allmulti mode.
>>
>> This is printed as a dev_warn() in drivers/net/virtio_net.c:virtnet_rx_mode_work [1].
>> The kernel doesn't continue booting beyond this point and after a few seconds,
>> it reports a soft lockup.
>>
>>>> Maybe I was incorrect in stating that the kernel crashes. It's more like
>>>> the kernel is stuck in a loop (according to these blog posts on soft
>>>> lockup [1][2]).
>>>>
>>>> In the above trace, RIP is in virtqueue_get_buf() [3]. This is what
>>>> calls virtqueue_get_buf_ctx_packed() [4] which throws the error.
>>>>
>>>> What I don't understand is why vq->packed.desc_state[id].data [5] is
>>>> NULL when the control features are turned on, but doesn't seem to be
>>>> NULL when the control features are turned off.
>>>
>>> Due to the net subsystem lock, CVQ handling is not as robust / secure
>>> against this error as the dataplane queues. There is an ongoing effort
>>> to make it more robust, so maybe this is something to fix in that
>>> line.
>>>
>>> Can you put the whole backtrace that prints the kernel?
>>
>> I haven't tested these changes with the latest kernel yet. I think this would be
>> a good time to test against the latest kernel. I'll update my kernel.
>>
>> Here's the backtrace that is printed in the kernel that I currently have installed
>> (6.8.5-201.fc39.x86_64), in case this is relevant.
>>
>> [   65.214308] watchdog: BUG: soft lockup - CPU#0 stuck for 51s! [NetworkManage]
>> [   65.215933] Modules linked in: rfkill intel_rapl_msr intel_rapl_common intelg
>> [   65.238465] CPU: 0 PID: 784 Comm: NetworkManager Tainted: G             L   1
>> [   65.242530] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14
>> [   65.248474] RIP: 0010:virtnet_send_command+0x17c/0x1e0 [virtio_net]
>> [   65.251505] Code: 74 24 48 e8 f6 b1 40 c1 85 c0 78 60 48 8b 7b 08 e8 29 92 43
>> [   65.260475] RSP: 0018:ffffb8038073f298 EFLAGS: 00000246
>> [   65.260475] RAX: 0000000000000000 RBX: ffff8ea600f389c0 RCX: ffffb8038073f29c
>> [   65.265165] RDX: 0000000000008003 RSI: 0000000000000000 RDI: ffff8ea60cead300
>> [   65.269528] RBP: ffffb8038073f2c0 R08: 0000000000000001 R09: ffff8ea600f389c0
>> [   65.272532] R10: 0000000000000030 R11: 0000000000000002 R12: 0000000000000002
>> [   65.274483] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>> [   65.278518] FS:  00007f2dd66f2540(0000) GS:ffff8ea67bc00000(0000) knlGS:00000
>> [   65.280653] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   65.284492] CR2: 00005593d46e5868 CR3: 000000010d310001 CR4: 0000000000770ef0
>> [   65.286464] PKRU: 55555554
>> [   65.288524] Call Trace:
>> [   65.291470]  <IRQ>
>> [   65.291470]  ? watchdog_timer_fn+0x1e6/0x270
>> [   65.293464]  ? __pfx_watchdog_timer_fn+0x10/0x10
>> [   65.296496]  ? __hrtimer_run_queues+0x10f/0x2b0
>> [   65.297578]  ? hrtimer_interrupt+0xf8/0x230
>> [   65.300472]  ? __sysvec_apic_timer_interrupt+0x4d/0x140
>> [   65.301680]  ? sysvec_apic_timer_interrupt+0x6d/0x90
>> [   65.305464]  </IRQ>
>> [   65.305464]  <TASK>
>> [   65.305464]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
>> [   65.308705]  ? virtnet_send_command+0x17c/0x1e0 [virtio_net]
>> [   65.312466]  ? virtnet_send_command+0x176/0x1e0 [virtio_net]
>> [   65.314465]  virtnet_set_rx_mode+0xd8/0x340 [virtio_net]
>> [   65.317466]  __dev_mc_add+0x79/0x80
>> [   65.318462]  igmp_group_added+0x1f2/0x210
>> [   65.320541]  ____ip_mc_inc_group+0x15b/0x250
>> [   65.323522]  ip_mc_up+0x4f/0xb0
>> [   65.324491]  inetdev_event+0x27a/0x700
>> [   65.325469]  ? _raw_spin_unlock_irqrestore+0xe/0x40
>> [   65.329462]  notifier_call_chain+0x5a/0xd0
>> [   65.331717]  __dev_notify_flags+0x5c/0xf0
>> [   65.332491]  dev_change_flags+0x54/0x70
>> [   65.334508]  do_setlink+0x375/0x12d0
>> [   65.336554]  ? __nla_validate_parse+0x61/0xd50
>> [   65.338510]  __rtnl_newlink+0x668/0xa30
>> [   65.340733]  ? security_unix_may_send+0x21/0x50
>> [   65.342620]  rtnl_newlink+0x47/0x70
>> [   65.344556]  rtnetlink_rcv_msg+0x14f/0x3c0
>> [   65.346509]  ? avc_has_perm_noaudit+0x6b/0xf0
>> [   65.348470]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
>> [   65.350533]  netlink_rcv_skb+0x58/0x110
>> [   65.352482]  netlink_unicast+0x1a3/0x290
>> [   65.354547]  netlink_sendmsg+0x223/0x490
>> [   65.356480]  ____sys_sendmsg+0x396/0x3d0
>> [   65.357482]  ? copy_msghdr_from_user+0x7d/0xc0
>> [   65.360488]  ___sys_sendmsg+0x9a/0xe0
>> [   65.360488]  __sys_sendmsg+0x7a/0xd0
>> [   65.364591]  do_syscall_64+0x83/0x170
>> [   65.365485]  ? syscall_exit_to_user_mode+0x83/0x230
>> [   65.368475]  ? do_syscall_64+0x90/0x170
>> [   65.370477]  ? _raw_spin_unlock+0xe/0x30
>> [   65.372498]  ? proc_sys_call_handler+0xfc/0x2e0
>> [   65.374474]  ? kvm_clock_get_cycles+0x18/0x30
>> [   65.376475]  ? ktime_get_ts64+0x47/0xe0
>> [   65.378457]  ? posix_get_monotonic_timespec+0x65/0xa0
>> [   65.380535]  ? put_timespec64+0x3e/0x70
>> [   65.382458]  ? syscall_exit_to_user_mode+0x83/0x230
>> [   65.384542]  ? do_syscall_64+0x90/0x170
>> [   65.384542]  ? do_syscall_64+0x90/0x170
>> [   65.387505]  ? ksys_write+0xd8/0xf0
>> [   65.388670]  ? syscall_exit_to_user_mode+0x83/0x230
>> [   65.390522]  ? do_syscall_64+0x90/0x170
>> [   65.390522]  ? syscall_exit_to_user_mode+0x83/0x230
>> [   65.394472]  ? do_syscall_64+0x90/0x170
>> [   65.396532]  ? syscall_exit_to_user_mode+0x83/0x230
>> [   65.398519]  ? do_syscall_64+0x90/0x170
>> [   65.400486]  ? do_user_addr_fault+0x304/0x670
>> [   65.400486]  ? clear_bhb_loop+0x55/0xb0
>> [   65.404531]  ? clear_bhb_loop+0x55/0xb0
>> [   65.405471]  ? clear_bhb_loop+0x55/0xb0
>> [   65.408520]  entry_SYSCALL_64_after_hwframe+0x78/0x80
>> [   65.408520] RIP: 0033:0x7f2dd7810a1b
>> [   65.413467] Code: 48 89 e5 48 83 ec 20 89 55 ec 48 89 75 f0 89 7d f8 e8 09 3b
>> [   65.420593] RSP: 002b:00007ffcff6bd520 EFLAGS: 00000293 ORIG_RAX: 0000000000e
>> [   65.425554] RAX: ffffffffffffffda RBX: 00005593d4679a90 RCX: 00007f2dd7810a1b
>> [   65.428519] RDX: 0000000000000000 RSI: 00007ffcff6bd560 RDI: 000000000000000d
>> [   65.430509] RBP: 00007ffcff6bd540 R08: 0000000000000000 R09: 0000000000000000
>> [   65.434723] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000000a
>> [   65.438526] R13: 00005593d4679a90 R14: 0000000000000001 R15: 0000000000000000
>> [   65.440555]  </TASK>
>> [   71.028432] rcu: INFO: rcu_preempt self-detected stall on CPU
>> [   71.028432] rcu:     0-....: (1 GPs behind) idle=7764/1/0x4000000000000000 s9
>> [   71.036518] rcu:     (t=60010 jiffies g=2193 q=1947 ncpus=4)
>> [   71.041707] CPU: 0 PID: 784 Comm: NetworkManager Tainted: G             L   1
>> [   71.050455] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14
>> [   71.055661] RIP: 0010:virtnet_send_command+0x17c/0x1e0 [virtio_net]
>> [   71.059518] Code: 74 24 48 e8 f6 b1 40 c1 85 c0 78 60 48 8b 7b 08 e8 29 92 43
>> [   71.065526] RSP: 0018:ffffb8038073f298 EFLAGS: 00000246
>> [   71.067651] RAX: 0000000000000000 RBX: ffff8ea600f389c0 RCX: ffffb8038073f29c
>> [   71.069472] RDX: 0000000000008003 RSI: 0000000000000000 RDI: ffff8ea60cead300
>> [   71.071461] RBP: ffffb8038073f2c0 R08: 0000000000000001 R09: ffff8ea600f389c0
>> [   71.075455] R10: 0000000000000030 R11: 0000000000000002 R12: 0000000000000002
>> [   71.078461] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>> [   71.079579] FS:  00007f2dd66f2540(0000) GS:ffff8ea67bc00000(0000) knlGS:00000
>> [   71.083577] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   71.083577] CR2: 00005593d46e5868 CR3: 000000010d310001 CR4: 0000000000770ef0
>> [   71.087582] PKRU: 55555554
>> [   71.090472] Call Trace:
>> [   71.091452]  <IRQ>
>> [   71.091452]  ? rcu_dump_cpu_stacks+0xc4/0x100
>> [   71.095487]  ? rcu_sched_clock_irq+0x32e/0x1040
>> [   71.095487]  ? task_tick_fair+0x40/0x3f0
>> [   71.100466]  ? trigger_load_balance+0x73/0x360
>> [   71.100466]  ? update_process_times+0x74/0xb0
>> [   71.103539]  ? tick_sched_handle+0x21/0x60
>> [   71.107494]  ? tick_nohz_highres_handler+0x6f/0x90
>> [   71.107572]  ? __pfx_tick_nohz_highres_handler+0x10/0x10
>> [   71.111477]  ? __hrtimer_run_queues+0x10f/0x2b0
>> [   71.111477]  ? hrtimer_interrupt+0xf8/0x230
>> [   71.116489]  ? __sysvec_apic_timer_interrupt+0x4d/0x140
>> [   71.119526]  ? sysvec_apic_timer_interrupt+0x6d/0x90
>> [   71.119526]  </IRQ>
>> [   71.124489]  <TASK>
>> [   71.124489]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
>> [   71.127499]  ? virtnet_send_command+0x17c/0x1e0 [virtio_net]
>> [   71.127499]  ? virtnet_send_command+0x176/0x1e0 [virtio_net]
>> [   71.132613]  virtnet_set_rx_mode+0xd8/0x340 [virtio_net]
>> [   71.136474]  __dev_mc_add+0x79/0x80
>> [   71.136474]  igmp_group_added+0x1f2/0x210
>> [   71.139469]  ____ip_mc_inc_group+0x15b/0x250
>> [   71.140473]  ip_mc_up+0x4f/0xb0
>> [   71.143492]  inetdev_event+0x27a/0x700
>> [   71.144486]  ? _raw_spin_unlock_irqrestore+0xe/0x40
>> [   71.147600]  notifier_call_chain+0x5a/0xd0
>> [   71.148918]  __dev_notify_flags+0x5c/0xf0
>> [   71.151634]  dev_change_flags+0x54/0x70
>> [   71.153529]  do_setlink+0x375/0x12d0
>> [   71.155476]  ? __nla_validate_parse+0x61/0xd50
>> [   71.157541]  __rtnl_newlink+0x668/0xa30
>> [   71.159503]  ? security_unix_may_send+0x21/0x50
>> [   71.161954]  rtnl_newlink+0x47/0x70
>> [   71.163680]  rtnetlink_rcv_msg+0x14f/0x3c0
>> [   71.165468]  ? avc_has_perm_noaudit+0x6b/0xf0
>> [   71.167506]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
>> [   71.170499]  netlink_rcv_skb+0x58/0x110
>> [   71.171461]  netlink_unicast+0x1a3/0x290
>> [   71.174477]  netlink_sendmsg+0x223/0x490
>> [   71.175472]  ____sys_sendmsg+0x396/0x3d0
>> [   71.175472]  ? copy_msghdr_from_user+0x7d/0xc0
>> [   71.179465]  ___sys_sendmsg+0x9a/0xe0
>> [   71.179465]  __sys_sendmsg+0x7a/0xd0
>> [   71.182526]  do_syscall_64+0x83/0x170
>> [   71.183522]  ? syscall_exit_to_user_mode+0x83/0x230
>> [   71.183522]  ? do_syscall_64+0x90/0x170
>> [   71.187502]  ? _raw_spin_unlock+0xe/0x30
>> [   71.187502]  ? proc_sys_call_handler+0xfc/0x2e0
>> [   71.191500]  ? kvm_clock_get_cycles+0x18/0x30
>> [   71.191500]  ? ktime_get_ts64+0x47/0xe0
>> [   71.195472]  ? posix_get_monotonic_timespec+0x65/0xa0
>> [   71.195472]  ? put_timespec64+0x3e/0x70
>> [   71.198593]  ? syscall_exit_to_user_mode+0x83/0x230
>> [   71.199571]  ? do_syscall_64+0x90/0x170
>> [   71.202457]  ? do_syscall_64+0x90/0x170
>> [   71.203463]  ? ksys_write+0xd8/0xf0
>> [   71.203463]  ? syscall_exit_to_user_mode+0x83/0x230
>> [   71.207464]  ? do_syscall_64+0x90/0x170
>> [   71.207464]  ? syscall_exit_to_user_mode+0x83/0x230
>> [   71.211460]  ? do_syscall_64+0x90/0x170
>> [   71.211460]  ? syscall_exit_to_user_mode+0x83/0x230
>> [   71.211460]  ? do_syscall_64+0x90/0x170
>> [   71.216481]  ? do_user_addr_fault+0x304/0x670
>> [   71.216481]  ? clear_bhb_loop+0x55/0xb0
>> [   71.220472]  ? clear_bhb_loop+0x55/0xb0
>> [   71.220472]  ? clear_bhb_loop+0x55/0xb0
>> [   71.223704]  entry_SYSCALL_64_after_hwframe+0x78/0x80
>> [   71.225564] RIP: 0033:0x7f2dd7810a1b
>> [   71.227495] Code: 48 89 e5 48 83 ec 20 89 55 ec 48 89 75 f0 89 7d f8 e8 09 3b
>> [   71.235475] RSP: 002b:00007ffcff6bd520 EFLAGS: 00000293 ORIG_RAX: 0000000000e
>> [   71.239515] RAX: ffffffffffffffda RBX: 00005593d4679a90 RCX: 00007f2dd7810a1b
>> [   71.241643] RDX: 0000000000000000 RSI: 00007ffcff6bd560 RDI: 000000000000000d
>> [   71.245469] RBP: 00007ffcff6bd540 R08: 0000000000000000 R09: 0000000000000000
>> [   71.247467] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000000a
>> [   71.251479] R13: 00005593d4679a90 R14: 0000000000000001 R15: 0000000000000000
>> [   71.251479]  </TASK>
>>
> 
> Yes, the kernel does softlock waiting for a reply if the CVQ does not
> move forward. This is a known issue that is being fixed, but it is not
> easy :). To achieve the packed vq support, we can either disable CVQ
> entirely or try to process the message the kernel is trying to send.
> Both approaches come down to the same functions in SVQ, so you can
> pick the one you feel more comfortable :).

I would like to start with disabling the CVQ altogether. The data plane
implementation is still giving a problem as described below. Once that
is resolved, it should be easier to handle the CVQ.

>> When I test my changes with the control feature bits turned off, I see another
>> issue. The kernel boots successfully in this case, but I noticed that no new
>> elements in the dataplane are added to the virtqueue. This is because, in
>> hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_translate_addr() [2], when gpas
>> is not null and QEMU tries to retrieve the IOVA address from the GPA->IOVA
>> tree, the result of map is NULL in the following line [3]:
>>
>> map = vhost_iova_tree_find_gpa(svq->iova_tree, &needle)
>>
>> Due to this, vhost_svq_vring_write_descs() [4] simply returns false and nothing
>> is added to the virtqueue.
>>
>> This issue is present even for split virtqueues, when I test my changes with
>> "packed=off". However, I don't see any issues when I build QEMU from the master
>> branch. I think the issue might lie in how memory is being allocated to the
>> virtqueues in my implementation, but I am not sure. I have a few ideas regarding
>> how this can be debugged. I'll let you know if I find anything else.
>>
> 
> Understood! In case you run out of ideas, it seems like a good
> candidate for bisection.
> 
> Thanks for the update!
> 

I managed to make some progress. I am no longer having problems with this.
I am facing a new issue though and this issue does not arise everytime.

When testing the current state of my changes, I am able to ping L0 from L2
and vice versa via packed vqs. Unfortunately, this does not work everytime.

I thought I would send a new patch series for review in case I have missed
something.

I have explained the issue in greater detail in the cover letter.

Thanks,
Sahil

