Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C842C54EFC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woeJL-0002l1-63; Tue, 28 Jul 2026 05:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woeJG-0002dy-Vv
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:41:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woeJF-0007QI-8z
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:41:14 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82Eji2026962
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cUMY7buvUujjwmjvw1tjC7sd0Ar7z/xxnVlDZDXYTMM=; b=SMhTE+PVDHEXPb71
 tswbFjZHxRy5I7dsSSlKdeSnxR5waF/2BlflUa7QZCWYfuWhk3j15B/Qh/UldWYz
 Gs0xAu0bWgxJvLU2q2sHZGpL/5ak8OjSpsSHk69PKn1uM1IwgKQerl1+rpIA2PU9
 ttO4rCJRXQlzIRQxqB2UHCU4ywnqeMFPpdz9DZzj2bUQQ6Kigt5n87CNJ28VMlIm
 ITeuR/hZUz0d0KyjcvYSgWVs01e7HA4JwnceSRQzcE8ga8lek+jSuU7Ot70xTuzM
 cZNinAcX+pxJ/BoK6iajiwGMXgkGBslO0jpA7o0OkyArQTduOv2H/Aie3yqHg2p5
 VKgUfw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpq9hgraa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:41:12 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a8db414c7so54235011cf.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 02:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785231672; x=1785836472; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cUMY7buvUujjwmjvw1tjC7sd0Ar7z/xxnVlDZDXYTMM=;
 b=aJ5oBZqA/V0Mr4ny2P3C0W8ZDsWdy83Y01NWnemKbSFq9LTcTIT0nqUNE8Paq7VXAq
 9TBDOZE0h01ycMo3S/z2LJbwjpBt78I1Ql+QvFiohl27UW78N7ZE5W04JgpVpkCcS5J7
 do9obcZYndwSTJjGOqXKdHn3xRet4HLs+SRLTcmKn616rnd/MbqOo3aU9+Jz+/4Q3dWe
 YMxkJdPSwcKr4bO0fikOhuP95W8imi06LrGQTt7TU42Zz5UtC7RuSxvYR/8GOO8uNmb8
 4sVX2vOJZJUs0aLXMIKftP02MUGFg7rx8sJVuXUyIHy5b7bwnHoBdi99PAJzl7RWHbZP
 zfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785231672; x=1785836472;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cUMY7buvUujjwmjvw1tjC7sd0Ar7z/xxnVlDZDXYTMM=;
 b=FYnAjI5pg6/hOAOCQx7vxjIYVULgWn1dqa+DotXd6mRfnDcvm0shKqqQxxBHTD2x5a
 NCTFlhZTi2w4evxWxvnOKyj67h1um8SCywDIjVwCsMzkJR2Yy0cT/i+H2vYrqIU7+DqY
 qOBKLwdnMwDqtiNHWm7w+keYREYQNTWHsPFtFtrayRe+A9M2eC4P6mUg5ziHh3Z9k47u
 mHDYKJbg5CfpSv44de+wBRU1i2b+sntBggkkXSzRB2U867q9aQP/oRRc3KfjcoSxwlSu
 t3ZSFkP7cC9QbcTne/LD8T/8e7MbcTzGtbrdSjoJmUfVzEaPNrof7+blT7bFXFXoJY3m
 LtGg==
X-Gm-Message-State: AOJu0YwKAxJ4W0kQmn/jpD+kBXwm32wkRvEDQE2U1gMY6uqTpmOqIx1R
 MBENLZ0hUygPgvCbjSC/cS8kFbOkYwDPI9yM0Lwf+LW7lq6YsJ8DbeuEza6MURZVXMUtBDMxuSF
 OtXAgzVm1v30hXkeXVNT2G058ZeOqX7S5SvzHcAN6EDqJhsHTDsZw2+G1Pf7nLoqJuQ==
