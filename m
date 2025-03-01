Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7047AC282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPJ-0007yM-Lz; Sat, 01 Mar 2025 00:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPG-0007qP-68
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:28:58 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPE-0008MM-IA
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:28:57 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213YXod030222
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q6tvz5dyJK9M2bYfP4Va0345pL/Ta6URQpUynRhKtnA=; b=WCgFoyKFJy8qlaNC
 WxymUZkaUQiWNd3vx5cY4q05Im47LCWP00lMzJgymKFK0/SDHM8rr2yIJkUhZ7Rx
 F+c/vttI8erVCu4yDzqXZxHTrkWsV5EIIgqLWVPFJFLNw9jwj6lxkXVWawWWb1GS
 31O3qfgdiJH1ZxwF+xllft/HGGUxug2w2bqZ4BAE/Fa1MOPNgrk03mGJz5OPdY8Z
 xTsccCfB/Vw1MB2Hs0UZaWObUYo5BsmGD8vhV52et1eYIHIUsnFN4A2WIKQyf9NS
 FEz+3qYgaI8RY3TiQ0IKIwYwOBPg1pP8VosqiPlZX/cnapyAF64sg9KkIGv4+5bf
 IF4Tug==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tf0g5c8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:28:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2feda472a4aso461528a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806934; x=1741411734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q6tvz5dyJK9M2bYfP4Va0345pL/Ta6URQpUynRhKtnA=;
 b=lSY6KhxHCXrHKqq2d857bfK4pBMs53mXOrkyzSbl2llsaG1Q+VNLeN05nJjz7BoLBN
 Dqxi7xQpfbt8CGW/ictHcVLVrAvQniMhafXYzRsHl5bbnj/+Omet+SN20CGPPVTgb4Yh
 9L8sI/zUshF5lVDhFlBOnHqj1JEIvzQ3oC0F7QWKRuPVNL+2n28HI8N7mEmv6Qaj2IWZ
 vWWZQgtPH+VdIOBKZhVJhHuF6ukx0W/2/KTJ3bwMZVMFhI1c3NfKU+4tcORt3r8odewN
 IoQPvBKWl6BfkoQUuXKC//m9XqZB7Ax0KmhxzBEINRonP2J11Hc4Y1TRwwIWaD0D8Ojs
 JSOg==
X-Gm-Message-State: AOJu0Yz+vOk+EtOs9nRdJqsZGLIRIabSSfRHzIJRs20hlQDVdigvKixp
 BFLMtwSeAt1r6IwCgyqXw5aT/89UNhP7bcbJNVCdSPOvmLfxhuWCxtZnEzvRmueRtKGJMcuqOLK
 6RNxewmeOHX5e0Cqk1xFhBkEZBoYx9kpcjO+GjE1feTfaqmgL2h0zo5n4gcw0Tw==
X-Gm-Gg: ASbGncso7Cw6zFLOqN9fBrVj0mzP91wGBL7yYb81NA47ayHp5+hMXjvbdmNY2tuCSVS
 o50ve5e9cthD+9C8MtfhJqIIsgg/e12zQglekJ6IUZXGf4vBlarmC5z62uT0i1JR0GoVFt1DSfB
 5bO12kX5RU35w7h8PRNYjW4x8HgNK7guXaGm+cNMMei19JdAdh/Kh6R3EaADl4bDWjKgZctAPrJ
 RLzg50PlH1ZsWzleGUP+vIac5ZX0mSzs3gCwSB6BEDlTXkMyAJszHAI888JVU3OZcikidGyFpZ7
 Wa3/TXp0FSzyBzqHseapCVuZpxLkRu+ld8r69N4OnVnZj4C0Jl6Ypm3QLBPyaAcb
X-Received: by 2002:a17:90b:35ce:b0:2fe:9ff7:a053 with SMTP id
 98e67ed59e1d1-2febabcb0d3mr7724099a91.23.1740806934095; 
 Fri, 28 Feb 2025 21:28:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQ+bTPvkJjdUgo0abY3wmlOqazZ0EKa8bt6bpjkfx+RztUU7EBy2ii5DEt1Hgy7BZptQ5FBg==
X-Received: by 2002:a17:90b:35ce:b0:2fe:9ff7:a053 with SMTP id
 98e67ed59e1d1-2febabcb0d3mr7724075a91.23.1740806933773; 
 Fri, 28 Feb 2025 21:28:53 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:28:53 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 03/39] target/hexagon: Implement iassign{r,w} helpers
