Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC06D606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kREStUp7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UAeotniX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTODp-0008Gi-Kc; Tue, 17 Nov 2026 13:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTODd-0008GC-Ag
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:47:51 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTODa-0008E8-Hg
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:47:49 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFR1rO3503809
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lLaKAT/jX/maEgsl83pCrNMF/a4I3hK4LflpZjxsaFk=; b=kREStUp7rKm8M2UB
 K1fWnMPXpmLvJDsCMA2zvy8Pjc2DWXtiJ4rSSCR/wL7tqmFlnwnieae0AJ1HlRgU
 1DKbzN4fZMmvVX2PWFpK4uGDwfgCUolO9bOl10w5Cz8z4VGWAyW1b+ezOf8mbzZu
 DWrSHwefvvW7xZYWZBExYoUVvpeV+iCypRrjvknFD0KccifzCdyEx05myyP/nACc
 QgbaassEUYAHjjMyEpLhb6MyOgB3WBvt5Y/3BRcOhqHeH2wSsilh04ibUnasORzI
 kAdCFcyDgAxWMKHcwXP4pIccEkgY7zsV+Tw4HbzqFRoIJBGEPK1d2QgD18k3Q9iq
 W73eLg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0mv126r4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:47:44 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-37549877380so118816eec.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794941264; x=1795546064; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lLaKAT/jX/maEgsl83pCrNMF/a4I3hK4LflpZjxsaFk=;
 b=UAeotniXLxFPl8keWIdor/mgogx6SALvSFPs3Vkg9Cej54RMGONuuwzc0zZjdj8kQz
 po+Bhmywlrg0UwkX4nfT8BWQpT4jir55nx2WOyPp7GhFMH9xXCa758ASkBPEDN/1rXFh
 BpLYPCUkIqIYAxVOjQTISBpHSxzZoZ2xSzua/M2e39cK/8RTu6MfUBKkOeIKqLzuv5ZI
 q0KXQO1j32wvgivzeD2FLdZEbrBpgeFlP+0dp/WIBR7Yc93uEsP+1wy6YBbnEUWJwgBa
 tOBld1XHBORmC5Q4RfJ0xNTWejzhj6YcFJ2kcF/NZuicaLjJROFqrL4Pjaf22KXr5g/N
 F5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794941264; x=1795546064;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lLaKAT/jX/maEgsl83pCrNMF/a4I3hK4LflpZjxsaFk=;
 b=zS0eyj3hbCKJ3ekOayniJ4R1xXF2MYKHdXvP+vPbH9HZ1bqSMwMOb2qLuzsae0nhLK
 m9yHPdENRZcoCNPwfd9dDG6RHvAA91dSK1V6sVEyIQE7cpmuH8k7uTAgYKci7UWWpuji
 MsselZ8sLKbKpvibWBqFO1O1N0hD92DH8Xip/ObkJeAEqIcebdJ7YmjBQHkIKrAcynEM
 9GYnjZbFJnx9q+Y5SLQFeq4HX17AuxOyQwZsnibh7to51j/HT2B+ZfnnXc5iFqPRAs6J
 NfiVu4aNN17eqevwFMTZzO+TLxSj/4+QpR28pAGbqX40x1hjIf+TZliXc9BbMYLUaRwN
 wm8Q==
X-Forwarded-Encrypted: i=1;
 AL+hErF2J8KqRS9adjarHHHE2IJzS2bYTETiHDwb/QZRr+0zMZ0RsVOr08zRyZhugCG2P1OZdYIWktuS4kCD@nongnu.org
X-Gm-Message-State: APuU4Z9O/ygqSai4v7cPz50oF1dw2BdM7Mv4p8Tlm2JKoBMnH1E3lV58
 b/Vnvkw25GNHGESyxUU251RTuRkVnx8GAJjOlvwLXZeM5cQWgEOo3dTItvxJsTOEGnEcnynQ8AG
 e315Tu7QhNDv7gOfG432XrGfLQF/Mwumbkptrk5Vk91bYDqvM7wtfBOwNyg==
