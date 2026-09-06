Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E24C79F99
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 22:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3LJR-0006G5-3F; Sun, 06 Sep 2026 18:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3LJK-0006Ep-Bw
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 18:26:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3LJI-0003a9-L7
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 18:26:02 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 686L9LH3883795
 for <qemu-devel@nongnu.org>; Sun, 6 Sep 2026 22:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lymf1mpJPKqLFwRjRgvV1s6zoYYYzfPRa3SVc1O4Nq4=; b=QXrM3OSzGD3fHMPh
 zUvqNIBjSD9F66YVEQUv63B8x08h/pHBRmXotKsMG7ETH5HU3t3fgqlzcXRkitGf
 va3nJvDTk2seKPyI3BM8iP17ITTBEkPjqMU2AI6QC/nuSYmK7C9DFoaJGXPyI9si
 TweQ6U+wfMHQFZP8YLzr7p7xjl3d1PkN68+CeTnmEKPBjh1gV+9CVzt0LOPws3bg
 eDbzQX3IW8HmGamgOqKmNFGCqDCknwnUQc18BMFsQ6IFu3bUg/t+EKqtvkAzhyWm
 rD3qdfOKD6m01ZWe7vsdz8f378shV2YdFF7V9JRBvwAkZqP8kKZTKh/PpB267BF+
 8zQEyA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggc8jc59g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 22:25:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d7293f13c6so35572425ad.2
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 15:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788733558; x=1789338358; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lymf1mpJPKqLFwRjRgvV1s6zoYYYzfPRa3SVc1O4Nq4=;
 b=cyXkRMuqKjLcCVMUWeJhKRjMKBBvJMLyJ0ctL9tvVjz4olypsmHPjHd+LkyhtI2OQw
 EgM79T3JIRHNN7MXF1ra/Uy3Eug5VSe8qkxlbSzqOYw4s2JcCdQyyaAuhdiqk6eVWszP
 NCU9NAqHFBcWZoMgNPPwzQhMPvm8vNEe1DryHoh7S4s0/ZBhDx1scKqJKffBn9cicn33
 tiIvg2r2bo6Za0sgjU2KJ1a0qEFMNgJ+Pj9qK4kEgIv3FSylmm0DGv5f/5gZ405moliV
 rgEsvIcEf4iz8SAQ3B6J9lpLlUg6PygCANRcA20nBczmxcu/n1ziS/1JJ59Oin2xLIhc
 tyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788733558; x=1789338358;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lymf1mpJPKqLFwRjRgvV1s6zoYYYzfPRa3SVc1O4Nq4=;
 b=In7ZP05/2Fu1Tl4nIhstJGydvTQT7qHjblf/JXD3nRgeJiXZe2q6Zw0arelTF7TmMR
 FZiLnX8zKMPdFg3k9IEwcC8L/bXUTsPUjSmPzMwLAEMuz+vpXY+G4kPoQEPnQX3/xAUI
 /CbFkVOatksKZn+r7h7kjO/L/DJzl1SEIh3sEUEFBGkvbdf0jAnsmJKVhg4T0Lihjdr/
 KpfwtVKMOaqW4in2eNbxLUal2AFRPrg4Nm8TcIm0sn7ka8qoIdsZ3pru+0ZZETcCSphS
 th9vGT4bUw2t4BAgGC44stp1aZc3jPTDCCRXzLhHgh9Bf8lTJ0ybw+/cS5G4nZVUcBKS
 nXAw==
X-Gm-Message-State: AFuF++k4B8OY//5q/U+N1of3OgqFheTX73XaHcoDdtwOlsBqTD/4DnCb
 ESVxjDtv8+YitOUPX+1skcC47I5pIgcUp86yaOCo2Oxu/pC8nTBxlns/7PXNkk/ky/1KtYnXgPw
 ZoEy7Dc+jE82DN6Mnta0u97x1PM0A1ptcJsW8vsuA2dUhcjQn9QnzFM0lUMLg8JWXuQ==
