Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82AA606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 23:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TvWGUe7/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GolmhdJd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK1mt-00054T-40; Thu, 22 Oct 2026 19:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK1mr-000544-45
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:01:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK1mp-00024r-8U
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:01:28 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMF0fW4081836
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8IyQaTAqm3dKVJ5dLB2G4az8kC5YU0LalyOqFINL4UU=; b=TvWGUe7/vjYT76ju
 t72itdkPw1fRdaroiezAl5TO9mPDM3t3IV7fWZF4Ed9uPpnflwq67EFjNLFzc8aM
 j4fBYTIeaDelfJZCiMzK6EX6MZZS3GniIDxwCxjF8O3sD+mQ8KEVfSw8JaJDKns5
 1kYjtHhLdmEspGBjr3U1G02bx8Cjc/Uxl5qQPTkw/StMhGrEqT32eMr6o2wxQAYe
 v+gkdQE7o8r50MO/MN+ID6Kj7XR+vP+joqcehpvMGq/IxgbAltb6O0Pu+1JBj9Pu
 8qdaAhlbk3mpdMrLfasfJGU9kIBaNMyJIiF5cPfRfOadTQw5Vs3yhsBhOI9stxPq
 F5nhLg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbgx3p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:01:26 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36637676140so495562eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 16:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792710085; x=1793314885; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8IyQaTAqm3dKVJ5dLB2G4az8kC5YU0LalyOqFINL4UU=;
 b=GolmhdJdya4IGDuCedCLxp3+iXTCIwNKtN0vY/AU095y3ugcsOsc3/qfN/EbYwsNJ4
 ci11h1+S6pEVqPvoKIOp2Bw8oXGXeKazTAxVVXldKWgrj3LT8oO27eKE1yC0majcpa/u
 qvdlwZ0O+v1/S4kjXPhz6I4n8y6w3cow2hplv7EF8rJNZniav8oAgKIBAGi0n1Gox2t1
 Fm6tKQdcl+eh1vVT093acUGKCmU3ScnGHmX59p5STgJkTNckV5dzSiiIpkhSYDaeY70B
 Kbi00HmR6AVu019m6pXWHx6rBMxUMcxq9E3G6aeo8QjGwBxoJdM9bJE6nt5u3h5rIqrI
 isjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792710085; x=1793314885;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8IyQaTAqm3dKVJ5dLB2G4az8kC5YU0LalyOqFINL4UU=;
 b=0YNESRVRFDsQLhU+dZ3p23/mEd9e2q9KXh7++t/6qCnE+HYHsb8RpmDtcvgXt6SwdQ
 lWag21nwI0NBdeDSbuK5X+EcBn8cm1kRzJKqGIIlfDak0Sf08T7AC1vKliC/NLwfawRe
 ZlOfZ+2sjyv/bhds9yqp/jSME/qPnAQRTIO2tD2bJepIS721t5ax8thn0NW1hviEsSne
 23zqF9z+FxuMTpF24z9ox0IocHufNgRl53pofqNyGc+WmlcG+AGigRIBuDSchwVIsTbN
 k3rUWbfFCHokBdGxcu1D5wMgyePLlv9k3W4aRtc/IYk4l00Y9ys3Ie/PM+AGBdtlBhZR
 HGnA==
X-Gm-Message-State: AFq9FYLh3ItTvahrz1Y69u8b8ePibY2NGedb5GQNQBH45vMop+yrHKSO
 Cr7oJfEF6LVhdGrfaZXLB5dpz8nc6vK+HUnND8aM0sOv6eVv1d5CXF9gZ01xwda8Fd1RF3sAbm2
 qnmY7RRF1Lw50HZXleZSAM9HLr3siuqqmirC6aikwlmOUUV1FBoh7Gi7irmbq8uXJxg==
X-Gm-Gg: AYBFou2l17vVdiPlruDM1SozeBxfVTmWJhDx6bi5z/ArMf2GIwUTp+N+/uROci9+krS
 BpwbcbtCMMqp1UW7GHHQSP0nrHEVZtF66TM1EzRFU1yRP8c542C0MppRr5g9EfFjivqDCdljeGY
 1GSyIDzDC7ysPSZ06IUbMw7MaMb57cuJ8Y1U+fKpBX5mNrDyqUjCSx0f8t0jkbN2JVqFWZK4aV0
 WKYhBDzcP+TdU4I3/Agv1S1uiTxEx47XIjS6oTfBqfrL6Yl1iFvDIdW/Sgg1aPYMvr5fNZ8a8By
 UBjBpjvT0BM6+MGb+LnkO9SHVTBs7sJPjazyVSHr7E2DQISjjiUmQGh2QJQ4nNvmx6K/qbz37W5
 DKajPwISCr0hEhnLjEE7aBUE1a1Uv+2V14sMOuZcFQ18BdA3G
