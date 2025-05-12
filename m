Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93802C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEY2m-0003OA-SN; Mon, 12 May 2025 14:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEY2e-0003I8-Tn
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:38:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEY2c-0004EH-Gx
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747075097;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMAnQk66oVPj8Mjos3U3u2tAvgXVUMwSTvkBFFFM0lQ=;
 b=KZ14qMV9DpFf6dBDGwcbtic3LVNamPm7zanG81TwyxF8YcGnF2HRXUpzp4JS1sfpa2M+ge
 y9upo2+QSajqY2UEmWkL4N21imAE7SnT0mfqe3LoCCqHoP0nB50Xruc4rOk3EcgJJDkG2t
 yieVxmd/dgEva4Jn679dORtOeVv1MFM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-1EYA3Mb4MNS5G0SlRhi-tA-1; Mon,
 12 May 2025 14:38:14 -0400
X-MC-Unique: 1EYA3Mb4MNS5G0SlRhi-tA-1
X-Mimecast-MFC-AGG-ID: 1EYA3Mb4MNS5G0SlRhi-tA_1747075093
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10BC01800DA1; Mon, 12 May 2025 18:38:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.162])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C15A130001A1; Mon, 12 May 2025 18:38:10 +0000 (UTC)
Date: Mon, 12 May 2025 19:38:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH RFC 00/10] qapi: remove all TARGET_* conditionals from
 the schema
Message-ID: <aCJADz2WhyOBYy3H@redhat.com>
References: <20250508135816.673087-1-berrange@redhat.com>
 <c7623b1c-01c1-46c0-bfa6-dc34aa4e722d@linaro.org>
 <aB3EpKu0iafLtgVT@redhat.com> <874ixt6gsd.fsf@pond.sub.org>
 <aB4JiDnVE8XrVfax@redhat.com> <874ixt2e2l.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874ixt2e2l.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sat, May 10, 2025 at 08:08:02AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, May 09, 2025 at 03:43:30PM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> > Even if we had a QAPI schema that didn't vary per target, this is
> >> > repeated probing is tricky to avoid when we have completely independant
> >> > binaries. We would need QEMU to have some internal "build id", so that
> >> > we could detect that all binaries came from the same build, to let us
> >> > avoid re-probing each binary.
> >> 
> >> Back when I created QAPI/QMP introspection, I floated the idea to put
> >> something into the QMP greeting to enable safe caching.  Libvirt
> >> developers told me they didn't need that.  I don't remember the details,
> >> but I guess the cache invalidation they already had was deemed good
> >> enough.
> >
> > I don't recall that discussion, but I would think the problem is
> > that we probe much more than just QMP schema. Actually thinking
> > about it, the fact that we probe more than just QMP schema means
> > my idea of probing once and getting the answer for all targets
> > may not be practical. Some of the query-xxx  commands we run will
> > likely need to know the target.
> 
> Yes.
> 
> We could split the cache along validity conditions.  Possibly worth the
> extra complexity if expensive probes then live longer in their cache.
> 
> I'd love to have a list of probes libvirt runs and why.

We don't record the 'why' I'm afraid, so answer the 'why' is pretty
much a case of having to read the code :-(

The list of probes is also somewhat metadata driven, starting
from:

 https://gitlab.com/libvirt/libvirt/-/blob/6ff8d08777ebbcb9a1e11534c3a3341fbf0343e8/src/qemu/qemu_capabilities.c?page=6#L5718

you would have to then work backwards for each virQMEUCapsProbeQMP
method we call.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


