Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89970C282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFQ2-0002lz-Ue; Sat, 01 Mar 2025 00:29:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPy-0002OT-Ib
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:42 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPw-0008VU-Ol
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:42 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213KIX3007085
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 agl+X7U3TeTeYgu+MUvUQYl9XGWMQ3XQNHFltF38jOw=; b=A8t51reKOhnZ6iEF
 8HoiPpH+0kVa8L4LyuQl/B8fatYBbfn5Dzc3g6860LNcPKk/5/ODbbe+iffXQ2jI
 L5itZ9EDYgcq2xRlZwX/qwpcM+R0xwvkkD+oCDobGjcYT7dGYDlVpJXWrAoZwGBR
 zUa368rgbXWmYy2TqT6HK2jWx8eCSyfR04iQ8aBfdIuWOBX4uaV0eOM/hUN5kgq+
 F4K3wfWsy5sfy8pw57jESBITtPZbnIWIbsdXPmbodQUBhwgI1jCwNNbrrJRRLwvN
 bTKa0JPeYkc9HAdkuNARvKnfPbMYdjqZt7xO7A//BvUCXqdxI+TdtQ8b20xpeXUy
 Zjecng==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t88r6dk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:39 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2feb47c6757so3929158a91.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806978; x=1741411778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=agl+X7U3TeTeYgu+MUvUQYl9XGWMQ3XQNHFltF38jOw=;
 b=wPOxYnE7Qhh6aPhd8egLXpwSzNzsaBYd/Y52dfxsPFy6mlK1uQCwfaG5+Kel5CijT/
 YuvfJMCdI7NHjvev4ne0/o9WYlOXqfbuIOaQP7a7J2zxQEKIcJQm0w2/5AJV0EMrHLEB
 wsbS6i7mO66/a2zZnvQ3K78ccdW5N/9OOGK+n3zG4E5pwmrxmDuXGL/+zL1sbisPri79
 qCJmIMcGPmIknTaiE6SQOnTDAl166AhBITjycqDlGi1bhljYNkyBWqMOelgxs++cj7Rk
 ItFed8YXB3kllwrgeg++tSJshe1J1jRoX8oNwF5OPeRfFdfUKYu9xEybru4DTJloROQT
 2WrQ==
X-Gm-Message-State: AOJu0Yzf+G9l6ONlpZ6Tn/tDKEXVGpcLTusTXMTqR3hR83rLJ9xrg9e9
 CR9+3BxrQsFklo4cSKJcArSpIq2HSy1kmWpnG6uic317A8OnGtdvCLBfQec1CaQwfxtECyCwDE0
 40Y+/daWYlDaPlfo080iLA2vj6+aiZSV0Bk9N30d8F048unv8x4P73DWqZUsfaA==
X-Gm-Gg: ASbGncv24g35JRKOt8ZTILKiCwbAiBqb8ToZ9b2OMGQmFmPvr5oa4YB33HzcaZOUSKQ
 20wtyOK7v46xlaBS14aZcHtXL/yt5kCAcYFxV7r/Gz+TSut2Gvb2PP1Fw8V8P4wcOcrWWWF6mxO
 30BiUicy8cJcPdLNkS24Ct1dyfU/2EXE0Up4uEfUz3hYmE3s02SmMq3/bwS3O1VyzMtzKcWtg2M
 d2nHWk8wVWj7Kj9yCtzeVCBVCBcr3sUqibFL++hLY6GEssKVZAaIB/H/lAnP4XOORAd8Wg1H7r8
 sfjRBLrFSGTs5/jnoUd1PTLk6kWb4hyW688AX4l1OTfYH+k9FVWOWwXX6DOgLZ+L
X-Received: by 2002:a17:90a:e7d2:b0:2fe:8a84:e033 with SMTP id
 98e67ed59e1d1-2febab1f4c1mr10180440a91.2.1740806978358; 
 Fri, 28 Feb 2025 21:29:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyDjB8yxKn0F2tCJkUHO+cVsJWag26XFsB9IntHpmfVTwcfHMe0g3Krg76JcVyFfig7sfEug==
X-Received: by 2002:a17:90a:e7d2:b0:2fe:8a84:e033 with SMTP id
 98e67ed59e1d1-2febab1f4c1mr10180423a91.2.1740806977988; 
 Fri, 28 Feb 2025 21:29:37 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:37 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 37/39] target/hexagon: Add support for loadw_phys
