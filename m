Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE7ED3C92D
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 15:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2YG3-0003UD-F6; Sun, 20 Oct 2024 11:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFq-0003OG-Do
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFp-0005R7-5h
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729439644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r2SU/h69yvxkJM5HdDexHlLR1QA6w8NK8C4Te2utDtM=;
 b=bOIba5ih6rqaeb1vAddwjO9ITyyD8fer5mXP4hARSprabNofVTcitwo/HgaCxxSRm7Leyw
 xIJHwHqnsyrDznqhq0ctA97BOZXSRNB6RTo2FSPkhhlNbEKfLkymb3w/5pjw+pfQ/YUNtJ
 6tZGMJdjWer8aEOV0tlGPUAgx7/NKH0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-IzSPgvz6Ocy5WsAkplPnOw-1; Sun, 20 Oct 2024 11:54:03 -0400
X-MC-Unique: IzSPgvz6Ocy5WsAkplPnOw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4316ac69e6dso8108005e9.0
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 08:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729439641; x=1730044441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r2SU/h69yvxkJM5HdDexHlLR1QA6w8NK8C4Te2utDtM=;
 b=PEMOKpZ/zMuFq3U3L2cfqyndenS/Ao7isRjKZy12EMttTo1oJybC2qABGeeuXLknBK
 MyQE6btSK6jjZ5xbrvf9M7U6n0sqt/fX2os0Hj+r+dj3IdZLaBX75Qa7nHqNiVzZku1m
 F3HvbvaYErsW+nOwI+S9vNdOatc+u+f/lEejYsCIlNKCP9wulTI/xtG20B8ltBD3G6Y7
 XAGdWrE3LaSVuV5AQrpuwJJQwpNFkur60xCujyetsaEfXQFIvm0E5ttQ/z2Au2ey7baM
 4lXYbAsy1T9QA0ak8s8rW0D656emhv8zG7WUja6VJLXgoVNxpiVZvxyDgdunE8reELMZ
 RZKQ==
X-Gm-Message-State: AOJu0YxVx98SQoWt7ADpvEDdUFgWBRqDyfelNdf8GCqtDgk6oWPt8w4w
 QK9CBX4A2FW0pRN8G4AoznLIBbLTD1E/fBWH9NIEOm52qToJGj/3ynKCRgsJSV3asx5fLnOr/xb
 tatFTd0heB1HT1l1EYCv4ODZZaXGkE4FI6WTqrgelOSL1cGYPG4CsTC3HYiwKth4ewZ18s8V5wL
 m6MYaiLv8bE8w2beRbzooklQ2BnKR7A7l98I27epc=
X-Received: by 2002:a05:600c:1c81:b0:42c:cd88:d0f4 with SMTP id
 5b1f17b1804b1-43161687d53mr60849415e9.22.1729439641251; 
 Sun, 20 Oct 2024 08:54:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhLA2VvGCtJbTdIYWN4PTBA2eWRFA6d81knpIiAZGXX/06Tpteutg42Tb2GKV2+bTWdXwz3w==
X-Received: by 2002:a05:600c:1c81:b0:42c:cd88:d0f4 with SMTP id
 5b1f17b1804b1-43161687d53mr60849305e9.22.1729439640812; 
 Sun, 20 Oct 2024 08:54:00 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a37935sm2016639f8f.17.2024.10.20.08.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 08:53:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 10/14] target/i386: add a note about gen_jcc1
Date: Sun, 20 Oct 2024 17:53:20 +0200
Message-ID: <20241020155324.35273-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241020155324.35273-1-pbonzini@redhat.com>
References: <20241020155324.35273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 6e89d4faef1..5d729e68c98 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1193,6 +1193,10 @@ static inline void gen_jcc1(DisasContext *s, int b, TCGLabel *l1)
 {
     CCPrepare cc = gen_prepare_cc(s, b, NULL);
 
+    /*
+     * Note that this must be _after_ gen_prepare_cc, because it
+     * can change the cc_op from CC_OP_DYNAMIC to CC_OP_EFLAGS!
+     */
     gen_update_cc_op(s);
     if (cc.use_reg2) {
         tcg_gen_brcond_tl(cc.cond, cc.reg, cc.reg2, l1);
-- 
2.46.2


