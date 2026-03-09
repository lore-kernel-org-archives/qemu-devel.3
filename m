Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643A3EFCD95
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 10:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzXuX-00069A-RM; Mon, 09 Mar 2026 06:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69ae9dc7.v1-1d79080cf5a8418284b903d3f126aa2a@bounce.vates.tech>)
 id 1vzXuU-00065P-A2
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:32:26 -0400
Received: from mail132-19.atl131.mandrillapp.com ([198.2.132.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69ae9dc7.v1-1d79080cf5a8418284b903d3f126aa2a@bounce.vates.tech>)
 id 1vzXuS-0006Zc-I9
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1773051335; x=1773321335;
 bh=3V1F5y00zAa+MdTV4jWBPDvbAqCcLx2ckw1wLWI6mTo=;
 h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
 b=UbujrpldGytPXFKcF4YRUQBcRulXEPx4hLPjaLIdJujQCnj1nIiZq37gX2qLe8ct7
 7MHkiIyVUCk0EHWDl4jwAlIcZpanEwoBNEL8htuMChOg/Z0f9zBw3ylI5I6Lq5s4hs
 Rax9YCeWAG0/Henxep8I/JghZk+7PnPKk89LzX8hgkTY4GU4MKywJ5SoPeEPBMmFe6
 Dh5KyuhcKxLKijVJkipUWQJMA9JhrZDre4Q6wAzB+kxpdnKaLxnDFEqrgguvSmv7hi
 +o7IvJu+87oskv4I9Q8qbWEZqSr70EUJ0ls5LsEgIybYBc4wOtmGcil0V3HGIaSs6K
 1PgKyrfyMCbqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1773051335; x=1773311835; i=anthony.perard@vates.tech;
 bh=3V1F5y00zAa+MdTV4jWBPDvbAqCcLx2ckw1wLWI6mTo=;
 h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
 b=NDXxAenJ0+CmWTsMHnYxxWGJ4IIgKKHtLzd1di+CFM7ztTVt8lxvSVmPvcIrsbPkc
 J2ON5FxjcSMA9Bh5DYdUA2+ElEqwWf8AKsDBnyPMtIWRtlmn62R5awCp3VOUJaEhT+
 VxV9hkWU4VL6ZfGW22fH1rHqJYS1HZzUgeX80W5ikg067Pg9JctC839Se3gin/mD6q
 7DqVCSGz2SQcZGewS8UX5/+WIh5sbK4ii+7JZhsuqhKNzCgGycdL48Xu/F8evAIgfe
 enTm4rjwc+sZ37ysZZoz1eza8DB11Ny+bD8PFgGgyhgIAOvsw0ogHdTBSvT2EEaQSt
 KIq9SOzLlSCGg==
Received: from pmta09.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
 by mail132-19.atl131.mandrillapp.com (Mailchimp) with ESMTP id 4fTtF3318cz1Yg
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 10:15:35 +0000 (GMT)
From: "Anthony PERARD" <anthony.perard@vates.tech>
Subject: =?utf-8?Q?[PULL=200/3]=20Xen=20queue=202026-03-09?=
Received: from [37.26.189.201] by mandrillapp.com id
 1d79080cf5a8418284b903d3f126aa2a; Mon, 09 Mar 2026 10:15:35 +0000
X-Mailer: git-send-email 2.47.3
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1773051334677
To: qemu-devel@nongnu.org
Cc: "Anthony PERARD" <anthony.perard@vates.tech>
Message-Id: <20260309101529.25695-5-anthony.perard@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.1d79080cf5a8418284b903d3f126aa2a?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20260309:md
Date: Mon, 09 Mar 2026 10:15:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.132.19;
 envelope-from=bounce-md_30504962.69ae9dc7.v1-1d79080cf5a8418284b903d3f126aa2a@bounce.vates.tech;
 helo=mail132-19.atl131.mandrillapp.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
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

The following changes since commit 1ae4271ab8dbfbf5dc28b36baa7f3fd5fd2215e1:

  Merge tag 'pull-11.0-virtio-gpu-updates-060326-1' of https://gitlab.com/stsquad/qemu into staging (2026-03-07 11:22:16 +0000)

are available in the Git repository at:

  https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20260309

for you to fetch changes up to 5a0b8890862251de3f182020cdfa3faaec7623aa:

  xen-hvm: Emit RTC_CHANGE upon TIMEOFFSET ioreq (2026-03-09 10:48:33 +0100)

----------------------------------------------------------------
Xen queue:

- Bug fix handling framebuffer during migration
- Emit RTC_CHANGE event
- One build fix

----------------------------------------------------------------
Liam Merwick (1):
      hw/xen: Fix trace_xs_node_read() params

Ross Lagerwall (2):
      xen-hvm: Handle framebuffer relocation
      xen-hvm: Emit RTC_CHANGE upon TIMEOFFSET ioreq

 hw/i386/xen/xen-hvm.c   | 3 ++-
 hw/xen/xen-bus-helper.c | 2 +-
 hw/xen/xen-hvm-common.c | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)


--
 | Vates

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


