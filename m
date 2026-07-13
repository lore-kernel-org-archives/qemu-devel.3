Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD00CC44506
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjC9j-0002i0-Vi; Mon, 13 Jul 2026 04:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjC9i-0002bc-DF
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:36:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjC9g-0002jP-TL
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:36:50 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D6NxjH674494
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qHGhBTHB+bAm0nSSXXim2etiXX5UkncMiwLS7q/k1/I=; b=Sd0M1OvJYsGLPdZD
 YxOuNSUSTqA3wVyrhiYZeUz2mJpMNPkkSVL9po5/yX3tI7M29BZANHcFrCn7lYOj
 z6W0lYUY2iLGLlxuaOiVEhC9sbvUURbJZgXt1xhVK2YVKD8cL4oGNggssmccdUzZ
 x6ABfyXC92rTQ7S1L0KKvN7bOLR4Stf50WN4/BTYLk+vsWwogPsCLY0fpYEC0hkO
 e3XfWa2MTx+pouVverBEgBHR8QwHeF6UvvH6ULBqgWgDResO4Hc2FpXEyIKBFlXi
 GSFwPRrlp+403/sBJT2Y2aw0Add6Y/7RaaTmGX5we0mZHIYNTqVlPMsfcXvUPstO
 IfNwiQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbecgn88h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:36:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c26012cd0so39103401cf.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 01:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783931807; x=1784536607; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qHGhBTHB+bAm0nSSXXim2etiXX5UkncMiwLS7q/k1/I=;
 b=ECOcVlbwPTL9/E0o+zNf0gocZqTF7MZTS408+hSMcP8FDTyxLbICdaEpdGovlG5vUO
 sZ12vlGwtSNSrzlS75KVsj6iU+JXKTXWa4kaZ4Xs3VtyDplcmS1rf+gY68x2TkgoZ80B
 xuXLxG6jTX3vfvekquvf/TGYjWw/extZn9LkBdn8AVfI2RelkYFj7DCFdjfBSgcN1K6L
 ej8Lq37/cIIRGvIwp0kSHyzGytx2mrYNay9XbbGQdF2Pmf2Nufd0gQyUVf2tL+Dwl1Dz
 rbaxpVLx5ST5qhPazonhkfu1zAljRSr1GnWECnjANS67oZ8XJy7M6ux4rQEDDJP1hmVo
 +x4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783931807; x=1784536607;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qHGhBTHB+bAm0nSSXXim2etiXX5UkncMiwLS7q/k1/I=;
 b=XIU4JbFVX5prjTd3GdWjj1DrsJaZSPDXzppbkWGx8dOS9JbgquBhow90goteC7oX6E
 onIRj2/yS4lQgV3/SvrCed2b9w+lJTTNcBWgfikFnEKsmJcfLYtDAjb5ZPDc9RgvAhP+
 AATYb+/U/+VLGP0PHoLns5EyyMq+H4LpvI+oU/NAPvD8Y2AobUI9TlGgwD94b++yg+rX
 Ceq6pYQPsgNki5hZTC7QozG3iHRT1u0HjsSWynJGwd8BXwtxFWB/dFbgLtxumeoxvp/2
 mRH3z6AAK5GXjsnbwW5sgTUeeM3IrlUlemQbsKTh+KLLZLkm+v8Ombn/3D05enAeg/lB
 TOOw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMiZg9CgzlSn313YQU2G8bpCLHKsVXee1G0ye0Z8IoSKnLCS2r4Q18l4QxNVx6NCA98+wti3XjCRzh@nongnu.org
X-Gm-Message-State: AOJu0Yzwib6E2YhEHb4zeclydFmvkX1EryJhG+Lby2ZfG6KYBsNov3Jl
 WPCstbbKqqj5Z1QdtYWims4iV7NAlDwGDiCAL17bi7L7e/Gw6bukpPU9tqz7uQkEATUR4WdFiCq
 EGCok6TuNojqNABxKOMjLV2iVOaYYzmnCaeL1x/QsIqdjupWDrAc16qNp5Q==
