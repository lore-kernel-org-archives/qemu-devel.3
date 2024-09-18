Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C51CCCD18A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 07:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqpLG-0001No-VO; Wed, 18 Sep 2024 03:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1sqpLD-0001Fl-OT
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 03:43:11 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1sqpLA-0001lS-Iz
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 03:43:11 -0400
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M3lHZ-1sqYUL1fQR-000R9l; Wed, 18
 Sep 2024 09:42:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Brian Cain <bcain@quicinc.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 2/3] linux-user,
 mips: update syscall-args-o32.c.inc to Linux v6.10
Date: Wed, 18 Sep 2024 09:42:55 +0200
Message-ID: <20240918074256.720617-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918074256.720617-1-laurent@vivier.eu>
References: <20240918074256.720617-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WhIXQAovqRAKTYyCw8lYHRikee3ceVeRlg0684HnuuWgRbzLS+/
 xhoPRkwLYejURbH0uw7WxFYwKQme3OPJENS7x19hfRhFBvnTG6ZmmICDzoUELWeOmBot8TS
 WuLd4fwXdQbw51moztNiTaZrTe7+VEkCXkE8G4CF95PvQ9szjhu0s0/9TM6K7ZhCElyX/ok
 y7KZ9X1drdOrxmMhMU/5A==
UI-OutboundReport: notjunk:1;M01:P0:2bIVb3qUOhY=;aB3PSy9UVSdEEkPLZVVE2rtsi84
 d2G1/6pmoUUonwxGqL8fEp/46aUXtHlFBjVPavcIyMVLqDDMbjxb86AfC2keaJBH2zJ2UsE5v
 thyfycKCl19Nf1odjaDIgP2d7QQc6lu/IYxWFqIh1StrV/C31aikZJftxmAZ8ZD8fMs6Fc7J0
 CBjXfJ7JzaZYbMdVKHWhO664mFS0YjEtvA1XGi2DjLYJc8/q6fnBPvbBpheI9yp/ucukNZQls
 i88laW3zXBGaogTXX2h7LWrVnUgkOYEj2IbasCd+TAXuGq6qWPhkp/gqzWNA7oQ4TGvCYYAmY
 dt4VxFhydJAG3KX+Ts/7X6goBqkmSqOZtRDT+jrMIAw/NOA+3RzbvgUeVY3D+YXX3hoy81Ujh
 rjlV1/zajcXHLqw5+KSxChTMRTLT6MjVNVt3LE4PihFICKPXkesXMSWcAR0pZpy+V87PQuPLp
 aFedIfs0y3aMjUtPRkJT8n4FtAyS1K5M93h8ExLw5wZVxjwYxdw6ip5ZPHuADo3YbiRq6Tjnk
 miSNtXmOmwGjzU0jIB3FuWLRPJuqXNUD34PeMEASYxsVJNBS4rETdLofMftxGkfkVp7GbGOvh
 Rv5PMiS2H19bFvo4n15z9sCzYX6EFwA/98zIkFQn5hLqk5+5Kmz0+3e9pdVw3eKHfe037j82L
 DpdT7u9HVngIz6veCyIe5GrOZ2MpQ1v1F/X+y2CCp4RT4q+SWxBRFzMvQYXs6ZZ7ISYJl3j6v
 SIrhgzAVK8lWZDeZ3pLKLfgo9JTrPqaLw==
Received-SPF: pass client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Updated running scripts/update-mips-syscall-args.sh

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mips/syscall-args-o32.c.inc | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/linux-user/mips/syscall-args-o32.c.inc b/linux-user/mips/syscall-args-o32.c.inc
index a6a2c5c566ca..780c0a8a495b 100644
--- a/linux-user/mips/syscall-args-o32.c.inc
+++ b/linux-user/mips/syscall-args-o32.c.inc
@@ -441,3 +441,23 @@
     [ 440] = 5, /* process_madvise */
     [ 441] = 6, /* epoll_pwait2 */
     [ 442] = 5, /* mount_setattr */
+    [ 443] = 4, /* quotactl_fd */
+    [ 444] = 3, /* landlock_create_ruleset */
+    [ 445] = 4, /* landlock_add_rule */
+    [ 446] = 2, /* landlock_restrict_self */
+    [ 447] = 1, /* memfd_secret */
+    [ 448] = 2, /* process_mrelease */
+    [ 449] = 5, /* futex_waitv */
+    [ 450] = 4, /* set_mempolicy_home_node */
+    [ 451] = 4, /* cachestat */
+    [ 452] = 4, /* fchmodat2 */
+    [ 453] = 3, /* map_shadow_stack */
+    [ 454] = 4, /* futex_wake */
+    [ 455] = 6, /* futex_wait */
+    [ 456] = 4, /* futex_requeue */
+    [ 457] = 4, /* statmount */
+    [ 458] = 4, /* listmount */
+    [ 459] = 4, /* lsm_get_self_attr */
+    [ 460] = 4, /* lsm_set_self_attr */
+    [ 461] = 3, /* lsm_list_modules */
+    [ 462] = 3, /* mseal */
-- 
2.46.0


