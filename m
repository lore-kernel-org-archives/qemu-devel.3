Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98EAC44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAMT-00067R-5A; Tue, 07 Jul 2026 14:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAME-0005Yi-Et
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:17:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAMA-0006UO-4P
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:17:22 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FT51t4130520
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tjc1xg0RdmsvnqFSf2gsvMOceuIFqG+R6km1aQS+0aM=; b=K+RnTeuR+xq9gq3w
 ppjyaE+Mqmt4DSO8mQH1gifCbKUQZr4JnL+jOoTknG3hkmN1XNsuXOyU0dWXhkUT
 T7gDbZA4SXFSGPls3arOfAP/mpTufJ57/hu6TxbJOPSxrw1bdcWjUBLbxlUtLFH/
 zImqtlSOxhCTx4c/Bq66M0MGbRBRIzjb4y0wemdwEW5Grh5LMclm5ugJ8yQH7Py5
 yKH1xuoXc3VKAQ7O5+leZSVGDCb6ZNrMwO01j9zVTkcSiNCVIlR9YNInFvh/xNuP
 gr1Lc4MTuU3ycJI40YVztaQgEld5rcntngQEDWzRdvqcrN6AIkgM5MHTvOd082AW
 LbTPNQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8t15bhqv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:17:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915d3261c5cso417918385a.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448236; x=1784053036; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tjc1xg0RdmsvnqFSf2gsvMOceuIFqG+R6km1aQS+0aM=;
 b=iwOiyLlKI7cOtOU3nvN2knDYlhH9XDam5jCWNf5plUcOceN+eI05zNDrXjBXMH4xlV
 WRD+pOeVKTcqiPJC8MvJoobVsIiPUt6YukgWVp4qBwCYJmbMwiKOvZwQuapQSZtWLjrd
 nSIU6lyIi0Rbi5fH+VxZ6QXccnTyMYXR1k7NkYLJaBiJnhBoZocMhroRezeiB6gIpgo0
 VjqMf7fIpGIXLRlP4lfQO4pWJIakweSUfvHu7jNcfKdpv11l4XtE3tcHY9eNXPzahUDL
 36C58WYYpn7GJudfhY21cxwImJDH/kvzZ6cvdrA5AUGgcUr7s6N9NrX476356wFAzRp/
 zKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448236; x=1784053036;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tjc1xg0RdmsvnqFSf2gsvMOceuIFqG+R6km1aQS+0aM=;
 b=NelHuOqc39xjCTgIGMOncd9VG7RcmwyazOCM/X1l0Nu/zk5ce4A0RQHYT3ll9WuUwX
 K+1JcVhg1imuXWSuNErv6iVNTNroUv1u2x/326VwZulyKZ/IqaTAtZlcWvSx/Z+GMhZ1
 nCf3bc/1qf7B+w7sxpnRxjB4mHeah+vOIc1M2BioGHXbYSmxDWHPxLXU5U0z+2EN93ms
 C4N2rstxTmSrIm8sJx6P65gq3FsJhn2coJjCrSsskJblMkiOUGypaP3q4qG7p+/SPgoQ
 KC+3x/d9rHQc9giUM1iqL0W4OUqxmGcjZTbEMMLsmN0GPik5HZeJz7A2d+dUN9+UIJXF
 aa0A==
X-Gm-Message-State: AOJu0YyjGWNzQaJcE8v2adZFcceN9CmyJNbDOjd1bzoO6TC0O1DYfd0I
 eohRLTf9MGqMgiog1U9TspW57Wdb7BT41YgJoVFBYZ37TIyDsVGVJwQZ4Is8U4rlaVDwk/wDvZc
 txFz/JJNXoRXVuwgDCunzGaEivD0/9GvbHeibBjVKp/pLPyGRCfthC3dibVJy2myevw==
