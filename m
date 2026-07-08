Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6C8C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whUdx-0002fF-57; Wed, 08 Jul 2026 11:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whUdv-0002f6-FZ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:56:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whUdt-0001bl-KW
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:56:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668C3Mc52579480
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 15:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rl+8Lf3AHaMrrunPG0nqTjSiKI+WxqLQdG06+E4eoQs=; b=lgjAh8AXfZFljlTa
 kMjGtnW0FHui/SENhAxDMcymZidXavl9WBqrQ+ZcX71AIFHjcUXF/ZkTtohvJZB5
 oDLzfzmTeruYxj0YaW/efrX7OCgFMbwRhZBvjyX+/aJ7VwGKBE+Tp2n77Cg/YVoF
 shxWHav5RD3M9HYfFbHwCRJ7KkYYyHQI3UyV+vORWoj3cMY0fqqhzAPtasDLfSZn
 ee8UdVfzoik7p/kc611WJ/1n0EFob9afMq84amC/UWbIzOpRBLdzWpscTK6pmQju
 mMeOvg9dtr8XKE459vgMip4y5HWkbehJHiAi+5RXPCxD0jdvfThNnw5Ru/PzXOSR
 B5GQkw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9b5gbmew-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 15:56:53 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c860544c077so1651140a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783526213; x=1784131013; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rl+8Lf3AHaMrrunPG0nqTjSiKI+WxqLQdG06+E4eoQs=;
 b=BNiswEJpWdy9eKR2mDoeKy+jLoibhgoM9sECKgUlexFQ2KVoiFsomtZl8Rr837NzIe
 g0lsllmaOi0PdIP1mgz9aSZsUy0PcQVWtZbtqHTVpuAX3MS8q9H27vYyHIo1ammAz+gH
 khDD/Gxvagm+JzZZhSuqFBVTneyH22EIb350dZFFuL2HnVJtTjEtvPV/crN9xQMAsHke
 oVMwecwuLptnyds+8idruRYGUuhvSuuq6YuGNcuAkIXBG+gMV1Eca74pgEGkx4fFyVKs
 kTjZIzEpBI+15uSEiDxBthOi/vTB4p+44YU1Ghux048OrT7I4K3dmZzHHeBn9B3iPc0X
 cZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783526213; x=1784131013;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rl+8Lf3AHaMrrunPG0nqTjSiKI+WxqLQdG06+E4eoQs=;
 b=HzDA21WmMHs8zRqlrihDIKEQwwp1exTB/PlqcdyycpRi6ZOhAECM07UN1yi9aUAK4G
 3ZRqpeXhK7vVwRowPdNLvy6+8SJ49VEAUIPgSxiuH16kta7uJUijrjNugQiZNkBk3N7t
 Je+H73B1/JbooDO8Mf2wGawECChM/yal90MKra8NAL8RReDGpIu0pzkpkaUkUoSwQN1g
 Lu7KlRom7H/Lq5CFibBRfkGXQJoRC1s22VOpZWD42g2BILXoydz9NljVqlLv/rJ8+sjU
 WJSmQtTSzDtKdJn0dA5gFsLSL2VvCu2dzM6gtevT/aSU7iQhcV5zysy2GmAz4GErYSvv
 2j7Q==
X-Gm-Message-State: AOJu0YzBD8tNJAr2saA31O8ogpy+bgpBxGeFhm3DbBZv54TSb8gnqnA+
 DNT5+NyZ40jmgSicXn2jepw5fQ88k3JP6ePxnUOCPXGv/G1rxVU6nW+6s+nFX3bOVZaif0CXcxv
 TsVvbZXNQNOu35QUdaS9oFV5qWV72HbWR0ASIpEKT7RgkP2c9n0KhfYydFw==
X-Gm-Gg: AfdE7clupc3LNcUQCFktLYEuF7l3Q1gpgnn9s14Q0RDIFgr36ZOClLmTShTLzgJyomW
 wg7oPWeXuQopV9tYKtvH7U9VjNEDYGicUUXZ2KevJ6hPgjqsibm/6Zc4/aYwBg3QxLTszg96HwZ
 fr7Alxlsu6Nkk9e1g8APJqH/t/IgY1ANcyBV26myz1BzbR62lNpaIs9HrmcWSUIdcvO1LwFGZqc
 kMebCkXCyPSVAV8UpWdc0Xg1GbzY0WGvfP70z6aC6hHyaMIbrEMao/SjwQvKeonD8ziIOFPFFx+
 H/VY2tYn4dmwWwSJ29C2ZbeJbbzVzNFja8oBiMRbuSJ8DPnaEsSjh5CES1eIdEM4Ho0g7mbIQsM
 KOBqkK//wy6tdKH7Uk8vH3MgEQF6V2jxHT00QBTkz/dKjUKLpgq6l+3MJpT705WKazDvlrhJ4HU
 IIFBk=
