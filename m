Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9096DC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 08:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjapk-0000RQ-Ft; Mon, 11 Mar 2024 04:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rjaph-0000R6-AL
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:16:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rjape-0005ug-FZ
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710144985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=o6u5chL0ZKfspPibUdL3kaZu+1Hx9Y3Ha5YkUxPtjaI=;
 b=M7htUTvr7AbN9F7fb8uHerLIoHrtJ5c+uPyHy0f9FTYd+5EmHxrd04z5PQWALNoWjHQa59
 yucP25w7SVASNILkJrUGPDhXQVEeTxPeNDRcAWKSvPgWQJoBi36dR6zE6gpAITWkVonbQs
 H2q8AeJc0nyrOHnKuIVRp25xjN1SKzY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-MjFDK3NfM2S8Fb_1t87KHg-1; Mon, 11 Mar 2024 04:16:23 -0400
X-MC-Unique: MjFDK3NfM2S8Fb_1t87KHg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a4488afb812so204333466b.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 01:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710144981; x=1710749781;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o6u5chL0ZKfspPibUdL3kaZu+1Hx9Y3Ha5YkUxPtjaI=;
 b=OXlpjIJFV2cOK31OUvvrcF3ISH0RZUc6Zt11pQlfd2jGKnFdmOtP1FRaFwgVLRuqzS
 mL9jo4HRsBIQUf3vL4ROmbk5VBZomUfoohMhfJWkvYmnKAa7OzvldMGA1b6J8Fs46TyU
 Yhy2PqfZs+aHQkqHHW1V3QAau2+2lsMWNxWvy8VqVYoUey9p6YC1UcjTRs9/fDIwXFP5
 6/GVQ8FzbhOP8DJ9sqdPi+/IQlTrwy6nQsqJx0DkwcrlR3xtJ3vgrpP4crjXYl/tJqaz
 gb9ajlftfKthZWMQaTrnsbQnztFQSgw5WmIlFwPoxSjn+v/pv9tIe/VIuTQkwDO14+cN
 c0bg==
X-Gm-Message-State: AOJu0YwS6s1kSOT9x7HfF9bdth6u5MuoZpMGo+zX3BDe561rPtfkM6We
 ewQOLfPw7bxhnemiTYVUUdxTku0gPItPBY9QunM97uVH0ghjpD4a/+/p4LNOHcojeQ6qMZ6Qmph
 dUgPSswaLEqbsilCFh6vE5rNiZzYTu2yxbfnCyffe50sD5BbXwVsbUYhmm6s/X1Vib5vH00mpiV
 xP4vHEx/j9H6+I+XZ5UxreoZsH2+6Vre9zpuiY
X-Received: by 2002:a17:906:bfe7:b0:a45:f89b:a915 with SMTP id
 vr7-20020a170906bfe700b00a45f89ba915mr3246493ejb.45.1710144980893; 
 Mon, 11 Mar 2024 01:16:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb9a8psONN5/uGNiWlBvcaxrz1SgTp5rOmrnJ8QLzP+hCAmMKZf8O3I09u+R9+S6cgGepOXw==
X-Received: by 2002:a17:906:bfe7:b0:a45:f89b:a915 with SMTP id
 vr7-20020a170906bfe700b00a45f89ba915mr3246480ejb.45.1710144980485; 
 Mon, 11 Mar 2024 01:16:20 -0700 (PDT)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 bh21-20020a170906a0d500b00a44efa48c24sm2626500ejb.117.2024.03.11.01.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 01:16:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] tests/plugins: fix use-after-free bug
Date: Mon, 11 Mar 2024 09:16:19 +0100
Message-ID: <20240311081619.669832-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

rec->count.score is inside rec, which is freed before rec->count.score is.
Reorder the instructions

Reported by Coverity as CID 1539967.

Cc: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/plugins/howvec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 2d10c87e0fb..94bbc53820a 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -167,9 +167,9 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
 static void free_record(gpointer data)
 {
     InsnExecCount *rec = (InsnExecCount *) data;
+    qemu_plugin_scoreboard_free(rec->count.score);
     g_free(rec->insn);
     g_free(rec);
-    qemu_plugin_scoreboard_free(rec->count.score);
 }
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
-- 
2.43.2


