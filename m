Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621B9CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfK1-0000CS-BK; Tue, 29 Sep 2026 17:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfJz-00009i-0M
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfJx-0003fr-CZ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:06 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TI3caX1724319
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cfmxbAG15jvpfT29doLpiwAO6RaFBAa3zrjbhRNPCXA=; b=NJq2KK+z34+Gh56V
 IBvHpnvBhkA4fDxWyG8ktFD6J4c7VnRYXW3NgcASpodPszRlWOzh2Xin4wNq5CGU
 vt504P2Mp/hSJ+KPdM+j0lIjcI5LPdA036tVG4GdDPUnOGECKCtIZVsTSmpRA8Al
 t6Ks7x+ob9+tfwC+JFiKCJ9Ik4K8LYcUjyPND3B3uTGw7eKboSk5Ov/dupCpXgor
 UNg2Q6pTFFh+xq9Zq/qIx/9D06BFNJXydceEcY7c+PVEAGIV2V7JyMVSKVLsr071
 oa9oHhCqwT4BYlj8NYSUiD87mzrk4+lKGO4NUgMR2E888086ygRzjHjLspsdoRZo
 ndipVg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0j97rrja-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:04 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34bbf2e3c5cso2805837eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717103; x=1791321903; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cfmxbAG15jvpfT29doLpiwAO6RaFBAa3zrjbhRNPCXA=;
 b=NWArtkGfnMHORGwQkXJDWT4NCGhqQlL3LRDHGJni70KkzydZp9DifzhVULryyNchzp
 ynholIkxzadqxvrBgthzLF6TFjtOz5qvY3tij1X1/wkvtQTo24aVFFMu4eEjEuaKxnCE
 ubYeZPbj0aa4zzqbczK0KzPdUHDKhWDKxSrbIzEXW1IIslKgf8N1kmknBEuAdwCvP6Yq
 OE7HB32U1JrdmpvkPkL4d5jOBP9ehXIg77X/t/9Cbv8bZSqz+PlwWr7yW95Y8ZNQH8eG
 LBt6Kj81hRM3GkSRNsqAxh+gfuYNyyj719abtgxA/+BsqfVm74fhP9INsDktrkPaao3F
 SxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717103; x=1791321903;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cfmxbAG15jvpfT29doLpiwAO6RaFBAa3zrjbhRNPCXA=;
 b=w6YsYlWTNvaGeIeZX3hfdpQwNV8naYrnNA78bgp6NA43z7oyXs/tDoaWj0LoEnz4s4
 8pFaM3qnUutiQCRydLj26c+qlUpFs8L8a7mGodmxku1vIqjKd6Tf5plBdlmKSYj6Y0NH
 106NmSLEwDYaxq9wTcWwgMClJ2cmNIZ0vOWgCCfEX6E7Zm6rpwRIG3ncl3Oc5ttf9V8p
 yKXu5x98XIo7o2o43GBwzF96cSQopsf0kKtmV7jEroPN9xke8gsZGcEaFzYLSVULO8WV
 0S1nADyU5DAG+g2y1GG3dUV8rgdxA9CtNs2B314eEweKOW5RqXKEd/4KnheAxc4JuTOr
 +Kkw==
X-Gm-Message-State: AFq9FYIsenyBvMC+uLDe6IfEEmzKUqVtFimVW01KgmTW694PWMM+noL9
 msA7QjvrN9A1oHxulMrb25hOdRJBpquiYxJ/B4fiizEQuUctiewTkyduU3jGxTDNFC3ODISQGkV
 c5W4B1o3fKb+NhfUJg83Y1WH75NM91G49w2ncIEmuFVu2AEUETlXDeVe4+fTpx+2ZoQ==
