Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3F060A2639
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UG4Kqba5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NSZAOHkl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIveF-0003OO-S4; Mon, 19 Oct 2026 18:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIve0-0003HX-KL
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:15:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIvdz-00023F-1m
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:15:48 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZkLV200671
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cmp3zvFWstLxNaWBbYOhX2V+6AMtg7b7SM51ghYyp/0=; b=UG4Kqba5o2pbOuH1
 1mOBnzpg/+nt5SHyZqIEeo94M3v3YntPfLxSJxQD/qURwOj85B+i9Tkw0Fvs5qJR
 MfPx/d/c/EV3v5ELKA+CL/XVAedsofP5ftVsqV4obAy26EgR1QJX2ztqXH6Ptw24
 eIM2v1K7OSVdVtigedd7sVul6bloPde6JG7zOe2/LKOu6MSJJVW56N3qFvf6bpb4
 Aw2HdXhQOalkREDymmRc4X2VFzcCLFj+ySjcV0QSFCWWpIgemsMo4EV5zkBaca12
 r2LLomJ7vrxQ67LxOXV8ea3NGuIHmTm/BIlY2FTBbT/AlIGXqpqLjrqJRj7y5nGK
 4sTKDw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr780ttc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:15:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso4370813eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792448145; x=1793052945; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cmp3zvFWstLxNaWBbYOhX2V+6AMtg7b7SM51ghYyp/0=;
 b=NSZAOHkltNrgKdHFL0Lh96eqveU2bBVfPIaHArpHHX4kha5otglhkPneDZ/lP4ExaL
 tBouy3+Ycqdl705Ir6gg9c+pciCkuZVUCxt7V+OFRZH2eeEGyxrgNkxsq1CmHgL3kcWQ
 +s4zRkGSccjuJwnXizGsGMy4YkOe1LI9XkKuQ3frcmJe0Dwu2EQiYLuzkR/jss6F5KIy
 ta++ukx6IUlVHf2uAnZ8oDKZWIeXcjoGaH6/OF8V12I4Gh4k86P1VLJMlubNG9OmSjqs
 /Vlsnnl1i/ei/pS4J1LHfo3RqwI8AW6N6HOhGAlyhxeyqVzCc6GbBx1K+Ll1LSMBuP/o
 Cihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792448145; x=1793052945;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cmp3zvFWstLxNaWBbYOhX2V+6AMtg7b7SM51ghYyp/0=;
 b=oIG6VYnIJFfa37LDqYspOhDufARVUifpkrTiIHSABs+QT+wsa+gei3eCGhbUJYZYDG
 MpRVilAPdce3mQA66TMwahf92skg5h74XX/8ZN70KtVawxLe3ixBhiS3TNsaARX22feU
 Z8SY/3QEJuwMQwJMeyAOs3Rshj2K3/MK+LHoWYbaWBCZYOYjcNlOCtFO3I9OJ7AGZMCy
 tcR0B4EKfp2p1syrq2EHKm37ffaLp7BjDuAmyUA8/9IbDO+H2tcNC8TlPGoUAKGUIekG
 a6YAkuaJS8Aheul+rjOJZ31X4DUmZyW8wFIvzzVjfNSyAJHPuBYfRuEjwd5FV/QxRdwc
 87jA==
X-Forwarded-Encrypted: i=1;
 AKwUvBygkz0Z1EC6egwrLGUH/IgF3f1gUTMRgVejm6BUw1yk4ewyy2DMaVMGcUWhdzMa0jiAoWFjeK7wm8/M@nongnu.org
X-Gm-Message-State: AFq9FYKaMJfShZhwxdj73qY2Z6W/BF1NAqceL5J7Rv0wY2uUcSP51JXl
 tEHG3tTNTsKRqMcnQnOrx4YbQeY2kP4FCz0shPZ+/XKp4NX/lpHaWwwfRsIvSSJNQrdM6zFWzBi
 gncDqn1TctnvVt1j7xmr6LdfEYMahlTKCzxCdyuffvU2YssoQRyTPT5etSw==
