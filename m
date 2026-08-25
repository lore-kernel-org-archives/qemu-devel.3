Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F30C61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylx8-0002On-Of; Tue, 25 Aug 2026 03:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wylx6-0002LB-9i
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:52:12 -0400
Received: from nx206.node02.secure-mailgate.com ([192.162.87.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wylx4-0000UA-H7
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:52:11 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.2) tls
 TLS_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <christian@quante.one>)
 id 1wylx1-00EHW4-AL; Tue, 25 Aug 2026 09:52:08 +0200
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1787644327;
 bh=hScJBLf5JE1ad734WvKcrcUa1hRunhwYrFZJL6aJdy4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xM4H1UUhFzHxSmx3om0YjHhjslpjtO4jAJE7Q19/ICQaKAcVCEZ/VYnIYL84sHTpZ
 MSsvlH7gLfafxV38DlEviD22l3DZU0+C9+vHDSoI4kvnjeI1qeZLRVV4ut+ppN7h7x
 6IcObNxWIoCCd42qN8d5nBVbrHQi4HouMYjcBjeE=
Received: from Zeuss.fritz.box (p57b2f393.dip0.t-ipconnect.de [87.178.243.147])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id 47FE2280CB6;
 Tue, 25 Aug 2026 09:52:06 +0200 (CEST)
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Quante <christian@quante.one>
Subject: [PATCH v2 2/2] hw/input/ps2: say why unknown keyboard commands draw a
 resend
Date: Tue, 25 Aug 2026 09:51:27 +0200
Message-ID: <20260825075127.34876-3-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825075127.34876-1-christian@quante.one>
References: <20260825075127.34876-1-christian@quante.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178764432706.4156473.14796010202711159407@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: SB/global_tokens (0.00992241105839)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuXbhZKxo9bsEFD8Kj7cRWyJ3QBAKW1PETXt
 sam3I5tZbiu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4aLbDVr9n8nIXP/kMcR+6OpS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMxqKIdDR6RVaf4xWSq5/wwdOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgm3QTha208ypFqQwBFb
 xm4JX7semJdl8Weuy8+tlMSTQwhoy9D5QZ6a84vJal7pM1XhlAOd290vPXa7Loma0jth+x0iJ0NX
 07iZIeUSWePdS+owFPr4kjXuZPwOU47Z9+s09nAWqoDs8zZa/KiCJd90Lk7053RUfwPXoECB9OvJ
 bEB3ZiIyIjwOoMnQjl6CrKp8EdZ8SizDtPkcGuerFSnVOYtq+HE3WG85mIDi374DW/icy5el5aWU
 /wf4ShFNzAzxuUotuUNGy5ExxW0GC5CkQjQ6zWGsvxsVC/m+yny0Rue4mmnjPFy3dPHP2FzOds3E
 46oSR4SMslNlGoPN/ReRDyx85JvPA3M+w5jBayuCMVamoWktV59525k34keYykbMQrAIKOj+9hX4
 DXX27MdKse0EuSSr7btxBu5GkHP0MO/iDzcBQTphqKbEazY5fbVoh9VoIekQHpwUfpYnEThmBYJb
 VMG52ZGVwnbZoccL6igIeMz3MSv4B3x/z73En6W2sqBJqpK1GG6vy7Bj1AGPtF7Ey5dhohH1DJe4
 xKbBicPC1/Rnj77R/+sTEK1dN5vsJ9kuQgio2RjilK0QWzDS9OQPoavkwPMV2SuvcnEWOuw2MxX0
 5+DV5wYxLp/Q72cFKjFopoBzI+w6TKsrBBDgOPIh4HEPoN/NFnLJ6oXdnjOfbpfTHUB7Gt5iiSuf
 1AqE4RUbbmt6iPMBsUv9RZcAqvUAApbMLAQDq1Y3RVkolMgdqFY8KQ9Egxp4UGe16U/eGVjath4b
 vkom8c4V/PtEw6nIoDr0sXUZ7YZoZ/GZ+g6r2+bdtWXb1z9s4uNhgHLX+AZlS2zN461BhwVoVaJE
 tlw222OyNqTeU9tH1jYC/i8C7bWQrrnqtP27In+yOBOqEi1X3qoM14sIpnfztEwQP0Uw9n8VcNp0
 5ACBU/pi9Ze6aNYZYil6cObjel6n0jQ=
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=192.162.87.206; envelope-from=christian@quante.one;
 helo=nx206.node02.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The keyboard path has answered unknown commands with KBD_REPLY_RESEND
since commit 06b3611fc2a3 ("ps2: reject unknown commands, instead of
blindly accepting them"), but never said why. Give it the comment the
mouse path just gained, so the reasoning is written down in both
places.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Christian Quante <christian@quante.one>
---
 hw/input/ps2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index e8300d2d83..01af4350b3 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -647,6 +647,10 @@ void ps2_write_keyboard(PS2KbdState *s, int val)
             ps2_cqueue_1(ps2, KBD_REPLY_ACK);
             break;
         default:
+            /*
+             * A PS/2 device answers every command it is given; an unknown
+             * one draws a resend.
+             */
             ps2_cqueue_1(ps2, KBD_REPLY_RESEND);
             break;
         }
-- 
2.53.0


