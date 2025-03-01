Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D74C282D0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFOQ-0004fS-1x; Sat, 01 Mar 2025 00:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFOF-00041B-QZ
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:55 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFOD-0008C4-SX
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:55 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213MFcV026296
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ne+88ifZZFir6Q+UY3LyuLRSQkP0KO3iP7PQXByn+cw=; b=aeymY0cF3SCtVzGM
 mMTTejs3AxlI0m5fVcovVIjEdXQlK4wcF5CW8KJhW/vLnONJTvQLtCqEpfT5w5Lk
 ejUE29xCJRxyHCOH/yq34B787ZWQ3i0KYVP/Wp3GMr+GPUT9dTLjq/hMqdg6Pf4W
 5ajVHFV0W2ZFiHsPt85LlfrF0Q0AjUnmpC6NG9UUSzhyixBlLu2NyCxMA1HG4ubV
 gLKch9mHtXcGZh5GcVpK8YLybEncaNH6Wg16pJXnCqPe90lezk0xLkqbEjmbMqri
 rB5gIxV9B5KtGfFPcl8BsbTCTsEP/df3jhNAnHHIxRkVbdlMdtcqBcII6GFv9BVx
 AQ0ZVw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t95r63n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2feb019b13aso7405264a91.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806842; x=1741411642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ne+88ifZZFir6Q+UY3LyuLRSQkP0KO3iP7PQXByn+cw=;
 b=NhS0sYvMTe8OHbTX31r95QJM7Mwj7BAPgOCUWB314rs/3b2BNMI9WOy9NK+oVMbdpV
 oElUW718UjVlL9MAuZzlN2mzyj+xNK3DutzuaxAxVu6RnvodNAmU33eegKcHDr6Ya8LI
 LBEgSO9u0peEMnENI1gSksCFj9yWzKSJTYQbWyBicw2HtU0c5EV76ZmRPQgse+dcIcoD
 8hSYWpbJP920wpEyAyHD8qC3HkF6jsnDZVy8OOb0Mx9jxJmolz7cMmJrvWn2rorJ/NYo
 GmpNxZQCFoaHI1V+IqFiIYfvHc89n4Vh9ZORnHffhZOLLGAEUBOT6tKIdM2uLg31MMBe
 Fmug==
X-Gm-Message-State: AOJu0Ywkji3Pz6HOBHVrXGNVSTMU9mDoEFSmC9exgyEbT5RZ/LSEeNqM
 wS+S6rl8t8WvfaHQf4kLA2iQMyvlTSjYpNGXwIPc8XPHjqd0pOjmO3FbuzvLfT/PSyK8lmqTW89
 kFzQfXfRnzIgc+z9xNMDmkN9V/MWcCE6MngTpWAD656/+Wb0q3jStjHU6YbnQeQ==
X-Gm-Gg: ASbGncvG/y959WpX67l9/J4Q2IPLufh/TBmlO/0T4pB7ILKkdn78TC7nDhXMLhBFHVB
 Yurq41KTMXh0gYsQcw1DvV9d5B4jeJeCL5f+u9H/MOu/G3K2MeGn1fGv9u+iZfomiIRNu82MX71
 xIVzDJRHkPyljr5joYnBFlrCax51QL7cxIi6xw5HnWNu/itSZ2IScTHF7NtRpvpKy2LLqNXFEak
 FtCVOtHODQDuz9kgWWcwwLpkTV/yL0gSmE7lMH3K2Fm6f233S/9Bq0PnFk5ta33JF0lzw/4RXIT
 7pNkxpJZiSy/8vdLHHHYJoXerzl6GdJL0SnC5gb/eubcfZupZ9bYzfSTizQatJQR
X-Received: by 2002:a17:90a:e710:b0:2fe:ba82:ca5 with SMTP id
 98e67ed59e1d1-2febab5735cmr10559303a91.11.1740806842319; 
 Fri, 28 Feb 2025 21:27:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuFFlgoOkqUm/QW+XWNlqPtdmeUaq3t73BjBlN0XNseJNUrOZnGoRc7STh9MPjHg6xob4c6A==
X-Received: by 2002:a17:90a:e710:b0:2fe:ba82:ca5 with SMTP id
 98e67ed59e1d1-2febab5735cmr10559279a91.11.1740806841971; 
 Fri, 28 Feb 2025 21:27:21 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:21 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 26/38] target/hexagon: Add TCG overrides for rte, nmi
