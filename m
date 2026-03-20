Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC32E109318E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 08:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3VdE-0003MB-DN; Fri, 20 Mar 2026 04:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w3VdC-0003Lt-Dl
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 04:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w3Vd9-0001Tj-Ev
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 04:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773996893;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=igIg84ihIrwBcafUy0gr3URY7yCRsQi0aXdQlqRC/54=;
 b=aHJR2Q2Hj9a8ZMikKbRLOGf2++Pk6V2wpjCzaEHirmCRPeqXhAmBo+A2Rw5VbWK6HYBHZp
 HsnxWAEKXIp2DfCDUcWIsQoXvv7cXS9CNZ3UX90Q2gvZVPLOoIWHhZJEexFTmDM3gaqKda
 MI0qvNM2BLIaUmt4j0CF/TtsJ3O5H6E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-MXsFAsWENIy97m_QN-1iXg-1; Fri,
 20 Mar 2026 04:54:51 -0400
X-MC-Unique: MXsFAsWENIy97m_QN-1iXg-1
X-Mimecast-MFC-AGG-ID: MXsFAsWENIy97m_QN-1iXg_1773996890
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9696818002CD; Fri, 20 Mar 2026 08:54:49 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.255])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57DA030002DF; Fri, 20 Mar 2026 08:54:47 +0000 (UTC)
Date: Fri, 20 Mar 2026 08:54:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Development <qemu-devel@nongnu.org>
Subject: Re: QEMU requires a 64-bit CPU host architecture?
Message-ID: <ab0LPpXlojZHtMZQ@redhat.com>
References: <2c0d6ae0-eb06-4eed-87fe-0954ae59d951@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c0d6ae0-eb06-4eed-87fe-0954ae59d951@tls.msk.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Fri, Mar 20, 2026 at 09:45:20AM +0300, Michael Tokarev wrote:
> Hi!
> 
> Is it intentional that qemu does not build utilities on 32bit hosts
> anymore?

Yes, per this note:

  https://www.qemu.org/docs/master/about/removed-features.html#bit-host-operating-systems-removed-in-11-0


> I understand system/user emulation on a 32bit host, where there are
> quite some real difficulties with address space sizes.
> 
> But what's wrong with building qemu-img et al on a 32bit host?  It
> doesn't require 64bit address space..

While the acclerator burden was one big factor, there were other
code removals enabled by dropping 32-bit hosts, such as removal
of 64-bit atomics emulation, and removal of some back compat
definitions for 32-bit kernels, and simplifying assumptions about
CPU features in other code, all of which leak out into common
code used by qemu-img & similar tools.

Keeping an arbitrary, and continually changing, subset of QEMU
supporting 32-bit while most code dropped 64-bit would not be
fun situation for maintainers, even with CI to try to detect
problems.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