X-Gm-Gg: AfdE7clTtzHNkOpufKM+0pGWUOtYdbbAMEdOl/yk3KRg2/Tiuu9SpEPTkSALE9WSybl
 oVCkrDi4rqxveirZSjSpdNKJXTCI98MamwDrvxjU9q3qmKeh/h8NnDQJN8eAsWuOczWHLZZEWVn
 7DFU0uT4hRsY7Kgxjyh5Ked1eparpfHm27VN/68dOFSMYDWT4EkjSSUfZ2NbQ82640y9FRJYLXC
 A/u1A3QibYT406fipKI1tKJYVPrvl2osHqk1lyAmZBGMFJwLlVBBD3WlHRPrEDYvcbENU2lTKKp
 bn+miBPtJsPYIdq/W9mkoxyvBlEMq0js9OLt4Hh5ugImo5lADtiqX5ISWjUOW2Meq3WZys+V67g
 osc4oo/oWmW8saIOnDhDtbRmxe1OuBC3QHYFEEZODSHY87m8ygkZczJazdf9dL1EZqEUJ
X-Received: by 2002:a05:622a:2449:b0:51b:f640:2a4f with SMTP id
 d75a77b69052e-51c74776de2mr69913321cf.4.1783448230568; 
 Tue, 07 Jul 2026 11:17:10 -0700 (PDT)
X-Received: by 2002:a05:622a:2449:b0:51b:f640:2a4f with SMTP id
 d75a77b69052e-51c74776de2mr69912651cf.4.1783448229798; 
 Tue, 07 Jul 2026 11:17:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e3e2702sm36521634f8f.9.2026.07.07.11.17.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:17:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/23] target/mips: decode Octeon COP2 register selectors
Date: Tue,  7 Jul 2026 20:15:19 +0200
Message-ID: <20260707181529.60191-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gqWzDKW0S5D-7jJ4KHhdBzFa-RB06jGr
X-Authority-Analysis: v=2.4 cv=HstG3UTS c=1 sm=1 tr=0 ts=6a4d42ac cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=twb9M56xMN4JJA-i2tUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: gqWzDKW0S5D-7jJ4KHhdBzFa-RB06jGr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX/heY/e3Acg1M
 LT6QZ3bD6/pm25h9Ihq+UrKgK9og8dKv7XXYFgq32qIqKcp51jTS1hLi7geo6tvb0gWV07PjqCt
 VLD46fY2IIoKgKb8CCs38slmwi3sgh4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX4lxxBRQ1xq0K
 TyZciKhLoVz9gEHW+bduwDeafFV1GIZPrHEltaNXA+aSr+9j/GXOZl4ogWH1tpq7oMZ3y18Llri
 IYrYsqR1n2xoH7hYA54sjCRVZeXGY02jnLo8vYRcQyHMSJZscJXEnoNAeREA9UQ2qD+cVXCerG3
 fdnftHHpa9QOQbd78pDHgh4HtFDo+zpEGmdADi1mjFmLsgeyedOCJLz3ZuXfJK9y4ij4Qb2+IZK
 mROTqh8NVYiQjE743I9w/Y2UK/+Kofr3WUptkgf9koE8eTJ26isnSHE/DkkuHKrgent9sp35uRg
 rliiYud+Ht/8uEt99XA649JtcMMSIR75+7641HayBsHyCY1OJJkEZJ3TKA62j+ZxOyw7YlVjdkj
 Y5HtxEk5MWnMWVzJsZpcgAghILIkZjNn8HlDcilD0mPf0vN0RYBn8h7sqGVd3uQ2YThcG4AIL2i
 zWCf7zOJOKJ8IoXjB/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070179
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

From: James Hilliard <james.hilliard1@gmail.com>

Add explicit decodetree entries and translator bindings for Octeon
DMFC2/DMTC2 selectors that are simple COP2 register transfers.

Emit direct TCG loads and stores for register moves. Use signed 32-bit
loads for 32-bit DMFC2 readback and mask narrow writable fields such as
AESKEYLEN and CRCLEN on DMTC2.

Keep operation selectors with side effects in later functional decode
patches.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-14-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/octeon.decode                 |  80 +++++++
 target/mips/tcg/octeon_translate.c            | 210 ++++++++++++++++++
 tests/tcg/mips/user/isa/octeon/octeon-insns.c |  89 ++++++++
 3 files changed, 379 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 1e44c588dd6..09fbc6c1e34 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -97,3 +97,83 @@ LBUX         011111 ..... ..... ..... 00110 001010 @lx
 LWUX         011111 ..... ..... ..... 10000 001010 @lx
 LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
