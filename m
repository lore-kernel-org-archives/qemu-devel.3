Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927E7CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQi5-0001ec-GH; Mon, 11 May 2026 09:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhp-0001IB-Aj
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:30:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhn-0007mM-Eh
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:57 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B7AQ01453496
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lFsa4m/S5J/
 20qST7P95M0FPPybc451EGT/q/ncaDeg=; b=RLOHR8yE1didP//up3zXcxgbnHz
 F4QjWliHeQnri3ttVDph5fhNotgE4SIKC5zmD8OTP3LtYm/JrRuTMmGS4vRcK8bf
 bxSXmi7n8g/mkQQszEuN5QRgzIPlClf1s2Jg4f8nA2brKAd+5L6DIZwOGUfLHfZl
 LCMgUqHwEZr85hdUHQ+322xEHHpaBtw6+lXGlge50qJ3kdgG8AMDoiYqtiWT4TJ2
 qKf2wj0qqE83ayUK+TKq+gGLMqsL7d6nldt55SE06A25EEp1fwSQzqgdip571cR8
 dnEU59hiKfXAtQzfhDSx43bPn4mXxy1M8BhEA7IbEE0yN2fvzapXKluPJFA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ag6h9n6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:44 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b640ede74bso73173916d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778506183; x=1779110983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFsa4m/S5J/20qST7P95M0FPPybc451EGT/q/ncaDeg=;
 b=AmHOrPWDq/EK/Q34KIDqB1nz5//Di8tDJmoao2vG0cwpe2DumI2mhTHj4yHQjUdzzT
 cP3hEn/lWlj5mbbQBxRPO34D7NfEm+ls7zPf1qauGAx//yQY9EG1x0LRX7kvtm2hPXmU
 c6QEL87Y4/VbbqVmkRSTlTDTB4+xTCacXjg2INUY1BOSZcTT1gKHA23thrYSxxn/+uut
 ff3wxAh3JLwdv0e5unN4zy06PiL8g9eAKGciCU3Dw8TMg/8N6IYMGXhsRnMVsr4ZOStK
 6X0Jv+BOjwSHALEGZ8opAI1EgIYpfV+s5pXyc3ID8WSs+r10c4Ff2MYSKBET6hVWQtbQ
 ZEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506183; x=1779110983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lFsa4m/S5J/20qST7P95M0FPPybc451EGT/q/ncaDeg=;
 b=OJ/LZ/xk3owb/8+iqSVEbiL3m01fuakL3DzaLJ/8sPrAYWu/gPgxgg2RQ5gg+Gu/bR
 lXXDtvxwcxQSz0H/8gCV/rMw1fnXH/6bxxSS+lEn09ukU53WPUXCYzvWUGO5TH4N0655
 XK8+FAYnsAjjm4/ns9OYw138RNU3xbdr0Rxje3TTK8ZMjNvHs5WIabpfxzvD8lItHoc5
 4cCTf3nAyRPUM/CybabG2Hl3SmT895W5GgbQSvWc7E7HOG/qBHRWmqPxKKZ8N1UeRlYY
 AQDMQOG4j1dDJODRcexeQ36a1zAHXTDbkhL3UGx3kMFy6iynjWgT96FJS9rgq8vm5Wh8
 YXoA==
X-Gm-Message-State: AOJu0YwOh1aDK0YEUoJNM40eoIBCbY6Ur5wdCTn7xEvL82ZiLHUWvsVg
 PueW0/ucsjUzbB2yixlRHZF/jFBPdlmWHEqCeRhnKIkdIL5aFfHO5qO4EL0Gnt33g3bw9xmsSvn
 F66ZsN2j/y53ZWPo4ZzJZDxpGi4gIicqxe340eZMjS6ki+bYM1FlJ/6hTenGeysY/5Q==
