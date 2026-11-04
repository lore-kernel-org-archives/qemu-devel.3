Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2E5606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U73ctGfv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T6xfsl2F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOZrN-0006aP-5k; Wed, 04 Nov 2026 07:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOZrF-0006Wh-C3
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 07:12:51 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOZrC-0000wY-O6
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 07:12:49 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4BaCSX2728969
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 12:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +/gzBL355anQUTmmAMu+D1buk5BwDr6MMeYXZjrvads=; b=U73ctGfvc4K8fBQv
 KSwnTRvpGVn53SSRFee+3n/RA1p/dq9VGkIs7YmadmelUW4F7yN1IEeuwD0CW5KA
 WBfasPmdrFvUNPNrSZqnw3Frcant8zWLO/YNb30Kk/tfr9xqe82bvtbMhUrhjsk9
 2NrDhxJ2VDx8JyOFzzoq1TbIqL+E/tE/MMCNTqWOSUO4KAhmHfDFnUutk5NLUSal
 L/maz6FIzcsAslkmyCrh+bVjPvD50V/YwFvlkQrIffB2cOxexqJ2mmmUwF3gLwtF
 kjqTsfkMrzZj00FutXoUr4Wp8a7jYhlu/YmPD7EgrlXldT+DAHykus9L7qnWYzcs
 et5cOQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqpuvb9t4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 12:12:43 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7cc06b9ca9eso155935137.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 04:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793794363; x=1794399163; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+/gzBL355anQUTmmAMu+D1buk5BwDr6MMeYXZjrvads=;
 b=T6xfsl2F21pIxvGkDlVtYSzF4ceOdrOAkJzoMbb1z756x2/k7YmmRDtrzDs6zzmjpC
 POURU1fLzRzmsHCTJJzNkdhR3Iwo/YRXzxR18nL4x3irMliuI1BymCa+e/Ej366yZMd4
 wf60Sv8k9vaCAbYJQ59HKHL6WhukYL95fASc3eLavbzYM4D4vxF46C+XGRIKZ2B/8vWR
 oKUKm/1PQQxfkeZt+iZsp1IKlFHtly323QHM/bBNXf+H/jqGc26X1FYsUUzWvJYKvuhc
 KGf/9TL9wExbUJJm8cKcaqfmElL0v4GEA0M9cqyr3uCPGQPxZ2ofLbS8E8pLc00RJifH
 owFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793794363; x=1794399163;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+/gzBL355anQUTmmAMu+D1buk5BwDr6MMeYXZjrvads=;
 b=EM8FjMa7y/DgQYj5PFpjm2hxYaCz8GJQLVnww+kF2wfgVSFK+nH/oEuKGLrlyxu3Me
 boU+2dYRe6yVsgMyi73bgJTM/dMDHtpcYuMWgsM4ym52eWfKAReuMe+8nTd4j4ltvjtu
 ZdXfW5znKuxSr8cZj6xchJftrI/jsT/LVzD12NMKe6ZPq9mx8NfFwjnm6KJLNIsm5Uqx
 YID/zEJPbYHgeP+y6uEVUxWl1DtwG61osq3zeZCuwVQi5cuqMVz4P60sTVYKT5I6fu8d
 Jm735Lp3amI34MukzyVof4ZZ+x8JSfyx15iu/sQQ9dJXZ/1VwJZiuUwg1LtLdP/YPy+5
 h6vQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6XlZh8MstmCq/woGCLtETavRkDTpqR4CCYidN0aaUV9rNucKxbqwyhf/fEes0mOii4FF6eq8PytZa@nongnu.org
X-Gm-Message-State: APuU4Z9Mh9Za2RrWABTnE5lgOfGunvQUH1L4plmG701NEDqZe+oN0ZiE
 UHuMF4SkmqhsJAMyiCgfjvZT0m1yRBf1aVO/nWnMVjAfz81NpS6/DT2mR90tcdq1Mgg7sDCTGVW
 otTzEsHn0jKyKLZKs2Hppzn9TpUbSTN0CgzKVTwxXmYYsjEQeo156PUbB0g==
