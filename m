Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDD3606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 22:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W9VizEvU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JDkNyjoF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKODT-0002X1-MJ; Fri, 23 Oct 2026 18:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKODS-0002Wh-KC
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 18:58:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKODR-0004jx-1O
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 18:58:26 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvIGC297468
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 22:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=pkk/LrminIUwflY3NXO9pT
 P1DzdcZY/2xQ47rt8eaeU=; b=W9VizEvU2EbeSNmP3AUJIP3IO3uIZ1foVIj8hE
 stkbtoCi2ekBUtFPwdBhJ2su2sSDuOeVU20RwEYQjUvp/1It/h7rSD19w9xwVbq1
 IYi8wjk3Bu26vfmLuVCap1m1CwTcGB2Ff41CjECiw/chzp6Rp1zNHuZeacqwB+tE
 iSNpbFRXqs46mIaD6K9vs6xfgsDCgfzvem7sdUxfL2cPIDY5WQlp6xHxFeuIL4o/
 keBYm/O/x4iktsIkWcZkLPe12uKMF3Yu/ypv70lYmN7cCU0lBxFGoHPwvVvvyxbd
 6Qjw9A+stcc89ckuecbUkkNRM0BpMypfuzh5CFPqNZCTMhyw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgaruha4r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 22:58:23 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510d0baf63so3342762eec.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 15:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792796302; x=1793401102; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pkk/LrminIUwflY3NXO9pTP1DzdcZY/2xQ47rt8eaeU=;
 b=JDkNyjoF6Ua/3fZ+8OhmfJv2s8H/Bd9hSKjurozDZlmVaheSGvk19XeezMP5v+Rwhd
 v/gO3qVWipmHHP0jZC9VN73b4egdlasYvWyvKKCIJsxNq0jUKG/0aV9Hsn78obUbiFzL
 jl1qz6+1pjG06nokuqnQjcgIgrgxzoPgB3RF1su7XV3U5IjA8wfhJw7owW/ZxbMalds0
 CXUbBKQA88B41bIMRwmLPP19m/YnaWTdaQo479/iPQHyQDEpUj2wkG/1Cuyabv+EpCi+
 CVg7ZNDTsqjiYt8XAYBWgB0RPsN6Rmuqk+YubBpJ97li4bZ7JXZkoSkBKO0+o2VvTdC9
 RbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792796302; x=1793401102;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pkk/LrminIUwflY3NXO9pTP1DzdcZY/2xQ47rt8eaeU=;
 b=vdro/KVyp5jf8LKCYmwCeUzs6i2UyS9dTnEeO2TKNcN+dDz6UJFsoiiXqpwgLE8cCO
 pN0hOpKdvIZk0nZFnGRzc/KrvC2dCrdMJ1NaZDwEbcMaOa0ne8cgxRzsFnopaoD9Qi99
 s25KKlGlNEPOQBkPxev1M3QebuFsXbwhaZ5UAlc2AxEClsrh/BcZPGHjDK94Z0Fyv56K
 01PS7yfM2q5bcKIeQTiIFLeoyJXtBAKh104t24/GYpBZt47RKVyJl4OTw8a65RvgxDww
 r7J0HE6fW9SIy+6Gwn0Cgrtt1lodlq8HVJLJzz9QsgjJAO39dM2JvUz2lFjJL+b0rAVP
 ntKg==
X-Gm-Message-State: AFq9FYIECwiCHRnpxWKSdyVgfdrfnVfe87VKn3IixIDNsqkBf+RN/z+d
 2QruQJmjC2PSZvavNPM/F5Ah2yJ12/rms3iOuNoQsVuyKBZefxOX/KUg8VVTeRQb+HCjabcoZWj
 jXal289/byHC++RblvA3vS/BCaUA8TldDkAwH+5JC2rMwPuQceKENvTmJVL5coqAuVg==
X-Gm-Gg: AYBFou0GWs6+qF2zHiMhQb0SPh1AW0WdFGBv/vpu/Lnc83BrQaLJCPX1BKVcVlQMzQ6
 apDJfgG7gD85zTr+G7nSW34N+FOB0loJBAR55t18CdpiYbxLabHmuD7LdtPjimxgf0fy0kQ0y86
 5UK3weNRBUYOocBbuTj3VT9osv3/xD45i7vdp10ETpAxBNKcGpPtaU6Mo8a1rsvAcrMLkT+qrAr
 Dr05qovhdVpJnDxpCXZ8fzBv9n5g+sE3jpFOU6RbJgMRhVfZEPJOoXyifxq2Tq2FinDZdU7WtIy
 5Ur7T5KEdCNSmTXiqwNRjGgXizoabjnzOIU/cf2gm0onrOkm7afUJ8rUs0fEmhmzgBSHFkFC30u
 +enEhtW5AaaQMi8X72OLXWKIFOuKfgBEyggUB8RrdOVANwIc=
X-Received: by 2002:a05:7022:1005:b0:167:4198:2cb3 with SMTP id
 a92af1059eb24-19934e6c5a8mr772398c88.18.1792796301983; 
 Fri, 23 Oct 2026 15:58:21 -0700 (PDT)
X-Received: by 2002:a05:7022:1005:b0:167:4198:2cb3 with SMTP id
 a92af1059eb24-19934e6c5a8mr772351c88.18.1792796301305; 
 Fri, 23 Oct 2026 15:58:21 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a32ff780sm1280380c88.22.2026.10.23.15.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 15:58:20 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/4] Hexagon: Add v79, v81 HVX fp/vcvt instructions
