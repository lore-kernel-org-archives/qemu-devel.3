Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6E6606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=lDIxwZrS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yKl0rWfM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xThAu-00051O-2L; Wed, 18 Nov 2026 10:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xThAm-00050w-DY
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:02:08 -0500
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xThAk-0002sU-77
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:02:07 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id C09ACEC0B15
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 10:02:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 18 Nov 2026 10:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1795014124; x=1795100524; bh=NQ
 QD3/OlmmsFL5WYv15XcdSNCIM3rUzjmbRyidbYVss=; b=lDIxwZrS+4SvBYDmXE
 lTPaBP7dTgyHqrGdHNzBN6163zYon32H7NvbCXRLmfziU0S6fwVcIMcVwpADLD9s
 GW1RHDihe61lK9CoeM+iLlz+XB4dhpa5A9CfAaiAXb3jbKDx9Pbk/nyOuJbDBCBM
 4Ee42rB7tnGPUjwHJPS1cYvx+6kZHYM4NMiSZR17Ox7whGB/xonkOsoQFCOnISpZ
 srK8iD+wiIBjvFE2pCxBAasSTOh4tOF2xntSZ5E0LL4/13lkDiXxaR+0OHh7elyz
 ckjPDvJ20UCieSZq1puMD3R2JJR8rjEluclTlBk5dlL6av4Ox6Y80fqlkOfy1XJ/
 wwVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1795014124; x=1795100524; bh=NQQD3/OlmmsFL5WYv15XcdSNCIM3
 rUzjmbRyidbYVss=; b=yKl0rWfMMZC7pIQpmWxxSnrURVXunKsI0B+xPBz0Bmpy
 Ie6FyalU9iWQqi0XCQBFLAvff/6+XIaFk1z4MZcWerj+CTK2jnSpb37JIA/R93Mb
 F8izhCmA55rP28bsOSK6tEs9ekZsCk8rRqlrmIAhsD6MK/5ySnviJ7FIQC0HsyUy
 MB9JtmGTw12yi7S7/me4PMEAE0hjhuXvLuPG0nHCouvP6NxR8ih7YLGyIkmBMxRa
 w8Ky8IgoMrI3lhEr0u9jh12aNp7NJakbY+nzYR+9O0zY8SscjqJFYpkjpwK/N9/m
 Ygw5zOEurbHJhdh9XkPorg6pZIXBI0KY7dghbgRrPg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795014124; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:SMtjyxrkV/R1qEmeNJeoG8d8ql0dJds+uftPKBICoKbw22B
 c2rYgOH54RZyLP4OURZeHjvtVkf4d/tj6+2JpTUJLBafdtKrcqlXCEVnOPEy45pS
 q9jJ9L5ynXMYUe7rG2PtnKqHQJT8UWfNTX/jm3WESb6iBqkv0vJ1k6jyoY3h7MOl
 Plgom15Ul8UyZs2NtIEDP6zTxBGMi7JdxBV3eECcVrLF+PIUrA2K6m1psPMOJZSQ
 anhe+6XXwKPI4vkcOFrHJTL1L0xRSyYSY2jidk6qt5ilIdHA2ozGeG3mI4HQTY3G
 E6GvHZ60DKWO6lpssB/VaOF/yCV2fKdWQb+R+Gw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:xWYneLSLbOqpctYp1KhtccmJwbFDdHcJlSXo543nzO4=:EmvOm3niT8a4Y2kpEybWspyoJx+Yva073T4I6lRwvMo=;
X-ME-Sender: <xms:6739aqekV8gskwFS3QuJM0v3R3u0rDDkJQ1oZP_468dkM2DiWwuhUg>
 <xme:6739atJ-L6vBJnzY0jvfOQKq9DagvQX5vAAncUgU50adlRI7Btx52_XyM644IplRC
 qI_Dip81qr2mTlbKp9hMy7zRaqH2eLmK1Ln02TUV5tbJCn6szF5yaFQ>
