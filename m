Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D661606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ao1QSem9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K34gujJ2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSBG-0003HK-86; Fri, 20 Nov 2026 12:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSAc-0002xn-8Z
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:13:08 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSAZ-0003iS-09
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:13:06 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEfNct2196365
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /7s8ABkw8A0jDP5RoPLduBdGQ6lnCYdbqKkIWsykgw0=; b=ao1QSem9XZy5ORgA
 QhxEeTyfnTKJ5pSXQDF+Pib7rQTzdjy3y7D+8yaXXMje40exsjJdh7JcF667Iyqb
 w62Mf2hkBWqFMcu27vO5BuSpLpkG/2VgwUyAbKGpZcefl0AgpgWvlch3GfBa9LWa
 9I9Thax96UdQY2paGvHOMHyPEvaR4DzCgSCAqsEOQLOuK9smtcCtTbibxufbiXdx
 5bz01o3tJ8s4E6n0JCCTjc/LvIOdtNfzgG2Sb6Q1cS6Hbg6XAr5miqiy5BANhvKi
 gl8aPNd6a57UrixiaCRjsnM66JTisgAc/zHTk3mvWqFNHddUSdGuAZj3qlSPh7Gw
 svMAyg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2cd1uk9v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:13:01 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9211604468aso17909256d6.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 09:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795194780; x=1795799580; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/7s8ABkw8A0jDP5RoPLduBdGQ6lnCYdbqKkIWsykgw0=;
 b=K34gujJ2AdPaa8KdNZyr2WcuyvR0hhP1IxChVv5st3n3RCSQXZBjPUtgrGcoI/7kag
 D9C/cmcscvPNQO+6x6F9Dk5HZj6XVHLtdtnvJGmHi1GgiAktS6Xz5bXiuBj1BYoiglBN
 hS/jQDBxkkuqIVpYG2PLCsTarGzFvzrW55+H/S3w3yffmFKg9kmGMzJB95TVRqS1a9QU
 RiFwGtOCTNMcvX6mHA97s025ChnJ12rBENTX0dmpPlnBjjoHHSmd7ogrC8M6hvVV0xts
 smg6FoIWnmrtFkk8JcdG3179GVJ0H1T8KOtVaU5jGMDuk8DqdJn0U9GIMEk5++grWmMs
 YqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795194780; x=1795799580;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/7s8ABkw8A0jDP5RoPLduBdGQ6lnCYdbqKkIWsykgw0=;
 b=b0sOXvQHKyfFIQH2nzW/5COUNw6lQt9vt2bV7Qlk5q9/gzBnb/zLPbriJHDONrhrHJ
 1wrSwUFrKCtbqOj5na6CKAkGj3VfVSUgmSh1A+esan15cMwi4/jhkaLtyoyIM3LimeZT
 wC19ohHabYinQP0rSe1hekBAtB3kJTlCMmiJh5Bgkqyfsr3qnuFqE52wEbVM8JqOh3JE
 hffzrJK1LxJpeU6UHJS4A8TcN+FbfQtfPSZU9s2N6Xw93VIzvmnQ7Mt/ux8Gwe2HC20C
 19iFL8A4hNJV+ZJbgoV/IHdr9xNLDkraAMOn3lgs87MHb82XkNnP0wJd0OEOWaczT5Vi
 72KQ==
X-Gm-Message-State: APuU4Z9GL+6UChHIfuFBQ3DZwv5pkt8G9oDZYqL1poQT60F2smpCOjNv
 S/TtmjJHHUzy3Ef4muntqSFcjQP7/1WYw7CO0b4w6EiqfBzHcAxOhTEUHohXoa72s6OsLNGAJyM
 iyhc7PgObxlA4QQ7DCZkGgdrURJbxk12rrOekk9PBXMs0tTCO49kzaqI9uqMg/5mlyg==
