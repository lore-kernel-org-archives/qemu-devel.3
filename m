Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574B1CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 03:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDZLT-00089S-LF; Sun, 04 Oct 2026 23:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDZLQ-00088M-4K
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 23:26:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDZLO-0000pA-C3
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 23:26:27 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69511D9p498798
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 03:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Mx/s3RlzAz7+uVrqyVMPIAXgyVHf9NRvKzpley8JlZk=; b=Cexa8woAjTW08MC8
 lT6r47mIbVfVMelr/IhZ6P/+kc39AzNBmUpgqpoquKpzZ/2PyXjsCOG/SvIlVd4C
 HR95ejmZSMlIxiyW41VNweJV05SooBulnfoBqvN1XklDV539wzRoNWd/qqVtG8Xe
 PqTY7O+scg2IZMl5kp+qRvzMMbIbjwXSvmRjRsuioO4OtvIYV3lqCbhEXsmpHeJ4
 l3XUNgSCKHvIrY+QrXFmeU1JNxlirjZVUjInkrymZ6lQjHmtbvbKNlT5ccKt/hvA
 8gDHK2/xhvDQoqD1gBbVP+d92qDK0YnayDiRbg2sI0biOQKGCQH0Dxwovhf+KqpS
 IUfgqA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xgyrjbg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:26:24 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3282d5302ffso1826239eec.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 20:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791170784; x=1791775584; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mx/s3RlzAz7+uVrqyVMPIAXgyVHf9NRvKzpley8JlZk=;
 b=MznfHyRZXwvWIDX9mpbbXvktm0c8s6sc3xzE0dzNhKt5EJ+xEkwxxZxJoOnUO8llki
 lHhDUNDH0VnKvf80LwOyifQpb713XO9/P/roFeMgzgYEbNpS3RYOORwTiQgZ+jA3JcVG
 KSa6ILYcqspu/Q8Za0Rz6Cb9oYqXnVUZtsIY87K4sXefyqDBFh8UYR2AK0+CzyAq+SzG
 GqvannjN5qCrsVXjjJb6gSYH9ghTLkHV6BRBN/e5XANCx8jto2GCGoTfq3hInnkT7pHX
 F04CJdSs7zDEdo5AWnfKBMlVxfMcMC7+aPzsMLLivVP2jNfgfHV6NN7zfZvhEhx+Ro4U
 kddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791170784; x=1791775584;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mx/s3RlzAz7+uVrqyVMPIAXgyVHf9NRvKzpley8JlZk=;
 b=N4WV5JJuLhIVGUDrYtEP7IK2KsBBizaysqs9x0QF6VU+Qad/tzL9y8dk/LA7AT8R0d
 1KB4VYR6oHRYLkOcBFmvW4s9oQVoK9GFkp5yhfHO97Q/xNQ9PVMICLPECVKX7IS1dj3B
 ab94Gx0Ip7NoUCLYU4iv7gLB0xs65OHkeMNA1+TO2MeWKJiH00TYE9aOi1oLeg5iMLPi
 hWbxFx9s2QwF32mCVAYUTkVL9wFkMqCXqyn1j5yXmFq6CbEkBYl0A6ITACOQ1wpNqchP
 uonDNkqUt6Tq+9FIwUgGPCk5Cj0wZVvuDOqxQ1cRqx+IkNgRTuIMw3MRRmI3Q5XWcSG1
 Q2sw==
X-Gm-Message-State: AFuF++nDjdCZy5srJz3ezlfRaZaFR+CG6Wn3k5E2aQ3bF+y9aluAo1kk
 X+7IwoTFzmUAVnjwAENw1ZC3ksZWurCnVMv0ofpoADWmjM/LgPuiRksutwraDrKIhzJSlecqjST
 wkcPNpsXz+W8QxfQa2PlyKqTujjktcI1so9mGsxOvpO4Rd5HF3Y34szZfWeqTw0z3WA==
X-Gm-Gg: AYBFou0Jl7BlUOi0PCSTt2RogVHNYw8UoiE6hvXwloLRrZC7fIiWeqboY96D6dZ+oZd
 CXbwOkqn5T/ZLTUwcT4+9cPclE0B8WxECbpaQSd/j/3xCJURm9OE6FLzq+EArTsQNnzMgzPL2g2
 6G5HV+b6vxJ1RJSyJDu8uIB9Gv0yy4OiYocETzFQzmjOQZEsScs/l2DR3kgcY1wlxN3eyDCYWMk
 yyjcyYj2aw+XMR914Y0OlxJOe3OFsD8Ln6Kr3D8EC2dg070XjYGxnqfQREdHiZ5LeEoo2+0FXr2
 8vy7dXjbkZQRyqUV5WSQMqK7seyiMohQMlMjWSe/i9dnexoOIrTYV7fPABVnimfa23yaYlkVxlo
 ZKuI9mZZjQCEnyi5WKqU+5Ho2MdoRRvGABHd1V8bltrL8S38=
X-Received: by 2002:a05:7022:ea8d:b0:143:808b:b178 with SMTP id
 a92af1059eb24-14dd1e422f3mr14821289c88.26.1791170784158; 
 Sun, 04 Oct 2026 20:26:24 -0700 (PDT)
X-Received: by 2002:a05:7022:ea8d:b0:143:808b:b178 with SMTP id
 a92af1059eb24-14dd1e422f3mr14821267c88.26.1791170783622; 
 Sun, 04 Oct 2026 20:26:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fcd83fadsm18596255c88.11.2026.10.04.20.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 20:26:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, richard.henderson@linaro.org,
 Helge Deller <deller@gmx.de>, Brian Cain <brian.cain@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com
