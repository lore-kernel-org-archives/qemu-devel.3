Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB957C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wztgn-0001MG-1Y; Fri, 28 Aug 2026 06:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wztgl-0001Ln-Ra
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 06:19:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wztgk-0002jP-BL
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 06:19:59 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SA87TQ2596111
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 10:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 digF0j3RKkAWpIOB+mriAFqCAd6k2tiKXmcp2ZdjUXw=; b=mcByegqWdRpesCE3
 msTSudn5t+rhKkGt5agjtrEyQI5FJ4yRRgIhr7Ubvs/P3uU4S7UbIElidyT3eC2X
 QK5C3YtY9oJd4D2qJWwDzLSm4buzyB7jqMxTxmqoMWEW3ZqIaO12dLLgTJ/5pLdO
 STue35tC4gsPxwIn3q8aIG5ArkIIDJspCgaot7R27G9yZNBTnqSTE5u8B3gEfaVY
 JDVZfOw+gnDOZWX0xbVKyHOZ3E48HCY3E8XSxfbftkZvIzlo1y88zQ7wKuXCqEXF
 9khZoOuq+IzFN1BNY9zt4uqkRHc8GuOxf+aGTQG06FH+1kr6jgA0nk51IX0LbvF6
 I/uCeQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb1v39prk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 10:19:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52dcf1bb6e9so22211991cf.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 03:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787912396; x=1788517196; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=digF0j3RKkAWpIOB+mriAFqCAd6k2tiKXmcp2ZdjUXw=;
 b=BLGma95fCRZ/1yoCdxcusdWwEsRf4Y4Zze4MDR1dK9UhmBYbXUS4mH/cEM+nPAo0S8
 xFZv3d3PUBVmG2krZlDQ84+5EQqPJL4CQ8W08oA7Jcp0CM7ELYY7LGXPob+CCqu7/GVb
 vR9lt52hhR0YhXw+oXPvJ07p+zRGta+pUK+LeI8XKhHlddC1bTQRTE5OtnfBvQ2Hz/uD
 AtndSfAaUgFXopT25+ipiJofvn4/bsckQvvPT5nPA15iQ3zH/JGZR8EPRhQs9vdlyift
 OmLiirFeL9powSUeL2CfiMZXMN1b2oE/y9JS0QFsUZ5JysY008GnHrZjO0aEAfZLeJ3R
 hDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787912396; x=1788517196;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=digF0j3RKkAWpIOB+mriAFqCAd6k2tiKXmcp2ZdjUXw=;
 b=ZgXZA2cV4T93423hXmtPnAOjOBmK9vGeO73IFhGsh/MHYC45OWSFEtCHnZrnvQ/1jt
 8JNspoHTI+QnvZeNRgS8HTFcsIGLuanPxKsfLLDDw7mbs6Bjmvtx7NQM+V97WOUBEnCw
 MYQ6fohKb3fLAn49Ky5eU5ZHd2z4Zr7YpAj4MFPSvaS7P6kJrN07b6m6HkSaNWd8QeuN
 JjtRWp2/klKJvtMDOEAQ0oS+VjUkIDHlKaQKX69uXC7GH84TMn2oWDvQ8GoZNmg9lS0m
 L79Qui5qaWNiI9bTYVvXuIJCilCpE+xNPhUfdjVG9oPtrj6+PITHOgu5r+90CSM6W2/f
 plsQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4XjXguw54isawSMfM39Hbjgo500dTgaY6bbOv3OQ7FI0hwuQI/mvbf5tGs5I0ijQJB5jJMBiScLoF@nongnu.org
X-Gm-Message-State: AFuF++kgyCyL8OF5bhug8177t/1+uX0Lon9NP8PYmSZKhh8JnqZbqI2X
 hs0KtwKtmG7yL75uQhw/CSdvbNAT6PXnBwwUmkwaEvufE30GiJGISn4GTsLOdaHIbo2iMeCbsAx
 o+cE2+k5hPmhyxbacke99lRdgavvGYO6Gof47wexNhhcdq2JGeAGITO0tHQ==
