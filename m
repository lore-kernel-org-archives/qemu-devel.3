Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3A9C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPz-0002Qv-Lo; Sat, 01 Mar 2025 00:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPv-00024E-3v
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:39 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPt-0008Ul-28
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:38 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213KHTq007066
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g+UyZcX4bAUK+4tirk8dh2KZ5d43j5Zo+4gMsvAk25g=; b=Le3RHcXBNYet4+57
 21cTlUvJBtMsgV138vwrCda1PsKOX3FIeAo9VAAAXd9R710/xcAMvqozYPd8uGUw
 H0V6Zwvy6XmEpOLA3Qp7GVdtpbzWjyWVYQLn+rKd8O/JBF6uTQT/uN7c49AWdiYT
 Y/riHeX5I4veKbws7wW6yL0SBDxx8ZbVqqlFs4RL5bqDEszlIOkcD3iOkvVAdtS9
 2dSqImbwV1i6ia0/ZDGRXQ/aA2iewy/g5DBE3UHyIeQlRvNfVSFP+U/RQdu9G9wO
 lDwZrJugi/mohJes3+3gHYFlVr8GOf658wt76VCNAU038XLS37NUh1gHPCh5h1KI
 C/9I2g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t88r6dc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fe8de1297eso5818820a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806974; x=1741411774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+UyZcX4bAUK+4tirk8dh2KZ5d43j5Zo+4gMsvAk25g=;
 b=VDZW1W5bUBwOVOys++a5vgmEMl4wSJhd7LFvjQYM2VQA7EpGF3Oacnq5X/aV/FC9cA
 +iETgbpgdLJ2OX90K82XKC0F159Z+Xcd9pxw+7qGBm8LKflhfIB0/SVR7ulcN+gOph9Q
 iEkbKjpSrDc4eJc8FQjlcsiUKxQRl6spX2UvP8pKSijGWlNK8Q5qonwBEuQqSCH7eeu/
 ZLhYegF/6uejdzRakLcY+gohxSwxbKP06RsN5EQQrkMVHOPzHVla/vGbvlmLwD6U4hE+
 WegE7FYCG4OqgNfSBkMmHb8Ou0p6kfGCsJqAEiIhjOpfOSBSU51/YsTIsj2R9mmEWjpZ
 1mOA==
X-Gm-Message-State: AOJu0YxeddjiS470peZc6uqfAIhgYiok9+6KPrtDxFlVeoOQMZ5BlJp1
 0pkCFONlWjzYcqrCOqd1Oyi7RFfEFPc3D4/ZIPq+UJvNl2qsTFZBA1CQAE4fVuZeNUuhWelMtyY
 HutphWav9vtSitPeDWSMBmr4FJLPtKoAxUx2Qp3q8fc950S1axJLF5K2U59MezQ==
X-Gm-Gg: ASbGnct7Wu495ifsZ6CcmoVnAEeWSjhjPW/udCKvig2yPAByZcX3MSQl/FH5p2XfMto
 nZ/53//bTm4ayrLI7BFvlPyXEGD8Z3RzQpcdA/H10qWvvjl6DohKQ8DeMkc9IkTm1TknYk/ebR1
 NNJ0wzVrhUFwkPQoHtT5g2v+2R2QOCM9OIjCiBHVU0oYspJqWYDwinjwr3iqhhq8K0Pwi1Qjec1
 uTaBfSvF5R0ZwYhnoFAPkYYcLUPRZOSln3cGAlpxlva2Ql0Pvi6OuyJeKILx8+CqZ2SYedO5BfE
 p6ftTVarahUFAi7c+c8CB0uAo5IEuz+IUPeTJkuYgRF4fYGIFOhSq8glIFA+L93y
X-Received: by 2002:a17:90b:4ac6:b0:2f6:e47c:1750 with SMTP id
 98e67ed59e1d1-2feba9325ffmr10351063a91.13.1740806974513; 
 Fri, 28 Feb 2025 21:29:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzem81o/RziQDwlfTtxGeaMHumfRLa01xuM1ErnVW/o89RyJ6LbjylXHhZMZhK7Sf/K1e8ZQ==
X-Received: by 2002:a17:90b:4ac6:b0:2f6:e47c:1750 with SMTP id
 98e67ed59e1d1-2feba9325ffmr10351034a91.13.1740806974143; 
 Fri, 28 Feb 2025 21:29:34 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:33 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 34/39] target/hexagon: Add TLB, k0 {un,}lock
