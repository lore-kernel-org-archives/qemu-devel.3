Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39790C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 13:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0KSP-0004nL-Uy; Thu, 03 Apr 2025 09:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0KSL-0004mS-Cx
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0KSJ-0008To-Us
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743686283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hK1VQdhGXr6t7dx8oFywUBtknIybBnZEBM/8ByV3isY=;
 b=VuESBqd8wJnoJ/IAd/zUB1Oj0H3eY+7brmV6+EA4YAgy9hdqPeUsg/X4UkWOKawxNoWqH3
 ui61xhqkxMNoUv2YsdTgLrb2QRix/4p30slUJI1zoEUmT8lrcaX+lZjQd6xc506NVFDAEG
 7uzIsbAm+5xQyB5hK8f0CRo5rTGykd4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-aR9sP9goORK08A8Xqyt4jA-1; Thu, 03 Apr 2025 09:18:01 -0400
X-MC-Unique: aR9sP9goORK08A8Xqyt4jA-1
X-Mimecast-MFC-AGG-ID: aR9sP9goORK08A8Xqyt4jA_1743686280
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac3d3cd9accso74891566b.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 06:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743686279; x=1744291079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hK1VQdhGXr6t7dx8oFywUBtknIybBnZEBM/8ByV3isY=;
 b=KlKJxO4BDys25CmfsPifD2kijTY2cFseJa9wxFwfHcF1dxJ2jBr2HGy9Tjwj7nsJYg
 t5lAVHxpt/eNUpjlTdSKG4UFuWaZzKbnReNlxVQNSLW6ZQ1EYlBqEUCwGMS1Kyfaa0Lp
 tm5+URUOwEiFQpvLgMBHEUBc/+TNAI/b+R5zkoT56ePu/5YpA0Sn9fDBS8VyUls2SMkX
 a3BjUPblDlwaMwsKw12yfZEgH04KlcTAf24Qe/TXIMlMbGiscG5Xlerg6rJKKpKVffgj
 9APteBbRgHSucr67PxAsFZLqueyxiLswnyJMRURS1qfJGJJa58FcazFXDsywbnbz9Jg0
 oOdQ==
X-Gm-Message-State: AOJu0Yy/FemXk86S7BQ2gGI5e0cPOowF1pe8Mt+8kkrxonRhymvVHKfg
 NFtvObr/HGsnJB41R9VYpDbvwxbaQj+ZHEiN84Iy/bb3B7AMAcQZEyYkRDJRkAgLj72SfyFbIRM
 l4Rbhl0eFAoMh78E7ZXjhHYkwSnRp29i1d/oVV7OnX83xoLB1Qwu3ThrIrBB6bDKiZTnWWMJbwO
 yXqfiepNmVcyLMT9DALSZZFiDtCxz93RtYL17k
X-Gm-Gg: ASbGncv5g5AF4z9SbOSTJqC2RlRyuVa2b7c9ij83L2rfeJ+XFOU7QLZS+mDDdfzXjIA
 70fQkOwfjDL2PdQvkoXvH74RQRkWRx7yr6Cq/DVx7N2BfaSaEjqVUwQYAtduljUjJQN3llBuiLg
 OY2Pzt0GJfaIZ+KQaYzOPgT1H8PuedU/u4Z94PbV6v7Pkb/v+s2EBvAY55mWqjXIYBz3tmyAODH
 Qzhvoi/L6PJSem9719fd9s0cr3Ils2PmTLryFLyAjKoeYcb+R0RTJrW0kf5I/gTvrRa9ZKph4LP
 51rDDLSm0xFqPTYSMJ3K
X-Received: by 2002:a17:907:72c4:b0:ac3:8899:d2a6 with SMTP id
 a640c23a62f3a-ac7bc067d9bmr225038066b.12.1743686279216; 
 Thu, 03 Apr 2025 06:17:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyY9HucX6eJznLXasdmNwiAkD9tXY+fdRO7/orCYTaLAMsId1dImomE/oh5VCzXcVXfxzfJA==
X-Received: by 2002:a17:907:72c4:b0:ac3:8899:d2a6 with SMTP id
 a640c23a62f3a-ac7bc067d9bmr225034666b.12.1743686278728; 
 Thu, 03 Apr 2025 06:17:58 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.230.224])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe61bb2sm93513966b.32.2025.04.03.06.17.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 06:17:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] target/i386: emulate: microoptimize and explain
 ADD_COUT_VEC/SUB_COUT_VEC
Date: Thu,  3 Apr 2025 15:17:52 +0200
Message-ID: <20250403131753.82072-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403131753.82072-1-pbonzini@redhat.com>
References: <20250403131753.82072-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The logic is the same, but the majority(NOT a, b, c) is brought out
to a separate macro and implemented without NOT operations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_flags.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/i386/hvf/x86_flags.c b/target/i386/hvf/x86_flags.c
index 03d6de5efc3..25553bd55fd 100644
--- a/target/i386/hvf/x86_flags.c
+++ b/target/i386/hvf/x86_flags.c
@@ -45,14 +45,30 @@
 #define LF_MASK_CF     (0x01 << LF_BIT_CF)
 #define LF_MASK_PO     (0x01 << LF_BIT_PO)
 
+/* majority(NOT a, b, c) = (a ^ b) ? b : c */
+#define MAJ_INV1(a, b, c)  ((((a) ^ (b)) & ((b) ^ (c))) ^ (c))
+
+/*
+ * ADD_COUT_VEC(x, y) = majority((x + y) ^ x ^ y, x, y)
+ *
+ * If two corresponding bits in x and y are the same, that's the carry
+ * independent of the value (x+y)^x^y.  Hence x^y can be replaced with
+ * 1 in (x+y)^x^y, resulting in majority(NOT (x+y), x, y)
+ */
 #define ADD_COUT_VEC(op1, op2, result) \
-   (((op1) & (op2)) | (((op1) | (op2)) & (~(result))))
+   MAJ_INV1(result, op1, op2)
 
+/*
+ * SUB_COUT_VEC(x, y) = NOT majority(x, NOT y, (x - y) ^ x ^ NOT y)
+ *                    = majority(NOT x, y, (x - y) ^ x ^ y)
+ *
+ * Note that the carry out is actually a borrow, i.e. it is inverted.
+ * If two corresponding bits in x and y are different, the value that
+ * the bit has in (x-y)^x^y likewise does not Hence x^y can be replaced
+ * with 0 in (x-y)^x^y, resulting in majority(NOT x, y, x-y)
+ */
 #define SUB_COUT_VEC(op1, op2, result) \
-   (((~(op1)) & (op2)) | (((~(op1)) ^ (op2)) & (result)))
-
-#define GET_ADD_OVERFLOW(op1, op2, result, mask) \
-   ((((op1) ^ (result)) & ((op2) ^ (result))) & (mask))
+   MAJ_INV1(op1, op2, result)
 
 /* ******************* */
 /* OSZAPC */
-- 
2.49.0


