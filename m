Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444E9C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 17:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8tp-0005y7-3H; Fri, 14 Mar 2025 13:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8tJ-0005fv-7K
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:32:16 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8tF-0008Io-1G
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:32:12 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2243803b776so66984475ad.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741973521; x=1742578321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vI16NHb2tKWbIxjnq/SoVUTdY/Lep770BkCc47k0Rc=;
 b=N23ywjmO/uXqb54kDNyZLNU4nfZo0sSKep4zmAmuojzrktWIuZkkfp3xLnNhSHjCkN
 9v4Sdrkma7B8fxuFIH+tlh2KWxQnS4UmOhG+CY/Whyq8gyK/arNOk0/iZS6ad0AkZvMb
 rAEQVm3nN1vp2naiTnB63wOwwSGqcMN+WD5V+pCZSPpSt0598n9dAs1jJMlN0uGe3rkK
 iNGLQWnlt9PsSgjdDOvRgv+H+ab5HkKNszTxteqYdF16YoBHknfkH7/sOToVRyMetK+0
 MF8rV6NWXfFamwCRFCyY1NaQ4YCOqKV9RciC8MQ96dDXchFukcUqoyzt5i4iJ4mrxtDL
 ZUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741973521; x=1742578321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0vI16NHb2tKWbIxjnq/SoVUTdY/Lep770BkCc47k0Rc=;
 b=CryHV1eCPzHWRSqIqhzKBM8wEGgRo7V2LFcr0IwKYEeVbkgqLZs7ENEDvzYxBauuOH
 Tuz5zpO1J8QQbwr0u8KZKw/l7CkO6sy8UvyGne3X8Kn60DW24kvo2n96KH44CkeI3icu
 v6rzTas8MbmYYSMmWbwnKAZMPBT/ZlresPwouV8G3G4HgljipGLxfr3qhd85u5PzSf1e
 JhGlld5zfkZlGFKNLHYjvBwBak+ApkIBodjY90v1Ry6M9g7or3Qon2my6yTNHgohWLma
 hqOwZv/GpN0wBh6TYeS1juL8Ro1RhT2OSOF7moBtrO55HDQFOyM88Fa6YbftatRuEYQF
 EmfA==
X-Gm-Message-State: AOJu0YwH0syQyH6GvtU0ZRSCfMTlUG4o/EOhskqku4Tm0PH7kGjES9f7
 STNBq6zYjfUrhonVN0h3LQkcKnDL+IjMnuRKPg7LT5ZRtf061ohRDG3tOpZYn7XhWZBQWjhvkn0
 7uu8=
X-Gm-Gg: ASbGncuXTcawmtZLHUaBkmy3z4dibhbwyTMa6eXnFHX5E1ObtYhPfQWX8u7Rn1f7HF+
 i7uCxehj0rj63AVba7qH+xn2f7dxDi0bHz9jU8RkiUkRax0lR3xea3tQY3FQUsCAGGGJWGv67Pf
 9943VbleFTP7cWqKN0DsjQCYk+ONqsGYtv77H8PWNkN9C/LANnJRrN0iZZXuU+hWy2HnKHrijrt
 Pm2SBG0PnAp2VZ2gQLRu9cztAccWUK6x7qa0FKQ6CCQAQYT5meAMKSP7YfamNohmiE6Q+ldro4j
 aZnnbhBygm5oFCRe2OlR18nw2Wr2izalUzY9rYUiAtff
X-Google-Smtp-Source: AGHT+IG6cCxvjsVBwzL07VH+mus/++8may6iqII6GPehxKvNj4VKnHVcl4393YyfiqPTiVq1ksSu0w==
X-Received: by 2002:a05:6a20:9c8d:b0:1ee:efa5:6573 with SMTP id
 adf61e73a8af0-1f5c113f552mr5261243637.8.1741973521265; 
 Fri, 14 Mar 2025 10:32:01 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9cd03bsm2990529a12.8.2025.03.14.10.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 10:32:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Anthony PERARD <anthony@xenproject.org>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 14/17] include/exec/memory: extract devend_big_endian from
 devend_memop
Date: Fri, 14 Mar 2025 10:31:36 -0700
Message-Id: <20250314173139.2122904-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

we'll use it in system/memory.c.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/memory.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 069021ac3ff..70177304a92 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3138,16 +3138,22 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
 MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs);
 
-/* enum device_endian to MemOp.  */
-static inline MemOp devend_memop(enum device_endian end)
+/* returns true if end is big endian. */
+static inline bool devend_big_endian(enum device_endian end)
 {
     QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
                       DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
 
-    bool big_endian = (end == DEVICE_NATIVE_ENDIAN
-                       ? target_words_bigendian()
-                       : end == DEVICE_BIG_ENDIAN);
-    return big_endian ? MO_BE : MO_LE;
+    if (end == DEVICE_NATIVE_ENDIAN) {
+        return target_words_bigendian();
+    }
+    return end == DEVICE_BIG_ENDIAN;
+}
+
+/* enum device_endian to MemOp.  */
+static inline MemOp devend_memop(enum device_endian end)
+{
+    return devend_big_endian(end) ? MO_BE : MO_LE;
 }
 
 /*
-- 
2.39.5


