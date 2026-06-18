Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6746ACD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 13:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCgB-0008SQ-WD; Thu, 18 Jun 2026 09:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waCg9-0008SG-Sj
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:21:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waCg7-0001Gh-ES
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781788864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EycAvVuLn3+yNCyVX3zUTFQtoN0btFB93FwHwmKfCcE=;
 b=Zaln8JJ58I+EFjynU9Y6gP6oy0/Cg5d+DJU2JmLDdju9Rhf3KL3UpWOgB53vqQaK9w2hd2
 BDMtPBY+majqcG1LFEVKFPm1QRwHq86eq1hKURM44hUQ8EijoKSNln1nZHvgJpn4KKRS5i
 vdoCkr+FnR/WXmoh7rngOcerTXukZXg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-2BAb1gX7MX2-BVlihX39Bw-1; Thu,
 18 Jun 2026 09:21:03 -0400
X-MC-Unique: 2BAb1gX7MX2-BVlihX39Bw-1
X-Mimecast-MFC-AGG-ID: 2BAb1gX7MX2-BVlihX39Bw_1781788862
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A82C1956056; Thu, 18 Jun 2026 13:21:02 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.28])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BDA631956044; Thu, 18 Jun 2026 13:20:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [qemu-web PATCH v2 0/3] switch to GitLab confidential issues for
 security disclosure
Date: Thu, 18 Jun 2026 14:20:55 +0100
Message-ID: <20260618132058.1044341-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

With the move to use of the issue tracker, my intention is to
use a script to bulk import all disclosures received by
qemu-security@nongnu.org since March 1st 2026.  The imported
issues will reflect the current triage / resolution state of
each disclosure. IOW, completed issues will be immediately
marked closed upon import, non-virt use cases issues will be
marked public, and outstanding virt use case issues will
remain confidential.

The issue description will *NOT* be re-formatted according to
the QEMU bug template. Most disclosures have been provided
via email in markdown format, so this will be imported 'as is'
as the full description with no editting.

The "reporter" in these cases will be a throwaway "bot" account
but the orignal reporter's name, email, date and message-id will
be recorded.

Daniel P. Berrangé (3):
  contribute: reformat/restructure bug report guidance
  contribute: add automated tool disclosure to bug reporting
  contribute: switch security process to gitlab confidential issues

 contribute/report-a-bug.md     |  63 ++++---
 contribute/security-process.md | 309 +++++++++++++++------------------
 2 files changed, 184 insertions(+), 188 deletions(-)

-- 
2.54.0


