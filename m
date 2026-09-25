Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2131C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vA0-0005K6-EI; Thu, 24 Sep 2026 21:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9s-0005Cu-A4
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9q-00066l-78
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:27 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1l5gk4133030
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hRpOAAmPkxRy8tVUpIWqs9FFG5bf3DWD2jGR8TiQ8p8=; b=EeF+JrSt7NqbeDcZ
 WVXN6ZvFSOR+oY9euoBI4KeBuY6oXuoqwm/d4B0ehMa2xAY21erorZqzItqz2i7K
 aJXgFwBgGQp+xp2acbug8itM2050EqzMZQm8CTajxAnFD/HgjVT0LbJWx9GCnqku
 gZ+RZ7DJtHQAwbUf9NT3t/xyIu2SLHzCFXvSgcPKsp3xkNreDqtbtXTdEYAmD/Qp
 hSySLi53OxkIgcDq2Cx5FJaLjqXdQa9vL5rL8AjqWiAI+f4dIHdsu4f+Y4dTxMvd
 X0Z5Ng9s8HbxtepGR5NMvYZ9LJOY2Qy0bQ/tJPwHuHnad3m3pv/9YV6qhQT/wy1p
 XL12QA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw881sjw7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-338c2e27430so377693eec.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301314; x=1790906114; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hRpOAAmPkxRy8tVUpIWqs9FFG5bf3DWD2jGR8TiQ8p8=;
 b=itry1tkstQL8X7YVdpBdFTKUWGKvLfBbiklMBWjHKcAYogQT70ElPXq5aMXrUadRU+
 SpZiGsj2YZSRWIUCg48IA/KqgX5fczmqr/OAfo0HJ7rE5mYSKTxIrpwGpQFQKuMfSuI6
 Cx7eHtni+1E8ym/LRaVAPPE2dXRmdZx53i8guer8+0DcBp9hhawqzaP7qpEfwPRNGsyi
 H6SfPyGnXJUFCH4HO1YhzHq/CThkdWNTT3UB8LdF+tvxZuFj3XCOjTnna9Js4xVzWelo
 AO5G9mr5cREvrSt+OZFF0fR/DHdolsqB3xVYrSn9J3+Xpq7xLdyAkzcVRZwkU2+SlgQ+
 qVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301314; x=1790906114;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hRpOAAmPkxRy8tVUpIWqs9FFG5bf3DWD2jGR8TiQ8p8=;
 b=wreP3Kl2v9mYlAh2Rz858avb7K0+AQxWoyhaXUrn1uS0PFL7QLNrYK40frEbyHxBV4
 tEgFDpvFMUdhjp69jE3yoZzHkyZfJgV3S7GHXQ0MLRIxXKqc1YI/rJjjAhgFd5JX7wz4
 kkFwALofH3eNh4QJsyhzaJnCkqsh/bsrNcbbapp5gxzzKi6vzlJOupefokTPKIX6Ojgq
 BlmCMnYdtYANRxgaZvdyHWZ3Ff8v4TbN5suLJURshVZvvXCKgyh1Mk03Ycj4B+2Nuxhr
 kvAFKa4p74jW56euO59UppQlMpvX18haHu54DkYt33unwvw2z5peFgzdW2sleLJBejIh
 OLqQ==
X-Gm-Message-State: AFuF++lcLg3zGUvb+rqXkCD5ufCKefuVhxbPQNSt4YLZNQSsfovb5Hds
 JB+7ICVaO216bU1f3i8pXdp3iBV3gaVDGeM4v3sJoZvD7Ps29HoaJlNfK4DwZAFwFFfNcOS5hU7
 udU6bOlekGNKwCUSHh5FYHrpslAUmIHcFI8ZcGiSsTjygu3UlzIBDSIMD29f/cezfHQ==
X-Gm-Gg: AYBFou3Qnqz1ELiiMc5GTTrzanXRO1ibEqximmg32tjlWKJx+JPtAnhlzKulRPPyhyJ
 PXdaegK+H/eEVMqrDwS4aTzvTIzsAzXO5r4TGKdkU4/cAdv+TFW2Vua+aEl4hA1kbOj2iHilmKJ
 y+ZdsgKVbZuLxfiGg/HPacN+TXVdzQFyPeUN68QRPZExpxwi6SGnzTY6GsRMQmq3zCulQzki/QB
 zevx+QgkMWv1mu940RUTkacOAFBmYn348yiTo9mh9YF54c4qZrznqSBJahnzxU+j2dMEGofksjE
 DYpIrfeOXvTX9S/p1YlIFVFC5h1cArxUbMp60HSnLAY5PDKdPjclYPeT0mtZsOXNbh6Au3SEsJy
 6gDWB8HV/GTOP0bBmDpFZ0ZYMs2nktqz+3NvBzw4bqsALpJg=
