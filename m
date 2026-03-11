Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6ACCFD88F5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0B3i-0006Mn-ML; Wed, 11 Mar 2026 00:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0B3f-0006Lh-FU
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:20:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0B3d-00031u-Q1
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:20:31 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B2KjGn248813
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R9ubA4gBoAHXRbMRoa7yS4tDuYNHYYUPrykT3JtsZBo=; b=Dz9QdFSupzUdBAYs
 ZjRAeiq06TzJ5rdCYI0PRmTrik7copFAtOCboTpzSbcs+xDvcUue4IQOub2d47wx
 MCdiPuYmPOGqPg9Z7/XKOyX+Io9VnbAbzLvzkrJEqb8RtJgUdWGDIKkvnjJgTg/l
 UiAAHakk0RAVOpWFc1thiYjhtshPpseJGjX4B2V3Pii9XrAu31ajEiNz69HXaJjF
 zseHI7Jh6TtGc1cJaT7aGE1Vq7e/9zcSVbHBMqJDDvp+UWojxCGISogSFJHHKavv
 zZaBoPh5IytHQNnhB0moT7gVip5XI+S1ioKCXHmF6Zm+keuSwWlQ5o9wa/TTpFSL
 MGz7Cw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqv11ty2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:20:28 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7d496d080d8so80061322a34.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202828; x=1773807628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R9ubA4gBoAHXRbMRoa7yS4tDuYNHYYUPrykT3JtsZBo=;
 b=bvP5ORyZKUGj1aHSMJ1BD3f3ZboVr/slqcBZ7oe6dhML/11ZIyVKzMqHCq9SXFw2Qn
 7wawH6iNGj8MWH+25JsXFBkij4/nCPGzuGuAxDfRm8Om19M4zUDi8V42X8731iEFbOI8
 v2uG8vS8KNutiwMvve97Yxf/0muPuLI7C7hFMJWc40nZdjrApJYX2Sdll+Xt7qv8DEhF
 mK4vBXo8DRlURK51vPkZbWkCq29cGX794ApUuIhhBlortzuxWuGrQFyOWK225ou+lKj5
 QVWgariyLcoXzGmcZsiEcrKP0ejzttKjT7qhh5w/KemIjVarU1eM42ZgWeXiWeBDjX/m
 7zZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202828; x=1773807628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R9ubA4gBoAHXRbMRoa7yS4tDuYNHYYUPrykT3JtsZBo=;
 b=nus5HxcUwA4kxKCUVlO/BsbyLt3N+lrNr5CGCQTs2VNTWGgCWmg6V+S/jVZiOYBUzG
 ekdgGwotuTqXIjWZ7xLi8VlNxRAmuVUpPun0gmKAC+Y5wiZ5xE88g9j7xl4deZuBaMT/
 r23SwK6MQjsfYpOYtOrqX52Z4gcBHvShooMHcvNQw/HwfLgj5STzskV+UjxGka/8vNMl
 qSbkgiT3K/nTQxr6ZpK7I2ED5fq4/pWOWTVIoVvn7gFURYSIOA0A7r/nV3VTgvFGfibD
 FbgCHiKjdHl2uC7T32UsZKF8iDYb4kN8kngKJvuVeXwHcGu4zuIF+BbN87jE1IW3nNcA
 AMGw==
X-Gm-Message-State: AOJu0YyF1WWcq/phzv1oNxnW7MKlBP9v8pky317GyUSFOc1O746xbMP/
 i6Dke0Sj33nguCqX0ZD8I8JHPK4t4FkRuVzVIuB0zLwfOpna8iOJlRdjXU7woALMr8TzGXisrGk
 CVQlf6zjNqmVhjcgf3VR8ueg8GVBl93zKB1QyUi7ppN3kpG5zakkZL3U3M4ocEgwU+w==
