Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E92C982CC
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 02:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x87Q8-0005T6-CJ; Sat, 19 Sep 2026 22:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bodenrandin1@gmail.com>)
 id 1x87Q5-0005Sf-LP
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 22:36:46 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bodenrandin1@gmail.com>)
 id 1x87Q4-0004sR-6K
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 22:36:45 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99cso2113518a91.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 19:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789871802; x=1790476602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vFJXdOILjbLHSng1Qb8DLuF7K2XWRE8xMgG3DJO/WJQ=;
 b=sa3qEiL419hDMBHO4XTl+GV6+ZzraYvsHVYnzYfMiqrx8PMDYP6OKat4CVgNA5U6n1
 hHXNHfTi0UU0dtUkkCPQhK5g7SALByYMWoLXj4Mai24BtzKVwxuV67z2IRdy1jRzb2Bo
 uJK3af2H+2iVRxmI/NPBmYXOcJTmLwMhv2towHn/FbD+k03A2WzQYwHMhCkL9XlZg49F
 QmdznScyZ5hbpvNABbP9EvRmLnv7In+a3Tgd6MSj6Sxc2+siurZt83D1xUWy4z3qHWnk
 ueq4Izq9Tq5AzBjDLwwIybcEep6TakBJTalz1OW+fBthwxNZ9dEaJpUgJLYuFAf3Mv7W
 ShsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789871802; x=1790476602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vFJXdOILjbLHSng1Qb8DLuF7K2XWRE8xMgG3DJO/WJQ=;
 b=OBLiwLV43RSb4o0R7pfSNeD5s9hRm5EoxcX9bxAItQU6/K6ypAh0V/j8DaaHN46CeY
 2mF18dPJn5LXeALdogcswBZk1x23zKbCzo2g/4d8deCpzrZwGvksGajMNYqa8athrVSy
 KsPlNl9a92UNw9LobkphzVc3xoTtYCcE9Tpyecg8H0ipVVvaQf9UEA4ZWWlPSc08bd5g
 Oss1BG8uQLmwdvX5XhunREWwosW1rc3n+MBhUJ8+OdA62jG62eaoQ1jZINbg3m42Qq+n
 sz/QB1bKRQkpGm3K8D3HSgxken8lnRIOcpaUYbvH4YZgMToGHR7FwHiyBXlkSvL1AWq2
 MVJA==
X-Gm-Message-State: AFuF++l2nTwoX1/DJy7uu3PItEb271EbXsDG5bsMe7iCraasAY4hJzQK
 CyCAddL1TsJMaJSpT/bbRV1Qv1Whu5nnk+DDhjn2/wbnGXCkFerBXOi07QOpTg==
X-Gm-Gg: AYBFou2kOi3RQeMWbKeho13Tg13/waP9e1lWkIrqZY+cgqQt8QFq0tQ5cpMSienRb09
 OvsMq99OfbbujkToFU2tGYim7Za+6zOCS9lfMa++PGdrru00YIpGbJDcJDATVXVHrjJDnqhlyJA
 ZL2smxzmRzPY6GMyAPZ55LvbXm+joPHfkU4h6XewKMhsPtWf6qnWXjEi+KSaGE6TzvD0XzaONBj
 fcqU/jGp4ySk5S6Vx8r0dgGwq1uscnqsNnDvSQlOQwtruD/Ob9xlWnFjCJi+6e6j6nldgau7IBR
 FTWQcf3EBNsGElsI/LbZik6Kq/pHC9bj5now+aT6wZ7wKiINISY/LyFRBe5+8AteN/w1B5WzDre
 zZo3pYMWGo2OlMf5Veplb9LEO1x8ZSwWVPvnZrjw3BTh+RIsj0bJApHHcWGiAgtVZfMFzHuKZXZ
 ooFz9YG+aJ0i6fzfXiDe7+pF778bQYReMaVQegUy7Ju4ihHX/oA9+HTLPMvQt+zPTN2G9riVr0/
 J6R7iSDIUzdgiRC+tL9hUlFsYjpSg==
X-Received: by 2002:a17:90b:580c:b0:39e:4c81:6c96 with SMTP id
 98e67ed59e1d1-39e54f8a187mr12221803a91.28.1789871802427; 
 Sat, 19 Sep 2026 19:36:42 -0700 (PDT)
Received: from DESKTOP-D94CRUF ([47.153.23.114])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c32f15bb6sm7867254eec.4.2026.09.19.19.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 19:36:42 -0700 (PDT)
From: Boden Randin <bodenrandin1@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Boden Randin <bodenrandin1@gmail.com>
Subject: [PATCH] gdbstub: synchronize state for individual 'p' register reads
Date: Sat, 19 Sep 2026 19:36:40 -0700
Message-ID: <20260920023640.1861-1-bodenrandin1@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=bodenrandin1@gmail.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

'p' does not call cpu_synchronize_state like 'g' does.

Accelerators may keep guest CPU state out of sync with QEMU while a
vCPU is running. After a vCPU is stopped, an individual 'p' register
read can therefore observe stale state until something updates the state.

Signed-off-by: Boden Randin <bodenrandin1@gmail.com>
---

Notes:
    I found this while investigating why LLDB was showing the RIP truncated to 32 bits under WHPX. LLDB appears to use individual p register reads by default, while GDB primarily uses g, which is why I noticed the issue much more consistently with LLDB.
    
    This is my first open-source contribution, so please let me know if I missed anything in the patch or submission process.

 gdbstub/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 0a328b0dd4..31a845cfa7 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1246,7 +1246,7 @@ static void handle_get_reg(GArray *params, void *user_ctx)
         gdb_put_packet("E14");
         return;
     }
-
+    cpu_synchronize_state(gdbserver_state.g_cpu);
     reg_size = gdb_read_register(gdbserver_state.g_cpu,
                                  gdbserver_state.mem_buf,
                                  gdb_get_cmd_param(params, 0)->val_ull);
-- 
2.53.0.windows.1