X-Received: by 2002:a05:7301:4303:b0:368:2548:c08d with SMTP id
 5a478bee46e88-369d978ec2bmr634571eec.25.1792710085113; 
 Thu, 22 Oct 2026 16:01:25 -0700 (PDT)
X-Received: by 2002:a05:7301:4303:b0:368:2548:c08d with SMTP id
 5a478bee46e88-369d978ec2bmr634534eec.25.1792710084455; 
 Thu, 22 Oct 2026 16:01:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9c0e60dsm1088138eec.2.2026.10.22.16.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 16:01:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Anton Johansson <anjo@rev.ng>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 14/16] target/hexagon: fix the allocframe framekey
Date: Thu, 22 Oct 2026 16:00:46 -0700
Message-Id: <20261022230048.2160400-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
References: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfXwt0ixFPmjEaY
 5kZAFiVrvGLQe6SFaTe2woVyF47XNK2aAPhie5AvZGrPN9JxOe1rlkHVk+woiGhibAhH5vmlpgb
 fv33SHOBUUnBlxfgrSSq7i20hgOaxEw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfX4fYrIYCmR+0q
 bi1Fqpi1evaoAyCcItDcB9qdA/1dxfs11/QZJZaeTP/1/c/tcB7pw3f78SxsCU5q13xmkbxrx0s
 yYyuZotRisCj5X5xhSghzXedrknQuMaTkVe2ygoIQkR3OZr4Nkxf8Z7XPdNCK5gijgd6gcdecXc
 x9bLE42NwwoWwJNqeLm6+BfIQNc3rmoLZCZuLD/8fL03tmuWFT4QRwMR2ZmUFCl5gDQ99//vNtB
 Q/eICa8IVWDbtf3iNMBWOPf6wH8pNcnkDNNdL9TkLFR2QKSNr7/ok/P1hMT+KRBSZQ14TBHzPLf
 pYKw57hiHp43widsaIU5qXFVg36ybnNKM7aUk01WNvT4bcB5IgfcL2+cwlz7oDwNGcI5LRmJ4yC
 YeSwEC+eMzrudcaM/DvM0Id+CRW3JfVU/64/u/bmfiRgUc7zqBcdxjOyxi9K5A1GOZh2TtX/Qp7
 QnykcYjXRlh0MM4b7hw==
X-Proofpoint-ORIG-GUID: 00Q8teS0RoRHp99VHT9BrUHXJl4PGIUU
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6ada95c6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=_X05_UiFBxjwBGZApkgA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: 00Q8teS0RoRHp99VHT9BrUHXJl4PGIUU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220091
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