X-ME-Received: <xmr:6739anHz-uourvntMu0kJdJDbs-pw8624cGNb7pHaLrCOVG1UaKSSljVPV-GcSpMg3k>
X-ME-Proxy-Cause: dmFkZTGlN/iwvpO7W5TKdZzuPp+cPO7BGkCSncp6CyU4R7AIJ5zwoFk3d594xtz8ImL1e2
 W3Su3TqgoLHi+M0HKGbpaTFXp1dEVH4zZTRDpzrkrwrMh3IWARwPFpdw7NBUxZNxLw9nQp
 cI84rhUDGyLEKkvgu94MRlQiGocbz/hA6J61qbkCFcBnu70ZVhJZrUOwvMw+JZoIBCXTYx
 lNCcQzLCS1RKBRAN0ot1nHz1hL2mIrb6dU8xEmNzoj1qKnmsh5lRyDyBJPVerfTztKqcsM
 28jazJBWURMN034aVPRQ5KXn9wmf5CWCYBka3ILo7EHf59yBu6fe/Pouy1RhuBetLMg6g/
 sH1p+fbuGwX0GYswVatJnR7SQ2hgIwJ8ycOpSbrnvP5sKJvus3JDLvUV69ScmjKDh1joQZ
 Gt/JkHDNC2RSgF7vf3wKeipIk0BUmNlZutblX6hrvX0N80x0aNaPwC+uoWMXYTNA/F2BbQ
 KLZWv9Ai3gaBSyfONb4snC4HbwRIjaIiOSn99E3HNoHJK7b3HGdgco4Ya/WTreYqdZPCbN
 nGHSpLz2JtqBilW2LOXX/iIRwojbEcZMAoREMIX9kHJvjlmawdyow0x1xrct/J6RI1jBgB
 S7OFXwfeXu5ZBDgvvkZ94fwE9A41mwAP7kNit9KFaMLcMBrbUNBy6wY46NWg
X-ME-Proxy: <xmx:6739aoBuLuWkuNyKWmhntvKPMruNvyUxoO9FuVBu-tzdJFIYAS1_Vg>
 <xmx:6739ai9nz3KWMOqGIT98AOvwN6zBt7FhVjzt9iUXNVjcNPVBGorKOA>
 <xmx:6739asCYRP4ZwxjVrYEX9jB1YbwXNjZRExU0OfOgm637cL6uBT7ivQ>
 <xmx:6739avRY55vXba2DQqcKRHIpzKBPeu88Z1q77bjUaNT5gyeHiW1zyw>
 <xmx:7L39alhLOYFqlQk_gN2toeTLjUuxNYAJLT_3BTvDmINsieTmDQ1AQjPr>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 10:01:51 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Subject: [PATCH 0/7] hw/nvme get-/set feature fixes (FDP-related)
Date: Wed, 18 Nov 2026 16:01:27 +0100
Message-Id: <20261118-jwd-181126-fdp-fixes-v1-0-ed76fad7861d@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMi9/WoC/x3LQQqAIBBA0avErBtopEy7SrSQHGtaWChUEN09a
 fn4/AcyJ+EMQ/VA4lOy7LGA6grm1cWFUXwxqEZpIjK4XR7JECmNwR8Y5OaM1tnQUu9NZxjKeiT
 +QznH6X0/ZOzYlGYAAAA=
X-Change-ID: 20261118-jwd-181126-fdp-fixes-9a9f417d858e
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Jesper Wendel Devantier <j.devantier@samsung.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=103.168.172.146; envelope-from=foss@defmacro.it;
 helo=fout-a3-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Two generic fixes for nvme_get_feature - namely checking for invalid
SEL values and rewriting the checking of NSID- and ns lookup checks
for features operating on a namespace.

Otherwise fixes target features 1Dh (FDP) and 1Eh (FDP Events).

Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
Jesper Wendel Devantier (7):
      hw/nvme: get feature - return invalid field if sel is reserved
      hw/nvme: get feature - fix and revamp NS/NSID checks
      hw/nvme: fdp enabled helper
      hw/nvme: get fdp events, use helper
      hw/nvme: get feature FDP (1Dh) fixes
      hw/nvme: set feature FDP (1Dh) fix
      hw/nvme: get feature FDP events (1Eh) - return supported events

 hw/nvme/ctrl.c | 147 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 73 insertions(+), 74 deletions(-)
---
base-commit: c0080f56036249df4a3f56e07e90cb0e56b3fd34
change-id: 20261118-jwd-181126-fdp-fixes-9a9f417d858e

Best regards,
-- 
Jesper Wendel Devantier <j.devantier@samsung.com>


