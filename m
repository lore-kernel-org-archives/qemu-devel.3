Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7240C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 08:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI2U7-00089Y-El; Fri, 14 Jun 2024 04:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sI2U5-00089O-Ct
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 04:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sI2U3-0006Kj-M0
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 04:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718354430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Di40dV4SSs5kMJaZgdTD6rwFFzH9EvZCzVhjMbPA1GU=;
 b=QpTpH07T7Wiya9JINU8ff23sC+qRrafCL/WQwaQCS/rOisgSYQUM/GE9fJqqlRLGJ4WDLS
 sQmGLd8qB5OcCRbZ31i2XlZhN0/QC+sywftn4/PnowUez5/HH2NJCaonxIa/eLbL8WGzz5
 IrxMDQQgqMe2sYk2HpcMhadEEABA9fA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-PQG8LGn7MIW45INI2kLaOA-1; Fri,
 14 Jun 2024 04:40:28 -0400
X-MC-Unique: PQG8LGn7MIW45INI2kLaOA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73EAC19560B0; Fri, 14 Jun 2024 08:40:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.178])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F028A19560BF; Fri, 14 Jun 2024 08:40:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DFDE01800D65; Fri, 14 Jun 2024 10:40:23 +0200 (CEST)
Date: Fri, 14 Jun 2024 10:40:23 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 2/4] usb/hub: mark as deprecated
Message-ID: <wq2clcaocpcyvbbeya3vu5at47mxpj2w5wfngxfg6hbluchl5p@hlc4rlztp6hg>
References: <20240606143010.1318226-1-kraxel@redhat.com>
 <20240606143010.1318226-3-kraxel@redhat.com>
 <ZmHKotWS7ywfIvOj@redhat.com> <87r0d2w431.fsf@draig.linaro.org>
 <ZmqxgAh1v6-Y8zjH@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmqxgAh1v6-Y8zjH@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

  Hi,

> > This does seem quite aggressive because there may be cases when users
> > explicitly want to use old devices. Maybe there is need for a third
> > state (better_alternatives?) so we can steer users away from old command
> > lines they may have picked up from the web to the modern alternative?
> 
> We've got 2 flags proposed in patch 1 - "deprecated" and "not_secure" -
> which we formally expose to mgmt apps/users. Both of these are actionable
> in an unambiguous way. An application can query this info, and can also
> tell QEMU to enforce policy on this. Both are good.

Well, given that people apparently don't want actually delete stuff
I'm not sure the 'deprecated' flag actually makes sense.

> The "better alternatives" conceptable, however, is an inherantly fuzzy
> concept, because "better" is very much a use-case depedent / eye of the
> beholder concept.

Well.  I think the use cases can be grouped into two cases:

  (1) Operating system museum.  People using qemu qemu to keep their
      beloved (historical) OS alive on modern hardware.

  (2) Virtualization.  Run your production workload in VMs.

For (1) "better alternatives" doesn't make sense because you have to
consider what your (old) guest OS supports.

For (2) I think it does make sense.  I'd be conservative here and would
define possible production workloads as "OS which is still supported
with security updates".  Hardware old enough to be supported by all
production workloads (which should roughly being 10-15 years in the
market) can go into the "better alternative" bucket.  Examples:

 - xhci is old enough and can replace ohci/uhci/ehci.
 - intel-hda is old enough and can replace ac97/es1370/sb/...
 - sata is old enough and can replace ide.
 - nvme isn't old enough yet I'd say (also no cdrom support so it
   can't fully replace ide/sata).
 - q35 is old enough and can replace pc.

> This would makes it difficult/impractical for an application to take
> action based on such a "better-alternatives' schema marker.  It would
> imply the application has to understands the better alternatives ahead
> of time, as well as understanding the end users' intent and that's not
> really viable.

Well, with the conservative classification it should be possible to
simply apply it universally.  Throw warnings or errors in case a device
with a "better-alternative" tag is used.  Or build qemu without these
devices.  Or move these devices to a sub-rpm (if modularized), so they
are not present by default but can be installed for the (1) use cases.

take care,
  Gerd