X-Gm-Gg: AZFdTZdGacQbR68B7dae+WznKtAHA33uiMx9a4bBNCtbwI613lhLaIERzmuuPT10+N5
 zm8FTOcKPKm6jMdZQMJS4Us/yYfopopvZ32YUuwTZgaETToJ2nZILTYZGu/tP/utJXWD9xgAzT1
 geKWg5VMoVwYRM9drMbvISKMFtHbaTV8iMlJDDrYpPeFsFUH2s5apDLPpPc+BaDOW3un/FfaKpK
 cI+3RMgWlmXXT5MmYvFAH6brXzIsOB17ro41ZgrTFcYnKKVXtccgDyKLzUKxpbMFr1cK2FrV0SU
 JICrYUKFdydSUlmeOgUQ6uhhJg3RV5/D94FFTKJTEjWDUR8gVNDi6juRQMmH/F33QiKJm7kjofA
 QcVZg0qF+BYiqf1kgXT5BsDIyYKKjpH+KX5srXKZPFCWHzgjB0+/VabRlpDFuQrv/0XBZwiF0lp
 gZHtj5yFe2InMlBhw/26Es74Ie1LzVHhUaJNiFtTgUwS8=
X-Received: by 2002:a05:693c:8344:b0:36a:7b3c:4e0a with SMTP id
 5a478bee46e88-38281fe2c53mr243503eec.24.1794941263944; 
 Tue, 17 Nov 2026 10:47:43 -0800 (PST)
X-Received: by 2002:a05:693c:8344:b0:36a:7b3c:4e0a with SMTP id
 5a478bee46e88-38281fe2c53mr243481eec.24.1794941263403; 
 Tue, 17 Nov 2026 10:47:43 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-381a55555dbsm8537627eec.10.2026.11.17.10.47.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 10:47:42 -0800 (PST)
Message-ID: <dfd5a570-700e-4c4d-8420-3f4d477af201@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 10:47:41 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] target/hexagon: reject HMX operands outside VTCM
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
 <20261117183629.2002840-5-marco.liebel@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261117183629.2002840-5-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CtDTs41Ppv9dgHQ5w4vnX1a5eckSJd-d
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX+SoTEjsXnIxU
 mCf8GGVotJxCFVZFeVQVF1PzoD4YT2B4ItQWCUBm/nDgQ8t70V1XThodpStZC+ZRNCvdh29NQEJ
 ThsKGeGeqosYHytx7ySmJPyGysPjf9w=
X-Proofpoint-ORIG-GUID: CtDTs41Ppv9dgHQ5w4vnX1a5eckSJd-d
X-Authority-Analysis: v=2.4 cv=Cuwq4X4D c=1 sm=1 tr=0 ts=6afca150 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=TKH6f4qpilhQfw4zq4MA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX9gNDlsdL81OZ
 b5lRV0NyTbw2p4h4PlrPHr2DhKy+x8d+GaVtmVtocl/GbvpK3/rZabz5lyUsQBhgMKxWp7822hG
 WUUD8D8dyL6WmjN/HXwe56RHvGz6KhrvLsPt7Gs/envTCXGTnFxpNa+d/CXt7eRfz1lkgRj08zF
 +DvA0HcD36pthvKPY9HT1sgorViHP3pDtZA3OCSoyk1KE7eg0U4aZw3RWp96BPrm+ADZdmKIMhl
 o6QwTgP2hkhm97BZTAsztH1h0YUSTbyqZGlE0F2M80uW93zmf+kJuI29Ccr1xFPsOAqlhYkxzGK
 ar5EavoWUgGrv9UY9ssZ7AvAuTbdsvmRa4dKnmYWGIkXaUPqnF1ik+ykoRKXQaRXXbDhudkRLvW
 3/xf+1jCbTV/thvPWn3/RqGJbP6jEswMzHvs4jeKLgpGSUhOUpA19tPmFc7YvkY3KZJ2giNMOJR
 IRj5tVPoGNC/IIxY+gA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170074
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

On 11/17/2026 10:36 AM, Marco Liebel wrote:
> Check activation and weight addresses against the machine VTCM range
> before executing packet instructions. An invalid operand raises the
> precise coprocessor VMEM address error and prevents packet commit.
> HMX arithmetic remains unimplemented.
> 
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>  target/hexagon/helper.h    |  3 +++
>  target/hexagon/op_helper.c | 19 +++++++++++++++++++
>  target/hexagon/translate.c | 11 +++++++++++
>  3 files changed, 33 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

