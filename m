Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4442CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBowl-0003x3-RL; Wed, 30 Sep 2026 03:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBowh-0003b0-IT
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:41:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBowg-0004Nb-0U
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:41:43 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U7dP8Z2213494
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vt2nGbim/dxalLzeYStevZ+hPIUHTg2POhDwLA4wDro=; b=DiXq4+0+GW2OoOhO
 6219YjXKGl1H5/sxNzvIvmymmbvbniE4Q6LdlX0lU/bl9YXA2J4vlAyr0cpWcMKv
 RgzzTXTEYT6LpIChrBRo6driiBiGmsWpjCZlqASYtatJ2HN3+527f08zfIn4X+Fh
 wFDgoFV8wTHNt7M7GFxo/UBq2Ea1sscLeLIvzSSTh9loCwzOj8Chb0CrxAAJP9CE
 rxu/zNzPwXfyOrAD09Ai+6lhV/QKKg16wGuOghFFWtTpg8oZ145CiWo1llAsuIuV
 SIj3YqaJTqQZG1m2Rv1Mhty/pFf2f/N5jhUZ1kQsXMnyHLj7wg9qAkIE0UudutvQ
 6TCS2Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0smjh8fr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:41:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ca9b53afaso47569985a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790754100; x=1791358900; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vt2nGbim/dxalLzeYStevZ+hPIUHTg2POhDwLA4wDro=;
 b=adiHLgXkGMME+bA2yGzyaUCm09NZTYUGhp/bjgS6T0NLCDK3ewEw47QnRj/lkMEB36
 53E5p7znVydHQSv2B1rBGK4VM4JVcKsTpmDNfXyUGUzNnk3VuwQ7D82qn+r0xiG64fl0
 Zh+EFhsSOEfEpO81KOoR7b+aRE4ZWy18c7SEj5654faet1aWlNJT/gJozCZBZTnPMOSv
 0DWNS/H7+PuXrgbjkKf1h1g2iWbVD7C547K6vkKyoC+/yfqGHQPuU0d9dIJQuXpWSIPo
 l/2Dt+6T/nwzAfvPdEQcsZTETzfK5iP5fa5zIjIOfsZ4kj67BdnZYEI86Ie/8JWQiNG2
 MEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790754100; x=1791358900;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vt2nGbim/dxalLzeYStevZ+hPIUHTg2POhDwLA4wDro=;
 b=DZq7XFyRJEez2Dal+1nvX4oW3vTYdvZMM8j1iiOFQ8MObuIOH9QzB9kRPfBVdZiEUE
 bp8V5/Zy298EhLvNAifNIr+dCL8iphk6bDRAqzIHsG6qqlsgIEJWCxqtEseNrD1m5sFA
 xJdNcZp/7O3CS/JtInx2+SqLO0WoZk689ykSfnWK4C67WOvrU6wQEjFh6+2COV4xuEmu
 PeCYHgl4IYFUz8f96oezChCIToJ3sbtmC7zRrUppif0MUFr/OMx7uHbiXQCeGGZkaRU7
 pfSNyQCdsdxnDDy7JDiyNm7cNyCCXoZB1Rs5z79x1SVskia5V9cfz27dBqlwjK2jcYAL
 8rQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvL9nK650y/Fiu5LKolanTyEpKxvG/DnZA3Y/4leEDlmWXYqaohfX2OW0f+DeWDxx6mUHhRVgSREKk@nongnu.org
X-Gm-Message-State: AFuF++nzPBGNF1IWkBUf0zT9ovRdXOeVJbGAoME+G5wsNMPw7YmRAgIG
 HM1SeeivtvW798xbWuj3SjCJUdkNYPBKemEWz5+zBkrxW1+xu8Gr9ArAjT85RVAanv/vIriR1zt
 DNYt5dL2qMRcVHNe/xNyP1GPeD7K6Vunb2Nb811+/jdC4yKxI/XRVGcV6Qw==
