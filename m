Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BD8C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 11:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzZdN-000405-3x; Tue, 01 Apr 2025 07:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzZdJ-0003zn-0V
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:18:18 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzZdG-0005K8-Cp
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:18:16 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso5220972f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 04:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743506292; x=1744111092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZgURhMoGxQZudscYIEFxhqkfmGobPH7r04OwanQmpoo=;
 b=xFlKcLGdF1RyZUubomq8B9o+bBfdnjZU9w2z4fSy7KOfnIyv2MWv6efirWZ+I4wsFt
 jtPtDJb4WKH3PGt0hpAXfmgrbsF4ng2B3bVBO6sJDoKuJLFTMN6Elygt7CwxqUS2K1DH
 bR93azcUsk95nt2bofovOUQWt5+lXbCoXuWKKfW8f5h0qGC77qwe8Y482OgADMLTlYa7
 2igKKp52yKHVTsk4a0weu+Hav29wk+higbxEilAsWrSVpEaWM+fsNq797fjqeNLsClGv
 X6qYb1UhO3sF8/vZWa6DKTfEHa/Mp++B/uzyZdvmYaccocb1/nk2bE54Pv4gCIBldByP
 su9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743506292; x=1744111092;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZgURhMoGxQZudscYIEFxhqkfmGobPH7r04OwanQmpoo=;
 b=NI1N0GgxoZtMeHz2MYT7OFLMutTmCVWcBh3VykP+/+UQz6+H8r5Z6vtaB6IsWMyo0T
 mc7bxSXe6wlfdU6lZXP0k3IuPhY5ENHfPud8RS3xs450Pn2myTb/GcCU8638VZHdBOfE
 TJEVsyqRJjlwThRoGcarS7lMuBABruzj3MC7re3tQSPUH8KBMMzDUmRjOXS3mXqJxRIA
 LQRWw9i+dNj07N5gBZoIkYATN6CT6jEcHE/Ivjqc7i0TZ+GcMf9VRyYI3oRfwiKg1VAe
 eY3KwVSMXXXniZO2VUqjIX3sOMSusMN6iYPr3Q2Npl95zSey2Z5O+BAjcfn4o+vbF7h+
 BC0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+JayCWlwRVdkCzDdxmLhSrDFoxeJuxLuwewQzmqwR/b0dnqbSPMC2gyToSXvjSgo3jT1P8H7U6D+s@nongnu.org
X-Gm-Message-State: AOJu0Ywhm7RKz0JxCKMdApzIP+gnrrXoZpn2XB+sXX0XVp65woPlLrDy
 yQXWitOryxzeQHn2CCdMocyY5gLtWnuTkLgfTMc/ZrD3SI0mEel80HriPMADyKfXe1gCEb2p/hb
 L
X-Gm-Gg: ASbGncvp1TP9qns4AMXUqdkcl35Dm9u4oY9Sz3wPiveIZmX6OQnlXidAoShIbK+PpF4
 S1XIBW5MUzcD8dU0ILoS74sfHMimTaPhf9BhF5chyXNmdp4NSPu7npiSDeCbaEbV2i7cKkbAzTB
 /vcz8yfIcaQGZoySwzvLq+mlQ9OWxvctk8mYFn6UHJ1fMu0ACifjBdZtzh/tISEa8NL/vDczCwk
 158Gs37XyMSfrCnQpjEV3IIMAlALwewnVExV/M839BW6OJbl5hnIzXZYq51iVaCKVXLYBdOaTOs
 tIaiqCOCmvi5sPWxgBUKbNrApXUN0uPtnOZROMTqu7+q0SpzEq5iTZc3b7CcbGVJ+brdj7FdR7k
 VOCOENjjYcXpC
X-Google-Smtp-Source: AGHT+IEOKJlAX1BTfsz50AQVWMpS2mlEni2FyS1BQsOUAm38yR2emxkULnc4mi0u7CQQms0t0rS+RA==
X-Received: by 2002:a5d:59a6:0:b0:39c:dfa:c92a with SMTP id
 ffacd0b85a97d-39c12118ddfmr9863235f8f.36.1743506292326; 
 Tue, 01 Apr 2025 04:18:12 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b658ab2sm13993685f8f.15.2025.04.01.04.18.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 04:18:11 -0700 (PDT)
Message-ID: <3e8e7649-2ee3-4e72-9cd6-17db0551ea66@linaro.org>
Date: Tue, 1 Apr 2025 13:18:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 23/29] ui & main loop: Redesign of system-specific main
 thread event handling
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20241231202228.28819-1-philmd@linaro.org>
 <20241231202228.28819-24-philmd@linaro.org>
 <61ae31ca4643b2caf703a36cebe5ed4f2abbf324.camel@infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <61ae31ca4643b2caf703a36cebe5ed4f2abbf324.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi David,

