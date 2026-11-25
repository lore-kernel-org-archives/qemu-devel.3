Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF37606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 23:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JIfGWTPg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NKjH6xSt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWMWX-0007Ug-Ql; Wed, 25 Nov 2026 18:35:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWMWL-0007Rl-Fp
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 18:35:26 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWMWE-0004P9-Bt
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 18:35:20 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6APJAtCP648271
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 23:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JWo67icKfqqdexZ7gOkdZw6/A9lkZ7u1lcngt5h9rwE=; b=JIfGWTPgngrjHc66
 LZBfMwbOueZp/SykPpvWCYDts7r6OKbhFc+b1neao7clHsR47LRtmfvH7PMl7Pa2
 D/Xgrp8d2MuST6Kcgida+5Qfv1z8rfCCRuOMa93m85Hldv284615c7J4aKWDDpUj
 VL7x7P2Bi5J2AM69Oxrbg1sJGo/GqimirAhvz1CBFMkYytC6OxzAcDRwi6yB9OSK
 RVs/B3Qcf6WYB2iGqs8I0vdwb8xjdxe5SgpvT9y+Y8rswn9ALzZ+a7fKaRT69bXJ
 kxSKe6K7JPtcp0S/UP6MYVzPWli3zjw/CjQ1q6JCjU5g5LHAKGaze1IGv6EciFoE
 pioKaQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61ahswst-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 23:35:04 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-386a65fca25so5347646eec.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 15:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795649704; x=1796254504; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JWo67icKfqqdexZ7gOkdZw6/A9lkZ7u1lcngt5h9rwE=;
 b=NKjH6xSt5SkRX88mnVbMfC/hM6AYeUgSq9MU/FhjbmHpI/Ht1ow4zXnST/Bl+MNfCX
 KQT4gkK8UMLZjvb9kMywSbAkGiPKhFjBOAtQSAeNwvz2C4GsqHz1m7VJYHdGlpM9uXHv
 MaisIMJxVAO71Made1AMVROvhlAnFlHrT6bjd0QbQJwQo6vuIyt0/7O4RWuLA48QM7lv
 a80Soe5vsNVdePRtwEXkst9CUOvHJ2TRKLaqCZGhlAKVsvtAGd2p9othe1z5+w/DATov
 8ngNMjXtPN2b0t7duAlnkjXAr7J/LDAt/oBtytzysFvg/rQMhT4KTCOeigeNuNv3HCH/
 r9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795649704; x=1796254504;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JWo67icKfqqdexZ7gOkdZw6/A9lkZ7u1lcngt5h9rwE=;
 b=nwegb+EvaDtHABlT4nDz4TQ1TXGcHUbtIR9NgRabInZLNnUoeGw4cascogu8PqFNfp
 lff4iATXj1ougdqyGAWR6ghDxdemr0TYlpiqlcg9rX500qxxLTeIxC+KeXgLWrVcG0gw
 RoTH9JgXL+e0k7TULhtti8H0/XcYARq04rNbKiKsb1oiEmjh3kdxz6zQYfxIhCUHlTYl
 LemdCDNhe7M3bMemJeKYuLmUo7dpnuK/F/95UKTUqNXbeTowRzGQJPdixQDqPIbouKPr
 LBblVKK4kl4sA0iCL04UFXUwuJ5svsAEqXTMFg5Jb8ceWyrIb34iFNgj9J47686RvTyz
 8cHg==
X-Forwarded-Encrypted: i=1;
 AL+hErEDz9TnRObr6VCdiZzPezl2bUkrwSq9nAa9neGs4q8cG8Bah9DbUSi0sx3VUod+RZ2EYBGBiAKlKckk@nongnu.org
X-Gm-Message-State: APuU4Z9ijyJopuHAFFKr/thW99hUautY/ildeKb/KJRW4YqK65n1r96o
 vnY6H3Nyhiya5TBni11dCqQHuVbsPsaUmJ6OiI7sXKFaDtiEpoN0FSAXrx0X6ysf4k8CPCpLJ10
 /ERNZGkeeFWLmtRK0IDJF9HiQjZX6HhpNPsg5XO9mLn/x/Qu58Ns2is0SWg==
