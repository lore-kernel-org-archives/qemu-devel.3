Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A341EC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySjB-0000mf-5c; Mon, 24 Aug 2026 07:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySj9-0000jp-9g
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:20:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySj7-0006Un-G2
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:20:30 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O99Co12547896
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iDP7SSBBed9OilMDhZqOv3xXCrS8V81wrx791E5ihCQ=; b=E5+xTKN2yuAoWHRX
 Y1JYTo0NFKYslrAa/Oc+I5r0oCNBZpfYwCbTRhMl7TknPRBnDQbamuWoPAZ3eCXw
 BMlRogW6lWwmVdYJM5KisTwL4xGY0e6+DF8S6CvKbCk2MUZhDxqxoKGvsPh4q6gw
 TOr+ZMXCmbM+HeJUjq0cOiJ01/9RHLND7nzc3hxwn5hKtj4M3I0+4sFpLYO+EEUe
 yukezxNXGOVU5sj02YdZt27R+S5XXCGdTJkAHmI/1H63ahDArmjL1i87BmXUXKkE
 7o8+sY3QiZqO7Sr6l2W4I75cfwoz6RI0E+bIES64Oekx5rXTWesYp+HwQxsHlaAW
 WrAAPQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88k7jd4t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:20:17 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8eec6acbe21so64714886d6.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 04:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570417; x=1788175217; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iDP7SSBBed9OilMDhZqOv3xXCrS8V81wrx791E5ihCQ=;
 b=OtQZ2g1jPNHXWHC+PKcfc7xR+OxcUphby+kOwNhsFmJ2Olkz5jxVkoJxXGoi8MNKwG
 wOHn9CnTq9/VabAFDYFZridzd5Z+dagHcLCV387gbtLF3xZIALpYJWCVLqIM0oMbZ7p6
 O8ne1hjmGKSg3VNA0kHYytl1BBEm5KN+MZ9ZeC1Sb2W0x93g5W4uUr1BynxQUMeM+CAH
 vXAyUJn9nogclOjd2o+weXes81I6SK8gXf+m4Aqnk070zlnzdnv7wXUBKxw918+0cyDs
 poxQmVVAvBRtGVD7xeDiDDiBS5wa0H66nLgP74tWxlVnmRsUA8z3quj8WaDlpCRJCsWD
 f4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570417; x=1788175217;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iDP7SSBBed9OilMDhZqOv3xXCrS8V81wrx791E5ihCQ=;
 b=WwDro+w+55S30iyKhJ8V5nucOKTYI1Kpjs8p/hEDnq4slU2TVTKWwdT8vcphxsSvHF
 8+pM0ElNfp2mA8QCCmHMiv1q6g7beZBXUt0Uy8olhfSsx1oIz/xZtSwKaTlkSx0yFDdv
 SiwYS6oefwSlcFnYMxzDrgUH6mnZkeD7fFvN+4vkl8UAuUgEwiyg9w6NGEQ0q29IFuPS
 icTacntphHs+7HFDjaWnEz8ID2ljeyfR4e5M7QGHBMxUtpAOSpVBMgDWNE0gjFYur5Qw
 wu5MFrY3CZn4eBYn6uuSeRHCXNU3pEh7FIqph2KqaHoVPJnOpdZ2VVhtaAA398AQL19Q
 yOYg==
X-Gm-Message-State: AFuF++nR7IESVC2Kp4RhxP7VxZ/yJ9BPf/EzoX+sV4JNQfL89ZPq8Zpw
 76e2dN8beU/hOmekx+emzTo3TEGK2T0eHCmZNcgROWaauEQZEhpPrrPmce1UN3dxWUYJMxu8Hkl
 MNLQroFwDHFaEbsStXUyvtTwNCsPCZ6oN0kUw0fcxI/MpxIVgbtmYjV3N/aFl5isHAQ==
