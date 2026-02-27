Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C0CFEFB51
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4ak-0008El-3P; Fri, 27 Feb 2026 15:37:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4ac-00080X-97
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:35 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aY-0006uq-NG
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:33 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RH0GYR527234
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6ZZDuz6n4mV1vg7UyXtzywWZTFyf36zcYE/3mP+wDMo=; b=mFOOU7zktR9W8oPz
 JLdudF5quqpi9C47cJ/Ilw85jFWdtM9kMeKkyF8YqTPZIVdtV3VrH6+rIFAWzdvK
 ByLCj0QPFFx5b9bcNyA39ou5ho7Bm/hm2/i0FqfXuer5PjLZtSQ6mZ0S2e/x/mzi
 hs4QagzHak5fh1spzPZgK1nuHmFRpxayUoc+ftjPGShtQnwj36vaQ++VHVra7Hcj
 XvefTo71lri+kC2ZBTraIeDKZxPrsDIjWKAWh9ctm/rI1obdaZoengXrQnrZ34KN
 39dLqrvdpfJmvrqP16LBOaxxfUIQdHGeBYRnrr+lkWWd6i0iM7NnByl75pjJKudq
 o9RoNw==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjw23c940-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:19 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-679f6f264ceso30898748eaf.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224639; x=1772829439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ZZDuz6n4mV1vg7UyXtzywWZTFyf36zcYE/3mP+wDMo=;
 b=ewKVHC6KVEiKUkxjVC09u0MJotC1gAGVYuv6NHbpooSw6mjkBVw40z554ZpYmaOtSv
 PdztzwpNNFP711prDlKqgQ4Hd0If68QCndST2qwYzjisKLU+U+zRqlri0xk0WgRfhWqZ
 R5frNDnxqnsuiIIA1tyeYuP716VtM2IfK+AnoKZpugxrsf6+436KSrL+b04n8SlYz8GJ
 iukOa1yY1V4m4f++HxgmkR2NcXmuuVKhsei1iSBEHZz6l5dG5ZY+BLdMt5yg3bjgw2Ov
 rbgIvbCBAtZvPuxPYlGnW+cV+yaPX8j1g99Au6mdFEEj5e4acRWTGzeR5cmVV+PTOCN+
 4VVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224639; x=1772829439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6ZZDuz6n4mV1vg7UyXtzywWZTFyf36zcYE/3mP+wDMo=;
 b=osfy8wH1Q0wugh6Dhizc/xWlzzcZWlV+Qd+996N6EfNfBAM5H5+Ike6wifUNnwJPAK
 FTx8+xPhEW9hdZRmHyO7EzXjSyD3cafGj0XS7LcwARiOR+X5FQBoZeS66JRrO+I01I/K
 RaWT+3tKxfSKJt47dvgP3kKAdxMrtXmYT66n8yBPl2Um5Vet4TTqLOZ923XINM/FYU7D
 snVkw5bjCZ1NQ5IhChzT1zZBFARbw1T2WNSyp/FiS//msLBH0pFeLr7yAYG4J3/0PF2c
 GMof+1gnwFQCsV20GDFT3Y7Z5ZkxeImylnesvs9CIxJ9b4f+qLQzQH9jvoJ4Szc8ohS4
 GSyA==
X-Gm-Message-State: AOJu0YyLdA7DRSvZGV5TV8XvnL27ZQmkbZS/tXal1AgP6pf3H63Q6daF
 Ln5rNU6G361DmpMnEaBvicXWGHT99RJa4D3ZRtIL8PvtWjN2GsQWo5zVG0nIHnqG8Fk8TDEsxU6
 9rkGvYJTN0Urvx+WJU+GFZFay1zM6NMSP81rstEMRXKy8Rrf6U3vfcuS6sbBsq0qh7w==
X-Gm-Gg: ATEYQzzbiZBIHub03CFR1yJeFfJ8+pKePAhgAeUH4h1y5VwEV3pWWgVGUs6E7Cgg+xm
 +LSWeziI/50aOFG4lDVIIodgaSi2041LCakQkiGTOs2YVg/wsCRpOwD7vR/0pzj30Rsv8ftvZGE
 p35pJbEMsvn9V1KMPNiiiAd2wHkt/TqL4CsliFcbwLpRH7adQpHk6OKGxR1OK1L2Mqm0TFG4cVZ
 kO4g2GuW83gkedXaTVaBHN/C+EiGj2QtQdH0WuwX2L2qXwXuXaVxbkDWXCYGnvIa9klXe6nSHNK
 uZNChclaPekMiaxTTM5R/WNuN9ZiseEZywJ6i4pVbo4uWd+PQgwk8QXUgb/ANIGlrDZtsI8BkDw
 b+y0p5nY7GSruX8bmLEdFucHTCCoaM9fPRmHyabs+sE5ZJG95NSCdBjPC5RigpooxenBD6A==
X-Received: by 2002:a05:6870:142c:b0:3ff:4b26:c40f with SMTP id
 586e51a60fabf-41626d5d991mr2970521fac.4.1772224639022; 
 Fri, 27 Feb 2026 12:37:19 -0800 (PST)
X-Received: by 2002:a05:6870:142c:b0:3ff:4b26:c40f with SMTP id
 586e51a60fabf-41626d5d991mr2970499fac.4.1772224638616; 
 Fri, 27 Feb 2026 12:37:18 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:37:18 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 36/37] target/hexagon: Define f{S,G}ET_FIELD macros
Date: Fri, 27 Feb 2026 12:36:26 -0800
Message-Id: <20260227203627.932864-37-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: Uo6MIGIZ7nuhrZntn99nAwjds8q7eO4_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX5ZLJmH8k8khF
 j/T6+tiHh+xDPW68z4RX1hT2Pyr6qRjQyvCoNcUPsCyZPLQyt7IdezA1+MiLGhaprnyBmazsTfW
 WNylWH+SEUUKdYS+oX/spVVKro3jtLyjrB4klhkEl/cWo3khmc7MfQoXwzlvQ9BjsinMJ45mu23
 bmojP2xA45ccaEkuLjJhTkll1f+6oNiUfOaL8x/uJm4bwQ0ZdJghbwo3TI4JkWO3XlaJ6f73QrG
 qgpxOtCQSYjur+y+p/1V5OO+L0BnfIgSf/SD2HT1HxVYKOSZvg2rVljoQ2Bw1z9Hmp0G1Vk/Yni
 x99U3slLX/iZy9IGJ0FVPYwwbZwEs6yMtiqwboMJMJX+k+eHQM9tzBm6GUxrMIWryZXqxumeb2V
 tw7GAazUIbvfDaFa0fxTXS9/WjYKHTfHniNQDeknULQ4BLPSZsA9xjSod87zs1geuG4/Yu5SMnb
 gM3MgQ81ENHEnxzXSyg==
X-Authority-Analysis: v=2.4 cv=cJHtc1eN c=1 sm=1 tr=0 ts=69a2007f cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OC-ZKJ6AczBSh3OnBRYA:9
 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Uo6MIGIZ7nuhrZntn99nAwjds8q7eO4_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
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

