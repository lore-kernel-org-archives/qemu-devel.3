Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7174AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjByx-0002Fb-OD; Mon, 13 Jul 2026 04:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjByt-0002D0-Eb
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:25:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjByr-0001iz-Fx
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:25:39 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D6Nkva469324
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jx86LT6tbVgIC03nsJN+TghsjbPvnRSiKtm4j1ybhGg=; b=NkASd+Nohbb7dnX3
 lrWPG/4tbX2oE+yoQVhPaMCUVhiJnaIgTi9by/smH8xfseOeF/sd4LlkmUw7elAP
 p4Xg9lj7tsTKgPaWvbOoOMPtJoi7nbI5R11WSYm+DaQsilG3p1d8f1RbHlpB1lrD
 WsZ4bLAtgqfi02SyezjKieBL7lPYAFme6TGdpp/Fn1GTJfTjx63lySqVQ52ktebc
 ToESb6ouRg83Sh+IiqP1YIRCs6bchuVyeCU2hPG7rxwDv9lfkTCGDSpU9IGBm8bq
 XN0HLCUktm+q1ttAAKdq+Hy5wJoHH98GenSXLmn+ln+M15RpBOV+sYlQZpwGlifH
 MRY6ug==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbf4855mq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:25:35 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f0867a75ecso74985456d6.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 01:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783931135; x=1784535935; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jx86LT6tbVgIC03nsJN+TghsjbPvnRSiKtm4j1ybhGg=;
 b=aVh9qyaC0NmUPpcZcDsU6cqqzyiT0xgBbslUd6GCnbFR/BJv/5Wb8G0BNhEe6N6wXv
 mvfZWRAikDZ8YGVXbJxZ2bcDFbgKAvoqAMfq1JOQpbUSlVfa/IBUUyxBT5602rdBsq5W
 R3L2H1ulymn+pPKln99fSvWjnHunrY+W4eAb6xPGbi2dbaWGqZkZAzD4JfIZsqTocuhW
 egufWXIT8vELcg1r7mCvHFvpMmo3NBUn+5Tk2Hlj82KrmpBaDuuFLS3W5llHUK+w+LV8
 C5xOr1r0r0OoltC4jnYKJoD361omMCZzBIBFu5j3o8C0AYE9jI9SO5gmSyhDtq4q/Rgi
 737g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783931135; x=1784535935;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jx86LT6tbVgIC03nsJN+TghsjbPvnRSiKtm4j1ybhGg=;
 b=aH7nR8eA/2cH27OehENdLMuQgw++Ngc3e3/IxxhHQbrpo+fP90PieRZH+yQ9NwrplN
 PCEjbS2IMky5wy4+D8OPRzwN/32bViWeXCXgd3MW7a9VkosIEkNyn4xgi51szakYW8l4
 /bGjRc+t1U1Tb5JfuQD64TKI6Zcr1qNtrYUy1T4sv3ix/eHoOI5jSFdU8J//DaaZX91z
 WMlIXsPiVWUvyyn7ozxM0u8PlbWg18h9xjAgGSSgOEG+96Swipa8quVdV0t8eD/cIe6P
 HHdUCil5VOuzD5u8hcqSIkfm2Bo45CYpvgo4vBk9PprSLX4HVP2y8TAgk7OU1qgzzmy1
 kzsQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMi+S8B9Ba4zxZKAj9Nj6ziJ1ewjZobI3HJTi5u8OInLC8IUdYT7vWpHMwsv+gY1c/zb/3crIUKLxN@nongnu.org
X-Gm-Message-State: AOJu0Yxdv1A/mChBKMOCIXluH1KKbLI7RYoUmD80Uru4sN002BO5FzTC
 s7a8Sv8dleUTVvw0IWLRQim/EwoWhKlUKNYWOJHJ0akOp6c9ZKU8hkE2e39aUbtDXG1pvznUZOv
 Jc78j5YB1ZmEDsvJY/OXBrtP2K0O1eQDtGlR0d43EiWnBiial93mw7UxtDA==