X-Gm-Gg: Acq92OH9O3fzxz244S03niW5bUG/o52PDecAjEFoIuLJtH29nANOxJR+H6iuBwAbXGq
 MuCZJHPPtO2bpA8IT3zEfa9MQcJo8nnlJslEhcy2taiR31HDnr3sSMXgdkQlxbDHyK4Ux28DHp+
 9NnHp8ameJkm2IQl6/8EwkmHVUUOy0nFZlOKoHs0AcH9kQoM9ZvxYaZZ2Y/DuwtHkBBvlcOEOrv
 Pkk9vPW5kc8qw+qr8CRfd5D3mMeaNwnn/q9VL1zARhf1gU9vu3kOiIzFs1OvQZsckzsa6akEtEz
 N5z6c8bGLXJ8YmJ4v4wurlfHABTFzPDDEwW6MGfmdO8WPEo4TxZN48BTd5ONaHYXYfxRX5PRkRL
 mkkEKkBewob5JqnGl28as0KQqVoNSIPTq6A9QmNAeN7UDqG8EEDSULTR5XjP23GZEm4pPskc=
X-Received: by 2002:a05:6214:3f92:b0:89a:14ef:8eab with SMTP id
 6a1803df08f44-8bc45e1f44bmr391494576d6.41.1778506183456; 
 Mon, 11 May 2026 06:29:43 -0700 (PDT)
X-Received: by 2002:a05:6214:3f92:b0:89a:14ef:8eab with SMTP id
 6a1803df08f44-8bc45e1f44bmr391493776d6.41.1778506182829; 
 Mon, 11 May 2026 06:29:42 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c81b3fsm95250326d6.29.2026.05.11.06.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:29:42 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 13/13] target/riscv/cpu: remove riscv_cpu_* arrays
Date: Mon, 11 May 2026 10:29:10 -0300
Message-ID: <20260511132910.1738069-14-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
References: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fOsJG5ae c=1 sm=1 tr=0 ts=6a01d9c8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=xkx7_DFI7zyQbJe41r0A:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0OSBTYWx0ZWRfX3Fwuv9eRLUOi
 yHNIlrJYUI/hjFDaHH0ZemhoD60KSjW0TIe5Q1VQ9vxyCH3r1dH4PdrFZS2ItK5SKhMQn8sH3UB
 l41r1zdeo8pVAtAm395H0lzka7M9yO/YTXNcGj9HSVdspSKjrXMAQarVGE7e8YaiM8sB77T0wof
 QXejkLQLNyaepZdsnpAIMb7zu/Jb9WwO1LIggqbNnQmEhtw8/mqSjl7ovEbIpqnsfz5VSDbMCCt
 HjBhGYHPl68338gkT2u3sOKbngAxRIYZBOOB1+9uSOQ+I3+nOYf9e5itvszxQKyg+EtHRYEVDeB
 O+n8YKmDn/NrCeStPSovF/dQRpFeie1HhHqPn9f+gGnexA+kTVisARbYU4xCqLFRcvYMrrpoFK0
 eB7Ix+72usf66u9rLFZ5ca+9xCVBk5oAKFwlHnv64oNrEhyygxSI7SgPRNtHVhBluuMOslOcgiL
 Rw91IA+o4LBX4lLUvIQ==
X-Proofpoint-GUID: b_U6_xr5BEjG0a9nxfR2DL9sfEUiSgbl
X-Proofpoint-ORIG-GUID: b_U6_xr5BEjG0a9nxfR2DL9sfEUiSgbl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110149
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

There is no more uses left for these arrays. isa_edata_arr[] is doing
everything we need, making our lives a little easier when adding new
extensions.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 159 ---------------------------------------------
 target/riscv/cpu.h |  10 ---
 2 files changed, 169 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6dd05597e8..67452bb964 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1248,165 +1248,6 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
     return val;
 }
 
