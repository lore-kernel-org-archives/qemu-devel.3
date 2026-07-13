Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCEFC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjC9H-0002CH-Of; Mon, 13 Jul 2026 04:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjC9F-0002A4-Qh
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:36:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjC9E-0002h7-0q
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:36:21 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D6NxGt390895
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pho/1HjVTrTRFZpF/Eg185BPq6uLynSoK4ool5fkEec=; b=bm2Kaqc9kbMlyJT/
 djxFKpS51YIapV/QYpU+L/XffhFApiR/CvDxul3qSarCKsJ0F5hueKnSCfxG87wq
 DaYayJAWciWLbm2B+oPxH/kFRGB0Vccqd9J8NjxBTr5ptAOlpwDTHjB4FMk2dsEN
 Xi+enY0x7zksg8qN9PtUHLCn1KVKmWw5woe08vN4Euw0Q3VdkC1mj9wiqf96h2sP
 GbTTL5eayx8tOyCsrSGncCqSuqu2wZaCuvCkBrHDWQ9AK/DEB+0Mkv6J9rXmAVvs
 ZL+aigqOsZ9uh5RVY4vaYhA/wZeNGa4J0Q1o/ctchbnVw53GsEeHHUik1fpgAur/
 NGMb1Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbf0gn3hh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:36:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c07f25de2so28984691cf.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 01:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783931778; x=1784536578; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pho/1HjVTrTRFZpF/Eg185BPq6uLynSoK4ool5fkEec=;
 b=gs8pd/C92wYRcvhDBigrSGSz0SCoEcmZNeVp4o3RYHzELHvYSR923jLOgxCfr7lOPc
 ePG/kROA27SNKoHGBQJnHhFtlx5IWEgaYGm7zMcfChsVvysR6ciTP17JuBOldnlgCM/8
 QI61ZgJarT+OEgIaq4xB5YFenlUjI6I//Iqdti9S+rGFdT9TQqp3N2uprCJOv1IjiZzs
 CahaP3jnx+X69e0qyDJbgEeHG5uZD/d4maaNa+5yy/Ud+ulK6LBSjqbHjQYWzsTiMZL1
 BaIaOb3YfaS8AaQhAVHst09u+qQslzC9r/xGFV2LrKe9cZnvNw/YJ/W7/gPwmMuPbmlc
 cwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783931778; x=1784536578;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pho/1HjVTrTRFZpF/Eg185BPq6uLynSoK4ool5fkEec=;
 b=V73t5SgKW+yJ7ZRM8+zMR6Bi4dzD5zJx2SgV0ECgXJm9yQpPBhAuVYRvlC7d+peyC0
 pv6SPwt2x4rNMFc6PKgTgEH1vt4H/7i+MMYBwtlK/wr3XPimVsG0EMaSbCHk8EsaS13L
 /QzqqLDCT7lrLBO7YcFjJ4d/r62ZWHUeHsHt9wDwnvc/Xwe/JPB7RBvFYYPkFgMoeKF2
 Vki5cJ18+RpcIT05wD1HPG4tWgcCEZOmq3uv3vpRm1S/huSoIC+lBL/+l9o/nKJ3OBnx
 tdrhXBBsVYm04PY2xTtN4Qowg20caSqwlnlAf8m9xYgu2m6Dty2uuMsWCrLdT+tmYtth
 8m8w==
X-Forwarded-Encrypted: i=1;
 AHgh+RonBOIk6dTtjPe9gmbjCMlkl7yuJkUWzYdLUaHP3sK3O4NVX04a+9mquCbtJLzzDFCINv+VKjRPlRaC@nongnu.org
X-Gm-Message-State: AOJu0Yx2EqYNGVTQ1lG/4tbBybSXkuS8n4vaBso4fukz5Tz7cCYq2YIq
 PT1cmLQbsvtPD0b9vNTaCUUOmFppPyj7gaapIol3b6E2dP0TtOHUYPuj+HqNiGDKkwhvEJJY8KR
 25X86NsHIYdmBVc3yLzu4cRLSEWZUrl0k4B+1cJxvw8tmLG9JZ8jcnLlPAA==
