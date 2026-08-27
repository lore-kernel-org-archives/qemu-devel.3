Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CE8C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziG5-0007Wz-QG; Thu, 27 Aug 2026 18:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziG1-0007UT-Kj
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFz-0003bK-TZ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:37 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM25n3848558
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pina9xUkpaimkxo7Suy/F2+7P6bGM9KsfMCG/iYljXs=; b=p1Lm7c3zhVLiyi3r
 QsHglxK+1u1F5dCNj7Iouswhl6sZJg4kL6MPWR1X1CviOauXwoGp/J9emGN0v4ws
 iO/zv1woRfvUMLn1zGTKa3tcv9Ujjmcv1UfUxFYENKVZcSStxYU928+LOhwnJRZm
 nKHvW1pPRA9aBB9TWCc//1jYO+aklvz5G6DHIuYQyPZI36fi1nnXMB3CvmUWcbmr
 08W9GUQS3ObPGA7kni6hgWhQV6TVqxp0VcvvMFtX4gP5gnjZWZbti9ZqN6n9wXlX
 ObsE6V34UFtWhYZipJc97u4bdNN/odbDnXAe/SfO4CVTV9KhdM0ZZMH1H1g6Zeqy
 l+giFw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatnc0sxs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:34 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8535cdc2433so199143b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868454; x=1788473254; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pina9xUkpaimkxo7Suy/F2+7P6bGM9KsfMCG/iYljXs=;
 b=JRPILPVKY/m+i3EHVzXdAAaUAiqpYA7r3QoI22g537HZfn6JUwZ20zZQyGGEdp5VWU
 +nPcUaAbe2zvcDji1ZdQ/aTDx+yM8L9657ZRtkThuuM/2z8OhIMiZ1BZYlyXYxnjQl0r
 WPgwAsrNMgGW4nANU9ha2jW6G47RkarWfYadn4lwzBj449NBIFR2kLhsnczZLMLt9HRi
 ST5YMN8iAA9FCdbu4V82ekq3OBCYJs4/U210X52Wp7reI+Qi8J3xUcVMAfnVd7wv/MOW
 J8qxboXT0Izmb/imvJF3f5BOmBZ5EDXH2A2KLdEUNIdA79Nprs9DPEkoGmSEqhYvad1c
 AonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868454; x=1788473254;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pina9xUkpaimkxo7Suy/F2+7P6bGM9KsfMCG/iYljXs=;
 b=m3K8S8Cektnag2WW68ppit4DZOMZWUSoo+Xn0aT6ArGGoNxsrsWmWaCf/5ealCayd/
 XJSznQqKlxB6pUUIhJGIUDtbEp1KyJvTfaBYXJq0s1/La9Tg46Q5A5Qrk1AXSJ0S/FvT
 ly9fuLC4yp7wRIdi6IoKRmrOK82GA/VhBxyKU5KQG4qEpof6rmBJXN5ChSd3iT9j3Sfs
 OGEAwwH7QGe5sa1zgfiKOI9aSvPqq1Rajs10sl0ayV3BSwlTg04o0JArlQSLZfWIaXRq
 t1zmxQBEz58sItSN8pHa47aHiCbqwjG3FXM9bEG1IpU9//sutgIfZYN2aEesTkePHXoc
 ljKQ==
X-Gm-Message-State: AFuF++k3uIqGczuE5zLhopcVlAETpCGqGCmh+VfBhBg2vEJV2bswojuf
 7duPBU5PnZsfh+t8rqaEksSJnXP/uAm7ddWhJgPDHd56VUfUhUYGcIwS+mC2mgXb6ttw8E+goKL
 7aOOJ13+YSuZjIRmw12Kznwe8DYsboWBCOauIFgzWj3xnCZVLwwuxxiBOehvrAEhcjQ==
X-Gm-Gg: AR+sD13WVPZ0QH+Hf+P9Bl2HalgbZxwsJ39tytJg9VQL9fsogoMPz1CMgM761Ym8DhU
 bKk8Ot+papaeLp64e4c8pmMlB+Awty0lNaboFdpDimDBCd3R4UnSZEYKjmO0NKec2rBXmEGYVXb
 egbH6GKeA24C/xCB2WANR1c2C3Ie7pA6Y0rKVXuyrENpdHe9fP7zT0Lci7Q2WIlhwpYshGjA0/S
 qSazTs5a/6CoAO5cZIbb9bILz15rhrX3nw/jkz0CTGUzXTPFjOgWNj3+UdtNnxXoP49HR6GHbDg
 gH9ss0NmpzctRiYvu+XbQ20EFAOpemAUhNhWjd/q6Yiz6InVgB++VWrWACWC/SuBYI/j6QMgtxe
 xHTkfInWMhw0rmwPkAHCxLcraAa+K4T7XCm/Tb/UsUKJC8e6pdPwHZSasARc=