X-Gm-Gg: AfdE7cmpuMzdtHi92TL5RuU9lmjVQx73EcGhpoUh+tnXQ2L2pfuCyHKMwmtoelhAPWn
 R6Vc7qhYQkiOYPbfboHQPhQwYRYSbYMYYgWyqKCmF3wXZdUSxEGST+H+Kwx52XTg5uTyifPiZuX
 GrTQUHoaCCFpZbNQvMOyDFTEbu6ziKIJvJSYZrf4GSH0yrAz+oDD+WaVu9eqJmuiMO7D87gQ5yf
 eiM3+17Xs/dliLQXi4d5gqnH2XxhhU+nCbcPJhmi6Ce+huDlxwF6GZ6lxWbxEseL7UJ8sDGiSWW
 A7+aqIziYyfXKS04Ec9x64x95/RHnSYK63m8B+3Oy4ovOQokNBY6rMOir/2QERGefyQe3OMhTsx
 L3UqNedN0D5fkQCaHmAqR7PAeEYKtrOX6WzZrThApTTX8zAsKy3gY1QOyaI5glQ==
X-Received: by 2002:ac8:5ac1:0:b0:51c:9193:fd9e with SMTP id
 d75a77b69052e-51cbf067fbbmr85518271cf.15.1783931807022; 
 Mon, 13 Jul 2026 01:36:47 -0700 (PDT)
X-Received: by 2002:ac8:5ac1:0:b0:51c:9193:fd9e with SMTP id
 d75a77b69052e-51cbf067fbbmr85517811cf.15.1783931806583; 
 Mon, 13 Jul 2026 01:36:46 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e6ccsm84044499f8f.5.2026.07.13.01.36.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 01:36:45 -0700 (PDT)
Message-ID: <844669d8-12ca-40f1-9f2f-f09409ea45c4@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 10:36:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 087/134] sysbus: Remove *_orphan() creator variants
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
 <20260711223707.42139-88-graf@amazon.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260711223707.42139-88-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA4OCBTYWx0ZWRfX/9xVtGRIDD6j
 EUQ7CgTJzP2Tn2NvhMlpYRVF/htfKMBkhIh/dskVA6bGZ/NXQlgL1tkOIHPz2kZskNNSc6Z7qMW
 alrDqhdPki9S+9vCh95MzeP2tSvgxqY=
X-Proofpoint-ORIG-GUID: cd_SUmYEbVECkEFtuBczti2KuL-lBLhP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA4OCBTYWx0ZWRfX0A6MuQQjW8Ez
 /1+GAKkCtp+uTajYT8mgc4BzG3xoJsnK23kzGqiLphpJmvnAjY3t80Y4oBUSh7RAH343iqaWKuY
 fLoJZM/Rf1N1ITt1N+XI0XnXTE1bL+k2N/1IIzhAsQbqRR5VsZiyZyCHyz/5SUFU+pQWiwHF4pk
 SVRz8hwz4Eg8viMZDsqdW55AQIXPtKzZcyMQh6alT1Zuty0u9m9EfKBnjowjyJmi6llY46E2t/q
 i+ln/vF+6jjXCvbsQuEn3rVYJIUJXoYN8YoJQF2wsLTbgC1XRI3888xLe8ISF3qB981adsSIVrm
 NjhekmJGjJvrFXcPDZUOPlrwJdoRx9oj/uZfkLXbfVlkpg/kAosmC1MizadXkCU6GxdwYqpfwvV
 5g70IIboC9tt/ao7U7+LdEf4NNbSX7frW/ihH7haE5gCkgwxBrWBkVRUqBmP47J4QXJkRUC14g1
 3y4PpQVCuxXa6kQFHgA==
X-Proofpoint-GUID: cd_SUmYEbVECkEFtuBczti2KuL-lBLhP
X-Authority-Analysis: v=2.4 cv=KM9qylFo c=1 sm=1 tr=0 ts=6a54a39f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=vggBfdFIAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130088
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
> All boards create sysbus devices with an explicit parent now.
> Drop sysbus_create_simple_orphan() and
> sysbus_create_varargs_orphan().
> 
> Assisted-by: Kiro
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>   hw/core/sysbus.c         | 29 -----------------------------
>   include/hw/core/sysbus.h | 11 -----------
>   2 files changed, 40 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

