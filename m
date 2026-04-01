Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A9310F6FD6
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xUd-00010F-7v; Wed, 01 Apr 2026 11:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUU-0000q2-5t
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUS-00086E-RI
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:21 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631EInXI390125
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6ZZDuz6n4mV1vg7UyXtzywWZTFyf36zcYE/3mP+wDMo=; b=Qr89xrpMLTrKjjxF
 2R+wYDAumNX8I7Ec/W34wRNT9/BhhkXC4Tpp2RSKIs3+U/+hOpNUm4BHXU/xIXWD
 MkN2DYC+aEsJzbCq0Ldfij4R8Bphtmw0JVxjc2da8oHgn6SaU/BKM4t047qHGRjh
 PF84v7XtNFM4w3h23hEb1h+Pvbdm8o9ZxWn+R9XZzM3bGgvGQjnFEGijXwINpiYK
 MtJNZoiK8cEh7wDzgVTzHN8ZtGWEo0rDTERj3gWiUtdyy3zpGguVnGUILtRs9kJ3
 X7+rjvFqLKl1FNsEIWVfPtAppsBaVDWn0hN7bIVCsWdMfwnP2g4nmP5I7SuEWReq
 jDaLPQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d95118cm9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2c16233ee11so8130535eec.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057298; x=1775662098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ZZDuz6n4mV1vg7UyXtzywWZTFyf36zcYE/3mP+wDMo=;
 b=gW3+YaBZhFsPA8QTa+ostGjoB3YiRXqzbWs2SPaBzDew1qCc8Mi8eekyw7BOTdJmgS
 plkHXITAmhl99FLyEZtAmkYS+3mtPFcSOPh+B0ACsbL+ceyOBEKOP9AuVus+AlszXjHO
 bGbH1MsQrzueDYN+n53hOt9TccaoQGMLaXJ4muC7AQtVzWWoqC4Niio2sN47aeTi9D9U
 enoBzuVZgtJAB+2HFUZfJd1q7NeBTGP5JVP7722le+FYlYChjfabXrbmvN87ebKYMJbx
 qx0XGlftqddQ+LO3ZCqT2Crhn2h5osOy9MSKfU9lo2CZrdW/wBSdcdonoSH3a6xBQwrh
 u54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057298; x=1775662098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6ZZDuz6n4mV1vg7UyXtzywWZTFyf36zcYE/3mP+wDMo=;
 b=ogsXpD9wCO2NxldeT3/JPH14ATtqB7pgw7wi1hST4dzPOWSlpZLxVmTCeBowRSjbmw
 +Yaxb62BMvY+DdL5niL4b2LijNImtyo1xipxHi+YlNh/gW/XrJ56TBf85jp/GP2+HSm8
 L6qj5Wfmkbwnohe5t2ioUgVAqoHEi8hiowah9a6xFBWY3JjzVp83RXyH0p7MNCoy6fvP
 U5dCcjXCufN9AxFJcur9UD7+juwQq47dP9bCGp9dhLtlkhOezyf7+a73YApSOR6CLAzu
 ObjyRcAt+GGQLedVOhLt2N4UUDG92G6a8mO2PgQ+qHA6GWt3N9pqgqXKoV31c5fUeSF8
 usaQ==
X-Gm-Message-State: AOJu0YyxQ3QbVzbQBg3tS8R6QKUoCYUyY0YrDtQN9Qc4U062BgCSsHms
 lAFNv7OwrcdK2RR9mjgZRoNL3/BM0VF/8Gnfdma5v9GaEmFXJR4wscIFwZTupULqBK0QmgqcS+Y
 cdkkSRqvMZ5+sMvw1k8OIy5j/1RsJNB43MWwVlWSGiNS/BtwF5kaljzbELVieUyCfuQ==
X-Gm-Gg: ATEYQzx7w5tA/szjJEJGHaPtvq7rsMudqWni0YvD4QfjcTeVp0+yJBPB/5yd0DQRfAb
 DIAJ6zolY815qEo2hsdJEc1nx4KofRoaVMjEzaA6U8V22Id3BN454LJ8gj+z890hfO5ihEfR9Ri
 sJfIUVa6tZzBGaSmVyM3X01WqBNGTnKS6+n102JnfSYmJ3xLz3ul2V7LbwdgpYVx8s0jJnx4l0G
 xCmHoFjfKi7Ia4IzopAVIiF12LG81CzkPCzLY7iVQc8RbcvLVKPoKCrTpH9CLSsd8O5k9CCBwJj
 R8B+yQwe7G69e8/jBSB0KuJEGdhteOcdxeqqUNkepa3qQul96ZEDaBsy9dQ76c9Bm0ebfxggQQ9
 93+sbBe1FAvV58FHBo2pxZuYpC/YKghuAZxWt8dNl1Jo+H7nSu+Ijc8yNtVwY3PkzddE1hw==
