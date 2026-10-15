Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2D8CCA465
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 20:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRfo-0003H6-V7; Thu, 15 Oct 2026 16:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHRfl-00039k-Cl
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:03:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHRfi-0003D1-HX
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:03:28 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFYQB64077483
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 20:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=dmHYcA1H4Qt5oJweXys65S
 +00+1nouSkSdLZdY1Pey8=; b=Rwcw4RmBojj3FzkCr18LBbbgvcHVqTu7MjFC2N
 6Zm/SWE/ZlSRCuY9RG1dZ9VinOX6C2o3SJjoJnIztIw8DlqSrpilV8NCTex379Y1
 O9XKcqjSjtzc6EJ5oRSp3KFMYnkpvR6T9FLd7UvzaYmMo2XPIhtm/VM293Ht9zfF
 +NNpKbkFiKDqYsmQ5Q/IXBOx2BwXULgOiPMv1dLBWnBIMv1p5Sez0egoHlqWwCNb
 6Gy9w9RJ6oQe8YC7zN23KDbsOCT4yIh7jbCQ0bwmdF/oEvjVdHnhUQouXZnnbheM
 c+wO9D8MJDNhEqNUNSjjdT7pOz6Ey6CxgWQLtnsJHJv3bZ4A==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4havbc2hc3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 20:03:23 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139b62317d0so20848715c88.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 13:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792094603; x=1792699403; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dmHYcA1H4Qt5oJweXys65S+00+1nouSkSdLZdY1Pey8=;
 b=JElmy2+85LxEVDr3POk6whnc3/sw8iZXMzDRUuXjfnUiREaCfEvjUOrFC8OE58CAB4
 Ybre9le6SjZguME13rEFaAav0+P7OAIXtl3AxvBIpw1cg8dkxkvcO4urJvSfg4U5/SXV
 tWuqq5dz2WZTiiYxbJTaJ313bIpxB0fKgLdJVKVkmDX8n7IMJT4WADO+KH9FNMtJUCPV
 v9vAAA09OYYw4w5Wu1BOE+71jVlvnueXcg7KNeGFuAL9urS91tqLtiGFwGHkr+aKZrYC
 e27os7x7hXtkQjeFv6pfq/44OnSv05nIeLl5/PfrpDosQSHGBfWj9fJ5mtVJYKBoFKZD
 IqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792094603; x=1792699403;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dmHYcA1H4Qt5oJweXys65S+00+1nouSkSdLZdY1Pey8=;
 b=EZ9czGWr8OAUT4Zk6UJt0BdMMbGGrS4JW5LgiEANh225ARrjhm2bc3XAP9tCkABb/N
 EIcYCSkesYJyPtnFw3soCDnTm1HGjV9dsivHOGL1uW/4w/viaClzF/WN4CV9UNxbSJRS
 BbnVtdYlsx1kAkUQn/M/QHSdyhF3B2El+jvJViR1JAy1E0GtAUCTwZ5+ZuzTu3TdkmxW
 FGa7OqGimnd3WV6cqPCwTsFuGjuQUfY9VCaX68v2i1A/0d3kGn4OQ0ZFqaD09Uoe3lnW
 TE/kHARJk562mgB0l7l6HBqTkW/bfJZsJJGwbxhde5SED/IcRNq0idghE0/cZ4S8ze++
 NDcw==
X-Gm-Message-State: AFq9FYLVzZLkwy383iXViPgRvfMP71tnGV0PiEfVLVHBvDBB92K/cd6c
 F375lV0nnLsOLOP37xz3KKxSk/6YSCQbeaNUMmFJhMI/cTdWvLm46HIIkKxztp314n6lyFsy+wR
 WZlM5m01emF9KB0G7W7HH2Dm3BMm0Sxp7DVUPHnsCBgt+UXJ95QeJNiNlHMktQ0XlZw==
X-Gm-Gg: AYBFou2BmMavbOarveQOGiAZrRwIaOagmI+nfu9bcTbDwHiWMF9CNu1zx4yFouuwfSU
 ccc+P3MBn3+E80e+/OFZ/FPuBwwfxqS16Nvw4X+W9zFgUz7SD2sKGIvtqcb3Y7BlSTQR21hbZ1i
 Jzvbh7FTKdKt0mzPQ293ZJA9k2ZqhHBLlCJKIzF8Y5zbikmS9Z8Vv6LbGTljFYiPu5RAD9QxWJa
 lHnRzsgaIJu3l9Cl1N9EsRTH81UmoHvNFnExjFzjj0OGGix+IL/JA8MtmLR6r3alu+JE3BneSWW
 /SXN75HeD4fIYYRUQGh3MkHogka26DRNnnUYogrKLB4SfOiTMkHo5TFJOxq1p+aIY/Bxz5AM3eA
 o+SumQx7AioDekK9sbzPDqJzkycTU9RhJiepIh7jOkIYICRc=
