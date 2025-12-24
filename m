Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F064E776C0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRba-0000mV-84; Wed, 24 Dec 2025 11:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRbY-0000lJ-7n
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:20:52 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRbW-0002bs-EP
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:20:51 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-430f9ffd4e8so3345891f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593248; x=1767198048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/E7zKSmXhQyk+2Ne8DdJL65mcRus4X680Pp4lcYenM=;
 b=Nv2WFyDC+osYITLTAsDDmT5tIeYW4flFjf6avJ82XE4UQpqsmbCnEm10kh8P9uh5+W
 Hgwb6sz2KjrzcZySGvO5N+fs5Szxjx5tCejxVWFjHKboo4Lvo2n51V27LlU1NGYIIDGo
 68lP5S0cPh8sNA0XRzigdN0tqGP+jzkonWu0jcEADCOqdOl4ilgE4XBBoCtGgGLp+zQ0
 sOJcv/UyCYDA9D3tt9ZwGIostdyWaDoQF6ZTW+PFUz66nBkgZrBVPYbfbEFcIiwDmjMd
 WTa6KgJAUv6G6f4Avzr7YxXW4XMMiS9N5//33Uu9NP9lOoGi0m6WCFoQUmvYpOAJpz13
 HLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593248; x=1767198048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T/E7zKSmXhQyk+2Ne8DdJL65mcRus4X680Pp4lcYenM=;
 b=d8kgM9JyriIkyR2gxCnkSDoKVWD3AnASzRPWrSBrI0iWOU13F5vVT9+RxoTfIGUTfa
 4xfAgg7osB/u/YaAaVRpt1Zs8tugTM/MwcovC0BHdfb5QSq+OjAV9vmb6fCFEnL2rqHW
 fQ8xpGqGjCWTtivfH/xoieumGymmz4OCISbTIrElrRpHDaBMezekR8ad+sBi9/4cpu1w
 nCoKg9gD1Ak78wwA6r1Vhe4pDbRyW83T37v3Vhko6j91c9Ky4Qlzmav0z26TCRfGSa2x
 hXAHDU/38p7PoQTdtW2rW4vHO0kaHTFOSyCbcKxsgZIQzGEiqOlRNT3N3gMMHd2jewxI
 Icbw==
X-Gm-Message-State: AOJu0Yxh5wbPPPi3HDQyzK+qL2IwAOhc8TU0W4DNh07OHtCN+SZysFdL
 eObcdzr/wyYc4cQKlzOYqHOhh0cCFopLfadq616YiurSibPwTqW1OD04bXbHl4FUEyR1rynAT78
 1s0F79Kw=
X-Gm-Gg: AY/fxX5LOxdCNTAMngvocNa9uAH4mg0AkOeBrPvG5krlf2wYKzN1qja73m+86vGMN0X
 6ZCAqPOZ3kRrEu4DvNbKXNiD7f8vWUIvh+ndJhr3BRLXAeaqvMrbw13JDi7uYyxcBPXO0JE+btr
 fRVp0Yjcje+3x6xJ9diC0yisgwYwHuY3J66RbqDcH9nM/rk2/BfMpo/sMlZ1tUsPi7nLOySQTa5
 QXKUFcPgRqgTI9SF6CSlO7dkPT7g8bHaJvS0O4iwjKO71ryA+0viCIKYbiDaqz1LthgUs+syx9Y
 lcbIEQfHvrLSnsc9pD99QOvLm1UYu3mZGFJKjSMohhBE3qInZfkkrkENh28c8AR6KaBsSdK5rJj
 rutl1AuNR+/EqDfGdM50i6JWk0cLhCTPI//2NrBYm6MPdlIgWCDg7E/nY9ZAJTcSgcPcFaEvygH
 4gRgedqSfCHoXShbshf0RhUKCz1eOmZGPb9bQZzncJYCS0wP2Dxl6+pEI=
X-Google-Smtp-Source: AGHT+IFs63YUPZm0AokKvRsiAGTIeCOgPaBGbVLnJWCFGC3nXMOsfTQU0VXKXhLRRXtPeVLDDFGBkw==
X-Received: by 2002:a5d:64e9:0:b0:431:382:f141 with SMTP id
 ffacd0b85a97d-4324e3f5da3mr24781895f8f.12.1766593248490; 
 Wed, 24 Dec 2025 08:20:48 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324e9ba877sm34576607f8f.0.2025.12.24.08.20.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:20:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Anton Johansson <anjo@rev.ng>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/8] hw/s390x: Use explicit big-endian LD/ST API
Date: Wed, 24 Dec 2025 17:20:28 +0100
Message-ID: <20251224162036.90404-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224162036.90404-1-philmd@linaro.org>
References: <20251224162036.90404-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

