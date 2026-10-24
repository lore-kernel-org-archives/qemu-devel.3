Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF36606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 00:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b1h1VFXq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ui5Gv2Uj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKPFi-0002Y7-TR; Fri, 23 Oct 2026 20:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKPFh-0002Xy-T3
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 20:04:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKPFf-0001EK-V6
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 20:04:49 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvLcO3117159
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 00:04:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yzksfDjo7mtvpCtJcXuOkEEdrvKAp3QCYdAR1RWDlUU=; b=b1h1VFXqrdP1i2je
 Op2bqQJP8YfBbrrTSE3n+e0r2LDyTCbal22Me3+X8ZMCfOc0uhpXf6QmSLOri2aC
 6mEWVZAvL4hLQR9VHRxJrB/Mzpq6UZy5OrzG3jdXpCFvz+U8SoPwEhfFRNveGnLT
 xVPizvrPoFyFkzkVtOEh/HzTKDv91HKaf7Oi3xu1NcHvdmRCauJA8051FBZa5JyB
 LgpmRe/hqcszCA7oQ8T/Fygs6Wc52XNHG9hA8/xvTrpWCW+Lu1OEzLFdarmCIaOn
 xY7xIv5RU8rkUAsaHJYlfrjbDdqYQMrN7oATVlv8Iu5+vPiKDMPkJo5N4p6xwgx7
 YR2gbw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcrt8y0n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 00:04:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36637676140so2250833eec.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 17:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792800285; x=1793405085; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yzksfDjo7mtvpCtJcXuOkEEdrvKAp3QCYdAR1RWDlUU=;
 b=Ui5Gv2Uj4n8NNIsJeITuKUvoRvY2xSQxxxX8tmRJVMaIqVBtm9I/q7EZtCf8fMjbKP
 C7JuJLp6E09IlHUULd4IXB+RJ3lh9mSHJsu2w+B9W3tfwEjB15zdFDU60mFB8gGx/9Cj
 SVqEEtIkgP59uLaxFBK1JeBTU5oDmj8K6T6Z73zgXtRw8JiRLd5RXAd5BWD8VCAnni54
 6Ai9XOXOhrzM13gG8SJV99Orl+AXN/OTIND2lnfM8XAb4LDxzhAOpompDi/UND5hG/aV
 2tfF4d8h2DOzGGM2BnXxJsl0XoUs6QyqGVWYWqfrXxTHvVpx9puXVy3mG+ASK70vER0B
 sTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792800285; x=1793405085;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yzksfDjo7mtvpCtJcXuOkEEdrvKAp3QCYdAR1RWDlUU=;
 b=m8BTMIUcUDuG4amMAkDnAFg6fMeqtILnl40IcIdeR7s+qBcsckjkz0BjiApwlVy/wW
 qRkp0RMi25fA3jDA6GCaQLjHiQo3S7lg2MzkclPieMmg1CuIaZTvWJq00rOJM44h+F4U
 LKLKcsMERSkOXtcG92AYHaPMCln1sHmt/ZNbhiqNx2gjDv/tWYkQQH5+YSbMWT7GG3Al
 BAPOzyRSxaK3csUuwXSowij3NMqoEOXL3M9Z8+zdt28iSngXymz7FyGUP28bjMEwCgIB
 YeeI/uE4bGw73LSCIdwhUQyVUb15UrgMcH4ByoFu8CVJ5JygW8nMOQBfLYdDv0f+Ok7V
 8rUw==
X-Gm-Message-State: AFq9FYINIvbLfUdAhxvd9qtikpIESxlDsSWuKWPVWiJlKUYiKVULaryj
 DTJv47fCaiak30yohmlqVPPpUVNAjtQnTJ1lZ9L/kolXCgnVpzn+zrreFeBx/BYfvAr2UAGPKU7
 YWX8ba5AkwwQLcwRInMj24WJ2MUswM7NqnDZUcWvCdavOpsiXWoUgdCNd8Von3qWr2A==
X-Gm-Gg: AYBFou0chbn3D1x9v0Z8OZ00o/SubD9/qhEooOW0v5CMWRS/6HWlqxJd+gOLM/Zq/5d
 nbQqyOmC7iInOWZeUUDTU9C60Ja6N9KzbBXv9Cff4X/oJQxeK4n1Fc8BgMF9V3V49dCBnLFBQYn
 J2JY9tGwEVOXK4zVNOTu8Sf/N8mVcP9lKk7NAFhewp10Xl3efMcML5QS13/n1ClvD7EBwSQQu6N
 6MbTyfyk6dDEi+rwEBj75clhn2BI55qva+kV2JHrPOP1rT0EaHhnkxtG9L+3gzpyb97PY2fjz9u
 603HjEUcc6Zy4qwCSBsT2BtJ0AznnoK4T6+9FtfpTRKsCremMkEuul8vYpjyCtJFnwpJhuewd/O
 BLNott1HfRjrRsDCJifwavHgxewzl1x08BQCV3PWNDXPZvFT/PKbomnUnYgdiDRvjnzQiFw==
