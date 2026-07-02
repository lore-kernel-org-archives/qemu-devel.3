Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715A4C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfGSI-0008RQ-Ii; Thu, 02 Jul 2026 08:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfGSG-0008O6-Md
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:23:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfGSF-00006M-70
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:23:44 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6628sTmo4172791
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 12:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CvdR7H4wM5hxDEsVoGozeURPNP8zWTfyL/fabghl30I=; b=EPmocWiOPbmESckv
 b7ksGK6BBtGNEBUQNKibT7M67PpT4js+4y31VyCvNX+N5nUiaCO5+IzGuFcDnDBp
 HadFRQYvUqbj4YpSk6zTnV4WvV3jLINAJ2ea1kfua1NbVVaRYL/OwHps2+4nzYN7
 WmU0aVEvvASRJajsbo6+b00UsqOGegSy7MgZd4s0I7NO7BhSmXOpbbJVFLgtNGAA
 WPPyJzZZ+LJOKG1lkSK/pYjufi27onbf6ll/WFXg5gjNsYXazOc5q3PbpUDT6QVZ
 TN+fU0uJjNDDvh8BJ/IWAgTpqY/cqRrB2JSKqgSHHburpB7M+x790rQzF+LVIlSj
 fiRf9w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5mvwrsug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 12:23:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915f6ff639aso287238985a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 05:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782995021; x=1783599821; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CvdR7H4wM5hxDEsVoGozeURPNP8zWTfyL/fabghl30I=;
 b=haRixW6+BHqubp1nXvj26pzvTjUXzp4Dcv3OkKBuyYdIwaAonua2JFZeWHgm1vK4WT
 DCiIXq0uhDouIlWNFFbBPDMV4y0czXVS83NNLrIeJX2MCa2pZkj2MCrB4LrhPI8HVDhv
 f4Ga/07LMZCfqfVFLDlMOnILZU+Hr6UsqsYEsZzzMd1ySLtpbRdXONEerggfvVOzDUYQ
 7jIb9HN2FSfxkhgb+fqK6C/JXbRYSaq7KWEL/bDVjwNK4oxALDRdUxLOKnMA9DsWQRBz
 Je3FccW3833rjO1h4u09/ZbWvSB9v51cdhjkKNFoYcP4fE52hIkl78AsCV5K4gtoqyL2
 na8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782995021; x=1783599821;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CvdR7H4wM5hxDEsVoGozeURPNP8zWTfyL/fabghl30I=;
 b=FVVkjgeim6k7UndQRG6aUUeZxx0OS7xb1VqR32rxDjWhpLEZpHRjiHoJ1rMOBLmqKb
 QSQYGI3WM6rcpQzugFwN8qNgDaLc0HCdCFA0uAixK6tcAiWLfPoxUi04bbfUa/Vnw5Z5
 ChlK2AvLd+RyOECpj3zl/3u0t/S6PiCMtbFKdBN1DzAe/xIZ+PSHSEddSyBlmqo0bT4A
 Hg8ATwcGQ6B0j0ltOTx1k1WaNPx1M4ymIwrrHI5m/i9/gkpU2D/atKTUBFJusjyuhk6u
 VU4Fyv/t1n6D0Tal56j9KGZ5p+Z4KMYaSc29IE+8PMirRJIVBb7GYdlwOLl2dkYnpkgw
 hirA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qw78zqYOL/Hoq0NkvI7pOMvt+Hz7++TW/pnX4/0yj2SvJlyq3ZQlcg5dzPq6rzwRFNMMBDKChx9JV@nongnu.org
X-Gm-Message-State: AOJu0YwJI+NNSEXpncffEaPMW8ldH27m1ELSKwWgSxiniEMQarZA0fb6
 L+F7DHMe2YZmTHy0Mzu3XUHta2VpMP+m557SvHN5QVItE4Ms3eB6aYcMxcg7D1bib663WpXyOwX
 KIeov1lJ3E30cFwDeIETZzQU63CzTsh2aFLkjZbpP1TIEQWCqEfAeCiCwUg==