X-Gm-Gg: AfdE7clgH/i/RQ7t7lnWs+1G+dTe+JnbkLmVOSonIQqM+pOhfb5EYZtKULyPQDTxwOs
 A5Y0Vfo9ubFRjfhQkQwym/TjHAkRWMw/DGOcogRZa9jhOzAkK54BQoKRHJ+VpOEAkoX5hSYe3sx
 1Q0X6cyylDY6TW4JV/uS/oUkPNYl/js6KY4DB/nM/zHUAfAS727uLXfZGTWoczQw9iMjUBAwMk5
 ldrzyAkVoVrGR0I2enFV9IalWlt65gdqzSn4iOWamKpT4M2c91jz+zknMzUuLxMgEP8KqKWaDBm
 js3mMQ2FsznxLXr0Ya/W4C2cz+czLn/kdJY2ruqEUKfkg11zseeS2HE2OH+dBVGNN8JBocnipjh
 MvgAEmQKpFYY5/yBxwhTE1OFz8n6rgMKh8co8AIU8Cc1E9/PPQrFy2suJ6/hIDA==
X-Received: by 2002:a05:622a:4290:b0:51a:8c9b:64a2 with SMTP id
 d75a77b69052e-51cbf395337mr79147911cf.70.1783931777632; 
 Mon, 13 Jul 2026 01:36:17 -0700 (PDT)
X-Received: by 2002:a05:622a:4290:b0:51a:8c9b:64a2 with SMTP id
 d75a77b69052e-51cbf395337mr79147261cf.70.1783931777230; 
 Mon, 13 Jul 2026 01:36:17 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f373csm577217365e9.14.2026.07.13.01.36.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 01:36:16 -0700 (PDT)
Message-ID: <09dc819a-8bc9-41c6-a7df-8e684f4b7d3e@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 10:36:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 085/134] pci: Remove *_orphan() creator variants
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
 <20260711223707.42139-86-graf@amazon.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260711223707.42139-86-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Nq3htcdJ c=1 sm=1 tr=0 ts=6a54a382 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=vggBfdFIAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 4ZoaHPDr109EJnea_kF5YzBTpIvBmMQN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA4OCBTYWx0ZWRfX1VnEOY98/m/b
 qNtHbs+mlpMXEP1yo4yeVvY4sIhg/TG3wOXKMx1C5FkG6ISToE8S877tgeScEkXfVRiPuh0BJMO
 8ffoja264/EJthYdP7VH4JJqeMf+niPtezy3/sbGK2LSa2KPGCvrG3ayJwy7zXE8V5aFwYbskpY
 FVagrzlnEFZFbny75naCzcnCPWK9/N2ZAWNr5vdyRVTHdTNuQkTNMygImwwIX4Pez5M3VX110uy
 KyYeaqKsMKQMWv2agH4zoV47lkKLUepky/9DScrYjQYqrtBtDCTjuKzf9vUVaa1yRzBO+q9TGd3
 yOUxD8LgZ3HXf0grWFp1zRu2lGL1ewdZpAQls+q4I2Er/fXXByOHF+hrQQ64nm90kxAVCYwA+RI
 jHlec61QveZqlEfWnbb+0nO+1fk+vkmTt7CvkyMNturJqyrSa92tpJPjdw7Azy8di7UqIgOA8tm
 3htoNaBkxnC1y8m+hDg==
X-Proofpoint-GUID: 4ZoaHPDr109EJnea_kF5YzBTpIvBmMQN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA4OCBTYWx0ZWRfX8W/JAlQ24892
 3LsoAXxi/ap8kvZNFxaFbG4sZ2k8Mx0+HVjHcDD+ofkBC8kawKVQOJYyHDFKaLnS0qmgBr45dam
 O6Y9yJrErsD9cyfofF3RFPZEx5eDwZI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130088
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 12/7/26 00:36, Alexander Graf wrote:
> All boards create their PCI devices with an explicit QOM parent
> now.  Drop pci_new_orphan(), pci_new_multifunction_orphan(),
> pci_create_simple_orphan(), pci_create_simple_multifunction_orphan()
> and the internal pci_new_internal() they wrapped.
> 
> Assisted-by: Kiro
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>   hw/pci/pci.c         | 35 -----------------------------------
>   include/hw/pci/pci.h |  5 -----
>   2 files changed, 40 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

