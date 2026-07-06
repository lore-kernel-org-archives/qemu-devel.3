Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C371FC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjIA-000728-JD; Mon, 06 Jul 2026 09:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjI2-00070H-7z
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:23:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjI0-0007kD-Pi
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:23:13 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxGBC369006
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l1Vypo44nuoRmMbGeAqxoVIXpWzcYN9VIKeAKT/VOA8=; b=olQhxO8jWfyHYwcX
 srKflWX+RKAKB3C8OiSR+DN35bgay62AKpZD6THeOkF9mhsHe4F4NIVwhLFOnI1R
 bQ7v6FSBeKPoHJc08fP2ppDTBCyC+sYbbZ+52qPh1EZ4Ryuujhv+XwKcQL07Rc9L
 ZuZn2BoDz7ZJW7D7SJGN+ELXHjRzPhIzAEhlOnufwBNKhV4HNjaau2KFTodXTMJN
 honzxe74qzqVLzVPf8dOnvD+ZuMcOBcUm5E5AhTNsbuGZwt7QTCnldQIRj6/08hp
 DoiOC2B2WioVW/wAgR40O88lYgaaQM/3fsQNilJp6PHjBflSCgUQcoSFGs4a8QwW
 fgFF3Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h998d6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:23:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e55721a8cso309826485a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783344190; x=1783948990; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l1Vypo44nuoRmMbGeAqxoVIXpWzcYN9VIKeAKT/VOA8=;
 b=CYo99EvjQy6kM6SExQXeXGDCMiU+X6cEpdM81SPhoPi6yaRLcOZKw2fBA+g5iQsnV5
 a7PdpPKSyAnt4x7zMYYE6np5dO13rHXYsd4nGeVRYIr3gQ0f8tb4MOL+lwaqIdDl38My
 EoaSl2AaxRh4pl8bPTt9nTJOpYT/GmUZUkQEU0N8V7y1MIrhGF81S8sR5CtjYVXy7+dT
 pU2g54RHqDUttCgrLj9zsUga55Zhup2KWUULnvVJppuZJlP2sSh6npgy3Tr5t6tKm73P
 objKGGF2S4PVjmzYJz/5O+9Sp5+S6KC4TUO081EoX7su3nTDT50/uFFiFPY5Bi2X5Czo
 T6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783344190; x=1783948990;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l1Vypo44nuoRmMbGeAqxoVIXpWzcYN9VIKeAKT/VOA8=;
 b=YX/6yRnQ4E/r5BLsZBDj7rqMWW4getrsN8Fb6r4QM2lxmQAqm2lw89p1PCJ430IjWl
 uKJH++bLPx0gJKX/pBP3Ls5QnMbAMTi52CooKhCQHecChqhhC2fBHEudDN7kd7mWEN/U
 FV5EgSlTke1crcf5nC8VIDlNoRc+kkzA9UNtmwzwCwYhLOHrMDgYdBPF5opT6dhFF5da
 brXZ2ER6CobMm90LNXh46pcHG4YjDk1lRvq+pJn5pQBfsbHXtT2BK6YDN9q89/ImSq4b
 22kF/HxcQmS8b2Kzinsj4wtRiJZf/2V/NKTUqU+9pX7p0rRHXe53I5p4RlPA19DsDlNr
 asYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrhyhSb2WQ/+hfJMNJsfzgTSC473bljXRY7kMLLcYXIqVfsPYjahuGBKhnbbf/6wITnVqL97cdpbHGW@nongnu.org
X-Gm-Message-State: AOJu0Yx/qc1rnuPZ7OlzekQ/RC0B7iZDzGuz1bu576c5LS5VEXPbvNnO
 bWmkaDU9IYDWCNX1MwYlU1WdzIBnpv9PAE7Ddt52OJhz+eGV7IZeagZ65hddvH2Dx6FW7d77Teh
 zac5vQicvvcCbuxTXTCrYtPRyUliNNLxJx5zMgenejtu5X6rIAqrQbIsu7w==
