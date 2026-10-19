Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84A3606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NmbMVuvz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JG+ri5CF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIw1D-00026K-2O; Mon, 19 Oct 2026 18:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIw18-00024s-CX
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:39:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIw16-0003un-JI
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:39:41 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZhgg200602
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FN16nqY7Ug0HbUp7FN48ueJMuK0Qe1pezIPsL+MvCQY=; b=NmbMVuvzBaIUCnfX
 vYWwMMo10OGbprUfu6a9wp+sIe75u2pr2Wazq2L07l8ZhyTratyvekNUkr1RIHbX
 QiCtqmeoAkpeaAoM7gmMRl4sjggM+0BRI6aX0VissmaUQM8VnQDur6gxnlQZCTsB
 fLuus43AcWO1QHujH6mYELQSkxmK+cVN5cquXQmHaDpjcyiQguvyMjP/G9OZdYoL
 jdoKdSwsmVCTSjIhGIQj6rjYNF7b6BWiXoXrvFG3Xw81iiTdMsgpHHsqXKBs/C72
 mv6WdLtCxcw4rw9io+tr55U93flaql4KrbfwIKZMAGLOodzGdsQRTcAptDwmIj7B
 2kDdsA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr780vyy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:39:39 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3662e7a9299so63675eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792449578; x=1793054378; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FN16nqY7Ug0HbUp7FN48ueJMuK0Qe1pezIPsL+MvCQY=;
 b=JG+ri5CFSEAsj8J6A80FQO0beLN42JgsTLKu3tDztq3dg9H610GIH4+IS8E1Ffv78Y
 K41zmNzKF7XRfPo/PuUdePitdNPTNTrM+4ydRWN6gCV3kBjjwdMrz0VIwWt9PVKYPigC
 xkwbnUzICRLDNOxIfE66e2V2PXC67fjamWn/S4JckOPciaTNI7bQoiklhKMBu2MRS5N5
 0SrHbJH0+oRSdXOa1Qpz6I2datCKaXOI1EcUB9sDPx6Evt/MSkI9QxstbjGCpPR3NVbl
 yOr++2EADkCh74bEjuA4c1NdeM5fr5iKWWnePeb61JsMPoVbXs/v4739gJqhwSeNdGUh
 146w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792449578; x=1793054378;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FN16nqY7Ug0HbUp7FN48ueJMuK0Qe1pezIPsL+MvCQY=;
 b=SpJpj8oyPNi9RcfbnbLL3RQv26/W+1FKrZuLdG2wQQTAP7RxX4/7J05B0ICUiy8Q5w
 6WK0FgaT8nWe4X8NzHOy1bZfPowp4Z3nachlh0SwRK46eJtaAqmX8bQdn6gS3xG0bTMu
 ulDj5TQZSK/fnhK6e/CjlmaeWljNP1hXo2Yd4kArLfgTSrq0300YVN3d2OTKMx2R/76z
 zuIg98TTMyVqyZTJDHBy1GZGbNmTGI23S0hcpZKsX5+FQtGfa8xn9EA9RXyD5TYACPYr
 RmXB1LKJ+H1mRJm5haxz/JZJNIev+q8IEVREqHCX/1iFfCd2E6YLgv5kglyG9DwuCy61
 FyeA==
X-Gm-Message-State: AFq9FYJhN/3AJK9EnNONI3MbL0eKkkASSAJUqRdvf/Rvs57GnMqsrREY
 bc436g34CFszO4L2le2rPSnkVNlKTBWtyDyxhoZPsOwXDbX0xu2hMfytZE0IirBsN8WofJnAlVV
 OGJoHuuQlF2o5QfbFQSuv7993WdbW7J8A1AjuCqO/EbTwKST6qWAnLKcEqsi91jWoHQ==
X-Gm-Gg: AYBFou3cSaGQyGm28IEj5aNMV93Zk+k3H4IAsTFV/h3BudbTu4Ekh8OfnGTppBdYZEW
 AhhWPJS9sRp2q72jnyh6wVKky7Z8W5PlY/7Thb2meCOChGO93j/SLZATpNvB3k/0qq9PDPHsxYQ
 Ioe++qzRinNsqhmqqiXPlH7dliDgo2LVmGGupBwzGX8dqC4zmhkxhyfbgCjTKqS7ibC0tzjEhA0
 qYJYEVtkeRRBQKpKIGCcuvZcs8pcZxZHEl9MKgWg+apSD60JYiN1520ewr6V6s9SIzD9S3jq6/g
 5LMq6B/BCEyS+e7rVL59Mx5LcTxyvkuhC/wFJlXiJXNr86oSKPUbdIYS4ltdl2MnGQOcBul9Rdw
 2MJEac0YBKxSmuSXcorsadwMxNKtP2q2cUHkgEzlPMTRePtY=
