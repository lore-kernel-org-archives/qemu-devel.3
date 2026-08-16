Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C9FC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcAm-0004ec-C3; Sun, 16 Aug 2026 10:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcAY-0004YE-0x
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:49:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcAW-000121-LY
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:49:01 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlSwT3632271
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MvCTXi7xvNIZeLKyy3ZEPwPDWV5CvBy8bU0QqBY+PNY=; b=NTihcudTgJeUn0A7
 t3n4/JguRYs1hXDpGe7yYH+nWqgNQUY42Soiw9ac5dQSmRGHkJnitkeD1EU/sXNN
 SpLB3Ib07mkC3mvvI9wnIldecWeDByQdZ56YIevNAlCX6guaH4kU4g5VRKAHQhg6
 litv5YUc+YUyFPUrN/MqoqqR/0pEEJbBdviaQYKaDCx+UM8+O/yChooPYtngPAFP
 Ujcj3bGipO7tIkpCVTApWKkCmFeVGyanWC0HtqsNKs+2rOtajocLAzVjCH6hq8er
 nmxsAUyh0dFhyPuZZFgFJF1TIU+FsE9JiqbV3XgGxz2C2PiXZFbpvKZF5Y14ouR9
 5Dz4Wg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghekq2w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:48:59 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c19493ac2so27605811cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891739; x=1787496539; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MvCTXi7xvNIZeLKyy3ZEPwPDWV5CvBy8bU0QqBY+PNY=;
 b=YMERcfG+SJDsNHQs5t/S1ChZBOB2MhLuR+ZlE9p9ob/mCzy+ZR3YZyr4IRlx9zH4C8
 QVG70om5YS4a9tXwqoLM/6teY2hcGQs5x5me5WzGmaWiuB1kG0coSWFPwDAr4f7s9yzB
 gty4rujZi5eqEiAKuCZi0GcBnYd+/j+TIm3RgWoXgM88CIRtqKZvHZzS/LwMxjwGC+aK
 tIQml7yQJCcdwzCUniR0TU3bv9d14gB3XPTYqxfRDjsmR8ZXwUKG2WIMyR0ddDUHonAW
 gegJRcYW2RKTcZoOG916FmaTGALxQdWpu8bPb2MGvKWbOJCtQRPKEVguxvPBhDoDkgRI
 Ja/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891739; x=1787496539;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MvCTXi7xvNIZeLKyy3ZEPwPDWV5CvBy8bU0QqBY+PNY=;
 b=ea6kEq/8GbczFvY6o/CIRSxpajtWrwlln190VdNTAXpaNZ0sAp48mPdIfCfWY2QIdS
 BTFxc8prfO7PUoFPlzRLqwfyA/lV+9n0TaqkUazbnqblNKBycVNeen0PIf02AIabsEli
 O2cdDT0vuuD3WiJnix9JRauLX2PP1ClBNUsI97CUkPnAlaMa1nvrz2czkiAJcAx/4vTY
 MKUhqaYDeWf/y2N1ekw3zwbSzQ3bakrWdeEVrR7j6VLk8L9nbdo0XChz9aF1QIIiMfLJ
 N5O3hlwanwYOw/VNcpC4RfCJzqr/LN59PHJf6ZsHOyxny+cntiaPofIYdoT2hwz6Aq9o
 0c8A==
X-Gm-Message-State: AOJu0Yx7IW8RBTPagvPalMuk9fp/2gN22dbrhX0sX99rilWMaZ14HmpY
 m7d/NDTnXP1N8/cfa7VIQLq5WKH379mJmEcrvJunb7cJ7er+Y5ShhbdACKTrtmRExB5dkpAon7e
 Fiy85Omv4vO9b2XoHonUWIZQzhv7G/kRBWDoVAEZSZEOPkGjsIb6OAX74thQ5UQYwag==
