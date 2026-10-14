Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC933CC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5dr-0002Dv-8s; Wed, 14 Oct 2026 16:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5dp-0002DK-Ml
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:32:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5dn-0006HH-PJ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:32:01 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EFMihh1682652
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3nPFtTQXQO2lHnkEBwNRZPQ71nRnDAuknZdjfZM1KNI=; b=MhFsk/R0m7NK1cdf
 RtVINcGbSpVZBlyWG99V42JQtcXZkkRuSwKlzFwgprtDgTHU5+neKyjtWmIXs/iA
 rzudKyNtLh2Ozl/v2jofhBjcgTN7wSDrKmiQGLHXKE93KhRyqyOVGZa/ksKoNK9g
 tV4SQQVbYjyCYYlAA64qRMRcDDJ2UHkrmTpcRmf7FDbGd9ouCScLlOehDxbB6FMR
 VUA+kgFZcukNTQOlz23f213X8qlbixywBhEOtsiRW4mJTz1ML3EKTfaXWKYndN5v
 i3X9Jj3R6VRd4ioT9T29/rKoIFszri9l+kFJUgwzEHGy+zs7pI9h+KpE0H8QD8+m
 3EIK+w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacb015dx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:31:57 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so250366eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792009917; x=1792614717; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3nPFtTQXQO2lHnkEBwNRZPQ71nRnDAuknZdjfZM1KNI=;
 b=EAtjjHS9yuXmB27lIoAdCCxhWRqxrpD+5Fb6CTLq8KlkkePk+Biqag7wzqiw6jIu+s
 Jf2d+E2scKR0NMxEcC3PN4a8an9Pmos0sZODxvWvPCFaw8xF/eNt0wiRlU2VnjdhEetW
 QmTUW0giQFJsjIBV7UejXMDte3tBBJhdciEdEwoeij5CiGv2deuPJbR6hIUSIW2qbFxz
 xYSkj4+asxur6W+/Dpg/vK7dHRDK3XGoPnNd0BLAOopP55XYh+k3adBuv5EUCUJIUp3I
 CTkwS4RebRDbnIftV3OE5ID4s0AmZ3nFMy36trunLlgiLjtDY9g6/O4yTk9OapaMvPCL
 UrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792009917; x=1792614717;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3nPFtTQXQO2lHnkEBwNRZPQ71nRnDAuknZdjfZM1KNI=;
 b=Y7o13bHtK1hvYHW/zF2PZm5uCE+GV+EpVrOMpt1kW1/rF/9IjBHgvZCQJnKlqdl6ej
 VyfN3RLCtDDS+7AJ3b4nD6GKFHo9a27iVkomRJt07FOCd0LkXkDloFCx97SiHLEYTFTI
 zrcd3A9filUoEbMCra91fD9LWiY+jIQ3Yu99ZqbKCPcwbohwMvusK/GBk00AmUCIhQE1
 47Rnt0ex4JPKPEOp39Nl2jnSIMUBXFaqWLUWLESjlwpsN2UtqZ2rpXXl2aoHRBjtkTzU
 v2r0D2u7IvjQT8iaREo156wthitKetCrQOWZ5jKj04X5G/TUzgLFher8KM+teF65riFI
 1G2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzd0Z/XmLTpR5T4kFRIhGCn4EHXp4BLq12Y+h7Pea95X4s2DeqiAUWbwiQxvtMLY/MjZ3ICOzQuMJYU@nongnu.org
X-Gm-Message-State: AFq9FYIISLbXFJKGVHrkuBuYk+zPFL/tIxWcCrh153QLW9uSCc/Qtcat
 M3P0XkmW9TvMDFsRLSOq3TN33UUo968DB6a4HUDep9e/SgXi5vzn6SEghDDPqSdstJvADdSspW0
 YJPRmjpelgpn1N/ynSUrce0IU/+vtnt18X9HNB7liMBicnuM8NXU84Q9RxA==