X-Received: by 2002:a05:7301:dd90:b0:35d:84c2:eb27 with SMTP id
 5a478bee46e88-361a3221e5bmr12966792eec.35.1792449578291; 
 Mon, 19 Oct 2026 15:39:38 -0700 (PDT)
X-Received: by 2002:a05:7301:dd90:b0:35d:84c2:eb27 with SMTP id
 5a478bee46e88-361a3221e5bmr12966772eec.35.1792449577741; 
 Mon, 19 Oct 2026 15:39:37 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3607bc950f9sm38908474eec.0.2026.10.19.15.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 15:39:36 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 2/5] target/hexagon: check exception_index in has_work
Date: Mon, 19 Oct 2026 15:39:30 -0700
Message-Id: <20261019223933.3248208-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019223933.3248208-1-brian.cain@oss.qualcomm.com>
References: <20261019223933.3248208-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA5MCBTYWx0ZWRfX/u+R+3GMcV2a
 x8ogFttQXR7TpcvUBqb2cfmPM2TGInCJNbI7pCqblYqd6Vmwoz4K5kBU0/B5Nt5axEFELQJ13ku
 NpcZKG24uBr1anOpYhmxSuZT/1RUtLiTrxn1bsO3Q9ariVYPWN2MhVtm5RClMqM0zPOH3sesg30
 l6T6gmreM59snz10olQxN2H2lYiQ4dnELuZqBGtX/JuuJ6TdLkzV+3wCZzqB0UBgVc28e+kOeqB
 oPGhkPLIyl/VcwvfI2uuOgCBIfGlRNNASYR6Q4Zo9xnWltz2XIO16y+UQnkCX/ROiVED8p4371x
 K1kr5gaY8pqt4fJ5y8CaFNAzD0rXFtfj1fNps0/SavRsCLHNEe4KmbIBuAW/MFqtdxIfZKMBcTE
 5cRFNTZulxF7hGPzH/eFQQva5Bt6cbxDfIgBWqAZdh7rVvH8GEuArO75+MOFuu6iMvEvvvgMngr
 zezkgbAjC3Yl0ZkDgWw==
X-Proofpoint-GUID: PhmmaIxczAkEeRHJBhc0cA4Hm_vR10Zl
X-Authority-Analysis: v=2.4 cv=LKnz05W9 c=1 sm=1 tr=0 ts=6ad69c2b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=2Qhxk_BCo_5fC3_CN1YA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA5MCBTYWx0ZWRfX+jKITLzYs3D6
 YD74wrokRoPduVcAaLhqUThIAoORP3mP09puw0nD5CBILZ+YxpgpiH61BgOfxjojC9PCvaL2uQH
 l+u+C1ZmNyxAPpjeH1cqRGypwnun6so=
X-Proofpoint-ORIG-GUID: PhmmaIxczAkEeRHJBhc0cA4Hm_vR10Zl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190090
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
CmluZGV4IGYyMGQ2ZGU2ZjYzLi44OTZkNzI4MjVhNiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTM5Miw2ICszOTIsOSBAQCBz
dGF0aWMgYm9vbCBoZXhhZ29uX2NwdV9oYXNfd29yayhDUFVTdGF0ZSAqY3MpCiB7CiAgICAgQ1BV
SGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKIAorICAgIGlmIChxYXRvbWljX3JlYWQo
JmNzLT5leGNlcHRpb25faW5kZXgpICE9IEhFWF9FVkVOVF9OT05FKSB7CisgICAgICAgIHJldHVy
biB0cnVlOworICAgIH0KICAgICByZXR1cm4gaGV4YWdvbl90aHJlYWRfaXNfZW5hYmxlZChlbnYp
ICYmCiAgICAgICAgIChjcy0+aW50ZXJydXB0X3JlcXVlc3QgJiAoQ1BVX0lOVEVSUlVQVF9IQVJE
IHwgQ1BVX0lOVEVSUlVQVF9TV0kKICAgICAgICAgICAgIHwgQ1BVX0lOVEVSUlVQVF9LMF9VTkxP
Q0sgfCBDUFVfSU5URVJSVVBUX1RMQl9VTkxPQ0sKLS0gCjIuMzQuMQoK

