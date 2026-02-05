Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F558ECD99F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5VA-0006Yi-2I; Thu, 05 Feb 2026 14:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5V7-0006XY-Bc
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:58:53 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5V5-00032V-E0
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:58:53 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so911970f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321529; x=1770926329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cvKiWELxuJcWRYaqArTcXS0v2Sr7kfuoA6C4G3edWCw=;
 b=lul2BWga1UjabqQ3frzPQXkmh+5dRIDYUYKEQOZXnN0PiaxeVy8c0cxrJ5Is63XU+M
 /UdPinJH5ks1zBX02jucvs4SNAlMYprjNW6DLxWDyF3ygKSEbF4gsdL2F+3/Ew1BkLd1
 JqNvxfXvR1FOzvuqbwhpAd4fJPFLLGEwZFdME3d9iDa8NfWt4UdkxnZOaIxTBy0WDwvV
 pC22iU9SBYnNtHWqGijYTaWrIhuv7+hnQkSdgiH5AhzMV461Q9KYvb5CxmXVe56YCZyJ
 sR7OkNmYtuNYcySXIMBBaXEe0YMRPb2GOjB97+xsliWdz4WH2JEed9afE3htbHGmTOSK
 K6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321529; x=1770926329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cvKiWELxuJcWRYaqArTcXS0v2Sr7kfuoA6C4G3edWCw=;
 b=G8TdFD4LHDfXH1wrJ02EJyiEy33i22jxKccmjz9sVuC/UndOlHMpkAlMgjmZSKg4/0
 OycAweUxF1Tw6JYYKyOnKwOdcUEGS3GbD1vlZuOzlm/IdScTe+pv8ryIN0N4buY6JLnc
 SzsrKmkP8soY0gPffThuDMWuwieDbpVHj/NTpsPLXyUxFfLLIAQU2GWn7+r7Lt12rT5c
 tN1a7qhNAByGPY2deEn3Lepf0fdfuzxeIivNvYCS+G3u0slW/eHZGzPj7Taj9HGy4xOe
 VPlYaVt9OMGl1EkpZnhdQpuQFjPeGP7E3l5csjRwIkkOOanl28PRKuC9whUT9hdRYicc
 VbGQ==
X-Gm-Message-State: AOJu0Yw3KOQykfp8jp8Dsf0Z4JZ4rZUSO15cCWaD9VKrX/pQcAE/QlVh
 FqcWfqFw+VpVjLowzcTNQzqEGgGKkxr89LKoCX6hZcGetyg1n7TEYs+n/GFFjClt9x4=
X-Gm-Gg: AZuq6aJOxODh2a1RJ3XCPCQmh0pADHzCE4cGlkULsv50BSaT/fz2KJ4Zjuy8BEicVHY
 NG2M8hhdTOI1k9me4SxtAqepxTdPWv8O/tjxY/ad9brGL0mwCQLRNpJ58wRGKWvn5/i4gtpiCnG
 5iRW1Eviwb3nOZgCia4IOqekEKcQ4SLSFjn1UBOVCXWLUnxzv6SuWbB3t5AXy4SgIv3E/XGFBDw
 73e4PxPHlx+PNkvDO1WowIA4UpyrLpKTwWQWe+DSawBxcBvlExELNqyKP2oA+vxnPhZC788Cq41
 5iRhI8aK3LnpkXMRBvjIzJtezhF3HpBzHtFxLPn50ggumKg6jxwfPWdUXkc2J0RFeKPkst/U5Vl
 UDEba0j7Zh3iTld/8RvEiO/ruIpTPUn3Vr4a91mJSKu8IdK1JreHQGZI9FiIsBhrDmkIzlD1pJJ
 FfMwcXw5T2NksZeHjoMJs=
X-Received: by 2002:a05:6000:220c:b0:436:1a40:a6ae with SMTP id
 ffacd0b85a97d-4362923ed58mr793959f8f.15.1770321529519; 
 Thu, 05 Feb 2026 11:58:49 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:58:49 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 05/29] hw/core: Implement Remote Port irq, sync and ATS helpers