X-Gm-Gg: AfdE7cmsblIE1WqiHOjPfaZTZAOXtZG+q/mFI2/GaAXtFkV1MP6KkCkWih8y4mwHlb2
 ctDHRGQuqDxLtyGonUXCGnJvy9/Mm37D2PhTdqIdTQEktgnlc6yrdBDjiF+mO9d/jnSQbyMHl6K
 9r2WDKbah2Ur8/FNN4IEYiOutwxJuczLoaxxGoFfZIoPSsYnmsfgL8wd+q4dE3GvDTROjlT9fhT
 DjGJDU4BPCHoI22wza0MJxtzHGJBzPtMX7So0jdcPOVDJwei58i8HyoIDLo/IeP5qH0Y07FGe6F
 8JPxDAipJCh7+6Gv7m3wNPg5TWrvroP+4X7vCKwMjzq52YsOzz+XCR9ftfwlzLsPAsbwy+shIU5
 9cBnpSehuQm29E7YJrqk5APVETG4Pc1OH89lVgbtmmRCtkbOWIWg4tCy/vRqaEw==
X-Received: by 2002:a05:6214:5b08:b0:8ee:bb17:7e2d with SMTP id
 6a1803df08f44-903ffc615bfmr89513316d6.25.1783931134979; 
 Mon, 13 Jul 2026 01:25:34 -0700 (PDT)
X-Received: by 2002:a05:6214:5b08:b0:8ee:bb17:7e2d with SMTP id
 6a1803df08f44-903ffc615bfmr89512666d6.25.1783931134594; 
 Mon, 13 Jul 2026 01:25:34 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69bfd7a20e5sm6378413a12.20.2026.07.13.01.25.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 01:25:33 -0700 (PDT)
Message-ID: <f32bc1cc-7a14-464c-ab25-bbac3dab8d46@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 10:25:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 010/134] hw/avr: Give onboard devices a QOM parent
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
 <20260711223707.42139-11-graf@amazon.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260711223707.42139-11-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA4NyBTYWx0ZWRfX6Qk2PerKK9sF
 K3JyoHJBc/HAOlU7/Q3SR/0Ea+f+q+oj1DYeFna9u8hDE8grP4IoGcm1WYOd446RQvTcyK0d38H
 Yw2RtRmv6rDFFgAwCYQRrk3KxKaqzss=
X-Authority-Analysis: v=2.4 cv=OsJ/DS/t c=1 sm=1 tr=0 ts=6a54a0ff cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=ZiMIAIO6AAAA:8 a=vggBfdFIAAAA:8 a=EUspDBNiAAAA:8
 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=KohFQSMcaiS2QNUyYz07:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA4NyBTYWx0ZWRfXyOvrC4cxKqZF
 WKlzgZ9KM1OrxpIuM4d0qSYfr6DsDO/PdT8PKwME2NRl1GUx+2kmfNvVi7qw3VkpucEuDQojjkE
 HrLnCUydmqng0N6bd1Iaom2n4Yd81Pg6miP2MrIBAPvuLxHXu4TEL/f1rvqKT73FabEwiNAjv/W
 T3kv18nMzsjsdrFO1JfLKzqiv8igVqM2rI/4WD2UeEEbzuSR2TzUWgpswUmNrHJmibqnRGV3dWk
 UbrCVlX9Q5DIeKZ5PxMgOOyKQiSGbgzz6k6m82gnZcGH7fO+DQYfOba37HZ2bAg7JpGGLOW3o5o
 tpdU1uWfomn0/VCFW2UDhaROjnLjiqEIrxotGke+bSuyKNIhlpNbj6X8V+e1kRCX1OS39CEORoO
 JUrCra/kMuO3n1RQaZhWTrR92o4UsxRSQ+djyjE3sxFJetVqHNSh4YxEF380Z2cQZAo6yMAGPJA
 3fumXF2ibIpqp5wddoA==
X-Proofpoint-GUID: ZPbIR3hDalbCQi-uBG24uxg7O-BUDJNE
X-Proofpoint-ORIG-GUID: ZPbIR3hDalbCQi-uBG24uxg7O-BUDJNE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
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
> Convert the *_orphan() device-creation calls in hw/avr to the new
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
>    file:line       | parent       | name | rationale
>    atmega.c:287    | OBJECT(dev)  | "io" | unimplemented I/O placeholder is a fixed child of the Atmega SoC; SoC realize() creates it, SoC owns it
> 
> Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
> Assisted-by: Kiro
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>   hw/avr/atmega.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