X-Gm-Gg: AR+sD12A8J2qZhVTbPpUHSvhKKydljL6Ti7X1l/VkEAAZtBOBbL04vsa6e5dwLradkp
 Ui5YnEyWwn0UkWXsJU4TY8ScwOJy+dp00tvh9veLC2Tm8irLKapMvLgzurfJNXMqfkqfcl4L5o+
 F+84T7GED7FVzaHFwCSDHFgPnPeuky3oEYKY7/A4eMHXKZIpECeAPb+3lvqOFqxsq6POh0TJTck
 QdnF7BNFZNJS+KgqLs3m7jp8arF5mNYbrX9F+Okx4v7C3Bz48+BwYZDoT4LfwQ3kCiT469EXF56
 zm0rzfzpSrNrz+RsNigQiEj3a16697Z/UO6kfB8t4hEqs3A0TWcj3jzcO+Ph8E80yAJ3zMtVNIq
 VhdLs5NxtybFStRJHnb8Az+TQdpxeK5+qSnIgWYRiew==
X-Received: by 2002:ac8:6f0a:0:b0:52b:4e1f:940e with SMTP id
 d75a77b69052e-52d8537bb2bmr218358981cf.1.1786891738982; 
 Sun, 16 Aug 2026 07:48:58 -0700 (PDT)
X-Received: by 2002:ac8:6f0a:0:b0:52b:4e1f:940e with SMTP id
 d75a77b69052e-52d8537bb2bmr218358661cf.1.1786891738554; 
 Sun, 16 Aug 2026 07:48:58 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1f90sm23386241f8f.18.2026.08.16.07.48.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:48:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/56] hw/cpu: Correct CPU_GET_CLASS() comment
Date: Sun, 16 Aug 2026 16:45:20 +0200
Message-ID: <20260816144556.69009-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EKc2FVZC c=1 sm=1 tr=0 ts=6a81cddb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX3yCcsTJx7EiN
 ycPDjmdXp2uNZkUlcG9SbxAk3xEgZfgBjl/wBQ1wO1QCP5sqrnHYJUqIxgp41cwE+rzVQaQhoVE
 jSmyUKvQg2qyJkes1Pj0uqzprZIRlRs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfXz+jugkVA5r4H
 8I1qxIvgsDZCvEPTwx2EZzSjItEJ/D2P3Meyguv5rmxL4TmbOisqMywNDQQvBVVRcPjQwxi/J5S
 fMhFVhV2xzvzmgT4GGfvBaxgj1KMO/RSCE4kP8trR6JyFyuwmxjboLynmcrVCOHaGhzKRiWOfTD
 +jKZ7HPeDDNdnDzp5rxCELhvGZE7qF7jzuthNCg7rGmRNGsGaAoCOFHUcyHV768fb6EhXK9pj0W
 6oCuZXnRTEeYD9Ck1VQY/XaMHppTW7u8riX0G7JZC0JFBcxYjt3omlHIgcyg++BFXbp3O6gr8uF
 SFLFral/KPmSfHjtHIA/VrORm3C6AlxexmPZVejQLnd+ZP7RXgh6PM0Ic0gHIZ62F3Jvj/vllQM
 sWF2YKBZf3fO8zEPHvdgDmBoVSgI5YyGIS7Q5DgJeI21rwEOBSTsOM/2seQsAReZrML5/GvxoWT
 ib+wQfxyZsZ4cp1gXMg==
X-Proofpoint-GUID: E6bPS8aZ_z0GXen4rZ-h7oMi_u-UJuMZ
X-Proofpoint-ORIG-GUID: E6bPS8aZ_z0GXen4rZ-h7oMi_u-UJuMZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
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

commit 0e86d7a71e8 ("cpus: Cache CPUClass early in instance_init()
handler") renamed cpu_exec_realizefn() -> cpu_common_initfn();
update the comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260811183410.22428-2-philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index b54035fb13b..c5064a5449b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -60,7 +60,7 @@ typedef int (*WriteCoreDumpFunction)(const void *buf, size_t size,
  * expensive given the eventual call to
  * object_class_dynamic_cast_assert(). Because of this the CPUState
  * has a cached value for the class in cs->cc which is set up in
- * cpu_exec_realizefn() for use in hot code paths.
+ * cpu_common_initfn() for use in hot code paths.
  */
 typedef struct CPUClass CPUClass;
 DECLARE_CLASS_CHECKERS(CPUClass, CPU,
-- 
2.53.0


