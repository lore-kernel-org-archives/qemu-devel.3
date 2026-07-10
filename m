Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57512C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ6J-0007S3-3z; Fri, 10 Jul 2026 17:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ6G-0007Cx-LX
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ6E-00056F-Mq
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:36 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AKDcCf1811759
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B4xOslOXt+KodCQiS1iEhVVx8EtA/KKEKO+WOnwX/L0=; b=F0mLJQGosFtk8x5F
 QtJ5gOGBTZQMkQQW0b0TckV3FznFvYd5xnoBPdT2bwnpxSsAGF10v+Z+Ydot9Zyc
 eefvbIAdOyLdRVOvaee7owW5hY9VPzaScbVytcvzF+kko5xBs1qvTv3AT5DQA6+J
 y8oquQD+D8Dm7b/b+kcsZq1iI2No3B/V+cpD1VWDMkfb4CwGrW+O/tP/EGpiJ/UH
 +y7j2Dwqj5EXfS6Qd6t0tNEtnR6dprPTw+MknijV7N1BrIVyhjDbml9J2Q6hyknW
 fdjGdKkRNV1Mro5oTkBys4fYI9IMRf2MBrUixj3VUWXUo/6MmUyjDTNDLriHqq4j
 vx+YAg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5faj64-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:23 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca8409ba0easo2045645a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720163; x=1784324963; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B4xOslOXt+KodCQiS1iEhVVx8EtA/KKEKO+WOnwX/L0=;
 b=cAChSKKFZ+NgxoR1aNNX0murV6mVBO/zzHxRIXcZPAHw/zxn7UnYr0HfiT0ingbK68
 PWjl6O49KXbLxEVw5Hrq/BKnFMRXGz2pFnfTgOAW05I4eJgGyM8i2CCAm5pMnmfK6HyN
 O578YYKNbJVfaa7Mx+4EZNx1DvhF7OJglbUJXAz/4rAZ42GGY1785LYeG/wTCMhVafa2
 /QDOyUqtNHMpBvfnzOw7VPF7/EH4ZWY2/UpEr0zqBBOFU17C60QnWIpop9lvqogawVyy
 IqXtSn3lN956zCn22zMRzeAZ00uOycu8qAR/yCI6GJba1yQO85kraeaJh/kqh4XQx9QI
 J8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720163; x=1784324963;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B4xOslOXt+KodCQiS1iEhVVx8EtA/KKEKO+WOnwX/L0=;
 b=hrm+0DF2DbSeDy9dfSwe8uGWovvjEZqaklUnr6dtEaV0DnhtmtXaVgMVtWcALA3eYZ
 +/4MvKnjLYMTLfPZojlw+ncNlCbOvp8uspqUKudzTG6WFd+v8IbIfWmsGBDmhEC9q15/
 B/Pub92puoBqpFEECOk1njylFK7EZAxuNLqxKcop7M3r0CpUoqFaXlJ6P0KvZhU/2cZ0
 hmIq979gAM6XpdkZ+3VCOecfAFzSmWQc//0jLCgOT0+na9k3EyqFzr4yHTw5O2E4pYZA
 3/cchLeBv7pO/8I2bdSdPuALF4/GD/3dd/w/WKfyk/JiXi7fqDZVfaokuTo7jvdb8yjC
 is7Q==
X-Gm-Message-State: AOJu0YwR0V1NakfTudGNBG7rhPW2WmQD8ZFqYqJp4zhI2tI6Suw70qs0
 XemP6vhRDq1Vw0nrRgUcXOa4LresTFdqrFBidOdoKmXks1LuyS4GTi2iKZ2uXH927MwnJqqvMx7
 eogoo/4GcQog0HYOFAvXUmt7ni+nB+LJkuGluqVqDFz7ej7cV7TtahlfZpHvQ4N8Biw==
