Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FBE10F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXqO-0003bn-P3; Wed, 08 Apr 2026 14:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAXqL-0003JW-N2
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:41:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKP4-0005bc-Gv
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:38 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6380r3iP1796076
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4xiM9w315MleFLjo/dG8l5LSjtszmYZB2kComnl5sdk=; b=itEFdbl4CqmNIeuP
 5KV2PQQAtpLuboOksNULg5Dcrppo/80xNKJsS4fDs5d9BgD+GtNuI3GY3Oxa1Rb8
 93Zt1qLuYZPqNd0Z+TNTrIjIqtgQsUYXFenkrKb+snY/ie5xMZDaC508PNZzWJa+
 cKdmdGFYEhmI5UyVS+s+XBS9ZOsyH0J08BtjwzuhFc2g8o/xRD5pS7G+PFeAoIlB
 6iJdKvBk7bWiBTahNiHjfLsi+kAOFvGoDQRn39HOEkrBjaORSAnDUnwddlayNkEe
 K2E8JBrjlJtW+fL+99QXX2KwkyhU3gG1CdmnDj+3BWwtGfC7rUckZ/ZqJhKUFfM8
 ImB7DA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd51da8w2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:31 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12bf921cf49so7126064c88.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622030; x=1776226830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4xiM9w315MleFLjo/dG8l5LSjtszmYZB2kComnl5sdk=;
 b=VVX8b/m2xRsJf2wapo6zVShxxq1e67lnSoka7SOUnDM63qf9P0jSBEi1ZP50WwQ/h3
 vnkHo4CIkd9/UmTCXlEHmPsvY7zFSpufYlaDXFwo0UeK+4I0H6QGvGRxZXNO2Va0r/nY
 dorMVB90EAOheCqCxVU0s4EYo99FH7gTZ2woShGBpP8+BnY80R36u2JjF2viYceO9p9u
 Y4XYVHFlhQpI0nKwfhSwAtK0rubsr4JFfIPS9318H4pdDFGwuXon5n2qrKTORrX7HenO
 oaQIFwi7SsoMbMYqBlmw9QSvs/urRmOOROEwS3yO9v/DFE3BD1+6VA97t0wN6hMHg0MN
 1CXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622030; x=1776226830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4xiM9w315MleFLjo/dG8l5LSjtszmYZB2kComnl5sdk=;
 b=Js3XgebHmAESfklm70BRmQ4mX2t9wQUhHi6OddA11RfTfDX/vQhurK8eQYMpT9PUGj
 UttIZAGfepGhDdCFIajcfWGP8SDXFGuz0uyFx195glPx1MGqFNHS5//BynAHcXKl1Z7E
 LhPPY46KtRJe4Lcqwd5p52vax2gzh0ojfEiw48eT3dWILIv30T1UjrPin7kJ/6MQEakk
 QpY6j56dO6upAzPjGSNK/2G41sslZf0HFVEyXpT2c8dhpVYIwoZVDUl196Jbmm9f39TC
 goiduyoLqyIBUW9wwLfAc2z2R7MEjhxCBxFX46lekEPZlA7kzNs0xV9hYg/zA3HxzXpE
 Pv9A==
X-Gm-Message-State: AOJu0Yy6bcEKJkwVLHL8khIfA9uzCfcE5msXBHaRRxWvOZaSDlxrUkBX
 1oPfObKwuPc1qTwBMqJZVdgetR1bpwZMQk7K6+5XImMBL64rRAratDvUgOC/IdE1h/ugpIT7WNy
 NT16OJ04k5JqqK6GS22QnZ0Rr9pwK7ANddjGi6U9DMtwBGKyrOKqeKC89TjyrVtuS6g==
X-Gm-Gg: AeBDietxBbwBSY5NzhjsFMHQYsEMzVzxl9khITNP3Vn5TqMWsCCj9VmkHgo7ATBVB2q
 Odf3fmgDeWh/g24r5WDgZUHPZrWuVvb+G3S2BdvbSyldPVnfox5Yl0jfdJQtuImORHK8BZZR8Vk
 pNmOzjybg2cM/wvKrbQb9SOsLQyjRSBwpI0mjnEw5sgbHNKTGAnbwGfuo+wGF59f/XUD2iEyLvK
 +Mdeh0HQ2wlWEigru57VcyYJ6AbufMj6hDn/+swrLLXvjbobLMW4UL/UzSylkaF967alNAfTSzn
 E+viNIe0DbbS025K3LYYl3BEpFJ4yo7vwEzzM0NDEUuwNyoJfrASmgjiMoV6+I/tFsnYqw0awKy
 iACr2gJd9HHIftkWhRum4/wHeMNmOPDzmo3Qt3RDGXGCyfVgLt8vRE1kyZqWQkfT6ODDiMw==
