Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AA8C52D6F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRNe-00044L-Uf; Mon, 29 Jul 2024 10:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sYRNe-00043q-66
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sYRNb-0005kq-En
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722263378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lbm46Y5wkhF7nWxco558G3Y/1eyHQevpvQYVY1PR1s4=;
 b=bcPqB1Q0/mxx2nNMP4mKy3bhoFPx4s5dHAXpOph9w5oEZN7FCrR/5/9MmB9ruBItIqzzax
 nG58Qg53joQxgqDI7sPuPDNaXt4R4LzDFFh2BalmoFyeHFGjXNzv3DV3nm4nhfMcNvkFNK
 GaoF9ONi3ddL7dJgPdsNycn7d54mYDw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-DRn8NczaNkOtXWqoDq3FeA-1; Mon, 29 Jul 2024 10:29:34 -0400
X-MC-Unique: DRn8NczaNkOtXWqoDq3FeA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b79c5c972eso3831216d6.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722263373; x=1722868173;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lbm46Y5wkhF7nWxco558G3Y/1eyHQevpvQYVY1PR1s4=;
 b=YKnyFOSqgW73UyelR/i+cwCnt6TNNX0zLeO6WLaJCF4pLSEgss9xfvyCj09tAeYeWM
 0KfbDRoVq0Woi1DIdAqUgJwxXeHWreYc9U2bfCurHTd2AK9NWJAevXD41iqX0rOL6fpj
 Q0mBMZr6jefyl6z5tFQTlmPoEzXCO4fzuNp/WnVD+Q5BXltKkQ8pksAsOZtvESzHWzvh
 uaMnbWYo8J6yuIe35C2oM2VnAXmnbOZ04KDBAJToMKeqFQdHe6vli33l2tOmQyNcFvZv
 DcbxV9890/+6X/QWqELUDC8dMJ6gbHxU5tOZtK6TYusNbQk3lvQAdQnblKO3fuZFtXAy
 zKiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD+kHirc3WEVF3sfTlnX/QK7f4Tce7ENRiX47lCQwF3fw76WR5jSXO3jsjMFIrLKmGZyA45UKYBJmWNmvPW812lmAXO6A=
X-Gm-Message-State: AOJu0YwfS1JEHAyCdkgstwjKfBSycyPMm0qOmMROJtRL+ct6lk2O7NSn
 YLLi7bGLCuaZs5xs25sNAiD1ONWUV6ZiMJdrI4EMRQnmLNVLZnBbjowfDrnzjD6qu8kNcgabPVS
 hJlq+a6T1oh6aTfe8Wdjr2hsGb1TPmOeDrToLgR9xhAdH8C5Zw36U
X-Received: by 2002:a05:6214:496:b0:6b9:5c25:c41e with SMTP id
 6a1803df08f44-6bb3e233938mr107908056d6.3.1722263373425; 
 Mon, 29 Jul 2024 07:29:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/0fn16vDSOyqOqULLgaYiu3duLdXmXhFv2TNe2eMiETBGK+7HM9RmALJqTUw8PcGUKGTLEA==
X-Received: by 2002:a05:6214:496:b0:6b9:5c25:c41e with SMTP id
 6a1803df08f44-6bb3e233938mr107907866d6.3.1722263372939; 
 Mon, 29 Jul 2024 07:29:32 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb3fac6b6csm52646646d6.116.2024.07.29.07.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 07:29:32 -0700 (PDT)
Date: Mon, 29 Jul 2024 10:29:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <ZqenSQHzniN14g7G@x1n>
References: <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com> <ZqO2HvFJ8v7hZFOd@x1n>
 <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
 <5a74c1d4-3c33-42d1-8abf-e3aab71e13a5@daynix.com>
 <CACGkMEtgPvGu9=n6nQqDwkV77X4830PQwv-E4m-+93Y8OhoVnQ@mail.gmail.com>
 <f1d0621b-84f0-4c2c-b4f4-f8ebd494ec48@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1d0621b-84f0-4c2c-b4f4-f8ebd494ec48@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 29, 2024 at 01:45:12PM +0900, Akihiko Odaki wrote:
> On 2024/07/29 12:50, Jason Wang wrote:
> > On Sun, Jul 28, 2024 at 11:19 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> > > 
> > > On 2024/07/27 5:47, Peter Xu wrote:
> > > > On Fri, Jul 26, 2024 at 04:17:12PM +0100, Daniel P. Berrangé wrote:
> > > > > On Fri, Jul 26, 2024 at 10:43:42AM -0400, Peter Xu wrote:
> > > > > > On Fri, Jul 26, 2024 at 09:48:02AM +0100, Daniel P. Berrangé wrote:
> > > > > > > On Fri, Jul 26, 2024 at 09:03:24AM +0200, Thomas Huth wrote:
> > > > > > > > On 26/07/2024 08.08, Michael S. Tsirkin wrote:
> > > > > > > > > On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
> > > > > > > > > > On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
> > > > > > > > > > > USO features of virtio-net device depend on kernel ability
> > > > > > > > > > > to support them, for backward compatibility by default the
> > > > > > > > > > > features are disabled on 8.0 and earlier.
> > > > > > > > > > > 
> > > > > > > > > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > > > > > > > > > Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
> > > > > > > > > > 
> > > > > > > > > > Looks like this patch broke migration when the VM starts on a host that has
> > > > > > > > > > USO supported, to another host that doesn't..
> > > > > > > > > 
> > > > > > > > > This was always the case with all offloads. The answer at the moment is,
> > > > > > > > > don't do this.
> > > > > > > > 
> > > > > > > > May I ask for my understanding:
> > > > > > > > "don't do this" = don't automatically enable/disable virtio features in QEMU
> > > > > > > > depending on host kernel features, or "don't do this" = don't try to migrate
> > > > > > > > between machines that have different host kernel features?
> > > > > > > > 
> > > > > > > > > Long term, we need to start exposing management APIs
> > > > > > > > > to discover this, and management has to disable unsupported features.
> > > > > > > > 
> > > > > > > > Ack, this likely needs some treatments from the libvirt side, too.
> > > > > > > 
> > > > > > > When QEMU automatically toggles machine type featuers based on host
> > > > > > > kernel, relying on libvirt to then disable them again is impractical,
> > > > > > > as we cannot assume that the libvirt people are using knows about
> > > > > > > newly introduced features. Even if libvirt is updated to know about
> > > > > > > it, people can easily be using a previous libvirt release.
> > > > > > > 
> > > > > > > QEMU itself needs to make the machine types do that they are there
> > > > > > > todo, which is to define a stable machine ABI.
> > > > > > > 
> > > > > > > What QEMU is missing here is a "platform ABI" concept, to encode
> > > > > > > sets of features which are tied to specific platform generations.
> > > > > > > As long as we don't have that we'll keep having these broken
> > > > > > > migration problems from machine types dynamically changing instead
> > > > > > > of providing a stable guest ABI.
> > > > > > 
> > > > > > Any more elaboration on this idea?  Would it be easily feasible in
> > > > > > implementation?
> > > > > 
> > > > > In terms of launching QEMU I'd imagine:
> > > > > 
> > > > >     $QEMU -machine pc-q35-9.1 -platform linux-6.9 ...args...
> > > > > 
> > > > > Any virtual machine HW features which are tied to host kernel features
> > > > > would have their defaults set based on the requested -platform. The
> > > > > -machine will be fully invariant wrt the host kernel.
> > > > > 
> > > > > You would have -platform hlep to list available platforms, and
> > > > > corresonding QMP "query-platforms" command to list what platforms
> > > > > are supported on a given host OS.
> > > > > 
> > > > > Downstream distros can provide their own platforms definitions
> > > > > (eg "linux-rhel-9.5") if they have kernels whose feature set
> > > > > diverges from upstream due to backports.
> > > > > 
> > > > > Mgmt apps won't need to be taught about every single little QEMU
> > > > > setting whose default is derived from the kernel. Individual
> > > > > defaults are opaque and controlled by the requested platform.
> > > > > 
> > > > > Live migration has clearly defined semantics, and mgmt app can
> > > > > use query-platforms to validate two hosts are compatible.
> > > > > 
> > > > > Omitting -platform should pick the very latest platform that is
> > > > > cmpatible with the current host (not neccessarily the latest
> > > > > platform built-in to QEMU).
> > > > 
> > > > This seems to add one more layer to maintain, and so far I don't know
> > > > whether it's a must.
> > > > 
> > > > To put it simple, can we simply rely on qemu cmdline as "the guest ABI"?  I
> > > > thought it was mostly the case already, except some extremely rare
> > > > outliers.
> > > > 
> > > > When we have one host that boots up a VM using:
> > > > 
> > > >     $QEMU1 $cmdline
> > > > 
> > > > Then another host boots up:
> > > > 
> > > >     $QEMU2 $cmdline -incoming XXX
> > > > 
> > > > Then migration should succeed if $cmdline is exactly the same, and the VM
> > > > can boot up all fine without errors on both sides.
> > > > 
> > > > AFAICT this has nothing to do with what kernel is underneath, even not
> > > > Linux?  I think either QEMU1 / QEMU2 has the option to fail.  But if it
> > > > didn't, I thought the ABI should be guaranteed.
> > > > 
> > > > That's why I think this is a migration violation, as 99.99% of other device
> > > > properties should be following this rule.  The issue here is, we have the
> > > > same virtio-net-pci cmdline on both sides in this case, but the ABI got
> > > > break.
> > > > 
> > > > That's also why I was suggesting if the property contributes to the guest
> > > > ABI, then AFAIU QEMU needs to:
> > > > 
> > > >     - Firstly, never quietly flipping any bit that affects the ABI...
> > > > 
> > > >     - Have a default value of off, then QEMU will always allow the VM to boot
> > > >       by default, while advanced users can opt-in on new features.  We can't
> > > >       make this ON by default otherwise some VMs can already fail to boot,
> > > 
> > > It may not be necessary the case that old features are supported by
> > > every systems. In an extreme case, a user may migrate a VM from Linux to
> > > Windows, which probably doesn't support any offloading at all. A more
> > > convincing scenario is RSS offloading with eBPF; using eBPF requires a
> > > privilege so we cannot assume it is always available even on the latest
> > > version of Linux.
> > 
> > I don't get why eBPF matters here. It is something that is not noticed
> > by the guest and we have a fallback anyhow.
> > 
> > > 
> > > > 
> > > >     - If the host doesn't support the feature while the cmdline enabled it,
> > > >       it needs to fail QEMU boot rather than flipping, so that it says "hey,
> > > >       this host does not support running such VM specified, due to XXX
> > > >       feature missing".
> > > 
> > > This is handled in:
> > > 
> > > "virtio-net: Convert feature properties to OnOffAuto"
> > > https://patchew.org/QEMU/20240714-auto-v3-0-e27401aabab3@daynix.com/
> > 
> > I may miss something but I think "Auto" doesn't make sense to libvirt.
> 
> The point is libvirt can explicitly set "on" to avoid the "auto" behavior.
> libvirt does not have to use the "auto" value.
> 
> libvirt can still use "auto" if desired. virDomainNetDefParseXMLDriver() in
> libvirt actually parses tristate values (libvirt uses "default" instead of
> "auto" as the mnemonic) for these features though "default" is currently
> disabled by the schema (src/conf/schemas/domaincommon.rng). Allowing user to
> specify "default" is only a matter of editing the schema. Of course
> specifying "default" will make the VM unsafe for migration.

Isn't keeping the default AUTO the same as before when it used to be ON?  I
mean, AUTO in a qemu cmdline doesn't guarantee guest API either.

Indeed it looks like it's a step forward to make ON having the clear
semantics of "fail when unsupported".  It's just that I am not sure how
useful is AUTO here, because anyway we'll need to break ON semantics even
with AUTO, so that an old QEMU script with USO=ON used to boot on old
kernels but not it won't.

What I was trying to say is whether we should make the default parameter to
be migratable.  IOW, it looks to me AUTO should deserve a migration
blocker when chosen.

After all, Libvirt hopefully shouldn't use AUTO at all but only ON/OFF,
while any user when not caring much on these perf details should always use
OFF on any kernel dependent features that may affect the guest ABI.

Thanks,

-- 
Peter Xu


