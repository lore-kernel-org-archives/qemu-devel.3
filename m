Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C84A606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O2x+6b2V;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xo3YwnAj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiMe-0005R5-D3; Tue, 27 Oct 2026 10:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLiMG-0005Ak-LG
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:41:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLiME-0006Xp-0n
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:40:59 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoPvO2397395
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kxyOYWTRbwfiRbW618G0PRIzyEARU8jmkqdOTtKKM48=; b=O2x+6b2VaYn++WV7
 SpQYp9kFHflpPxeldwrz1IVlxPZA34UJJBfWkALswBjkxeb8umlkvGJVhQkinyU3
 iFQXAIMa4ePbtzWyh5CPSz2KiX/OCEnWDAwofUX5NzqS/7ovDk+zdaQAivgKb0b3
 nfKk+7dbSrlgGN1KQkn7K2CIarmKAUi2Zuy7f6joF065WJhh28B/9a8fTbEVSi7h
 KJoDLcRO8g3HiqiYzzbQRWfYoV25HXeEngvKrbCUkNYxFzjHc1+64xStQy6Ua+Sf
 Q2aDTx4AQzw4zOIHarCwxJqCsO+nVHy4MytKcrldqP8drKPIe65ppzKOwn64CE5N
 8+nxug==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjst1h3pv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:40:56 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91c0f73807eso62972876d6.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793112055; x=1793716855; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kxyOYWTRbwfiRbW618G0PRIzyEARU8jmkqdOTtKKM48=;
 b=Xo3YwnAjnOzzXnoK8avueUK8oPJ2fUjdnVKEjDiDGCWjcELEahub4i5U9VdKkPPBTb
 GsHcJUC3n/p6YnGBRd05jwi48Pfj+pdQc1RQWDObgDdNdcaWHncExzxxzcGkTPURX3+4
 AEj81wu+hBoh+RY6acaCPvSNxxGb6YaCuYgXozjNEJPpVK09TKfrNiBOnKYObh87OeqS
 tbIE0cBFDaAFVGP7q52MuXXazJKaUpIWl19M/GudPLGK7bNLQtENA2CwpDTPMU44sXzg
 SdgjiJip5sT7vKFoo177RCwnVcZpe3e5fvoCM7mr1uKj4dFrlHmdX19J15X7yxjMdgJe
 XoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793112055; x=1793716855;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kxyOYWTRbwfiRbW618G0PRIzyEARU8jmkqdOTtKKM48=;
 b=itv1RIHHZiQUnkLJf/MkrYHRV+weFBHpKxcZboNuA/4UM6vbd3pzAlTuxoqj+f1fea
 UFmeFQv4Lto8hF0kxlX1t/aQt4SIhCmnKXpXDr+1LUNLUvIhdjjlFLmJgzzZ3Qe7iXps
 FWJmWHSQCMOAirzqoBhJf29mIXIOJevmqsSThsgNCc8lGL3G8Ww2EO08hmv9Bouzb0XI
 XIk3O/r9JS1ReQAwX2zxLf1ucdSQCKxiy70FVjhhfgFH3BJZUea9ybocQcfebtaZZNK/
 70DlWpIYiLMSTanRewxayo2wznvD8whvyRcuOqjf+gDzvl+thsESpmxyspsBeQwrivUF
 EzOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7GHrzqa++ToOqSjB+DmsQaQKGI1SI7jGLx4JXhZb9TtCOf/h6hLowJRfOnfhjdIbmqY5zOjFGHFtd@nongnu.org
X-Gm-Message-State: AFq9FYJyf9cz1nwO7efH0AqT1eCsWRbHubuCViAoSIxxRqVeTG5e3Xxs
 Iphg3egkGVGdLeSS2jZ43Y5c1rW5fYn44Cb1Nq9Xbx20gLiwxMCCcU2OKT6eGMcXogATlqqCHq0
 mW9OsJfEokPDMQnUvtPoZ1ypXyjvLxFyk3Pbc0Xcq3kLefkuu3Cu5Eymty0nU1C2pgg==
