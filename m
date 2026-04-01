Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2098610F6FDA
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xVZ-00031a-AZ; Wed, 01 Apr 2026 11:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xVP-0002kw-HN
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:29:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xVN-0008JR-Gw
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:29:19 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631FLivj1562613
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FTlXPyeRzOyrsGJB6pfA3qXtdU8TIi9UxlieJg2LucM=; b=iV9xA/IkCucFUSBc
 oCLpOiA5O76WHSF+BawbMsdj8j3Apd9YCE1/uef5/30uASol4E4sGa8C0FHZoJNR
 DujMMWpUKgC7UisTasQkD/f1BtvXzJRLG9bsCtiIE9CYFpXKzUa4xg2/Yt3llCro
 cK5ZkXyajXi0hb0VYQWOTZl1q1PLyxSWak7Q1iuPDhfInyZAiIqhiG0HTirvdStl
 hdd3uTuB+u1xLTiPk/9R5UUAlM74FiGv+q452DXS3egglXOhEvWNMIEKwD10/lE5
 N2T1UuPE3flNT2rJx3o8ssmJXnD01qqtmtZSYCxis28kT+1hry7MqqSawXO/rBwl
 RTF/gw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8va3tq2b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:29:01 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdf75bc88fso6124058eec.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057273; x=1775662073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTlXPyeRzOyrsGJB6pfA3qXtdU8TIi9UxlieJg2LucM=;
 b=KryLr8o/zlqHqX0E1CF9NKnCY+ITbHaTNiLQGNpmmcxcPG2keQ2faSyOGdaOK1AwSd
 cmAJRR/ht5SbvX4UyUh7KVjDYgfQWSqKrCV/thoUAVNMgS1iVGoooFq6wn4v3X6bbRyF
 y6GcvfvqoJHlDo/VdQ/DFDVgA19vTnBZKPqyAnCqZLbcvMwlS6nEVbNbs440xHaHvTLs
 L0gcXlMmXqLsl6xqCvtkM7zC25KkoJWoaNtgKl/GqJAWoDA2kT4ZEJ2C+hZBM2ArQVUl
 mgoxdZ3rLa3MAWTWuVLk2YDYCDvByQZ23Nqln1ykagWFUwu7asM8UTlsqEe0W2vnY83W
 YKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057273; x=1775662073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FTlXPyeRzOyrsGJB6pfA3qXtdU8TIi9UxlieJg2LucM=;
 b=FYXYX7i0bIAf06lxSU5DegW+55eeExJaByqCeDRpwU92jlvGU84uLGv3akCqsmg+sJ
 OdibGVbYdtNMiLTG/nDVy/hZ4Bxd8QjmVvvNUFM1TltiR8gNddoLIBTLybmMp3855Vl3
 9D4t3zs0ykFX741l2vsPokh+BPYIGvBHXOk5gk2gmYG9lNXfzxK8r1xyuGg6bliszQaU
 1oFXeJw5ixXj+kJcuHMV/Vu/UEZ480Lw+xaTO1DSfbYNCFve95RYHBGqk76On+FzFKGK
 XGj4TW5WeI03uXh8r5H6w8xTewr+2eZ7lK1j2jusWTAf2fZvoLxefKH6iaG2Na8mVsnh
 JN+Q==
X-Gm-Message-State: AOJu0YzhEgX38V+MKxpdzHd9VdAF+saiKK8+I7h6ebGprc+NGDuPC7OA
 2g+Lu8H37ha0hTXBjfd8NPhW3283JhcO1jvZekABNm7544a5hzApseS43HHFI9vhU5NdJ2urJQc
 EeAKyikV0La20CS8/rLV2pchNRESHdY/4c32INMt5EBNgWytwKIzGRYrwvx4qhYZ5LQ==
X-Gm-Gg: ATEYQzwWDbxwAo+wjuv0DF2TvBFuv60BY0sNJmD/Yr80CcZOVryRBWhQx2DaUc4okZM
 HGYT1BdBedYL++azUx8wbxuF+/iG99BjXmvjvXvWTRiXvqg2Ml5mBPvn6TYjreE7dG9/5OVZz4S
 hqKWE99tACyGT4rDmZOrohZLFz+PuBstCGWpNYQ7d/XA/7uNPwmGFNzM3mF80ElqDJGyW5XqrzQ
 ShokhF5T64/GBge82Lbkw/UcGWKip23cqRwNKEFH1ShoLDbt45Mw9XCBza0qENUqI2xX1jwAuFC
 dInIkmsYQ0acsY7TfjD7+tSYNaEiR/xQ57u3iOON+LduNAzQJuV3PFNqA/Wu1IzUzf2FExSZbDj
 M+kZyriV2ZOR9IMNCrbpn7hwTb6h5f3FVP4FPCvbWXx63qtwM4AEN+1bl/4SExUTPR+4NIw==
X-Received: by 2002:a05:7301:4090:b0:2c5:190b:711f with SMTP id
 5a478bee46e88-2c9333ad12amr2145147eec.29.1775057272582; 
 Wed, 01 Apr 2026 08:27:52 -0700 (PDT)
