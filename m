Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E8ACA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWiy-0006W3-Ih; Tue, 29 Sep 2026 08:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWis-0006T6-Gr
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:14:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWiq-0002cZ-S1
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:14:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCE54d931721
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8PcgVB/OhOxxkqbKK8zX/9g6pcduO6zIG1E3/X0yW9U=; b=GmRuCgw+m6rONkTB
 h+MVhIXOKitZ6tEFnvrrPwVbYLh7bJwy8hKbIVmrVOelgcLlX52yR1o+ZjYees1Z
 OlC+HbfWQqbKwL8Ez2S6ModNRqfUtb8JFKshKqVwIOf6imPBPCK9XBd3ojaA7fz5
 a4h2ZY6koXS7bLdnVwD2pjFRp3BUs4LdOOKIo9h6u1FHU7RaLhXHZjlq56HkGo54
 kyGxFuUCAc6Y+lUAzv/UenQ3ycV4X2yPOZCLdehAGr9pktKWuJlnwbsjrEAr80SF
 hhCp/Zd0To4wyfPmHPlQju+mCmk3BVKN67eWoqnanyfbJqxLi7osPTrjDPuv0nZS
 +eH4UQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxhvqy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:14:11 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-988cb71802fso25933241.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790684051; x=1791288851; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8PcgVB/OhOxxkqbKK8zX/9g6pcduO6zIG1E3/X0yW9U=;
 b=AIyx7pWePn3jOcMXr1KS5lcm2svSLN2bZinmpaIksm3+sv1q6VKgES14fZPAJoADl3
 IdtSJxtmTjshI9f0ElffpiUj3dtjIQ6UDTPJ7+z93yZS2wDwBj5pkcjQXT9ZDfL4UzvD
 W+MjIOS+pS5RUz2xFMU9VgSaohUDsxVlNQ3u/Yb3wg7aLp83KZBDBvzQ5gSfibA4bCeh
 VyXzoJsVHeoEDyca6mcdF24qe5Zkg8WmpRMru+TwlbzoqfKnYhZDIk+elFM/ekwt2AjY
 3lk0DK8it6gk5g9OzzM7MaspW9+axum3P2i0xiSipIpbQbw5DyZwKAp/n4XB+5YNDgW0
 FVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790684051; x=1791288851;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8PcgVB/OhOxxkqbKK8zX/9g6pcduO6zIG1E3/X0yW9U=;
 b=vB2+unDv8iG7NN3HrOmCTkFK4HVBK3N077R0y0RlqC/vVwQbum0lRvN39ZJbi9dJ5A
 +94pEviqn5i/DZBYw+7y7kds7aU9lBWf4BNdULAUQ584YDm+dfXAYuhWPQ01qadbmqvl
 XfDYLRtFTzard4PE2r4eQ5c37ysXBmzBkcyIMR2+cekakt4lUATzKpuixDk0OXeK5Xwc
 IC3c2DVcCqGi2TtpjKPaZMtzaVng8Led3q5s0IQtc1n96ZPVN6Kmt9XPs1D2vbuzIBLR
 NCEKXtbHlRuKVznIXymrrk7TV7K4na0xPnzWXr5HgnRMfskZ7aMY5iA8+pXf+ebkhJjg
 N/wA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeegxUiz2Wba5tSvbjWsavJgdI2yEgi1HZ1I9+O+N/rgU6P3ictgp7e3RQMu4HMmXyG+pePhljhGCk@nongnu.org
X-Gm-Message-State: AFq9FYJySgx8qiqj0hRvlkl0qeBSkJNrlBeGNFbzqF/D9bui/BuITrbg
 gXcIiMixsVg+4+dHzrZny1H1PZItM/5BRxvHIykiC+4SEHYGuygO57FriGms6/EKhz2NVSkyO6c
 eN+eTiMip5xCGIXVci4CvHp4BAYu8vEYQNAZvQT64XEOUhW9s+tfhX2Qk2Q==
