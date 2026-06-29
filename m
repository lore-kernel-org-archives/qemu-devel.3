Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CF2C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIJ-0004Ag-IX; Mon, 29 Jun 2026 09:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHO-0003eK-LU
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHN-0006Fr-3R
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:06 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATSPx2579625
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WYScGZeBQb/FybxxD9F89fJ15bRXNrsuCqPgSPyLkDw=; b=gTauPZT2O7lFY46d
 Wsk2QxRUb4mG/fCWRapyWUnyBOePyMLZffaaa4TLozjJFPbOjMPQCnOPCAYawxaQ
 +CuAxP1ItKjtRNhWyab8vZvAK+WRHCG0UgYEtakk8M/+4qhVO56cp4EPJVUPG5mM
 qXfB/PAQTUwExKZ3Edo88jXCV2sPS7vXeqLVxCrBsiqMpbe8uNczn3mkTNvpHJC5
 i5+e2UYE09H5VpPYlKnqpOT6yt3Xx/DcF0yBorggUeCgZgi6qXOzCkPv2CeDU4Iu
 TMPkg7cfpcQAa30l2dNI++OkUa1YzSuC57qQdDHU/YcR1qPwN1sit/xUX7NzjDr2
 dKcvNA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7hksu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:03 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c8e14ebb2aso28194675ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740643; x=1783345443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WYScGZeBQb/FybxxD9F89fJ15bRXNrsuCqPgSPyLkDw=;
 b=DIYMfcMDPGnSrhWUZWCZNtALxaY2QwnyW+yocuB7r9YYvNU59uu9DLAneJVm1i6K5T
 YduUZzRZgXG8WknCea9lFZWG8+G1w9kDRKAMNrQ8Hql311uVHYmF0mjNW6EL685mlg4c
 BKgiJXhfWLh//JYi+wM5qLZxMK/YNh+ijOSet3rs7NL/DRnGuesj0Fj6VVPuWmmfYM+G
 9vwiXZ+jQsRhlJtkVOMwGOWTjFKPwS2HLSFV1W+yX8Fq0p/6IFeOJbx1ZUGlsLhyiVj1
 GkLaGcDb/h72hvA/LhGUQkd+xT6JopAY+x3RGphCg69nupoDXDtSZSfehEGZnDm8woLj
 Jwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740643; x=1783345443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WYScGZeBQb/FybxxD9F89fJ15bRXNrsuCqPgSPyLkDw=;
 b=hmQlgdPNk34WbzKI5QNJyT5LIo57NqHLTl/qP44Wyf/wfGqu8Ed6LnSSIegVr0Okor
 CS2bcQJkXmrOqFn6BoSz5CfWhDLYWskihBcDYaLTvRD2vIc+eWFwpBrByFLOuD9TFH4G
 wtZeIKl9/DErn+Qv+1wBTRBesSeyDpRMmJNq/iDfTPDVjiLLSr/S1r5b39swHt63Prpj
 k4UMggnPbCxdrOM/clX5c3eYTU4eAXjZyMbG4PB9NmQYmFnXZ+tLnKsMD7qU0GRYsuAM
 Zp/yF05HvhY42Os9t9Y/EWhzD/h4xHmMCX3u/wq2f/FwMGrb8+rpSpCkUUiCgsICw2kL
 h22w==
X-Gm-Message-State: AOJu0YxiLUM+mhdK5fCvRnRdUfs59eic4SrRvwYiF3JaIE2Iiy+Rw3mY
 fVUSdSBs/1SENyFznwS7C6pKhwBJlQzhu/4xCyzf48wkvB0GSZtZ9XLQ4BPuF2MjwRx75O651SV
 f+xYUT2M7xrNze2fvS+7+YIN9nYwMrYP5DiDM1qKXEHVOeEH6dr3sAPomk8qD1ObtFA==
X-Gm-Gg: AfdE7clAREafQJgXdf9YX+S6fGG3+KdDK1CZY3WSvl2j5U2mTOhu9uLRiNDxY9lQc4Z
 kW3jlVA94wVF+bZvRVlBHYMT0/fO8WT3atnC5PjtTzBueJT+vEPGzNR7qEF8E7drrYKSUktzpvC
 l02xpzgARKLxb4gaCi9WkWi1fX82rHIX9Tc7SzTuwrN9SRY4FhX5Jhcm7+GR3np8hOWFCEjw1Wc
 1Uj/sL+7kAeWE7l0KJ7MiPsP5bTb/bggFEaetFsRgAcuIhCqdHKovElBu4fipIyR9smaQK1GT8J
 N4fwsKwv6wbwzOtbLSsZ9fdPNozpeCp6w6Mp6K01I6wIJD11bxdU8UA1kIS7wrU88fiVaCL1UaG
 5P7vj0I+8A+xCkSaFWO5peMf/YUBjlJh68BiZP24b/Clp6IZEnIV/+gWcRzo=
