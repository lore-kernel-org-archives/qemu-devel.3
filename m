Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1397C606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FEg8pxsT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVtbU-0000VP-2H; Tue, 24 Nov 2026 11:42:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xVtbC-0000Ty-EY
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 11:42:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xVtbA-0006xT-Oy
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 11:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795538546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=igcAd0+EXNtgU7LTJt/wawgRFnD994zqYH9FjHu5xt0=;
 b=FEg8pxsT1oy3h2naFG8iQ9/M6/YHxJX8u9av9RVM16bHJJywVsyEkS+kTIXhJGTc30v6Li
 HMXmGdtMwzraX/k87XSbDS+Al2siYJ3h7GNSr3F5m/R/K71wdEVGZ1C/4budjuxhFSMwek
 npZHVKjk7I1nj5JtcWCeAQ5rwQHLy3k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-m5sWPsLjM8WLNdtbawC7pw-1; Tue,
 24 Nov 2026 16:42:22 +0000
X-MC-Unique: m5sWPsLjM8WLNdtbawC7pw-1
X-Mimecast-MFC-AGG-ID: m5sWPsLjM8WLNdtbawC7pw_1795538541
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0BA819560B9; Tue, 24 Nov 2026 16:42:20 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 906C030001A2; Tue, 24 Nov 2026 16:42:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, peter.maydell@linaro.org, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, alex.bennee@linaro.org
Subject: [PATCH v6 0/3] docs/devel,
 AGENTS.md: a completely new policy on AI-generated contributions
Date: Tue, 24 Nov 2026 17:42:14 +0100
Message-ID: <20261124164217.1768040-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As agreed in the community call, I'm posting a cleaned up version of
v5 patches 1-3, not including the permission for pre-arranged large
contributions.  However, the full text of AGENTS.md is included, as
that can be a useful way to steer agents in our preferred direction,
even for contributions not allowed by the policy.

To be clear, I don't think this is a particularly useful intermediate
step.  It all but encourages the same "don't ask, don't tell" behavior
that we had until now, perhaps even more since it does not mention
copyright anymore and therefore does not explain _why_ large contributions
are disallowed.  Also like the current prohibition, we won't get any
information other than gut feelings about when this happens.

To avoid that, I would like to have already an informal process for
evaluating AI-based contributions openly and on a case by case basis,
to understand what their prevalence could be and the impact on maintainer
review workloads.  (Personally, I'm more worried by a large amount of
small contributions and no path towards getting help in consolidating
them, than by a few large ones; but that may admittedly vary by subsystem).

Nevertheless, I plan to send this as a pull request next week, and keep
the rest for discussion in future months.

All changes from v5 are to the commit messages, other than removing
this sentence.

  No such agent currently exists; in the future, such official
  agents will be listed in the documentation.

Paolo

v5->v6: drop references to pre-arrangement in patch 1 commit message
        drop examples of agent behavior that were done on previous versions
        drop patch 4
        
Paolo Bonzini (3):
  docs/devel: relax policy on AI-generated contributions
  AGENTS.md: let agents know what the participation rules are
  AGENTS.md: make the human part of the design process

 docs/devel/code-provenance.rst |  71 ++----------
 docs/devel/index-process.rst   |   1 +
 docs/devel/llm-usage.rst       | 191 +++++++++++++++++++++++++++++++++
 AGENTS.md                      | 133 ++++++++++++++++++++---
 scripts/checkpatch.pl          |   5 +-
 5 files changed, 321 insertions(+), 80 deletions(-)
 create mode 100644 docs/devel/llm-usage.rst

-- 
2.56.1


