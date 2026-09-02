Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC3BC61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1cp0-0000m1-KA; Wed, 02 Sep 2026 00:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coz-0000kS-5F
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1cox-0000R3-Dd
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:36 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6824NWK22468868
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=x9QPyjjIHqOYjku0pp/AtcdU6VC0bKnTGUQZkq/9rU8=; b=Ik
 mqQUDror/pASZGfcORNFW4zgGOE2CqeAkQt/jsOm0gplEG+dKK2s5/gCBDxibV50
 r+rmcAPtViweGV2v17gx70wtxouEhEI4qhoezDtqC4/o9W4ujYm7CmRunxpthDVM
 jjeRhxanf/Uac3jMMJnM9tEp4cmSlHPglwoAEp25DaXR2J+uYb7IZ4/G4reno4wv
 is4eCQ9uA0QUiSOnQ9g48i4zrx/Q1BjHmkaRxp9dNlGsfPBBCD2/2oYQKY8zEDbg
 gJ6N6YJv1jLiD+F0sxGcyf5hIexnEak9hymOLmUvc/bZMyEac3WIVppcA8vn0GfU
 HhlVC1zCTK+kMM8cNnfw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge39cj39v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:43:24 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so1530845a91.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324203; x=1788929003; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=x9QPyjjIHqOYjku0pp/AtcdU6VC0bKnTGUQZkq/9rU8=;
 b=ic6ULnYPbel/6KpT9sAWcIJHCAUiIcDs+FzPN72bJwvQBBQRHtXbBsW+TFpY6PtTLd
 XoFNVpnTczRmpbJd+CWCgVYsem73s/atWXSFbQWrE/0M04/+lau3mh+bQXlHCrfWlveo
 499CriPUPATp+/9TKIjx9UjsJjtDeHeR/XCOdXKOBOYYlYH1S+uf099CRCYU1EBCQiDD
 g6GpWY3N6t1mHtaIEFj97iyCyU6Kwmf0VJLpQxhVhZi1PYW9OTmyCFhZorBj184Gf9hl
 JSwqDmmlERn8E9U6mcmu5BGNjzqNcE69SIcmUZtmcITezApf1jjMVzp+vA5RyVXTu4AB
 ZQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324203; x=1788929003;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x9QPyjjIHqOYjku0pp/AtcdU6VC0bKnTGUQZkq/9rU8=;
 b=cYAejJZQ8LSjKF2ZE1S2yuxzNwUG4zOrqEBWm4uOOs4/Hf6R5P1EZaPjLMWBu5c0x2
 Jno0N2gmwVSlPyDLhwBiHaB4PZipZJayY4+JpsyMb48WjDcYogPYOUs/M7SFVmZE5Bw8
 D223jW0iHHQUMKsrPS9YonO6MchV3/wxjuaxGP8LpgnyARM45lKFFy3GyoiulMITaX1E
 yu/AK3q522Jd8nLqwgwHCDcTq9+6ptOEMdNdsEP7zqpPN6NdplURZU2tcyFGztnuWYuG
 K0OnqtFYFYgUNVjWZd0ptK+3MfCmSWhpueyLxp4O6vIrwxBCr9Hs+IXo5vYE5Euz8Kw8
 OJrA==
X-Gm-Message-State: AFuF++lU5rSfeq09Oq3xIGuCopM6NNRT7Dq9b0jttmHPWBPU//aB28Z7
 5uGyxq/hTmRYJpp9/4n2y/4spBIt6TKTAEbgSLA0hjx+gurhqzcxciuIlSomGhMBjPsp0HbwgWm
 1b/iyFM6Hzk/z8WWchDu49UJC1jO4l7vc/nddo2K8odOCFcVQYIdMdXw8416YjXtVpg==
X-Gm-Gg: AYBFou1M+blcySxgynolsIu/XSHXbVZ1oUMAV+B0tQ5CwWORHplCZFuemIl+g8hGnEF
 JkWdkKf3extwxNKL7LCn0tqHU4odO0I0UMNVikX+hCk97h/dPXZlaDx3LCUsiR3bxrvg9+uLwex
 KSOedSHg7MA9ytCn88fevOIt2m1Y7z5fFzYUF2FywUJRljEemabBNzYN3MFKakl2WNcfuuPyZVz
 s0Nh9rCuKsiTGIsRWQ6sn/5GAA9/l90b+Rp77q2thNYTgYbdNTYx5fuHfx7vCJxahFa+LduMkSA
 p+ui4B0phzwvR0jxY67IVLjGfXCXRpiKmWuJyoz2TBjhxRh/17Y6UFajDdKcHWnT4UFypqXwPi2
 vviwSdU9NNS552AUIzF0M0xjr1ZMVW/GB9inZ4FD05/Jlw0z3
