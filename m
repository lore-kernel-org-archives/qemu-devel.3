Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1DAC624D6
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uqg-0002yx-7E; Sat, 05 Sep 2026 14:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqc-0002wg-9a
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqa-0001j3-HL
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:37 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685Hb5bB3176541
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 18:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tapcI97RzVBlLkzxaaAHSlqyAOyLKGboeJ+O5E4kBgU=; b=en4pxoHorfsn78yN
 VneCk7lzIV1Ao//KqcMrWj1JQLh3tde2GilEZkZYSI1ijAtMuSYvedlyHEY2UgGh
 us2t8FmT7KM9gBp8i2F9Bbhl9DhLrNML4+5x0zN4J3Z9cUzJ8tKpHpimM5HLIXcJ
 gs3azTi93BZg8RBYHznot7peJeSi1eHImVrWMJoHApMp+g6DNT5h+bGJx67ch2cV
 tArsHjN3pGSya2aT7Jjth+vqDV20cTlyGACY0ncX2zK3mMuGoDEFihAd4hzdaGS2
 xLtdAaQRC2JR+DL9RoIMUlmOxy6Az6MFb8X1Q3t89RtUA29EIVQJtDoMiadmltKB
 cXg9Ig==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggb5v9u6p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 18:10:35 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-398ba5404d2so3665097a91.1
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788631835; x=1789236635; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tapcI97RzVBlLkzxaaAHSlqyAOyLKGboeJ+O5E4kBgU=;
 b=BLLT7IN4kTh4eI7qC3ARKiX6uk9NAKMXrCD5QjiNIRtLD/FOlNQOF86j/+B+1XMuk0
 9FFA7OGYl9f2j7bce4g3iHZCuATJg9wja1nuUFAggTWd/eDViXFytSCY6QymS0t0VVp5
 D07LsEckYqZmu410Lpswg3auZGbYa+AS6TH7jL8iY4RolDhJnpjt0UTk5ifd/H8+3PUS
 SPqVVOPzgHiiKGO9tJedeHJ7Isr9b7RgzLj5cYipJ9mj920GvDKQLl7iJZGtLQCJP9rj
 Hgy02vdtm1mU/GcWFDudBwXnR3vES9Drt1T7YBGjHngVcyKBBC4dYAg/+z1N8bQ0qA6g
 k4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788631835; x=1789236635;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tapcI97RzVBlLkzxaaAHSlqyAOyLKGboeJ+O5E4kBgU=;
 b=lMjm8RusaOJuW1eMtPVd4w60GtWUUIT7TWb20Sr7A89MgM7PaZfyMpNxWfjTZ/b6TM
 Vw+Q6wnsOAi4w/XBUOmpfbqmAsMmwU+zjCmDupR2HIJSeFWU0Mw2exKf21MuqHMjCkYd
 m2viarM87hXXYlXb44/xk+NvrQZud2jWUx+w2enFUzJftnIUzgvLtYN1F2U2ehTFTOxS
 oepNddJkmIwZtNR4ubQPOTAv0vtU7qeYe0RHy3qYNuCRKTuebbMd2R9Rfeke9ugVdRDp
 q2e2fpQG6bWy3aHwmSw6L2tkAZP42RIoXgwXOQtsBYVV34SZygW6KakUmOGNoC7sFxHk
 9Kjg==
X-Gm-Message-State: AFuF++lqOag317yvP4psegBOsBs+Jun4DSIaZ99L0OvVcR3G29lkvqwz
 K2E1Z6oFxV5kojYm356bC3rp4tGWqKKuqQR1O7oG3eVoXUonrw2rchpHfWU2s3l7hEL+oUn1PHn
 n+gayOygrWVHT7sFrrXaE/GF+AV93f0TpmRUdOr98ohR5FADG+K8Q+VXiqeRTk8TtzQ==
X-Gm-Gg: AYBFou0vgyaoE/SPX2Rc6reVsx8mheT16WLnJSAa32DCIMPEpm3xw/bm8D9Lw3p/009
 xzipNFHPSJJKRivA3hmJWDUtgNAs60RPPA4N2mU2ugx3zPyHEsCfq2yXL9pNgRZ9aiMgSRPZslZ
 m9nUwMij/T1COoDJNbKWSRVY5Ns9kFVyvS/u7SeZKgcJpZqC36yCx0Y0u4aAsARrCrEUGoLtES5
 TizuLp34ghCICMdHgO1wiDK1pIuQmK12H3T7mEESKuJ0aLMWN1OmxucKc1TIm97OBZPiIzpfH5m
 5NqCb6MdWYgP4T4/5m18UxPjjLvLhx55Vjy5xPfwbjij4kgjYnIMcqeKiFT9PiTPyd9CjPuqmPk
 E2q4MsOSUQ0J6Rzy7EqLdoZK4qxkSnGBoNcDT5XMad1dp6/m0
