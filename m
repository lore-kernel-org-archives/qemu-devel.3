Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FC9606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N7yXi3Sk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VozDxW3T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXtv-0004Jb-Ih; Mon, 26 Oct 2026 23:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtc-0003oD-1w
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXtZ-00008n-DJ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:43 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2F4mx1421228
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q7fCPCfYMXl8XSzgcYYaGqDhxB7xE+yMsGRTK1b7d4k=; b=N7yXi3SkisxaJR+L
 wj3sriCbQE0nF9RO37mSCHY7dyzfMNiCayuZ/UkokkwdxaXVwi1PEp5NBMJ7zv85
 RZVuGbNvJJcRzpLVY/eYKXZTmlK0wbjvdxdp1MtiqKdnjMaRQ6L9W7YL+m1n8s+O
 8jNlI3weznR8L5qmMvsQxv5cnzDMU6ELxbxQfFf9GVvxUZl2QMf8ri7UnoKFH4AN
 jfHfevpjEHF3TkntZyHAk889bDBw0Ms2cewmUmhdKsbIdiFE2mTns399GHXrVEIO
 CGk74CHCdgw6u9qTpax/dC90O6buYA/kS25mYyW5IdISGYINo8LKwTLyCM60QNxT
 Fw9dNg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4sf3j0w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:30:30 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1a2f2ea3c3cso1339171c88.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071829; x=1793676629; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=q7fCPCfYMXl8XSzgcYYaGqDhxB7xE+yMsGRTK1b7d4k=;
 b=VozDxW3TibDNdeBDLCNLuWcciyLe/Q0A4hB9tqHv9wiNq7EWNsp+uZvbCqfwb2vQKi
 qEvkZ8cwZACUhpc3x8f08l2hOtiJD5NLrNjAiRJjmFiXEnwZFV2qTkH/mIObxWtkrFF1
 VfTkNQAKohqtY1D/UkkYAPosrYjHiWeR42WkeMF4SgOQLwxbxK1D3hhx5Gym95yVs+r7
 J/Sm9Uix+HCJxOReAAD8wrEEFIEdGkuronn9hRfycnfPFv+qBidDv1vYrzNb4oFmbq44
 6NZSFO7VJwWXpucIAQI7zMcsUG3okTbYUOflv5SLcRmczXMMsy9jwQVBlYg6Mtlz2o6p
 XYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071829; x=1793676629;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q7fCPCfYMXl8XSzgcYYaGqDhxB7xE+yMsGRTK1b7d4k=;
 b=WeRXNnjX5XUIK7Oz2beYK7fnFwbhETJria9Rv69QqByx07pV1bgAM2KYqhe0arWIB8
 5LABRP4nOeVRm5rhJuSk1Rwbl/tW/HNni7gk5oPHJd/hmFRjatMxIBvTxVQ3l2XmrVTL
 JKCqiZXa4L6KUTnbjtcvwvBnD4Gt/uWC1tzdSkTi2JgDt7+wChHBwBWb8W8L86e52QM1
 7mMxAh1RA+Uwb7ovue7iqeCYnZsE+y1W4TJL/9DCHJ/k5GxP+HLTC7GnSDiAuEu0ul1u
 tlCoZMSywrVq58ZSsLY+enAK1HfmKnPwTjSOZh9vvcU65P4OjY8oTRH8LUpImdlTprGz
 uiQA==
X-Gm-Message-State: AFq9FYL1mc6dy360rzhOjlbwVYT8askaTiV+QoApEOpfufbjX9dXCqKO
 3FvZmbmk7mEar/PY3/bvVwuVlQ2zL/1M+BwtF5naE2KojDJ7euK6eEuB9ccP4uA+RKMfDPTVHKP
 qsxKOmGa56gu+oi+7cZDihI8IjHR+wMVvCFlL6CM1Bak5uuRvzN+fbmuXybIIvq8Tlw==