X-Received: by 2002:a17:90b:2cc8:b0:396:6344:3b63 with SMTP id
 98e67ed59e1d1-39aedf8b4f9mr3366031a91.2.1788324203297; 
 Tue, 01 Sep 2026 21:43:23 -0700 (PDT)
X-Received: by 2002:a17:90b:2cc8:b0:396:6344:3b63 with SMTP id
 98e67ed59e1d1-39aedf8b4f9mr3365985a91.2.1788324202875; 
 Tue, 01 Sep 2026 21:43:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:43:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 27/28] hw/hexagon: assign a distinct htid to each DSP machine
 CPU
Date: Tue,  1 Sep 2026 21:42:30 -0700
Message-Id: <20260902044231.843004-28-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=T968ifKQ c=1 sm=1 tr=0 ts=6a97a96c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=2cblKrENZZ9LBr9VnxsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: rDhxiMZc3mzOpyTvwg_DVSVq7SFyrlBY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX23nCUBOqkaDX
 6ftD21ZSphAdXacj8CcFhwHR/zybCEq9f6qFX1RBkUgtytKt2kVLVm1cdZ7UhvOW5GFZfu4Ic02
 UNB+d7jPKbgioAoZJiMqQvR23r+ralU=
X-Proofpoint-GUID: rDhxiMZc3mzOpyTvwg_DVSVq7SFyrlBY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX6nwnKClnma2S
 Nuy/nVCnotl07t1UX3PY9nIZ2V3q8djWVoiNT9qNXPb6GHtJgKeJo0VxdqaixjrcTLSzPKG2ziK
 UwAHgoR5dsFdxJvy1kuSHNZoVoSJ6epGQuCJDGN3gEhsFg9nu5DtTYy7prfJzv9WIE6XPOW19/S
 Y0HSJBX0Xo1AiTEhzm1AMUyDu3b9Ub3ydusa2/adOULIPhVrz+KbzoYC59xLcWbQ86dXW0+LsU+
 hwn7YGXagUAOKOKd2zTBnxXNie7ETmwqo3jahWNhn1cs0PAwn57F8QwgwUpemP0KGBdrBmIHOJy
 lmaHZOuWp4hKoSSzV5IWV2V/7BeEkKa9uLsOx4LjVW/A+jaeVYVwbhRnxBrDMNcxz3FxCuJ4loM
 xzVx8igUWB/9rUdmeRslXMutqvwDw11EnwyNnFPVeKnUyDqpzcBo/oRt/jbypN4LgseE57He37u
 aLuleTln3egkXwyDFFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020040
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

VGhlIGh0aWQgcHJvcGVydHkgZGVmYXVsdHMgdG8gMCBhbmQgaGV4YWdvbl9kc3AuYyBuZXZlciBz
ZXQgaXQsIHNvIGV2ZXJ5CkNQVSBvbiB0aGUgRFNQIG1hY2hpbmVzIGNhbWUgdXAgYXMgaGFyZHdh
cmUgdGhyZWFkIDAuCgpUaGlzIGJ1ZyB3YXMgY2F1c2luZyBoMiB0ZXN0IGZhaWx1cmVzLgoKUmV2
aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAb3NzLnF1YWxjb21tLmNv
bT4KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1
YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tPgotLS0KIGh3L2hleGFnb24vaGV4YWdvbl9kc3AuYyB8IDIgKysKIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL2hleGFnb25f
ZHNwLmMgYi9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMKaW5kZXggMjE5ODQzNmE0NDAuLjViMmI2
ZTMxMmI2IDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMKKysrIGIvaHcvaGV4
YWdvbi9oZXhhZ29uX2RzcC5jCkBAIC0xMjUsNiArMTI1LDggQEAgc3RhdGljIHZvaWQgaGV4YWdv
bl9jb21tb25faW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUsIFJldl90IHJldiwKICAgICAgICAg
SGV4YWdvbkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUob2JqZWN0X25ldyhtYWNoaW5lLT5jcHVfdHlw
ZSkpOwogICAgICAgICBxZW11X3JlZ2lzdGVyX3Jlc2V0KGRvX2NwdV9yZXNldCwgY3B1KTsKIAor
ICAgICAgICBxZGV2X3Byb3Bfc2V0X3VpbnQzMihERVZJQ0UoY3B1KSwgImh0aWQiLCBpKTsKKwog
ICAgICAgICAvKgogICAgICAgICAgKiBDUFUgIzAgaXMgdGhlIG9ubHkgQ1BVIHJ1bm5pbmcgYXQg
Ym9vdCwgb3RoZXJzIG11c3QgYmUKICAgICAgICAgICogZXhwbGljaXRseSBlbmFibGVkIHZpYSBz
dGFydCBpbnN0cnVjdGlvbi4KLS0gCjIuMzQuMQoK

