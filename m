Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEB2C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFPq-0001XR-V4; Sat, 01 Mar 2025 00:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPo-0001L3-Ek
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:32 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPl-0008Pq-EF
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:32 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214m84I020607
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XD3ZkXuKWVFY8OJZhC6pipt+n+lknNaJrmpDhRmf/Ns=; b=bLbHpYCSRQdIYzGx
 87GIDzJlz7dMCdmqUDzL2dohul2aMEtFhIiaczLXh8Qv7yE5f3qmU6t64lxmnlG5
 +TDFRK/AarNGdpeZ1o6DUhvdkAojGsjo8lh+8zlzNR71ls7dIWpdRiWPblkjk+IY
 lmo8hgGZaK2vEQOVLIN09pOJ/dN68ai3VyA6DVju3CDcbgXX4zfdRoL0RiLWBN62
 PxHzhgy3PTgEy8XckHe6ri9LSiGeIH+2iuqyncxopiOalJpbK7DzbMc2loh0hvCB
 UygpI6rGVH9kZBuKxkLoP3COzLYmzI4RJPwseFxd4nZNP4V1UfhgIqDAFCC87OnI
 fZq1lQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453uh701yd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fe8de1297eso5818619a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806957; x=1741411757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XD3ZkXuKWVFY8OJZhC6pipt+n+lknNaJrmpDhRmf/Ns=;
 b=BZ/s5ySpWx7qkelhPCcPs006Asz8m3qsRe1jF3E8T+LtkW8lz0rNhykOuXpCU78rxF
 5TeMw11yXg+gJKbwPQ0gIMXaQ6IJfuoCIwm569v98UbOlAau5qNdLePMhmaQxjNJqp9u
 lSZKyo/skeuxTH348hfBPWbwHkn71mIi8DB0IYBM2X6dJyZi9qsDlwXD2VpocPx/faXI
 CHV8sQjAnByX4pSAUBUw7rH+CsJtinQ7eHue09ekrh4Tw0nYQfxVElckVFm/gSUSflTT
 MmrRp1oVuIHjskxrn+tTTAEAX+M2YA28XR/aIHoxCe+k5qaiDInx0zIKWYGecU3M7YBV
 XY3A==
X-Gm-Message-State: AOJu0YxUOZmPiUMRRFcUvGFxew7lfVPEIg0fpDF40NcuF5BE/XvZNJx2
 qYD8tMwepo/26i0RXUsOsCRGfFwAi335U77mIzy5Jqzt7nTuDaT7QCrW0TJVF5wR7FaCqN4rCMh
 NsgYxzXJUEqL6jfQYdLrYPaMEn+9BVqyl9WdKHW/y84MdhPe9jgN/i689N2xMMg==
X-Gm-Gg: ASbGncubXwMKLxAGtXQtza+24X/MKPWATZ+/iwLFd1cvWv9QOQwAzVpbEEiyes5BvTE
 GFq7tUCPTjQBmSg3mO+tUKdrL9KhO8MCRRyWBLePmsXs8GTkUoSuTwDl2qSLSIUYPer1RseFpC6
 DPly/9nRVoB6peMAf8J5NopFIITd+l44Te3+jWcjekxkLh4esxrMGYYA4/pZfoNjFhLFjUIY6XB
 biJpkdJiEEIsknxHXiRl+0sCLoOJCiuW18sfUuP4rtuLWmjsYpYjcCuiLJyKUWNe7RbqzHEgOfY
 4MA98gYL5IfExhJVlN51AATdmJrGbJ2P7zoI8ilXyP7kgSKKyY/745KSctmtI//b
X-Received: by 2002:a17:90b:3dc6:b0:2ef:ad48:7175 with SMTP id
 98e67ed59e1d1-2fea1364c29mr17044885a91.15.1740806957148; 
 Fri, 28 Feb 2025 21:29:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwktZbLVBpkDXekZBn/IvL54R0bM8JJgcI3UnmqfiN6Cib5kgUwjuxwhtMGQRaPNloKLHezQ==
