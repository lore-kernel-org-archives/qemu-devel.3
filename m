Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1BB606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=njWid/rt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L7Q83gSD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQWCO-0003xW-4A; Mon, 09 Nov 2026 15:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQWCG-0003kx-Co
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:42:33 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQWCD-0000KY-V2
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:42:31 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HHDI51525382
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YKYsKERAMFKPOsBV4MhFkZpCH1mMicqnYlynI4lyjYA=; b=njWid/rtMan7kpKp
 GpH7OeYNHMTDPsvUXq/uhOrWII72H9cSY039bLI/vrb5QezbemLlq9X/PhnG8tqJ
 8AwvYPbUWPx0597FN/JibmaPQjcZ7YbDXIeu7R4OFWRavotg8meQQ9JFSyOTsHtd
 P5qz/Fh2cnBJkGKO9sJY7q3GRiG/DhlNYUmV2eyUyePRZjoCYK41h1gjLmrA8TIR
 JvVtHe213GcNqHPKaSq2cvQUnfCpgCGINkL6vPlPPJ0jsQLxaZ6qiDdD/OKwFF4O
 7P7pUTy6eEhFUHvMSY/L98X7+Icgvd7fwD9YorEK4wDU7uvkh3+yjxxhbAaS6ByG
 p2aFKA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hufx81e1k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:42:28 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91c6c1e082bso23298556d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794256948; x=1794861748; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YKYsKERAMFKPOsBV4MhFkZpCH1mMicqnYlynI4lyjYA=;
 b=L7Q83gSDOD+lwVlCKfll/D5GVp+PegGo+gZv0dVcFF7VBYt4dx1BivEd2GXIFJ/ZP/
 cA9qZxT0XeSJ9tC4fr3xLOtOlPnE5YkxgFOC3B2E7LBmMrj8C2iTW92Rs81RjPWffd4m
 REO2FC51fafmM/bKZXwzXBzLIDPX+SxEnTJgIbVN3IRUeizkUTRWuBEJS13kbEd8vF5M
 zPsAwJrVsjmOEB9B9699NSObNJ7zYTHs6bzasWysOGAQV/r9cmB3A2PyzB7gzO6ob7ZQ
 EjGA1P08kgxk/FsjBUTARUYCRAiL1mOadg2szvclB1JLoTEcTc/lJ5OsxGH9zrzMhvOm
 m/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256948; x=1794861748;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YKYsKERAMFKPOsBV4MhFkZpCH1mMicqnYlynI4lyjYA=;
 b=wg85GnlyRWkNXbG06Qq+Jzi83pj10E8jRIaaj1GBtXMEtNMG52qmlWcbtu/j+h8lxG
 kreSdXMiQlcIoteJ7a7Oq0o8Y3YYQ7MS8+DWN3OBezIPHb3Te/2X3jRb4kVAqgMMXEGC
 xEenZ+R2+0Sq6/zPYb91hHSz2cL4SooOsB4wmwq8zAHsjh8vxCn897mr1pYSjB2KbbwM
 nO7mvXApep5ZQtumgbfmKf9YwdFLVKOhcDokCmEsQNO0ap9qoCaS2rXyf8CAK/pWt0bf
 veJrX4APOIqbF8/KXtrLrGcA6pVdX7+KzcD6zfd9qATiT9IJqBwUX+SZJgWILllxIfPW
 XHgA==
X-Forwarded-Encrypted: i=1;
 AL+hErFHpvFx6wizM7Cstni6hEOqojRrCZyLRLNP9ASGtkUSiMDfpJbntO3BI3ZXaqUNceD/F6kzPBv8jAmJ@nongnu.org
X-Gm-Message-State: APuU4Z+phhd7X7lLLljVJzYI2nSaN5KJe1uIZhgifv8Omg+56lynJ1vs
 kiodhkPUvztoenY8x39kD8wkngG9pw249JmJdzwaTRSOm0rRaIZi/Hft5wHzY/N93GQswjOYiIq
 ruzHUpRVSr9/0c6lWHuibu3+n/vJlISRNhgrQSNAipuiDAXsHVrtTUYU64g==
