Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2394BC43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weoSE-0002RY-UH; Wed, 01 Jul 2026 02:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weoSD-0002RB-7i
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:29:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weoSB-00011W-TL
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:29:48 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6615m5W9126701
 for <qemu-devel@nongnu.org>; Wed, 1 Jul 2026 06:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zBrx/znEIt81CrPxutIyu4rGfGyEoft4AazNPhuk3Bs=; b=LF/HmGpMiuTlf57K
 8xXxsiw+aYWoZo/9t2+KaJmUZrWiTnDJmsCUuf59ipru/QKgaIpteCktDc2P4vrP
 ozCkVRLCDafenedU+153qsfhtTT9KjjdJxAlVTjqzqQCRbpmBcuEq0ijIqWckkcM
 +aYVKuXJhLbZsOGIAHGqn9zLVxO8tAf4NhlNUXHmf+Bgx4e4EB+pCwZ0NQE9L6QC
 3LwAYnqw8X6FgT3hvyfZCFlsD5TntTsiTXPBKDlqlN2L9gDw8IBZjFj4/owzsKcB
 jvvXZUkqKKx99YWjdR9yF3pvTgL5kTc3XFsbWku42Za6qpzm4+2XEFxB9qZskC9o
 94TU8w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4fc0brbm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 06:29:46 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e52306621so30761485a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 23:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782887386; x=1783492186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zBrx/znEIt81CrPxutIyu4rGfGyEoft4AazNPhuk3Bs=;
 b=i2r+R9ixXVfqUeLNHcR80Kut+dpZINStRJwohym9U3SfgaHBCHKboC1PmMruwyaWuD
 vmLVj17CODUafeLmldhk+g34w6VK43tixyvIeuSVion//cUITiDQpdf/RZzk9jQjINFb
 iizvugICrvy0yBw2uH9txZoadomcHupmpi6XGsNQOKUXtvyYLTZGTu2vJL840q/KH92I
 P+3P7kSx7YSY2RmLfxpIs0j+osokZieemdsbh0czs8T7ukcxOi9kflraBazCTbLiasje
 dcN/wkFtK2TWPNLzU9FyEGGwOvz7dG7lvKMEiE3GKYHPGxGIJRvLngxLubc6ZkiGS8EU
 2n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782887386; x=1783492186;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zBrx/znEIt81CrPxutIyu4rGfGyEoft4AazNPhuk3Bs=;
 b=j2q5zBmybAEwX+lCcLdheIlezL9E2V2tBu5t01MIAVkvHcWu5kQE08uSS82kSOYB6P
 F+1GPph/LKKnQK/AvCCfE2AfhLFhGJ7eoM9sakFJZ2vlYZzl/zpJSqalWo348Onp/FMa
 ZLwQCD18ZF9qo3fmSp8IyYS6ru0f1cVvU46Us2UQ965Op7jA1jLrxW0aV6NreDHWz3b4
 nEcgEjMnuGSwi6E3ZEn2Yhv3RHTzLHgbPD4wDB8YhiGQqaeYr/AgCQ88NbNAUAH0mFzJ
 a7w1Xz8g4+R/neA32dgRHC86ND3vAAVgsuxicTAfBSqAFRmCuHviCmIunagA5LZYBKeW
 soow==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tpslXiGUXeaoOvpjZqlYYskll1akqXNwZSORX+QtznwqulVzbZfzf4SMnwrGm4C9tguGhROLbWflI@nongnu.org
X-Gm-Message-State: AOJu0YzV6Ob/p0OxeMIe6R93Qhdya4SlSUt9ZFaVb+rc4ve7IDO7/owb
 ipJiVxuKuu0NastAxXtfWpYpWOEYPBZgMbkvhKw24WodU7rLWvOZwpmRTOvnlV0TVSE9LoedcOs
 CsadDkFE8vc2Qc13zPqgFIr92bcg9CfuKD57CLGiohrdnE06ARcvPGIMA5A==
