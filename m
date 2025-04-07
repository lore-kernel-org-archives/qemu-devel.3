Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CE2C3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1odH-0004xy-2N; Mon, 07 Apr 2025 11:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1odE-0004wO-1q
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 11:43:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u1odC-0002f8-Hp
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 11:43:27 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378doD4017429
 for <qemu-devel@nongnu.org>; Mon, 7 Apr 2025 15:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gVoHJ0OtSSYZsMzuDVY7GZ5ga6wHPMe1mgwZjB5K2qs=; b=e5n3o6TwElw2vbNs
 rL67EBF17zpyx9nYgFYvZdzzgQc/ccQCfYK5enQ15qJib7NvdCJRej3kNj4VglOu
 ky8UEcRCeqXECeulJxOItrA45+wp1FKSss0zgDRuCO4FluJxbIEPRtBQIMDM7U1z
 cEsINmZr2tmQaE1BC92xruY2cdKtk/sZrlItGl4hshviPR9DjOmNW72Z5A3x+P1Z
 fFXNqk7iY1cJFh7dfpZShDp0dT84vYtuwQSzEaNCzU2rJZNVBVTyw1/TyMRPsNDH
 uhcU1Q+2FLAclK+8GXwO7l9/qk53HHHR2FMIHVM6xgdLEaZQ+kd4STugwIw9gKCg
 SphMtA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twg3cpjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 15:43:25 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7395095a505so3454383b3a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 08:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744040604; x=1744645404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gVoHJ0OtSSYZsMzuDVY7GZ5ga6wHPMe1mgwZjB5K2qs=;
 b=TSJ73tRtxMaCP0yT52DvRK84XnPMgB2l70z9zxV/8diAJOSiRbbmzz8x6f1TIsTk4y
 XOfsbkS6RlUPnC/P0l45iN/wrzk7kHMLFGyjLlIJ8VAXmQzqIulMxu4l6JdIbB09Qw2x
 d1QfXgfEtYZZtNr9VP/nUAFfC4xctv+GUCXRhi036M+pKq5Y6wdcHFTkjXNhCmm7qghh
 qxtJJu/kpVxH87zwzUTEheH3j2SyLueVPwzoyEB7jorgY9MvHzmkZw75oZJlIQjryi0p
 FoZv90PYoIMOVKvcv2rbScqOzNeZqfaEDkKgrhkzFzcEuu1fOx7eWDQkkamV+wNo7Wpw
 1jIw==
X-Gm-Message-State: AOJu0Yxv4BVGVCwjyk4FPJ0wCovAdL0cGIsPo9FP79Btc9YD/8b0Vadv
 283Lc2HdO5qC61yGRPxgtYnIM0+OWTofQRJ2HZY7t8Zv8MOcyPj1dmBtzNmquxwPDuQ8m321vl2
 81dHg5LZ3tu1UM99e4HLUJ9uDL/uDL5UloTtHx8o/0FAj/3ZaGvXfxIQielJWdA==
X-Gm-Gg: ASbGncu4N9+wJ8bckLfqtzjgXAdffQco2CGs40GmSJaz1rzj6kv0+chKFpUtode+xAY
 n3frPmD0b+rWO0JG98ibbhaIorzN/dW/vrp7XTOY5VF5nCvAe9lzVrQ0J+7Hghxmo5ZRLJiOWMv
 N7xZRBE1ch31g7pszro4RooKRPKVjU2QWnr8XJ/rgk7QB8nO0KANkloi3CJe0BFKkhqxXNcKFnK
 DSNImoJBhFMV43v4AXRtODXlAGVNWjwf38Rq/l9340MIxmSLy8VV2tYzViTTopIG6aoIbv/zdfz
 Mn3puyV5O+G0juvD4GYFqm161pTQAnjd0hACNc+DmsNkXgzgMBIKpbvQwgVu9Yq7
X-Received: by 2002:a05:6a00:2e14:b0:736:4bd3:ffab with SMTP id
 d2e1a72fcca58-739e4be89demr13116329b3a.17.1744040604104; 
 Mon, 07 Apr 2025 08:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8hZNjs2t6W98ctkr+Vfrkt9yTm+oW56r6gZywOA6QnZmqCCr5+k6WlJi/2Rpo993V41B3Lw==
X-Received: by 2002:a05:6a00:2e14:b0:736:4bd3:ffab with SMTP id
 d2e1a72fcca58-739e4be89demr13116305b3a.17.1744040603688; 
 Mon, 07 Apr 2025 08:43:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee3fesm8681651b3a.37.2025.04.07.08.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 08:43:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 2/5] target/hexagon: Fix badva reference, delete CAUSE
Date: Mon,  7 Apr 2025 08:43:11 -0700
Message-Id: <20250407154314.2512587-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407154314.2512587-1-brian.cain@oss.qualcomm.com>
References: <20250407154314.2512587-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: u_jpHJtBHk8rkKZqesqsRW4dBdi0h2Uf
X-Proofpoint-ORIG-GUID: u_jpHJtBHk8rkKZqesqsRW4dBdi0h2Uf
X-Authority-Analysis: v=2.4 cv=I/9lRMgg c=1 sm=1 tr=0 ts=67f3f29d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=HN0uuiy-se_EESAQhN8A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=905 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070109
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgQkFEVkEgcmVnIGlzIHJl
ZmVycmVkIHRvIHdpdGggdGhlIHdyb25nIGlkZW50aWZpZXIuICBUaGUKQ0FVU0UgcmVnIGZpZWxk
IG9mIFNTUiBpcyBub3QgeWV0IG1vZGVsZWQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxi
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1LmMgfCAz
ICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5k
ZXggNzY2YjY3ODY1MS4uNjJmMWZlMTViOCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTIxNiw4ICsyMTYsNyBAQCBzdGF0aWMg
dm9pZCBoZXhhZ29uX2R1bXAoQ1BVSGV4YWdvblN0YXRlICplbnYsIEZJTEUgKmYsIGludCBmbGFn
cykKICAgICBxZW11X2ZwcmludGYoZiwgIiAgY3MwID0gMHgwMDAwMDAwMFxuIik7CiAgICAgcWVt
dV9mcHJpbnRmKGYsICIgIGNzMSA9IDB4MDAwMDAwMDBcbiIpOwogI2Vsc2UKLSAgICBwcmludF9y
ZWcoZiwgZW52LCBIRVhfUkVHX0NBVVNFKTsKLSAgICBwcmludF9yZWcoZiwgZW52LCBIRVhfUkVH
X0JBRFZBKTsKKyAgICBwcmludF9yZWcoZiwgZW52LCBIRVhfU1JFR19CQURWQSk7CiAgICAgcHJp
bnRfcmVnKGYsIGVudiwgSEVYX1JFR19DUzApOwogICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9S
RUdfQ1MxKTsKICNlbmRpZgotLSAKMi4zNC4xCgo=

