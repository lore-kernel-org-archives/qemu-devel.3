Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950CDC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 19:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiH16-0001uY-0T; Fri, 10 Jul 2026 15:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiH10-0001u8-De
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 15:36:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiH0x-0007Xn-Cx
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 15:36:01 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AH4HuQ1234471
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 19:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LoL2wmjCoqFOnuV3v1eT2IqUjXLnBmWTbQtFAyiOrSM=; b=Mwyp/wJRN5hxneH7
 0SWxV2uTSKeeKHy7BwNk6vSdmP1+7u/XW0nMQDtS0WVyyOX/zmaOLujflHOaF1bJ
 hp/WWJKcyIBfd3eC59vrXNO76MMfN3evOIYvxraU2HIB7o3AyZMsWV0hcdxLDzFS
 eA5NyYaUvOPrCrfPEQWk9APwAa9tpPyHhVX7litr0GUWK8nm8wvtx6nlezG2KlIC
 9Z+37WpgRcYesM4u1Xzx1C3ciJYvgBL+DAiSrpI4g8Normy7L6DOfSCqKmjtGBSx
 8z4z40JLE+734yCEEjwZIdlyAQCiL+upUXor4qQUjfXS/rUBLSKi+DnJ13uYxjS/
 DKmObA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb4rm8hh5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 19:35:57 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38dbe39ce62so424907a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783712157; x=1784316957; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LoL2wmjCoqFOnuV3v1eT2IqUjXLnBmWTbQtFAyiOrSM=;
 b=IJVjRip7yPpRaOxcT9UI+mL4+MHrNvK7GQL6OsLnb3W5EXleRQywn6QJFxTYjo5pXe
 tjq2o7kbGPDG0GqX0gUm7ee6aNCp3xdSCOaQrMUJVibZUWH54gYJVqpMDt2mQD9ok9Ag
 2p84YC+qP9rmFx1brcQsV9v56iGPrSxIaaHxkeykKGyExXzeghUd4IBgDjFNHLyYZd2i
 qiZz/YSYxQloQdA1r3xUYOhc+GX8aBGiMaD+QChUTBC91RJsErI7cjsdoCaL1uL8zcK5
 upnoqJ5Ut5b/3DfQ0STmEH7vSwkiYs7LmdXtsJEm/CZ9C+8iLUNY7wnrDPFzp4U+An2s
 dyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783712157; x=1784316957;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LoL2wmjCoqFOnuV3v1eT2IqUjXLnBmWTbQtFAyiOrSM=;
 b=IiBEHX9sV13v6WdrN5xuE9Chlmm8RUIisBghWYUUa9ZMvgEVuk8HiDPwGrJD4metSZ
 Z+AtjbZ28dxBJZO61MKn+EAqHr/3CSU2+Wn84bEip9TWx3D5z3ZbNhyyV0R6FwFcanKG
 TsWKolWqsQ6FT77Gj4GpY9xDDD+qsA5FIF/nS2SK1pML2KKuDi72DGxXbl9Nugjy5PoA
 mhag+30eRgB4zZvxLlVeubUoIgwInm0LmQKEa6RPvSoUkKewtSiq2vrS4tRSzg3tsciH
 p4Dx4zqJ/5CQNgdXXVIjwrTT/fYhif/eKwN9lQaHwMMcxEMBdBRIUPLTBANKP6whVSfP
 wJvg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqqTxnhMg/fjqB0tKqe1CjYa1xmHynzbXVMvykf9Pn/CwftO9MMnSZ4yW1rpXiBSuicL8xlLM1EzKru@nongnu.org
X-Gm-Message-State: AOJu0Yyt83iq56Y61sbR7mDS6SDQYpBhuy7nHPemjKYeIZ9+Glj3u2q1
 kDsYm9JBn+fpBGTZJ9FfogUGsRlHx9tSjS9HlwKelI0OcXkhoWK4I7XA/n85Y5ycziOu4+qauZ5
 X+h8afpyftBlrY/LjooU2v7w4okZnVxkScWxyhJk3t4wSSjfn28lBpAHXlQ==
