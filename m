Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8738D12663
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 08:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Evt-00035G-MY; Tue, 05 Nov 2024 03:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8Evr-00034r-Oy
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 03:28:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8Evp-0006Bz-B4
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 03:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730795335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2UOZcrVgXPkwDZNLiPo4ketdNOaWW/W0xEwr7eJy4zc=;
 b=is721H08SJftVpE+SvMs/BqIDLazxkn4dFxJlQHa/HkcT7glnjZbE+yWGp+ugqOgDgU+kR
 x5phGnoayRQphYejbi/4bl39x3e4BVNa7Qt56XvtUv4ISUkkJG0dTALCy484M1/5DWBAww
 uzezWLkI5MvB3tG+PPZMx/+cJjWTij0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-vJhadsUBMm2I0M1C7n9-jw-1; Tue, 05 Nov 2024 03:28:53 -0500
X-MC-Unique: vJhadsUBMm2I0M1C7n9-jw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d531a19a9so2764724f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 00:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730795331; x=1731400131;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2UOZcrVgXPkwDZNLiPo4ketdNOaWW/W0xEwr7eJy4zc=;
 b=L+0Oe+zSrKRYf3tVwl7dTKTX1HsgN7gyyB92xupae3Air7I5CPxWFKalW+iA5RpWEv
 ns0Qla4J7mWizxKy+rI1xXCxdWwkNUlSVpZUkAIw+ICM9WY17TVdauE73IIcQkTm9zeG
 Dh9myKLDEV28M8t3d5ICZmtU7Da2CXPwklOwGpr7XgkNd5W9v8XbVLRWSTSDVa9+8oeh
 +vzML4C3lv+KwVQt3swCj1bdNu0T+0pGaT5Ku8PwpkxtGTVocxfFbHvYHtXZ06NeXxAm
 d3ZugX1kNYVcnZf/GjcvKa9qk5Rt3+njeEtbr9WpfxAKxobTU3he+0qxXCzijyFkJUaG
 luag==
X-Gm-Message-State: AOJu0YyemdYw560GfD3/BlVndxv5tCP4T2hELFQ/n9GglyIY1IcWJr70
 J4ETdehBfGPgFuSvIi9iK/BekfKSS22EFomiSndOV6J1IbTCQlg4qBdFQn81VQhFbLzxBnD+Hpz
 tHcEmAP9CSmoRydMdL94XfEsufOMtxuV543r728wBlkw260fKB0R637ghNuMqsKfLZExUYXMLSs
 WjAtMtoZqEiLpJOorGJwPA/CDkzZkenOkmuMcN7pw=
X-Received: by 2002:a05:6000:2c5:b0:37e:c4e3:f130 with SMTP id
 ffacd0b85a97d-381be907327mr16551548f8f.41.1730795331085; 
 Tue, 05 Nov 2024 00:28:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGegtoYcVs3YZ/j7f3JPQXN9ZIISl6XoIIFjDr6opABqxJ4GZXZgGdAqL06ENyM+zTG7gBOxA==
X-Received: by 2002:a05:6000:2c5:b0:37e:c4e3:f130 with SMTP id
 ffacd0b85a97d-381be907327mr16551526f8f.41.1730795330593; 
 Tue, 05 Nov 2024 00:28:50 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d414csm15267093f8f.26.2024.11.05.00.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 00:28:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tao1.su@linux.intel.com
Subject: [PATCH] target/i386: add avx-vnni-int16 feature
Date: Tue,  5 Nov 2024 09:28:48 +0100
Message-ID: <20241105082848.230020-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

SHA512, SM3, SM4 (CPUID[EAX=7,ECX=1).EAX bits 0 to 2) is supported by
Clearwater Forest processor, add it to QEMU as it does not need any
specific enablement.

See https://lore.kernel.org/kvm/20241105054825.870939-1-tao1.su@linux.intel.com/
for reference.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3baa95481fb..ae5b85f4e8e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1113,7 +1113,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_7_1_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            NULL, NULL, NULL, NULL,
+            "sha512", "sm3", "sm4", NULL,
             "avx-vnni", "avx512-bf16", NULL, "cmpccxadd",
             NULL, NULL, "fzrm", "fsrs",
             "fsrc", NULL, NULL, NULL,
-- 
2.47.0


