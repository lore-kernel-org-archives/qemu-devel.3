Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BA4CCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 20:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRfy-0003Uh-4p; Thu, 15 Oct 2026 16:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHRft-0003LB-2o
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:03:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHRfr-0003Ee-FC
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:03:36 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFE2Ai2678271
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 20:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U/M/6P4gwX9yNMbs+L6jBr/DCKCOnbulmkGdz93C2Fg=; b=UgtEGZsKHQ2IxnJZ
 zJ5CobT7fkW2i2j4z2AgeX0THdocR8sXa7AQC2DMcR6XUaMbWBXaEPpjGx079KQj
 TauEg1XmpB2Zp0c1nL3N2qyLsNTxxSpGdJBE7Ut5C5Li0hLyY2ksT9vDH4rmHTS6
 IxXbT4hxCogM7hrZQ5i1cTr+7Y2sGapX9ncW//lB1NcWLEhJcGqNom5ShgB97vAh
 I0VX8XrqrhZFHBDlOZkQZ0Sve0KrCNlO0GDcXH7+R3nSVrYfuqyzdsWV7I/0PJ2j
 IClN0bChLFdtl16J7whpZTWiwPnx9DbSSSahiqdBqNgKsoeV9Hxx/8EngXrtCnBK
 f3liZw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19t94ma-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 20:03:34 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35a4d2e39acso4425052eec.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 13:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792094614; x=1792699414; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U/M/6P4gwX9yNMbs+L6jBr/DCKCOnbulmkGdz93C2Fg=;
 b=LcQBN5Ry1EmdA1uPQTOCLMThX9Jd5td3Nb82X3EZLjJmT2hUXETUrnoahi0f/FGPZH
 GBHMtrEDR2uL32QjBURmyD0x3QxpWId5+xQvHzRk4r5nD4vL+2wEmxXq+EIN/qB+VxgV
 trQeZUMG/XyDfiCZdjx/ol+svB/9sBYRMj8IH/StlBrByeEThscPrPyyu+As+KWV6orM
 +lM9PJASs3cu8m9Ex3tJZ5V5uIJpJGvbZh6Fn3CZDvWRiOLy7M1zFDOQrG8gT8+UncWU
 4DNkgIHQEpgzJqfDSpVpP5PdiKtBbYo3vgNqPAh1FvPJR2tYh8EMGHV5rPAmrwM9QznV
 fxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792094614; x=1792699414;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U/M/6P4gwX9yNMbs+L6jBr/DCKCOnbulmkGdz93C2Fg=;
 b=ZD9o3StkoZr3swUgv7NFGmfXg/A/Az/yviwELIqdsJc/+Og5VGihv+WtOHg+Hs6fvS
 BSXUu3C6BTcrdScVkl+miW7t7FNjntv1Mn+AKgAZXtVUaArVDUQyHPEpJwv8LKfOQltL
 mqhaUJXI5No5BtGgnt0KGPfFlrGzbuiTl9RBdhirix97YOjTPs2deXx7gfEiS72mJd5C
 GEcqX396aaROrFL6hwOOQ0iJrTaejtp52jY9ytBQgw2JkSqiyZPAtatgx2B3m3eWM5gd
 ze4hIA3qrpzqaUL2Jx5SYIeRarrAwvbSZev00oOH+aK2KL9N655OWnYE6DrDeaYGcy1D
 n6TA==
X-Gm-Message-State: AFq9FYKFjpr1DX4CcI1F+z7LQ0wjTb8ARySAcJ13vJg/vo+8po8f4pXL
 /+mTFYPXGm+U4AUsbsxXBK+6kAOlFHtZ2/GCKJSArATmgRC7fnAzzFL4FwEZm4bLkokkFPjQMu6
 Y2FVRwJwfgs49LDF6AfCNjMTLkSISI6OaCwSRc/BUnDIOtpHrQlpJaVG7bG1TDlbzuA==
X-Gm-Gg: AYBFou2yQU9ZY1aZMLpvSORlSgnx0Ccw/F7GhEVIWE7+a/77t0o/yDWJPsMkaxMaV+K
 SECC4DUa2BucDfMlpQzJGYTbyXvaCAWMcrA8IQ31UB6ylG8mahVNleo96bIjYV8PphMtOXkskJr
 kF3LlHmA6ilaC8gXeNZA45FdgF7aIc7keycmeH16NojSzd20aCPZufY+9FfAtTvScQWGHJ1sj8a
 9uUGcbPZQjhVdsAVUYNnaqGmvbXDKnGMDUzjqLa2UWOVPABSwT3WOtI5ZR3EPptdm+YjG9UnQvq
 9LLmDfe2X7Lg/K+wn4IK/5+sXFbuUDsPZjJz6lS7a9tchLX5jU4xgkGJR/RqJoNRDKqdyFu9DC4
 aP+2PAJKMa51GrIcNfa8JaJ1+hOatUvPrVdjbPQe4g2j+vEE=
X-Received: by 2002:a05:7300:e002:b0:35d:5a2c:2321 with SMTP id
 5a478bee46e88-35d5a2c2980mr9273681eec.20.1792094613492; 
 Thu, 15 Oct 2026 13:03:33 -0700 (PDT)
X-Received: by 2002:a05:7300:e002:b0:35d:5a2c:2321 with SMTP id
 5a478bee46e88-35d5a2c2980mr9273638eec.20.1792094612760; 
 Thu, 15 Oct 2026 13:03:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-182a6d6969asm1347058c88.12.2026.10.15.13.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 13:03:32 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 7/9] target/hexagon: halt on tlblock when the TLB lock is
 contended