X-Gm-Gg: AYBFou2dqApn4nnjsz1v/uCoYzNGEI2Ol+wHuqj2/TiSEMDXRo0q9dhkOrXtJlQSrNf
 3P57woR/FMuq3Jcdqxfkrmp0n6JWoh5Jd9NUiwffMP1Ytx+vf4YT7CMziQPtmBcNxNDLARzFAz2
 cJ7YCs2gK9ktbv44RqtMZpyK34tNTWrWMUa9v0rTaw+xx9aEsWfdzq+goaEesIEtNuPndyLVTCs
 mkmEwDKupdxudsB6G9l902PUEIJOnauBqWbM+79YmGukgdI1EtmUEEs1yFEfHTBWXl43MbI6mGb
 nptHpQHNCSlEXv36bxR8osZN+vN+BRnni8bLjc9V/+nl2Azhfa+VzIrSk7MvRgpgLhu3mfBUKms
 3+YiCTNS15qHTyiwyAD4MzIGxdrSQT9dsegkzqXCYxBSMhKfRRs1KlLXVE3LqPq32GZDPB98Tdw
 nCwPNGPyaD/W8kOA==
X-Received: by 2002:a05:620a:628b:b0:93f:6f8:9d72 with SMTP id
 af79cd13be357-949bac7c684mr520717885a.77.1795194780199; 
 Fri, 20 Nov 2026 09:13:00 -0800 (PST)
X-Received: by 2002:a05:620a:628b:b0:93f:6f8:9d72 with SMTP id
 af79cd13be357-949bac7c684mr520711085a.77.1795194779478; 
 Fri, 20 Nov 2026 09:12:59 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8d4f9aa8sm48714965e9.4.2026.11.20.09.12.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 09:12:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH-for-11.2 v4 03/14] hw/scsi/scsi-disk: Add
 quirk_mode_page_no_flexible_disk, use it on the 715
Date: Fri, 20 Nov 2026 18:12:23 +0100
Message-ID: <20261120171235.61325-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120171235.61325-1-philmd@oss.qualcomm.com>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Dt/Da2/+ c=1 sm=1 tr=0 ts=6b007f9d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=zCys0jnkAAAA:8 a=EUspDBNiAAAA:8 a=2MoOl1b4q7AZYG_WMiUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=AAPjE2N9MkmuCaafd2wf:22
X-Proofpoint-GUID: cYBxlBH2pY-hTaPshkoaVbr2-hGgjvHJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfXxq7s5+NjCs8I
 mHEjYiUTkfYAUwzlOGRTrd2DKP37HZ9dMRUh4UYbwPha+ZqQHXRnmsV75Z3qKjdBrIXm4HPOwR2
 avYEl+PP+JKLcqUhm2Oamm69Ql3oD3S3pmUVLAG5g+JHQF2ZcMPQ30JS2dBgVs8bCk5+tLLso3z
 v+o09WewbWk3NQsLUfQEe7H7+jaesQFO9hEluriegNEGnwUw9Vh0XJHT84aRXCoRus9HHZ+u1xm
 FMkyaHd5v7WKihFBMlZari5kGaLYmmPE1qYF27IoVkj/elKYcN42gxO5bC5hg4VxFGbERfU9rwn
 s7aSgKHArCLZPo+Y/p1kuRnayCpHk2VzQHibQn16x3KvuYBXjwcO4ScZ7IaSHuvooWkxe89Nll0
 ZAnEpuJiUMMbnkkqKFj+Zhk7umf+HDvYu/oi4CuwkuZWUJeh4adLO8gUzA62CJsTMFKq5ELCF3r
 5VVP++9P09Bn78NL+0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX7j92b2XHgN3h
 Y3meNc0Zo+Rl7tzniPp2GJjl3oVTSk0CwNXMt1ekoD5F3ivH55WhktXny2ZJXhDso9+TEOKN2Ox
 GU2f4MhjpMcnz0/W+7bnUdKW+kZ7QRs=
X-Proofpoint-ORIG-GUID: cYBxlBH2pY-hTaPshkoaVbr2-hGgjvHJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200068
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

scsi-disk answers MODE SENSE for page 05h (flexible disk geometry)
for every disk. Per the commit author, real SCSI hard disks of that era
reject this page with CHECK CONDITION, ILLEGAL REQUEST, INVALID FIELD IN
CDB, as only floppy drives implement it. This has not been verified
against real hardware or a datasheet here.

Per the commit author, HP-UX 9 on the HP 715 probes page 05h on the open
root disk and, when the page is returned, treats the disk as a floppy
and leaves it out of the ioscan listing, so SAM shows no hard disk.
This guest behaviour has not been reproduced here.

Add the quirk_mode_page_no_flexible_disk property, which makes page 05h
an invalid field in the CDB, and enable it for scsi-hd on the HP 715
machine through its compat properties. The property is also defined for
scsi-cd, like the other mode page quirks, as both device types share
mode_sense_page() and the same quirks bitmap; the 715 does not enable
it there.

