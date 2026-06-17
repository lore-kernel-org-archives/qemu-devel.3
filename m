Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178EFCD98ED
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 23:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa01z-0004OF-40; Wed, 17 Jun 2026 19:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wa01w-0004NK-Hu
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 19:50:48 -0400
Received: from p-east2-cluster1-host6-snip4-10.eps.apple.com ([57.103.76.103]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wa01u-0003tZ-0A
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 19:50:47 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPS id
 C30E71800224; Wed, 17 Jun 2026 23:50:40 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ5JHVoHRQNGD1YCWgZLVxQEFVsHVghdEkoXXS1aDhwTVhUTC1NWXxUXG1wAFxlRTQ5YWwhbBA8fTAxRAkIFVl5KDB0EVAddBV1WUAJaS0IES0VoXAVcHEAXSB1faktWFAQVVkNUBF9QVBFXUAtZAkIPSAVcAFkBRQlLAUMFWgZJCFUAQFoDWBFaF1EeWAVyHVxWUAJaVRIEQAhWUF4IXh9MHA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1781740242; x=1784332242; bh=96OjZZvnL7ZcQJPP9u2rImRmMAgyB1VN3+HAPMO28JA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=N2SkjMtYlWyVid5HQWZxe8H2gZKhmxkSkOzh0pHjAzX4OXkFellAvTLckyA/FTC+hw6EOhOEUL1uZjROJR/5uyWDGhgt9Y7SBtS3tBR0Ext1mJnosEnRA261HulWmBz99zJbQj/x/1N6HAKZeTNUI6pvWu0TRO76tkS6oWyUrjRMiEIg28LllOnsPNOSABNO+pyM+/eQ8oUfcImD/uYJI7FsX4yFktqDo4tLGnT12Mo4DfkfF3sKhCAi5d5KtFmau4LIz7xOpf9w/rFy3cIwtXvMFFPgC2dqNpATrQoqrOzO5a2AzjQGf0SHVHO3eVhy/wKxTlQb0y779RB2Ix/1XA==
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPSA id
 17C381800208; Wed, 17 Jun 2026 23:50:40 +0000 (UTC)
From: Matt Jacobson <mhjacobson@me.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Matt Jacobson <mhjacobson@me.com>
Subject: [PATCH v2 2/5] fifo32: add fifo32_peek()
Date: Wed, 17 Jun 2026 19:50:29 -0400
Message-ID: <20260617235032.21491-3-mhjacobson@me.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617235032.21491-1-mhjacobson@me.com>
References: <20260617235032.21491-1-mhjacobson@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2erAHf-X_CM3qM4e1e57s3nKrFC_By6W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDIyOCBTYWx0ZWRfX3WXjuXyrUWDW
 DZtfQSO4Zu+Qy1e2w3/jfVWRcR5t677uqAmZAZ1mtzHrffcl/ESQtdgbaggDqVOiulJTIuravnG
 54EuB8pse4GCmst6CMyiIl78Vd/U6ra/piEWRCbMneCXQcyWNr0A9frz/RebW8O/nf1Rk/ZAXfR
 x+fJblEdmZMlSAS1qeVdFRuw9toCMN1XFcMdn3+yosBb46Wb+GuppcMjHctUt8jo0897vtTQ9pv
 vbdUVLGiWaoNWnCu7UHLobmMR7AMdSIQN/LTxlqGG7vc3HppFQFZcxHCkOUCl5VTiK8Mh7vHCQp
 OEJOSHcvwq2kQpi4zIE
X-Proofpoint-GUID: 2erAHf-X_CM3qM4e1e57s3nKrFC_By6W
Received-SPF: pass client-ip=57.103.76.103; envelope-from=mhjacobson@me.com;
 helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add fifo32_peek(), which, like the other Fifo32 functions, ultimately just
delegates to the Fifo8 code.

Signed-off-by: Matt Jacobson <mhjacobson@me.com>
---
 include/qemu/fifo32.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/qemu/fifo32.h b/include/qemu/fifo32.h
index 4e9fd1b5ef..7601bcfbfe 100644
--- a/include/qemu/fifo32.h
+++ b/include/qemu/fifo32.h
@@ -117,6 +117,31 @@ static inline void fifo32_push_all(Fifo32 *fifo, const uint32_t *data,
     }
 }
 
+/**
+ * fifo32_peek:
+ * @fifo: fifo to peek from
+ *
+ * Peek the data word at the current head of the FIFO. Clients are responsible
+ * for checking for emptiness using fifo32_is_empty().
+ *
+ * Returns: The peeked 32 bits data word.
+ */
+
+static inline uint32_t fifo32_peek(Fifo32 *fifo)
+{
+    uint8_t bytes[sizeof(uint32_t)];
+    uint32_t ret = 0;
+    int i;
+
+    fifo8_peek_buf(&fifo->fifo, bytes, sizeof bytes);
+
+    for (i = 0; i < sizeof(uint32_t); i++) {
+        ret |= (uint32_t)bytes[i] << (i * 8);
+    }
+
+    return ret;
+}
+
 /**
  * fifo32_pop:
  * @fifo: fifo to pop from
-- 
2.53.0


