Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC965C98328
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 02:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAers-00051v-JM; Sat, 26 Sep 2026 22:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAerr-00051d-Dj
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 22:43:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAerp-0007Ul-Vc
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 22:43:55 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxnbn091342
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vwBv1XNaXf0AV0dLDWbYf/cD8bQGK2OHFgJKP4zHzNA=; b=KNZNRUl7KeCTmlnf
 QwqHUwBf+fCp8cWWE0eqSPFEMo9myef6BCD4NKc98KWeg1S4LtJ6BMGJnZHpIaI0
 h4e/dVL/4zpdAoWe+x1Gx90jzPPtZ1jmR75PRd92Bsd1eMKRGxvjkA0WtnQrYFCf
 HLKRk6XJk1OWvbrPY6VeX+E20dESip45I7koJ8elWe4HxcOexkufNfZOVe2n4zxK
 JzepYuppo5yLR4QbJ4oNfnUrlygY1dXX4tJ43tX+J2rbqC3b1KFhJdr7WUE3S3SA
 mjnqdZgmaBrtUXCsCRNZN+s+6ATxZvNpxXAodqa1MVvhzTyA3TIOhPeg44Ukukqk
 21nXaw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5cgj8t3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:43:52 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso3481595eec.0
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 19:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790477032; x=1791081832; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vwBv1XNaXf0AV0dLDWbYf/cD8bQGK2OHFgJKP4zHzNA=;
 b=WzXTHCAZfYRFQfYiHC17OcoYF0clhw68rboxBLwXNlqd9u8iTty4btHldu4yqJKQOg
 h2C/PHzZ90Bl+l9D+rzQmol46rT69huF9HjCWtbwB2Fy9OrVJNtfsi2a2bvxmJUCip/R
 DtuJjs0zEcrxRP5CAqqMT8TyZq58KMMjDmVAlSVGlImjaZeTKoTX92m/KfATFGSFkQY3
 D/gmSh+y3AhpbM9a+pFofzTQXHhiLZPXX7dPdBqQlc5xvSGTStgLkrjman6THwu2TYLv
 vvpCyputAD+uNH7sXIt+KUs1BacsiV0zp1YpD96jtgsIEXHNolN5JfDGHn7D9Ei3s530
 kukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790477032; x=1791081832;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vwBv1XNaXf0AV0dLDWbYf/cD8bQGK2OHFgJKP4zHzNA=;
 b=LTGAwkUXevWBwqHC5xVtzNFQ/Y8dMJeTNtwwtL69+wuZQHla5xw6dquLKAOlWvo1fL
 l8A3VJCrvGmOO+DWiMFl8ACe7KEE1Zy3hbhU+IsDRkC2Q+xo3vjj+GscJ8Wi0o04Kylc
 OZ4l83Tc6Xb+afO3CXubtlORKxMoIkVxFGAw6I+f/q0XZgUUlwT8BBUWmQRRpsFnKEHu
 nqcWyliebvBTnP5sLfMYgU4OaPpHd1C9MmiZZFsk4fLSUpuE3MT+pxMKk4FtXK6id/06
 6b5568NfOV29Rvma1ihDAPcw2FOhoBolh+m6LfxkNseUz2i050vAuyGD0f6WJC7zN/rJ
 3l/g==
X-Gm-Message-State: AFuF++nDBuJTcwu+cg1NoF3po6tMkP4d/quFDKNn2LVHxfIHDz5bnUaG
 7D+s+UVTOm9EmWu8h3Xz1uDkdm0EKfsHDK84EAAtp3+r6ZF9FCEQjm3LOIycDxCVpmr6jsY1Dm/
 RC9cSKjSF7F72musWXtuZYVp4ibknWUZ9x2wy7npA+iQYpK6jBYDmqTr0muOfzhMWEA==
