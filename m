Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0355EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjMqq-0004Eb-4Z; Mon, 13 Jul 2026 16:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjMqn-0004DA-UR
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:02:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjMqj-0005dc-47
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:02:01 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9Pcj2256692
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 faF0t5LKNg5xUwVRQHF+IXYl1aWvFVxSoIxiEtECwZM=; b=UhxzRw2PX7hZYSMH
 65NSiO0hsGxEyLX8NI8X4AaM2FuEtc1WHRc0tbsnSlMVmj9XGlpKQ1kypbavge01
 MYuykPBsTwMXv+iP9JlqSl0Or7oGdXbTbxTNGPmqaVKlg1S8JQVk4MeBTzfNb+pE
 grSZ36a03aPQZxXnDl3zxgYIULxCX1yksTc5x5WnvCvIbCY6zVWVCMajjpMzPWNh
 sCNslp/CMsarn3Nytrtn8V9OAmI41BbXXtNuCEAgxH4z75SBL9z40u2ydBtIKy0r
 Wo1TT9b036Umk3oI39LxQX8L34ZRUk9j19J7fOKyUwhUcbdD9NnpG9xkZoA1M88G
 NedMfg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk9tdaq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:01:53 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca860baea9fso399333a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 13:01:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783972912; cv=none;
 d=google.com; s=arc-20260327;
 b=d63gunYzW9TXab91Jpy7mQRp41w+RxnPlqmXf5szITfb6eyy9A9MTCfUAYDBJdB+Dh
 WQ4rY0JQgychbbVrbRVR6SM9u7wX6OpNXh4bixNtISP5yU+mOnaHr/Z7mwyUi1Png3RV
 1B2c12PTZ13mv+2fkXxfH2NPppnUbm7F6EowkIjZSf4tIyjooSc/rLDgIPeJ2mnJoONz
 7nDvpgIeEFtRL8DHTmYe4McCs9Pj7xietR0uabRC4TvYOSJo/eA+W2AFGQ8Q9ttdofNS
 YvRxVC7Dt+JU++W1kBxXHyOLm96uteuuhcCbU6/AIM/6b6ev2vKiZv/+5XnPzoH0podo
 i+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=faF0t5LKNg5xUwVRQHF+IXYl1aWvFVxSoIxiEtECwZM=;
 fh=WdUB6g0MsZNI7avD2uP4txb4LNtVPCkKHMnDB8exqbI=;
 b=QWPWH/TLDAd1CBz70Umqyhuu4EOxr99OCMAdMji9MDbnqkCOJM4xummoCQOuECmFHJ
 FRNqyLb3QcYqrNngpn2mNR9MrssIYRPggDN0RNhiPdbxDnNWdKW9nHsQiItiFcwDXppC
 0YX0Tw1/G/CJT9XyWWGzwBFEPoCQnaroEbblK/DhqtxW0ahOPJ074UvCC5tJGJP1Xdg9
 BxSfhvvoBtgudMvV6giKqHoARVGFm554Rd6fmPsqx2GeC/Kz44nfrURlQopVGlBHCyTh
 tiSjcITNg6u30Wt0LBcRW9FgBUBwR13ufleNEDyuQmikq4TDtX387956J7m+TU0SronK
 5CzA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783972912; x=1784577712; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=faF0t5LKNg5xUwVRQHF+IXYl1aWvFVxSoIxiEtECwZM=;
 b=LjJ9dAwXIsF+bc41KLOj4aSbkJ2IgwzBqrYsEV+dnuarGvbiS6yPmROHjkRDfm88Um
 npllLxyBUekP4M6q6jbYGFFQgwTeXaC4JtLyiD0eUsxZ3btIV5XQ0PcNT9ffca0+xvq3
 UAmCAMbsKHYRvHyxFGNGJycC2KNQ/GDXDbEo9wL1xiXgrItdHWDMtq/sDMRZTvBoLjkl
 lbfDoaYj2vHv5AnhfUSnSmaBGJpZB6PeXWPWAkmZ4JtRIJTTlyahUhusnT8jh+afR5B/
 s7XvQNpP2/x57JRSiaRpClHH4XYZFGn2tRrqCvTDO4RfzoT4EJ5pdML9C9qMxZZIsQvW
 q5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783972912; x=1784577712;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=faF0t5LKNg5xUwVRQHF+IXYl1aWvFVxSoIxiEtECwZM=;
 b=ZnSLOi6Cx1WiFeddzYiGF12F23AEG5bRqW5KNtPFUFV0La7eKwEPv5InilRMlL5BBy
 +dE0KKOAvxNoc4jgp+kLhGshyngB8LxZc/8SLDbGQkVzBf9LMSn6VB2KnfgabTWdiEoG
 3d6gdW1ybtOBNYDWq/CmbneNyeDXNFWA03qlVA4AEG/Z2xWxxw0letTOqZl3qvT88SCc
 yoU4HMGuuQWVqBanEm1o1TQ/OKioZyZ+EeOtwaZtK7Nguxmu1ZoGkuWvEVwZhWaJ7zge
 CmQ+8IeMvC5MfCOe/cZhh5zo6ApcmiqWM7LLEM7o15Ntn7dWvwVQQBM8mXHKpUdjzGTC
 Gw7A==
