Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE90EB3632
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 21:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxB6D-0005nw-DD; Mon, 02 Mar 2026 16:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vxB6B-0005no-6x
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 16:46:43 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vxB69-0007He-JF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 16:46:42 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 622GGXPn3742057
 for <qemu-devel@nongnu.org>; Mon, 2 Mar 2026 21:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v3f0en0tpC+gZm+caGbc4NF+XxV2Vy1QEOYeehZ4u20=; b=ZqYyNvEsxu420Wnk
 D94raRr4KmLtn4kU6GLld79LggT124YzLN0CsS3G4bqbIvV6EoSrZdbbLfvO+Ack
 0VPZiP/Zczn3gEoJXLrOHJ8Vo4l/URT3DlLFC5Csc978XiZqIJPbBqqhvVYQPVNO
 0YR2FYwAsHlhWlAjJsLiCtUvuZgZhsb+gXtxCAu1tPvBgomzuVyFrjEpYimM/Y1k
 YRuOULQ4Juzjd8qmz/cVVGW70UWzD7BL5Og7aRf9faKnbp2Zin0Hg0HjbXY6eSkx
 oL9NIW7b62awh8mUko2r+8kz1jlWaSLDgHsdd6QhMjS56Rbctk4pvH6PcGi7RfIU
 ov1v0A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7trjeqw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 21:46:38 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2be21146933so294178eec.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 13:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772487998; x=1773092798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v3f0en0tpC+gZm+caGbc4NF+XxV2Vy1QEOYeehZ4u20=;
 b=Su2GAg6/md2e/nmLDKOchI2Fu8HFemO+RBPpSS6ALfEwt9kGYWpTQkn/y8LSTxm/be
 ncA+De0R+WOxURWvj7urnCCMNcm1b1AepBfGaLvCCkHLBKPype5cZLVkKX+Ndx4uOTnk
 ZQ8ZqZz8Km9O2c9w3EFKall38x1mxaF68xVKYcglzGY2KqGLF/6yCBCLvwVPX4HfBjDw
 ug4q+H6KAVQbEmFsNX6pLXTvDV1OALPaa0nW119uK7wBB2to1MNZHiwzx3mDbGPdiRZa
 ApIrwFgHDV1hqB1OxW7W2j07bixP/T3OLsNiKo8Ya0uac5FGPglF0+fP33qY5WFW2fAn
 /csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772487998; x=1773092798;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v3f0en0tpC+gZm+caGbc4NF+XxV2Vy1QEOYeehZ4u20=;
 b=ppplbMITvHBQWMiaZo8lGGa9qY63Xeq3AwCs8RMXx0HVZ47kVMISC4xn+AoTOXRwCF
 BoUM+cGluZlPl3CxwrmrzIGhsa4DwewwAIQ48jjEuH0sQ8CgcsxklxuWFAwLkjN3o+2s
 8pLLVrIG8dXsTK1VUb1q7VuvC+OelZViCgkwOdro288pTC2FZ9XbbTw5ULuesuJizNJF
 fnJzWsxwFy4TdzPBB1EHomvQfbHay9oLDF0QwHam9Nl9CFHINvKCZHCYN/SbRqdqz3h5
 auu1hT9FrMa6wpt5mbtztce1joFhEhz5gMSYusljWWJwenF83ajSEUsg2lp2L9EZEjVH
 G9kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRJL/AdZg76zP0FSG1x/QtKfKGwn/RDiN8BnM5RwuhwDHKhwYVNMpisBAS4izxvq3Kx5BYaq6tEINJ@nongnu.org
X-Gm-Message-State: AOJu0YyBIbY86V8Tl1+c1QldnOCx4oMG5t51n+e3UYLC6P06joaZGYMU
 JWlIIVVEpRt+rgcUJwSgyIBefFkK3BXDjiPjcmRt+TbiTvw/l3GET/SVKBDNaHdQ3CW1vbCDfPj
 BIHbYGbEXIBrgZ3Ng00ifQNDh3ogu5P64bGcfqFk18zUXrk9wLlSuG3t32/yF6HkqyA==