Date: Fri, 28 Feb 2025 21:26:16 -0800
Message-Id: <20250301052628.1011210-27-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: -7KWm7vXM3mpxCYR23vXX68YFZgjJ-BF
X-Proofpoint-GUID: -7KWm7vXM3mpxCYR23vXX68YFZgjJ-BF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=751 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010040
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Z2VuX3RjZ19zeXMuaCB8IDE5ICsrKysrKysrKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2hl
bHBlci5oICAgICAgfCAgMSArCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgIHwgIDQgKysr
KwogMyBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vZ2VuX3RjZ19zeXMuaCBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmgKaW5k
ZXggOTQyZDA3YjQwMS4uNmQ3M2ExOGRiNCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2Vu
X3RjZ19zeXMuaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCkBAIC04MSw0ICs4
MSwyMyBAQAogICAgICAgICBnZW5faGVscGVyX3N0b3AodGNnX2Vudik7IFwKICAgICB9IHdoaWxl
ICgwKQogCisvKgorICogcnRlIChyZXR1cm4gZnJvbSBleGNlcHRpb24pCisgKiAgICAgQ2xlYXIg
dGhlIEVYIGJpdCBpbiBTU1IKKyAqICAgICBKdW1wIHRvIEVMUgorICovCisjZGVmaW5lIGZHRU5f
VENHX0oyX3J0ZShTSE9SVENPREUpIFwKKyAgICBkbyB7IFwKKyAgICAgICAgVENHdiBuZXdfc3Ny
ID0gdGNnX3RlbXBfbmV3KCk7IFwKKyAgICAgICAgdGNnX2dlbl9kZXBvc2l0X3RsKG5ld19zc3Is
IGhleF90X3NyZWdbSEVYX1NSRUdfU1NSXSwgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
dGNnX2NvbnN0YW50X3RsKDApLCBcCisgICAgICAgICAgICAgICAgICAgICAgICAgICByZWdfZmll
bGRfaW5mb1tTU1JfRVhdLm9mZnNldCwgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVn
X2ZpZWxkX2luZm9bU1NSX0VYXS53aWR0aCk7IFwKKyAgICAgICAgZ2VuX2xvZ19zcmVnX3dyaXRl
KGN0eCwgSEVYX1NSRUdfU1NSLCBuZXdfc3NyKTsgXAorICAgICAgICBnZW5fanVtcHIoY3R4LCBo
ZXhfdF9zcmVnW0hFWF9TUkVHX0VMUl0pOyBcCisgICAgfSB3aGlsZSAoMCkKKworI2RlZmluZSBm
R0VOX1RDR19ZNF9ubWkoU0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9ubWkodGNnX2Vudiwg
UnNWKQorCiAjZW5kaWYKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oIGIvdGFy
Z2V0L2hleGFnb24vaGVscGVyLmgKaW5kZXggYWRhNTIwYmQ1Mi4uNzMwZWFmOGI5YSAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vaGVscGVyLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGVscGVy
LmgKQEAgLTEyOCw0ICsxMjgsNSBAQCBERUZfSEVMUEVSXzIoc3RhcnQsIHZvaWQsIGVudiwgaTMy
KQogREVGX0hFTFBFUl8xKHN0b3AsIHZvaWQsIGVudikKIERFRl9IRUxQRVJfMih3YWl0LCB2b2lk
LCBlbnYsIGkzMikKIERFRl9IRUxQRVJfMihyZXN1bWUsIHZvaWQsIGVudiwgaTMyKQorREVGX0hF
TFBFUl8yKG5taSwgdm9pZCwgZW52LCBpMzIpCiAjZW5kaWYKZGlmZiAtLWdpdCBhL3RhcmdldC9o
ZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggMDlh
NTI4NDMyOS4uMTM5YTBiNWFiMiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE0MzMsNiArMTQzMywxMCBA
QCB2b2lkIEhFTFBFUihzZXRwcmlvKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgdGhy
ZWFkLCB1aW50MzJfdCBwcmlvKQogICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CiB9CiAKK3Zv
aWQgSEVMUEVSKG5taSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHRocmVhZF9tYXNr
KQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CiAjZW5kaWYKIAogCi0tIAoyLjM0
LjEKCg==