X-Gm-Message-State: AOJu0YxOtGROvA1aVLJV4HlqxK9/nZAKQjmLEeWvtwA4bYO7x9z2jZPJ
 8uAcbMFuq0vMVFBe49b791am51afLES2vzNaTxyoUyIMo2ZWBSGMPsrxCmcgL/NrmhxoHgbvMvs
 IlURcJyg6j7kS8+xhGX9lSCaCp4r8l+jSIlaGIu+fpEahESzHHfCwpmm1Y7hRHSwmxrn4Qf/C9C
 0YbAY0HKegoUYHy96uGuBefQSZlP/s2FNm
X-Gm-Gg: AfdE7cl/uhMVxA0h2dBUbhUHT/dbpi3c+apEJcjgLllc3t1Z4LO96RlF9VcR3I6bAKa
 4TDq7XNtlq6GleIIxtxksbJB/NJQmIkAWNrKNc5UZd+c8dcPtJxU2kfHlx8LDZ2ncB8b/md5gFH
 xKUY9s4LPMuQRDK1LZis2soH8vWTxWtHDNOLbWlVf8G4Lo2KHxFZnmU92K9h2dOpFW5rS7
X-Received: by 2002:a05:6a20:430b:b0:3bf:c07b:a9a4 with SMTP id
 adf61e73a8af0-3c1108c219dmr10728755637.59.1783972912066; 
 Mon, 13 Jul 2026 13:01:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:430b:b0:3bf:c07b:a9a4 with SMTP id
 adf61e73a8af0-3c1108c219dmr10728691637.59.1783972911250; Mon, 13 Jul 2026
 13:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260711223707.42139-1-graf@amazon.com>
 <20260711223707.42139-130-graf@amazon.com>
