Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFEFCD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXdSg-0000Ka-GF; Thu, 11 Jun 2026 07:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXdSe-0000JY-JF
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:20:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXdSc-0007qu-J8
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:20:36 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BA1qCP271475
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AD/Q7/2636o3hlObJyzSqNEjXF0nwYvyi+Igpex9TlQ=; b=WWdnyq84GjpkYHad
 GGWfq3qyW2tV83c3aYdK1w1hSYVM72VM7rxPRKX2teKuxdsx7Hc3niZs1M0+seJm
 hj7AOvmjFYHd0bGaASSwoiScPG9GBmGIyt3WSTxs8xY25gV8zmcbwFtWwYvErRF/
 2zg/B1tJseN7FAqYkKekPJSQF/JeIIou8YuD23jjfjJtv8Q8EQR18zngE9zS/URP
 4+tAO2QawPZsGC5NY1MIKf/Od2jyxXPSDTBClhcynRIRs88lBmXC13rxGkMwLVUt
 zTEzfcsDZoX5i1TZpNPZ3ia87+0jBf19/3FOHPvn87JtUT0GEqV3RgbtljuHoDwH
 +ky/YQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe71k7dm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:20:30 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6cfc66167c4so2956969137.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 04:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781176830; x=1781781630; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AD/Q7/2636o3hlObJyzSqNEjXF0nwYvyi+Igpex9TlQ=;
 b=HIEjC/DTDcwk1t5wbEwp27BRt0BOheVcGtQJDwmhDG7yWxtHQJtLwfFY/r20u2B4g4
 E7dMlyDmplnTjT416L/nbVlzxYzZZtLwsxsind2H15YoX7z+abU6y4s+oW3QZA4LkYEp
 cXVecYL1VWoK19f5NIkK7HWkBFO2+ynlkgghf82Ce3KEeBb8h8wGreW+/NQH3K1wZKDc
 W/a5NiaIePLxfD4aZR05Bj0tQtMUDJSxGvq4JCpCBqpHjGsjx8Kv9EZ9ydBoMDRg4/+2
 79lZOgTe326YJ0qILBjEckYYK/SSBlqHtubtLBHMIzSa9359l1nI2zjhQfgVLqMXuXfS
 l7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781176830; x=1781781630;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AD/Q7/2636o3hlObJyzSqNEjXF0nwYvyi+Igpex9TlQ=;
 b=pcDeooE6GxV76IGaYKGNXt4psN6da67BzbPynMLYPnYn8IJldo9qzvGpRRpIjsBMhz
 K/w+YMsJ7Vi5k/rwVaL6n/6QCpXTXvdOIoBSw2jl1WY7l8jgorrXXG8tgB5rwR22tKQ/
 b7Ix7t2eC+MrnEd3gXHgs15uUaRuoq+u/onq76j0v377/XYLESUsyW3hmx4ImGQFYbsm
 Sn8KgFzbcQA6BP5mS4XsleD0G2Zvv7spxcvTFoXjEXUB73cDof0iSQ+fjR+Xeis1YTCV
 KZjht7hqnmbXjMUOLw6qkL3Ux6sNCJNQAGzA/1082jsyAggRwRZMxy6YHiDD2kiRp+wK
 GH+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fZG+4kvUVd5+hJh9hsjf5D6QSyXE8iLiYwsfBRtAuCMNQaTFUyHROTae9z4vDNrgCpmL1QXhfHSQr@nongnu.org
X-Gm-Message-State: AOJu0Yzn02SAomgbJuJMqC8tFA38104oNs5a3u/C1v2QtN9+/EUDESvR
 2f5BLJmEYqixstrw1ITYraAsoEL5bMwuHlykzMLq9OoHaZ6gGb8zrqXrZCY4p7ZieKgaDsSAAE3
 zzVbDhErTQmePn94G+AWUfWX4y1raXzutbhtMUdjIKvNo5KKIB5TVjhpgXg==
