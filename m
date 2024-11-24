Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A9FE668A0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 06:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tF6Rr-0003xU-A5; Sun, 24 Nov 2024 01:50:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tF6Rp-0003xL-SQ
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 01:50:21 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tF6Ro-0002pJ-0r
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 01:50:21 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so30417305e9.3
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 22:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732431018; x=1733035818; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3tl1RfzhKiosCDYuQbMUGd0pD2indYWZvbdIFjc7LZY=;
 b=ZaxC5AUSYM80FPgg1Mb9X213WfSg4dazVcEFQT0aW9Yr2XGNVizpihhAqrJhDA9mop
 Atb4vu6TlW4gWExvf1lAPin2oSG4t9dR+1+IpgjDeF8KlwdktBlKbTsztebyu6H9g55G
 +8TSvdY1z4ki99KKfDpONiMORwf09kQ6+70ukwY4ivbC/hTDoadxf+jfjSr8iXd7gp16
 gIZ63GFfDA4ZR3eTSeqRPFNgwKtu8FjvfJ4cAZwUkXnTTeO5AhWr/wzzsKhIWFttKBsR
 STHu5bS6NUikilSAgauKv7yzk6U5/XJIa6RbzQBGMg/VNmgKnSi/TbD8SdLZVQ5WAsKZ
 w9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732431018; x=1733035818;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tl1RfzhKiosCDYuQbMUGd0pD2indYWZvbdIFjc7LZY=;
 b=eFBmM1OffFibUXvKoFzwWs8HK31lR5omYeILKdJycJDglPwEVoGMWt3xmwAD5e24Qy
 A2VP1OUCk1vuK9kxCgxONQHWtgTHyP3/4fPZppsADGDv7pz4fI59/LP+19dy5APlqgkp
 YcMHyKpX7I/lWNJJA3cxsMp+p1wSjb1caShEFBKA2AmDVcXnQCqaayWhvy5zrJXoDiSm
 ITepN/bibG4pn/3tTgT1/nV7EmCdehs0jmrsWYkGAHgB80OsXt2aQCjwOBcVgwht92YO
 qSMZYsl/fS0BRrxpUpc0Ckv4w8E/Idn3ujC1iT8eASYRf5TOJZFtRiRAS67GjLwmhScW
 zBFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRplQaKW/tA6Ug3DNTFJf5m/kURSVXdEgWgz70QFpc3waMUdbK2apGYUOuLByAKBdtV+WRd1x+Y7AV@nongnu.org
X-Gm-Message-State: AOJu0YxfUXVfNQ61llwwEv2PjuCIJKhlAZ2V1br/atMdLMItpHr0dqMG
 5Rla811pD2HTB1fRpjWfJ5qUFqVVGONg5lniTNZ50v6aKXGvovP/
X-Gm-Gg: ASbGncuWo6JaaaMh1EcDGFdmVxD8Pb+apfpb+X0jDdZVHsyziq44Am6Xg3RLXgR5TIQ
 fo3eSGOUZ5hqgG3W1BundopFF5/+Pko/SlGGlZ69vtZ3WIdgW7Rxjr5/h2Qw6cretZdnIIbSrR8
 5tMkonoe2WpAambGCwN3F7MbIiVQnYCBM5jTEJjQX1CR6fe0IsWg/8EjzUXOcnXrxZJ9uIWz3FT
 hXAAKu1Xa/LXEcIbayZojfGsg86pfU/zOTr/W4Yn9Qkel+P3I0Gtfy0hSjE/wi99PsDpqyyqtsE
 n66hV7osqVvB9A==
X-Google-Smtp-Source: AGHT+IGnQNOyEYE98fjrxkvgsyNQaSErLFAbNIszj3JBQzVaNQ9FzIPxipUe/ogih58Zqm2Tq3i0lQ==
X-Received: by 2002:a05:600c:1986:b0:434:942c:1466 with SMTP id
 5b1f17b1804b1-434942c17eamr21490085e9.29.1732431017930; 
 Sat, 23 Nov 2024 22:50:17 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde8fcdfsm82300775e9.32.2024.11.23.22.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Nov 2024 22:50:16 -0800 (PST)
Date: Sun, 24 Nov 2024 06:50:16 +0000
From: Stafford Horne <shorne@gmail.com>
To: Rob Landley <rob@landley.net>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: QEMU commit 0a923be2f642 broke my or1k image.
Message-ID: <Z0LMqEqcdjkAxnN-@antec>
References: <afac091f-08cb-0f6d-4c01-bfa4421e7a47@landley.net>
 <Zufcf4iAqosZ7VBf@antec>
 <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec>
 <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec>
 <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x343.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On Sat, Nov 23, 2024 at 11:18:53PM -0600, Rob Landley wrote:
