Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F000A606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FljVFhK4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OATrKaLo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKosY-0002kQ-0l; Sat, 24 Oct 2026 23:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKorA-0008Re-NI
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:25:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKor3-0001dc-21
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:25:08 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P17HWl3097777
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /M4884aPT4oFNpvxLNFc5sC3u7brSuQcX4ONRj7bubQ=; b=FljVFhK4sSrPYaV5
 TnVXbW129tegmvqLnui3kT305dpX/U+m0oKPITgbtMuFYFQHEu25bOH39maRg1PA
 gbKmVSb+cUSmonzx7pdBYwL7kUmEZiUMCuRf5l4zJfd19v1IxbaMM8R9rK4blL22
 M0+dR/bCW6gnEJl7p+I6fRUDLfL44cs7WRWRQLRYe316W/1zLYm8MW8CVwCzo4Ts
 qg1Tz2ca42ysUOsGNRc0BqY0is2pPW4GcFXk0Coa2S/cUEc2wQkCmuH2mbk3VjmK
 WAZ7nN8FfCKdDIChT1p82CxwuWk59lGajlCzYWyWxWsIoj9nUTw6zOYWmLyc6G7m
 i0WysQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgj1pap65-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:25:02 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-147be78cd56so8639741c88.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898702; x=1793503502; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/M4884aPT4oFNpvxLNFc5sC3u7brSuQcX4ONRj7bubQ=;
 b=OATrKaLoe+4kcijRpL98xmjJr5wxAmXtxHrm1Wsbp7KLZF0JJuTf6367tLZlBqN0aM
 egUQjvtsD2YUlnQipAU+8U9MRw8fFqpN7zdXtPePVF63UEPSH+srA8/fylYSaWc95oN1
 Q+5MFNjyA888imv39gSFXlQF7JLGNQ/0nASN0AZBO8h4nj0/IW+OmKb2gzSQ/zPMhjv8
 rhusy+ihdGPEw2ay+RNPCJcJeYAEiv4xArM4oHFdntylvS1cVxSYrcmZZ2H4z3j5gDGD
 OgI3rsTh/LBjIrZxLwyXMg6hY1MMbdiFFZ4MtnQ79Yr+aDdJmG5LLx7ozQvbkEo+nDJk
 UF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898702; x=1793503502;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/M4884aPT4oFNpvxLNFc5sC3u7brSuQcX4ONRj7bubQ=;
 b=IjNTeXNwh+c1vUbTNWFD66srKOvBkLZHV8W98TB8Ke5GPVCPLwlUObmE8Kp1vq+6oh
 xrcSmePMn6e4rBHW051x/t/AMd61FQjSknyOdh3JI0ktRlMo7Vi9BRVmNaiMAZ6qIu/i
 o6QA92W7FuzclGJVmuO8Przc6ITi+hjHNXWMgMX4BDRKjh2NUroqPnuOzvLiHaOuTqcS
 l2SR5iQpfx102hECabp4ilO/nomLpXzFBwQ7sPTcn2mrGTCsZZaMAO3Xhm8n4dm8gALv
 s7+oaaZUvKoT3tmEo5aZcd03dF9aDtbqYoXgx5I44HmQmIlHf4s3NYuVHK6Ir6XNZj5h
 CfaQ==
X-Gm-Message-State: AFq9FYK38/JJKJtiXetVpgqabA7lAdBokfRCwFXWNA0jtwNnXi83Ocba
 sorIVnwzM3AjbjKChm9AsfwHfnaBH3RQmFeM3s0yYjUzlem9vw6NJDYiSFEytpZi+Wz2y+FM6yU
 aSjioCjjRxa1mUAyo/Hiyfh7Qcvjkd59zuQkgoV2pOegk3ql62CpXZ/o6NFnOnNCDNA==
X-Gm-Gg: AYBFou0wR2bZ2M+RchklyU+Lg+m0KcOkGJuKDeKBF5B2715/vVuzCAtOQJk5rJUK0yv
 0x3m/IgahwDTmS2cJy8azPV8lzugoxQE1MCCpRgok8j1lIC904XUmftXwvbU3V6qhEAkbCLKpfw
 jxECYeooOmPFw/T3ogAFf0MflXuP3XCRa+zuTQQbAgw7CkIhyesRVdxOddMXhMNmMRfZYVESRCe
 O/B8xUNzQXKSu37aC/SprxcHQ+1dHtdyiwsSbQdWrVJbB7PavBUEnOFGxxuIyxST6SkytdOXp1y
 bR4Apygylw/EwlLr7q9zfLn0b3raeoEOHOWlWkoQggcrUIXld4vyPWvXMXeNGrS62DHfgfLgk5J
 7VMlBl0JW0+s5Sily7rWofJWKAcBb8zyWBaa1pLIHy6kaOj4=
