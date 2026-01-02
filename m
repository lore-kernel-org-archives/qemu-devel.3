Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44914FA3758
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 20:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vblVx-00041v-94; Fri, 02 Jan 2026 15:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vblVi-0003vT-PW
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 15:12:36 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vblVf-0002Tq-U6
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 15:12:34 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 602ENil6803153
 for <qemu-devel@nongnu.org>; Fri, 2 Jan 2026 20:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=LgiSAyKeqdm4iwxPrWsmLytvuGCzdsj3c5YV6L+3F5Q=; b=C0
 zNwwvZbFZtSevoHxu6K2wPI5dPdfF9FnHbdmIWvLzy0HdkI8Nr0wFI910TeglKRg
 GCBJX/6P1VC8aop9goP2Q46n5+cBauHv7hap5fjICyADOlDOFQ5DJ0CaRMeFMFnQ
 WThULvdyfvejsgJtJQvtjO193aG/T4GQGYEHhfUrjxw0aG1LVui5tLuEdLb8CHoN
 XsmpyTeHxtQX+mNkqbwNhzA0QteZfRBWaosKp7Z0bwcfo0yziCEFw1T6pc03Xbqd
 djpY/YlYlZAhf58k151twzCuwgznPfGB0NGq8B3+il/rY5QY98PYHqa3LpkoFNWs
 p9tFtQZtTbXoTuoHtbkg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4befr08n89-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 20:12:27 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-bc240cdb249so11062769a12.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 12:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767384746; x=1767989546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LgiSAyKeqdm4iwxPrWsmLytvuGCzdsj3c5YV6L+3F5Q=;
 b=Y2a7oprXI4GUIDIyp82s5Rihz1rAAAcuVStYbdEC39Xqo1NoOwrI+NageZER8aTl/y
 UK/XizBOIQP27uhnBjYcf+ZgNpf+zPFUWp1TDqv/N7wjp1dKUNG2IxQZZ4N3TQegDjOg
 xxMdinxdcmIimh6fqcFT9cRV8mEDC61T5DYGCYQlr/t96+nL12ZLdXrCvLnF9mTKnpcs
 Jesqv9q9+hptctBfRrb/kduxvfg8Jck2huMv2CqvBoG9MpDntBP0lSeis7fNloEJ+qak
 +cqESwiNnprEPPV2RE0ZeiUmt6m+h+TjBHbRIl8jj4sK4tgvYlKjCQLLcd5/7sIlmQMy
 LDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767384746; x=1767989546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LgiSAyKeqdm4iwxPrWsmLytvuGCzdsj3c5YV6L+3F5Q=;
 b=Y7XFVh3cfDpb+OoM3r1624KqtTENpcZILE3rzOehe13iogJygflWnW4/vZTcTFBPa3
 yKDoGoDJ/EBV8nAmROzfy84EFkddTA0dqyHJohvhCGYYLiYAqUL/Y5MDZ+ib14Y8EpQE
 d42h1BFJiDbR7rIgu6f3EUPSMlklDEmPJtmTcdFw3P5Oy7hJQCcjXiLULfnlOjY8yf40
 jhVqsX/G6ai8TdXQShSA3SdaigyJNgoYQwH6pQu3wkDCL3/H7OSwQ73Edgx6+0wyCcuq
 qhWDt2BSXDj15ozEUzf32d/kVpJx9tze3Jlc9GSFgCusCs8kwpl1hEnZyK7BP/myQEy+
 gD/A==
X-Gm-Message-State: AOJu0Yzdiozx66JF81BvYxgiDT57JlvNqjCPEmMAZiygKFKwx2MIKZje
 v/Z3m8ut3jhkbwZF3vVYuXxTEIEUZO50NkiSiBIP+2y04FZQyO9eN1cUDaJFBK1dkYTOXta6XHe
 zEZbth36YOdMsR4AmQc+Eyi7zXLaJkW68092Un/CbFEiyElqynArKEsuqjtdfj7d7SQ==
X-Gm-Gg: AY/fxX4vyZCl1SkNq6CC/i0ZL8IoEuUj6o2DC/eaInTTnfZsqL6waiyIWHcBFwdKwGe
 A0oPnny+KQc2H92t8i5VAvBeDwrKgO6M/dVEVEAMk03+ksd/QP6uM83ZtCXDmt4Vbrowe3Z+xkN
 kfBijQR9rpNjTcjgXm0WHlMgkziEHnWnxCuCj1Yggh9TPKlRhgVeSeBOOGyUjRybpI1uvyv8tgJ
 78U6zEk6rxXAUlXWI5u3JZNA/++MySGYLezovPAJlHEiSZrWm38ddGVoBBKhGKHxsmVzqBfc2FN
 LBouiSjSys9p8d3V9aAkDpcJmZNx97PfIoc+laIj67q/mNV2yLkxOmuaE9n9XNUOV+xfN/zC2CP
 HNpP/BJru2SWxMLA/SKSwGGpt69DBQ2GHLr3dxFzwBhUoGulfkq+HVl6aBA==
