Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65315CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xESkk-00062u-69; Wed, 07 Oct 2026 10:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xESjp-0005WN-3J
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:35:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xESjn-0001UA-2Z
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:35:20 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697BVNAS2364098
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 14:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WS+7B8EhKgR91/U78IbY1HcJHNLyIvYm9+e6clb68f4=; b=KJ1EWhZFb+gHzcGO
 PA21reZGNq38VU+QerOOiSnWwb78ESlCoFucqBo+DlkqM7AZVpnzPFtmn0EKXyES
 pb1NYxshwLyC0YxVaTiUqsd5a/RyB7VJdtzE5r3SVJNDwhJ5zyv9m3M00OB2gQDp
 Wy8aQxCFSK40HRs2pCAXsO6Dd9cTt7LvLh7oxnM3ra6PdozYernyqD1XSQFrS7uK
 anxjmK+e2GCy3Ed9gQFTuWHrFx4oFXlXnTB7VjvcpZ4+lPZ2134Mbc+CUKi/HX0j
 JU3mOWQqvuHtQ1GQGDBQo4ecidBOzhAEgyqDHBNN+S1KyqZvEBZWusotMSxYuGl3
 WJkU6Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fw8suw2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 14:35:17 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3510d0baf63so8289732eec.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 07:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791383716; x=1791988516; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WS+7B8EhKgR91/U78IbY1HcJHNLyIvYm9+e6clb68f4=;
 b=gF0QpvS135qOpBWafaSbTZCkA9unkmVq697072XSZ3vWpQ6RyDqsu9+GThI11pFfvj
 NWMOyFYCl/rimuFoxez28GVYJPvRLE1xbcgseXq76NIsdOtoQE8PA/0hb4xl5wAYqOks
 HaX9RpUxmCHddjFZuSEKurb3E+oG5h7+L/RUoK7HrzSGP91uj8EYJ9O9gHm2vMwgoK6U
 I8caMXzdEdlvLmSEhQ1fA8d/Ty9Oz/rSWF7PySlrYk6bDeJdAQSwcFpvX7LVcU5QCe2L
 RyYwmUbxNEz2FmKAip92Bk2OkFfqJIXLtooJLr1LLWNdCaYfxKfZuV+CBsnfH7Lp3ojd
 XgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791383716; x=1791988516;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WS+7B8EhKgR91/U78IbY1HcJHNLyIvYm9+e6clb68f4=;
 b=KtsTCOf92nzpDmdctUjsMeKOlUHXFQa0MOapPOARV7rn9U/niIn1hdovf8fo4epVtf
 eZCRhMuXpy0LeyCKVc7H7oC/I6XflPqRR3f4jKZFOvHXS3+hUw5Z8uvaFyTVbQpZcB+A
 6+hK9HvhTBbdDlKaEYSpGnGokZj/kFCwEZsHZvK41fQhYXDHOa9/5wI+RSeMZpUOSTJU
 JybUNC/7Tlj0OM0GpfVd1HUI+XtZ05a2mLfyecdJ1JwHDR7gUSWtugDffL64t5EAQPZf
 aunVVPuocaP/Wo1dDkcMFq3D31gIsyAqOwkAOfHJMzyqES5B4YmwIVxNog7h1OnJr9zX
 o5Eg==
X-Gm-Message-State: AFuF++kMWRgHwiTb7RecTmvYcyG23V5uue+Y/CcltWpf0gI833trrOni
 tHdQCb0YQIS9l/5znXWGle3J72wjKc4ThLlbLqf698+bRb7Ul0m+rYVI6xjkn/DyDIokleXYgzd
 yf+0oZFpS3NAnA/+O36S/jv6Grw0OLGNETbKo4f+d2OVntTwqSrkNnR2uSnI13aei9A==
X-Gm-Gg: AYBFou0K5fxo3SkY8+efqx7I2g/EfqbJA16kELh1nmxKoopPdg4uWyAblklej7/4cG5
 PGATjXm32Qdwt4avMO0QqGABHVmRPfZxfO9Zo3tci4je5BzBCbswwAcuUa1rg9jPm8bnI6r5UtH
 VCjmo9uuGNe8d47gzRD2Tpk2gChDDFjcE4qTLav87iFzWiHwlW9BjkKAI9JAzbYbgD4ukPd2ht/
 LY9F8+GZFvdDMLBaZbTXOcyeJb8KRfR2cpaidfv+pMUOcL5hQIP8HFZ+offbF0qurNDE00V34Vd
 JfdMHyG8V1hzc2+xaxbGasbbuqr9XBfbZL84oRdPUmEBeUqQAaX4ch6nYxxlBFebAG9+piAjcV/
 38geIwIVxkNzqAyJRQjLYgenxiSFFfq6yWMWNIPtbiGDyAzp8Rq5RHyxATaZ3IcC++4zZiw==
X-Received: by 2002:a05:7301:2124:b0:34b:d8dc:430b with SMTP id
 5a478bee46e88-3515def9611mr2289441eec.24.1791383715888; 
 Wed, 07 Oct 2026 07:35:15 -0700 (PDT)
X-Received: by 2002:a05:7301:2124:b0:34b:d8dc:430b with SMTP id
 5a478bee46e88-3515def9611mr2289405eec.24.1791383715065; 
 Wed, 07 Oct 2026 07:35:15 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515af26f10sm9117302eec.13.2026.10.07.07.35.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 07:35:14 -0700 (PDT)
