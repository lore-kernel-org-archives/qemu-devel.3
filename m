Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211A3CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 13:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyW3s-0008AJ-92; Tue, 16 Sep 2025 09:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1357816113@qq.com>)
 id 1uyQu4-0006T7-FO; Tue, 16 Sep 2025 04:19:08 -0400
Received: from out203-205-221-153.mail.qq.com ([203.205.221.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1357816113@qq.com>)
 id 1uyQtw-00049X-GU; Tue, 16 Sep 2025 04:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1758010722; bh=FXEkO1SVjIIKuKprQqjM70EdoENi90rxNlR45ZFRMqk=;
 h=From:To:Cc:Subject:Date;
 b=eDEy+D0R1qlMyG/7e2tkMaDDQCzZ152H5U09TFR0MZb+AemrmvtH7082mKFgKc+5F
 oF6Dtsx0wS3PbtlHn/pLOwe41J1DQE88Kbn7tAmyQWjbePJUQpv7qtuWbNYEpNz1mF
 QBsJLtAWD4z+F9uxSnOzm21pDVS8oFzqZNBP/ALE=
Received: from localhost.localdomain ([60.191.5.130])
 by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
 id 29F20EC2; Tue, 16 Sep 2025 16:10:31 +0800
X-QQ-mid: xmsmtpt1758010231tsecvkwpy
Message-ID: <tencent_E89CB2B19584679F7D6FF370ADEEC2992707@qq.com>
X-QQ-XMAILINFO: MS1AjjpKGz7zUmhv6uKWruYZT5fi2T0H7laXm8wX0zCC7QnIu7hmU6rZHTNw5h
 eXCohywz0fvwyQhXnAdJ3+DSyX/UlLcx8tJgIsyAWj4Z8K4cNm84w0Zm8c97UX06IpOR/1e1X7Zg
 sq42WE7YiMg/lhtAAaf1cp1gZcOAr2YLtQhmqvLISKgC4bVCDRZK8CyuP0+REifiFRhqennk4Kge
 k10RAS1g0uTA3JACksOuf506+nWVgtr8gsyEVyN4SmBA+czHQeT2HydiiZGwBhSP4mmPD34hOphq
 FA9Mznes0tTUoyStliVFdyaSxDT8s7AnjxLZ784VHqqFP+QLcBpWPh3Pmf5X1M9LA4OHdScuxvi5
 izrFGqHZ8g6XQ8lHgJhWV4bTsQSJBQs0dm6Z6v560ZK90+4XYi2iys3VOs+Tknhu02616yq9Mfcm
 E2Ixh+IiMQONfTM6l6sKTJMdr6qGJGZ2SwCFdQ0EG8iLAOvS6fTIgLYZsnF67wsjbotuR1VJlU5X
 vrZkPLGsyq+/ADt20jE/P7/tTLzH9dVk+V750PiHPCbX2y4TXPmCfyUxZptZhHgQDj0opMf9LM68
 Cl8EEH4f4elYgvhYdsOvTDndeU5ztEpPbs7v8UOaE6mAnDP1BdHhg6AAXJHHzLwvKLkqDnOtfxml
 /dK3jyp2xGysDhCmOFO4fzibUPSQaqJwZXinZFZeNgh1ManE/lLvSyfPUfFvcdWYGi1syrtGe0oH
 5fXs8zzrwa+lcys559E665CwbRvKrlM8lFIrWg1SEZphrBXUfCiG0Q50QXI4vRPOPVqp5gqLFDQo
 MVm0m5mGaYPmsAlc0CosuY3C05PRtpi27Uhp2HK9eZEMr+FmAtEIC25S+EbqF0WUbaCbyOc+V3rT
 DdoV76d/h/Zs6A4RC3ROY057Uh7Ta+V8u/Cb/yygYXePHOwET6JtM/kj8IPHN2OoJrwWBvSWngWf
 72qUQecCfWI2nVJUgbDmQEL+CGV450HZfSR1UG9yaSX1nfz3qIzyp3OVGafKri0ETiOIrSUYEf72
 UKCP1wHHJHMxkY+A9t
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: SillyZ <1357816113@qq.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	SillyZ <1357816113@qq.com>
Subject: [PATCH] hw/net/can: Remove redundant status bit setting in can_sja1000
Date: Tue, 16 Sep 2025 16:10:09 +0800
X-OQ-MSGID: <20250916081010.1151-1-1357816113@qq.com>
X-Mailer: git-send-email 2.47.1.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.153; envelope-from=1357816113@qq.com;
 helo=out203-205-221-153.mail.qq.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 16 Sep 2025 09:49:30 -0400
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

In PeliCAN mode reception, the RBS (Receive Buffer Status) bit
is set twice at line 842 and 845 with identical operations:
  s->status_pel |= 0x01;
  s->status_pel |= (1 << 0);

Between these two operations, only interrupt_pel is modified and
status_pel bit 4 is cleared, neither affecting bit 0. The second
operation is redundant.

This cleanup aligns PeliCAN mode with BasicCAN mode, which correctly
sets this bit only once (line 883).

Signed-off-by: SillyZ <1357816113@qq.com>
---
 hw/net/can/can_sja1000.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 5b6ba9df6c..6b08e977a1 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -842,7 +842,6 @@ ssize_t can_sja_receive(CanBusClientState *client, const qemu_can_frame *frames,
         s->status_pel |= 0x01; /* Set the Receive Buffer Status. DS-p23 */
         s->interrupt_pel |= 0x01;
         s->status_pel &= ~(1 << 4);
-        s->status_pel |= (1 << 0);
         can_sja_update_pel_irq(s);
     } else { /* BasicCAN mode */
 
-- 
2.47.1.windows.2


