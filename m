Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C3C606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oxl58VEA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F+iblLl3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOZXV-0001mo-SN; Wed, 04 Nov 2026 06:52:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOZXU-0001mW-OF
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:52:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOZXS-0006VI-Ur
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:52:24 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Ba7TJ609711
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 11:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h+OM9sYwGLpZ+1YST1qHKhlATMSJdlnKzoMrlrhO3Jw=; b=oxl58VEAbyKNCNJS
 oVO58jvjRY99Qhsl3oVpxLBXvTKOSET17bMBoyrq4wirADGfH+T92w0U2zpIJ0Ml
 1LMhpBrN+x0S54/wX2d/VvRmUJz8idG+ciQG6coeDH32g2h4cbhZeOdDNtKLdOH9
 1UzLIFL/3OS1eIhpDBqifywfxWT1ENL3U2U2DUUAii3SST0UzRAZ3khTjs4HmIos
 Oa7b6XRTNgsIFnkqdJ/q81AfB6LcmT6vald+g7tI3on8UCkrQHrlCs/tOW3+Qv7d
 rNy7u0ptTCIKk+X9141nL3nnoFyJ9inYI2euo+tV/0gnjh0O6D7PTwIDnxQi+wi+
 jjpMOg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr3r80499-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:52:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9441113670dso167317685a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 03:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793793140; x=1794397940; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :references:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h+OM9sYwGLpZ+1YST1qHKhlATMSJdlnKzoMrlrhO3Jw=;
 b=F+iblLl30kuDr+kFt7QFkp37k6Ck3FwY2/de1RA5HkMCDmIKu+YAGei20maMR490fn
 Xi1Gn/yJ89YztC1ug1YrFdHLpqXic+mP7B69M9oeHI/ADLK7pQXQvj/cfeJ3A+2Cv57I
 nv1U871H8CCjHTVQfHLzM6soT9JlOZUAROLYEc6yp+uGtl2qHw3VfD49KhQY0no2AB1e
 rNnvxOv5ZbH6Xsg9PXXTxKACMhiRklAiTk5iH9oTpTtirfpTaV9+oFnKntzloZ0FzXU2
 0+QUZLJ2bcPuNILfLNyBhqBMPnINJgqjwMpozIDpmoNQCyXQuN9W8EIFtqFxBo/K/Qbc
 qHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793793140; x=1794397940;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :references:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h+OM9sYwGLpZ+1YST1qHKhlATMSJdlnKzoMrlrhO3Jw=;
 b=UXuP13OuxgKjdyAZyogxrqseeToU7Iv/q23zgJcf5hfYVAHZn/Asol0IHy1FYUxoey
 fn6nfay+G+xin0rnA3SIrmqQU5MzSrdyACsWnZcxAdTySNKhcfpXs1X4c10lS2oA8CtE
 cftuLlms4iv/DEDc18gzN4MPAZXGzIRdKZW+dw0WcQYUpJdguOLVeo4oC+m0H8l2K9x7
 EFYOpIgxo1QCDZ7ml1jStXCEbvy9WIMqzkEyYhMCx+RNph3LHQ++Znm79oD7bDwQlDyL
 3/oK1J2geVWZgcTTWHBpsjQbyL98FMQKAAVdwjm/4zoAKTp55Z6jE26mHF7CCMMHYovF
 VJiw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWcB04K6i9nnhWyU3ggyh3wDJmXXGF0stb6qaJElKHBabdVTgz2rZK2z3+ZYcvs5qGge/dTxSDRYVE@nongnu.org
X-Gm-Message-State: APuU4Z+nQKMiTJAT4KgnTqQkw7quWzbiuh6CTgPXoolP+KegCY5B/ONt
 jyTrkFfNth7nSbUnbEnqdWPS+Me/U6DFwsExlHcK0P7oYuaQTONvAnZGjiQpJSwG3uEd2N1tyPJ
 P8CgTJ7PtS2Ux0JhbzFRTRpfmqMd97Vh6TpSfNjfYBBwLI4OKYRswS2FmOQ==
X-Gm-Gg: AYBFou0fbjxijHw4Az4q+gUrnrZTz+Ma958OPS9oHDu3v+phlxTi/MrGxqJTK0QVfVW
 FajO8Bp3KuP/fyZyZr38qFbLlqFwUWu+dtPSGIMh3ju2bAZIM7cXV+zYC4PO/HFWl2VhlATlJa8
 H4SGYuRYsQq8ZvRrIzlnjfM9HJoktbtUhbe5bES5iYlQ0qksq9ZOYfljnMe07gi+Mk0PgmN9OYe
 kejs778qn+vMAXng6Eau5PaRy6vI+VnoWXJmZ/YVB7py2DPbh1xdew0BjB3D9sq8LTFSwqQ2U6B
 gw+q/3cSEpGnUW4j+P+WXZYkZuweHpfcvgTktMyPoar66R/5NvdQZhutaiXloCO0jAogeQ73xVD
 SNiv9L58fGc5NYH/9+wMmCinYK8ouDOho7gfZYty5ihQ0Ml+5CrPKCTH5PL4YBuU/zThg9yhXli
 WNBFni2g==
