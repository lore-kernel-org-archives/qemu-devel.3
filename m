Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1CAC88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6W3u-0005vm-8a; Tue, 15 Sep 2026 12:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W3f-0005u7-43
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W3c-0003mI-9g
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:30:58 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFAQMh813414
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IcJNdY4hlB5wuvciSxp0uXAgBsXsEcVgYAWPzivXFtc=; b=Bn+LNovqns+vCGb+
 t91yGgu19ChCqsd+q6WyWB9O5NZ56GC+q9JHGlr2hIdz6vZZcqm+3xLuraGfQ9ML
 rFODfnhl2FwDTC6BMXHy6Dcs5qxC3luSGOYrQSDxJpG3wQZ21f0gGjgcId0Wf47N
 H807QCk6MSy/DIuQfgqQrqHlxFvif73Cu7bgVfOtaQVXCM7aRWJjtTxYH/sqyNSL
 jJQOjkwH9jABPaeR28iTv8fPAeIWmqyYuTsSwSKECZXovPXvod8xnFekmQVOyjo8
 DwTFLblwAQ5bHhDE4Jqyezl7awWhCAG6Oueimu83xMIIr0xRsOE4ogIp4Jsf5VxN
 x4PK4A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq6kc170e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:30:54 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-381250979d5so5309995a91.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789489854; x=1790094654; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IcJNdY4hlB5wuvciSxp0uXAgBsXsEcVgYAWPzivXFtc=;
 b=cuBJTYm0fgNjVwpEEIxB3Lcd+EYR8bCVzr+1C0XJ3WOIU80G41omiAw22oohjWgzuZ
 zaJeoLBe/xZlI0QawyTm8D1MOdNI6OvgdtfuxsZWdtCpbAR2Q4D/IkJzKi7/fkqOkMW5
 0/fjZ9YVV4cceYNMPEIlgRittGG1qtMoOvOWtolnVHvn4TEQZ7vbGEN9T1+ZPh2La7rP
 ApjvxHogOMe+HthTWTLu5O8uoIP2r9IC2hy8ltkrJAfWZJO0hmK2TyPBpp/rPyAjkMAE
 gcRiB1/qzJq/FG8co9Xkbu2Dsg3NDvhh93mvSkvzOePyReoFU7zb6lP/XoOXT1Fw+ErS
 L7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489854; x=1790094654;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IcJNdY4hlB5wuvciSxp0uXAgBsXsEcVgYAWPzivXFtc=;
 b=PXct1U7wtI4NOBGjTUtAHdE6v80K7g5p0FmNw6jd/FflJ2uz3TMHkWBvqTfITEsrAf
 f4vrL2WOWHf/yqQXPU7U2+qFLLZ+iXGSqFwUEYo8Lb5QpNKa/rnHJB5/mXIMtwY/Sq+v
 pfXeHTkmyM0FZDOoTWLQsvGTwqmMCwEMlNxpjS5Mgkca/8vMOZ+JWrnEt4eVGgSJM1KD
 AgPq04xDThAi/tSGRda//T6Bv+fGbXp3v9a2Wi7zqZoDUZv0BpHcsIDXbtY3r+jUpprc
 wGPm6vv5TpH6vzGeoVbL5KcdtVJQhzu8x1ulpUK1KKVIR7dIUDRtJcJVA//u7Sh1BIIe
 BuAQ==
X-Gm-Message-State: AFuF++mGOFnZhTzZ0Cz/XGNcQVj3Fu3bw0PDZweY9QUM/mMXK7pIT1S4
 FJ7FgZ0zfTQmp7XHF9r7X4NCV3Ul6cxBxG+rFqTsil+8gw5sFOmEy3ALDhkQ/vXhRbHJdvuIoUN
 +THY9so09WxrwupRkyxGJkfXmYQQJbQ1XlKwEpI6Y2ojM+ce8lpFY6W2BsHfuvbzktg==
