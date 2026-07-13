Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792CCC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjBwb-0001PE-Dk; Mon, 13 Jul 2026 04:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjBwM-0001O9-Vc
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:23:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjBwK-0001Rx-JS
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:23:02 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D6Nwpp472821
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NSoNOcu4qvWDiMgcyhXoHCcSKtxuutZE6mAwUwxZQl4=; b=Jqw+2pnPX0EIUE4t
 Qr+8KMa7hqVLOL+pcke/lXxQCCC7xxxb2bURdjSNuWJUbF0jiJG4yA6b+pg5Aggv
 znG7yr2xlPaGON/8YHB2iA+nqsUiZqjTVOpG6zAj/nDP35UEGmaXPoUTe2g2Y9D2
 qF5RjfiPfZdvn5xb8Eya0gEE57AsnVuUvulmRhUdPlArQHRMMnu4Cmf9QjcZQbK3
 VDZAm4eEb/iE8cTpLtO5MnutaFX0KCysUwl45hdG9WeloqXuErJvIgzc4P48cbpq
 x9+8VG1FuX/RabftrhK9KGybY3HNF7ctCfPDAFV2OqDb8mxdiZWb2XjHHz6lOsvT
 Dy477g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbee9n7rm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:22:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c083f1818so39929661cf.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 01:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783930978; x=1784535778; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NSoNOcu4qvWDiMgcyhXoHCcSKtxuutZE6mAwUwxZQl4=;
 b=L/4oKRAvsOqeL0uqvTyjHdyeVNIhLIzuYeEByQDzlp+XH15ShlIRXR5mrT5XIunUB2
 t4ClROLShhYQtsNhWziGxjOLvjwto113lqF7xlQHM3GAN2moC7cEJdReHNpzwKZRB1jA
 kTmSr5WM8Y+VRoisjjiTaM+5dSd8t1AfZe33qsfZxYaZYhN4E2RtdcZYZDDJy45UN30E
 JjqwNPLcOXLnZv3sLm49uZYZR9DtBvCQ6dN+YgY0cB4VFLaKtixV8HsguS4jNa2POhN+
 A2kS8RRpfXBqT8ysifVqda+wBYtg9Yx22IyBtg2zdKN1tGBDua2BfDBsI4g7k++khbv0
 52dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783930978; x=1784535778;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NSoNOcu4qvWDiMgcyhXoHCcSKtxuutZE6mAwUwxZQl4=;
 b=DeQsbLgSVDHM+IvbfilPRP6E8qwAO44oFcBVhwclSdeY7H4rc6xqnOIXALpOIKoxkg
 1GHHG9OBXDL+7D+I6AR9jvsusQSnE7kqESdgV8Ed9bevc6qmWtpHiKDNHXv67tByu9i/
 hXNLktybjoBV9K5gQ9DLFgBCyRpL7FBXW0K9WqlbUpTbCng1Q8M6K1xQDTDTjt6vhkKR
 ztflR7LvmlZMS5JvW+ZtdMz00me7LjwvIEkQBGQOgdsIqsybwwkgirqE5bTW9p0BA3nr
 AGNF5AyPQDs41hbaZCESgVyOagkwIMX2BWRb2HScMLmrLEvNhN5X0BCcvTpmLY8xemVc
 sZFg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpONY93Jed4LoUWiknNtq2Bgq4UOjh3QTUEUuQ6tJcjQzmG9QsakxtRaRQgKjUHQnEvDppLCKJ1e5ms@nongnu.org
X-Gm-Message-State: AOJu0YwpG3PcdHLbxIixpDlFOlHpnSb+DZz19LgtICY5+QTuSx6wN1lY
 q2iyxxtTDVzDtfbkZ0Uo/Hho5MCbXtq5oEKwsqAyftJnS1I+Oj1HK0a29Nn6Kcx+92fE0gcKnAi
 QV9omwpGtI4EtmCuZ/+9OhXb4Cvgg5Ttr7YyPs8hSLePwXLt3ho5iiv/lmg==