X-Received: by 2002:a05:620a:4586:b0:93f:22ae:f8ff with SMTP id
 af79cd13be357-9442178cd60mr2550163385a.46.1793793140120; 
 Wed, 04 Nov 2026 03:52:20 -0800 (PST)
X-Received: by 2002:a05:620a:4586:b0:93f:22ae:f8ff with SMTP id
 af79cd13be357-9442178cd60mr2550159785a.46.1793793139681; 
 Wed, 04 Nov 2026 03:52:19 -0800 (PST)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b452cd020csm45015225e9.4.2026.11.04.03.52.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 03:52:18 -0800 (PST)
Message-ID: <e429414f-a869-4dff-9fe6-fd7315b8e7ca@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 12:52:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/ssi-sd: Handle immediate write start token after R1
Content-Language: en-US
To: Manuele Conti <conti.manuele@gmail.com>, qemu-devel@nongnu.org
References: <20261104111619.24479-1-conti.manuele@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Bin Meng <bin.meng@processmission.com>
In-Reply-To: <20261104111619.24479-1-conti.manuele@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cND_ZQNAOJNrrQowosLWR6LEzPaakKmG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA0NyBTYWx0ZWRfX+niiAdXy7ggY
 5tzYiqxnQRnlf/QMoEgNxhRPWxOkrUtiaQ+1ic6658Ev/0FidQPXqZJd+OPZF+sPiJraCCHHwWI
 jtlzoDzPCOlsZAlxkoibJbrlAE41P3GrGZY3gQ+YAOIXKXNPmDK1KDbPlRoZWtq3nLt47Qv5Aeg
 xrCvIywJSflcHBP6JCCISDcjO1Ycj6AXBDuk57DyxDjWx1y5A1uvx89i8cjby0JkTt31g9v2xf5
 KloVyf+tH9NidFPwDziM/mmjZaIDL4XxcXrNBjOh2wcGw6n2peRXP1/0vPGAVut0pocPKAsAJNA
 FuCBdlWo1w7OVRsnjHSZXgaUDBYFZ3WzgD52F7d88dCtFBzhYKhR53pn7n0rn+Q+4vi68WQfx0B
 5pzl6Te+C8ISuHkQAfVykMy+J8Xg+i+H6nTh2gKv/PFVN+DcSfLde8VnntcdleKMLIQELEXA25g
 E8ibn0OPEXJnnYW+x6g==
X-Proofpoint-GUID: cND_ZQNAOJNrrQowosLWR6LEzPaakKmG
X-Authority-Analysis: v=2.4 cv=UuP2pOwB c=1 sm=1 tr=0 ts=6aeb1c74 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=qf5Zgl7zJ2BHlWJloCEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA0NyBTYWx0ZWRfX4lSspFduPXve
 CtwIuw88/0Fs3PsJNwVyEex+gU0fYGdpe+m9EgK1EFif7qRwtyOMtGnoLl223qSN6141BK5iDot
 VDRAj3w2G8VzFvB7Qcl8cuQpWl+oi9M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040047
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

Hi Manuele,

On 4/11/26 12:16, Manuele Conti wrote:
> When a write start token immediately follows the R1 response,
> the SPI SD controller may still be in SSI_SD_RESPONSE state
> and discard the token.
> 
> Recognize single-block and multi-block write start tokens
> when the SD card is ready to receive data, allowing the
> write operation to proceed without an additional dummy byte.

What guest is being run? Can you share the reproducer?

Unfortunately I only have access to the Simplified Spec and this
seems to be covered by the Full one.

> 
> Signed-off-by: Manuele Conti <conti.manuele@gmail.com>
> ---
>   hw/sd/ssi-sd.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> index a3a9f0c7efd..13c87c49cfb 100644
> --- a/hw/sd/ssi-sd.c
> +++ b/hw/sd/ssi-sd.c
> @@ -185,6 +185,12 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
>               s->mode = SSI_SD_CMD;
>               return SSI_DUMMY;
>           }
> +        /* The next byte after R1 may already be the write start token. */
> +        if (sdbus_receive_ready(&s->sdbus) &&
> +            (val == SSI_TOKEN_SINGLE || val == SSI_TOKEN_MULTI_WRITE)) {
> +            s->mode = SSI_SD_DATA_WRITE;
> +            return SSI_DUMMY;
> +        }
>           if (sdbus_data_ready(&s->sdbus)) {
>               DPRINTF("Data read\n");
>               s->mode = SSI_SD_DATA_START;


