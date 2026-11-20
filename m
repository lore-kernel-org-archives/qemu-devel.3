Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062BF606A32A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f/NUiyXo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SAo7gE5f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSBG-0003H0-5e; Fri, 20 Nov 2026 12:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSAn-000312-Tf
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:13:18 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSAm-0003rT-7C
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:13:17 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEfYgp1680243
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 idgvY+a6R+Z+I3NHKy2UDJP7pusobRCKTbr/NYjb26E=; b=f/NUiyXoozKFImor
 sWGfYhowrtGmV+MHmgSyEh1cx5zf67lqNUXlXaRXqL5eEWdClc4RABbhCdqlXVlk
 3XU/Ea5KcYTw3vQEnI0/tA3eb8oY5sV2dSvZGk3klj2Mofa5FeOllpZIBWH+xkOK
 qcirwAUio73NxCiNzwgrEKi/NpZm75cGx/HZQ2YuOsyBiZ+yEIegSD/3d5xll8xI
 iMiYUeXPXmHLhqj/RIWkWZCTYvWUSAOVnSkdN5xBfIaKEIQTvJIt4CZfcad8R+ZQ
 OO52yTjtlcLYMVh76UBZ2/A0nPVatuPCvAApUjvm6RJKp0d8nJrlB92Z5C/nagdw
 tXYYlA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27b5vt2f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:13:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-949b0d322fcso206521285a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 09:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795194795; x=1795799595; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=idgvY+a6R+Z+I3NHKy2UDJP7pusobRCKTbr/NYjb26E=;
 b=SAo7gE5f3gJpAfKnUYLvZmzTYqCWRPpm+jyZjvt+1QURc6O+SpZ5czEHMaQeRDdhYy
 Pp7LckXAwITh3XnxgBHye0zUXlgy0TfZz+lulhDWe/ij5W4oo+CS427oFOPM0XoMp+S1
 Mr8uFNW+d8SPQF8hDez6i7BvMlRNVru/G1QSGQfn5TWBmYVKo1WcOpvHuNmIBcUl3Pk5
 6agsMhY4i3Sluvbmk51N68iYEnv0o2Z/DpksDWXF6/bDHXAXks7tQ7qhvW3v3idWF9z8
 TtIueqd0vBqcr+gOZZeFzVR8sh/7v4BQ7xQPlFSasqoygmzFPRE/33+97S//Xa8e+3qs
 1zAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795194795; x=1795799595;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=idgvY+a6R+Z+I3NHKy2UDJP7pusobRCKTbr/NYjb26E=;
 b=Y3irNEnVOLgGbN+MI0SSB48U1do3bhVNYsZjetj3YxVkw7cs9HkmitJhAax45Kmau0
 3HqICG1tXPxEg3h1ziioG2aMWBMQT2reocfLS9U9VhNIElvpAnjP7oLVRqyLXqvA/9bc
 sbFJe3wvQiX8J0WKVSkeUFcFtthaXb7AJeS+a4EfZ2lnLBUkzqCPwdNsjHRrNCP6vi1T
 nRJQVZBpPI7/Nh9SgL7kFCOCRkmGbtoMfyFgeAiAuBIddEKqYHrfVgHjVDGjsfVayhBJ
 NnGri4+iGrrgeknWI0KyVlwxmVmwOPqpJrosZgC2O0CYCz+Ix3EZCzmFw0HCNOPoPhKE
 Ct6A==
X-Gm-Message-State: APuU4Z8bmMllR4K9odH4YzfAyVj+Li38YODzEQ56eKlL7XymzVUmp9Zd
 JUne2KT2bOc9cSv4cyyrbBRFeifHnm0yOw6ZIIiln6koTVEaWwT1yeKzxQ8FSKY+8pqpRAXfRlb
 akj+YmOkfbEJrHBpQEaScPg7WUSBHBukkNbVnHw8EdnsLCUKOzSB9JJTVBhuGgcjfOQ==