In-Reply-To: <20260711223707.42139-130-graf@amazon.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:01:34 -0500
X-Gm-Features: AVVi8CezzKOCQiuBZSEVq1qFZQvrFtG-XaoSQhU3Qc-h2MF7MTaMnqRQ3kKjhFo
Message-ID: <CAEqNhNaEsFL9J3N-2+SNtkK5zNzLXNc_=2KBYiTyBynaXmn19A@mail.gmail.com>
Subject: Re: [RFC PATCH 129/134] hw: Parent board-created CPUs under the
 machine
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Song Gao <17746591750@163.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Farhan Ali <alifm@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi <balbi@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
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
 Tyrone Ting <kfting@nuvoton.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Laurent Vivier <laurent@vivier.eu>,
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow <shentey@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Ran Wang <wangran@bosc.ac.cn>,
 Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwNyBTYWx0ZWRfX1sQoYOmv3BJy
 KdWm0xnpe5KMPHNRwvv82+jcJju5zmuOgzIGBF0IlS2a50rczZS7oINJAh+GLYLyCoiZbbrtJsw
 PDAX48aveRuQFx5mLcXw6Kf1H+1vNIDVN0CPLHBDFg/WvR81RKSzZqh50M2rWlCP/jH1k8N4X8Q
 kOrn+I+MiuVTdU2Bo8sozv4ri6wSpMljhRLg1C9VpM+FAvbAKcOigcjUk+dYFLHaAEiP30sOTCP
 1gjxKL6nhaupKoBmzfyVscDfwDmoyZzdIDb5sXhb8YgvlN28g03SsRk+zw8QyX2eQjb2bfVvoDZ
 7iQokpctX+0wI+nVN1Yr4cW0GsWh/N41oSRaTFR96aAuKwTR7v58ClRZHvg8QcTQjQ0e2QEYbGT
 ggJ1XQMvpV3zPCIC624IV7pE8R/s/tMwBlCDIr4WpjBjSMINcDZnpUphFlzpMxc2P7u5k/vCzc/
 rdYSVbJb9cIDXZVDnfQ==
X-Proofpoint-ORIG-GUID: 8OjY3mEOSzc3Ws34G3kE9za8nawMDE9p
X-Authority-Analysis: v=2.4 cv=UMHt2ify c=1 sm=1 tr=0 ts=6a554431 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=vggBfdFIAAAA:8 a=EUspDBNiAAAA:8
 a=W7yJQE5JMTQGjF-4Sx8A:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: 8OjY3mEOSzc3Ws34G3kE9za8nawMDE9p
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwNyBTYWx0ZWRfX+bhBRO4XOHVL
 bkAEPlFGfM4zMKJmtgH4zaK0Z1x6oBgcJJxR6X91aNf3oemLmjcz4DwXZVp7x94OCUCH9WI2bhE
 97/pr+kPqkgsmpLa8Tj7VuAFQBk94fM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130207
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Sat, Jul 11, 2026 at 6:11=E2=80=AFPM Alexander Graf <graf@amazon.com> wr=
ote:
>
> A number of boards create CPUs via object_new(cpu_type) followed
> by property setting and qdev_realize(NULL), rather than through
> cpu_create().  These CPUs currently fall into /machine/unattached
> via the device_set_realized() fallback.  Parent them explicitly
> under the machine (or the CPS/SoC container that owns them) as
> "cpu[*]", matching the naming convention used by cpu_create().
>
> The subsequent object_unref() and qdev_realize_and_unref() calls
> are converted to plain qdev_realize() (or dropped) since the
> parent's child<> property now holds the reference.  Error paths
> switch to object_unparent().
>
> The transient introspection object_new() in hw/arm/virt.c
> machvirt_init() (probing pa_bits) is deliberately left as-is;
> it is unref'd immediately without being realized.
>
>   hw/arm:       integratorcp mps3r realview sbsa-ref versatilepb
>                 vexpress virt xilinx-zynq
>   hw/hexagon:   hexagon_dsp virt
>   hw/i386:      x86-common xen-pvh
>   hw/loongarch: virt
>   hw/mips:      cps
>   hw/ppc:       e500 spapr (cpu-core)
>   hw/riscv:     cps microblaze-v-generic
>   hw/s390x:     s390-virtio-ccw
>   hw/sparc:     leon3 sun4m
>   hw/sparc64:   sparc64
>
> Assisted-by: Kiro
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---

