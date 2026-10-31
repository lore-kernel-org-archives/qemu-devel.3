Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DF5606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x2eEvLyE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNC89-00021w-SV; Sat, 31 Oct 2026 12:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC86-0001wU-Mu
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:40:30 -0400
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC84-0007gs-MP
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:40:30 -0400
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-1a3c08d6928so2233832c88.0
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 09:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793464827; x=1794069627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eGnVCnTQCp+6LgMeUUkhTtcg3Gr700DtQC6abT73vWQ=;
 b=x2eEvLyELCQGjquBnIwuRg1VgUXXhGtxZBdISNPDiTtpJDar1fxzzQxEFxXvaIArfy
 2zZanF9viiN1cI3PssF/p/kxQRS3OXMaa7qcFlizB8qSOWTl6Rg+s/CfauzLWxtb+Kxn
 8cr2gUHBfxYmBJwVV81QpdagsuJkgbOsuh2pTtjCO17Hpml92bCySIyAHNBYAr0/mPqj
 Ehr9k8tfSrWfhqkXhvYhVnEWuXIolP0k28inchXiNEVb0VtYCEKR5PH2UPTwMiXFIkgV
 uLzPvNbCQ30/n+WzwtFZNujq6DRbBsXaYE//2KlJCk/EqCk4khVZOaDbWo+IcLHZDeyx
 gKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793464827; x=1794069627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eGnVCnTQCp+6LgMeUUkhTtcg3Gr700DtQC6abT73vWQ=;
 b=VsKx8AvkzaLXy6JLHOg4B8CKgDh/7CMLipLvMDLaU8KV0kGtej+RZR6Hfie8wrEZXc
 CmivrWqQfCjNGqtDNmEjfRGhhAXhQBS79YFxUhaeeZES8pOgBPQ63UcL8MjpL82d9ZA+
 d8PsXOK8/N1M8pi2sHpO/S14JmnUYySZrlFPIArXP1L+LogxyLpHOs746BpM3aZORTP8
 NVcZshW+VjereO2uTqRaQcGmlzcNJ38VfulujxEgoIeKCpvSnP1KIp8le1R9W3MSGY4L
 pWYwy5kOv/ZjQJffKEN1ZpxmqRXope1AEuCPcCpA1ecaZNt4utxXVquyclmu+MSgdvo1
 fnJw==
X-Gm-Message-State: AFq9FYLbw7+OVMeG3m4R1fuylq7fxah2oOUueasH/iMH8Jj39AICYgVd
 HsXgLsj2xTS5Q6r6GAQns9JR3oV7sAhjP2O7d2sp7Jq6wQgAwuu7r3raviiyELng
X-Gm-Gg: AYBFou1iSQADt4IvxfjJMtv66uLjyVtW6gCnBWJC8NDjzMqC/g0m+1MzeUlLz/y2csE
 eX4zXPNko1gP65yLP3dNoEvF2tw2CUcsNjbNDiTz2WhYK9FFGnC3EMcYqXxHkKWk3DAnDmrGKib
 F+81GGOk21kpcy8VRnRq79dxP3a3Ma9YQKfoT3DunnfOjBtIDYixvNJM6/UgFVch8/f3kuO4oHY
 +04g7jaJwUmka858mgPp/18Dp3WybvyqjlWMGpyrr6koptC1xwB9ZPxvFpcgPCQRTBE+MC+aCDR
 F5wYHQeMeXJd1gsEnypN20dqR6JYE7rFL+Z/fZgFYKL244Y6Xco5XLPinIoiT5f41tTD7eatDe7
 Rtg3zWG9iETASE+OOCDgYoOq066gRKh7aTuRkftxRgfzV+k2XVC2/QN8jW0LBWGZYju4g6KLifO
 rgdPaFWQY64EZIIqlDyV5xmeO5wOGDWURo2YPbFy2BrqZWQt44Umrm3smmIHHyd2tPhIUFbeO87
 sHqJHEMDSWKXXE5usp0tKkxtZIHrh/58gPudjFmsgosz+wxnqDhPZIix62C/RttIu0TqzOPqHgA
 Jlwc8WgZk92rAz+bx6OhpSMIOHGn4Q/ZTy+XGEkusEbdbNYe
X-Received: by 2002:a05:7022:1089:b0:14d:3c0c:79e9 with SMTP id
 a92af1059eb24-1ac5b027fccmr7653682c88.11.1793464826439; 
 Sat, 31 Oct 2026 09:40:26 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm19574572c88.11.2026.10.31.09.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:40:25 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 01/12] target-info: add target_loongarch()
Date: Sun,  1 Nov 2026 00:39:56 +0800
Message-ID: <20261031164009.2048-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261031164009.2048-1-luoyonggang@gmail.com>
References: <20261031164009.2048-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1236;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Report whether the selected target architecture is LoongArch.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 2cd4cc5671b..6c4e2809ad3 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -92,6 +92,13 @@ bool target_hexagon(void);
  */
 bool target_or1k(void);
 
+/**
+ * target_loongarch:
+ *
+ * Returns whether the target architecture is LoongArch.
+ */
+bool target_loongarch(void);
+
 /**
  * target_base_ppc:
  *
diff --git a/target-info.c b/target-info.c
index e67d7bed520..b6d9cd8d97c 100644
--- a/target-info.c
+++ b/target-info.c
@@ -84,6 +84,11 @@ bool target_or1k(void)
     return target_arch() == SYS_EMU_TARGET_OR1K;
 }
 
+bool target_loongarch(void)
+{
+    return target_arch() == SYS_EMU_TARGET_LOONGARCH64;
+}
+
 bool target_base_ppc(void)
 {
     switch (target_arch()) {
-- 
2.55.0.windows.3