X-Gm-Gg: AfdE7cmCaDdnpfqwuIflg0d4cQDTHUJY+P8FnnWm14+jtw6yfZ4UskaOkKDAvKFBIp7
 mxsMYoBxMB0yyCU9TXaGPek970snqf7xWifJZUvfwl2YYizKv+QEefkM98MFM0FCjqdl1AhPSId
 IT4iqMSIo3oCVKgsVI2epY8y7q6VotZtKFT1U3Az/u8IUDSgY0+5JBwm8UubSJH3atDSGB4gFwp
 OXx+a3ZTPf70dmqKA1b0uN+9LC+KNFxifxtPYA2wCBVyGFAwE/FPOP3OT2AacSyIigW8z07TDpV
 21xaPCuyIhUp835atraQVbOobkF/MeFlBDrsNxBPUcQG0KIe0xHmGtdx/OQnYpUFZKoQ8U/YPDZ
 swCVacNIaFIL/uIdaHB+C8otEUnDlhkKdSQh3KD8FUlgstDBARYBs7Deqdxw7mq/oLP0ICklEnU
 vbFfA=
X-Received: by 2002:a17:90b:3807:b0:36d:b12b:f57d with SMTP id
 98e67ed59e1d1-38d15364aefmr5259710a91.12.1783712157081; 
 Fri, 10 Jul 2026 12:35:57 -0700 (PDT)
X-Received: by 2002:a17:90b:3807:b0:36d:b12b:f57d with SMTP id
 98e67ed59e1d1-38d15364aefmr5259690a91.12.1783712156625; 
 Fri, 10 Jul 2026 12:35:56 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3119c2a7bb5sm21377827eec.25.2026.07.10.12.35.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 12:35:56 -0700 (PDT)
Message-ID: <35b13e9c-1a0c-460b-bc1d-ae7dc9a83025@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 12:35:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/hexagon: initialize deferred sreg-write temps
 to current value
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20260709230645.3033240-1-brian.cain@oss.qualcomm.com>
 <20260709230645.3033240-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260709230645.3033240-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xbNil3jLZz38lfE6kMz-goesYd1jJH2o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE5NiBTYWx0ZWRfX7Wd2iq3pW8ft
 De2ybbpwPl1ciKfN9/yqvs766/4dsFWG2+ouh7BLn167N/4LVTD9qc86SNDvE0qmG811rDb1nvi
 vSn+82MVuLXXMtEEqDKnwYVmoOdLtLU7M/+n464itWZx0GYiHa7YzsS34Zx0WxuF1y+d966+DPx
 SQInOlXMamMF7AyNsaNP2F5G4w22Y+G2iNsWwmQ6o/IxdespusomMsPnVqRzHeg14WE0gPxA1oI
 pKJEm4rcLsGJryEcdTNvlAsDNLNkZcR6htqNcR8pKa7QM0/jAwYHSTECSW0bDokdvl+Y0+kUJ2j
 moBV040/pBHOdajrGcBhtbX5vpZfXa9HGGhUIrL0jwwZvT/NnGuWn+Ot03+lm+GgMvBLJ0s8IdV
 aUAvkuyQmKBLUhrvv25wyvxQmvdbQ9OqJM5p7sy6KuVpQvCJIkIcuML/8y5qEoKq1a+n8aFG5lf
 nQXy8qKmJ8a1LRXa/8g==
X-Authority-Analysis: v=2.4 cv=JIYLdcKb c=1 sm=1 tr=0 ts=6a51499d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=CRQKjEEzemIFEkHPrE0A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: xbNil3jLZz38lfE6kMz-goesYd1jJH2o
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE5NiBTYWx0ZWRfX9LCRHPjV9j2S
 iTxdRPpD+Cm/o5046LLTPRhnvknghTy5XfkUX+tzkp/OIsX+fhjAdiOn9rO1oUac2XrBrjI4yzb
 Jlw6UZ5UZyvHSqO/qX604mUu7X04FCo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100196
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

On 7/9/2026 4:06 PM, Brian Cain wrote:
> Unconditionally allocate and initialize the temp to the sreg's current
> value for every logged sreg write, rather than only allocating
> when need_commit is set or the register is SSR.
> 
> Without this, reading a deferred sreg write within the same packet
> before it is committed can observe an uninitialized temp instead
> of the register's pre-packet value.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/translate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

