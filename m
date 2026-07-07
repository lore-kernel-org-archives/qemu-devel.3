Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F31C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5bz-00013B-UP; Tue, 07 Jul 2026 09:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5by-0000oS-4s
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:13:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5bw-0000Rv-Fp
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:13:17 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8t7i3768570
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JM9SCED9Plarjv9QQZHSBpEU4+Cp5EQcu1bRESutIKI=; b=NkghIEyt/yW1EBHD
 f9m7iS4XFRehIhG02uTDs9pknQZQ1S77AmReBbzlWDOSoPTNNG23EAIrYoXJ/0Oj
 H9iKoEDzqey4u265v7qCrvvytAiVeNq0XraHJAS4H5rCDXRStd+Cu1S8pD7OM0Sy
 goD6+hFuoaMiRUix2CLwlRPS5ql3y251Phvc8ygGv+STRboQ+orfCJGyBJMj1fNu
 IvzP6F3FJD0xOtSDB3f8dT0rix5BSVm9PK005RE8e4D9TdvnwNodsVR1LM6LpX3k
 4kaoCdgGUHtBd8uXv+kWt+ccV7EGjfS7V/PXWNbIwfAfF+7nTX/XLJf7nUMDSlgO
 bhtHZQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8qj7ajvr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:13:15 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c33f48ee4so46470611cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783429995; x=1784034795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JM9SCED9Plarjv9QQZHSBpEU4+Cp5EQcu1bRESutIKI=;
 b=a2YscLq2kFQAzetU2r4pUSWuD5VwVyLixGaLShi69Om5oC2+b+G45BH5uC8aiYCehs
 fl/6ObAofaRSS+VRD38QC739NjTMg9sKGqntTujyG1mBlb7KD0XC2UmNtQZUNk+le2ug
 3LeCDxtwmXW6mjkZBc1mlV0h5+gcoi67suJZ3K4ba0fIa8a6gOyZPTx3DJ3sAQlYiDxl
 jpDSyIX4kYnuzO3CZh7u0fITvUh60eyEG8oYcy36pEnBPVK2/FGLacuOYGPbSr88WbCC
 ppXOmvC2Le2Y9pVlw2TizevnzppuahiWUOIFO/iXOVcqwrscmoyDNjeRAZvRmTCUkW2b
 yfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783429995; x=1784034795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JM9SCED9Plarjv9QQZHSBpEU4+Cp5EQcu1bRESutIKI=;
 b=cgk+f/BXvajm1kg2U1ryjP1CHmZ/h5wq8QERWL7ZvPEgdN9oCZeWAQ2Sut54908Vzs
 bYCQ/J/r6JynolRUG+ogc+HSjjJoNqis5qGdre6Dk6+LhOP3Hk1H3aDJrt74io8d2Yxp
 DtmqRMWvONW6oimJaUXd9IGX+JwJx2a0Qzq9CyBv/Luj1aak+NlIjA0F1IGzNEr9tFwA
 wgP3GaGbKd7LQQ16ojcxuiHEqvFlS0XIAw//m62h6iyjFZSPU50KKlPHWmYmtcIX/OTz
 zeUR98ZtJkbJ2vQk9xO49tP+z5AOhga4ifcxD5SC53y08XGi7FQ9togP7G1yjLbbuXG+
 1z3Q==
X-Gm-Message-State: AOJu0Yy4GNRGjyi3xgRIocSse5878fJ5ll4nUqQPfEOq25r9MKuVOBRG
 /x3+MOIauFJyIqvJsNx/gyTXa8CMEh4QTGNZjy7q6FeoMQm+I9Ej9zi5X0bMJILalamWYU7MG70
 6CCRM/rSRVW2LxqMCYrwO/6W0xbucPFSDLZfvy/RWBHBM/SBF+5BuFYB4sbbnTmn3dw==
X-Gm-Gg: AfdE7clzFKlKfAZtcZn3eBBWKMU/6EuTJHWitiB5Lcg8ZfqT7QOxFQ0AJF8/0rIxeu2
 4gRH45Y2n21khbux0SKyiKbt6/sanv3/xK9k85Cv5AzgSJ66zudINw3HTyaojjvHfQFjlz2hCdA
 DJzf+x+DP8E5GmtUbhOlR+Zj7pwmfLsc6hbRByc4VB42b5C0zJDAHgRF5e6zzX/CzTQnAKNOi7F
 5JnecILB2s2KisGsxsdBPa/ztahW1YppBfJoMODL4DKJ8A3gmhT9wTUWgjNIEtSH/Psxwe3ALW8
 LUpH/vfNzZqWLnDzKBhOMB7FqF3uOkCY0Sh5OMvPtYzKDT4X7ZIweBSzIZqye0uaXAd4xxpBg2x
 qmd70EM/MLchyN53X3Pp9hoMZPGcL8rEA6qx6bFd8pL+GJHYK2RgOL6wxCvp+B6uFyBEp
