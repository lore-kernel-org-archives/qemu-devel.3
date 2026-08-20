Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA5CC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx0QX-0005EH-7C; Thu, 20 Aug 2026 06:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0QV-0005E9-Vn
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:55:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0QU-0007MU-Hq
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:55:15 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KA2mUI2932707
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 10:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BpR73BTf1YtpAr3ZE6EiP23yFQwK2M+fAv/L6W7BmRU=; b=jJ9QXHW3LYIlgFcU
 1tCgx4kuUwAEa/V5ZrcUeaRGGu3UouBeXYmhYH7/Z2xZ+OK977RA39/Ja2hJQwGG
 vgrw7w2e166/00Pr/7/OuXgETei5N7ntFz6lrCn/sZZ+BohNsW8S9YZvMGjJ7aTq
 RGg+p2rZv8Ou+oGOvYhQR1/qaGgts0ork7ubAZh3qaZzJFVqvOmwthRJwy3CaAiK
 V7hiHcznSDl4btN+GQOS+cnkEBRyDNCZtWuX5iT4BNM+sk5QK1PGSVp1nusYWqJt
 SXyCi6nA9C16eR06VoHVJ1nQUCV5dHB5SzsybwCE4l2NfGVgDbOCTtFDe7V44elh
 vg7c3g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg0g6md-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 10:55:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936e393061dso193350485a.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787223313; x=1787828113; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BpR73BTf1YtpAr3ZE6EiP23yFQwK2M+fAv/L6W7BmRU=;
 b=jg63fR1eq1R8Wv4inLWl+d0jvEOmpi+Qwozzw5duXwfIa4ylLMhjjZBYS4nPXurCAz
 Oq5Ix4gRzXQvhnT8ZEwy7AwwTaH13ed9nlsMShHU2jccYZAaIDS/EIv6ScekU0Mw0UYT
 k1uYVOxjEzI14j8x18qvrXgV/BH4y6dazeL3+t9EwqpTXuEWi/UndEQ83VxIkiF1pvOe
 nOu2t+dvdgpf2c+CWiJgZ7NC7c4XZi+yhIo4eAnZ8YXnJXYy+WWwgv5HG2VZkoxu2AVW
 Bb3NP3fVieE5ZdKLNmFXyYaPXmpwB4FkVcljggqS0SHkxv9udQOX6PCQOtn6e07DdIMH
 jG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787223313; x=1787828113;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BpR73BTf1YtpAr3ZE6EiP23yFQwK2M+fAv/L6W7BmRU=;
 b=UPMGWzZs7Q9enPRZiLRuculqehJfzde9KaxWeQ2SPeUDhEySYoeGp6oEmoemQdxVw2
 AmxYyumDNg6hQN1pDPbEzsVfvpPjdXxp5pXSkh9xDufOb+fyoxWSFaPJG+YPUikI0feG
 6PsWcSkgjG0XjHzYIfHkQ+9RwVdVzQ2zb0rW1lcb3c5YXgNYUKF6VMgo8qXxx/oOl5qe
 46NpK3ovRk91vhptsdYZnZkxtmrZr9Q+yzROdK6gtEXaIi5SNPNeoC/Az/1l4lkwIunR
 WVdhI9+O/mQYESrp6/5pKwmKJkMeZrgTWPD8cx8vkHEJ5zlAe06UfhelXGFAyMMqXBDY
 ozAw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4ib1/q7aye2rJjCSmNJFjMWxbuoru5TH/Dw8nfJkzJoQEOdmuMQgaOOXLS/pbgGDUPROFgySkiug5@nongnu.org
X-Gm-Message-State: AOJu0Yw4xx7yZOOXd7kwESoXkIt8Nxc3Dnp97XNwp/OexV8JVcHtVMX0
 IaTJ0Il39IF34tEhEwyV6qhnIMeMFmQMp4zKHyebUU1jw/vmmt6ydliKmgqBSFomH78+MmuvT2I
 WDQfqwCF6vvPon6dYOPTb+YWfG8UM3LtTj1FByDJ5tjB+EznZc8Tjk72GLQ==
