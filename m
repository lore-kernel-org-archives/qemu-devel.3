Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58CAC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5ee-0004vy-Oh; Tue, 07 Jul 2026 09:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5eL-0003rI-VQ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:15:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5eJ-0000rs-Re
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:15:45 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8vGt3676666
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lN9MATFtm4EizLb/W1v/0rpJT6SEROwN4JCs2tgU2T0=; b=QQ9kaYZQUIzDVq/l
 pGMboN+n/oxcB3Pg4m7bTeg0KAk397Nb85AdGDTsttuYXY8iN9m4sGcnw/KeAtMY
 s7+pyo6MjBHIUo+eiqWKZYEEDia7kU1eYm959yRvMkSlpYxN5ahljlwVwts6DUAs
 idrfVRkFTuNUVfvwxItvtz31nM43cGtW4jUfRKIfXiZsN9jPUhFcmA0m/c2HFboa
 FcA4K9rPgx4P8eX/oNTCHKemaY4IC1/N/06H9EGLHh9lGwaO+Po/CDoVLIIwIXIj
 2aVT6uyOnOOxNeii3lvgdNn9QrJDQy1NLLUbZfde1z/qXaR5yZNPxZ8v0fYRGWxD
 PesEig==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8t15a4r6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:15:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0d6a2f4cso46981621cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430142; x=1784034942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lN9MATFtm4EizLb/W1v/0rpJT6SEROwN4JCs2tgU2T0=;
 b=JYEAese38sOjyjkHzIeJm2EFYfZlX0edO6oi28ILxW42ICMUzTRvN4i50MVHnB75Uq
 yuU0W+YId6Ez9oTi9ScFasWymtOtU92hmEaoLuknfI1qCaDkM4Cf9QvlUJQhqRPBgDWM
 QNMKmODO7Q8gmAvR/WR+xwrDh0kPpODncZc1HUjzfM7sHtXYPY0lWoOGlqymbbbGMZSa
 uX+2wN1MjzgxIAlakQpJp3TLyTHJt6rhSjHw/4p3vYiC7kwGLqtEYlmOgXHoBDojYikL
 B2bOxMNvQW3msRfRSEKl/5zIGcXlZpPJlK8wTyZMfzK6kOnFHC/ClLBa4I+XnzYF13Sw
 As5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430142; x=1784034942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lN9MATFtm4EizLb/W1v/0rpJT6SEROwN4JCs2tgU2T0=;
 b=MnLxJGyMbMNnJrZOhoJuGu8I7Fw8ipZcAN08Td00EqtHXgMqk5ZhHkIlumCsaVk4Hb
 iQE3qhGhAKqWL8Qx3Nnupx33ssRlvzhm7vKe6ivCdgdBxdTxJHBW4aS6/PlxugT9ULGU
 tntcyRrkRsNnaSHkKD0vh0zmYaLbC23vF9/2J/Qrv2c2ujLDxaHMF/fkKNx5P1RD3tag
 vIzTQfhGy5KC2Eu6hJMfkVx5OOSGNbxx3F6M3dqZvNelCM90nmLlxRaGZiXh+pEoKFQY
 f4DXdvcLUg075xdRjqoBA/gFL1tKbcaQKuI35mQnP2oPRzZYyxUZNMjf7NqOK1dwJrKY
 BF+g==
X-Gm-Message-State: AOJu0YxYQu+Wu5LTkjyOofnadFoZJUkT9hOrtguev650D0avdFCSruDT
 zUQCCwqkZrZMwwAcL6waduxF77qURTSSOWHucUJbhl8PNgDyBxSkz+VLXqTWsepCL+fMzymmt8E
 dpDrKqs1Wu4tQxpCbbld3o/lQOvR7a5CEWa5JyA6YUD3U0jOIev6Dpfj/qsUyBLOBBw==
X-Gm-Gg: AfdE7cke3aOgTog56ddN2QPaeagW6WpcfcDCanujlIiutz+Cbl3bHLvf4IFzFFR23jO
 aUqnPAWQLUFSApJ5QeHWw7UlzWiC/DR+MttHfS/aTPhIDHqH21HwT3h+8io54Qnu9J9Dpcqgu3m
 Wiw+3UTHo9oUmhYAnechVPNKhb3V59P9t7CefZHih27z2gBPzNzzrDXFIeKHSv1iX04IMyDlaVc
 FtZd4CV5jbvC8pK14OqYeQcXtbqDp2gAh4rlSLTcMWGafTZRfEVAPOy156ImGN5Tt+Sb3Sj3zhq
 4EQOlc1BEkmHK4AU7ljdLy8+XZ613UDajpdhdG98eK07raUTk7rLOPBW56xq07bfTDCfKee8s43
 xRtEIEXbrFDYvnDfG9whssDiIzAB/iW44M97zXzP31mKq+DubBZsC/2aE0DWeLh+McI0p
X-Received: by 2002:a05:622a:992:b0:51c:df0:1b34 with SMTP id
 d75a77b69052e-51c748844c0mr51481771cf.33.1783430141920; 
 Tue, 07 Jul 2026 06:15:41 -0700 (PDT)
X-Received: by 2002:a05:622a:992:b0:51c:df0:1b34 with SMTP id
 d75a77b69052e-51c748844c0mr51480481cf.33.1783430140645; 
 Tue, 07 Jul 2026 06:15:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad820d33sm134878366b.3.2026.07.07.06.15.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:15:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/32] hw/block: m25p80: Fix dummy byte handling for Macronix
 flash