X-Received: by 2002:a05:701b:2096:10b0:172:c87c:2c46 with SMTP id
 a92af1059eb24-172c87c2dfcmr20757614c88.9.1792094602296; 
 Thu, 15 Oct 2026 13:03:22 -0700 (PDT)
X-Received: by 2002:a05:701b:2096:10b0:172:c87c:2c46 with SMTP id
 a92af1059eb24-172c87c2dfcmr20757574c88.9.1792094601480; 
 Thu, 15 Oct 2026 13:03:21 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-182a6d6969asm1347058c88.12.2026.10.15.13.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 13:03:20 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com
Subject: [PULL 0/9] hex queue
Date: Thu, 15 Oct 2026 13:02:57 -0700
Message-Id: <20261015200306.1602540-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=QbvzLcbv c=1 sm=1 tr=0 ts=6ad1318b cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=7S6Y4c5DWqIhGNYimIUA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3OSBTYWx0ZWRfX9ilrb+xd+GN9
 sd1NTr+O8VHb2pck6wEkzP2LEtol7cuuYYzBoF7dQPyY/WFZHRc+32BQ1eqD5WMCDENZO7aJI18
 vExs+Zbz3xpjOJdEGPCoSXRaNaffHIw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3OSBTYWx0ZWRfX49Ki/lKMQ8np
 ubPqp9UQ/68ssyAVmve+bTX0m1HLN4btjPmSp38SbqAtMA+/BImSV46++hGzJ+2v4huuJt8yEt4
 Cf7e5PqJ+ts1Nc/Ak14POOrxSmQc8EBaYWouUdbLpF84ikIbLwnzlj/t2ydN8z42VCkTixL7Sw8
 v1rUtQvFXlHvkIVdGt9uj6xl0xQ7osSheiz6lGlepJPDQYTal30CQmJdYjX0f1aCF79RXaOrklH
 VPeCeQ8VDTYyLHwG5lwUYZ9cLWuBlCN2zghx0wSqb74/UMVA5sf0YsloMfs3Aho4tyzXAez3Acp
 3iLc9EDCjQJceWPXlFs7EHgphEYy9WZDqH58Uws1RQe9QzFV+3YkqDpoiUNWFvn7Fj33+lhI+4h
 OYhF3UQuiO2MzOdjmnwDL0PN4obSEhhu+ds54vCA/Y0oWlHF4lSoIxyrmYzB0dtthqwSuLwlUo+
 8kUWxuwqn745hZTE5fA==
