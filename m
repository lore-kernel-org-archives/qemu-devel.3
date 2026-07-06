Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E841BC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgg2Q-0005VI-Cg; Mon, 06 Jul 2026 05:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgg2I-0005UX-9P
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:54:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgg2G-00072w-2V
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:54:46 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66693xua107755
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 09:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FItJHwZ8IcH0nmshCcvaLDrdFzmOxSnTwNdZjMgYL+o=; b=WlVYoBcnstWFi8+z
 nc4QYub/roAFS8Kbumotp4MG6YsL15FPDTu3SkPwBaCJ9rRB7kaej+hoUIxkhLX/
 9J5lP0MckfB91nk2JzW1XL5BmoLPhP9DYBjRl782W+U4q5Eq41LfbI6XC5AOXLYn
 k++tznNsBIXpfEX3hhAE+nIK2SMdp1pNJmpF17D8x+brjI1PiB4BA57X6MwBKI9T
 8YCWpKpwf9CQMWkjbt/yKtiFGyDCeIWyqEbo8hw+vhqos4qW75o5BSE+Ljj5i5YR
 jueM7ri4Z/nq6nYfz26SkX8TptwWlVEXlCgxFXg8h7vmNLpAn6syAfGM8G92d08H
 Kthifw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f891ur9fc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 09:54:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e82060977so293068585a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 02:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783331675; x=1783936475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FItJHwZ8IcH0nmshCcvaLDrdFzmOxSnTwNdZjMgYL+o=;
 b=XYx2wLyyT6Kpl4U1NgT3aOLUZiM2RT2OkhtaHy8E+fi3j3HK+iQ10CkZqmXVHryNPm
 FWnqqSKTAYlWNXxZMk70r4LOlXat2WnqqI/OxdMQ9ARhthwSpc7N4SaQDZRGZTXMbJ1S
 nke244vP8rDX4feVhfcwvgakfPgvt34+ISa4BrxL8JVQTR7pOPLNOB6XCE8O2nGliofo
 7l+6qITqIoqNJ7qr18eVFoWbupvQ8Yzf+Z8UAfnFcbW0x82y2NrsVUXFMke5E8u/ZJYP
 2qDQwfjQG4DVz26Fb1SCgDcT6VzWKBEo9eVP3SJBMOFeWWlq5QNgw9tAJg2SvjSzv++p
 ocVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783331675; x=1783936475;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FItJHwZ8IcH0nmshCcvaLDrdFzmOxSnTwNdZjMgYL+o=;
 b=lvOsA0s+nJU3fXagmHPDY/MKc6/fvm/Jrw8+xQI3zt89FC71no7VSakRfxh9QhEbCj
 aOqEOw0D6YGKWoiFmuyuScTbKxOJxoiE8ilB+jbPkIDIWAHDkb47U8TtWtfqA+Y5+4Hi
 nu53ArXtJzW+iV8jiJp7WgWZpK7KxtFqEZywxmNtMKqej4vbt4Ky9uNPRMKEbMPV8Qz/
 Re5cX0kRKLrxbkA64FGXwsA+cctTBPBJO5OYrShwbn3xcTI4qFppHrQg8+JxIhuJRH1u
 WN4+6SXU3u2NxfDlGxsYHyh05IvP42Mx/dZiDXTpo6Cyenejk5BLqmpoXW8x+xYeEF/m
 JO5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYOHv2p1KfaumgWEZaikCzSS8tcCBfT0fW5TcfT6cZkXOeE3PL9Q0joAp7yVXiMC7r8J3znsb/E7EX@nongnu.org
X-Gm-Message-State: AOJu0YxiH9QbmNlGpsR4XmNX1AoUcp2JLXsL3FMf39zMym5dUKOJcO8i
 wDlEIPGdYYVvX+q8smpjRF1n4JHfkkuuRxhEb2P/pOjqSjaRfUeh8PC0SNuqoQwPfNY+2ZwsTH/
 NgZy5qVOtN+gwvFUzOzrRSph9nP1unK9DVCyJgAIbNKirn1PJIK+s7ai4rA==