For hexagon,

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>  hw/arm/integratorcp.c           |  3 ++-
>  hw/arm/mps3r.c                  |  4 ++--
>  hw/arm/realview.c               |  3 ++-
>  hw/arm/sbsa-ref.c               |  4 ++--
>  hw/arm/versatilepb.c            |  3 ++-
>  hw/arm/vexpress.c               |  3 ++-
>  hw/arm/virt.c                   |  4 ++--
>  hw/arm/xilinx_zynq.c            |  3 ++-
>  hw/hexagon/hexagon_dsp.c        |  5 +++--
>  hw/hexagon/virt.c               |  5 +++--
>  hw/i386/x86-common.c            |  9 ++++-----
>  hw/i386/xen/xen-pvh.c           |  5 ++---
>  hw/loongarch/virt.c             |  5 +++--
>  hw/mips/cps.c                   |  5 +++--
>  hw/ppc/e500.c                   |  5 +++--
>  hw/ppc/spapr.c                  |  4 ++--
>  hw/riscv/cps.c                  |  5 +++--
>  hw/riscv/microblaze-v-generic.c |  3 ++-
>  hw/s390x/s390-virtio-ccw.c      | 16 +++++++---------
>  hw/sparc/leon3.c                |  3 ++-
>  hw/sparc/sun4m.c                |  5 +++--
>  hw/sparc64/sparc64.c            |  3 ++-
>  22 files changed, 58 insertions(+), 47 deletions(-)
>
> diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
> index 81c0bce8f9..30a6a940c5 100644
> --- a/hw/arm/integratorcp.c
> +++ b/hw/arm/integratorcp.c
> @@ -598,7 +598,8 @@ static void integratorcp_init(MachineState *machine)
>      DriveInfo *dinfo;
>      int i;
>
> -    cpuobj =3D object_new(machine->cpu_type);
> +    cpuobj =3D object_new_child(OBJECT(machine), "cpu[0]",
> +                                        machine->cpu_type);
>
>      /* By default ARM1176 CPUs have EL3 enabled.  This board does not
>       * currently support EL3 so the CPU EL3 property is disabled before
> diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
> index d6c29c1172..dd434eaefd 100644
> --- a/hw/arm/mps3r.c
> +++ b/hw/arm/mps3r.c
> @@ -388,13 +388,13 @@ static void mps3r_common_init(MachineState *machine=
)
>          memory_region_add_subregion_overlap(&mms->cpu_sysmem[i], 0,
>                                              &mms->sysmem_alias[i], -1);
>
> -        mms->cpu[i] =3D object_new(machine->cpu_type);
> +        mms->cpu[i] =3D object_new_child(OBJECT(mms), "cpu[*]",
> +                                        machine->cpu_type);
>          object_property_set_link(mms->cpu[i], "memory",
>                                   OBJECT(&mms->cpu_sysmem[i]), &error_abo=
rt);
>          object_property_set_int(mms->cpu[i], "reset-cbar",
>                                  PERIPHBASE, &error_abort);
>          qdev_realize(DEVICE(mms->cpu[i]), NULL, &error_fatal);
> -        object_unref(mms->cpu[i]);
>
>          /* Per-CPU RAM */
>          memory_region_init_ram(&mms->cpu_ram[i], OBJECT(mms), ramname,
> diff --git a/hw/arm/realview.c b/hw/arm/realview.c
> index 99591e7d80..f938367131 100644
> --- a/hw/arm/realview.c
> +++ b/hw/arm/realview.c
> @@ -119,7 +119,8 @@ static void realview_init(MachineState *machine,
>      }
>
>      for (n =3D 0; n < smp_cpus; n++) {
> -        Object *cpuobj =3D object_new(machine->cpu_type);
> +        Object *cpuobj =3D object_new_child(OBJECT(machine), "cpu[*]",
> +                                        machine->cpu_type);
>
>          /* By default A9,A15 and ARM1176 CPUs have EL3 enabled.  This bo=
ard
>           * does not currently support EL3 so the CPU EL3 property is dis=
abled
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index c9adc972c1..3b759d9209 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -783,7 +783,8 @@ static void sbsa_ref_init(MachineState *machine)
>              break;
>          }
>
> -        cpuobj =3D object_new(possible_cpus->cpus[n].type);
> +        cpuobj =3D object_new_child(OBJECT(sms), "cpu[*]",
> +                                        possible_cpus->cpus[n].type);
>          object_property_set_int(cpuobj, "mp-affinity",
>                                  possible_cpus->cpus[n].arch_id, NULL);
>
> @@ -808,7 +809,6 @@ static void sbsa_ref_init(MachineState *machine)
>                                   OBJECT(secure_sysmem), &error_abort);
>
>          qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
> -        object_unref(cpuobj);
>      }
>
>      memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_MEM].base,
> diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
> index f68c4765c6..8d93fff207 100644
> --- a/hw/arm/versatilepb.c
> +++ b/hw/arm/versatilepb.c
> @@ -208,7 +208,8 @@ static void versatile_init(MachineState *machine, int=
 board_id)
>          exit(1);
>      }
>
> -    cpuobj =3D object_new(machine->cpu_type);
> +    cpuobj =3D object_new_child(OBJECT(machine), "cpu[0]",
> +                                        machine->cpu_type);
>
>      /* By default ARM1176 CPUs have EL3 enabled.  This board does not
>       * currently support EL3 so the CPU EL3 property is disabled before
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index f877ccf330..986525b9ce 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -219,7 +219,8 @@ static void init_cpus(MachineState *ms, const char *c=
pu_type,
>
>      /* Create the actual CPUs */
>      for (n =3D 0; n < smp_cpus; n++) {
> -        Object *cpuobj =3D object_new(cpu_type);
> +        Object *cpuobj =3D object_new_child(qdev_get_machine(), "cpu[*]"=
,
> +                                        cpu_type);
>
>          if (!secure) {
>              object_property_set_bool(cpuobj, "has_el3", false, NULL);
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index f2249a0b72..95e087d692 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3039,7 +3039,8 @@ static void machvirt_init(MachineState *machine)
>              break;
>          }
>
> -        cpuobj =3D object_new(possible_cpus->cpus[n].type);
> +        cpuobj =3D object_new_child(OBJECT(vms), "cpu[*]",
> +                                  possible_cpus->cpus[n].type);
>          object_property_set_int(cpuobj, "mp-affinity",
>                                  possible_cpus->cpus[n].arch_id, NULL);
>
> @@ -3139,7 +3140,6 @@ static void machvirt_init(MachineState *machine)
>          }
>
>          qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
> -        object_unref(cpuobj);
>      }
>
>      /* Now we've created the CPUs we can see if they have the hypvirt ti=
mer */
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 441289e63f..a2dcdd422d 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -222,7 +222,8 @@ static void zynq_init(MachineState *machine)
>      }
>
>      for (n =3D 0; n < smp_cpus; n++) {
> -        Object *cpuobj =3D object_new(machine->cpu_type);
> +        Object *cpuobj =3D object_new_child(OBJECT(machine), "cpu[*]",
> +                                        machine->cpu_type);
>
>          object_property_set_int(cpuobj, "midr", ZYNQ_BOARD_MIDR,
>                                  &error_fatal);
> diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
> index 53dfe6741e..d78a987dca 100644
> --- a/hw/hexagon/hexagon_dsp.c
> +++ b/hw/hexagon/hexagon_dsp.c
> @@ -143,7 +143,8 @@ static void hexagon_common_init(MachineState *machine=
, Rev_t rev,
>      sysbus_realize(SYS_BUS_DEVICE(tlb_dev), &error_fatal);
>
>      for (int i =3D 0; i < machine->smp.cpus; i++) {
> -        HexagonCPU *cpu =3D HEXAGON_CPU(object_new(machine->cpu_type));
> +        HexagonCPU *cpu =3D HEXAGON_CPU(object_new_child(OBJECT(machine)=
, "cpu[*]",
> +                                        machine->cpu_type));
>          qemu_register_reset(do_cpu_reset, cpu);
>
>          /*
> @@ -158,7 +159,7 @@ static void hexagon_common_init(MachineState *machine=
, Rev_t rev,
>                                   OBJECT(glob_regs_dev), &error_fatal);
>          object_property_set_link(OBJECT(cpu), "tlb",
>                                   OBJECT(tlb_dev), &error_fatal);
> -        qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
> +        qdev_realize(DEVICE(cpu), NULL, &error_fatal);
>      }
>
>      rom_add_blob_fixed_as("config_table.rom", &m_cfg->cfgtable,
> diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
> index fb23cda19f..48f1e35dd3 100644
> --- a/hw/hexagon/virt.c
> +++ b/hw/hexagon/virt.c
> @@ -280,7 +280,8 @@ static void virt_init(MachineState *ms)
>
>      cpu0 =3D NULL;
>      for (int i =3D 0; i < ms->smp.cpus; i++) {
> -        HexagonCPU *cpu =3D HEXAGON_CPU(object_new(ms->cpu_type));
> +        HexagonCPU *cpu =3D HEXAGON_CPU(object_new_child(OBJECT(ms), "cp=
u[*]",
> +                                        ms->cpu_type));
>          qemu_register_reset(do_cpu_reset, cpu);
>
>          if (i =3D=3D 0) {
> @@ -300,7 +301,7 @@ static void virt_init(MachineState *ms)
>          object_property_set_link(OBJECT(cpu), "tlb",
>                                   OBJECT(tlb_dev), &error_fatal);
>
> -        qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
> +        qdev_realize(DEVICE(cpu), NULL, &error_fatal);
>      }
>      fdt_add_cpu_nodes(vms);
>      clk_phandle =3D fdt_add_clocks(vms);
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index 151a67ee5f..5bbfee737e 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -55,15 +55,14 @@ static size_t pvh_start_addr;
>
>  static void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error *=
*errp)
>  {
> -    Object *cpu =3D object_new(MACHINE(x86ms)->cpu_type);
> +    Object *cpu =3D object_new_child(OBJECT(x86ms), "cpu[*]",
> +                                        MACHINE(x86ms)->cpu_type);
>
>      if (!object_property_set_uint(cpu, "apic-id", apic_id, errp)) {
> -        goto out;
> +        object_unparent(cpu);
> +        return;
>      }
>      qdev_realize(DEVICE(cpu), NULL, errp);
> -
> -out:
> -    object_unref(cpu);
>  }
>
>  void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
> diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
> index ab90c83a83..7aef48ad61 100644
> --- a/hw/i386/xen/xen-pvh.c
> +++ b/hw/i386/xen/xen-pvh.c
> @@ -29,12 +29,11 @@ struct XenPVHx86State {
>  static DeviceState *xen_pvh_cpu_new(MachineState *ms,
>                                      int64_t apic_id)
>  {
> -    Object *cpu =3D object_new(ms->cpu_type);
> +    Object *cpu =3D object_new_child(OBJECT(ms), "cpu[*]",
> +                                        ms->cpu_type);
>
> -    object_property_add_child(OBJECT(ms), "cpu[*]", cpu);
>      object_property_set_uint(cpu, "apic-id", apic_id, &error_fatal);
>      qdev_realize(DEVICE(cpu), NULL, &error_fatal);
> -    object_unref(cpu);
>
>      return DEVICE(cpu);
>  }
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 580ef0bb3e..b749aafdbe 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -948,13 +948,14 @@ static void virt_init(MachineState *machine)
>      /* Init CPUs */
>      mc->possible_cpu_arch_ids(machine);
>      for (i =3D 0; i < machine->smp.cpus; i++) {
> -        cpuobj =3D object_new(machine->cpu_type);
> +        cpuobj =3D object_new_child(OBJECT(machine), "cpu[*]",
> +                                        machine->cpu_type);
>          if (cpuobj =3D=3D NULL) {
>              error_report("Fail to create object with type %s ",
>                           machine->cpu_type);
>              exit(EXIT_FAILURE);
>          }
> -        qdev_realize_and_unref(DEVICE(cpuobj), NULL, &error_fatal);
> +        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
>      }
>      virt_check_dmsi(machine);
>      fw_cfg_add_memory(machine);
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index 620ee972f8..b997608373 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -74,7 +74,8 @@ static void mips_cps_realize(DeviceState *dev, Error **=
errp)
>      }
>
>      for (int i =3D 0; i < s->num_vp; i++) {
> -        MIPSCPU *cpu =3D MIPS_CPU(object_new(s->cpu_type));
> +        MIPSCPU *cpu =3D MIPS_CPU(object_new_child(OBJECT(s), "cpu[*]",
> +                                        s->cpu_type));
>          CPUMIPSState *env =3D &cpu->env;
>
>          object_property_set_bool(OBJECT(cpu), "big-endian", s->cpu_is_bi=
gendian,
> @@ -87,7 +88,7 @@ static void mips_cps_realize(DeviceState *dev, Error **=
errp)
>          /* All cores use the same clock tree */
>          qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->clock);
>
> -        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
> +        if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
>              return;
>          }
>
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index f3917c0755..a0eb25e956 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -941,7 +941,8 @@ void ppce500_init(MachineState *machine)
>          PowerPCCPU *cpu;
>          CPUState *cs;
>
> -        cpu =3D POWERPC_CPU(object_new(machine->cpu_type));
> +        cpu =3D POWERPC_CPU(object_new_child(OBJECT(machine), "cpu[*]",
> +                                        machine->cpu_type));
>          env =3D &cpu->env;
>          cs =3D CPU(cpu);
>
> @@ -956,7 +957,7 @@ void ppce500_init(MachineState *machine)
>           */
>          object_property_set_bool(OBJECT(cs), "start-powered-off", i !=3D=
 0,
>                                   &error_abort);
> -        qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
> +        qdev_realize(DEVICE(cs), NULL, &error_fatal);
>
>          if (!firstenv) {
>              firstenv =3D env;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9b6b5e7257..e6c1b7f0b1 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2776,7 +2776,8 @@ static void spapr_init_cpus(SpaprMachineState *spap=
r)
>          }
>
>          if (i < boot_cores_nr) {
> -            Object *core  =3D object_new(type);
> +            Object *core  =3D object_new_child(OBJECT(spapr), "cpu-core[=
*]",
> +                                        type);
>              int nr_threads =3D smp_threads;
>
>              /* Handle the partially filled core for older machine types =
*/
> @@ -2790,7 +2791,6 @@ static void spapr_init_cpus(SpaprMachineState *spap=
r)
>                                      &error_fatal);
>              qdev_realize(DEVICE(core), NULL, &error_fatal);
>
> -            object_unref(core);
>          }
>      }
>  }
> diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
> index b6b30e05e1..2bf506b61a 100644
> --- a/hw/riscv/cps.c
> +++ b/hw/riscv/cps.c
> @@ -63,13 +63,14 @@ static void riscv_cps_realize(DeviceState *dev, Error=
 **errp)
