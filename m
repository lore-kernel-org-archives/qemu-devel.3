Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5061CD5BD0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 16:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smExS-00082V-KU; Thu, 05 Sep 2024 12:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1smEwy-0007lX-KO
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:03:16 -0400
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1smEwv-0004rJ-1G
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1725552184; bh=dxdoE+Tc69+QIWnRgHImPXkCDL2I7LUw0KJGtL4nNOo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GFrTHFeEIgyFKXRi3Fk+VbCAleTAzFk68KT5e6YKmmqVzxLQtYguti0fUUqD3m2Hf
 SLsFMzZruLmV7xlvNUwGMACKScw07jR3DClTzkSvl05JiH5XubgBVumxANN0v1Ts+2
 0rYOLVm38nXXEXo7CUEtOVekUbx3F9V32xkYA2BU=
Date: Thu, 5 Sep 2024 18:03:03 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: maobibo <maobibo@loongson.cn>, loongarch@lists.linux.dev, 
 qemu-devel@nongnu.org, xry111@xry111.site
Subject: Re: qemu direct kernel boot on LoongArch
Message-ID: <7311f2fa-2353-48ad-85f5-5eae1f6cb65f@t-8ch.de>
References: <49432aed-3ed7-2f07-7f65-311faef96197@loongson.cn>
 <ZtkhtxcJUK-JediY@zx2c4.com>
 <f50c4868-7c2e-1ede-ab19-c67ea0acaab3@loongson.cn>
 <CAHmME9rRJjJ5tHf_xtprkHtWz-ButOOZXVo=E9y8qSyQ-qu6ew@mail.gmail.com>
 <ccc7db47-d065-4e78-bf67-c4e8855c9be4@t-8ch.de>
 <ZtnGA4mH0I2hdx4N@zx2c4.com>
 <ea52a89c-449f-4aed-8138-f81ad20a1a79@t-8ch.de>
 <CAHmME9pPvk4s9JnEPmc9w71hkeHD_1U-fAy0+8MQNmO_9Gh3=g@mail.gmail.com>
 <b11ba2f4-ba4b-40fb-860e-e10e760562fe@t-8ch.de>
 <CAHmME9pjokr=ahBbJA9Ljf8jjOyfyRAk0Qo4YeDYO_gs78GGzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHmME9pjokr=ahBbJA9Ljf8jjOyfyRAk0Qo4YeDYO_gs78GGzg@mail.gmail.com>
Received-SPF: pass client-ip=2a01:4f8:c010:41de::1;
 envelope-from=thomas@t-8ch.de; helo=todd.t-8ch.de
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

On 2024-09-05 17:18:07+0000, Jason A. Donenfeld wrote:
> On Thu, Sep 5, 2024 at 5:16 PM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> >
> > On 2024-09-05 17:07:22+0000, Jason A. Donenfeld wrote:
> > > On Thu, Sep 5, 2024 at 5:05 PM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> > > >
> > > > On 2024-09-05 16:53:55+0000, Jason A. Donenfeld wrote:
> > > > > On Thu, Sep 05, 2024 at 07:25:05AM +0200, Thomas Weißschuh wrote:
> > > > > > On 2024-09-05 06:04:12+0000, Jason A. Donenfeld wrote:
> > > > > > > On Thu, Sep 5, 2024 at 5:45 AM maobibo <maobibo@loongson.cn> wrote:
> > > > > > > >
> > > > > > > > Jason,
> > > > > > > >
> > > > > > > > With the latest qemu 9.1 version, elf format booting is supported.
> > > > > > >
> > > > > > > Thanks, I just figured this out too, about 4 minutes ago. Excellent.
> > > > > > > And the 1G minimum ram limit is gone too.
> > > > > > >
> > > > > > > Now working on how to trigger resets.
> > > > > >
> > > > > > With "reset" do you mean normal (non-panic) system shutdown/poweroff?
> > > > > > Since QEMU 9.1 and a recent kernel you can use the pvpanic device for
> > > > > > that in a cross-architecture way.
> > > > >
> > > > > What I mean is that I need for userspace calling `reboot(RB_AUTOBOOT);`
> > > > > to actually result in QEMU being told to reboot the system. Sounds like
> > > > > that's not possible (yet?) in 9.1?
> > > >
> > > > With reboot(RB_POWER_OFF) this is indeed the exact usecase for pvpanic
> > >
> > > I'm actually using reboot(RB_AUTOBOOT) wth QEMU's -no-reboot, because
> > > that tends to be far more compatible with a greater number of
> > > platforms, for example, x86 without acpi. Shucks.
> >
> > You can check that both QEMU and the kernel support pvpanic shutdown
> > through sysfs and if so use reboot(RB_POWER_OFF); and
> > reboot(RB_AUTOBOOT) otherwise.
> 
> I guess. But the whole idea is to bloat the code as little as possible
> and use one interface for everything. Pushing that all up into
> userspace is pretty icky.

If it works through ACPI everywhere then sure.

> It sounds like LoongArch already supports this via ACPI GED, but
> there's some plumbing that needs to be done still. So maybe I'll just
> wait for that.

Also sounds reasonable.

> Meanwhile, any idea about adding a second serial to the platform? I've
> been futzing with it for a bit now to no avail.

No idea, sorry.

