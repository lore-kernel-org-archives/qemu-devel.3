Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D24C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEJ6-0003d0-Kj; Mon, 13 Jul 2026 06:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEJ4-0003c9-LG
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:54:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEJ2-0004MR-OU
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:54:38 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D77P8A810514
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 10:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LW3fYohk/aaKNf9gFX7XJAGrK7Rod9ZwfEsbUEYpc0k=; b=TAs3HUWcKq3c4dR1
 pBV3PfPnOs49dDkaDFeAiuoKfk+IfXVqQeAFNXYssHj6LesQwEWOuktlLq+8EYvf
 j5/kNgTo5mIKFstpKNeiYnN9sm0bDDJODab1KswSIv5eH2Dh7QgVW6Hzk+ADBUm0
 RZgFtt4q0VWMrPqzgSfFd/4YlvZ6V9D4c2L9j1MX72VhpEKnGSjj3NSlDM1Pt8eY
 B4YnxJ/ghWHop+hZe4q99TdmRKla1iRA7Q0UeXQWZhAJTWJUtzKk1dYM730MWHi4
 8ahXBbRcRa8NE9WAs21U+azV0vdz7z/4LGgwgwgi2moaYpFU7iwLiqH22X4OjTV2
 hbT1VQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcubsrtrb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 10:54:35 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8e9489f62bfso57241826d6.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 03:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783940074; x=1784544874; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LW3fYohk/aaKNf9gFX7XJAGrK7Rod9ZwfEsbUEYpc0k=;
 b=bbXJ9jajDgbLOJrh5rP0iWzOaegs67Cqp7LOqQCnWNbDsyeTN/yJUL3JLNQIKE5jt+
 OEX5/HnhMF4MFetJbQ6i1K5GakvZGHHX0E2qU4BYHWOCykTl0ifuSzcxvhpVLuSsptgl
 2IJJdN1uYwkTuVnU0NGhd3U5hxqlrG6nHmEqCnGOxT213ECnwgyqpbvDAFl83hE1jDqk
 cnmasReAdIg4xS6dKJHm6n98HlShrxv8j3vBOnh01e67zEpO2eQy9X/79QY7RR/9YV+G
 WfH7vsjXKyHFi/0Qt0rhTe9RAtoOytnyix+5UpTJ/zxTK4Ve8B1/FSeqQfYPW1xhLW0g
 dMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783940074; x=1784544874;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LW3fYohk/aaKNf9gFX7XJAGrK7Rod9ZwfEsbUEYpc0k=;
 b=d5g8vT8gm0hTIB9X0YEzwyI7bkqqX2+Ji9jKOekdksBV9Lhd/0svKfcYnA0X8PVeqW
 S0zzwgH3wfdsvwukcMjIcd969GL2s1eLEeOabq5a1iS8P9c3ofm3lUoiQ+uGzAnkONmC
 +N8RW6meYMe+sh1S2X14v2nauzwe+gYKnvnB210O71zaVgd0epXu6Ka5e5qyykLokCDx
 CZ0qIYukD7zd28F26sDC5g5WSNqWjrHyr8kIubvx4HtrMswC3srzkhHGy2OOmXyC3ZJs
 c2WtVJxRMTofxH22+VYQ5ChhRXCyVj+rpqRRVTiP4ZrHYdlIavEdVgOaIzLdNkuGqCHs
 Cj1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKh/7yeEJcCL7amRnzWCfSgGTE2SDlXzzN5WDUVwpnRBWQl5vCf1XENsBd5ZYwS61OZK87suzIkK/4@nongnu.org
X-Gm-Message-State: AOJu0Yziw0QndLOE/WlsCPELU/ni1ZDMf5J7qPn5eUTwxEkFe+R8KYaZ
 74NBbjMPaaXf5rl1FpM04CTg2zRxagXxZYvmpjFWC0FxY0L77RZ4yph+YDoq0uaHcWYoLL+YpU/
 Qp1gMSGZtL0ibzndslbpRiPv8oygc2XyIat9fWLFnoPWfai1EEufYzmK0sw==
X-Gm-Gg: AfdE7cmKvUGOCQtXDDsvsCe+ObkxJluJhdifsbKy34f+w6ahTlWmOztBOvFLHI0vnSD
 FJCqoU82jyfUrhjYxw0zXzukqdN6410BDAkXhd+Ad1OFmDZOTVcNz8LIteBTogaLRAlbUglewQa
 M7+jJSkJqPUv10ha9z6F5M6pkQQjz9zhMe3Tu2EUKZ/DcVpQMYPcj1cvAu1MsUfFORRgZ8u1YHH
 CiWCe01sx7w1WjJVYazNiAf/B73ucF6tGNOVdFPyhf4G95ytBPgWe+b7faYgm3hOvxiZFlxO7TR
 nh8xFGsUTn7ctt2SxiVmcuxT8EjP6DV6SIhcpRf2mTP1ssoJTSKcpflWfXTa50qZ9xkzi+qZ9bm
 uphebnbJpGq7H7d+sDbMxCIOJbpBMNjI1F5qMefz7N0sxU282ZjEfOHMj4nHa8w==