Date: Thu,  5 Feb 2026 20:58:00 +0100
Message-ID: <20260205195824.2610192-6-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42c.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

The patch add support for encoding and decoding of following
commands:

- RP_CMD_interrupt: propagate gpio and interrupt lines changes
to external peers
- RP_CMD_sync: support for synchronization between QEMU and the
remote model
- RP_CMD_ats_*: handling iommu transactoin request and invalidation
accross the link.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-proto.c         | 100 ++++++++++++++++++++++++++++
 include/hw/core/remote-port-proto.h |  29 ++++++++
 2 files changed, 129 insertions(+)

diff --git a/hw/core/remote-port-proto.c b/hw/core/remote-port-proto.c
index 33a6769087..65551ad281 100644
--- a/hw/core/remote-port-proto.c
+++ b/hw/core/remote-port-proto.c
@@ -131,6 +131,24 @@ int rp_decode_payload(struct rp_pkt *pkt)
         }
         pkt->busaccess.master_id = master_id;
         break;
+    case RP_CMD_interrupt:
+        pkt->interrupt.timestamp = be64_to_cpu(pkt->interrupt.timestamp);
+        pkt->interrupt.vector = be64_to_cpu(pkt->interrupt.vector);
+        pkt->interrupt.line = be32_to_cpu(pkt->interrupt.line);
+        pkt->interrupt.val = pkt->interrupt.val;
+        used += pkt->hdr.len;
+        break;
+    case RP_CMD_sync:
+        pkt->sync.timestamp = be64_to_cpu(pkt->interrupt.timestamp);
+        used += pkt->hdr.len;
+        break;
+    case RP_CMD_ats_req:
+    case RP_CMD_ats_inv:
+        pkt->ats.attributes = be64_to_cpu(pkt->ats.attributes);
+        pkt->ats.addr = be64_to_cpu(pkt->ats.addr);
+        pkt->ats.len = be64_to_cpu(pkt->ats.len);
+        pkt->ats.result = be32_to_cpu(pkt->ats.result);
+        break;
     default:
         break;
     }
@@ -294,6 +312,88 @@ size_t rp_encode_busaccess(struct rp_peer_state *peer,
     return sizeof *pkt + ret_size;
 }
 