X-Gm-Gg: AYBFou1MNCNE5QYMgx3CHvctZoA681wOiuTH6DYsFwp8qWQ1iblRqu4xtPzeizHsf7v
 piUIdk1oxRC+fsQcvhwM7EGm36pFdiRiRLAwexprSQtKQAjrqBOKyil71grnrYaSQEtpvdYbpng
 DR6N89nL++EWt3fnYQ+JwJTjgKzmUjavncC0VCiWoM9XPWKPuLxmUiaGam+zW5rw7G4vDUmDHU0
 S+CMV7hco+mXQvJLM3xc9mhD0rQnFlCua2S8jhnPwayXXV3dwet0aZqPBaiq3jzWOl2NrHQUVbH
 942Ve77LVa0k09zm5O0EwQu+3sQjDv4TE4zEqyuhdFDx2t9qwC3twTGMfyFuPviCpqnJ4na8cpq
 Vbb1bf334xXywGo5dd3RUca+mOPGSZvy+G+xL2QY/rWjUWmNvTLzso7oO7Wdbr2D+IXPoXZP/mf
 8nhChJ/+Ts
X-Received: by 2002:a05:6214:1d03:b0:91e:b592:ee15 with SMTP id
 6a1803df08f44-91ef0189d74mr11064816d6.15.1794256948108; 
 Mon, 09 Nov 2026 12:42:28 -0800 (PST)
X-Received: by 2002:a05:6214:1d03:b0:91e:b592:ee15 with SMTP id
 6a1803df08f44-91ef0189d74mr11064406d6.15.1794256947474; 
 Mon, 09 Nov 2026 12:42:27 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef04e7315sm4585836d6.22.2026.11.09.12.42.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:42:27 -0800 (PST)
Message-ID: <047d75fc-5338-45d4-be5f-b0a635f73639@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:42:23 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 35/38] target/riscv: Add implied rules for Zvfbdota32f
 extension
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
 <20261104194155.679241-36-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-36-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AbYkjHXG c=1 sm=1 tr=0 ts=6af23034 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=9MQm-rMt-FVqDPw3zRgA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-GUID: JZ4XaQi23IBMt3FjACehEpbPHzLSutIU
X-Proofpoint-ORIG-GUID: JZ4XaQi23IBMt3FjACehEpbPHzLSutIU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfX/pxtJ716iWTd
 NxXW9VTtP8pJfgAlUDj6A3TrFXt6Td97go3YGxeg6fb1SNZJq7JAjMKKF75vIHxL4p5MwvmUcDl
 I8wyepOvlRkbCKE2XgjmiuC7SfQ6BKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfXxRJbFq6bxe8q
 jrXJMB4UiCSZOPfOFBwhSqlNadz3ToM2KgCss1nBT1EeotaaZOzFaEiHSabceJP/Ppu6HnjbF/a
 qmv24BLamiSVKm36np6LZvF8HQ7fhYfK8eX/V3UcbvfVW2OP7DsK4qT/wPsnXtYQvt4gHjImWJu
 9pJvCjPOC5b6LyOORGzGU8cFGr9e4bfaG9DTq10txadfOmhy9WLUvfBcH6meJf4FW1AZre4JMko
 QV699QHZziqNMNobwKzTekWkHJEF6+yYrTnjoTkZv4gKDsphF0Eq8ySBIEta+iiwHzb/9SMw2Qb
 WtwKCaxEvvWH+U2VzcMzJ0Xi7tQr76crN3D5ZO5q+r4IZwsYq59dVg8CSLLP/7H9owHm7Nu+nOG
 TMMRU+AglMui9ey0HVBjzu6kXEyu/jjmiEKOSP9YZIjK3D72xzrZfwjsNhrC5Zd192LmFP+zgwo
 gclaF/d3ofZ06rbT6AQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 11/4/2026 4:41 PM, Max Chou wrote:
> Add implied rules to enable the implied extensions of Zvfbdota32f
> extension recursively.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ed0f5ed976a..ff09bafe667 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2903,6 +2903,15 @@ static RISCVCPUImpliedExtsRule ZVFQWBDOTA8F_IMPLIED = {
>       },
>   };
>   
> +static RISCVCPUImpliedExtsRule ZVFBDOTA32F_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvfbdota32f),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32f),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>   static RISCVCPUImpliedExtsRule ZVFWBDOTA16BF_IMPLIED = {
>       .ext = CPU_CFG_OFFSET(ext_zvfwbdota16bf),
>       .implied_multi_exts = {
> @@ -3131,6 +3140,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>       &ZVE64D_IMPLIED,
>       &ZVE64F_IMPLIED,
>       &ZVE64X_IMPLIED,
> +    &ZVFBDOTA32F_IMPLIED,
>       &ZVFBFA_IMPLIED,
>       &ZVFBFMIN_IMPLIED,
>       &ZVFBFWMA_IMPLIED,