X-Received: by 2002:a05:7301:648f:b0:2ae:554a:64c1 with SMTP id
 5a478bee46e88-2b05ec96473mr32075727eec.31.1767384746034; 
 Fri, 02 Jan 2026 12:12:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3ZgwTn9bBfBgFocc+KU12ACEaJN0ObWCGEhmtCvxbVStYnMKw8Ah+o8k30PCJ/PxYzvH/TA==
X-Received: by 2002:a05:7301:648f:b0:2ae:554a:64c1 with SMTP id
 5a478bee46e88-2b05ec96473mr32075707eec.31.1767384745538; 
 Fri, 02 Jan 2026 12:12:25 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b140c42e7esm1794621eec.22.2026.01.02.12.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 12:12:25 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 8/9] Hexagon (target/hexagon)
 s/gen_log_vreg_write/gen_vreg_write
Date: Fri,  2 Jan 2026 12:12:04 -0800
Message-Id: <20260102201205.2050363-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260102201205.2050363-1-brian.cain@oss.qualcomm.com>
References: <20260102201205.2050363-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=XsL3+FF9 c=1 sm=1 tr=0 ts=695826ab cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=7b1gsmKfWQ02FWdkqOIA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 30dECrW7iwRhALpSRID61fSXgLzBo-mn
X-Proofpoint-ORIG-GUID: 30dECrW7iwRhALpSRID61fSXgLzBo-mn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE4MSBTYWx0ZWRfX6+wC2lPG20+v
 boLRsogo7vwB8xMUbugAgAfwpnNnlVxcfcqpao2CnXsNs4gEZPoT/uLs5ZurI//w0a6zwIh+XGi
 71RaHPB9j/q7B6g44VjgUeKqMuF4b3M5ePHTTf48HjflD0c7rAKosR2B0hueCV5cNu006oF+x6w
 DSbdHBfF8OTtRg/YSAKYV29aRHIEigT71qw1CenV3DhHIB9ZRihOk2w96ZGZO8HtpyvLyMD5v45
 9a05YN89Dx+xSVoc78i/dMQo00hqZrb5/DOjPyiRU6SPDH3t1eNlPrno8Tm0brAXZPapJfq2t/g
 4WXmTBPW1FwHFjZOfy/xE7/krT/NpFQ2I3dOojeP4mXFQ1o9EbtS4ZAWvRDPSzIm6iXDGeJcj1/
 wX0rPJ6cm28x/vgZ0lRUOXQQMh9AKTsx6ZH9QjBfgtPuCY9x7LywU3QZjPFlKKgiLkcD1+lLlhu
 el3wRz0PN0tWnUvZe5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601020181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KCk5vdGUgdGhl
