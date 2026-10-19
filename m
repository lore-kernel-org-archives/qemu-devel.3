Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8023CCF2D3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 06:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIgYm-0004en-Bx; Mon, 19 Oct 2026 02:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgYk-0004eH-Iz
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 02:09:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgYi-0002jx-US
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 02:09:22 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J4j3km238682
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 06:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cq7w0dM6sl1PMbI53RCJwUl+pC22WqAIvSpe+0LKqCM=; b=fgZxVL8edlyHWet4
 Y3fkEr+5SgLGv8d71orEcqMbCm/vPOEgQa56enIlwQXUnEioUOxxVIXMYePcvDgr
 Q02lxa6Em7kzA6GVqto4QK7w2R1zbQiOiDBMscWAKDFvSM2EVTTsg3LTRWq6rk4S
 Csef2UMDPlSxmayw0jw3PYta/1GVnYmzuUa/7Ag5qDpA9c6wgk8gZQH7ocWCvLPX
 f06uROiTBci9clvDNv9M7ZOL+bHRB+u1icw+IxdJUzHoJ6zSGGaDhec4Vhy5YR2y
 rWAHHbFJuaedhracWW3MwdtK2NbgJXxJswXFE7I+xGrLCGOuYg8Ny0fgZnLyNbHR
 Vr5hwA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc26k50cv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 06:09:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35d4538fd74so6530869eec.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 23:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792390159; x=1792994959; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cq7w0dM6sl1PMbI53RCJwUl+pC22WqAIvSpe+0LKqCM=;
 b=J57lbEp+L0Y5M+D+rVbj9X4OBddUzk21X161WFwiTX9ubTe7mKJ8TtIvoRiBR1gQZP
 vZFO6VHeRRMWfGKO6Sw5/ZjmQ2Xz3icTEcXJbC6FUWDbpsSCC2u72HgrCUlcome1TzKI
 3pPtqe/f/oocbfYj5/8c3IG+8B4Ti/VS3P6Z7UB5dzAujl3Ol6Ftn+DTLcnoEHRGfbRv
 WxZ4vdaYV1venTO9BmeSB7SYrfZo5yG2HETZZvLT8er66Dlar5zAOK+aXtir6fehchCf
 fJT3XgYXKR1G0imE9wqdz4OErnc5I+/0fmCLEH+kghALkvBijsqDJjdgEPV3AnEBd6GK
 GP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792390159; x=1792994959;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cq7w0dM6sl1PMbI53RCJwUl+pC22WqAIvSpe+0LKqCM=;
 b=oyz4WgXndZEJkzqldq2AXx7f2c3kMUD6eQIWpRi6H/YLkvrlCI/dwEq17TjBm1AnJP
 O1CHyylvOqET7NbUkNVj/5qVoPzodb3HOYe80/Vr+f3Ol4AEl6Eux3+kkSa0+yn96Iah
 hnd082Nt5N9Nt6/iYDtMSrXEY8smyeXt6w33H2GD4vTlLuMj59EpGgsa0cSXx7OxOQBY
 Zf1E8sm+/G6vSgf16uOKvpjCakQy0fPzBgtf3Ay/2uDUaKIQKZHmYaVeSiN57NhxcrJF
 A5sXPFGuTlgnaxeWRXLyTm01BSk0ZyeuY6l57UMU4Q43HyqQTQbu4k0zz5m4TKvxLrBS
 AROQ==
X-Gm-Message-State: AFq9FYJInQlpeARAH0oNp1q049ErjVkn1zcaSMx/EYG0VRN7vpyQgDgq
 K50KwzPXwwtNAa49x27lmXHkuhehaBTrk5TO4tHjt21DOUk+srnbkRlfadDTxEf8TEu28Jutei2
 sdum+5Ch6dNtg2hsAwQ+r+CG0NQILJv28r+bGZbGEnf8iIyjF481+3I5v6dgtSS6eKQ==
X-Gm-Gg: AYBFou2FjjYjWJIVKf277SL/uyZRlQCkK3CCeTDC53JUS3N8hJ9ystp4/7VnNm+e4YZ
 P9RSXCficitu+hlJVvkZ/Mi90cXgJpVEWW6/eg1Jl+Mr3l7tL9mF/vxYJTwsUW6edvEFcuJseui
 Zf7hSMXwR/gcKN7SRDkelvvTj0YUA3T7ymROLnKOnW3r0yLl2S/A2mIT7dqWVPXSKEbYiZpTIHd
 rYoO1JNYcXNhtlXdMJbwDW18B2j8lCRlPvNydANM9yPW98I2NriN1+fT4LuRTkC9Lvk8MVhoxi/
 5BTqrbbxYNWvrSOEh0olSGuyKzTYrr0tLJIHTpEX+wLR5fJiAqyksqsepGwdLlXd9cum/+xyeQU
 wXAo8cxdF0QpmknSIqZKssDMkIADDI6JPpIPYFjKpvNfhNdo=
