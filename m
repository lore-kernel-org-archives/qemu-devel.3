Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9E9C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4cU-0003PR-Cg; Fri, 10 Jul 2026 02:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4cN-00034U-IP
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4cL-0004qV-Tn
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:47 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nSGf3848787
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /HW2umT7ZcCx0QfTnRS0HUUGWGI83sT6JleEDXAdh+8=; b=Axqs7YPGvNP/vQ5h
 O5p+qo4bivspZZeX6bieJ6g35O+p4f9oOu9glx0FV/BOcz3puPyHjr8GHJqGpKRp
 1eAAScFYBMENG0PPoQhTYnh/TmH6WnUrNXP0qdZNYe3S6HeDVjjTolJjlfnGSNQ6
 NB2Ows7uXK843DStwP8imepW75E/fHm35RyXVsjS1b8Nfr8f5cDX7GTSOrqOLo1T
 X2vAxjCJe6PRw3mFNvP/0uN7VXqwHg97+iB5yocJKbRzNvFSs5EDMIC2/0dJB2OE
 fHkHjPvIy9BuaTlwBLanQhcGZtHbXWEDQHikxS+2gAGZD+Kj76KXTm/6YTN713ro
 gaHt5g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeesu2c6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:34 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8482fd61e83so1064216b3a.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664494; x=1784269294; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/HW2umT7ZcCx0QfTnRS0HUUGWGI83sT6JleEDXAdh+8=;
 b=HOaB4yc/mU7koFgWT3BWVM4HUXOKjqB6FpIQ+6xD4xoO8wqn9DOEwW0nOPItk5NPEj
 07uCcrx/HwmzaMT6KSNDjxeKepBbPKkeluEP3K8EY+a1VUfnUgcE2aqWLHiS8HuPOgM4
 NcIn/EHX1cskwnZItv/HzKwSpxwkBEq8r5+MZ3Og+1t1ZcDj8yJNUBRazlxsY6I1Sc7d
 ZccWRf2b9mMiIidGmPaKQ2G00dD47fqVIPoCRpkUdjNO+klRZgD2NOu4lyIayjEkmcad
 JiDrvLmNLqJibZ1P011aIEs4Ybw4qAXiDfQPFNYs6gnjgYnHAF9uTDoyEDNm03iDcIQk
 GQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664494; x=1784269294;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/HW2umT7ZcCx0QfTnRS0HUUGWGI83sT6JleEDXAdh+8=;
 b=nRgskX+QOm7hwUMUBOPiMpGD7pBdmaGmnNaZupodDpw1zAvJr7eXvJ/h9u1QTGj1XT
 dHetjuCi9oA/kKRnKbeJq8VLvTGkUREcyZC32ejrMR9cHi0M+hZVmKwW0heoGqVYb7Ji
 ucggrWFI1PS0sX4axd+kSsivfMw2MNHghl767A8Kef3noHAJZWJ/RnU2Jjka6saI+2xS
 FJehzvJSevkRMkoQY6xOCt2iuR77ODHrStBcdwGwQFY9UT1lreOgKfuRxBqc64HohQ5b
 kcjr7EbCMl34AMasipIxUXBQ11OUo2yOqAEs/oaO5QAGKeBfvDbpF45iiZ9XKys8eCqF
 hq3A==
X-Gm-Message-State: AOJu0Yyb8Rk6JUx2Yf+PY9wtdnkfLteXR41jbPOZ1lwELp/Lz/oL9f8I
 uLoME/vZ8ng0EZ0HbeDRDc5OjgKHK7QmO9JkSTa5CBFlaBxc7PCNDczpSJo+JVWmXsla88i29hu
 PZA/FJZXODE1Fih2taYbuY6cUuI7eg5UhuWQBusNZN1d8om+0RcT/Ps/MCR1KsjoIjg==