X-Received: by 2002:a17:90b:1c07:b0:399:149a:3f27 with SMTP id
 98e67ed59e1d1-39b2617ed8bmr21709555a91.9.1788631834623; 
 Sat, 05 Sep 2026 11:10:34 -0700 (PDT)
X-Received: by 2002:a17:90b:1c07:b0:399:149a:3f27 with SMTP id
 98e67ed59e1d1-39b2617ed8bmr21709505a91.9.1788631834162; 
 Sat, 05 Sep 2026 11:10:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm17985505eec.7.2026.09.05.11.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 11:10:32 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, sid.manning@oss.qualcomm.com
Subject: [PATCH 16/17] tests/tcg/hexagon: add scalar+HVX and masked store tests
Date: Sat,  5 Sep 2026 11:09:48 -0700
Message-Id: <20260905180949.1852673-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: FTVjpJhxCtrxlks0Nj6wco44lf1CCREp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfXyCvB/jS8F0yP
 62lQzq1UfQKoVJmoIlKbGYWRA7HOFbl0PAgLWbQmGPBhHyh/ZhipdUfo92L6/p3Ip/+wSje2Sf9
 FrrGDRwgVAgXiV6t1SmgcQh67gvnAjFAFPXo46eq6QJ2c+fT2VCc2ijNDuhPSLal6bfeFqwjgVy
 KldAW+h5eLBVsIRpMdQWNBYWEI2+ZlZGSP0mihvOmFV/fxs0t9+kI/kkCfcElljnhttSEV5aFz/
 zznwI++SRz7/ye3/ijySG3Bxa3W9wfRtYjafOzoyySqJ9U1eIB9DQO8ORs+v2cNlwdQUV4PUeB0
 INeNN5kgs/lZ54Y9Oxrk/GhcDfaybmVtIoBAs4L1oITExyA5Ay+ptAvlAk1xIS9GjFFxFnJTNOq
 ZjojlN6pZcTdEkxBK7IvNrIQupYDFoB2k99eiKzLn65pgxDEyMZ2el1XU9fYrujBQcnz0kShwfS
 lBErudwektjx4o1fGFQ==
