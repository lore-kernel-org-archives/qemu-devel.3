Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D077C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0uLs-0000yC-Uz; Mon, 31 Aug 2026 01:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0uLp-0000xG-Ay
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:14:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0uLn-0007JX-UU
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 01:14:33 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52I4p1933542
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 05:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ky+Oubql6ay0BSBRazstaXhDAnOUgQreUl1P7QOt+Kc=; b=eb9qZ1fN1ORahnri
 4tK2OMRalZXXjQRsThY2YJfNTjIOJMBtdFocDoh9GEGUgQIjqUpssLAWIdjBOm0V
 1/P+MMg9bKa0uhoPAx35Uz8FBrqU+CTWfAJQV6hOP2uxbyerw2rQnToo71A+8/d6
 08QDzXKWHw0Hqx1DWCE9OuHceNd5RXLjcMd2QkH96YSxhj6D/suoKfOI2H4LqVb7
 tqyv2LngqjK/6iAtUnSNa0nTkbaWtd0Hn6i/6w58Thktf6QaBIaPtLDPu0QGq4QS
 TRwrlIfKx53zUUgJEFiPMQqythOBm4Qz5rGfQhR+c+RZUt4GOqqT2CZ2axCkpKK8
 11ckYw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbrq84g4a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 05:14:29 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e820609d9so620164085a.2
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 22:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788153269; x=1788758069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ky+Oubql6ay0BSBRazstaXhDAnOUgQreUl1P7QOt+Kc=;
 b=e/iVKvXs56IbqDPZszBErfcYPtyJ4345HBIzUtah1pg3Z50eG5WxsMZ3vL5aRUyGsm
 0gxTaR/GZfumglizZyoR6/lnQLNqiIKyaP8KoorujUMTmLwUCLriUraOeldAE3S3C29w
 oqyuvDScv9RzBvUmtJKyAo0X7Gda+FgozLffL7pybJQxtQ+VOMNxJcxOkOHyacyyQ6nT
 1H1HK4K/w/0RTqiERDDJZXaLn1Mo8qIa2kIk5K/mo/6U9IFyQmmxjIbq5+VDBUz6rasp
 CzNC07rMa1PmUYittMKORocsfDE3pNUIzGPRG/1ndohRixf8LL1bf59ux7mIrskNVLIq
 ovhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788153269; x=1788758069;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ky+Oubql6ay0BSBRazstaXhDAnOUgQreUl1P7QOt+Kc=;
 b=iIICl2FvvJji4kNVsBdYpDohE6m55l7Q45+3CbvIE9rrIICqZaoPH2PVjxx+ShyMK6
 WLYkZWce19pNH+js8puvazTS2C1Rz0YVcUABp3qgWvBcSHaw9bUeQ/UnH0aKGId5cxqw
 QYq/Bv5xXplsavb40f9JxgNc0RMreu3MwzDN5OddfdwEG0mOaVoO88xRq/7MU5hpI1vH
 FCGqhu8Mwok2su/1N+5ZqsKA/kpfSD/gBobWfXc0JmhgfxmRlqHk0qed10Evpm5odiet
 OZLSRcXHbU5TEoIaFeYlowUIt3/2Gv4z/IRQh/c2sUDiOhy7kOhMi+8LbHuAsvSvx9Cj
 R+nw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKIuYixzKnxR1+ti+HwB5YqIr0UAb+i8HUIsUElFefC+rI5bDMUC7+/6n2z1pn+RDuCNSCdKP1A2PL@nongnu.org
X-Gm-Message-State: AFuF++n3/pYUwdeW2H4xYvMbx6/382c7R6bgRF/Y69vEG1SOJ9kHwdYr
 gEVRH8u5cZb3LObvYa83+Z/1SR6elgyLNZfZnlTX1M/RV88X6myrcNfLfMHfyQitcbMYKTauQia
 DcQS0iEkOpTtHIFtRkFRouD93cTmj9X9RVaeVuXNXGnS95xCwN7cGsPsyWw==
