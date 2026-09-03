Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE59C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24x7-0004dA-Dy; Thu, 03 Sep 2026 06:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24x4-0004XE-RI
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:45:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24x3-0007WK-39
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:45:50 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHE3g440333
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BTy2XS91RzmD8oGboMvqcXBcmA2Uon8RInC8cmD3rjo=; b=PFqULDYi8ydWtBhN
 Edy+hm31djS6NL3gxlD/K6MV5mI7BznNzyeGCae/GJN5B09N/QOn8UvpOosE+Ze4
 ULPcteMt71InB1xJja7B/stjRs7FPn97b7EFS3O469wJcL46c9g+WDVMGDJuBe2X
 uqXTpvzatGhOvr84uZxqtNDQ5sak+iePVCT2KPji7jE4Jp/8/KefXYTvgHGjXN6W
 byXKxJTfW7cqyEEfT4x26SimO0pBCwcQ7T7Cyhb0S8l3LsW9VLR6Xaewp4bvXliv
 4h0WDBIIApdg029T72vU5B/Z/7F/OPtZsS1axkuSbSzCOAZMQj4lDGb7kWXPqoUt
 zrBEjw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6p706ex-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:45:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-939062ecda9so326263185a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432347; x=1789037147; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BTy2XS91RzmD8oGboMvqcXBcmA2Uon8RInC8cmD3rjo=;
 b=jBRqmXcW//5pIVbWvuFzi5FYGd3gJoMVRs+qEQ8qcPCiTol2QqBA6pxk4i4tN28QvJ
 RJy7LKHq2tINeYCuq3Ee5JXNcu0nEbMv+TtYp2kHRRu55/6BDrfB9qihQ+s3AMjbN1ru
 xE1O0mrCxw/vWAvY81byVm5l3aXcpipeVYSupLbj9WXP1ik2Cl4W3p2rDdyPe8br5Z1h
 58B3LxIsmFHA3xTTwDzoqXVUD8bGo1HZAGG0taqUpRWCHC3LJAcWmajllvJDoiM5cRtA
 dqFDxvr0J1YVtLMBTBexjIKa9+VZXYsvaKKRxIge7U0Fia4J3t+g5xx1GPl2Q0OdBnsK
 Qe0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432347; x=1789037147;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BTy2XS91RzmD8oGboMvqcXBcmA2Uon8RInC8cmD3rjo=;
 b=lUkI/6kV0d9pEATi21cTlO0mkM4J+wjvoyPSdk/8aISP5PS0gNru2lZ26VJI69g9Mg
 3QAq9VCOIJ7zSPdQsJIFGE/xwp6v96RAVOpWuaABV/nuuqStENA/nnLEITmG8AWPm5ap
 thtYZqChW2UZhfnAN9JRGWHoNHkdckDDNUlsxuavY+ogXn9pDUfeZ5+ehHgwmgyTbpeC
 KxdShFjxNWAwpMYvompND7uxc970Lvp15Ooh+dhw3vG2d0zLUVReeZy9Y7FbATley9pM
 iCxAP+YkCChY+MyyXqq5XJJHTTPHmkRIsa5lR/CA5pXQWezVXf78+pHEh5MCj9GQDiCK
 eSqw==
X-Gm-Message-State: AFuF++kjcBSzPnGTvpb5TauGTpItP93La66B5WEZcz3pAGrtdQKdj2SQ
 hkVgXCBr7Rl3zWmjkggKculBf12x/JdShryB0q+vcWf+maIAMYGUlsiWMvX125K0TWRf0HNxRvJ
 jjCNzwAwtb83BVhMmSnx4Yx3X1uYhP3eoouCE4Ag+gjSFAw9e5MO2yttUFiAEmx3fbg==
X-Gm-Gg: AYBFou2JQ7c7MEofI0lghUCImcnDvpwqqJy4F+sgLlmJr93BBz20ou+yA5/KQon9GYs
 Iw3sOb6qitprt5MUD7krxNpYlSg1eQa0fw0S+WpmTnhZ5IH094uFlEMnMV/wh7HRf6Uo6AYgDUn
 XBTjO6JPfV8PkFDsos8IbiNZMj5pEFNFNHiDMUTQt1DV9WsxBSPaoontY/Nrva71qxckPFAZrCf
 JjD5YwYIN6luRB4N5tz8bg9QW8CsAIvw7LDHvRZhcsrBQlHtn1CruJJ9fTKONAeaKXVCt2ZulFF
 c08VQ4FonKXvbdFjaw1NFEchbfCplwFuCVNgDSoBHnT7Qc5cWjzFx6Ccs0ZaH0jwAZ/nNwzs0+u
 9lhjKMZJIdkENchl3nMACiti4cBm+OGzPOKy94Y93
