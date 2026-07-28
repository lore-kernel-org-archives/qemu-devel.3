Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCC4C54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZjN-00016d-Gy; Tue, 28 Jul 2026 00:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjF-0000jp-9Z
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjD-00025G-PS
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:45 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3aW9q1303407
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kSGwiMRYDcRmg6ozYAQgmtSI9aq9HO9mUGyA7RaMKw0=; b=Dzmov+yW5BSHrhVJ
 H4R50DMABFG/UdOfy9WfkkdQ7vOVLT/rC3QWL3rikdFBY2wBnecm/d5XWUtr3aVq
 +Dh/lZOylN1/uw1m9P1Mu9giJhyhxYll1LBgBCosroSFmzpC9+Znus9KNuW1KLvA
 DV0TLDZR84PVWxXdyNRjWt5mAggk8l7fkJGjdI6vDIFbhsa4kmwjHW0n+Qgq90Pq
 6OQNiK6ZMMu/+z02kcAhtUYZcI3PwgJaZm+jvSOwmyv3Ps2jf+tG7qThKjVu6meS
 IpYVUw2VYjU7EqeK7VMGMunuWpnosdG4h+yQqwxTx7oYbX+MEPc7g4P1+HNr9APl
 pu/YEQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp8agaw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cfc52ddc55so46107355ad.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214062; x=1785818862; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kSGwiMRYDcRmg6ozYAQgmtSI9aq9HO9mUGyA7RaMKw0=;
 b=bilMiNSBFbbMISTKzvrZpFbkk+7FaMbhPimRb5C3qEZpsofXqYidDOjtly9XkJQhw5
 Wmbu04/5q+uJfVawsFOGVCcgW1gQmTiItNCn1KuD7r7rL+kD6ItbusSOPEX9Gfv7loym
 y67QwtJXUFI30FQLtJIiY+yBTE9KTtoNqHsVxjlPoDkvCMx0Q15XFEH2paqM+Ge9MIxe
 evxsBohu0mMW8kTswtDHyojV6RWUrX2CL1B2+9bEEX7ZOZycEcA5WM/l50uvLBDAH+Iz
 tYw/hV1uM0CEIg9yr6/enb5x3mvqKr0bXeEUsrCqQC4ZhSzKylEYOh+qXqgxIJ3nCoud
 7hRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214062; x=1785818862;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kSGwiMRYDcRmg6ozYAQgmtSI9aq9HO9mUGyA7RaMKw0=;
 b=hHVTFrE/a7cmpAFprlo96I2khOL9q/2tFw9n9f+TnGviD3Pxd+hjnD3w7rt4ve5SdC
 jGz9M/kXYRRWfqn/kwjQgPotq6ZtGs8AmIxhBoKofpeBDOuSn0TztyUh5cDFWqvj2WG3
 EpZNb/7l7Hz1iqb01vUTMonvuL7wrsgJL2yBakVnG9Kd+hfuA7C/8UaOkDyVdiyEBb7v
 M8ToyvHC9Iq82kYdDDPW7QzVaazHFUduVtOtXCnnp8yXUb3IztoHZzHL9kiC1SDUtrnd
 Ed6vgddk0N/f9NHNo6woWqSktDb48NstDh6kqpBkdg0yh1ovWJIId5hXERWXNAG9d05Q
 l6/Q==
X-Gm-Message-State: AOJu0Yz4Un0frWUHTmxLsEqdm5HPqkNTN3Vq++2nu86Bwoxk72lGl3v0
 sTiF5SERSmNmJuDPbYVfoOsIz48UGiEB0uHRfnJLNlvn6rxiicPsbYFvRTrhPRMEpi+Didhwpl3
 yzIXCzwOAeYtZxAUviY1/hV6B6I8QDBJAFRadGjwqGoeJFqyPlMDzVnYiecOqI7kDCA==
