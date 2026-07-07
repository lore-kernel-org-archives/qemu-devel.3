Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF2AC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgys5-0001CY-9v; Tue, 07 Jul 2026 02:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgys3-0001CH-Oy
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:01:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgys2-0006U8-60
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:01:27 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66748tLY2450788
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 06:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fJz+IyYVc+73pv+JUYxMYRl+IF0wOm0katyk+I5IyrY=; b=b91+r4dkI6PDoTKr
 IxGe0W+jiOV7Pn4auauF3nXWMo5tysPsDdOchrkh+aQx68gZ69s27ybLnZ+OV7lU
 /tiXbtFo+8HHxglPm+D52KuX6K4FZWaxqMztvoA4eyCZhcj2Hg1spQL15yNNgbIC
 Y2rDw5xb46rF0imdPj4Yoz1CYZH/yM+yVHiaySc7IjdF48BkXOqaptCi5d+WIKVq
 m5iCIMJSSR3UcD+jZjS+1B9RaSEasCkKkqbwjHyymZBEo52RFp8IDo57+BSm0wTl
 /dmgGLVeOv2nmx5OARuRf/a7DQmFFOd4Tue59y4aESOJIgWjKKdXweICUqsXimaf
 o3LidQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8su70cst-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:01:21 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d137a68so90421811cf.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 23:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783404080; x=1784008880; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fJz+IyYVc+73pv+JUYxMYRl+IF0wOm0katyk+I5IyrY=;
 b=hfBxZgE/s6l72McjR66+Qo93p3HsbOdKKxghXQJ+V/ejOAC4VFCzQXD18E1gnGEuYu
 V2MuN37OtCbjGRwj6te78h6KmTqx9VjuMG0Tl1xBL0t01Z1sBIPmZNRW7qc8wz6Yip5K
 HYUsoSgSdsJ7GEwufKbwGjevH8XWOXLfxcVw24UcdDrbrMQOMR5OuIh1FDFArzkMbF1d
 YBBtFLlHY6GgywWbCDHhizJxbFTXEaAF0mAJyrF87IW6ItRlnFn0CDML2cPkynNvSl/O
 HGcR34UGah82olq20sVMqQpoVfr0Z/nGd7GWuP3oItx8W9GFjgjVRIzSo/f9c6/A4yH3
 2tHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783404080; x=1784008880;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fJz+IyYVc+73pv+JUYxMYRl+IF0wOm0katyk+I5IyrY=;
 b=O3oJu4rl2NRBRyj+5xTNSW5iNw2djul7CiNtLCDm697dgkhaFfh1l8MqTjUMfZJHaj
 J1EYZbF23UGN6WRmyP4BL+z5JJ0X86ptNb3nsWoGZnaoqTS0z2yCsnmaOz+/tjWC6bFe
 M9glZbPtwQbYqfDxbnySl4JdG5Zn0MhE6PNtlwE7pm4TJSbfOruURe/4gLB/HS86wZZi
 dyumMEqFRg/ZFXGBaLWvsLscjVn6h1BQjjBHSgIVgsgshqVWj0AE1lzXpdkGB2Wlw5Wr
 Ew+1XVC7a5HxeO9x9zPeCIxiL+Ze+IN0P9YuAd0B130M4mtCZorftuPMYGtXDttqq2LR
 oAyA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrbW4DIf+jQxyQb65/6kAAWDipfw9iLZvrN/p2hAzqDlgw+p4t3nsvOXHH/bg545VfMWD91oYYH2B1K@nongnu.org
X-Gm-Message-State: AOJu0YxW+cahlyjgQgzVgLLo60W9NhLSjLWyFq6tL6XolelgeRTQGv3x
 GTT3OPOx8BfqfWhP4LKIwwjGylc5iQNKsi3sHov7Y8XnUGq2Mv04dy2D8aeQUHNKjUff57naJO1
 XWbrBtygut3tmd0LTeZ+TKVfeEICm3wYDAVIUTMH5e/JnMG/jqElraJ8B4A==