X-Received: by 2002:a05:7022:212:b0:11a:fb3c:568b with SMTP id
 a92af1059eb24-12bfb744257mr9880258c88.17.1775622029536; 
 Tue, 07 Apr 2026 21:20:29 -0700 (PDT)
X-Received: by 2002:a05:7022:212:b0:11a:fb3c:568b with SMTP id
 a92af1059eb24-12bfb744257mr9880241c88.17.1775622028942; 
 Tue, 07 Apr 2026 21:20:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 21/28] target/hexagon: Add next_PC, {s,g}reg writes
Date: Tue,  7 Apr 2026 21:19:46 -0700
Message-Id: <20260408041953.1899532-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: xgSBVledx29ZGhwjxu5Bt5r7mpJqxsbt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX4m0zFgID8AY2
 cM9kk69HsxWPbURa8MrJqwimQe/luZt++3w00/oIP6g6bYTnWz2xtVc3F2lefwvyHEh2pAuHJOa
 OFECnJbXLKQ8NqLbnxJUCEBh0svJseruN0AglojU8Fo9hCy6UAHpDmvxdRhbImlESjOL2sH5gtw
 OT6TqFwt5wxtV8fht9oLLlvYWkP/uqwerOPydiSiHRXilAFzZpSxb2fkKuHg5nrfRCRIieHDO2E
 kqEAVDjqJ/TvK1GxtIbiWNz2dr8AOrmoAj8eZdCxoJr1dLVV0VUvXhWwGJHPHnR3KxkbXB+0GjA
 7VCUtx9sjyfDA50571gOsNLxVTwt7rmhaCIpZVrvaFis3lrGZqx5EQfLoB/Brs+PE4K+yG/W0Nm
 iv2JtwLi5K0MCeGgdTE6zFBQsrLITUYFfLxc+j+Ezb6kPiCEn8/84z5TCr34/DISpUCShD64lz4
 z7mE24X7W4O1JLtsM7A==