X-Gm-Gg: AfdE7cnpz/xm5bU6pvr29DqXjl0AqSZsd3GEcXbvr+6b0cX8SJuuRLkezUogIpBvKUo
 bM8aj/v+/ue0P+yuTIxHcJNFcIvFjob8VvohSzmPSDFhEqKjg+od72/0Xya+UueVxjOzo/L244I
 f91Ix8cvx4jPQcjzPUM0BuHn0E+Z+z6I9ePFHrS7ARz33ZxZjHxhEyadDfbJftvPv/CRZW+9mgj
 ISpUBaHDGOgo9Xr4zFlowy/myHpWRJWdLLjj1iWymdINElMyGW3wuKT2ZuEubBazL1AHMWnDwIq
 kwqfh5U2L57asQMyQ1Sy/HPoG9AjSDPlsmpm93+2BJ2g2B6oVx9MvSmr1Jd391ac47sRlbNRJQH
 +YRVEtDjCdWq9NcZfxx1CzS/iU+xTQKYG5PLj5HFc/rJIpSzmINcWjYHbNZvuHQ==
X-Received: by 2002:a05:620a:6309:10b0:92e:7d7a:108b with SMTP id
 af79cd13be357-92e7d7a11d8mr404763585a.50.1782995020948; 
 Thu, 02 Jul 2026 05:23:40 -0700 (PDT)
X-Received: by 2002:a05:620a:6309:10b0:92e:7d7a:108b with SMTP id
 af79cd13be357-92e7d7a11d8mr404760185a.50.1782995020427; 
 Thu, 02 Jul 2026 05:23:40 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477ddf0f27bsm8331816f8f.30.2026.07.02.05.23.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 05:23:39 -0700 (PDT)
Message-ID: <310ab638-f574-484e-acf8-ccdb49d105e1@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 14:23:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/arm/imx8mp-evk: Introduce FslImx8mpEvkState
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Matyas Bobek <matyas.bobek@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260701224612.48342-1-shentey@gmail.com>
 <20260701224612.48342-4-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260701224612.48342-4-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3t-Q6SrJbPv_gVutkmU3biryoa2vh4kk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzMCBTYWx0ZWRfX0w9gKyLSdIu/
 e7QVQbvEZQsO9sFFi774LDlGWT8KXVK7FPlj8dx91gtYT0iN29p2mndh+GaVogyAKbyxeoFxX+U
 VvF5O/WyEuc5vQoSK88NV6l5/YOWK0wxhThi5oSZQy9FzM+1aQX3eNa9Pqcd1b6YGq25P8ly/qN
 z0C8Zs8Zdd7JUyuLOiyNOhsFS4qQizRqJpseGlp+gfJ/nY7iPFMsA6ub+l351YDBE/Oia3suxog
 AoDmMREkPNWIAocmJgYDC5rngNcBAvuAeJ5+ZNxjNgR9yEX1Ge8uwlAnjmPgoXVazV3Rx/gqAp/
 WruF5cj0OzeysWJ/BXRHJ1LwlxJHzrtsG8If7I/pqR9hLQSRluQHF7PaGnq5hzq/yGoo8VxeEfj
 DFs8/NKShEOLf1mMpVZFlwPy4P1wUCY026thAI/SDqYyOoYqjsuCm7kjXPc9yH2qPRh8iPF4F/s
 wWl8ahDfeE2+7C3xXSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzMCBTYWx0ZWRfXxYtpSyCTAPK2
 htZy/FPnUk0NF2jVenPPacFf79VLSkJGMgZkhSWjVcMDA+L7EN8Ick4yXPSwEfO03D4GZAA8gXe
 8wXq5uN9rUhwXi+JPjOOpM0MtZVIhAw=
X-Authority-Analysis: v=2.4 cv=N+UZ0W9B c=1 sm=1 tr=0 ts=6a46584d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 3t-Q6SrJbPv_gVutkmU3biryoa2vh4kk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020130
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

On 2/7/26 00:46, Bernhard Beschow wrote:
> Introduce class FslImx8mpEvkState which will be needed for holding
> CanBusState attributes and associated properties.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/arm/imx8mp-evk.c | 30 ++++++++++++++++++++----------
>   1 file changed, 20 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