X-Gm-Gg: AYBFou32iZ7nsZ8+KTTZpOOQh1cogsfmGeyXtFitS3tZ534k+cNms6glUxXPcYlnap7
 z7Xp3FtRXVr6l6RWd/rKTpZZAWellpLwmSx3Lygd1AC1BmP/+KQ8u29K4QNMlitAcWB9F9zWvxj
 PzRoXPuTEpjlBZRMOzgWCNLWP1xyzxwSD+vRKk/GLYTvocUTL1CsuzfYUq0KmtKR6/l0D42lyS/
 afmDBEeKXnTOhhpGpzYWOMTQ5hk2RwVe8v0EzvAyi+pRmigO5CLhbYbTNwbMCi5H08EF2lurGDX
 jfC4EQAdIKWwJEUbsOmSzgzPipmGHgUy6AQ+f6i7AVL59YV9KrKoF+oimjh/WB/j0PM2cwYh7bF
 EbEGqlK19EW7hrpTm6GOEiL1iQ9Jg2LpyPlNiHc7vIZRSeyUejCRQuTAyD/1qFooUMW7oxA==
X-Received: by 2002:a05:7301:6197:20b0:351:4d2d:af26 with SMTP id
 5a478bee46e88-3619f1fca55mr13317326eec.2.1792448144942; 
 Mon, 19 Oct 2026 15:15:44 -0700 (PDT)
X-Received: by 2002:a05:7301:6197:20b0:351:4d2d:af26 with SMTP id
 5a478bee46e88-3619f1fca55mr13317285eec.2.1792448144291; 
 Mon, 19 Oct 2026 15:15:44 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm58453842eec.28.2026.10.19.15.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 15:15:42 -0700 (PDT)
Message-ID: <5c293cd9-8296-4e46-8e65-26ebc762841e@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 15:15:40 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] hw/hexagon: add the SC8480XP NSP0 machine
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-9-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019055245.1457795-9-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfX4Ufh1SmiFs2V
 vIrFor5C1MUKvaePzXw3KnknFd2TP7M80sY7cHgXGM62FZjDVwWYLeBSUcQMMLOInErtC/77G3Y
 +DXTN0zIgeG2DpgS2RmNxOWxKgN4NM3He07o1E/W2lUbMsnnPCllCj43IqGplRiqRITRg8qXxD4
 8uwshiyhYvl8OPL3EW2snkN+TKi1AAWTUuHnZcbMBPvBkw0hwq+c4Vu38dxLaOIwcImQYxpMv1N
 5B4MMr3rdIs0BoYjOPKpNBgmpgw2JbD+cX28jrixtLqK70VUratNDE9H4IuNL1ecRRuVLGym95P
 b4+KLcUg6o/k5yqDj0CRUBgJTTDelpPN0iaTR8LDIeECvtvpAwBqiBV9QehgEu3Yq+kF4IyyhIW
 0ZA4rrOrCs7nqpSG6/y5HAm2x79GEE4PryiwdM4URLzvnOXN9Jdj2MobdGxkoXUBaS2YvewT49Q
 q9ZF2RqDccdkIW5mh3g==
X-Proofpoint-GUID: mDan-A5NnuXBN3WnCAES7OThzDZG0uQ6
X-Authority-Analysis: v=2.4 cv=LKnz05W9 c=1 sm=1 tr=0 ts=6ad69691 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=FKJOJ4UNXjMlZ-yoCNQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfXzGu/jHb2vE+s
 XVmv0w6ci4BC4MVmC8ISYkI9d7VB8xlCxJ83O8VaOMgBZBgy+JiMLhQpq3A0vP6tx2ok86sYNZD
 kL2GmUp1vm8+qgqEQRZ9UPMSAnqwyJ0=
X-Proofpoint-ORIG-GUID: mDan-A5NnuXBN3WnCAES7OThzDZG0uQ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190088
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/18/2026 10:52 PM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon.h               |  1 +
>  hw/hexagon/machine_cfg_sc8480xp_nsp0.h.inc | 52 +++++++++++++
>  hw/hexagon/sc8480xp_nsp0.c                 | 90 ++++++++++++++++++++++
>  tests/qtest/l2vic-test.c                   |  2 +
>  tests/qtest/qcom-dsp-test.c                |  1 +
>  tests/qtest/qct-qtimer-test.c              |  2 +
>  hw/hexagon/Kconfig                         |  6 ++
>  hw/hexagon/meson.build                     |  1 +
>  8 files changed, 155 insertions(+)
>  create mode 100644 hw/hexagon/machine_cfg_sc8480xp_nsp0.h.inc
>  create mode 100644 hw/hexagon/sc8480xp_nsp0.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