X-Gm-Gg: AR+sD11hyCaJskP6aEb7vPZAM4D5Tk9fg0cZrsCWsS/he/6RqkzINZDKCyjBW6b682V
 Tiv0lz3kQ2CRsL3Q5e8QVmc67tr2sbUlSdQhlSnMOLwrPDcvAX0mbElWfNQSKrfzX4hloiO6xIa
 ykIHKCKCDvgN8uCHaPZmeVhPPinARBIyVRaRt90PNCwr87V8yWnRtx1vvVaYBPznYM/P1mbZnlz
 YAQHpajbu2S4+494jmGo4PYrutyCC6SakEznZLnwnAKahRsS+CkZ7yvBAFtBEPSn0qHi9Cv6MSI
 Qi+Z0rFM98o4c1hopq/beXKmeikrVbpSY8Y57N4mnxV3XLr2kjmeM7TjnT6aZM2C5W8VRsGy85i
 HfIf9fSIrPPpygFGfkbzGTIUBedFvGBpR6tBQIImBvixgEWfcTw==
X-Received: by 2002:ac8:7e8f:0:b0:52d:a151:10f5 with SMTP id
 d75a77b69052e-52e09ca57e5mr169643601cf.22.1787570416873; 
 Mon, 24 Aug 2026 04:20:16 -0700 (PDT)
X-Received: by 2002:ac8:7e8f:0:b0:52d:a151:10f5 with SMTP id
 d75a77b69052e-52e09ca57e5mr169643111cf.22.1787570416416; 
 Mon, 24 Aug 2026 04:20:16 -0700 (PDT)
Received: from localhost.localdomain (44.170.88.92.rev.sfr.net. [92.88.170.44])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b208sm1135772366b.10.2026.08.24.04.20.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Aug 2026 04:20:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 17/20] target/tricore: Document architectural interrupts as
 not implemented
Date: Mon, 24 Aug 2026 13:17:06 +0200
Message-ID: <20260824111711.26297-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824111711.26297-1-philmd@oss.qualcomm.com>
References: <20260824111711.26297-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=b4iCJNGx c=1 sm=1 tr=0 ts=6a8c28f2 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=s1NLoHz9uzatdv2VNqxUSg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Cu_OB6cER5A0ZMY7a4UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX4WEsxlu/2UWg
 UBc6wbtf5la6WanvlMpj+f+rfIreG+nqiYlkoYGYMoHUY7E6fqvRaJVh3oXkTFDokN8gCVRBmTP
 W0w5DxVxhkVi6NZW9q0sALGDer3dzNo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX/QfrGS78KySf
 CXpToSwZKBe41UeqF1i0tsVBpMno9S8VAiK2NUQxuq99OGDylRW2D9hi0tfdq0u448SegklEP5y
 pDGlaKjURNd9YmpDE5x5aPMUjxVGt0udyXApGwbdSZKbphA+GH9/ZGOJcRSODZiW9UQtSlGQ4IG
 bJ8a++pj5Qzu4aY9Uf1gJO5iS7wRwpvjI6z/W8XiaZWY43HyFiC8TzaHqaT/s9Bftt5viOOWell
 hZ6lS0nR2abKyHCwcxD1sQlsi0WOwPKTl+uOywOQXjJ0CdU0bGSX+YkbA6Q+Ovzrgu9+gLL/cd6
 FSWGz7+wFwqTX2n3J1R5dl0W413x7HTZ/wdfVG1LSeiYZAZ/1IwQsxJIGygvF6R3gqU3Q6loOVt
 hGsh3DF0ASg3zhCdLBix7GADM+Yxwd0wHA/jJeSQtJGpiivP0XLAXiK1fjKrkf4+pNq2dR8XIBe
 R9zLBU6CDeuOK01M0CA==
X-Proofpoint-ORIG-GUID: 3N1qdriinXs6VJT5ryuDS47eMrzZuPMS
X-Proofpoint-GUID: 3N1qdriinXs6VJT5ryuDS47eMrzZuPMS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240094
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

As mentioned in commit de680286b52 ("accel/tcg: Make
cpu_exec_interrupt hook mandatory"):

 > Tricore doesn't currently implement the architectural
 > interrupt handling.

Add a comment to help understanding why this SysemuCPUOps
has_work() handler is simply always returning %true.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 6d448727005..82b56c3cd56 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -113,6 +113,7 @@ static void tricore_cpu_reset_hold(Object *obj, ResetType type)
 
 static bool tricore_cpu_has_work(CPUState *cs)
 {
+    /* Interrupts are not implemented */
     return true;
 }
 
-- 
2.53.0


