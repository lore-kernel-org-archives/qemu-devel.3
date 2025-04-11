Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23943C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3BrY-0004Al-3f; Fri, 11 Apr 2025 06:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u3BrP-0004AB-TN
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u3BrN-0008W7-BY
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744368224;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eU3i7ksd+mJj3VuzUDa3za3WVC2XwEODdj0A4xtuMuY=;
 b=cXVfio/srXjlKtGXyfqUaFLZ57Z0Rfr6R/ZvfFf5oHMk477jjBl3X25T8GTtitwl7jgX09
 cYCgtAOlqlPHC0lsnHfSe1lDSpgjyTXAKYi/6uDhbgq8IBxzK7wFBMHtbjTFq1phAbGXMq
 9rSiNQxsoZetG1QzeZD84sJRNg6uvjg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-LhISw8rZP5K2bnIqjeJgdA-1; Fri,
 11 Apr 2025 06:43:42 -0400
X-MC-Unique: LhISw8rZP5K2bnIqjeJgdA-1
X-Mimecast-MFC-AGG-ID: LhISw8rZP5K2bnIqjeJgdA_1744368221
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 540DE1800262; Fri, 11 Apr 2025 10:43:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D0931801A69; Fri, 11 Apr 2025 10:43:37 +0000 (UTC)
Date: Fri, 11 Apr 2025 11:43:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, devel@lists.libvirt.org
Subject: Re: Management applications and CPU feature flags (was: [PATCH V1
 0/6] fast qom tree get)
Message-ID: <Z_jyVQMfRbWaM66y@redhat.com>
References: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
 <87friheqcp.fsf@pond.sub.org> <Z_YolW1Nw6Q_tsz6@angien.pipo.sk>
 <Z_jq5drO_25w0bC6@redhat.com> <87lds77zgx.fsf_-_@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lds77zgx.fsf_-_@pond.sub.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 11, 2025 at 12:40:46PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Apr 09, 2025 at 09:58:13AM +0200, Peter Krempa via Devel wrote:
> >> On Wed, Apr 09, 2025 at 09:39:02 +0200, Markus Armbruster via Devel wrote:
> >> > Hi Steve, I apologize for the slow response.
> >> > 
> >> > Steve Sistare <steven.sistare@oracle.com> writes:
> >> > 
> >> > > Using qom-list and qom-get to get all the nodes and property values in a
> >> > > QOM tree can take multiple seconds because it requires 1000's of individual
> >> > > QOM requests.  Some managers fetch the entire tree or a large subset
> >> > > of it when starting a new VM, and this cost is a substantial fraction of
> >> > > start up time.
> >> > 
> >> > "Some managers"... could you name one?
> >> 
> >> libvirt is at ~500 qom-get calls during an average startup ...
> >> 
> >> > > To reduce this cost, consider QAPI calls that fetch more information in
> >> > > each call:
> >> > >   * qom-list-get: given a path, return a list of properties and values.
> >> > >   * qom-list-getv: given a list of paths, return a list of properties and
> >> > >     values for each path.
> >> > >   * qom-tree-get: given a path, return all descendant nodes rooted at that
> >> > >     path, with properties and values for each.
> >> > 
> >> > Libvirt developers, would you be interested in any of these?
> >> 
> >> YES!!!
> >
> > Not neccessarily, see below... !!!! 
> >
> >> 
> >> The getter with value could SO MUCH optimize the startup sequence of a
> >> VM where libvirt needs to probe CPU flags:
> >> 
> >> (note the 'id' field in libvirt's monitor is sequential)
> >> 
> >> buf={"execute":"qom-get","arguments":{"path":"/machine/unattached/device[0]","property":"realized"},"id":"libvirt-8"}
> >> buf={"execute":"qom-get","arguments":{"path":"/machine/unattached/device[0]","property":"hotplugged"},"id":"libvirt-9"}
> >> buf={"execute":"qom-get","arguments":{"path":"/machine/unattached/device[0]","property":"hotpluggable"},"id":"libvirt-10"}
> >> 
> >> [...]
> >> 
> >> buf={"execute":"qom-get","arguments":{"path":"/machine/unattached/device[0]","property":"hv-apicv"},"id":"libvirt-470"}
> >> buf={"execute":"qom-get","arguments":{"path":"/machine/unattached/device[0]","property":"xd"},"id":"libvirt-471"}
> >> buf={"execute":"qom-get","arguments":{"path":"/machine/unattached/device[0]","property":"sse4_1"},"id":"libvirt-472"}
> >> buf={"execute":"qom-get","arguments":{"path":"/machine/unattached/device[0]","property":"unavailable-features"},"id":"libvirt-473"}
> >> 
> >> First and last line's timestamps:
> >> 
> >> 2025-04-08 14:44:28.882+0000: 1481190: info : qemuMonitorIOWrite:340 : QEMU_MONITOR_IO_WRITE: mon=0x7f4678048360 buf={"execute":"qom-get","arguments":{"path":"/machine/unattached/device[0]","property":"realized"},"id":"libvirt-8"}
> >> 
> >> 2025-04-08 14:44:29.149+0000: 1481190: info : qemuMonitorIOWrite:340 : QEMU_MONITOR_IO_WRITE: mon=0x7f4678048360 buf={"execute":"qom-get","arguments":{"path":"/machine/unattached/device[0]","property":"unavailable-features"},"id":"libvirt-473"}
> >> 
> >> Libvirt spent ~170 ms probing cpu flags.
> >
> > One thing I would point out is that qom-get can be considered an
> > "escape hatch" to get information when no better QMP command exists.
> > In this case, libvirt has made the assumption that every CPU feature
> > is a QOM property.
> >
> > Adding qom-list-get doesn't appreciably change that, just makes the
> > usage more efficient.
> >
> > Considering the bigger picture QMP design, when libvirt is trying to
> > understand QEMU's CPU feature flag expansion, I would ask why we don't
> > have something like a "query-cpu" command to tell us the current CPU
> > expansion, avoiding the need for poking at QOM properties directly.
> 
> How do the existing query-cpu-FOO fall short of what management
> applications such as libvirt needs?

It has been along while since I looked at them, but IIRC they were
returning static info about CPU models, whereas libvirt wanted info
on the currently requested '-cpu ARGS'

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


