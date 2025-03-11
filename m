Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16252C35FF1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzIr-0002oH-AC; Tue, 11 Mar 2025 09:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEX-0005Vj-7I; Tue, 11 Mar 2025 09:01:27 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzET-0000FP-7t; Tue, 11 Mar 2025 09:01:19 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ff797f8f1bso7290510a91.3; 
 Tue, 11 Mar 2025 06:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698074; x=1742302874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kNfAFKwb/h/Q47CuyyAbJR4Xbbiqi59X5UF2kJZMU+s=;
 b=kxuU6wQQwNaZ4em4NG4E6Q0MFA3DZJ85S04AoxUi7JnFufgZoZhtkwGfIDeuhw+6pK
 NouYzoddDctuadi4UL7/il4Rkof4m5BJAUVo4fhE+af44/SnqtEhB5JEBJ/jZqFvfPgp
 cqimOvAP5CbNQacpHGFDnOfsnHmbSkO5A+aTJbvFOoG3zXSB6R06MFhovsoLygaFwri0
 eHOT3In42NwyutpLmsgQaEUjs6xoCJDxkoNUNdNRykUGQg3UuTJQj13vjEvq5fRNazfg
 gP/xJJ+j8Ai2s3wEJkoFKxsNpANhE7B9UkTdHadC/0Q+U4lwREjGt1HyF3ByN7VXYIFy
 C1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698074; x=1742302874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kNfAFKwb/h/Q47CuyyAbJR4Xbbiqi59X5UF2kJZMU+s=;
 b=ltr/HqNkrFcKauHaTi/qbXnf1Whr5KRT4QIaJXkSDLSLDgm42UDOG3WohAAXCx8hgf
 MHuKb3Fsp2qJmuKwd+4SpP4qQsunM4cAMJkQeYMTZZvdTWKngcdy/0OoacfdvRSEKSgq
 TX3v3N1h9G5YeqdXB1PXtEnEexmJ5AlLE6CBADA2JLo4UiY68JhPqp/047NvYlZj6L2u
 zElTps19q46kD1AVH1wvFZ/n4bcDaj44bj+9TGu4BSeDZP9d8J6g2EbmfdVQZgZShaNJ
 xNYWbCJhigc1qsh9WGxr0qfEitqhDKt+2LpcHr9L7ytMcReCs4PQVjNTUm+O+Urf/guq
 IPYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/LoaRH22fENwWTcy2vdTdH+YlsFVWkm0T+CS/pSNO31qSpkLi4HH9dbSGRFAItZ8boLf16fyvbg==@nongnu.org
X-Gm-Message-State: AOJu0YzHVvQLnBAW2ErImN2DZacFp18gRswQL2oEYCf8R+NLPt871B5O
 m509l/O6e2R4soXyG/hvV97gPNrO47261+2CFwKaaa0CGiOMvi4QzzQZoQ==
X-Gm-Gg: ASbGnctbmIEm6E+I3aLkq+8v7pPwPDCS8kkpoK9EyBtvqis29X7F+YZYQUHi98vqJV1
 VbrrYlhWJwxGtkmuw51y5x5L/BNiDObx4kpZ3AfGjJLWFoeAw5/jhp1AIpt4jZgHdT6aMdkY4A2
 0aSl8BFZxID09aAwaDQWXLqaWFLSCSoUY0l0np0weqodiFKgHx7asKelmc9xpUe5lPEf+smIoGP
 fqBLuJeT9Df0yl6GsVAy7B3jwt3+X2D/i4gp5DlJ2yTs7qWSwKOHkJ7xq8pTwtgDQK/qo6KDiyz
 H6Px5ydoB4reOZJR2QbUTkHGBnKRRCqKlaFJzIjOCrzsfEwq1NtqcGqjbu2z6Q==
X-Google-Smtp-Source: AGHT+IEUxDsnBxxE5nNu4SKGqQyGuvwFXnfJLIyrLcaDFm/15CUqwxnjvMAlvSg/FQ7RNNwBFBQGpw==
X-Received: by 2002:a17:90b:2648:b0:2fe:e9c6:689e with SMTP id
 98e67ed59e1d1-300ff0c9bacmr4859052a91.8.1741698074488; 
 Tue, 11 Mar 2025 06:01:14 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 55/72] hw/ppc/spapr: Convert HPTE_VALID() macro as
 hpte_is_valid() method
Date: Tue, 11 Mar 2025 22:57:49 +1000
Message-ID: <20250311125815.903177-56-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Convert HPTE_VALID() macro as hpte_is_valid() method.

sPAPR data structures including the hash page table are big-endian
regardless of current CPU endian mode, so use the big-endian LD/ST
API to access the hash PTEs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-ID: <20241220213103.6314-3-philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0cae4853db..daf997cea1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1409,7 +1409,11 @@ static uint64_t *hpte_get_ptr(SpaprMachineState *s, unsigned index)
     return &table[2 * index];
 }
 
-#define HPTE_VALID(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_VALID)
+static bool hpte_is_valid(SpaprMachineState *s, unsigned index)
+{
+    return ldq_be_p(hpte_get_ptr(s, index)) & HPTE64_V_VALID;
+}
+
 #define HPTE_DIRTY(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_HPTE_DIRTY)
 #define CLEAN_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) &= tswap64(~HPTE64_V_HPTE_DIRTY))
 #define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |= tswap64(HPTE64_V_HPTE_DIRTY))
@@ -2206,7 +2210,7 @@ static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
 
         /* Consume invalid HPTEs */
         while ((index < htabslots)
-               && !HPTE_VALID(hpte_get_ptr(spapr, index))) {
+               && !hpte_is_valid(spapr, index)) {
             CLEAN_HPTE(hpte_get_ptr(spapr, index));
             index++;
         }
@@ -2214,7 +2218,7 @@ static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
         /* Consume valid HPTEs */
         chunkstart = index;
         while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
-               && HPTE_VALID(hpte_get_ptr(spapr, index))) {
+               && hpte_is_valid(spapr, index)) {
             CLEAN_HPTE(hpte_get_ptr(spapr, index));
             index++;
         }
@@ -2264,7 +2268,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         /* Consume valid dirty HPTEs */
         while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
                && HPTE_DIRTY(hpte_get_ptr(spapr, index))
-               && HPTE_VALID(hpte_get_ptr(spapr, index))) {
+               && hpte_is_valid(spapr, index)) {
             CLEAN_HPTE(hpte_get_ptr(spapr, index));
             index++;
             examined++;
@@ -2274,7 +2278,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
         /* Consume invalid dirty HPTEs */
         while ((index < htabslots) && (index - invalidstart < USHRT_MAX)
                && HPTE_DIRTY(hpte_get_ptr(spapr, index))
-               && !HPTE_VALID(hpte_get_ptr(spapr, index))) {
+               && !hpte_is_valid(spapr, index)) {
             CLEAN_HPTE(hpte_get_ptr(spapr, index));
             index++;
             examined++;
-- 
2.47.1


