Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C716010F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYN1-0007Av-IA; Wed, 08 Apr 2026 15:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAYJz-0001Kx-Mb
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:12:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKPJ-0005ct-6g
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:55 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637M3Luw1619750
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eDXxY8veDppPGZYB4pvyhydqmDwea2dSVqYJLsKwO3E=; b=IafqgEBUstDrhJzv
 JMSNGpDkUKq1Ws11RTBe3+WV4aTVwx2twf15D27E1Hw7Chu3FpfS6dmsMSckqbAK
 OoZQAPJCwFUIDp2BYxIDdMwczsfbr0ncRO9h136lGiVuVLW+Ouyfzvf2dXGHdpwG
 dv95Byp09gEqS/u4WLh5SpjyZ1FnK/oE6jzskKoHkkfnwLY0KcjYrTKbllGFE1sN
 z1SGPmzRH2MSTZ5Esj2xxYoXh9aKrkOIbuBVZCELAsK1We8Vioy5SLJrWi+uORoR
 Cnjr4IfVjrHi2CdSlU6X1YMyAJRo6MC1t11qt+GJ82mJWuEFEJh0A84IVvsgW1yX
 oZP7Qw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddacrgxjr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:36 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1279caef718so9083044c88.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622035; x=1776226835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDXxY8veDppPGZYB4pvyhydqmDwea2dSVqYJLsKwO3E=;
 b=A8GYssb476l/NZKY/GJmG56UaruBmLkGOTJGxOApTwtRr/Qz5iXn3JHW6x1rvXi+s9
 5wpv0TJrd9x2nx/hkNcf8B2bA+EZzfNkNLRp7leNIdD5Xj/dpYS++mOFoVRQ0ykQb/H1
 Uc7UuTeUkPK79n+vJagTJTn+3K1cPyNwWoEL9KMHaWtbtgEq46TawD2jangHuzOGsgnv
 7ousko5FrNjcuIGEjyz/DNPKbN2q0CQOMZCE7HAKh4dpm+qu5JLkcQ0W9Y2j7mOxxkiX
 +PWdru1FL0G+PSqLd8zf/3+dcLU8GJU8yYKkiFi9lwXgIiAUW4zqhSD/8/iJauYx1I2T
 d4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622035; x=1776226835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eDXxY8veDppPGZYB4pvyhydqmDwea2dSVqYJLsKwO3E=;
 b=aTTi8UqzLd3v+ezwYQcnmVOj1DWidYwyqOISd+XopQ0aHDQ8D9MHHdytZWSBtESM06
 JP2e0M6eL3FsZM24z98RTrsXUT/B1SUlmYXsxHWiRP2StRCOyAL9dDmQOQ16Hil6h4Oe
 rrTjPlU2qYdN5MDOCr2wmo2tP/CPsZ8xgEyc8dhRzYgfAMp2A+vZh8fJLFwCfnq+KuhP
 aPs7Cn+S+ZISfpAirvC/MGbPBmuaydMV2TwRJrlckMrEtVFq5ysXscWCoJjJKpF2tk41
 dYEXxqMsh7T5qjmEFepHTToEL2FH6P3QObe10fmR3Zho6iaqzCWZAf2UTRlsQV24LEYj
 yEnw==
X-Gm-Message-State: AOJu0YzGgx0cel2WmzD4UNzacvPwQDlvi6IZG55/BvOVLuoZyZul2xcP
 H4elzuYlMy1yzXhtkr+RSCU+GBVSFW15d/vZcHeLMn/mqJ4kPVTp8R+wIuuvicdMZoGAbhCTLGA
 O0AEQZ0k/sDlSvuzAFJt25tP3VnyQwbyW/VP0KjJQb3jUq+xbnplT+jFoms5lrNav6A==
X-Gm-Gg: AeBDietCzrvT2Ws7PZ9N+L7zfWl/hTyxYH10i+pQ7abPUgLzjQBZS0TpZVcPT/EH95k
 i5fT8PsX2L3fmcx4DDmvatYeLAAhBosdmsQGlOknvd0gcJiUoPc57XCl1XHjefAlnE673bESqlF
 QDDV/iXEoxYejIvZDMDx7G0jyOIIok0FGOm9EcPRGf9jNzxr0BFvtVOdRV9VwvMmBhUNjhWONQI
 iTMitGnmFWuAdBMqw3zAQwY+33l76uYql72Y0NXV9bu4v+Mm21vEzZBJLss+mSXXwM/YutUZ/Mc
 zA1QfHtb9SKVaSCxt96ViiZkg3MXT8TJ3ZZCKJuybdAk0/Tm+f2ZL5Q8STQg7yB8nww0ERSKbOq
 hf5QxWFGhR/WcA4VRoioNCCEBYEgpumxllOnHPifRQ0PyBwhOFZFZkOnjfiuCG8clPPnblw==
