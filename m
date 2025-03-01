Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3ADC282D0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFNL-0002rV-T9; Sat, 01 Mar 2025 00:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNJ-0002qQ-3I
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:26:57 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNH-000866-Ff
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:26:56 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214ekFj022292
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yWTZ7VRtzDmAXfV3dJSDJ4TXwiMNm3kRuELPzv2n3L0=; b=AkhRQxMJjE4s2Sdo
 5JFL64SgP5yr4vsoN0nvrgzmRqxIY6laO19PixAmDEDgoiQZ+smYsJ/mIFySx0a1
 t4i48mOnEZvroqoVBWUB874C0gPzheiRl6zaxuqtZ6mARKN4Hlj9N0TDwW0ZA7bO
 8TN1EV+f5F3/u3X4BlKp9pilWXS4LtPOE0YlKRHfwS/SrI4uwcFOfy1H/P6WHp2Z
 Lj+JjpSeAhy4FqmeYwJ8USMziCPh1qWtTcMYtgVOHurQUC1WLz+4rKMysguYN8ts
 gIgPZofEMYNG8iYjZYO+aVgjgF8LrbNIzSr2PhuQH9m54Nz/DYFCdjszyO1fG3Cy
 kxK5Pw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tm5g4sk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:26:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-22334230880so39434625ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806813; x=1741411613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWTZ7VRtzDmAXfV3dJSDJ4TXwiMNm3kRuELPzv2n3L0=;
 b=Z6bywpAOx4VtLChIOmpWmxsDMZNTLpzE1wScXPj/FMWvQvTPlAw40ZZyAjJ3YclUZz
 8kh72DKh7UKUHKLpiN15j9N6JRc2Z8iJbX7ulKvavz7K9EKGvLsOYCb/emRoy/GVvXGB
 aV9IWYGkv32NZrrp1OujCfWudaYQFHCSnIMTVLHNNkIHMpB/aWPCGw54lx5Be6K4DGbZ
 cfqlwlCO4R1SPgdljeCcHvUdISn9ZFxZLPTuMXyhkf09fohS3URmRNT85YUcY2eVDxSC
 yOQVmV9Dv0VXmKp5UEfTJqFJ/d/KTPfM/2r0musNFE4SFkzgBL2B7y7cXln7YI2ypnrL
 ADIw==
X-Gm-Message-State: AOJu0YybsWiPAtZKz2P55aqu6x47ujIkyzUBsYR7DAIab2UaxI803sAf
 BMcVLqKGlv9xFRG8dX3JR9fE25UJ6FH3xiutx/srmMBDIbljDk3LwijDIiVuzCww+ViXBjmC1qB
 CiYr8bFmahVLXesHet8kNaOHm7rQgkc1B56ZPU4o/+we7CM3SOVEOL/j2SHgCJA==
X-Gm-Gg: ASbGncsUFdXXUrI18akCteaIOAXDbbXMmQxMixX8U8sIIVM6ks8b18w9xuVEhDMwTFk
 UaYujJFgBfXTviUeA5+pXB7ZxcGw9mbgDVxuemlrl6RpszylJwSrZFalwKiKTloF0132DYx7iJM
 oC7Xuj3F39TV5Y8oQIFiVSYIAHOUGvjgAJ9AJ8Wdo7MXqP7UGyWeonGLWcx1n5ye3BM3c3VBaFI
 q7tKnl7gMG0gYD6k3UrtlPJQGt4fxLAxb9ZuasadgGg/MgkBTufZTS8dozrmmACDd8hGc3Pi0yr
 oS0Ip1PSIf5DFGKeRkzIp7oPrPyTL+iBl7j/2YaOwgVN4Ykgcyz5oyj5MNcEr16K
X-Received: by 2002:a17:903:1987:b0:216:410d:4c53 with SMTP id
 d9443c01a7336-22369254a72mr99159195ad.41.1740806812999; 
 Fri, 28 Feb 2025 21:26:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrg5Q5VXZfCCWBWKg/xDXzMlJzIafsgkYzEFt9ZyMG8WBHkBN0pH8o0tOxv1jRcmUOCovNlQ==
X-Received: by 2002:a17:903:1987:b0:216:410d:4c53 with SMTP id
 d9443c01a7336-22369254a72mr99159015ad.41.1740806812656; 
 Fri, 28 Feb 2025 21:26:52 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:26:52 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 04/38] target/hexagon: Make gen_exception_end_tb non-static
