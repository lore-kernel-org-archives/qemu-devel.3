Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6E9CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI2y-0007wa-7k; Mon, 01 Sep 2025 23:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2N-0006b6-TF
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2M-0004wL-4O
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:27 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S9Y8030159
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S9U9Uvohu42z9l6+p73uyfEB3XHB6hDRIEdfSEWzNOk=; b=QM21zjO3IOz/Zzk+
 pxkwMk7CJ5VCJ5dzSmIpxEmE+dH/5zltCxaZ3Mo3fPrjVZllO31tDDdMKUa2awTA
 m1hjFnddXwdPyDh27xpZ8XAS/Bhjm+FWzxCbOyKrv6UTFY0+VmSfW33HR1XbLV4w
 7Ti/csGeq/jR5iM9HZ717BGJQNNATePhpbBElfX+eS4+mlgtzs4MaCzjfqhQPzpm
 fRkHWXLu7dgAot3kNJ6OvmhK6RkrUkhEzbNm5QE0ivVbH4OJ/Tr7U/+8tfjq9oRP
 JF6lrJVDPzi485Jeo/OtBEwas0XbGT6akVzmcJNuxlzZ3aan3e+0pbqXN6mYWa7V
 UWITQg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy26vf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:50:14 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-329ccb59ef6so732200a91.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785012; x=1757389812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S9U9Uvohu42z9l6+p73uyfEB3XHB6hDRIEdfSEWzNOk=;
 b=kjLyS8PdQdH1e3OC7TlVcRzLQOB0pvcQra7FyNLgpJNRNqn95oLboEpe4sCL9ugjeT
 aqrI98QNO/58X4+YnhzqfslAo5mCF5jdiXzXQEVZCnnezkjiORb1nR0oEhGTHIqVp6Sy
 S9RzE3q17fPZufXjZB7h2+D0azQrFA2JNpqjabHIPc0tGs8744qFkNvHsASRAYZ+6HCt
 dOy81VrkTafTxqXC0c85iNTaG03eQeaZ+bEErzbd9agVnxK+0L9txDKhXh62xpERdpt6
 sHGHPgoJPXm6EF7tPc5UpQDAlg1VSniJaNO6j+z0fdQUsoYkoTZ/zNwMwrY+Ux/bVohs
 hEqw==
X-Gm-Message-State: AOJu0YzguUetuobUeXFg/dAlVsBh/dWcJ7tNKufnL90Tb3JL2O6OX1ke
 auxeyr6LDTQMosnmiaAv8ttYGSX4YFne6HMJn0HOO3GMIlSaBJXbumxVyJTxzrjoQv2azyzH2RM
 Wh2IIOv73/4IOX+aPHaoxJqjRpedXdzsCqMUoiGxQvuv9slCKojnWi3VGootXxPIJCM75
X-Gm-Gg: ASbGncsVSIAXaiK7wimh+5ScjXfrFXltf+m4Al5lfTRoxHqU7Dlj6c3b3LanmsPfp/b
 TG0kQkGHyGhM67lynk76dzRD86tWebwMbboWMXTjAbXy4p5Fd0zlyOVy41oJk01Kf3hHzIJyYFa
 X8Y15yAtPdmnhpbOa2wibQOQeufTDd4r9+dM8llAkQKGlVppQu3qmnvG6utkXcDV8SnEj3ZvPH4
 TErjd+ileRd1m6uESXCD19mt5HK7Sy2KjcP70aF2KJWoHFk98jzwBaIysjoA7aE3Hj+mLRR1tk1
 0YRCTC8SJfdCy5JPBTagDjE8m1EklM773rLSYDSo7nrD3uWTejfUzwWytnoXi5FSvWNDMDVO1NS
 Z3KlvLDRh1FiM