+size_t rp_encode_interrupt_f(uint32_t id, uint32_t dev,
+                             struct rp_pkt_interrupt *pkt,
+                             int64_t clk,
+                             uint32_t line, uint64_t vector, uint8_t val,
+                             uint32_t flags)
+{
+    rp_encode_hdr(&pkt->hdr, RP_CMD_interrupt, id, dev,
+                  sizeof *pkt - sizeof pkt->hdr, flags);
+    pkt->timestamp = cpu_to_be64(clk);
+    pkt->vector = cpu_to_be64(vector);
+    pkt->line = cpu_to_be32(line);
+    pkt->val = val;
+    return sizeof *pkt;
+}
+
+size_t rp_encode_interrupt(uint32_t id, uint32_t dev,
+                           struct rp_pkt_interrupt *pkt,
+                           int64_t clk,
+                           uint32_t line, uint64_t vector, uint8_t val)
+{
+    return rp_encode_interrupt_f(id, dev, pkt, clk, line, vector, val, 0);
+}
+
+static size_t rp_encode_ats_common(uint32_t cmd, uint32_t id, uint32_t dev,
+                         struct rp_pkt_ats *pkt,
+                         int64_t clk, uint64_t attr, uint64_t addr,
+                         uint64_t len, uint64_t result, uint32_t flags)
+{
+    rp_encode_hdr(&pkt->hdr, cmd, id, dev,
+                  sizeof *pkt - sizeof pkt->hdr, flags);
+    pkt->timestamp = cpu_to_be64(clk);
+    pkt->attributes = cpu_to_be64(attr);
+    pkt->addr = cpu_to_be64(addr);
+    pkt->len = cpu_to_be64(len);
+    pkt->result = cpu_to_be32(result);
+    return sizeof *pkt;
+}
+
+size_t rp_encode_ats_req(uint32_t id, uint32_t dev,
+                         struct rp_pkt_ats *pkt,
+                         int64_t clk, uint64_t attr, uint64_t addr,
+                         uint64_t len, uint64_t result, uint32_t flags)
+{
+    return rp_encode_ats_common(RP_CMD_ats_req, id, dev,
+                                pkt, clk, attr,
+                                addr, len, result, flags);
+}
+
+size_t rp_encode_ats_inv(uint32_t id, uint32_t dev,
+                         struct rp_pkt_ats *pkt,
+                         int64_t clk, uint64_t attr, uint64_t addr,
+                         uint64_t len, uint64_t result, uint32_t flags)
+{
+    return rp_encode_ats_common(RP_CMD_ats_inv, id, dev,
+                                pkt, clk, attr,
+                                addr, len, result, flags);
+}
+
+static size_t rp_encode_sync_common(uint32_t id, uint32_t dev,
+                                    struct rp_pkt_sync *pkt,
+                                    int64_t clk, uint32_t flags)
+{
+    rp_encode_hdr(&pkt->hdr, RP_CMD_sync, id, dev,
+                  sizeof *pkt - sizeof pkt->hdr, flags);
+    pkt->timestamp = cpu_to_be64(clk);
+    return sizeof *pkt;
+}
+
+size_t rp_encode_sync(uint32_t id, uint32_t dev,
+                      struct rp_pkt_sync *pkt,
+                      int64_t clk)
+{
+    return rp_encode_sync_common(id, dev, pkt, clk, 0);
+}
+
+size_t rp_encode_sync_resp(uint32_t id, uint32_t dev,
+                           struct rp_pkt_sync *pkt,
+                           int64_t clk)
+{
+    return rp_encode_sync_common(id, dev, pkt, clk, RP_PKT_FLAGS_response);
+}
+
 void rp_process_caps(struct rp_peer_state *peer,
                      void *caps, size_t caps_len)
 {
diff --git a/include/hw/core/remote-port-proto.h b/include/hw/core/remote-port-proto.h
index f65f82195d..7322e0e357 100644
--- a/include/hw/core/remote-port-proto.h
+++ b/include/hw/core/remote-port-proto.h
@@ -478,6 +478,35 @@ size_t rp_encode_busaccess(struct rp_peer_state *peer,
                            struct rp_pkt_busaccess_ext_base *pkt,
                            struct rp_encode_busaccess_in *in);
 
+size_t rp_encode_interrupt_f(uint32_t id, uint32_t dev,
+                             struct rp_pkt_interrupt *pkt,
+                             int64_t clk,
+                             uint32_t line, uint64_t vector, uint8_t val,
+                             uint32_t flags);
+
+size_t rp_encode_interrupt(uint32_t id, uint32_t dev,
+                           struct rp_pkt_interrupt *pkt,
+                           int64_t clk,
+                           uint32_t line, uint64_t vector, uint8_t val);
+
+size_t rp_encode_sync(uint32_t id, uint32_t dev,
+                      struct rp_pkt_sync *pkt,
+                      int64_t clk);
+
+size_t rp_encode_sync_resp(uint32_t id, uint32_t dev,
+                           struct rp_pkt_sync *pkt,
+                           int64_t clk);
+
+size_t rp_encode_ats_req(uint32_t id, uint32_t dev,
+                         struct rp_pkt_ats *pkt,
+                         int64_t clk, uint64_t attr, uint64_t addr,
+                         uint64_t size, uint64_t result, uint32_t flags);
+
+size_t rp_encode_ats_inv(uint32_t id, uint32_t dev,
+                         struct rp_pkt_ats *pkt,
+                         int64_t clk, uint64_t attr, uint64_t addr,
+                         uint64_t size, uint64_t result, uint32_t flags);
+
 void rp_process_caps(struct rp_peer_state *peer,
                      void *caps, size_t caps_len);
 
-- 
2.43.0


