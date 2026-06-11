Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C21CD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY8Y-0007yU-V2; Thu, 11 Jun 2026 01:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY8J-0007t6-3D
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:39:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY8G-0004t5-Rm
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:39:14 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GQ853817138
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Px1q1arDkToOKAPbd05fKQ
 OxqE9YaSsEw9rxSeDnaYA=; b=O6sygTaH5IETG2C/bxk9vStXjXi3nHtdS2wKus
 oaggU6rIf21qXf0WewXcNWvcbvKTbbdSBolmM1MLB+feajaLTK7HYVvp6rcS2UJh
 IYZPu27FFuLcL2W3w8ZM4BR9bMzt5JVz6T58dAv5lou0WM/U2HQet8NKU+ipWCCn
 2gJV3cYjT901TUCvcaaXH4ojWebbSvO3gK/TQVydd0M0k2cacTUYz2gVWcjdfCE9
 jxLlIByD0A0FA6ks6llGmUfqZgjD1J/w3ghPsJomGKJCL74wZJOE3L7TFW3ZeiEJ
 Loixu72dp5hkJISo2WHIhPrCSWNc6iBdVcbX6O14J1pdDWEQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6ust29-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:39:08 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-307fe856724so1898922eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781156348; x=1781761148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Px1q1arDkToOKAPbd05fKQOxqE9YaSsEw9rxSeDnaYA=;
 b=eh8yotB8JAGPCwpTnb9fsANcYYSATdzYSUlj4F3zK+Edg6Jh/2tBaGSo49VO8P2TiR
 hj5TfCTgJjoXWjtY15SghlWJTj3869dXPSRt07NS0/L8vsmYO6i+KUZrijxv+u1reOXq
 a03gpsqX4Uwbv8Rv6S/EvsDQ5qntbLGSFqsFZE7jIvGfDihFkbNfQPdUcwabpP0eGl7J
 whO/9xjGfPOnXRlbyxuH8GgepYqu+H1dtbMDlIEEeltIjqHnWem4MvDyJGa+bevn+yPY
 zdEryK8MTnUev/vBpyvbi8yO81GyraF1p0kbi9D81R9ATyMkBB44O5ZzMgpXoYTCwBFg
 fhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156348; x=1781761148;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Px1q1arDkToOKAPbd05fKQOxqE9YaSsEw9rxSeDnaYA=;
 b=RmT9ObqWhQiA3/20K93KidEarXGG/q00SxQ7S6Cc4osDuc3kOhitQGdHCPP8wXlREw
 HfkuUHsz2Zuv05dJzcqeNPGyQQBPrz+Jj1fRuzK5TME33nyet1pZLKPfR3xxF+zUTFKH
 GrlNTPF8C47QUs3RrJkR0JJ6A0c1iIwnIZJESYSeLvLQxofS4ObSJa0tBFivPqdobj6g
 nwM73WX9lndDMfcZPoESfTdJUQLXtkcQu8NAvUuJlakPfQm0SMjv8rwL4QwccrtT8Q2E
 eA3/AWXh1Ia5vaRA5DSfa8CLuoRY3nYvNDXeHBNjd8I5twosGEvkpezzTSVhwtFBdyax
 SNHg==
X-Gm-Message-State: AOJu0Yz8MXFWTo5OVazLZRcZiNj0Tjl7akHcddW+MSNL8xwu+neQwOGB
 0WYpcDg+boRZbMy+yzfjr+9IPPx7iAU/ChEHAS/vF39q3irHjrwQErWbgqkayrhQqCuP5Wdz08t
 DPXjtVMs6t8+v6YNzArTustf5rweMjyG4rppgH1qp1h+GEa88E7rI2+HyMPnSUkbDCw==