X-Gm-Gg: AYBFou15GITZHdRkrcOOjSxwB+wgiltDZ10NEtbgjWFBYtLLu1G3v/Ellk2jZFdzqVM
 YF5zo5zouu+UtYqBXiaox3E3JEs8Lp8ssXGBLw+nt7FCpodp8YkLM/yKRXQ8aGcwsyS61of3aqP
 GFSmgHYLNOu+/1p1UmcFnGLPOJhkBQjcOIplCuVgJzm8NoHG4QfWL1ayUbPjfQsZSpWaMZyh1TX
 WQlg3lA2N3WNWnab3xBTtBq7bwrAUQzQtK91+C9JAVSncrubHgJx4xyYlpfDQkP2IzfVNohuttX
 4i+zA7YEFzaLIaJpmrJ5YZB2Upd93m06duj1z7omscE7abuvekRvXH/dw12JM0sIwjE51R6ZGeo
 B3MSrMN0CJqd4k+VqLLPGRuv74DizMrZHfuMe6l0wwqYj390=
X-Received: by 2002:a05:701b:21c5:b0:13f:ad08:44aa with SMTP id
 a92af1059eb24-146ce491ecbmr5720226c88.13.1790477031854; 
 Sat, 26 Sep 2026 19:43:51 -0700 (PDT)
X-Received: by 2002:a05:701b:21c5:b0:13f:ad08:44aa with SMTP id
 a92af1059eb24-146ce491ecbmr5720192c88.13.1790477031248; 
 Sat, 26 Sep 2026 19:43:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145ac67c3f8sm15459747c88.3.2026.09.26.19.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 19:43:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 2/5] target/hexagon: clear LL/SC reservations at context
 boundaries
Date: Sat, 26 Sep 2026 19:43:44 -0700
Message-Id: <20260927024347.3545385-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260927024347.3545385-1-brian.cain@oss.qualcomm.com>
References: <20260927024347.3545385-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAxMCBTYWx0ZWRfX5mjl3y7Ovoog
 rXxCZrTbGgfTe0kAbizf9hCmqbZ241fVyX5ABoDrQ3+4vG7v77dxSfwXvQ88coYlQ1Tk0o/Z12f
 iTCpL5B63lbnksqVk7Dvv/0d3Rg+D1caLFnLfRXUmC8iSOkmJR7lG0LuohAd8W6mZ5D9DvPAPuM
 ZBEXxTxyZxoC1n/qHLcF7ruHtnVb0k79KtcjBr0vTSoq4gomXQy4lAc2j5YKwHzFwBoC/cVIxFc
 ayjLa7WGMJ6VIceARdCXiyz7mxpO/1u4mhHG5CgMx/7e6CFHbVItkfVB2arA4Nm+l+qhOPhd2HZ
 O7PLIrcX8WG/HWYrl+tnsKy0IL5sS0OlrtKLJC+N3Cum2cQXmJa2OXl6h1ZPX1zSMPDtlQq3m0B
 PM/KfC+gBkQnQ4QGbjAGZ7I73jCStVKCClvmTjb9x9+zRtvPfoULV6TBbTjIExLJPSrGHxvbcvh
 CxqKlLjbFIMDZ3owYhw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAxMCBTYWx0ZWRfX+yWn4Bb5VSYn
 s9+HaNuZdjMGWhr0WYQXaTTk0SQ7BElUFqydzFiLuoiJwswBboLJ2JQ9OiqhGZXQ58cMu7ZbELZ
 gBETxvdQcKlm9QeSPq9SfL3L0sjzS6s=
X-Proofpoint-GUID: cgbJhIAhNDYolO34UR6ebl4Ep7liHh4a
X-Authority-Analysis: v=2.4 cv=QvLLTlyd c=1 sm=1 tr=0 ts=6ab882e8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=nIBb1lFIQW7svKiJGhEA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: cgbJhIAhNDYolO34UR6ebl4Ep7liHh4a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270010
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

