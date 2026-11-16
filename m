Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66E5606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eV5awRf0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KaVvCkJW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT483-00051y-Hg; Mon, 16 Nov 2026 16:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT47n-0004sp-2h
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:20:30 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT47l-0003O5-Iw
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:20:26 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJemj62727631
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WLWixMoxXvf+QY3h7b/7+ttG04S3mh99Bg6WKd/luVc=; b=eV5awRf0e5Sv3q5u
 dbAQ8qIGeF5fRwPn1g9+iEgzsmr/OR0dES3xYDkyRaRqvztG3dVJuT8g0sJDBvfx
 PPSkT8EUDHOyRtm7QnasdfMfMgzwxZqzJyeK/FXDLiYzB97TuHoUEckVCIMFI9AH
 ObIwBK4W4wjn7fWlT04sWJ8nj0xZw4PsxZewOYtQ2EieI9fvvjtynWmxynHQfn20
 +I0Ac0xO/VUcZFvLh2wuKSVaR9R8EN1grdIVNZezI9MLFAZ+kzCy9wiGkZE2f6QM
 Y0e4wCzgF2WLTjM20fK88Ic9x4kKGTt2XyQmWwuPygPDFU/YDulg+P1nxvN2VHsL
 MGzQiQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j07regftv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:20:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso5631371eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794864024; x=1795468824; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WLWixMoxXvf+QY3h7b/7+ttG04S3mh99Bg6WKd/luVc=;
 b=KaVvCkJWapsNFmNtcsJPSEQ24u6gX+05i++ZwxohmioClgz/W7sCZ21ttoKF2bQ0ts
 AvyH1apNYIjlWsjojRxaYn/aGc25YgAw+rP3e/WOrW7qfBttsKmoPHYpK03X1fLlly2W
 69h6MH9rdmuvMOHeYirZelY3w3V0bNqd6VgI9JDlrFB5zM7TfWgzIv8yFh5/fIKIqsA5
 DI6tJ3rXIZ/nPHAEUi5dx1oUWcgSZizeKlN4BioU9Mc/mO4km4Stz+QQaUOvr7aycW1R
 +WS0THMh5FI0Vj+niZbT6GrhTDYgw2jMjnUoX31v1IVyc4wq8wjMW4T5xYbX3u0CmdJx
 981A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864024; x=1795468824;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WLWixMoxXvf+QY3h7b/7+ttG04S3mh99Bg6WKd/luVc=;
 b=NEr9B/kBBEMptRPs+WrYMV33oJb6iYsjNRp0wARjgBZT3bFnlKRql6JJapeywoP2jV
 JvHUZTvkaHGJEx2yPDxeBL/Uo/qyautQkWdwj0DUzaJBqrgS898mdluMCsUYYQ6Ty7IM
 DHmrKKmztpwnWCs4PkkfXJ5zvVccGh9bu4fM6Nc5wH6wKoT9I43WLNHrFANCKCTqKo92
 w4iSA4m3t3yn81P7poLOKuDJkLJJwX+BbxbonAl9/Vf9SbT3nIv4MMbNeHiEd6+3tMcv
 5czhMBUqjXJjQBK2Ai/ExxyJQwe/8aalz0su+sIUJDUGqCTR004MvTUGy40IfQKZa9SE
 sqXA==
X-Forwarded-Encrypted: i=1;
 AL+hErEie3DTTdbdqN8WpXMFkWDwVcoQB0VH2/d0v5Otrutzuno5TvVBMgVybbMwDwHspZ85CQ1kFaN2N7ab@nongnu.org
X-Gm-Message-State: APuU4Z/NIerqQmLUkWwfVeSzU55llN1Ou+ZDX5xD1bPeJIBZqDukR5dt
 szKCGoDFbY8j7K+Jn5rdemzYJbcxtTgLn1ZhRPbFIpXQippL7n2FvuUHXQ2RffWWrHFBcYch89u
 /5Ljt+jmb9nMEczde1e7dcHwgG3DtkqmybmGbt6xZMZEHDiGGJDsMlRAnmQ==