X-Received: by 2002:a05:6a21:3315:b0:3c0:9c1b:d0ba with SMTP id
 adf61e73a8af0-3c0bd31de9bmr3654562637.69.1783526212922; 
 Wed, 08 Jul 2026 08:56:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:3315:b0:3c0:9c1b:d0ba with SMTP id
 adf61e73a8af0-3c0bd31de9bmr3654529637.69.1783526212481; 
 Wed, 08 Jul 2026 08:56:52 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117483dec6sm22131255eec.11.2026.07.08.08.56.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 08:56:52 -0700 (PDT)
Message-ID: <1a1a0990-928d-42b7-b8b2-9bc9382f01b5@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 08:56:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tests/lcitool/refresh: use raw string literal for
 trailers
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk,
 richard.henderson@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, mjt@tls.msk.ru
References: <20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260707214655.1138626-2-pierrick.bouvier@oss.qualcomm.com>
 <ak4Gmp15YT0x4lSZ@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ak4Gmp15YT0x4lSZ@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1NiBTYWx0ZWRfX/nFFDsyk2GX/
 dgLfGfbrxNBzIi7zaKuyZ736ltseGxmNE6wK2jkI01+XTP2MGuNrp3A/FtWayM7M5UDxKtCp0Pv
 xJm+8jAZvW/WI/+p8zfJaMtAWiIyTqM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1NiBTYWx0ZWRfX32mNOuX6Asok
 tpW3BUr6p3Y9qhuDCIsjq6csyJZCQSq1jJhPw03YcLF9TwyvSdrvNTgbzcozAmpr6NLfvhCOOEA
 MAZ98maC2wnfk/7JWO4WrZBh/43Zl2t5kEOnRf4QNweOyCaF5tXXLiudSwjqpl6OkwAa9Mepv1H
 piqxMVSYsOr+FJxSspojkO7ncvUs8Ueq2vn8bMH83pfHbA1B0hVRi4DHvhr8IryUy+HrrV/59UG
 4ahriNUFZPHamr8gyoH71FJC4uUh2/YYOOFKzha+ai69D3etzwkW1BaCSAfFjvOhxbTg+9yPwsG
 orRhnaLBH1M8FOFskCON3eHohhbLEQ90qKb8EjLbe+Aa9OAxs8cxUvi6r2JNTTWVVBv0m/tAW6A
 FQwUIAsAVPBRSKDhxbORd9ZUYoGUfxHFITaRlWTRjPxCNDYPk7iC7BoZaUIsHtGdWEoSAAufOCs
 Fo8MQv5Oz0sPX+aKCeQ==
X-Proofpoint-ORIG-GUID: fQ0lD8uwSAewr1PLpApAZ1IX-GJMaRri
X-Authority-Analysis: v=2.4 cv=JLULdcKb c=1 sm=1 tr=0 ts=6a4e7345 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=LdmRkruTV9A3LsMisGEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: fQ0lD8uwSAewr1PLpApAZ1IX-GJMaRri
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080156
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

On 7/8/2026 1:13 AM, Daniel P. Berrangé wrote:
> On Tue, Jul 07, 2026 at 02:46:52PM -0700, Pierrick Bouvier wrote:
>> Using a list of string is not convenient, as users need to escape it
>> manually and handle end of lines. By using a raw string literal,
>> what you see is what you get.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  tests/lcitool/refresh | 209 +++++++++++++++++++++---------------------
>>  1 file changed, 105 insertions(+), 104 deletions(-)
> 
> Does what it says on the tin so....
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> ...but given the size of the trailer we have inline, I wonder if we
> would be better off just having that trailer in a plain text file
> alongside the refresh script, such that 'refresh' just auto-appends
> any <foo>.trailer file contents to any docker file it emits called
> "<foo>".
>

IMHO a simple raw string literal in an existing script is enough, it's
perfectly readable and maintainable this way. Adding yet another file
means that you need to look in another place, which is already complex
enough between the dockerfiles, lcitool itself, and refresh script.

> With regards,
> Daniel