X-Gm-Gg: AYBFou2C+SBGhpxxVxbeUBF9UtKuwt1miYjhlnqBaN56FNzwDOae3hqK5v/pyD8X1iR
 xKdOO4sqhDjYLyaXQXfobTFKZC8THQBzeYp6RdcBN8TipuADdqP8x7tlnwu1EhpxQRf3d06GY/P
 12aTQYKu/wVLqzY3PE65z4xGCGDi/qygN21DCcoUfvPbrcMEwQAu1OGJ+Z+LviXlg/2yF0U70nt
 q5purJoZY4RXmCl2In2XgIJAXjse27VCBDYRRjIiQMFM6jOLtGpYaHT1ek6WmxkwixrOL7rWPHw
 EZkefoAXEgztgqcI897jFwcJOloA11+CF4KJM8v2j6aL6KKCZ84cP8NAXwGf2rC6KbHwMxJKkcr
 lW0i8pZNP8ohTA37XPhE=
X-Received: by 2002:a05:620a:4110:b0:93c:6c6e:1776 with SMTP id
 af79cd13be357-93ca96be79cmr77701885a.11.1790754099746; 
 Wed, 30 Sep 2026 00:41:39 -0700 (PDT)
X-Received: by 2002:a05:620a:4110:b0:93c:6c6e:1776 with SMTP id
 af79cd13be357-93ca96be79cmr77699285a.11.1790754099278; 
 Wed, 30 Sep 2026 00:41:39 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a017b7337bsm18923815e9.3.2026.09.30.00.41.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 00:41:38 -0700 (PDT)
Message-ID: <65279741-ffee-40d5-a669-2e7e7f5757c1@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 09:41:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/11] hw/arm/aspeed_ast27x0: Use unimp array and table
 for unimplemented devices for SSP/TSP
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
 <20260930072501.2612119-8-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260930072501.2612119-8-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzMCBTYWx0ZWRfX86a5FxWaLLab
 FJrYjm7IQvU3pzqj3JiLhsbtwE2fUtajto9PCSpRECa5X0yLqdBvetUgEEyx1O/r9LO/DAIobxO
 Kvv+5owkD7tO3+ZwWSiFSLs30/XThTc=
X-Proofpoint-GUID: K3ILDtsKPPlEIFi3XYw7jAwtGVq_uc9n
X-Proofpoint-ORIG-GUID: K3ILDtsKPPlEIFi3XYw7jAwtGVq_uc9n
X-Authority-Analysis: v=2.4 cv=KfxHIgYD c=1 sm=1 tr=0 ts=6abcbd34 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7g8aA7A78AY7OC82r+w+4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzMCBTYWx0ZWRfX1jJpyitmjTIX
 D5Hav+G7iEHBrw/oXq7h41tJhNMrUYBksp2fSVhpvsk2ZHNVaaWnw9LdQ33CYKG1oFEU2zUvTNY
 xwXVFZHi2C4wSm6R1cB+TmDZjr/kCdqr7nwPqfpu6SSUno1gJKUFiLwUv8ZE70+hv/pUupBzIsL
 YtlXV0VlFBRZ8tKxCbbV7kUtFrYaqWqPD9BWYKgud+rTwzXdR/ZJbLFDDlodfiX53qMMdnO5tQD
 b+PIAk/7YLSFb3RQrs/pp69TXO7I1lY2ZNcqU7M17f3hSnHLlWrMd7ZMz+g5UDKUamqaJL1YQ+I
 eK3ToquWxLPD74hEsF7KQztXnFTZa6Qm+mkKkegafxPTd6uNrcDO+rVC9UoR9RG2HuxGKmIIrGR
 REl6LbSyrEliyKSbWmAwuaMBzwPu8ByGoWEVC5eN0oXG9RY20dJW5l52lVbpdNSQE46dIyrhUPP
 sIFdunhS71fPK9XbZLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300030
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-09-30 9:25, Jamin Lin wrote:
> Before this change, each unimplemented device needed its own field in
> the coprocessor state. This made the code hard to maintain.
> 
> Add an "unimp" array in AspeedCoprocessorState for all unimplemented
> devices, and use the AspeedUnimpDevice table to describe them. This
> makes the code easier to maintain and read. Convert AST2700 SSP and
> TSP to use them.
> 
> This also fixes a type mismatch. SSP and TSP used the "timerctrl"
> field (AspeedTimerCtrlState) to create an unimplemented device. They
> now use the "unimp" array instead.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_coprocessor.h |  1 +
>   hw/arm/aspeed_ast27x0-ssp.c         | 56 ++++++++++++++---------------
>   hw/arm/aspeed_ast27x0-tsp.c         | 56 ++++++++++++++---------------
>   3 files changed, 53 insertions(+), 60 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

