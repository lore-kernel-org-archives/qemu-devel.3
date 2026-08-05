Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5094C561E6
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrer7-0005t6-8L; Wed, 05 Aug 2026 12:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrer4-0005sZ-NM
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:52:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrer3-000350-1u
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:52:34 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675FVHNp3867833
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 16:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i0yyzx7IRthUL/mEubksJFQ21MXOWiA+b7IgPoE8PCo=; b=P0V/S1kF6qFCdttu
 KVBkWLWyM1yFJNmrvG9jTqvOfyzbx+4UaXJyESPqGEI3scCOvuDIDNB716noyqqm
 IdizUdcGmJySPgZ0dsh+t79Dk/LyX9HYcQZe1pwnHEdZso82t9+Icm7v7uXfjUyI
 oaOSgP8+166GY4YUYGEM0clZSTMXlOiR1i0AWQ0KL9gnq8EawYy6pl++q2HiRmS9
 Vs9lAZJNAlPGQOD7v14nIniiAd2lTAiuOoFkaKN/VxDR9EoUSVmFkCnMWsCONikE
 KzDhXJ4wJi4Fnrt9BzywR5rrLd58UcjEKgn1tv7uIxNHQWjmKOu9Q89ET+pwfY6r
 LOKCAQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5dk1801-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 16:52:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc88e22f92so26734185ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785948751; x=1786553551; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i0yyzx7IRthUL/mEubksJFQ21MXOWiA+b7IgPoE8PCo=;
 b=E9GXior3aY2cvoyc67nttmZdoKS3v+sngdbfR8dEC8Mpu/7/qjsu9kc/at6X54PO2w
 96tLbvkhCVfWWrSqLePAUlqF+5RXDlmR1qm0QX21Ua4f7n1LeyC7g4+oJmOpmMrHlTyg
 7lqYZdsNViYM8dxYmUoMYbB1MQAG2ZW0zkrFSvGvuQDHh/BI9p95LFHfmJFBbDqcEW2q
 /DaIw01J75Fhkt4Go59s09OyHmJRlaC8qpJi9fud5evyONPGemsL+9Xe2Dp8VxcsmO5/
 t3+tjttHXDQazrLHwE/thsVJiDL4YGDeZq6hbcy1EVCeai2VHC7oLZ7XeTxiccD4Q+Dv
 nZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785948751; x=1786553551;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i0yyzx7IRthUL/mEubksJFQ21MXOWiA+b7IgPoE8PCo=;
 b=d5/KBU2wPPyvKIxAQgkemAKlEFqWNJt7Svxa3Hii9YsrParw9xuUxQ8rNDMulI9KpZ
 mUZaoFPESbl8G2j3J78XDYHH++cId7inpIxBkmYyBVXQZCA02VmKUlivy+na0P+Q7HBz
 ZCG1Ktv8pKZ8DEE7xNA2q6ReiyICmUdAqzVKeNI1mfjUgjEXuX06TpgCid/5ym7fs9jc
 L7763tPNMRBmLEd67jtG+vHzZdCtUm0t5bAH4yapE4RDCu2glbE8vdZ5iIV11rUjQB+B
 xClwcsmSvS44QiDeBgCcXMs4VCS1A1ej3FMXt2ksipWOHm5lSaN/++D167CQUx8hu6VB
 JIxg==
X-Gm-Message-State: AOJu0YxexFbV6N+4oiTLCUYXsZF8x3z2Wtx67GjW+XHWf9zTdRgHODrB
 jHdyiQvnyBv/8NSb9X3zf51csX+flkn/MRN9NVhWqdh6MHafbwNgP+JP5vhVURjNarlQyPWU0dT
 LquWVXeb4tBbgMmG0F3zlNIkdJ9+ZdTL6Eeio0nRZi1kpSY/UKBCn0nv+wyMQBKoe1A==
X-Gm-Gg: AR+sD132vB70ELPeo78wMsYr7qoI/sJuejnQRAq+mp3wWKvgXx8YCVJmzap6uWx+dZd
 s6nCjffIcj4+aGoo843BrnlYkzNxM1NfbLDzAnQk/4HVmDKLzdDy1UwnfPMPmdx7bjuiBp/fK0M
 9OX1pBmjqKAtMfg5BPGUFxpUqnhoQiQKsedmRjM5nnPAALwHnGIT3r7L7mdmaQIMVKO2lmAUhSq
 sHdmEqkMcshrTSxvex7sdTo1QiDQPXh7BI2Qu6Wv8zsS8y7kLTQyE9rCw74mkaeSrJTVxG4f8a+
 BFRKsSxomoflAZs3JCGDulURsDJWcabtnm0CkkNzwt2rntbwgUHUTKWYvwfFycojgpXsK4iZtVh
 M/A10dSrhhUmOyUuQHvZc6TeS0ZWw5NVUQCh3VtkVxJnvP2tX
