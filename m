Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AE3CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWon-00033A-Tm; Tue, 29 Sep 2026 08:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWog-0002qY-2n
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:20:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWoe-0003Ju-Jy
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:20:13 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCEWwR265398
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZuekfKwt877oN9OAleZX0XVsjgv8QM7v9SrBnd7hDhI=; b=U3/2pyMhaEiNPLr9
 yGmQvPzIHAWqKGwq4fuB5oYfEf6HzQDRXWjFf/UQ0RXhqDip6Bb1yv7oNwvWdS2I
 hYaeHsTJVUYiIfMwueRMz20RDOhGbka0ixt/Pu70fOrJiNLOKRGN2QakMHMULpPE
 4wIEZbhrXoh2xjqyYuD7P3S10ZVcPe+zvgpUpshEIiVO05Msmbc20AdsYyuhtHzo
 c7NFgMCP6/qRVPTD1Ri/RZX+wV6Y4czVOEj5J/6yg2YNB0mGOXh+08rJC9KA9EAU
 HTc0eg+AlVyJfD/UEMW9QHGqPTLpKMxi1q9l/6ZYe9lSmsZAQ9syoV74KZPbM3LD
 7h1KOw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h01vkjqu8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:20:11 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7989d8ef4a6so553339137.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790684411; x=1791289211; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZuekfKwt877oN9OAleZX0XVsjgv8QM7v9SrBnd7hDhI=;
 b=bZg8G8u+MFK9SWSsLaeFlwqOblc67EZk8gcQ854aSwyFldqmTWjENqj9cXh1IaSlRT
 c4/6jyD5VNw622vAnGivqyLBb+QngSyl1B5fJTUeoWMbmeHpjQ5OSrVGR+AWJIoInCwz
 BoJtD/xRVztfBX12LknqyU+JKEIT4MJnagqWYnA1OQohsiYppb6VE5RVHdQpnXfKaFOR
 4w9hnYeloih73Q3t0QPcCGp3918rOBcATJTOYGn7W/7WL5XvJq7BM7919iEXJaEQN9MZ
 6k0QgO4inExGjd5+p6rZR+MR105GpOlK41uZfb94H8Zn+rxXcWlwCuLNZFNobbciwMjV
 uNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790684411; x=1791289211;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZuekfKwt877oN9OAleZX0XVsjgv8QM7v9SrBnd7hDhI=;
 b=rjwJcz9yHsI/m93sRodZPntUF0GnbvCwyMJzuTxCyBi1QvEESBJhN+SVuvdJRPyW4g
 KCMt5QUPAL1V34k0hrIPA00gEbfzAJghld+hMp8KW0kBugDZuT9oXypeJK26VZjvG3ai
 8szcW6fAXGcwbi9Qrdn7+Ua/qfiQBuPXaCj1wV9iex2ziw1fp4OzqRyVshvZnXX9q7Ty
 zxKPQ+lpHB19l3XsVNRtR1hR+dHbFSLeEYJocfqnHpxTKnB5IrjWXV+VDTkSrrGgKOQ9
 8LxrbB4eJDawhd7SWXw9l5LdlmZiMN/jo9/PsR/9iKVdHAqkCX9y84/2kaD7FSsMNTmg
 cXhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwK+YkkujFTVbYvSMHJa9nzPZjF6KUyqMd4ZtR+eypUGkZJckmZtpndwF00wxDMsPJVBrEgvzzW8aTR@nongnu.org
X-Gm-Message-State: AFq9FYI+Ne8MsFKQxEz8r888LyXyiIg1gkA3CB5QHYNkrK29UDx70bpk
 Ny73MvjTX0kw2M99fc3zfZZk2SbyWHXnlI5Brxv0CwBKMrtmOY3z86Qh4MeVC+4Uj6SHpOX5qxH
 M2WkxbWzmjq3iLkn+7CDKov+/9yFdXzqLlm4/eJ6BiGW0eFyu/4+oWMWPIg==
