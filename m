Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C249D606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pNlnlIiI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jVXThOVG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXtG-0002Y2-Ms; Mon, 26 Oct 2026 23:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXt5-0002JO-CO
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLXt3-0008KI-Oz
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:11 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2ExPs3986657
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EXMlL0CQEUWxaU5cW50xDxNN5MRk9w89xRLd3/Rde3M=; b=pNlnlIiIXlwcvuw6
 OxnSPlZPDy//C9YextjhTSUNnQZOnlPChdbnrzQwXXuwFt7T0dAhxzZZpYv6Z+Jj
 T2vNsY9gdz96oWrBihm+M70cbnqwW5ZEGtHtP9Nz40dc9x3Um3/FzSibP9hmMwQb
 +OG95c4FyqBHfxDuuHbB5mcF9kgutcLFy9TDmRXq0Pivsr+qfgOG3B+jRnfmzQVU
 7ASfcERztJM+EiJ1wAsvE/MNRBcsWm8qZawTL3NIwW+MgCC9hDbnMGyHs8+29DtP
 9/B2Z3Sj0KaPzblWOb6SJlm10xRZC8OTpmPK7aOxCannY8Ve4FvmiVn2Q2f/ZNfr
 T8e48w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj8smtj2y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:29:58 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35c3c370b17so6370126eec.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071798; x=1793676598; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EXMlL0CQEUWxaU5cW50xDxNN5MRk9w89xRLd3/Rde3M=;
 b=jVXThOVGwXB4FFO0gsY00cgf05SUgoWQDNh3NGrgAURG+hha3QN3/T4pe7LhEfau0P
 bsS09P7MUZ9WDlOR7Io/+xdB5h1PAN81g3VRqnsYEULxABW9uv6uNfxtAaQx98Z+8em1
 MGNRlL3Vs3g70eFfPwsHDs/T5azX9LapUYZTKqFG4vKbsudlk26/RuSfd+C401kkLA4P
 +6OYwC33aYTgoCGK2gzAdZyj5BiaRuaAiYP9OlTygPy+lBQO1b4p/FihKplooth8YbwO
 6Ou1pEBjfCUWwxyI7q6wwyRxwEQUVbToqV+LPllHZrAVjyxQuMl3m/sw9mHcVWRAc0it
 HXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071798; x=1793676598;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EXMlL0CQEUWxaU5cW50xDxNN5MRk9w89xRLd3/Rde3M=;
 b=h3fy+UQl+eKeiopU8tEVbfL0QiFBmbikjCGLCjfTpMoHq5COCFv0mXrPPULIlQTk1Q
 Le79KbJnOQ0+zJcxJhS8q1oNVCojYq4anYqc3XcEkOCj2eJHtD6VF/WXO5pTsWm9TKNi
 aq3/hVdwiC81UevrBE6Dsv1G/1j30PjQ3zdK6Ih9Do3A5qpGeXwj+u6jPEkT8QsD0uOb
 Y6I7unm99FzmX7tR9Ncs0CzeLPaUlHM+L2TC4ghTbQuPN3T2etIJXxmvZ2xBEj6iav/4
 XiQiNyPCuEu82Gg7DkoxDiXk6atq/jU/ScSVggqoLFknfQwBU2bPAeYHl3lqxXkMyWFa
 xtdg==
X-Gm-Message-State: AFq9FYJEySs51Q3mEPIiqzj16QlQ4SAy4kqdqqfxXNPhZe1wPqpsVzE4
 vdROlanLoEK8OUAuLtZ6uQxHaRnlqHVWAHIB3cbs+UWKFEDaqOoqAYCBBqVqOxKlKzdCFAMogGf
 tRGag7VxdCpCw3ySZFYw1FIIkdkLQVbvuqpE+GMPj0pyrzZKM9MaL62jm4oxCVWBPPA==
X-Gm-Gg: AYBFou15jvpbaA+h+xzcEaClOInO4JJ7H0mTqe3oVrdEHNJfQSQOZUBnqS+LtzIe1Xe
 CiAI1IPcNgehoAhfEpYUis4gcAPAL6zIWWNrRZgCdDy1zqDsa6hGJJBQJK/l3I4TBmHQMDt/w90
 4+X2vkxxnf5lT027EhYmV0+9tjAVFxUea+/ivHl5ZNTHotRq1IyzrsecQduylQBlQ2taSks/qqf
 5I9DDBWasKwccNG8RgvCtPK8GUq4ZOHYpEyQEbwHdlkLzSIi3k20dVcNsjTcd32QqsPMCmEvXa3
 KyMgMj/pYCmx1q7rHtB/KIMXrEymN3heuWXoI/Zc60nRplhosHiLIR1rGAmd/3lEitto9BTAsmK
 sHH7MaWzkaayhMODUWTaxqmC1dWC5rigyP9ev4GFikii9L00=
