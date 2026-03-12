Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E336F105A594
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 12:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0fIc-0004li-UW; Thu, 12 Mar 2026 08:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w0fIa-0004lJ-Tu
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 08:37:56 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w0fIZ-0001h9-G4
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 08:37:56 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2aec4a71ef9so2605025ad.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 05:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773319074; x=1773923874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4kpKB82B808dmXk8GsT3FbFqvAl6veGW+hmwY2lKqMA=;
 b=cuxKaYfY0ifJo3OjZhcaXuRpRBAofHqctfsOUsoM2aTXdbUJv/zVj4dD2Jc+I336mf
 GdoNa+LOjO/UmJYoIG/mZpSypGMI9i69J60h9RHncywYAll4VLlHnE0eft7++VZYQBfE
 x3/zgpVIwljC2hCDOpmjrD1XPJIrdVV3YwDVms0vKtGa24/ynyIY5a9ISYBMAUhQxO0K
 M/h7y7+mfZfb5UrCIYsQjXb3ZgUH9HyhTRTbqj+mEvIz4ZOuALJBUfef0cTpwoSxJmN5
 jiZK9zPXQbqS36nLnADClGbxmIVcgI5jrapFTacdisSVbAmy6UjVHR3I9QR8whSG0HBn
 dAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773319074; x=1773923874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4kpKB82B808dmXk8GsT3FbFqvAl6veGW+hmwY2lKqMA=;
 b=bfsyLl6LA68STJpM1BKGLDF7tZphhkpeogI5f26wmPFDNoTO7pvEHMOoMo4Yq17utE
 m6Ohgp3M05+DamACsmE61kV1FkxkLdtWdOIuEKPwvbOez1Xe1M8M8DArS6VlgaPaLYPF
 GzjOfLRLyg+n4lnCmy4PC6AeUdGaIylmMD4nJYsZXW2pwou2JLoxoIUQ0YoyLQPPJlWj
 CDJs82IbMUNlmN2no2eOvCQqnEk9bg8iFzVtuBIvUYhC0/N+FBUwZAj5BZ0Wb6T6xJTU
 ABthE+A5ZFcsM7ejTvZpYW3XcGtIhi8vih/xaqJwvZrVSbVQfzDmg0hQL8gJCCdIevii
 PVeA==
X-Gm-Message-State: AOJu0Ywq/VrKRPVDVhVxfABfKEMats0jDquXH6sOojvfpozy3dKuLDx4
 FgGKxhV0pJyNvtzCyRi4AcRKy2OvC69RNhB0JerHTRAtgwnoq80iT3tcFrr6Uw9WYLs=
X-Gm-Gg: ATEYQzwv/1O0KonhMePXHyTKZG0Tq/gMJY1u/5u95w7rLX6vnyi9VzND/rvIgc7J7ae
 QpY9GFiFwgy8zllWKxqLbrz52ALNeysKh/i+K1EZ33FRqL3mM5y0QJNSJNsL1WygQTwLFCTGjZY
 bVKnyOBUx6SdEpdq9uHNrM0jCE7G7/t7X5qQSEzp1veHT2Tnc5OiDZjDUhNTN72jYq5UmapJ6O1
 1CQPJ55nbrlhWz6Y4ado5jSRheGzPJVfHvIf/PkwcD26DD4QrxEaJHzZ4ItPvrH4HOdqjVC9+Tb
 /IqvY32eVj9m6lfbsN7uovEygRLDu1LsrRn/arnW6INQHNpjs2BgnKcpxyX1ezq8dOoSScOC0Vj
 w0c0Cg4uZBZ/LhvXVPinKRX1jlV9rwvBNsHlAu109WnYwNZ7bMHw8NAszpS/JF1adwC1d4bWxON
 5u3UuAyfd+S98CpcD3MctXjgJ/Kjx9Vw83yrkfQEyP8mxhl4cN4390KaOmQxqNwysTr17kNR8J7
 ldoJFMK9Q==
X-Received: by 2002:a17:903:17cb:b0:2ae:c529:a130 with SMTP id
 d9443c01a7336-2aec529a950mr10622195ad.9.1773319073829; 
 Thu, 12 Mar 2026 05:37:53 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aec7c81621sm4550265ad.83.2026.03.12.05.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 05:37:53 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org
Subject: [PATCH] target/i386: Fix dereferencing before null check
Date: Thu, 12 Mar 2026 21:37:44 +0900
Message-ID: <20260312123744.232366-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The 'sev_common' pointer is dereferenced via SEV_COMMON_GET_CLASS()
before it is checked for NULL.

Fix this by moving the NULL check to the beginning of the function
before any dereferencing occurs.

Resolves: CID 1645467

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 target/i386/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index cddffe0da8..d23694e05b 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2009,11 +2009,10 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 static void sev_handle_reset(Object *obj, ResetType type)
 {
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
-    SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
-
     if (!sev_common) {
         return;
     }
+    SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
 
     if (!runstate_is_running()) {
         return;
-- 
2.43.0