X-Received: by 2002:a05:7022:e14:b0:127:35af:1446 with SMTP id
 a92af1059eb24-12bfb778c4dmr9876277c88.36.1775622035419; 
 Tue, 07 Apr 2026 21:20:35 -0700 (PDT)
X-Received: by 2002:a05:7022:e14:b0:127:35af:1446 with SMTP id
 a92af1059eb24-12bfb778c4dmr9876261c88.36.1775622034929; 
 Tue, 07 Apr 2026 21:20:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 26/28] target/hexagon: Add TCG overrides for transfer insts
Date: Tue,  7 Apr 2026 21:19:51 -0700
Message-Id: <20260408041953.1899532-27-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: -91ds-W0TGBux9kOdCSqf6hroONDq_sR
X-Proofpoint-GUID: -91ds-W0TGBux9kOdCSqf6hroONDq_sR
X-Authority-Analysis: v=2.4 cv=WZs8rUhX c=1 sm=1 tr=0 ts=69d5d794 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=LN73x9Sj_Gq4gUX8wwYA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX1DDiIH6ay3pF
 21gkBKTdQ9dgd1ofkWMroe+oy1b83N32Eti8Y3LilMEaAeeEv7dCDNl+/v6asNOHpSvQ2czv8xf
 GrutgkeArutOOjSQGJRmHwROV16DuIw/cogDYp/oxX8twA43puMrlMXpbOnSOPc/ahitEwId1Hn
 7ECWRwfGc3soLBaRhhmt1sE9CCZnDJAq2sl+UNULLZPiu1M9cAz6SZSJVP8n5UkMETVFztU0ZG3
 /aLHJWhyB+uy1Dt4GsflVXVAALld1HeQLNH0+/duNvAQqME6i++j/6FC4qTLrp1YD6+VCW6G5mf
 NKIle851lxbaRJvzg67YiijHlapHjn/8sPHJ0ZTLuTYIDvsfWWqJrNstzQfIYyGu7IRQXUw0kyQ
 KCCoQHxZT/ieo8b7LqjtquHpMFGOA1rRhrEPQJRwP1i7FgMdMCx6NZZwGIUprvQZmg4JKrMRfik
 4O5uPQdAIaNLP7+oPUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMjUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2df
c3lzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4IDA0NDA2ZGI2YTRiLi5j
NGQ3YzIxYjg5MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCkBAIC04MCw2ICs4MCwzMSBAQAogICAgICAg
ICBnZW5faGVscGVyX3N0b3AodGNnX2Vudik7IFwKICAgICB9IHdoaWxlICgwKQogCisjZGVmaW5l
IGZHRU5fVENHX1kyX3RmcnNjcnIoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfdGwoUmRW
LCBTc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfdGZyc3JjcihTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX21vdl90bChTZFYsIFJzVikKKworI2RlZmluZSBmR0VOX1RDR19ZNF90ZnJzY3BwKFNI
T1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92X2k2NChSZGRWLCBTc3NWKQorCisjZGVmaW5lIGZH
RU5fVENHX1k0X3RmcnNwY3AoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfaTY0KFNkZFYs
IFJzc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfRzRfdGZyZ2NycihTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX21vdl90bChSZFYsIEdzVikKKworI2RlZmluZSBmR0VOX1RDR19HNF90ZnJncmNyKFNI
T1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92X3RsKEdkViwgUnNWKQorCisjZGVmaW5lIGZHRU5f
VENHX0c0X3RmcmdjcHAoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfaTY0KFJkZFYsIEdz
c1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfRzRfdGZyZ3BjcChTSE9SVENPREUpIFwKKyAgICB0Y2df
Z2VuX21vdl9pNjQoR2RkViwgUnNzVikKKworCiAvKgogICogcnRlIChyZXR1cm4gZnJvbSBleGNl
cHRpb24pCiAgKiAgICAgQ2xlYXIgdGhlIEVYIGJpdCBpbiBTU1IKLS0gCjIuMzQuMQoK

