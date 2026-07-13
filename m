Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6546C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjC2r-0003jl-8t; Mon, 13 Jul 2026 04:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjC2p-0003j1-Na
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:29:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjC2l-0001sH-Cg
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:29:43 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D6Ni8d507140
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tn0yCKOo7Xgd/5CWSoWTfoF+F+wIOpEp/qzrxY0r2DE=; b=e6JCN+hiM4y537hA
 fNBDj8BSEmlCNIahtcjMMZ/toFYtHTqfR3MRLNn0/FPgftnf82rOGjysTnSmeQSW
 nxiuDFAlGjKq34mOcuA2m125NBqw5DKtxbEMlvHuZ6oHEahzO2Z7ypP/PdlJI12w
 lJ0Uvy8+O+9k4xFxhxXLpLi5fqMjdrqw5Dfu3KCpQMXuX/0K1P4Fk9DvZG0GNO16
 LlgmFIin+J9AVTEsyvYkerGceEBgC3AD3Qujevf5x3vRFbhE0BsK4pQ6UWxJ3esz
 XRtE/EVv2ar8KXKz1t1UJ3/A+JdWqupC4nW3zFpP9bd1cMtLxR/o8m/q86EYdrqf
 HP3aWQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fctc8gkrb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:29:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c075c1e25so30168001cf.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 01:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783931376; x=1784536176; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tn0yCKOo7Xgd/5CWSoWTfoF+F+wIOpEp/qzrxY0r2DE=;
 b=D7O09VRu7hVVngCDlGp//4G6y50Je/Z41kVIGEzfAbFrQcxeFyEUVrO8jd2NE1bAvM
 N/Ct1x1u3zwMBaFMcT6c+VDCHaaSU0w+ScAp7u4soUR2p/wp0N4BoDpjV+c/6/duYTdr
 P5w6CcJ/hrxJrlyN6FQ+e7aWSjnf0E7cRLtzLLJsyhRdgWEufFth1+0OJjSM2p3UcaMa
 yd7sTEReYd1AEtk02YPFV7uRLYxUxbjDQoiuJUoVSUY2Ih39bAuYNVXx9yusZys3SFIV
 3YxkMPf4+phIKLCTE2ORI3aXH7ERWjDh2EIL82Bof5SaQsh2i5+wQjMFXcTUKOESIlLs
 Rq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783931376; x=1784536176;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tn0yCKOo7Xgd/5CWSoWTfoF+F+wIOpEp/qzrxY0r2DE=;
 b=bIHNxvMq7cXGVuyAnX/VlI3QJgmc4dwt/dsndnp+PFCxQW3SCUT5jEhdjbMIwegcK7
 A3/cyPnJ1362Nwj2tdUpuJosZL1ATkVWC6kB5aYQWeV6tVrppQnmQdi+JbAp5Ob6RR9T
 sfXPwisX81LsrOdqghyuQtweKBfz4M5kvGnLOikqxJjB3dGjXEUAAYt8mfR8e/bfQsJo
 bOzQH7DeU54AmKnXEeuCi1DFWOkleRc16z8u1j89YPwYpcgaFPu3zNdqB6ds7Tx/LSlM
 /gsI39fkaxYe6Be4amd7COmA6jXM81khXuBLXzMG0EmWRUutJH2DT7AMiHcS3fq0C972
 V0hw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpd21ZCHuFBEs0TlEH7jXRcrdQrC3vjf5u3Ih5+1SECTrRMNT6aUH7D4CBv/aT7iBX3axmdiRxO4Rkd@nongnu.org
X-Gm-Message-State: AOJu0Yxzp9xLPIq1zQXAkmFBytstbkRuA5zR1PN3K999DYMAjYKOfiMg
 blBJndGoSkpKC8rcxbFHI/uwhU86vPV/VfUP3BZ5d8ROEGYIQFKBEmcBXJhe0fu2OBqCsWjCeuh
 6EfGUUpX07ocZHKeMHlZwk5H+7OFf9raBrnBE+AOlMt1PaRFVkIXOTlGLUw==
X-Gm-Gg: AfdE7clKvLlR09fLv26iBDHLCoeubrkqDdpE7JYhbE4owtsyagLcjKEPHxioSRFpEfE
 CPl+bNWzeUhN1QFLcMphYIXDazukbvbZ4xTs+JXCBfL+q9/hVdnFPFMz9YPPgZgLld3hiyaL24w
 F/wpYX3HnWrgCd3J+rbNexMZ5BGPovPp3m8xeWjQ9JuR82h5tVoiLFqcw9MYXci56FML0tZ/lDR
 eHON/PojsfDMAAsCLYeKkQA/WNdb3t0W74ULWGkaJr8vYlAflUm/LApm49vC77ASjZrh7nsOf3V
 eYksM6PEqKmO81DjUP1GMJNDWgoyqJGbT4T/rNUa4w4IcBmYqJr6B4/RZZ9kZX+bX+M4Rqrg0Dh
 /uOfQSWxJS647UuEqoJp+vqHK2bPK7oiW7lJR0o2Z8KgWQGy5Ox0lMBOEOo2VRA==