X-Gm-Gg: AYBFou2NdzrGcRFBgfUS4MwSAGwHH3hg4cPgIUGq++kswa+eGvc90JMjK5J8xi0l8rW
 ZVJ62Dj2qlbCmEilBj37AkKARavvSlfI48MHdDfGcYI3FC5oYXqGoYUTN+1VenN9JbXYXuGz6zj
 jyLq/K1clia+eoGmNe3yCQjABUIuPllk/df6fmI4cinss8XXMGdRyAnQoQz9l9q7K4SYbDPzgv5
 IOTlFWcsSKzG0do/hiBLS8R4h+tTUDdeUzbnb61I4DEBtRdM5VZmIFNv6ILWgooulZV9E0dZ7lW
 w7P/2zWslQzw8aYnePgmpg8RNzLCd165ynK5NOUbIEFoH+sXw64HAJtonig6iEiSvlZnIO4CFaO
 F1MrdsDFWiUkm3WhEyQtiVkWHe9jk85VVKChUEAt3z1uF7jkIA+A6sCR/VelHTNnvEP0nRzwza/
 5Zfq7HN0R8hJpxqA==
X-Received: by 2002:a05:620a:6605:b0:947:920d:662d with SMTP id
 af79cd13be357-949ba9a2e20mr599519685a.35.1795194794549; 
 Fri, 20 Nov 2026 09:13:14 -0800 (PST)
X-Received: by 2002:a05:620a:6605:b0:947:920d:662d with SMTP id
 af79cd13be357-949ba9a2e20mr599508385a.35.1795194793529; 
 Fri, 20 Nov 2026 09:13:13 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88402ce9sm80090705e9.0.2026.11.20.09.13.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 09:13:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH-for-11.2 v4 05/14] hw/scsi/ncr53c710: Keep DCNTL.EA and
 DMODE.FC1 across an ISTAT.RST reset
Date: Fri, 20 Nov 2026 18:12:25 +0100
Message-ID: <20261120171235.61325-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120171235.61325-1-philmd@oss.qualcomm.com>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfXwSi87+MFZliP
 TF695VObWOlYddOjXYYuMEWLB3zPiuo6H8b4WNYbmLakhV8P/3cEYJLhS/5PusflloqPy+o+WmG
 WeSkvOUagK9fgjiQndpUCPc/QybLiVQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX9p5LMh4tyOXv
 q7WTpSgxusXFwTxJF+tzWyF0iil93pB4xZ+0HbX47DJc/QYzr+E11NMyOVFIxzt/loZE2xEb1yE
 NahuaNEE51yeDn2FTk/PR0zh6g2HCkhmsHi0UenaeGPYIhVxcmgo9Leo5esui/M/93u29Wnup1Y
 w6/ahkbzbI2LjBAWRJvm542vhBOVfOoqSKaeVpQM7K9lQCr26YsC4hACpa+5gHVBTD+pSd84Z13
 NUZ8SE3u+YDNykSptAEggL4boFS3UynmUYRGccdIHZwCnQNvyIbGlnAkuoqtrL1nkpx03Xpmcqs
 5a628q0lsVsCe35l2ek25uEablD1Doe/rKkvZd6H3pwQat1gVLOSz0Qaoh1gtqAR1vY0kW6zpnI
 xt85sZbsDpoxrM5S9b/45YTLWrGTOqo+FtQMpoCnSw63u8FR02bk5WlS2hM4k/T0FqMab6HT9sS
 6YdSjD3yyfF5ndK6P3w==
X-Proofpoint-GUID: 5W0-KeeRl1h3RYM7zhLDrWAezCGwKu0x
X-Proofpoint-ORIG-GUID: 5W0-KeeRl1h3RYM7zhLDrWAezCGwKu0x
X-Authority-Analysis: v=2.4 cv=LPTz05W9 c=1 sm=1 tr=0 ts=6b007fab cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=m1ZtPpK_mvkRyh5kXggA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
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