U2V0IGxsc2NfYWRkciB0byB+MCBkdXJpbmcgcmVzZXQgYW5kIHNvZnQgcmVzZXQsIGFuZCB3aGVu
ZXZlciBsaW51eC11c2VyCnJldHVybnMgdG8gZ3Vlc3QgY29kZSBmb3IgYSB0cmFwIG9yIGEgc2ln
bmFsLgoKUmVzZXQgcHJldmlvdXNseSBsZWZ0IGxsc2NfYWRkciB6ZXJvLWluaXRpYWxpemVkLCBz
byBhIHN0b3JlLWNvbmRpdGlvbmFsCmlzc3VlZCB3aXRob3V0IGEgbWF0Y2hpbmcgbG9hZC1sb2Nr
ZWQgY291bGQgbWF0Y2ggYSBndWVzdCBhZGRyZXNzIG9mCnplcm8uCgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogbGludXgtdXNlci9o
ZXhhZ29uL2NwdV9sb29wLmMgfCA0ICsrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICAg
IHwgMyArKysKIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
bGludXgtdXNlci9oZXhhZ29uL2NwdV9sb29wLmMgYi9saW51eC11c2VyL2hleGFnb24vY3B1X2xv
b3AuYwppbmRleCBlNGVmOTdhMTE4NC4uZTZiYjNiNjJhOWYgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVz
ZXIvaGV4YWdvbi9jcHVfbG9vcC5jCisrKyBiL2xpbnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5j
CkBAIC0zOSw2ICszOSwxMCBAQCB2b2lkIGNwdV9sb29wKENQVUhleGFnb25TdGF0ZSAqZW52KQog
ICAgICAgICBjcHVfZXhlY19lbmQoY3MpOwogICAgICAgICBxZW11X3Byb2Nlc3NfY3B1X2V2ZW50
cyhjcyk7CiAKKyAgICAgICAgaWYgKHRyYXBuciAhPSBFWENQX0FUT01JQyAmJiB0cmFwbnIgIT0g
RVhDUF9ZSUVMRCkgeworICAgICAgICAgICAgZW52LT5sbHNjX2FkZHIgPSB+MDsKKyAgICAgICAg
fQorCiAgICAgICAgIHN3aXRjaCAodHJhcG5yKSB7CiAgICAgICAgIGNhc2UgRVhDUF9JTlRFUlJV
UFQ6CiAgICAgICAgICAgICAvKiBqdXN0IGluZGljYXRlIHRoYXQgc2lnbmFscyBzaG91bGQgYmUg
aGFuZGxlZCBhc2FwICovCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS5jCmluZGV4IDFmN2Q4YThkZjcwLi43MzQ3YTMzNDJjZSAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTQx
MSw2ICs0MTEsNyBAQCB2b2lkIGhleGFnb25fY3B1X3NvZnRfcmVzZXQoQ1BVSGV4YWdvblN0YXRl
ICplbnYpCiAgICAgSGV4YWdvbkNQVSAqY3B1OwogCiAgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKyAg
ICBlbnYtPmxsc2NfYWRkciA9IH4wOwogICAgIGVudi0+dF9zcmVnW0hFWF9TUkVHX1NTUl0gPSAw
OwogICAgIGhleGFnb25fc3NyX3NldF9jYXVzZShlbnYsIEhFWF9DQVVTRV9SRVNFVCk7CiAKQEAg
LTQ0Niw2ICs0NDcsOCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9yZXNldF9ob2xkKE9iamVj
dCAqb2JqLCBSZXNldFR5cGUgdHlwZSkKIAogICAgIHNldF9kZWZhdWx0X25hbl9tb2RlKDEsICZl
bnYtPmh2eF9mcF9zdGF0dXMpOwogICAgIHNldF9mbG9hdF9kZWZhdWx0X25hbl9wYXR0ZXJuKDBi
MDExMTExMTEsICZlbnYtPmh2eF9mcF9zdGF0dXMpOworCisgICAgZW52LT5sbHNjX2FkZHIgPSB+
MDsKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQogICAgIG1lbXNldChlbnYtPnRfc3JlZywgMCwg
c2l6ZW9mKHVpbnQzMl90KSAqIE5VTV9TUkVHUyk7CiAgICAgbWVtc2V0KGVudi0+Z3JlZywgMCwg
c2l6ZW9mKHVpbnQzMl90KSAqIE5VTV9HUkVHUyk7Ci0tIAoyLjM0LjEKCg==