X-Gm-Gg: ATEYQzy1Ao6rGpJ3XW+MCQfq9GLRJHsivrIqEIlKDEyaBXk+9HnrSpsRIsj2cuSEUOX
 6ShI31axMWfYzEoORg4/dSERF6Cvan0tsnZ1yQg9jhJ05Q8Xf1L1tE3ODMANVTWaDQ1gpApS7Uh
 M+qKXXzEqAvxPgh0egzomRfF/rTW30Poa5kEOjro7b7cV8LmLfs6gDYI3fo1USyQvD/N9xgKU6Y
 0hjhnYZpWs7jX+6dq2FS+RMWWJCfRfEOUS8HT86yj7vmNcP58lMXAcYWAlt2o8Bd60pqYSe8BzZ
 Q/nc+gU65ZIeYa3GI2V2n9s5KZxu5Efwd5D0a0Uspb/2IqbN5rxbdjCUj0ko96n4iXpiwPgG0T6
 0Z9AjRNocvEB7MpRvsVOiopACb+Cn0yXz3ZsxRwI/6Xj+MsjtHltgtLK90BdeVk8dv12dTg==
X-Received: by 2002:a05:6830:8381:b0:7d7:4c91:13b2 with SMTP id
 46e09a7af769-7d76a64d423mr903080a34.1.1773202828119; 
 Tue, 10 Mar 2026 21:20:28 -0700 (PDT)
X-Received: by 2002:a05:6830:8381:b0:7d7:4c91:13b2 with SMTP id
 46e09a7af769-7d76a64d423mr903066a34.1.1773202827772; 
 Tue, 10 Mar 2026 21:20:27 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76aeccd73sm892003a34.27.2026.03.10.21.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:20:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 4/9] hw/hexagon: Add v68, sa8775-cdsp0 defs
Date: Tue, 10 Mar 2026 21:20:14 -0700
Message-Id: <20260311042019.1085030-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
References: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMyBTYWx0ZWRfXyWlbpzfG/81E
 ow301xAx7xjSm156cTHdMGkyDN61a7jD5LaFONYskET79pUiw8FMBHjCYJDwB+FGuZfO493nbOk
 2ijcgYz2fHeRgkXgJCnANzUO5Z4Em7X1WN4YnhTlaREvM81Pj0hGkqJmkc8ipz7JcM2pu55soBi
 I85PRhB4gsfCMvLI4EXjqfyPjz06vvUYpSQ8zm2RgJYdtYW+swZlxC5tfxeKdz4IgNcAL3OEvTN
 wz/YbPYCRcWCX3SIroxvjqXmUAOfbGPcIWTcZlaRIe51i6lXjo/m6wM2mLf3kFX2+1chijz+rS2
 fQnuO8z2E948DTm/wOzitQlQbaGqBpJPFHf/F50ck91l5XPe1sUzy4MpfF1JKhE1VlXVM9w8QB5
 gWrzjBnCs4QUN8xoFRxSVu2IHSCP62kj1W2r/Sh+Zgav4q0Ps5t4yds7sa9TT20i6FvbsvhJsNF
 wKcYmk7oW6hhKUPcDkg==
