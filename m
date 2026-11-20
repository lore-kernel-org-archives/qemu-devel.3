Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C760A260C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LPvCes3s;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EVP2HHde
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSCa-0004v6-Bs; Fri, 20 Nov 2026 12:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSBc-0003oJ-32
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:14:09 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSBa-0003wM-CV
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:14:07 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEfGI82039946
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dSk32GFV9w8KwAVkufxIR4tqPzxMljQ04C6vWgo8qes=; b=LPvCes3sTEuJxRUw
 /VB9SikIhGTJa1stiKFwLHRSIs4jdEnLN750YcyVFX8sane9PXg+mrHxV0u8IR2e
 3e3pylFgfpHbsZG/wbie3bU7HJXVDX788y9nVfY5FLj+tdGS3f2ZjvFy4+MwBm20
 Z9ZZic/JSHkVsaKCRDdNqRLvxQGvWLs/gMVXVbWRbYNpqTLIut/roTr1RCMTQB+d
 fiClXSC8WniAM3246PG+qaa//xxjj9xQ6klU2pTLBiBA1qHx12raCdErZxqDCaoX
 sEtv+DGrtOGfylEz76GGabgiFO7L2xlYO7zzSuB6e/dVw0DxzloaPMUfQwkKdm34
 mRQeWA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjtty02-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:14:05 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9213e04641dso11705346d6.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 09:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795194845; x=1795799645; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dSk32GFV9w8KwAVkufxIR4tqPzxMljQ04C6vWgo8qes=;
 b=EVP2HHde8YHMYeVQb117RPcOdKtCMxtQdvQUeAq3sv4Z/W35QAhqIw3qdzpi6Dmr+P
 lrADCcvA7BfDBkP4u5jxelJDEXPJ/amhqxwu2P38tQOBdbGNbMQBkSbNYPlB8C+1rzgK
 YK/twq6ieRrkPBN194akB5WBIZSXtpV3Smn+dPSPIud/oxsMnthMQ1sJu2t7dsvTIDA5
 FCwrobUzthQVmpp5LHB+BGVG+/fMzrQPgSpjk6SZ623F09ztwMqaPzDJ5d+iK+sU8D20
 9NWzyKis1DU+u5tVJltXPv1R1I6ZN72U5ThaxBL3uWPvE8lKNcIisCSPNvUifAACA/Vf
 jnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795194845; x=1795799645;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dSk32GFV9w8KwAVkufxIR4tqPzxMljQ04C6vWgo8qes=;
 b=ASvTYunG0KsoGbytlSTiaOHUPiNMzy0EuhHTtj5HmJKdSSaoFk37UznS6IB8265wiU
 US2RFpsXBBISYerGzlmspeMHtdgN6t3KkZpO1toEAiYGj9uAEfRLmjVdcu1OyBQUz+yi
 S8JkMadP+dd6mGp1XpSv1YoKVMMD4DFhrWBETC832r8DQe1+xccpOIc4KvIv3xJL4nIM
 /udedWS9M0wo6iIhoePGPPbbZfOLZc5vxGw6KC7efWKsv3Dxjex0tfDQFh1Sy6SkxeOr
 Ais1gfFa0pskkbAS7uhRopQsEYtD15W222nfutz47eG7ciunDNB3g1bEltu+OK9GNNc9
 jnYg==
X-Gm-Message-State: APuU4Z8Up9McWx8VJSbLRs4wLEXEKNDsXCyNHf6/G7SaHFWslB12igJ8
 BNYIpZF82qGXXJttJss/77R98dS8WdSR+VuAR9jrePo+G/poOjGGEeicHGdyL9A8ibQZvelipIO
 EtXoqIMylyKiQsgj0zbrqpD/NBaaCLPvVPNJodv66pwGqBP4WdPFFuIzJSmENVSuZFQ==
X-Gm-Gg: AYBFou3qJ37cApjvHZjf1QJMAQM47hAMu6vUzGWrNWWe16SlX1/7F703MRKjVYtfMkK
 3nHwntfU1nYKv47q3b3bEQrRRbDOQuIQWFeBGryRpivZw3tPx4NNlg6B53QNgUi8dEXL8qBjc7Z
 WuI9T1WiPRg+D4+2WIFZDTvrXWIxYatkeSiZdf8r1swzglxRakD6DEEx4i0//elcoI6hnzEFPf8
 EVXAUm1jKhUhOYlJf4cUwA2yV8AbQGG32Xkga2nrOsvMmWdQWBZ+pswVj4EgCM7mjAj181VgZ5Y
 8xnB1rYx8GVmNFv5NEgoqqFcrNVvlwptToiKXZtl0tWHFPS3cEKR9F38AWJn7idOunAZpHfiOjS
 EWBR6WBvw3CpCWl6V7P7WlkL13/jtHaE65wCpyMQVGTn4SPihisxj3FN8qAV0mdsdAH2FLCZRiw
 kOyVbTTuLynxfhTA==
X-Received: by 2002:a05:620a:4551:b0:944:d7b:e7a with SMTP id
 af79cd13be357-949baa0ce68mr600302485a.52.1795194844609; 
 Fri, 20 Nov 2026 09:14:04 -0800 (PST)