X-Received: by 2002:a05:7022:438e:b0:195:e4b9:d326 with SMTP id
 a92af1059eb24-19936a5e5e9mr8063751c88.12.1792898701758; 
 Sat, 24 Oct 2026 20:25:01 -0700 (PDT)
X-Received: by 2002:a05:7022:438e:b0:195:e4b9:d326 with SMTP id
 a92af1059eb24-19936a5e5e9mr8063723c88.12.1792898701224; 
 Sat, 24 Oct 2026 20:25:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:24:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 39/40] target/hexagon: only flush the softtlb when SSR.ASID
 changes
Date: Sat, 24 Oct 2026 20:23:45 -0700
Message-Id: <20261025032346.2917451-40-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMyBTYWx0ZWRfX6s/7qqslKrRX
 cpMSNGQHklo3+xLPsmX/CfgV5KpN2YLH23Zp1uaAWO9wn/QayTKRus1282GHSmXnGZHo4Dnuz0t
 jqegC3sLnEeAdt4DxdACHjGxrVip+98=
X-Proofpoint-GUID: _HhUgQfYjsb-5hCeK_MM2a8x-nSMobm9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMyBTYWx0ZWRfXxp4qm8jOzcko
 2B5e0xLHf8IxuFiUTS3ucSY5Gy9lLsooJkybECAWA6U6fOdRe0KWYuSMgPjkRfILAqM11l0oOU3
 NAX3vYcpH+8HTbfahpMEgQ3G3siyMFh5VBZjkBs+hYRkgS3Fd6G7+QUstUcNOUS6EVa3jgQJpy3
 zvFrzbX0H6BR2mpHMV2NjnxBVIyPH5uvZ0dnzVkvMuie3hoyarNHN7tcbNz1uh8AssFAoyMBXLz
 qNfTuSgH8j9O3yvFqE92pw8CYJKBUgR6+Z2Gldfs4jP9jKAl9tSoS1bAzwZr2wmPvhu8+2MaCIG
 dnVnSyoSncPIyDRTsjkm6Pn7djGLaYn1fdVAVxtAm2AxbS0lDsH58SzhpmogEvUqXR7OKRpiZ9z
 MWqHlbMVdB+2C4ZaqLJ7kCb50cALE150TAJZV1oiuIXrSj0X2lceSDYGUbDKaJ9/OXWnRkPRe8n
 vYaWZ6G0nvrnOb6+kyA==
X-Proofpoint-ORIG-GUID: _HhUgQfYjsb-5hCeK_MM2a8x-nSMobm9
X-Authority-Analysis: v=2.4 cv=D5vSufRj c=1 sm=1 tr=0 ts=6add768e cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=03mWCbMf3N1Ipu_5KecA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610250013
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

