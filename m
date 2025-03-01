Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADFAC282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPN-00088I-V2; Sat, 01 Mar 2025 00:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPK-00083D-JY
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:02 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPI-0008ND-Tb
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:02 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213Gngf005403
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /i+ZUfqaP8JGue0A2xzcyNC25I/nrXf6rB9YDXOFk7s=; b=GvTohUWMZ5DFYNAg
 YD5hPVE0L1//XWlTEpWhH+tgFcnLZQnu8iym6ApSsN/MfGM/gGFdJR4hTcgMVZLg
 SRfHquHFIyM3RwiKhnwLopNXhv/GanCWEaEQDUuuDRiX3VFYmeC6Y44OhcNy0L0y
 1Rb32ROvF8pxH8ewUiFxhkqcs0dOiXWH+bDgxII8gSlNOaMpvXFIQe3ijLJ6rCqK
 5wWoqSItMYOkLCPxqSbM/VSUE0BCXbTV5mFNFM+NtheMHT6q9KDWat7dz3phmckV
 /kbYkuQyDITgMU8rLoaK9u9rd9GNoc+XCOMvKvex8vkp5S9gRaBoQSWtYPABVprh
 doiK0g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t6k06g6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:28:59 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2feb8d29740so3586795a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:28:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806938; x=1741411738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/i+ZUfqaP8JGue0A2xzcyNC25I/nrXf6rB9YDXOFk7s=;
 b=vOUeKB9rOobB0mvSU400xBjjM2qh2g/iRqagjBfsiMSWDAqkI4UxUqR94IJh4iQteh
 IVnHGwAZ4HH2MiKqpLhxFpD29UeQPLbiCQa+2bEZQtI9b/iMaJ05KpXe9RYhD6qQUgLA
 HhyHFfjdXlJuzYADhxb/e8iS0dINRsPwyWEtZdn+wjwmbLXkqSItoG+w6DXzBmTBuHnj
 3NVOyIR67hRq1G8j70I8Uxc22i8HJpUqPFrrOdDEBkrbVSXU1RfXVcPTtCjerVqjDMC5
 hLAn5WrhVOKe/ZR+rYmKv1+sYmS0XG9AGlqdWyMOJNMqW699HvvAvMn5LVL1LbWimJ6S
 QgiA==
X-Gm-Message-State: AOJu0Yz+fvEy9pV5DQXpIwdimPaq6pfqvvHAbRrUGg5dHVbLXgyDCzdK
 9zggJVbUNgxggldxPFLc+dmy71J74/EbwpbQSL2vy6iHb9JwirqZ4jYakv69KAnvNZJQpli9RX/
 jaVDpU5spkMgdBEIszDIXeiHmftSVBX8bbx2LiBrLuF8VLjoRqRqYXjgAHccr1A==
X-Gm-Gg: ASbGncuoblb2jO3r4a1alGsJDh3ANDY2xN36JjH5ZwAAbT/tnSCSKxtfUxqSGkD6xA7
 LL8J7+rEFwseiHlkxPgbRdbigs9ciAQL052ATUeIIlm6wrQW04huvif4j4IGHkOqbxUhbpdYNgB
 Mo/qoWGO/ocQP2SgL+6yao9r99ULS/t6sKRcThn7Vg1DYnrVtF6u78U9Hcd5a34pwVrHWRScZtm
 OLNTKAurAqmKVgQFQDZL6f90HrMVmy1pkjf5L579xHyrngNl3a/3j7+5b1M1mIhC9uXZOW28vDe
 tMRau3iR10xyTcnM/Ev848TLPS6Wq7BtxvU96OhXqrLF+kEVMgKV3dwbIqEKLZbV
X-Received: by 2002:a17:90b:4f44:b0:2fe:7f40:420a with SMTP id
 98e67ed59e1d1-2febab799f7mr10788751a91.17.1740806938616; 
 Fri, 28 Feb 2025 21:28:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH72kiKGN4dHuERv/u6L5H0eIF3oOIwgmpqzEVp5xfeok9+rQlarJqlcsYi/8jSZj9Lh5K7Gw==
X-Received: by 2002:a17:90b:4f44:b0:2fe:7f40:420a with SMTP id
 98e67ed59e1d1-2febab799f7mr10788714a91.17.1740806938177; 
 Fri, 28 Feb 2025 21:28:58 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:28:57 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 06/39] target/hexagon: Implement {g,s}etimask helpers