X-Gm-Gg: AYBFou0C0lZDNyJbdVvg/IohiP634wnRvTTZhHbAz0i1gq1xDFkDN7FTd0FkXlGV1Qb
 uFvcWDy1VOhAZ+08QpLxeOeBg4KC65Z3qz6+6Jpe5l7DANCjhV4tsS/qLFySfZZ6/zrH8QCDLl5
 B9BKuGUGO68wGMbMxby7DfLZzbY65x/PQY2u00dXv9eiipR4dy5KPRcmTAKkF+Vk+EPE7pDp6+G
 7I13pwXcUzThnatj97gDO9r9acXa77V2QdBptS85e2tc4YHUGxouDoqEZqGIiKVUct5LcW2QSTE
 6GODSFmMuB+Z+RhbxFRSc2hhjvJ2EPk6MVm8fJmUDp9BOp1UZcW1U4pBMWqL25tQGipci0zM6kL
 pEhADwnbbvdFOY+UeOVCa9i+/ehWu/wpHlg==
X-Received: by 2002:a67:e703:0:b0:7a7:36ac:b17a with SMTP id
 ada2fe7eead31-7af1e4f6353mr5257310137.20.1790684050884; 
 Tue, 29 Sep 2026 05:14:10 -0700 (PDT)
X-Received: by 2002:a67:e703:0:b0:7a7:36ac:b17a with SMTP id
 ada2fe7eead31-7af1e4f6353mr5257303137.20.1790684050454; 
 Tue, 29 Sep 2026 05:14:10 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00c11a9d2sm85583755e9.3.2026.09.29.05.14.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:14:09 -0700 (PDT)
Message-ID: <03a8bb81-5526-4bf4-994f-68dde5af87a7@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:14:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/42] tests/functional/arm: Add console test for
 `sabrelite` machine
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
 <20260921214710.29422-8-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921214710.29422-8-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX3cQo+7/uP5o8
 5vLlT6c8qPlACfdKn8GhJXv+G8lFeJRc+iPUB6Z+Hjr+t/9DVPNkYxGJoEFBIUQohI9jshRMiOp
 mAN9yZ43q7qqaJ8bTIoefrTp6cMuEQ0=
X-Proofpoint-GUID: C5BpWcEHxluPHvgEPmFpb8WWQfHKcJGn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX4JOyKfnVJ3EQ
 3XkYMRmZaFABtvOI/U0fuTivakWVM56SWq+WRYMiiqUoarMf/pqns8Glh2o6Li8q4qxOYVQSFsk
 74i9xWv/q/I/5HsPOGL7a7F3A0gv5zKIN5MRZMNiopy5Y+pnqkVHlSbYgFsndgvGMYayKtLgupZ
 +ZNszihb4p0GFUEmZg2bkUhiK79I42dxP+RQjDBJ5MVUKNV0yGWNNGPLEaLGLXnPgyWelHDyVdx
 uCyPFA+Bq+c5MLsT8o8U4Xs4n4Zww2OFFmTeGUfi03rR0yv2rquJBDfYRU4aLC6KRFiznYVDHR7
 wXEGu16Ax+cREHVBue3+n1Jms9dXFcgmJlsjvGZT1PguVyyrDO/J8M56r2bERUQyNEoSDDMflfb
 yTAev+/EjCAuEmPD1OZgoIFm8ENlENYNFmowFZx03MKZ8vIqoHwSnh3Z/eijuSR00Z/J0xs5zko
 X0AU1LEC59uDPlpWPtw==
X-Proofpoint-ORIG-GUID: C5BpWcEHxluPHvgEPmFpb8WWQfHKcJGn
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abbab93 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290048
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

On 21/9/26 23:46, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   MAINTAINERS                            |  1 +
>   tests/functional/arm/meson.build       |  1 +
>   tests/functional/arm/test_sabrelite.py | 46 ++++++++++++++++++++++++++
>   3 files changed, 48 insertions(+)
>   create mode 100755 tests/functional/arm/test_sabrelite.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