X-Gm-Gg: AYBFou0HoOduMytV7R3rRW/h+EqqSK3b4c/xGWTUnUXhLxL3i1+TllaE9yfx01pUtab
 7pJDsN/UBg+CeGmogc1QKmVnzKKZh4n7KTJChAFT0IFCLhHFgI3GTlBHqhprztvrKDe9lSNHX7i
 +6xWf11FW+KApFSRyyCwpz605DU9cJIpR9pXUOwxX2qNV3tO68vnd1RfXDrSWWcP7E8fZoXUAN3
 puPOnv9pM9Iug7ssny7k/hvdhE0pk1inqNbxfW2CHe4Os4NhxfxbxjhbxbhIrgUbM1Ly5E2ZqPp
 I23zex0Y9LYOrciMYTORHaJabc4wCh2HkK5i6fzkAdVXLOEjHVMoms/kFg2lUD4uohoHJ+CFNkH
 YbrtUZ90WNr9DLLltu9dUvKVeIcrlnn5uJEP+tiM1iplOiNb5
X-Received: by 2002:a17:90b:1d52:b0:39d:f189:48d6 with SMTP id
 98e67ed59e1d1-39e10c45f67mr3360672a91.4.1789489854010; 
 Tue, 15 Sep 2026 09:30:54 -0700 (PDT)
X-Received: by 2002:a17:90b:1d52:b0:39d:f189:48d6 with SMTP id
 98e67ed59e1d1-39e10c45f67mr3360631a91.4.1789489853449; 
 Tue, 15 Sep 2026 09:30:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd0baaasm6068590a91.9.2026.09.15.09.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:30:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 03/17] tests/tcg/hexagon: fix undefined signed integer
 overflow in hvx_misc
Date: Tue, 15 Sep 2026 09:30:33 -0700
Message-Id: <20260915163047.4180600-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
References: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfXyhVJTaQWagDZ
 X0k2iXsIOhWfDRod4Cu/rEiI22EbvMmZrgCHRHjan1OP82AO/HE7CPQ7NLb31fsszCwmQZXD6It
 dWqErnBkNYZAt9SAJeQRzTNwg/JW3mE=
X-Proofpoint-GUID: epXn0lrVf7ihZn5iRIYku-YqxwZCb5Fb
X-Authority-Analysis: v=2.4 cv=ZINCCn7b c=1 sm=1 tr=0 ts=6aa972be cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=7jozP2JQLfe_envvOV8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: epXn0lrVf7ihZn5iRIYku-YqxwZCb5Fb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzOSBTYWx0ZWRfX0nuqPnRWqS5A
 QEiYuA67WSPImcKG72XBq/xSIygNY6ecFMf50tk5mXba4YVVDqbiPOZbgh7H/C0UgSJr2U6P2X+
 TXfDGXAwcWhXbXVqp5KyRlGPkmkxuwikV0yMLdvck7HtHOGpExegK1A/HP0vowSODWcXLGkS4V0
 2jdKY+p9niu/9ypNxYIpEy7YulpYcVHU/FEirhH+wbf99NYaamLKphkaKXweBBtxMOEuJfYHmxk
 IpUmTHeq0r7Xl0HZDs4EO7hPhpBSjAlL2B37RQnLX4bJBBNEOXuMbJmODd9lq24GLYIGcazvyZq
 BzfQ0FowzkmRZN4uVWAgxvIR1wNVmo/g1JRZjpX9ocHtFDT9VP9R6OPDBycFZwZdzkQeKGCe0Zj
 D6q4HCnNI5LSeAFt3XVM9hOuPzPNZ1Tagjoo34FrUGit1PxIiPk/Di3UybI/Fp8J4stEXMsfe7C
 Ogl8ADPOwwY83HcNEGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150239
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