aGV4YWdvbl9tb2RpZnlfc3NyKCkgZmx1c2hlZCB0aGUgc29mdHRsYiBvbiBhbnkgY2hhbmdlIHRv
IFNTUi5FWCwgVU0sIEdNLApvciBBU0lELCBidXQgb25seSBBU0lEIGFmZmVjdHMgdHJhbnNsYXRp
b24uICBFWC9VTS9HTSBqdXN0IHBpY2sgdGhlIG1vZGUsCndoaWNoIGlzIGFscmVhZHkgY2FwdHVy
ZWQgaW4gbW11X2lkeC4KCkVYIHRvZ2dsZXMgb24gZXZlcnkgZXhjZXB0aW9uIGVudHJ5L3J0ZSwg
c28gdGhlIGZsdXNoIGNyZWF0ZWQgYSBmZWVkYmFjawpsb29wIHdoZXJlIGEgVExCIG1pc3Mgd2lw
ZWQgdGhlIHNvZnR0bGIgYW5kIGd1YXJhbnRlZWQgdGhlIG5leHQgYWNjZXNzZXMKbWlzc2VkIHRv
by4KClJlbmFtZSBoZXhfbW11X21vZGVfY2hhbmdlKCkgdG8gaGV4X21tdV9hc2lkX2NoYW5nZSgp
IHRvIG1hdGNoIHdoYXQgbm93CnRyaWdnZXJzIGl0LCBhbmQgbmFycm93IGl0IHRvIHRoaXMgdGhy
ZWFkJ3MgbW11IGluZGljZXM6IHRoZSBBU0lEIGxpdmVzIGluCnRoZSB0aHJlYWQncyBwcml2YXRl
IFNTUiwgc28gb3RoZXIgQ1BVcyBhcmUgdW5hZmZlY3RlZC4KClJldmlld2VkLWJ5OiBQaWVycmlj
ayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQv
aGV4YWdvbi9oZXhfbW11LmggICAgfCAgMiArLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5j
IHwgMTcgKysrLS0tLS0tLS0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2hleF9tbXUuYyAgICB8ICA3
ICsrKystLS0KIDMgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfbW11LmggYi90YXJnZXQvaGV4YWdv
bi9oZXhfbW11LmgKaW5kZXggMGM0OTQwNDQ0OGMuLjliNmVhNWI5NjdiIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9oZXhfbW11LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5oCkBA
IC0xNyw3ICsxNyw3IEBAIGV4dGVybiB2b2lkIGhleF90bGJfaW52YWxpZGF0ZV9hc2lkKENQVUhl
eGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBhc2lkKTsKIGV4dGVybiB1aW50MzJfdCBoZXhfdGxi
X2xvb2t1cChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3NyLCB1aW50MzJfdCBWQSk7
CiBleHRlcm4gdm9pZCBoZXhfbW11X29uKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIGV4dGVybiB2
b2lkIGhleF9tbXVfb2ZmKENQVUhleGFnb25TdGF0ZSAqZW52KTsKLWV4dGVybiB2b2lkIGhleF9t
bXVfbW9kZV9jaGFuZ2UoQ1BVSGV4YWdvblN0YXRlICplbnYpOworZXh0ZXJuIHZvaWQgaGV4X21t
dV9hc2lkX2NoYW5nZShDUFVIZXhhZ29uU3RhdGUgKmVudik7CiBleHRlcm4gYm9vbCBoZXhfdGxi
X2ZpbmRfbWF0Y2goQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IFZBLAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIE1NVUFjY2Vzc1R5cGUgYWNjZXNzX3R5cGUsIGh3YWRkciAq
UEEsIGludCAqcHJvdCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCAq
c2l6ZSwgaW50MzJfdCAqZXhjcCwgaW50IG1tdV9pZHgpOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vY3B1X2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCmluZGV4IDkx
OWZjYmM3Yzk3Li5iYWZmZTZiYmFhOSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hl
bHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYwpAQCAtMTkyLDI3ICsxOTIs
MTcgQEAgdW5zaWduZWQgaGV4YWdvbl9odnhfc2VsZWN0X2NvbnRleHQoQ1BVSGV4YWdvblN0YXRl
ICplbnYsIHVpbnQzMl90IHNzcikKIAogdm9pZCBoZXhhZ29uX21vZGlmeV9zc3IoQ1BVSGV4YWdv
blN0YXRlICplbnYsIHVpbnQzMl90IG5ldywgdWludDMyX3Qgb2xkKQogewotICAgIGJvb2wgb2xk
X0VYLCBvbGRfVU0sIG9sZF9HTSwgb2xkX0lFOwotICAgIGJvb2wgbmV3X0VYLCBuZXdfVU0sIG5l
d19HTSwgbmV3X0lFOworICAgIGJvb2wgb2xkX0VYLCBvbGRfSUU7CisgICAgYm9vbCBuZXdfRVgs
IG5ld19JRTsKICAgICB1aW50OF90IG9sZF9hc2lkLCBuZXdfYXNpZDsKIAogICAgIGdfYXNzZXJ0
KGJxbF9sb2NrZWQoKSk7CiAKICAgICBvbGRfRVggPSBHRVRfU1NSX0ZJRUxEKFNTUl9FWCwgb2xk
KTsKLSAgICBvbGRfVU0gPSBHRVRfU1NSX0ZJRUxEKFNTUl9VTSwgb2xkKTsKLSAgICBvbGRfR00g
PSBHRVRfU1NSX0ZJRUxEKFNTUl9HTSwgb2xkKTsKICAgICBvbGRfSUUgPSBHRVRfU1NSX0ZJRUxE
KFNTUl9JRSwgb2xkKTsKICAgICBuZXdfRVggPSBHRVRfU1NSX0ZJRUxEKFNTUl9FWCwgbmV3KTsK
LSAgICBuZXdfVU0gPSBHRVRfU1NSX0ZJRUxEKFNTUl9VTSwgbmV3KTsKLSAgICBuZXdfR00gPSBH
RVRfU1NSX0ZJRUxEKFNTUl9HTSwgbmV3KTsKICAgICBuZXdfSUUgPSBHRVRfU1NSX0ZJRUxEKFNT
Ul9JRSwgbmV3KTsKIAotICAgIGlmICgob2xkX0VYICE9IG5ld19FWCkgfHwKLSAgICAgICAgKG9s
ZF9VTSAhPSBuZXdfVU0pIHx8Ci0gICAgICAgIChvbGRfR00gIT0gbmV3X0dNKSkgewotICAgICAg
ICBoZXhfbW11X21vZGVfY2hhbmdlKGVudik7Ci0gICAgfQotCiAgICAgYm9vbCB4YV9jaGFuZ2Vk
ID0gR0VUX1NTUl9GSUVMRChTU1JfWEEsIG5ldykgIT0gR0VUX1NTUl9GSUVMRChTU1JfWEEsIG9s
ZCk7CiAgICAgYm9vbCB4ZV9jaGFuZ2VkID0gR0VUX1NTUl9GSUVMRChTU1JfWEUsIG5ldykgIT0g
R0VUX1NTUl9GSUVMRChTU1JfWEUsIG9sZCk7CiAKQEAgLTIyOCw4ICsyMTgsNyBAQCB2b2lkIGhl
eGFnb25fbW9kaWZ5X3NzcihDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50
MzJfdCBvbGQpCiAgICAgb2xkX2FzaWQgPSBHRVRfU1NSX0ZJRUxEKFNTUl9BU0lELCBvbGQpOwog
ICAgIG5ld19hc2lkID0gR0VUX1NTUl9GSUVMRChTU1JfQVNJRCwgbmV3KTsKICAgICBpZiAobmV3
X2FzaWQgIT0gb2xkX2FzaWQpIHsKLSAgICAgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYp
OwotICAgICAgICB0bGJfZmx1c2goY3MpOworICAgICAgICBoZXhfbW11X2FzaWRfY2hhbmdlKGVu
dik7CiAgICAgfQogCiAgICAgLyogU2VlIGlmIHRoZSBpbnRlcnJ1cHRzIGhhdmUgYmVlbiBlbmFi
bGVkIG9yIHdlIGhhdmUgZXhpdGVkIEVYIG1vZGUgKi8KZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2hleF9tbXUuYyBiL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYwppbmRleCAyZTBlNGFiNzA1
Yi4uOWEwZTI5YWUyMTIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYworKysg
Yi90YXJnZXQvaGV4YWdvbi9oZXhfbW11LmMKQEAgLTczLDExICs3MywxMiBAQCB2b2lkIGhleF9t
bXVfb2ZmKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgIHRsYl9mbHVzaChjcyk7CiB9CiAKLXZv
aWQgaGV4X21tdV9tb2RlX2NoYW5nZShDUFVIZXhhZ29uU3RhdGUgKmVudikKK3ZvaWQgaGV4X21t
dV9hc2lkX2NoYW5nZShDUFVIZXhhZ29uU3RhdGUgKmVudikKIHsKLSAgICBxZW11X2xvZ19tYXNr
KENQVV9MT0dfTU1VLCAiSGV4YWdvbiBtb2RlIGNoYW5nZSFcbiIpOwogICAgIENQVVN0YXRlICpj
cyA9IGVudl9jcHUoZW52KTsKLSAgICB0bGJfZmx1c2goY3MpOworCisgICAgcWVtdV9sb2dfbWFz
ayhDUFVfTE9HX01NVSwgIkhleGFnb24gQVNJRCBjaGFuZ2UhXG4iKTsKKyAgICB0bGJfZmx1c2hf
YnlfbW11aWR4KGNzLCBNTVVfSURYX0FMTCk7CiB9CiAKIGJvb2wgaGV4X3RsYl9maW5kX21hdGNo
KENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBWQSwKLS0gCjIuMzQuMQoK