cmUgYXJlIHR3byBmdW5jdGlvbnMgaW1wYWN0ZWQKICAgIGdlbl9sb2dfdnJlZ193cml0ZSAgICAg
ICAgICAtPiBnZW5fdnJlZ193cml0ZQogICAgZ2VuX2xvZ192cmVnX3dyaXRlX3BhaXIgICAgIC0+
IGdlbl92cmVnX3dyaXRlX3BhaXIKVGhlc2UgZnVuY3Rpb25zIGRvbid0ICJsb2ciIGFueXRoaW5n
LCB0aGV5IGp1c3QgZ2VuZXJhdGUgdGhlIHdyaXRlCgpTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2lt
cHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0
aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPgpSZXZpZXdlZC1ieTogQnJpYW4gQ2FpbiA8
YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxi
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMg
ICAgICB8IDggKysrKy0tLS0KIHRhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgfCA4ICsrKyst
LS0tCiAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyBiL3RhcmdldC9oZXhhZ29uL2dlbnB0
ci5jCmluZGV4IDI1MzRkOTY2MjAuLjM2OTY4NTQ5ZDUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL2dlbnB0ci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jCkBAIC0xMTc0LDcgKzEx
NzQsNyBAQCBzdGF0aWMgaW50cHRyX3QgdnJlZ19zcmNfb2ZmKERpc2FzQ29udGV4dCAqY3R4LCBp
bnQgbnVtKQogICAgIHJldHVybiBvZmZzZXQ7CiB9CiAKLXN0YXRpYyB2b2lkIGdlbl9sb2dfdnJl
Z193cml0ZShEaXNhc0NvbnRleHQgKmN0eCwgaW50cHRyX3Qgc3Jjb2ZmLCBpbnQgbnVtLAorc3Rh
dGljIHZvaWQgZ2VuX3ZyZWdfd3JpdGUoRGlzYXNDb250ZXh0ICpjdHgsIGludHB0cl90IHNyY29m
ZiwgaW50IG51bSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWUmVnV3JpdGVUeXBl
IHR5cGUpCiB7CiAgICAgaW50cHRyX3QgZHN0b2ZmOwpAQCAtMTE5MCwxMiArMTE5MCwxMiBAQCBz
dGF0aWMgdm9pZCBnZW5fbG9nX3ZyZWdfd3JpdGUoRGlzYXNDb250ZXh0ICpjdHgsIGludHB0cl90
IHNyY29mZiwgaW50IG51bSwKICAgICB9CiB9CiAKLXN0YXRpYyB2b2lkIGdlbl9sb2dfdnJlZ193
cml0ZV9wYWlyKERpc2FzQ29udGV4dCAqY3R4LCBpbnRwdHJfdCBzcmNvZmYsIGludCBudW0sCitz
dGF0aWMgdm9pZCBnZW5fdnJlZ193cml0ZV9wYWlyKERpc2FzQ29udGV4dCAqY3R4LCBpbnRwdHJf
dCBzcmNvZmYsIGludCBudW0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBW
UmVnV3JpdGVUeXBlIHR5cGUpCiB7Ci0gICAgZ2VuX2xvZ192cmVnX3dyaXRlKGN0eCwgc3Jjb2Zm
LCBudW0gXiAwLCB0eXBlKTsKKyAgICBnZW5fdnJlZ193cml0ZShjdHgsIHNyY29mZiwgbnVtIF4g
MCwgdHlwZSk7CiAgICAgc3Jjb2ZmICs9IHNpemVvZihNTVZlY3Rvcik7Ci0gICAgZ2VuX2xvZ192
cmVnX3dyaXRlKGN0eCwgc3Jjb2ZmLCBudW0gXiAxLCB0eXBlKTsKKyAgICBnZW5fdnJlZ193cml0
ZShjdHgsIHNyY29mZiwgbnVtIF4gMSwgdHlwZSk7CiB9CiAKIHN0YXRpYyBpbnRwdHJfdCBnZXRf
cmVzdWx0X3FyZWcoRGlzYXNDb250ZXh0ICpjdHgsIGludCBxbnVtKQpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSBiL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkK
aW5kZXggMTI3N2ZlYzlhMi4uNmI2ODM0ODdiYyAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFnb24v
aGV4X2NvbW1vbi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CkBAIC04MjMs
OCArODIzLDggQEAgZGVmIGRlY2xfdGNnKHNlbGYsIGYsIHRhZywgcmVnbm8pOgogICAgICAgICAg
ICAgIiIiKSkKICAgICBkZWYgbG9nX3dyaXRlKHNlbGYsIGYsIHRhZyk6CiAgICAgICAgIGYud3Jp
dGUoY29kZV9mbXQoZiIiIlwKLSAgICAgICAgICAgIGdlbl9sb2dfdnJlZ193cml0ZShjdHgsIHtz
ZWxmLmh2eF9vZmYoKX0sIHtzZWxmLnJlZ19udW19LAotICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHtodnhfbmV3dih0YWcpfSk7CisgICAgICAgICAgICBnZW5fdnJlZ193cml0ZShjdHgs
IHtzZWxmLmh2eF9vZmYoKX0sIHtzZWxmLnJlZ19udW19LAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAge2h2eF9uZXd2KHRhZyl9KTsKICAgICAgICAgIiIiKSkKICAgICBkZWYgaGVscGVyX2h2
eF9kZXNjKHNlbGYsIGYpOgogICAgICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCkBAIC05MTUs
OCArOTE1LDggQEAgZGVmIGRlY2xfdGNnKHNlbGYsIGYsIHRhZywgcmVnbm8pOgogICAgICAgICAg
ICAgIiIiKSkKICAgICBkZWYgbG9nX3dyaXRlKHNlbGYsIGYsIHRhZyk6CiAgICAgICAgIGYud3Jp
dGUoY29kZV9mbXQoZiIiIlwKLSAgICAgICAgICAgIGdlbl9sb2dfdnJlZ193cml0ZV9wYWlyKGN0
eCwge3NlbGYuaHZ4X29mZigpfSwge3NlbGYucmVnX251bX0sCi0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB7aHZ4X25ld3YodGFnKX0pOworICAgICAgICAgICAgZ2VuX3ZyZWdf
d3JpdGVfcGFpcihjdHgsIHtzZWxmLmh2eF9vZmYoKX0sIHtzZWxmLnJlZ19udW19LAorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB7aHZ4X25ld3YodGFnKX0pOwogICAgICAgICAiIiIp
KQogICAgIGRlZiBoZWxwZXJfaHZ4X2Rlc2Moc2VsZiwgZik6CiAgICAgICAgIGYud3JpdGUoY29k
ZV9mbXQoZiIiIlwKLS0gCjIuMzQuMQoK

