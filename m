Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A93C5DF66
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 11:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvZMp-0001lF-9W; Sun, 16 Aug 2026 07:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <narimansayed28@gmail.com>)
 id 1wvSay-0000lD-Pc
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 00:35:40 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <narimansayed28@gmail.com>)
 id 1wvSax-0003G2-Cm
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 00:35:40 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-482938466a7so1183792f8f.1
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 21:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786854938; x=1787459738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vt0hlKCIgUUpRy6BPbyzZxYr4+CSZL2N8xdEVEJEljM=;
 b=VvuNukKPTgOy0iT34vQQTArvPVWuOeG7tMjwX3hdcWM6OVH36shMUUUaQY0B+pdldy
 9+xca+SDDkHGARV+YD8FB6p6UgOL83VDJHz/msgHo7nfOeRrEdxs6fVfsE+YFz5fcPfb
 Peqt5GlsUm91A0Py3yxKdzQPR6h+fSAfZKoP4zmTmp2fr90QYQkzQsxYyK0SyHhm+4OV
 w+S8pGIeLyuk/IKqe9fjUO0WBRRtBjX4jwtJweovicz+gjVMYBm0Lci2EPIJImBqVNOA
 KDaH5ymTSBleqFD0M2azMuI2kKanGrt00lE/eas6YhKLqFCG9R0nD8ZmQQTF747txIgv
 1tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786854938; x=1787459738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vt0hlKCIgUUpRy6BPbyzZxYr4+CSZL2N8xdEVEJEljM=;
 b=G2Ui+lyUWB5xZa/jQzaODGyMrk3N3Klk8oeOu4N+U/UD4LS7kW7TlMrwFxnDp8UHP7
 YDx1HCFk/aOrRsw7WjJDB14690EXqKix+2QG8wG+BhMnZIfHqztvOgyC159V6amDIeMM
 AuwX8xReHpV0gOFiqVBiR99xodk9FaI7/agR/FbpAwlx/oVikMjih4ZBJvAwthfoCtiK
 0nLWv0LZBs7mgUrfDgW4m2BCMcYDwIgC/irKlaKkw6LCgdKM9OhjkcsOG4qSx7Oga+Wn
 pUi3jyt0KPmINbjIZS0IczL189F5wXTW0sJR9yYUM0OFRxNoo4lwr7TQB5KGnzG0iMfX
 BVGQ==
X-Gm-Message-State: AOJu0Yza3vkN7qS7EbwNFW8HqIEdYfkPZwgKhV4jruvgRKMuq3K61RM3
 AEt6FOtA5b/6/wqYOAPE87elqFCL0l7Meh6KqUhgTK7ZYQNHSQfNVGDkWf2I0eYC
X-Gm-Gg: AR+sD101DTcLf0v0iP7H3az04Fi7ZGb5nDXDW2r5+WYtbvLdEcHsfB93O33+bPaXvTY
 Z/SYlqLIfGnjrn/k7U7Hjnb2nyYbhwbBAeU1ELV3TvgOeEIVgZ0BkwSq09gpXmynliR7VGUj97/
 aFsk5P63Qyub9AL0oxEwfz1i6JZX+0wdO8Ib71hDEwEq+2ASilGRJyjvPP438BF/lp9nnYnK98K
 nAoTC+JIwPt4LrZA4uER1cbONANiaYMqyMthIrNIFJKo8F4vZ5L/Qo0cCOmaEHhzoerUtJ4bIQy
 3o/l22wzp8Nv1McfzslROyMtk8nrKCepKKpW2pWFBGK1CKHmvO8sqXjsIdevaiysXb6qcc3CnEM
 dm2X9BjQL/2Qls1qNhUzQkFgNsuH52Cl7UA58z8EtTGskirwdu7b2QZwScyxnyTwrsQvsBFAOXM
 Krw+TOAcfrt/2IdAbagmq8CucmP0XCSK8sG/SEZmry3rlbHkbESdquNUea7OeWfEGzxbSXlCbH6
 GhzzgJzBSRCCYCrZovKvewQ
X-Received: by 2002:adf:ea42:0:b0:47d:dfc6:b28b with SMTP id
 ffacd0b85a97d-4816079d262mr17605360f8f.30.1786854937794; 
 Sat, 15 Aug 2026 21:35:37 -0700 (PDT)
Received: from DESKTOP-2SK3BJA.localdomain ([197.49.67.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b27bfsm22971471f8f.23.2026.08.15.21.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 21:35:37 -0700 (PDT)
From: Nariman Sayed <narimansayed28@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nariman Sayed <narimansayed28@gmail.com>
Subject: [PATCH 2/3] net/tap: expose tap_get_mtu() via NetClientState
Date: Sun, 16 Aug 2026 07:34:50 +0300
Message-Id: <20260816043451.2547-3-narimansayed28@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260816043451.2547-1-narimansayed28@gmail.com>
References: <20260816043451.2547-1-narimansayed28@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=narimansayed28@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 16 Aug 2026 07:49:20 -0400
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

Add a public tap_get_mtu() function, following the same pattern
as the existing tap_get_fd(), to allow other subsystems (such as
virtio-net) to query a tap netdev's host MTU via its
NetClientState without depending on tap-internal headers.

This is a preparatory patch; the function is not yet called from
anywhere.

Signed-off-by: Nariman Sayed <narimansayed28@gmail.com>
---
 include/net/tap.h | 1 +
 net/tap.c         | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/net/tap.h b/include/net/tap.h
index 6f34f13eae..6b478acbfb 100644
--- a/include/net/tap.h
+++ b/include/net/tap.h
@@ -32,5 +32,6 @@ int tap_enable(NetClientState *nc);
 int tap_disable(NetClientState *nc);
 
 int tap_get_fd(NetClientState *nc);
+int tap_get_mtu(NetClientState *nc);
 
 #endif /* QEMU_NET_TAP_H */
diff --git a/net/tap.c b/net/tap.c
index 57ffb09885..122319d5f3 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -379,6 +379,13 @@ int tap_get_fd(NetClientState *nc)
     return s->fd;
 }
 
+int tap_get_mtu(NetClientState *nc)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
+    return tap_fd_get_mtu(s->fd);
+}
+
 /*
  * tap_get_vhost_net() can return NULL if a tap net-device backend is
  * created with 'vhost=off' option, 'vhostforce=off' or no vhost or
-- 
2.34.1