X-Received: by 2002:a05:622a:1aa3:b0:51c:61a:50e6 with SMTP id
 d75a77b69052e-51cbf0714b3mr78537231cf.3.1783931376273; 
 Mon, 13 Jul 2026 01:29:36 -0700 (PDT)
X-Received: by 2002:a05:622a:1aa3:b0:51c:61a:50e6 with SMTP id
 d75a77b69052e-51cbf0714b3mr78536661cf.3.1783931375794; 
 Mon, 13 Jul 2026 01:29:35 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d8410sm84050360f8f.15.2026.07.13.01.29.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 01:29:35 -0700 (PDT)
Message-ID: <89684024-5f7b-48a4-b8d1-e3f3cae2ddb2@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 10:29:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 014/134] hw/nitro: Give onboard devices a QOM parent
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
 <20260711223707.42139-15-graf@amazon.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260711223707.42139-15-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o0W_wfctayIoPEug0KLWpYkICmZ7pOPh
X-Proofpoint-ORIG-GUID: o0W_wfctayIoPEug0KLWpYkICmZ7pOPh
X-Authority-Analysis: v=2.4 cv=UtRT8ewB c=1 sm=1 tr=0 ts=6a54a1f1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=ZiMIAIO6AAAA:8 a=vggBfdFIAAAA:8 a=EUspDBNiAAAA:8
 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=KohFQSMcaiS2QNUyYz07:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA4NyBTYWx0ZWRfXzVEfFSNBe3DO
 +F4OXYF2TrafpqaTpzNPOJOYFJw8AlcW8DeVsLH8BkOGOTvFFNqaHWHeeM+upEbzh3MViSdKqvZ
 sU/yGYIhk++NdzSXs+n3coBn9Qeavv8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA4NyBTYWx0ZWRfXw1r5DIxSi+cP
 HbzivCjuicUnKLDRLfJLnEVGUxwLW+RULwEfHihDXTMqiYtuHeVk+8LyvVeonpRINIUc5UezNjJ
 VFFOavCalq4e7PzHNogkedLLQ+qswfpU9BsPj7K3Fb0rIyTEe16nDN2JscNQr+X+eDW7RHlpVIQ
 VY53dJhrcolUytGmmZOL7bDJdtBOv72D5mfMKeE7wWay9C+XsiSJq4m1L8lx87ugGVTkSwboyEN
 1fdc9nsmPTk52Pu0fsDOoymjXzW/LDXsc6sj84PpqGnIS9p14EdF3xM63E1Lghe1Tc0qi2jNgjJ
 /fTkN3BuVHGD3vNh//eiSWCue2ynrA88UfszgDopDbFu77WULiorRoTdCRvH2Sxd06UIHMrnZ4y
 Bfx2EgX6/mV5DHc5PEPdMMYRO+CY1JYZ8Te6SDtm5fJpShpb20Si7IOzaDbA0VMO/CgGGqkECHd
 9m+fiESUa34cKxCU4gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130087
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

On 12/7/26 00:35, Alexander Graf wrote:
> Convert the *_orphan() device-creation calls in hw/nitro to the new
> parented API introduced earlier in this series, so every onboard
> device gets a stable path in the composition tree instead of landing
> in /machine/unattached with an unstable device[N] name.
> 
> The parent for each device is the object that owns its lifetime: the
> machine for board-created devices, the containing device for
> composite children.  Names follow existing QOM conventions.
> 
> Per-site rationale (reviewers: dispute the modeling here):
> 
>    file:line              | parent          | name        | rationale
>    machine.c:200          | OBJECT(bridge)  | "heartbeat" | onboard heartbeat is a fixed child of the vsock bridge it plugs into; bridge owns its lifetime
>    machine.c:212          | OBJECT(bridge)  | "serial"    | debug-mode serial-over-vsock is a fixed child of the same bridge
>    nitro-vsock-bus.c:51   | ORPHAN-JUSTIFIED| -           | bridge is parented immediately after via qdev_set_id() to /machine/peripheral/nitro-vsock; keep the orphan creator here
> 
> Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
> Assisted-by: Kiro
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>   hw/nitro/machine.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

