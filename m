Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF68C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIK-0004Fc-LM; Mon, 29 Jun 2026 09:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHv-0003t8-6u
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHt-0006OL-Oj
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:38 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT6uD2618925
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rn3nrXF+9M3gB0m5jL2ztn1CUMGQuvNbgLv/5EwohVs=; b=ct4y/TyNxTLOBRLY
 uqc4i4N98Md5TpHmxZIqk5mMLGwFNRj3Pio39Otq9SFlMj7XI9zECNo5aY3P9mzS
 DxikxR2CzOPYCYDSFeWPonSIkju3csErqSlGlUlmq3aelWqWLh5EMygaBJenCQrk
 Vn+rGRe0b0A9AH/iXfNuzyg2bdSDbNVJZmhhVEdZ0JHUYdmsWpzX+vfy2spYrrrP
 E57Q9MrfmuM9Rn8kw4wn14oY52jR7Tuw380Q1OgkRZmpK/Z8jkVVP64YHRLtfTzh
 qBm9GXtjt3mOfwnaBt8BupZnZs5hfNOSOlzK4xPoAoM0udAOBe8Pa43jo1UnEwNw
 q9oRGg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3pdkrv4n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c9b71388fbso28500525ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740676; x=1783345476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rn3nrXF+9M3gB0m5jL2ztn1CUMGQuvNbgLv/5EwohVs=;
 b=kmS1r4Ye5hiVcytA6T8mMGfB/CmxKkZxj/qgKJwijJGBUfyKGdO9PsOzxKbzPIqfZd
 AShVX3uzZ/QnjN0LfulIvD+OeRF8YHcb8LZBVc0ugmZGeyJcXmmelEfIHWVC7+GnlO1T
 wfMiuj5iFRkXttuTUfz0ezgsRymARKlvMuMZXzjbPPOHBUWz1RnTHZeDFROFA8eILd4u
 /ff+fSjr+GAl48RY73JkP2tnTM0jd5O5Y2cQRRztg1VBp2KPkhnv/bzJkkCoxaBT+UIM
 qw7T7QpZqqfcpe885VwdN0VeegvAq09HIAqr29t3rzRe0U7gFXeRIUH/B66XBUO++5zT
 q0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740676; x=1783345476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rn3nrXF+9M3gB0m5jL2ztn1CUMGQuvNbgLv/5EwohVs=;
 b=mdc2dH/yOckEN4w+nPrwFxrdR3opSAHuwWU0LCh8UF97eM31DL68l7kl2DZS91FkU6
 XfwCWK9hgUkhdgK83H6O9KyXHA0mEWrpfCpKWLFMWpYNSrAsebPny7z1L9fVPEuhd/U2
 qbdHQch9aUdWI4HQt93Nh9YJdfZqkduy8bjWcTaFdfcBRlDXYU9TqDbP3+2s2NTcHMXq
 LuLNZhwigm/EqlDCRpeze6XvMVzyq5DO1HEFk8WuVBXy9ZYzXXIHpsmQnMQx6NMqPFGz
 hdfHm+rxKkaizXupyCQvupzGaZ3qNjWwYTKf6pFgFIvNXQIoEfvCuwBxuGFTHXc0+Tce
 mfww==
X-Gm-Message-State: AOJu0Yx00YJ/EWB1O6Qjjumz1/O7UK8cHSe7jLYTN8Z1xdsGoZ8Bcebw
 SnBRShELofVsQNtAIqhXu0IvHNLNZawt1MspPTVOTbFl4TlgxF8fMxNvdlIYlGejW2iz4ujO0FJ
 tzth3pgls/pT7JLtkDvybjiI+l/kqYySpwFtI9cIktQxfODgSOLIs18LLEVn7vqin4g==
X-Gm-Gg: AfdE7ckrYgRFjjViUoQZ49Ud0HA1jvukFylL300ZeH+qxoxVpXdeJhbJgfNLPp9up7C
 tHr2LPWMmXvVMqsMhBo/xnxGUAXwvKAVvogJou++HGkwQAGj6iWdJZKKzYy15Ww4mkY/+0t8pP6
 BB9fkfl35HJzDXGmTEJKfjsaOAO3J3uGAvofjkHToW6+xJS2YUj4N0NZF2KCNbOp5CQnbL1+4NW
 u6XjjZDmxdo4PWkd5yqSjABEoqnS/OkGJMM2ZvAddEL2Sb1+HShxRjn066NhNyRsTVdqa1ETtmP
 NoV4LKxfsPqn9ODqjTpiL7Anl2bynNlHxcuIzDNMOOoCrSLX3ixy2VSCKb2anN8iTPwpMYsLCX6
 pqH97OyPTjvTWOZZQ2lRCZX7mW7ZTKotkwbj0ar7uFvU88peXDah8hMY+4Q8=