+
+# Selector-driven DMFC2/DMTC2 interfaces for Octeon COP2 engines.
+&cp2          rt
+{
+  [
+    CVM_MF_HSH_IV0                       010010 00001 rt:5 0000 0000 0100 1000 &cp2
+    CVM_MF_HSH_IV1                       010010 00001 rt:5 0000 0000 0100 1001 &cp2
+    CVM_MF_HSH_IV2                       010010 00001 rt:5 0000 0000 0100 1010 &cp2
+    CVM_MF_HSH_IV3                       010010 00001 rt:5 0000 0000 0100 1011 &cp2
+    CVM_MF_HSH_DAT0                      010010 00001 rt:5 0000 0000 0100 0000 &cp2
+    CVM_MF_HSH_DAT1                      010010 00001 rt:5 0000 0000 0100 0001 &cp2
+    CVM_MF_HSH_DAT2                      010010 00001 rt:5 0000 0000 0100 0010 &cp2
+    CVM_MF_HSH_DAT3                      010010 00001 rt:5 0000 0000 0100 0011 &cp2
+    CVM_MF_HSH_DAT4                      010010 00001 rt:5 0000 0000 0100 0100 &cp2
+    CVM_MF_HSH_DAT5                      010010 00001 rt:5 0000 0000 0100 0101 &cp2
+    CVM_MF_HSH_DAT6                      010010 00001 rt:5 0000 0000 0100 0110 &cp2
+    CVM_MF_3DES_KEY0                     010010 00001 rt:5 0000 0000 1000 0000 &cp2
+    CVM_MF_3DES_KEY1                     010010 00001 rt:5 0000 0000 1000 0001 &cp2
+    CVM_MF_3DES_KEY2                     010010 00001 rt:5 0000 0000 1000 0010 &cp2
+    CVM_MF_3DES_IV                       010010 00001 rt:5 0000 0000 1000 0100 &cp2
+    CVM_MF_3DES_RESULT                   010010 00001 rt:5 0000 0000 1000 1000 &cp2
+    CVM_MF_KAS_RESULT                    010010 00001 rt:5 0000 0000 1001 1000 &cp2
+    CVM_MF_AES_RESINP0                   010010 00001 rt:5 0000 0001 0000 0000 &cp2
+    CVM_MF_AES_RESINP1                   010010 00001 rt:5 0000 0001 0000 0001 &cp2
+    CVM_MF_AES_IV0                       010010 00001 rt:5 0000 0001 0000 0010 &cp2
+    CVM_MF_AES_IV1                       010010 00001 rt:5 0000 0001 0000 0011 &cp2
+    CVM_MF_AES_KEY0                      010010 00001 rt:5 0000 0001 0000 0100 &cp2
+    CVM_MF_AES_KEY1                      010010 00001 rt:5 0000 0001 0000 0101 &cp2
+    CVM_MF_AES_KEY2                      010010 00001 rt:5 0000 0001 0000 0110 &cp2
+    CVM_MF_AES_KEY3                      010010 00001 rt:5 0000 0001 0000 0111 &cp2
+    CVM_MF_AES_KEYLENGTH                 010010 00001 rt:5 0000 0001 0001 0000 &cp2
+    CVM_MF_AES_INP0                      010010 00001 rt:5 0000 0001 0001 0001 &cp2
+    CVM_MF_CRC_POLYNOMIAL                010010 00001 rt:5 0000 0010 0000 0000 &cp2
+    CVM_MF_CRC_IV                        010010 00001 rt:5 0000 0010 0000 0001 &cp2
+    CVM_MF_CRC_LEN                       010010 00001 rt:5 0000 0010 0000 0010 &cp2
+    CVM_MF_GFM_MUL0                      010010 00001 rt:5 0000 0010 0101 1000 &cp2
+    CVM_MF_GFM_MUL1                      010010 00001 rt:5 0000 0010 0101 1001 &cp2
+    CVM_MF_GFM_RESINP0                   010010 00001 rt:5 0000 0010 0101 1010 &cp2
+    CVM_MF_GFM_RESINP1                   010010 00001 rt:5 0000 0010 0101 1011 &cp2
+    CVM_MF_GFM_POLY                      010010 00001 rt:5 0000 0010 0101 1110 &cp2
+    CVM_MT_HSH_DAT0                      010010 00101 rt:5 0000 0000 0100 0000 &cp2
+    CVM_MT_HSH_DAT1                      010010 00101 rt:5 0000 0000 0100 0001 &cp2
+    CVM_MT_HSH_DAT2                      010010 00101 rt:5 0000 0000 0100 0010 &cp2
+    CVM_MT_HSH_DAT3                      010010 00101 rt:5 0000 0000 0100 0011 &cp2
+    CVM_MT_HSH_DAT4                      010010 00101 rt:5 0000 0000 0100 0100 &cp2
+    CVM_MT_HSH_DAT5                      010010 00101 rt:5 0000 0000 0100 0101 &cp2
+    CVM_MT_HSH_DAT6                      010010 00101 rt:5 0000 0000 0100 0110 &cp2
+    CVM_MT_HSH_IV0                       010010 00101 rt:5 0000 0000 0100 1000 &cp2
+    CVM_MT_HSH_IV1                       010010 00101 rt:5 0000 0000 0100 1001 &cp2
+    CVM_MT_HSH_IV2                       010010 00101 rt:5 0000 0000 0100 1010 &cp2
+    CVM_MT_HSH_IV3                       010010 00101 rt:5 0000 0000 0100 1011 &cp2
+    CVM_MT_3DES_KEY0                     010010 00101 rt:5 0000 0000 1000 0000 &cp2
+    CVM_MT_3DES_KEY1                     010010 00101 rt:5 0000 0000 1000 0001 &cp2
+    CVM_MT_3DES_KEY2                     010010 00101 rt:5 0000 0000 1000 0010 &cp2
+    CVM_MT_3DES_IV                       010010 00101 rt:5 0000 0000 1000 0100 &cp2
+    CVM_MT_3DES_RESULT                   010010 00101 rt:5 0000 0000 1001 1000 &cp2
+    CVM_MT_AES_RESINP0                   010010 00101 rt:5 0000 0001 0000 0000 &cp2
+    CVM_MT_AES_RESINP1                   010010 00101 rt:5 0000 0001 0000 0001 &cp2
+    CVM_MT_AES_IV0                       010010 00101 rt:5 0000 0001 0000 0010 &cp2
+    CVM_MT_AES_IV1                       010010 00101 rt:5 0000 0001 0000 0011 &cp2
+    CVM_MT_AES_KEY0                      010010 00101 rt:5 0000 0001 0000 0100 &cp2
+    CVM_MT_AES_KEY1                      010010 00101 rt:5 0000 0001 0000 0101 &cp2
+    CVM_MT_AES_KEY2                      010010 00101 rt:5 0000 0001 0000 0110 &cp2
+    CVM_MT_AES_KEY3                      010010 00101 rt:5 0000 0001 0000 0111 &cp2
+    CVM_MT_AES_ENC_CBC0                  010010 00101 rt:5 0000 0001 0000 1000 &cp2
+    CVM_MT_AES_ENC0                      010010 00101 rt:5 0000 0001 0000 1010 &cp2
+    CVM_MT_AES_DEC_CBC0                  010010 00101 rt:5 0000 0001 0000 1100 &cp2
+    CVM_MT_AES_DEC0                      010010 00101 rt:5 0000 0001 0000 1110 &cp2
+    CVM_MT_AES_KEYLENGTH                 010010 00101 rt:5 0000 0001 0001 0000 &cp2
+    CVM_MT_CRC_IV                        010010 00101 rt:5 0000 0010 0000 0001 &cp2
+    CVM_MT_GFM_MUL0                      010010 00101 rt:5 0000 0010 0101 1000 &cp2
+    CVM_MT_GFM_MUL1                      010010 00101 rt:5 0000 0010 0101 1001 &cp2
+    CVM_MT_GFM_RESINP0                   010010 00101 rt:5 0000 0010 0101 1010 &cp2
+    CVM_MT_GFM_RESINP1                   010010 00101 rt:5 0000 0010 0101 1011 &cp2
+    CVM_MT_GFM_POLY                      010010 00101 rt:5 0000 0010 0101 1110 &cp2
+    CVM_MT_CRC_LEN                       010010 00101 rt:5 0001 0010 0000 0010 &cp2
+    CVM_MT_CRC_POLYNOMIAL                010010 00101 rt:5 0100 0010 0000 0000 &cp2
+  ]
+  CP2_Undef                              010010 ----- ----- ---- ---- ---- ----
+}
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index b0af2f48382..b33252dd1f8 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -13,6 +13,216 @@
 /* Include the auto-generated decoder.  */
 #include "decode-octeon.c.inc"
 