Date: Fri, 28 Feb 2025 21:28:12 -0800
Message-Id: <20250301052845.1012069-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: g7LLqfxHv0OfgXE0G344E7L4yWVyGOzq
X-Proofpoint-ORIG-GUID: g7LLqfxHv0OfgXE0G344E7L4yWVyGOzq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=452 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010040
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
b3BfaGVscGVyLmMgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiAxIGZpbGUg
Y2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmlu
ZGV4IDlmNzliMWEyMGMuLjgzMDg4Y2ZhYTMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xNDY4LDEyICsx
NDY4LDM5IEBAIHZvaWQgSEVMUEVSKHJlc3VtZSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQz
Ml90IG1hc2spCiAKIHVpbnQzMl90IEhFTFBFUihnZXRpbWFzaykoQ1BVSGV4YWdvblN0YXRlICpl
bnYsIHVpbnQzMl90IHRpZCkKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIENQ
VVN0YXRlICpjczsKKyAgICBDUFVfRk9SRUFDSChjcykgeworICAgICAgICBIZXhhZ29uQ1BVICpm
b3VuZF9jcHUgPSBIRVhBR09OX0NQVShjcyk7CisgICAgICAgIENQVUhleGFnb25TdGF0ZSAqZm91
bmRfZW52ID0gJmZvdW5kX2NwdS0+ZW52OworICAgICAgICBpZiAoZm91bmRfZW52LT50aHJlYWRJ
ZCA9PSB0aWQpIHsKKyAgICAgICAgICAgIHRhcmdldF91bG9uZyBpbWFzayA9IGFyY2hfZ2V0X3N5
c3RlbV9yZWcoZm91bmRfZW52LCBIRVhfU1JFR19JTUFTSyk7CisgICAgICAgICAgICBxZW11X2xv
Z19tYXNrKENQVV9MT0dfSU5ULCAiJXM6IHRpZCAlZCBpbWFzayA9IDB4JXhcbiIsCisgICAgICAg
ICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBlbnYtPnRocmVhZElkLAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAodW5zaWduZWQpR0VUX0ZJRUxEKElNQVNLX01BU0ssIGltYXNrKSk7Cisg
ICAgICAgICAgICByZXR1cm4gR0VUX0ZJRUxEKElNQVNLX01BU0ssIGltYXNrKTsKKyAgICAgICAg
fQorICAgIH0KKyAgICByZXR1cm4gMDsKIH0KIAogdm9pZCBIRUxQRVIoc2V0aW1hc2spKENQVUhl
eGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBwcmVkLCB1aW50MzJfdCBpbWFzaykKIHsKLSAgICBn
X2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIENQVVN0YXRlICpjczsKKworICAgIEJRTF9MT0NL
X0dVQVJEKCk7CisgICAgQ1BVX0ZPUkVBQ0goY3MpIHsKKyAgICAgICAgSGV4YWdvbkNQVSAqZm91
bmRfY3B1ID0gSEVYQUdPTl9DUFUoY3MpOworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKmZvdW5k
X2VudiA9ICZmb3VuZF9jcHUtPmVudjsKKworICAgICAgICBpZiAocHJlZCA9PSBmb3VuZF9lbnYt
PnRocmVhZElkKSB7CisgICAgICAgICAgICBTRVRfU1lTVEVNX0ZJRUxEKGZvdW5kX2VudiwgSEVY
X1NSRUdfSU1BU0ssIElNQVNLX01BU0ssIGltYXNrKTsKKyAgICAgICAgICAgIHFlbXVfbG9nX21h
c2soQ1BVX0xPR19JTlQsICIlczogdGlkICVkIGltYXNrIDB4JXhcbiIsCisgICAgICAgICAgICAg
ICAgICAgICAgICAgIF9fZnVuY19fLCBmb3VuZF9lbnYtPnRocmVhZElkLCBpbWFzayk7CisgICAg
ICAgICAgICBoZXhfaW50ZXJydXB0X3VwZGF0ZShlbnYpOworICAgICAgICAgICAgcmV0dXJuOwor
ICAgICAgICB9CisgICAgfQorICAgIGhleF9pbnRlcnJ1cHRfdXBkYXRlKGVudik7CiB9CiAKIHN0
YXRpYyBib29sIGhhbmRsZV9wbXVfc3JlZ193cml0ZShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWlu
dDMyX3QgcmVnLAotLSAKMi4zNC4xCgo=