X-Proofpoint-ORIG-GUID: TwY83gzw6ox_bDVBS9ClScwdRzioORmZ
X-Proofpoint-GUID: TwY83gzw6ox_bDVBS9ClScwdRzioORmZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150079
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA3ZThkM2M3ZmM0NjBmZTdjZDI4YTNl
NDIzZDc0NjZmYTI5MmJjMjY5OgoKICBNZXJnZSB0YWcgJ3B1bGwtYXNwZWVkLTIwMjYxMDE1JyBv
ZiBodHRwczovL2dpdGh1Yi5jb20vbGVnb2F0ZXIvcWVtdSBpbnRvIHN0YWdpbmcgKDIwMjYtMTAt
MTUgMTQ6NTg6MjggKzAyMDApCgphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBh
dDoKCiAgaHR0cHM6Ly9naXRodWIuY29tL3F1YWxjb21tL3FlbXUgdGFncy9wdWxsLWhleC0yMDI2
MTAxNQoKZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDM0YzkxZmVlZDA4MTdkM2FhZTZj
NmJlZGRjOTQ0NmNjZDJmNzg2MDI6CgogIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbjogYWRkIE1p
bmlWTSwgbG9jayB0ZXN0cyAoMjAyNi0xMC0xNSAxMzowMTozMiAtMDcwMCkKCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KSGV4
YWdvbjogYnVnZml4ZXMgKyBwY3ljbGUgc3VwcG9ydAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpCcmlhbiBDYWluICg5KToK
ICAgICAgdGFyZ2V0L2hleGFnb246IHJlbW92ZSBwYWNrZXQtY291bnQgUENZQ0xFIGltcGxlbWVu
dGF0aW9uCiAgICAgIGh3L2hleGFnb246IG1vZGVsIFBDWUNMRSB3aXRoIHZpcnR1YWwgY2xvY2sK
ICAgICAgdGFyZ2V0L2hleGFnb246IG1hcmsgY2xvY2stYmFja2VkIHJlZ2lzdGVyIHJlYWRzIGFz
IEkvTwogICAgICBleGVjOiBjb3JyZWN0IHRyYW5zbGF0b3JfaW9fc3RhcnQgZG9jdW1lbnRhdGlv
bgogICAgICB0YXJnZXQvaGV4YWdvbjogY2hlY2sgcHJpdmlsZWdlIG1vZGUgZm9yIHN5c3RlbSBp
bnN0cnVjdGlvbnMKICAgICAgdGFyZ2V0L2hleGFnb246IHdha2UgSzAgYW5kIFRMQiBsb2NrIHdh
aXRlcnMKICAgICAgdGFyZ2V0L2hleGFnb246IGhhbHQgb24gdGxibG9jayB3aGVuIHRoZSBUTEIg
bG9jayBpcyBjb250ZW5kZWQKICAgICAgdGFyZ2V0L2hleGFnb246IHNldCBhIHN0YXJ0ZWQgdGhy
ZWFkJ3MgZW5hYmxlIGJpdCB3aGVuIHN0YXJ0IHJldGlyZXMKICAgICAgdGVzdHMvZnVuY3Rpb25h
bC9oZXhhZ29uOiBhZGQgTWluaVZNLCBsb2NrIHRlc3RzCgogaW5jbHVkZS9leGVjL3RyYW5zbGF0
b3IuaCAgICAgICAgICAgICAgICAgfCAgIDUgKy0KIGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29u
X2dsb2JhbHJlZy5oICAgIHwgICA1ICsrCiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMyArLQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5oICAgICAgICAg
ICAgICAgfCAgIDYgLS0KIHRhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmggICAgICAgICAgICAg
IHwgICA4ICstCiB0YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCAgICAgICAgICAgICAgICAgICB8ICAg
MiArCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCAgICAgICAgICAgICAgICB8ICAgMyArLQog
aHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5jICAgICAgICAgICAgfCAxMjkgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgICAgICAg
ICAgICAgICB8ICAxMiArKy0KIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyAgICAgICAgICAg
ICAgIHwgIDg1ICsrLS0tLS0tLS0tLS0tLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAg
ICAgICAgICAgICAgICAgICB8ICAzOCArKysrKysrKy0KIHRhcmdldC9oZXhhZ29uL2hleF9pbnRl
cnJ1cHRzLmMgICAgICAgICAgIHwgICA4ICstCiB0YXJnZXQvaGV4YWdvbi9oZXhfbW11LmMgICAg
ICAgICAgICAgICAgICB8ICAgNiArKwogdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMgICAgICAgICAg
ICAgICAgICAgfCAgMTAgKystCiB0YXJnZXQvaGV4YWdvbi9tYWNoaW5lLmMgICAgICAgICAgICAg
ICAgICB8ICAgMiArLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgICAgICAgICAgICAgICAg
fCAgNDcgKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAgICAgICAgICAg
ICAgIHwgIDM2ICsrKystLS0tLQogaHcvaGV4YWdvbi90cmFjZS1ldmVudHMgICAgICAgICAgICAg
ICAgICAgfCAgIDEgKwogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19mdW5jcy5weSAgICAgICAgICAg
fCAgMTYgKystLQogdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSAgICAgICAgICAgICAgfCAg
IDggKy0KIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgIHwgICAxICsK
IHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X21pbml2bS5weSAgIHwgIDQ4ICsrKysrKysr
KysrCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSB8ICAgMyArCiAy
MyBmaWxlcyBjaGFuZ2VkLCAzNDUgaW5zZXJ0aW9ucygrKSwgMTM3IGRlbGV0aW9ucygtKQogY3Jl
YXRlIG1vZGUgMTAwNzU1IHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X21pbml2bS5weQo=

