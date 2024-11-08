Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF53DD5E154
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 10:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9MN9-0002Pa-PW; Fri, 08 Nov 2024 05:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <042b4ebfd2298ae01553844124f27d651cdb1071@kylie.crudebyte.com>)
 id 1t9MN5-0002PL-TJ; Fri, 08 Nov 2024 05:37:43 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <042b4ebfd2298ae01553844124f27d651cdb1071@kylie.crudebyte.com>)
 id 1t9MN3-0005bF-NO; Fri, 08 Nov 2024 05:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=Y2sYtKZduLLC2e1R1hX/xjMEglvdUjKcDnQtYov+6qA=; b=XktEs
 J8rM0zlzhNBBRVUXtTVVKCj1Ce8wuhA/peUgjMwkXmdDdwtlNqJi1q3unUR62jP9/Eik2qvOqc3bp
 EK+cAnkreTpGKpsktRC89GgvxTaspW3li3QnZpXd0fmi1leyFeFZzFz84AHKKHknrg64jOz5BvSUf
 9tfTeyOhvaQ3vqIg56aCYs8GTelI0d0SW17WmhPH+QohxRwdT4Nn2M0y5ZgetvAwSmAVa2nSTIfYe
 XQN4hI6b7YuUXEG8QZCPmf/z6eDw1DyBCKlhV+fDk5qg7Oe2HZ3pds2EPpAl2fD2S22mgpQfYYIWv
 SFx3TgxADmjbverpu96TOg9gx56OMvhkrd9khItyZjdfjWU3kRx1IQ03AiMXFyMU0nO7E3bh7RZdh
 ePaWk3ju5XlvcoG24eJar1AG4FUydb1VGFCTG2q0slrOvEXZROmSP0E2bhI4do3OJx0fw9PUblaDa
 VD3i/7smlYmaqBDRTrv8tiNa+d89nPoyfJkQoL7l3tAWXr1omngzkbfnN1YRqgHNTWZo70m4EL5Pj
 PCQ9iStGv8gdGUnnAArMmuWqnwqEViZKxRq8IIzxjjKZeoC4+qhV0CUSPL2+Fjokc2NVesA3PTwc7
 RlYQlbl98nuPIR4KZQnZHzqPphfpKQPbP2fd++35KwaU/YXfn2ih8kiPPx267Y=;
Message-Id: <cover.1731059803.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 08 Nov 2024 10:56:43 +0100
Subject: [PULL for-9.2 0/1] 9p queue 2024-11-08
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Akihiro Suda <suda.kyoto@gmail.com>, jan.dubois@suse.com,
 anders.f.bjorklund@gmail.com, Balaji Vijayakumar <kuttibalaji.v6@gmail.com>
Received-SPF: none client-ip=5.189.157.229;
 envelope-from=042b4ebfd2298ae01553844124f27d651cdb1071@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The following changes since commit feef1866d1366d651e6a3cb8c9cf1a9aabb81395:

  Merge tag 'pull-riscv-to-apply-20241107' of https://github.com/alistair23/qemu into staging (2024-11-07 15:08:05 +0000)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20241108

for you to fetch changes up to 042b4ebfd2298ae01553844124f27d651cdb1071:

  9pfs: fix crash on 'Treaddir' request (2024-11-08 10:38:12 +0100)

----------------------------------------------------------------
* Fix crash with a bad 9p client.

----------------------------------------------------------------
Christian Schoenebeck (1):
      9pfs: fix crash on 'Treaddir' request

 hw/9pfs/9p.c | 5 +++++
 1 file changed, 5 insertions(+)

