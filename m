Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58398C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wutwI-0001uW-GN; Fri, 14 Aug 2026 11:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wutwD-0001sK-To
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 11:35:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wutwB-0007GL-Uv
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 11:35:17 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EDxJpO1505797
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 15:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 utVvaMh4z80sbHWCUqbOZNquGsboFlauJg3XBGiQKp0=; b=LqJaufYQ8tySngxW
 O60YLSQ51pp2K72qU0aLzU3D1lLh+QFqR7Rc+NG3HrHyOL2BNJN8cn2cUPaBaF4j
 qj/RT5hEN9JlTLJENipFEZXxl1/aNP4MxHaYZdYYwfWLoFsB4BarDkBbvmctl5Wo
 MQbAn672bNqEPAR3On04W6rwydX8TXTcVsE1ld/FQT5050mvUEuucNGQieV1KYuk
 7+TWyAeds/lCgwcCFUGShfoyUWXVKSKf6LwAwruYsMs4cVRL+VDxrvNh/DB/h9Dc
 OrCjvUmL54UhA0FrwqGboK+03j1GpU9VIr9yXH4QXFDYa6DGBdrUXoRRcfjKL/hW
 M8+SGg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1v8ptq44-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 15:35:12 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbee6bb8408so1213707a12.3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786721711; x=1787326511; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=utVvaMh4z80sbHWCUqbOZNquGsboFlauJg3XBGiQKp0=;
 b=fY0wDa/gzoS4HPAdcUhSjCttwL6GJTrJ4Z64EEUtvY7i0g/mFs7w0GrTl06Zzr6YUb
 2aH93kkH6k+dOKAoW8nJ+Sgbq0Gx5/EFoO9GasMTPG4kYBlnIDTrmm9muCSQm2IgA4JG
 /plERJH8w5QgOSEaEY5ovtgsCKQvAVSI9R2AAsJdZSuOBAzrZ6mA590DiQ2NmGIXgaX6
 EWpVmUTmIZ5JwdxyZk5g7B/MUKQfouJWZugh7wE1AlizurLC2FR3BkgB0qK2JF+JYefK
 /rC6S7xdEJ2EKP8NyRovhqHPQ2DGXPB8a6+k2wn36aJhBYhKcA+f5AidaOI26142Viao
 Z9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786721711; x=1787326511;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=utVvaMh4z80sbHWCUqbOZNquGsboFlauJg3XBGiQKp0=;
 b=bfXzVGHZGqWh9qR4nYccbkPFJ9Gp9JB4pr0df4eMR55qtRWw9u2AYWe5K/c6+fDohZ
 y/fxKsyCwt/TBKZc+5ir7HWlrD0NzkY/5UMKVAwBlyneDCMLOnQhdGPnetYJV1mtHO+K
 XwUd/g2iQR6YjT4ZCDZIyvTt24evur40zD4aNzD45+/EhwdKYDbaxfQc/sLECAY4m+ux
 2DJene97lqlmJhFktqQ99vc9hn5WwhpBui3suKzP3aMts/7uXHtwW23C/F4WQTWVLH4x
 NXIxdFWX2RpHmIWkc7uHJJDSWzBu0yYkj3uY0ZKTuWeWaUm6JPGh4F9RHStR633hjfnc
 C6Fw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBado0r8aDZ8VTok5dwkQvrqzLax68wSoZfAMmragEi63dXK2hE0EelpoC73e7kRdSVaiWhLtaOXn3@nongnu.org
X-Gm-Message-State: AOJu0YwNeqde3pD4tu5kus7qvEmUHHG7cJWSRk3k8XnRM1eMVyVZO0mB
 EuUFQgcLc5RCRptGYzwtOH+N4CEohhbPom/7lh6wpWMOnhZL25BMUeZYdNL+at/Y7afgN0vYMw7
 lYl8zeYdgDh6mdOpSy3sCL+Fr9Ls14QaCxaBO8WqgA7AIGtSpqVj2X5yjHw==
