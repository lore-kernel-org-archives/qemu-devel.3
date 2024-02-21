Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9E0C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoam-0001sx-Ox; Wed, 21 Feb 2024 10:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rcoU6-00011I-DW
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:26:12 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rclFu-0001hF-Vz
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 06:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SdrpIFjDFnDlqh1n6qGojGd8iD/1fx4+Nqk5dVrq9C8=; b=JJycK0PRFvCnbDk76MRNDkE30I
 yvolb1LjXQKEkNi9xZqDo6ZeydRmlNHDCK9ohqz0F6uBNTKjuHZR5MxFH1CiSLZT5Cc4zLeooYN/o
 kme0ePqiOzHm8wcQpshpvy2ruluOtCg4F3/UgF0fC7qo8nJBvOlf6l/QY/mHXM16ezE5liUdWD+8o
 i81d5uu5OB3c4udCBA3IBe/pOJ0FQu4/sPapLZD2VzmlaM4Tuu4jwnjfPRc3Fb4YLVcOe3QkcM3w7
 KDGQCVa1ZLDlrGtOWQPgyTAHwNF+PbEtNZY4hVdcfypC46NhAJu6RSE1QWtY/8Zq/a0mCL1lRqwRr
 RTdSS2eI+Zp3w6yLL7GdDhZ194BWKzW8qNy0IYaI9sM87lrFHOiGR8AlDNdZfBShXinJh6JE8j3Vu
 WvpvyykibbFKxs4mpMAeoFg1bi27koArN+JhJfZAnbd2nlHP+gbXkFuBTtxuKi18xSoXsruJHQruY
 W1dpwIn5z+u4UQ0/xA575ASeH1IGTdCFofsSNkLf8u9/mDXRq+qRazwdGWkIQW8W4G5xUkSEyugFM
 noM9aF9SDw0C2/g8wfeyIMzplpXNtHuLKHkb4Tc3JF1ZBdQZhuqiu5gQBnOW2KOQKnAhyVhSH570V
 8Gge7VEvlhbDhI0DcPsbwbUDoDFlTVs6onX1UIC1M=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rclF8-0008P4-7B; Wed, 21 Feb 2024 11:58:34 +0000
Message-ID: <61d6f47c-1618-4509-91de-328cc5428a63@ilande.co.uk>
Date: Wed, 21 Feb 2024 11:59:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20240220160622.114437-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 00/10] reset: Make whole system three-phase-reset aware
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 20/02/2024 16:06, Peter Maydell wrote:

> This patchset is an incremental improvement to our reset handling that
> tries to roll out the "three-phase-reset" design we have for devices
> to a wider scope.
> 
> At the moment devices and buses have a three-phase reset system, with
> separate 'enter', 'hold' and 'exit' phases. When the qbus tree is
> reset, first all the devices on it have their 'enter' method called,
> then they all have 'enter' called, and finally 'exit'. The idea is
> that we can use this, among other things, as a way to resolve annoying
> "this bit of reset work needs to happen before this other bit of reset
> work" ordering issues.
> 
> However, there is still a "legacy" reset option, where you register a
> callback function with qemu_register_reset(). These functions know
> nothing about the three-phase system, and "reset the qbus" is just one
> of the things set up to happen at reset via qemu_register_reset().
> That means that a qemu_register_reset() function might happen before
> all the enter/hold/exit phases of device reset, or it might happen after
> all of them.
> 
> This patchset provides a new way to register a three-phase-aware reset
> in this list of "reset the whole system" actions, and reimplements
> qemu_register_reset() in terms of that new mechanism. This means that
> qemu_register_reset() functions are now all called in the 'hold' phase
> of system reset. (This is an ordering change, so in theory it could
> introduce new bugs if we are accidentally depending on the current
> ordering; but we have very few enter and exit phase methods at the
> moment so I don't expect much trouble, if any.)
> 
> The first three patches remove the only two places in the codebase
> that rely on "a reset callback can unregister itself within the
> callback"; this is awkward to continue to support in the new
> implementation, and an unusual thing to do given that reset is in
> principle supposed to be something you can do as many times as you
> like, not something that behaves differently the first time through.
> 
> Patch 4 is an improvement to the QOM macros that's been on list as an
> RFC already.
> Patches 5 and 6 are the "new mechanism": qemu_register_resettable()
> takes any object that implements the Resettable interface. System
> reset is then doing 3-phase reset on all of these, so everything
> gets its 'enter' phase called, then everything gets 'hold', then
> everything gets 'exit'.
> 
> Patch 7 reimplements the qemu_register_reset() API to be
> "qemu_register_resettable(), and the callback function is called
> in the 'hold' phase".
> 
> Patch 8 makes the first real use of the new API: instead of
> doing the qbus reset via qemu_register_reset(), we pass the
> root of the qbus to qemu_register_resettable(). (This is where
> the ordering change I mention above happens, as device enter and
> exit method calls will now happen before and after all the
> qemu_register_reset() function callbacks, rather than in the
> middle of them.)
> 
> Finally, patch 9 updates the developer docs to describe how a
> complete system reset currently works.
> 
> This series doesn't actually do a great deal as it stands, but I
> think it's a necessary foundation for some cleanups:
>   * the vfio reset ordering problem discussed on list a while back
>     should now hopefully be solvable by having the vfio code use
>     qemu_register_resettable() so it can arrange to do the "needs to
>     happen last" stuff in an exit phase method
>   * there are some other missing pieces here, but eventually I think
>     it should be possible to get rid of the workarounds for
>     dependencies between ROM image loading and CPUs that want to
>     read an initial PC/SP on reset (eg arm, m68k)

Absolutely, this would definitely help with m68k :)

