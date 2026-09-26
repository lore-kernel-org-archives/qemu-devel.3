Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFC1C9832A
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 19:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAY02-0001Kl-4L; Sat, 26 Sep 2026 15:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAXzw-0001Ji-06
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 15:23:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAXzu-0005rH-6U
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 15:23:47 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxRCA1449995
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 19:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kFySTYUfKsCPbenlOAgs2Ktg2ZtG+ZXH7tI1Nzpi/MQ=; b=BS1gQvbxc4mpsmXf
 +N7SlouHnYD96xgYZNU/c5/Wjr2K3RROeYJBDA3pd3DupZUp1NZSPPSeIO7nLP+5
 vtOio1N2Wjpmk1OCLs44wydlMwHZ40Fe83pXCtNd2RHlm7VUdsyf0BhKIo5Uw8gs
 bXBhgs5Ml9Fy/eKWOoHwmAheXjhF01Yp86ERCr5UDo9Dg1y/QS9ytDuJV/AFZ70f
 JhZi3chZ7sGQEFzDrGZ/YvqNtZMONEI4af/lSHqlLX0ESfbUgQQJO5zI35sCWGQ6
 Gzv/rkRdGafiQMctu4WuDCRaCMxXsudofXuIAzA+U99YzekdZyTxs/ZF64dFcxRY
 utwiCQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3rfsws0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 19:23:42 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso3213424eec.0
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 12:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790450622; x=1791055422; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kFySTYUfKsCPbenlOAgs2Ktg2ZtG+ZXH7tI1Nzpi/MQ=;
 b=KJay2OJHbg70RCKx42JsyCidIwFi9rqN9yXRqAhsnd4kizlFlWy71dFaJ/vvcPUVgM
 jmkQB/UiihCKJfwgzNNjf6mAGbQuptPajjSWPjK228utE68xyVdTqOkEiVx45jHV19FL
 yr7RGldVZbBoaZAwiij96w7upeZoHNfFHj/muY8vpu8dpufZr/F477Sua6nfzSSmRsrL
 FTniDDvxM1H8cHkocomzVGMl2FltmDkWLcW/FWejJ3VaTfBLosihf6WpfOJj11ZkS0DY
 CCKxy9qDqRNOp5V29M9BrwBDwF1noE95UTQRmHMIvnwkYaF4+621bmRzvEc3CAfrII+x
 zNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790450622; x=1791055422;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kFySTYUfKsCPbenlOAgs2Ktg2ZtG+ZXH7tI1Nzpi/MQ=;
 b=R4UKg9i9TqmbYUv2AQ3MSRJxnqarazrIF0zhzQZN0PbNFu8etDcyu8zZznc1IG2HOS
 s7hDC+CLyyt3RDCFh0x2Rp5AbjU+q89bL8Xt5osCjLMAV/7eUGONzJqbPc1AFPfsciUG
 alijPMFV2/+tFMIU8EIUHFaar1O2RSCJl7wqn0vhMI2M6evJ+JAgT1QpMlpOAY0lBRF0
 ae4zimiUpkvKStzeaxrwO6Rp9+QAq/vFz2bILW2VfGRDxRmreEvbZu/M6BF/6sxvBO7G
 WiicBZxUTYzQ4KUEvPOLXhuG0x2XZdDo1M1Ie/zulQ3DfeKdf3azRubqIMx+vjYh+Z0V
 TylQ==
X-Gm-Message-State: AFuF++kjfC6CVw6Y2vOEHMxKQzkDzNlzJnZyQfujFa8l6yiqgTPmwk91
 zGsuNCbW8t69z4XcEl8yXo+jXHx1PyUJn0EADZDQYCryBgW7j/R1q3/LrMoKGxwIK1RRlBZmO5K
 zSed2v7Z8AjdFA4QGfknbMqULrrthtEToQiDTKpUdwyBoyCNxjjFupQeW316PzICppA==
X-Gm-Gg: AYBFou3XejLWCk3d81t+xJeVKRJF5+vD+ZouUDB5UzfjItCMOZFCwkRHUQgDnzf05/G
 EhCMPEyfBl494Nq2gmz7NdnyiS5yT6uFVsF+Bca8hHXNGCah30dUfGVyeOkDjVMcz8KcmKvf3Ty
 wrdwND0yWT8MuXwhwhRBHoxzl5YdTKqiB2Sp06Ax45RKv/K7exFF5Nq0+50FLvsNR4r3jG5bHLE
 ysttcOJd9SpKM8ucCCQpQyGx/L37Ph6ZnUBaQIAVAWkrX3im1PxXYPeMvfanS57BPmuysAzc0rE
 n/RG42W+caai30xvfOHm/sN92gQvVGN6mTYH94bvYSUkUwdUozaTb9K0WsGV5ZcSlGk9Zl7C87S
 dIc2PhiZgQNIg9m7FghLp3YE+RgPzqj8IdzTloItfAaIxdiU=
X-Received: by 2002:a05:7022:7f19:b0:147:cd15:3e2 with SMTP id
 a92af1059eb24-147cd150a91mr1842376c88.4.1790450621657; 
 Sat, 26 Sep 2026 12:23:41 -0700 (PDT)
X-Received: by 2002:a05:7022:7f19:b0:147:cd15:3e2 with SMTP id
 a92af1059eb24-147cd150a91mr1842352c88.4.1790450621101; 
 Sat, 26 Sep 2026 12:23:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145aa0cb6b9sm13526271c88.1.2026.09.26.12.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 12:23:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org, marco.liebel@oss.qualcomm.com,
 Taylor Simpson <ltaylorsimpson@gmail.com>