X-Gm-Gg: AfdE7cm7ZrmMrvgdIl2ssC18CzxoeKsM2+BfcBu+EyzaJMrFdEJ1s6s6vJbxlCWVm77
 KpcaPRk3peHicrL77G14v2546PlPIzt36Per2Svek2HWs1+80frP6IK5/ngG2XS9UWBVRei9P37
 tNsL+/TKQv/uJ7ElXtyWDGkWC66aMZsQx23E05OoDBitTkn58l7aNUlbNUgpgVO1iBuRTbdF/Ph
 4aGq6lVmW0il1PUFPBozt2A1evTdLBqRELYk9E+CnEj7wbpkmsUGYAEoBE47yhzPNzELpxUP+eX
 v6adIW0sgynmbsnMX0ZvSbHZ30WNugUe5c7xTCy/pve3JbjTXMQO6agNP06UrJ3p0dhpwo7w82G
 Wq8fHP2pKHWJwG6GHHzMfDqVsDvKGzqYf7NZtxdLg0GUU1ua/aQ==
X-Received: by 2002:a05:620a:178c:b0:92b:6805:91a5 with SMTP id
 af79cd13be357-92ebb5af395mr74245185a.61.1783344190121; 
 Mon, 06 Jul 2026 06:23:10 -0700 (PDT)
X-Received: by 2002:a05:620a:178c:b0:92b:6805:91a5 with SMTP id
 af79cd13be357-92ebb5af395mr74240385a.61.1783344189497; 
 Mon, 06 Jul 2026 06:23:09 -0700 (PDT)
Received: from [10.237.61.207] (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c636ea60sm328344375e9.3.2026.07.06.06.23.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 06:23:08 -0700 (PDT)
Message-ID: <df5c8b9f-26e2-4286-87f3-8f45288f247e@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 15:23:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] hw/net/can/flexcan: Wire clock control module via
 link property
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Matyas Bobek <matyas.bobek@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, Paolo Bonzini
 <pbonzini@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Francisco Iglesias <francisco.iglesias@amd.com>
References: <20260702184038.178196-1-shentey@gmail.com>
 <20260702184038.178196-2-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260702184038.178196-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: G0qNoe9mDdozc-OaFGFgd9l2dXHj00HS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEzNyBTYWx0ZWRfX+6t12MJHtynq
 QKzjwbu69XTdFGG8ins/lfO6apajEvkojA4cn/95kflIXht84gnW3lwONGyTXUvtL7rAZRBWgo9
 qLcK8OHq3P1uu5FsFSqJ0c6xJnNxHaI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEzNyBTYWx0ZWRfX60RcGp0D/kST
 vNaSGORSHuUAZEj5QttTAsTkk8HSE5oE4eO6j60OgKaN6CgTO7Lr+1E0i+JPC+zFOl+4FK5Cl/a
 Gng4s76s8HphhRV2UYacFK2kxMn9xGMWl2la7XRbpvKjuSZeP9BdbNdOLBbpM/XNRHCom5IFQrf
 Su1iy58bLo1XmxHwXW+bi35aWlBJu1QUsD/LPYNPkZwnkukWhhfk5eb/VbQrN3y1AUDiSxJQNGv
 MYoisufSFbsEjJHxT1nWaWXIBbPiZ5LtbHI8XTk6254l532nyv8Bno9LmuAQZjwdRxKwxiEWyTh
 XVq1mmVMtlVIztlMlpFwjGD+2f7emSKuhwDKKOyc/so97kUxHj2Cd1x4/HzLFa+2Nc8UkzTRZ70
 VD5rH+KZk7HMgeAMEalZC+ZAk1Em+J0Z6X3+UNehYxQzXTWBT5Obdh/CHtnosiwGNxYZaKynH8k
 9PlHif5Ix91yEzDUeYw==
X-Proofpoint-GUID: G0qNoe9mDdozc-OaFGFgd9l2dXHj00HS
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4bac3e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=3vsBvid6nmlQ9tsTqnQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060137
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

On 2/7/26 20:40, Bernhard Beschow wrote:
> When wiring struct FlexcanState to the clock control module, it is
> currently necessary to reach into its private data. Moreover, when
> forgetting to wire the clock control module, QEMU will crash after the
> guest has already started. Fix both by letting struct FlexcanState
> expose a link property whose sanity is checked at realize time.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/arm/fsl-imx6.c    |  3 ++-
>   hw/net/can/flexcan.c | 10 ++++++++--
>   2 files changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