X-Gm-Gg: AYBFou0TuIvpRaD9tJV/VfT5/oeomkbeKrdWPCwceGV0E31zb0kprFHJBag/utVfI3Y
 zwJTxwIdbZ8Vhewt0F3Yt67mDd7JdKCW0yWMmy8V7jzUyw33p94R3rlq17OeD+viiIp7rKCUDbH
 h/ui162n5RbXZG7MVowO+RI0BTqm93R8EtDsD/DB74TIHX6fQ+0jWeZAUBKMTqfzOdPXcMTdChS
 EnJ0Juw1N8bRSrz3hc1OSHakQHccevZzg0NbPOdfoVuBg7DuN+Tu3UU33Bjbtq3JP23ceGaTvin
 UjzHDBOnslbYHIT1/AnOY7y+iibllA5luXCRzyWcanPTrGxgRW5c421ha19mUIuEu+cRFKceMx5
 bD5tbFWphgW0C1kyk5VUd4L4jXvdAcx46a+Sf9SvXrDaOGKa2
X-Received: by 2002:a17:903:3810:b0:2d6:3c22:99bf with SMTP id
 d9443c01a7336-2db124afcefmr298686945ad.9.1788733558298; 
 Sun, 06 Sep 2026 15:25:58 -0700 (PDT)
X-Received: by 2002:a17:903:3810:b0:2d6:3c22:99bf with SMTP id
 d9443c01a7336-2db124afcefmr298686525ad.9.1788733557733; 
 Sun, 06 Sep 2026 15:25:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339ac24d7esm34936605eec.15.2026.09.06.15.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 15:25:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peter.maydell@linaro.org, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 3/3] target/hexagon: Fix semihosting ACCESS filename handling
Date: Sun,  6 Sep 2026 15:25:51 -0700
Message-Id: <20260906222551.3712954-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260906222551.3712954-1-brian.cain@oss.qualcomm.com>
References: <20260906222551.3712954-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: pXitD1LeQYuxleUzlbUJqIx3LIVQi4bu
X-Proofpoint-ORIG-GUID: pXitD1LeQYuxleUzlbUJqIx3LIVQi4bu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDI1MCBTYWx0ZWRfX/cBDkWkDMD7D
 /cae1WtCR9dXGerlYTk+it09HMxiOisTLiWzS9JrrT+n0OOoXXC8oCqgV+OZCU/yUD77t0YD9Dh
 jwCI6ooToIH5AefxRheQkhj/DOhmfshRSPFpkHlcKq2gXlZkGcmK151LbpmScxk2Lbf0z0FQC5d
 hN/Qpwe24AeTeBeHXS60xUlSpJJLf8gVo7oIralVk598NmGoF8+kVzSyLkku65LGPrzGzZGLzr6
 mSV0+9cvUZHCLOyaEpKC9UpKIJA3+ozEiyOxQkl+K7ZZ3D0wVpKoDwn4CbqvPM6FudddQk3P+/C
 X2CIyQpIvvqm64ZSpoVJc0dZYjSJfnrh3Z52IF5HxyKiwsryRXM93NPDQ1Llqb4GSxMCNImosMp
 CMidZtKS60D8zer7MRdTiu5gnStWu6EsQ27Y6IBSBm7komIg07Ryd9O3OZLK+IPBMvfHHMlKB9N
 7E3ShNQDQWVjGkcUB8A==
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a9de876 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pS50CBgNNeok3lFgILkA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDI1MCBTYWx0ZWRfX11uGm/FSDcBt
 TO3xPJtcBVXXrdMx5EDAVsZ98epujeTApQneb3c8Ad6t76rm9FGMGXjr4qeMUG9pUYgDSii1NvV
 nv+dYCdBJhVlrSS65432sjoMj/ihWxM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609060250
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

