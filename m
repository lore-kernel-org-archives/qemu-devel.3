Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E3A606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fxCidKWO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TIWJwXz0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHwm-0008K1-DE; Fri, 23 Oct 2026 12:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHw6-0006zO-R2
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:16:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHw5-0002R7-04
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:16:06 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6A6j3019170
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q6RYsjAnSxeg5H+IYjSF15lRDnyLKngQ/0YHC5SX+0g=; b=fxCidKWO+wNmtDyc
 TpiK6JV5sXIrtChDliME/AKeiXCeOL7ZTh9Cr/az0lMj8Y2Yc5i9Gj303pvcU31F
 wjjegEdPYkjLIgkgBRDLruL4AtUn9dKw9DU35G16UCJCTFncADRsMGULRfybUXeR
 fqJZkU0ECZ8pgcfqPkLlzVuPeQlPFZo+EtwNplPLm4KN7rtNtEBkNRhH7hbAVQEI
 lP6SSRtsiq5EiHyVvAKvH5nrggyWM+fNIkhssaItHfoKT4+i8Gw9zg8/K9s7KIAR
 4nfADNj0KEhBRa8VHI/wGy6rZS+a6FS6wLkikxoHzx5VwlT7WajnlPSk8T53n0pP
 6+GsHQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsykbxj1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:16:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so245204985a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772162; x=1793376962; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q6RYsjAnSxeg5H+IYjSF15lRDnyLKngQ/0YHC5SX+0g=;
 b=TIWJwXz0NF16QHRPkE+sVw406RYO7Xn0Y8kWzI4Hd8RksTbHB9o/I1yBvMaSKzWDQX
 HpCgNizMV3PJpx3pFial141VBcP0TZO5ns6HyaxZccFTy/I14VWSsQJQyt4Dh1l+rtLt
 xEMiy5V5iwuSMq4hlrepYbuVz5d7rCPCMRVwaJARMG79uZ32AyBw2QLgVzmvCq+UHpsX
 ME7TEbos/O9ke3OclgU9/+YLsx9RLTBDaU/iS1iUylQ5mrG3N5SLYRW7ba3vOSSX6ovV
 jW04UGKabLOPuwkKeGTTY2gs7kYPwpOr65Na2MRXtfCIR7s6Iqx2rI7C2/rjhllCpEdf
 efIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772162; x=1793376962;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q6RYsjAnSxeg5H+IYjSF15lRDnyLKngQ/0YHC5SX+0g=;
 b=pPDJ/7OE5MZAgcA/n9WFmrM1wyY37FQ2wpkiBjWweldokJSiQ0NLrbeoeGMufQuf1m
 EHzVOCX7VsLwaLIieEazIVyVmxOKeeVa4ZmBw5weKbexo7+dMMJnV6ffmkOlnUHLmEKv
 8HQZjJQTk9feJmbaxyOHQ/Szw3o3iXZCOlBPIU84GPdkG8yDgo8wKWbTSwzj0y7eU8my
 /PAcfF0tILLcTuOgsoTLuduXi3gfqB4Q7tPxYk6r8WyXDdnVSikN3UbCxXbwfm1EaMO7
 l91P7y4PJsxaobPX2oLQp07Raaxbc8FW3ghSV2yuVSuKkrEafEkJAySc+pVcFziXYgYz
 BskA==
X-Gm-Message-State: AFq9FYJNZ9aWkem7olW1oeGQBTAnAGmYszyO+s59jCIssQYR5zbDCqQZ
 OejmzWmm4zxOdrn2UfHbnfduWOxrtgDIGYEHLiKM85snFicJaUNUSwdPHNfHu8wU+I9Cg1JepOm
 l5J1IanQvCJ9JSPgq8aKJtWlSVSRAke+aRb7YSPZkzz0RRO0M1zxXq/5cnGALANqWkoSf