X-Gm-Gg: AR+sD10eDEMuz5nB1k+YJtDdPQjhVBhKCoRKIWU/yVIeFXqPPtAOLNKvTpf4+J0tL+T
 Cnejeb2LykJCiem4rIX/1akhW3bTclVN4qmIpdS72QsrzVDEcClGUyAd+OgYEpGYXcLrE8B+5BD
 HrH2EEE030D0EhSvbRICZi6hPZHA4ZnZUUhxQKWmZ3+MpEQ71AIao5/wFsi5TxUHQ8dlHpd4HD4
 CB3r4YfSh1U9ZUSbMTlqAiGyJ4c3MRCYaH7RD1CfYQfwrhyOKDlIositK1V+bK1yBg8guSG2kAU
 TVSTD40Jxj8vzE20kJkvHZfcdHWzLUX0sR+Zi6/ZVFmWMtT1aWRUb/OT699a3lZQC7EBiBeM1Nx
 RdFQmQohpHb0lzAxNDqrLk+KRVOhouc6GFw==
X-Received: by 2002:a05:622a:93:b0:52e:125b:9444 with SMTP id
 d75a77b69052e-52fa1d2d479mr152782661cf.17.1787912396579; 
 Fri, 28 Aug 2026 03:19:56 -0700 (PDT)
X-Received: by 2002:a05:622a:93:b0:52e:125b:9444 with SMTP id
 d75a77b69052e-52fa1d2d479mr152782231cf.17.1787912396051; 
 Fri, 28 Aug 2026 03:19:56 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b91c52fdbsm40471925e9.0.2026.08.28.03.19.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 03:19:55 -0700 (PDT)
Message-ID: <77dce32e-1d4d-456b-aebf-ade34516464f@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 12:19:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: Mark the next-cube machine as "Orphan"
Content-Language: en-US
To: Thomas Huth <th.huth@posteo.eu>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20260828095241.118458-1-th.huth@posteo.eu>
 <20260828095241.118458-4-th.huth@posteo.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828095241.118458-4-th.huth@posteo.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA4OCBTYWx0ZWRfX84eDXJGu0YZR
 49WLz6MYh8VDuPq8+ihiilyO4Izw4fmmv0gtBBD4WmqhihVo7G5zShFXVCbPFgj8Uq2u/SrVLvb
 hMZurnGoSUtbs7at+FqbefATttvLYik5JQAe+bsHj7i2XMjKS4TXd4tvAqY1jetTb6Ou2LF9UlB
 bfhfGvRhiYSttRh2EwW+B1f+BLM9/2n1i7+zD3npUyXIBU21Rxt4Igfb8tph3D9jzyfq8EOfw8s
 QSPHUk096darf7s0u6TBlppISLvOC1M8x2OdPmVRdHJSebZhx0pkJ5EIss2dRgbmYt5I9YZbRjM
 bp+pHdefqX9sbIAsZOLgi7GO6iMDFByRSu4wy0zPpi7Bb908ba8JtXH5jaflGNW7U1RzgBE1Gzr
 DNQMt9j04pdEVLJe4WiUaYnA7UdioUNV+3BUjyzTD/Up99ki7Wy1JoHzPFYMxL12axf0tzKc8o8
 SOigwEQP9P9H4XeyHUg==
X-Proofpoint-ORIG-GUID: TIP_V71xErK35XVO1kOY2-JS_ERCtd3M
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA4OCBTYWx0ZWRfX2rgUUgq0jXmr
 PGsBubSbLaUzxEwiLhPIYYWk5viIBpW0nNPs0hR+jNlH8Gd1TjKnAo0ous6UAHQ+teJqt7EcQIa
 s+6RNJ8Rd2j2ZlERaoypfkKbkiUIlHE=
X-Authority-Analysis: v=2.4 cv=faedDUQF c=1 sm=1 tr=0 ts=6a9160cd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bgKrIEmzAAAA:8 a=EUspDBNiAAAA:8 a=lQJ2xDUnkanUC6s2uggA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=Ifulqbl_J-1aL42CD9IR:22
X-Proofpoint-GUID: TIP_V71xErK35XVO1kOY2-JS_ERCtd3M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280088
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 28/8/26 11:53, Thomas Huth wrote:
> I never manage to get this machine to a fully usable state, and in the
> course of time I also lost interest in this machine. Mark it as
> "Orphan" to set expectations right and make place for somebody else
> to take over.
> 
> Signed-off-by: Thomas Huth <th.huth@posteo.eu>
> ---
>   MAINTAINERS | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