X-Gm-Gg: AZFdTZeureLpOHdjMWJR49ny9/yPBZ69AXTLM+HQKhu+CVXaxFzJ8Qq6CYD+WpJRPpR
 xYwGaudTpisW9yklzf1Wy9XE++jTYCGcdhYJnznnRx2aMTnYLJyd3eUPkAhXSEfRi2bW4RKcOeZ
 zVPn+sosHGF+gxCdby0rT8HB+fQtLwHsnQ+18toXpIXjoiruc/79JmLN20pzXqk1VX7NYvd8Hop
 6CwmCcLxjgAalPPalV0/uq1Jn8KP1gUFCpX1p1yAI179FGSx5+DQKLXCK1+QVeoAIRjROitPhbe
 1kJeP5wPLICd0ZnDZ+oNOsQPgErDrLZg0vAzBTNEaHbXFjlgNe4QFqNeituYH8kRo/BmGhODNMj
 9RT46DBx2/DEul0eUT1elnKCdOCq780uPpoyhCPUhaN6Zwgwq3jA3hfVJvK10ZpechTQBACN5BI
 dArcsF3ETcEvbCpu+UPWQoYOkra5FMYQODSqrOAVObeyY=
X-Received: by 2002:a05:7300:ce12:b0:37b:dbd0:ba63 with SMTP id
 5a478bee46e88-37bdbd0ba97mr6275406eec.3.1794864023493; 
 Mon, 16 Nov 2026 13:20:23 -0800 (PST)
X-Received: by 2002:a05:7300:ce12:b0:37b:dbd0:ba63 with SMTP id
 5a478bee46e88-37bdbd0ba97mr6275381eec.3.1794864022951; 
 Mon, 16 Nov 2026 13:20:22 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d07b3sm35450830eec.22.2026.11.16.13.20.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:20:22 -0800 (PST)
Message-ID: <0ca7abf4-203e-4265-b361-c3236c1fe108@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:20:21 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/48] hw/m68k: rename the 'virt' machine to 'm68k-virt'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-27-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-27-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX5rYiW5UkW9LE
 7eR7IuXLqrJBjInQKdRLHzj2za4Fws1srjLSaA4g9rj07YyOg+p2vteGKVTnSv0F+its1DMmryM
 eBm2XJXvOTs5CLYffTd/KzOTO2GZIsU=
X-Proofpoint-ORIG-GUID: g5GaDhtQhIydIkil3FhKyEdMWZJxvVQL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfXwWv6y3Vpqctq
 tSImHArcBLXz9SqUvPhZUwVGT2IDg6McnwCwtEBh5N4mxtbUrFAOmXM5ABhfOtxE1IdOXTjbp1R
 hij1eCJPCGoLxDHYDyfRPJwKpsRO27FQwLNVLXJX8KMBnU2XjoAkH0IJYE80xZn4/1PIzgaln78
 Zmw0ylnCZjQjOZz8MrAIs8jzRGhdSWJXRWO5JrHZ80Ra+SxxC3AjmY1JmlFqTINz3Bd9SuOCHkK
 t1rai7/a/1oK8MVhMg1Xd32tDUc63UQbPEHd2EBrr5Ihx9nnrHEA8mq7y3iz/XvRu2HeFE3al97
 0mrWiHNMi2yJQV/A6tq71I200Ip1j88n5KzFcssmGJmTnx0nKR8M30ClyHLLu00CnR246a9ddxS
 yFNDCbSFAEAo8JFw60Bta5us7Qqom9mDimTthEeO8N8S0m3yff9RyAki0CeYW6+tgVNJ2JZgJIb
 q700MUo0R1CT5qKg8Mw==
X-Proofpoint-GUID: g5GaDhtQhIydIkil3FhKyEdMWZJxvVQL
X-Authority-Analysis: v=2.4 cv=R9uWitRX c=1 sm=1 tr=0 ts=6afb7398 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=cPAzhqMq5pTeXIFO_yEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160084
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

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> This introduces a globally unique QOM typename 'm68k-virt' for
> the virt machine type.
> 
> An alias is added to resolve existing convenience name 'virt'.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/m68k/virt.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

