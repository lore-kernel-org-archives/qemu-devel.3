Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D24AE7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 04:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLx8r-0006b4-DW; Thu, 12 Dec 2024 23:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tLx8n-0006Zy-TG
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 23:19:02 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tLx8k-00082b-ST
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 23:19:01 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD0vQOP023114
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 04:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ysrokvq/Lw6vkrpLlAVaHo30vhxe3UGTZ9VPrTE3GKw=; b=lzVLw5dLMvfiaRkR
 /IRt2AUx6/biXKMniH5BMrPh6k5zU+YMfcmGgzM9seEGzsB4rD32YRAjyex8MLYA
 oVzOVwQ/Lk7MKQqR0O8raMHD5Qi75+bYuwTxpwwJwXNcI+fownECAvKcgZQuj84l
 jVsFQhBEifNeR7GQ6ohHcYndBQzHSBAZZ6TDxXpj+EVosqvMZgPg+lMq2xaSXTX+
 GfowkIlecLndkdULRBmLMug9f6ulOeKDvukrqDrbNdXXnrVtvvX/XWLP6LQQI9xM
 xm6Cio/qs6GAteSJWWHuQybS+mzfEB2zDPF+dwT/uLy4Ku3rp2KIvrc3OomtefJV
 uYh/cQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd40n220-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 04:18:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-725dd39ebe7so1166953b3a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 20:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734063534; x=1734668334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ysrokvq/Lw6vkrpLlAVaHo30vhxe3UGTZ9VPrTE3GKw=;
 b=Ln4LFC8XMU0qqnPIGLW+H7Af+RGp/3yMK2TchBslyZEjqx7jmvtN7ysqm0p74fmFTh
 ++oMos6HgzuRtsS6E/FvKGjjg7LrbQQFdo3dijPqESEg3MAb3sChoSQfeCXHA7dkq2+2
 7Pk3/tsf36ddd87TFZf9qzm/1hf1WaUYnF7t97k5NuvxCa2y8OM5+8MyV+8g2s5+uf/7
 Y2w6hpehvdMKJMuhO1lLD4b3L03LJwP1MhgFNeFXdyOLYiAxFFzQtpnlbZOL/kNxn7dE
 BRG7lDyU+OTcS2vN+lJcBpEgPzITW6xp73drm4TcCjhkAPJPgP2hvrXwriH6EhLZlVBK
 yiBQ==
X-Gm-Message-State: AOJu0YyNlgHzQdKIEj+y86JiAENF4P2L9/Ai/wGTq7ElFlq13cHrKY1u
 ro8X9v+lImLo8OxYU/1oROFDqZoTw6PYQoJ/RLaNmkLAs/QBnrj33TkGnxjQwtQ9xVmLc0NEl4x
 5fLH97j8LJH4u3f3/f/MGd1qY1XC2zIFm/m9Ysk3e2eiOGiFuQmWyoEf953QdPw==
X-Gm-Gg: ASbGncvawHOuxv3v5J8PxEHLkTgusTcj8edVnsWe3X0JdArAx3csGVbQbtoZDgtmqeI
 DEJYNdEiPsfFBEkRqlkXFuUoObW2rqhaLjLlK75DlZlWUXVSSLRHmCPOiQdLrqpMKEz6PQ5SIH6
 RktdE664XcCbj9wSplTant3q4x9XVZL8iCZfglRN35DEIrQDZi+a+e1ndRqtOsukmrUuz6HXnmm
 U/SUqHgsoVvZIA63hUg9eBPXtkz0oj8gTHUy4px7fK9gjMdCiArzs+O3+m7lJ78QfS6RAe+0dJg
 y8Fs/uwyC1K1I10VuCPtxynTupo2uQ==
X-Received: by 2002:a05:6a00:c96:b0:724:bf30:147d with SMTP id
 d2e1a72fcca58-7290c17f109mr1641759b3a.11.1734063534373; 
 Thu, 12 Dec 2024 20:18:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQiu6zsuVpmsUf5cVaAGThCreDmsF/rZXbxJEAvSuxlhsZhrHCW91Vdz+y7pUMA3Nv1NZsag==
