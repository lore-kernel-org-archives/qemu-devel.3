Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8F5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 03:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYdHd-0007r1-QV; Mon, 29 Jul 2024 23:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYdHc-0007qT-6Y
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 23:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYdHW-0006uK-3G
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 23:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722309127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TWBkvF315pAZ214F3Dz7O9R39xxLYxv/Z4+ulhZ0CIE=;
 b=V4wC8eyLo4/JwVl3pM6sCUILsyKT/jFCHjvu3oPOL2veZlBGPvJdmognaS8K21QvkDgX34
 jRnX5TjTCRn29PKyLVAIVXVKtJdh1W+Kgzt5XCWvlTYbivRXxbNJuKjXLi+7kAgfA0BAa0
 NwuoepBA3DwNK+DzCu01OqH6HXBgg10=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-npUKzJyyOmW6KOLjj8ruLA-1; Mon, 29 Jul 2024 23:03:41 -0400
X-MC-Unique: npUKzJyyOmW6KOLjj8ruLA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-71a43a07997so3061531a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 20:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722308620; x=1722913420;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TWBkvF315pAZ214F3Dz7O9R39xxLYxv/Z4+ulhZ0CIE=;
 b=PEftiTPRG+m9PV9rQI8PBA1QNbvkMAzlEs7ezESLt9OYOEruXkCMataTSQ2L3B/gyp
 lhiKA3OWljb2we58AbhAg72hXxjGL8BQ1ghMfhtqKQurUqSDp00GUSIrn4BypkRQFz73
 0yhOuE4/4MRzpGRnWQFvuqrEdxdLApQGbyAqrlFOkeydpQHhAlx9Gf+zxmPCmUcUzZvm
 F9Hn9VXD401Ey+DPzukH/zZ38Kttb2kSAT972LPhwtr6ViXBzLGaPPVFmxxa4j7mqnEU
 Yo1YXVnh2NJ0eDIfkJRaUypeNolLvLP0m3x9oZN33Woxcxk8XMXkhvswohxac4LBNGWq
 O9Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/CExP8uJg7WpcwQtnoG1bT5OhccsDDWpTra8NwjBwKLLDd1YJPe5DcmxGcjPHiUrnZtSvrajqoNPwufaf6fu+uUem0lg=
X-Gm-Message-State: AOJu0YxM9vGB5wjj9PFYEV/wTYxmwjo+SBuKFqFDn40B7X4YwcjrPhHX
 jZXtxNjcKzP0Sb9Qafi1rQEbCFChC8HiZgXN2fR1XiDMRHY93D/4Is+A9qkFXhNdGqJTFvL8J7K
 9HF0kaqstj2MqcYDanTd3lLMVFCgR3a/GgBNKMEUXY8ABFmfyC2Ycoep91lJqL9aorAX+lzcvg5
 F/7qGaRixuln+jI3y2t3os9Mazv9k=
X-Received: by 2002:a05:6a20:7f95:b0:1c4:8dc0:8520 with SMTP id
 adf61e73a8af0-1c4a0e04682mr8038605637.0.1722308620055; 
 Mon, 29 Jul 2024 20:03:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMnw0FpsgLOsI/97ezLDPofrmcNFnVbo/3r1T1OUMh6rKCyoWj/rRNSH/UIXKwybfCx/6hFSuVSgGlp3psKWY=
X-Received: by 2002:a05:6a20:7f95:b0:1c4:8dc0:8520 with SMTP id
 adf61e73a8af0-1c4a0e04682mr8038577637.0.1722308619415; Mon, 29 Jul 2024
 20:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com>
 <ZqO2HvFJ8v7hZFOd@x1n> <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
 <5a74c1d4-3c33-42d1-8abf-e3aab71e13a5@daynix.com>
 <CACGkMEtgPvGu9=n6nQqDwkV77X4830PQwv-E4m-+93Y8OhoVnQ@mail.gmail.com>
 <f1d0621b-84f0-4c2c-b4f4-f8ebd494ec48@daynix.com> <ZqenSQHzniN14g7G@x1n>
 <720d7d64-2b65-48cc-afa7-3b5ebc17e283@daynix.com>
 <CACGkMEtPwdddgnmSqzS92Z7yNDfu_B8xaFujy9PqMks7m8jqiA@mail.gmail.com>
 <688dd596-888f-49e1-a19c-0d62d417cce4@daynix.com>
