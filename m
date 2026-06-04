Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64BBCD6E77
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 16:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVBHe-0004F4-88; Thu, 04 Jun 2026 12:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVBHb-0004Di-O7
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 12:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVBHa-0000js-1E
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 12:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780591860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bkLw2slq5pbLD39+bSQqKXGUC+kIR3vdzza2hCdSQ9k=;
 b=GDYGBSQBOw3gHBCoenJiLUvxdVL0LVKbTCQzfT45Rb2BFPcVXLoxe6i08ciFl0VCkj/3u+
 Ff6bPE71OiFSoAbLpxvXXt/QhazbgslyMFya1A+6faQIabkLB5YtHMQEOw1LhqakcmWrxU
 gR8zpg2e1SqWkbcfAVJJSg3FhS7jW9Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-flgM5vfxMv6Ns0vBNj7rHg-1; Thu,
 04 Jun 2026 12:50:56 -0400
X-MC-Unique: flgM5vfxMv6Ns0vBNj7rHg-1
X-Mimecast-MFC-AGG-ID: flgM5vfxMv6Ns0vBNj7rHg_1780591855
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 871A21800365; Thu,  4 Jun 2026 16:50:55 +0000 (UTC)
Received: from berrange.com (unknown [10.44.50.34])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 62D0E1800480; Thu,  4 Jun 2026 16:50:52 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [qemu-web RFC 0/3] switch to GitLab confidential issues for security
 disclosure
Date: Thu,  4 Jun 2026 17:50:45 +0100
Message-ID: <20260604165048.457860-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I previously raised the idea of using GitLab issues for security
disclosures:

  https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg04582.html

This patch proposal formalizes that into a concrete proposal:

 * qemu-security is entirely discontinued

 * "confidential" GitLab issues are to be used

 * The priority is to have a low overhead process that is
   as close to normal bug & development workflow as
   possible.

 * No embargoes will be accepted, beyond the time needed
   for a maintainer to develop a patch, unless extenuating
   scenarios apply. A vendor's/user's desire to delay to
   suit their arbitrary software upgrade schedule is NOT
   an extenuating scenario.

 * All confidential issues will be expected to be made
   public, either when the patch is proposed to qemu-devel,
   or sooner if a issue is low severity and a patch is not
   a priority for the manitainer

 * Eliminate dependency on any single maintainer/person to
   the greatest extent practical

Some open questions

 * I describe using "cve::required" as a gitlab label to
   track issues that need CVEs allocating. I'm unclear what
   the best way is to actually do the allocation. This is
   where it is hardest to eliminate the single person
   bottleneck / burden.

   Traditionally I would email Red Hat product security via
   Mauro (CC'd) but that's still a single point of failure.

   I'm personally not willing to sign up for QEMU to be a
   CNA, because they have unreasonable expectations for
   volunteer projects. I'm not going to give them my phone
   number nor agree to any SLAs for response to query.

   From a selfish QEMU upstream maintainer POV, I would say
   that CVEs are largely devoid of value. The people who
   care most about them are the downstream vendors who
   ship old QEMU versions and track bugs for backporting.
   If we want to pull a security fix into our stable release
   branches we can do that easily without a CVE.

   Thus one nuclear option is to say "not our problem" and
   no longer assign CVEs at all. Instead assign a unique ID
   of QEMU's invention "QEMU-SEC-nnnnn", and let downstream
   vendors take the pain of allocating and mapping QEMU's
   identifiers to CVE identifiers.

 * We have >100 disclosed issues to qemu-security
   that were classed as non-virtualization bugs which
   I asked the reporter to file gitlab issues for.
   Almost no one followed up to do that. I don't want
   these bugs to go into a black-hole as they are all
   basically valid, but I also don't fancy bulk filing
   100's of issues from my own account.

   There are also more non-triaged issues some of which
   are valid security bugs which ought to be tracked
   rather than sucked into a black-hole. Again that
   implies more bulk filing of bugs :-(

 * Moving away from a small dedicated group of people
   handling security reports, to a distributed
   responsbility has a notable risk - every maintainer
   may consider it "someone else's problem" and ignore
   security disclosures. Some poor sucker then gets to
   run triage across an ever increasing set of issues
   and try to encourage maintainers into responding.

   Based on our experience with normal bug triage work,
   I'd say it is a near certainty that this will happen
   to some extent.

   I don't have any answer here other than even this
   bad outcome will probably be less bad that the status
   quo with qemu-security email disclosure. Personally
   I can/will not continue with the email workflow any
   more.

   IMHO this mostly points towards the downstream vendors
   needing to invest more in QEMU if they want to have a
   guaranteed security SLA upstream.

Daniel P. Berrangé (3):
  contribute: reformat/restructure bug report guidance
  contribute: add automate tool disclosure to bug reporting
  contribute: switch security process to gitlab confidential issues

 contribute/report-a-bug.md     |  63 +++++---
 contribute/security-process.md | 280 ++++++++++++++-------------------
 2 files changed, 155 insertions(+), 188 deletions(-)

-- 
2.54.0