X-Gm-Gg: AYBFou0r1Yu+D59wpFbRU+p89Gr/aYOJ00nF5bX/Y8aLFYiGLMmE25p/hwriBNwvdny
 cR2rYQ00Pz8wAWs5Tk2Vsn3CbrASFep1l2IQ4w/sUYTT0jDOhj0jOfeveaLeR0rhjsdgLO+PINc
 YRGeVC8hOQGNv0G6R2RL5678Do6v+Iksju5sA/H4ZyjROj0X/7sFdUkgG6CW2SGk3EEptWHI30B
 hVU4qhB6dH1E150gsT7GBx48JU2ifx/s8BIxICn+bk6cMkzJlpKj2zhTkw6lULIAd5miGUMWwCn
 Y5a5JHV0yW+H6fQK0RBqD4pP6vf2Gx5msAGWUKNfkG9iMTCLAHfWezThirNJcrd0qcUFcjxKxg/
 qnksbe2yjDdBcn0j75b8h+P21EuBNLdlwcboFruXfdnJ4KIw=
X-Received: by 2002:a05:7022:7f15:b0:15b:7f7a:730d with SMTP id
 a92af1059eb24-19937022745mr13293167c88.28.1793071829128; 
 Mon, 26 Oct 2026 20:30:29 -0700 (PDT)
X-Received: by 2002:a05:7022:7f15:b0:15b:7f7a:730d with SMTP id
 a92af1059eb24-19937022745mr13293125c88.28.1793071828509; 
 Mon, 26 Oct 2026 20:30:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:30:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 28/41] hw/hexagon: add v79NA1 machine
Date: Mon, 26 Oct 2026 20:29:14 -0700
Message-Id: <20261027032927.3055166-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX4noRXJ7rVdx1
 VVGqu/QiEDC67hRAvDfKFkhuWEGHJ2Ep8OeruXKpn0PpPHyUYeuLZKUM+t67y/UppfAUpXvMqff
 1oPVrtjNwj74ZBtci8Ak3MppD9qkvC4=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6ae01ad6 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=7BVmsqUksLU-FW-GvuIA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: 4b4Ht5z2Xb1xl5nmlIFgeAo_DRM4T4hJ