X-Received: by 2002:a05:693c:87c3:20b0:340:f698:fd70 with SMTP id
 5a478bee46e88-34197cabaf4mr321267eec.18.1790301314081; 
 Thu, 24 Sep 2026 18:55:14 -0700 (PDT)
X-Received: by 2002:a05:693c:87c3:20b0:340:f698:fd70 with SMTP id
 5a478bee46e88-34197cabaf4mr321249eec.18.1790301313371; 
 Thu, 24 Sep 2026 18:55:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:55:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 26/40] tests/tcg/hexagon: add scalar+HVX and masked store tests
Date: Thu, 24 Sep 2026 18:54:15 -0700
Message-Id: <20260925015429.2579174-27-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6ab5d483 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ZgKQQoYZz-FTevMfDfAA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX0GwL7WLMEAW1
 ci/xCbtp3g8Fvaui7I7oEu9mYhNIHjfxmy3vDUt31mUhlTgevIcQqQWaV8CHdAxYuxKUAmOIKDm
 cCIVdYytHEBBRLtwGNwH7TtiEpkg3BIrIcahsF5jOLxzYZc6nuSgss29TsE7s9m9DNHg6squS8C
 +ZTqy6pHYSTsn2MWdoaaFwYurLbZysjmBtOCEsS9XMfjVSiU5rHuRikZOFz3zHoUfNyPd6tOTyY
 FJ9u4ZK10y4Jw4pfaQFcjcXGNIvfsZvtdTgLI8Xns9iyw5EMdDE21Q8Qy0oZXK5fXSDoIxNMOA1
 IEz6hDYU9VIn1YSAKJB9KBYU7YTqKM8ezaYHZEbtPUX6y9jLQn5RLcT1+g7x7AMLqNSZ4Ce+b3v
 P5jsTUBEN6/p+1YknOCa9kQVStFnZQZqDUg4iIS+yhdYNINmF1S1qyjTXvODHcgRK/CPbPkLfdw
 joIOKCa8+zYv11jZ/SQ==
X-Proofpoint-ORIG-GUID: L_-kBHLkWLaN9XL3OH60J-zkTseJM7nC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfXwiGk3g6/R1In
 eYhZjcs/ahSnLPS7uP/Ud5xd74CsFMPorYxLuFHuMVw85OvcSeQ/C1ehVYLl2FzkCVE/wZKQeCy
 PMClIIW8y/dFijOrbLtjcaiklwG2+5g=
X-Proofpoint-GUID: L_-kBHLkWLaN9XL3OH60J-zkTseJM7nC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250007
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