X-Gm-Gg: AfdE7cnYFQ6B9JNNPLkPkxfDKQMlBFYylWIngcOOUCPl69EaYQRZRvSlb/TrrvX3jFP
 yY0QKG/97OCnjVd+CMRXJ7UWP5PYmZSdZXQ+3R2821fRdgoFGhHZNYQrR9Xp9YZ1HPXZdbPJSG0
 9qyHu+xHzGCj4qIn+MRvMhZlVPq9P2s/aV190t3IUT+SeFtgy0JzxH2UmxYjTJoyngugcjwQ0Df
 Kz5pVflUVUl2shpX2lF1S+AzEPbVZMirTSeT/wO8iDxqIXsFaxZ9f1o3eZ8Ipw1Y2D92bfbK5g+
 FtuNKz9W5BYZM/IMouNURJ0Z2UhK7GAFnD6i5QYdgelDFDHUvJhOfrR4IO1uxxohLEHiqr1ZQP0
 1enh8W4nTRloQ7xfisdDXLbwigJYNnY964c1c6MRsyN9vMWA6fQczNnxBufktJg==
X-Received: by 2002:ac8:5e4a:0:b0:517:5add:e449 with SMTP id
 d75a77b69052e-51c747d8fc4mr41427641cf.22.1783404080341; 
 Mon, 06 Jul 2026 23:01:20 -0700 (PDT)
X-Received: by 2002:ac8:5e4a:0:b0:517:5add:e449 with SMTP id
 d75a77b69052e-51c747d8fc4mr41427101cf.22.1783404079826; 
 Mon, 06 Jul 2026 23:01:19 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f294a6sm59262605e9.1.2026.07.06.23.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 23:01:18 -0700 (PDT)
Message-ID: <a9a0fa5f-5e23-49ec-89a6-24e4d38d28a6@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 08:01:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/91] tests/docker/docker.py: remove "Image is up to
 date" info
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-28-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706223343.988769-28-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NCBTYWx0ZWRfX6I5gb1uG6XB8
 cZn0bcLo6fa1MjbktbwZIe4Sm/WWuIxvLYK8D7l80VChbFb51lLsuDESmuXUXX45x9OcJuqC97u
 v+JXGpYYu9hL9vX/v2feCzRrQtiCf27ZMyIqGKKDIXzfVvQRhfwzYz+KyWBUfNLaxNFOfTPdB/b
 AfSW0Y+ilOKyjMehbkt6ORpdUqvKatm0u3U6AjtEmjCNyVMAn52fZV65hnw3C+CChV/AZLuDeaE
 xr4TTq2+637rufCasSxWf8pBZjLlebHG18IBkDYTq89MytUF74e1OhS2eknDN1mKoFsAGejg6Bz
 EwGHjHRp8icBEg6mFluDS29sUZ19dlcuvrZcJ1YME8u2tWjmGzZNPUSZtR57ZO7qgIKbkrjOrcq
 bL9rMYaGCQPdpSjSId2lRmKN0iVJOH/PaTkQggnkYNQTWYEySbedlTWZCkyKD+isV9skmkR4A+A
 AoEs+LQ/MyPQNinlzQg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NCBTYWx0ZWRfX271GR4g+NG9o
 C4SsrjDJzcmC2MUVEgLU6lUnmjpuCVqIPK31xw7jG8KKOUY2SUTCXFHTOFQXIauYtJcbRpdv/V5
 PovA8hFsoGu5bTKtmJyuNkY/4urx6Mo=
X-Proofpoint-GUID: DleE9kRVSEsujBjzFpiqLC0tXmwRixhL
X-Proofpoint-ORIG-GUID: DleE9kRVSEsujBjzFpiqLC0tXmwRixhL
X-Authority-Analysis: v=2.4 cv=HN7z0Itv c=1 sm=1 tr=0 ts=6a4c9631 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=IoKZ2G59pYhk7RI_QmcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070054
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

On 7/7/26 00:32, Pierrick Bouvier wrote:
> It's useful to print build output by default, but not useful to mention
> it succeeded. Reduce verbosity of tcg tests build.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/docker/docker.py | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