+#define OCTEON_CRYPTO_OFFSET(FIELD) \
+    offsetof(CPUMIPSState, octeon_crypto.FIELD)
+
+#define CP2_MF_I64(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mf_i64, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MF_S32(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mf_s32, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MF_U16(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mf_u16, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MF_U8(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mf_u8, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MF_HSH_PAIR(NAME, FIELD, INDEX) \
+    TRANS(NAME, trans_octeon_cp2_mf_hsh_pair, \
+          OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX)]), \
+          OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX) + 1]))
+#define CP2_MT_I64(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_i64, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MT_U32(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_u32, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MT_U16(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_u16, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MT_U8_MASKED(NAME, FIELD, MASK) \
+    TRANS(NAME, trans_octeon_cp2_mt_u8_masked, \
+          OCTEON_CRYPTO_OFFSET(FIELD), MASK)
+#define CP2_MT_HSH_PAIR(NAME, FIELD, INDEX) \
+    TRANS(NAME, trans_octeon_cp2_mt_hsh_pair, \
+          OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX)]), \
+          OCTEON_CRYPTO_OFFSET(FIELD[2 * (INDEX) + 1]))
+
+#define OCTEON_LO32_OFFSET (HOST_BIG_ENDIAN ? 4 : 0)
+
+static bool trans_CP2_Undef(DisasContext *ctx, arg_CP2_Undef *a)
+{
+    generate_exception_err(ctx, EXCP_CpU, 2);
+    return true;
+}
+
+static bool trans_octeon_cp2_mf_i64(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    tcg_gen_ld_i64(value, tcg_env, offset);
+    gen_store_gpr(value, a->rt);
+    return true;
+}
+
+static bool trans_octeon_cp2_mf_s32(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    tcg_gen_ld32s_i64(value, tcg_env, offset);
+    gen_store_gpr(value, a->rt);
+    return true;
+}
+
+static bool trans_octeon_cp2_mf_u16(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    tcg_gen_ld16u_i64(value, tcg_env, offset);
+    gen_store_gpr(value, a->rt);
+    return true;
+}
+
+static bool trans_octeon_cp2_mf_u8(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    tcg_gen_ld8u_i64(value, tcg_env, offset);
+    gen_store_gpr(value, a->rt);
+    return true;
+}
+
+static bool trans_octeon_cp2_mf_hsh_pair(DisasContext *ctx, arg_cp2 *a,
+                                         int hi_offset, int lo_offset)
+{
+    TCGv_i64 hi = tcg_temp_new_i64();
+    TCGv_i64 lo = tcg_temp_new_i64();
+
+    tcg_gen_ld_i64(hi, tcg_env, hi_offset);
+    tcg_gen_ld_i64(lo, tcg_env, lo_offset);
+    tcg_gen_concat32_i64(lo, lo, hi);
+    gen_store_gpr(lo, a->rt);
+    return true;
+}
+
+static bool trans_octeon_cp2_mt_i64(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_st_i64(value, tcg_env, offset);
+    return true;
+}
+
+static bool trans_octeon_cp2_mt_u32(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_st32_i64(value, tcg_env, offset);
+    return true;
+}
+
+static bool trans_octeon_cp2_mt_u16(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_st16_i64(value, tcg_env, offset);
+    return true;
+}
+
+static bool trans_octeon_cp2_mt_u8_masked(DisasContext *ctx, arg_cp2 *a,
+                                          int offset, uint8_t mask)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_andi_i64(value, value, mask);
+    tcg_gen_st8_i64(value, tcg_env, offset);
+    return true;
+}
+
+static bool trans_octeon_cp2_mt_hsh_pair(DisasContext *ctx, arg_cp2 *a,
+                                         int hi_offset, int lo_offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_st32_i64(value, tcg_env, lo_offset + OCTEON_LO32_OFFSET);
+    tcg_gen_shri_i64(value, value, 32);
+    tcg_gen_st32_i64(value, tcg_env, hi_offset + OCTEON_LO32_OFFSET);
+    return true;
+}
+
+CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT0, hsh_dat, 0);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT1, hsh_dat, 1);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT2, hsh_dat, 2);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT3, hsh_dat, 3);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT4, hsh_dat, 4);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT5, hsh_dat, 5);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_DAT6, hsh_dat, 6);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_IV0, hsh_iv, 0);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_IV1, hsh_iv, 1);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_IV2, hsh_iv, 2);
+CP2_MF_HSH_PAIR(CVM_MF_HSH_IV3, hsh_iv, 3);
+CP2_MF_I64(CVM_MF_3DES_KEY0, des3_key[0]);
+CP2_MF_I64(CVM_MF_3DES_KEY1, des3_key[1]);
+CP2_MF_I64(CVM_MF_3DES_KEY2, des3_key[2]);
+CP2_MF_I64(CVM_MF_3DES_IV, des3_iv);
+CP2_MF_I64(CVM_MF_3DES_RESULT, des3_result);
+CP2_MF_I64(CVM_MF_KAS_RESULT, des3_result);
+CP2_MF_I64(CVM_MF_AES_RESINP0, aes_resinp[0]);
+CP2_MF_I64(CVM_MF_AES_RESINP1, aes_resinp[1]);
+CP2_MF_I64(CVM_MF_AES_IV0, aes_iv[0]);
+CP2_MF_I64(CVM_MF_AES_IV1, aes_iv[1]);
+CP2_MF_I64(CVM_MF_AES_KEY0, aes_key[0]);
+CP2_MF_I64(CVM_MF_AES_KEY1, aes_key[1]);
+CP2_MF_I64(CVM_MF_AES_KEY2, aes_key[2]);
+CP2_MF_I64(CVM_MF_AES_KEY3, aes_key[3]);
+CP2_MF_U8(CVM_MF_AES_KEYLENGTH, aes_keylen);
+CP2_MF_I64(CVM_MF_AES_INP0, aes_resinp[0]);
+CP2_MF_S32(CVM_MF_CRC_POLYNOMIAL, crc_poly);
+CP2_MF_S32(CVM_MF_CRC_IV, crc_iv);
+CP2_MF_U8(CVM_MF_CRC_LEN, crc_len);
+CP2_MF_I64(CVM_MF_GFM_MUL0, gfm_mul[0]);
+CP2_MF_I64(CVM_MF_GFM_MUL1, gfm_mul[1]);
+CP2_MF_I64(CVM_MF_GFM_RESINP0, gfm_resinp[0]);
+CP2_MF_I64(CVM_MF_GFM_RESINP1, gfm_resinp[1]);
+CP2_MF_U16(CVM_MF_GFM_POLY, gfm_poly);
+
+CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT0, hsh_dat, 0);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT1, hsh_dat, 1);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT2, hsh_dat, 2);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT3, hsh_dat, 3);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT4, hsh_dat, 4);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT5, hsh_dat, 5);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_DAT6, hsh_dat, 6);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_IV0, hsh_iv, 0);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_IV1, hsh_iv, 1);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_IV2, hsh_iv, 2);
+CP2_MT_HSH_PAIR(CVM_MT_HSH_IV3, hsh_iv, 3);
+CP2_MT_I64(CVM_MT_3DES_KEY0, des3_key[0]);
+CP2_MT_I64(CVM_MT_3DES_KEY1, des3_key[1]);
+CP2_MT_I64(CVM_MT_3DES_KEY2, des3_key[2]);
+CP2_MT_I64(CVM_MT_3DES_IV, des3_iv);
+CP2_MT_I64(CVM_MT_3DES_RESULT, des3_result);
+CP2_MT_I64(CVM_MT_AES_RESINP0, aes_resinp[0]);
+CP2_MT_I64(CVM_MT_AES_RESINP1, aes_resinp[1]);
+CP2_MT_I64(CVM_MT_AES_IV0, aes_iv[0]);
+CP2_MT_I64(CVM_MT_AES_IV1, aes_iv[1]);
+CP2_MT_I64(CVM_MT_AES_KEY0, aes_key[0]);
+CP2_MT_I64(CVM_MT_AES_KEY1, aes_key[1]);
+CP2_MT_I64(CVM_MT_AES_KEY2, aes_key[2]);
+CP2_MT_I64(CVM_MT_AES_KEY3, aes_key[3]);
+CP2_MT_I64(CVM_MT_AES_ENC_CBC0, aes_resinp[0]);
+CP2_MT_I64(CVM_MT_AES_ENC0, aes_resinp[0]);
+CP2_MT_I64(CVM_MT_AES_DEC_CBC0, aes_resinp[0]);
+CP2_MT_I64(CVM_MT_AES_DEC0, aes_resinp[0]);
+CP2_MT_U8_MASKED(CVM_MT_AES_KEYLENGTH, aes_keylen, 3);
+CP2_MT_U32(CVM_MT_CRC_IV, crc_iv);
+CP2_MT_I64(CVM_MT_GFM_MUL0, gfm_mul[0]);
+CP2_MT_I64(CVM_MT_GFM_MUL1, gfm_mul[1]);
+CP2_MT_I64(CVM_MT_GFM_RESINP0, gfm_resinp[0]);
+CP2_MT_I64(CVM_MT_GFM_RESINP1, gfm_resinp[1]);
+CP2_MT_U16(CVM_MT_GFM_POLY, gfm_poly);
+CP2_MT_U8_MASKED(CVM_MT_CRC_LEN, crc_len, 0xf);
+CP2_MT_U32(CVM_MT_CRC_POLYNOMIAL, crc_poly);
+
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {
     TCGv_i64 p;
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index 9153e37e9e0..7a7445c40a5 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -186,6 +186,86 @@ static uint64_t octeon_mtp0_zeroes_p1(void)
     return rd;
 }
 