Date: Fri, 23 Oct 2026 15:58:16 -0700
Message-Id: <20261023225820.330905-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MCBTYWx0ZWRfXz7BJN+G30n9W
 0+Cj7Znh0c8/KphD+WZx3ZLYdXjtaWUx5Nnf11/e0G4dRWM9OaoSnXI7H01hJ7sE6ipDY0O3v00
 60i7yYyY6540w5KgTZq3/SBsBoUiGU0=
X-Proofpoint-GUID: mwuC4hyqHQwk0aAf7W2bFe5mhUQb5nVt
X-Authority-Analysis: v=2.4 cv=SK7Xx+vH c=1 sm=1 tr=0 ts=6adbe68f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=vs3G8eokVA2NTI78HyUA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: mwuC4hyqHQwk0aAf7W2bFe5mhUQb5nVt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MCBTYWx0ZWRfXxxB8QwKYg7Tf
 W+gY2sp0FDG+mCAE+EenbWOXgwDDqa1fXkvYYRTjTEPaQbGDOrX9qRAxFDZruIwnEhnH1g32QVl
 1LVp4T5JpJDEB8HcALm86x2GtE8aUvtNRmRdQMQM8ZAPIxk5cRy4rc45zR8XHpYQ6+Ea3Q7idrj
 an8Mkz5WyNO8xGDFx+bFqHmREmc8XflmNfCFQsRaZC7ashWSYYv9nG1isyOCXY3gZl8QmRAxp22
 lP76wowKhI4UkNqu4Mg5daaOBsRHiBROiVofBCEY1giTZzB8TTXKZv2X7r+umPM7/Gt8rqdO+zC
 egq/C1vIeoseEstfCC8RGa9uBIwWE4xYD63aqgv7XEvsjleEVhwWySYPUi6oG1isdsM05hk5QUA
 shVhVD30YpeTIZH84nRs1jYJ4E+GECP7BjJ/kTjEM6nDl+PRzeONpLvpfmqU0Ozg63qxIc3dsc5
 Dm5MLIg29oxIHS7bCXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230090
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QWRkIHN1cHBvcnQgZm9yIHNvbWUgbWlzc2luZyBIVlggSUVFRSBmcCBpbnN0cnVjdGlvbnMuCgpC
cmlhbiBDYWluICg0KToKICB0YXJnZXQvaGV4YWdvbjogYWRkIHY3OSBIVlggdmN2dDIgaW5zdHJ1
Y3Rpb25zCiAgdGFyZ2V0L2hleGFnb246IGFkZCB2NzkgSFZYIEZQOCBpbnN0cnVjdGlvbnMKICB0
YXJnZXQvaGV4YWdvbjogYWRkIHY4MSBIVlggRlA4IGFuZCBxZjE2IGNvbnZlcnNpb25zCiAgdGVz
dHMvdGNnL2hleGFnb246IHRlc3RzIGZvciB2ezc5LDgxfSBIVlggdmN2dDIsZnA4LHFmMTYKCiB0
YXJnZXQvaGV4YWdvbi9tbXZlYy9odnhfaWVlZV9mcC5oICAgICAgICAgICB8ICAzNSArKwogdGFy
Z2V0L2hleGFnb24vbW12ZWMvbWFjcm9zLmggICAgICAgICAgICAgICAgfCAgMjAgKwogdGFyZ2V0
L2hleGFnb24vbW12ZWMvbW12ZWMuaCAgICAgICAgICAgICAgICAgfCAgIDEgKwogdGFyZ2V0L2hl
eGFnb24vYXR0cmlic19kZWYuaC5pbmMgICAgICAgICAgICAgfCAgIDEgKwogdGFyZ2V0L2hleGFn
b24vcmVnX2ZpZWxkc19kZWYuaC5pbmMgICAgICAgICAgfCAgIDEgKwogdGFyZ2V0L2hleGFnb24v
Z2VucHRyLmMgICAgICAgICAgICAgICAgICAgICAgfCAgIDcgKy0KIHRhcmdldC9oZXhhZ29uL21t
dmVjL2h2eF9pZWVlX2ZwLmMgICAgICAgICAgIHwgMTU2ICsrKysrKwogdGVzdHMvdGNnL2hleGFn
b24vY2hlY2tfcmV2X2dhdGluZy5jICAgICAgICAgfCAgMzAgKysKIHRlc3RzL3RjZy9oZXhhZ29u
L2ZwX2h2eF92NzkuYyAgICAgICAgICAgICAgIHwgNDc4ICsrKysrKysrKysrKysrKysrKysKIHRl
c3RzL3RjZy9oZXhhZ29uL3FmbG9hdF92ODEuYyAgICAgICAgICAgICAgIHwgMTIxICsrKysrCiB0
YXJnZXQvaGV4YWdvbi90YWdfcmV2X2luZm8uYy5pbmMgICAgICAgICAgICB8ICAxOCArCiB0YXJn
ZXQvaGV4YWdvbi9pbXBvcnRlZC9tbXZlYy9lbmNvZGVfZXh0LmRlZiB8ICAxOCArCiB0YXJnZXQv
aGV4YWdvbi9pbXBvcnRlZC9tbXZlYy9leHQuaWRlZiAgICAgICB8IDExNyArKysrKwogdGVzdHMv
dGNnL2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgfCAgIDIgKwogMTQgZmlsZXMg
Y2hhbmdlZCwgMTAwNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCiBjcmVhdGUgbW9kZSAx
MDA2NDQgdGVzdHMvdGNnL2hleGFnb24vZnBfaHZ4X3Y3OS5jCgotLSAKMi4zNC4xCgo=