Subject: [PATCH 01/10] target/hexagon: Allow temporary HVX write and future
 write
Date: Sat, 26 Sep 2026 12:23:29 -0700
Message-Id: <20260926192338.2702952-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3NyBTYWx0ZWRfX/rgOgTNMRis+
 fvS7fabbWnDLzgOxigmiZf7QGrbiDriRNoOoZx5sdFWWwibEZPiTIus0Veo0D8LCUYVYTR2362k
 GRUhg3WLOEi8N7BXh1vlaWTHz5ISaUo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3NyBTYWx0ZWRfX+Ga4sQ9EfpEo
 WmP/gOnplG78Do5axzmXjBhWRo6tqUB8jQOZkrmtn2uQtVLloqfAZU66hE98XFI63TXgU/LLxXH
 3gR9RPQNcFgR2vj2MSLeUy4wFL9SagCint6cminQP5LBnMrYM+DmI5LOr6OkbbhybomQhDIUsbv
 8qXr8nbE5qCSFIMbgeSvmmgtgH75/U2R8s8d71s17AsvcBr1wBJ8ydj/NaUHTo8V7wmS8zWz2fL
 8Q7yoAH+HVV1X+ABcGg2ZzO8Olp0Pay6qtebAVGsHBZWkT6GHGpbOJib3zjQHZbG+YjOOEuZYfw
 IRuhcWmOE/UylOKKfKQScJF7D0ddNq7YSdMXTUg6BLUMNW0oSegJdA0KQbzTJ8pZZQ2u1HvgTXV
 w78NHABsPGU9VQcnrOgVjgsz9W38eWYSgtQlE1DV0bC+yGxirtVh7Qis2O9v1pwuJdc+lvGEwWH
 9RQcsHSJEPkAjtjy8SQ==
X-Proofpoint-GUID: M3dQPwUDbQ1xaz_RGZAJRp0hAFlx99dL
X-Proofpoint-ORIG-GUID: M3dQPwUDbQ1xaz_RGZAJRp0hAFlx99dL
X-Authority-Analysis: v=2.4 cv=K6G3jCWI c=1 sm=1 tr=0 ts=6ab81bbe cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=I82WhRWopznsc1ms7nkA:9 a=QEXdDO2ut3YA:10
 a=LvpTVT36VLQA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260077
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

SFZYIHBhY2tldHMgd2l0aCBWeC50bXAvVnggcmVnIHdyaXRlcyB3ZXJlIGluY29ycmVjdGx5IHJl
amVjdGVkLgoKQ2M6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCB8IDEzICsrKysrKy0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vdHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAppbmRl
eCBlMTcyNjE3NjFiMi4uN2JjNjIwN2EwOGMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC0yMzcsMTIgKzIz
NywxMyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY3R4X2xvZ192cmVnX3dyaXRlKERpc2FzQ29udGV4
dCAqY3R4LAogICAgICAgICAgICAgY3R4LT5oYXNfaHZ4X292ZXJsYXAgPSB0cnVlOwogICAgICAg
ICB9CiAgICAgfQotICAgIGlmICghdGVzdF9iaXQocm51bSwgY3R4LT52cmVnc193cml0dGVuKSkg
ewotICAgICAgICBzZXRfYml0KHJudW0sIGN0eC0+dnJlZ3Nfd3JpdHRlbik7Ci0gICAgfSBlbHNl
IHsKLSAgICAgICAgc2V0X2JpdChybnVtLCBjdHgtPnZyZWdzX211bHRpX3dyaXRlKTsKLSAgICB9
CisKICAgICBpZiAodHlwZSAhPSBFWFRfVE1QKSB7CisgICAgICAgIGlmICghdGVzdF9iaXQocm51
bSwgY3R4LT52cmVnc193cml0dGVuKSkgeworICAgICAgICAgICAgc2V0X2JpdChybnVtLCBjdHgt
PnZyZWdzX3dyaXR0ZW4pOworICAgICAgICB9IGVsc2UgeworICAgICAgICAgICAgc2V0X2JpdChy
bnVtLCBjdHgtPnZyZWdzX211bHRpX3dyaXRlKTsKKyAgICAgICAgfQogICAgICAgICBpZiAoIXRl
c3RfYml0KHJudW0sIGN0eC0+dnJlZ3NfdXBkYXRlZCkpIHsKICAgICAgICAgICAgIGN0eC0+dnJl
Z19sb2dbY3R4LT52cmVnX2xvZ19pZHhdID0gcm51bTsKICAgICAgICAgICAgIGN0eC0+dnJlZ19s
b2dfaWR4Kys7CkBAIC0yNjMsOCArMjY0LDYgQEAgc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2df
dnJlZ193cml0ZShEaXNhc0NvbnRleHQgKmN0eCwKICAgICAgICAgc2V0X2JpdChybnVtLCBjdHgt
PnZyZWdzX3VwZGF0ZWRfdG1wKTsKICAgICAgICAgaWYgKGlzX3ByZWRpY2F0ZWQpIHsKICAgICAg
ICAgICAgIHNldF9iaXQocm51bSwgY3R4LT5wcmVkaWNhdGVkX3RtcF92cmVncyk7Ci0gICAgICAg
IH0gZWxzZSB7Ci0gICAgICAgICAgICBzZXRfYml0KHJudW0sIGN0eC0+dnJlZ3NfdW5jb25kKTsK
ICAgICAgICAgfQogICAgIH0KIH0KLS0gCjIuMzQuMQoK

