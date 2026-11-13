Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E16C606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cfJb/DjN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrYl-0000wz-Vv; Fri, 13 Nov 2026 08:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRrYj-0000uy-0R
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 08:43:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRrYh-0007Tt-0D
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 08:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794577395;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=elYpq57Lxfy9z/+SMcCZ01IgK9M4KySEKylkgJT6IOA=;
 b=cfJb/DjNS2IQlGT8tslx8qWfVQ+6Wp85Vv7twx1NuRmDl24XwCty5CLupYfhvT3+JkBHOh
 w3w9+ESI5L+6VBRzIh7SKbC2b7dpdPIgbYk/drxlQ0s/NcLeieV5gUecpA5GveAGvzaqQ6
 WRivtD5YRfApR1zOm5ZJ+PtPjR5cHyQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-d9uRrGfkMcC2N-oKyOA8OQ-1; Fri,
 13 Nov 2026 08:43:09 -0500
X-MC-Unique: d9uRrGfkMcC2N-oKyOA8OQ-1
X-Mimecast-MFC-AGG-ID: d9uRrGfkMcC2N-oKyOA8OQ_1794577388
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 592421956048; Fri, 13 Nov 2026 13:43:08 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2CAB1800495; Fri, 13 Nov 2026 13:43:06 +0000 (UTC)
Date: Fri, 13 Nov 2026 13:43:04 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 00/48] hw: resolve QOM type conflicts in multi-target
 builds
Message-ID: <avcT6M1z-qxpkkmh@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <CAE2XoE8OvtmLOx9LqmL=aOu2ptu0UpFGYwOdU5YHQ3N=9e1rpg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2XoE8OvtmLOx9LqmL=aOu2ptu0UpFGYwOdU5YHQ3N=9e1rpg@mail.gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 11:08:02PM +0800, Yonggang Luo wrote:
> On Thu, Nov 12, 2026 at 9:31 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > When building a multi-target binary, QOM types from multiple targets
> > will be linked together. QOM types are required to have unique names
> > when registered, so linking multiple targets in turn requires QOM type
> > names to be unique across the QEMU codebase.
> >
> > Global QOM type name uniqueness is a desirable property for QEMU
> > regardless of multi-target work, so that QEMU presents a non-ambiguous
> > object model to applications regardless of context.
> >
> > In a multi-target binary, it is desirable to applications are able to
> > introspect all types linked into QEMU, when launching with '-machine
> > none'. Dynamic filtering of registered classes at runtime, to resolving
> > QOM naming conflicts is undesirable, as it requires introspection
> > to be repeated for each available target in order to discover the full
> > set of available types in a binary.
> >
> > Introspection is a fairly heavy weight process due to QEMU's vast size,
> > so enabling introspection to be done once only for all targets will be a
> > very significant benefit for management applications with a multi-target
> > binary.
> >
> > The glaring problem is that our historical design has led to multiple
> > targets all providing a 'virt' machine type, which leads to multiple QOM
> > types call 'virt-machine' which are all different.
> >
> > Having a common short name "virt" is a useful characteristic for users,
> > but this does not imply we need to use that as the basis for primary QOM
> > typename. It is sufficient to have an alias called 'virt'.
> >
> > In terms of implementation there are two core pieces
> >
> >  * An 'Aliased' interface which can be implemented by QOM types which
> >    want to support type aliases.
> >
> >  * A 'TargetSpecific' interface which can be implemented by QOM types
> >    which want to declare  they can only be used with a subset of targets.
> >
> > With those foundational pieces
> >
> >  * Machine implements Aliased and TargetSpecific
> >
> >  * query-machines reports multiple aliases and declared supported
> >    targets per machine for introspection
> >
> >  * All the 'virt' machines are renamed to $target-virt, and aliases
> >    added for the shorter 'virt' names to retain compatibility and
> >    convenience when a target is selected
> >
> >  * All the machines which have 'is_available' set now report their
> >    targets via the TargetSpecific  interface
> >
> >  * Creating machines validates declared targets from TargetSpecific
> >
> > An apparent design mistake in TYPE_ACCEL_CPU is resolved which allows
> 
> Target independent TYPE_ACCEL_CPU  is my first choice, if the QOM name is
> do not have to be kept, I think this is better.

TYPE_ACCEL_CPU is a name of an internal abstract class, so we
are free to change that.  IIUC, in this particular case even
the sub-classes are internal only.

Only the leaf-node classes which are used with public QMP or
command line args are formal public ABI.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