+static uint64_t octeon_cop2_key0_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80104\n\t" /* dmtc2 $8, AES_KEY0 selector */
+        ".word 0x482a0104\n\t" /* dmfc2 $10, AES_KEY0 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_key2_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80106\n\t" /* dmtc2 $8, AES_KEY2 selector */
+        ".word 0x482a0106\n\t" /* dmfc2 $10, AES_KEY2 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_key3_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80107\n\t" /* dmtc2 $8, AES_KEY3 selector */
+        ".word 0x482a0107\n\t" /* dmfc2 $10, AES_KEY3 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_keylength_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80110\n\t" /* dmtc2 $8, AES_KEYLENGTH selector */
+        ".word 0x482a0110\n\t" /* dmfc2 $10, AES_KEYLENGTH selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_hsh_dat0_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80040\n\t" /* dmtc2 $8, HSH_DAT0 selector */
+        ".word 0x482a0040\n\t" /* dmfc2 $10, HSH_DAT0 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
 int main(void)
 {
     assert(octeon_baddu(0x123, 0x0f0) == 0x13);
@@ -199,6 +279,15 @@ int main(void)
     assert(octeon_vmm0(5, 13, 7, 11) == 59);
     assert(octeon_vmm0_zeroes_mpl1() == 0);
     assert(octeon_mtp0_zeroes_p1() == 0);
+    assert(octeon_cop2_key0_readback(0x1122334455667788ULL) ==
+           0x1122334455667788ULL);
+    assert(octeon_cop2_key2_readback(0x8877665544332211ULL) ==
+           0x8877665544332211ULL);
+    assert(octeon_cop2_key3_readback(0x0102030405060708ULL) ==
+           0x0102030405060708ULL);
+    assert(octeon_cop2_keylength_readback(0xa5) == 1);
+    assert(octeon_cop2_hsh_dat0_readback(0x0102030405060708ULL) ==
+           0x0102030405060708ULL);
 
     return 0;
 }
-- 
2.53.0