X-Received: by 2002:a05:620a:4551:b0:944:d7b:e7a with SMTP id
 af79cd13be357-949baa0ce68mr600296185a.52.1795194844032; 
 Fri, 20 Nov 2026 09:14:04 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b2c5sm127297155e9.5.2026.11.20.09.14.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 09:14:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH-for-11.2? v4 12/14] hw/scsi/lasi_ncr710: Map the full LASI
 SCSI module page
Date: Fri, 20 Nov 2026 18:12:32 +0100
Message-ID: <20261120171235.61325-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120171235.61325-1-philmd@oss.qualcomm.com>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kwxJihun8hz65rwMug3yWcxfCW0ncMt5
X-Proofpoint-GUID: kwxJihun8hz65rwMug3yWcxfCW0ncMt5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX9oPTYyqXXbod
 VGufYVpAZi1TQt/dn4x6xk8p+JtO9crfFV7TQ/iEzk6TYSjogcJ8WP8Fbp/iBsNSX/szhoka4aJ
 fLVNJUW98F1+UXCodhS5TOMRfeCPbAr9T33Oxom0y+SjGFPra4XkkUM1n+iSziCtKWUm2hQMHe2
 3RPzHkXL+UwLP9u466mfXIOqvBqjcPow6bfQeE/RvcLoB7VYZsiYbnvaHhby2e/By+ayGfneqUq
 purYz2wDhS5GBn/Xs8Fz59WQ/IBy7BB0ZNnEifV7b61eGwtQ2ngGeR+htG0IyB/fxpZOyMOU6wh
 RWlui4iywvCqYrkTJkXOf/bVqdrYw8jvhr7OyfGIMP8CvDWP+k7Do5jTWlj0Z5JCbRG+5NAsSbk
 wNpVxKZLxgsx/5RHp+6s7tq9Uxx+qq9kGEHvTkrlkktuyy9MpmRX2gtCH3KjPqeIVvRdf6UkPhv
 E9kxA0J1vFGPx03sCtw==
X-Authority-Analysis: v=2.4 cv=XcccX455 c=1 sm=1 tr=0 ts=6b007fdd cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=zCys0jnkAAAA:8 a=EUspDBNiAAAA:8 a=n7BD_sn2foo_3xeKym0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=AAPjE2N9MkmuCaafd2wf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfXzTmu0n+YhEa5
 1IN0+FGeMb3IXRBKoVogYYsZy3I+NltFS7j0gE8/qH4jUAIcEmusgzQI4xkAbVqywzGutxy5Jgk
 eZ+c+H/n0rvZW+yKhDKsrNzHvaH2F4c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200068
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

From: Keith Monahan <keith@techtravels.org>

0x100..0x1ff goes to the chip core as before.  The rest of the module
page reads as 0: HP-UX reads a board strap at 0xd85 (bit 0x20:
differential bus, 25 MHz clock); 0 is single ended, 50 MHz.

0x10..0xff and 0x200..0xfff are unmapped module space.  Writes to all
of them are ignored.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/scsi/lasi_ncr710.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
index cbb04017ce9c..c8a28cd987b8 100644
--- a/hw/scsi/lasi_ncr710.c
+++ b/hw/scsi/lasi_ncr710.c
@@ -45,7 +45,8 @@ static uint64_t lasi_ncr710_reg_read(void *opaque, hwaddr addr,
         return val;
     }
 
-    if (addr >= 0x100) {
+    /* 0x100..0x1ff goes to the chip core. */
+    if (addr >= 0x100 && addr + size <= 0x200) {
         hwaddr ncr_addr = addr - 0x100;
         if (size == 1) {
             /*
@@ -68,6 +69,11 @@ static uint64_t lasi_ncr710_reg_read(void *opaque, hwaddr addr,
 
         trace_lasi_ncr710_reg_forward_read(addr, val);
     } else {
+        /*
+         * The rest of the module page reads as 0.  HP-UX reads a board strap
+         * at 0xd85 (bit 0x20: differential bus, 25 MHz clock); 0 is single
+         * ended, 50 MHz.
+         */
         val = 0;
         trace_lasi_ncr710_reg_read(addr, val, size);
     }
@@ -83,13 +89,14 @@ static void lasi_ncr710_reg_write(void *opaque, hwaddr addr,
 
     /*
      * 0x00..0x0f is the read only LASI module header (ID/SVERSION/HVERSION);
-     * writes to it are ignored.
+     * 0x10..0xff and 0x200..0xfff are unmapped module space.  Writes to all
+     * of them are ignored.
      */
     if (addr <= 0x0f) {
         return;
     }
 
-    if (addr >= 0x100) {
+    if (addr >= 0x100 && addr + size <= 0x200) {
         hwaddr ncr_addr = addr - 0x100;
 
         if (size == 1) {
@@ -191,7 +198,7 @@ static void lasi_ncr710_realize(DeviceState *dev, Error **errp)
         (uint64_t)s->ncr710.scripts_timer);
 
     memory_region_init_io(&s->mmio, OBJECT(dev), &lasi_ncr710_mmio_ops, s,
-                          "lasi-ncr710", 0x200);
+                          "lasi-ncr710", 0x1000);
     sysbus_init_mmio(sbd, &s->mmio);
 }
 
-- 
2.55.0