In-Reply-To: <688dd596-888f-49e1-a19c-0d62d417cce4@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jul 2024 11:03:28 +0800
Message-ID: <CACGkMEvgYTjQ5orDJMbmE8-Kwqko9dFPerTnxsRgs0EtnmKKTQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 dmitry.fleytman@gmail.com, sriram.yagnaraman@est.tech, sw@weilnetz.de, 
 qemu-devel@nongnu.org, yan@daynix.com, Fabiano Rosas <farosas@suse.de>, 
 devel@lists.libvirt.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Jul 30, 2024 at 10:57=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2024/07/30 11:04, Jason Wang wrote:
> > On Tue, Jul 30, 2024 at 12:43=E2=80=AFAM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>
> >> On 2024/07/29 23:29, Peter Xu wrote:
> >>> On Mon, Jul 29, 2024 at 01:45:12PM +0900, Akihiko Odaki wrote:
> >>>> On 2024/07/29 12:50, Jason Wang wrote:
> >>>>> On Sun, Jul 28, 2024 at 11:19=E2=80=AFPM Akihiko Odaki <akihiko.oda=
ki@daynix.com> wrote:
> >>>>>>
> >>>>>> On 2024/07/27 5:47, Peter Xu wrote:
> >>>>>>> On Fri, Jul 26, 2024 at 04:17:12PM +0100, Daniel P. Berrang=C3=A9=
 wrote:
> >>>>>>>> On Fri, Jul 26, 2024 at 10:43:42AM -0400, Peter Xu wrote:
> >>>>>>>>> On Fri, Jul 26, 2024 at 09:48:02AM +0100, Daniel P. Berrang=C3=
=A9 wrote:
> >>>>>>>>>> On Fri, Jul 26, 2024 at 09:03:24AM +0200, Thomas Huth wrote:
> >>>>>>>>>>> On 26/07/2024 08.08, Michael S. Tsirkin wrote:
> >>>>>>>>>>>> On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
> >>>>>>>>>>>>> On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich =
wrote:
> >>>>>>>>>>>>>> USO features of virtio-net device depend on kernel ability
> >>>>>>>>>>>>>> to support them, for backward compatibility by default the
> >>>>>>>>>>>>>> features are disabled on 8.0 and earlier.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.c=
om>
> >>>>>>>>>>>>>> Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Looks like this patch broke migration when the VM starts on=
 a host that has
> >>>>>>>>>>>>> USO supported, to another host that doesn't..
> >>>>>>>>>>>>
> >>>>>>>>>>>> This was always the case with all offloads. The answer at th=
e moment is,
> >>>>>>>>>>>> don't do this.
> >>>>>>>>>>>
> >>>>>>>>>>> May I ask for my understanding:
> >>>>>>>>>>> "don't do this" =3D don't automatically enable/disable virtio=
 features in QEMU
> >>>>>>>>>>> depending on host kernel features, or "don't do this" =3D don=
't try to migrate
> >>>>>>>>>>> between machines that have different host kernel features?
> >>>>>>>>>>>
> >>>>>>>>>>>> Long term, we need to start exposing management APIs
> >>>>>>>>>>>> to discover this, and management has to disable unsupported =
features.
> >>>>>>>>>>>
> >>>>>>>>>>> Ack, this likely needs some treatments from the libvirt side,=
 too.
> >>>>>>>>>>
> >>>>>>>>>> When QEMU automatically toggles machine type featuers based on=
 host
> >>>>>>>>>> kernel, relying on libvirt to then disable them again is impra=
ctical,
> >>>>>>>>>> as we cannot assume that the libvirt people are using knows ab=
out
> >>>>>>>>>> newly introduced features. Even if libvirt is updated to know =
about
> >>>>>>>>>> it, people can easily be using a previous libvirt release.
> >>>>>>>>>>
> >>>>>>>>>> QEMU itself needs to make the machine types do that they are t=
here
> >>>>>>>>>> todo, which is to define a stable machine ABI.
> >>>>>>>>>>
> >>>>>>>>>> What QEMU is missing here is a "platform ABI" concept, to enco=
de
> >>>>>>>>>> sets of features which are tied to specific platform generatio=
ns.
> >>>>>>>>>> As long as we don't have that we'll keep having these broken
> >>>>>>>>>> migration problems from machine types dynamically changing ins=
tead
> >>>>>>>>>> of providing a stable guest ABI.
> >>>>>>>>>
> >>>>>>>>> Any more elaboration on this idea?  Would it be easily feasible=
 in