X-Gm-Gg: AYBFou18lHyZqQ1wzc76Dcr4ozz25fiPyEQq0T65ZUN2a/PQB762hZJZdlNa8oEQX0C
 x63cQQJC+XmOHZOtjwllFgfsf0Pz/M0oD5r1gjrqzUgv2l4kjirozgqSOnvtHaaUSpVDIcpPE+q
 TLm9c5iQBPdETUO8ZIGyxHLAMylQIwTyBI63AxoKfU+gN6h57tgAJj4KDPAbaL5AfMd9R3fyEy1
 n2+gz1K9UGOFoikb1CK5gHBwMvNLSC1xCHMrtvzoabvZDx+t+olODTESsLScYaP+VjUFMWlzHgy
 /eRLvL5+X0sdEX6Jl9dbJSqEtHD2cZJgviP5KzzYZjHrv9FEG6RtWPGR92dVxbl9AgChl7uypC0
 lZKT64SbMEVFwceYzP3C9UNBsoomXAPW8w24IJOx0G3SeXtxVnW1woN5D0aHa6MXEZ+VIBw==
X-Received: by 2002:a05:7300:8420:b0:351:7f5c:dbe1 with SMTP id
 5a478bee46e88-3537e02318amr25672438eec.28.1792009916752; 
 Wed, 14 Oct 2026 13:31:56 -0700 (PDT)
X-Received: by 2002:a05:7300:8420:b0:351:7f5c:dbe1 with SMTP id
 5a478bee46e88-3537e02318amr25672393eec.28.1792009916104; 
 Wed, 14 Oct 2026 13:31:56 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35b29c2f861sm39092569eec.11.2026.10.14.13.31.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 13:31:55 -0700 (PDT)
Message-ID: <eeeafd06-bff8-48a9-bb3e-f2e1626035a5@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:31:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] target/hexagon: add v85 scalar atomics
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014195223.3233623-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VKpIDNPX c=1 sm=1 tr=0 ts=6acfe6bd cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=_76h-Ig-ajUNHCtRXWwA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfX+qHcKhkF9bet
 I2gTg/P59+bPjKI+fB91W9nFuViwVrQiJ145FW/SHU8bZ3tncIAJon30OAiz4zsEPG/wuWlcw/u
 iYbD76eMphhsCjFZEpmVKpEN/kF9AAs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfX1P/nz4NtYBIZ
 8KYsKZNWsf6eFN9Do00aPJaG5CmotDUSzXPkBCKOa9/Un6t4r+tVE5ZfSOYCuc1toK8aTsVQ1lQ
 L9iJ/Pcgxu9myEGkgMIfcaevrO+4Evv5P9RrO75hj52MLsW3asCL/tHJZjBBN4aqhCQlr5kfT+A
 OG/C783oiPkmpyYLWa1iC5Su3MUDDYPfbLKIvc0ZA9eazrG484Jep8QjD5t7AZiDBWW/omk06Cr
 BSmzlJBCftSxGK8IzdRXijyS2S5KxKsoLqM6vaqVWHv6aDMCqk/c5vQImnbGSvXky0ABOCTspcb
 el55yf1q7Aiu5nZUKfRKdvSmI/zLEJF7HknziIRDNL2YNjXyET4vkR/Mdj32wzdjWebcblAVAoh
 dQ7sXop9fPJoIIC20IJFgb3PHUckhgvdLd1pJacKcCamo5JtF9gzOW5VS+i7sYXMMtWTEjx5CJo
 H5DGANyu4fppXoBsGZA==
X-Proofpoint-ORIG-GUID: rII_Hj6EN8x7I7kU_Asg94G6SJ4UE3eD
X-Proofpoint-GUID: rII_Hj6EN8x7I7kU_Asg94G6SJ4UE3eD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140081
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/14/2026 12:52 PM, Brian Cain wrote:
> The scalar atomic instructions are able to perform a word or double-word
> read-modify-write atomically.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg.h                | 27 +++++++++++++++++++++
>  target/hexagon/genptr.h                 | 11 +++++++++
>  target/hexagon/attribs_def.h.inc        |  1 +
>  target/hexagon/genptr.c                 | 32 +++++++++++++++++++++++++
>  target/hexagon/tag_rev_info.c.inc       | 15 ++++++++++++
>  target/hexagon/gen_idef_parser_funcs.py |  2 ++
>  target/hexagon/imported/encode_pp.def   | 15 +++++++++++-
>  target/hexagon/imported/ldst.idef       | 15 ++++++++++++
>  target/hexagon/imported/macros.def      | 10 ++++++++
>  target/hexagon/imported/system.idef     |  1 +
>  10 files changed, 128 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