> I also think it's a good idea to get it into the tree so that we
> have a chance to see if there are any unexpected regressions
> before we start putting in bugfixes etc that depend on it :-)
> 
> After this, I think the next thing I'm going to look at is whether
> we can move the MachineState class from inheriting from TYPE_OBJECT
> to TYPE_DEVICE. This would allow us to have machine-level reset
> (and would bring "machine as a container of devices" into line
> with "SoC object as container of devices").

This would be really useful! In particular, moving MachineState to inherit from 
TYPE_DEVICE will allow setting MemoryRegion owners to the machine itself for 
arbitrary registers implemented by the board.

> thanks
> -- PMM
> 
> Peter Maydell (10):
>    hw/i386: Store pointers to IDE buses in PCMachineState
>    hw/i386/pc: Do pc_cmos_init_late() from pc_machine_done()
>    system/bootdevice: Don't unregister reset handler in
>      restore_boot_order()
>    include/qom/object.h: New OBJECT_DEFINE_SIMPLE_TYPE{,_WITH_INTERFACES}
>      macros
>    hw/core: Add documentation and license comments to reset.h
>    hw/core: Add ResetContainer which holds objects implementing
>      Resettable
>    hw/core/reset: Add qemu_{register,unregister}_resettable()
>    hw/core/reset: Implement qemu_register_reset via
>      qemu_register_resettable
>    hw/core/machine: Use qemu_register_resettable for sysbus reset
>    docs/devel/reset: Update to discuss system reset
> 
>   MAINTAINERS                      |  10 ++
>   docs/devel/qom.rst               |  34 ++++++-
>   docs/devel/reset.rst             |  44 +++++++-
>   include/hw/core/resetcontainer.h |  48 +++++++++
>   include/hw/i386/pc.h             |   4 +-
>   include/qom/object.h             | 114 ++++++++++++++++-----
>   include/sysemu/reset.h           | 113 +++++++++++++++++++++
>   hw/core/machine.c                |   7 +-
>   hw/core/reset.c                  | 166 +++++++++++++++++++++++++------
>   hw/core/resetcontainer.c         |  76 ++++++++++++++
>   hw/i386/pc.c                     |  40 +++-----
>   hw/i386/pc_piix.c                |  16 ++-
>   hw/i386/pc_q35.c                 |   9 +-
>   system/bootdevice.c              |  25 +++--
>   hw/core/meson.build              |   1 +
>   15 files changed, 587 insertions(+), 120 deletions(-)
>   create mode 100644 include/hw/core/resetcontainer.h
>   create mode 100644 hw/core/resetcontainer.c


ATB,

Mark.