X-Received: by 2002:a05:7300:7a9a:b0:35a:8dad:6724 with SMTP id
 5a478bee46e88-361a1f495bamr10133003eec.22.1792390158688; 
 Sun, 18 Oct 2026 23:09:18 -0700 (PDT)
X-Received: by 2002:a05:7300:7a9a:b0:35a:8dad:6724 with SMTP id
 5a478bee46e88-361a1f495bamr10132975eec.22.1792390158041; 
 Sun, 18 Oct 2026 23:09:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360820a02b8sm31770053eec.17.2026.10.18.23.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 23:09:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 2/5] target/hexagon: check exception_index in has_work
Date: Sun, 18 Oct 2026 23:09:08 -0700
Message-Id: <20261019060911.1479329-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019060911.1479329-1-brian.cain@oss.qualcomm.com>
References: <20261019060911.1479329-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfXyuLdPO42Po0p
 1HzChi7C7jCnWIFLPiKQfTy0953RipzcMn6O12Zd/Bs463C5S0aoAhuG/ZSQtsZElElkluvw6uU
 rHcDqeNhwfi4a4tAdUw/zyST2urzOZSlG2XRCZzhfHjySa2awQ/NK5tWsyQ9Rhncyqvca/Bii6r
 KAKkjRQR5DXEwExvZbpNnrDeI+8JYcJTndb3HVmH5zQqOqAq54UTDESQVaFNmza8vfhfa4+nVE6
 BJvGUGrCh9ADFx0bP4VYCccOE8Dd5pqcuVj3p/NUAlE0JhnO/mHAjH+KQatS+AvbRROGePsseLO
 QSO1mSO5oX3PPjHvZLHRgvdXFDI9wpZNSqfbGH3mytAD3xmZvzk5wS9mW02m1iCvvUxUxPEGcz7
 lYJjPrYCGVEPDH1g5cbKuDbqviotvn5sZAck4FgOnmDjgWsXlsOgK72vQXe0eQRi+INYs4+0uiL
 +IHjahuWhGorrqGfkUw==
X-Proofpoint-GUID: WdgxTQa5vour_giZrrE2kTB_gPe_vGEB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfX37hdD76LNDNW
 P2Q8p/apigaPJDCSJk8C3pFT72533fBnt+blxh59RocfAOqyQhcxfAeQfE37a0BltS42egjXOPM
 5sJzrbZmy8BZDLc/5CoF1w4zRLxjwRY=
X-Proofpoint-ORIG-GUID: WdgxTQa5vour_giZrrE2kTB_gPe_vGEB
X-Authority-Analysis: v=2.4 cv=Cowq4X4D c=1 sm=1 tr=0 ts=6ad5b40f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=2Qhxk_BCo_5fC3_CN1YA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190024
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

V2l0aG91dCB0aGlzIGNoZWNrLCBhIGhhbHRlZCB0aHJlYWQgdGhhdCBnZXRzIGFuIE5NSSB3aGls
ZQppdHMgbW9kZWN0bCBFLWJpdCBpcyBzdGlsbCBzZXQgd29uJ3Qgd2FrZSBpZiBubyBpbnRlcnJ1
cHRfcmVxdWVzdCBiaXRzCmhhcHBlbiB0byBiZSBwZW5kaW5nLgoKU2lnbmVkLW9mZi1ieTogQnJp
YW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29u
L2NwdS5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IGYy
MGQ2ZGU2ZjYzLi44OTZkNzI4MjVhNiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMK
KysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTM5Miw2ICszOTIsOSBAQCBzdGF0aWMgYm9v
bCBoZXhhZ29uX2NwdV9oYXNfd29yayhDUFVTdGF0ZSAqY3MpCiB7CiAgICAgQ1BVSGV4YWdvblN0
YXRlICplbnYgPSBjcHVfZW52KGNzKTsKIAorICAgIGlmIChxYXRvbWljX3JlYWQoJmNzLT5leGNl
cHRpb25faW5kZXgpICE9IEhFWF9FVkVOVF9OT05FKSB7CisgICAgICAgIHJldHVybiB0cnVlOwor
ICAgIH0KICAgICByZXR1cm4gaGV4YWdvbl90aHJlYWRfaXNfZW5hYmxlZChlbnYpICYmCiAgICAg
ICAgIChjcy0+aW50ZXJydXB0X3JlcXVlc3QgJiAoQ1BVX0lOVEVSUlVQVF9IQVJEIHwgQ1BVX0lO
VEVSUlVQVF9TV0kKICAgICAgICAgICAgIHwgQ1BVX0lOVEVSUlVQVF9LMF9VTkxPQ0sgfCBDUFVf
SU5URVJSVVBUX1RMQl9VTkxPQ0sKLS0gCjIuMzQuMQoK

