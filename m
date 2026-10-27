Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1AF606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NudZLS6B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B1UCI28f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXr7-0001Gl-Ny; Mon, 26 Oct 2026 23:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLXqz-0001E6-HN
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:28:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLXqx-0008Er-4E
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:28:01 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2G1Gt4156126
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HfauI7IDRHbRZ4xDWKKzDooNPXhq6NTKM72+HCBV3e8=; b=NudZLS6BDe6eqoER
 wWeTlzvWLNprCLt6RB+YzoTjvCtFHN+qf8g0VricpAy1aps04tZlIsLbuLI8ExJr
 o41GKCBJgPciyQu5eeCphVKfRlVHfXC1938ZWsRknWLo738gfVCPEFyWF3Yd4j6b
 P71j9W+t7DddpV187dAUf/IbHIF7ZONWH/1SGL6IzZP1Yg4gNZO5ov3x5HAzCakq
 AGC++ZBEvAko6x3kr/VvZDTM/3foFPokaLgVwthUrhiu0Pq3dT8lzasuARVRg5/C
 C/Xx7cFiVbMtqfDaf5D2/OQyECSkj66UgspWQ6fowcBF5ip6abruCVZc+THdmXw3
 sa2PKQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u63s58-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:27:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93909014c85so763131085a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071676; x=1793676476; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HfauI7IDRHbRZ4xDWKKzDooNPXhq6NTKM72+HCBV3e8=;
 b=B1UCI28faY0GaVVUIaEUvmIKzUujOwUFYvyznAI1dmeHCcatmUIbU4/8/uBUmWXe9J
 K65nHvH7+hjRAfqFb6nE0r7nlzy6a38DY/9EvThUo8Utgk2HNYv2TIkHEllWSL2z7YqV
 4xp6wTTOkd+WsuQQvHqi5nwHYFEuYVejjnJW5MsTVuI92DssIL+XdZNZQEOjl2pXWzxq
 HPffQieuFoC7lqhqlOoKdIP4TGz3gvTIwg+8e/Q/GDQ53YpoQS8nINRJa1N1HcsWot9Z
 ghDwMeDjFnDewBXnMJ6dtdR9jZHThvBUpFX+FltZy+uPuBfFVmArU953D11IOE4a0KGD
 Ltzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071676; x=1793676476;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HfauI7IDRHbRZ4xDWKKzDooNPXhq6NTKM72+HCBV3e8=;
 b=dUXRxkkm6/eVjw50SIREVxo2F+9xVqd4Ho26eic3Il+8HUimZ6GOoY3GDkGnpSGmnm
 dILzkuB3vuIALLHiIoDSYq1vO4IALgt/epCCmYAD09CCKMYWnIzLP2uB5nVBm9Kua0Tt
 P97VfNcH0VEafmLQ+JUqgFFJ7DwEHYNNiga+U3fegN0sfhdurViERpYzxNX7PZhiC1Ts
 /exQv0Yxbk2KO8z0oBfQn+cCalalWVTZUbjm449TTP43LDDD2xt51F0OmU7xKOYXfX4O
 wHc+G7ENUULYcHGYgiMcsnjauCabJmkBHG9aTqLhwMVeDFZL3XbIp6xLUOga72iaxgZt
 sfWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwn+vggaMMkutcm7AHJGpRTnZ92Rb8hEn//sfosgnDYViGRPPt/oa4FK79pBQra8ljXzaQkpsf/LqQx@nongnu.org
X-Gm-Message-State: AFq9FYIWvA3z0XlTSpdGarSCKE0l3n4CKN0PFUzPhSiuK7cTF74jxI5N
 oitI59l8zp4ypwGcPYaFnQ6xV0a9ezLbn6SWJoWUT7GS8zcDcUWN9oSsNYx5M8c2LY/qNRlKSbP
 TFiYIMGWiQykcRnpuy+hAi6kqZsV+FQw1jQucMO8HpI0Z5AuxC3s2dzzwBw==
