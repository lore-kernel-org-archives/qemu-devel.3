Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8E3C61DC4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8eB-0003rX-E4; Wed, 26 Aug 2026 04:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wz8eA-0003r1-JR
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:06:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wz8e9-0004fV-4h
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:06:10 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q6RuGZ451448
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GNIgWYJEBgzV5VenT9qffCzQiVrTpag1cKB1YFTWaQA=; b=Dj5FvgSIc2sQF8XH
 OjnehoEFQJH9gt40ynK7FGNzb/ncJkhduoc3C9xjxzJt6XugIk7GIUKspsIusLq3
 qVOqC5Zlff/eS+KT+UaPSSCjqUxh3u9A2twe3HTOQXQEeaX7PiP191tx2uON/zlw
 qZLmvloMbm+Hfvp4ICM2FbPcOKsBrmOkT8sjMej/rgNxmJPa85Yi9c8Ks4He8Ooa
 ux4q//4xHNUv4nBjtIhmK3fQV2/WPabWhyNOxn2qX5IbUW20IWi5X6QP00brkwip
 G1/J0Z/I85+80+k7XU9LDiVS73hnzztd/Ia+VP9CRUSM3BYlNyxtN59fdzuL4E1b
 Wamp/Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r1gh2kk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:06:08 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52d7b3adda4so7314391cf.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 01:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787731567; x=1788336367; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GNIgWYJEBgzV5VenT9qffCzQiVrTpag1cKB1YFTWaQA=;
 b=MFZkKrtFdIKqflgdZ2wOWmyd+dsforSq9gMIe6e1QDrX/Iic7fEllDNsZI/Bo38dAz
 RmKGKmKobGLuO4zlUrALUza0QElBksBKQDz28+fzopzcT9ZA1/WrNYEL/vnI+BfsRjcS
 0S+loqcvsACh/+ze66PYzf0UIPNb0lZWxWNNSrZiugfg/qpDnotKuFrciYdO8OOTwJu2
 097F/SxfAaoXYwILl19SIMmtygsGG5VSIRIP07n7ay+5T+PT3cmuAtwxoETJVbRDsjmL
 HGN5OOkLbOBGRXTsFnTDbfkVjSe/46e5uVq4vw8hPAyti5mw0B9lKXo6efvBuY5VYRtf
 3djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787731567; x=1788336367;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GNIgWYJEBgzV5VenT9qffCzQiVrTpag1cKB1YFTWaQA=;
 b=RCneQBBHR0hNbWp1ue2WDRq75IkAVwT3QNGFPaJVw7oF+R8rMl2LcPF1DjCozYukOq
 h/ZqtdEQIjl9mvNyVATkQB2HaBQLhB2FHgLV4ctxVTufhhbyCAcXCkojOXh2LvlbuAHi
 03+/GZBEMnOq4DTvg4185x2zI8NHG/G5ISEx3SjE8Q14eppHZ8pI6HZ8M0Ijj6jyqEZH
 kQDszfLoVBGusYJT+ftvTJ2wAOM+YqxHQDvD2v+w0HcGdnphf2EbbRzn8E9+I1pKG5LY
 jElT2uzB7zdsHcxoSPsfTI8/BYuiXChqEkSo2iLxxcPfRarwKp8XhZeafDKaz0BeOwZ2
 NvBg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpzC7E7fy1kTOR+RWZ33/5H/EkWp3ZUTbdFEEF+3a+wCRUfMU9usD9PCy8T4JAEQNlibu/R8CALUn0V@nongnu.org
X-Gm-Message-State: AFuF++k5oyW3rkRTGqxLI3Okt8TG1ZjdnySAGLcmrRWE87fHeameA33S
 CwWMsG1jKuepK/qKXWo8MYm2GpKWAmVKIpkHRskuDvJ4K4zocNjiH1nmi50xsc3l6C6Rp4HHHDg
 NnyneOqJMHDShcjHF1KSuw+hqWoiBmKHs3Yxk6wBWLMsG1FYKa7fmQjXvwQ==
