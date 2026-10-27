Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F51606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=msUWCYbc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SXwSK6a+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmrK-0004QJ-7S; Tue, 27 Oct 2026 15:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmqk-0003ap-Lt
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:28:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmqj-0002PM-3V
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:28:46 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIIAP03486349
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y/BfbaE26gcWnbvzTsVqRyELQcp58GjPgwZGNGRMTc0=; b=msUWCYbcxIw2Y8bz
 4LM1UHwhoZbMfGqnCfh1vQ9kCjGSuqNwhlE0BZ36c8t0rxxjgrdaTj90MVWr0h0D
 6Q7Nw2qDMi2xqwM43hDHB9ShW181p8tcOfGsNhQdL7F8raZzUKCupv1+GSpXtLu1
 lovOU6vR54ze2B4kp1HNYle+EPs4fjyQVw4J0xypmlDE/8gp1/P6vI6yB50Gicdz
 jaU6WrwkZuiDW+qau9miUAjASVCqam5upgmzpijPI7LG7BKmCj9Vy0Axw/3sCHUa
 Sac6Gja7SH2CsuSpv23LswYnqaKgLhEVyeJ4zERagEUWDqSdmn+DDcJS7ZzcVM+z
 jPH9kw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbtc368-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:28:43 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91becce058aso5439786d6.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129323; x=1793734123; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y/BfbaE26gcWnbvzTsVqRyELQcp58GjPgwZGNGRMTc0=;
 b=SXwSK6a+aP5B1csWDfdROwE1KcB8Y9pso8BdBypvrI4nOGNpdGG4mubTgDi9Fx9SMp
 vfJi0DDQqNCN7TcxtV5id7Sc42hyZS4Y34UQpy8njXua2CD+wmbIHMR8MTma6ujOvw6S
 ISlyWUzNyoroBUuxrnNtgFwVWvomi7UyPvRrxA3up9SgJVCkwjYjkVGYlljp+g470ICd
 yK9HAJyeiB8ul8UDwu/pM23oAnM2cAeZLo2DhBRL5+eajXG7CGPz9zt5x3zLJxdD78RN
 Yng6+RAXRV6zanF4Wt60IPCN+5N//87nKRPl+d83hr4rZE32TTf3l3XwiEcmRKmbn4Av
 XPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129323; x=1793734123;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y/BfbaE26gcWnbvzTsVqRyELQcp58GjPgwZGNGRMTc0=;
 b=biX7ZpEi+MOAJYyRuQ+emoFNMyaazGsqjb6lTNMb28PnEaVFJEV153avk1clqytqa8
 JRN6xUDf8MK/5p8R51M/E0w3U32CLGkzncAiC3v0OF0DEspiPJB2hZj9A+q0bLNihCiN
 7rnChDM4KxOYrcMn49FGMxfU/4995pWKSACqyfdXG6pjWpOjv618r6Wzk/eRnas0BE2K
 JcWy7sPYMiN8Gq4GPpTyvyQXnaqepW+I1dNzGPKoNkex2lDaIYT7EulclI9p8cJ77YCx
 VPQvsdihq/XOkf5WS9+77P5Z8NmT9wA5voFkjyR4LSskDyjgS5FkS3ttuaXvC/P3ro3S
 Jwrg==
X-Gm-Message-State: AFq9FYJVnSQmhsWkBDgHtzFZd5S3a4byRf1PkrzkEdrwwd3lZNUy1HPU
 1QEEBdIFjO3ry6qO9rEUG32aHnDtKDxnv7Yy603oXVICqwljYFW9J4aEs2amtSv62qxscucSZaf
 uPAGpZBspk38P8/svqkgxG1zyVWZRDTHnfB7A4n2e2fBVIr2dfXhOTUm+ZAU+cccPZw==
X-Gm-Gg: AYBFou3LZ/W2Cn8LBwKGCbnNiyuVpbZ9OcxVl1cu6z+aK08U25T/PKCxDoft0fX83aA
 GbulZ9OlLkY2aC+EYsCqD+JEX2eM89DF8S+5vnRvM1ZNycF7/WNrbBv5anKty6U+XV4IpdZdCBd
 On4AeDipF2vj1QWsxNrPT8N5fA7ruDriTzzRYlKZc2aQHNOxMbywPU73hlVdmEC6x05YNQnKYAA
 JEPAnoO7R3yZ61HZFFKzKir2ai1/DMZCcbjiC1gAAPcGxRMu5FHI3cGQImrjf8Jc+2za2GLMiPN
 7SXOCZIDejoby9YMbbT0uM0JdOvI45HqY6fKWukltYKOGGjdT5J4hJFAFBPXieKEhfiL5FsG7l+
 6DXi3RLzlhfixRgITMvBHMdhCzU7oVmAjC/24HibKEKaIrxJkS+w8U7T3
X-Received: by 2002:a05:620a:4087:b0:93e:c12c:4416 with SMTP id
 af79cd13be357-940ef9cee5amr1607326085a.82.1793129323384; 
 Tue, 27 Oct 2026 12:28:43 -0700 (PDT)
X-Received: by 2002:a05:620a:4087:b0:93e:c12c:4416 with SMTP id
 af79cd13be357-940ef9cee5amr1607322885a.82.1793129322706; 
 Tue, 27 Oct 2026 12:28:42 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4ba7sm24630076f8f.33.2026.10.27.12.28.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:28:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 44/59] hw/net/lan9118_phy: Trace with QOM path