The NCR 53C710 data manual, ISTAT bit 6 (RST) description, says the
software reset clears all registers except that "This reset will not
clear the Enable Acknowledge (EA) or Function Control One (FC1) bits".
EA is DCNTL bit 5 and FC1 is DMODE bit 4.  ncr710_soft_reset() cleared
both registers entirely.

Add named defines for the two bits and preserve them in the soft reset.
ncr710_soft_reset() is also used for device reset and realize, which
must still clear both bits, so those callers (the LASI reset and
realize handlers and the sysbus reset handler) now zero DCNTL and
DMODE after calling it.

The effect on real guest drivers has not been tested.

AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/scsi/ncr53c710.h   | 5 +++++
 hw/scsi/lasi_ncr710.c | 6 ++++++
 hw/scsi/ncr53c710.c   | 7 +++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
index 00b6a01577c0..7dd0fe5f7589 100644
--- a/hw/scsi/ncr53c710.h
+++ b/hw/scsi/ncr53c710.h
@@ -85,6 +85,11 @@
 #define NCR710_DCNTL_REG        0x3B    /* DMA Control */
 #define NCR710_ADDER_REG        0x3C    /* Adder Sum Output (32-bit, LE) */
 
+/* DMODE bit 4: Function Code 1 (FC1), kept by an ISTAT.RST soft reset. */
+#define NCR710_DMODE_FC1  0x10
+/* DCNTL bit 5: Enable Acknowledge (EA), kept by an ISTAT.RST soft reset. */
+#define NCR710_DCNTL_EA   0x20
+
 #define NCR710_REG_SIZE         0x100
 
 #define NCR710_BUF_SIZE         4096
diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
index 27234aadd390..27d8b5c74935 100644
--- a/hw/scsi/lasi_ncr710.c
+++ b/hw/scsi/lasi_ncr710.c
@@ -186,6 +186,9 @@ static void lasi_ncr710_realize(DeviceState *dev, Error **errp)
                      &s->ncr710);
 
     ncr710_soft_reset(&s->ncr710);
+    /* A device reset clears EA and FC1; only ISTAT.RST keeps them. */
+    s->ncr710.dcntl = 0;
+    s->ncr710.dmode = 0;
 
     trace_lasi_ncr710_timers_initialized(
         (uint64_t)s->ncr710.reselection_retry_timer);
@@ -246,6 +249,9 @@ static void lasi_ncr710_reset(DeviceState *dev)
     LasiNCR710State *s = LASI_NCR710(dev);
     trace_lasi_ncr710_device_reset();
     ncr710_soft_reset(&s->ncr710);
+    /* A device reset clears EA and FC1; only ISTAT.RST keeps them. */
+    s->ncr710.dcntl = 0;
+    s->ncr710.dmode = 0;
 }
 
 static void lasi_ncr710_instance_init(Object *obj)
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 9ea2c47744e7..55153418e409 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -349,8 +349,8 @@ void ncr710_soft_reset(NCR710State *s)
     s->ctest5 = 0;
     s->dsp = 0;
     s->dsps = 0;
-    s->dmode = 0;
-    s->dcntl = 0;
+    s->dmode &= NCR710_DMODE_FC1;
+    s->dcntl &= NCR710_DCNTL_EA;
     s->scntl0 = 0xc0;
     s->scntl1 = 0;
     s->sstat0 = 0;
@@ -2266,6 +2266,9 @@ static void ncr710_device_reset(DeviceState *dev)
     NCR710State *s = &sysbus_dev->ncr710;
 
     ncr710_soft_reset(s);
+    /* A device reset clears EA and FC1; only ISTAT.RST keeps them. */
+    s->dcntl = 0;
+    s->dmode = 0;
 }
 
 static const struct SCSIBusInfo ncr710_scsi_info = {
-- 
2.55.0


