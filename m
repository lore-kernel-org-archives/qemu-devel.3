Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCEEC021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFQ2-0002i6-CO; Sat, 01 Mar 2025 00:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPp-0001OI-61
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:33 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFPl-0008Su-Tp
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:29:32 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213MF8b026309
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pU8hVZPrx5M/Nh+U274cUvZDIgmflPFv/nrq9791pcA=; b=MQIkd37EHT4LSHVL
 uBUALii/gF8gTz4qV9blqg+Qr4ipowOwSrBXv/UkV5mO5BlNexw9FJaHR/GjB/HO
 BSVuzgojcHJsXTRjsgfN237BLow79zAxemggnRPTzGd1MA/rI0T18U+mtiJSFtVR
 NpvLscgM1xdIX/B/1bhhXP0ASDyAx5bFzwrDWoJg6VOz0JohQwo+2+QnYLmdn7L8
 C+0cFAoBmx1yz0PM32zsuvRlYQVDrVD5of/h7dqTVTkb1rp5s9sQk5STKp3YwlXy
 0HjIHsxl4T7qZ9Xr9tKvudF3nE4tJe3+pThtaOPGmCuu6Gt6VytX+aBYxRCxvhHo
 tG3J8g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t95r67y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:29:28 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2fede63f32dso536184a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:29:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806967; x=1741411767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pU8hVZPrx5M/Nh+U274cUvZDIgmflPFv/nrq9791pcA=;
 b=nI3OqZ/ojmjfaGHiAou6z6ksbH56rgsac92gJ3ktV8s8aybSqjPLMnTW8X7lc1yvm3
 hbTjGhbmPSAGFQ6H/Flchc4KdLXEN7UQ3wQSi0/ZgEDDzFXlZbXEweeV5RgpKLtfFAL1
 Vj7qW0oKDt9DS8R1rL3gcY/M88nfk/IiVCZcbwkYQX7A13WXpERSQm+qHA/VAwoMbDvt
 lOdrPvp30FIx/Ou3Cxgo5D32YU3T3hXecyBjN0wNChCIPkR8i1hwshV9+/PCsUq6jAc9
 KCLP9zT90DDXliFKQZH9cIMc0HkoeuCW8tteiU22uzfGemruKvsPN57yNlmgQuLH8XYG
 ZNLw==
X-Gm-Message-State: AOJu0YwqF7k7Ef4yyKYGjVFb/Pz3GfdM172P8I4TiBKw9oBT05IqovWq
 8bXT5mTlaCUeLRR/0DPHVi8M4gGlNqD5+Oa070qAKU1YzEU/R2F/vYKF+ywezPdPTcMwmPFWHYs
 3AmxN/Ckxc6wYNZNgKI8NEM/MeizS05A6Mwj2UwRdERpLeicBCoA1CyBSs6Zjvw==
X-Gm-Gg: ASbGncu2szgQa9ddF/cLR1BRi4mKdt20cPOMVAjb/bXew7ySkqwq8CFlWdcL8gSYxIj
 pvyh7CFIOEZB455eql8GfhWyv+KbTRHzrWcWvj5AgyLieHOObbFDOhI5wfM6If50NCKA3QDOT64
 RdxUT6TcYfJQWfYDatJdR0UOeHg4+0Y3v1zZSIFeE6I841sXCoohX605SpWMpNFQm3K3dBas4ag
 iYp2z6fT6XRknYPo69hL+NXYy+HtEpby5qT4poq9FZ65lDDJHreU/ApT5OZKWW9H9VHExKReLyq
 d+ek5ppW1fNAql52kO5uVzKV/vywC3fhQ2Uv6pvj+9zFVR/h+7JVEBv62DLwNCDh
X-Received: by 2002:a17:90b:2252:b0:2fa:ba3:5457 with SMTP id
 98e67ed59e1d1-2febab78780mr11231842a91.17.1740806967497; 
 Fri, 28 Feb 2025 21:29:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9EEBosxkYmLIuU0Y8M9gRyBFgVwCeMoJWW3S2wxEhbFbX6iL2nNeqLVr0BoqRXbA1sFOLKg==
