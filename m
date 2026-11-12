Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22A6606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hKqBjMLu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRVFM-0000p2-6z; Thu, 12 Nov 2026 08:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRVFI-0000la-DA
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:53:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRVFG-0004uZ-80
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794491620;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZrYVlB9dGaCokMXc4LampFipwKZHyIqTDYlmcJZE6oU=;
 b=hKqBjMLuIWXr45049llrVe3cRh65KMHranukHUp6NF56fOEb/5x+oJZA9K29AclWRkkigt
 j8IqegqNptO73T0loP91jF2NE7A759vVP2FxIpCb0Qjgliex5XO9aGFiDir3pDkTEMRXqS
 XvJ8SaMOZddnIsw+GZYfiwRmV0CgPhs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-OUHkWUiTMUiexkLwgEAkCA-1; Thu,
 12 Nov 2026 08:53:38 -0500
X-MC-Unique: OUHkWUiTMUiexkLwgEAkCA-1
X-Mimecast-MFC-AGG-ID: OUHkWUiTMUiexkLwgEAkCA_1794491617
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75A5A1953949; Thu, 12 Nov 2026 13:53:37 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C0A330000E5; Thu, 12 Nov 2026 13:53:35 +0000 (UTC)
Date: Thu, 12 Nov 2026 13:53:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>
Subject: Re: [PATCH 0/5] qom: prepare a TypeBucket for same-name target
 variants
Message-ID: <avXE3JuiDyBxpm5_@redhat.com>
References: <20261105190346.1539-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261105190346.1539-1-luoyonggang@gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Nov 06, 2026 at 03:03:41AM +0800, Yonggang Luo wrote:
> This series prepares QOM to hold more than one TypeImpl under the same name, one
> per target, so a multi-target binary can register same-name types without
> renaming them. Nothing uses it yet.
> 
> type_table maps each name to a TypeBucket, which holds the variants and the
> union of their QEMU_ARCH_* masks. Registration still aborts when masks overlap,
> and a name lookup returns the one variant left for the selected target.
> type_register_targets() registers a variant for a target mask.
> type_register_static() is unchanged, so binaries keep one TypeImpl per name.
> 
> The change stays in qom and target-info and does not conflict with the virt QOM
> name or is_available series.
> 
> Daniel asked what a TypeBucket means. This is that prototype, based on the
> bucket idea from Pierrick.

Thank you for sending this.

IIUC the overall idea here is not all that different from the
existing 'is_available' callback approach. It is still allowing
us to have multiple different classes registered with the same
name. Instead of a opaque callback being used for the filter,
each type is tagged with an explicit target, which can be
filtered on.

So the end result is still the same, we have multiple QOM classes
with the same name, and dynamically filter which are visible to
the management app at runtime. It is slightly better in the that
filtering is data driven, instead of callback driven, but IMHO
this still doesn't address the fundamental historical design
flaw of having clashing QOM type names.

IMHO we need to work from a principal that we should produce a
This gives us a unified type model across the whole of QEMU which
is *invariant at runtime*.  This means type names must be unique
and statically defined at build time, and that properties must
be unique and unconditionally defined against classes at build
time.

The property part in particular is not tied to the multi-target
work. We have other technical debt cleanup work going on that
moves from registering properties against the object instance,
to registering properties against the object class, to produce
an invariant class definition. Removing target-specific property
registration is a natural part of that we would want to do even
without the multi-target motivation.

I've proposed a refinement of my previous PoC from last week that
properly adapts the machine types to unique names:

  https://lists.gnu.org/archive/html/qemu-devel/2026-11/msg02706.html

and pulled in your patches for removing target specific properties
there, since although not a dependency, it is complementary.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


