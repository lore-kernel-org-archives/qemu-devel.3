Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E092BFCB636
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 17:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyYYY-0008Fv-Qi; Fri, 06 Mar 2026 12:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyYXh-00080r-PQ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:00:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyYXf-0007Oa-Ud
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772816447;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KLzwEjeBMchNV63gBdE1LUgL5fiWC1CwtrxXEtnhMUE=;
 b=GhJJ+DiTvhq9fUaoGOlrWVPkq7lKgBGhRwMD/uT7RB26UsDm6oFdhaEV46AQdsksIlAy/o
 /iiLIKHE0sI0fA1kcrz1az4SXVWKLMLu5tiQHiGfFQFhI66jbP7hT1SSnnJ9kZhmGJ6T1e
 OH++VCZNFwz2acMz90LKTt3XawA3wBQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-1UGYQnt4PeSY8rb9KvprZQ-1; Fri,
 06 Mar 2026 12:00:45 -0500
X-MC-Unique: 1UGYQnt4PeSY8rb9KvprZQ-1
X-Mimecast-MFC-AGG-ID: 1UGYQnt4PeSY8rb9KvprZQ_1772816444
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 742BF1955DA6; Fri,  6 Mar 2026 17:00:44 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.197])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1472F180035F; Fri,  6 Mar 2026 17:00:42 +0000 (UTC)
Date: Fri, 6 Mar 2026 17:00:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Avi Kivity <avi@scylladb.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/nvme: add `model` parameter
Message-ID: <aasIN6T7aN8RhUfz@redhat.com>
References: <20260302142831.1269291-1-avi@scylladb.com>
 <aaWhHEI4QaDINc8K@redhat.com>
 <CAF950WLOB1BXkJ+rmRea3nWuLRZG=O3gDas9HUhM1LMsmrnffA@mail.gmail.com>
 <CAF950WJJC+Wr+K4DQeyqM=_NdQfz=DJ+mN0fM-nyu0XBQe2pag@mail.gmail.com>
 <aal7cdCf2A0SUO_u@AALNPWKJENSEN.aal.scsc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aal7cdCf2A0SUO_u@AALNPWKJENSEN.aal.scsc.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

On Thu, Mar 05, 2026 at 01:47:45PM +0100, Klaus Jensen wrote:
> On Mar  5 13:11, Avi Kivity wrote:
> > On Mon, Mar 2, 2026 at 4:50 PM Avi Kivity <avi@scylladb.com> wrote:
> > 
> > >
> > >
> > > On Mon, Mar 2, 2026 at 4:39 PM Daniel P. Berrangé <berrange@redhat.com>
> > > wrote:
> > >
> > >> On Mon, Mar 02, 2026 at 04:27:48PM +0200, Avi Kivity wrote:
> > >> > Add a `model` parameter, readable with nvme-cli. This allows
> > >> > impersonating other disk manufacturers or hypervisors, similar
> > >> > to the the -smbios option.
> > >> >
> > >> > Signed-off-by: Avi Kivity <avi@scylladb.com>
> > >> > ---
> > >> >
> > >> > Disclosure: prepared with AI assistance. I believe it to be of good
> > >> > quality.
> > >>
> > >> Can you clarify how AI was involved,
> > >
> > >
> > > I asked an LLM (Claude) to add a model parameter to the nvme code, which
> > > it did, then I asked it to documented it, which it also did.
> > >
> > >
> > >> as QEMU's policy is to decline
> > >> any contributions where AI was involing in an authoring role:
> > >>
> > >
> > > Very unfortunate. It would have taken me an hour or two to re-orient
> > > myself in the code base, for something that took me a couple of minutes
> > > with AI.
> > >
> > 
> > So what's the verdict?
> > 
> > FWIW I think the probability of AI copying these few lines from some
> > non-GPL project is zero.
> 
> As maintainer I don't have a problem taking this patch, but I'm not sure
> how to deal with the policy in this instance.

When introducing the policy we had debated whether to allow so called
"trivial" patches where one might argue the copyrightability concerns
are negligible, but could not come to agreement on that matter so left
it as strict policy.

> Daniel, please advise if I can take this. I'd have written the patch
> like this myself.

To avoid having to exhaust time debating this, I've wrote new
patches myself without direct reference to Avi's proposal, which
do the equivalent thing, plus some more on top.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