X-Received: by 2002:a05:7023:88d:b0:169:3706:d61b with SMTP id
 a92af1059eb24-1993505df7amr13494100c88.16.1793071797829; 
 Mon, 26 Oct 2026 20:29:57 -0700 (PDT)
X-Received: by 2002:a05:7023:88d:b0:169:3706:d61b with SMTP id
 a92af1059eb24-1993505df7amr13494072c88.16.1793071797269; 
 Mon, 26 Oct 2026 20:29:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19886f790e4sm28479637c88.0.2026.10.26.20.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:29:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PULL v3 11/41] target/hexagon: preserve callr target when Rs is LR
Date: Mon, 26 Oct 2026 20:28:57 -0700
Message-Id: <20261027032927.3055166-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: ED6UeLXa55Bfp5vH2QhwHMEWdVXnZuKC
X-Authority-Analysis: v=2.4 cv=Sfti5fRu c=1 sm=1 tr=0 ts=6ae01ab6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Ml5uk3Oo-jtE3ATjI50A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: ED6UeLXa55Bfp5vH2QhwHMEWdVXnZuKC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX1jtQEcDqqM45
 2hUnNeCrVbuoUFry26/QAM2plZQzKvnUMSEQasaNsug1WddWNRqmUqWiSkTazV8DmqEMotaxWaf
 3HR68p0gkbM0VInWvop5ZVVk7XsSpPI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfXw10AzlYHduHI
 tY14D4rakInH2uLSe4PhC5XqBjO9iPQVi0BKL0xNiQPbbTZzTzmzQ8TzTEXpo6dABeS66C9W8vi
 foTlAJ9o431nQLlWXKzNi81zbHMtj9zWYsget0WGQVGfGs6T76/nn8/Zc4RUvXZWb0OPAXWdG1Q
 NgZk+InmJEi5g+rW/fFwgrxM3udn2WJ73VXPSMUwG9mdQY6KvEHXbLGt+AkYGBhOVoSYlAngX5z
 xrIY/WNAinFl+degv3kSTvObwx1yLM3q5Lc0pdhhfjclutWaAySydU8k63nMDeuiFCrDV4e8JHg
 VXZ2qMLNvDr1ngqDb0TB+7C7dW0nDtixUuuKOKWBLe0X+eqEcsI1Bghag/qwz3o4s+cxS93po/f
 hWMSIyZ29dDjzu+wxOu2v2h3Xmb+KKOf4U9gUHTuL/5xSl4dYFVHkh8uQPSfCvVDxgWH1PDqTkr
 rzV/9ED3iqsm20IyPwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270013
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

Z2VuX2NhbGxyIHdyb3RlIHRoZSBsaW5rIHJlZ2lzdGVyIGJlZm9yZSBjb25zdW1pbmcgdGhlIHRh
cmdldCwgc28KImNhbGxyIHIzMSIganVtcGVkIHRvIHRoZSBuZXcgcmV0dXJuIGFkZHJlc3MgaW5z
dGVhZCBvZiB0aGUgb2xkIExSCnZhbHVlLiAgQ29weSB0aGUgdGFyZ2V0IHRvIGEgdGVtcG9yYXJ5
IGZpcnN0LgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJA
b3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVs
QG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5A
b3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyB8IDIgKysKIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9nZW5wdHIuYyBiL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jCmluZGV4IGQyMzRmOTk0ZjQ2Li5m
MWQwNTI5ZDBjOCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vZ2VucHRyLmMKQEAgLTEwNTksNiArMTA1OSw4IEBAIHN0YXRpYyB2b2lkIGdl
bl9jYWxsKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcGNfb2ZmKQogc3RhdGljIHZvaWQgZ2VuX2Nh
bGxyKERpc2FzQ29udGV4dCAqY3R4LCBUQ0d2IG5ld19wYykKIHsKICAgICBUQ0d2IGxyID0gZ2V0
X3Jlc3VsdF9ncHIoY3R4LCBIRVhfUkVHX0xSKTsKKworICAgIG5ld19wYyA9IGdlbl91bmFsaWFz
X2dwcl9zcmMobmV3X3BjLCBscik7CiAgICAgdGNnX2dlbl9tb3ZpX3RsKGxyLCBjdHgtPm5leHRf
UEMpOwogICAgIGdlbl93cml0ZV9uZXdfcGNfYWRkcihjdHgsIG5ld19wYywgVENHX0NPTkRfQUxX
QVlTLCBOVUxMKTsKIH0KLS0gCjIuMzQuMQoK

