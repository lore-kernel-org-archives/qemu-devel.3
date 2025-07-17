Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25528C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucT37-0008PD-I0; Thu, 17 Jul 2025 14:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1ucQOB-00033B-8w
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:19:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1ucQNp-0003f7-9P
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752765529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jRw19WaZX8OHqHgr3p74vXY3BrDW8uDvIN+4MIF95WU=;
 b=bOs/sd+P+idxwymDLG1/N1teHT5aJCavTI5NCwPL8PtKZ7jRa3A/ciNKA44FfwL+ZJDzBs
 wOSls+rlLd/lf9w5HYirUP4kqGAztyeEg01UN5ZRu/Duxx+PliDuNl2s/Q/e0Z2naKNXKM
 mIteUiv+nT4FveG7P1Swk7VkKU5SlTo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-pSMrzxUONO-vVagWhWK8pA-1; Thu,
 17 Jul 2025 11:18:47 -0400
X-MC-Unique: pSMrzxUONO-vVagWhWK8pA-1
X-Mimecast-MFC-AGG-ID: pSMrzxUONO-vVagWhWK8pA_1752765527
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B70FE1855151
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 15:17:56 +0000 (UTC)
Received: from localhost (unknown [10.44.33.147])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08F271955F22; Thu, 17 Jul 2025 15:17:44 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Andrea
 Bolognani <abologna@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] watchdog: generic name for i6300esb
In-Reply-To: <aHaC6_2vdXJqdxLo@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20250610143259.1056400-1-cohuck@redhat.com>
 <20250610143259.1056400-3-cohuck@redhat.com> <aEhnbN1pSYgdi4EZ@redhat.com>
 <CABJz62O3FKYfUOyCLMotgYgckWV1frSUb=MtTW2J4fDTEg_==g@mail.gmail.com>
 <877c09792e.fsf@redhat.com> <aHZ7rpYFMWai-7RL@redhat.com>
 <CABJz62P+p_uYiatXroauLkG2AH2TnjS8drbHxLPsgY+=QSB8Lw@mail.gmail.com>
 <aHaC6_2vdXJqdxLo@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Thu, 17 Jul 2025 17:17:42 +0200
Message-ID: <874iva7so9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 15 2025, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Tue, Jul 15, 2025 at 09:16:24AM -0700, Andrea Bolognani wrote:
>> On Tue, Jul 15, 2025 at 05:02:54PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> > On Tue, Jul 15, 2025 at 05:44:25PM +0200, Cornelia Huck wrote:
>> > > Hmm. So
>> > > - request a new PCI id (probably in the PCI_DEVICE_ID_REDHAT_* space)
>> > > - restructure to have two devices base off the same core functionali=
ty
>> > > - teach guest operating systems about the new device
>> > > - teach management software like libvirt about the new device
>> > >
>> > > Not sure how fast we can get an ID (or even how to go about it.) The
>> > > second step should be reasonably easy. The third step is the most
>> > > complex one, but at least teaching Linux should hopefully be easy
>> > > enough, and existing guest operating systems could continue to use t=
he
>> > > existing device. The last step is probably not that bad.
>> > >
>> > > I can start down that path, if we have some consensus that this is t=
he
>> > > right way to handle this.
>> > >
>> > > I'd still argue that patch 1 should be applied regardless :)
>> >
>> > This sounds like a hell of alot of busy work to fix a problem that, II=
UC,
>> > does not actually exist from a functional POV - it is merely a percept=
ion
>> > issue that people might be put off by the "Intel 6300ESB" names.
>> >
>> > IMHO a better use of time is to expand documentation to clarify this is
>> > just fine for all PCI architectures, and change nothing in either QEMU
>> > or guest kernels.
>>=20
>> Agreed that it's not the most high-reward endeavor, but IIRC users
>> were getting genuinely confused and annoyed by the string "Intel"
>> showing up in their aarch64 guests.
>
> So be it, that's far from the only wierd thing in virt.

So I'm wondering what the general sentiment is towards having an "Intel"
device show up in your non-Intel guest. This device is generic enough to
be included in PCI_DEVICES, and should be usable on any of those
platforms.

Linux treats this as a generic PCI driver as well. Do we know what
Windows on non-x86 expects? The *BSDs? Others?

>
>> You can point them to documentation over and over again, or you can
>> work to prevent the confusion/annoyance from showing up in the first
>> place. Which of the two approaches is a better use of anyone's time
>> is up for debate.
>>=20
>> I for one am grateful that someone put the time in all those years
>> ago and, as a result, PCI and USB controllers don't suffer from the
>> problem today. Ultimately it's up to Connie though.
>
> The PCI/USB controller situation is not the same tradeoff though.
> Those guest kernel drivers will identify and attach to these two
> controllers regardless of their PCI vendor/product, via the PCI
> class property. In that case changing the PCI ID and other device
> metadata in QEMU is cheap as it has no negative impact on guest OS
> driver compibility.
>
> In the case of 6300ESB though the guest driver is tied directly to
> the currently used PCI device product/vendor ID.
>
> If we change this then we have actually created new functional
> problems with guest/QEMU compatibility, in order to placate a
> non-functional problem. That is not a good thing.

I don't think the suggestion was to disable the existing driver on
non-Intel setups, but to add a more generic one. Still, more work to get
this actually propagated into guests than doing the change in
QEMU. Before I start down that route, I'd like to know whether the issue
is actually big enough to make investing time there worth it.


