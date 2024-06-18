Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15E2C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 17:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJcbg-00015y-Iu; Tue, 18 Jun 2024 13:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3XMNxZgwKCuMSFGNMJXYJKFSLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--nabihestefan.bounces.google.com>)
 id 1sJcbf-00015W-79
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 13:26:55 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3XMNxZgwKCuMSFGNMJXYJKFSLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--nabihestefan.bounces.google.com>)
 id 1sJcbd-0004J2-Mp
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 13:26:54 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-63128f5eb5bso107734017b3.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718731612; x=1719336412; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mIz+uBMleWspMGOXrthG2m3FtkYnjCAe7akkH5AGnWM=;
 b=Es6cdfBlp9sCXZu4Ze5lb6tBnzTabXJ0sVRgTqcJo21aQxFpGjvVqHxgbSXvc8WxYQ
 17Kn8yjRRfUF3eheEqN+LnLh5ESvqrUnKy00uY5PnuMAfm5O/BSIBDCQJnaA3xhKWV+h
 A0AQHJ4Ve6Q5lIEkAzy2vfl2HQW1UDT3jZRk/hRDiITP5haka2tgMAE23WUEDRFnVMYL
 HgihB0TVtlWUV9g1yDzyPOTo0Tb00rSDUda5jBGdOYjTWRdOqSNKcf/AMFk5naw3XWUD
 AnVRWHj9kaLEgKEQ2g73hiYEZRi793QBK7O3aSR0MlB4ZdqEvi1dBYkRuGgu5QjSzq+s
 2XhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718731612; x=1719336412;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mIz+uBMleWspMGOXrthG2m3FtkYnjCAe7akkH5AGnWM=;
 b=efQfrb5iQUUwPLe5pdem4+FMUFTbWotqAX6QUmzABRAhnwwTqmI+su0P1VpwJqGD2o
 ZLIPJDOaUc4w6Ussr6SsTl+aBlKvWJd6bTkOO/q2cE9fKkT/G3m2eHKBVllL5TCDTnwJ
 psDxtrB0xKc9y0XMY+zA/3hpRzw6sCaFfHbQGPDYbwBHyRiKaYvpLIKJPg8tnqFQoB5e
 3r8Siit7NqsGv4Y10Jsb2mrG8dyTvoYVJb8O9roR56Z+1vw02QMVTMJK/+uirTv7ek2d
 y10Mjo/E79XJu4nmlojbgTCbMAkvbxFDHL0/AKqgZqlVR1cT8MReiaYro6kXbqLFKMFX
 JMqA==
X-Gm-Message-State: AOJu0Yx4N6YZY/hTrgtaWpowQZ1hEGdc1wrA9qVoSN1VfyNWcLwO+BuM
 5kdcpICamUQ2XAk5/1dOaoGjkI2er9yGTJOQvVhzNpCV03lma6eOQJ408sz4lvgTpsTz/CGnK6T
 41lCuRZm5VdduGuClJbgHSWz5LA==
X-Google-Smtp-Source: AGHT+IHBOv1PdzCsKuq4sgvs6nuKiYTfaU11URmwjnq63RTNBM7y7c0tAj7OawhkACJ5oysicz/1S0R00g03rPzsjlQ=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:690c:887:b0:627:dd6a:134 with
 SMTP id 00721157ae682-63a8d923fc9mr908607b3.3.1718731612244; Tue, 18 Jun 2024
 10:26:52 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:26:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240618172643.3451083-1-nabihestefan@google.com>
Subject: [PATCH] hw/net: Fix Coverity Issue for npcm-gmac
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, kfting@nuvoton.com, wuhaotsh@google.com, 
 jasowang@redhat.com, nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3XMNxZgwKCuMSFGNMJXYJKFSLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x1149.google.com
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