X-Gm-Gg: AR+sD11jg1mPvDz0JxbiMkRV4cG/dDv5+RcBBhXKWDbAGUgsG0d+JHOkLBC8n6zp0xg
 Eq30Q9sqaUh9fNwiwZp75aaN0Szf2ZQdjEJOgeU20OsCtLPULCWg0TbvEHhtB3c1Hg8wktHy/6T
 bD9JHouIpVOz11YMu74NzLAfvoq+f6g37evF5TrnGL0hapQpw5Tg3LZfk4DRxR/N3eimXhWp8u2
 B88pGsLDA7lg5aev9xmo7GpjyY74Oa1el2zo9/J2cCKBVcU+iXZzhPJs2/tnEv16VEeTkGS0wUG
 inFoJNSlR0Q2PG11Z52MJOP6B2qkS9bbhqrlZonGiwcYdPkVt9Ti3M3pDv7AtK893jhJnw1aAtG
 RQyGIxjNsnpd99iXwcidoDErYBayk0msR/KBYdSXYISm8ay/69q5Bk8+CDrJeGvg6rw2h
X-Received: by 2002:a05:6a20:6a1f:b0:3c6:61b9:917c with SMTP id
 adf61e73a8af0-3cc71ced6e0mr7086662637.11.1786721711276; 
 Fri, 14 Aug 2026 08:35:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a1f:b0:3c6:61b9:917c with SMTP id
 adf61e73a8af0-3cc71ced6e0mr7086596637.11.1786721710733; 
 Fri, 14 Aug 2026 08:35:10 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1413889bca5sm15132827c88.12.2026.08.14.08.35.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 08:35:10 -0700 (PDT)
Message-ID: <dec2a5af-dad2-44c6-8eb5-b87ff9595d7e@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 08:35:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Restrict arm_do_plugin_vcpu_discon_cb() to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260814080507.23196-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260814080507.23196-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=K4MS2SWI c=1 sm=1 tr=0 ts=6a7f35b0 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Et0EIf6WsffwpvoSOt8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDExOCBTYWx0ZWRfX023tML6PVsWY
 qzdk95x6ReorzfcYM8RgtWLI74Maj1Y6NPIQpcfWrSerWYZLL30SnlCX0gL8QwyOfAwRcu85Bij
 9cDYds+92vPU0rBulkA04Rrjjc9cat0eVIkRhHvNI0rGrpXbstjqCVjgHj6ZsZV/HraGsbD5/N0
 encVplKdzykhGS+PC718j5Vtj7IZBMUAgmEDCyroOM+sGiNx8pSWK80VWAdDTkDHDwnkmc2tfGX
 tTRA678Oz341yxoKSUI7EBjbDDSHBa/fdjlsATeeLoo7/LcxMn7QOnOlbNK7+UE/9+/mgVATPfN
 I49QdFacNyjxtfR43saJLQmnaY1w4Zi9Fwr9Z640oASrPLhmFyWCm4npxEEGN71l9SKXDoYkJRO
 WtzO0Qmg0xsLZK40dcv5i9VLrrr3dTpqzPtJOH3dLV5Wy97oV+wu4oCpu44xVYpA/q3j2Nwms4L
 1eGTntTPM5ItHL6d9gA==
X-Proofpoint-GUID: Ifxhton_1U-CmogvHBCtQEa8E-MZhisk
X-Proofpoint-ORIG-GUID: Ifxhton_1U-CmogvHBCtQEa8E-MZhisk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDExOCBTYWx0ZWRfX504yPMjvgRm0
 NMYUXx+z8s3d6MW/yPDoeiNsGYx2FP3n1Ny71oK6MSpav14Gri8Upi0EltmnUd89N7/87X1+NSt
 9n1m6vc3C+h85MMxaa0yuUt67yLEqgA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140118
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 8/14/2026 1:05 AM, Philippe Mathieu-Daudé wrote:
> So far TCG plugins can only be used when TCG is available.
> Move the arm_do_plugin_vcpu_discon_cb() call within the
> 'if tcg_enabled' block and wrap the definition with #ifdef'ry.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/arm/helper.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