Date: Tue,  7 Jul 2026 15:12:17 +0200
Message-ID: <20260707131223.51505-28-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: onZRSHd95I22fqWLNEvcDarE1KoMCtRq
X-Authority-Analysis: v=2.4 cv=HstG3UTS c=1 sm=1 tr=0 ts=6a4cfbfe cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=qudNOe3MAAAA:8 a=FRSEYCzRAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=eCjGLk0DLWPBDlXMaRQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=icPJRyImjHd6_pBPa6HO:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: onZRSHd95I22fqWLNEvcDarE1KoMCtRq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX96O3QNcF/Pl1
 CMmX0rfGUI8pnpJFnETDam6XYAI9pkECjLKFnYpoO8gB4ui3ptIod5w8mjbe4huvLkAka0wb6qq
 O0HUk2wRTc4iZNh3pfERQpQuIMRvX30=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX/6qliNvYqgmb
 sCeVjO2FlTfD9ZZFekj/MQN9h6BszUnjsmzSR/mlQJZIEQaZ04Zn8lyurHjIfLftDexeQduJQbT
 EXF+Rve6zvnJy+TEIyYVg1CSNmtVFcD48dtNYVmGlwYfholtfXi4Hf433eULF4C10RdIBHG/6Hf
 zwF/rL9OiqF9qAwb+lEvwSdEevv6IQU0JmAzMi/gJwt485ZCAN89UHs5jlCvIuJN4+BgEmBTgjn
 ABsjkVbn/SPkOf7m5wEtmBmg2dXbOwz/BOCbcViTiMwlGzICZz+7pWKkSxlt0CawPpcZibVxgBM
 xwRAezzt1lOxDYUdH6wf+aYFEO57mZ2IxD61KLpTC9Z+CTiE1Q3g58uwWTTujrykRmwylE5BYu9
 qLc3wFJD7g21S5/vn5poPvbPXBtb5x85Cnt0FlBZBnTEEFSgbn/hTaHmAiOK9fpboGQeDHSTiYS
 o/cFU65UM6RqkMrQ41w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bin Meng <bin.meng@processmission.com>

Macronix flashes expose DC[1:0] bits in the volatile configuration
register [1]. These bits select the number of dummy clock cycles
used by the fast-read command families.

Convert the Macronix dummy-cycle settings through per-command-family
tables and round up the non-byte-aligned cases that the byte-oriented
SSI model cannot represent exactly.

[1] https://www.macronix.com/Lists/Datasheet/Attachments/8657/MX66L51235F,%203V,%20512Mb,%20v1.1.pdf

Fixes: cf6f1efe0b57 ("m25p80: Fast read commands family changes")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20260707083431.219671-4-bin.meng@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/block/m25p80.c | 63 +++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 83d1ce1f956..d7a9d793737 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1024,6 +1024,39 @@ static uint8_t numonyx_extract_cfg_dummy_bytes(Flash *s)
     return dummy_bits / 8;
 }
 
+static uint8_t macronix_extract_cfg_dummy_bytes(Flash *s, uint8_t bus_width)
+{
+    static const uint8_t dummy_cycles_fast[4] = { 8, 6, 8, 10 };
+    static const uint8_t dummy_cycles_dio[4] = { 4, 6, 8, 10 };
+    static const uint8_t dummy_cycles_qio[4] = { 6, 4, 8, 10 };
+    const uint8_t *dummy_cycles = dummy_cycles_fast;
+    uint8_t dummy_bits;
+
+    switch (s->cmd_in_progress) {
+    case DIOR:
+    case DIOR4:
+        dummy_cycles = dummy_cycles_dio;
+        break;
+    case QIOR:
+    case QIOR4:
+        dummy_cycles = dummy_cycles_qio;
+        break;
+    default:
+        break;
+    }
+
+    dummy_bits = dummy_cycles[extract32(s->volatile_cfg, 6, 2)];
+    dummy_bits *= bus_width;
+
+    /*
+     * Assert that the dummy bit count is byte-aligned
+     * as SSI core can only consume whole dummy bytes.
+     */
+    assert(dummy_bits % 8 == 0);
+
+    return dummy_bits / 8;
+}
+
 static void decode_fast_read_cmd(Flash *s)
 {
     s->needed_bytes = get_addr_length(s);
@@ -1039,11 +1072,7 @@ static void decode_fast_read_cmd(Flash *s)
         s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
         break;
     case MAN_MACRONIX:
-        if (extract32(s->volatile_cfg, 6, 2) == 1) {
-            s->needed_bytes += 6;
-        } else {
-            s->needed_bytes += 8;
-        }
+        s->needed_bytes += macronix_extract_cfg_dummy_bytes(s, 1);
         break;
     case MAN_SPANSION:
         s->needed_bytes += extract32(s->spansion_cr2v,
@@ -1091,17 +1120,7 @@ static void decode_dio_read_cmd(Flash *s)
         s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
         break;
     case MAN_MACRONIX:
-        switch (extract32(s->volatile_cfg, 6, 2)) {
-        case 1:
-            s->needed_bytes += 6;
-            break;
-        case 2:
-            s->needed_bytes += 8;
-            break;
-        default:
-            s->needed_bytes += 4;
-            break;
-        }
+        s->needed_bytes += macronix_extract_cfg_dummy_bytes(s, 2);
         break;
     case MAN_ISSI:
         /*
@@ -1141,17 +1160,7 @@ static void decode_qio_read_cmd(Flash *s)
         s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
         break;
     case MAN_MACRONIX:
-        switch (extract32(s->volatile_cfg, 6, 2)) {
-        case 1:
-            s->needed_bytes += 4;
-            break;
-        case 2:
-            s->needed_bytes += 8;
-            break;
-        default:
-            s->needed_bytes += 6;
-            break;
-        }
+        s->needed_bytes += macronix_extract_cfg_dummy_bytes(s, 4);
         break;
     case MAN_ISSI:
         /*
-- 
2.53.0