X-Received: by 2002:a17:902:ccc9:b0:2c0:e5ee:f554 with SMTP id
 d9443c01a7336-2ca25dbd290mr3924585ad.8.1782740675726; 
 Mon, 29 Jun 2026 06:44:35 -0700 (PDT)
X-Received: by 2002:a17:902:ccc9:b0:2c0:e5ee:f554 with SMTP id
 d9443c01a7336-2ca25dbd290mr3923905ad.8.1782740674546; 
 Mon, 29 Jun 2026 06:44:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:44:32 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Sid Manning <sidneym@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 74/77] hw/hexagon: Add support for cfgbase
Date: Mon, 29 Jun 2026 06:12:29 -0700
Message-Id: <20260629131232.2487780-75-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a4276c4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=7umkzkyUMl8fFcUskJ4A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: QVzJwHeejCkjrlzcaM8o2Op1p1kLWxBO
X-Proofpoint-ORIG-GUID: QVzJwHeejCkjrlzcaM8o2Op1p1kLWxBO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfXw8mKrjZot445
 XzqU+BVhR9+f6guYiPqYw7Mvdt37/ZEVOhkfMTtYMXtPBhaGIB1Xd18tMWSJL78dk6BpIqJHPeD
 M3CyaARYVREYGDcjlMmGDcI97E19/Pf2nDfi/e18nHRMDH/OTOq1jqSHC8PuVm50BgXCszCZe3D
 BIrBhxYaBV4rcr4Gm/54vrb8STquFJX9CvF+jdqOYE+Xanw5yaNTSyM/MKFsT0eXGOPO2Bmmds3
 V9WcYtMdf90XgzlOdeJVjAQlj+p0yK/GJPpsi6qY4IjZY1cnE3vtCnqAGY19wQnyuJKueqrJFot
 +61aoF6f76kK5BHp3juszIqeDVmO2mK370/V1V2rWFEmjckr0uqPzDaDw59qjoNda8hpApy3Fgq
 Vz0aUbe0ChAqq8ZJYqCuEFznJRi6MUtD7/9K+j6FxA0ASJG2y/1bHymtGCp1QXl/CuBAOYPwNde
 XCJcg/BtkUMn3d+wD9Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX00lidcX8fJh7
 J3+KWFL3oXLTENR3DVG3OOCwyn4Oqku0nOjBo4NI/DWDXyDWVnsLyYj0Vq/g5FB737LcXyRqDvS
 dqfmROdHZtjB4bDCZfcECh7AD+iiZrw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
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

RnJvbTogU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5
bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogU2lk
IE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4g
PGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL2hleGFnb25fZHNw
LmMgfCA0ICsrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICB8IDEgLQogMiBmaWxlcyBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9ody9oZXhh
Z29uL2hleGFnb25fZHNwLmMgYi9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMKaW5kZXggYWMwMWQz
NTk5MjguLmFhNDkzOTkzMjI5IDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMK
KysrIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jCkBAIC0xNjIsNiArMTYyLDEwIEBAIHN0YXRp
YyB2b2lkIGhleGFnb25fY29tbW9uX2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lLCBSZXZfdCBy
ZXYsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1QodGxiX2RldiksICZl
cnJvcl9mYXRhbCk7CiAgICAgICAgIHFkZXZfcmVhbGl6ZV9hbmRfdW5yZWYoREVWSUNFKGNwdSks
IE5VTEwsICZlcnJvcl9mYXRhbCk7CiAgICAgfQorCisgICAgcm9tX2FkZF9ibG9iX2ZpeGVkX2Fz
KCJjb25maWdfdGFibGUucm9tIiwgJm1fY2ZnLT5jZmd0YWJsZSwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2l6ZW9mKG1fY2ZnLT5jZmd0YWJsZSksIG1fY2ZnLT5jZmdiYXNlLAorICAgICAg
ICAgICAgICAgICAgICAgICAgICAmYWRkcmVzc19zcGFjZV9tZW1vcnkpOwogfQogCiBzdGF0aWMg
dm9pZCBpbml0X21jKE1hY2hpbmVDbGFzcyAqbWMpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IDA2YmU1YzhkNDk4Li40MmQ5M2U1
ZGE0NyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFn
b24vY3B1LmMKQEAgLTQwMCw3ICs0MDAsNiBAQCB2b2lkIGhleGFnb25fY3B1X3NvZnRfcmVzZXQo
Q1BVSGV4YWdvblN0YXRlICplbnYpCiB9CiAjZW5kaWYKIAotCiBzdGF0aWMgdm9pZCBoZXhhZ29u
X2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkKIHsKICAgICBDUFVT
dGF0ZSAqY3MgPSBDUFUob2JqKTsKLS0gCjIuMzQuMQoK