X-Gm-Gg: AYBFou2+7AZpPT62U40kQEl+dlmM0pWvH3oL1H+gBqwDko6fss5LhdvnVB++5TQi2Uv
 6CnXMA6WPRAAjfXLC8UMhtAdmAwAFTHsx5ylz/MLaEsNHuWkfOwYSePuPSjE+BIerhODFzreHOL
 Ls7PSZin70wvLzgJWrsL8GJH9bBcbW4TgjiOCShAoMUIhkkjAQHgDWIS9Z+MJsAcGj0g7uB4vtv
 Vx4gAWoJvx8XfwDmTc/J93AaSosOkZh/l+q6uC4dTpbDknwmNTVBQd/zS/mwEaBJ1+mp6qmQPej
 dGqjoWYg1WHct3egKbKi+Yhy8BQtWZ/68gsLnBFPb6yaO/YqzZCd0DU8Hf6+3TowaOLri7elvNe
 4PdkmHfdtUysUR/cnO/ZqP2frCQ9IDgtWqUeMo9xSMsbdfWgmPgWMbL/fK8F1UYCZ9Fc/6tkWFV
 9t7R9XQA==
X-Received: by 2002:a05:6102:418d:b0:7cc:c104:6dc6 with SMTP id
 ada2fe7eead31-7d07261f9b2mr5162674137.14.1793794362782; 
 Wed, 04 Nov 2026 04:12:42 -0800 (PST)
X-Received: by 2002:a05:6102:418d:b0:7cc:c104:6dc6 with SMTP id
 ada2fe7eead31-7d07261f9b2mr5162671137.14.1793794362310; 
 Wed, 04 Nov 2026 04:12:42 -0800 (PST)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec9cd43bsm3760201f8f.14.2026.11.04.04.12.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 04:12:41 -0800 (PST)
Message-ID: <105d0d14-f3ec-4a83-aa82-96365f91c736@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 13:12:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 3/4] target/arm: Only allow GICv5 on CPUs without
 AArch32 at EL1..3
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261103172616.2400758-1-peter.maydell@linaro.org>
 <20261103172616.2400758-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261103172616.2400758-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O6SsLx9W c=1 sm=1 tr=0 ts=6aeb213b cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=2OPPvVUHo6XKvPPvzmcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: dX_Y8jg_7OuFw0GkhZhcodDBQl1nHAoI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA0OCBTYWx0ZWRfXxJ0N7ih6BwwZ
 fztlfDgCS5lDgL9DHtzjkQ2m9NA661N8vHyVwF3E3hVXb2TvbdwHjxv4yJQDipM/UZZbjQtN9Ng
 W6NzZtg2HsyeHKw/iBsflFZvG7t/MaE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA0OCBTYWx0ZWRfX4XlSvCyreHom
 JQz+nzqfYNIwJnICcf9ZJxIdhg+3/RVytKIvNCvuFxPbsQGU4IHrhaia8Ny35QfTjwkhRwlXo/B
 ZcNvnTpFJpyfeHF4nNZhaik3wA8MiT9kCPQ1Vg1eT/Nwv3sUh73g7wdDA6ms5r8TBGB5Qxl9kwI
 cGTVtVwgDMWeLTpkB4LlOd8zujnH/pMtzVv5O4aZ6NWpbwGEYN/FYcmfmqe2b2FuooxL5BqwFU+
 Fh8wwqLnBUrDI9E/vtTUlMufRtWTwUcLxgw+oMugNlyxNnPCpLCLIM0Ff60wVMEMgFb1aJqtxm3
 AmFiHfqxEPezkWDXoewYAhOiZqok78Z7sRsEe2D0FCQSoAXuklRm3MhfHf7AMwpfgdAnSOfe02y
 o5Zc+37u5QhJq4YnsilAw2SidEU4O3SjmZFr0r/6O6Hzb49Tr7xfy/VbXzb+GUViL11yDMoIDHf
 Hfe4fiN0pFKXn1VDioQ==
X-Proofpoint-GUID: dX_Y8jg_7OuFw0GkhZhcodDBQl1nHAoI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040048
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 3/11/26 18:26, Peter Maydell wrote:
> We previously allowed the GICv5 on any 64-bit CPU, with a hack where
> enabling the GICv5 silently disabled AArch32 for EL1..3.
> 
> Now that we have a separate 'max-v8' and 'max-v9' where max-v9
> correctly doesn't implement AArch32 at EL1..3, we can fix the "when
> do we expose the has_gcie property" condition so that we only allow
> the GICv5 when AArch32 doesn't exist above EL0, and remove the hack
> disabling AArch32.
> 
> We could instead have defined a new ARM_FEATURE_V9, but "allow the
> feature to be present on CPUs where it doesn't actively break
> anything" fits the way we've generally handled things in QEMU, and it
> avoids having a new V9 feature bit that we only use for this one
> thing and where it's not clear when we should be setting it for KVM,
> hvf, etc accelerators.
> 
> In practice the only CPUs which will allow GICv5 now are max, max-v9
> and a64fx.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu-features.h |  8 ++++++++
>   target/arm/cpu.c          | 37 +++++++------------------------------
>   2 files changed, 15 insertions(+), 30 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

