Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35E2C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 22:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxBD7-0007Ru-D1; Thu, 20 Aug 2026 18:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxBD5-0007RW-Bd
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 18:26:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxBD3-0003OG-Qz
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 18:26:07 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK7d39250389
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 22:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SHNxzLlb0bFi4mN7H5Km8ntRe6oiuSklItj9hrI5UyE=; b=ABuRNdCPhNRJT4Ii
 0ip7gjRzJt19zy5JZWKtpXafzfWT1KJPh8N6lSWVAaR3aSU+uAGUvkcRXKNSbgTL
 y0QckDgFRQP39i3kdYOmK/8q22OqNBMj8XXm8AdWe4ZVdWQ3H8GcksWiwbVKYTdL
 5SyRlffXz851nZkD6RHILEkifiP9ajlrf+hjS4GyMuBQVbgiwGDp8iMnUZVu03DG
 wPSg6nLyPm1JINaywxWwjfupwTa94Z+o7h9fk1HV1+4T5SFllj+i4WM/KlrtCX79
 GbU77UzmnOMdeAOMaAOFO5WHAqshIJHv7yjuDZbSZwvtb1oPpL+JaGXIWv0pFxpP
 jAtGjA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5w49bup8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 22:26:03 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbee5bab340so466716a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 15:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787264763; x=1787869563; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SHNxzLlb0bFi4mN7H5Km8ntRe6oiuSklItj9hrI5UyE=;
 b=irAzjgLtD+Y67P1OS3yfOG0WMYQ/mP47l9VQWeVt8JGemT5xCZRwy3kFT+dmB5FCsO
 ZqMIFOlXI2Cj6ayAyfuf0EhHtgZL0XfLNMux/R3i3oqlQxBKFYoi89yJxn+4zONtig6K
 65fH6vbh92HgnOO45dSGCN4FgKKFA4VVo5XkAKM7aPVQRv8zlMZ5x0GEeTliDA1qypMf
 tAJInC2uta9tjk3JMqanfE/GlaQ+l4nFXZP9tdzpUyAlYgZzUEybY//ZTXChZqBBb4CZ
 IxPC84kV2XcMvrZeeO+sp0EVVGGYnz/4zlR36GhA0ElY6N4Rr2lSpagu3vR+uIdLxJQw
 Tg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787264763; x=1787869563;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SHNxzLlb0bFi4mN7H5Km8ntRe6oiuSklItj9hrI5UyE=;
 b=fy4TlGHqjIxxHHpSPzxaEWcYa7eA/6xIq667myvFpNp7O5x/Y13Eoek4XP8Q6IL6w/
 OfGLOrxrVW+x3o0jwxVOA7xww+fiKu5jGv1m6L7ykZuE+GKkIwuM9mWNgeS9MCZCRlwA
 nj6mR9prHKK6dUaJmTA5SsYEKYLvhXfvJSYK3urYRwy2FJryBxg1EClU1G5MB7sBH9XX
 8tlNub4MNoshbimbz3rnDdCdTjz02PE0z52aG2D0h0FDDYF6dKUWvw5LLgOvHudkOn0y
 obAhowya9pKhV5Zs5Nw63dtmnc9adW1ctjZBPUwtDwJI+1/f+73sVJKXJzct1YMfddb9
 huGw==
X-Gm-Message-State: AOJu0Yx/U4SbvUzeJ4KcPvuI+Qr/AtOCX+uzxFoYyvI7/HMt1fRI8qAl
 KZw1CwhXTyJRpi3QiU8LOxhQb1lNTHSHZf8n2l1gxsKNlCvceDxpHeoS5VMWN3/1rvHZQ+pMU0M
 1I4bKTjoCTGSnbidtYeOxCjFMuQSEAN71X9oW3jwhTTgPA0SApHdi/Ljv4g==
X-Gm-Gg: AR+sD103CpfrJ+2HU6TRF8x6yqTZ0StNhUSzDAdfsy9HK5+pVGKXdh0J034ujv0zS9z
 gWL6UinE1Z2sHh+fe//tYe3njiNy+7Ooa8VApmnbN0LPdYvku75hG6Tb95qKMaEdpoWFwbzK/IB
 +dvJkTTd26TF3RXcJQQz6B01DHPTXTYBPeqiENlYfcyfeAIwyHh0wzUTG3J11/S+mA/vjT4Cqu9
 Ooz1sbw71FPpBgw2iqxtTmJ0dQRoPt5sgRbTdJE/0oEBHJwHGjtnH2qUR8KiD5yb3F7dE6q7ovh
 vUlXDBACdSSkemrLLzkpFn0s2Jc19bF1FTrFgO+CTVhNrzjwzrBT5iU6rd0QbfCjjhu9qdKEiz7
 eBck+7GMUDrTx8eOoXmSmVKycQVrG8iBSc9HTPRQ91ZXl5h5uRpeiTR2cE0LD1mV4x6dQ