Date: Fri, 28 Feb 2025 21:25:54 -0800
Message-Id: <20250301052628.1011210-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: rTu9tM_O5Bj4pPwqHXh24TCB0sCxWil2
X-Proofpoint-GUID: rTu9tM_O5Bj4pPwqHXh24TCB0sCxWil2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=874 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010038
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
dHJhbnNsYXRlLmggfCAyICsrCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyB8IDkgKysrKy0t
LS0tCiAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCBiL3RhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oCmluZGV4IGQyNTFlMjIzM2YuLjJiZDEyNTI5N2EgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBA
IC0yODEsNiArMjgxLDggQEAgZXh0ZXJuIFRDR3YgaGV4X3ZzdG9yZV9hZGRyW1ZTVE9SRVNfTUFY
XTsKIGV4dGVybiBUQ0d2IGhleF92c3RvcmVfc2l6ZVtWU1RPUkVTX01BWF07CiBleHRlcm4gVENH
diBoZXhfdnN0b3JlX3BlbmRpbmdbVlNUT1JFU19NQVhdOwogCit2b2lkIGhleF9nZW5fZXhjZXB0
aW9uX2VuZF90YihEaXNhc0NvbnRleHQgKmN0eCwgaW50IGV4Y3ApOworCiB2b2lkIHByb2Nlc3Nf
c3RvcmUoRGlzYXNDb250ZXh0ICpjdHgsIGludCBzbG90X251bSk7CiAKIEZJRUxEKFBST0JFX1BL
VF9TQ0FMQVJfU1RPUkVfUzAsIE1NVV9JRFgsICAgICAgIDAsIDIpCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4
IGZlNzg1ODcwM2MuLjJlOWE5MzRmYzYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5z
bGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC0xODUsMTMgKzE4NSwx
MiBAQCBzdGF0aWMgdm9pZCBnZW5fZW5kX3RiKERpc2FzQ29udGV4dCAqY3R4KQogICAgIGN0eC0+
YmFzZS5pc19qbXAgPSBESVNBU19OT1JFVFVSTjsKIH0KIAotc3RhdGljIHZvaWQgZ2VuX2V4Y2Vw
dGlvbl9lbmRfdGIoRGlzYXNDb250ZXh0ICpjdHgsIGludCBleGNwKQordm9pZCBoZXhfZ2VuX2V4
Y2VwdGlvbl9lbmRfdGIoRGlzYXNDb250ZXh0ICpjdHgsIGludCBleGNwKQogewogICAgIGdlbl9l
eGVjX2NvdW50ZXJzKGN0eCk7CiAgICAgdGNnX2dlbl9tb3ZpX3RsKGhleF9ncHJbSEVYX1JFR19Q
Q10sIGN0eC0+bmV4dF9QQyk7CiAgICAgZ2VuX2V4Y2VwdGlvbl9yYXcoZXhjcCk7CiAgICAgY3R4
LT5iYXNlLmlzX2ptcCA9IERJU0FTX05PUkVUVVJOOwotCiB9CiAKIHN0YXRpYyBpbnQgcmVhZF9w
YWNrZXRfd29yZHMoQ1BVSGV4YWdvblN0YXRlICplbnYsIERpc2FzQ29udGV4dCAqY3R4LApAQCAt
NTU4LDcgKzU1Nyw3IEBAIHN0YXRpYyB2b2lkIGdlbl9pbnNuKERpc2FzQ29udGV4dCAqY3R4KQog
ICAgICAgICBjdHgtPmluc24tPmdlbmVyYXRlKGN0eCk7CiAgICAgICAgIG1hcmtfc3RvcmVfd2lk
dGgoY3R4KTsKICAgICB9IGVsc2UgewotICAgICAgICBnZW5fZXhjZXB0aW9uX2VuZF90YihjdHgs
IEhFWF9DQVVTRV9JTlZBTElEX09QQ09ERSk7CisgICAgICAgIGhleF9nZW5fZXhjZXB0aW9uX2Vu
ZF90YihjdHgsIEhFWF9DQVVTRV9JTlZBTElEX09QQ09ERSk7CiAgICAgfQogfQogCkBAIC05MTIs
NyArOTExLDcgQEAgc3RhdGljIHZvaWQgZGVjb2RlX2FuZF90cmFuc2xhdGVfcGFja2V0KENQVUhl
eGFnb25TdGF0ZSAqZW52LCBEaXNhc0NvbnRleHQgKmN0eCkKIAogICAgIG53b3JkcyA9IHJlYWRf
cGFja2V0X3dvcmRzKGVudiwgY3R4LCB3b3Jkcyk7CiAgICAgaWYgKCFud29yZHMpIHsKLSAgICAg
ICAgZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoY3R4LCBIRVhfQ0FVU0VfSU5WQUxJRF9QQUNLRVQpOwor
ICAgICAgICBoZXhfZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoY3R4LCBIRVhfQ0FVU0VfSU5WQUxJRF9Q
QUNLRVQpOwogICAgICAgICByZXR1cm47CiAgICAgfQogCkBAIC05MjcsNyArOTI2LDcgQEAgc3Rh
dGljIHZvaWQgZGVjb2RlX2FuZF90cmFuc2xhdGVfcGFja2V0KENQVUhleGFnb25TdGF0ZSAqZW52
LCBEaXNhc0NvbnRleHQgKmN0eCkKICAgICAgICAgZ2VuX2NvbW1pdF9wYWNrZXQoY3R4KTsKICAg
ICAgICAgY3R4LT5iYXNlLnBjX25leHQgKz0gcGt0LmVuY29kX3BrdF9zaXplX2luX2J5dGVzOwog
ICAgIH0gZWxzZSB7Ci0gICAgICAgIGdlbl9leGNlcHRpb25fZW5kX3RiKGN0eCwgSEVYX0NBVVNF
X0lOVkFMSURfUEFDS0VUKTsKKyAgICAgICAgaGV4X2dlbl9leGNlcHRpb25fZW5kX3RiKGN0eCwg
SEVYX0NBVVNFX0lOVkFMSURfUEFDS0VUKTsKICAgICB9CiB9CiAKLS0gCjIuMzQuMQoK