X-Received: by 2002:a05:622a:840e:20b0:51c:7b12:6008 with SMTP id
 d75a77b69052e-51c7b12674cmr13337031cf.84.1783429994836; 
 Tue, 07 Jul 2026 06:13:14 -0700 (PDT)
X-Received: by 2002:a05:622a:840e:20b0:51c:7b12:6008 with SMTP id
 d75a77b69052e-51c7b12674cmr13336781cf.84.1783429994413; 
 Tue, 07 Jul 2026 06:13:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19db05ecsm5660846a12.28.2026.07.07.06.13.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:13:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/32] hw/gpio/pca9552: fix off-by-one in QOM led index
 validation
Date: Tue,  7 Jul 2026 15:11:57 +0200
Message-ID: <20260707131223.51505-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oERNdV0R4n3_8wCLTB9Q6F9w_tquqmaw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX4HMDuVPQQS4N
 IDINlLeJuthuKcfc0P5kIxJEaWCjEpT/D5SUJkeHKY7fnwL4jz+6PdzBBEKJwTZU5qzjlf2Cpuv
 OVN/aBLYk3vltV55Aqxt9jR3vSAax57nM6eK1KktxKFEyowtvpUpUjgGU3YcByw688VXxvyixiF
 7Bbf4l1OfH/KfBmxMqAepDW8A0ZbRKR9fjvd5d61DG62MYN/KY2qt+VZrDTgqrdMpAK/svsziwk
 oa1PhOyRqBnNmoaPKn1oHn+EKMzz51RFhxCE1ljbXLn4fi0UkYX5+6SM+oKmBDUaDPTluCqL1fd
 dnaJ2VbobVSVpBco/MZTzrwWVviAAnPwECu1/gHAyhsrDd7OJRORO1l1JjIBUmlV3Z+rjiL3AZK
 8j3Z8jKKIyt/oA9WhminVP7BNJ9nyN5zh2Jn1fojIoSmjBwJrBbtZ0G8gKx6RK1qnaXNP9pRaoV
 wO02imx8+jqDjPs5OwA==
X-Authority-Analysis: v=2.4 cv=PIM/P/qC c=1 sm=1 tr=0 ts=6a4cfb6b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=NFH0hdw5WT1NvSh7Sn8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX95bLDsod/F+8
 K4lbCNBNjt+k6iILD1lfAe70JQ6aTtKfFEOKxXDgH2wNHxRsY4alSOpUzSEZVNCs3GwfA/f1DLS
 dmw7XcJE39EgcOkNXH14ausji9eGgiM=
X-Proofpoint-GUID: oERNdV0R4n3_8wCLTB9Q6F9w_tquqmaw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
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

From: yujun <yujun@kylinos.cn>

pca955x_get_led() and pca955x_set_led() accept led indices equal to
pin_count, but valid indices are 0..pin_count-1.  For a 16-pin device,
led16 passes the current check and then accesses an LS register past
max_reg.

Use the same >= pin_count bounds check as pca9554_set_pin() and the
gpio input handler assert in this file.

Fixes: a90d8f84674 ("misc/pca9552: Add qom set and get")
Signed-off-by: yujun <yujun@kylinos.cn>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Message-ID: <20260629074133.187549-1-yujun@kylinos.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/gpio/pca9552.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 472d8ad9571..b13ac9fd9ce 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -311,8 +311,8 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "%s: error reading %s", __func__, name);
         return;
     }
-    if (led < 0 || led > k->pin_count) {
-        error_setg(errp, "%s invalid led %s", __func__, name);
+    if (led < 0 || led >= k->pin_count) {
+        error_setg(errp, "%s: invalid led %s", __func__, name);
         return;
     }
     /*
@@ -352,8 +352,8 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "%s: error reading %s", __func__, name);
         return;
     }
-    if (led < 0 || led > k->pin_count) {
-        error_setg(errp, "%s invalid led %s", __func__, name);
+    if (led < 0 || led >= k->pin_count) {
+        error_setg(errp, "%s: invalid led %s", __func__, name);
         return;
     }
 
-- 
2.53.0


