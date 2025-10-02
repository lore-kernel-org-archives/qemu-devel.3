Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE55CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4EuF-0006w3-Jd; Thu, 02 Oct 2025 04:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Eu4-0006qf-HA
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:08 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Etl-0000uK-R2
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:08 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e4f2696bdso8989925e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759394559; x=1759999359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPyvtamk/7TWz3NLD4QWdvW1Is4VocR+bm6o/kbYsjI=;
 b=dMEAFdACXcEqjjETcDlkDp8e8gSrlBhEEKTJwhA/GTEIVnWmHgG1Gwkc+ZUYOhicnu
 n81knu2stpnjrsllTVZjRjol3EjFFXocKuVC5vKNK21GpYgT3jpmEF9/A6GaLRUNi5dI
 YEKrCz8T+lp35DQsQ5NryLbPrhx37DP19oMMhDMXrUVPk12dnQDQFLvryLHS+MI/vYF8
 f7JJD+PqHmC4+9A+ZaGaGtacWdSNNn222QLrxQWCsdiII69ukNpHFRmzVoo2Ngqsn6vZ
 rC4NCgC8efcltxsha6nmBkOopKmNCWtqBIEwqkfpfZZ4UVj9rxLHBxFdD2qZAi9I6GD+
 UO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394559; x=1759999359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sPyvtamk/7TWz3NLD4QWdvW1Is4VocR+bm6o/kbYsjI=;
 b=epHGVeRynPwb2vq0kXZZclc5t8pit0sWyqm6jjOgTeSVIt5I/gOMersEpvbf+0Cut4
 pdKQWCtwyJdgDVXyyVnRnXButNUp1euBzAmwgz3z20e9esb2sCwBVdBbuyrxUI4wY0zy
 jz2gY0AlZhSAwOpeEGmKkid21UauqqMgJ16VeV1rhChzNEY10HZolk2JMz3kqevrqiSm
 zx3zXzSz5UryIG0ZkzWjefd9znKSO6ZuuD8h0pz15075GrTCNwqFubUwx3MVfR4v3mDz
 pZWa2QaxgQ0rQnypBhtHOwZILL9vcYipiSo036OeehaMEOuS3ksfwxAJIJwH64qrVBvk
 ByYg==
X-Gm-Message-State: AOJu0YyKT7kSVZvAGG7GftljAbdB8EG9hGniEvIyBu2F/as1gIJJq2KK
 CTcgu6echyC2o+Q90/MrGkP5TVP5BFSYB5iQyshcxl5+l8l6M3TxmV/FZKQjB0SGztHp+8PQRDA
 ai7BY5CGGGg==
X-Gm-Gg: ASbGncst73oO6GATL+seWNLZ5PmtM41UNBQQ9dEvE8ySzmVp7/grFk/Oc0ElarnssZo
 MS6JtK31+bproCAydnsa6xMPMBdHDQOPYOhqHPPlck+nYTMhygtp5qm00bmMUAs0iz8OQJMjnvG
 V/Ny33s55Yc/tpkbfPdda4FFsbXawrnskglo45bKGnBH5HuyMmAIq4xGORbxc1ycV8TwsgOr7xg
 a4ZVPYs36jWvhuieptYaZSZmTXgRRbgE3043Hw7H/g7cf1blrd7vrowMnN7cZB9veEMFb4BjdaI
 ZmLhKBU9ksGsYJJxGMvloGPqXULQqw20AZGToxr/bWFHDT3P/RAvKxgeG/SAUjJgD/oYOObp4Kg
 /mk+XJ9xkBMG/jqGjMCXo/gEJN/cwY4OrjJZJKuNhq5xVAjGZW5/0iGx8H4JklZQbopgUYpfMzv
 Uc1K5GFVSZNGxf79625rv/y33bGkO0ZsIauOvm7eqO
X-Google-Smtp-Source: AGHT+IGiO2MQIF6Yep6y2/isH2QW+nXbG00es5/W6noyWTP2pD3nWUiti/7EsFpua85fKefjjBmssQ==
X-Received: by 2002:a05:600c:4fc6:b0:46e:1a07:7bd5 with SMTP id
 5b1f17b1804b1-46e61285d7dmr48438525e9.29.1759394558687; 
 Thu, 02 Oct 2025 01:42:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f50b2sm2597515f8f.56.2025.10.02.01.42.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 01:42:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 07/17] hw/s390x/sclp: Replace [cpu_physical_memory ->
 address_space]_r/w()
Date: Thu,  2 Oct 2025 10:41:52 +0200
Message-ID: <20251002084203.63899-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002084203.63899-1-philmd@linaro.org>
References: <20251002084203.63899-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/s390x/sclp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 16057356b11..d7cb99482b2 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -304,6 +304,7 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
     SCCBHeader header;
     g_autofree SCCB *work_sccb = NULL;
+    AddressSpace *as = CPU(cpu)->as;
 
     /* first some basic checks on program checks */
     if (env->psw.mask & PSW_MASK_PSTATE) {
@@ -318,7 +319,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     }
 
     /* the header contains the actual length of the sccb */
-    cpu_physical_memory_read(sccb, &header, sizeof(SCCBHeader));
+    address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
+                       &header, sizeof(SCCBHeader));
 
     /* Valid sccb sizes */
     if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
@@ -331,7 +333,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
      * the host has checked the values
      */
     work_sccb = g_malloc0(be16_to_cpu(header.length));
-    cpu_physical_memory_read(sccb, work_sccb, be16_to_cpu(header.length));
+    address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
+                       work_sccb, be16_to_cpu(header.length));
 
     if (!sclp_command_code_valid(code)) {
         work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
@@ -345,8 +348,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
 
     sclp_c->execute(sclp, work_sccb, code);
 out_write:
-    cpu_physical_memory_write(sccb, work_sccb,
-                              be16_to_cpu(work_sccb->h.length));
+    address_space_write(as, sccb, MEMTXATTRS_UNSPECIFIED,
+                        work_sccb, be16_to_cpu(header.length));
 
     sclp_c->service_interrupt(sclp, sccb);
 
-- 
2.51.0


