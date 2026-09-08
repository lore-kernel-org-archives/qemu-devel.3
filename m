Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A595C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3vzD-0004aY-1k; Tue, 08 Sep 2026 09:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3vzA-0004X8-PX
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:35:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3vyo-0006DI-UF
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:35:40 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688CkgvW4162845
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 13:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i+BQYS4xacAVfjkq5bOrVH3c3+v4rw4NRLcpKfLn4bU=; b=S4CXCEh5UMpQa8eE
 gPzZP5V31iTLUKgZ4R/L08IB7bdXGzc6OI4JUYJ8qFMyTTca8R/YuqjUmrqR/K/x
 orlYczKmf1FtnFEwYRrI5CMDSUaNrxVkggkT1Jm/hwhpuM+lwX9bFEbBn8oNuyA9
 0pqOj5XOfPYgjma2qzX/KwM7RxxAGUQMjk3Qu8WFeRXJesUMaZsPUrNODwdBXy4v
 ys+7DLkeLKrFJnl3eNsR+CWbnsNp61m/yYPtoddd7JkJchY2Ca4Hv56qDR8SgOrV
 oUyK3gMgQH2EBthi8Lf5c0y6q/JGIs5Msx18yUvBYMqVGl4KtlqeI5tKHC1Rq8gK
 vRF4GQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjb0pa5ps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 13:35:16 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39af92138f9so7032643a91.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788874516; x=1789479316; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i+BQYS4xacAVfjkq5bOrVH3c3+v4rw4NRLcpKfLn4bU=;
 b=CrxC3y48tPPETB0GwEW62fdRGJA1pD3fhVijxgQBrWjjtO2HQjZoplZtm0z3OGX4Ve
 4C9uFrRosPNwfdeISGwV4d+M2i1HEwKgu3MurTmEmGIylqDmzNDMDI3kcRMfQVf1wt+h
 TKZGzAIcK4FdpNcaO66AX3nx+04SZNyXKuKTnlAl6NHf0ebC2tSUowcRpN0LiCGf9iCq
 hSMionAeet/DBqdy8SyAe0bQnkJm0CAeK1UL3JRjENYAeMNKVfSmoAiD5yDNCd2PfO2/
 w3KHnpxl9jgcSK6zNodqCrq7mBgM+658Hj7UP6wbiRXf8aZd/eFD7M+bONWGJuY2quzV
 FuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788874516; x=1789479316;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i+BQYS4xacAVfjkq5bOrVH3c3+v4rw4NRLcpKfLn4bU=;
 b=qUlJxewwggRgUqghWc8ze6vJAT82M6gtkOMJmPhFQ0wg7Cn7kHIxwEWaR9/Jh6+jjV
 4ddFxaEbe7yyN2+ySRB8v4JRG/Bg98jtq8GJCM0V2WJOvFtquVnTf5qdAgRudbaYx0Pq
 dFjLhmohk2cUrCbjGMnIEeVrUyBEoPK3ccLhT/peRj5YOuT7WoC4zQiA1A9lxX6AcBAG
 4Ppd0xN9FjX3mqGEytvoInEuLw27d37XwxxHRy0eauk2aDWsb0nmjaBAdFZFNhPLeL4X
 dfqv8aITFV8e9qLZxGKVQY4thJbbgJiSwLEgg1bMS6shQVb+E5fw6x7FxK5y3BK2zex+
 UV/A==
X-Gm-Message-State: AFuF++kwLsBpkd4qwmPR+vSMIFU2dVuk1RG4JwjfrOSpoLtYk/c4vg0R
 w+rhKh4zh2wjrcNs9s96+vUSxkmxwktbCgsFt67/X2BJEA/PIS2rksocW2aN30LiUWAP6Zcp9w6
 srsAQV7FnggWjq56iAFOHSNNWx2VSNqV5wzocDRT/Sowrtn0fIW5UD7JHUwACltJ0XA==
X-Gm-Gg: AYBFou2b30SnAJaZdfAp5eZvq0MncnqoiVU3V8EpydeEUnRdKI9OrznubVye+Hf7nVD
 3uirx0NIBI/QsLTp6jbr7EJHUQHz5pMx50BsansTPFB5yI75/e2sGenmM5Nqig5VPzfafe0R8fx
 Ey7DhLfrGRWM9/1hmVGEeIYj5i0eGpb6EZEwTkxi50Wo7QU4ikOmiNd1Rh1xqP6IN4rmXcd+o5F
 W8zYc4SJ4U0IZT0ox2QAf+DrlYXYKDudUSpUUwTLUlAe+CRoqKPXyy71KftQ8HSZCrqZtXTcNQe
 jtkdZ+nK44y0wGJn0R/Pz3zycNZReMyBlllYg3kYjmhW9020mxqiYoL/PfaEocqHcEq3Q/+eIRQ
 H04Sxeo02CV2wQjUcsjIwUBb3VxCcQp+qbwTCO+py1b4hs58F
