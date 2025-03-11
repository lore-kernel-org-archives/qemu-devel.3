Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32143C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 20:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5lE-0002a0-B2; Tue, 11 Mar 2025 15:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5kE-00011h-P1
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:37 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5k8-00007z-Sc
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:26 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2fa8ac56891so8939948a91.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741723103; x=1742327903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9PU2mUUZXceFgFF8NURkIZqXSTxuLUTW3yG3F37dHQ=;
 b=rN6w0DfLjrshpW89JkD4TPYYWnfDEOo3+DaPlXUBnl3VdyHwWrogHjDZmADqBibNXl
 rWFQbUycfBsmKuSYynxnlnxw1BGEVUzAJZaMRzo9Dxfdw72P/QR+b232LpYxH5tNx4HQ
 zdZSTrwEzfWt/0KM5+NsAWlvQUVdOW0PLhXTZ9X+6tI9W11qjSLOlcQ7T0NArEJ3imcM
 XstAeJwjDOcpS95eJsfeLVSyMNtpo6uVc7LYEa06VPfGpdsvFQ2mq2qZXDkroKIKbofb
 QV+TUXMFyoD9dx5IecGow+3bpzAvKMroK+FD3J0ATCVsio1E9ZUWIa5rL1Qt4wCi6g7f
 wm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741723103; x=1742327903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d9PU2mUUZXceFgFF8NURkIZqXSTxuLUTW3yG3F37dHQ=;
 b=Hpz2gluRv/tfr3w39OTJ3m3FU1gzpZY7ZSMPKzhreXhhXC4gfurhTuoZtDEKVhrG25
 ViRjyPdvsDcCXfBFNRtvOrDrJUxPwi9GGO7zTX8/mAINUKfwOVMNe8PSFnr1uad6WZgA
 otsRC25QsPPbYAuirE8aYozab/a9koW5/LcABY/qfoZdr+/6ccgYUT/ez7EflHmKXjZI
 yR+x2roInwvbd1PPj5hlUdoH1c6P6RgA6Ers+rg+/1c1uo243A3GUmZGdyMU0Ypn6H0+
 6Q5YN8+oHX/UgW+qe4DpkLnHXJEmV72aoCEp8lC80FkDchmJj43RMrKzpi1hRyQKV41L
 rA7w==
X-Gm-Message-State: AOJu0YwkUP/lc58atdAiRHyw813hCte6IHBMiDOGPrW8UiBlliIT8BFf
 ZK4KLCOUtJHp5nRnu+ixs/P50qyfxvx0dKlTQrKRtW4LDBzLPOQ5FQC5su2Nqj4WhX/mMo6M2ps
 9GJA=
X-Gm-Gg: ASbGncuVa/FjEk5ljTyjG7udep4g7PU3i6mGgaTCCHENMN4/N3bzGaEzwchiZBfpVwb
 xP1Qt4avrhHPFQHcQxikNtK04Ja8MJ+tjz/NBt4p3DCVU+4dShyNKhWYlMuJauozRSeyQLyhgU4
 vFgVcppTGq0d6gvChdG0kaOahyJ6NgjQEbmcwTGAHEjRsumHJYwFQGiV0u+HlxsUPHPFx1NgWV+
 /EbtMUpZVASI4TnR/duYLtLpXBk77LwEd4OYPEn5D2yxbuxD1umazLS9F5GqU5I1uFSr7/6m8eA
 mLhEGwFnXhQ7lyMWxM6m4E7AddSDjDO8yBpJK3lBUdZI1DM7Yr62e6Q=
X-Google-Smtp-Source: AGHT+IGg+aQTZ2xq9SQi3eRnsIeXjPhQ74pTHWyL4E+moWnFDewPnn2zGKzm8djm9QcS5fi3hNfHgA==
X-Received: by 2002:a05:6a00:c8f:b0:736:34ff:bfc with SMTP id
 d2e1a72fcca58-736aaab7d8fmr24949384b3a.19.1741723103280; 
 Tue, 11 Mar 2025 12:58:23 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a6e5c13asm9646981b3a.157.2025.03.11.12.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 12:58:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 manos.pitsidianakis@linaro.org, Peter Xu <peterx@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, alex.bennee@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 11/17] exec/ram_addr: call xen_hvm_modified_memory only if
 xen is enabled
Date: Tue, 11 Mar 2025 12:57:57 -0700
Message-Id: <20250311195803.4115788-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
References: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/ram_addr.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 7c011fadd11..098fccb5835 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -342,7 +342,9 @@ static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
         }
     }
 
-    xen_hvm_modified_memory(start, length);
+    if (xen_enabled()) {
+        xen_hvm_modified_memory(start, length);
+    }
 }
 
 #if !defined(_WIN32)
@@ -418,7 +420,9 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
             }
         }
 
-        xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+        if (xen_enabled()) {
+            xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+        }
     } else {
         uint8_t clients = tcg_enabled() ? DIRTY_CLIENTS_ALL : DIRTY_CLIENTS_NOCODE;
 
-- 
2.39.5