X-Gm-Gg: AYBFou0xmEONdKCnY2tHinRnz6+hqhbtromTaZYHf5IiiM32VwBAksoSQJ5YaxsIwQU
 MygjsQ68baUwK1nJfUjpXZAayaKPbfetDeM/TRVWqaAp3eAk2bM5kVGV4ZnDvOLWEin8i4O7y3M
 ALyVp83rGdStYEA1NFSLqRqc6PASLnBmcm8x2+ZGSsM9vaIEF1XaGe4dhGPWaMp5m3zPPloME4m
 t0xMB2MtjRBWIRffvtZ4860H8MIRhvqN1l4YyhVtyQ441b576D3IM6uoeoH3rG+eNIOI79WXKat
 /ew8eRTm3J/ZpjXeqg9og1W9aJ2UKc5BcptFMrkUXVFcl0lyr8ST3disMZjhFkcGZxjwyg0pqyT
 BIq/SvJ2g88CaGSeCW4+Urxy/CBUSy0eixA==
X-Received: by 2002:a05:620a:6286:b0:93e:6f65:de63 with SMTP id
 af79cd13be357-940ef8f8310mr1414931085a.47.1793071676280; 
 Mon, 26 Oct 2026 20:27:56 -0700 (PDT)
X-Received: by 2002:a05:620a:6286:b0:93e:6f65:de63 with SMTP id
 af79cd13be357-940ef8f8310mr1414928985a.47.1793071675833; 
 Mon, 26 Oct 2026 20:27:55 -0700 (PDT)
Received: from [192.168.69.230] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3c5bsm20654109f8f.9.2026.10.26.20.27.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 20:27:54 -0700 (PDT)
Message-ID: <29193611-9483-4353-8c17-b295a896e34f@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 04:27:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/14] hw/ssi/aspeed_smc: Fix AST2700 DMA flash address
 mask
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
 <20261015055642.106204-3-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261015055642.106204-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: B5MqR3XKhpGSloWC1x6jd_T1foWiwPxv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX/xfCkz15+tk6
 8/ZHFMYeDqj3S2eLDeecNOxxGeOG9OQMdb9wi+an01vFMwKOmOmrYYjZvld5cgvxhmbaqOSihqs
 nXgse7Vjg60ph0j89ap/ereF4J8VkjrGPHHncg0pJGAAHEl4cow2sZT+27bIQNNqA/qUOm8StVP
 ceTWLkR2Hhcommye/ce/IeBnYpAPWCOIGGliNiZDWnPpq0JwJ9vO9KRrr4Ft80kZMmsh9y7TmiN
 3V3/6iwvoay2ihL0m9nYkCW5P9qc85O7ZxqAqH8cAFyiAN9i4QKnl6kUSdzNQKDF4o47K75zipc
 hZArdEWO/jy52zTITs9Ot+HmULswrzJcRrq4WqPXvNLOwLfx25XMtlvGz7Xm5c3WgqTdaqxPJfs
 O3jRuxsXgyQAbQttl7ScbX6ekx6ASDIo6W0dj0bvFDw+XtB+/STZ/aTX5ldBYfTrpphRmnCobCY
 gwkq7qdqgRHZy3xle5Q==
X-Proofpoint-ORIG-GUID: B5MqR3XKhpGSloWC1x6jd_T1foWiwPxv
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6ae01a3d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=9vyheZCN1ONZMrlOZ-EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX1yB4jvhgboIA
 sJyBHYu64FlzVir5gjFeq88IAlJtVcxKv9T2jcvad2UwvjFqJe2JRQu78IsO26gqYSDid2RRhUZ
 0ef29Qq6waoI+UZ6UWKbfDy0DPVCQ7I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270013
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

On 15/10/26 07:56, Jamin Lin wrote:
> The DMA flash address register (SPI084) holds the offset of the
> flash access within the controller's flash window. The AST2700 FMC,
> SPI0 and SPI1 controllers use a dma_flash_mask of 0x2FFFFFFC, which
> clears bit 28, and SPI2 uses 0x0FFFFFFC, which limits DMA to the
> first 256MB of the window.
> 
> With the default segment layout, FMC CS2 is mapped at offset
> 0x10000000. A DMA read from that offset is masked to 0x0 and returns
> data from CS0 instead of CS2.
> 
> The Linux driver programs SPI084 with the window offset masked by
> 0x7fffffff, so bit 28 is a valid address bit.
> 
> Set dma_flash_mask to 0x3FFFFFFC for all AST2700 controllers to cover
> the full 1GB flash window.
> 
> Fixes: bdb3748dba30 ("aspeed/smc: Add AST2700 support")
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/ssi/aspeed_smc.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