X-Received: by 2002:a17:90b:1e41:b0:398:9beb:a2b9 with SMTP id
 98e67ed59e1d1-39b087f4d0emr37651426a91.27.1788874515998; 
 Tue, 08 Sep 2026 06:35:15 -0700 (PDT)
X-Received: by 2002:a17:90b:1e41:b0:398:9beb:a2b9 with SMTP id
 98e67ed59e1d1-39b087f4d0emr37651379a91.27.1788874515485; 
 Tue, 08 Sep 2026 06:35:15 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-334fbd5e6f6sm29029079eec.23.2026.09.08.06.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 06:35:14 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com
Subject: [PATCH 1/5] target/hexagon: add the v75, v79 and v81 CPU models
Date: Tue,  8 Sep 2026 06:35:07 -0700
Message-Id: <20260908133512.2353957-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908133512.2353957-1-brian.cain@oss.qualcomm.com>
References: <20260908133512.2353957-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: CVW4qRiGO-DuQvdHg7_z2ZUPZkGaXlZe
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE0NSBTYWx0ZWRfX7hUY6xHyJSJd
 QIJLBbvKH0kPPrrAhhv9RjJED4zXtgGzpSsy5MLckIjdJs7pYghJ10QvlLSfJNnlwTT6loFf614
 8rgZGf4Zhh2E0vLq2JF/q/nouoWFx70=
X-Authority-Analysis: v=2.4 cv=HL3z0Itv c=1 sm=1 tr=0 ts=6aa00f14 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=sGg2OeOXg0vhTN0KIsEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: CVW4qRiGO-DuQvdHg7_z2ZUPZkGaXlZe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE0NSBTYWx0ZWRfXz5mfAy6Iv0oW
 JaqjymE+cmAc6lMwz9bCDw1jtSkMICDd4tRk9sy5YC66PSpvSmx3KrPxAOXXrJ0CI7mik64niez
 5Lxse4M/pNxOUt8jceIZmvoqEeVEJfJi9DtyTQDKr2/2sGfQLdBCpjHmcUq3ObfP19hnweRAeLv
 YrGQtyssS+LrB3zYj10lqwp/oh+/TZ3XeuVPaZ4JBwbYiqacdheaVHZwK13TodlX0IPIPUJ672f
 63453Deo2nEkokgu9OnKvBv4F4YQCz4mz2gfQORrhs8TdHXzlk4IY0yddI1hHdv2IDwHveAEybg
 YNLOL3IDg7jt8kwdaf5rGGgUzZ7/G9F+BrYkVVafvHh8yxNmiW1xBmDpEU76Tmf9Xdh/Yr1QQkv
 L/Rfi5UWZVHCOQpOZrqWjr0aGqrZZsjxsvmtZ9J+hh5/w6A0FemAQyK4ajHsTFIAW+C5lq+1XO7
 KnBacR6nB3khe+Bj3FA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080145
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

