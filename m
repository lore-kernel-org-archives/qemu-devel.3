Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3FEE74ADD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 21:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIarH-0006wU-KW; Tue, 03 Dec 2024 16:55:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1tIYb0-00058I-FY
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 14:30:06 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1tIYaw-0000Mf-05
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 14:30:05 -0500
DKIM-Signature: a=rsa-sha256; bh=d8ezzLBUL0P7KbvyRek7FE5m+sqXxdsJXsfvPa8i7dI=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1733254198; v=1;
 b=OhxpdhfjkLcPeCPrAI2hTNqOG6/NH/ct2zehsVGi8U+mPOdFS6vqrbuMP4/uEVntyEI73In2
 dEHl3AmTT33GKVMN9F7W55mrROUaCgQpsipsTeYtkrh54JGG8eDKeNTjR4nVo7PN5op5g6F1sSA
 Dm1V0jHkKAfPHWzIAAet53fmuc7VzrX7AUFPotc04nXn0ZkfNhZ+qIOFXCER9TmsK2HdzkLe4im
 HEEpuLizFvk0+3IOlBIdrjG1REBaI9Z3Y0v75vgnxOFdtZfist8ypE0KUs+qK6lQQDERV3eQWNE
 OMTQD5E84nbsjHZJwji9l8UksEkQM+0VXb+ySqZwhyo8g==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id E92E02044E;
 Tue, 03 Dec 2024 19:29:57 +0000 (UTC)
From: ~vikram <vikram@git.sr.ht>
Date: Mon, 02 Dec 2024 14:37:42 -0800
Subject: [PATCH qemu] MAINTAINERS: Add correct email address for Vikram Garhwal
Message-ID: <173325419787.15783.10886794805501181990-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Francisco Iglesias <francisco.iglesias@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Dec 2024 16:54:58 -0500
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
Reply-To: ~vikram <vikram.garhwal@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Vikram Garhwal <vikram.garhwal@bytedance.com>

Previously, maintainer role was paused due to inactive email id. Commit id:
c009d715721861984c4987bcc78b7ee183e86d75.

Signed-off-by: Vikram Garhwal <vikram.garhwal@bytedance.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aaf0505a21..b4723eecde 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1914,6 +1914,7 @@ F: tests/qtest/fuzz-sb16-test.c
 
 Xilinx CAN
 M: Francisco Iglesias <francisco.iglesias@amd.com>
+M: Vikram Garhwal <vikram.garhwal@bytedance.com>
 S: Maintained
 F: hw/net/can/xlnx-*
 F: include/hw/net/xlnx-*
@@ -2673,6 +2674,7 @@ F: include/hw/rx/
 CAN bus subsystem and hardware
 M: Pavel Pisa <pisa@cmp.felk.cvut.cz>
 M: Francisco Iglesias <francisco.iglesias@amd.com>
+M: Vikram Garhwal <vikram.garhwal@bytedance.com>
 S: Maintained
 W: https://canbus.pages.fel.cvut.cz/
 F: net/can/*
-- 
2.45.2