The S390x architecture uses big endianness. Directly use
the big-endian LD/ST API.

Mechanical change running:

  $ for a in uw w l q; do \
      sed -i -e "s/ld${a}_p(/ld${a}_be_p(/" \
        $(git grep -wlE '(ld|st)u?[wlq]_p' hw/s390x/);
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/css.c          | 24 +++++++++++-------------
 hw/s390x/s390-pci-bus.c |  4 ++--
 hw/s390x/virtio-ccw.c   | 24 ++++++++++++------------
 3 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 53444f68288..4bc2253c182 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1582,27 +1582,25 @@ static void css_update_chnmon(SubchDev *sch)
         /* Format 1, per-subchannel area. */
         uint32_t count;
 
-        count = address_space_ldl(&address_space_memory,
-                                  sch->curr_status.mba,
-                                  MEMTXATTRS_UNSPECIFIED,
-                                  NULL);
+        count = address_space_ldl_be(&address_space_memory,
+                                     sch->curr_status.mba,
+                                     MEMTXATTRS_UNSPECIFIED, NULL);
         count++;
-        address_space_stl(&address_space_memory, sch->curr_status.mba, count,
-                          MEMTXATTRS_UNSPECIFIED, NULL);
+        address_space_stl_be(&address_space_memory, sch->curr_status.mba, count,
+                             MEMTXATTRS_UNSPECIFIED, NULL);
     } else {
         /* Format 0, global area. */
         uint32_t offset;
         uint16_t count;
 
         offset = sch->curr_status.pmcw.mbi << 5;
-        count = address_space_lduw(&address_space_memory,
-                                   channel_subsys.chnmon_area + offset,
-                                   MEMTXATTRS_UNSPECIFIED,
-                                   NULL);
+        count = address_space_lduw_be(&address_space_memory,
+                                      channel_subsys.chnmon_area + offset,
+                                      MEMTXATTRS_UNSPECIFIED, NULL);
         count++;
-        address_space_stw(&address_space_memory,
-                          channel_subsys.chnmon_area + offset, count,
-                          MEMTXATTRS_UNSPECIFIED, NULL);
+        address_space_stw_be(&address_space_memory,
+                             channel_subsys.chnmon_area + offset, count,
+                             MEMTXATTRS_UNSPECIFIED, NULL);
     }
 }
 
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 52820894fa1..aeeed82955a 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -461,8 +461,8 @@ static uint64_t table_translate(S390IOTLBEntry *entry, uint64_t to, int8_t ett,
     uint16_t err = 0;
 
     tx = get_table_index(entry->iova, ett);
-    te = address_space_ldq(&address_space_memory, to + tx * sizeof(uint64_t),
-                           MEMTXATTRS_UNSPECIFIED, NULL);
+    te = address_space_ldq_be(&address_space_memory, to + tx * sizeof(uint64_t),
+                              MEMTXATTRS_UNSPECIFIED, NULL);
 
     if (!te) {
         err = ERR_EVENT_INVALTE;
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 4a3ffb84f8f..9dd838c61e4 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -889,26 +889,26 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
             }
         } else {
             assert(vector < NR_CLASSIC_INDICATOR_BITS);
-            indicators = address_space_ldq(&address_space_memory,
-                                           dev->indicators->addr,
-                                           MEMTXATTRS_UNSPECIFIED,
-                                           NULL);
+            indicators = address_space_ldq_be(&address_space_memory,
+                                              dev->indicators->addr,
+                                              MEMTXATTRS_UNSPECIFIED,
+                                              NULL);
             indicators |= 1ULL << vector;
-            address_space_stq(&address_space_memory, dev->indicators->addr,
-                              indicators, MEMTXATTRS_UNSPECIFIED, NULL);
+            address_space_stq_be(&address_space_memory, dev->indicators->addr,
+                                 indicators, MEMTXATTRS_UNSPECIFIED, NULL);
             css_conditional_io_interrupt(sch);
         }
     } else {
         if (!dev->indicators2) {
             return;
         }
-        indicators = address_space_ldq(&address_space_memory,
-                                       dev->indicators2->addr,
-                                       MEMTXATTRS_UNSPECIFIED,
-                                       NULL);
+        indicators = address_space_ldq_be(&address_space_memory,
+                                          dev->indicators2->addr,
+                                          MEMTXATTRS_UNSPECIFIED,
+                                          NULL);
         indicators |= 1ULL;
-        address_space_stq(&address_space_memory, dev->indicators2->addr,
-                          indicators, MEMTXATTRS_UNSPECIFIED, NULL);
+        address_space_stq_be(&address_space_memory, dev->indicators2->addr,
+                             indicators, MEMTXATTRS_UNSPECIFIED, NULL);
         css_conditional_io_interrupt(sch);
     }
 }
-- 
2.52.0


