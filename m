Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FF7C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 06:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjYmq-0002SI-LN; Mon, 11 Mar 2024 02:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rjYmm-0002Ry-Ou
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 02:05:22 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rjYmi-0007ry-NV
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 02:05:19 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41312232c7aso18977575e9.0
 for <qemu-devel@nongnu.org>; Sun, 10 Mar 2024 23:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710137114; x=1710741914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T7wM/S+LBXC4hmfzLEA4Q2Vo+vH3NsQdY3B+yanN870=;
 b=OsWquVG3HOmrc/qhbLFIHmwU40dJ3zRKLE9wFYa2vjs04+gaptLuwWhkQAmXKBsWhS
 W/LQUdj1d3gswyYxFp68HjLpmr80q8sFCgO6hTbKl2edSbmqt2FgVLBv2pAZDabp2r+c
 pCOHC2CCfeoWVcL3S0kWSE3Pv1gwaVx2yyr45tMst5Ied1aN1VGsiGM0Rf4YuNpYnpEV
 XGaAz2y7zYlXJTP93yxj5N6I8s0atR/UVqgQBstp195xF2KOgi73QLgg308tTOO1MOWT
 O+pmn1GgzmHEp35l/yWwnS9J/yijvaHXvzqCC6CrdVXkDnuPQHIAbt9G7cGc4AQ/IjqV
 aFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710137114; x=1710741914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T7wM/S+LBXC4hmfzLEA4Q2Vo+vH3NsQdY3B+yanN870=;
 b=ObgqNleAvmQBeI/QL/H1eSyUWaAkgoRsK+eJtIMivtGwG+a7GmMkcJG0ov+xjfVBrw
 CDQVae8YfxXmrskcQ19UNRf2KCCSyDySh7y9q6sB2ivWFJNgDsYwGFqXIahNKnU2KuFJ
 jA6xxitpEqjSamKid64gVWVS9i7/sALqy+Hndw9Fg46B8ctM94gkebCKWDluxLPDj4wA
 3KyfoE5AT5OZ+3jYD5IKvG3fjVSWg4RNm3TNM50Ys0rioybP7Ivwj1Bff63vM5lyHGJa
 jDAO0Vqm6UVUi/rPtbGdyjI/l6F+op+aBxz528JC33kTZxSkgmhLo6ttbKUH72mv8c7a
 M2FA==
X-Gm-Message-State: AOJu0Yxl2iMm2CI4DAv92CrvPzAzh6KGpOovR24d9L40PO8qsrvPvSJ3
 SOccudqLZuaLx4be8ICRbzIJBHtyOO9pRkvCbL89dtWwN3S6VNJudzmMIGXicKuoXdcAo6TtFT9
 aAuM=
X-Google-Smtp-Source: AGHT+IFOrB0vYyxtTj2hReSNOpyLclogf8LbOyR766pQdpiEtTAeuplC0nRrQVLERmyv+Q7F9fBVXQ==
X-Received: by 2002:adf:c089:0:b0:33e:7620:7288 with SMTP id
 d9-20020adfc089000000b0033e76207288mr6531710wrf.20.1710137113703; 
 Sun, 10 Mar 2024 23:05:13 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 i6-20020adffdc6000000b0033b66c2d61esm5450044wrs.48.2024.03.10.23.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Mar 2024 23:05:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] plugins/howvec: fix use-after-free
Date: Mon, 11 Mar 2024 10:04:56 +0400
Message-Id: <20240311060456.218190-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

reported by coverity scan
---
 contrib/plugins/howvec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 2d10c87e0fb..5be91f6fc5c 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -168,8 +168,8 @@ static void free_record(gpointer data)
 {
     InsnExecCount *rec = (InsnExecCount *) data;
     g_free(rec->insn);
-    g_free(rec);
     qemu_plugin_scoreboard_free(rec->count.score);
+    g_free(rec);
 }
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
-- 
2.39.2