X-Received: by 2002:a05:620a:5bd3:b0:939:6de7:a623 with SMTP id
 af79cd13be357-9396de7ccf2mr484247985a.47.1788432347212; 
 Thu, 03 Sep 2026 03:45:47 -0700 (PDT)
X-Received: by 2002:a05:620a:5bd3:b0:939:6de7:a623 with SMTP id
 af79cd13be357-9396de7ccf2mr484244985a.47.1788432346797; 
 Thu, 03 Sep 2026 03:45:46 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e80388sm14545394f8f.14.2026.09.03.03.45.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:45:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 49/51] system: improve -mon deprecation warning
Date: Thu,  3 Sep 2026 12:39:33 +0200
Message-ID: <20260903103936.62355-50-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: quX5xPwZ5EXHgtabsw2yLnc6VaRUcXQC
X-Proofpoint-ORIG-GUID: quX5xPwZ5EXHgtabsw2yLnc6VaRUcXQC
X-Authority-Analysis: v=2.4 cv=OZyoyBTY c=1 sm=1 tr=0 ts=6a994fdb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=ID6ng7r3AAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=9lCKVJmnSQc2mt-fxsIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=AkheI1RvQwOzcTXhi5f4:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX/givwNgvYHch
 9oiRmg7+EmpPynZnf9bz3Ve6RKIitZDx0XKs0ruw8+IG2pYflkljadJ07O91ItRNgR3Fhkz/TW1
 q8idLLUs+SG+DnYWneIhsP2KUhN/yw4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXzzaqHABy37KY
 wVPrINh90MMRAYfCrQnPYWrtA1nvrqrrgUGQN0rPOp59sez5HpeAmIcwraGByiNqW9tgJjObnGY
 2mBQQa2CtoE2lUSl618NUXrWzSFLF3e5YA0UZVoqOBTw2tA+KGTMrUDBQSyFnkGh93iE3y+Oohe
 xIlGOQc8BTd/Ok+lWb/KLJLWuWfUo2W7ZLVBAG+26748+v+H2ch8rDozZXfmEvenM8SWq76yzWW
 mb84T5Ry9n6Q0vq5INOouK0+oFQBBo6JYAAwex303wZamc5PB6Dob6wefzPqHdQIhZf+6jVBirT
 tistXNXsHjCWsqgsFDXa5/3vgnri1S13YBZGPi/n5xS2kM/TBpCauaFnOF+mMBgacIG8i7alGrD
 IPeBbUHqOaxzKJFkEWu72CdvZZ/ckLjwuMcs9vVPE6W/GcW3+pIsa8HDvPQk9O4Kpqizn2kSFUM
 bGu2319pWDQlOYE91SA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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

From: Daniel P. Berrangé <berrange@redhat.com>

Expand the text a bit to make the new syntax more explicit and point
users to the man page for further info.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260902104753.1756783-1-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 system/vl.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 1b22a358d23..9bd7664b85c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3238,8 +3238,13 @@ void qemu_init(int argc, char **argv)
                 default_monitor = 0;
                 break;
             case QEMU_OPTION_mon:
-                warn_report_once("'-mon' is deprecated, use '-object' with "
-                                 "'monitor-hmp' or 'monitor-qmp' types instead");
+                warn_report_once(
+                    "'-mon' is deprecated. Switch to either "
+                    "'-object monitor-hmp,id=ID,chardev=CHR-ID' or "
+                    "'-object monitor-qmp,id=ID,chardev=CHR-ID' instead. "
+                    "See '-object' docs in the QEMU manual for further "
+                    "configuration guidance: "
+                    "https://www.qemu.org/docs/master/system/invocation.html");
                 if (!qemu_opts_parse_noisily(qemu_find_opts("mon"), optarg,
                                              true)) {
                     exit(1);
-- 
2.53.0