X-Authority-Analysis: v=2.4 cv=AcaB2XXG c=1 sm=1 tr=0 ts=69d5d78f cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=_gAO3K6JQlmC9C_l6q8A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: xgSBVledx29ZGhwjxu5Bt5r7mpJqxsbt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmggfCAgMiArLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCA4NyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQogMiBmaWxlcyBjaGFuZ2VkLCA4NCBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKaW5kZXggODJiMzI3MzEy
ZWMuLmQ1ZWEyOTZmZjI2IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAor
KysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtNDUsNyArNDUsNyBAQCB0eXBlZGVm
IHN0cnVjdCBEaXNhc0NvbnRleHQgewogICAgIGludCBncmVnX2xvZ19pZHg7CiAgICAgaW50IHNy
ZWdfbG9nW1NSRUdfV1JJVEVTX01BWF07CiAgICAgaW50IHNyZWdfbG9nX2lkeDsKLSAgICBUQ0d2
X2kzMiB0X3NyZWdfbmV3X3ZhbHVlW05VTV9TUkVHU107CisgICAgVENHdl9pMzIgdF9zcmVnX25l
d192YWx1ZVtIRVhfU1JFR19HTEJfU1RBUlRdOwogICAgIFRDR3ZfaTMyIGdyZWdfbmV3X3ZhbHVl
W05VTV9HUkVHU107CiAjZW5kaWYKICAgICBpbnQgcHJlZ19sb2dbUFJFRF9XUklURVNfTUFYXTsK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMKaW5kZXggNmJiYTEzNWY2OTIuLmE0MmZkNzcxZjI5IDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUu
YwpAQCAtNTUyLDYgKzU1MiwxMCBAQCBzdGF0aWMgdm9pZCBnZW5fc3RhcnRfcGFja2V0KERpc2Fz
Q29udGV4dCAqY3R4KQogICAgIGN0eC0+cmVnX2xvZ19pZHggPSAwOwogICAgIGJpdG1hcF96ZXJv
KGN0eC0+cmVnc193cml0dGVuLCBUT1RBTF9QRVJfVEhSRUFEX1JFR1MpOwogICAgIGJpdG1hcF96
ZXJvKGN0eC0+cHJlZGljYXRlZF9yZWdzLCBUT1RBTF9QRVJfVEhSRUFEX1JFR1MpOworI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCisgICAgY3R4LT5ncmVnX2xvZ19pZHggPSAwOworICAgIGN0eC0+
c3JlZ19sb2dfaWR4ID0gMDsKKyNlbmRpZgogICAgIGN0eC0+cHJlZ19sb2dfaWR4ID0gMDsKICAg
ICBiaXRtYXBfemVybyhjdHgtPnByZWdzX3dyaXR0ZW4sIE5VTV9QUkVHUyk7CiAgICAgY3R4LT5m
dXR1cmVfdnJlZ3NfaWR4ID0gMDsKQEAgLTU4NCw2ICs1ODgsMjQgQEAgc3RhdGljIHZvaWQgZ2Vu
X3N0YXJ0X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKICAgICAgKiBnZW4gcGhhc2UsIHNvIGNs
ZWFyIGl0IGFnYWluLgogICAgICAqLwogICAgIGJpdG1hcF96ZXJvKGN0eC0+cHJlZ3Nfd3JpdHRl
biwgTlVNX1BSRUdTKTsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIGZvciAoaSA9IDA7
IGkgPCBIRVhfU1JFR19HTEJfU1RBUlQ7IGkrKykgeworICAgICAgICBjdHgtPnRfc3JlZ19uZXdf
dmFsdWVbaV0gPSBOVUxMOworICAgIH0KKyAgICBmb3IgKGkgPSAwOyBpIDwgY3R4LT5zcmVnX2xv
Z19pZHg7IGkrKykgeworICAgICAgICBpbnQgcmVnX251bSA9IGN0eC0+c3JlZ19sb2dbaV07Cisg
ICAgICAgIGlmIChyZWdfbnVtIDwgSEVYX1NSRUdfR0xCX1NUQVJUKSB7CisgICAgICAgICAgICBj
dHgtPnRfc3JlZ19uZXdfdmFsdWVbcmVnX251bV0gPSB0Y2dfdGVtcF9uZXcoKTsKKyAgICAgICAg
fQorICAgIH0KKyAgICBmb3IgKGkgPSAwOyBpIDwgTlVNX0dSRUdTOyBpKyspIHsKKyAgICAgICAg
Y3R4LT5ncmVnX25ld192YWx1ZVtpXSA9IE5VTEw7CisgICAgfQorICAgIGZvciAoaSA9IDA7IGkg
PCBjdHgtPmdyZWdfbG9nX2lkeDsgaSsrKSB7CisgICAgICAgIGludCByZWdfbnVtID0gY3R4LT5n
cmVnX2xvZ1tpXTsKKyAgICAgICAgY3R4LT5ncmVnX25ld192YWx1ZVtyZWdfbnVtXSA9IHRjZ190
ZW1wX25ldygpOworICAgIH0KKyNlbmRpZgogCiAgICAgLyogSW5pdGlhbGl6ZSB0aGUgcnVudGlt
ZSBzdGF0ZSBmb3IgcGFja2V0IHNlbWFudGljcyAqLwogICAgIGlmIChuZWVkX3Nsb3RfY2FuY2Vs
bGVkKHBrdCkpIHsKQEAgLTc0Myw2ICs3NjUsNjEgQEAgc3RhdGljIHZvaWQgZ2VuX3JlZ193cml0
ZXMoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgfQogfQogCisjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKK3N0YXRpYyB2b2lkIGdlbl9ncmVnX3dyaXRlcyhEaXNhc0NvbnRleHQgKmN0eCkKK3sKKyAg
ICBpbnQgaTsKKworICAgIGZvciAoaSA9IDA7IGkgPCBjdHgtPmdyZWdfbG9nX2lkeDsgaSsrKSB7
CisgICAgICAgIGludCByZWdfbnVtID0gY3R4LT5ncmVnX2xvZ1tpXTsKKworICAgICAgICB0Y2df
Z2VuX21vdl90bChoZXhfZ3JlZ1tyZWdfbnVtXSwgY3R4LT5ncmVnX25ld192YWx1ZVtyZWdfbnVt
XSk7CisgICAgfQorfQorCisKK3N0YXRpYyB2b2lkIGdlbl9zcmVnX3dyaXRlcyhEaXNhc0NvbnRl
eHQgKmN0eCkKK3sKKyAgICBpbnQgaTsKKworICAgIFRDR3ZfaTMyIG9sZF9yZWcgPSB0Y2dfdGVt
cF9uZXdfaTMyKCk7CisgICAgZm9yIChpID0gMDsgaSA8IGN0eC0+c3JlZ19sb2dfaWR4OyBpKysp
IHsKKyAgICAgICAgaW50IHJlZ19udW0gPSBjdHgtPnNyZWdfbG9nW2ldOworCisgICAgICAgIGlm
IChyZWdfbnVtID09IEhFWF9TUkVHX1NTUikgeworICAgICAgICAgICAgdGNnX2dlbl9tb3ZfdGwo
b2xkX3JlZywgaGV4X3Rfc3JlZ1tyZWdfbnVtXSk7CisgICAgICAgICAgICB0Y2dfZ2VuX21vdl90
bChoZXhfdF9zcmVnW3JlZ19udW1dLCBjdHgtPnRfc3JlZ19uZXdfdmFsdWVbcmVnX251bV0pOwor
ICAgICAgICAgICAgZ2VuX2hlbHBlcl9tb2RpZnlfc3NyKHRjZ19lbnYsIGN0eC0+dF9zcmVnX25l
d192YWx1ZVtyZWdfbnVtXSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvbGRf
cmVnKTsKKyAgICAgICAgICAgIC8qIFRoaXMgY2FuIGNoYW5nZSBwcm9jZXNzb3Igc3RhdGUsIHNv
IGVuZCB0aGUgVEIgKi8KKyAgICAgICAgICAgIGN0eC0+YmFzZS5pc19qbXAgPSBESVNBU19OT1JF
VFVSTjsKKyAgICAgICAgICAgIGNvbnRpbnVlOworICAgICAgICB9IGVsc2UgaWYgKChyZWdfbnVt
ID09IEhFWF9TUkVHX1NUSUQpIHx8CisgICAgICAgICAgICAgICAgICAgKHJlZ19udW0gPT0gSEVY
X1NSRUdfSU1BU0spIHx8CisgICAgICAgICAgICAgICAgICAgKHJlZ19udW0gPT0gSEVYX1NSRUdf
SVBFTkRBRCkpIHsKKyAgICAgICAgICAgIGlmIChyZWdfbnVtIDwgSEVYX1NSRUdfR0xCX1NUQVJU
KSB7CisgICAgICAgICAgICAgICAgdGNnX2dlbl9tb3ZfdGwob2xkX3JlZywgaGV4X3Rfc3JlZ1ty
ZWdfbnVtXSk7CisgICAgICAgICAgICAgICAgdGNnX2dlbl9tb3ZfdGwoaGV4X3Rfc3JlZ1tyZWdf
bnVtXSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjdHgtPnRfc3JlZ19uZXdfdmFs
dWVbcmVnX251bV0pOworICAgICAgICAgICAgfQorICAgICAgICAgICAgLyogVGhpcyBjYW4gY2hh
bmdlIHRoZSBpbnRlcnJ1cHQgc3RhdGUsIHNvIGVuZCB0aGUgVEIgKi8KKyAgICAgICAgICAgIGdl
bl9oZWxwZXJfcGVuZGluZ19pbnRlcnJ1cHQodGNnX2Vudik7CisgICAgICAgICAgICBjdHgtPmJh
c2UuaXNfam1wID0gRElTQVNfTk9SRVRVUk47CisgICAgICAgICAgICBjb250aW51ZTsKKyAgICAg
ICAgfSBlbHNlIGlmICgocmVnX251bSA9PSBIRVhfU1JFR19CRVNUV0FJVCkgfHwKKyAgICAgICAg
ICAgICAgICAgICAocmVnX251bSA9PSBIRVhfU1JFR19TQ0hFRENGRykpIHsKKyAgICAgICAgICAg
IC8qIFRoaXMgY2FuIHRyaWdnZXIgcmVzY2hlZCBpbnRlcnJ1cHQsIHNvIGVuZCB0aGUgVEIgKi8K
KyAgICAgICAgICAgIGdlbl9oZWxwZXJfcmVzY2hlZCh0Y2dfZW52KTsKKyAgICAgICAgICAgIGN0
eC0+YmFzZS5pc19qbXAgPSBESVNBU19OT1JFVFVSTjsKKyAgICAgICAgfQorCisgICAgICAgIGlm
IChyZWdfbnVtIDwgSEVYX1NSRUdfR0xCX1NUQVJUKSB7CisgICAgICAgICAgICB0Y2dfZ2VuX21v
dl90bChoZXhfdF9zcmVnW3JlZ19udW1dLCBjdHgtPnRfc3JlZ19uZXdfdmFsdWVbcmVnX251bV0p
OworICAgICAgICB9CisgICAgfQorfQorI2VuZGlmCisKIHN0YXRpYyB2b2lkIGdlbl9wcmVkX3dy
aXRlcyhEaXNhc0NvbnRleHQgKmN0eCkKIHsKICAgICAvKiBFYXJseSBleGl0IGlmIG5vdCBuZWVk
ZWQgb3IgdGhlIGxvZyBpcyBlbXB0eSAqLwpAQCAtMTA0NCw2ICsxMTIxLDEwIEBAIHN0YXRpYyB2
b2lkIGdlbl9jb21taXRfcGFja2V0KERpc2FzQ29udGV4dCAqY3R4KQogICAgIHByb2Nlc3Nfc3Rv
cmVfbG9nKGN0eCk7CiAKICAgICBnZW5fcmVnX3dyaXRlcyhjdHgpOworI2lmICFkZWZpbmVkKENP
TkZJR19VU0VSX09OTFkpCisgICAgZ2VuX2dyZWdfd3JpdGVzKGN0eCk7CisgICAgZ2VuX3NyZWdf
d3JpdGVzKGN0eCk7CisjZW5kaWYKICAgICBnZW5fcHJlZF93cml0ZXMoY3R4KTsKICAgICBpZiAo
cGt0LT5wa3RfaGFzX2h2eCkgewogICAgICAgICBnZW5fY29tbWl0X2h2eChjdHgpOwpAQCAtMTI1
Niw2ICsxMzM3LDggQEAgdm9pZCBoZXhhZ29uX3RyYW5zbGF0ZV9pbml0KHZvaWQpCiAgICAgaGV4
X2xsc2NfdmFsX2k2NCA9IHRjZ19nbG9iYWxfbWVtX25ld19pNjQodGNnX2VudiwKICAgICAgICAg
b2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCBsbHNjX3ZhbF9pNjQpLCAibGxzY192YWxfaTY0Iik7
CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBoZXhfY2F1c2VfY29kZSA9IHRjZ19nbG9i
YWxfbWVtX25ld19pMzIodGNnX2VudiwKKyAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRl
LCBjYXVzZV9jb2RlKSwgImNhdXNlX2NvZGUiKTsKICAgICBoZXhfY3ljbGVfY291bnQgPSB0Y2df
Z2xvYmFsX21lbV9uZXdfaTY0KHRjZ19lbnYsCiAgICAgICAgIG9mZnNldG9mKENQVUhleGFnb25T
dGF0ZSwgdF9jeWNsZV9jb3VudCksICJ0X2N5Y2xlX2NvdW50Iik7CiAjZW5kaWYKQEAgLTEyOTYs
OCArMTM3OSw0IEBAIHZvaWQgaGV4YWdvbl90cmFuc2xhdGVfaW5pdCh2b2lkKQogICAgICAgICAg
ICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCB2c3RvcmVfcGVuZGluZ1tpXSksCiAgICAgICAg
ICAgICB2c3RvcmVfcGVuZGluZ19uYW1lc1tpXSk7CiAgICAgfQotI2lmbmRlZiBDT05GSUdfVVNF
Ul9PTkxZCi0gICAgaGV4X2NhdXNlX2NvZGUgPSB0Y2dfZ2xvYmFsX21lbV9uZXcodGNnX2VudiwK
LSAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCBjYXVzZV9jb2RlKSwgImNhdXNlX2Nv
ZGUiKTsKLSNlbmRpZgogfQotLSAKMi4zNC4xCgo=