X-Received: by 2002:a05:7300:3d13:b0:351:7e5d:2de9 with SMTP id
 5a478bee46e88-369e837c6b1mr1195049eec.1.1792800285174; 
 Fri, 23 Oct 2026 17:04:45 -0700 (PDT)
X-Received: by 2002:a05:7300:3d13:b0:351:7e5d:2de9 with SMTP id
 5a478bee46e88-369e837c6b1mr1195008eec.1.1792800284443; 
 Fri, 23 Oct 2026 17:04:44 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8d9307bsm1854727eec.14.2026.10.23.17.04.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 17:04:43 -0700 (PDT)
Message-ID: <96c23be3-7809-43ce-9ad4-920f2b46687a@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:04:42 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] multi-target: remove qmp_query_cpu_model_expansion
 duplication
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5NCBTYWx0ZWRfX20nj8iM1ymaq
 GWz4Ul4tFLGrFhj/Ey/2pddsoHI44p2UZFGt8oDeP3zP+hU0C1qRzkpmiBc/yZUnHqCAgpqjO7R
 lwQM1xJLz1TS4Im0fXzsQ0bS3OHJQP0=
X-Proofpoint-ORIG-GUID: ubCnaWCIrdlOeqSxMqUS5gUfWcY5YCYZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5NCBTYWx0ZWRfXyXYAbr0qo+C0
 vvJv3wAzPtIxT46AEJMP85D7a/3XduHPFE25Z1lsgu6N+FnBKNkyoAp016F9ZxKUvILCs/jC4JN
 uvUuvjhTeW4hlA+8g3K0cT2duzfIvp/T5P6nokpPGqfki4DqJCermGr/xKZ+VdlWk7BMJ1ePc5n
 EkJtxdWXP5m8Gldx8/QmAMEoaz9++muVYYEq3bVsKDa+AtW1j4wJNV+X5PtzNq5nRiG6e5tTsk5
 5nsV5lh3IxdV3G/CltHQxvxvRQFAtyfNWJm62JZ7LB4jQDloS4RsyPW1YIHJf2+1m02MrJpdPOV
 4dGclHAtQzD0KioIhJFe808TYWkTJ+DqMpZABLVACcZJABKPRhXP4H25S8diBxwqBOfGve6i63k
 +lkHvDIi0xeXud0aFfdL2h4wwxEoVt3ak7BuD9Hi+slmSfDJ7Nie30vSXfB4z0sLngdSBeVHM7z
 AgnOCbiUkEZ2/Q7EyNw==
X-Authority-Analysis: v=2.4 cv=E7lYNqdl c=1 sm=1 tr=0 ts=6adbf61d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JEbRuu-vPki5EhdbkP4A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: ubCnaWCIrdlOeqSxMqUS5gUfWcY5YCYZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230094
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/16/2026 9:25 AM, Pierrick Bouvier wrote:
> This series allows to link multiple targets that define
> qmp_query_cpu_definitions. It simply replaces the duplicated definitions with
> target-specific ones and a single dispatcher.
> 
> It follows the exact same approach and structure than:
> https://lore.kernel.org/qemu-devel/20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com/,
> which was merged yesterday.
> 
> Pierrick Bouvier (6):
>   target/arm: rename qmp_query_cpu_model_expansion to
>     qmp_query_arm_cpu_model_expansion
>   target/i386: rename qmp_query_cpu_model_expansion to
>     qmp_query_i386_cpu_model_expansion
>   target/loongarch: rename to qmp_query_loongarch_cpu_model_expansion
>   target/riscv: rename qmp_query_cpu_model_expansion to
>     qmp_query_riscv_cpu_model_expansion
>   target/s390x: rename qmp_query_cpu_model_expansion to
>     qmp_query_s390x_cpu_model_expansion
>   qmp: reimplement qmp_query_cpu_model_expansion as a dispatcher
>     function
> 
>  hw/core/machine-qmp-cmds.c            | 26 ++++++++++++++++++++++++++
>  include/system/qmp-cpu.h              | 21 +++++++++++++++++++++
>  stubs/meson.build                     |  1 -
>  stubs/qmp-cpu-arm.c                   |  8 ++++++++
>  stubs/qmp-cpu-i386.c                  |  8 ++++++++
>  stubs/qmp-cpu-loongarch.c             |  8 ++++++++
>  stubs/qmp-cpu-riscv.c                 |  8 ++++++++
>  stubs/qmp-cpu-s390x.c                 |  8 ++++++++
>  stubs/qmp-cpu.c                       | 14 --------------
>  target/arm/arm-qmp-cmds.c             |  7 ++++---
>  target/i386/cpu-system.c              |  7 ++++---
>  target/loongarch/loongarch-qmp-cmds.c |  7 ++++---
>  target/mips/system/mips-qmp-cmds.c    |  9 ---------
>  target/ppc/ppc-qmp-cmds.c             |  9 ---------
>  target/riscv/riscv-qmp-cmds.c         |  7 ++++---
>  target/s390x/cpu_models_system.c      |  7 ++++---
>  16 files changed, 107 insertions(+), 48 deletions(-)
>  delete mode 100644 stubs/qmp-cpu.c
> 

This was merged into master (3745b15e090e3dbcfcf28fc96928abba8fd2ed2a).

Regards,
Pierrick

