Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA9DC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 19:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkRYz-0008Ai-Uy; Thu, 16 Jul 2026 15:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkRYy-0008A2-6R
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:16:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkRYw-0002xR-86
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:16:03 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGSlW13171758
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 19:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=FSF3D2amAOQRqqrB9H+h9O
 pmNWtVGH9XWyfCTAg5B3c=; b=P4SRNYnn/2vpagNx//Iy4KNigOwlwOZ57UgleT
 dODpZNd1wh1lsQQ94o+j6TVUumBCko3ens0i72cS/MsBNCfiPhIT7aBHt4yZgazr
 TfPiAZCP6rAlegSjQpxqULqTh9a4+cKhKcVXi6Abl/RsndBVFbSdKaCaxMURPcM8
 hib5XPPjdOoS/+hHLiLKeOGuM27eNz0axlTPv+fJYb1yKq1nQdRx9unZnABGeNm2
 fo24hI7K+Als0V1QcDyU7xZ5IoBN0HiuH9a0uWl88PCydhkVlVbxoj9PRw2KGQhN
 BFHY2xH2slGQjtS4UQsD5WcD+owgAneYecfYpaycHIVRNMPA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fevkv2m7w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 19:15:59 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88e0d11a3fso3239293a12.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784229358; x=1784834158; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FSF3D2amAOQRqqrB9H+h9OpmNWtVGH9XWyfCTAg5B3c=;
 b=NXqyaXajVcmPV1bok+OUSvIKPDYS2/9FFgbCVrioFyhEM2bNSDvvb4gOB1YT4jB+Hd
 p8jEr0NO/YGFc4D1cNAOWwZj8Z5ZM1WFB8h3R6d8G55AbAXXQKzZqQ5cY/dCM1+QSgce
 LuTTaOwxX3eQDpEbNbRtZD+sLxvRHKtrzMi35AxuE1OwI14j1w0DOuKnrRXjKabiZu12
 pPgiPhAcYLcexZgweUYZSYGcqN2hiTFJI+i1vJfiQOKMhvqMLw40+Cyyx5qenvoHY4kY
 ZIjvQcC6tHRsB+peHQdsD8VkPBXOT5u1JIx7bW/zwStSf71DNAu6jrBJ/6OucJoJQXej
 t7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784229358; x=1784834158;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FSF3D2amAOQRqqrB9H+h9OpmNWtVGH9XWyfCTAg5B3c=;
 b=kQGZWp0ZnwETjxREy/bPTKtYScUCeHGJATaUuN30cictkPKKi/7a6YbErjFmOO915i
 ls0kPXzUEnTQ7E0LJb6w3FnhsUpijA5Ca0oBG4JaxheAzXrTlhsW7fR3fApKz1HSaBFv
 YnMAhKtOEaZddlNkHPCgb9yjz1bkOmmlwunoxX4U0Wda+Fv7NIo7ulE7k8mfnemuTx4A
 QpVPBBivv3KGnn9y1CJMsclDdp9vGTSrmDWSXXrjHg5f9SjjuNdlYcpUGWSG+VLlkc9x
 EheRsVrT4SvXIslOM5fZVHnHKpP50ZQTy4eKxursTGq/abRt85y+WC1hXmL91olFXoOG
 W/aQ==
X-Gm-Message-State: AOJu0Yzcfyjm8ENUvyTH4PqLIBK1RU0IhA+/kN3wTG778jShh0Ky1hRt
 7hFn4gYUtm8BSHgTmyOX59XOUflLL9MmoZDdOxIAMcGzAHxSD0iDJcznflJ88h0RMAWOr7Ip8sr
 Y1YHoii1JWNgPvLSblu3TcUWpkoZsdv5u0NpyHS/LpkEG2yDbJZuXkvysUrFQj/5Odw==
X-Gm-Gg: AfdE7cmNREEtMbqrzHoPLDVnPBE57R6IHAtgn50pfz9v4vPr+pEHuYDvg+NRzJH5MVQ
 hLpkjpEeloFV3IiJd2tKGVtWdhUge8h/KI3VZQ/HMQH1LBqAvfYh6OCBBF0I12EbhH0An6+/bRQ
 tREM2rQAt0J6d84s/7Nphgb/Ht/siszSqr7Ru07PmJ+7om+/AerfjIz1NP7I3jnVobe0+1Vp+au
 wPjvWEtp856Mh46p/Bv0GRqi3bpx9oxXG5YdhFYYznTX6m7ZePdx3YG3SO8KVAucjAKV8FTmBEm
 9vDkex5UeZe8Bp9iBU+Nl8iIwvA1H9t+T7VMMzD6fXsEMz2AgEhVUTXMlwO5ac9DETPTX292Mzy
 VLqDCDDNhYM6VyKDDKojq8p9jSe8mnKQuzeG0ZodArBdCS9VW
X-Received: by 2002:a05:6a20:9183:b0:3c3:8b83:f19f with SMTP id
 adf61e73a8af0-3c3a5e95608mr412262637.60.1784229358107; 
 Thu, 16 Jul 2026 12:15:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:9183:b0:3c3:8b83:f19f with SMTP id
 adf61e73a8af0-3c3a5e95608mr412226637.60.1784229357657; 
 Thu, 16 Jul 2026 12:15:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13cd4344b8bsm13143885c88.13.2026.07.16.12.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 12:15:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Fix sreg writes, PC update for system reg TBs