Date: Thu, 15 Oct 2026 13:03:04 -0700
Message-Id: <20261015200306.1602540-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015200306.1602540-1-brian.cain@oss.qualcomm.com>
References: <20261015200306.1602540-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: uG4BctLoSkfaU5c6jsMzsL2eOQ-fglnx
X-Proofpoint-ORIG-GUID: uG4BctLoSkfaU5c6jsMzsL2eOQ-fglnx
X-Authority-Analysis: v=2.4 cv=NqZE4MdJ c=1 sm=1 tr=0 ts=6ad13196 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=n7pvLpctYYjJJk5sxiwA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3OSBTYWx0ZWRfXzQcA3zfa/0nB
 F65sgmuqIb0+W2LzolvLzw1LAC0++ni4XsY3tpshqgMDGX9FVz3592CIeAj2YoYSbiFcycjJpSX
 NED6qPc7rl0A26Yp1tBdeBPFiGsN1K6Zq7DIlm3ddz65b+NFySlcjFD4wir6JlkxbweluMlMi37
 H3DXtlX6An4lLzAf9YmcxMTLZqy8euXsNOPwAmpG2aRY+iehnJ4YMEhFPp9O4vlDBV90tMhjTQf
 R3mKOnQwZW5A0CUz6e0KSRlF6ccglairkyplBWfSOY5nwoHOUqRbGECW38oZfjseT9oPB6ug7Hj
 OpEnk0mXg5jCFVTmBs4gLqMem5qwbov7QY9/WT4m+EC3/muujvguzKLOVorUAsEjuPn7G5AabKD
 krm+aDLaPuhCot8IApiWf4ZyRGXjs31rjcsvSSK+Zg/aHO0XCPSVVCQrpPQjHuY5RDdzMyVX7F2
 7v53oIM4EIoLZ57XlvA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3OSBTYWx0ZWRfX6HY3EQk9dCMb
 //e9cvQQdgPLYvXERPKI+Gf4q77p0If0cLRl6FDWc0W7IZ628gihyGRdXq/5fcfu9yUi0GOo/0w
 DjOpkLxa0R9oY4HdPsG64l8WhPJpL3E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150079
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

U2V0IFBDIHRvIHRoZSB0bGJsb2NrIGluc3RydWN0aW9uIGFuZCBsZWF2ZSB0aGUgQ1BVIGxvb3Ag
d2hlbiB0aGUgbG9jayBpcwpjb250ZW5kZWQuIFRoaXMgcmV0cmllcyB0bGJsb2NrIGFmdGVyIG93
bmVyc2hpcCBpcyBwYXNzZWQgYW5kIHByZXZlbnRzCmV4ZWN1dGlvbiB3aXRob3V0IHRoZSBsb2Nr
LgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1
YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hleF9tbXUuYyB8IDMgKysrCiAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4
X21tdS5jIGIvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5jCmluZGV4IDYzNzg3M2IyNjY4Li43OWEx
OTc5N2EwNSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4X21tdS5jCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2hleF9tbXUuYwpAQCAtMTIsNiArMTIsNyBAQAogI2luY2x1ZGUgInN5c3RlbS9j
cHVzLmgiCiAjaW5jbHVkZSAiaW50ZXJuYWwuaCIKICNpbmNsdWRlICJleGVjL2NwdS1pbnRlcnJ1
cHQuaCIKKyNpbmNsdWRlICJhY2NlbC90Y2cvY3B1LWxvb3AuaCIKICNpbmNsdWRlICJjcHVfaGVs
cGVyLmgiCiAjaW5jbHVkZSAiZXhlYy9jcHV0bGIuaCIKICNpbmNsdWRlICJoZXhfbW11LmgiCkBA
IC0xODAsNiArMTgxLDcgQEAgdm9pZCBoZXhfdGxiX2xvY2soQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IFBDKQogICAgICAgICAgICAgICAgICIsIHRocmVhZCBtYXkgaGFuZ1xuIiwgUEMp
OwogICAgICAgICAgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOwogICAgICAgICAgICAg
Y3B1X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9IQUxUKTsKKyAgICAgICAgICAgIGNwdV9s
b29wX2V4aXQoY3MpOwogICAgICAgICAgICAgcmV0dXJuOwogICAgICAgICB9CiAgICAgICAgIGVu
di0+dGxiX2xvY2tfc3RhdGUgPSBIRVhfTE9DS19XQUlUSU5HOwpAQCAtMTkxLDYgKzE5Myw3IEBA
IHZvaWQgaGV4X3RsYl9sb2NrKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKICAg
ICAgICAgZW52LT5ncHJbSEVYX1JFR19QQ10gPSBQQzsKICAgICAgICAgQ1BVU3RhdGUgKmNzID0g
ZW52X2NwdShlbnYpOwogICAgICAgICBjcHVfaW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBUX0hB
TFQpOworICAgICAgICBjcHVfbG9vcF9leGl0KGNzKTsKICAgICB9IGVsc2UgewogICAgICAgICBl
bnYtPnRsYl9sb2NrX2NvdW50Kys7CiAgICAgICAgIGVudi0+dGxiX2xvY2tfc3RhdGUgPSBIRVhf
TE9DS19PV05FUjsKLS0gCjIuMzQuMQoK