The array name hw_compat_715 suggested a versioned machine compat
table, which it is not; call it hp_715_scsi_quirks.

AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/scsi/scsi.h |  1 +
 hw/hppa/machine.c      | 10 ++++++++++
 hw/scsi/scsi-disk.c    | 13 +++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index a2f6f0be7fce..0efa62554d50 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -264,5 +264,6 @@ bool scsi_generic_pr_state_cleanup(SCSIDevice *s, Error **errp);
 #define SCSI_DISK_QUIRK_MODE_PAGE_VENDOR_SPECIFIC_APPLE    2
 #define SCSI_DISK_QUIRK_MODE_PAGE_TRUNCATED                3
 #define SCSI_DISK_QUIRK_MODE_PAGE_SET_BLOCK_SIZE           4
+#define SCSI_DISK_QUIRK_MODE_PAGE_NO_FLEXIBLE_DISK         5
 
 #endif
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 8a3f673daf75..2c9114995aad 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -1024,6 +1024,14 @@ static void HP_A400_machine_init_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_size = 1024 * MiB;
 }
 
+/*
+ * HP-UX 9 ioscan sends MODE SENSE page 5 to the open root disk and leaves
+ * the disk out of its listing if the page is returned.
+ */
+static GlobalProperty hp_715_scsi_quirks[] = {
+    { "scsi-hd", "quirk_mode_page_no_flexible_disk", "on" },
+};
+
 static void HP_715_machine_init_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
@@ -1045,6 +1053,8 @@ static void HP_715_machine_init_class_init(ObjectClass *oc, const void *data)
     mc->max_cpus = MIN_CONST(HPPA_MAX_CPUS, 8);
     mc->default_ram_size = 256 * MiB;
     mc->default_nic = TYPE_LASI_82596;
+    compat_props_add(mc->compat_props, hp_715_scsi_quirks,
+                     G_N_ELEMENTS(hp_715_scsi_quirks));
 }
 
 
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a2df3a4ec464..ce43ddf6c062 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1156,6 +1156,15 @@ static int mode_sense_page(SCSIDiskState *s, int page, uint8_t **p_outbuf,
         return -1;
     }
 
+    /*
+     * The flexible disk page is only implemented by floppy drives.  Some
+     * guests (HP-UX 9 ioscan) take a disk that returns it for a floppy.
+     */
+    if (page == MODE_PAGE_FLEXIBLE_DISK_GEOMETRY &&
+        (s->quirks & (1 << SCSI_DISK_QUIRK_MODE_PAGE_NO_FLEXIBLE_DISK))) {
+        return -1;
+    }
+
     /*
      * If Changeable Values are requested, a mask denoting those mode parameters
      * that are changeable shall be returned. As we currently don't support
@@ -3293,6 +3302,8 @@ static const Property scsi_hd_properties[] = {
                     0),
     DEFINE_PROP_BIT("quirk_mode_page_set_block_size", SCSIDiskState,
                     quirks, SCSI_DISK_QUIRK_MODE_PAGE_SET_BLOCK_SIZE, 0),
+    DEFINE_PROP_BIT("quirk_mode_page_no_flexible_disk", SCSIDiskState,
+                    quirks, SCSI_DISK_QUIRK_MODE_PAGE_NO_FLEXIBLE_DISK, 0),
     DEFINE_BLOCK_CHS_PROPERTIES(SCSIDiskState, qdev.conf),
 };
 
@@ -3401,6 +3412,8 @@ static const Property scsi_cd_properties[] = {
                     SCSI_DISK_QUIRK_MODE_PAGE_TRUNCATED, 0),
     DEFINE_PROP_BIT("quirk_mode_page_set_block_size", SCSIDiskState,
                     quirks, SCSI_DISK_QUIRK_MODE_PAGE_SET_BLOCK_SIZE, 0),
+    DEFINE_PROP_BIT("quirk_mode_page_no_flexible_disk", SCSIDiskState,
+                    quirks, SCSI_DISK_QUIRK_MODE_PAGE_NO_FLEXIBLE_DISK, 0),
 };
 
 static void scsi_cd_class_initfn(ObjectClass *klass, const void *data)
-- 
2.55.0