X-Gm-Gg: Acq92OH+VbYx889NVdpuKGhs/6bdpxTOTX810STplJlRvQN9fXsLnkn0XKNiMkpZ8O4
 hPxcZyHnPlbQor5hKH/S/NK+9tc644m73jIPirQYZCzkSLfN9ZY6dABOrQO7haSCkyyDnMooexz
 rZ0zjQbd6azCQLlYdFrAvSxOyC+G1/t58M+vE20NkZSVlSopusdA+EmCitv/JzE3OfadxBG0OEu
 N00dYCQ/dNkJ8c/ZoVBin5NoKzX027FET378zlVuVmB5tuL7RLp1QKCbytY3B+mWAzCOOg7tWX1
 nq+Fv/phwU+/s8d536xf/K2CJniA6a1Aiwg50D/k7orB5ZMbaVYS9qPGtyJ53swGgtHtb+fgLHv
 Gb5pkMqsuvA4syRqxSYP9woyDPiJfFuMz3T4KVNoYXXVOSguCECEnRG1EoKPNr6Ja+O+CMmUBt7
 AejxgiEVD6q2R+
X-Received: by 2002:a05:6102:a51:b0:62f:34db:9474 with SMTP id
 ada2fe7eead31-71d5f9c6774mr701232137.20.1781176830111; 
 Thu, 11 Jun 2026 04:20:30 -0700 (PDT)
X-Received: by 2002:a05:6102:a51:b0:62f:34db:9474 with SMTP id
 ada2fe7eead31-71d5f9c6774mr701211137.20.1781176829620; 
 Thu, 11 Jun 2026 04:20:29 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2c9057bsm67424305e9.5.2026.06.11.04.20.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 04:20:28 -0700 (PDT)
Message-ID: <63c62a8e-2ff0-4175-be70-0aecd13c406c@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 13:20:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/22] hmp-commands.hx: fix button_state doc
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
 <20260610-ui-input-v2-1-f68452dd6a22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610-ui-input-v2-1-f68452dd6a22@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4SlIuqnw-8yf-qCTauP8HOAEdk-cGJ5B
X-Proofpoint-GUID: 4SlIuqnw-8yf-qCTauP8HOAEdk-cGJ5B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExMyBTYWx0ZWRfX9vQKz59JJAA7
 775biEc+yVRPryucLdCVDNXlUUrepELeaDWBg6xnMywMwQtpAQYdQ14JZWHDJCMN7PdWzKNTzZr
 vEQnjCKOug4EnXr2hKGnfUf9HkzOP+AWKfJ6ytQ0zzEw7bDa52XXOEkr98JHIit+U95g66+KAJi
 m9GJdXHk0kYokxQpSWTtTzrP0sCK6BzD82m4cHhuEmHmUFomiFBwJNWKaoNVvsfFAwdQhTZuqYN
 5yPbNWv4yYf75WYFMZw1RIh/yy5GE1aUznrrcD2BiUQ/DoNf0+G13dm/QPscrb5pGabwKzbDaD/
 86PMz6KhKfwyr11qrpX+M6FFqkduxuxrs8DdxDSnGdAVVtxPMQsK1PYTJq3BJkyCWRJnpj3YEij
 0YkxDWTZlNxueuoqOZD2FmNB9/OwVsE8Cgh0k4fMApGLSiKGG1qeL+PA/8Dp8BCVd2L7o0OjNLA
 V1jtBQMwz3ZNtnreU8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExMyBTYWx0ZWRfX8lvNKtogqEoW
 24QMWQFYP3qoIYDWSyhV0gmWaeF9xovV5aM0rBdc6wrFIw4Ye4hy1h9EPSdsNwokMKL3sJRLjSL
 fjQ74eu09CYxMP5f2LdX93fDXmUNVaA=
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a2a99fe cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=3WJfbomfAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
 a=1cNuO-ABBywtgFSQhe9S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110113
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

On 10/6/26 12:56, Marc-André Lureau wrote:
> Right & middle buttons are inverted (see hmp_mouse_button)
> 
> Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hmp-commands.hx | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