X-Gm-Gg: AR+sD10tOaZ7FZ2jgxN+ShypcbnG2jzjeUsKOwn6Po2RLZyBf1fk0q9ljqBm+YMvT3L
 9CcmsQF41b4dhR2Qr7oJBLwTGuh7TMvMCAXF2ncOMC68atPhz6rrDwtN6LiXgD6nfrfSMpg8y2P
 n8XNFPfr/pI2z6QqLQWApbbcRgTfd0RS96zmIZArY5h6KAxyZooNHq0BFBsq/0RuUIqIlGlqlDj
 h0NA7yFUf0pYUAw2yZuzIb1IyO/1AST1AtvTZFWCkJe3CPjLboz9IM2BbhZfbZ/MVosS07KRO+k
 ZGG7XVRKXvXUU8xcGizgnbf4xZnvf+uaqEKnwB/ygzQfi0RmRfyQ/FqVzQhFy/qFBInKEDP+Syv
 328KDSv7elEM2NoDmGpA3o/3iP+DfeXVlkkpfgXSkEG3M/eHLBKuDCpA97g==
X-Received: by 2002:ac8:5f8a:0:b0:51a:8c9a:8fb3 with SMTP id
 d75a77b69052e-529d72226d4mr11994801cf.68.1785231671678; 
 Tue, 28 Jul 2026 02:41:11 -0700 (PDT)
X-Received: by 2002:ac8:5f8a:0:b0:51a:8c9a:8fb3 with SMTP id
 d75a77b69052e-529d72226d4mr11994501cf.68.1785231671074; 
 Tue, 28 Jul 2026 02:41:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45cb67esm67587875e9.8.2026.07.28.02.41.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jul 2026 02:41:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/6] hw/sd/sdhci: Extract uSDHC-specific quirk
Date: Tue, 28 Jul 2026 11:40:51 +0200
Message-ID: <20260728094055.12684-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728094055.12684-1-philmd@oss.qualcomm.com>
References: <20260728094055.12684-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4MyBTYWx0ZWRfX9eLLy5WF1CMr
 DL554uIXPUG83N2IeOHDpe44g2Fx8jkczpRtJ4J2N18faSxRXojEyZZmFq/YWRw7QVeyDEW+50y
 +7gCa7vW6mVGNqPwE4jgtIuLOlB7pZg=
X-Proofpoint-GUID: c0KyRfDKaO5QntFBC3JnHN9PmaWy0ZhF
X-Proofpoint-ORIG-GUID: c0KyRfDKaO5QntFBC3JnHN9PmaWy0ZhF
X-Authority-Analysis: v=2.4 cv=Aa6B2XXG c=1 sm=1 tr=0 ts=6a687938 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8
 a=Rg1yqSK7o-gODesPaPkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4MyBTYWx0ZWRfX5cAZNQCTiq/X
 WKVNuOuknfphNbVRYBXCN3Zg9g1TT9Feh5Ci2pSRsOWE6H7IP91ZJ8v7gP+5eM1To+pa4NsGW0h
 1ErJWo/2YRWNJgJmKhAl7jfizF2X7fs+eKid56ZYDPD1cMWs/cumrSmLt2y0Lx6PtKtzQtf1RR7
 3IdvP2rEbG4brHjOLGgdwcqsT2yQeb6LXbqyA2mlccrkhBp7PJAJ9z7lWT+qhc/F0KPh9KIrOqs
 LlhuZUKuu8vGi4G5pPZ0Q4D3dxxFKCVvD4VlcT2Ig8ED7hE3XMeSUOngalcT0a56B8BGHM4k060
 0hDRlS4M4uzTKGphZYyIyMyryGW7jKhUFme2zowCpI2HxkSDCHoPPqUqnO5doEniYaRDEbQMo8f
 WO4QgxP34dZrQmHNVV6FuQfkmhHFLOsQMLz32Qe/Bd93gqPzwi6daZkcumU5H+z6gjiAY0Y//Nc
 bIBD9LLlf/6EFAYXPBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280083
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

From: Bernhard Beschow <shentey@gmail.com>