X-Received: by 2002:a05:622a:1456:b0:51c:f3:34de with SMTP id
 d75a77b69052e-51cbf0bf820mr77332621cf.20.1783940074410; 
 Mon, 13 Jul 2026 03:54:34 -0700 (PDT)
X-Received: by 2002:a05:622a:1456:b0:51c:f3:34de with SMTP id
 d75a77b69052e-51cbf0bf820mr77332081cf.20.1783940073910; 
 Mon, 13 Jul 2026 03:54:33 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493fbae1cdbsm178692545e9.10.2026.07.13.03.54.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 03:54:33 -0700 (PDT)
Message-ID: <c8081b11-b38e-4662-97a4-46734cd9d92e@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 12:54:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 004/134] sysbus: Make
 sysbus_create_simple()/_varargs() take a QOM parent
Content-Language: en-US
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Song Gao <17746591750@163.com>,
 Aditya Gupta <adityag@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Farhan Ali <alifm@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi <balbi@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Jan Kiszka <jan.kiszka@web.de>, Max Filippov <jcmvbkbc@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Jared Rossi <jrossi@linux.ibm.com>,
 Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic <pasic@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow <shentey@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Ran Wang <wangran@bosc.ac.cn>,
 Hao Wu <wuhaotsh@google.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260711223707.42139-5-graf@amazon.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260711223707.42139-5-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Oq9/DS/t c=1 sm=1 tr=0 ts=6a54c3eb cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=vggBfdFIAAAA:8 a=EUspDBNiAAAA:8 a=e-WwYK0FPL1hkuWrF-MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: 7G_j-75xiZ5rQX8_PeYdSKDEQWHONoE-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExMyBTYWx0ZWRfX9C8XNWfZFfB/
 mBX8L2V/lpn9vXJh3BW0bbjT5jZprJ5VZqL7PYSHF8wu/Vs664jWVfjjLxhYT0rZppGYzBj0Zke
 yb6ht+qlL2EHUTqEtwipaf36K9IbxTg=
X-Proofpoint-GUID: 7G_j-75xiZ5rQX8_PeYdSKDEQWHONoE-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExMyBTYWx0ZWRfXwJ7+K4sNtAGK
 dFJo4LTQJ56cGLKIcyuKjlmmH06pXb/cCju7rmtEQUTwBKik8/3LBG09qx6ZAG8gFVlkWMJ8Z5r
 gsvqj3BcqXvTfRPXtKad76Etd+GOsBu5Cqhzq2kkAflAq5Kg7YxNTK57DKFO9jXRnQcUPeU28sO
 KV90xN/NeY3gx5urSHwgE9ECUkFo5aGvQCCSvgE/P+bD1j1gZTQ8tedoqSNj1NDf6HZc3hSYeTY
 a2JuLsoxqSX7Z5nFbI07YYO876XVu/YohhcHJsdM6kKQjcczClNA91/7c3U8tPa/sMUulAbzukO
 7LSvZpcoEaJG08dVxzGiPDEVnBNzvGg9BK+pkfT5aftaCd0BNjLV4/KpaXULRMDVtGspaGwvJYK
 gM53QpHA26n5xlPumRiOTWRfD4/s0uzSKcKG9c+MS3zNPol+WpCRaykfhmr2QlOLGxE4Ys+FPlL
 LUHrNLVLMyV3PxpQY9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130113
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