X-Received: by 2002:a05:6a21:70c8:b0:3c3:b226:f165 with SMTP id
 adf61e73a8af0-3cb8603af69mr9304959637.35.1785948750599; 
 Wed, 05 Aug 2026 09:52:30 -0700 (PDT)
X-Received: by 2002:a05:6a21:70c8:b0:3c3:b226:f165 with SMTP id
 adf61e73a8af0-3cb8603af69mr9304908637.35.1785948750143; 
 Wed, 05 Aug 2026 09:52:30 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586402e53sm26429356eec.11.2026.08.05.09.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 09:52:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org
Subject: [PATCH 2/6] target/hexagon: add GVec overrides for HVX saturating
 add/sub
Date: Wed,  5 Aug 2026 09:52:21 -0700
Message-Id: <20260805165225.3117924-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
References: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 8FkNp61bN2NInzfFSRbaWhfvfwrOk_I0
X-Authority-Analysis: v=2.4 cv=Or9/DS/t c=1 sm=1 tr=0 ts=6a736a4f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=YGnXqKny2LhDWXJfIGkA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEzOCBTYWx0ZWRfX8Sl879rQPb+f
 efetf2uqoqJHjqce+mSphV1dxEQZXHyfSWG+jrg/obcMe2wIu4CsK0x9CPOLdPkVPwbFdUMiwRt
 ZpowkQn7+9Er50+hUjlS3j8oR7i1ES6wuZyL6qRTdkKtrzhEzffRte0GY//0umTxLezAF95cfRC
 ogbk6TUknzmzrnoEcWHbbkpk3NdM5/lqIcfYjRoiupeStiqXrXWQKxtRghkppzGnV8TLyK7YrZc
 JZgtJZ1cm6VBDLjGQuobrus2fzo/HHuB73cQfhSrvF84NXwxmguEqVTDvTP0UcC0UWs6Vzq6q+2
 RiV5uLDZ6WuXdZDS0v88ilDkLKEGNP/gf8OVeYaf6tcUoCBnFgWoaU/qybqVn5f0KMI1Jv7/CuN
 sbxW3w3IJ/GcA9rNSJpcvnzgKPb83E7uGZWaOg7i53aLNN/paxYVutow2ULJYOkKKqJvgRQ/JAR
 Y3ZbZ53XH6Pz29Fcszw==