Date: Tue, 27 Oct 2026 20:23:25 +0100
Message-ID: <20261027192341.9197-45-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX1LDdR6lCISha
 8vocTjpq5dGqU6WOhkNWBvmuZeIESZ93kvwWk7hf4Un3Ol764o/ibCYVr6ughCmupJW8R2aSZj2
 DTOJFfcXMpmxGNAwZCIyYtGC0yQ20ME=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXxR+aYUTzKkyu
 Jl/9yKyYSYI6nn851J/L4V1ZNpWDBN8uDkFvbOoJQby6FMIPncDloDc3R7iZLkNtUYB1hV3TkvK
 1eUqx5cYr+h7jBsFVGImqujKSFl9FtK4kcH/1pEljhZEqw2PUGPCnLhK3XxxGogrJnh61xYAdYk
 +nLXy/7PyqE2LCGnfZKMW06oZbloxEsd+x2Gi1lg1wIFkIfZfjCodYFJ219g+cdIpkh4FYJH2vI
 ZQHRTgMsY+ufig8D6rHLdF/VcqVix2TRNSSI0HVjAkAE3UydMxrHrEq5dPRD97K6zAr4gwuiPuq
 QpaK05rMXE6KpTz0Z/2nBb/3OmLAmB5XqEymCJdVDL+D6NfMKieZdHPGGmuScnj0Dpi5zjaGIeo
 skfijo5r8tSXZgbLfm+4F1eoZNlDWJUFNUxnZtO5Izzoarz1sY2cLv1dzEVPqnsi+gV3nN0Hy4e
 ksvetskkjW8aFA4baEw==
X-Proofpoint-ORIG-GUID: Ip6hiOQD2K71FHtKQ1L0gHx8z0Ex212f
X-Proofpoint-GUID: Ip6hiOQD2K71FHtKQ1L0gHx8z0Ex212f
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae0fb6b cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fDfDFZYEbvkheSTyqaYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bernhard Beschow <shentey@gmail.com>

Some i.MX SoCs have multiple i.MX network IP blocks which in QEMU use
the LAN9118 Phy. Allow to distinguish them via their QOM path when
tracing.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260921214710.29422-42-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/net/lan9118_phy.c | 10 +++++-----
 hw/net/trace-events  |  9 +++++----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/net/lan9118_phy.c b/hw/net/lan9118_phy.c
index 2fc027d112cc..ee87a51241d1 100644
--- a/hw/net/lan9118_phy.c
+++ b/hw/net/lan9118_phy.c
@@ -85,14 +85,14 @@ uint16_t lan9118_phy_read(Lan9118PhyState *s, int reg)
         break;
     }
 
-    trace_lan9118_phy_read(val, reg);
+    trace_lan9118_phy_read(DEVICE(s)->canonical_path, val, reg);
 
     return val;
 }
 
 void lan9118_phy_write(Lan9118PhyState *s, int reg, uint16_t val)
 {
-    trace_lan9118_phy_write(val, reg);
+    trace_lan9118_phy_write(DEVICE(s)->canonical_path, val, reg);
 
     switch (reg) {
     case MII_BMCR:
@@ -138,11 +138,11 @@ void lan9118_phy_update_link(Lan9118PhyState *s, bool link_down)
 
     /* Autonegotiation status mirrors link status. */
     if (link_down) {
-        trace_lan9118_phy_update_link("down");
+        trace_lan9118_phy_link_down(DEVICE(s)->canonical_path);
         s->status &= ~(MII_BMSR_AN_COMP | MII_BMSR_LINK_ST);
         s->ints |= PHY_INT_DOWN;
     } else {
-        trace_lan9118_phy_update_link("up");
+        trace_lan9118_phy_link_up(DEVICE(s)->canonical_path);
         s->status |= MII_BMSR_AN_COMP | MII_BMSR_LINK_ST;
         s->ints |= PHY_INT_ENERGYON;
         s->ints |= PHY_INT_AUTONEG_COMPLETE;
@@ -152,7 +152,7 @@ void lan9118_phy_update_link(Lan9118PhyState *s, bool link_down)
 
 void lan9118_phy_reset(Lan9118PhyState *s)
 {
-    trace_lan9118_phy_reset();
+    trace_lan9118_phy_reset(DEVICE(s)->canonical_path);
 
     s->control = MII_BMCR_AUTOEN | MII_BMCR_SPEED100;
     s->status = MII_BMSR_100TX_FD
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 81af808044e1..839a612d3569 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -11,10 +11,11 @@ allwinner_sun8i_emac_read(uint64_t offset, uint64_t val) "MMIO read: offset=0x%"
 allwinner_sun8i_emac_write(uint64_t offset, uint64_t val) "MMIO write: offset=0x%" PRIx64 " value=0x%" PRIx64
 
 # lan9118_phy.c
-lan9118_phy_read(uint16_t val, int reg) "[0x%02x] -> 0x%04" PRIx16
-lan9118_phy_write(uint16_t val, int reg) "[0x%02x] <- 0x%04" PRIx16
-lan9118_phy_update_link(const char *s) "%s"
-lan9118_phy_reset(void) ""
+lan9118_phy_read(const char *path, uint16_t val, int reg) "%s: [0x%02x] -> 0x%04" PRIx16
+lan9118_phy_write(const char *path, uint16_t val, int reg) "%s: [0x%02x] <- 0x%04" PRIx16
+lan9118_phy_link_down(const char *path) "%s"
+lan9118_phy_link_up(const char *path) "%s"
+lan9118_phy_reset(const char *path) "%s"
 
 # lance.c
 lance_mem_readw(uint64_t addr, uint32_t ret) "addr=0x%"PRIx64"val=0x%04x"
-- 
2.55.0