X-Authority-Analysis: v=2.4 cv=UO3t2ify c=1 sm=1 tr=0 ts=6a9c5b1b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ZgKQQoYZz-FTevMfDfAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: FTVjpJhxCtrxlks0Nj6wco44lf1CCREp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX8bvMLqQ541QC
 4LVjD24i0XoAiB8OyyzBGs2K3DYSkFABc+TKgxoJm7jN5Qk78za3KENPZFM4sbVqyU/ri9UMVys
 mEKX2Vbbp5lc2+XxQ1AwTdOB2+AL724=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050201
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
cmlmeSB0aGUgaW52ZXJ0PWZhbHNlCnBhdGggaW4gbWFza2VkIHN0b3JlIGdlbmVyYXRpb24uCgpT
aWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0t
LQogdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYyB8IDY2ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDY2IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jIGIvdGVzdHMvdGNnL2hleGFnb24v
aHZ4X21pc2MuYwppbmRleCBmMjBhZmM4ZTY3MC4uMDI4NTg4NmMyYTUgMTAwNjQ0Ci0tLSBhL3Rl
c3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21p
c2MuYwpAQCAtNTY2LDYgKzU2Niw2OSBAQCB2b2lkIHRlc3Rfc3RvcmVfbmV3KCkKICAgICBjaGVj
a19vdXRwdXRfdyhfX0xJTkVfXywgMSk7CiB9CiAKKy8qCisgKiBUZXN0IGEgcGFja2V0IHdpdGgg
Ym90aCBhIHNjYWxhciBzdG9yZSBhbmQgYW4gSFZYIHN0b3JlLgorICovCitzdGF0aWMgdWludDMy
X3Qgc2NhbGFyX3N0b3JlX2RzdDsKKworc3RhdGljIHZvaWQgdGVzdF9zY2FsYXJfaHZ4X3N0b3Jl
KHZvaWQpCit7CisgICAgc2NhbGFyX3N0b3JlX2RzdCA9IDA7CisgICAgbWVtc2V0KCZleHBlY3Rb
MF0sIDAsIHNpemVvZihNTVZlY3RvcikpOworCisgICAgLyogRmlsbCB2MCB3aXRoIDB4QUJDRCBw
YXR0ZXJuICovCisgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBNQVhfVkVDX1NJWkVfQllURVMgLyA0
OyBpKyspIHsKKyAgICAgICAgZXhwZWN0WzBdLnV3W2ldID0gMHhBQkNEQUJDRDsKKyAgICB9CisK
KyAgICBhc20oInIwID0gIzB4QUJDREFCQ0Rcblx0IgorICAgICAgICAidjAgPSB2c3BsYXQocjAp
XG5cdCIKKyAgICAgICAgInIxID0gIzQyXG5cdCIKKyAgICAgICAgIntcblx0IgorICAgICAgICAi
ICAgIG1lbXcoJVtzY2FsYXJdKSA9IHIxXG5cdCIKKyAgICAgICAgIiAgICB2bWVtKCVbaHZ4XSkg
PSB2MFxuXHQiCisgICAgICAgICJ9XG5cdCIKKyAgICAgICAgOgorICAgICAgICA6IFtzY2FsYXJd
ICJyIigmc2NhbGFyX3N0b3JlX2RzdCksCisgICAgICAgICAgW2h2eF0gInIiKCZvdXRwdXRbMF0p
CisgICAgICAgIDogInIwIiwgInIxIiwgInYwIiwgIm1lbW9yeSIpOworCisgICAgY2hlY2tfb3V0
cHV0X3coX19MSU5FX18sIDEpOworICAgIGlmIChzY2FsYXJfc3RvcmVfZHN0ICE9IDQyKSB7Cisg
ICAgICAgIHByaW50ZigiRVJST1IgYXQgbGluZSAlZDogc2NhbGFyX3N0b3JlX2RzdCA9ICVkLCBl
eHBlY3RlZCA0MlxuIiwKKyAgICAgICAgICAgICAgIF9fTElORV9fLCBzY2FsYXJfc3RvcmVfZHN0
KTsKKyAgICAgICAgZXJyKys7CisgICAgfQorfQorCisvKgorICogVGVzdCBub24taW52ZXJ0ZWQg
bWFza2VkIHN0b3JlOiBpZiAoUXYpIHZtZW0oUnQpID0gVnMuCisgKiBFeGlzdGluZyB0ZXN0cyBv
bmx5IGNvdmVyIHRoZSBpbnZlcnRlZCBmb3JtICghUXYpLgorICogVXNlIGFuIGFsbC10cnVlIFEg
cHJlZGljYXRlIHRvIHVuY29uZGl0aW9uYWxseSBzdG9yZS4KKyAqLworc3RhdGljIHZvaWQgdGVz
dF9tYXNrZWRfc3RvcmVfbm9uaW52ZXJ0KHZvaWQpCit7CisgICAgdm9pZCAqcDAgPSBidWZmZXIw
OworICAgIHZvaWQgKnBvdXQgPSBvdXRwdXQ7CisKKyAgICBtZW1zZXQoJm91dHB1dFswXSwgMHhm
Ziwgc2l6ZW9mKE1NVmVjdG9yKSk7CisKKyAgICBmb3IgKGludCBpID0gMDsgaSA8IE1BWF9WRUNf
U0laRV9CWVRFUyAvIDQ7IGkrKykgeworICAgICAgICBleHBlY3RbMF0udXdbaV0gPSBidWZmZXIw
WzBdLnV3W2ldOworICAgIH0KKworICAgIGFzbSgidjUgPSB2bWVtKCVbc3JjXSArICMwKVxuXHQi
CisgICAgICAgICJyMCA9ICMtMVxuXHQiCisgICAgICAgICJ2NiA9IHZzcGxhdChyMClcblx0Igor
ICAgICAgICAicTAgPSB2YW5kKHY2LCByMClcblx0IgorICAgICAgICAiaWYgKHEwKSB2bWVtKCVb
ZHN0XSkgPSB2NVxuXHQiCisgICAgICAgIDoKKyAgICAgICAgOiBbc3JjXSAiciIocDApLCBbZHN0
XSAiciIocG91dCkKKyAgICAgICAgOiAicjAiLCAidjUiLCAidjYiLCAicTAiLCAibWVtb3J5Iik7
CisKKyAgICBjaGVja19vdXRwdXRfdyhfX0xJTkVfXywgMSk7Cit9CisKIGludCBtYWluKCkKIHsK
ICAgICBpbml0X2J1ZmZlcnMoKTsKQEAgLTYxNSw2ICs2NzgsOSBAQCBpbnQgbWFpbigpCiAKICAg
ICB0ZXN0X3N0b3JlX25ldygpOwogCisgICAgdGVzdF9zY2FsYXJfaHZ4X3N0b3JlKCk7CisgICAg
dGVzdF9tYXNrZWRfc3RvcmVfbm9uaW52ZXJ0KCk7CisKICAgICBwdXRzKGVyciA/ICJGQUlMIiA6
ICJQQVNTIik7CiAgICAgcmV0dXJuIGVyciA/IDEgOiAwOwogfQotLSAKMi4zNC4xCgo=