X-Gm-Gg: AfdE7cn/KarS8mb+Uu6VIVqpKRRkrlVBYeNAiu++OFrS0UoJgiILy81cRXiHjWX2ZcA
 IbhT5izlUZTjKKhoKR6g/gDjqHqVhoknBkFmpbutjy319V0BzoYw6o2iEqcJe3sQJlMFZAjlLzz
 3bgCUK90YykBLH5itYHDQxyAiVXXOsO6f0BCT/8vF99z9EN/CuQPYPkQXIIVC38SsFEMFn2mY1V
 xLO/q5DC7WswEy/JwQ9Ks/fiyXqqSha98fBYhblpAs/8BJeUB7Y02T/5y64ohUotkfTJ2SvYVcU
 QUFmwZmkjhyrXhG7erfkx/w6E6YpVQym/ZgeW1tj2PxHurl6wWqZfYIJbJFG+B7MdP6Z1kC6Zlt
 V3+pm8Ue2hhLlLwE123uXqJhbnt9Y80+Oa+CXYOvEkuZmnGZSNIPqg8476h1OUw==
X-Received: by 2002:a05:620a:2906:b0:92e:5afb:7ca3 with SMTP id
 af79cd13be357-92e78256ba6mr43987085a.21.1782887386405; 
 Tue, 30 Jun 2026 23:29:46 -0700 (PDT)
X-Received: by 2002:a05:620a:2906:b0:92e:5afb:7ca3 with SMTP id
 af79cd13be357-92e78256ba6mr43985785a.21.1782887385892; 
 Tue, 30 Jun 2026 23:29:45 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47563d194b0sm14822961f8f.1.2026.06.30.23.29.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 23:29:45 -0700 (PDT)
Message-ID: <c1f50928-4b83-42c1-bca4-b4d5af3ef7c0@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 08:29:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi: Fix misspelled section tags in doc comments
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@mailo.com, zhao1.liu@intel.com, eblake@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com
References: <20260701061136.798815-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260701061136.798815-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA2NSBTYWx0ZWRfX8gYVA68YLzQl
 s7OoyLEdtHoBE+FqN/YHj3aiMi28E5q38X7dt/qCh3r/qpDuB04VHJWY7/YzZX7DnVoxkLkatY7
 Yow7v1A5Wzoq/N5g8gTF+a6/NDt0epGswpHW9v1pfmMi5wlRasc/PwKOQddzjd3Lr39ev7r0kyj
 RhYIKh5FpweF2cEOn1Vsc7GFwk4PvQaI5U/RVE2rF9hoAdIsHYarJyNhTYDtmMC4Ik5Y35Cy9qj
 AYFgSsXR7gUFGo5Y1YyBlS4M7WQkZJAXNHXMYFLWYHZKoPNgkXERTaazSz244MNAjim6cpPpWcG
 K12eH8bjjrAhpceBXVOdp6NsaONeU14q9YGHHgkel7SltP8a8qqzGXJv3lzPG8qRstCp0sP5aZP
 jhJeFoxyFNNUsjO7HjWFpCYiSTfxIl4drpt0mVhkm0XvwZov6eI8NrcLUm2qHq22fEiz723l7V5
 8yqrAt52VXwaK44Wpag==
X-Proofpoint-GUID: AsTHdUHVB2wxM5k1GQKaud7I9dtg7Eqi
X-Proofpoint-ORIG-GUID: AsTHdUHVB2wxM5k1GQKaud7I9dtg7Eqi
X-Authority-Analysis: v=2.4 cv=Ivkutr/g c=1 sm=1 tr=0 ts=6a44b3da cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA2NSBTYWx0ZWRfX8hGUEIBKdQ2I
 iwXMysudUaa5eUi0Gw3eupmrCrqnXNDShbyJjTKfqUVHQWyF5js3clmQ+Ty46y3S/QIS3BY/BdU
 6+E9D7x6kpOACBF0h2F6YgJPfYY9EGM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010065
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 1/7/26 08:11, Markus Armbruster wrote:
> Section tags are case sensitive and end with a colon.  Screwing up
> either gets them interpreted as ordinary paragraph.  Fix a few.
> 
> Fixes: 4e88e7e340 (qapi/qom: Define cache enumeration and properties for machine, 2024-11-01)
> Fixes: 8eb6d39e22 (qom: qom-list-get, 2025-07-11)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/machine-common.json | 2 +-
>   qapi/qom.json            | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

