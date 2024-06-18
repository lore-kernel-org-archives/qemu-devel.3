Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3567DC2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 17:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJcYl-0005gR-Qm; Tue, 18 Jun 2024 13:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3pcJxZgwKCiwVIJQPMabMNIVOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--nabihestefan.bounces.google.com>)
 id 1sJcYj-0005dI-HF
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 13:23:53 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3pcJxZgwKCiwVIJQPMabMNIVOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--nabihestefan.bounces.google.com>)
 id 1sJcYi-0003da-0M
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 13:23:53 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dfeff072f65so9665016276.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718731429; x=1719336229; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mIz+uBMleWspMGOXrthG2m3FtkYnjCAe7akkH5AGnWM=;
 b=qgsa4nvZ0ycqLGd/COe0XhtjMpTW2iMHlG7802J6u2Qm2MRorhyzy+rp1xBlQtZwtb
 fYSOK+fNRno+4bFlA671HAK5XCMd4UlLieKdrSxmItFwZbWcoWIHA87ZH/hJSELGlk0q
 u4NIARRoe1X358Ti7eifeBGzuOIiQ/Q2q1IqIp6ZlcPX5FvnC6g3G2Zkp0Vuz/lUomiy
 XfHckdS8tcdA2enn6aPBD6w08wZ1IGJsMuCWmTa8T/5ytfpi8u8blCgJ7nysBbKsISg6
 7aYpIf/3TtV9HwABhplKOGMCrutE4N3svss+ll+9n+2mdyQTvlOsKvVRRMdjEF2s4pPF
 mvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718731429; x=1719336229;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mIz+uBMleWspMGOXrthG2m3FtkYnjCAe7akkH5AGnWM=;
 b=HqiSxAms5quRDTr31G518UZrXbVWywbYSYWVUVKvcBULruexpJm76IhuR9ibvlLh9X
 a5ofqauq8qrIODfzQ+8LZBwP4MzaowF9bKba3tEuGBjk78FSGiVJf239//Qv6idNlwuf
 R7mPRe2Ydp4A8vovAQVjJlHOuuWvvfzUa59fEzbKsCVMdw8F6nQ6XSZ2pJGyRW0lyeJ9
 NXo7tQ3Z0fHE0JzKuU21WORKhSaDOJYBiglitxT9Ntz0u72jNzkUTX9QheIJmy4FnvKS
 oElsfbQ78VjG0EB4SgO12FFvRvfr+ms/SfAkScWxnV0ByZNyDw0SHg4A6g/I/QW2J0+n
 7WhA==
X-Gm-Message-State: AOJu0Ywgca8O0fJAP/K9zdxJNoSJxC0NkpdnMlZcYFWRn3P0DZhR5nac
 Q3+jUHwBYLgctwCt/CtduG1Sm47NcQ0mKQ0sZeGLDNL5n0CArJgJMGCn3mIf0PvxbfoDPkS8kll
 glwhqXwh57Qc/v5szPOorQCiosw==
X-Google-Smtp-Source: AGHT+IHTQ00Obz4frbbMs2A18rdB/amTirjk+GFrizcUfKhsAJcvLU2VJbYLPTVph1Wfaj6gxKU4HY0drwVpMXV0lbk=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:114b:b0:dfb:15c1:73f9 with
 SMTP id 3f1490d57ef6-e02be1ddca5mr73803276.8.1718731429072; Tue, 18 Jun 2024
 10:23:49 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:23:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240618172344.3448375-1-nabihestefan@google.com>
Subject: [PATCH] hw/net: Fix Coverity Issue for nocm-gmac
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, kfting@nuvoton.org, wuhaotsh@google.com, 
 jasowang@redhat.org, nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3pcJxZgwKCiwVIJQPMabMNIVOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

There is an extra `buf=` set that is not used by npcm-gmac. Remove it
for coverity to be happy.

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 hw/net/npcm_gmac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 1b71e2526e..b397fd5064 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -614,7 +614,6 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
             net_checksum_calculate(tx_send_buffer, length, csum);
             qemu_send_packet(qemu_get_queue(gmac->nic), tx_send_buffer, length);
             trace_npcm_gmac_packet_sent(DEVICE(gmac)->canonical_path, length);
-            buf = tx_send_buffer;
             length = 0;
         }
 
-- 
2.45.2.627.g7a2c4fd464-goog