djczIGlzIGN1cnJlbnRseSB0aGUgbmV3ZXN0IGNvcmUgdGhpcyB0YXJnZXQgaW1wbGVtZW50cy4K
CkFkZCB0aGUgdjc1LCB2NzksIHY4MSBDUFVzLiAgTmV3IGluc3RydWN0aW9ucyB0byBmb2xsb3cg
aW4gc3Vic2VxdWVudApjb21taXRzLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4u
Y2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS1xb20uaCAgICAg
fCA2ICsrKysrKwogbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYyB8IDYgKysrKysrCiB0YXJn
ZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgIHwgMyArKysKIDMgZmlsZXMgY2hhbmdlZCwgMTUgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS1xb20uaCBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS1xb20uaAppbmRleCA2ZTFiYjA0MDcwNC4uMmJmYTRkNWQwZmMgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS1xb20uaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUt
cW9tLmgKQEAgLTI1LDYgKzI1LDkgQEAgdHlwZWRlZiBlbnVtIHsKICAgICBIRVhfVkVSX1Y2OSA9
IDB4NjksCiAgICAgSEVYX1ZFUl9WNzEgPSAweDcxLAogICAgIEhFWF9WRVJfVjczID0gMHg3MywK
KyAgICBIRVhfVkVSX1Y3NSA9IDB4NzUsCisgICAgSEVYX1ZFUl9WNzkgPSAweDc5LAorICAgIEhF
WF9WRVJfVjgxID0gMHg4MSwKICAgICBIRVhfVkVSX0FOWSA9IDB4ZmYsCiB9IEhleGFnb25WZXJz
aW9uOwogCkBAIC00OSw2ICs1Miw5IEBAIHR5cGVkZWYgc3RydWN0IHsKICNkZWZpbmUgVFlQRV9I
RVhBR09OX0NQVV9WNjkgSEVYQUdPTl9DUFVfVFlQRV9OQU1FKCJ2NjkiKQogI2RlZmluZSBUWVBF
X0hFWEFHT05fQ1BVX1Y3MSBIRVhBR09OX0NQVV9UWVBFX05BTUUoInY3MSIpCiAjZGVmaW5lIFRZ
UEVfSEVYQUdPTl9DUFVfVjczIEhFWEFHT05fQ1BVX1RZUEVfTkFNRSgidjczIikKKyNkZWZpbmUg
VFlQRV9IRVhBR09OX0NQVV9WNzUgSEVYQUdPTl9DUFVfVFlQRV9OQU1FKCJ2NzUiKQorI2RlZmlu
ZSBUWVBFX0hFWEFHT05fQ1BVX1Y3OSBIRVhBR09OX0NQVV9UWVBFX05BTUUoInY3OSIpCisjZGVm
aW5lIFRZUEVfSEVYQUdPTl9DUFVfVjgxIEhFWEFHT05fQ1BVX1RZUEVfTkFNRSgidjgxIikKIAog
T0JKRUNUX0RFQ0xBUkVfQ1BVX1RZUEUoSGV4YWdvbkNQVSwgSGV4YWdvbkNQVUNsYXNzLCBIRVhB
R09OX0NQVSkKIApkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYyBiL2xp
bnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMKaW5kZXggMzliMDIwMTgxNDUuLjJmZDQ1ZjdlMzhh
IDEwMDY0NAotLS0gYS9saW51eC11c2VyL2hleGFnb24vZWxmbG9hZC5jCisrKyBiL2xpbnV4LXVz
ZXIvaGV4YWdvbi9lbGZsb2FkLmMKQEAgLTM3LDYgKzM3LDEyIEBAIGNvbnN0IGNoYXIgKmdldF9l
bGZfY3B1X21vZGVsKHVpbnQzMl90IGVmbGFncykKICAgICAgICAgcmV0dXJuICJ2NzEiOwogICAg
IGNhc2UgMHg3MzoKICAgICAgICAgcmV0dXJuICJ2NzMiOworICAgIGNhc2UgMHg3NToKKyAgICAg
ICAgcmV0dXJuICJ2NzUiOworICAgIGNhc2UgMHg3OToKKyAgICAgICAgcmV0dXJuICJ2NzkiOwor
ICAgIGNhc2UgMHg4MToKKyAgICAgICAgcmV0dXJuICJ2ODEiOwogICAgIH0KIAogICAgIGVyciA9
IHNucHJpbnRmKGJ1Ziwgc2l6ZW9mKGJ1ZiksICJ1bmtub3duICgweCV4KSIsIGVmbGFncyk7CmRp
ZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmlu
ZGV4IDRhN2I3NmUzYmNjLi5mYjBlM2NhYTQ4MSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24v
Y3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTg3NCw2ICs4NzQsOSBAQCBzdGF0
aWMgY29uc3QgVHlwZUluZm8gaGV4YWdvbl9jcHVfdHlwZV9pbmZvc1tdID0gewogICAgIERFRklO
RV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WNjksICAgICAgICAgICAgICBIRVhfVkVSX1Y2OSksCiAg
ICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y3MSwgICAgICAgICAgICAgIEhFWF9WRVJf
VjcxKSwKICAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjczLCAgICAgICAgICAgICAg
SEVYX1ZFUl9WNzMpLAorICAgIERFRklORV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WNzUsICAgICAg
ICAgICAgICBIRVhfVkVSX1Y3NSksCisgICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y3
OSwgICAgICAgICAgICAgIEhFWF9WRVJfVjc5KSwKKyAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdP
Tl9DUFVfVjgxLCAgICAgICAgICAgICAgSEVYX1ZFUl9WODEpLAogfTsKIAogREVGSU5FX1RZUEVT
KGhleGFnb25fY3B1X3R5cGVfaW5mb3MpCi0tIAoyLjM0LjEKCg==