X-Received: by 2002:a05:6a21:1788:b0:3c3:9993:d5c3 with SMTP id
 adf61e73a8af0-3cd3008be95mr3361294637.9.1787264763475; 
 Thu, 20 Aug 2026 15:26:03 -0700 (PDT)
X-Received: by 2002:a05:6a21:1788:b0:3c3:9993:d5c3 with SMTP id
 adf61e73a8af0-3cd3008be95mr3361227637.9.1787264763036; 
 Thu, 20 Aug 2026 15:26:03 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ae1416dsm26679783c88.11.2026.08.20.15.26.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 15:26:02 -0700 (PDT)
Message-ID: <11084bd6-361a-4696-bcba-572aa3020107@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 15:26:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 11/28] hw/arm/smmu-common: Implement secure state
 handling in ptw
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162512.2807281-1-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260813162512.2807281-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2NiBTYWx0ZWRfX2YfUuJSFcDeE
 qcnk4cvWvfP+ZcgIfPdAvIgiQiuRoT0mLhjQNpD4Se17G4Hz4uKxOFpD0kIvhtqJU/WRZhN+Kfp
 lu6gWS/whB2Yct2iNnQZ+gJRLDfWw8A=
X-Authority-Analysis: v=2.4 cv=YP+vDxGx c=1 sm=1 tr=0 ts=6a877efc cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=fgrLqfBXAAAA:8 a=EUspDBNiAAAA:8 a=_zrsuuM1xf9QxEgsPNkA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-ORIG-GUID: -63dNT-C0-9LpT-uArQsRjoQp9t-WnIt
X-Proofpoint-GUID: -63dNT-C0-9LpT-uArQsRjoQp9t-WnIt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2NiBTYWx0ZWRfX2SKbQ+PtBw8B
 q+koGbezUq62iTvVHfImD7ve1njAnOFiUCM+VUj4a8E4rCPLIGDFKdljHltnTdwj4xWdVFI7bYb
 3d4aPhYe6r+OC9dnTIB9NpKw8lGB/NK85/C5FTU+BtMipqYALrLwCi2NkRNmXJiP/Ww6TOJRLOh
 fjyjefv9t80abTebrdjIbgqwvRyLJwgc9YZEoLWu2OiS7xzIBd9zl8iOPAzM96GnkiXLUF7vcVC
 T9/8WDdq3b4a1b+UhJ+Rl6skOCvS890/SMg9ZSAoNKn310san3JPe3JKSQKvBFBhlV+4sxFBal2
 3259fHQZNryaRG7L08v2puMHnAr+la6SHuY1h06R8d/kr7XOu4eDg5Nizgueq1VaIAaVFy3dRJB
 Tpa9wnpI+3qIvEf4o2BaBJG7amyVlub4Bcd8ydq3mtQXJzYdeIzCYhqev0IJZT9oNNvqT9vaYjo
 SZcbnXWCINy9ywNHZKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200166
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/13/2026 9:25 AM, Tao Tang wrote:
> Enhance the page table walker to correctly handle secure and non-secure
> memory accesses. This change introduces logic to select the appropriate
> address space and enforce architectural security policies during walks.
> 
> The page table walker now correctly processes Secure Stage 1
> translations. Key changes include:
> 
> - The get_pte() function now uses the effective security state to fetch
> page-table entries from either the Secure or Non-secure address space,
> with explicit transaction attributes matching that address space.
> 
> - The stage 1 walker tracks the security state, respecting the NSCFG
> and NSTable attributes. It correctly handles the hierarchical security
> model: if a table descriptor in a secure walk has NSTable=1, all
> subsequent lookups for that walk are forced into the Non-secure space.
> This is a one-way transition, as specified by the architecture.
> 
> - The final TLB entry is tagged with the correct output address space,
> ensuring proper memory isolation.
> 
> Note: We do not yet support secure stage 2 translations. This patch
> only implements Secure stage 1 page-table walks. Baseline propagation
> of the incoming NS attribute for stage 1 bypass is handled separately
> in this series with ATTR_PERMS_OVR == 0. Full ATTR_PERMS_OVR support
> is left for a separate series.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmu-common.c         | 73 +++++++++++++++++++++++++++++-------
>  hw/arm/smmuv3.c              | 19 ++++++----
>  include/hw/arm/smmu-common.h |  7 ++--
>  3 files changed, 74 insertions(+), 25 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