...
> I'm attempting to regression test as many targets as I can to get consistent
> basic behavior out of:
> 
>   https://landley.net/bin/mkroot/0.8.11/
> 
> I'm trying to get a new release out with the 6.12 kernel which is why I'm
> revisiting this now.
> 
> I've even got a test script that runs all the targets under qemu (booting
> them in parallel even) and checks that A) they boot and run userspace, B)
> they can talk to an emulated hard disk, C) they can talk to an emulated
> network, D) the clock gets set reasonably, E) it knows how to exit the
> emulator. You'd be surprised how many regressions there are in just that...
> 
> Speaking of which, is there a way to get or1k to exit the emulator? I told
> the kernel to reboot but it says "reboot failed, system halted" and hangs
> instead of exiting qemu. (My testroot runs qemu under "timeout -i 10" to
> kill it after 10 seconds of inactivity, I.E. nothing written to stdout, but
> it still counts as a failure on one of the criteria.)

With the or1k-sim board it is not possible.  Traditionally on or1k we use
special NOP instructions to reboot simulators i.e. 'l.nop 1'.  The QEMU team was
not happy to support this mechanism.

  https://lore.kernel.org/openrisc/fb69c137317a365dcb549dfef1ecd2fbff48e92c.1492384862.git.shorne@gmail.com/T/#mef76d30d294aed84548b1e0d3e23aae499deaeec

As an alertnative we can use the 'virt' board which supports shutdown and
restart via the generic syscon drivers.

    $ grep -C1 SYSCON arch/openrisc/configs/virt_defconfig
    CONFIG_POWER_RESET=y
    CONFIG_POWER_RESET_SYSCON=y
    CONFIG_POWER_RESET_SYSCON_POWEROFF=y
    CONFIG_SYSCON_REBOOT_MODE=y
    # CONFIG_HWMON is not set

> > > > Note, I did find some issues with the kernel nor properly handling stdout-path.
> > > > It seems that if there are multiple uarts the first one will always be used as
> > > > the default uart.  Only the console= command line argument can be used to
> > > > override that.
> > > 
> > > I've never managed to get console= to go through to linux in
> > > qemu-system-or1k. The above tries but is ignored.
> > 
> > As I mentioned above this is a good clue and explains why the alignment "fix"
> > fixes your issue.
> 
> Happy to do it properly. Almost all the other targets can do console=, the
> FIXME was there to highlight the fact it didn't work right. (Silently
> working for the WRONG REASON is still bad when regression testing.)
> 
> > > It's also doing a statically linked initramfs because -initrd didn't work on
> > > this target. Happy to update if it's been fixed, the other targets are
> > > almost all using -initrd to feed in an external cpio.gz
> > 
> > Using -initrd should work.  But also using the statically linked initramfs
> > should be fine too.  The setup I use for testing uses virt with a virtio block
> > driver.
> 
> Most of the other targets _don't_ use builtin initramfs, so you can swap
> them out "aftermarket" as it were. When it's separate you can examine and
> edit the contents without rebuilding the kernel...
> 
> > When using qemu with -initrd qemu will back the kernel, initrd and fdt one after
> > the other into memory as per.
> > 
> > [ kernel ] - Loads from 0x100 (based on elf layout)
> > [ initrd ] - page aligned
> > [  fdt   ] - page aligned devicetree (revert moved to 4 bytes aligned)
> > 
> > The fdt address gets placed into r3 which the kernel uses to find the qemu FDT.
> > Finding the FDT one of the first steps of the boot processes.
> 
> I updated my mkroot config:
> 
>   https://github.com/landley/toybox/commit/fb3ca98e2faa
> 
> I.E. changed the FIXME to ttyS0, removed BUILTIN=1 so it's no longer
> statically linking the initramfs image, and yanked the builtin DTB, and the
> result works with v9.2.0-rc1.
> 
> Still doesn't know how to exit qemu, though. (Is there a kernel symbol I can
> add to 6.12, or does qemu still not have an exit mechanism for this board
> yet?)
> 
> (FYI: be2csv is a shell function to convert bash's brace expansion syntax to
> a comma separated value list, and then csv2cfg is another shell function
> that turns the CSV into https://lwn.net/Articles/160497/ . The CSV is
> shipped as docs/linux-microconfig in the tarball if you're curious. That's
> how a 400 line bash script can build a Linux system that boots to a shell
> prompt for a dozen architectures. The or1k config is now 2 lines, for
> example. 3 with the "if or1k" check. The variables it assigns to are
> documented around line 190.)

That looks good. I need to work on getting my integration testing better, Ill
look into your tools for that.

-Stafford