SEVYX1NZU19BQ0NFU1Mgd3JvdGUgYSBOVUwgYnl0ZSBwYXN0IGl0cyBmaXhlZC1zaXplIGZpbGVu
YW1lIGJ1ZmZlciB3aGVuIHRoZQpndWVzdCBzdHJpbmcgZmlsbGVkIGl0LiBVc2UgbG9ja191c2Vy
X3N0cmluZygpIHRvIGF2b2lkIHRoZSBvdXQtb2YtYm91bmRzIHdyaXRlLgoKRml4ZXM6IDc3MTFm
ZGJhODhiICgidGFyZ2V0L2hleGFnb246IGFkZCBtYWluIGFyY2gtc3BlY2lmaWMgc2VtaWhvc3Rp
bmcgb3BlcmF0aW9ucyIpClJlc29sdmVzOiBDb3Zlcml0eSBDSUQgMTY4NTk0MgpMaW5rOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FGRUFjQTlNT3M2VmZIZjJVSFo4ejRjZHZhQis3RFk2
aEpiMmVtWVoyYUxTZS10Nml3QG1haWwuZ21haWwuY29tLwpTdWdnZXN0ZWQtYnk6IFBldGVyIE1h
eWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2Fp
biA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hleHN3
aS5jIHwgMjEgKysrKysrKysrKy0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4
c3dpLmMgYi90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYwppbmRleCAxOGQ3M2I0OTFhMC4uMWM2OTBj
ZjM3ODkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL2hleHN3aS5jCkBAIC02MDMsMjUgKzYwMywyNCBAQCBzdGF0aWMgdm9pZCBzaW1faGFu
ZGxlX3RyYXAwKENQVUhleGFnb25TdGF0ZSAqZW52KQogCiAgICAgY2FzZSBIRVhfU1lTX0FDQ0VT
UzoKICAgICB7Ci0gICAgICAgIGNoYXIgZmlsZW5hbWVbQlVGU0laXTsKKyAgICAgICAgY2hhciAq
ZmlsZW5hbWU7CiAgICAgICAgIHVpbnQzMl90IEZpbGVOYW1lQWRkcjsKICAgICAgICAgdWludDMy
X3QgQnVmZmVyTW9kZTsKLSAgICAgICAgaW50IHJjOwotCi0gICAgICAgIGludCBpID0gMDsKKyAg
ICAgICAgaW50IHJjLCBlcnI7CiAKICAgICAgICAgaGV4YWdvbl9yZWFkX21lbW9yeShlbnYsIHN3
aV9pbmZvLCA0LCAmRmlsZU5hbWVBZGRyLCByZXRhZGRyKTsKLSAgICAgICAgZG8gewotICAgICAg
ICAgICAgaGV4YWdvbl9yZWFkX21lbW9yeShlbnYsIEZpbGVOYW1lQWRkciArIGksIDEsICZmaWxl
bmFtZVtpXSwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0YWRkcik7Ci0gICAg
ICAgICAgICBpKys7Ci0gICAgICAgIH0gd2hpbGUgKChpIDwgQlVGU0laKSAmJiAoZmlsZW5hbWVb
aSAtIDFdKSk7Ci0gICAgICAgIGZpbGVuYW1lW2ldID0gMDsKKyAgICAgICAgZmlsZW5hbWUgPSBs
b2NrX3VzZXJfc3RyaW5nKEZpbGVOYW1lQWRkcik7CisgICAgICAgIGlmICghZmlsZW5hbWUpIHsK
KyAgICAgICAgICAgIHNlbWlfY2IoY3MsIC0xLCBFRkFVTFQpOworICAgICAgICAgICAgYnJlYWs7
CisgICAgICAgIH0KIAogICAgICAgICBoZXhhZ29uX3JlYWRfbWVtb3J5KGVudiwgc3dpX2luZm8g
KyA0LCA0LCAmQnVmZmVyTW9kZSwgcmV0YWRkcik7CiAKICAgICAgICAgcmMgPSBhY2Nlc3MoZmls
ZW5hbWUsIEJ1ZmZlck1vZGUpOwotICAgICAgICBzZW1pX2NiKGNzLCByYywgIHJjID09IDAgPyAw
IDogZXJybm8pOworICAgICAgICBlcnIgPSBlcnJubzsKKyAgICAgICAgdW5sb2NrX3VzZXIoZmls
ZW5hbWUsIEZpbGVOYW1lQWRkciwgMCk7CisgICAgICAgIHNlbWlfY2IoY3MsIHJjLCAgcmMgPT0g
MCA/IDAgOiBlcnIpOwogICAgIH0KICAgICBicmVhazsKIAotLSAKMi4zNC4xCgo=