On 8/1/25 14:51, David Woodhouse wrote:
> On Tue, 2024-12-31 at 21:22 +0100, Philippe Mathieu-Daudé wrote:
>>
>> This change tidies up main thread management to be more flexible.
>>
>>   * The qemu_main global function pointer is a custom function for the
>>     main thread, and it may now be NULL. When it is, the main thread
>>     runs the main Qemu loop. This represents the traditional setup.
>>   * When non-null, spawning the main Qemu event loop on a separate
>>     thread is now done centrally rather than inside the Cocoa UI code.
>>   * For most platforms, qemu_main is indeed NULL by default, but on
>>     Darwin, it defaults to a function that runs the CFRunLoop.
>>   * The Cocoa UI sets qemu_main to a function which runs the
>>     NSApplication event handling runloop, as is usual for a Cocoa app.
>>   * The SDL UI overrides the qemu_main function to NULL, thus
>>     specifying that Qemu's main loop must run on the main
>>     thread.
>>   * The GTK UI also overrides the qemu_main function to NULL.
>>   * For other UIs, or in the absence of UIs, the platform's default
>>     behaviour is followed.
> 
> When exiting an emulated Xen guest with <Ctrl-a x> on the console, I
> now see:
> 
> (gdb) run
> Starting program: /home/dwmw2/git/qemu/ball/qemu-system-x86_64 -display none -vga none -serial mon:stdio -machine q35 -accel kvm,xen-version=0x4000a,kernel-irqchip=split -smp 2 -kernel /home/dwmw2/avocado/data/cache/by_name/bzImage -append printk.time=0\ root=/dev/xvda\ console=ttyS0\ xen_emul_unplug=ide-disks\ xen_no_vector_callback\ noapic\ loglevel=0 -drive file=/home/dwmw2/avocado/data/cache/by_name/rootfs.ext4,if=none,snapshot=on,format=raw,id=drv0 -device xen-disk,drive=drv0,vdev=xvda -device virtio-net-pci,netdev=unet -netdev user,id=unet,hostfwd=:127.0.0.1:0-:22
> 
> Starting syslogd: OK
> Starting klogd: OK
> Running sysctl: OK
> Saving 256 bits of non-creditable seed for next boot
> Starting network: OK
> Starting dhcpcd...
> no such user dhcpcd
> dhcpcd-9.4.1 starting
> no interfaces have a carrier
> forked to background, child pid 111
> Starting dropbear sshd: OK
> #
> QEMU: Terminated
> qemu-system-x86_64: ../block/block-backend.c:1290: blk_in_drain: Assertion `qemu_in_main_thread()' failed.
> 
> Thread 1 "qemu-system-x86" received signal SIGABRT, Aborted.
> 0x00007ffff5ffc724 in __pthread_kill_implementation () from /lib64/libc.so.6
> (gdb) bt
> #0  0x00007ffff5ffc724 in __pthread_kill_implementation () at /lib64/libc.so.6
> #1  0x00007ffff5fa3d1e in raise () at /lib64/libc.so.6
> #2  0x00007ffff5f8b942 in abort () at /lib64/libc.so.6
> #3  0x00007ffff5f8b85e in __assert_fail_base.cold () at /lib64/libc.so.6
> #4  0x00007ffff5f9be47 in __assert_fail () at /lib64/libc.so.6
> #5  0x0000555555abf911 in blk_in_drain (blk=0x555557ca6680)
>      at ../block/block-backend.c:1290
> #6  0x000055555593410c in xen_block_dataplane_stop (dataplane=0x555558982950)
>      at ../hw/block/dataplane/xen-block.c:695
> #7  0x000055555593441a in xen_block_dataplane_stop (dataplane=<optimized out>)
>      at ../hw/block/dataplane/xen-block.c:689
> #8  0x00005555555dfd5e in xen_block_disconnect
>      (xendev=xendev@entry=0x55555880aa60, errp=<optimized out>)
>      at ../hw/block/xen-block.c:172
> #9  0x00005555555dfeca in xen_block_unrealize (xendev=0x55555880aa60)
>      at ../hw/block/xen-block.c:282
> #10 0x000055555578ef71 in xen_device_unrealize (dev=<optimized out>)
>      at ../hw/xen/xen-bus.c:978
> #11 0x0000555555bfe65f in notifier_list_notify (list=<optimized out>, data=0x0)
>      at ../util/notify.c:39
> #12 0x00007ffff5fa6461 in __run_exit_handlers () at /lib64/libc.so.6
> #13 0x00007ffff5fa652e in exit () at /lib64/libc.so.6
> #14 0x0000555555b523dc in qemu_default_main (opaque=opaque@entry=0x0)
> #15 0x00005555555609c0 in main (argc=<optimized out>, argv=<optimized out>) at ../system/main.c:76
> 

Is this still an issue?