X-Received: by 2002:a05:6a00:c96:b0:724:bf30:147d with SMTP id
 d2e1a72fcca58-7290c17f109mr1641723b3a.11.1734063533881; 
 Thu, 12 Dec 2024 20:18:53 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725deac1daasm9451938b3a.171.2024.12.12.20.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 20:18:53 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, peter.maydell@linaro.org, 
 quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 Brian Cain <bcain@quicinc.com>, Brian Cain <bcain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 2/5] target/hexagon: rename HEX_EXCP_*=>HEX_CAUSE_*
Date: Thu, 12 Dec 2024 20:18:33 -0800
Message-Id: <20241213041836.39986-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213041836.39986-1-brian.cain@oss.qualcomm.com>
References: <20241213041836.39986-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: XB2zKYBqqJJo5fJewHPNAq9zorisrkf5
X-Proofpoint-ORIG-GUID: XB2zKYBqqJJo5fJewHPNAq9zorisrkf5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxlogscore=627 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130030
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgdmFsdWVzIHByZXZpb3Vz
bHkgdXNlZCBmb3IgIkhFWF9FWENQXyoiIHdlcmUgdGhlIGNhdXNlIGNvZGUKZGVmaW5pdGlvbnMg
YW5kIG5vdCB0aGUgZXZlbnQgbnVtYmVycy4gIFNvIGluIHRoaXMgY29tbWl0LCB3ZSB1cGRhdGUK
dGhlIG5hbWVzIHRvIHJlZmxlY3QgdGhlIGNhdXNlIGNvZGVzLiBJbiBIRVhfRVZFTlRfVFJBUDAn
cyBjYXNlLCB3ZSBhZGQKYSBuZXcgIkhFWF9FVkVOVF8qIiB3aXRoIHRoZSBjb3JyZWN0IGV2ZW50
IG51bWJlci4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21h
aWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29t
bS5jb20+Ci0tLQogbGludXgtdXNlci9oZXhhZ29uL2NwdV9sb29wLmMgfCAgNCArKy0tCiB0YXJn
ZXQvaGV4YWdvbi9jcHUuaCAgICAgICAgICB8ICAyICstCiB0YXJnZXQvaGV4YWdvbi9jcHVfYml0
cy5oICAgICB8IDE1ICsrKysrKysrLS0tLS0tLQogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oICAg
ICAgfCAgMiArLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgICAgfCAgNiArKystLS0KIDUg
ZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvbGludXgtdXNlci9oZXhhZ29uL2NwdV9sb29wLmMgYi9saW51eC11c2VyL2hleGFnb24v
Y3B1X2xvb3AuYwppbmRleCBkNDExNTllNTJhLi40MGRiNTk2MzAxIDEwMDY0NAotLS0gYS9saW51
eC11c2VyL2hleGFnb24vY3B1X2xvb3AuYworKysgYi9saW51eC11c2VyL2hleGFnb24vY3B1X2xv
b3AuYwpAQCAtNDIsNyArNDIsNyBAQCB2b2lkIGNwdV9sb29wKENQVUhleGFnb25TdGF0ZSAqZW52
KQogICAgICAgICBjYXNlIEVYQ1BfSU5URVJSVVBUOgogICAgICAgICAgICAgLyoganVzdCBpbmRp
Y2F0ZSB0aGF0IHNpZ25hbHMgc2hvdWxkIGJlIGhhbmRsZWQgYXNhcCAqLwogICAgICAgICAgICAg
YnJlYWs7Ci0gICAgICAgIGNhc2UgSEVYX0VYQ1BfVFJBUDA6CisgICAgICAgIGNhc2UgSEVYX0VW
RU5UX1RSQVAwOgogICAgICAgICAgICAgc3lzY2FsbG51bSA9IGVudi0+Z3ByWzZdOwogICAgICAg
ICAgICAgZW52LT5ncHJbSEVYX1JFR19QQ10gKz0gNDsKICAgICAgICAgICAgIHJldCA9IGRvX3N5
c2NhbGwoZW52LApAQCAtNjAsNyArNjAsNyBAQCB2b2lkIGNwdV9sb29wKENQVUhleGFnb25TdGF0
ZSAqZW52KQogICAgICAgICAgICAgICAgIGVudi0+Z3ByWzBdID0gcmV0OwogICAgICAgICAgICAg
fQogICAgICAgICAgICAgYnJlYWs7Ci0gICAgICAgIGNhc2UgSEVYX0VYQ1BfUENfTk9UX0FMSUdO
RUQ6CisgICAgICAgIGNhc2UgSEVYX0NBVVNFX1BDX05PVF9BTElHTkVEOgogICAgICAgICAgICAg
Zm9yY2Vfc2lnX2ZhdWx0KFRBUkdFVF9TSUdCVVMsIFRBUkdFVF9CVVNfQURSQUxOLAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGVudi0+Z3ByW0hFWF9SRUdfUjMxXSk7CiAgICAgICAgICAg
ICBicmVhazsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFn
b24vY3B1LmgKaW5kZXggMjUxNTBkNTIxNC4uMTRlNmU4MTljMiAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vY3B1LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKQEAgLTE0Myw3ICsxNDMs
NyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY3B1X2dldF90Yl9jcHVfc3RhdGUoQ1BVSGV4YWdvblN0
YXRlICplbnYsIHZhZGRyICpwYywKICAgICB9CiAgICAgKmZsYWdzID0gaGV4X2ZsYWdzOwogICAg
IGlmICgqcGMgJiBQQ0FMSUdOX01BU0spIHsKLSAgICAgICAgaGV4YWdvbl9yYWlzZV9leGNlcHRp
b25fZXJyKGVudiwgSEVYX0VYQ1BfUENfTk9UX0FMSUdORUQsIDApOworICAgICAgICBoZXhhZ29u
X3JhaXNlX2V4Y2VwdGlvbl9lcnIoZW52LCBIRVhfQ0FVU0VfUENfTk9UX0FMSUdORUQsIDApOwog
ICAgIH0KIH0KIApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMuaCBiL3Rhcmdl
dC9oZXhhZ29uL2NwdV9iaXRzLmgKaW5kZXggNDI3OTI4MWE3MS4uMmU2MGMwZmFmZSAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHVf
Yml0cy5oCkBAIC0yMywxNCArMjMsMTUgQEAKICNkZWZpbmUgUENBTElHTiA0CiAjZGVmaW5lIFBD
QUxJR05fTUFTSyAoUENBTElHTiAtIDEpCiAKLSNkZWZpbmUgSEVYX0VYQ1BfRkVUQ0hfTk9fVVBB
R0UgIDB4MDEyCi0jZGVmaW5lIEhFWF9FWENQX0lOVkFMSURfUEFDS0VUICAweDAxNQotI2RlZmlu
ZSBIRVhfRVhDUF9JTlZBTElEX09QQ09ERSAgMHgwMTUKLSNkZWZpbmUgSEVYX0VYQ1BfUENfTk9U
X0FMSUdORUQgIDB4MDFlCi0jZGVmaW5lIEhFWF9FWENQX1BSSVZfTk9fVVJFQUQgICAweDAyNAot
I2RlZmluZSBIRVhfRVhDUF9QUklWX05PX1VXUklURSAgMHgwMjUKKyNkZWZpbmUgSEVYX0VWRU5U
X1RSQVAwICAgICAgICAgICAweDAwOAogCi0jZGVmaW5lIEhFWF9FWENQX1RSQVAwICAgICAgICAg
ICAweDE3MgorI2RlZmluZSBIRVhfQ0FVU0VfVFJBUDAgICAgICAgICAgIDB4MTcyCisjZGVmaW5l
IEhFWF9DQVVTRV9GRVRDSF9OT19VUEFHRSAgMHgwMTIKKyNkZWZpbmUgSEVYX0NBVVNFX0lOVkFM
SURfUEFDS0VUICAweDAxNQorI2RlZmluZSBIRVhfQ0FVU0VfSU5WQUxJRF9PUENPREUgIDB4MDE1
CisjZGVmaW5lIEhFWF9DQVVTRV9QQ19OT1RfQUxJR05FRCAgMHgwMWUKKyNkZWZpbmUgSEVYX0NB
VVNFX1BSSVZfTk9fVVJFQUQgICAweDAyNAorI2RlZmluZSBIRVhfQ0FVU0VfUFJJVl9OT19VV1JJ
VEUgIDB4MDI1CiAKICNkZWZpbmUgUEFDS0VUX1dPUkRTX01BWCAgICAgICAgIDQKIApkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5o
CmluZGV4IDNmYzFmNGUyODEuLjhhM2I4MDEyODcgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29u
L2dlbl90Y2cuaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmgKQEAgLTEzNjUsNyArMTM2
NSw3IEBACiAgICAgZG8geyBcCiAgICAgICAgIHVpViA9IHVpVjsgXAogICAgICAgICB0Y2dfZ2Vu
X21vdmlfdGwoaGV4X2dwcltIRVhfUkVHX1BDXSwgY3R4LT5wa3QtPnBjKTsgXAotICAgICAgICBU
Q0d2IGV4Y3AgPSB0Y2dfY29uc3RhbnRfdGwoSEVYX0VYQ1BfVFJBUDApOyBcCisgICAgICAgIFRD
R3YgZXhjcCA9IHRjZ19jb25zdGFudF90bChIRVhfRVZFTlRfVFJBUDApOyBcCiAgICAgICAgIGdl
bl9oZWxwZXJfcmFpc2VfZXhjZXB0aW9uKHRjZ19lbnYsIGV4Y3ApOyBcCiAgICAgfSB3aGlsZSAo
MCkKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJn
ZXQvaGV4YWdvbi90cmFuc2xhdGUuYwppbmRleCBiY2U4NWVhZWI4Li41NjIxMDU3MDVhIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuYwpAQCAtNTU4LDcgKzU1OCw3IEBAIHN0YXRpYyB2b2lkIGdlbl9pbnNuKERpc2Fz
Q29udGV4dCAqY3R4KQogICAgICAgICBjdHgtPmluc24tPmdlbmVyYXRlKGN0eCk7CiAgICAgICAg
IG1hcmtfc3RvcmVfd2lkdGgoY3R4KTsKICAgICB9IGVsc2UgewotICAgICAgICBnZW5fZXhjZXB0
aW9uX2VuZF90YihjdHgsIEhFWF9FWENQX0lOVkFMSURfT1BDT0RFKTsKKyAgICAgICAgZ2VuX2V4
Y2VwdGlvbl9lbmRfdGIoY3R4LCBIRVhfQ0FVU0VfSU5WQUxJRF9PUENPREUpOwogICAgIH0KIH0K
IApAQCAtOTEyLDcgKzkxMiw3IEBAIHN0YXRpYyB2b2lkIGRlY29kZV9hbmRfdHJhbnNsYXRlX3Bh
Y2tldChDUFVIZXhhZ29uU3RhdGUgKmVudiwgRGlzYXNDb250ZXh0ICpjdHgpCiAKICAgICBud29y
ZHMgPSByZWFkX3BhY2tldF93b3JkcyhlbnYsIGN0eCwgd29yZHMpOwogICAgIGlmICghbndvcmRz
KSB7Ci0gICAgICAgIGdlbl9leGNlcHRpb25fZW5kX3RiKGN0eCwgSEVYX0VYQ1BfSU5WQUxJRF9Q
QUNLRVQpOworICAgICAgICBnZW5fZXhjZXB0aW9uX2VuZF90YihjdHgsIEhFWF9DQVVTRV9JTlZB
TElEX1BBQ0tFVCk7CiAgICAgICAgIHJldHVybjsKICAgICB9CiAKQEAgLTkyNyw3ICs5MjcsNyBA
QCBzdGF0aWMgdm9pZCBkZWNvZGVfYW5kX3RyYW5zbGF0ZV9wYWNrZXQoQ1BVSGV4YWdvblN0YXRl
ICplbnYsIERpc2FzQ29udGV4dCAqY3R4KQogICAgICAgICBnZW5fY29tbWl0X3BhY2tldChjdHgp
OwogICAgICAgICBjdHgtPmJhc2UucGNfbmV4dCArPSBwa3QuZW5jb2RfcGt0X3NpemVfaW5fYnl0
ZXM7CiAgICAgfSBlbHNlIHsKLSAgICAgICAgZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoY3R4LCBIRVhf
RVhDUF9JTlZBTElEX1BBQ0tFVCk7CisgICAgICAgIGdlbl9leGNlcHRpb25fZW5kX3RiKGN0eCwg
SEVYX0NBVVNFX0lOVkFMSURfUEFDS0VUKTsKICAgICB9CiB9CiAKLS0gCjIuMzQuMQoK

