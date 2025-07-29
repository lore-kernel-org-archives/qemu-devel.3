Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680E2C87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 16:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugn4d-0007T1-6I; Tue, 29 Jul 2025 12:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1ugmm7-0001gN-FI
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 12:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1ugmm1-0007lO-Ti
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 12:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753804892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SGYv72RxjZ33ADQVQ3rOtxtJu0wJd3kwSPw8DblHG1Q=;
 b=gqwYZb0hdBCQWiHF0R7AeUTfTlOt24b5TxU/guaVRzflNInYGN6tqlrKZox4g2W7lO0rTS
 OFqfNLgV6JxDpubxkq4MCoKEmCtVV9sLH06tLbGiXWywA9dpQSIvUtARfcJbBznwnNkvIu
 ayRinhd1kYOLv97SqsHtgZAkqLMft9U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-VyBVxoNCOL-I0sX1TfgxzQ-1; Tue,
 29 Jul 2025 12:01:30 -0400
X-MC-Unique: VyBVxoNCOL-I0sX1TfgxzQ-1
X-Mimecast-MFC-AGG-ID: VyBVxoNCOL-I0sX1TfgxzQ_1753804889
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BAC618007E1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 16:01:29 +0000 (UTC)
Received: from localhost (unknown [10.44.34.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 448331955F21; Tue, 29 Jul 2025 16:01:28 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] watchdog: generic name for i6300esb
In-Reply-To: <aHkboV03D6lSzpgK@redhat.com>
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
 <aHaC6_2vdXJqdxLo@redhat.com> <874iva7so9.fsf@redhat.com>
 <aHkboV03D6lSzpgK@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 29 Jul 2025 18:01:25 +0200
Message-ID: <87tt2v3s16.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jul 17 2025, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Thu, Jul 17, 2025 at 05:17:42PM +0200, Cornelia Huck wrote:
>> On Tue, Jul 15 2025, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>>=20
>> > On Tue, Jul 15, 2025 at 09:16:24AM -0700, Andrea Bolognani wrote:
>> >> You can point them to documentation over and over again, or you can
>> >> work to prevent the confusion/annoyance from showing up in the first
>> >> place. Which of the two approaches is a better use of anyone's time
>> >> is up for debate.
>> >>=20
>> >> I for one am grateful that someone put the time in all those years
>> >> ago and, as a result, PCI and USB controllers don't suffer from the
>> >> problem today. Ultimately it's up to Connie though.
>> >
>> > The PCI/USB controller situation is not the same tradeoff though.
>> > Those guest kernel drivers will identify and attach to these two
>> > controllers regardless of their PCI vendor/product, via the PCI
>> > class property. In that case changing the PCI ID and other device
>> > metadata in QEMU is cheap as it has no negative impact on guest OS
>> > driver compibility.
>> >
>> > In the case of 6300ESB though the guest driver is tied directly to
>> > the currently used PCI device product/vendor ID.
>> >
>> > If we change this then we have actually created new functional
>> > problems with guest/QEMU compatibility, in order to placate a
>> > non-functional problem. That is not a good thing.
>>=20
>> I don't think the suggestion was to disable the existing driver on
>> non-Intel setups, but to add a more generic one. Still, more work to get
>> this actually propagated into guests than doing the change in
>> QEMU. Before I start down that route, I'd like to know whether the issue
>> is actually big enough to make investing time there worth it.
>
> If we're a mmgmt app provisioning a guest, we have to choose what
> watchdog to create - either the old one which works everywhere
> that currently has a driver, or the new one will will work in
> far fewer places. We'll have to wire up guest OS info about
> watchdogs into osinfo, and then wire up all the mgmt apps to
> query this and take action based off it. All possible, but it
> still feels like a huge waste of time to me.

The fact that the device is something emulated and not the Intel
hardware device is actually visible to the guest:

00:02.0 System peripheral: Intel Corporation 6300ESB Watchdog Timer
	Subsystem: Red Hat, Inc. QEMU Virtual Machine
	Flags: fast devsel
	Memory at 10804000 (32-bit, non-prefetchable) [size=3D16]
	Kernel driver in use: i6300ESB timer
	Kernel modules: i6300esb

(lspci -v so unfortunately not immediately obvious, but still)

AFAIK the BSDs do not have a driver for this device at the moment -- and
given what turns up when searching for i6300ESB, someone implementing a
driver is far more likely to pick the exising PCI ID.

Windows would also need some dance according to Yan's mail, for unclear
benefits.

On the whole, I think this is not really worth the hassle, we can simply
keep this device as-is.