X-Gm-Gg: AYBFou1nk3dWLUufca51Z/5bbBnjxVrTsT6c0VXE6cQohz8pTfbVAZ/h7Ey/ULywbNK
 k3P9yedIYweTsS9vstqtB8oHSOxDr33QFAQyuABzw4i7QxrkWZwqQxEN+4YIOWfkNieH/ce4Si8
 MPfj3yPIAhZsq11nnIECZDZyjTDEVRehDrjfyM2JO42ePSqIovmb4Wri/ni34kIUXW0v4r93q9b
 LdqurRER+ALFENu33XaoR6L7bAopeuM/BUYrYbin2zovDL9A1uNQpEN2TY+Skf0C3P/PtpvgCK4
 CiU7gHXV3qRqSeVKFFpeVHIKYwjZGVyfqpmWD0laO5Ory1fhyEjuzGOTx84joARotANJ8QVr9Ed
 Rfz5b+TU9FHqs9pzrzZPhSgRdQWYun9iruQ==
X-Received: by 2002:a05:6102:8489:20b0:7b2:7490:fd75 with SMTP id
 ada2fe7eead31-7b274912cdbmr2300002137.7.1790684410547; 
 Tue, 29 Sep 2026 05:20:10 -0700 (PDT)
X-Received: by 2002:a05:6102:8489:20b0:7b2:7490:fd75 with SMTP id
 ada2fe7eead31-7b274912cdbmr2299983137.7.1790684409991; 
 Tue, 29 Sep 2026 05:20:09 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af509658dsm3230573f8f.32.2026.09.29.05.20.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:20:09 -0700 (PDT)
Message-ID: <0bde2a11-a2ef-4b99-ba2d-e8bbab4dd880@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:20:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/42] Kconfig: Extract config IMX_RNG from config IMX
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
References: <20260921214710.29422-1-shentey@gmail.com>
 <20260921214710.29422-23-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921214710.29422-23-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfXwBPSG1fWP9Xh
 Wymd14inVL2QgZJiXZGZxl32yrtT/HCgdHD2PLXSVS8pcc1FtjaBT6eOGiI6jvcb789R/jsp+HA
 6QZugvHZlZv3xbisOxsOms/e/DAMSk0zEM4JLkiSRnLaEtBQEBIxswXvb6c+e6V3ZVSc9Yqhl0J
 NrZdOQR1MVUhpuVvmIcQJnRVzIxO2JDBj00WSu9+sotQIgfvFqCZ9ReCr5cn4qF8+OYFEIyPA6K
 evoyuP8XYaHHEmQfSO7ex8BObteD4UCwjgaZpxMBWhyQTDBHTuUSoEdP7AUDSUeaFGPusWCbeyp
 A0yY2NHOqm6oIi6DRkij5IS7mEDj6jQrUhAijaWKTHkyBm0ubpZ5Sy0g1cui6S1xAK1xThADQaB
 PxexNdpOGBgWJykpDwjAUdRlMpgXiZCflSDtGwb5U1SdVvxnbcUOWBsqcQDnXBgG66WXjWSigE9
 g/sAPtWIth5NsTTdX5w==
X-Proofpoint-GUID: 9x6z3t73KCNWv83GsC07EHZdPzJD-SZt
X-Authority-Analysis: v=2.4 cv=VcVir1p9 c=1 sm=1 tr=0 ts=6abbacfb cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=lY-AFCGOYIL7-6051IUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: 9x6z3t73KCNWv83GsC07EHZdPzJD-SZt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfXzfjpUc0TrgDQ
 p48h7hcIZLq35B6O/bkbrbkgbt9spe3uVizun3KtBND5mgaRmAOr12utiAIrsXFh1s0VodQKF1Y
 Nk6RB1QD7EV+XwRfX54pjp105q5yeyA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290049
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 21/9/26 23:46, Bernhard Beschow wrote:
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> config IMX_RNG to eventually eliminate config IMX.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/arm/Kconfig      | 1 +
>   hw/misc/Kconfig     | 3 +++
>   hw/misc/meson.build | 2 +-
>   3 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

