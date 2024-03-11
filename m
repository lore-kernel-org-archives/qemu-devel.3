Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B363C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjrU-0001eQ-5n; Mon, 11 Mar 2024 13:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1rjjrQ-0001bs-Cs
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:54:52 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1rjjrM-0001G6-Kz
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:54:51 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MHFwM-1rfOGf47Tk-00DDrN; Mon, 11
 Mar 2024 18:54:42 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 0/1] M68k for 9.0 patches
Date: Mon, 11 Mar 2024 18:54:39 +0100
Message-ID: <20240311175440.305912-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.43.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IRVDsMdHJnTnyGUDns1aN7Jkxi9iZwcSvQobSeD8aorD3D0dVYL
 rmCoa2W+MwHnv67cvkSCN+TtLaWvcWkZGk05eewzFvczMw+zOhuz4cMSE6Q3X8TqhDGxpX+
 dMAlZPyU3yIoo5nIaz3OhMXAWbwWwyFIr+ni2Gh4AY7xSiX2YuQ8nU8BW2cmE5DAKwPHmA/
 lnmgFSWvyClHM5zfRDljQ==
UI-OutboundReport: notjunk:1;M01:P0:7QsDzB6yECQ=;llXe7Dpo3ewWDWVxpn4vUWikJP6
 vkzA074d0QASn1c/Yz27cE+2xw0l0arfqtWysaSbteh9XkrMMqWfDpUX/E91kLqNlQxY57Mxd
 pb3SMcs8DayBYAOS1HaMNvq9GWDK50Xnc7lRDMA09u4Kdkr+xTUy465+m08eK6MrptRTDbnvb
 z42DEwYe0fQY1sipfMoJlVHj2BVFRW3O2Pbexkm8QvZRupk7URIdH3j6nFBb/wM0S6bw24UYY
 q8C3lsRvaMURoy8VAyKcqaFejRiwL/8yrePR4GGKh5r9fJlQK9yBzw4UfKjS+APVYzwlK0BS+
 +WyE83n69zyxoTKJiVeFDT7mucLC5to6vWM4jucKtQ8YM/wigxHNusji7q873c45HPDXRLyM3
 Atty3mI7RDi1IsKmpCGB28SWi4G8r5/SiN+Stay+wRi/AhB5VeXb+GuakSE33Jcgf4MTAM8Jm
 ZXis4CWo2BSVY5VvHXHJCciVS47wCE9Xr0xAOV25ZE0yKemOqU/pIe6UG3ePL8B1mxWy5LCdG
 vwKvMyqvoIkvH21qn1f54m3aqC2Mrxve/vwiQy8nrFlg4kbm4FAtdnWF1IAeOL5SuEfXqMEvi
 f+ROqrmJD3hQGpxKH7XxOX/aoOuFHFe779+NR3u3tKM0N6K3pzum3on9vnsGdrlAI3H5FaI7L
 7IbI+MMy6emWF8ZM79VKsNPcar5cbQEPt+YWW39tr9e20OE9idJ887nCKgns0GfhZuVCv6kkz
 nwt4r+Lp8n7L4OqB0+NBvsfcoMVRnHJjSxwX6N9r2jsKFbbmvlIGOE=
Received-SPF: pass client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 7489f7f3f81dcb776df8c1b9a9db281fc21bf05f:

  Merge tag 'hw-misc-20240309' of https://github.com/philmd/qemu into staging (2024-03-09 20:12:21 +0000)

are available in the Git repository at:

  https://github.com/vivier/qemu-m68k.git tags/m68k-for-9.0-pull-request

for you to fetch changes up to e39a0809b99bbbe5f0ec432fdd9e8c943ba24936:

  virt: set the CPU type in BOOTINFO (2024-03-11 09:38:08 +0100)

----------------------------------------------------------------
Pull request for m68k 20240311

----------------------------------------------------------------

Laurent Vivier (1):
  virt: set the CPU type in BOOTINFO

 hw/m68k/virt.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

-- 
2.43.2