X-Received: by 2002:a05:7300:ed18:b0:2c5:b23e:48ab with SMTP id
 5a478bee46e88-2c9321b76b5mr2162144eec.21.1775057298283; 
 Wed, 01 Apr 2026 08:28:18 -0700 (PDT)
X-Received: by 2002:a05:7300:ed18:b0:2c5:b23e:48ab with SMTP id
 5a478bee46e88-2c9321b76b5mr2162113eec.21.1775057297690; 
 Wed, 01 Apr 2026 08:28:17 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:28:17 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 36/37] target/hexagon: Define f{S,G}ET_FIELD macros
Date: Wed,  1 Apr 2026 08:26:56 -0700
Message-Id: <20260401152657.314902-37-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfX4GrQdC2VuvrL
 uQeZ6sYJdTLYjD+SrkdZV8sv0O0vr4Pz1HyUGbUSGzaHr7nGnzDAs68SI/W4qGU5SF/vkcaAqCg
 EeevdXlWQtGgjmeBvuf6XlAP4oGO51bg/izrIQx80Cdja7NQp4KSGS3aUM6PQo0+0YU52OC3ZOi
 UERxiCuf3yIduCxypqmaAvd6/U3zefnQbRNXBg+lHLij9e5o24HlERYBSUZOO+caSaV2FBAVwOe
 oDWii/4i7YRC1dt5yieeb3OAItEC+GtqSfBkAb3YeeUmoj/4P4levtHwL8Cb7XId0IficXHdkX/
 YWsRPt3WfMFgR6BrC/FaKnMc0FuNHZjFTGufOylfcuP9qipS9kd5Ea7Q72xNMCyplL1rtkmRHUi
 cZgvaHyaKv3GK5/pMzLMEXK/anF+NkJah16hTJtKLVO7uzgypGFH8f/4kCgQSppkaNO9QjbOgJZ
 WxG1H9OiI7PN9vgEPyg==
X-Proofpoint-GUID: SQ-NGRFfNLubvkVUXPSJYoX-3VRcFg80
X-Proofpoint-ORIG-GUID: SQ-NGRFfNLubvkVUXPSJYoX-3VRcFg80
X-Authority-Analysis: v=2.4 cv=F8pat6hN c=1 sm=1 tr=0 ts=69cd3993 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OC-ZKJ6AczBSh3OnBRYA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oIHwgMTAgKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oCmluZGV4IGU0YmZlYTQ5MjNmLi4yNmQzZjdkOGE0YiAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vbWFjcm9zLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgKQEAgLTY1Myw2
ICs2NTMsMTYgQEAgc3RhdGljIGlubGluZSBUQ0d2IGdlbl9yZWFkX2lyZWcoVENHdiByZXN1bHQs
IFRDR3YgdmFsLCBpbnQgc2hpZnQpCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9b
RklFTERdLndpZHRoLCBcCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERd
Lm9mZnNldCkKIAorI2RlZmluZSBmR0VUX0ZJRUxEKFZBTCwgRklFTEQpIFwKKyAgICBmRVhUUkFD
VFVfQklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0u
d2lkdGgsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0ub2Zmc2V0
KQorI2RlZmluZSBmU0VUX0ZJRUxEKFZBTCwgRklFTEQsIE5FV1ZBTCkgXAorICAgIGZJTlNFUlRf
QklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERdLndpZHRo
LCBcCisgICAgICAgICAgICAgICAgIHJlZ19maWVsZF9pbmZvW0ZJRUxEXS5vZmZzZXQsIFwKKyAg
ICAgICAgICAgICAgICAgKE5FV1ZBTCkpCisKICNpZmRlZiBRRU1VX0dFTkVSQVRFCiAjZGVmaW5l
IGZEQ1pFUk9BKFJFRykgXAogICAgIGRvIHsgXAotLSAKMi4zNC4xCgo=

