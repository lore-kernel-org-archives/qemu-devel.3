Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179A4606A765
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QLYZ99JE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eaI9ByF4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTjQp-0006cc-Kc; Wed, 18 Nov 2026 12:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTjQo-0006cT-4R
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 12:26:50 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTjQm-0001ed-H2
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 12:26:49 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIHGEom240482
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 17:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bBUAroXyf2OmhRlQibPFDsMiocdhLLjZKawNZGPK0k8=; b=QLYZ99JElcKe2L6T
 XXVuVP9KvcAuk9RJWKXtRW4giOjYkUcUBb+YJOch2wyePzN9HzuEL5fkbV/Z9q9j
 iPak1Y1e2vrDPsmiGv9poROX1aoOzPLDCx1EctpHoOoDQskSICGn0Fz+hYlScWHb
 Ik7KL8qCM4jRPdLI2S3cG6s/60ZAPJoJ1Y8xIhE4mjlbNTy1ndd6nGEZXMchJ5Kq
 p+oufASZ3/t5TjrYgKgNqZo1KzGG1j71cEq8IxaOaR0T7wbfVZiA8QAHrwdWM6Vg
 EXrhYx7orrwrY2y/E2MUf23wU7vabvUyhATcrlaHkigLQYb4Dh+xqSWfxkmsaWki
 hEwP/A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g3kr3na-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 17:26:46 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-383ec96a7deso64173eec.1
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 09:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795022806; x=1795627606; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bBUAroXyf2OmhRlQibPFDsMiocdhLLjZKawNZGPK0k8=;
 b=eaI9ByF4ZTRaa4w0htw/HTdqewU5h+bXgHvW9v3kYDYmej5aFyJdrMnKVZK0/kQDfV
 dzQN8H2DA7FUAk4isPGT93FKFgLfuv3Os4yUZMOxTAyD9C4ZSfgNtqiecoPRPndyElmb
 CDc4Fu4cBgm8QgEAZxj0MEMeGStYin1M7hYYjaPMxPn5S493oV5T0LEyB+NxS+IAWW8c
 fpgNTWaKDKjqTfgfL+M0E0HMz6rgHZuMWLlBKDn8+mQP8hRub/5M3B5BvIhJMH9Nekff
 Pr3bzeNAnphkuS5V2kf0P8hmhVYXFoJwCOp+DRt0Efrxt7nuM25oiun6Yw9RTgWs50y5
 UwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795022806; x=1795627606;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bBUAroXyf2OmhRlQibPFDsMiocdhLLjZKawNZGPK0k8=;
 b=hffT8wqX+iVtvHQXUdIjuSBfEnhOt7WpAtS1BHDUTw3732KZ9NzNmng0zt4mdVEq7V
 WqVqGGUxEHsJ6NF214ew6iEiMewiLZiE+eY8ch3qHKGKAI7lT0H19zkkbTLRTbmXIjQF
 F2gYccJCyOBOpwsKlzqbHwrjMTAR7ZgSDE9nkqN1x6EpiClihIBBI850bMikXod7gDOP
 8lqG8RVlCA8ruDjq3URo2v+M04csyGf4mFhJ4tZyEYgXU6KS0apSAJBbUUTlJPR74CTq
 KCR2RjSBmsHipOUo3SDnVBa0L6emOtgo8U1HkQ8IfGcaFBK067zj2LfKDvjVjHdBinPV
 hCnA==
X-Forwarded-Encrypted: i=1;
 AL+hErG3bfkIEMrB9aQlsdg5VC2kkZPelIOn/sU2Ck7lVzbxym5IS5Afml6VkAhwo5wQLojqPAtPDbU8AuWs@nongnu.org
X-Gm-Message-State: APuU4Z97tpZOoyQJBvvaJr++DICbO46e5zfpmeZgojyw2785jWNj9gdV
 D9gJph3K0fFH7QqAvdrofelLvsIfOwBQJ8SRz0RPeiS3ZCFinywfrxAPhDrn5wKbWomb7Kg+lLi
 3rfsnofvMbvudaTPKBqZxa+aQFxEJ1yvs82PBsmLzGnuZaNKM7J2V/SKrfw==
X-Gm-Gg: AZFdTZd5fdIou+jXS1JSktnv/MqAseBPTK2xO6DP9aQFCC8J21Z5T4BDUteq1AHT1VZ
 3Io9ZRPu3l5r6Xk59eDPaoUvW5LyPBHbhiFVlajdY/2PlncVJ4OowerFrnH3PSSAfu2OAv9xMV3
 +wG001ob+veUTTJCSqgHBjgirIuiV1Qzbeq5N/c+5DllWf8/L+WDOr79b8gD2B61rjgWhsh+24v
 vaV5ThLJY5MyVLhudqn604YfYyJAwLlrPUMWAQAyg3rDuEiQQo3dDfu2N7Olyk805rZeHQswsym
 94QaA1Nm+GRHz3/d0xGB59ArPgzeCvHkQfhpS+hibrH1jQeR4l4lTZ6oMFF6p+TIJ6q4Nu9qSon
 s1joQ5ANIZgWuh09oi/svSplY3cA9WtNvB8kIT7UnqJonXwUb8DEEE9Do9WYYAiAh+2WFZGfuwE
 uGf4jE6n+6Tfai36RnrCzHpZ0fp/HNQi7z9C5CBreLeYs=