X-Gm-Gg: AR+sD11LfzivxgtXbdB1ptt88wgQjlLGjB0vseQeKzJO3QFFLfLS5RhK5dL1WgxPr6x
 MDxDrqLPIxr/49AbqVP1AKI258HaViG8jse7WiSykp5zEwWZGoS7BuRmhukHuAh/agcWF7teANA
 QiAX7PO81BpOgrpBi2n4X301CujBbyYjsdOFEDVCOGVUyuPA09xeMEsMllC9RDT9lXrezcmX8PF
 h/+74OVVpnz9KUNF008nMakIaXisPDQyX+EtmxrSxqQfW4geALScWUD4OrvqanzzXsr8q4gc0NK
 EcQV3Ml3Ore92aQ+FDqzyVg+QOdJlcCq4qZQZdDmPiSxLnWAkyg9Y7Z59s72WxgtPF1oX1slv3y
 80d7bzj3BDb4QzeFXVtveIPDDxvocMM+L7OM=
X-Received: by 2002:a05:620a:7081:b0:914:e3dd:17ea with SMTP id
 af79cd13be357-9371e22056amr1039099585a.12.1787223312816; 
 Thu, 20 Aug 2026 03:55:12 -0700 (PDT)
X-Received: by 2002:a05:620a:7081:b0:914:e3dd:17ea with SMTP id
 af79cd13be357-9371e22056amr1039095485a.12.1787223312384; 
 Thu, 20 Aug 2026 03:55:12 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b7d4asm10629227f8f.21.2026.08.20.03.55.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 03:55:11 -0700 (PDT)
Message-ID: <be278ba9-1e87-4def-8bb9-eeb14b17a03a@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 12:55:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/arm: Remove spurious WM8750 dependency from
 Realview Kconfig
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jan Kiszka <jan.kiszka@web.de>
References: <20260819185430.3467629-1-peter.maydell@linaro.org>
 <20260819185430.3467629-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260819185430.3467629-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GK8N4---NpvRNUrlBZ2DlRR-j3azTlzt
X-Proofpoint-ORIG-GUID: GK8N4---NpvRNUrlBZ2DlRR-j3azTlzt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA4MCBTYWx0ZWRfX3MhW7/3N1/b+
 3AHuXbUJteO44KxCkK03OTjb/uyh64N5wGMDfVHRrVy87GZ+nQ6Spsr41kEqOmL5NTtQa54+QMJ
 7uDYrzsAhCOYs9fnkBBqdW84pql706nk9iezKv2YPeUcVd+IoSVPi2pebSYCsz0ZCnII6eaaKi7
 710hSFGdTJVDMQ/jUhSOGfKsKNKjCE6mKShnsFCddGhB38pBjXpFyebhiEG/hdZ8EOe/VlPxASI
 iSJi2q/szg0m7W3ZGxe2xV10UooChHWs7YYGtE5RqAMFIdfgVpljJysC0oYcsgcz5MEsdNamyGH
 65sR26OpowyiffTgCojth5NfwdmRVPa9XZ0P+bsUbg1kfSFkqWxh2WOd0wyQlPkOHksh/AzcVjm
 G8S329ilVrY4wYPxOjFQT44/3B55HBtkqIV7hkHyaYW4rSpB4Fkqh62cOkDsWRXEVZSZhtIRZ7H
 e96gUktSurFW5J/5jig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA4MCBTYWx0ZWRfXwKbIW079RkNp
 h0Oc21AK9eKG308dDnVk82cczkfVX8rxixqavP6ujWhNqP3M1orYeYSY7m86qfXvOcUk8SH+oDW
 RKhv3pUuuCdGqEOjDoxb6wzrs6Hfcnc=
X-Authority-Analysis: v=2.4 cv=JoXBas4C c=1 sm=1 tr=0 ts=6a86dd11 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=NbfgatFzXNzTUJnNQ2AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200080
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 19/8/26 20:54, Peter Maydell wrote:
> The REALVIEW Kconfig stanza has a "select WM8750"; however the board
> itself doesn't actually use this i2c audio device: its audio is
> provided by the pl041 (which connects to an LM4549). Remove the
> spurious dependency.
> 

Is it worth Cc'ing stable?

Cc: qemu-stable@nongnu.org
Fixes: 79e93e24de8 ("hw/arm: Express dependencies of realview, versatile 
and vexpress with Kconfig")

Anyway,
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 260d2f0751..5e9a0bd8dc 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -155,7 +155,6 @@ config REALVIEW
>       select ARM11MPCORE
>       select ARM_TIMER
>       select VERSATILE_PCI
> -    select WM8750 # audio codec
>       select LSI_SCSI_PCI
>       select PCI
>       select PL011 # UART