Date: Thu, 16 Jul 2026 12:15:52 -0700
Message-Id: <20260716191555.3397687-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE5NyBTYWx0ZWRfX2bG2ToN7NkZE
 0JXa0IjAGihSpT0C8ZoL8baG5T3sWR9wqVQSPi0BZDhGuhanPfnoVeM7ww/WlzVTIbiLjntbz6y
 8yyVUR8vzSRamM8f+F/37Z3ngQcB9Dbs4bnwadX0F/zdt6hUmyWItbW19ULd8pl8hBxDoCjCzMF
 oZh1bgDACEwKZTaLzRWVe2qqxejKN7BiGh2upvrSQMzwtR4HmPxlQPLZ/VePTdK+nFbGf1N3sqH
 19kpoIYzz3kpVV0YdpID+nLdpbsbluZ+3UNaIhowygLQRnLbHzQaEgrJNAXCf0ni4JY4GSeD0qX
 sGCategAbCDGerfRrLcyblCbWR4M9z8UANTozxeAIGq+P1Dz0+SNIO7EIXuhYuO65FdryuIKl3W
 TpKpvGzuGMMfEyhdb6qwBR7ECnG+1nP0VeGtC4F+jRibI49o/tLFZte/c07FTbncQYequZTJAOY
 rsLPpyNBCGOHK4PVnJg==
X-Authority-Analysis: v=2.4 cv=WrEb99fv c=1 sm=1 tr=0 ts=6a592def cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=O2z1f2Wd96jbqaGoOxsA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: p5MmVo4YYwNKDX-pXO78RHzCyPwmmLDb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE5NyBTYWx0ZWRfX3RXxFK4EqASs
 kEKFt1gSnllBXXPrQ98ILKLXOA960yHGcT6LR+ratt2Ov32VPsYzJjzTYKfQlmKYFtUisjL5BxL
 sOkwy6v57ELjeJzNYLpyUBdH70IiOoY=
X-Proofpoint-ORIG-GUID: p5MmVo4YYwNKDX-pXO78RHzCyPwmmLDb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160197
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

V2hpbGUgcHJlcGFyaW5nIGwydmljIGRldmljZSBpbXBsZW1lbnRhdGlvbiwgSSBmb3VuZCBhIGNv
dXBsZSBvZiBidWdzCnRoYXQgd2VyZSBwcmV2ZW50aW5nIHRob3NlIHRlc3RzIGZyb20gd29ya2lu
Zy4KCnYyIGFkZHMgYSBuZXcgcGF0Y2g6IGB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb246IGFkZCBh
cmNoX3Rlc3RzIGZ1bmN0aW9uYWwKdGVzdGAsIGxpa2UgdGhlIG9uZSBmcm9tIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA3MTUxODU3MDEuMTI4NzE3Ni04LWJyaWFuLmNh
aW5Ab3NzLnF1YWxjb21tLmNvbS8KYnV0IG9taXR0aW5nIHRlc3RfaW50X3N0ZWVyaW5nIHdoaWNo
IGRlcGVuZHMgb24gbDJ2aWMuCgp2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZl
bC8yMDI2MDcwOTIzMDY0NS4zMDMzMjQwLTEtYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tLwoK
QnJpYW4gQ2FpbiAoMyk6CiAgdGFyZ2V0L2hleGFnb246IGluaXRpYWxpemUgZGVmZXJyZWQgc3Jl
Zy13cml0ZSB0ZW1wcyB0byBjdXJyZW50IHZhbHVlCiAgdGFyZ2V0L2hleGFnb246IGZpeCBQQyBu
b3QgYWR2YW5jaW5nIGZvciBub24tQ09GIFRCLWVuZGluZyBwYWNrZXRzCiAgdGVzdHMvZnVuY3Rp
b25hbC9oZXhhZ29uOiBhZGQgYXJjaF90ZXN0cyBmdW5jdGlvbmFsIHRlc3QKCiBNQUlOVEFJTkVS
UyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKwogdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmggICAgICAgICAgICAgICAgICB8ICAzICsrCiB0YXJnZXQvaGV4YWdvbi9nZW5w
dHIuYyAgICAgICAgICAgICAgICAgICAgIHwgMTQgKysrLS0KIHRhcmdldC9oZXhhZ29uL3RyYW5z
bGF0ZS5jICAgICAgICAgICAgICAgICAgfCA1NiArKysrKysrKysrKysrLS0tLS0tLQogdGVzdHMv
ZnVuY3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICB8ICA1ICsrCiB0ZXN0cy9mdW5j
dGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5IHwgNTcgKysrKysrKysrKysrKysrKysr
KysrCiB0ZXN0cy9mdW5jdGlvbmFsL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgIHwgIDEgKwog
NyBmaWxlcyBjaGFuZ2VkLCAxMTYgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pCiBjcmVh
dGUgbW9kZSAxMDA2NDQgdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxkCiBjcmVh
dGUgbW9kZSAxMDA3NTUgdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5w
eQoKLS0gCjIuMzQuMQoK