On 12/7/26 00:34, Alexander Graf wrote:
> Sysbus is by far the largest producer of orphaned onboard devices:
> of the ~1180 unparented device creation sites in the tree, well over
> half go through sysbus_create_simple(), sysbus_create_varargs(), or
> qdev_new_orphan()+sysbus_realize_and_unref() open-coded.
> 
> Apply the same rename-and-reintroduce treatment as qdev_new():
> mechanically rename the existing helpers to *_orphan() and
> reintroduce the short names with a leading (parent, id, ...) pair
> that plumbs down to the new qdev_new().  The parented versions call
> sysbus_realize() (not _and_unref) since the child<> property already
> holds the sole reference.
> 
> The mechanical rename part is generated by
> 
>    spatch --sp-file \
>        scripts/coccinelle/qom-parent/sysbus-create-orphan.cocci \
>        --in-place --include-headers --dir .
> 
> or equivalently
> 
>    git ls-files '*.[ch]' '*.[ch].inc' '*.rst' '*.py' | \
>        grep -v '^subprojects/' | \
>        xargs sed -i \
>            's/\bsysbus_create_simple\b/sysbus_create_simple_orphan/g;
>             s/\bsysbus_create_varargs\b/sysbus_create_varargs_orphan/g'
> 
> Assisted-by: Kiro
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>   hw/arm/allwinner-h3.c                         | 16 ++++-----
>   hw/arm/collie.c                               |  2 +-
>   hw/arm/exynos4210.c                           | 14 ++++----
>   hw/arm/fsl-imx6.c                             |  2 +-
>   hw/arm/integratorcp.c                         | 18 +++++-----
>   hw/arm/mps2.c                                 |  6 ++--
>   hw/arm/musicpal.c                             | 18 +++++-----
>   hw/arm/npcm7xx.c                              |  2 +-
>   hw/arm/realview.c                             | 24 ++++++-------
>   hw/arm/sbsa-ref.c                             |  6 ++--
>   hw/arm/stellaris.c                            |  8 ++---
>   hw/arm/strongarm.c                            | 10 +++---
>   hw/arm/versatilepb.c                          | 28 +++++++--------
>   hw/arm/vexpress.c                             | 20 +++++------
>   hw/arm/virt.c                                 |  8 ++---
>   hw/arm/xilinx_zynq.c                          | 10 +++---
>   hw/core/sysbus.c                              | 35 ++++++++++++++++++-
>   hw/i386/kvm/clock.c                           |  2 +-
>   hw/i386/kvm/xen_evtchn.c                      |  2 +-
>   hw/i386/kvm/xen_gnttab.c                      |  2 +-
>   hw/i386/kvm/xen_overlay.c                     |  2 +-
>   hw/i386/kvm/xen_primary_console.c             |  2 +-
>   hw/i386/kvm/xen_xenstore.c                    |  2 +-
>   hw/i386/microvm.c                             |  2 +-
>   hw/intc/apic_common.c                         |  2 +-
>   hw/loongarch/virt.c                           |  2 +-
>   hw/m68k/next-cube.c                           |  4 +--
>   hw/m68k/virt.c                                |  2 +-
>   hw/mips/jazz.c                                |  2 +-
>   hw/mips/loongson3_virt.c                      |  2 +-
>   hw/or1k/virt.c                                |  2 +-
>   hw/ppc/amigaone.c                             |  2 +-
>   hw/ppc/e500.c                                 |  2 +-
>   hw/ppc/pegasos.c                              |  4 +--
>   hw/ppc/ppc440_bamboo.c                        |  2 +-
>   hw/ppc/sam460ex.c                             |  8 ++---
>   hw/riscv/virt.c                               |  4 +--
>   hw/sparc/sun4m.c                              |  2 +-
>   hw/vmapple/vmapple.c                          |  4 +--
>   hw/xen/xen-pvh-common.c                       |  2 +-
>   include/hw/core/sysbus.h                      | 32 ++++++++++++++---
>   .../qom-parent/sysbus-create-orphan.cocci     | 18 ++++++++++
>   42 files changed, 206 insertions(+), 131 deletions(-)
>   create mode 100644 scripts/coccinelle/qom-parent/sysbus-create-orphan.cocci


> diff --git a/include/hw/core/sysbus.h b/include/hw/core/sysbus.h
> index f3c4259d29..7737c959c5 100644
> --- a/include/hw/core/sysbus.h
> +++ b/include/hw/core/sysbus.h
> @@ -91,15 +91,39 @@ bool sysbus_realize_and_unref(SysBusDevice *dev, Error **errp);
>   /* Call func for every dynamically created sysbus device in the system */
>   void foreach_dynamic_sysbus_device(FindSysbusDeviceFunc *func, void *opaque);
>   
> -/* Legacy helper function for creating devices.  */
> -DeviceState *sysbus_create_varargs(const char *name,
> +/**
> + * sysbus_create_varargs: Create, parent and realize a sysbus device
> + * @parent: the QOM parent (usually the machine or containing device)
> + * @id: child<> property name
> + * @type: sysbus device type to create
> + * @addr: MMIO region 0 address, or -1 for none
> + * @...: NULL-terminated list of qemu_irq to connect
> + *
> + * Create a sysbus device via qdev_new(@parent, @id, @type), realize
> + * it, optionally map MMIO region 0 at @addr, and connect the given
> + * IRQs.  The returned device is owned by @parent.
> + */
> +DeviceState *sysbus_create_varargs(Object *parent, const char *id,
> +                                   const char *type, hwaddr addr, ...);
> +
> +static inline DeviceState *sysbus_create_simple(Object *parent,

Both are legacy. Updating the doc:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +                                                 const char *id,
> +                                                 const char *type,
> +                                                 hwaddr addr,
> +                                                 qemu_irq irq)
> +{
> +    return sysbus_create_varargs(parent, id, type, addr, irq, NULL);
> +}
> +
> +/* Legacy helper function for creating unparented devices.  */
> +DeviceState *sysbus_create_varargs_orphan(const char *name,
>                                    hwaddr addr, ...);

