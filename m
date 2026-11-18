Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E31606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Oeg7oiLS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTd78-00022S-Cd; Wed, 18 Nov 2026 05:42:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTd77-00022I-5y
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 05:42:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTd75-0007qp-GF
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 05:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794998522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B9yAUZSrn3unSmAM6gFu6tLwtix7WZyphIH+7ks4P7w=;
 b=Oeg7oiLSOMQq3ABW2o1lAej6RGBqzUpo+wEmHnNediH8Nc6jKO9PDxe/yiadm4VYZYSsHP
 xTacfHEf5Cv8JdA7HI9ckIDuaAByM73ns2Qgu3iOuGZHyNWAXve2yTKwmNnscLL37X4ukf
 v0NNoSDbLC4vBZvrk6c8kMfLBDctDK4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-zTi5J_XnPKS9jcxHhEh8jw-1; Wed,
 18 Nov 2026 05:41:58 -0500
X-MC-Unique: zTi5J_XnPKS9jcxHhEh8jw-1
X-Mimecast-MFC-AGG-ID: zTi5J_XnPKS9jcxHhEh8jw_1794998516
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 132751956063; Wed, 18 Nov 2026 10:41:56 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E01D195B3C2; Wed, 18 Nov 2026 10:41:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 0/4] docs/devel,
 AGENTS.md: a completely new policy on AI-generated contributions
Date: Wed, 18 Nov 2026 11:41:46 +0100
Message-ID: <20261118104150.599535-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In preparation for the next community call, here is another version of
the new AI policy.  Discussion after v4 centered on two points, namely
large contributions and cross-subsystem changes.  In order to facilitate
reaching a consensus, I am splitting the part about larger contributions
to a separate commit that can or cannot be included.

I will leave out from the cover letter the blurb on why reviewing the
policy and the benefits/risks that it entails.  As before, the change
seeks to ensure clarity on the part of contributors, and to have AI usage
that helps us produce better code rather than flood us with dubious work.

Trying to split out large contributions made me realize how hard it is
for such a policy to be balanced.  In my opinion, the version that
does *not* allow large contributions makes the job harder for
maintainers, because it does not provide a sanctioned way to grow
a steady stream of small but useful contributions into something more
structured.  I've tried to put my thoughts in the commit message of
patch 4, which also covers cross-subsystem changes.

As before, the patches introduce agent instructions that help the
contributor drive the design and understand the code produced by the LLM;
the instructions are also split into "no large changes allowed" and
"large changes allowed" parts.

I chose to move the Reviewed-by tags to the *last* patch, including the
large contributions part, since that is effectively the version that was
reviewed.

Paolo

v4->v5:
- "AGENTS.md: add final instructions" already merged
- fix rST syntax
- section "No automated posting" in AGENTS.md revised and expanded;
  same for the "official project agents" exception in the policy
- "``AI-used-for`` must not be included unless some part of the patch
  *content* was authored by the AI" added explicitly
- disclosure required for all non-trivial, functional code changes,
  even if only a small part of a larger patch
- "docs/devel: allow larger contributions with pre-arrangement" split
- minor wording changes, mostly to allow separating patch 4

Paolo Bonzini (4):
  docs/devel: relax policy on AI-generated contributions
  AGENTS.md: let agents know what the participation rules are
  AGENTS.md: make the human part of the design process
  docs/devel: allow larger contributions with pre-arrangement

 docs/devel/code-provenance.rst |  71 +----------
 docs/devel/index-process.rst   |   1 +
 docs/devel/llm-usage.rst       | 208 +++++++++++++++++++++++++++++++++
 AGENTS.md                      | 138 +++++++++++++++++++---
 scripts/checkpatch.pl          |   5 +-
 5 files changed, 343 insertions(+), 80 deletions(-)
 create mode 100644 docs/devel/llm-usage.rst

-- 
2.56.0


