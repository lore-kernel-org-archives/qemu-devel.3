Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F06CD4851
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 21:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOMhN-00077r-Ub; Sat, 16 May 2026 17:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wOMhK-000772-Bp
 for qemu-devel@nongnu.org; Sat, 16 May 2026 17:37:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wOMhI-0000Wl-1E
 for qemu-devel@nongnu.org; Sat, 16 May 2026 17:37:26 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64GKXXmS1861748
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 21:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KI4v4q7laIlDS7q5LjsUhVF3mJ3/tKJ89aJJwYZvF6c=; b=NxgjZ5fythDuKM+/
 XoGZ5rDU5ZeOXxODFkMdEJxWGSZ4XP7z5AkJcclEDAtMridQacz10k5x8dHjCzOz
 WWTi+4eK3seCiCjJ+I4aGYz5DfUAO4D+1iLSOWxmV5SwmoXk8HiLfPFw7pt+1I1e
 lvyLfSRlaAILstBuszsdHs3FRGdeVSHc2VWmAAGl5Qf0UBbCYbAOgbdPxcDHNZgl
 hBVhUoK2wj4d5WzofHeCHHzyH+r8BTW1W6evB+6MTvXlOtxiKr2ah26rW300DAXL
 RB/xZMHsrBS4sMXo3WLlqOFkEFDNiJYcz32eIWWZWhzNViwbQlON7DBMClvjqbN4
 FMRq1Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6h01hq8f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 21:37:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2bda35eab74so691647eec.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 14:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778967439; x=1779572239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KI4v4q7laIlDS7q5LjsUhVF3mJ3/tKJ89aJJwYZvF6c=;
 b=gkmF2DP8JQgW0AoxY7GURaQ5BO20sQXxqEvF0x8Zu7PfxwGxaWZbmJLEjX1NbA20QE
 MTTn7qmCG3bI5WYhKhMn54yiczUKCsWpWrKRkuq7Lx6DUKV2PTnIQxaxamk3pEPIOc3D
 t5whqbp9KHn7F8T1beDPXpI5PQmLu553C6+5LCaBIH/Fj85X4zIrrx6zU4mE+JobI3kw
 KkwHxD+TQnLM8v3Ctmx5c1PPQ1CrUdVoHmtFFjy5aBizlvTbxyIDex+jBQFOvanmH8Ol
 p9G5a7sUWCALEdpK4DdAFTSb6MuVqP0C2Bm5wNfaFIfrdx/pHNQ8THhjeW6uEd8Lv7zx
 MGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778967439; x=1779572239;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KI4v4q7laIlDS7q5LjsUhVF3mJ3/tKJ89aJJwYZvF6c=;
 b=mSJV/V2qt1B4NJDn/ircDQlHp6X2Qjv50On1W+FvSE/vuJpRl16Q1Y6TqwN+je1iGO
 Hy9CUaxv5DSGEemUyu1k3DBIK7MdFUOIrS7nUjaqK1zPjDe+DXz8mR1qScrCNStzvWdA
 hfiIW6iR6QKlEImK1PyQe1ZV8C9lFPsJKoRCUc60NBFWE8H+N5MZRMP5yD0QXnrB/z8N
 D1TW+jJbsYgKLGDayb1hNf9TRvySTVwJHUy2mS8SVEixrv0P7oYN+9lu/C1yXCPayigA
 cHG6hO9qsoykkqcZY0f7J7PM/vDri0XU4RIZakbKbIuV2v2wIGXMcgJmnzhfGcvBw50R
 2/DA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9E4Ng+/g7nZ5YyX7xjde6u+bHAbMqpJ55twrqlLeS9ET2wqUyA4yPUXdMvvaEa9TTKvVhHybjryeFz@nongnu.org
X-Gm-Message-State: AOJu0Yzv0IwHFNR/lyXrJSGhNzogTRUnUsbWQp50rQ2xR8cryjNWZVcW
 jxMI+nElR2uN/MYziDALJtU11G+xWHpr8OwG1jdjsYwcni+dooiE8eGzWCmOdqGo+UFOk6xzOQU
 +W5H91+mcv+9nTxQFluKzrsyTc6kpMgJO/vmcFa2z1C6U2xyi/RURi2Iv+Q==
