Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC3CD1039D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 12:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOEDJ-0002kg-SB; Wed, 26 Nov 2025 07:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vOECy-0002eR-GA
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:01:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vOECw-0005eh-L3
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764158471;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0aRYLyciveQYGVv6knn3FZcsGQmfiDY+JOGWJa9G+U=;
 b=aJOdxOgCI1Gm7LqxiQ7Veve8O6dNvvNBhIOSQLmVwcLLvG4hExaRUx6ckSTFZaEKGqf/ww
 L+KtSoWnLvOS9/9INBAvduKgfHej14DCx5uVSN+YoO1J78U8jGtm6+FmFNjSnaor0/SY1E
 KrnCrbPTc6bjXnRZHlqLK8hjI7zRHMc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-rRefW3i2PnOdVseySCfqag-1; Wed,
 26 Nov 2025 07:01:07 -0500
X-MC-Unique: rRefW3i2PnOdVseySCfqag-1
X-Mimecast-MFC-AGG-ID: rRefW3i2PnOdVseySCfqag_1764158466
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 675441954B24; Wed, 26 Nov 2025 12:01:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A557180094B; Wed, 26 Nov 2025 12:01:03 +0000 (UTC)
Date: Wed, 26 Nov 2025 12:00:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 farosas@suse.de, peter.maydell@linaro.org
Subject: Re: g_autoptr(Error)
Message-ID: <aSbr--ZbqzKVNDuC@redhat.com>
References: <20251125070554.2256181-1-armbru@redhat.com>
 <871plmk1bc.fsf@pond.sub.org> <aSWSLMi6ZhTCS_p2@redhat.com>
 <87jyzexrly.fsf@pond.sub.org> <aSXWKcjoIBK4LW59@x1.local>
 <769f5a57-7006-4cef-a5cb-12d53b7c30a5@redhat.com>
 <c0aa79ad-d6f4-413f-ade6-43e7609e37ac@redhat.com>
 <87ecplc8yn.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ecplc8yn.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Nov 26, 2025 at 12:46:40PM +0100, Markus Armbruster wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
> > On 11/26/25 09:19, Cédric Le Goater wrote:
> >> On 11/25/25 17:15, Peter Xu wrote:
> >>> On Tue, Nov 25, 2025 at 12:46:01PM +0100, Markus Armbruster wrote:
> 
> [...]
> 
> On the review and merging of commit 18eb55546a5 (error: define
> g_autoptr() cleanup function for the Error type):
> 
> >>>> I missed it.  Not he submitter's fault; it was cc'ed to me.
> >>>
> >>> If someone to blame, it's the reviewer.
> >> At end, I was the one who merged this stuff. My bad.
> >>
> >> I felt confident at the time, as it was only a single-line change reviewed
> >> by a subsystem maintainer and the patch was large enough that this didn't
> >
> > s/patch/series/ makes more sense.
> >
> > Sorry for the noise.
> 
> > C.
> >
> >
> >> raise my attention.
> >>
> >> But it should have been treated with greater caution, global features must
> >> be introduced together with concrete usage proposals. I think this would
> >> have raised some unconscious red flags.
> >> Thanks,
> >> C.
> 
> Don't worry about it!  From my point of view, the process worked okay.
> A big series got reviewed by maintainers, except for one little patch
> touching another subsystem, where that subsystem's maintainer (me)
> remained silent.  The series was then merged without further delay.
> 
> Would I have appreciate a timely nudge on that little patch?  Sure.  Is
> not nudging me a failure of sorts?  Nope.

The other thing that plays in here is that we actively encourage use of
g_autoptr everywhere. It is very unusual for "Error" to be a type that
does NOT want g_autoptr, and thus the mistake is very much on the cards.

I've proposed it before myself & Markus caught it. I also caught one
other proposals to add it since my attempt. This third time it slipped
through review. I expect we'll see a 4th attempt to add it at some point.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