X-Gm-Gg: AYBFou1Wz5wzUF2nYGOJKlrRHRyHP4YhIEhWEEkE89AIYPq+N2y5VGasyrHUe6MJ7kq
 IOr9x5BBIXkye2BX5zhc3W1yylw+HGW1fHgpPFdW9IA9gWWGimyfORXNYQfDEaGxidXOu1D4bym
 QnODnNH7atl9yFEvbqd0Plyt4XJI17sgDf4Axfsq2hbN1zFUjKlAb4yTal0+sAYclxXszYCyvQh
 CUUbSEYE5ryl+ny26lO5xBw2Iot8M1UTBgS2SbciyEAQni1PpGVSeb57tAP/jgeFP8RwuhvOCq8
 A1oaRfGM+dVre8uGfLaKHSDvVO7TgbUtBLcTWeP7Ba7hA8Srt5wqBE9TpSKN743kusmrTBSheKd
 cFonTL4NYOMMamkdv0aXIT1oaeP65ZanrpAGHzn1L
X-Received: by 2002:a05:620a:390c:b0:93e:e175:ee92 with SMTP id
 af79cd13be357-93f6f7d048cmr479542185a.39.1792772162384; 
 Fri, 23 Oct 2026 09:16:02 -0700 (PDT)
X-Received: by 2002:a05:620a:390c:b0:93e:e175:ee92 with SMTP id
 af79cd13be357-93f6f7d048cmr479537385a.39.1792772161904; 
 Fri, 23 Oct 2026 09:16:01 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d37c4c2sm823295f8f.4.2026.10.23.09.16.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:16:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/83] qemu/osdep: Document ARRAY_SIZE() macro rejects pointers
Date: Fri, 23 Oct 2026 18:12:28 +0200
Message-ID: <20261023161332.60153-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX5+UL7S4QTeYU
 VzdivbwxM5PBlTtXz9a+7ykeQo81ZQkunJyjQlqt8/z4TZu7EPOZd5ZldfaNYwjnd7w4JlrED4H
 nNihpcKLT34OLaWxHnor0ovF00POTVLGDSis7Zi0flIorKPogt34cIl5zJISvvbO+A27IJ7Esum
 RNnwWaCgW9D7p0HCXrxCo9q1Q7nq6ITPMMxqGwpuvRwhW3J2ubmii/EfsxeCI908TaeqqdS4VYw
 GpqSIFD8fsWhuvtPVEYFaIklx+9s8S/h45H18ws4VM4R9Q2YQsM6OOhZke0TYtz/zaSGYg7ZrCm
 DK4rNpmXloLIvrhxKd/e0pk8s/iPzg9lUViIPx3AHrN82JfuZpFXnGJ+TKvSoF5fqTKaek0YB8K
 //T0/qAl9Ti7aN3bhDuphxK/TdY/2djKAyuemYxZ+ICTsJd/AJGpjdQioEl/3L6WiwRHAqnXUU+
 ct+pXk2jW7Y81DiYTww==
X-Proofpoint-ORIG-GUID: bF0P1s1ihiLtxcU52Q-p1yZ-M-s-VI2j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX0eqelWqnCHX2
 b9Nmx8tFvB5DZrn2ly7LK1tz4Ks3FEej7/GdDKcO6ubg0gmlh6Bs2acIB1iZ6B46KNl+yd9v38j
 qZLIxeCVJF0YHs5ImCbOEzjnRTeOT+I=
X-Proofpoint-GUID: bF0P1s1ihiLtxcU52Q-p1yZ-M-s-VI2j
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6adb8843 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Kwhbg8pJGtqcix1HUGwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230063
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit ed63ec0d22c ("ARRAY_SIZE: check that argument is an
array"), passing a pointer to ARRAY_SIZE() is a build error.
Document that.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-2-philmd@oss.qualcomm.com>
---
 include/qemu/osdep.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 1ec5b42230b..5d5695ade28 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -528,6 +528,12 @@ void QEMU_ERROR("code path is reachable")
  */
 #define QEMU_IS_ARRAY(x) (!__builtin_types_compatible_p(typeof(x), \
                                                         typeof(&(x)[0])))
+/**
+ * ARRAY_SIZE() - Return the number of elements of an array
+ * @x: the array
+ *
+ * Note: fails to build if @x is a pointer.
+ */
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + \
                        QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))
-- 
2.55.0