X-Received: by 2002:a05:6a00:1d89:b0:842:3c77:5996 with SMTP id
 d2e1a72fcca58-854c648573dmr13360391b3a.1.1787868453664; 
 Thu, 27 Aug 2026 15:07:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:1d89:b0:842:3c77:5996 with SMTP id
 d2e1a72fcca58-854c648573dmr13360321b3a.1.1787868453166; 
 Thu, 27 Aug 2026 15:07:33 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 033/105] tests/tcg/Makefile: skip user/system tests if
 target Makefile is not present
Date: Thu, 27 Aug 2026 22:05:27 +0000
Message-ID: <20260827220641.84885-34-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX72TsgVCJLYl3
 ggxcn1wSyV7HtUCzqITX2t+LZfXdwdRV7wwGPCsShp9EkIqROSFUGVQ/o8tbrydudN0P9BGHUl1
 NXqBinOmtkabAyYZOXBCN2JZmHr9Z4a0AcllhIIpYDUGkfRZwdRwUGighFpfVTF3xndaDHIdXAL
 8/A3RWNIgWD8I8OMHvShrmM9wlPAvMyFXBktVnveSGTKovCzzCqscYM5ovZokQxBNkyR0quyEAq
 1b0xeSpg7WAhC2Qke5WkpVdZ+c/Q/GsnSdyHQQQzyXk4isCjCEaN2SHRicoVaY88g10TrxeO2++
 ap3X9+wz/p0/p+aB899CzHn0ClkNgDr7qtCnfjmAlT8o3G5yHb/z8Qf1YUpr9tIR5G9xUV6JN3V
 14HPjG1ne3Zva0zZEtef0vrK8IGNg7exJSQ25yqtlHTKNFvTZjRNFHe4whwzIRr8myX2r+b+Yam
 vblOD0ojVXXdBI0eo6Q==
X-Proofpoint-ORIG-GUID: vEljRo8MSb3UNO6KtAY0sc7lbzMSHOLX
X-Authority-Analysis: v=2.4 cv=HfUkiCE8 c=1 sm=1 tr=0 ts=6a90b526 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=bQBZ4AfKrqIn4QZ8WyYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX5ZCGpIrZH5Oz
 utnY7nJtyDxhaPGBzsJF+AqYvFt+x/UeDIlnPeCLyj2qoVXEgJl03ZDzW1s+hE7myjoQU1n5r85
 cRcMn8qgBzvexzQ6D7yZM/z8jj5OqLs=
X-Proofpoint-GUID: vEljRo8MSb3UNO6KtAY0sc7lbzMSHOLX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

In the next commits, we'll port each architecture from Makefile to
meson, and it's easier to review those changes if we remove Makefiles
step by step.

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/Makefile.target | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 1b83824ff4e..836fccaca23 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -105,7 +105,9 @@ ifeq ($(filter %-softmmu, $(TARGET)),)
 # $(TARGET_NAME)/Makefile.target to include the common parent
 # architecture in its VPATH. However some targets are so minimal we
 # can't even build the multiarch tests.
-ifneq ($(filter $(TARGET_NAME),aarch64_be),)
+ifeq ($(wildcard $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target),)
+# skip user tests if Makefile.target is not present
+else ifneq ($(filter $(TARGET_NAME),aarch64_be),)
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
 else
 -include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
@@ -135,7 +137,11 @@ ifneq ($(filter $(TARGET_NAME),$(MULTIARCH_SOFTMMU_TARGETS)),)
 -include $(SRC_PATH)/tests/tcg/minilib/Makefile.target
 -include $(SRC_PATH)/tests/tcg/multiarch/system/Makefile.softmmu-target
 endif
+ifeq ($(wildcard $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target),)
+# skip system tests if Makefile.target is not present
+else
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target
+endif
 
 endif
 
-- 
2.43.0