X-Gm-Gg: AZFdTZcEIKEdREesOibjScohT5AmUvyOCE5xeaXHGBLYcjo54CMlzs1AC8Lt53XwgYr
 CITngujuSc3i731efH6dQGm4GowT7WIE7YEihwZ4sWDSszDOucj9qkZJ2LHsFhfHzlqQPf1NfLi
 Yupj2CwtHm6QoYkFTacj3tVH4BhLoYqe7HQHWlya0KFg95sYmq1HW0xpN9bplFEWok7wxAwjQW2
 66w4Ant75cv50FkWT1ah3VWCRxT0YtoayaxLAmxleHhE5ZaqG0KrSiQT5IVgXkDn9Ts/fD2ysCB
 Je9afLPsSOYQ6QIL3wa/GEbNrMXX2Z7AKBj5SO0KpaE+fNvGj7roc7V9K4cWeK20yCJi8NOHCs/
 D/qh4t9/5TmZhGv8UbJZEd361WqQkU8AUiiXyn7jX5XbihUry8B6Syjla0SlsUIzsid7fm5d0yj
 qntWsWHVf3xZRhEmReP7DSMIctE3A+9utE36FtITKE/wA=
X-Received: by 2002:a05:693c:87d6:20b0:386:bc19:6a30 with SMTP id
 5a478bee46e88-386bc196d10mr8483687eec.20.1795649703625; 
 Wed, 25 Nov 2026 15:35:03 -0800 (PST)
X-Received: by 2002:a05:693c:87d6:20b0:386:bc19:6a30 with SMTP id
 5a478bee46e88-386bc196d10mr8483668eec.20.1795649703137; 
 Wed, 25 Nov 2026 15:35:03 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385d2b93dd9sm64828801eec.24.2026.11.25.15.35.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 15:35:02 -0800 (PST)
Message-ID: <6c043791-8106-4311-bbbd-36a95a290cc1@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 15:35:00 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-12.0 2/5] dump: let targets set e_flags in the ELF
 core header
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20261125194855.3154845-1-brian.cain@oss.qualcomm.com>
 <20261125194855.3154845-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261125194855.3154845-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4sD_tVqfFraS1mrI194cqmVwunv6neuu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA5MyBTYWx0ZWRfXwZDzzJhzHhyc
 Nodv0oI+C+rQcY6HZy1Z/QEI1aAVHma10F0JWspHtqZ8iqbD7ng2BwqJbejw/VPdVNp7EWnqE23
 dv33nGbE86WgRcvA+ReRY+RE0081SZE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA5MyBTYWx0ZWRfXxJFm6aH/A6tY
 O+10W3zEP5GFeBCMg7ugl9QjOKra2ga3D7jwW3pM1C185EgLmCqwN/Vmmxj2X0yntSjAfxFeB7X
 WRD1VDa2IrV1y5kOzNo/bUh5ILAIwpc27SYPVov7mmbWC/7Awk2rgt0ObI/69B71NQ7OSLAqAAQ
 pNirm8k3FRYLkMYeeaQmnjRaHZP8KgaijrlGCqATB1eLqeVVkpTd6nzXvlrQ5PQeSnOyWxQytqI
 li3msvru0pcysxFQ5Tro6jFvxmahltqWgiQezcnh0lCeIJaB44HCBkw6KL6If/Ypnfnh5KuMS+1
 09vU7DD5MMvpfndqi1rZscrLrHdOznSdDG/KeOkqGqWYJiZbhsIpuvrbxwgx0jDzh9uQtdGxgA0
 zUhHazH7rmLsSn2opE+5EIdTYiwxwAKJ7pisAexnBxYKGZmKdE0WhmEtfyBqp4kNncK9J9t0ik2
 1vZExCBv5bwMzR3ZKvg==
X-Proofpoint-ORIG-GUID: 4sD_tVqfFraS1mrI194cqmVwunv6neuu
X-Authority-Analysis: v=2.4 cv=BbxNQbt2 c=1 sm=1 tr=0 ts=6b0770a8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=N5RyUz4TmgjOJdWA_v8A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250093
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/2026 11:48 AM, Brian Cain wrote:
> Some targets encode machine details in the ELF header e_flags field,
> hexagon for example includs the ISA version.
> 
> Add a d_flags member to ArchDumpInfo and emit it in the ELF{32,64} headers.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/system/dump-arch.h | 1 +
>  dump/dump.c                | 2 ++
>  2 files changed, 3 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

