Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA89C3ABC6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD9cf-0005W8-1q; Thu, 08 May 2025 18:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3cC4daAwKCok0novur56rsn0t11tyr.p1z3rz7-qr8ry010t07.14t@flex--nabihestefan.bounces.google.com>)
 id 1uD9cc-0005VF-7K
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:21:42 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3cC4daAwKCok0novur56rsn0t11tyr.p1z3rz7-qr8ry010t07.14t@flex--nabihestefan.bounces.google.com>)
 id 1uD9ca-0003S2-AD
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:21:41 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-22fba10f55eso7331725ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1746742896; x=1747347696; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=fAPCiA6RKhgktgeaYt6XdYoAJLE7E95Vkv4XUtsa3Jg=;
 b=WV9NLbbxxrzn3ix6Q2L/6aBwNvcSx3Mk2uqXwNA5nqpZpK8hMX7HZlBNs7T6cp2lnJ
 wve4JSpHje5hVj0WwiswZ8U5XmD7KenTEeMS05lxbM3psCBUB1KAPjmtEEKnTVRRSldx
 Sy9XbkW/LHTm+U4hP48s92tjFmMbw9qEaqTfjwk/9XTPK2j7lAFK9SwoXl+/cPjDUgh+
 4yNWY0S3A42Ue2NItM34iRyQdbwv4e2VJV0Qo7nz5PyA9FgbStzBJe3307pmSsQ6PzXb
 eJeZmMdGbx/74+i+fPZkrRRyyBH2edjtHFAlAuRXtFViE0XwAkBegx4CkXKCwDrcxxmS
 h8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746742896; x=1747347696;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fAPCiA6RKhgktgeaYt6XdYoAJLE7E95Vkv4XUtsa3Jg=;
 b=dmt3vLhPms+2tayZ8J3XTnyQrb1p2UDVZi+AIrvwXvnFTUaaVEUNTkcn101L3a6vJR
 FBGTRDVFW8X6unMV2wT150WLUIc1so29Esspw6rx18kyhlp76m1GPPNV1CZKtya3AChD
 Xlzk+i5j0vZl9OLyZoufwuqdkL4XXgaZSF1VhqNWwDug1HxBw5E4EWbCvocrA+26MFnl
 6issQ0PovhiUD6KHYeIUNjkiYmFYVo5WUDNox2Ynhlto3t1Pfpwr11ug6+3YWzAzIRcB
 gDh4oxfJgWwvYvt/U+aS0BMW+lt4eEypT+7lQO+VsH2WlW0+5h5TUO9/7vrGWGkfZFQ3
 bf6g==
X-Gm-Message-State: AOJu0YxHpMshVtQ8ax4pBdV1mU5ci3/NGCwn9JAm1J5bD6pPALugmCdR
 P/A3OW3m2PZfp7P9BlEUrsXJobe/7YjRTXMoF9A+CtPTa0gDlijsUKw1beG8NCUXWtIjlOebTsq
 AkYIqC2dtPXuCfTPFVIYAVMxC++FfDWr6l8tC8SOxgFV7oUAAcYVvwgwtJMTFGGsu0/mpSeHNC2
 RVtKUXp1shPT6hHV5rzCpoMi9UPiyf/1AmPI+JVNLzu2B8SrV5D0yqpMwbJf3lRDc=
X-Google-Smtp-Source: AGHT+IHBOykAl+9pkLECBkKW+tqqBC4S9PQU+1cqMmyuAIhaGhyD4dp6Kb4qva58sJtgASIwSgjP8eKRxpq5CIJW4XY=
X-Received: from plle7.prod.google.com ([2002:a17:903:1667:b0:223:225b:3d83])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cecb:b0:22f:a932:5374 with SMTP id
 d9443c01a7336-22fc918d1a7mr17310455ad.48.1746742896087; 
 Thu, 08 May 2025 15:21:36 -0700 (PDT)
Date: Thu,  8 May 2025 22:21:31 +0000
In-Reply-To: <20250508222132.748479-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20250508222132.748479-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250508222132.748479-2-nabihestefan@google.com>
Subject: [PATCH 1/2] util: fix msan findings in keyval
From: Nabih Estefan <nabihestefan@google.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, armbru@redhat.com, 
 Peter Foley <pefoley@google.com>, Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3cC4daAwKCok0novur56rsn0t11tyr.p1z3rz7-qr8ry010t07.14t@flex--nabihestefan.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Peter Foley <pefoley@google.com>

e.g.
I	2025-02-28 09:51:05.240071-0800		624	stream.go:47	qemu: Uninitialized value was created by an allocation of 'key_in_cur.i' in the stack frame
I	2025-02-28 09:51:05.240187-0800		624	stream.go:47	qemu: #0 0xaaaac49f489c in keyval_parse_one third_party/qemu/util/keyval.c:190:5

Signed-off-by: Peter Foley <pefoley@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 util/keyval.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/keyval.c b/util/keyval.c
index a70629a481..f33c64079d 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -187,7 +187,7 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
 {
     const char *key, *key_end, *val_end, *s, *end;
     size_t len;
-    char key_in_cur[128];
+    char key_in_cur[128] = {};
     QDict *cur;
     int ret;
     QObject *next;
-- 
2.49.0.1015.ga840276032-goog