>      int harts_in_cluster =3D s->num_hart * s->num_core;
>      int num_of_clusters =3D s->num_vp / harts_in_cluster;
>      for (i =3D 0; i < s->num_vp; i++) {
> -        cpu =3D RISCV_CPU(object_new(s->cpu_type));
> +        cpu =3D RISCV_CPU(object_new_child(OBJECT(s), "cpu[*]",
> +                                        s->cpu_type));
>
>          /* All VPs are halted on reset. Leave powering up to CPC. */
>          object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
>                                   &error_abort);
>
> -        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
> +        if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
>              return;
>          }
>
> diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-gene=
ric.c
> index 0a83932405..f97ce402e6 100644
> --- a/hw/riscv/microblaze-v-generic.c
> +++ b/hw/riscv/microblaze-v-generic.c
> @@ -65,7 +65,8 @@ static void mb_v_generic_init(MachineState *machine)
>      qemu_irq irq[32];
>      MemoryRegion *sysmem =3D get_system_memory();
>
> -    cpu =3D RISCV_CPU(object_new(machine->cpu_type));
> +    cpu =3D RISCV_CPU(object_new_child(OBJECT(machine), "cpu[0]",
> +                                        machine->cpu_type));
>      object_property_set_bool(OBJECT(cpu), "h", false, NULL);
>      object_property_set_bool(OBJECT(cpu), "d", false, NULL);
>      qdev_realize(DEVICE(cpu), NULL, &error_abort);
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 037cb6eb5e..0625d4a8df 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -56,20 +56,18 @@ static Error *pv_mig_blocker;
>  static S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id,
>                                Error **errp)
>  {
> -    S390CPU *cpu =3D S390_CPU(object_new(typename));
> -    S390CPU *ret =3D NULL;
> +    S390CPU *cpu =3D S390_CPU(object_new_child(qdev_get_machine(), "cpu[=
*]",
> +                                        typename));
>
>      if (!object_property_set_int(OBJECT(cpu), "core-id", core_id, errp))=
 {
> -        goto out;
> +        object_unparent(OBJECT(cpu));
> +        return NULL;
>      }
>      if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
> -        goto out;
> +        object_unparent(OBJECT(cpu));
> +        return NULL;
>      }
> -    ret =3D cpu;
> -
> -out:
> -    object_unref(OBJECT(cpu));
> -    return ret;
> +    return cpu;
>  }
>
>  static void s390_init_cpus(MachineState *machine)
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index f9ef2758e1..a2781bcc32 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -278,7 +278,8 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
>
>      for (i =3D 0; i < machine->smp.cpus; i++) {
>          /* Init CPU */
> -        cpu =3D SPARC_CPU(object_new(machine->cpu_type));
> +        cpu =3D SPARC_CPU(object_new_child(OBJECT(machine), "cpu[*]",
> +                                        machine->cpu_type));
>          qdev_init_gpio_in_named(DEVICE(cpu), leon3_start_cpu, "start_cpu=
", 1);
>          qdev_init_gpio_in_named(DEVICE(cpu), leon3_set_pil_in, "pil", 1)=
;
>          qdev_realize(DEVICE(cpu), NULL, &error_fatal);
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 51f5468a02..1ae9d834ca 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -787,7 +787,8 @@ static DeviceState *cpu_devinit(const char *cpu_type,=
 unsigned int id,
>      CPUSPARCState *env;
>      DeviceState *cpudev;
>
> -    cpu =3D SPARC_CPU(object_new(cpu_type));
> +    cpu =3D SPARC_CPU(object_new_child(qdev_get_machine(), "cpu[*]",
> +                                        cpu_type));
>      env =3D &cpu->env;
>      cpudev =3D DEVICE(cpu);
>
> @@ -795,7 +796,7 @@ static DeviceState *cpu_devinit(const char *cpu_type,=
 unsigned int id,
>      object_property_set_bool(OBJECT(cpu), "start-powered-off", id !=3D 0=
,
>                               &error_abort);
>      qdev_init_gpio_in_named(cpudev, cpu_set_irq, "pil", MAX_PILS);
> -    qdev_realize_and_unref(cpudev, NULL, &error_fatal);
> +    qdev_realize(cpudev, NULL, &error_fatal);
>      cpu_sparc_set_id(env, id);
>      env->prom_addr =3D prom_addr;
>      return cpudev;
> diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
> index 16f4aa052b..9092c4193e 100644
> --- a/hw/sparc64/sparc64.c
> +++ b/hw/sparc64/sparc64.c
> @@ -272,7 +272,8 @@ SPARCCPU *sparc64_cpu_devinit(const char *cpu_type, u=
int64_t prom_addr)
>      uint32_t  stick_frequency =3D 100 * 1000000;
>      uint32_t hstick_frequency =3D 100 * 1000000;
>
> -    cpu =3D SPARC_CPU(object_new(cpu_type));
> +    cpu =3D SPARC_CPU(object_new_child(qdev_get_machine(), "cpu[0]",
> +                                        cpu_type));
>      qdev_init_gpio_in_named(DEVICE(cpu), sparc64_cpu_set_ivec_irq,
>                              "ivec-irq", IVEC_MAX);
>      qdev_realize(DEVICE(cpu), NULL, &error_fatal);
> --
> 2.47.1
>