VXNlIHVuc2lnbmVkICgudXcpIGluc3RlYWQgb2Ygc2lnbmVkICgudykgYXJyYXkgbWVtYmVycyBm
b3IKdmVjdG9yIGFkZGl0aW9uIGFuZCBzdWJ0cmFjdGlvbiByZWZlcmVuY2UgY2FsY3VsYXRpb25z
IHRvIGF2b2lkCnNpZ25lZCBpbnRlZ2VyIG92ZXJmbG93LiBXcmFwcGluZyBhcml0aG1ldGljIGlz
IHdlbGwtZGVmaW5lZCBmb3IKdW5zaWduZWQgdHlwZXMuIEFkZCBDSEVDS19PVVRQVVRfRlVOQyh1
dywgNCkgdG8gc3VwcG9ydCB1bnNpZ25lZAp3b3JkIGNvbXBhcmlzb25zIGluIHRoZSBURVNUX1ZF
Q19PUDIgbWFjcm8uCkZvdW5kIHdpdGggVUJTYW4uCgpSZXZpZXdlZC1ieTogU2lkIE1hbm5pbmcg
PHNpZC5tYW5uaW5nQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4g
PGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy90Y2cvaGV4YWdvbi9odnhf
bWlzYy5oIHwgIDEgKwogdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYyB8IDE4ICsrKysrKysr
Ky0tLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmggYi90ZXN0cy90
Y2cvaGV4YWdvbi9odnhfbWlzYy5oCmluZGV4IGMyMWVhOTc1YzE2Li5lMzI3MTVlZDExZCAxMDA2
NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuaAorKysgYi90ZXN0cy90Y2cvaGV4
YWdvbi9odnhfbWlzYy5oCkBAIC02OSw2ICs2OSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjaGVj
a19vdXRwdXRfIyNGSUVMRChpbnQgbGluZSwgc2l6ZV90IG51bV92ZWN0b3JzKSBcCiBDSEVDS19P
VVRQVVRfRlVOQyhkLCAgOCkKIENIRUNLX09VVFBVVF9GVU5DKHcsICA0KQogQ0hFQ0tfT1VUUFVU
X0ZVTkMoc2YsIDQpCitDSEVDS19PVVRQVVRfRlVOQyh1dywgNCkKIENIRUNLX09VVFBVVF9GVU5D
KGgsICAyKQogQ0hFQ0tfT1VUUFVUX0ZVTkModWgsIDIpCiBDSEVDS19PVVRQVVRfRlVOQyhoZiwg
MikKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMgYi90ZXN0cy90Y2cv
aGV4YWdvbi9odnhfbWlzYy5jCmluZGV4IDMyYTM2NjFhODZmLi5mMjBhZmM4ZTY3MCAxMDA2NDQK
LS0tIGEvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYworKysgYi90ZXN0cy90Y2cvaGV4YWdv
bi9odnhfbWlzYy5jCkBAIC01NSw3ICs1NSw3IEBAIHN0YXRpYyB2b2lkIHRlc3RfbG9hZF90bXAo
dm9pZCkKICAgICAgICAgcG91dCArPSBzaXplb2YoTU1WZWN0b3IpOwogCiAgICAgICAgIGZvciAo
aW50IGogPSAwOyBqIDwgTUFYX1ZFQ19TSVpFX0JZVEVTIC8gNDsgaisrKSB7Ci0gICAgICAgICAg
ICBleHBlY3RbaV0ud1tqXSA9IGJ1ZmZlcjBbaV0ud1tqXSArIGJ1ZmZlcjFbaV0ud1tqXSArIDE7
CisgICAgICAgICAgICBleHBlY3RbaV0udXdbal0gPSBidWZmZXIwW2ldLnV3W2pdICsgYnVmZmVy
MVtpXS51d1tqXSArIDE7CiAgICAgICAgIH0KICAgICB9CiAKQEAgLTI4NSw4ICsyODUsOCBAQCBz
dGF0aWMgdm9pZCB0ZXN0X21heF90ZW1wcygpCiAKICAgICAgICAgLyogVGhlIGZpcnN0IHR3byB2
ZWN0b3JzIGNvbWUgZnJvbSB0aGUgdmFkZC1wYWlyIGluc3RydWN0aW9uICovCiAgICAgICAgIGZv
ciAoaW50IGkgPSAwOyBpIDwgTUFYX1ZFQ19TSVpFX0JZVEVTIC8gNDsgaSsrKSB7Ci0gICAgICAg
ICAgICBleHBlY3RbMF0ud1tpXSA9IGJ1ZmZlcjBbMF0ud1tpXSArIGJ1ZmZlcjBbMl0ud1tpXTsK
LSAgICAgICAgICAgIGV4cGVjdFsxXS53W2ldID0gYnVmZmVyMFsxXS53W2ldICsgYnVmZmVyMFsz
XS53W2ldOworICAgICAgICAgICAgZXhwZWN0WzBdLnV3W2ldID0gYnVmZmVyMFswXS51d1tpXSAr
IGJ1ZmZlcjBbMl0udXdbaV07CisgICAgICAgICAgICBleHBlY3RbMV0udXdbaV0gPSBidWZmZXIw
WzFdLnV3W2ldICsgYnVmZmVyMFszXS51d1tpXTsKICAgICAgICAgfQogICAgICAgICAvKiBUaGUg
dGhpcmQgdmVjdG9yIGNvbWVzIGZyb20gdGhlIHZzaHVmZmUgaW5zdHJ1Y3Rpb24gKi8KICAgICAg
ICAgZm9yIChpbnQgaSA9IDA7IGkgPCBNQVhfVkVDX1NJWkVfQllURVMgLyAyOyBpKyspIHsKQEAg
LTI5NSw3ICsyOTUsNyBAQCBzdGF0aWMgdm9pZCB0ZXN0X21heF90ZW1wcygpCiAgICAgICAgIH0K
ICAgICAgICAgLyogVGhlIGZvdXJ0aCB2ZWN0b3IgY29tZXMgZnJvbSB0aGUgdmFkZC1zaW5nbGUg
aW5zdHJ1Y3Rpb24gKi8KICAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBNQVhfVkVDX1NJWkVf
QllURVMgLyA0OyBpKyspIHsKLSAgICAgICAgICAgIGV4cGVjdFszXS53W2ldID0gYnVmZmVyMFsx
XS53W2ldICsgYnVmZmVyMFs1XS53W2ldOworICAgICAgICAgICAgZXhwZWN0WzNdLnV3W2ldID0g
YnVmZmVyMFsxXS51d1tpXSArIGJ1ZmZlcjBbNV0udXdbaV07CiAgICAgICAgIH0KICAgICAgICAg
LyoKICAgICAgICAgICogVGhlIGZpZnRoIHZlY3RvciBjb21lcyBmcm9tIHRoZSBsb2FkIHRvIHY0
CkBAIC0zMDYsMTAgKzMwNiwxMCBAQCBzdGF0aWMgdm9pZCB0ZXN0X21heF90ZW1wcygpCiAgICAg
ICAgIGNoZWNrX291dHB1dF9iKF9fTElORV9fLCA1KTsKIH0KIAotVEVTVF9WRUNfT1AyKHZhZGRf
dywgdmFkZCwgLncsIHcsIDQsICspCitURVNUX1ZFQ19PUDIodmFkZF93LCB2YWRkLCAudywgdXcs
IDQsICspCiBURVNUX1ZFQ19PUDIodmFkZF9oLCB2YWRkLCAuaCwgaCwgMiwgKykKIFRFU1RfVkVD
X09QMih2YWRkX2IsIHZhZGQsIC5iLCBiLCAxLCArKQotVEVTVF9WRUNfT1AyKHZzdWJfdywgdnN1
YiwgLncsIHcsIDQsIC0pCitURVNUX1ZFQ19PUDIodnN1Yl93LCB2c3ViLCAudywgdXcsIDQsIC0p
CiBURVNUX1ZFQ19PUDIodnN1Yl9oLCB2c3ViLCAuaCwgaCwgMiwgLSkKIFRFU1RfVkVDX09QMih2
c3ViX2IsIHZzdWIsIC5iLCBiLCAxLCAtKQogVEVTVF9WRUNfT1AyKHZ4b3IsIHZ4b3IsICwgZCwg
OCwgXikKQEAgLTQ4OSw5ICs0ODksOSBAQCBzdGF0aWMgdm9pZCB0ZXN0X2xvYWRfdG1wX3ByZWRp
Y2F0ZWQodm9pZCkKICAgICAgICAgcG91dCArPSBzaXplb2YoTU1WZWN0b3IpOwogCiAgICAgICAg
IGZvciAoaW50IGogPSAwOyBqIDwgTUFYX1ZFQ19TSVpFX0JZVEVTIC8gNDsgaisrKSB7Ci0gICAg
ICAgICAgICBleHBlY3RbaV0ud1tqXSA9Ci0gICAgICAgICAgICAgICAgcHJlZCA/IGJ1ZmZlcjBb
aV0ud1tqXSArIGJ1ZmZlcjFbaV0ud1tqXSArIDEKLSAgICAgICAgICAgICAgICAgICAgIDogYnVm
ZmVyMFtpXS53W2pdICsgMjsKKyAgICAgICAgICAgIGV4cGVjdFtpXS51d1tqXSA9CisgICAgICAg
ICAgICAgICAgcHJlZCA/IGJ1ZmZlcjBbaV0udXdbal0gKyBidWZmZXIxW2ldLnV3W2pdICsgMQor
ICAgICAgICAgICAgICAgICAgICAgOiBidWZmZXIwW2ldLnV3W2pdICsgMjsKICAgICAgICAgfQog
ICAgICAgICBwcmVkID0gIXByZWQ7CiAgICAgfQotLSAKMi4zNC4xCgo=

