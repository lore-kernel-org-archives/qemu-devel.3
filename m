Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3601C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 11:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMmql-00009S-He; Thu, 27 Jun 2024 06:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMmqj-00008F-Ms
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:59:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMmqi-0008Ki-9P
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719485970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=abscoC0lX1Ee1BtKDnuXw7QDVvtFTrSpSpzBrX/FytA=;
 b=bvhci8J4C1WEdn3JsLCwDyQA65iVIVDqLjMT06R8scqRCtbGj0NGWlXcU1YVTzk5zXApF/
 T0zKjLfNUSDV2ZN01ESyDbAfJhd9jQi9CotNcjFu1sQKgMW314n8OmFwLrvHEEoGkAgvIA
 wSJvwD7Iq0b0RHqD8BXwwb04N9LbSWg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-TLsx08sLP86OZghn8DbVbg-1; Thu, 27 Jun 2024 06:59:26 -0400
X-MC-Unique: TLsx08sLP86OZghn8DbVbg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ec4df4e2e8so51358851fa.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719485964; x=1720090764;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=abscoC0lX1Ee1BtKDnuXw7QDVvtFTrSpSpzBrX/FytA=;
 b=fpV0uOOL0M/c7JzIWxkF32RqVRljUVzU7eVNA385BQnzUi96tom7PG0dWXpTPjXbdY
 e8fbEGdqjWXNtXPOS/w2w8yFaGB4xjEE6/Z/YJbik/6lVL+pCWRf/kKaJ51X3erVAGhN
 967yLvd8gErusmgFmdBOFiHrawvSsADKjijMq6n5sPxHEOwDdpIXk5IeeMhPU4HDgx7R
 DeeJqQunZnXLAl1g/VgLIKi62wV873CyFhRPzM45UHqOTw2XfpHQrJhpkgxsCjX12S1i
 w92F+x8tLHCXDSbL4IlzMS1foljYLioQKm1P55DXiKeTxEXFDYh0Vs6L0bMHmYrSSuL1
 JC7g==
X-Gm-Message-State: AOJu0YwjfM40bnl1slMr/ZrVGN6NhOz57sVp2ilPKpuGpdMkqlyfRhM3
 1OseJnC1Fy4CdWDldmJfopHGuLFYTrDplqzrIH5r/5rOgs0+huauD9gFwsx68t8KGieoSuQMx0l
 eHR36UjbtU4kZ4PqNmyEsA5BVB58BimJDRsKaQcDvmvkVtdPgvBo8UH+XSyQgwkNFPO5ZJq3gI8
 yvikARlnePb1+H0l3orcIxiu9W5uJwTW/vjoV5
X-Received: by 2002:a2e:9495:0:b0:2ec:529e:6522 with SMTP id
 38308e7fff4ca-2ec5b2b208cmr70933101fa.31.1719485964471; 
 Thu, 27 Jun 2024 03:59:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0pWc4hUnFjoX7gfFwuomVspyPN8gcgJurjnXZmpJx2GOOcPneh3Yk63P4y0lsGRBfhRJVgw==
X-Received: by 2002:a2e:9495:0:b0:2ec:529e:6522 with SMTP id
 38308e7fff4ca-2ec5b2b208cmr70932611fa.31.1719485961957; 
 Thu, 27 Jun 2024 03:59:21 -0700 (PDT)
Received: from avogadro.local ([151.48.235.205])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-584d0c9dbf1sm717203a12.19.2024.06.27.03.59.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:59:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386/tcg: remove unused enum
Date: Thu, 27 Jun 2024 12:59:19 +0200
Message-ID: <20240627105919.981453-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 257110ac703..aeb7bc4d51b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -282,22 +282,6 @@ enum {
     JCC_LE,
 };
 
-enum {
-    /* I386 int registers */
-    OR_EAX,   /* MUST be even numbered */
-    OR_ECX,
-    OR_EDX,
-    OR_EBX,
-    OR_ESP,
-    OR_EBP,
-    OR_ESI,
-    OR_EDI,
-
-    OR_TMP0 = 16,    /* temporary operand register */
-    OR_TMP1,
-    OR_A0, /* temporary register used when doing address evaluation */
-};
-
 enum {
     USES_CC_DST  = 1,
     USES_CC_SRC  = 2,
-- 
2.45.2


