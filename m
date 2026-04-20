Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13575F588F9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wErcg-0005L5-Jh; Mon, 20 Apr 2026 12:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wErcQ-0005AD-CB
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:37:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wErcN-00077K-Nx
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:37:05 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KA4LmE2981436
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 16:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HQz8tD8df1HIippMaze0fMU8DOqnSVe3mJiyyiNclwY=; b=INYx1NUvsNYI3ltp
 UTav0OmkNo1jYkt/TFqgYdCj2KVbMbBDiT47a9Voy8K2p4OWgXxMc2kmlA5A9Er7
 kwCnIKnzQ+dydUfQNXcyqahxG/7SHvCUH12qlX5NaMk6swN3BSnXP8N0wDEjSGeD
 Rd9esoKwP510suVvJPcmfiqK9Tgd6TiUr+XGUgvxweeEvWJrdC+e0EvGSqNjrIPZ
 e41RhxlHP1sgRYgOt28Z1j6henef1y8hfdSkd+/TRkdGq0BxESyM6RwGIqGEL+cu
 dggnxKtyVTzS7x1YnNvkLbNdEjamZUsI4k+ARPhpMjxdwf0INuS0x7eCaNo6s7ZQ
 hSLLSA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnj2pse5x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 16:37:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2c16233ee11so4453157eec.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776703021; x=1777307821; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HQz8tD8df1HIippMaze0fMU8DOqnSVe3mJiyyiNclwY=;
 b=auxNasaG+9JcpdhXBpJCBDHk6iZwsEhoU+H1Oa0ZL/JioRnDD2EwfVnE8siBu8XSEf
 7gqLZ8Cty4VLmI0g2ImYzYE24iZbRXOOLFKLu23e9OcNfVZaihUakVT5yYjmy09aud9X
 mmdMm1YA7jQ1VaNUf3leM4B06mpsF0iohmT7H9zIi4YFDW48OzkoIS02DyuVP/zItSMv
 ttHAqtNK5xlGGHjP8EHEvRMEqY8zA9u8u7e28XKAxJ8j1VhopeNjONA/iNHRebmM+s/F
 oZb1CxCMc8e0KViWrw8GssiEJqeQxnI4DqVUvPLDRwnMZdBGIJ/SWpPnL7RqGGOoC9CW
 Fh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776703021; x=1777307821;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HQz8tD8df1HIippMaze0fMU8DOqnSVe3mJiyyiNclwY=;
 b=NSjgH+91UarDVFqB1PxJvEUk5K2Kc9q9137U869DYq/Zx9vrOF/Y1A/OnZ332NxPlY
 yKtAE2yGkK3GQuNdtcsKnoS4R4U8D7fL+5H53R8c6/hFYBrqQjMraEGvifPahf2QvDbi
 uSYilr5lDz1wxYnQMieIU4Z/ygSE5mNxdJvSV8ZtJNMZaWOEAc1gUidE/rJ68KM5zeSa
 12i3tYLcPNDSCPOyVyly6vTTZuAUHbwB7upMnKOHr/waJs/dtgsezqKbMyPUXFJr4IUE
 R5u7hM56otH77Op9KokSub3DtJT4LsHuEw7rpfnViHQTK3PD5NtIhLyfSTLAy99855ne
 ftHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ88HzHz2NYw5DJ+hnox2JVAXLG6eXMW3jLkedTep0iLYwT4OgTQvHqkg8nVfBGwYATqAtvvlOBnPwYZ@nongnu.org
X-Gm-Message-State: AOJu0YwNdVGCssx2SApGwwb9R/rFNTdx8KpxWwy6VVFode+GWEdDkX0z
 gPi/bxMinhJN6yWGO3SdoYaDbnEwpI34s/8fLStJPiC/mCa+DmwrDTaCIca5BQaer22Gzu8eSnK
 WzuEL9nZYyKTkjry26zcb3ADSEOkmCBdfgkUbrP143Ls+gd2J4YqwiznKpA==