X-Gm-Gg: AfdE7cm4PoxAhL0WX9XZP+1t7x3yvRCSpnC1owVSmZVNw01mavtyF+w9NYc5YL9WaD0
 dr9BBGRBLy/R+EuxkSwE3MPLw7yaU35QtTh+MKcb6E/V2asJK9CsDLM9pVsroDnFScndQvcTGZ/
 ZqykP6WACnmpSbweRMqmled2CesJG2W/dUiX/cTHFMKpTJg/35dHKow7WkDgGNP+4oLqxxk7BPS
 cWEGgQL62lH2LLf3wWOaL8LHowEL4BVpR9M2w/oknfEs5efzUKvkfTRFNA4iXIsMdnkev7A5Nq2
 ndwarE4cRZkMrTwzBBFioFcWUutliW6pVEzMvIZ2ql0yeH6mysVejSb+MyWq9A9vK/xIkz/8qVX
 x/g29G0S0lOBs6KuRN8gxWEq7yeBq2AesnCoBKq7mK2QpkcJ9MM3Ko/n4Hagi8g==
X-Received: by 2002:a05:622a:1393:b0:51a:9a12:9f08 with SMTP id
 d75a77b69052e-51cbf315c4amr80553201cf.51.1783930978237; 
 Mon, 13 Jul 2026 01:22:58 -0700 (PDT)
X-Received: by 2002:a05:622a:1393:b0:51a:9a12:9f08 with SMTP id
 d75a77b69052e-51cbf315c4amr80552591cf.51.1783930977669; 
 Mon, 13 Jul 2026 01:22:57 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d780csm83132689f8f.11.2026.07.13.01.22.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 01:22:56 -0700 (PDT)
Message-ID: <0878aca4-490a-4fa4-9fa4-d9c085ed11cb@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 10:22:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 002/134] qdev: Rename qdev_new()/qdev_try_new() to
 *_orphan()
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
 <20260711223707.42139-3-graf@amazon.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260711223707.42139-3-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA4NiBTYWx0ZWRfX6XQcNdGbp0oy
 7HyVlg8Q0Ci8YmPlUszcK568gWqn8UnnUo6hrDmr3D1zwp2c6PtGy0Jw1KXO80Ef+rFyJfORDED
 OpE9Zecpe3oBe8EiLz0hbXCFjRFWhz4=
X-Proofpoint-GUID: saoUCphJctpArFWuMkjILlWC3-bZ3qwb
X-Authority-Analysis: v=2.4 cv=a7UAM0SF c=1 sm=1 tr=0 ts=6a54a062 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=vggBfdFIAAAA:8 a=EUspDBNiAAAA:8 a=uEQV49vVqB13Y67JniYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA4NiBTYWx0ZWRfX9zzYkTDbsF9A
 Sx0iqsWvKFtBgjuzFCPGCFWFJd/l1wDQZsk7z+M7sFog4AL/kesrmgSYR2ZyDZWCt+4JKMnlPAq
 Hpliw4RjSkXmHChnqvf7LxRTJWzIwNMT+IhRKXztlTG2ZbtuJmB8QXRp+gLSKRtwqig1ifeAjTy
 h7fVlWXUrwIHMu6wsVp2ZxHTWpQV3nOYSfqQAFAyN4fpu9gDw9LQqVfrGqXmtkHnsuLabyB04B2
 21pGuqPxudJ8TECryzs6Iy0Bfl6suLLJNitWfuEHGtf2hA2oAE0BTOBdPpnxJYSX+rk//vMAW5E
 0ZU4XbVRlscEGQrEmZ42KBY2RAoSMScqQWsvBArwfuxOZ85IKqvkJfVrhfHSyHeoDwFbX88+lVw
 N9lXprnMmU4X4HC41eyyFHJsyO+w1TXWAIhp7TjSQOtPsWyscygHDJMgZ3vaFpn5ZX0xBtviUoO
 6kUL9BU1dwfWBvX/BRw==