X-Gm-Gg: AfdE7cnzuePn0e3jqM/c7KVXi7RXlQKBJFdKu/IPFwSJNQ5pPlJLX9hLMrrsuYMUJsu
 nSGeTEKhD9NN8NnB7lJ0upGKUD7gw90GZXSOkZA66k6Tcrmou7vAg/dIkB960iblzrnz+yiuN5/
 j0Wz1M9c6nAN2KJ5F5X1iHGRjdoFDntkogUpI/+8abRHfuxQSpZT3olEzyCBkUFm/gkMnGqMsWO
 qbyFjd92XMJCzkTAnAVWv58S8IzR65Y/sDah+YkNHpUFvmDLTdgKnUlB2IweDnpLBv/Ap/PQodT
 Ioh69Evbc0xAUgPOpa7myjqS1/4PFGVT+EAPoFy2e1YMwEw0GY87uf1gclwnFSZuuvb+BuTw71R
 HyTNn5RkiuCn+X676Mgci+Cl/b1sYzPeERBYxicb+j3F789i72BrmlKnZ7LXc1gcnVb0Y9K7O7N
 FP9/uclA==
X-Received: by 2002:a05:6300:2201:b0:3bf:b8d8:8296 with SMTP id
 adf61e73a8af0-3c0bc99890emr13170057637.26.1783664493964; 
 Thu, 09 Jul 2026 23:21:33 -0700 (PDT)
X-Received: by 2002:a05:6300:2201:b0:3bf:b8d8:8296 with SMTP id
 adf61e73a8af0-3c0bc99890emr13170011637.26.1783664493496; 
 Thu, 09 Jul 2026 23:21:33 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 38/97] tests/tcg/aarch64/system/gpc-test.c: remove unused
 variables
Date: Thu,  9 Jul 2026 23:19:16 -0700
Message-ID: <20260710062016.1818125-39-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: F8MBaRN7h0x5kY8sQNKOGggUXOCT7wbp
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a508f6e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=4Gh5T0g__NNyS1BPEC0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXx8NBiX5HhxAn
 iIAaz5KetvXi18GfB+1Fd8fllyM5Imcr9C2h6JVdxbUaA/uBtnVonA5+zV8AbJR01JhHvVsrYX5
 br6rKOTkUhM+wWk16ByKslqra3OsXhg=
X-Proofpoint-ORIG-GUID: F8MBaRN7h0x5kY8sQNKOGggUXOCT7wbp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX0AbOO//zLE4a
 tsHra/pzRI+O7jEvqvQYd7LjImRJ/zGO61Hob9fZNmEPYd39SKj5tRwvnegNi/cgOCt2n/dxyyE
 C56SDMYZbEWCucEYds1Jk4hsxIq7YG28fc2LtOI91psaCKL8dxxFKxkH2uEIXKrJHqFdrF4ITYW
 3SCBJXdMQ7ysTVGcuSDnhwYJzRv6IB8McmAnnNUXxq9kbdAF7lYZQRgBUVjCpRhUqke4dA/+q2d
 ps+e2PD/9wDHBWb45vdqtAxVBMZf37EfwEz4y5pekmnLBODuff1ngLJBSIyOj3AGSiLnTdWU3ZV
 YV5HmNj/DlbsMoOcBHxiHSPKmVNzqGgQ6GaQI93BEUHm9P8Wt9Mqwj4kVUch/3yLprewM0taBfc
 +oD8KTYARZUWC9Qou+GyHKG43XxEQf7Ms33PfHust/8aqe1Y/uXd7ZT9Mdh1rg0uUtxV7+gNoJg
 /X/hgErwYYnejV9xIZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/system/gpc-test.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/tcg/aarch64/system/gpc-test.c b/tests/tcg/aarch64/system/gpc-test.c
index f26b23efafe..0ce0ffea277 100644
--- a/tests/tcg/aarch64/system/gpc-test.c
+++ b/tests/tcg/aarch64/system/gpc-test.c
@@ -28,7 +28,6 @@ const uint32_t gpis_per_64_bits = 16;
 
 int main(uint64_t sp)
 {
-    uint64_t out;
     uint64_t pfr0;
     uint64_t gpt_base;
     uint64_t rme_status;
@@ -38,10 +37,6 @@ int main(uint64_t sp)
     uint64_t gpt_table0_addr = (uint64_t) realms_gpt0;
     uint64_t gpt_table1_addr = (uint64_t) realms_gpt1;
 
-    /* Mask is FNG1, FNG0, and A2 */
-    const uint64_t feature_mask = (1ULL << 18 | 1ULL << 17 | 1ULL << 16);
-    const uint64_t in = feature_mask;
-
     get_sys_reg("CurrentEL", currentel_raw);
     currentel = (currentel_raw >> 2) & 0x3;
 
-- 
2.47.3