X-Gm-Gg: ATEYQzzsUIb0UXXdQq8BbcaCUGvmlGw0tvB0drIzSCSVs2WRgyYlN3RXaBkkx2phQnN
 vxMxfHIlrHU1pSL2jFWUUTS31cinDRQi2rNqADiegl1bv9vjSnjmS2DUiSCvgvSBr/6M9tvKikx
 yahwFTdJjZvMXxFcQGwXQY1BJqyvzsuYJ17SdydrhqQQgXoyID6MdmXfMYKhn28hvRMCZY9MkHk
 ix6bD2pXipTxEEI/LPcJy1mtcGiUX9+Y7SWTmUXgAzTu4NeyH3Vszy8S29F1XGccrodbISM7R1Z
 PTNG50lJwdsGtlBDIXLgafz7/Rok8GgW4SALNccx7grQz7/OMUrevrY0EsogudSQBQzw1HAEWlA
 jWswxEu6VR19/z9CAGGgKz1v/HPxrKQHNfl5v7vpbvM8KorqxB28xHE40s7OFn7ML+wJIyb9P/g
 8y
X-Received: by 2002:a05:7022:608e:b0:11b:baa5:f4d1 with SMTP id
 a92af1059eb24-1278fb6080cmr6468669c88.6.1772487997640; 
 Mon, 02 Mar 2026 13:46:37 -0800 (PST)
X-Received: by 2002:a05:7022:608e:b0:11b:baa5:f4d1 with SMTP id
 a92af1059eb24-1278fb6080cmr6468639c88.6.1772487997051; 
 Mon, 02 Mar 2026 13:46:37 -0800 (PST)
Received: from [10.110.0.81] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789a43c12sm16128215c88.14.2026.03.02.13.46.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 13:46:36 -0800 (PST)
Message-ID: <6069dcb7-e947-4dd7-9477-dad8252fa921@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 13:46:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] hw/i3c/dw-i3c: Use ROUND_UP() for RX buffer
 allocation alignment
To: Jamin Lin <jamin_lin@aspeedtech.com>, "clg@kaod.org" <clg@kaod.org>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "komlodi@google.com" <komlodi@google.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <20260302032626.1974743-1-jamin_lin@aspeedtech.com>
 <20260302032626.1974743-2-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
In-Reply-To: <20260302032626.1974743-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2MyBTYWx0ZWRfX7u0slhR0ezc6
 DTsErrzEPTr2RyQsy+I3R4RFOnjhfjl9BgXL6GWKFLv4TYX8Iduz+Gq9WLIXIaN0uG/Y7iI7Rqz
 okSAgjGMgISmVHOO5nXRYcd/3CqW9DT5ae70UhILD8/cF2L6xj+eCP2dOTzMvdOLZXqR1vrJxDs
 y8HIRZCmbG10o5J/diWsbnnC14op/ASdTuxT2KSIABn7UKxPOL2iukhq198ArC2xFZ9AtcT5WKc
 RMZiJY9F7eVYLzwj2GOoDUrggTrAT616xxiuAtKXbBBeaDpaNDyu6ifzz3yZI/Kd302uhciUEWU
 dUdJvcjx65eKEgKlDiKimuH7n0j39x1c8Bp+fXBwe2cudjykkoVmzQxQzuaDM6IRbXZcmgnPyPL
 AHTejwyLcG5wOstTiGhF/p8jTIMlD/Ocg2Mss84KGPP25E1QIgpTnJVCZ4FpTAJYx/qcfgsEfMP
 heMNCrTP8IwLyIgcNfA==
X-Authority-Analysis: v=2.4 cv=TNhIilla c=1 sm=1 tr=0 ts=69a6053e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=PmZNVC7w5negABTizRkA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-ORIG-GUID: Ihr4lDcKjalY-j3FB6jEcyQqUmBfy9zM
X-Proofpoint-GUID: Ihr4lDcKjalY-j3FB6jEcyQqUmBfy9zM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020163
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/1/2026 7:26 PM, Jamin Lin wrote:
> The RX temporary buffer allocation manually aligned the size using:
> 
>     num + (4 - (num & 0x03))
> 
> Replace this with ROUND_UP(num, 4) for better readability and
> consistency with common QEMU coding style.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/i3c/dw-i3c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
> index d742458129..3d8b95a14c 100644
> --- a/hw/i3c/dw-i3c.c
> +++ b/hw/i3c/dw-i3c.c
> @@ -1282,7 +1282,7 @@ static uint16_t dw_i3c_rx(DWI3C *s, uint16_t num, bool is_i2c)
>       * Allocate a temporary buffer to read data from the target.
>       * Zero it and word-align it as well in case we're reading unaligned data.
>       */
> -    g_autofree uint8_t *data = g_new0(uint8_t, num + (4 - (num & 0x03)));
> +    g_autofree uint8_t *data = g_new0(uint8_t, ROUND_UP(num, 4));
>      uint32_t *data32 = (uint32_t *)data;
>      /*
>       * 32-bits since the I3C API wants a 32-bit number, even though the

Looks good to me

Reviewed-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>



Thanks
Jithu