X-Gm-Gg: AR+sD13o6efxoDf/PESreW9FP/xx/1YOMZiGSQsRbo2g0FPtSRowtHU2SvHzKhaoW85
 U6Q2LusewD04M5LTnITmmfRsKwtxfIPWRc93hdHqnGJutEC3HsA6lPgP3ZH5i/csp5RrK91zMAK
 vArTemaUsPVeueSN/WSjxXGpVO2zM//6+7PjK6vfkWlBvsOfYfVZm36SwicCjgmOyAXe/dPXil2
 0GFzQnqGDZjSTVsL78U+Q7+Qa68sLGNydXcW0rKAG2JLwDMjbHqp+Mzbk/97QCsB76Y7l3yQMPA
 O7lQAGJwjdl5zf4uJBwchOF0NDD/Dq2oDYiPiTbuP0WALBbeEPKmtMVfbJ74TZRGe2M4RM4R4Um
 8MM85MnBJrYsT2UdZ+cSk2rOsZOXncfXnjioWXA4MI1DvkohjJrhf20UBgBUxe5rYWL5XTls=
X-Received: by 2002:a05:6a20:7f9c:b0:3bf:c28f:8afc with SMTP id
 adf61e73a8af0-3c89cad866fmr1170389637.0.1785214061521; 
 Mon, 27 Jul 2026 21:47:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:7f9c:b0:3bf:c28f:8afc with SMTP id
 adf61e73a8af0-3c89cad866fmr1170358637.0.1785214061102; 
 Mon, 27 Jul 2026 21:47:41 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:47:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 050/103] tests/tcg/multiarch/sha1.c: fix big endian
 implementation
Date: Mon, 27 Jul 2026 21:41:54 -0700
Message-ID: <20260728044248.137626-51-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfXwsgRTa8+StCu
 jOefqiPTOmY5BoHeDydVpOGiLuloFzEHxAo+RH8/kLo5XwBRnFmdI2cgl1+ThZ5VTZbKJysX6ox
 ZnpBqa1xFEsUSykiEkKsGpFxKVxqa0I=
X-Proofpoint-GUID: qG8Bg0m_k8L3xb87YG6YVYhNHFFMxevG
X-Proofpoint-ORIG-GUID: qG8Bg0m_k8L3xb87YG6YVYhNHFFMxevG
X-Authority-Analysis: v=2.4 cv=KLJqylFo c=1 sm=1 tr=0 ts=6a68346e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=0eg9nERfSt1gVPs494UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX3eeUmUJeup4Y
 0m+KHBLyRysvTwvo3r6gBPxOiLwMT2kRVjmBrECTdzZOE3Fx2vZNrx5/Wqplse7ArpkSvW0HNEG
 fVzHZqckTd5IipfMEdak/f3PegxGQFLAts77cqz6KcP+xc1y/a+aUL2rjhPF1A8gN92ff2a281A
 ZxFXE8DosXjd8kk/Elr90pADmUNAqHoyjyLc07IGR9yABh/HLlwi9O+otlINKxfN1jfKFHvjqxh
 NBy+fn8YJ2Zy1mBIPal8NPo8JMo/0IIhi9gYf6UNVvyi5sRKG/w8lPraasW+qLrmczNNxwqpetY
 VuRRZazMws2vo53EZA291vwxuQCc994hOvt3M/Lus2MhqKm46UK4k7Lrg8vazoOTR8eCiwseCS4
 WsEgR5soiaubJnLCautN07Scx/uOHZqXBIVvEkSYhzhRPFinLTInQrr895OFCh7OKiT7+2g8wq6
 J+gH8PWgXemN82LjOQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
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

All big endian targets were returning a wrong value due to this.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/sha1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/multiarch/sha1.c b/tests/tcg/multiarch/sha1.c
index 0081bd76577..6cebad2951d 100644
--- a/tests/tcg/multiarch/sha1.c
+++ b/tests/tcg/multiarch/sha1.c
@@ -48,10 +48,10 @@ void SHA1Final(unsigned char digest[20], SHA1_CTX* context);
 
 /* blk0() and blk() perform the initial expand. */
 /* I got the idea of expanding during the round function from SSLeay */
-#if BYTE_ORDER == LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define blk0(i) (block->l[i] = (rol(block->l[i],24)&0xFF00FF00) \
     |(rol(block->l[i],8)&0x00FF00FF))
-#elif BYTE_ORDER == BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 #define blk0(i) block->l[i]
 #else
 #error "Endianness not defined!"
-- 
2.47.3