X-Proofpoint-GUID: y0dnlAPjmvOTdYrOaN8wNHk-AxUti6TC
X-Authority-Analysis: v=2.4 cv=S5vUAYsP c=1 sm=1 tr=0 ts=69b0ed8c cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Y0VZbjsYLljPqHOwCnMA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: y0dnlAPjmvOTdYrOaN8wNHk-AxUti6TC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110033
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBY2tlZC1ieTogVGF5bG9yIFNp
bXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2Fp
biA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGh3L2hleGFnb24vbWFjaGluZV9j
Zmdfc2E4Nzc1X2Nkc3AwLmguaW5jIHwgNjQgKysrKysrKysrKysrKysrKysrKysrKwogaHcvaGV4
YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMgICAgfCA2NSArKysrKysrKysrKysrKysr
KysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMjkgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUg
MTAwNjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jCiBjcmVhdGUg
bW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMKCmRpZmYg
LS1naXQgYS9ody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYyBiL2h3L2hl
eGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
CmluZGV4IDAwMDAwMDAwMDAwLi4zZDc4N2MxMDRmZgotLS0gL2Rldi9udWxsCisrKyBiL2h3L2hl
eGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jCkBAIC0wLDAgKzEsNjQgQEAKKy8q
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICovCisKK3N0YXRpYyBz
dHJ1Y3QgaGV4YWdvbl9tYWNoaW5lX2NvbmZpZyBTQTg3NzVQX2Nkc3AwID0geworICAgIC5jZmdi
YXNlID0gICAgICAgICAweDI0MDAwMDAwICsgMHgxODAwMDAsCisgICAgLmwydGNtX3NpemUgPSAg
ICAgIDB4MDAwMDAwMDAsCisgICAgLmwydmljX2Jhc2UgPSAgICAgIDB4MjYzMDAwMDAgKyAweDkw
MDAwLAorICAgIC5sMnZpY19zaXplID0gICAgICAweDAwMDAxMDAwLAorICAgIC5jc3JfYmFzZSA9
ICAgICAgICAweDI2MzAwMDAwLAorICAgIC5xdG1yX3JlZ2lvbiA9ICAgICAweDI2MzAwMDAwICsg
MHhBMTAwMCwKKyAgICAuY2ZndGFibGUgPSB7CisgICAgICAgIC5sMnRjbV9iYXNlID0gMHgwMDAw
MjQwMCwKKyAgICAgICAgLnJlc2VydmVkMCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5zdWJzeXN0
ZW1fYmFzZSA9IDB4MDAwMDI2MzgsCisgICAgICAgIC5ldG1fYmFzZSA9IDB4MDAwMDI0MTksCisg
ICAgICAgIC5sMmNmZ19iYXNlID0gMHgwMDAwMjQxYSwKKyAgICAgICAgLnJlc2VydmVkMSA9IDB4
MDAwMDI0MWIsCisgICAgICAgIC5sMXMwX2Jhc2UgPSAweDAwMDAyNTAwLAorICAgICAgICAuYXhp
Ml9sb3dhZGRyID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLnN0cmVhbWVyX2Jhc2UgPSAweDAwMDAw
MDAwLAorICAgICAgICAucmVzZXJ2ZWQyID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmZhc3RsMnZp
Y19iYXNlID0gMHgwMDAwMjQxZSwKKyAgICAgICAgLmp0bGJfc2l6ZV9lbnRyaWVzID0gMHgwMDAw
MDA4MCwKKyAgICAgICAgLmNvcHJvY19wcmVzZW50ID0gMHgwMDAwMDAwMSwKKyAgICAgICAgLmV4
dF9jb250ZXh0cyA9IDB4MDAwMDAwMDQsCisgICAgICAgIC52dGNtX2Jhc2UgPSAweDAwMDAyNTAw
LAorICAgICAgICAudnRjbV9zaXplX2tiID0gMHgwMDAwMjAwMCwKKyAgICAgICAgLmwydGFnX3Np
emUgPSAweDAwMDAwNDAwLAorICAgICAgICAubDJlY29tZW1fc2l6ZSA9IDB4MDAwMDAwMDAsCisg
ICAgICAgIC50aHJlYWRfZW5hYmxlX21hc2sgPSAweDAwMDAwMDNmLAorICAgICAgICAuZWNjcmVn
X2Jhc2UgPSAweDAwMDAyNDFmLAorICAgICAgICAubDJsaW5lX3NpemUgPSAweDAwMDAwMDgwLAor
ICAgICAgICAudGlueV9jb3JlID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwyaXRjbV9zaXplID0g
MHgwMDAwMDAwMCwKKyAgICAgICAgLmwyaXRjbV9iYXNlID0gMHgwMDAwMjQwMCwKKyAgICAgICAg
LnJlc2VydmVkMyA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5kdG1fcHJlc2VudCA9IDB4MDAwMDAw
MDAsCisgICAgICAgIC5kbWFfdmVyc2lvbiA9IDB4MDAwMDAwMDMsCisgICAgICAgIC5odnhfdmVj
X2xvZ19sZW5ndGggPSAweDAwMDAwMDA3LAorICAgICAgICAuY29yZV9pZCA9IDB4MDAwMDAwMDAs
CisgICAgICAgIC5jb3JlX2NvdW50ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmNvcHJvYzJfcmVn
MCA9IDB4MDAwMDAwNDAsCisgICAgICAgIC5jb3Byb2MyX3JlZzEgPSAweDAwMDAwMDIwLAorICAg
ICAgICAudjJ4X21vZGUgPSAweDAwMDAwMDAxLAorICAgICAgICAuY29wcm9jMl9yZWcyID0gMHgw
MDAwMDAwOCwKKyAgICAgICAgLmNvcHJvYzJfcmVnMyA9IDB4MDAwMDAwMjAsCisgICAgICAgIC5j
b3Byb2MyX3JlZzQgPSAweDAwMDAwMDAwLAorICAgICAgICAuY29wcm9jMl9yZWc1ID0gMHgwMDAw
MDAwMiwKKyAgICAgICAgLmNvcHJvYzJfcmVnNiA9IDB4MDAwMDAwMTYsCisgICAgICAgIC5jb3By
b2MyX3JlZzcgPSAweDAwMDAwMDA2LAorICAgICAgICAuYWNkX3ByZXNldCA9IDB4MDAwMDAwMDEs
CisgICAgICAgIC5tbmRfcHJlc2V0ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwxZF9zaXplX2ti
ID0gMHgwMDAwMDAxMCwKKyAgICAgICAgLmwxaV9zaXplX2tiID0gMHgwMDAwMDAyMCwKKyAgICAg
ICAgLmwxZF93cml0ZV9wb2xpY3kgPSAweDAwMDAwMDAyLAorICAgICAgICAudnRjbV9iYW5rX3dp
ZHRoID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLnJlc2VydmVkNCA9IDB4MDAwMDAwMDEsCisgICAg
ICAgIC5yZXNlcnZlZDUgPSAweDAwMDAwMDAwLAorICAgICAgICAucmVzZXJ2ZWQ2ID0gMHgwMDAw
MDAwMywKKyAgICAgICAgLmNvcHJvYzJfY3Z0X21weV9zaXplID0gMHgwMDAwMDAwYSwKKyAgICAg
ICAgLmNvbnNpc3RlbmN5X2RvbWFpbiA9IDB4MDAwMDAwZTAsCisgICAgICAgIC5jYXBhY2l0eV9k
b21haW4gPSAweDAwMDAwMDgwLAorICAgICAgICAuYXhpM19sb3dhZGRyID0gMHgwMDAwMDAwMCwK
KyAgICB9LAorfTsKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vbWFjaGluZV9jZmdfdjY4bl8xMDI0
LmguaW5jIGIvaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMKbmV3IGZpbGUg
bW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAuLjczNGExMmEyZjEyCi0tLSAvZGV2L251bGwK
KysrIGIvaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMKQEAgLTAsMCArMSw2
NSBAQAorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIgKi8KKwor
c3RhdGljIHN0cnVjdCBoZXhhZ29uX21hY2hpbmVfY29uZmlnIHY2OG5fMTAyNCA9IHsKKyAgICAu
Y2ZnYmFzZSA9ICAgICAgICAgICAweGRlMDAwMDAwLAorICAgIC5sMnRjbV9zaXplID0gICAgICAg
IDB4MDAwMDAwMDAsCisgICAgLmwydmljX2Jhc2UgPSAgICAgICAgMHhmYzkxMDAwMCwKKyAgICAu
bDJ2aWNfc2l6ZSA9ICAgICAgICAweDAwMDAxMDAwLAorICAgIC5jc3JfYmFzZSA9ICAgICAgICAg
IDB4ZmM5MDAwMDAsCisgICAgLnF0bXJfcmVnaW9uID0gICAgICAgMHhmYzkyMTAwMCwKKyAgICAu
Y2ZndGFibGUgPSB7CisgICAgICAgIC5sMnRjbV9iYXNlID0gMHgwMDAwZDgwMCwKKyAgICAgICAg
LnJlc2VydmVkMCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5zdWJzeXN0ZW1fYmFzZSA9IDB4MDAw
MGZjOTAsCisgICAgICAgIC5ldG1fYmFzZSA9IDB4MDAwMGQ4MTksCisgICAgICAgIC5sMmNmZ19i
YXNlID0gMHgwMDAwZDgxYSwKKyAgICAgICAgLnJlc2VydmVkMSA9IDB4MDAwMDAwMDAsCisgICAg
ICAgIC5sMXMwX2Jhc2UgPSAweDAwMDBkODQwLAorICAgICAgICAuYXhpMl9sb3dhZGRyID0gMHgw
MDAwMzAwMCwKKyAgICAgICAgLnN0cmVhbWVyX2Jhc2UgPSAweDAwMDBkODFjLAorICAgICAgICAu
cmVzZXJ2ZWQyID0gMHgwMDAwZDgxZCwKKyAgICAgICAgLmZhc3RsMnZpY19iYXNlID0gMHgwMDAw
ZDgxZSwKKyAgICAgICAgLmp0bGJfc2l6ZV9lbnRyaWVzID0gMHgwMDAwMDA4MCwKKyAgICAgICAg
LmNvcHJvY19wcmVzZW50ID0gMHgwMDAwMDAwMSwKKyAgICAgICAgLmV4dF9jb250ZXh0cyA9IDB4
MDAwMDAwMDQsCisgICAgICAgIC52dGNtX2Jhc2UgPSAweDAwMDBkODQwLAorICAgICAgICAudnRj
bV9zaXplX2tiID0gMHgwMDAwMTAwMCwKKyAgICAgICAgLmwydGFnX3NpemUgPSAweDAwMDAwNDAw
LAorICAgICAgICAubDJlY29tZW1fc2l6ZSA9IDB4MDAwMDA0MDAsCisgICAgICAgIC50aHJlYWRf
ZW5hYmxlX21hc2sgPSAweDAwMDAwMDNmLAorICAgICAgICAuZWNjcmVnX2Jhc2UgPSAweDAwMDBk
ODFmLAorICAgICAgICAubDJsaW5lX3NpemUgPSAweDAwMDAwMDgwLAorICAgICAgICAudGlueV9j
b3JlID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwyaXRjbV9zaXplID0gMHgwMDAwMDAwMCwKKyAg
ICAgICAgLmwyaXRjbV9iYXNlID0gMHgwMDAwZDgyMCwKKyAgICAgICAgLnJlc2VydmVkMyA9IDB4
MDAwMDAwMDAsCisgICAgICAgIC5kdG1fcHJlc2VudCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5k
bWFfdmVyc2lvbiA9IDB4MDAwMDAwMDEsCisgICAgICAgIC5odnhfdmVjX2xvZ19sZW5ndGggPSAw
eDAwMDAwMDA3LAorICAgICAgICAuY29yZV9pZCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5jb3Jl
X2NvdW50ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmNvcHJvYzJfcmVnMCA9IDB4MDAwMDAwNDAs
CisgICAgICAgIC5jb3Byb2MyX3JlZzEgPSAweDAwMDAwMDIwLAorICAgICAgICAudjJ4X21vZGUg
PSAweDFmMWYxZjFmLAorICAgICAgICAuY29wcm9jMl9yZWcyID0gMHgxZjFmMWYxZiwKKyAgICAg
ICAgLmNvcHJvYzJfcmVnMyA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5jb3Byb2MyX3JlZzQgPSAw
eDFmMWYxZjFmLAorICAgICAgICAuY29wcm9jMl9yZWc1ID0gMHgxZjFmMWYxZiwKKyAgICAgICAg
LmNvcHJvYzJfcmVnNiA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5jb3Byb2MyX3JlZzcgPSAweDFm
MWYxZjFmLAorICAgICAgICAuYWNkX3ByZXNldCA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5tbmRf
cHJlc2V0ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmwxZF9zaXplX2tiID0gMHgxZjFmMWYxZiwK
KyAgICAgICAgLmwxaV9zaXplX2tiID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmwxZF93cml0ZV9w
b2xpY3kgPSAweDFmMWYxZjFmLAorICAgICAgICAudnRjbV9iYW5rX3dpZHRoID0gMHgxZjFmMWYx
ZiwKKyAgICAgICAgLnJlc2VydmVkNCA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5yZXNlcnZlZDUg
PSAweDFmMWYxZjFmLAorICAgICAgICAucmVzZXJ2ZWQ2ID0gMHgxZjFmMWYxZiwKKyAgICAgICAg
LmNvcHJvYzJfY3Z0X21weV9zaXplID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmNvbnNpc3RlbmN5
X2RvbWFpbiA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5jYXBhY2l0eV9kb21haW4gPSAweDFmMWYx
ZjFmLAorICAgICAgICAuYXhpM19sb3dhZGRyID0gMHgxZjFmMWYxZiwKKyAgICB9LAorfTsKKwot
LSAKMi4zNC4xCgo=