Date: Fri, 28 Feb 2025 21:28:40 -0800
Message-Id: <20250301052845.1012069-35-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: SbOeGx5QymZQFIdFNzdHSq7NGrQ4lLCV
X-Proofpoint-GUID: SbOeGx5QymZQFIdFNzdHSq7NGrQ4lLCV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=612 mlxscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503010040
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
c3lzX21hY3Jvcy5oIHwgICA4ICstLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgIHwgMTA0
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAx
MDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9zeXNfbWFjcm9zLmggYi90YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmgKaW5kZXggM2M0
YzNjN2FhNS4uZTVkYzFjZTBhYiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vc3lzX21hY3Jv
cy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaApAQCAtMTQzLDExICsxNDMsMTEg
QEAKICNkZWZpbmUgZkRDSU5WSURYKFJFRykKICNkZWZpbmUgZkRDSU5WQShSRUcpIGRvIHsgUkVH
ID0gUkVHOyB9IHdoaWxlICgwKSAvKiBOb3RoaW5nIHRvIGRvIGluIHFlbXUgKi8KIAotI2RlZmlu
ZSBmU0VUX1RMQl9MT0NLKCkgICAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKQotI2RlZmluZSBm
Q0xFQVJfVExCX0xPQ0soKSAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKQorI2RlZmluZSBmU0VU
X1RMQl9MT0NLKCkgICAgICAgaGV4X3RsYl9sb2NrKGVudik7CisjZGVmaW5lIGZDTEVBUl9UTEJf
TE9DSygpICAgICBoZXhfdGxiX3VubG9jayhlbnYpOwogCi0jZGVmaW5lIGZTRVRfSzBfTE9DSygp
ICAgICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpCi0jZGVmaW5lIGZDTEVBUl9LMF9MT0NLKCkg
ICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpCisjZGVmaW5lIGZTRVRfSzBfTE9DSygpICAgICAg
ICBoZXhfazBfbG9jayhlbnYpOworI2RlZmluZSBmQ0xFQVJfSzBfTE9DSygpICAgICAgaGV4X2sw
X3VubG9jayhlbnYpOwogCiAjZGVmaW5lIGZUTEJfSURYTUFTSyhJTkRFWCkgXAogICAgICgoSU5E
RVgpICYgKGZQT1cyX1JPVU5EVVAoZkNBU1Q0dShlbnZfYXJjaGNwdShlbnYpLT5udW1fdGxicykp
IC0gMSkpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9o
ZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDcwMmMzZGQzYzYuLmYzYjE0ZmJmNTggMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jCkBAIC0xMTg0LDYgKzExODQsMTEwIEBAIHZvaWQgSEVMUEVSKG1vZGlmeV9zc3IpKENQ
VUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBuZXcsIHVpbnQzMl90IG9sZCkKICAgICBCUUxf
TE9DS19HVUFSRCgpOwogICAgIGhleGFnb25fbW9kaWZ5X3NzcihlbnYsIG5ldywgb2xkKTsKIH0K
Kworc3RhdGljIHZvaWQgaGV4X2swX2xvY2soQ1BVSGV4YWdvblN0YXRlICplbnYpCit7CisgICAg
QlFMX0xPQ0tfR1VBUkQoKTsKKyAgICBnX2Fzc2VydCgoZW52LT5rMF9sb2NrX2NvdW50ID09IDAp
IHx8IChlbnYtPmswX2xvY2tfY291bnQgPT0gMSkpOworCisgICAgdWludDMyX3Qgc3lzY2ZnID0g
YXJjaF9nZXRfc3lzdGVtX3JlZyhlbnYsIEhFWF9TUkVHX1NZU0NGRyk7CisgICAgaWYgKEdFVF9T
WVNDRkdfRklFTEQoU1lTQ0ZHX0swTE9DSywgc3lzY2ZnKSkgeworICAgICAgICBpZiAoZW52LT5r
MF9sb2NrX3N0YXRlID09IEhFWF9MT0NLX1FVRVVFRCkgeworICAgICAgICAgICAgZW52LT5uZXh0
X1BDICs9IDQ7CisgICAgICAgICAgICBlbnYtPmswX2xvY2tfY291bnQrKzsKKyAgICAgICAgICAg
IGVudi0+azBfbG9ja19zdGF0ZSA9IEhFWF9MT0NLX09XTkVSOworICAgICAgICAgICAgU0VUX1NZ
U0NGR19GSUVMRChlbnYsIFNZU0NGR19LMExPQ0ssIDEpOworICAgICAgICAgICAgcmV0dXJuOwor
ICAgICAgICB9CisgICAgICAgIGlmIChlbnYtPmswX2xvY2tfc3RhdGUgPT0gSEVYX0xPQ0tfT1dO
RVIpIHsKKyAgICAgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLAorICAgICAg
ICAgICAgICAgICAgICAgICAgICAiRG91YmxlIGswbG9jayBhdCBQQzogMHgleCwgdGhyZWFkIG1h
eSBoYW5nXG4iLAorICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPm5leHRfUEMpOworICAg
ICAgICAgICAgZW52LT5uZXh0X1BDICs9IDQ7CisgICAgICAgICAgICBDUFVTdGF0ZSAqY3MgPSBl
bnZfY3B1KGVudik7CisgICAgICAgICAgICBjcHVfaW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBU
X0hBTFQpOworICAgICAgICAgICAgcmV0dXJuOworICAgICAgICB9CisgICAgICAgIGVudi0+azBf
bG9ja19zdGF0ZSA9IEhFWF9MT0NLX1dBSVRJTkc7CisgICAgICAgIENQVVN0YXRlICpjcyA9IGVu
dl9jcHUoZW52KTsKKyAgICAgICAgY3B1X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9IQUxU
KTsKKyAgICB9IGVsc2UgeworICAgICAgICBlbnYtPm5leHRfUEMgKz0gNDsKKyAgICAgICAgZW52
LT5rMF9sb2NrX2NvdW50Kys7CisgICAgICAgIGVudi0+azBfbG9ja19zdGF0ZSA9IEhFWF9MT0NL
X09XTkVSOworICAgICAgICBTRVRfU1lTQ0ZHX0ZJRUxEKGVudiwgU1lTQ0ZHX0swTE9DSywgMSk7
CisgICAgfQorCit9CisKK3N0YXRpYyB2b2lkIGhleF9rMF91bmxvY2soQ1BVSGV4YWdvblN0YXRl
ICplbnYpCit7CisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKyAgICBnX2Fzc2VydCgoZW52LT5rMF9s
b2NrX2NvdW50ID09IDApIHx8IChlbnYtPmswX2xvY2tfY291bnQgPT0gMSkpOworCisgICAgLyog
Tm90aGluZyB0byBkbyBpZiB0aGUgazAgaXNuJ3QgbG9ja2VkIGJ5IHRoaXMgdGhyZWFkICovCisg
ICAgdWludDMyX3Qgc3lzY2ZnID0gYXJjaF9nZXRfc3lzdGVtX3JlZyhlbnYsIEhFWF9TUkVHX1NZ
U0NGRyk7CisgICAgaWYgKChHRVRfU1lTQ0ZHX0ZJRUxEKFNZU0NGR19LMExPQ0ssIHN5c2NmZykg
PT0gMCkgfHwKKyAgICAgICAgKGVudi0+azBfbG9ja19zdGF0ZSAhPSBIRVhfTE9DS19PV05FUikp
IHsKKyAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsCisgICAgICAgICAgICAg
ICAgICAgICAgInRocmVhZCAlZCBhdHRlbXB0ZWQgdG8gdW5sb2NrIGswIHdpdGhvdXQgaGF2aW5n
IHRoZSAiCisgICAgICAgICAgICAgICAgICAgICAgImxvY2ssIGswX2xvY2sgc3RhdGUgPSAlZCwg
c3lzY2ZnOmswID0gJWRcbiIsCisgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCwg
ZW52LT5rMF9sb2NrX3N0YXRlLAorICAgICAgICAgICAgICAgICAgICAgIEdFVF9TWVNDRkdfRklF
TEQoU1lTQ0ZHX0swTE9DSywgc3lzY2ZnKSk7CisgICAgICAgIGdfYXNzZXJ0KGVudi0+azBfbG9j
a19zdGF0ZSAhPSBIRVhfTE9DS19XQUlUSU5HKTsKKyAgICAgICAgcmV0dXJuOworICAgIH0KKwor
ICAgIGVudi0+azBfbG9ja19jb3VudC0tOworICAgIGVudi0+azBfbG9ja19zdGF0ZSA9IEhFWF9M
T0NLX1VOTE9DS0VEOworICAgIFNFVF9TWVNDRkdfRklFTEQoZW52LCBTWVNDRkdfSzBMT0NLLCAw
KTsKKworICAgIC8qIExvb2sgZm9yIGEgdGhyZWFkIHRvIHVubG9jayAqLworICAgIHVuc2lnbmVk
IGludCB0aGlzX3RocmVhZElkID0gZW52LT50aHJlYWRJZDsKKyAgICBDUFVIZXhhZ29uU3RhdGUg
KnVubG9ja190aHJlYWQgPSBOVUxMOworICAgIENQVVN0YXRlICpjczsKKyAgICBDUFVfRk9SRUFD
SChjcykgeworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKnRocmVhZCA9IGNwdV9lbnYoY3MpOwor
CisgICAgICAgIC8qCisgICAgICAgICAqIFRoZSBoYXJkd2FyZSBpbXBsZW1lbnRzIHJvdW5kLXJv
YmluIGZhaXJuZXNzLCBzbyB3ZSBsb29rIGZvciB0aHJlYWRzCisgICAgICAgICAqIHN0YXJ0aW5n
IGF0IGVudi0+dGhyZWFkSWQgKyAxIGFuZCBpbmNyZW1lbnRpbmcgbW9kdWxvIHRoZSBudW1iZXIg
b2YKKyAgICAgICAgICogdGhyZWFkcy4KKyAgICAgICAgICoKKyAgICAgICAgICogVG8gaW1wbGVt
ZW50IHRoaXMsIHdlIGNoZWNrIGlmIHRocmVhZCBpcyBhIGVhcmxpZXIgaW4gdGhlIG1vZHVsbwor
ICAgICAgICAgKiBzZXF1ZW5jZSB0aGFuIHVubG9ja190aHJlYWQuCisgICAgICAgICAqICAgICBp
ZiB1bmxvY2sgdGhyZWFkIGlzIGhpZ2hlciB0aGFuIHRoaXMgdGhyZWFkCisgICAgICAgICAqICAg
ICAgICAgdGhyZWFkIG11c3QgYmUgYmV0d2VlbiB0aGlzIHRocmVhZCBhbmQgdW5sb2NrX3RocmVh
ZAorICAgICAgICAgKiAgICAgZWxzZQorICAgICAgICAgKiAgICAgICAgIHRocmVhZCBoaWdoZXIg
dGhhbiB0aGlzIHRocmVhZCBpcyBhaGVhZCBvZiB1bmxvY2tfdGhyZWFkCisgICAgICAgICAqICAg
ICAgICAgdGhyZWFkIG11c3QgYmUgbG93ZXIgdGhlbiB1bmxvY2sgdGhyZWFkCisgICAgICAgICAq
LworICAgICAgICBpZiAodGhyZWFkLT5rMF9sb2NrX3N0YXRlID09IEhFWF9MT0NLX1dBSVRJTkcp
IHsKKyAgICAgICAgICAgIGlmICghdW5sb2NrX3RocmVhZCkgeworICAgICAgICAgICAgICAgIHVu
bG9ja190aHJlYWQgPSB0aHJlYWQ7CisgICAgICAgICAgICB9IGVsc2UgaWYgKHVubG9ja190aHJl
YWQtPnRocmVhZElkID4gdGhpc190aHJlYWRJZCkgeworICAgICAgICAgICAgICAgIGlmICh0aGlz
X3RocmVhZElkIDwgdGhyZWFkLT50aHJlYWRJZCAmJgorICAgICAgICAgICAgICAgICAgICB0aHJl
YWQtPnRocmVhZElkIDwgdW5sb2NrX3RocmVhZC0+dGhyZWFkSWQpIHsKKyAgICAgICAgICAgICAg
ICAgICAgdW5sb2NrX3RocmVhZCA9IHRocmVhZDsKKyAgICAgICAgICAgICAgICB9CisgICAgICAg
ICAgICB9IGVsc2UgeworICAgICAgICAgICAgICAgIGlmICh0aHJlYWQtPnRocmVhZElkID4gdGhp
c190aHJlYWRJZCkgeworICAgICAgICAgICAgICAgICAgICB1bmxvY2tfdGhyZWFkID0gdGhyZWFk
OworICAgICAgICAgICAgICAgIH0KKyAgICAgICAgICAgICAgICBpZiAodGhyZWFkLT50aHJlYWRJ
ZCA8IHVubG9ja190aHJlYWQtPnRocmVhZElkKSB7CisgICAgICAgICAgICAgICAgICAgIHVubG9j
a190aHJlYWQgPSB0aHJlYWQ7CisgICAgICAgICAgICAgICAgfQorICAgICAgICAgICAgfQorICAg
ICAgICB9CisgICAgfQorICAgIGlmICh1bmxvY2tfdGhyZWFkKSB7CisgICAgICAgIGNzID0gZW52
X2NwdSh1bmxvY2tfdGhyZWFkKTsKKyAgICAgICAgdW5sb2NrX3RocmVhZC0+azBfbG9ja19zdGF0
ZSA9IEhFWF9MT0NLX1FVRVVFRDsKKyAgICAgICAgU0VUX1NZU0NGR19GSUVMRCh1bmxvY2tfdGhy
ZWFkLCBTWVNDRkdfSzBMT0NLLCAxKTsKKyAgICAgICAgY3B1X2ludGVycnVwdChjcywgQ1BVX0lO
VEVSUlVQVF9LMF9VTkxPQ0spOworICAgIH0KKworfQogI2VuZGlmCiAKIAotLSAKMi4zNC4xCgo=

