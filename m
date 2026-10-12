Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72409CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG7wJ-0006Qz-4t; Mon, 12 Oct 2026 00:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7wG-0006Pi-B3
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:47:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7wD-0004ON-JO
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:47:03 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lLK2893052
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +zJj8yb66SRWdLm1rkwYPBruiZb4vnYM7QpdQ0cklEk=; b=apdYz+viGlnxT+7G
 4IeFEjWr2VhWLPD/AAGqfyg5WMSKokKahMl6ljTiKIoY2rYhgojBCdItbZzKIRM0
 sM7+1QFuJ6XKbXomDquI02fE6s954+X+hQXjIcilIoszlOasqPhfWefCaF3mjiST
 jBEfP9TOPxJKn85svTcyNkaISKlm3EexT7VPDSDsDCQwpl8VtmwQ3WyKHg1+PWgv
 rUDn1FrrFaQqsDhX71wb3HJB09Ca9r0id2ZN4uFbhlh7kj0dA34nl+65t9wA6a0w
 R+G6f+KeCv+28HjEEZvWCuce4YhoAcKmecD/Z0Kq5i7D5eTZD9jkJdAKjYVmPINq
 qGssnA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j710wju-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:47:00 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-917a7fffbe0so39785536d6.1
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 21:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791780420; x=1792385220; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+zJj8yb66SRWdLm1rkwYPBruiZb4vnYM7QpdQ0cklEk=;
 b=KPKKBh1iPBzIUM5u6eZuIX9/FEQ54jG3jdIiMxuEJ11nbQOYD/QbpSNr/mpwjE47uB
 36PsJH974xfsJElWFPioQIEIqXHEuHCKzDvOfGr7HQ4syBLi67DW5a6K3S2BtIjfaEVH
 lducl6vm9nV2Vr1Fre6qhMUFt/N5dwRkXUcmoV7AEL+1OliZ3QTL+1ouD6eWpMm3QokB
 S0CzLE0vGke8xxK6vvyID7horAUMTEM649LLHX9dwNsmM8F4h4+/chDQFmhaHNddnWDy
 BxCa/EDWkqMkD3mC0/v+BgHFcxZDjfiGRmomXgCMdMWxTOv9ziveqGq3wXV22h1UzOEe
 ZTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791780420; x=1792385220;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+zJj8yb66SRWdLm1rkwYPBruiZb4vnYM7QpdQ0cklEk=;
 b=0lczttrQFlslyt37oEHeFAayjDcTSi/Qx8JnbDZiuDlyJiIv3+O88Gr42/JZnxEb5x
 L1TTP9IOGlmCY6+sneu4pqlRGUbhSS9ZXLFnsh+GtbzEBZGiTrBpNjOO5RqrZ2B5bkJf
 1JXh6BzhTvfMBh9XfXL5LsnGdXayyG0itNIxkgd0gDBQhxfnvLMvfi6bQAkspmNWvMHc
 SRFVTPm7Wsj5v1x0iS3a597b4SNLwlX8cav4OtqZN/lvOOXwG/wt41muLYn32ki/Q13n
 yUob426OB1Oa5nf5IX/3ciZHtYmZgLq267Ouo3hpfaCOor6lEr2L/lV9UB93ueDmDJ/L
 mdvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHGlpDPR6IjnPgd8avfdgT0PvdOyw4U3eUBR6aMKEUSxptGKiYNySAnFZ+JQjWJjG4MJDoqcDFzWY1@nongnu.org
X-Gm-Message-State: AFq9FYIdP6n96t5vAVgH9rl0Z6ODkwKTydfEgxhDeAyvrwrvuXkMZov0
 Jm0O1MJfNLzRE1nxQVu/HTLhAQ1wCGBOKkHWiiR17nGwfotdOp2KKa5DfkrkSqJQuBXC8KpuQ8U
 MpyE5dd2ekcw3sCVE9+QVvEQL1DZ48OO97mUUUOW3rc/wmBDuZsVbUlc/GA==
