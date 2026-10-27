Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C9606A335
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rubus9oX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QIZGa4Pc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiKj-0001ss-Hg; Tue, 27 Oct 2026 10:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiKK-0008O5-8V
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:39:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiKI-0006C1-OZ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:39:00 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDnsX03434868
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5m2V4Cw2pbARPt8giz1x4Tv7QgjGl/JECvE7V/EJubY=; b=Rubus9oXlxMuWjG+
 9gr5caNYXl7hYBbZI1a4CLE+Wi/DYgaWlPCD+3AzeIyMWng3wE73HjF0/EvXT93h
 32JoSPFR9gD7vqwIXNTjDMBOtkWSPHa7DdvKZPwLZ4O6VvWGzJ3n2gpwq2uuZ93n
 +1sfAILIpwRNxP3zWYCcFSg5p9V4JqFpUuGM4pFxasK96h8sywzEu/CKsxAgnyV4
 FjjdColnfMGOHbhpqsmOLuAOVDLZYlbm5VpeKavSzi5G894FvUxXELIge8LguSKR
 jJchCAVU2K7vACDailm9jO8MMxMeFRvKmZkjht0X15GYpPayzEwHIVwijyIFbEC+
 H+fK+g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hje3dbjfr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:38:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ad98380ccfso6645324a91.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793111937; x=1793716737; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5m2V4Cw2pbARPt8giz1x4Tv7QgjGl/JECvE7V/EJubY=;
 b=QIZGa4Pc7ikbVY2qhBbVk53fOiqmyNVaT+8sl+kMc0cYw1K+vu6I19sBCVnkGge6ov
 IhBd5R5iWmQhoWJZ1AZVij4ZN1FRW8kLuP4TuSorKAi2WF04RP+geBDjk8cxyLd7VqeR
 /+WdjDMrDm0BUQZlZqda/7ME6PikHxngPvi3cBTT9XChxsOyPymTmdp6QMulLvLnWe1B
 No6vZ05j4gyBd+qUf+K2EJCnj8NqNwNkABbW+I3cHlPB6HeABbWBOHqNttwtvjHOqP1X
 mB9arEIY1IqEbwqbZKLaeX1qPGMf5qluZiAiNx2r+4/K26MOXpmZkT0PYFfqAKfCIvn2
 mbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111937; x=1793716737;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5m2V4Cw2pbARPt8giz1x4Tv7QgjGl/JECvE7V/EJubY=;
 b=PNw1MFkouIavFmP/oeGZZdGQ6XcEoWF40qf5ugwmCrf2/XLfLxt/5CuJMH8mXKdoFs
 dA6aAOMZbly26XQOmBN2eICi8yiYufzfRbL8Ie6W636uRoFpQIogKRvjUYfHySJ52Rjv
 fNaVOgkp8FxP33Ncy6t37M/o2pn/Vup3DJHoD5p2+M+j2ocjOYGFkOwKSR7KBb/uRYX8
 sMQBVUZQyrO8WexqjbRtgHA3by908RY+9b/Drfu0e0Jq+r5oDy+O9+7gitklQIgj5D0M
 atlIDmFaVMifiEmW+Lan38NVvQC6c5q4xGu3khoGJXyD/M0xcvvAZv8yr0zeJWHrIui7
 6avQ==
X-Gm-Message-State: AFq9FYIvM45bHydc/gp74HulHkztg+alDmWhmf3QGA2xbVEAav7nBnvP
 UdHwCA61K+9K7mScK4hVcLYHkUe8Qw1ejL2Gt6R/aezBs6eNmZH+D+4k/kYCBwzLxr2aC8X+if0
 dAC+PHxrrs1oGccC+odNRRZmR68/Q5GC4jWiK3PoNcc84WXiKyiPZTtlTewco8HPVEQ==
X-Gm-Gg: AYBFou0mOwC6JfKXHfnNE3a6q3+2zrYmP3czDoYQvX2XqxFQujhtI/zUS6aS+u5Fcag
 Cgza9qNsj5J2TB/vU33mJbotRlWDOI4as3a0rk5XEuUc9mDPTx6vA/T4TIqqhk2Y7pbKeT/1fur
 Uc46FBF2aVTEuLMweamsNwOvhTAjjEuBAenAhbX31yhlAyLC28hIaUlDmwTIbRFjSrp0VpkIog5
 izkK1wX9GIV2QxPE+TyoD8XO72ZdhjaxqDypvwu2hEfe2oTCJIq8tgHieAckydgML1Kb8oG2xY6
 fMY0SmEa+mSX2b25octPjGr2GgMmUjf2VS5KQlWGsLLsfIlzbq9OblbWx5ynBflBVGiMUrUipwG
 ZyshFcClGu5tuWSFXPiEUAs8X9zxqd8xgenmTCd0Sk0y8P5s=