X-Received: by 2002:a05:7301:188a:b0:37b:e40:397e with SMTP id
 5a478bee46e88-3827ff7aef9mr2709606eec.14.1795022805662; 
 Wed, 18 Nov 2026 09:26:45 -0800 (PST)
X-Received: by 2002:a05:7301:188a:b0:37b:e40:397e with SMTP id
 5a478bee46e88-3827ff7aef9mr2709587eec.14.1795022804902; 
 Wed, 18 Nov 2026 09:26:44 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a45274aesm10133565eec.2.2026.11.18.09.26.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 09:26:44 -0800 (PST)
Message-ID: <353ba4cf-6b15-48c0-a6bb-ec5ae85a787e@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 09:26:43 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pc-bios: rebuild H2 firmware
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
References: <20261118171410.3753915-1-brian.cain@oss.qualcomm.com>
 <20261118171410.3753915-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261118171410.3753915-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2OSBTYWx0ZWRfX1SvxUAmAJIyI
 bf6ygnVPwEoRB4QI3G74UcOlI0ZZ4OyKJYKi/8xRlh3dr+MAgMUdngZUK8lvAj2Com7xEvSFJ2q
 shaW8njoxEMmeA7Z69Cgb0Xr/rArJkNsfAfP5EsLBMMzR+mb921TiRGbOOhhrWEMg4vWfw2KJ7T
 lN4Ezdq5asgk97635bamsMpHKV6rUfRw/WjtV9b1mdMbWnVRp2vA1F78NsPod4P9MwkmjtyajnO
 YRU3/BFy/9pfpqCySLrlrpZFK1dvkoBGsaGeAntSYTdwOSe0UpuchjnMFI/nvi/QImDaCQY+Efk
 1LQ85dVWHgZs8uchdVGHIByOK0Dn8nZOBVF/gXgwoHs84YpPLbhyp2ebPq94ZO7XFYTxN6YYqRQ
 JA/63E/X0MFd/o8pXn9dDiprYf3I5NGmtRERvnmhWJ+7lIRpGnecmedm9YgIg2yib4xHB3xdYOf
 0vThxz5YnamS7SnVmzg==
X-Authority-Analysis: v=2.4 cv=Wom+otfv c=1 sm=1 tr=0 ts=6afddfd6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Vp7HDKK07dk4pWr7rIUA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2OSBTYWx0ZWRfX+G+AN+q1V82a
 pd00duqorxKPwDbkMWxDTboobN0AXUjeNQf4bc0vJEvy3WAyXkG1PX6q81PlLlNzYQrC4QO8rYm
 MsmUQ1afcjVpknJj37EEtrEoe80QG4s=
X-Proofpoint-ORIG-GUID: UOuGA5JS-jZxO5fBj0i5PokKDD560xIW
X-Proofpoint-GUID: UOuGA5JS-jZxO5fBj0i5PokKDD560xIW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180069
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/2026 9:14 AM, Brian Cain wrote:
> Rebuild the H2 images with the updated roms/Makefile.
> The H2 sources and build ID are unchanged.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  pc-bios/README                          |   7 +++----
>  pc-bios/hexagon_booter_qcs6490_cdsp     | Bin 285292 -> 285292 bytes
>  pc-bios/hexagon_booter_sa8775p_cdsp     | Bin 281224 -> 281224 bytes
>  pc-bios/hexagon_booter_sa8797p_nsp0     | Bin 288904 -> 288904 bytes
>  pc-bios/hexagon_booter_sc8480xp_nsp0    | Bin 288908 -> 288908 bytes
>  pc-bios/hexagon_booter_sm8975_nsp       | Bin 288900 -> 288900 bytes
>  pc-bios/hexagon_loadlinux_qcs6490_cdsp  | Bin 200428 -> 200428 bytes
>  pc-bios/hexagon_loadlinux_sa8775p_cdsp  | Bin 200456 -> 200456 bytes
>  pc-bios/hexagon_loadlinux_sa8797p_nsp0  | Bin 208136 -> 208136 bytes
>  pc-bios/hexagon_loadlinux_sc8480xp_nsp0 | Bin 208140 -> 208140 bytes
>  pc-bios/hexagon_loadlinux_sm8975_nsp    | Bin 208132 -> 208132 bytes
>  11 files changed, 3 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