-#define MULTI_EXT_CFG_BOOL(_name, _prop, _defval) \
-    {.name = _name, .offset = CPU_CFG_OFFSET(_prop), \
-     .enabled = _defval}
-
-const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
-    /* Defaults for standard extensions */
-    MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
-    MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
-    MULTI_EXT_CFG_BOOL("smcsrind", ext_smcsrind, false),
-    MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
-    MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
-    MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
-    MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
-    MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
-    MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
-    MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
-    MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
-    MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
-    MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
-    MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
-    MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
-    MULTI_EXT_CFG_BOOL("zcmop", ext_zcmop, false),
-    MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
-    MULTI_EXT_CFG_BOOL("zama16b", ext_zama16b, false),
-    MULTI_EXT_CFG_BOOL("zabha", ext_zabha, false),
-    MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
-    MULTI_EXT_CFG_BOOL("zalasr", ext_zalasr, false),
-    MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
-    MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
-    MULTI_EXT_CFG_BOOL("zfa", ext_zfa, true),
-    MULTI_EXT_CFG_BOOL("zfbfmin", ext_zfbfmin, false),
-    MULTI_EXT_CFG_BOOL("zfh", ext_zfh, false),
-    MULTI_EXT_CFG_BOOL("zfhmin", ext_zfhmin, false),
-    MULTI_EXT_CFG_BOOL("zve32f", ext_zve32f, false),
-    MULTI_EXT_CFG_BOOL("zve32x", ext_zve32x, false),
-    MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
-    MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
-    MULTI_EXT_CFG_BOOL("zve64x", ext_zve64x, false),
-    MULTI_EXT_CFG_BOOL("zvfbfa", ext_zvfbfa, false),
-    MULTI_EXT_CFG_BOOL("zvfbfmin", ext_zvfbfmin, false),
-    MULTI_EXT_CFG_BOOL("zvfbfwma", ext_zvfbfwma, false),
-    MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
-    MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
-    MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
-    MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
-    MULTI_EXT_CFG_BOOL("sspm", ext_sspm, false),
-    MULTI_EXT_CFG_BOOL("supm", ext_supm, false),
-
-    MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
-    MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
-    MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
-    MULTI_EXT_CFG_BOOL("smpmpmt", ext_smpmpmt, false),
-    MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
-    MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
-    MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
-    MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
-    MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
-    MULTI_EXT_CFG_BOOL("ssdbltrp", ext_ssdbltrp, false),
-    MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
-    MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
-    MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
-    MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
-    MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
-    MULTI_EXT_CFG_BOOL("svrsw60t59b", ext_svrsw60t59b, false),
-    MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
-
-    MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
-    MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
-    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),
-
-    MULTI_EXT_CFG_BOOL("zba", ext_zba, true),
-    MULTI_EXT_CFG_BOOL("zbb", ext_zbb, true),
-    MULTI_EXT_CFG_BOOL("zbc", ext_zbc, true),
-    MULTI_EXT_CFG_BOOL("zbkb", ext_zbkb, false),
-    MULTI_EXT_CFG_BOOL("zbkc", ext_zbkc, false),
-    MULTI_EXT_CFG_BOOL("zbkx", ext_zbkx, false),
-    MULTI_EXT_CFG_BOOL("zbs", ext_zbs, true),
-    MULTI_EXT_CFG_BOOL("zk", ext_zk, false),
-    MULTI_EXT_CFG_BOOL("zkn", ext_zkn, false),
-    MULTI_EXT_CFG_BOOL("zknd", ext_zknd, false),
-    MULTI_EXT_CFG_BOOL("zkne", ext_zkne, false),
-    MULTI_EXT_CFG_BOOL("zknh", ext_zknh, false),
-    MULTI_EXT_CFG_BOOL("zkr", ext_zkr, false),
-    MULTI_EXT_CFG_BOOL("zks", ext_zks, false),
-    MULTI_EXT_CFG_BOOL("zksed", ext_zksed, false),
-    MULTI_EXT_CFG_BOOL("zksh", ext_zksh, false),
-    MULTI_EXT_CFG_BOOL("zkt", ext_zkt, false),
-    MULTI_EXT_CFG_BOOL("ztso", ext_ztso, false),
-
-    MULTI_EXT_CFG_BOOL("zdinx", ext_zdinx, false),
-    MULTI_EXT_CFG_BOOL("zfinx", ext_zfinx, false),
-    MULTI_EXT_CFG_BOOL("zhinx", ext_zhinx, false),
-    MULTI_EXT_CFG_BOOL("zhinxmin", ext_zhinxmin, false),
-
-    MULTI_EXT_CFG_BOOL("zicbom", ext_zicbom, true),
-    MULTI_EXT_CFG_BOOL("zicbop", ext_zicbop, true),
-    MULTI_EXT_CFG_BOOL("zicboz", ext_zicboz, true),
-
-    MULTI_EXT_CFG_BOOL("zmmul", ext_zmmul, false),
-
-    MULTI_EXT_CFG_BOOL("zca", ext_zca, false),
-    MULTI_EXT_CFG_BOOL("zcb", ext_zcb, false),
-    MULTI_EXT_CFG_BOOL("zcd", ext_zcd, false),
-    MULTI_EXT_CFG_BOOL("zce", ext_zce, false),
-    MULTI_EXT_CFG_BOOL("zcf", ext_zcf, false),
-    MULTI_EXT_CFG_BOOL("zcmp", ext_zcmp, false),
-    MULTI_EXT_CFG_BOOL("zcmt", ext_zcmt, false),
-    MULTI_EXT_CFG_BOOL("zicond", ext_zicond, false),
-    MULTI_EXT_CFG_BOOL("zclsd", ext_zclsd, false),
-
-    /* Vector cryptography extensions */
-    MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
-    MULTI_EXT_CFG_BOOL("zvbc", ext_zvbc, false),
-    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkb, false),
-    MULTI_EXT_CFG_BOOL("zvkg", ext_zvkg, false),
-    MULTI_EXT_CFG_BOOL("zvkned", ext_zvkned, false),
-    MULTI_EXT_CFG_BOOL("zvknha", ext_zvknha, false),
-    MULTI_EXT_CFG_BOOL("zvknhb", ext_zvknhb, false),
-    MULTI_EXT_CFG_BOOL("zvksed", ext_zvksed, false),
-    MULTI_EXT_CFG_BOOL("zvksh", ext_zvksh, false),
-    MULTI_EXT_CFG_BOOL("zvkt", ext_zvkt, false),
-    MULTI_EXT_CFG_BOOL("zvkn", ext_zvkn, false),
-    MULTI_EXT_CFG_BOOL("zvknc", ext_zvknc, false),
-    MULTI_EXT_CFG_BOOL("zvkng", ext_zvkng, false),
-    MULTI_EXT_CFG_BOOL("zvks", ext_zvks, false),
-    MULTI_EXT_CFG_BOOL("zvksc", ext_zvksc, false),
-    MULTI_EXT_CFG_BOOL("zvksg", ext_zvksg, false),
-
-    { },
-};
-
-const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
-    MULTI_EXT_CFG_BOOL("xtheadba", ext_xtheadba, false),
-    MULTI_EXT_CFG_BOOL("xtheadbb", ext_xtheadbb, false),
-    MULTI_EXT_CFG_BOOL("xtheadbs", ext_xtheadbs, false),
-    MULTI_EXT_CFG_BOOL("xtheadcmo", ext_xtheadcmo, false),
-    MULTI_EXT_CFG_BOOL("xtheadcondmov", ext_xtheadcondmov, false),
-    MULTI_EXT_CFG_BOOL("xtheadfmemidx", ext_xtheadfmemidx, false),
-    MULTI_EXT_CFG_BOOL("xtheadfmv", ext_xtheadfmv, false),
-    MULTI_EXT_CFG_BOOL("xtheadmac", ext_xtheadmac, false),
-    MULTI_EXT_CFG_BOOL("xtheadmemidx", ext_xtheadmemidx, false),
-    MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
-    MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
-    MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
-    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
-    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
-    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
-    MULTI_EXT_CFG_BOOL("xlrbr", ext_xlrbr, false),
-
-    { },
-};
-
-/* These are experimental so mark with 'x-' */
-const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
-    MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
-
-    { },
-};
-
 static void cpu_set_prop_err(RISCVCPU *cpu, const char *propname,
                              Error **errp)
 {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ea6f3e8731..4b1c766ee9 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -982,16 +982,6 @@ bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset);
 void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext);
 bool riscv_cpu_is_vendor(Object *cpu_obj);
 
-typedef struct RISCVCPUMultiExtConfig {
-    const char *name;
-    uint32_t offset;
-    bool enabled;
-} RISCVCPUMultiExtConfig;
-
-extern const RISCVCPUMultiExtConfig riscv_cpu_extensions[];
-extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
-extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
-
 typedef struct isa_ext_data {
     const char *name;
     const char *prop_name;
-- 
2.43.0