X-Gm-Gg: AfdE7ck7d+O4rt5kVfGjol5GmacLF+eM0kKd3zuMUn8Mobn6lbIvCjo9ito8T/FMrMe
 Gf9JI1ckLapjkvCLk0tti33J91mno+5PD51YUe8NOXw/+E8DeYz335qY/M4mjAX6b9qRS0kjuDR
 McV0fGjWrL2+ydR1lcE5fubKnvSOgo0oSxOqT8M9beALjuvpaJD6juHNK5JwlWuo4wYPmzTT7b5
 vjAAU12A+d4m5xPnRP2BPRt5y5eDtdN2DNmYi9vAMe0KPMujrhHfgEkdGwmP8KrDdEOy2uC+XTx
 /whljExUesmVLqRu5hWOo2c+7mxS0RnuuCpcOybA+nzdRtguyWxnmOh6AEBkslcdAasYJw9jhcZ
 QfSaSW7k/iP1VCeAq4i8SBZY7wY8UKOcWen+NLGlRk99M+3cWqFt2nxG8MFam1Q==
X-Received: by 2002:a05:620a:8804:b0:918:7e9e:de74 with SMTP id
 af79cd13be357-92e8b4ba8ddmr1035943785a.17.1783331674784; 
 Mon, 06 Jul 2026 02:54:34 -0700 (PDT)
X-Received: by 2002:a05:620a:8804:b0:918:7e9e:de74 with SMTP id
 af79cd13be357-92e8b4ba8ddmr1035941485a.17.1783331674333; 
 Mon, 06 Jul 2026 02:54:34 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19d79906sm3904779a12.14.2026.07.06.02.54.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 02:54:33 -0700 (PDT)
Message-ID: <2412f8a1-84d7-4d23-bede-4cac49f6a412@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 11:54:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] hw/arm/aspeed_ast27x0: Move SCU link into AST27x0
 coprocessors
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260706084540.1988785-1-jamin_lin@aspeedtech.com>
 <20260706084540.1988785-4-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706084540.1988785-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6lPKEgmfoxlO0suRg6dq9qMnFCMJdm8b
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEwMCBTYWx0ZWRfXzqxP09Z7/fCi
 /po7pIOx35X2DvDFyIgnFHzn1X+lPk6V/Jkt4M7f9Jg4Uadn/8CnmIfBhu0jtCJMy8IWbO1f7IT
 GO8foNrQfpjcQ90wMoQ7uMBoNMoBtbU=
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a4b7b5b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=lYaixF1Ub9yBDHAr5aoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEwMCBTYWx0ZWRfX9doBCraY3FI1
 BUKqymEMF6qpP8rJSiO4hpf5lQZKtt9fNNX182mZgizpgw5ptcnK3BLp/TyUki5+Ijn+Zq9YyCN
 pnrrv8eJypzutrZUIfyjo4Ad7KXnh45Y2aLdP2Ky13QUir4upYY2oDxTJkSCn/H+nvKyJyxIfiF
 mi00gztR+u3dTOUnGUZUtMR5t0GuqKL6iV3U2z1A80mxmFwI5AUnlCK87UZzO9h2ysaU9GAmxYN
 AjebVZIa9wuRKGD1bahYnpgrIpEGPcOBTiZk/nVXJBMvyL67HChpfDigyh2LZ+Ua2ENBXiFyswb
 tzJqPyClW3BMLntuU9h+f+XNoTPnoUyOYs4iignDWDBAeu25lKgeqp+nImnxWGWo9nCwvXEjngJ
 d4tabteA3LxcwoK99PWOsLNXj5046gh7TfmD3w6eaqczs49U39GiPrapAuhhRaMMcQ1LzCMNuO1
 4QPVpOGHXfzJVeJQh/w==
X-Proofpoint-ORIG-GUID: 6lPKEgmfoxlO0suRg6dq9qMnFCMJdm8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060100
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 6/7/26 10:45, Jamin Lin wrote:
> The SCU link is only needed by the AST27x0 SSP/TSP coprocessors for their
> AST2700-specific SCU alias window.
> 
> Move the link property from the common AspeedCoprocessorState into
> Aspeed27x0CoprocessorState, so the generic coprocessor model no longer
> contains an AST2700-specific dependency.
> 
> Also validate that the SCU link has been provided during device realize
> before accessing it.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_coprocessor.h |  5 +++--
>   hw/arm/aspeed_ast27x0-ssp.c         | 19 +++++++++++++++----
>   hw/arm/aspeed_ast27x0-tsp.c         | 19 +++++++++++++++----
>   hw/arm/aspeed_coprocessor_common.c  |  2 --
>   4 files changed, 33 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