X-Gm-Gg: AfdE7cmi1jPjQXv/1Q879UD3sLrdNQb4E2RfUMaDWdb8QjM8LZ/aU0d6WKdRYwJLjV8
 alrz1Ypsux+cBqiG0eXZgUoCGzQFglyKMT6sJSFLCJyR2eCsy6P4R4eKygHRQ48OTxQe5Aotal+
 y7XwgR0CHYM1EXB081aMsz6CXtMbQLxa6VkAB2mB+LBGo1Ff3ARxsrkXqVJIpF3h1ZDFO0tFe1b
 5VHrsr8X9aFMbQ8dERv/lPKbrOmxE7NSDh0Z2GEjrdJhvptwyTMoYlsqQICJCSCyFrevGMLp+BZ
 BID4gl3ruE0sIGRVzANpLFu/6Zfh9UKAVW9A9YSgK62c4tsvT9Pnfb6buOKspfzPtQ241a12kFI
 +thgTpifydGPoqYlydeToqLrEDdWLNDCtNdInLb1KrQmLDVpyGdCtgYlUdaXg5kgCxu6C+InLkX
 oZJKC++Q==
X-Received: by 2002:a05:6a20:a10a:b0:3bf:bde7:d67e with SMTP id
 adf61e73a8af0-3c0f0bcf127mr6394744637.32.1783720162736; 
 Fri, 10 Jul 2026 14:49:22 -0700 (PDT)
X-Received: by 2002:a05:6a20:a10a:b0:3bf:bde7:d67e with SMTP id
 adf61e73a8af0-3c0f0bcf127mr6394717637.32.1783720162296; 
 Fri, 10 Jul 2026 14:49:22 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:49:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 70/98] plugins/api.c: identify or1k pc register and mark it
 as read only
Date: Fri, 10 Jul 2026 14:43:14 -0700
Message-ID: <20260710214343.2065491-71-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a5168e3 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=qpq-EKoDnDwZV1OHMCMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 6AZRkwyPC8A8XpZkDHFFMwPYcXocqOqq
X-Proofpoint-GUID: 6AZRkwyPC8A8XpZkDHFFMwPYcXocqOqq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfXwAxLp9kNVJ3H
 oSwzgfasgHvHNgO091ay0hyqS5NzfjIUBZrDEJ29rf2IqkU42J3/kBQM2MN/+2S5aDl944eC7K3
 uxCnykllHR2bdoNDlk1d/dGzn88kceE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX93ZjxAMCzt6y
 Moad4PbhoAXh+ns7WlK8A+OZzfH0CBpNNh7WD7wc5ivPQlnHdADrcJlElRP1rN/U2rEJ0JLaLYH
 hCpsLcoE6MWVsjQ7y9/8zk/dpYX14kjm/7HLoJwcyYA9GVOIYNNVnZxliBurJ5iravQNCViHvyN
 QQCJRF1CxkJ6lglEZhYVHp/TgHhl+O7bfM77Ap+6esKFB+DOWaXLmSnt3E5EJ/6PN4HR4N4Ic86
 9mGZlcRuHZr69QsvrLW80l/lRyFOPlfIyHUcyqAfySPqpxGzNAhYjRoj40SVYRN0+dHYlcU3kn1
 xOzEW5EIfoC+VWYfzLnDJue64kZhHIxqM7HZtruubvP2TIeCB6eoKPpHoB++ZSVIvmROmnimFv3
 kKG6vETQ0EhAgLIK1bTxTki6RKhZolH3Pjg+rS3hgx05JAIlsvCcxWMd2bdvcVxLyTdVogR/OCV
 CF5YM1/nZOefA1gF5dA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100219
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

plugin registers.c checks if at least one register is read-only, which
was missing for target or1k.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 plugins/api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/api.c b/plugins/api.c
index eb982f9aad7..3520c96f411 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -425,6 +425,7 @@ static const char rip_str[] = "rip"; /* x86_64-specific name for PC */
 static const char pswa_str[] = "pswa"; /* s390x-specific name for PC */
 static const char iaoq_str[] = "iaoq"; /* HP/PA-specific name for PC */
 static const char rpc_str[] = "rpc"; /* microblaze-specific name for PC */
+static const char ppc_str[] = "ppc"; /* or1k-specific name for PC */
 static GArray *create_register_handles(GArray *gdbstub_regs)
 {
     GArray *find_data = g_array_new(true, true,
@@ -449,6 +450,7 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
             || g_strcmp0(desc.name, pswa_str) == 0
             || g_strcmp0(desc.name, iaoq_str) == 0
             || g_strcmp0(desc.name, rpc_str) == 0
+            || g_strcmp0(desc.name, ppc_str) == 0
            ) {
             desc.is_readonly = true;
             plugin_ro_bit = 1;
-- 
2.47.3