X-Received: by 2002:a17:90b:3dc6:b0:2ef:ad48:7175 with SMTP id
 98e67ed59e1d1-2fea1364c29mr17044856a91.15.1740806956781; 
 Fri, 28 Feb 2025 21:29:16 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:16 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 21/39] target/hexagon: Implement hexagon_resume_threads()
Date: Fri, 28 Feb 2025 21:28:27 -0800
Message-Id: <20250301052845.1012069-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: ouXOlrykH_dEXYcbcy6Cmj6Z8L5NcDDK
X-Proofpoint-ORIG-GUID: ouXOlrykH_dEXYcbcy6Cmj6Z8L5NcDDK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=613 classifier=spam adjust=0 reason=mlx scancount=1
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
Y3B1LmggICAgICAgIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5oIHwgIDEgKwog
dGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIHwgMzcgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgIHwgIDMgKystCiA0IGZp
bGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IGQyOGMx
MjQ5ZjMuLmJhYTQ4ZWMwNTEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBi
L3RhcmdldC9oZXhhZ29uL2NwdS5oCkBAIC00NSw2ICs0NSw3IEBAIHR5cGVkZWYgc3RydWN0IENQ
VUhleGFnb25UTEJDb250ZXh0IENQVUhleGFnb25UTEJDb250ZXh0OwogI2RlZmluZSBSRUdfV1JJ
VEVTX01BWCAzMgogI2RlZmluZSBQUkVEX1dSSVRFU19NQVggNSAgICAgICAgICAgICAgICAgICAv
KiA0IGluc25zICsgZW5kbG9vcCAqLwogI2RlZmluZSBWU1RPUkVTX01BWCAyCisjZGVmaW5lIFRI
UkVBRFNfTUFYIDgKICNkZWZpbmUgVkVDVE9SX1VOSVRfTUFYIDgKIAogI2lmbmRlZiBDT05GSUdf
VVNFUl9PTkxZCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmggYi90YXJn
ZXQvaGV4YWdvbi9jcHVfaGVscGVyLmgKaW5kZXggMWNkZjRmOGRkMC4uMDcyMzQ4NWU3OSAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhhZ29u
L2NwdV9oZWxwZXIuaApAQCAtMjEsNiArMjEsNyBAQCB2b2lkIGhleGFnb25fc3NyX3NldF9jYXVz
ZShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgY2F1c2UpOwogdm9pZCBoZXhhZ29uX3N0
YXJ0X3RocmVhZHMoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spOwogdm9pZCBo
ZXhhZ29uX3N0b3BfdGhyZWFkKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIHZvaWQgaGV4YWdvbl93
YWl0X3RocmVhZChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIFBDKTsKK3ZvaWQg
aGV4YWdvbl9yZXN1bWVfdGhyZWFkcyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFz
ayk7CiAKIHN0YXRpYyBpbmxpbmUgdm9pZCBhcmNoX3NldF90aHJlYWRfcmVnKENQVUhleGFnb25T
dGF0ZSAqZW52LCB1aW50MzJfdCByZWcsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1aW50MzJfdCB2YWwpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVs
cGVyLmMgYi90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKaW5kZXggMWQ5YjlmOGJlZi4uY2Mx
YTg5NjU0MiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3Rh
cmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYwpAQCAtMTI0LDYgKzEyNCw0MyBAQCB2b2lkIGhleGFn
b25fd2FpdF90aHJlYWQoQ1BVSGV4YWdvblN0YXRlICplbnYsIHRhcmdldF91bG9uZyBQQykKICAg
ICBjcHVfaW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBUX0hBTFQpOwogfQogCitzdGF0aWMgdm9p
ZCBoZXhhZ29uX3Jlc3VtZV90aHJlYWQoQ1BVSGV4YWdvblN0YXRlICplbnYpCit7CisgICAgQ1BV
U3RhdGUgKmNzID0gZW52X2NwdShlbnYpOworICAgIGNsZWFyX3dhaXRfbW9kZShlbnYpOworICAg
IC8qCisgICAgICogVGhlIHdhaXQgaW5zdHJ1Y3Rpb24ga2VlcHMgdGhlIFBDIHBvaW50aW5nIHRv
IGl0c2VsZgorICAgICAqIHNvIHRoYXQgaXQgaGFzIGFuIG9wcG9ydHVuaXR5IHRvIGNoZWNrIGZv
ciBpbnRlcnJ1cHRzLgorICAgICAqCisgICAgICogV2hlbiB3ZSBjb21lIG91dCBvZiB3YWl0IG1v
ZGUsIGFkanVzdCB0aGUgUEMgdG8gdGhlCisgICAgICogbmV4dCBleGVjdXRhYmxlIGluc3RydWN0
aW9uLgorICAgICAqLworICAgIGVudi0+Z3ByW0hFWF9SRUdfUENdID0gZW52LT53YWl0X25leHRf
cGM7CisgICAgY3MgPSBlbnZfY3B1KGVudik7CisgICAgQVNTRVJUX0RJUkVDVF9UT19HVUVTVF9V
TlNFVChlbnYsIGNzLT5leGNlcHRpb25faW5kZXgpOworICAgIGNzLT5oYWx0ZWQgPSBmYWxzZTsK
KyAgICBjcy0+ZXhjZXB0aW9uX2luZGV4ID0gSEVYX0VWRU5UX05PTkU7CisgICAgcWVtdV9jcHVf
a2ljayhjcyk7Cit9CisKK3ZvaWQgaGV4YWdvbl9yZXN1bWVfdGhyZWFkcyhDUFVIZXhhZ29uU3Rh
dGUgKmN1cnJlbnRfZW52LCB1aW50MzJfdCBtYXNrKQoreworICAgIENQVVN0YXRlICpjczsKKyAg
ICBDUFVIZXhhZ29uU3RhdGUgKmVudjsKKworICAgIGdfYXNzZXJ0KGJxbF9sb2NrZWQoKSk7Cisg
ICAgQ1BVX0ZPUkVBQ0goY3MpIHsKKyAgICAgICAgZW52ID0gY3B1X2Vudihjcyk7CisgICAgICAg
IGdfYXNzZXJ0KGVudi0+dGhyZWFkSWQgPCBUSFJFQURTX01BWCk7CisgICAgICAgIGlmICgobWFz
ayAmICgweDEgPDwgZW52LT50aHJlYWRJZCkpKSB7CisgICAgICAgICAgICBpZiAoZ2V0X2V4ZV9t
b2RlKGVudikgPT0gSEVYX0VYRV9NT0RFX1dBSVQpIHsKKyAgICAgICAgICAgICAgICBoZXhhZ29u
X3Jlc3VtZV90aHJlYWQoZW52KTsKKyAgICAgICAgICAgIH0KKyAgICAgICAgfQorICAgIH0KK30K
KworCiBzdGF0aWMgTU1WZWN0b3IgVlJlZ3NbVkVDVE9SX1VOSVRfTUFYXVtOVU1fVlJFR1NdOwog
c3RhdGljIE1NUVJlZyBRUmVnc1tWRUNUT1JfVU5JVF9NQVhdW05VTV9RUkVHU107CiAKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVs
cGVyLmMKaW5kZXggMTE4ZjExMjQ4Ny4uMGRjZTEzM2QzYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE0
NzYsNyArMTQ3Niw4IEBAIHZvaWQgSEVMUEVSKHdhaXQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB0
YXJnZXRfdWxvbmcgUEMpCiAKIHZvaWQgSEVMUEVSKHJlc3VtZSkoQ1BVSGV4YWdvblN0YXRlICpl
bnYsIHVpbnQzMl90IG1hc2spCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICBC
UUxfTE9DS19HVUFSRCgpOworICAgIGhleGFnb25fcmVzdW1lX3RocmVhZHMoZW52LCBtYXNrKTsK
IH0KIAogdWludDMyX3QgSEVMUEVSKGdldGltYXNrKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWlu
dDMyX3QgdGlkKQotLSAKMi4zNC4xCgo=