Message-ID: <a7d52187-776d-4a14-82b9-80e15bf12fa8@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 07:35:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/21] multi-target: add straightforward architectures
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1OCBTYWx0ZWRfX4Re2pt2OBi7I
 PnonV4eufIpZkzGk4QLi+16f4+3BrbfrFB31JJnBvVBxXcshC13jHZfMq5jerAJUGNRLgibHS/5
 qPL6THOUoX8YNq4VcEohNrFIR8ezp6E=
X-Proofpoint-ORIG-GUID: 58sh6n_wOs2LEPN4JyaFe1iWL54AEfQZ
X-Proofpoint-GUID: 58sh6n_wOs2LEPN4JyaFe1iWL54AEfQZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1OCBTYWx0ZWRfX5feG7L7beJn3
 HAUvCOMh3huGn/x+ITCsOQbqrMObXyHOpwZl/c0X04zOZ9gpH4a52ug2KavoShR2AiRf3j4Gb51
 y2urrtizKCN4YHKvChYA+RuodDqn75JD8xMxRt+gSvVuB0qgGNKSQR7f4Sgl35kx2LkyKO2/7s1
 J1L2HWPwwXUYv9z4aS4OWqz2Pp12Yl2yGSUpBqJS0sNqJyxzc1TfYBuYVxjr5d72aoZ9aY45Fc6
 Z380/YneS14hNMreaaxZ/kS5aXyRj34MNR9C0dXAcVtnzOMH1D0idNk0H0vn6G9WtmRX0frr6hw
 4bTl2+16UnKrLU4BKCwr6djVzLQzQgqhT8n/ig/l/Zww3Grhfo5lcOTieGPEysRs3pN4wBsNpDo
 o+hFodbjbFPLBWdBeWpClBFql83Yoc+HDssisyNoNhMEHq7Lbw4LlJgaBS3WdUWySt+r1m1tDvH
 O1yWP/kM6zHhyZh/PMg==
X-Authority-Analysis: v=2.4 cv=Af0kjHXG c=1 sm=1 tr=0 ts=6ac658a5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=AfxKsdDCOPCRk7pzva4A:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070058
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

On 9/29/2026 7:00 PM, Pierrick Bouvier wrote:
> This series adds all architectures that only require stubs, basic helpers
> renaming, or filtering to be included in multi-target binary.
> 
> List:
> - alpha
> - microblaze
> - m68k
> - hppa
> - rx
> - tricore
> - or1k
> 
> Pierrick Bouvier (21):
>   hw/arm/virt: make virt machines available for base arm targets only
>   meson.build: subdir system before finalizing stubs library
>   system/meson: use stub_ss for dtb stubs
>   target/microblaze: prefix helper conflicting with other arch
>   target-info: add target_m68k
>   hw/m68k/virt: make machine available for m68k target only
>   meson.build: add m68k to multi-target
>   hw/pci-bridge: use stub_ss for pci_expander_bridge_stubs.c
>   target/alpha: prefix divs helper
>   meson.build: add alpha-softmmu to multi-target
>   meson.build: add avr-softmmu to multi-target
>   target/hppa: prefix helpers conflicting with other arch
>   meson.build: add hppa-softmmu to multi-target
>   target/rx: prefix helpers conflicting with other arch
>   meson.build: add rx-softmmu to multi-target
>   target/tricore: prefix helpers conflicting with other arch
>   meson.build: add tricore-softmmu to multi-target
>   target-info: add target_or1k
>   hw/or1k/virt: make virt machine available for or1k target only
>   target/or1k: prefix symbols conflicting with other arch
>   meson.build: add or1k-softmmu to multi-target
> 
>  hw/arm/virt.c                  |  2 ++
>  hw/m68k/virt.c                 | 10 ++++++----
>  hw/or1k/virt.c                 |  1 +
>  hw/pci-bridge/meson.build      |  4 ++--
>  include/qemu/target-info.h     | 14 ++++++++++++++
>  meson.build                    | 10 ++++++++--
>  system/meson.build             |  4 ++--
>  target-info.c                  | 10 ++++++++++
>  target/alpha/fpu_helper.c      |  2 +-
>  target/alpha/helper.h          |  2 +-
>  target/alpha/translate.c       |  4 ++--
>  target/hppa/helper.h           |  6 +++---
>  target/hppa/op_helper.c        |  4 ++--
>  target/hppa/sys_helper.c       |  8 ++++----
>  target/hppa/translate.c        |  6 +++---
>  target/microblaze/helper.h     | 10 +++++-----
>  target/microblaze/op_helper.c  | 10 +++++-----
>  target/microblaze/translate.c  | 10 +++++-----
>  target/or1k/exception.c        |  2 +-
>  target/or1k/exception.h        |  2 +-
>  target/or1k/exception_helper.c |  2 +-
>  target/or1k/helper.h           |  2 +-
>  target/or1k/interrupt_helper.c |  2 +-
>  target/or1k/sys_helper.c       |  6 +++---
>  target/or1k/translate.c        |  2 +-
>  target/rx/helper.h             | 12 ++++++------
>  target/rx/op_helper.c          | 12 ++++++------
>  target/rx/translate.c          | 14 +++++++-------
>  target/tricore/fpu_helper.c    | 12 ++++++------
>  target/tricore/helper.h        | 14 +++++++-------
>  target/tricore/translate.c     | 14 +++++++-------
>  31 files changed, 124 insertions(+), 89 deletions(-)
> 

This was merged into master (faf92d98e399320836f0db9bdf192593a8b56a71).
Thank you for your contribution!

Regards,
Pierrick

