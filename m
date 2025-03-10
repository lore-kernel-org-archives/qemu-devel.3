Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0EBC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1treez-0004Rl-DV; Mon, 10 Mar 2025 11:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.67cefb0d.v1-4e2cc361ba10468da6f519822df6b2a7@bounce.vates.tech>)
 id 1treew-0004ON-7t
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:03:14 -0400
Received: from mail186-3.suw21.mandrillapp.com ([198.2.186.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.67cefb0d.v1-4e2cc361ba10468da6f519822df6b2a7@bounce.vates.tech>)
 id 1treet-0005MV-Uy
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1741617933; x=1741887933;
 bh=klRDbF3sox3xFybtUsbMtKppKrRe9i8THe0Q0/EA8aA=;
 h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
 b=OWa0Ykk4AJ+4P3a7DCTCMLpgqOaLl717OwJqiLKxyj+wVQyOWAGaZ/ZIenC+vpfHv
 B3bPlCDTX4kadBIe0DXT2MjImsggyyeyhCYZep1dGjJGLK7dqm2BWqMy/m1b/Rn8nW
 RImaLNI4DshziLfJaakId/Z5lcQdN94Umf9nmJHLI9Sa/K4MKCSLsxFQx2K2z+iNnd
 dNodQIbirT+hKLW/29wPMSLD6pXJlS8ferEi2KzJruatYkve9hmkSv/bDMPUyUzUyO
 O4TwU5fa8axAVn2jI2iH+ZP7F5R/Nuro4b5bVirGDaVFVVbC6NdHT6Q/AgXyEjmUBZ
 B2n4dQ/n9mvCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1741617933; x=1741878433; i=anthony.perard@vates.tech;
 bh=klRDbF3sox3xFybtUsbMtKppKrRe9i8THe0Q0/EA8aA=;
 h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
 b=oQlzX0fdqGqlC0pSDIHq3MLvYLfBi4H4LTy/E2HR7YvRTERixq37K6LL/osjgcUyp
 26Jg6qN2RVNSv/QoUZZ2nvSt5Qs6hWILnaZimNt7Lz7Q5PLT9bcMM7n1g1nMcji2mx
 2uMw0ksf7gXYxeJQaCShe6D4bC1p0hIzxDpoX/zkk3aQ6/g7C0tyUizNS+XcHHNPeF
 JJ3NpzdB5W/rLCQLP6EXoUlB+LIPkH0wFQGCXS6Lee7BD8dpjLW4NeXMaaFuqNF2lI
 KbML3Ut9eAIkLIxKFx1MY0NOsirffhLifA+K7cMe9jbxtrOHnq3m0pUCgBrwjropi2
 6q35/gts3cO7Q==
Received: from pmta10.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail186-3.suw21.mandrillapp.com (Mailchimp) with ESMTP id 4ZBKSY4jbBzDRJYVD
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 14:45:33 +0000 (GMT)
From: "Anthony PERARD" <anthony.perard@vates.tech>
Subject: =?utf-8?Q?[PULL=200/3]=20xen=20queue=202025-03-10?=
Received: from [37.26.189.201] by mandrillapp.com id
 4e2cc361ba10468da6f519822df6b2a7; Mon, 10 Mar 2025 14:45:33 +0000
X-Mailer: git-send-email 2.39.5
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1741617932974
To: qemu-devel@nongnu.org
Cc: "Anthony PERARD" <anthony.perard@vates.tech>
Message-Id: <20250310144516.28828-1-anthony.perard@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.4e2cc361ba10468da6f519822df6b2a7?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250310:md
Date: Mon, 10 Mar 2025 14:45:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.186.3;
 envelope-from=bounce-md_30504962.67cefb0d.v1-4e2cc361ba10468da6f519822df6b2a7@bounce.vates.tech;
 helo=mail186-3.suw21.mandrillapp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 5136598e2667f35ef3dc1d757616a266bd5eb3a2:

  Merge tag 'accel-cpus-20250309' of https://github.com/philmd/qemu into staging (2025-03-10 13:40:48 +0800)

are available in the Git repository at:

  https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20250310

for you to fetch changes up to 68adcc784bad13421ac7211c316a751fb99fcb94:

  xen: No need to flush the mapcache for grants (2025-03-10 13:28:03 +0100)

----------------------------------------------------------------
Xen queue:

* xen/passthrough: use gsi to map pirq when dom0 is PVH
* Fix missing xenstore node from xen-block backend
* Fix xen mapcache extraneous invalidate

----------------------------------------------------------------
David Woodhouse (1):
      hw/xen: Add "mode" parameter to xen-block devices

Jiqian Chen (1):
      xen/passthrough: use gsi to map pirq when dom0 is PVH

Stefano Stabellini (1):
      xen: No need to flush the mapcache for grants

 hw/block/xen-block.c  |  2 ++
 hw/xen/xen-mapcache.c |  1 -
 hw/xen/xen_pt.c       | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h  |  4 ++++
 4 files changed, 66 insertions(+), 1 deletion(-)


Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech

