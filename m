Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E46C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubiWi-0003qw-GJ; Tue, 15 Jul 2025 12:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1ubhpc-0002Dx-GP
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1ubhpa-0004iH-TY
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752594272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxiTyg1mRMC7Z3JQbUBfWU3xSp+ncpALjV0Dn7J+JGg=;
 b=huJh9HUGjYTJ3v0eVzvSUW4knHDS5c6kMajEOz43Vty+WLELUmbRF7Db3hyBqYm76YprHp
 qSoTSCL3JxthmqEY0qPfIpNv4TZR7fCp2pgSXG6znVi7fcG+N7oCVmLIyosVSL1nkjm0EW
 aNsIUjOgL6XtvQEotYfzVx8QGyn/5Hg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-0IzG2LRhO8G2kLVQbfQwVQ-1; Tue,
 15 Jul 2025 11:44:30 -0400
X-MC-Unique: 0IzG2LRhO8G2kLVQbfQwVQ-1
X-Mimecast-MFC-AGG-ID: 0IzG2LRhO8G2kLVQbfQwVQ_1752594269
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BB6D180028F
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 15:44:29 +0000 (UTC)
Received: from localhost (unknown [10.44.32.81])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7880218002B5; Tue, 15 Jul 2025 15:44:28 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang?=
 =?utf-8?Q?=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] watchdog: generic name for i6300esb
In-Reply-To: <CABJz62O3FKYfUOyCLMotgYgckWV1frSUb=MtTW2J4fDTEg_==g@mail.gmail.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20250610143259.1056400-1-cohuck@redhat.com>
 <20250610143259.1056400-3-cohuck@redhat.com> <aEhnbN1pSYgdi4EZ@redhat.com>
 <CABJz62O3FKYfUOyCLMotgYgckWV1frSUb=MtTW2J4fDTEg_==g@mail.gmail.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 15 Jul 2025 17:44:25 +0200
Message-ID: <877c09792e.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
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

On Tue, Jul 15 2025, Andrea Bolognani <abologna@redhat.com> wrote:

> On Tue, Jun 10, 2025 at 06:12:12PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> On Tue, Jun 10, 2025 at 04:32:59PM +0200, Cornelia Huck wrote:
>> > The Intel 6300 Enterprise SouthBridge is a south bridge for a more or
>> > less obscure embedded Intel system; however, the i6300esb watchdog
>> > device we implement in QEMU is a virtual watchdog device that should
>> > work well on any PCI-based machine, is well supported by Linux guests,
>> > and used in many examples on how to set up a virtual watchdog.
>> >
>> > Let's use "virtual i6300ESB" in the description to make clear that
>> > this device will work just fine on non-Intel platforms.
>> >
>> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> > ---
>> >  hw/watchdog/wdt_i6300esb.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> I'm not entirely sold on the idea that this is needed, but at the same
>> time I won't object so
>>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> I would argue that this change is incorrect.
>
> While the QEMU device can be used for non-x86 VMs, it *is* faithfully
> modelled after an Intel part, and the guest OS will recognize it as
> such:
>
>   # lspci | grep 6300
>   07:01.0 System peripheral: Intel Corporation 6300ESB Watchdog Timer
>
> What we actually need to do is create a new QEMU device with distinct
> PCI IDs, same as we've done in the past for qemu-xhci, pcie-root-port
> and pcie-to-pci-bridge.
>
> That will take a lot longer to integrate throughout the stack and be
> supported across the various guest OS, but it's the only approach
> that eventually leads to truly Intel-free non-x86 VMs.

Hmm. So
- request a new PCI id (probably in the PCI_DEVICE_ID_REDHAT_* space)
- restructure to have two devices base off the same core functionality
- teach guest operating systems about the new device
- teach management software like libvirt about the new device

Not sure how fast we can get an ID (or even how to go about it.) The
second step should be reasonably easy. The third step is the most
complex one, but at least teaching Linux should hopefully be easy
enough, and existing guest operating systems could continue to use the
existing device. The last step is probably not that bad.

I can start down that path, if we have some consensus that this is the
right way to handle this.

I'd still argue that patch 1 should be applied regardless :)


