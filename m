Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD769CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rl0-0001rI-LS; Tue, 30 Sep 2025 00:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Rku-0001ob-2r
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:14:24 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Rko-0000uw-TJ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:14:23 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3f0308469a4so3076668f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759205655; x=1759810455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cfNLwv+i5cO84zMF6diWkvUfOapkzoMYrwwz0ZMfYgk=;
 b=iWUw2zCJ6+RAADwmLX1QsrzZQVeE6rmLoRQWTSBFhj75qWMMxXjVuupNvDC7KtBZWx
 UqejVTfzudDNYpZag0Q+uxZPqaDnhhRiO9SqH1oArMEN3KA5Zg29xjWAdyV30HMyVfQz
 p7tIp/ubL6CkfbYS5y/9RdQqpQDIfu2HQfAS0F6S/n64UJ84uoVlnDEOjZN1YOtqn4oH
 COohWnv5LigIi0T6kye66OeJTS9u67LBcNJ+pwFsBxE/t2XQHdZ1Yi9944l+YrqcHKKh
 dJLOq539oB/6+UT2rO8qbjgDgHNnQMUegpOHsYOhAo6Lz5TDkwMtqeTMW9MKYK5lcC2S
 cjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205655; x=1759810455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cfNLwv+i5cO84zMF6diWkvUfOapkzoMYrwwz0ZMfYgk=;
 b=iFfmm2olMK0l+3XBKUf2TEBjtW+7M7eHA7EMwpwY4CKQ+EMl9fIYnkLh9tVnhpq8Tp
 eEz4zo72VZ94ijJAMgXCULv3DR1XwTlv9j7B0qIFUpioExP4FQCxJMH0bNsTIZJZoSIz
 yCs8gwn0Oe3iiNXGqInj6NajDtH1ceNjqRzZbTmg7R31Hy7KNxXIF/N2eNBgHOJXtfz8
 5UOqLb0gLwBicybyMT/WTRYjIW2z2TngYzCpHEgBx2A1OLkz0kjQwX7SFFcPOot1pKhT
 3N44LUaG4dva06ppWlZklk5HvfTF4JwdPz63lELk0MTU++Fd7TjzailfYmhi4H+py02H
 VYKQ==
X-Gm-Message-State: AOJu0YwPGZMBkVTLlCsf1c/N/ZIWWe+jV6734JcS5JX9UHs5/KdXRtbh
 ysd8qXubz1cgEdLJMEbMbaZw9Ql0SmhGGJLgtRDd3Fvjz9OAc4J1o8nJaeHEhfta743HP1jGpnz
 qFHabj4q0qg==
X-Gm-Gg: ASbGncu37QxKc2pToRvyeue2nFjkmlCR2MvsF15ftg6cuguSb5KQvlCRysp6YAY/5fG
 Jc/gc3qkVllOAZnXfp8QWcOv4SZuFCq3YKyOUAUjVuTtzR+WqBF100v8JomV3f+Lv1cjfSrpP6z
 f6tcNN9aqfDrdbyvvhp8mi8hfN5jiQCnriYZEP1TjvJ1MCZWo1w6VvRtERsKGroJzWptyYOVYp+
 ZM/pEhWymVcng/LPN8/qdZcOYrvSnY3bWYd0/xoE/+z3q5FugiLwXeNVBUhHzWqXpdV0piWUUr4
 /yLrJ3Zgk5mcQStkG7KK1xcMXqojWmGU/5w/B2wFDR9yTGECXfmweRRiHik8qgqNcBMYtQjUrde
 co2j69JxDkL0PPATq7Zv0iTk2DJfBc6T3jT3qLAVA1ChBtJ9WKWYk+c9b4KtJZcIrYL6iZ5bWZx
 krgwoCzIwyhE9hj9t0G2Me
X-Google-Smtp-Source: AGHT+IHP/zG4X6xn4hUDdclB/D1afSsyjXOgC/ThtRrRCj048iTFTeDxSXkrbhWZePrU5zQ+WKtYTA==
X-Received: by 2002:a05:6000:1848:b0:3eb:8395:e2e0 with SMTP id
 ffacd0b85a97d-40e4b38923emr16718454f8f.51.1759205654828; 
 Mon, 29 Sep 2025 21:14:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-41f00aebdb7sm8027318f8f.57.2025.09.29.21.14.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 21:14:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Eric Farman <farman@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Zhao Liu <zhao1.liu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 08/17] hw/s390x/sclp: Replace [cpu_physical_memory ->
 address_space]_r/w()
Date: Tue, 30 Sep 2025 06:13:16 +0200
Message-ID: <20250930041326.6448-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930041326.6448-1-philmd@linaro.org>
References: <20250930041326.6448-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

cpu_physical_memory_read() and cpu_physical_memory_write() are
legacy (see commit b7ecba0f6f6), replace by address_space_read()
and address_space_write().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/sclp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index f507b36cd91..152c773d1b4 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -319,7 +319,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     }
 
     /* the header contains the actual length of the sccb */
-    cpu_physical_memory_read(sccb, &header, sizeof(SCCBHeader));
+    address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
+                       &header, sizeof(SCCBHeader));
 
     /* Valid sccb sizes */
     if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
@@ -332,7 +333,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
      * the host has checked the values
      */
     work_sccb = g_malloc0(be16_to_cpu(header.length));
-    cpu_physical_memory_read(sccb, work_sccb, be16_to_cpu(header.length));
+    address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
+                       work_sccb, be16_to_cpu(header.length));
 
     if (!sclp_command_code_valid(code)) {
         work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
@@ -346,8 +348,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
 
     sclp_c->execute(sclp, work_sccb, code);
 out_write:
-    cpu_physical_memory_write(sccb, work_sccb,
-                              be16_to_cpu(work_sccb->h.length));
+    address_space_write(as, sccb, MEMTXATTRS_UNSPECIFIED,
+                        work_sccb, be16_to_cpu(header.length));
 
     sclp_c->service_interrupt(sclp, sccb);
 
-- 
2.51.0