X-Gm-Gg: AR+sD10lFZgJv58yZP2Hi19I4UYJVt9eWT0lIhtGRE2/E3I5KsRXliLL4aWIRgPAZfo
 nQjrQbOlgmGH7hpxm1siwTQHWpYYRVbw+u7ZeAEDytyh/dHG+YYPcv0GDQttZk0mqjGkHImyx3T
 IJULL8XjiXZEdpilS9wJem9xUitDZcJmyZgWK6jZrqrS3hKCYXnZL36OU3Baw/z+XannY7Kwbhd
 RcyED2fF1jpvwAqMOnSM1GTMqv2cTyjpoKsX8yLud7o4JsRq0WBwAsfuaJOScuV0AnWz27UzL2P
 CNuorrrepSkJT/v+LNfBx8Qmnen2Nv3pPb6zgzbZtptJIA/+d+HWLfo1nse7V8HJhmPOSpOm5MP
 Ohu2h31p+PjT/gxIDE9Z2GITYuap+DR93hQ==
X-Received: by 2002:a05:620a:1a1a:b0:92e:71bb:d1c0 with SMTP id
 af79cd13be357-93942855b42mr64572585a.15.1788153269042; 
 Sun, 30 Aug 2026 22:14:29 -0700 (PDT)
X-Received: by 2002:a05:620a:1a1a:b0:92e:71bb:d1c0 with SMTP id
 af79cd13be357-93942855b42mr64569485a.15.1788153268616; 
 Sun, 30 Aug 2026 22:14:28 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9500c80asm299372585e9.9.2026.08.30.22.14.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 22:14:27 -0700 (PDT)
Message-ID: <ba4efe3c-015d-432b-b799-b36402101103@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 07:14:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/16] hw/riscv/atlantis: Rework device tree creation
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-11-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260831021500.82565-11-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DRCWgIgYUyUZh5krB1UfeLSsP0NhchNe
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0MiBTYWx0ZWRfX4emyEUzte4Ws
 XM97xNP66g37Z7peJZKt5yIFNh1NliiacqFG081QH06qbaXLOEHqFQzYJCMqEoMX0DYpab0qcTb
 i7jm8gBAkF/tQMmvbUa/D8fqAjdE/7s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0MiBTYWx0ZWRfX0N2gZJejGypA
 Aqz4jT9RxbnkRyW0JhdTta2uLsQAko3uVSLUnh1Ezji6e2cnjWGJ8pzDbH8h4r/t5Iurq0tklKs
 VnTZjw9OtoKU+lx6MesGDWK7vnJoOlxKLEH+eEnmkGG9Zow/XzuH8gY3NKDZehS2IIBZ5q5NkLt
 Qs739fG+AhsIx1j9YNapTZ4ro6HUzogo4rvTBBSznKbInpr/g+zeUQMqkvBjaZEwM2n78Orqx0+
 7iw+RAV8zX5f1wEp1lJLu6Ck7RepP9e+BWbsW8aRWK8RmLq3VX3zERwPgLr3Huss73c1czEr/cQ
 iJeAIhTP0xlBM4Tq/wHTl5NrxijzSYTP9HauYLq7OWzFZJ/Bm6CS+Dl4x9aBO2Jdvc50E8UZ/sy
 ISeo2+/jxsq8nneLOPHZkHXNN4Ev0TJyrBUud+RuJF07KswtULn83uYcFLx/awILJh+gOWG1Lot
 GKjEZvuBHbnKbZZFOgA==
X-Authority-Analysis: v=2.4 cv=ZOPnX37b c=1 sm=1 tr=0 ts=6a950db6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=MixTh2NVsqCyUEpE3OoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: DRCWgIgYUyUZh5krB1UfeLSsP0NhchNe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310042
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

On 31/8/26 04:14, Joel Stanley wrote:
> Remove the direct use of MachineState from the device tree creation to
> allow separation between the SoC (TTAtlantisState) and the QEMU
> MachineState.
> 
> Fix this for the device tree pointer by passing it directly to the
> functions that use it, instead of casting the TTAtlantisState to a
> MachineState.
> 
> MachineState::smp.cpus is replaced with TTAtlantisState::cpus.num_harts,
> as these are equivalent after tt_atlantis_machine_init.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   hw/riscv/tt_atlantis.c | 51 +++++++++++++++++++-----------------------
>   1 file changed, 23 insertions(+), 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