X-Gm-Gg: Acq92OGlwO5rnFVs8xAWd2Kgp6WKJvmDRvIVBN4pek8h0dvyvQ7HJqsfJ/faIP3GnO5
 IKxJqHPW3Zk8JoFE+j210SBzZAodU8UCxBLFMyzZlbR9CfhRlpOyTiqeVeDXdUiQnHE/NXsAgU6
 2y9MCGif8anjQeLWm65nEx0LbLPQ0MA3yhBxOFsBOHabfMrUhxilE3PwpUB44FYjl6XtcRqODNb
 t3tK0mGQXKu3oT2+2Ce2gbWVMxnebG/JXL3TdKNlX6aN2s1+Ihruay4dD2vDcDxrLp8X+LzyCqa
 byH7/PcnGESAYotIrwAcBNyMZ8JoMZNHRZZSKZ3Ra7KJnM13QJ5RuSjTPWVIzpUQWu9IOljrvSg
 uIIUfbUMJRjhkCGJ5tAYuPdzqsRF9e43FzFZ4GMPZkfrrht7AoUnWbOLKF/Z/1xfRMVFclARHUq
 Nn//tA
X-Received: by 2002:a05:7301:5f84:b0:304:67ef:41db with SMTP id
 5a478bee46e88-30804bac904mr1186984eec.28.1781156348257; 
 Wed, 10 Jun 2026 22:39:08 -0700 (PDT)
X-Received: by 2002:a05:7301:5f84:b0:304:67ef:41db with SMTP id
 5a478bee46e88-30804bac904mr1186969eec.28.1781156347757; 
 Wed, 10 Jun 2026 22:39:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a9fesm735778eec.16.2026.06.10.22.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:39:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com
Subject: [PATCH v7 00/9] Hexagon system emulation - Part 3/3
Date: Wed, 10 Jun 2026 22:38:53 -0700
Message-Id: <20260611053902.3927367-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=FJ8rAeos c=1 sm=1 tr=0 ts=6a2a49fd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=YJdtpyM7O4cuCvoz8cYA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MyBTYWx0ZWRfXw8VsO/M4LuXJ
 a8XuML3OiJf3njz2qPm8p+J91oTw9jWcG3zgBN6Oscn5zuj9rG4h4r+4per5qxa70DwYqSTwPR6
 APacaM5F3YKE10nlign3XtKlPmy1I+U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MyBTYWx0ZWRfX2KpNhlHG9Rt2
 KSX+LW8BRO879AlcTW+D5plEjTTt4UvKBMgjXDXnc7uVFZJ2LxHNtmkV7kJUxt1k4RtqKEsP+gF
 VTlPeYHj80KScFMjkhVjd2YcPQXPwg6gJjMypW/f4zZZdAcMarbxLBVNIJRcCBcalSGSbdnA54I
 zfQIwyhOxzwwl0/bdsjEa/MK8cazQQaOCiEv92GoI2JVYPelNeaRI5Eszj2h1lzxJ2/ZCtAi9+s
 gqAyI5LpMr8s4o6M5b70eExyGYeI48+6Q0FNkJxuWNPcAbUkiLW9vV33pyv8UURTPiqlzGP4Jxk
 WNpPsB3O7FyvEshG6BSFc4/sOL2EsrL4nFGbBe5P9C1gUwwjCyG4npB0OJOY+FO/wnauOOhEjiQ
 ib7zvMdq6ijc4MQfQvHteRaD2ciEee0m+KJqAoBxkiTufOpfQrhGRuBnnt4vt53fSvs0uXPr3iP
 FrXQnOG3K+AGUCPQBLA==
X-Proofpoint-GUID: 0PaYhQDc_JMaeM7RDmuCKnMMrXjQmKn6
X-Proofpoint-ORIG-GUID: 0PaYhQDc_JMaeM7RDmuCKnMMrXjQmKn6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110053
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