X-Received: by 2002:a17:90b:2b4f:b0:3a8:6a6b:596d with SMTP id
 98e67ed59e1d1-3adead4819emr8712762a91.26.1793111936587; 
 Tue, 27 Oct 2026 07:38:56 -0700 (PDT)
X-Received: by 2002:a17:90b:2b4f:b0:3a8:6a6b:596d with SMTP id
 98e67ed59e1d1-3adead4819emr8712740a91.26.1793111936106; 
 Tue, 27 Oct 2026 07:38:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404dde70sm4056102a91.1.2026.10.27.07.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:38:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 33/42] target/hexagon: check exception_index in has_work
Date: Tue, 27 Oct 2026 07:37:12 -0700
Message-Id: <20261027143721.4125584-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfXwxvC/pp86B1I
 5fCpL7gL9V4VzItLuyzxaZSm5o2fO/kCjVg6DzRFO3lEmOTZS6DHSPQGH2GCtPK49aLDETTojtx
 lxXferb2wwMu/pyIeTPb8bSPIBPj6gw=
X-Proofpoint-GUID: 69VYGj1wkSpqXMPm4xewj7v6qRyYuYAS
X-Proofpoint-ORIG-GUID: 69VYGj1wkSpqXMPm4xewj7v6qRyYuYAS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX8Z5m10173+pJ
 jk8RnqhAtRYBn6ojoaLKX2BzN7CPU2ZSL2jtIw3C6NBhqupuXyRuLFT/r1TQS6jskuIkx6c5PeP
 qZl0j4bgxYRE4yab0WlWlXDpis2XhtOsn9NNj6nbqB4l9me7z0iLILVFfN7t3p9QJKgrQJndn7S
 WPa12cbP6U7ekHsNuy4bFgbJP7O9nQA/m1PuK8r8wt+Zee/EREqiBAj5u8/00+NsW7xnt6B+3OP
 PifzLhdPa0lItMZeKxHRAAaw7AtlB7p3dkd2E/jQvfx1aBqzBz1V39tMi0Auo95jqWAjLlx9eAb
 uDeqFJ3JmwefpNXa9JDYpA8vFF2xigj6tWS/eO8TYASPpzIMt2FrvWEg81GN4LwcCstiXpECG/l
 wt/3Ds9C9NhY1YNPB/0TfzvBeMUdvl67Ap9I4v9/NlJda6wn8U6jGVO5fdiJto0tchQqEIcwvr8
 dSN+oE++1m6L3qj9FTg==
X-Authority-Analysis: v=2.4 cv=SN/Xx+vH c=1 sm=1 tr=0 ts=6ae0b781 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=2Qhxk_BCo_5fC3_CN1YA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

V2l0aG91dCB0aGlzIGNoZWNrLCBhIGhhbHRlZCB0aHJlYWQgdGhhdCBnZXRzIGFuIE5NSSB3aGls
ZQppdHMgbW9kZWN0bCBFLWJpdCBpcyBzdGlsbCBzZXQgd29uJ3Qgd2FrZSBpZiBubyBpbnRlcnJ1
cHRfcmVxdWVzdCBiaXRzCmhhcHBlbiB0byBiZSBwZW5kaW5nLgoKUmV2aWV3ZWQtYnk6IFBpZXJy
aWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9m
Zi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdl
dC9oZXhhZ29uL2NwdS5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5j
CmluZGV4IDYzMmVlM2Q2MGJkLi4yODFkMjAxMjUwYiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTQzMCw2ICs0MzAsOSBAQCBz
dGF0aWMgYm9vbCBoZXhhZ29uX2NwdV9oYXNfd29yayhDUFVTdGF0ZSAqY3MpCiB7CiAgICAgQ1BV
SGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKIAorICAgIGlmIChxYXRvbWljX3JlYWQo
JmNzLT5leGNlcHRpb25faW5kZXgpICE9IEhFWF9FVkVOVF9OT05FKSB7CisgICAgICAgIHJldHVy
biB0cnVlOworICAgIH0KICAgICByZXR1cm4gaGV4YWdvbl90aHJlYWRfaXNfZW5hYmxlZChlbnYp
ICYmCiAgICAgICAgIChjcy0+aW50ZXJydXB0X3JlcXVlc3QgJiAoQ1BVX0lOVEVSUlVQVF9IQVJE
IHwgQ1BVX0lOVEVSUlVQVF9TV0kKICAgICAgICAgICAgIHwgQ1BVX0lOVEVSUlVQVF9LMF9VTkxP
Q0sgfCBDUFVfSU5URVJSVVBUX1RMQl9VTkxPQ0sKLS0gCjIuMzQuMQoK