VGhlIGZyYW1lIHRoYXQgYWxsb2NmcmFtZSBwdXNoZXMgaXMge0xSLCBGUH0sIGFuZCB3aGF0IGlz
IHNjcmFtYmxlZCBpcwp0aGUgTFIgd29yZDogRlJBTUVLRVkgaXMgWE9SJ2QgaW50byB0aGUgdXBw
ZXIgMzIgYml0cy4gIFRoZSBnZW5lcmF0ZWQKY29kZSBmb3IgZkZSQU1FX1NDUkFNQkxFIGJ1aWx0
IHRoZSBrZXkgZnJvbSBGUkFNRUtFWSBpbiBib3RoIGhhbHZlcyBvZgphIDY0LWJpdCB2YWx1ZSwg
c28gaXQgc2NyYW1ibGVkIEZQIGFzIHdlbGwuICBkZWFsbG9jZnJhbWUgYW5kCmRlYWxsb2NfcmV0
dXJuIG9ubHkgdW5kbyB0aGUgdXBwZXIgd29yZCwgc28gYSBGUCByZXN0b3JlZCBmcm9tIGEgZnJh
bWUKcHVzaGVkIHdpdGggYSBub24temVybyBGUkFNRUtFWSB3YXMgY29ycnVwdC4KClVuY292ZXJl
ZCBieSB0ZXN0aW5nIHNvbWUgYm9vdCBpbWFnZXMgdXNpbmcgUXVSVC4KClJldmlld2VkLWJ5OiBQ
aWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jIHwgIDIgKy0KIHRlc3Rz
L3RjZy9oZXhhZ29uL2ZyYW1la2V5LmMgICAgICAgICAgICAgICAgfCA2NyArKysrKysrKysrKysr
KysrKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgfCAg
MSArCiAzIGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKIGNy
ZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cvaGV4YWdvbi9mcmFtZWtleS5jCgpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuYyBiL3RhcmdldC9o
ZXhhZ29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJzLmMKaW5kZXggNDljYzExZmRkZDguLjE0
ODQwZDk4NzM3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXIt
aGVscGVycy5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJz
LmMKQEAgLTE5ODksNyArMTk4OSw3IEBAIEhleFZhbHVlIGdlbl9ydmFsdWVfZnNjcihDb250ZXh0
ICpjLCBZWUxUWVBFICpsb2NwLCBIZXhWYWx1ZSAqdmFsdWUpCiAgICAgKnZhbHVlID0gZ2VuX3J2
YWx1ZV9leHRlbmQoYywgbG9jcCwgdmFsdWUpOwogICAgIE9VVChjLCBsb2NwLCAiZ2VuX3JlYWRf
cmVnKCIsICZmcmFtZV9rZXksICIsIEhFWF9SRUdfRlJBTUVLRVkpO1xuIik7CiAgICAgT1VUKGMs
IGxvY3AsICJ0Y2dfZ2VuX2NvbmNhdF9pMzJfaTY0KCIsCi0gICAgICAgICZrZXksICIsICIsICZm
cmFtZV9rZXksICIsICIsICZmcmFtZV9rZXksICIpO1xuIik7CisgICAgICAgICZrZXksICIsIHRj
Z19jb25zdGFudF90bCgwKSwgIiwgJmZyYW1lX2tleSwgIik7XG4iKTsKICAgICBPVVQoYywgbG9j
cCwgInRjZ19nZW5feG9yX2k2NCgiLCAmcmVzLCAiLCAiLCB2YWx1ZSwgIiwgIiwgJmtleSwgIik7
XG4iKTsKICAgICByZXR1cm4gcmVzOwogfQpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24v
ZnJhbWVrZXkuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2ZyYW1la2V5LmMKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKaW5kZXggMDAwMDAwMDAwMDAuLjVkNTc5MjkzNDc3Ci0tLSAvZGV2L251bGwKKysrIGIv
dGVzdHMvdGNnL2hleGFnb24vZnJhbWVrZXkuYwpAQCAtMCwwICsxLDY3IEBACisvKgorICogIENv
cHlyaWdodChjKSBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gYW5kL29yIGl0cyBzdWJzaWRp
YXJpZXMuCisgKgorICogIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVy
CisgKi8KKworI2luY2x1ZGUgPHN0ZGlvLmg+CisjaW5jbHVkZSA8c3RkaW50Lmg+CisKK2ludCBl
cnI7CisKKyNpbmNsdWRlICJoZXhfdGVzdC5oIgorCisvKgorICogYWxsb2NmcmFtZSBwdXNoZXMg
e0xSLCBGUH0sIHNjcmFtYmxpbmcgTFIgd2l0aCBGUkFNRUtFWSwgYW5kIGRlYWxsb2NmcmFtZQor
ICogcmVzdG9yZXMgdGhlbS4gIFB1c2ggYSBmcmFtZSBhbmQgcmV0dXJuIHRoZSB3b3JkcyB0aGF0
IHdlcmUgc3RvcmVkLCBGUAorICogdGhyb3VnaCB0aGUgcmV0dXJuIHZhbHVlIGFuZCBMUiB0aHJv
dWdoIEBscl9zdG9yZWQsIGFuZCB0aGUgRlAgYW5kIExSCisgKiB0aGF0IGRlYWxsb2NmcmFtZSBy
ZXN0b3Jlcy4KKyAqLworc3RhdGljIGlubGluZSB1aW50MzJfdCBmcmFtZV9yb3VuZHRyaXAodWlu
dDMyX3Qga2V5LCB1aW50MzJfdCBmcCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQzMl90IGxyLCB1aW50MzJfdCAqbHJfc3RvcmVkLAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKmZwX2JhY2ssIHVpbnQzMl90ICpscl9i
YWNrKQoreworICAgIHVpbnQzMl90IGZwX3N0b3JlZCwgc2F2ZWRfZnAsIHNhdmVkX2xyOworCisg
ICAgYXNtIHZvbGF0aWxlKCIlW3NhdmVkX2ZwXSA9IHIzMFxuXHQiCisgICAgICAgICAgICAgICAg
ICIlW3NhdmVkX2xyXSA9IHIzMVxuXHQiCisgICAgICAgICAgICAgICAgICJmcmFtZWtleSA9ICVb
a2V5XVxuXHQiCisgICAgICAgICAgICAgICAgICJyMzAgPSAlW2ZwXVxuXHQiCisgICAgICAgICAg
ICAgICAgICJyMzEgPSAlW2xyXVxuXHQiCisgICAgICAgICAgICAgICAgICJhbGxvY2ZyYW1lKCMw
KVxuXHQiCisgICAgICAgICAgICAgICAgICIlW2ZwX3N0b3JlZF0gPSBtZW13KHIzMClcblx0Igor
ICAgICAgICAgICAgICAgICAiJVtscl9zdG9yZWRdID0gbWVtdyhyMzAgKyAjNClcblx0IgorICAg
ICAgICAgICAgICAgICAicjMxID0gIzBcblx0IgorICAgICAgICAgICAgICAgICAiZGVhbGxvY2Zy
YW1lXG5cdCIKKyAgICAgICAgICAgICAgICAgIiVbZnBfYmFja10gPSByMzBcblx0IgorICAgICAg
ICAgICAgICAgICAiJVtscl9iYWNrXSA9IHIzMVxuXHQiCisgICAgICAgICAgICAgICAgICJmcmFt
ZWtleSA9ICVbemVyb11cblx0IgorICAgICAgICAgICAgICAgICAicjMwID0gJVtzYXZlZF9mcF1c
blx0IgorICAgICAgICAgICAgICAgICAicjMxID0gJVtzYXZlZF9scl1cbiIKKyAgICAgICAgICAg
ICAgICAgOiBbZnBfc3RvcmVkXSAiPSZyIihmcF9zdG9yZWQpLCBbbHJfc3RvcmVkXSAiPSZyIigq
bHJfc3RvcmVkKSwKKyAgICAgICAgICAgICAgICAgICBbZnBfYmFja10gIj0mciIoKmZwX2JhY2sp
LCBbbHJfYmFja10gIj0mciIoKmxyX2JhY2spLAorICAgICAgICAgICAgICAgICAgIFtzYXZlZF9m
cF0gIj0mciIoc2F2ZWRfZnApLCBbc2F2ZWRfbHJdICI9JnIiKHNhdmVkX2xyKQorICAgICAgICAg
ICAgICAgICA6IFtrZXldICJyIihrZXkpLCBbZnBdICJyIihmcCksIFtscl0gInIiKGxyKSwgW3pl
cm9dICJyIigwKQorICAgICAgICAgICAgICAgICA6ICJtZW1vcnkiLCAiZnJhbWVrZXkiKTsKKyAg
ICByZXR1cm4gZnBfc3RvcmVkOworfQorCitzdGF0aWMgdm9pZCBjaGVja19mcmFtZSh1aW50MzJf
dCBrZXksIHVpbnQzMl90IGZwLCB1aW50MzJfdCBscikKK3sKKyAgICB1aW50MzJfdCBscl9zdG9y
ZWQsIGZwX2JhY2ssIGxyX2JhY2s7CisKKyAgICAvKiBPbmx5IExSIGlzIHNjcmFtYmxlZCwgRlAg
aXMgc3RvcmVkIGFzIGlzICovCisgICAgY2hlY2szMihmcmFtZV9yb3VuZHRyaXAoa2V5LCBmcCwg
bHIsICZscl9zdG9yZWQsICZmcF9iYWNrLCAmbHJfYmFjayksIGZwKTsKKyAgICBjaGVjazMyKGxy
X3N0b3JlZCwgbHIgXiBrZXkpOworICAgIGNoZWNrMzIoZnBfYmFjaywgZnApOworICAgIGNoZWNr
MzIobHJfYmFjaywgbHIpOworfQorCitpbnQgbWFpbigpCit7CisgICAgY2hlY2tfZnJhbWUoMCwg
MHgxMjM0ZmZmMCwgMHg1Njc4YWJjYyk7CisgICAgY2hlY2tfZnJhbWUoMHhmMjFmMjBhMCwgMHgx
MjM0ZmZmMCwgMHg1Njc4YWJjYyk7CisKKyAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQQVNTIik7
CisgICAgcmV0dXJuIGVycjsKK30KZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL21lc29u
LmJ1aWxkIGIvdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQKaW5kZXggYTZhY2U0Yzc3YzIu
LjBmZDYyY2U3ZTRjIDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZAor
KysgYi90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtNjgsNiArNjgsNyBAQCB0ZXN0
cyArPSB7CiAgICdvdmVyZmxvdy5jJzogeydjZmxhZ3MnOiBjZmxhZ3MsICdleGVfbmFtZSc6ICdo
ZXgtb3ZlcmZsb3cnfSwKICAgJ3ByZWdfYWxpYXMuYyc6IHsnY2ZsYWdzJzogY2ZsYWdzfSwKICAg
J2R1YWxfc3RvcmVzLmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCisgICdmcmFtZWtleS5jJzogeydj
ZmxhZ3MnOiBjZmxhZ3N9LAogICAnbXVsdGlfcmVzdWx0LmMnOiB7J2NmbGFncyc6IGNmbGFnc30s
CiAgICdtZW1fbm9zaHVmLmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCiAgICdtZW1fbm9zaHVmX2V4
Y2VwdGlvbi5jJzogeydjZmxhZ3MnOiBjZmxhZ3N9LAotLSAKMi4zNC4xCgo=