X-Proofpoint-ORIG-GUID: 4b4Ht5z2Xb1xl5nmlIFgeAo_DRM4T4hJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX1a+z6whPBBtf
 07yXg16BGN9hlhTNrYEi0nzARimRLFOuB5q0vpvKpVqDmTLt6x2K0sAeLp49fTFGZH/ztpwoO02
 aVICONunjvibiy0//nvnGmTB7SD+kjmLix/3EA4VFrwsYl81mJO5FgwIH6goHb5q0npt+HI+T2M
 8HtQfWjpJTUd+HrA6zFsoorULYLidI2SNobAh9hkOdsWmgTLEmrqknHELifHv0Mimp/3b3VexV3
 MQ++BGSwU6X+MSin5VSaO4oIEyjObsOpe2aMD5u1ASrFq4lnEJ9KoBQz/r9b+OPnUSTyCaHoH4P
 a/bKkTMu1ELXuHoQCpBFjq4/UDmTY2yEIfwFUMLHDGGFe+HdXYm7LPz69oJ27f/6WB6apar8pRU
 +9Pgmb9Ol55ifxfv268OzxKkEVqpIuDgiOFuCUmfDNVFn6VKg/5nSMGm56yuK4dpGPVYprmEGii
 6Eosl32ihUkwlVnfiHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270013
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QWRkIHRoZSBIZXhhZ29uIFY3OU5BXzEgc2ltdWxhdG9yIG1hY2hpbmUsIHdpdGggdGhlIGNvbmZp
ZyB0YWJsZSBvZiB0aGUKdjc5IGNvcmUgYW5kIGVpZ2h0IENQVXMgYnkgZGVmYXVsdC4KClJldmll
d2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oICAgICAgICAgfCAgMSArCiBody9o
ZXhhZ29uL21hY2hpbmVfY2ZnX3Y3OW5hXzEuaC5pbmMgfCAzNCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrCiBody9oZXhhZ29uL2hleGFnb25fZHNwLmMgICAgICAgICAgICAgfCAyMiArKysr
KysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjc5bmFfMS5oLmluYwoKZGlmZiAt
LWdpdCBhL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmggYi9pbmNsdWRlL2h3L2hleGFnb24v
aGV4YWdvbi5oCmluZGV4IGYzYWVlNGE0MmU2Li41NDgxMzVhN2RkOSAxMDA2NDQKLS0tIGEvaW5j
bHVkZS9ody9oZXhhZ29uL2hleGFnb24uaAorKysgYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdv
bi5oCkBAIC0yOSw2ICsyOSw3IEBAIHR5cGVkZWYgZW51bSB7CiAgICAgdjczX3JldiA9IDB4OGM3
MywKICAgICB2NzNtX3JldiA9IDB4Y2M3MywKICAgICB2NzNuY18xX3JldiA9IDB4OGI3MywKKyAg
ICB2NzlfcmV2ID0gMHg4Yzc5LAogICAgIHY4MV9yZXYgPSAweDg3ODEsCiAgICAgdjgxX3NjODQ4
MHhwX3JldiA9IDB4ODA4MSwKICAgICB2ODFkZ2JfMV9yZXYgPSAweGNjODEsCmRpZmYgLS1naXQg
YS9ody9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y3OW5hXzEuaC5pbmMgYi9ody9oZXhhZ29uL21hY2hp
bmVfY2ZnX3Y3OW5hXzEuaC5pbmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAw
MDAuLjcwYTdhZTU4YmM1Ci0tLSAvZGV2L251bGwKKysrIGIvaHcvaGV4YWdvbi9tYWNoaW5lX2Nm
Z192NzluYV8xLmguaW5jCkBAIC0wLDAgKzEsMzQgQEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wLW9yLWxhdGVyICovCisKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaGV4YWdvbl9t
YWNoaW5lX2NvbmZpZyB2NzluYV8xID0geworICAgIC5jZmdiYXNlID0gICAgICAgICAgICAgMHhk
ODE4MDAwMCwKKyAgICAubDJ0Y21fc2l6ZSA9ICAgICAgICAgIDB4MDAwMDAwMDAsCisgICAgLmwy
dmljX2Jhc2UgPSAgICAgICAgICAweGZjOTEwMDAwLAorICAgIC5sMnZpY19zaXplID0gICAgICAg
ICAgMHgwMDAwMTAwMCwKKyAgICAuY3NyX2Jhc2UgPSAgICAgICAgICAgIDB4ZmM5MDAwMDAsCisg
ICAgLnF0bXJfcmVnaW9uID0gICAgICAgICAweGZjOTIxMDAwLAorICAgIC5jZmd0YWJsZSA9IHsK
KyAgICAgICAgLmwydGNtX2Jhc2UgPSAweDAwMDBkODAwLCAuc3Vic3lzdGVtX2Jhc2UgPSAweDAw
MDAyMDAwLAorICAgICAgICAuZXRtX2Jhc2UgPSAweDAwMDBkODE5LCAubDJjZmdfYmFzZSA9IDB4
MDAwMGQ4MWEsCisgICAgICAgIC5sMXMwX2Jhc2UgPSAweDAwMDBkOTAwLCAuYXhpMl9sb3dhZGRy
ID0gMHgwMDAwMzAwMCwKKyAgICAgICAgLmZhc3RsMnZpY19iYXNlID0gMHgwMDAwZDgxZSwgLmp0
bGJfc2l6ZV9lbnRyaWVzID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLmNvcHJvY19wcmVzZW50ID0g
MHgwMDAwMDAwZCwgLmV4dF9jb250ZXh0cyA9IDB4MDAwMDAwMDYsCisgICAgICAgIC52dGNtX2Jh
c2UgPSAweDAwMDBkOTAwLCAudnRjbV9zaXplX2tiID0gMHgwMDAwMjAwMCwKKyAgICAgICAgLmwy
dGFnX3NpemUgPSAweDAwMDAwNDAwLCAubDJlY29tZW1fc2l6ZSA9IDB4MDAwMDA0MDAsCisgICAg
ICAgIC50aHJlYWRfZW5hYmxlX21hc2sgPSAweDAwMDAwMGZmLCAubDJsaW5lX3NpemUgPSAweDAw
MDAwMDgwLAorICAgICAgICAubDJpdGNtX2Jhc2UgPSAweDAwMDBkODAwLCAuZG1hX3ZlcnNpb24g
PSAweDAwMDAwMDA2LAorICAgICAgICAuaHZ4X3ZlY19sb2dfbGVuZ3RoID0gMHgwMDAwMDAwNywg
LmNvcHJvYzJfcmVnMCA9IDB4MDAwMDAwNDAsCisgICAgICAgIC5jb3Byb2MyX3JlZzEgPSAweDAw
MDAwMDIwLCAudjJ4X21vZGUgPSAweDAwMDAwMDAxLAorICAgICAgICAuY29wcm9jMl9yZWcyID0g
MHgwMDAwMDAxMCwgLmNvcHJvYzJfcmVnMyA9IDB4MDAwMDAwMjAsCisgICAgICAgIC5jb3Byb2My
X3JlZzQgPSAweDAwMDAwMDIwLCAuY29wcm9jMl9yZWc1ID0gMHgwMDAwMDAwOCwKKyAgICAgICAg
LmNvcHJvYzJfcmVnNiA9IDB4MDAwMDAwMTYsIC5jb3Byb2MyX3JlZzcgPSAweDAwMDAwMDA4LAor
ICAgICAgICAuYWNkX3ByZXNldCA9IDB4MDAwMDAwMDEsIC5tbmRfcHJlc2V0ID0gMHgwMDAwMDAw
MSwKKyAgICAgICAgLmwxZF9zaXplX2tiID0gMHgwMDAwMDAyMCwgLmwxaV9zaXplX2tiID0gMHgw
MDAwMDAyMCwKKyAgICAgICAgLmwxZF93cml0ZV9wb2xpY3kgPSAweDAwMDAwMDAyLCAudnRjbV9i
YW5rX3dpZHRoID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLnJlc2VydmVkNCA9IDB4MDAwMDAwMDEs
IC5jb3Byb2MyX2N2dF9tcHlfc2l6ZSA9IDB4MDAwMDAwMGEsCisgICAgICAgIC5jb25zaXN0ZW5j
eV9kb21haW4gPSAweDAwMDAwMGUwLCAuY2FwYWNpdHlfZG9tYWluID0gMHgwMDAwMDA4MCwKKyAg
ICAgICAgLmF4aTNfbG93YWRkciA9IDB4MDAwMDQwMDAsIC5jb3Byb2MyX2ludDhfc3ViY29sdW1u
cyA9IDB4MDAwMDAwMDIsCisgICAgICAgIC5jb3JlY2ZnX3ByZXNlbnQgPSAweDAwMDAwMDBkLCAu
Y29wcm9jMl9mcDE2X2FjY19leHAgPSAweDAwMDAwMDA3LAorICAgICAgICAuQVhJTTJfc2Vjb25k
YXJ5X2Jhc2UgPSAweDAwMDA0MDAwLCAuQVhJTV9kYXRhX3dpZHRoID0gMHgwMDAwMDEwMCwKKyAg
ICB9LAorfTsKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYyBiL2h3L2hleGFn
b24vaGV4YWdvbl9kc3AuYwppbmRleCAwYTIzMjRhNzNiMi4uMzg1NDM0MjAxNGYgMTAwNjQ0Ci0t
LSBhL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYworKysgYi9ody9oZXhhZ29uL2hleGFnb25fZHNw
LmMKQEAgLTMxLDYgKzMxLDcgQEAKICNpbmNsdWRlICJtYWNoaW5lX2NmZ192NjZnXzEwMjQuaC5p
bmMiCiAjaW5jbHVkZSAibWFjaGluZV9jZmdfdjY4bl8xMDI0LmguaW5jIgogI2luY2x1ZGUgIm1h
Y2hpbmVfY2ZnX3Y3M25jXzEuaC5pbmMiCisjaW5jbHVkZSAibWFjaGluZV9jZmdfdjc5bmFfMS5o
LmluYyIKICNpbmNsdWRlICJtYWNoaW5lX2NmZ192ODFkZ2JfMS5oLmluYyIKICNpbmNsdWRlICJt
YWNoaW5lX2NmZ192ODFxYV8xLmguaW5jIgogI2luY2x1ZGUgIm1hY2hpbmVfY2ZnX3Y4NW5hXzEu
aC5pbmMiCkBAIC0yMjQsNiArMjI1LDIyIEBAIHN0YXRpYyB2b2lkIHY4MWRnYl8xX2NvbmZpZ19p
bml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSkKICAgICBoZXhhZ29uX2NvbW1vbl9pbml0KG1hY2hp
bmUsIHY4MWRnYl8xX3JldiwgJnY4MWRnYl8xKTsKIH0KIAorc3RhdGljIHZvaWQgdjc5bmFfMV9j
b25maWdfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpCit7CisgICAgaGV4YWdvbl9jb21tb25f
aW5pdChtYWNoaW5lLCB2NzlfcmV2LCAmdjc5bmFfMSk7Cit9CisKK3N0YXRpYyB2b2lkIHY3OW5h
XzFfaW5pdChPYmplY3RDbGFzcyAqb2MsIGNvbnN0IHZvaWQgKmRhdGEpCit7CisgICAgTWFjaGlu
ZUNsYXNzICptYyA9IE1BQ0hJTkVfQ0xBU1Mob2MpOworCisgICAgbWMtPmRlc2MgPSAiSGV4YWdv
biBWNzlOQV8xIjsKKyAgICBtYy0+aW5pdCA9IHY3OW5hXzFfY29uZmlnX2luaXQ7CisgICAgaW5p
dF9tYyhtYyk7CisgICAgbWMtPmRlZmF1bHRfY3B1X3R5cGUgPSBUWVBFX0hFWEFHT05fQ1BVX1Y3
OTsKKyAgICBtYy0+ZGVmYXVsdF9jcHVzID0gODsKK30KKwogc3RhdGljIHZvaWQgdjgxZGdiXzFf
aW5pdChPYmplY3RDbGFzcyAqb2MsIGNvbnN0IHZvaWQgKmRhdGEpCiB7CiAgICAgTWFjaGluZUNs
YXNzICptYyA9IE1BQ0hJTkVfQ0xBU1Mob2MpOwpAQCAtMzE2LDYgKzMzMywxMSBAQCBzdGF0aWMg
Y29uc3QgVHlwZUluZm8gaGV4YWdvbl9tYWNoaW5lX3R5cGVzW10gPSB7CiAgICAgICAgIC5wYXJl
bnQgPSBUWVBFX0hFWEFHT05fRFNQX01BQ0hJTkUsCiAgICAgICAgIC5jbGFzc19pbml0ID0gdjcz
bmNfMV9pbml0LAogICAgIH0sCisgICAgeworICAgICAgICAubmFtZSA9IE1BQ0hJTkVfVFlQRV9O
QU1FKCJWNzlOQV8xIiksCisgICAgICAgIC5wYXJlbnQgPSBUWVBFX0hFWEFHT05fRFNQX01BQ0hJ
TkUsCisgICAgICAgIC5jbGFzc19pbml0ID0gdjc5bmFfMV9pbml0LAorICAgIH0sCiAgICAgewog
ICAgICAgICAubmFtZSA9IE1BQ0hJTkVfVFlQRV9OQU1FKCJWODFER0JfMSIpLAogICAgICAgICAu
cGFyZW50ID0gVFlQRV9IRVhBR09OX0RTUF9NQUNISU5FLAotLSAKMi4zNC4xCgo=