X-Received: by 2002:a05:7301:4090:b0:2c5:190b:711f with SMTP id
 5a478bee46e88-2c9333ad12amr2145118eec.29.1775057271889; 
 Wed, 01 Apr 2026 08:27:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:27:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 07/37] target/hexagon: Make gen_exception_end_tb non-static
Date: Wed,  1 Apr 2026 08:26:27 -0700
Message-Id: <20260401152657.314902-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: -HQBo-mO_aJsh-z1j3n_djYvckZQ4Fx6
X-Proofpoint-ORIG-GUID: -HQBo-mO_aJsh-z1j3n_djYvckZQ4Fx6
X-Authority-Analysis: v=2.4 cv=B/C0EetM c=1 sm=1 tr=0 ts=69cd39bf cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=t4cj51CzC67JwBy76UgA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfX/SDqAnmClpa5
 0BG0lGx+/R8tF+kKpnafxQwG+ILnI019Fhsx4wipAswjMU+CONBf97q+sRvrU+cuPXjjORVleOg
 YuYIjq51WQjQ9dMQXNHYtO0iyPVwqb0ep82IqUezFT6rn/2i5hlLHaDAlQDG3wCKFPOyiyXQxtd
 ZSgtYhvww50T73xMqIlE9bJZbCBVbIVSuWWrwF/eny4ePi6kUCTQrmZD7T2M765POq9Rlw21niY
 9D6N6w7ITwUug4x4sAT6o3g7onmqx7zQcQYNoEGYTplXoj+ljLsdMMbKgKLCBlZUeqrMrmwn+eT
 N5fwd8imzKmpA30POlJ3vzw3L6ntxC1+eFmcr+bLRLYxc/az270cMbYQwtLBWxjUwE3Hy1IhEWI
 kz1FrS9A2szm9NlSPGvjfhRQejAGTPXBoQRnjJivhowti1aIXqmcdBlGuq3akqY3JAt+1Jdfhz7
 dhKAnveYUmZc0csbJoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgMiArKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCA0ICsrLS0KIDIg
ZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRl
LmgKaW5kZXggYjM3Y2I0OTIzODEuLjI4MDRlMDhjZTU3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi90cmFuc2xhdGUuaAorKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtMjgy
LDYgKzI4Miw4IEBAIGV4dGVybiBUQ0d2IGhleF92c3RvcmVfYWRkcltWU1RPUkVTX01BWF07CiBl
eHRlcm4gVENHdiBoZXhfdnN0b3JlX3NpemVbVlNUT1JFU19NQVhdOwogZXh0ZXJuIFRDR3YgaGV4
X3ZzdG9yZV9wZW5kaW5nW1ZTVE9SRVNfTUFYXTsKIAordm9pZCBoZXhfZ2VuX2V4Y2VwdGlvbl9l
bmRfdGIoRGlzYXNDb250ZXh0ICpjdHgsIGludCBleGNwKTsKKwogdm9pZCBwcm9jZXNzX3N0b3Jl
KERpc2FzQ29udGV4dCAqY3R4LCBpbnQgc2xvdF9udW0pOwogCiBGSUVMRChQUk9CRV9QS1RfU0NB
TEFSX1NUT1JFX1MwLCBNTVVfSURYLCAgICAgICAwLCAyKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwppbmRleCA2MzM0
MDE0NTFkOC4uMWY0YWMyYzNjODQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC0xODksNyArMTg5LDcgQEAg
c3RhdGljIHZvaWQgZ2VuX2VuZF90YihEaXNhc0NvbnRleHQgKmN0eCkKICAgICBjdHgtPmJhc2Uu
aXNfam1wID0gRElTQVNfTk9SRVRVUk47CiB9CiAKLXN0YXRpYyB2b2lkIGdlbl9leGNlcHRpb25f
ZW5kX3RiKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgZXhjcCkKK3ZvaWQgaGV4X2dlbl9leGNlcHRp
b25fZW5kX3RiKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgZXhjcCkKIHsKICAgICBnZW5fZXhlY19j
b3VudGVycyhjdHgpOwogICAgIHRjZ19nZW5fbW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBj
dHgtPm5leHRfUEMpOwpAQCAtNTkwLDcgKzU5MCw3IEBAIHN0YXRpYyB2b2lkIGdlbl9pbnNuKERp
c2FzQ29udGV4dCAqY3R4KQogICAgICAgICBjdHgtPmluc24tPmdlbmVyYXRlKGN0eCk7CiAgICAg
ICAgIG1hcmtfc3RvcmVfd2lkdGgoY3R4KTsKICAgICB9IGVsc2UgewotICAgICAgICBnZW5fZXhj
ZXB0aW9uX2VuZF90YihjdHgsIEhFWF9DQVVTRV9JTlZBTElEX09QQ09ERSk7CisgICAgICAgIGhl
eF9nZW5fZXhjZXB0aW9uX2VuZF90YihjdHgsIEhFWF9DQVVTRV9JTlZBTElEX09QQ09ERSk7CiAg
ICAgfQogfQogCi0tIAoyLjM0LjEKCg==

