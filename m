Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28B6CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLTm-00017v-Gn; Tue, 19 May 2026 10:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPLTk-00017f-Ez
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPLTh-0004ZY-LV
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779201084;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type; bh=efQOIeCyf7KqJrHPQrhYs6ThaX0ggJUDrlt1Y9N8tLE=;
 b=a7ftSguxwbzCvKinvHioB8Xm5HVIWcITyZHmpwyTwaEFHGE7CrnUd0hjfB3SwMAKX3xQYt
 dUhX/kUiFSntKepd0t0f2oXQ0ejsaKppxER/uYiLJmBrfH0BqgSQv/P08zlDCVqPT0Hygb
 MJ6iXR3Di36+bZuNdX5KlYpSdOVVPuM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-BwUMONYyPc273EXlMfw06A-1; Tue,
 19 May 2026 10:31:17 -0400
X-MC-Unique: BwUMONYyPc273EXlMfw06A-1
X-Mimecast-MFC-AGG-ID: BwUMONYyPc273EXlMfw06A_1779201076
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EFFF18909A1; Tue, 19 May 2026 14:26:57 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.49])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDC7B19560A3; Tue, 19 May 2026 14:26:54 +0000 (UTC)
Date: Tue, 19 May 2026 15:26:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: RFC: GitLab issues for security disclosures
Message-ID: <agxzKzzDOJm1EU_v@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The qemu-security mailing list was created several years back now and
traditionally saw 1-2 disclosures a month at worst. This was manageable.

Since approx March 1st, the new normal is to see as many as 20 disclosures
in one single day, more than 200 in total now. This is unsustainable.
I was thinking we needed more people on qemu-security to triage, but IMHO
this won't really fix the problem.

This needs an issue tracker to cope with & email is not an issue tracker.
We faked an issue tracker with a shared spreadsheet to prevent us drowning
these past few months, but this is still not sustainable & probably won't
ever be.

The traditional POV was that security disclosures must be dealt with on
a strict "need to know" basis until there was a concious decision to make
them public. Typically that happened when a patch was published by the
maintainer on qemu-devel. Rarely have we applied an embargo period after
a maintainer had a patch ready to post, as most bugs were not severe
enough. Also in typical usage Libvirt has SELinux/AppArmour to mitigate
impact of a guest ecsape into QEMU.

QEMU is not alone in this chaos, to quote Linus

   https://lkml.org/lkml/2026/5/17/896

[quote]
  the continued flood of AI reports has basically made the security list
  almost entirely unmanageable, with enormous duplication due to
  different people finding the same things with the same tools. People
  spend all their time just forwarding things to the right people or
  saying "that was already fixed a week/month ago" and pointing to the
  public discussion.
[/quote]

They have explicitly changed their policy for disclosure now:

  https://github.com/torvalds/linux/commit/a03ef333fbd6cd861c8457c3d055ee3643a9baad

[quote]
  If you resorted to AI assistance to identify a bug, you must treat
  it as public. While you may have valid reasons to believe it is not,
  the security team's experience shows that bugs discovered this way
  systematically surface simultaneously across multiple researchers,
  often on the same day
[/quote]

IME for qemu-security we've definitely seen the same bugs reported by
different people, within days of each other, a couple of times even
the same day. Dupes are not the majority  - QEMU has so much low
hanging fruit - but they're a sizeable chunk.


Because we don't have a good automated way to publish disclosures
from qemu-security, we don't provide contributors any way to check
for duplicates before submission. The burden of checking for dupes
thus falls on the qemu-security triage people, or the maintainers
we forward issues to.

For disclosures in the non-virtualization use case, we ask the
reporter to file a gitlab issue or send a patch. They almost never
do this. We're lucky to have any reply to emails at all.


IMHO we need to move to an issue tracker. GitLab was originally
discounted in favour of qemu-security list since "Confidential"
issues cannot have visibility managed in a fine grained way.
They are visible to everyone with "Reporter" role or higher,
which is 70+ people for QEMU.

If we accept the kernel's view that AI discovered issues should be
considered public immediately because of the high chance of parallel
"discovery", then GitLab's limitations don't seem to bad.

It is also of note that we've had some people ignoring qemu-security
policy and directly filing public gitlab issues for stuff discovered
via AI/LLM agents already. Those are not getting attention for CVE
assignment, should it be needed which and can't be cross-referenced
by general maintaniers to stuff we have received via qemu-security.

We have some options IMHO

 1. Move all security disclosure to GitLab confidential issues
    no disclosures via email

 2. Move AI/fuzzer assisted disclosures to GitLab confidential
    issues, keep human discovered issues on qemu-security list

 3. Move AI/fuzzer assisted disclosures to GitLab public
    issues, keep human discovered issues on qemu-security list

In all three cases, if a GitLab issue is determined to be security
relevant, any maintainer could send a request to qemu-security list
to get Red Hat product security to allocate a CVE.

Out of those I'd probably lean towards (2) which is slightly
more restrictive than the kernel new policy but not by much.

Some key benefits of using GitLab for security disclosures

 * We can trivially make disclosures public if we classify them
   as a non-virtualization use case, or when the fix is ready.

 * We can formally track the lifecycle of disclosures through to
   the final fix, for both virtualization & non-virtualization
   use cases. The only difference will be that the former can
   request a CVE assignment

 * We can do reports/queries of outstanding issues
 
 * We can more easily use automation to process issues

 * Maintainers can see bugs without waiting for someone to triage
   and forward it on their way.

 * The small number of security bug triage people are no a bottle
   neck anymore

Some downsides/implications

 * Every disclosure in a confidential issue will be visible to every
   maintainer who has joined the qemu-project repo on GitLab. IOW
   that is treating every maintainer as equally trusted.

   We do have qemu-security though we could be mailed if someone
   considered their disclosure to be severely impactful but the triage
   team can't make that decision.

 * We must NOT grant membership to qemu-project at a Reporter level
   for anyone whom is not an active maintainer. They must be limited
   to the "Guest" role at most.

 * No one is formally responsible for GitLab issue triage. We have
   had Thomas do it in the past periodically with script assistance.
   We have Alex doing some of it now with bot assistance. The danger
   is security disclosures get ignored as "somebody else's problem"
   no one has accountability.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


