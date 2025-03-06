Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD070C28B24
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDl7-0008C6-Q2; Thu, 06 Mar 2025 11:07:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tqDj1-0006Po-BP
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:05:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tqDiw-0008KO-RI
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741277124;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CiuNvnjJP5MotkVq+HHQWlet/MGSOekNGEEEtipC8ek=;
 b=GcKMLV6WnQ2vJ4hx/ZTU5ctgjYDpGS3yGuitUVBpjqRHahmpu6q74cfAl1W+wAfw02KLYP
 7KiEYwJ5pHR4Je5/H1NxrTYw0PcTgNO8TFIvI3YinTynuZHX1oZSpayBORGutmpzv+j3Xh
 dDuz49IbGnkqqMpdCAtcoiKXVhj2z7s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-QYu2YZRsPwOswM2Vntji7g-1; Thu,
 06 Mar 2025 11:05:14 -0500
X-MC-Unique: QYu2YZRsPwOswM2Vntji7g-1
X-Mimecast-MFC-AGG-ID: QYu2YZRsPwOswM2Vntji7g_1741277113
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B7A21955D66; Thu,  6 Mar 2025 16:05:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3CF61956095; Thu,  6 Mar 2025 16:05:09 +0000 (UTC)
Date: Thu, 6 Mar 2025 16:05:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH qemu v2 1/3] hw/s390x: add CPI identifiers to QOM
Message-ID: <Z8nHlBnfcT7H87fB@redhat.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
 <48caabe7-c112-4454-96a8-742d154c77ee@redhat.com>
 <78b6c548212517ef8620fce0c6832e4f@imap.linux.ibm.com>
 <f64b5ce4-8843-4d92-af97-24160f687698@redhat.com>
 <98ab6ad416f0dcf7d1beb5105cace9ca46ad3c84.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98ab6ad416f0dcf7d1beb5105cace9ca46ad3c84.camel@linux.ibm.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Mar 06, 2025 at 04:44:33PM +0100, Nina Schoetterl-Glausch wrote:
> On Thu, 2025-03-06 at 15:55 +0100, Thomas Huth wrote:
> > On 06/03/2025 13.23, shalini wrote:
> > > On 2025-03-05 16:56, Thomas Huth wrote:
> > > > On 24/02/2025 13.04, Shalini Chellathurai Saroja wrote:
> > > > > Add Control-Program Identification (CPI) to the QEMU Object
> > > > > Model (QOM). The CPI identifiers provide information about
> > > > > the guest operating system. The CPI identifiers are:
> > > > > system type, system name, system level and sysplex name.
> > > > > 
> > > > > The system type provides the OS type of the guest (e.g. LINUX).
> > > > > The system name provides the name of the guest (e.g. TESTVM).
> > > > > The system level provides the distribution and kernel version
> > > > > of the guest OS (e.g. 0x50e00).
> > > > > The sysplex name provides the sysplex name of the guest
> > > > > (e.g. SYSPLEX).
> > > > > 
> > > > > Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> > > > > ---
> > > > >   hw/s390x/s390-virtio-ccw.c         | 29 +++++++++++++++++++++++++++++
> > > > >   include/hw/s390x/s390-virtio-ccw.h |  8 ++++++++
> > > > >   qapi/machine.json                  | 24 ++++++++++++++++++++++++
> > > > >   3 files changed, 61 insertions(+)
> > > > > 
> > > > > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> > > > > index 51ae0c133d..13ea8db1b0 100644
> > > > > --- a/hw/s390x/s390-virtio-ccw.c
> > > > > +++ b/hw/s390x/s390-virtio-ccw.c
> > > > > @@ -50,6 +50,7 @@
> 
> [...]
> 
> > > > > +##
> > > > > +{ 'struct': 'S390ControlProgramId', 'data': {
> > > > > +     'system-type': 'str',
> > > > > +     'system-name': 'str',
> > > > > +     'system-level': 'str',
> > > > 
> > > > Not sure, but would it make sense to use a number for the system-level
> > > > instead? At least it's a number in ControlProgramId, not a string.
> > > > 
> > > 
> > > The system-level, when interpreted as an int provides the output below
> > > 
> > > 'system-level': 74872343805430528
> > > 
> > > But the desired output below is obtained only when interpreted as a str. 
> > > please refer https://www.ibm.com/docs/en/linux-on-systems? 
> > > topic=identification-system-level for details on system-level. I will also 
> > > document this in the description of system-level as suggested by Daniel. 
> > > Thank you.
> > > 
> > > 'system-level': '0x10a000000060b00'
> > 
> > Well, the idea of QOM/QAPI is: It's an *API* for machines, not meant for 
> > direct consumption by the end user. So passing an integer as a string is not 
> > the right way here. For the user, you'd require some upper level instead 
> > that renders the integer in the right shape for the user. So please don't 
> > use a string for this at the QOM/QAPI level.
> 
> In a sense the system level is a bitfield.
> So this could become a struct
> 
> {
> 	'hypervisor-use' : true,
> 	'distribution-id': 3,	// or an enum?
> 	'distribution-version-major: 24,
> 	...
> }

Yes, if this is a mandatory format, breaking out the fields makes sense.

> Not sure how to handle the 3 undefined bits in the highest byte.

If they're always left zero, might as well just omit them until
such time as they have semantics defined (if ever)


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