X-Proofpoint-ORIG-GUID: saoUCphJctpArFWuMkjILlWC3-bZ3qwb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130086
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
> qdev_new() creates a device on the heap without a QOM parent.  If the
> caller does not add one before realize, device_set_realized() dumps
> the device into /machine/unattached with an unstable canonical path.
> 
> We want the short spelling qdev_new() to be the one that gets
> parenting right by construction.  As a first step, rename the current
> functions to qdev_new_orphan() and qdev_try_new_orphan() tree-wide so
> that a subsequent commit can reintroduce qdev_new() with a mandatory
> (parent, id, type) signature.
> 
> Purely mechanical, generated by
> 
>    spatch --sp-file scripts/coccinelle/qom-parent/qdev-new-orphan.cocci \
>           --in-place --include-headers --dir .
> 
> or equivalently
> 
>    git ls-files '*.[ch]' '*.[ch].inc' '*.rst' '*.py' | \
>        grep -v '^subprojects/' | \
>        xargs sed -i 's/\bqdev_try_new\b/qdev_try_new_orphan/g;
>                      s/\bqdev_new\b/qdev_new_orphan/g'
> 
> No functional change.
> 
> Assisted-by: Kiro
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>   hw/alpha/typhoon.c                            |  2 +-
>   hw/arm/aspeed.c                               |  2 +-
>   hw/arm/aspeed_soc_common.c                    |  4 +-
>   hw/arm/bananapi_m2u.c                         |  2 +-
>   hw/arm/cubieboard.c                           |  2 +-
>   hw/arm/exynos4210.c                           | 12 ++--
>   hw/arm/imx25_pdk.c                            |  2 +-
>   hw/arm/imx8mm-evk.c                           |  2 +-
>   hw/arm/imx8mp-evk.c                           |  2 +-
>   hw/arm/integratorcp.c                         |  8 +--
>   hw/arm/max78000fthr.c                         |  2 +-
>   hw/arm/mcimx6ul-evk.c                         |  2 +-
>   hw/arm/mcimx7d-sabre.c                        |  2 +-
>   hw/arm/mps2-tz.c                              |  4 +-
>   hw/arm/mps2.c                                 |  4 +-
>   hw/arm/msf2-som.c                             |  4 +-
>   hw/arm/musicpal.c                             |  6 +-
>   hw/arm/netduino2.c                            |  2 +-
>   hw/arm/netduinoplus2.c                        |  2 +-
>   hw/arm/npcm7xx_boards.c                       |  4 +-
>   hw/arm/npcm8xx_boards.c                       |  2 +-
>   hw/arm/olimex-stm32-h405.c                    |  2 +-
>   hw/arm/omap1.c                                | 12 ++--
>   hw/arm/orangepi.c                             |  2 +-
>   hw/arm/raspi.c                                |  2 +-
>   hw/arm/realview.c                             | 18 ++---
>   hw/arm/sabrelite.c                            |  2 +-
>   hw/arm/sbsa-ref.c                             | 20 +++---
>   hw/arm/stellaris.c                            | 20 +++---
>   hw/arm/stm32vldiscovery.c                     |  2 +-
>   hw/arm/strongarm.c                            |  4 +-
>   hw/arm/versatilepb.c                          | 14 ++--
>   hw/arm/vexpress.c                             | 14 ++--
>   hw/arm/virt.c                                 | 24 +++----
>   hw/arm/xilinx_zynq.c                          | 26 +++----
>   hw/arm/xlnx-versal-virt.c                     |  2 +-
>   hw/arm/xlnx-versal.c                          | 70 +++++++++----------
>   hw/arm/xlnx-zcu102.c                          |  6 +-
>   hw/arm/xlnx-zynqmp.c                          |  2 +-
>   hw/audio/intel-hda.c                          |  2 +-
>   hw/audio/model.c                              |  2 +-
>   hw/avr/atmega.c                               |  2 +-
>   hw/block/fdc-sysbus.c                         |  4 +-
>   hw/block/fdc.c                                |  2 +-
>   hw/block/pflash_cfi01.c                       |  2 +-
>   hw/block/pflash_cfi02.c                       |  2 +-
>   hw/block/xen-block.c                          |  2 +-
>   hw/char/exynos4210_uart.c                     |  2 +-
>   hw/char/mcf_uart.c                            |  2 +-
>   hw/char/mchp_pfsoc_mmuart.c                   |  2 +-
>   hw/char/pl011.c                               |  2 +-
>   hw/char/serial-mm.c                           |  2 +-
>   hw/char/sifive_uart.c                         |  2 +-
>   hw/char/spapr_vty.c                           |  2 +-
>   hw/char/xen_console.c                         |  2 +-
>   hw/core/qdev.c                                |  4 +-
>   hw/core/sysbus.c                              |  2 +-
>   hw/cxl/cxl-host.c                             |  2 +-
>   hw/display/sm501.c                            |  2 +-
>   hw/display/xlnx_dp.c                          |  4 +-
>   hw/dma/rc4030.c                               |  2 +-
>   hw/hexagon/hexagon_dsp.c                      |  4 +-
>   hw/hexagon/virt.c                             |  6 +-
>   hw/hppa/machine.c                             | 12 ++--
>   hw/i2c/core.c                                 |  2 +-
>   hw/i2c/smbus_eeprom.c                         |  2 +-
>   hw/i386/microvm.c                             |  6 +-
>   hw/i386/nitro_enclave.c                       |  4 +-
>   hw/i386/pc.c                                  |  2 +-
>   hw/i386/pc_piix.c                             |  2 +-
>   hw/i386/pc_q35.c                              |  2 +-
>   hw/i386/pc_sysfw.c                            |  2 +-
>   hw/i386/sgx.c                                 |  2 +-
>   hw/i386/x86-common.c                          |  6 +-
>   hw/i3c/core.c                                 |  2 +-
>   hw/ide/ide-bus.c                              |  2 +-
>   hw/intc/exynos4210_gic.c                      |  2 +-
>   hw/intc/riscv_aclint.c                        |  4 +-
>   hw/intc/riscv_aplic.c                         |  2 +-
>   hw/intc/riscv_imsic.c                         |  2 +-
>   hw/intc/s390_flic.c                           |  4 +-
>   hw/intc/sifive_plic.c                         |  2 +-
>   hw/isa/isa-bus.c                              |  6 +-
>   hw/loongarch/virt.c                           | 18 ++---
>   hw/m68k/an5206.c                              |  2 +-
>   hw/m68k/mcf_intc.c                            |  2 +-
>   hw/m68k/next-cube.c                           |  2 +-
>   hw/m68k/q800.c                                |  4 +-
>   hw/m68k/virt.c                                | 10 +--
>   hw/mem/sparse-mem.c                           |  2 +-
>   hw/microblaze/petalogix_ml605_mmu.c           | 12 ++--
>   hw/microblaze/petalogix_s3adsp1800_mmu.c      |  8 +--
>   hw/mips/boston.c                              |  4 +-
>   hw/mips/jazz.c                                | 12 ++--
>   hw/mips/loongson3_virt.c                      |  6 +-
>   hw/mips/malta.c                               |  4 +-
>   hw/misc/empty_slot.c                          |  2 +-
>   hw/misc/led.c                                 |  2 +-
>   hw/misc/sifive_e_prci.c                       |  2 +-
>   hw/misc/sifive_test.c                         |  2 +-
>   hw/net/lan9118.c                              |  2 +-
>   hw/net/smc91c111.c                            |  2 +-
>   hw/net/spapr_llan.c                           |  2 +-
>   hw/net/xen_nic.c                              |  2 +-
>   hw/nitro/machine.c                            |  4 +-
>   hw/nitro/nitro-vsock-bus.c                    |  2 +-
>   hw/nvme/ctrl.c                                |  2 +-
>   hw/nvram/fw_cfg.c                             |  4 +-
>   hw/or1k/or1k-sim.c                            |  6 +-
>   hw/or1k/virt.c                                |  8 +--
>   hw/pci-bridge/pci_expander_bridge.c           |  4 +-
>   hw/pci-host/astro.c                           |  2 +-
>   hw/pci-host/bonito.c                          |  2 +-
>   hw/pci-host/pnv_phb4_pec.c                    |  2 +-
>   hw/pci/pci.c                                  |  2 +-
>   hw/ppc/amigaone.c                             |  2 +-
>   hw/ppc/e500.c                                 | 22 +++---
>   hw/ppc/mac_newworld.c                         | 18 ++---
>   hw/ppc/mac_oldworld.c                         |  8 +--
>   hw/ppc/pnv.c                                  |  4 +-
>   hw/ppc/pnv_bmc.c                              |  2 +-
>   hw/ppc/ppc440_bamboo.c                        |  4 +-
>   hw/ppc/prep.c                                 |  4 +-
>   hw/ppc/sam460ex.c                             | 16 ++---
>   hw/ppc/spapr.c                                |  4 +-
>   hw/ppc/spapr_irq.c                            |  2 +-
>   hw/ppc/spapr_vio.c                            |  2 +-
>   hw/ppc/virtex_ml507.c                         |  6 +-
>   hw/remote/machine.c                           |  2 +-
>   hw/riscv/boston-aia.c                         |  4 +-
>   hw/riscv/microblaze-v-generic.c               | 14 ++--
>   hw/riscv/microchip_pfsoc.c                    |  2 +-
>   hw/riscv/sifive_u.c                           |  4 +-
>   hw/riscv/virt.c                               |  8 +--
>   hw/rtc/sun4v-rtc.c                            |  2 +-
>   hw/s390x/ap-bridge.c                          |  2 +-
>   hw/s390x/css-bridge.c                         |  2 +-
>   hw/s390x/s390-pci-bus.c                       |  2 +-
>   hw/s390x/s390-virtio-ccw.c                    |  6 +-
>   hw/scsi/lasi_ncr710.c                         |  2 +-
>   hw/scsi/ncr53c710.c                           |  4 +-
>   hw/scsi/scsi-bus.c                            |  2 +-
>   hw/scsi/spapr_vscsi.c                         |  2 +-
>   hw/sh4/r2d.c                                  |  6 +-
>   hw/sh4/sh7750.c                               |  4 +-
>   hw/sparc/leon3.c                              | 10 +--
>   hw/sparc/sun4m.c                              | 38 +++++-----
>   hw/sparc64/sun4u.c                            | 14 ++--
>   hw/ssi/ssi.c                                  |  2 +-
>   hw/tricore/tricore_testboard.c                |  2 +-
>   hw/ufs/lu.c                                   |  2 +-
>   hw/usb/bus.c                                  |  4 +-
>   hw/usb/dev-serial.c                           |  2 +-
>   hw/vmapple/vmapple.c                          | 20 +++---
>   hw/xen/xen-bus.c                              |  2 +-
>   hw/xen/xen-legacy-backend.c                   |  2 +-
>   hw/xen/xen-pvh-common.c                       |  2 +-
>   hw/xtensa/virt.c                              |  2 +-
>   hw/xtensa/xtfpga.c                            |  2 +-
>   include/hw/core/qdev.h                        | 14 ++--
>   include/hw/i2c/i2c.h                          |  2 +-
>   include/hw/misc/unimp.h                       |  2 +-
>   include/hw/ssi/ssi.h                          |  2 +-
>   include/hw/usb/usb.h                          |  2 +-
>   migration/migration.c                         |  2 +-
>   net/net.c                                     |  4 +-
>   .../qom-parent/qdev-new-orphan.cocci          | 18 +++++
>   system/qdev-monitor.c                         |  2 +-
>   target/mips/cpu.c                             |  2 +-
>   target/xtensa/cpu.c                           |  2 +-
>   170 files changed, 459 insertions(+), 441 deletions(-)
>   create mode 100644 scripts/coccinelle/qom-parent/qdev-new-orphan.cocci

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