X-Gm-Gg: Acq92OHqYVuITOVRPJaj5ajhSslH5N0YqMdRecze5PyIira+uOboBDs9931JfewFQkC
 2zf6dpFRuqbq5wC6p1uREjxsUTv6B2YZgg2Sle4w3B8v5V5XgnimzbHRdS6Suf3O/KPuL6E3/3g
 /7tR9YiKx3wuuWGSj1qAiJJFhvUg1yDPotl9V4qy0TKpCOiiN0FFMxmnmO/SEslXLJ3kMr2kNnL
 mx9vbNXZG9BnM+uC2C+wxR5ZflLmvmVnvFMsmgAhm0FC7NPWtPsybac/l7WvlLF8uNMiYO43v5g
 DBdiJaGhcQqyIrhB08bRcwfZX8OmQ9+w5Bj4czF8A1lOy7DRriHBmuk7JXH/cVvtq49JS4QsWBz
 xCumvqm43FqzkveZrrIECqKrgG9dGnSW2y5U7nyuU5vk/DiabzgpyvTvqnoiK6+gQvjUH1aeqXa
 H9KsuMvYg22qj8Kw==
X-Received: by 2002:a05:7301:1984:b0:2be:9c19:b34b with SMTP id
 5a478bee46e88-3039785c745mr3778736eec.4.1778967438709; 
 Sat, 16 May 2026 14:37:18 -0700 (PDT)
X-Received: by 2002:a05:7301:1984:b0:2be:9c19:b34b with SMTP id
 5a478bee46e88-3039785c745mr3778723eec.4.1778967438174; 
 Sat, 16 May 2026 14:37:18 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e6a9sm10286993eec.2.2026.05.16.14.37.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 May 2026 14:37:17 -0700 (PDT)
Message-ID: <4fe8e2cb-8a5a-45ee-822d-2488dbec845e@oss.qualcomm.com>
Date: Sat, 16 May 2026 14:37:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/21] hw/arm/aspeed: Do not realize 64-bit CPU types
 under QTest
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Laurent Vivier <lvivier@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20260516171524.19184-1-philmd@linaro.org>
 <20260516171524.19184-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260516171524.19184-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hYoMsUZpq8yQbkPF6pma-6vmjfUPAfXU
X-Authority-Analysis: v=2.4 cv=XbG5Co55 c=1 sm=1 tr=0 ts=6a08e38f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=aow-egSQAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=RhXjfXvIr8CSHO81VaMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=gFNbaldVC-z-bsjSTzMo:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: hYoMsUZpq8yQbkPF6pma-6vmjfUPAfXU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDIxOCBTYWx0ZWRfXxK8dysuyuvoB
 wLJ1Y226U7H5isUaDAqiPgDRfI6kbWJd9+F2XBYgB6SSBWAaQ0ty1JgmJRKhwRqE2Zr89a5z7eH
 8kVQ1fQwkqvuGUrF2COUm9EoTqaz6bca/HLTtjCSLNghelajp4FHjTujlvMNxNyUvO60L37YeQ2
 qiNAv24rLMyxjCiuHMSTfnojHVS8QR6qnxbmrghp9cG+Dkak2Bt3tmln68foLDTBussxOgNv5MN
 fsYxvTrKKiUw4MA/GQrRcJitHVgfGs9HPA18LIQR0C+Lq/6NthLgJV7BgA+oX7ZdEi537naBwth
 CG0cWUvNT1IXmPIogdmOYUZgNRp++1wAPJE/N/0WW26jpBvIxyN7QVEoW5lRTHUtkkfIPG43Qi0
 lH3phkzwiXQaZkUkNv6yr80j8zUzpdVXi2pHil4VFpcnSua0NGtWcfGMUD6e3zl1mpBVE04kX7B
 8ODx5Ze5Ldu8ObyESSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605160218
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/16/2026 10:15 AM, Philippe Mathieu-Daudé wrote:
> aspeed_ast27x0.c models 2 similar SoC based on a 64-bit only
> CPU (Cortex-A35), only available in the 64-bit binary.
> 
> If we build this file as common object, these SoCs become
> available in both 32 and 64-bit binaries; however when running
> the introspection test on the 32-bit binary, the init() method
> tries to init the Cortex-A35 type -- although not realizing it
> -- which is not available. Simply skip CPU initialization when
> running QTests on a 32-bit binary, asserting the realization
> step is not reached.
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/arm/aspeed_ast27x0.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