Subject: [PATCH v2 04/10] target/hexagon: fix V6_vcmov reserved-bit encoding
Date: Sun,  4 Oct 2026 20:26:10 -0700
Message-Id: <20261005032616.1293829-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261005032616.1293829-1-brian.cain@oss.qualcomm.com>
References: <20261005032616.1293829-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 31hRSW9SVCg9it0aGlbFHZmDNPnv2biL
X-Proofpoint-ORIG-GUID: 31hRSW9SVCg9it0aGlbFHZmDNPnv2biL
X-Authority-Analysis: v=2.4 cv=A6b5rKWG c=1 sm=1 tr=0 ts=6ac318e0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ptefoZwEObSeWYFtGJoA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAxMyBTYWx0ZWRfXzs67bzGjt3m6
 dxa5DYd1VKPcp3vhDRK2KHt/DzYLJsNTHGBsUCtkSyi/t1hpau5/ub3Yh3y12iK+aaWRG8oZyU3
 GsYKpXuN3tchg14srgXme4ZS4lki9i0rhtMQMZmM50taAC/V1FaGPi5Fdpn++42wuBpW9NV2HCv
 Oyt0xPTH56UhDD+PdlLWpKz4CUJFRKq6DWzv/z2udD/niXZhtix0nG68MB/cOrl25DwZb9VDCVV
 lQfN9qvjwULqdjUDTjNAfuNwXrAJ2ofRMc8m+JXS3HaJ0CasX59582cC8KfyGu91TJUF20MD4Y5
 TQxBva+QL8eSB5bjZ5xCLXL3rd8jCBL1EcWj9+tu+aPpXGY2xEF6h3RCZMP39C9dkJWgM1cLopp
 pkZ7AYsALNtapfxulfyb5kQxnZiSZ9jp2MrAQMVXuSLHjK1WWuk7ekhYoXz15/sDG8C37brB5Lx
 A41Nm2+yKgx8BZfwQMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAxMyBTYWx0ZWRfX+jkT1JJYUJDW
 NyJ3CmTq4dJWH2pW3UJevwW+2oHb4AjZUYtyEZQqb7YFCmfxgo+bHRH8whJUtroUVttDpNrzpK3
 wZLhbMi4w3WTn37BwGMhVOy3bTrKrEI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050013
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

VGhlIGFyY2hpdGVjdHVyZSBkZWZpbmVzIHRoaXMgZW5jb2RpbmcgYml0IGFzIHplcm8uICBMZWF2
aW5nIGl0CnVuY29uc3RyYWluZWQgYWNjZXB0cyByZXNlcnZlZCBlbmNvZGluZ3MgYXMgVjZfdmNt
b3YuCgpSZXZpZXdlZC1ieTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21t
LmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0u
Y29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21tdmVjL2VuY29kZV9leHQuZGVmIHwg
MiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbW12ZWMvZW5jb2RlX2V4dC5kZWYgYi90
YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9tbXZlYy9lbmNvZGVfZXh0LmRlZgppbmRleCAwODRhZTNk
ODU0Mi4uYjQ2ZjUxNDkyZDkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21t
dmVjL2VuY29kZV9leHQuZGVmCisrKyBiL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21tdmVjL2Vu
Y29kZV9leHQuZGVmCkBAIC0zOTQsNyArMzk0LDcgQEAgREVGX0VOQyhWNl92c2h1ZmYsICAgICAg
ICAgICAgIElDTEFTU19DSiIgMSAwMDEgMTExIHR0dHR0IFBQIDEgeXl5eXkgMDAxIHh4eHh4IikK
IERFRl9FTkMoVjZfdmRlYWwsICAgICAgICAgICAgIElDTEFTU19DSiIgMSAwMDEgMTExIHR0dHR0
IFBQIDEgeXl5eXkgMDEwIHh4eHh4IikgLy8KIAogREVGX0ZJRUxEUk9XX0RFU0MzMiggICAgSUNM
QVNTX0NKIiAxIDAxMCAtLS0gLS0tLS0gUFAgLSAtLS0tLSAtLS0tLSAtLS0iLCJbIzJdIGlmIChQ
cykgVmQ9VnUiKQotREVGX0VOQyhWNl92Y21vdiwgICAgICAgICBJQ0xBU1NfQ0oiIDEgMDEwIDAw
MCAtLS0tLSBQUCAtIHV1dXV1IC1zcyBkZGRkZCIpCitERUZfRU5DKFY2X3ZjbW92LCAgICAgICAg
IElDTEFTU19DSiIgMSAwMTAgMDAwIC0tLS0tIFBQIDAgdXV1dXUgLXNzIGRkZGRkIikKIERFRl9F
TkMoVjZfdm5jbW92LCAgICAgICAgIElDTEFTU19DSiIgMSAwMTAgMDAxIC0tLS0tIFBQIC0gdXV1
dXUgLXNzIGRkZGRkIikKIERFRl9FTkMoVjZfdm5jY29tYmluZSwgICAgIElDTEFTU19DSiIgMSAw
MTAgMDEwIHZ2dnZ2IFBQIC0gdXV1dXUgLXNzIGRkZGRkIikKIERFRl9FTkMoVjZfdmNjb21iaW5l
LCAgICAgSUNMQVNTX0NKIiAxIDAxMCAwMTEgdnZ2dnYgUFAgLSB1dXV1dSAtc3MgZGRkZGQiKQot
LSAKMi4zNC4xCgo=