X-Received: by 2002:a17:90b:2252:b0:2fa:ba3:5457 with SMTP id
 98e67ed59e1d1-2febab78780mr11231808a91.17.1740806967131; 
 Fri, 28 Feb 2025 21:29:27 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a5dc8sm4732955a91.23.2025.02.28.21.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:29:26 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 29/39] target/hexagon: Add pkt_ends_tb to translation
Date: Fri, 28 Feb 2025 21:28:35 -0800
Message-Id: <20250301052845.1012069-30-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 5N0q0_NwYPT_i96D2jXU9E8sfJx8nrLu
X-Proofpoint-GUID: 5N0q0_NwYPT_i96D2jXU9E8sfJx8nrLu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=731 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010040
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
dHJhbnNsYXRlLmggfCAgMSArCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyB8IDk5ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCiAyIGZpbGVzIGNoYW5nZWQsIDk5IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuaCBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCmluZGV4IDliYzRiM2NlOGIu
LmM5NTMzZmVlMWYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCisrKyBi
L3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC04NCw2ICs4NCw3IEBAIHR5cGVkZWYgc3Ry
dWN0IERpc2FzQ29udGV4dCB7CiAgICAgVENHdiBicmFuY2hfdGFrZW47CiAgICAgVENHdiBkY3pl
cm9fYWRkcjsKICAgICBib29sIHBjeWNsZV9lbmFibGVkOworICAgIGJvb2wgcGt0X2VuZHNfdGI7
CiAgICAgdWludDMyX3QgbnVtX2N5Y2xlczsKIH0gRGlzYXNDb250ZXh0OwogCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5j
CmluZGV4IDA2MGRmNmU1ZWIuLjQ3NTcyNjM4OGEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC0yNTksNiAr
MjU5LDE4IEBAIHN0YXRpYyBib29sIGNoZWNrX2Zvcl9hdHRyaWIoUGFja2V0ICpwa3QsIGludCBh
dHRyaWIpCiAgICAgcmV0dXJuIGZhbHNlOwogfQogCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkK
K3N0YXRpYyBib29sIGNoZWNrX2Zvcl9vcGNvZGUoUGFja2V0ICpwa3QsIHVpbnQxNl90IG9wY29k
ZSkKK3sKKyAgICBmb3IgKGludCBpID0gMDsgaSA8IHBrdC0+bnVtX2luc25zOyBpKyspIHsKKyAg
ICAgICAgaWYgKHBrdC0+aW5zbltpXS5vcGNvZGUgPT0gb3Bjb2RlKSB7CisgICAgICAgICAgICBy
ZXR1cm4gdHJ1ZTsKKyAgICAgICAgfQorICAgIH0KKyAgICByZXR1cm4gZmFsc2U7Cit9CisjZW5k
aWYKKwogc3RhdGljIGJvb2wgbmVlZF9zbG90X2NhbmNlbGxlZChQYWNrZXQgKnBrdCkKIHsKICAg
ICAvKiBXZSBvbmx5IG5lZWQgc2xvdF9jYW5jZWxsZWQgZm9yIGNvbmRpdGlvbmFsIHN0b3JlIGlu
c3RydWN0aW9ucyAqLwpAQCAtMjcyLDYgKzI4NCw5MCBAQCBzdGF0aWMgYm9vbCBuZWVkX3Nsb3Rf
Y2FuY2VsbGVkKFBhY2tldCAqcGt0KQogICAgIHJldHVybiBmYWxzZTsKIH0KIAorI2lmbmRlZiBD
T05GSUdfVVNFUl9PTkxZCitzdGF0aWMgYm9vbCBzcmVnX3dyaXRlX3RvX2dsb2JhbChpbnQgcmVn
X251bSkKK3sKKyAgICByZXR1cm4gcmVnX251bSA9PSBIRVhfU1JFR19TU1IgfHwKKyAgICAgICAg
ICAgcmVnX251bSA9PSBIRVhfU1JFR19TVElEIHx8CisgICAgICAgICAgIHJlZ19udW0gPT0gSEVY
X1NSRUdfSU1BU0sgfHwKKyAgICAgICAgICAgcmVnX251bSA9PSBIRVhfU1JFR19JUEVOREFEIHx8
CisgICAgICAgICAgIHJlZ19udW0gPT0gSEVYX1NSRUdfQkVTVFdBSVQgfHwKKyAgICAgICAgICAg
cmVnX251bSA9PSBIRVhfU1JFR19TQ0hFRENGRzsKK30KKworc3RhdGljIGJvb2wgaGFzX3NyZWdf
d3JpdGVfdG9fZ2xvYmFsKFBhY2tldCBjb25zdCAqcGt0KQoreworICAgIGZvciAoaW50IGkgPSAw
OyBpIDwgcGt0LT5udW1faW5zbnM7IGkrKykgeworICAgICAgICBJbnNuIGNvbnN0ICppbnNuID0g
JnBrdC0+aW5zbltpXTsKKyAgICAgICAgdWludDE2X3Qgb3Bjb2RlID0gaW5zbi0+b3Bjb2RlOwor
ICAgICAgICBpZiAob3Bjb2RlID09IFkyX3RmcnNyY3IpIHsKKyAgICAgICAgICAgIC8qIFdyaXRl
IHRvIGEgc2luZ2xlIHNyZWcgKi8KKyAgICAgICAgICAgIGludCByZWdfbnVtID0gaW5zbi0+cmVn
bm9bMF07CisgICAgICAgICAgICBpZiAoc3JlZ193cml0ZV90b19nbG9iYWwocmVnX251bSkpIHsK
KyAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICAgICAgICAgIH0KKyAgICAgICAgfSBl
bHNlIGlmIChvcGNvZGUgPT0gWTRfdGZyc3BjcCkgeworICAgICAgICAgICAgLyogV3JpdGUgdG8g
YSBzcmVnIHBhaXIgKi8KKyAgICAgICAgICAgIGludCByZWdfbnVtID0gaW5zbi0+cmVnbm9bMF07
CisgICAgICAgICAgICBpZiAoc3JlZ193cml0ZV90b19nbG9iYWwocmVnX251bSkpIHsKKyAgICAg
ICAgICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICAgICAgICAgIH0KKyAgICAgICAgICAgIGlmIChz
cmVnX3dyaXRlX3RvX2dsb2JhbChyZWdfbnVtICsgMSkpIHsKKyAgICAgICAgICAgICAgICByZXR1
cm4gdHJ1ZTsKKyAgICAgICAgICAgIH0KKyAgICAgICAgfQorICAgIH0KKyAgICByZXR1cm4gZmFs
c2U7Cit9CisjZW5kaWYKKworc3RhdGljIGJvb2wgcGt0X2VuZHNfdGIoUGFja2V0ICpwa3QpCit7
CisgICAgaWYgKHBrdC0+cGt0X2hhc19jb2YpIHsKKyAgICAgICAgcmV0dXJuIHRydWU7CisgICAg
fQorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgLyogU3lzdGVtIG1vZGUgaW5zdHJ1Y3Rp
b25zIHRoYXQgZW5kIFRMQiAqLworICAgIGlmIChjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfc3dp
KSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfY3N3aSkgfHwKKyAgICAgICAg
Y2hlY2tfZm9yX29wY29kZShwa3QsIFkyX2NpYWQpIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNv
ZGUocGt0LCBZNF9zaWFkKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfd2Fp
dCkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX3Jlc3VtZSkgfHwKKyAgICAg
ICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX2lhc3NpZ253KSB8fAorICAgICAgICBjaGVja19m
b3Jfb3Bjb2RlKHBrdCwgWTJfc2V0aW1hc2spIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUo
cGt0LCBZNF9ubWkpIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9zZXRwcmlv
KSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfc3RhcnQpIHx8CisgICAgICAg
IGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9zdG9wKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bj
b2RlKHBrdCwgWTJfazBsb2NrKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJf
azB1bmxvY2spIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl90bGJsb2NrKSB8
fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfdGxidW5sb2NrKSB8fAorICAgICAg
ICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfYnJlYWspIHx8CisgICAgICAgIGNoZWNrX2Zvcl9v
cGNvZGUocGt0LCBZMl9pc3luYykgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFky
X3N5bmNodCkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX3RsYnApIHx8Cisg
ICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl90bGJ3KSB8fAorICAgICAgICBjaGVja19m
b3Jfb3Bjb2RlKHBrdCwgWTVfY3RsYncpIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0
LCBZNV90bGJhc2lkaSkpIHsKKyAgICAgICAgcmV0dXJuIHRydWU7CisgICAgfQorCisgICAgLyoK
KyAgICAgKiBDaGVjayBmb3Igc3JlZyB3cml0ZXMgdGhhdCB3b3VsZCBlbmQgdGhlIFRCCisgICAg
ICovCisgICAgaWYgKGNoZWNrX2Zvcl9hdHRyaWIocGt0LCBBX0lNUExJQ0lUX1dSSVRFU19TU1Ip
KSB7CisgICAgICAgIHJldHVybiB0cnVlOworICAgIH0KKyAgICBpZiAoaGFzX3NyZWdfd3JpdGVf
dG9fZ2xvYmFsKHBrdCkpIHsKKyAgICAgICAgcmV0dXJuIHRydWU7CisgICAgfQorI2VuZGlmCisg
ICAgcmV0dXJuIGZhbHNlOworfQorCisKIHN0YXRpYyBib29sIG5lZWRfbmV4dF9QQyhEaXNhc0Nv
bnRleHQgKmN0eCkKIHsKICAgICBQYWNrZXQgKnBrdCA9IGN0eC0+cGt0OwpAQCAtNDczLDYgKzU2
OSw3IEBAIHN0YXRpYyB2b2lkIGdlbl9zdGFydF9wYWNrZXQoRGlzYXNDb250ZXh0ICpjdHgpCiAg
ICAgICAgIHRjZ19nZW5fbW92aV90bChoZXhfc2xvdF9jYW5jZWxsZWQsIDApOwogICAgIH0KICAg
ICBjdHgtPmJyYW5jaF90YWtlbiA9IE5VTEw7CisgICAgY3R4LT5wa3RfZW5kc190YiA9IHBrdF9l
bmRzX3RiKHBrdCk7CiAgICAgaWYgKHBrdC0+cGt0X2hhc19jb2YpIHsKICAgICAgICAgY3R4LT5i
cmFuY2hfdGFrZW4gPSB0Y2dfdGVtcF9uZXcoKTsKICAgICAgICAgaWYgKHBrdC0+cGt0X2hhc19t
dWx0aV9jb2YpIHsKQEAgLTkyNyw3ICsxMDI0LDcgQEAgc3RhdGljIHZvaWQgZ2VuX2NvbW1pdF9w
YWNrZXQoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgICAgIHBrdC0+dmhpc3RfaW5zbi0+Z2VuZXJh
dGUoY3R4KTsKICAgICB9CiAKLSAgICBpZiAocGt0LT5wa3RfaGFzX2NvZikgeworICAgIGlmIChj
dHgtPnBrdF9lbmRzX3RiIHx8IGN0eC0+YmFzZS5pc19qbXAgPT0gRElTQVNfTk9SRVRVUk4pIHsK
ICAgICAgICAgZ2VuX2VuZF90YihjdHgpOwogICAgIH0KIH0KLS0gCjIuMzQuMQoK