X-Gm-Gg: AYBFou1S3GcyQZolXSIEwpiHZd/icKAf/r7ysCql1k1fLsOC/WETIHi7bmxuBTcsBi6
 gfmq+7liU25cYSzUzlFiP7hwtHR+2uW7wKeJpHYY4sGodP7L0hMp0ujJlLPMyIqOXE7jjxAkz3u
 VXoHLB+xCQ9wObPtaJO87DFWx+VCwUCkgFmbZ1fDGM0MxYkqmBV/Qhbp5ZZ/1ntmi84qJZ7cyPM
 XcHXrrVVFCvCR0ia6NBkJx83xPSkpaqXvGse+acl8r9zBTtlI5tHlegEikQzMafp8w6tmmA1f9Y
 AQaah9K/uQfSgQti64ghsWQOhCTxO0B+ffkR3DED0tHKlC37BoX+J+HUNaT4SezI5GRjVhM0Oz8
 b/ua45wbIbZjPq0VBQrT2+mvHmbf9KxV6ZbWrUnTWGg3W/R7o0A==
X-Received: by 2002:a05:620a:6841:b0:93f:a7e:e0f0 with SMTP id
 af79cd13be357-940ef9dfd13mr1395721585a.82.1793112055053; 
 Tue, 27 Oct 2026 07:40:55 -0700 (PDT)
X-Received: by 2002:a05:620a:6841:b0:93f:a7e:e0f0 with SMTP id
 af79cd13be357-940ef9dfd13mr1395717785a.82.1793112054574; 
 Tue, 27 Oct 2026 07:40:54 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a59d238sm259945225e9.14.2026.10.27.07.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 07:40:53 -0700 (PDT)
Message-ID: <f2582baf-1d7f-4a5b-bad0-f2c3fd82a7af@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 15:40:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] hw/sd/sd: Add buffer argument to
 sd_blk_{read,write}
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Christian Speich <c.speich@avm.de>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20261006094447.43491-1-shentey@gmail.com>
 <20261006094447.43491-3-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261006094447.43491-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HJ1WhYtv c=1 sm=1 tr=0 ts=6ae0b7f8 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: 3hrOEJQL8KRag277jt80w8bT5909ogG6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX4f8jndv+JBuq
 WWpQWDxWfjMUOGCUj00+grjvI1GFgy/klNUsAHWSlkaaNafDA/6eiOgtJVkYhcQfS9tWrj6ZTCD
 zUbsP6CPo4lW8ZQ7zwydpNJxNDLZApE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX6ARJe224pNcy
 O5TiMlPv2Tq+2fj59w8wIzQrJIImS8RiPunPw5ELTlD0lFQ6rPNtlLwPdPNVhGjwFUgnO3qqusj
 7oxqdfeZWNRGTYVeex8Piru+W08Xd3VlBD2I2wb3IV84JppUa8RmcilcDJBRTPk5XMx8U2Z7fYb
 WA/gF88gr/jM0vLDC9Tasc3PGt2bnUz6I4i+0ApxAESlah/KZ8/VUHM7Mp+EsvhWH8gcpN5fEPR
 BaYLObkbqHtnotqGW4HueInn3cmQqY0ai6/IchtTfM0fxzMJYI9YzqcrUzsmoEWgPBKqKba7Ypm
 cMjrAoMbEoGLo1NZqt+kOy27k5o8bDmEHK9GZwoaVAi0qPTsxa85dLWsTgXNDExfj9fX5ggCBbp
 iq84K9MeASp7h9+rESAGnVbbqfJxaDTMXSp8Z0s1w5PmW1szAUpFiE6ZvF4ZfDZRcuinb4X1WxJ
 VlMFe+Q0/grSwHE44mQ==
X-Proofpoint-GUID: 3hrOEJQL8KRag277jt80w8bT5909ogG6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 6/10/26 11:44, Bernhard Beschow wrote:
> The next patch offers to skip the s->data bounce buffer for CMD18 and
> CMD25. Prepare for that by adding a buffer parameter.
> 
> Rather than introducing two new wrapper functions, as in the inspiring
> commit, the additional argument is added at all call sites. This reduces
> the number of helper functions and matches existing code where multiple
> sd->* arguments are passed to sd_blk_{read,write}.
> 
> This patch is inspired by: https://lore.kernel.org/qemu-devel/20260417-sdcard-performance-b4-v4-3-119e66be10c2@avm.de/
> 
> Inspired-by: Christian Speich <c.speich@avm.de>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/sd/sd.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