VGhpcyBpcyBQYXJ0IDMgb2YgdGhlIEhleGFnb24gc3lzdGVtIGVtdWxhdGlvbiBzZXJpZXMuICBJ
dCBhZGRzIHRoZQpib2FyZC1sZXZlbCBzdXBwb3J0LCBtYWNoaW5lIGRlZmluaXRpb25zLCBhbmQg
YnVpbGQgaW5mcmFzdHJ1Y3R1cmUKbmVlZGVkIHRvIHJ1biBoZXhhZ29uLXNvZnRtbXUuCgpUaGlz
IGluY2x1ZGVzOgogIC0gR2xvYmFsIHJlZ2lzdGVyIG1vZGVsIChRT00gZGV2aWNlIGZvciBzaGFy
ZWQgc3lzdGVtIHJlZ2lzdGVycykKICAtIEdsb2JhbCByZWdpc3RlciB0cmFjaW5nCiAgLSBIZXhh
Z29uIFRMQiBkZXZpY2UgaW1wbGVtZW50YXRpb24KICAtIE1hY2hpbmUgY29uZmlndXJhdGlvbiBk
ZWZpbml0aW9ucyAodjY2ZywgdjY4biwgc2E4Nzc1LWNkc3AwKQogIC0gY2ZnYmFzZSBzdXBwb3J0
CiAgLSBIZXhhZ29uICJ2aXJ0IiBtYWNoaW5lIGRlZmluaXRpb24KICAtIEJ1aWxkIGNvbmZpZ3Vy
YXRpb24gZm9yIGhleGFnb24tc29mdG1tdSB0YXJnZXQKICAtIEJvb3Qgc2VyaWFsIHRlc3QgZm9y
IGhleGFnb24KCkJhc2VkIG9uIFBhcnQgMSB2OCArIFBhcnQgMiB2Ni4KCkNoYW5nZXMgc2luY2Ug
djY6CiAgLSBNb3ZlZCBoZXhhZ29uIFRMQiBkZXZpY2UgaW1wbGVtZW50YXRpb24gZnJvbSBQYXJ0
IDEgaW50byB0aGlzCiAgICBzZXJpZXMgYXMgYSBuZXcgcGF0Y2ggKCJBZGQgaGV4YWdvbiBUTEIg
ZGV2aWNlIGltcGxlbWVudGF0aW9uIiksCiAgICBmb2xsb3dpbmcgdGhlIGludGVyZmFjZSBkZWNs
YXJhdGlvbiBub3cgY2FycmllZCBieSBQYXJ0IDEKICAtIFJlbW92ZWQgIk1vZGlmeSBTdGFuZGFs
b25lIHN5bWJvbHMiIHBhdGNoOyBpbmNvcnBvcmF0ZWQgY2hhbmdlcwogICAgZGlyZWN0bHkgaW50
byAiQWRkIG1hY2hpbmUgY29uZmlncyBmb3Igc3lzZW11IgogIC0gRHJvcHBlZCBNQUlOVEFJTkVS
UyBkb2MgcGF0aCByZW1vdmFscyBmcm9tICJBZGQgbWFjaGluZSBjb25maWdzIgogIC0gImFkZCBi
dWlsZCBjb25maWcgZm9yIHNvZnRtbXUiOiByZW1vdmVkIENPTkZJR19MMlZJQyBmcm9tCiAgICBk
ZWZhdWx0Lm1hazsgcmVtb3ZlZCBzdGFsZSAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkgYmxvY2sg
ZnJvbQogICAgY3B1Lmg7IGFkZGVkIEFja2VkLWJ5IGZyb20gUGhpbGlwcGUKICAtICJEZWZpbmUg
aGV4YWdvbiB2aXJ0IG1hY2hpbmUiOiByZW1vdmVkIGwydmljIGludGVncmF0aW9uOyBzaW1wbGlm
aWVkCiAgICBmZHRfYWRkX3VhcnQoKSB0byBkcm9wIGlycV9waGFuZGxlIHBhcmFtZXRlcjsgcmVt
b3ZlZCBWSVJUX1FUTVIsCiAgICBWSVJUX0dQVCwgVklSVF9NTUlPIG1lbW1hcC9pcnFtYXAgZW50
cmllczsgYWRkZWQgUi1iIGZyb20gUGllcnJpY2sKClByZXZpb3VzIHZlcnNpb25zOgogIHY2OiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwNTI5MjE1OTM3LjYxMDIyOS0x
LWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KICB2NTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcWVtdS1kZXZlbC8yMDI2MDQxNjIxMDMwNS4yMjU1NTc5LTEtYnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tLwogIHY0OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYw
NDA4MDQyMTQ5LjE5MDI3OTYtMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20vCiAgdjM6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjAzMTEwNDIwMTkuMTA4NTAzMC0x
LWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KICB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcWVtdS1kZXZlbC8yMDI1MDkwMjAzNDk1MS4xOTQ4MTk0LTEtYnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tLwogIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjUw
MzAxMTcyMDQ1LjEyOTU0MTItMS1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20vCgoKQnJpYW4g
Q2FpbiAoOCk6CiAgaHcvaGV4YWdvbjogQWRkIGdsb2JhbHJlZyBtb2RlbAogIGh3L2hleGFnb246
IEFkZCBnbG9iYWwgcmVnaXN0ZXIgdHJhY2luZwogIGh3L2hleGFnb246IEFkZCBoZXhhZ29uIFRM
QiBkZXZpY2UgaW1wbGVtZW50YXRpb24KICBody9oZXhhZ29uOiBBZGQgbWFjaGluZSBjb25maWdz
IGZvciBzeXNlbXUKICBody9oZXhhZ29uOiBBZGQgdjY4LCBzYTg3NzUtY2RzcDAgZGVmcwogIHRh
cmdldC9oZXhhZ29uOiBhZGQgYnVpbGQgY29uZmlnIGZvciBzb2Z0bW11CiAgaHcvaGV4YWdvbjog
RGVmaW5lIGhleGFnb24gInZpcnQiIG1hY2hpbmUKICB0ZXN0cy9xdGVzdDogQWRkIGhleGFnb24g
Ym9vdC1zZXJpYWwtdGVzdAoKU2lkIE1hbm5pbmcgKDEpOgogIGh3L2hleGFnb246IEFkZCBzdXBw
b3J0IGZvciBjZmdiYXNlCgogTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAxMyArCiBjb25maWdzL2RldmljZXMvaGV4YWdvbi1zb2Z0bW11L2RlZmF1bHQubWFr
IHwgICA3ICsKIGNvbmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLXNvZnRtbXUubWFrICAgICAgICAgfCAg
IDggKwogbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAr
CiBody9oZXhhZ29uL3RyYWNlLmggICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICsKIGlu
Y2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmggICAgICAgICAgICAgICAgfCAxNjEgKysrKysrKysr
KwogaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmggICAgICB8ICA1NSArKysr
CiBpbmNsdWRlL2h3L2hleGFnb24vdmlydC5oICAgICAgICAgICAgICAgICAgIHwgIDMwICsrCiB0
YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgICAgICAgICAgICAgICAgICAgIHwgICA1ICstCiBody9o
ZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYyAgIHwgIDY0ICsrKysKIGh3L2hl
eGFnb24vbWFjaGluZV9jZmdfdjY2Z18xMDI0LmguaW5jICAgICAgfCAgNjQgKysrKwogaHcvaGV4
YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMgICAgICB8ICA2NSArKysrCiBody9oZXhh
Z29uL2hleGFnb25fZHNwLmMgICAgICAgICAgICAgICAgICAgIHwgMjI0ICsrKysrKysrKysrKysK
IGh3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuYyAgICAgICAgICAgICAgfCAzMTYgKysrKysr
KysrKysrKysrKysrKwogaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5jICAgICAgICAgICAgICAgICAg
ICB8IDQ2NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBody9oZXhhZ29uL3ZpcnQuYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgMzQ3ICsrKysrKysrKysrKysrKysrKysrKwogc3lz
dGVtL3FkZXYtbW9uaXRvci5jICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQogdGFyZ2V0
L2hleGFnb24vY3B1LmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAtCiB0YXJnZXQvaGV4
YWdvbi90cmFuc2xhdGUuYyAgICAgICAgICAgICAgICAgIHwgICAxICsKIHRlc3RzL3F0ZXN0L2Jv
b3Qtc2VyaWFsLXRlc3QuYyAgICAgICAgICAgICAgfCAgIDggKwogaHcvS2NvbmZpZyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArCiBody9oZXhhZ29uL0tjb25maWcgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDE0ICsKIGh3L2hleGFnb24vbWVzb24uYnVpbGQgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDcgKwogaHcvaGV4YWdvbi90cmFjZS1ldmVudHMgICAgICAg
ICAgICAgICAgICAgICB8ICAgMyArCiBody9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICAxICsKIHRhcmdldC9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDEgKwogdGFyZ2V0L2hleGFnb24vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAg
ICB8ICAgMiArCiB0YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgIHwg
IDEzICstCiB0ZXN0cy9xZW11LWlvdGVzdHMvdGVzdGVudi5weSAgICAgICAgICAgICAgIHwgICAx
ICsKIHRlc3RzL3F0ZXN0L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKwog
MzAgZmlsZXMgY2hhbmdlZCwgMTg3OCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKLS0K
Mi4zNC4xCg==

