Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3305C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFQ7-00033c-22; Sat, 01 Mar 2025 00:29:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFQ0-0002WM-6S
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:44 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPy-0008Tc-FO
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:43 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213Gngi005403
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /ac62C4QIf3TDqEVKRceJfZ3NQ+seqv54H8kYQN3O6A=; b=LbqnXuu1DoxgxcOU
 5ehXuVCZkMtgTxDn1OjiXsee0wVq+qjgB9j1YCslx/2NeqdEmX1Yix4zo9j2NT2+
 U6+H+2e+ekUAY/9KZ9pwmI4K0QO86b1M+WzDB6UxNjezH1id8bt4Urk2PMMhWrKX
 Ujtue46edjNCRvhY29ANdn9TTHGA18m0tpN1MLRzD0vNywNW98ylDJyfMassTEuH
 yg2fZABILsiU+Nq2Ewn5pe7D4ol7vBu2xVcLuI3TwLaOXBgaPy1GUbALdE711bb/
 974GzwVv7sxvHv7/xPL0Gl53rhlWwBMlabY/n8+aZWS/y5PfiYKogKAkXGwD40TQ
 hno5Gg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t6k06je-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fe86c01f4aso5822015a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806970; x=1741411770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ac62C4QIf3TDqEVKRceJfZ3NQ+seqv54H8kYQN3O6A=;
 b=mZItysIfm34o+rqb0G0WvkduFcCAYa4hA2w++M0Ffoxs+mSiI+c+NLR/tQbPAdP03g
 WGZ4Q/aWzBl+F7upcvOK8iHQXg3bfJ/tEuRw0R4VGhbzbt6zT3zc2FXhPFHspdAHkveu
 KxVH9u49Bsd4TfqZRmgc/cm3n0/Hzosc89KjW6Rem2R/neViamzWNBxe9tM6l6nGM8LQ
 5MqJbb6n9fWVQd3Ilj1H2jH+kLrYwysc0JbMHknoYlnYFZOhOifmfaYAdvhYNjvtVeRO
 MHr0lo6FbU1MNqoj+2MSxHqbr6L64oBFyrQC9PEq+Rxo717ElYwvV1zzG8XSbfi/yP1D
 hxbA==
X-Gm-Message-State: AOJu0YxJltWO45Y1w+JEBa0Va29qH5ogNUMZqq/tVc5G0DVdnJlcByf8
 a4aqBq7v33wBYOA75lhdSuJ3EQCAgEQHy4royQhrDHwAbDVmiUCmLz8LX7krBD5BVe9FPNG9Zub
 ramS/CbqEzySdMH7g4vT7vj0bfS0yRFy7SQOrDlSKFyuQXTpXItCLM1It4ciD9g==
X-Gm-Gg: ASbGncs/xHw8m46/7RYpEBxN+dBQ1a41C5QCVLFyF6YOpNSAOlDWXcDIH8eCQMDVNWM
 cgCvnEllvO6hpkEl13yB8kRNMQnnlq+bDCOo+CglC7R9hJ2OtilfqyTSeRQ+BCgTyw6fQd28bX6
 uXOd5cWLBkKK0To7xHbhkLq6/hmlB6SFQhwIvjeWJZ1BMN2yN5TTzy14Bf7zHjSiNgFeQe3pFAO
 9gWe3K5TT9T/VLhS4IbaASsV8xnp6CK0dl/uvCMsA1EMCB1k8WhITXF6fDUZI6GhLZXUsHp3IJU
 cxBviIXo79NwkjqRkJFTwGJNdhb0CfHb1R+MVnv9fz7QpPFwNeUP0f8rFRzcaGb3
X-Received: by 2002:a17:90b:1b47:b0:2ee:c04a:4276 with SMTP id
 98e67ed59e1d1-2febab2eea1mr8846061a91.5.1740806970001; 
 Fri, 28 Feb 2025 21:29:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECq4LHXrqAA2NJ0nqFYCdYY9tUTvUCbUiaD+gCRKAKMNsSoNQU+4KVse0UJPAa0tbl8KAzeQ==