X-Received: by 2002:a17:902:f602:b0:2c9:d277:2cdb with SMTP id
 d9443c01a7336-2c9d2773a23mr46131725ad.9.1782740643086; 
 Mon, 29 Jun 2026 06:44:03 -0700 (PDT)
X-Received: by 2002:a17:902:f602:b0:2c9:d277:2cdb with SMTP id
 d9443c01a7336-2c9d2773a23mr46131435ad.9.1782740642619; 
 Mon, 29 Jun 2026 06:44:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:44:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 53/77] target/hexagon: Implement siad inst
Date: Mon, 29 Jun 2026 06:12:08 -0700
Message-Id: <20260629131232.2487780-54-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX6u/G4Q1VfMTB
 Xqsh4oePNb8Aefuayt/cwIMwgLh/6sJ55KV5Q9gA2vVOGDmpMSmRJk4AV2WxM6XOoka0EVQ9g6L
 ebr+2B8nkjm1j9xPGZpAsk9OEzYu6cg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX07Lpf7HlSqZe
 CoUC1jLZlsz0ytvbMww8HPIxsi9OKzK6qXlGMIfm6sR/iCWzRqyR+L2xTWEopyrzByiUrT/2qyn
 /1bmo2e2JHhGlcDuRjLrt5FlG5YzjeXYRwYofa1O8t8uE/rhG0ekcTtiFWjfXI+ycWU0xzZwld8
 6/LfKGwD8nRtnwMAcS26+cAXspTP2IDdT6yP1+bq5cfIMB5va4dykiLq2UPAvmBFjBfgQwgOPnd
 2CBefOTRrpeE4A89vs31WrroXYUVUdHH1CEdz4BXmsTjGoLG78xHQiC5hkA7iPSmK+LoAZTAdsl
 9/aajHEk5KKztAXTlgCvgHTZZdrATEAX1XZkCou94LNgWh8l49sYXqTh97VhcvXEn/jjIJMiIbB
 vtymrdJhlxeuD20khPcZuzuaBQQgeyJJ6WaovGYHk1cWf59JdO9gc/59xWA+NSkcxhWZgrQ8eCl
 5SosCWNqawrKGc11Cfg==
X-Proofpoint-ORIG-GUID: P_9GG46jizi6yGVRHa3F3QtGm2i5HB_0
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a4276a3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HdTxHAvixyPUp6pof0EA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: P_9GG46jizi6yGVRHa3F3QtGm2i5HB_0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpzaWFkIGlzIHRoZSAnU2V0IGlu
dGVycnVwdCBhdXRvIGRpc2FibGUnIGluc3RydWN0aW9uLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBT
aW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENh
aW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYyB8IDE3ICsrKysrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggYThiZjg5YWI5OTYuLjRk
MzE5YTI2MzdmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMTQzNiw3ICsxNDM2LDIyIEBAIHZvaWQgSEVM
UEVSKGNpYWQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBtYXNrKQogCiB2b2lkIEhF
TFBFUihzaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKIHsKLSAgICBn
X2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHVpbnQzMl90IGlwZW5kYWQ7CisgICAgdWludDMy
X3QgaWFkOworICAgIEhleGFnb25DUFUgKmNwdTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7Cisg
ICAgY3B1ID0gZW52X2FyY2hjcHUoZW52KTsKKyAgICBpcGVuZGFkID0gY3B1LT5nbG9iYWxyZWdz
ID8KKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9T
UkVHX0lQRU5EQUQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJ
ZCkgOiAwOworICAgIGlhZCA9IGZHRVRfRklFTEQoaXBlbmRhZCwgSVBFTkRBRF9JQUQpOworICAg
IGZTRVRfRklFTEQoaXBlbmRhZCwgSVBFTkRBRF9JQUQsIGlhZCB8IG1hc2spOworICAgIGlmIChj
cHUtPmdsb2JhbHJlZ3MpIHsKKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfd3JpdGUoY3B1LT5n
bG9iYWxyZWdzLCBIRVhfU1JFR19JUEVOREFELAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpcGVuZGFkLCBlbnYtPnRocmVhZElkKTsKKyAgICB9CisgICAgaGV4X2ludGVycnVwdF91
cGRhdGUoZW52KTsKIH0KIAogdm9pZCBIRUxQRVIoc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKLS0gCjIuMzQuMQoK