X-Gm-Gg: AYBFou17aBa+yTs73Yn6uYa01glNsVrGItG3jmWC22egfdtkr/jAuesbK2Z6N40ssiY
 OFsp6O+HsMzEuyLYS4/s67uw5ZQjZeD61wv4iELAzPaCRwo6ilFT1xUN6NDlPKPsqTPL5gBLXRN
 HFlmPwdlOFJHqGBCDVHinaxPktv8pSrPVhUZrJrfx5ojK190SZNdBKyBxBMQJEexrmEUSIM+IqH
 7ttH1RXmcdHYcATuNWoTBSYpcf72zZqwv/9tnSfllL4hWxVtAhpf8WebBWRwyRBuZqRc10s1e9f
 B3cmSD4BL57prNydva7dWjOAZZuof7XwXVdwh21TYsvcMYJtzFTLXIbarvWzdJLIEdwWrH11zsA
 NhjRQjTRdh5hoJZUKdBR7nLtD9Qfm1sR7mU4YQfIhBSj874cb37sPiKTYZGjhLL5NBQOonUp1yz
 pUQlo=
X-Received: by 2002:a05:6214:85cf:10b0:91b:8e83:e4a7 with SMTP id
 6a1803df08f44-91b8e83f377mr1577666d6.11.1791780419740; 
 Sun, 11 Oct 2026 21:46:59 -0700 (PDT)
X-Received: by 2002:a05:6214:85cf:10b0:91b:8e83:e4a7 with SMTP id
 6a1803df08f44-91b8e83f377mr1577586d6.11.1791780419279; 
 Sun, 11 Oct 2026 21:46:59 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b550887ebsm85848686d6.33.2026.10.11.21.46.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2026 21:46:58 -0700 (PDT)
Message-ID: <af49f43e-d856-40f6-bb1f-987347016440@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 23:46:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] target-info: add target_hexagon
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
 <20261009225226.10657-3-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261009225226.10657-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfX5sV8I0dHNOLo
 KHZpJBuS1I7BbQhoQOlCXcRvo7USNxFjac2fsiIwlATz3eZA7z9ANhFWoJsub1K3YtBR2VmApMV
 ueEeaEMHOdWCdQ0Y9l6aS3oE/bFX31w=
X-Proofpoint-GUID: lZ-5AAqdHom-IKuB3qU210ozi543VGPq
X-Proofpoint-ORIG-GUID: lZ-5AAqdHom-IKuB3qU210ozi543VGPq
X-Authority-Analysis: v=2.4 cv=ePGGH3p1 c=1 sm=1 tr=0 ts=6acc6644 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=32ggs3lF5JV5lGpjTxAA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfXxPGJD6NFFnNl
 XWV66IRB1lFSkJbED3lE1tlOuqE3QMeCTjhJqM5tarYtuejXwRMoSZUrr1/aepAzne+7kRHEvRQ
 VhVLBFZ3wL1w2z4cDs/Cc26z0tyLPGaZsvQOvu43/TS/+ipvgNapC2sxITahSBczczWl0l5sP/z
 WxT9jleVv+DQR3orbv8nGmxjzbFZ2WufNq3u3Y7Ctk6OtXjsVmt4aurrU0kHbLTsHQRpqaWRQmy
 c7nXTh1VNH2Eq8uf5oY65md9pBulVq0jkW9mM+XEx65gD0T3L2CLP8VbNB4DVuPk3oaXnjUdDaa
 7vk+WtW7aVt2lQkxRV0mesFFAnHtEQu21HMWuSG35+Sj8/dEmFZ9NOnBmCtTnEmlVkF67PVW1dB
 Yu8ASUa5arJ43fwGVgcZPw/KpyegSh8NRHTK+I9GOj/krZrMDY4ofvCIlZRwhx2aF6PY60n9/jA
 /NdYlRxZBjnG8R7j/dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120018
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 10/9/2026 5:52 PM, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---



Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   include/qemu/target-info.h | 7 +++++++
>   target-info.c              | 5 +++++
>   2 files changed, 12 insertions(+)
>
> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index adda363ac39..862097c6c63 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -70,6 +70,13 @@ bool target_aarch64(void);
>    */
>   bool target_m68k(void);
>   
> +/**
> + * target_hexagon:
> + *
> + * Returns whether the target architecture is Hexagon.
> + */
> +bool target_hexagon(void);
> +
>   /**
>    * target_or1k:
>    *
> diff --git a/target-info.c b/target-info.c
> index ab43c9f802c..0efa4d32546 100644
> --- a/target-info.c
> +++ b/target-info.c
> @@ -68,6 +68,11 @@ bool target_m68k(void)
>       return target_arch() == SYS_EMU_TARGET_M68K;
>   }
>   
> +bool target_hexagon(void)
> +{
> +    return target_arch() == SYS_EMU_TARGET_HEXAGON;
> +}
> +
>   bool target_or1k(void)
>   {
>       return target_arch() == SYS_EMU_TARGET_OR1K;