X-Gm-Gg: AYBFou1iuGQcwSLRiIEdxmwAYwfEAhQbTfHowcGk0AGP49qRzCQY+qo8Y3fzPnRUiwo
 Wb+iVTjO6BT0Vubbo3duUCs2fJIrAZ3Rq8N1U2gWyl+0cJ6LZwZ0OBSBBOVBpgv6ct4h3bvoxVU
 MEe5vxUettmnYJhbrX3f3x46UVCpcfIKbwpR7CXMji2/MoO2nCwEFcntkI/xNOv0NaSx3ohl5TA
 8YnaRqvMULKHEkaWA/5AB+rsF1tfGHi7JDOxV0IYMqeof8hKcrrJ25+9osOQR+e5emOAJNrgRxT
 Bs67eiHdMRtfI4OiXX+Zx31vFjSzz4rcpDdoIQ0X+bKgY6dptvAcYx+VV6lWB8Ti8mjDLrXxrMS
 spOuw/dJJ/XBCkX+EOd+XrKu7YBtJUYsz/k9Y+EWyu7kpfQsJPBDU2YoYC9a/
X-Received: by 2002:a05:7301:4301:b0:34c:853b:fe76 with SMTP id
 5a478bee46e88-34c853c01eamr298273eec.32.1790717103256; 
 Tue, 29 Sep 2026 14:25:03 -0700 (PDT)
X-Received: by 2002:a05:7301:4301:b0:34c:853b:fe76 with SMTP id
 5a478bee46e88-34c853c01eamr298239eec.32.1790717102616; 
 Tue, 29 Sep 2026 14:25:02 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:25:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 07/24] tests/tcg/mips/user/isa/r5900: add README
Date: Tue, 29 Sep 2026 21:24:22 +0000
Message-ID: <20260929212439.110454-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: E4imJ4U-q-aDPs2oaU4W1aFD7UcCPgFm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX1yM8fPBzWgEl
 7prIjdPZpOLHZ/tzs7X8Uk1UvFSkBkpXd2sSDbbGSPugZ/xs7EjfAggD1ElK11bIjCY16qkjwyJ
 jGscksmTG7TcZXLT94ehvsWNkh/qxHm9PDTyaNiyq/0WLAKg2f087iCCI+q2u3PDkEJ/3HT30Ve
 LrCbwhxTJvAoIjIjNbQOHxgNyY/7KVlyVHYVR8HY5wS3cfhlEYorw9eksr7QCWZqopkvmBiVxmd
 8zREZPcqPKvIsJZiaJPz7PjMbwViKcJJ6vFDTuUpbAQxF+3f6wkCI80QUP04tIIyfjlwCGNg5PB
 ksMj8woq9Ytx9oKmFJnpM9s2SaxUZoJI3DCyQ1pYOReobrY0hdGDJPymwuYR+7F1yGyKRb1Caxg
 3n+GSUoL6eB3ourGayoDJJmWHlMl1MbmE+iFsGRi0jiSwM6+VepQzHGB8aFychOiMJ7LL4k3e77
 t+cNPRmEEsN8lERDIvw==
X-Proofpoint-ORIG-GUID: E4imJ4U-q-aDPs2oaU4W1aFD7UcCPgFm
X-Authority-Analysis: v=2.4 cv=BPImP1QG c=1 sm=1 tr=0 ts=6abc2cb0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ybKMF2EBzz_YHPg-y3kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX3bXdZUAfKCza
 AGPJseV4JqcBnrguXfGNqDVnrr+iccx411zjQDeEm8xRE9JWALK+K29GVbIN5HVXsY9u5QMtA28
 Kfj2xEtL/xUwS9fDNJinZ1YVEz56VfU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290085
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

Those tests are dead code at the moment. We can keep them around here,
but at least let's document what it is and why we can't run them.

Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/user/isa/r5900/README | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 tests/tcg/mips/user/isa/r5900/README

diff --git a/tests/tcg/mips/user/isa/r5900/README b/tests/tcg/mips/user/isa/r5900/README
new file mode 100644
index 00000000000..18ecfc3bd0a
--- /dev/null
+++ b/tests/tcg/mips/user/isa/r5900/README
@@ -0,0 +1,6 @@
+This test suite can't be run at the moment. We don't have a qemu target for this
+architecture, which has single-float arithmetic, and custom 128-bit registers.
+Also, a specific toolchain has to be compiled for it.
+
+We keep the tests here in case someone is interested one day to resurrect this
+architecture.
-- 
2.43.0