X-Gm-Gg: AR+sD13MxvGtdl7+nJuqd5quwCCb/6IJk4ivHuzjM0VsNNh+Yv4NU5ZPV356bC3fEet
 42mr3yZ4LVJ7XeEfTpXF17hEPbBCtLCql/zH3rLIWKfgLJ2NYtVhNxvJEEMAZOsBQlCjJ3kArWu
 0E2t8UPTW6QaC863mMp6us8wtKqmctQqRIf6kuyMwEnlyOFePRJr1FekZ7Q4sywppy/aHilB190
 UyBbrx8SY9PRBIKR2sqXedeDNbEbiLpUJ83rSEPP8fhjY44KqdnTk2wqOPHlSelekU0dO3WWn41
 AM+K+nGlpRtRPPV8CgABIv2ZQ3VhLbLr357ppNxGz8YfLwqvIgl/DsILI7TPpSZp6NLXWhud7dz
 po6raKSk1prGi2W+jYY5duTPp5RvOreelDA2JRM36zrU=
X-Received: by 2002:ac8:610b:0:b0:52d:f63b:94d9 with SMTP id
 d75a77b69052e-52e4236fdb5mr46691871cf.30.1787731567456; 
 Wed, 26 Aug 2026 01:06:07 -0700 (PDT)
X-Received: by 2002:ac8:610b:0:b0:52d:f63b:94d9 with SMTP id
 d75a77b69052e-52e4236fdb5mr46691491cf.30.1787731567080; 
 Wed, 26 Aug 2026 01:06:07 -0700 (PDT)
Received: from [10.254.188.74] (14.89.66.37.rev.sfr.net. [37.66.89.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28e8499sm1936107f8f.26.2026.08.26.01.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 01:06:06 -0700 (PDT)
Message-ID: <ba77f671-2ec1-4b73-b2b4-e857599a5822@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 10:06:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] hw/arm: Rename ax3000-boards as axiado-boards
Content-Language: en-US
To: Kuan-Jui Chiu <kchiu@axiado.com>, 163wangjack@gmail.com,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <20260826074635.2850931-1-kchiu@axiado.com>
 <20260826074635.2850931-3-kchiu@axiado.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826074635.2850931-3-kchiu@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QSbhPCGFChsIVuitUFX3AsZjCywYHoYM
X-Authority-Analysis: v=2.4 cv=FPMrAeos c=1 sm=1 tr=0 ts=6a8e9e70 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=JQZmDyB7+sUo+n2VpL1TLQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=440cDlBIAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=d9D1X1bx8dWolqnE4HNT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2NSBTYWx0ZWRfX24K/Ww4lYUqp
 WzCczSqZzWlLtJ0qffJ384xBQzKqDOqKYmqR+tgsD+tTpp7r4wsxiiur2DxDlDNRrI6Zsq4aLCG
 O4pTxuxlMqo6/uOsR+56i/mDsLnbXuY=
X-Proofpoint-ORIG-GUID: QSbhPCGFChsIVuitUFX3AsZjCywYHoYM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2NSBTYWx0ZWRfX5W9wtbTd1v3I
 vbpBsU/HavnE2yG3+ZOH4bOO4zxr7ukumn1mWSXdlqtAMtNjwar75xT6C5fYLrR5SvzENAHZDdR
 mpdnlf38ldByKs01+qqnapsVue6Ujaf85l6OKeZxmTWe4bO2jQqOduQL8mSWm4z1LebGzj2OiJ8
 Mh52CdYu4irCGhKKMUQU/5aRw1loxuIx4NJk1YZkcpxBYR2a2nlghSed8JtFFCg8AUDSQDDkMLO
 Y9/oab8kAl6csr2dWYMPrEZMvOfDmNH+lCDfENsvjXIUf7lQQ1NhZYEHzyDJESAusLS92A5RZOp
 PWqa9vAl8Xc2/NTA9ZzSVSndWfKivZ0PdjzqVMlmQ0tpqZ8DptYQxRRoaD8GtnS1+8s72LJWP3m
 l9pATIIZxnn9orUsSXo9RMkVfe3SO3IV1PFoUE5NujZN5gSfG8v0ZrrQ/E9KWohoO1EVyDcYk3T
 nkrgXA6CgD96KTk+H7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260065
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

On 26/8/26 09:46, Kuan-Jui Chiu wrote:
> Rename header file ax3000-boards.h as axiado-boards.h for sharing across
> different Axiado SoC series
> 
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> Reviewed-by: Jack Wang <163wangjack@gmail.com>
> ---
>   hw/arm/ax3000-boards.c                              | 2 +-
>   hw/arm/ax3000-evk.c                                 | 2 +-
>   include/hw/arm/{ax3000-boards.h => axiado-boards.h} | 0
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   rename include/hw/arm/{ax3000-boards.h => axiado-boards.h} (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