X-Proofpoint-GUID: 8FkNp61bN2NInzfFSRbaWhfvfwrOk_I0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEzOCBTYWx0ZWRfX0rCJ9XJ2D6qC
 gqVc62HYK7+NBDCI5T8cknDpTvDWD8OF7axIsDxNf8SevpWq9LahWJ/VPIU9sN6alt/9UlWLJp8
 FlZvBvm+W2Ej5sgAr6IjqqMTIzpAvnI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050138
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRhcmdldC9oZXhhZ29uL2dlbl90Y2dfaHZ4LmggfCA5MyArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA5MyBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaCBiL3RhcmdldC9oZXhhZ29uL2dl
bl90Y2dfaHZ4LmgKaW5kZXggMGRhNjRkNDY3ZTYuLjQzYTBmMzU4ZjAwIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2df
aHZ4LmgKQEAgLTIzNCw2ICsyMzQsOTkgQEAgc3RhdGljIGlubGluZSB2b2lkIGFzc2VydF92aGlz
dF90bXAoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgdGNnX2dlbl9ndmVjX3N1YihNT18zMiwgVmRk
Vl9vZmYsIFZ1dVZfb2ZmLCBWdnZWX29mZiwgXAogICAgICAgICAgICAgICAgICAgICAgc2l6ZW9m
KE1NVmVjdG9yKSAqIDIsIHNpemVvZihNTVZlY3RvcikgKiAyKQogCisjZGVmaW5lIGZHRU5fVENH
X1Y2X3ZhZGRic2F0KFNIT1JUQ09ERSkgXAorICAgIHRjZ19nZW5fZ3ZlY19zc2FkZChNT184LCBW
ZFZfb2ZmLCBWdVZfb2ZmLCBWdlZfb2ZmLCBcCisgICAgICAgICAgICAgICAgICAgICAgIFZFQ1RP
Ul9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZVEUpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmFk
ZGhzYXQoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9ndmVjX3NzYWRkKE1PXzE2LCBWZFZfb2Zm
LCBWdVZfb2ZmLCBWdlZfb2ZmLCBcCisgICAgICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpF
X0JZVEUsIFZFQ1RPUl9TSVpFX0JZVEUpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmFkZHdzYXQo
U0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9ndmVjX3NzYWRkKE1PXzMyLCBWZFZfb2ZmLCBWdVZf
b2ZmLCBWdlZfb2ZmLCBcCisgICAgICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUs
IFZFQ1RPUl9TSVpFX0JZVEUpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmFkZHVic2F0KFNIT1JU
Q09ERSkgXAorICAgIHRjZ19nZW5fZ3ZlY191c2FkZChNT184LCBWZFZfb2ZmLCBWdVZfb2ZmLCBW
dlZfb2ZmLCBcCisgICAgICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RP
Ul9TSVpFX0JZVEUpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmFkZHVoc2F0KFNIT1JUQ09ERSkg
XAorICAgIHRjZ19nZW5fZ3ZlY191c2FkZChNT18xNiwgVmRWX29mZiwgVnVWX29mZiwgVnZWX29m
ZiwgXAorICAgICAgICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0la
RV9CWVRFKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZhZGR1d3NhdChTSE9SVENPREUpIFwKKyAg
ICB0Y2dfZ2VuX2d2ZWNfdXNhZGQoTU9fMzIsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2Vl9vZmYsIFwK
KyAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVfQllU
RSkKKworI2RlZmluZSBmR0VOX1RDR19QQUlSX0FERFNVQihPUCwgVkVDRSwgRFNULCBTUkNfQSwg
U1JDX0IpIFwKKyAgICBkbyB7IFwKKyAgICAgICAgdGNnX2dlbl9ndmVjXyMjT1AoVkVDRSwgRFNU
LCBTUkNfQSwgU1JDX0IsIFwKKyAgICAgICAgICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9C
WVRFLCBWRUNUT1JfU0laRV9CWVRFKTsgXAorICAgICAgICB0Y2dfZ2VuX2d2ZWNfIyNPUChWRUNF
LCBEU1QgKyBzaXplb2YoTU1WZWN0b3IpLCBcCisgICAgICAgICAgICAgICAgICAgICAgICAgU1JD
X0EgKyBzaXplb2YoTU1WZWN0b3IpLCBcCisgICAgICAgICAgICAgICAgICAgICAgICAgU1JDX0Ig
KyBzaXplb2YoTU1WZWN0b3IpLCBcCisgICAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJ
WkVfQllURSwgVkVDVE9SX1NJWkVfQllURSk7IFwKKyAgICB9IHdoaWxlICgwKQorCisjZGVmaW5l
IGZHRU5fVENHX1Y2X3ZhZGRic2F0X2R2KFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1BBSVJf
QUREU1VCKHNzYWRkLCBNT184LCBWZGRWX29mZiwgVnV1Vl9vZmYsIFZ2dlZfb2ZmKQorCisjZGVm
aW5lIGZHRU5fVENHX1Y2X3ZhZGRoc2F0X2R2KFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1BB
SVJfQUREU1VCKHNzYWRkLCBNT18xNiwgVmRkVl9vZmYsIFZ1dVZfb2ZmLCBWdnZWX29mZikKKwor
I2RlZmluZSBmR0VOX1RDR19WNl92YWRkd3NhdF9kdihTSE9SVENPREUpIFwKKyAgICBmR0VOX1RD
R19QQUlSX0FERFNVQihzc2FkZCwgTU9fMzIsIFZkZFZfb2ZmLCBWdXVWX29mZiwgVnZ2Vl9vZmYp
CisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmFkZHVic2F0X2R2KFNIT1JUQ09ERSkgXAorICAgIGZH
RU5fVENHX1BBSVJfQUREU1VCKHVzYWRkLCBNT184LCBWZGRWX29mZiwgVnV1Vl9vZmYsIFZ2dlZf
b2ZmKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZhZGR1aHNhdF9kdihTSE9SVENPREUpIFwKKyAg
ICBmR0VOX1RDR19QQUlSX0FERFNVQih1c2FkZCwgTU9fMTYsIFZkZFZfb2ZmLCBWdXVWX29mZiwg
VnZ2Vl9vZmYpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmFkZHV3c2F0X2R2KFNIT1JUQ09ERSkg
XAorICAgIGZHRU5fVENHX1BBSVJfQUREU1VCKHVzYWRkLCBNT18zMiwgVmRkVl9vZmYsIFZ1dVZf
b2ZmLCBWdnZWX29mZikKKworI2RlZmluZSBmR0VOX1RDR19WNl92c3ViYnNhdChTSE9SVENPREUp
IFwKKyAgICB0Y2dfZ2VuX2d2ZWNfc3NzdWIoTU9fOCwgVmRWX29mZiwgVnVWX29mZiwgVnZWX29m
ZiwgXAorICAgICAgICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0la
RV9CWVRFKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZzdWJoc2F0KFNIT1JUQ09ERSkgXAorICAg
IHRjZ19nZW5fZ3ZlY19zc3N1YihNT18xNiwgVmRWX29mZiwgVnVWX29mZiwgVnZWX29mZiwgXAor
ICAgICAgICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0laRV9CWVRF
KQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZzdWJ3c2F0KFNIT1JUQ09ERSkgXAorICAgIHRjZ19n
ZW5fZ3ZlY19zc3N1YihNT18zMiwgVmRWX29mZiwgVnVWX29mZiwgVnZWX29mZiwgXAorICAgICAg
ICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0laRV9CWVRFKQorCisj
ZGVmaW5lIGZHRU5fVENHX1Y2X3ZzdWJ1YnNhdChTSE9SVENPREUpIFwKKyAgICB0Y2dfZ2VuX2d2
ZWNfdXNzdWIoTU9fOCwgVmRWX29mZiwgVnVWX29mZiwgVnZWX29mZiwgXAorICAgICAgICAgICAg
ICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0laRV9CWVRFKQorCisjZGVmaW5l
IGZHRU5fVENHX1Y2X3ZzdWJ1aHNhdChTSE9SVENPREUpIFwKKyAgICB0Y2dfZ2VuX2d2ZWNfdXNz
dWIoTU9fMTYsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2Vl9vZmYsIFwKKyAgICAgICAgICAgICAgICAg
ICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVfQllURSkKKworI2RlZmluZSBmR0VO
X1RDR19WNl92c3VidXdzYXQoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9ndmVjX3Vzc3ViKE1P
XzMyLCBWZFZfb2ZmLCBWdVZfb2ZmLCBWdlZfb2ZmLCBcCisgICAgICAgICAgICAgICAgICAgICAg
IFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZVEUpCisKKyNkZWZpbmUgZkdFTl9UQ0df
VjZfdnN1YmJzYXRfZHYoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfUEFJUl9BRERTVUIoc3Nz
dWIsIE1PXzgsIFZkZFZfb2ZmLCBWdXVWX29mZiwgVnZ2Vl9vZmYpCisKKyNkZWZpbmUgZkdFTl9U
Q0dfVjZfdnN1YmhzYXRfZHYoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfUEFJUl9BRERTVUIo
c3NzdWIsIE1PXzE2LCBWZGRWX29mZiwgVnV1Vl9vZmYsIFZ2dlZfb2ZmKQorCisjZGVmaW5lIGZH
RU5fVENHX1Y2X3ZzdWJ3c2F0X2R2KFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1BBSVJfQURE
U1VCKHNzc3ViLCBNT18zMiwgVmRkVl9vZmYsIFZ1dVZfb2ZmLCBWdnZWX29mZikKKworI2RlZmlu
ZSBmR0VOX1RDR19WNl92c3VidWJzYXRfZHYoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9UQ0dfUEFJ
Ul9BRERTVUIodXNzdWIsIE1PXzgsIFZkZFZfb2ZmLCBWdXVWX29mZiwgVnZ2Vl9vZmYpCisKKyNk
ZWZpbmUgZkdFTl9UQ0dfVjZfdnN1YnVoc2F0X2R2KFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENH
X1BBSVJfQUREU1VCKHVzc3ViLCBNT18xNiwgVmRkVl9vZmYsIFZ1dVZfb2ZmLCBWdnZWX29mZikK
KworI2RlZmluZSBmR0VOX1RDR19WNl92c3VidXdzYXRfZHYoU0hPUlRDT0RFKSBcCisgICAgZkdF
Tl9UQ0dfUEFJUl9BRERTVUIodXNzdWIsIE1PXzMyLCBWZGRWX29mZiwgVnV1Vl9vZmYsIFZ2dlZf
b2ZmKQogLyogVmVjdG9yIHNoaWZ0IHJpZ2h0IC0gdmFyaW91cyBmb3JtcyAqLwogI2RlZmluZSBm
R0VOX1RDR19WNl92YXNyaChTSE9SVENPREUpIFwKICAgICBkbyB7IFwKLS0gCjIuMzQuMQoK