In Linux, the ESDHC_MIX_CTRL quirk is guarded by esdhc_is_usdhc() while
the eSDHC code path uses the standard SDHC interface. Extract the quirk
into a new `usdhc_write()` function.

Fixes file system corruption on emulated i.MX53 where Linux'
esdhc_is_usdhc() returns false. The same likely happens on e500 and
imx25-pdk machines.

Cc: qemu-stable@nongnu.org
Fixes: 75e98bc4f859 ("hw/sd/sdhci: Add TYPE_FSL_ESDHC_BE")
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20260720201133.24796-3-shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sdhci.c | 73 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 29 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index c86dfa281f4..e58a6103970 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1795,34 +1795,6 @@ esdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         sdhci_write(opaque, offset, value, size);
         break;
 
-    case ESDHC_MIX_CTRL:
-        /*
-         * So, when SD/MMC stack in Linux tries to write to "Transfer
-         * Mode Register", ESDHC i.MX quirk code will translate it
-         * into a write to ESDHC_MIX_CTRL, so we do the opposite in
-         * order to get where we started
-         *
-         * Note that Auto CMD23 Enable bit is located in a wrong place
-         * on i.MX, but since it is not used by QEMU we do not care.
-         *
-         * We don't want to call sdhci_write(.., SDHC_TRNMOD, ...)
-         * here because it will result in a call to
-         * sdhci_send_command(s) which we don't want.
-         *
-         */
-        s->trnmod = value & UINT16_MAX;
-        break;
-    case SDHC_TRNMOD:
-        /*
-         * Similar to above, but this time a write to "Command
-         * Register" will be translated into a 4-byte write to
-         * "Transfer Mode register" where lower 16-bit of value would
-         * be set to zero. So what we do is fill those bits with
-         * cached value from s->trnmod and let the SDHCI
-         * infrastructure handle the rest
-         */
-        sdhci_write(opaque, offset, val | s->trnmod, size);
-        break;
     case SDHC_BLKSIZE:
         /*
          * ESDHCI does not implement "Host SDMA Buffer Boundary", and
@@ -1891,9 +1863,52 @@ static void fsl_esdhc_le_init(Object *obj)
     qdev_prop_set_uint8(dev, "sd-spec-version", 2);
 }
 
+static void
+usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+{
+    SDHCIState *s = SYSBUS_SDHCI(opaque);
+    uint32_t value = (uint32_t)val;
+
+    switch (offset) {
+    case ESDHC_MIX_CTRL:
+        /*
+         * So, when SD/MMC stack in Linux tries to write to "Transfer
+         * Mode Register", uSDHC i.MX quirk code will translate it
+         * into a write to ESDHC_MIX_CTRL, so we do the opposite in
+         * order to get where we started.
+         *
+         * Note that Auto CMD23 Enable bit is located in a wrong place
+         * on i.MX, but since it is not used by QEMU we do not care.
+         *
+         * We don't want to call sdhci_write(.., SDHC_TRNMOD, ...)
+         * here because it will result in a call to
+         * sdhci_send_command(s) which we don't want.
+         *
+         */
+        s->trnmod = value & UINT16_MAX;
+        break;
+
+    case SDHC_TRNMOD:
+        /*
+         * Similar to above, but this time a write to "Command
+         * Register" will be translated into a 4-byte write to
+         * "Transfer Mode register" where lower 16-bit of value would
+         * be set to zero. So what we do is fill those bits with
+         * cached value from s->trnmod and let the SDHCI
+         * infrastructure handle the rest
+         */
+        sdhci_write(opaque, offset, val | s->trnmod, size);
+        break;
+
+    default:
+        esdhc_write(opaque, offset, val, size);
+        break;
+    }
+}
+
 static const MemoryRegionOps usdhc_mmio_ops = {
     .read = esdhc_read,
-    .write = esdhc_write,
+    .write = usdhc_write,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
-- 
2.53.0