> >>>>>>>>> implementation?
> >>>>>>>>
> >>>>>>>> In terms of launching QEMU I'd imagine:
> >>>>>>>>
> >>>>>>>>       $QEMU -machine pc-q35-9.1 -platform linux-6.9 ...args...
> >>>>>>>>
> >>>>>>>> Any virtual machine HW features which are tied to host kernel fe=
atures
> >>>>>>>> would have their defaults set based on the requested -platform. =
The
> >>>>>>>> -machine will be fully invariant wrt the host kernel.
> >>>>>>>>
> >>>>>>>> You would have -platform hlep to list available platforms, and
> >>>>>>>> corresonding QMP "query-platforms" command to list what platform=
s
> >>>>>>>> are supported on a given host OS.
> >>>>>>>>
> >>>>>>>> Downstream distros can provide their own platforms definitions
> >>>>>>>> (eg "linux-rhel-9.5") if they have kernels whose feature set
> >>>>>>>> diverges from upstream due to backports.
> >>>>>>>>
> >>>>>>>> Mgmt apps won't need to be taught about every single little QEMU
> >>>>>>>> setting whose default is derived from the kernel. Individual
> >>>>>>>> defaults are opaque and controlled by the requested platform.
> >>>>>>>>
> >>>>>>>> Live migration has clearly defined semantics, and mgmt app can
> >>>>>>>> use query-platforms to validate two hosts are compatible.
> >>>>>>>>
> >>>>>>>> Omitting -platform should pick the very latest platform that is
> >>>>>>>> cmpatible with the current host (not neccessarily the latest
> >>>>>>>> platform built-in to QEMU).
> >>>>>>>
> >>>>>>> This seems to add one more layer to maintain, and so far I don't =
know
> >>>>>>> whether it's a must.
> >>>>>>>
> >>>>>>> To put it simple, can we simply rely on qemu cmdline as "the gues=
t ABI"?  I
> >>>>>>> thought it was mostly the case already, except some extremely rar=
e
> >>>>>>> outliers.
> >>>>>>>
> >>>>>>> When we have one host that boots up a VM using:
> >>>>>>>
> >>>>>>>       $QEMU1 $cmdline
> >>>>>>>
> >>>>>>> Then another host boots up:
> >>>>>>>
> >>>>>>>       $QEMU2 $cmdline -incoming XXX
> >>>>>>>
> >>>>>>> Then migration should succeed if $cmdline is exactly the same, an=
d the VM
> >>>>>>> can boot up all fine without errors on both sides.
> >>>>>>>
> >>>>>>> AFAICT this has nothing to do with what kernel is underneath, eve=
n not
> >>>>>>> Linux?  I think either QEMU1 / QEMU2 has the option to fail.  But=
 if it
> >>>>>>> didn't, I thought the ABI should be guaranteed.
> >>>>>>>
> >>>>>>> That's why I think this is a migration violation, as 99.99% of ot=
her device
> >>>>>>> properties should be following this rule.  The issue here is, we =
have the
> >>>>>>> same virtio-net-pci cmdline on both sides in this case, but the A=
BI got
> >>>>>>> break.
> >>>>>>>
> >>>>>>> That's also why I was suggesting if the property contributes to t=
he guest
> >>>>>>> ABI, then AFAIU QEMU needs to:
> >>>>>>>
> >>>>>>>       - Firstly, never quietly flipping any bit that affects the =
ABI...
> >>>>>>>
> >>>>>>>       - Have a default value of off, then QEMU will always allow =
the VM to boot
> >>>>>>>         by default, while advanced users can opt-in on new featur=
es.  We can't
> >>>>>>>         make this ON by default otherwise some VMs can already fa=
il to boot,
> >>>>>>
> >>>>>> It may not be necessary the case that old features are supported b=
y
> >>>>>> every systems. In an extreme case, a user may migrate a VM from Li=
nux to
> >>>>>> Windows, which probably doesn't support any offloading at all. A m=
ore
> >>>>>> convincing scenario is RSS offloading with eBPF; using eBPF requir=
es a
> >>>>>> privilege so we cannot assume it is always available even on the l=
atest
> >>>>>> version of Linux.
> >>>>>
> >>>>> I don't get why eBPF matters here. It is something that is not noti=
ced
> >>>>> by the guest and we have a fallback anyhow.
> >>
> >> It is noticeable for the guest, and the fallback is not effective with
> >> vhost.
> >
> > It's a bug then. Qemu can fallback to tuntap if it sees issues in vhost=
.
>
> We can certainly fallback to in-QEMU RSS by disabling vhost, but I would
> not say lack of such fallback is a bug.

Such fallback is by design since the introduction of vhost.

> We don't provide in-QEMU
> fallback for other offloads.

Yes but what I want to say is that eBPF RSS is different from those
segmentation offloads. And technically, Qemu can do fallback for
offloads (as RSC did).

Thanks

>
> Regards,
> Akihiko Odaki
>