Date: Fri, 28 Feb 2025 21:28:43 -0800
Message-Id: <20250301052845.1012069-38-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: gu2IAcS2YThlzHqJyG8Ab8QgWhtjZtpN
X-Proofpoint-GUID: gu2IAcS2YThlzHqJyG8Ab8QgWhtjZtpN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=792 mlxscore=0 clxscore=1015 adultscore=0
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
aGV4X2NvbW1vbi5weSAgICAgICAgICB8IDMgKysrCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9l
bmNvZGVfcHAuZGVmIHwgMSArCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9sZHN0LmlkZWYgICAg
IHwgMyArKysKIDMgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSBiL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24u
cHkKaW5kZXggN2I1YmIyY2Q0Ni4uNWU4NGVmYjQwMyAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaGV4X2NvbW1vbi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CkBAIC0y
NjYsNiArMjY2LDkgQEAgZGVmIG5lZWRfc2xvdCh0YWcpOgogICAgICAgICBhbmQgIkFfQ1ZJX0dB
VEhFUiIgbm90IGluIGF0dHJpYmRpY3RbdGFnXQogICAgICAgICBhbmQgKCJBX1NUT1JFIiBpbiBh
dHRyaWJkaWN0W3RhZ10KICAgICAgICAgICAgICBvciAiQV9MT0FEIiBpbiBhdHRyaWJkaWN0W3Rh
Z10pCisgICAgICAgIGFuZCB0YWcgIT0gIkw0X2xvYWR3X3BoeXMiCisgICAgICAgIGFuZCB0YWcg
IT0gIkw2X21lbWNweSIKKyAgICAgICAgYW5kIHRhZyAhPSAiWTZfZG1saW5rIgogICAgICk6CiAg
ICAgICAgIHJldHVybiAxCiAgICAgZWxzZToKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2lt
cG9ydGVkL2VuY29kZV9wcC5kZWYgYi90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9lbmNvZGVfcHAu
ZGVmCmluZGV4IDM3ZmFmNjJiMWIuLjQxZTRhYjllM2EgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL2ltcG9ydGVkL2VuY29kZV9wcC5kZWYKKysrIGIvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQv
ZW5jb2RlX3BwLmRlZgpAQCAtMzg4LDYgKzM4OCw3IEBAIERFRl9FTkMzMihMNF9yZXR1cm5fZm5l
d19wbnQsIElDTEFTU19MRCIgMDExIDAgMDAwIHNzc3NzIFBQMTAxMHZ2IC0tLWRkZGRkIikKIAog
LyoqIExvYWQgQWNxdWlyZSBTdG9yZSBSZWxlYXNlIEVuY29kaW5nICoqLwogCitERUZfRU5DMzIo
TDRfbG9hZHdfcGh5cywgICAgICBJQ0xBU1NfTEQiIDAwMSAwIDAwMCBzc3NzcyBQUDF0dHR0dCAt
MDBkZGRkZCIpCiBERUZfRU5DMzIoTDJfbG9hZHdfbG9ja2VkLCAgICBJQ0xBU1NfTEQiIDAwMSAw
IDAwMCBzc3NzcyBQUDAwMC0tLSAwMDBkZGRkZCIpCiBERUZfRU5DMzIoTDRfbG9hZGRfbG9ja2Vk
LCAgICBJQ0xBU1NfTEQiIDAwMSAwIDAwMCBzc3NzcyBQUDAxMC0tLSAwMDBkZGRkZCIpCiAKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2xkc3QuaWRlZiBiL3RhcmdldC9oZXhh
Z29uL2ltcG9ydGVkL2xkc3QuaWRlZgppbmRleCA1MzE5ODE3NmE5Li40ZTFlNWQ1MzI2IDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9sZHN0LmlkZWYKKysrIGIvdGFyZ2V0L2hl
eGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmCkBAIC0yMDMsNiArMjAzLDkgQEAgUTZJTlNOKFMyX3N0
b3Jld19sb2NrZWQsIm1lbXdfbG9ja2VkKFJzMzIsUGQ0KT1SdDMyIiwgQVRUUklCUyhBX1JFR1dS
U0laRV80QixBX00KIFE2SU5TTihMNF9sb2FkZF9sb2NrZWQsIlJkZDMyPW1lbWRfbG9ja2VkKFJz
MzIpIiwgQVRUUklCUyhBX1JFR1dSU0laRV84QixBX01FTVNJWkVfOEIsQV9MT0FELEFfUkVTVFJJ
Q1RfU0xPVDBPTkxZLEFfUkVTVFJJQ1RfUEFDS0VUX0FYT0ssQV9OT1RFX0FYT0spLCAiTG9hZCBk
b3VibGUgd2l0aCBsb2NrIiwKIHsgZkVBX1JFRyhSc1YpOyBmTE9BRF9MT0NLRUQoMSw4LHUsRUEs
UmRkVikgfSkKIAorUTZJTlNOKEw0X2xvYWR3X3BoeXMsIlJkMzI9bWVtd19waHlzKFJzMzIsUnQz
MikiLCBBVFRSSUJTKEFfUkVHV1JTSVpFXzRCLEFfUFJJVixBX1JFU1RSSUNUX1NMT1QwT05MWSxB
X05PVEVfUFJJVixBX01FTVNJWkVfNEIsQV9MT0FELEFfTk9URV9OT1BBQ0tFVCxBX1JFU1RSSUNU
X05PUEFDS0VUKSwgIkxvYWQgd29yZCBmcm9tIHBoeXNpY2FsIGFkZHJlc3MiLAoreyBmTE9BRF9Q
SFlTKDEsNCx1LFJzVixSdFYsUmRWKTsgfSkKKwogUTZJTlNOKFM0X3N0b3JlZF9sb2NrZWQsIm1l
bWRfbG9ja2VkKFJzMzIsUGQ0KT1SdHQzMiIsIEFUVFJJQlMoQV9SRUdXUlNJWkVfOEIsQV9NRU1T
SVpFXzhCLEFfU1RPUkUsQV9SRVNUUklDVF9TTE9UME9OTFksQV9SRVNUUklDVF9QQUNLRVRfQVhP
SyxBX05PVEVfQVhPSyxBX1JFU1RSSUNUX0xBVEVQUkVELEFfTk9URV9MQVRFUFJFRCksICJTdG9y
ZSB3b3JkIHdpdGggbG9jayIsCiB7IGZFQV9SRUcoUnNWKTsgZlNUT1JFX0xPQ0tFRCgxLDgsRUEs
UnR0VixQZFYpIH0pCiAKLS0gCjIuMzQuMQoK