Date: Fri, 28 Feb 2025 21:28:09 -0800
Message-Id: <20250301052845.1012069-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: PLcTqxeiPuQiJYAsITK6IbvJq_TXu305
X-Proofpoint-ORIG-GUID: PLcTqxeiPuQiJYAsITK6IbvJq_TXu305
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=659
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgppYXNzaWdue3Isd30gYXJlIHRo
ZSAiSW50ZXJydXB0IHRvIHRocmVhZCBhc3NpZ25tZW50IHtyZWFkLHdyaXRlfSIKaW5zdHJ1Y3Rp
b25zLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0u
Y29tPgotLS0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgNDggKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5j
IGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggZmVkNWNjMjcxNS4uZGVkNmM4MGQ2
MiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hl
eGFnb24vb3BfaGVscGVyLmMKQEAgLTEzOTQsMTIgKzEzOTQsNTYgQEAgdm9pZCBIRUxQRVIoY3N3
aSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spCiAKIHZvaWQgSEVMUEVSKGlh
c3NpZ253KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3JjKQogewotICAgIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgdWludDMyX3QgbW9kZWN0bDsKKyAgICB1aW50MzJfdCB0
aHJlYWRfZW5hYmxlZF9tYXNrOworICAgIENQVVN0YXRlICpjcHU7CisKKyAgICBCUUxfTE9DS19H
VUFSRCgpOworICAgIG1vZGVjdGwgPSBhcmNoX2dldF9zeXN0ZW1fcmVnKGVudiwgSEVYX1NSRUdf
TU9ERUNUTCk7CisgICAgdGhyZWFkX2VuYWJsZWRfbWFzayA9IEdFVF9GSUVMRChNT0RFQ1RMX0Us
IG1vZGVjdGwpOworCisgICAgQ1BVX0ZPUkVBQ0goY3B1KSB7CisgICAgICAgIENQVUhleGFnb25T
dGF0ZSAqdGhyZWFkX2VudiA9ICYoSEVYQUdPTl9DUFUoY3B1KS0+ZW52KTsKKyAgICAgICAgdWlu
dDMyX3QgdGhyZWFkX2lkX21hc2sgPSAweDEgPDwgdGhyZWFkX2Vudi0+dGhyZWFkSWQ7CisgICAg
ICAgIGlmICh0aHJlYWRfZW5hYmxlZF9tYXNrICYgdGhyZWFkX2lkX21hc2spIHsKKyAgICAgICAg
ICAgIHVpbnQzMl90IGltYXNrID0gYXJjaF9nZXRfc3lzdGVtX3JlZyh0aHJlYWRfZW52LCBIRVhf
U1JFR19JTUFTSyk7CisgICAgICAgICAgICB1aW50MzJfdCBpbnRiaXRwb3MgPSAoc3JjID4+IDE2
KSAmIDB4RjsKKyAgICAgICAgICAgIHVpbnQzMl90IHZhbCA9IChzcmMgPj4gdGhyZWFkX2Vudi0+
dGhyZWFkSWQpICYgMHgxOworICAgICAgICAgICAgaW1hc2sgPSBkZXBvc2l0MzIoaW1hc2ssIGlu
dGJpdHBvcywgMSwgdmFsKTsKKyAgICAgICAgICAgIGFyY2hfc2V0X3N5c3RlbV9yZWcodGhyZWFk
X2VudiwgSEVYX1NSRUdfSU1BU0ssIGltYXNrKTsKKworICAgICAgICAgICAgcWVtdV9sb2dfbWFz
ayhDUFVfTE9HX0lOVCwgIiVzOiB0aHJlYWQgIiBUQVJHRVRfRk1UX2xkCisgICAgICAgICAgICAg
ICAiLCBuZXcgaW1hc2sgMHglIiBQUkl4MzIgIlxuIiwgX19mdW5jX18sCisgICAgICAgICAgICAg
ICB0aHJlYWRfZW52LT50aHJlYWRJZCwgaW1hc2spOworICAgICAgICB9CisgICAgfQorICAgIGhl
eF9pbnRlcnJ1cHRfdXBkYXRlKGVudik7CiB9CiAKIHVpbnQzMl90IEhFTFBFUihpYXNzaWduciko
Q1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNyYykKIHsKLSAgICBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOworICAgIHVpbnQzMl90IG1vZGVjdGw7CisgICAgdWludDMyX3QgdGhyZWFkX2Vu
YWJsZWRfbWFzazsKKyAgICB1aW50MzJfdCBpbnRiaXRwb3M7CisgICAgdWludDMyX3QgZGVzdF9y
ZWc7CisgICAgQ1BVU3RhdGUgKmNwdTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgbW9k
ZWN0bCA9IGFyY2hfZ2V0X3N5c3RlbV9yZWcoZW52LCBIRVhfU1JFR19NT0RFQ1RMKTsKKyAgICB0
aHJlYWRfZW5hYmxlZF9tYXNrID0gR0VUX0ZJRUxEKE1PREVDVExfRSwgbW9kZWN0bCk7CisgICAg
Lyogc3JjIGZpZWxkcyBhcmUgaW4gc2FtZSBwb3NpdGlvbiBhcyBtb2RlY3RsLCBidXQgbWVhbiBk
aWZmZXJlbnQgdGhpbmdzICovCisgICAgaW50Yml0cG9zID0gR0VUX0ZJRUxEKE1PREVDVExfVywg
c3JjKTsKKyAgICBkZXN0X3JlZyA9IDA7CisgICAgQ1BVX0ZPUkVBQ0goY3B1KSB7CisgICAgICAg
IENQVUhleGFnb25TdGF0ZSAqdGhyZWFkX2VudiA9ICYoSEVYQUdPTl9DUFUoY3B1KS0+ZW52KTsK
KyAgICAgICAgdWludDMyX3QgdGhyZWFkX2lkX21hc2sgPSAweDEgPDwgdGhyZWFkX2Vudi0+dGhy
ZWFkSWQ7CisgICAgICAgIGlmICh0aHJlYWRfZW5hYmxlZF9tYXNrICYgdGhyZWFkX2lkX21hc2sp
IHsKKyAgICAgICAgICAgIHVpbnQzMl90IGltYXNrID0gYXJjaF9nZXRfc3lzdGVtX3JlZyh0aHJl
YWRfZW52LCBIRVhfU1JFR19JTUFTSyk7CisgICAgICAgICAgICBkZXN0X3JlZyB8PSAoKGltYXNr
ID4+IGludGJpdHBvcykgJiAweDEpIDw8IHRocmVhZF9lbnYtPnRocmVhZElkOworICAgICAgICB9
CisgICAgfQorCisgICAgcmV0dXJuIGRlc3RfcmVnOwogfQogCiB2b2lkIEhFTFBFUihzdGFydCko
Q1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IGltYXNrKQotLSAKMi4zNC4xCgo=