VGVzdCBhIHBhY2tldCB3aXRoIGJvdGggYSBzY2FsYXIgc3RvcmUgYW5kIGFuIEhWWCBzdG9yZSwg
YW5kIHRlc3QKYSBub24taW52ZXJ0ZWQgbWFza2VkIHN0b3JlIChpZiAocTApIHZtZW0pIHRvIHZl
cmlmeSB0aGUgaW52ZXJ0PWZhbHNlCnBhdGggaW4gbWFza2VkIHN0b3JlIGdlbmVyYXRpb24uCgpS
ZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNv
bW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29t
bS5jb20+Ci0tLQogdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYyB8IDY2ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDY2IGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jIGIvdGVzdHMvdGNn
L2hleGFnb24vaHZ4X21pc2MuYwppbmRleCBmMjBhZmM4ZTY3MC4uMDI4NTg4NmMyYTUgMTAwNjQ0
Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMKKysrIGIvdGVzdHMvdGNnL2hleGFn
b24vaHZ4X21pc2MuYwpAQCAtNTY2LDYgKzU2Niw2OSBAQCB2b2lkIHRlc3Rfc3RvcmVfbmV3KCkK
ICAgICBjaGVja19vdXRwdXRfdyhfX0xJTkVfXywgMSk7CiB9CiAKKy8qCisgKiBUZXN0IGEgcGFj
a2V0IHdpdGggYm90aCBhIHNjYWxhciBzdG9yZSBhbmQgYW4gSFZYIHN0b3JlLgorICovCitzdGF0
aWMgdWludDMyX3Qgc2NhbGFyX3N0b3JlX2RzdDsKKworc3RhdGljIHZvaWQgdGVzdF9zY2FsYXJf
aHZ4X3N0b3JlKHZvaWQpCit7CisgICAgc2NhbGFyX3N0b3JlX2RzdCA9IDA7CisgICAgbWVtc2V0
KCZleHBlY3RbMF0sIDAsIHNpemVvZihNTVZlY3RvcikpOworCisgICAgLyogRmlsbCB2MCB3aXRo
IDB4QUJDRCBwYXR0ZXJuICovCisgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBNQVhfVkVDX1NJWkVf
QllURVMgLyA0OyBpKyspIHsKKyAgICAgICAgZXhwZWN0WzBdLnV3W2ldID0gMHhBQkNEQUJDRDsK
KyAgICB9CisKKyAgICBhc20oInIwID0gIzB4QUJDREFCQ0Rcblx0IgorICAgICAgICAidjAgPSB2
c3BsYXQocjApXG5cdCIKKyAgICAgICAgInIxID0gIzQyXG5cdCIKKyAgICAgICAgIntcblx0Igor
ICAgICAgICAiICAgIG1lbXcoJVtzY2FsYXJdKSA9IHIxXG5cdCIKKyAgICAgICAgIiAgICB2bWVt
KCVbaHZ4XSkgPSB2MFxuXHQiCisgICAgICAgICJ9XG5cdCIKKyAgICAgICAgOgorICAgICAgICA6
IFtzY2FsYXJdICJyIigmc2NhbGFyX3N0b3JlX2RzdCksCisgICAgICAgICAgW2h2eF0gInIiKCZv
dXRwdXRbMF0pCisgICAgICAgIDogInIwIiwgInIxIiwgInYwIiwgIm1lbW9yeSIpOworCisgICAg
Y2hlY2tfb3V0cHV0X3coX19MSU5FX18sIDEpOworICAgIGlmIChzY2FsYXJfc3RvcmVfZHN0ICE9
IDQyKSB7CisgICAgICAgIHByaW50ZigiRVJST1IgYXQgbGluZSAlZDogc2NhbGFyX3N0b3JlX2Rz
dCA9ICVkLCBleHBlY3RlZCA0MlxuIiwKKyAgICAgICAgICAgICAgIF9fTElORV9fLCBzY2FsYXJf
c3RvcmVfZHN0KTsKKyAgICAgICAgZXJyKys7CisgICAgfQorfQorCisvKgorICogVGVzdCBub24t
aW52ZXJ0ZWQgbWFza2VkIHN0b3JlOiBpZiAoUXYpIHZtZW0oUnQpID0gVnMuCisgKiBFeGlzdGlu
ZyB0ZXN0cyBvbmx5IGNvdmVyIHRoZSBpbnZlcnRlZCBmb3JtICghUXYpLgorICogVXNlIGFuIGFs
bC10cnVlIFEgcHJlZGljYXRlIHRvIHVuY29uZGl0aW9uYWxseSBzdG9yZS4KKyAqLworc3RhdGlj
IHZvaWQgdGVzdF9tYXNrZWRfc3RvcmVfbm9uaW52ZXJ0KHZvaWQpCit7CisgICAgdm9pZCAqcDAg
PSBidWZmZXIwOworICAgIHZvaWQgKnBvdXQgPSBvdXRwdXQ7CisKKyAgICBtZW1zZXQoJm91dHB1
dFswXSwgMHhmZiwgc2l6ZW9mKE1NVmVjdG9yKSk7CisKKyAgICBmb3IgKGludCBpID0gMDsgaSA8
IE1BWF9WRUNfU0laRV9CWVRFUyAvIDQ7IGkrKykgeworICAgICAgICBleHBlY3RbMF0udXdbaV0g
PSBidWZmZXIwWzBdLnV3W2ldOworICAgIH0KKworICAgIGFzbSgidjUgPSB2bWVtKCVbc3JjXSAr
ICMwKVxuXHQiCisgICAgICAgICJyMCA9ICMtMVxuXHQiCisgICAgICAgICJ2NiA9IHZzcGxhdChy
MClcblx0IgorICAgICAgICAicTAgPSB2YW5kKHY2LCByMClcblx0IgorICAgICAgICAiaWYgKHEw
KSB2bWVtKCVbZHN0XSkgPSB2NVxuXHQiCisgICAgICAgIDoKKyAgICAgICAgOiBbc3JjXSAiciIo
cDApLCBbZHN0XSAiciIocG91dCkKKyAgICAgICAgOiAicjAiLCAidjUiLCAidjYiLCAicTAiLCAi
bWVtb3J5Iik7CisKKyAgICBjaGVja19vdXRwdXRfdyhfX0xJTkVfXywgMSk7Cit9CisKIGludCBt
YWluKCkKIHsKICAgICBpbml0X2J1ZmZlcnMoKTsKQEAgLTYxNSw2ICs2NzgsOSBAQCBpbnQgbWFp
bigpCiAKICAgICB0ZXN0X3N0b3JlX25ldygpOwogCisgICAgdGVzdF9zY2FsYXJfaHZ4X3N0b3Jl
KCk7CisgICAgdGVzdF9tYXNrZWRfc3RvcmVfbm9uaW52ZXJ0KCk7CisKICAgICBwdXRzKGVyciA/
ICJGQUlMIiA6ICJQQVNTIik7CiAgICAgcmV0dXJuIGVyciA/IDEgOiAwOwogfQotLSAKMi4zNC4x
Cgo=