X-Received: by 2002:a17:90b:1b47:b0:2ee:c04a:4276 with SMTP id
 98e67ed59e1d1-2febab2eea1mr8846038a91.5.1740806969546; 
 Fri, 28 Feb 2025 21:29:29 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:29 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 31/39] target/hexagon: Add implicit sysreg writes
Date: Fri, 28 Feb 2025 21:28:37 -0800
Message-Id: <20250301052845.1012069-32-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: flM9e4hljdmsQRQCkAQJw863Po_tyCSZ
X-Proofpoint-ORIG-GUID: flM9e4hljdmsQRQCkAQJw863Po_tyCSZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=682 mlxscore=0
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
dHJhbnNsYXRlLmMgfCAxNiArKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFy
Z2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXggZDRiMjJhY2I3Mi4uZmY4ODFkMTA2MCAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMKQEAgLTQyNiw2ICs0MjYsMTYgQEAgc3RhdGljIHZvaWQgbWFya19pbXBsaWNp
dF9yZWdfd3JpdGUoRGlzYXNDb250ZXh0ICpjdHgsIGludCBhdHRyaWIsIGludCBybnVtKQogICAg
IH0KIH0KIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitzdGF0aWMgdm9pZCBtYXJrX2ltcGxp
Y2l0X3NyZWdfd3JpdGUoRGlzYXNDb250ZXh0ICpjdHgsIGludCBhdHRyaWIsIGludCBzbnVtKQor
eworICAgIHVpbnQxNl90IG9wY29kZSA9IGN0eC0+aW5zbi0+b3Bjb2RlOworICAgIGlmIChHRVRf
QVRUUklCKG9wY29kZSwgYXR0cmliKSkgeworICAgICAgICBjdHhfbG9nX3NyZWdfd3JpdGUoY3R4
LCBzbnVtKTsKKyAgICB9Cit9CisjZW5kaWYKKwogc3RhdGljIHZvaWQgbWFya19pbXBsaWNpdF9y
ZWdfd3JpdGVzKERpc2FzQ29udGV4dCAqY3R4KQogewogICAgIG1hcmtfaW1wbGljaXRfcmVnX3dy
aXRlKGN0eCwgQV9JTVBMSUNJVF9XUklURVNfRlAsICBIRVhfUkVHX0ZQKTsKQEAgLTQzNyw2ICs0
NDcsMTIgQEAgc3RhdGljIHZvaWQgbWFya19pbXBsaWNpdF9yZWdfd3JpdGVzKERpc2FzQ29udGV4
dCAqY3R4KQogICAgIG1hcmtfaW1wbGljaXRfcmVnX3dyaXRlKGN0eCwgQV9JTVBMSUNJVF9XUklU
RVNfU0ExLCBIRVhfUkVHX1NBMSk7CiAgICAgbWFya19pbXBsaWNpdF9yZWdfd3JpdGUoY3R4LCBB
X0lNUExJQ0lUX1dSSVRFU19VU1IsIEhFWF9SRUdfVVNSKTsKICAgICBtYXJrX2ltcGxpY2l0X3Jl
Z193cml0ZShjdHgsIEFfRlBPUCwgSEVYX1JFR19VU1IpOworCisjaWZuZGVmIENPTkZJR19VU0VS
X09OTFkKKyAgICBtYXJrX2ltcGxpY2l0X3NyZWdfd3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRF
U19TR1AwLCBIRVhfU1JFR19TR1AwKTsKKyAgICBtYXJrX2ltcGxpY2l0X3NyZWdfd3JpdGUoY3R4
LCBBX0lNUExJQ0lUX1dSSVRFU19TR1AxLCBIRVhfU1JFR19TR1AxKTsKKyAgICBtYXJrX2ltcGxp
Y2l0X3NyZWdfd3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19TU1IsIEhFWF9TUkVHX1NTUik7
CisjZW5kaWYKIH0KIAogc3RhdGljIHZvaWQgbWFya19pbXBsaWNpdF9wcmVkX3dyaXRlKERpc2Fz
Q29udGV4dCAqY3R4LCBpbnQgYXR0cmliLCBpbnQgcG51bSkKLS0gCjIuMzQuMQoK