X-Gm-Gg: AeBDietN8YqyDQsXuxH6n4Qcyt1huNJFrlk1FyRgDvm51OP0l9FMCWqV+VIINMIFSPR
 HXbbIy9NjydaqjO7zJ7c/eDRnKJLBwjtAFk9HT3YRa2GaA2/1jJ3bytejyPF5jBGnUaQmUSr/Ca
 tDyNTA8GZd7hX8SE5JmuQp9OAOPxl3YVPWkQyykr94gF/CUmOyV0G/iRUQO+L4SlwMy0ss0aLCe
 IMfzCmZybwm+QWV+j5cdES/pProGOuXECRPFcedeE8uRu1lb3UsrcGaA8kc5a2m6uxERNXWdWGW
 wWt9CHkAhFKQF3b4YwYUpg0OmtOfya15o+inbRAbDU78DXnvfnGmgvk1iuBttvrrjVezxYzlGqW
 uJBFwQDDgxM2CJKCbcSthSsZKsl/0SES9+Wp7ScWSrikbZynrGhZIVG69LNJtsoruOR/V9hIkFY
 ayLKeIfc7aDbKyMZ2LlhgZweNE
X-Received: by 2002:a05:7022:ef0d:b0:119:e56c:18b3 with SMTP id
 a92af1059eb24-12c73f9707amr7054448c88.27.1776703021249; 
 Mon, 20 Apr 2026 09:37:01 -0700 (PDT)
X-Received: by 2002:a05:7022:ef0d:b0:119:e56c:18b3 with SMTP id
 a92af1059eb24-12c73f9707amr7054394c88.27.1776703020668; 
 Mon, 20 Apr 2026 09:37:00 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c7b62fe87sm11497296c88.2.2026.04.20.09.36.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 09:37:00 -0700 (PDT)
Message-ID: <3b7586ce-626c-4b76-9421-35b5a0dbcc9f@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 09:36:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 23/37] target/hexagon: Add system reg insns
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
 <20260401152657.314902-24-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260401152657.314902-24-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: P_r6nlW2t_ZPqBCh4JlUWpiUy7ZWBMRd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE2MCBTYWx0ZWRfX3OO8Rui/4IBh
 4n8EcMxJ9eU8sG9CsW8gv9eE/EbYvCEYs+D8YTN7rZiXnfQCnZI0ibEJqFr4wYS+jkpkNJwtkaU
 rk/t1aCga19LBghZrqkDOHOCamPZOuRATaoCH6E0MrlrcejFQBa/AZeBhmqPwuO3BuDVe4hS26G
 MVYqcijT+jqyL8mQ53kOBeHq7/Y65tG3k8rgh4N63sHk5AZ3JrwXYDFGzes4iIL7syQCHbklej4
 6+GE4xrt3W1VoZX3Uo0QGocuQAGQ6ieEiycjN1gCQ4knNDaAjZUoHNr2wxQutwp3uN4MpxHFTbS
 ZEisfOaK3Qo0C/HGENi6XQ6BbhahwOR1uHRnkbqe4X1x1KSpNUjakavtlQYLdokAxxBe2pHKPhQ
 /TekEJY23asyGcv3nz2Afy1eIa4UJbt77mwf3Y2xPvyi3EFngPRnvkkBMwVKRGUkD0ZgJvkuclF
 6kOOyg6B98D21F92GvA==
X-Authority-Analysis: v=2.4 cv=XMoAjwhE c=1 sm=1 tr=0 ts=69e6562e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=uIGHoVdDp3z8IcWzBhAA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: P_r6nlW2t_ZPqBCh4JlUWpiUy7ZWBMRd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200160
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

On 4/1/2026 8:26 AM, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Acked-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/imported/encode_pp.def | 128 ++++++++++++--
>   target/hexagon/imported/system.idef   | 244 ++++++++++++++++++++++++--
>   2 files changed, 345 insertions(+), 27 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

