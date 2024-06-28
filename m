Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF5DC3065A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPx-0005jM-76; Fri, 28 Jun 2024 13:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPw-0005j1-0q
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPu-0002Fj-Hp
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ORCk/FXIHVUbFmgn9cgWoHSkGsXOS7zZLuug5lf0HZE=;
 b=ZftkVedRVzYKQ4rhnTSa4D8sZ6sP519XtoKF57WJVbDKp3QtMwRj6ILfxwTDcB3HuudlCg
 dk/KwDUkRo9Yt8KZ6sZL84b2gQ0KH+kqUJX5y1X/QEhJMFKcna7Dpn036B0S2vH/V+6MPD
 4ue9OuM4pVFuxxjkdYSVYvbVPrBniiw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-pbm_nEQ_M2iayJZ7MZKtLA-1; Fri, 28 Jun 2024 13:29:44 -0400
X-MC-Unique: pbm_nEQ_M2iayJZ7MZKtLA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52cdd05fec8so898924e87.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595782; x=1720200582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ORCk/FXIHVUbFmgn9cgWoHSkGsXOS7zZLuug5lf0HZE=;
 b=wd00XCPEmKbSNrkiWWJaZ9JFmeLQyQZeXqs9oxDa/Wlnax4MGIN50GRJe2WoVNDpCO
 WbByxOrYkfyD3txE/mYdQJJjonSTQEuuzj17qxPlh4Fgw3ukt/s8CpR5Krwh8nu08Ls+
 Lkul6v0xSTDHiHXpHhg4oDVCcZ12PK2FQTaiTzUkjhA3VFzpFa6+uVLESWKDBVTIH+VR
 owdfVOURBR5TyQlnaWmGLiXvl0EMz+Up7t6okLT3w8dW048ogLD3vPOpgjDczdlLYmgO
 yWBdLhOyh7An/tMy3q2p2aoaiDzCX0bVn4WhLPRxg9hnoUn7cvu5j5t1uWLO1HwN2CsY
 PXRQ==
X-Gm-Message-State: AOJu0YwUD5SvYlSC6C6zXId9lLsqAh50bRLAa5aAQBhiTBxYqJ1pnawe
 C2u0X7fn90BnDY0pfxHI/LYBJcgmW1/lChaQKW8IwsueSeDohsS2wWWM0FgC0OM8s5VLapGTi+7
 k7v6tQ8mhP+lcfv8XLKF8iHq0CoD6zOsyM4DGqVGlpwPSOlGfXi2e2zFuTwzkGw0ss/lQlVPF7B
 cCmHanDbB2hiaj5IPticJlZ9hqJhHSduWHh1ZK
X-Received: by 2002:a05:6512:20b:b0:52c:d88a:8981 with SMTP id
 2adb3069b0e04-52ce183b245mr9936454e87.34.1719595781747; 
 Fri, 28 Jun 2024 10:29:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEetHpCOLmaxg1RSBItWfs+DPeYlvmDTGhYxwJuyz5JLNynj5E9l12tOzyjUXFNzMq0gHtffA==
X-Received: by 2002:a05:6512:20b:b0:52c:d88a:8981 with SMTP id
 2adb3069b0e04-52ce183b245mr9936439e87.34.1719595781181; 
 Fri, 28 Jun 2024 10:29:41 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0b809csm95552166b.212.2024.06.28.10.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/23] target/i386: SEV: store pointer to decoded id_block in
 SevSnpGuest
Date: Fri, 28 Jun 2024 19:28:51 +0200
Message-ID: <20240628172855.1147598-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
References: <20240628172855.1147598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Do not rely on finish->id_block_uaddr, so that there are no casts from
pointer to uint64_t.  They break on 32-bit hosts.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 6daa8c264cd..2d4cfd41e83 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -153,6 +153,7 @@ struct SevSnpGuestState {
     /* configuration parameters */
     char *guest_visible_workarounds;
     char *id_block_base64;
+    uint8_t *id_block;
     char *id_auth;
     char *host_data;
 
@@ -2170,16 +2171,15 @@ sev_snp_guest_set_id_block(Object *obj, const char *value, Error **errp)
     gsize len;
 
     finish->id_block_en = 0;
+    g_free(sev_snp_guest->id_block);
     g_free(sev_snp_guest->id_block_base64);
-    g_free((guchar *)finish->id_block_uaddr);
 
     /* store the base64 str so we don't need to re-encode in getter */
     sev_snp_guest->id_block_base64 = g_strdup(value);
+    sev_snp_guest->id_block =
+        qbase64_decode(sev_snp_guest->id_block_base64, -1, &len, errp);
 
-    finish->id_block_uaddr =
-        (uint64_t)qbase64_decode(sev_snp_guest->id_block_base64, -1, &len, errp);
-
-    if (!finish->id_block_uaddr) {
+    if (!sev_snp_guest->id_block) {
         return;
     }
 
@@ -2190,6 +2190,7 @@ sev_snp_guest_set_id_block(Object *obj, const char *value, Error **errp)
     }
 
     finish->id_block_en = 1;
+    finish->id_block_uaddr = (uintptr_t)sev_snp_guest->id_block;
 }
 
 static char *
-- 
2.45.2


