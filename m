Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236C9FC9ECF
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 04:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyjYW-0006ar-Jb; Fri, 06 Mar 2026 23:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyjYV-0006ag-Eo
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 23:46:23 -0500
Received: from p-west3-cluster5-host4-snip4-2.eps.apple.com ([57.103.72.35]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyjYT-0004bI-V1
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 23:46:23 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-4 (Postfix) with ESMTPS id
 1D00E1800108; Sat,  7 Mar 2026 04:46:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772858777; x=1775450777;
 bh=s3HA2WDey3bAcqquCsuNGjJi7baMe/y7moYU/BlJtZ8=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=Wt2WXGjfIxSnDrMmAyF/4S3gTepewN6ZMEroGBGiKkdKzSnucnkF+SSZDjeBZ2sh3r7X1qwGcVhaTjupk7cf/bDRYHU2u/Z37zcirEbYA9rdRBB6m7ybByoe/ZQL6k92Te95ShGGBHRznJd2kK0Lt0YO2O7g5NDeTeaKY0a3DX3I0LIyQxO+030PIhBWIRQ1SAHpBxI9E4vB5NwNnA6tcSxQq0HtRsP1X/4OxMay+cBCGyVM3VTgbpa3Dwx7nK3WmGsXZSRVIG2m4JBE+0cNXwnsvG2Wif5fNv8SEJIX5GR2m9Yo15a8Wr98tLYOI159M799D8dVWfv40w2UthcH5Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-4 (Postfix) with ESMTPSA id
 ED2E5180008F; Sat,  7 Mar 2026 04:46:11 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v6 0/4] vmapple: making it work on the latest macOS host
 releases
Date: Sat,  7 Mar 2026 05:46:04 +0100
Message-ID: <20260307044608.25486-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dHb4-ACLKcFEuYIkYgbpGmHaRXHgqXTK
X-Proofpoint-GUID: dHb4-ACLKcFEuYIkYgbpGmHaRXHgqXTK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDA0MSBTYWx0ZWRfXztWvsj0gL3ll
 5UawXnwASG9gyFFo7yGLNBW1oPBwkPdvyYL0Dtm6vAtjZjc5JJmP9u/wodtHCbXL1uZKrfeP0Gz
 56NBEHUToMtg5LDN2L6LKoAKgWC4uGJ4BdwZjNnNgzpW8QJ55pW/d9gREYZ1Qt5cZlZp1SNM7aW
 ngRfj1jMAVVb98jHPNXyxtmDgzTMTUjXWRmK9LYcQD1PulvLhp4ffnhO5+c0A6/BUcTP6I3rkx8
 TqiYmg3/Y9lLMd2tD/edS7g7MV4++qDIyWaZVQm61D17gZNwAXMskmPYzu3NuvXXv1QVvZdYJpB
 7PRgJpI4uF+Rl4avRx0nn1iJyBrf4q9CwLToybVJa1IySqsudcs3MteTqKxzsk=
X-Authority-Info-Out: v=2.4 cv=CdIFJbrl c=1 sm=1 tr=0 ts=69abad98
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=PWwuWOSklEzM4Y2Y:21
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=PFpAfj6M7uIAZud8rW0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxlogscore=675 malwarescore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 clxscore=1030 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070041
X-JNJ: AAAAAAABb9wBUzM9po/Kv0FnGkEm9cBe62Z/idorHAnXYMREjtSJzFdbGv8cicxHAWvj3BGfgXqz7UUVwUdPD1P2NAr+l2LmmZs7pncfWuE4jyj+t6R3CKb/ExFdTD1zoaXriVhWT4+Cyr+XSvaS7ZAZIkIWOpF4Dg8On8qgjoazD8sXjMddK679+uI7F0xP3wynF+rA6AuOnbOn22ON8KtoyGlILbtOhuwpXWt3BIyoe3icWLf1zVodfbGg53mL67vg6sgwQkybOXCYlr+ghsp+6RCXkZUy/AGILy6iGSv6xJlrTFVIXtC+Zm64i59r1NfyU/uK6vUwLZZWhIVVERMUN5HivcRGj79wmaHYqaqWG8xrArvGsGiRHItUvv6MC6iz1uYYAsZ8+iLpD4BRKeyltmg2xSHyAd0x0fxmVDSkom2PkuiC5STu1EgxZWajWRErdytGFywHnEWd1ZoF60w+mXge2wu+gtCDpNyB5VONHRCR+0pb3ZfZxLNMToL4TYrWqY4lg2Xt/dfN6cHsMbdJOsQw9enGAcYt5E8BWQvKBnTVvB1HjptAJqgeCl38nDApBbGRs3dW73u3gMimhKND9vRqoYTT4pGZ8ai70a2hkS4SSvsPesYGj2t7OwyJZACTXUVaPgCLa0LZwzRv7UNL65KT/Um029QzU5yl2C6hjpGIcDWCTdBhOahmw9DneGp1g/SpQNCP+5boG/pVOVMXWIn39WYNZ69T1Ks8omPBv1rq7cNLdza1Mq1ryQoQpW7oBkjR/RqZysG0Zk8JmfUrdOg8MQ==
Received-SPF: pass client-ip=57.103.72.35;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Support for newer guest OSes isn't part of this series.

v6:
Rework the patches a bit, with making sure that there's no compiler warnings

v5:
Address review comments and rebase.

v4:
Rebase and resend without the RFC tag as I didn't get feedback.
Drop patch 1 (version I posted was incomplete anyways). Last patch isn't worth it too tbh.

v2->v3:
Remove the Apple M4 support workaround part for now, to be part of another patchset perhaps
Address comments

v1->v2:
Remove some lines that shouldn't have been present...

Mohamed Mediouni (4):
  system: memory: convert some helpers to const
  vmapple: apple-gfx: make it work on the latest macOS release
  hw/vmapple: aes: convert MAX_LEN to a #define
  Revert "hw/arm: Do not build VMapple machine by default"

 configs/devices/aarch64-softmmu/default.mak |  1 -
 hw/display/apple-gfx-mmio.m                 | 59 ++++++++++++++++-----
 hw/display/apple-gfx.h                      | 16 ++++++
 hw/display/apple-gfx.m                      | 42 ++++++++++++++-
 hw/vmapple/aes.c                            |  3 +-
 include/system/memory.h                     | 14 ++---
 system/memory.c                             |  6 +--
 7 files changed, 114 insertions(+), 27 deletions(-)

-- 
2.50.1 (Apple Git-155)