X-Received: by 2002:a17:90b:2251:b0:329:e47d:f914 with SMTP id
 98e67ed59e1d1-329e47dfa8emr707689a91.21.1756785012244; 
 Mon, 01 Sep 2025 20:50:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmcSjdWiUIxIP3jCXqgWO5cGdqCFBiKYj491pCrxQXTO/v4a2kOl8oqu0XZJXIJ54jPa7LZw==
X-Received: by 2002:a17:90b:2251:b0:329:e47d:f914 with SMTP id
 98e67ed59e1d1-329e47dfa8emr707646a91.21.1756785011550; 
 Mon, 01 Sep 2025 20:50:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327c5fc5055sm14117932a91.14.2025.09.01.20.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:50:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com
Subject: [PATCH v2 09/11] tests/qtest: Add hexagon boot-serial-test
Date: Mon,  1 Sep 2025 20:49:49 -0700
Message-Id: <20250902034951.1948194-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
References: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b66976 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=mx_w8yxdHMTqIFmIFlQA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: ughswJB8ijo6ZKM1W_jMnMls5naukTnZ
X-Proofpoint-ORIG-GUID: ughswJB8ijo6ZKM1W_jMnMls5naukTnZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX90B7jFRTMumH
 //ITCjaO59Lq3yY2MbeEEO76usfNdcy7Fj5uQBElXK2czzQj7jV+IpnsHsHIsNTdMLGBn9k7Ntm
 3XCZPvB7x3nESo7gBgk+HBbHPx5Jxk2QDpRLIOzaJBS807o9E/MID1m2EDgwpjU0gNwXMmxRoXD
 q85nS7tPB+5yna2QcKeUh+Zi8REFUbcwPZmA2BimUCh55ieW7cj44l6nNdVBxAXgZttkWLBtO5s
 FDnlP+ZqnAmKLw9Cds4n0AJdo+Hm3dcyq8Y2UnVcMKnM1cwkgM1qbvvjrqxCBVlTOlgURf4v9PM
 B5/ej/+YarmrxxZKE8Yj75zoqfUK8dVz1DKNNgew/1VJkKEBxPWiYjo60htEiSdo+ihLgxgtaZP
 7Qo+/q3B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add boot-serial-test support for Hexagon architecture using the virt
machine.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 tests/qtest/boot-serial-test.c | 8 ++++++++
 tests/qtest/meson.build        | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index a05d26ee99..733e0f855c 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -142,6 +142,13 @@ static const uint8_t kernel_stm32vldiscovery[] = {
     0x04, 0x38, 0x01, 0x40                  /* 0x40013804 = USART1 TXD */
 };
 
+static const uint8_t bios_hexagon[] = {
+    0x00, 0x40, 0x00, 0x01,                 /* immext(#0x10000000) */
+    0x00, 0xc0, 0x00, 0x78,                 /* r0 = ##0x10000000 */
+    0x54, 0xc0, 0x00, 0x3c,                 /* memb(r0+#0) = #0x54 Write 'T' */
+    0xf8, 0xff, 0xff, 0x59                  /* jump 0x0 ; Loop back to start */
+};
+
 typedef struct testdef {
     const char *arch;       /* Target architecture */
     const char *machine;    /* Name of the machine */
@@ -194,6 +201,7 @@ static const testdef_t tests[] = {
     { "arm", "microbit", "", "T", sizeof(kernel_nrf51), kernel_nrf51 },
     { "arm", "stm32vldiscovery", "", "T",
       sizeof(kernel_stm32vldiscovery), kernel_stm32vldiscovery },
+    { "hexagon", "virt", "", "TT", sizeof(bios_hexagon), NULL, bios_hexagon },
 
     { NULL }
 };
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 669d07c06b..4e79cd0a8f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -284,6 +284,8 @@ qtests_riscv32 = \
 qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : [])
 
+qtests_hexagon = ['boot-serial-test']
+
 qos_test_ss = ss.source_set()
 qos_test_ss.add(
   'ac97-test.c',
-- 
2.34.1


