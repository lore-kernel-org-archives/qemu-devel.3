Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519B1CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 21:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGkOy-0006Pw-RX; Tue, 13 Oct 2026 17:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGkOx-0006Po-91
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:51:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGkOv-00050h-NE
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:51:15 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DK90oJ1999236
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZRgWQcL9l7QbMlT7k7j+TUxWi3Kbn3uI3/WeSEcg/gY=; b=GMV4IUoaVDFP8uqu
 p9HRaejppcAE3d50+/tCewXmRK69yG6z7qwWfOoP2/nqblUFe0+r97jnCe+Yc1cI
 C4lwVbb31gVnm9DgMa95CvOkVezB+rZrbQPhS37h8LM5+x4TWnN3quUyCKLkCZJv
 fs51IoGcyMoDBbMN89Qfp6487JCHXhzPBshIVXHXCOPVZ5W0fJ84sjB/twkbFZXr
 +/54bWwFBjGFvGX8Znw99Zi4ZFOGWN3fFPravYr8KRG63SQMwR8KQm+s6ZzMVAM8
 QzIsjA6o4Hu475T5sp80cswfBli64J0SXBV1KjEul4a7XFXXErMy9zj2ceNEuPn0
 oIRajA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9f62c15r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:51:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35a4d2e39acso1052185eec.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 14:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791928270; x=1792533070; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZRgWQcL9l7QbMlT7k7j+TUxWi3Kbn3uI3/WeSEcg/gY=;
 b=N53zbyNp02Klx4BqJ3qXEJmYKij5UhMpICTBggpYYjr4AB7NeiHIJQAHrNOo1KNmvp
 XCZAmTyqtFFsYd2wdUNbQ7iypRJrrIPFXIyPVEQfm0OVQRew9UJgKBD+Os5vLvmh9aga
 qRz2s/aajeGBvz14zlJsPWtCpm3Gw85AkiD2o8YTPWhiuC7SwH0nUuvMFLzl5OjvhwRE
 vZWp8Oh9pFSScSmfGfqPXtKIzmZKarDzbtz5Mx/ae54NkUabGliWawyKte/yshQEerof
 q/NRBpCX5gQoA4ahZUqWMHC6bqFQxOspItMOvShBwz+IaYoY67QqsIOlB+AVmoDEAtfA
 EV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791928270; x=1792533070;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZRgWQcL9l7QbMlT7k7j+TUxWi3Kbn3uI3/WeSEcg/gY=;
 b=UByv8PAkgtbCIfyD0BfjWAiH8G1Hcj9Oyj4guOIbj+gAwe4jLrmREUt7qpxnl6Pfho
 YixdBwD1yhsItIEWTlL2gfZeCAL6QDb3rW9CZnnijCzxDyEcXXjtumV2eJZskl/PRlDz
 Be4/A2WqKrgHy16ViZTHwGQy3vkBxT1hnukKu/UyIn989PDL6960bSjHEpsWHYGA+PIl
 T4GkDpc+ttC9bBVCa18RUEPrmz6GxneYD2LNyg1NOEtGej7qVuOmRdGEXeVRywsFP9Wf
 sdK9wOzj/V/G5E1AUysVl2EOvjrnBA9r/xkld5rv23nEiauEO9acaY23cm1uQ+4WYAwy
 zlrA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+f5aIysv9b3bMf/MR/FoL288Uu+ytQBA57/0SJwYtj9NOG4C1XWp+nFTQ3azm0FBMmFM83VFQAwZn@nongnu.org
X-Gm-Message-State: AFq9FYJgpjaf+nwqEw82mv7ZO7ZlQgN+3uzF2vhAvsBPSPcJm7Cak/1F
 h8AzHpJ3TX9Mtz0H+X+Koj0jW1A1b4iTQD4sieHAyeoETuqx7uKtlSlXIVwHkaYwbkIRIOJTmZH
 DT3Y1wtk1Hp6u58b1n+ai9WWRnTOJ5JH0AEUqpYE+XEb0BQ1VjaO3lxKfnw==
X-Gm-Gg: AYBFou1sRZEFpcrbENwMaUhg32t3YSMZIABRsYnWVp07yrLFxIjXu/PnhYZtJXNDDnu
 LC+DJm7EK66rm7YgNLq7J5wsAXFDKXLxB6OR9OIQeAtgaLdaNpzAtUU72DZEuKtt90p8WI1pLzf
 3QQqbIOwuPzLybqrESHHLiX5CpSTAm/d2IQ7//SWgOlYpfsIuWSNrKlhHMHTlOZ+fM02jmu/5HI
 iOFxe8iUHU75ghzK74XLSI+XoFLNYHvS0eebyseIzH9nBe9YCNMH0wps/gGN4bNP7hzM9RonnlF
 zANnL6EYpKA+CXdL9uDK/rHQH+oExE+VyWzxsca80DBH0l9qyMEmlXQACKZpGtxm7GWlWPgGW3G
 y2mGNdu+sTViPvggiQ5fCRZHxtkDKpYSKGnjmEap03Lldzr5xJJdsjtGol5nd4PD5ed8srQ==
X-Received: by 2002:a05:701b:4211:10b0:14d:baf5:c40f with SMTP id
 a92af1059eb24-16a5dee142dmr19961644c88.14.1791928269574; 
 Tue, 13 Oct 2026 14:51:09 -0700 (PDT)
X-Received: by 2002:a05:701b:4211:10b0:14d:baf5:c40f with SMTP id
 a92af1059eb24-16a5dee142dmr19961609c88.14.1791928268917; 
 Tue, 13 Oct 2026 14:51:08 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-17dc865cbffsm295364c88.6.2026.10.13.14.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 14:51:08 -0700 (PDT)
Message-ID: <92987794-e0af-4b45-8e32-831d7afe1ce0@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 14:51:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target/hexagon: check privilege mode for system
 instructions
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
 <20261009192541.4163758-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261009192541.4163758-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FOKOVOos c=1 sm=1 tr=0 ts=6acea7ce cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ssq6Z6STJUegY2MsAWwA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4NyBTYWx0ZWRfX5oN2q4HDCX4Z
 UwqUDDXgd1HFbPQyMrrY24AXMcS400xKqYwz1P5Qjuu6323Ew4BvCHZOLqKHeylDSiCS0LwBS4w
 4dIx7zyc+S327t85tObeXT87vY4anX8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4NyBTYWx0ZWRfXwjCS3D1ACl2r
 3YDPGAr2OqpYNoKUO/ge8kCTmdW/YUCOz4d1dB7nUKWppqsNhoxHWm9m+9AuIuXVyZUEDOGK8zn
 xJCFuiZkcDvKPtyeG+lsH5dq8FhB3b+TbkFoWOfM0GYbuezxpKxY0TwOiVT4/+TS5K+irmFLMns
 fii5j3lifpQoL0sMEDpyiHJqwTJr3Yaf8uv13xjK0BhrMP6gu2b6g339SirCGYG0llJAN8Ooau2
 t+xqv7NoncQhIuxOW9CMfG6f7+q3QnOcC08dp1DxIGjtehPM0lvp8gMXcgQXi9dXARQ1anJO/dB
 MJX3fQlKolqwCA4NfRwFtQVvUE7nejaL2TIE7wtvVKUWKvrXBIWDGJWnWvtxjXMm2+3B6A2EJmK
 5LAfkQHQ63TIUotAz/d5r/eEx/ZHF+jRqFfs5KUHrny15KU5nSKBjH5LSX+e+sqYVcDZ5XTdAPj
 kdfVIspSqc3R3ftetAQ==
X-Proofpoint-GUID: SXzowKuhsSNPCYJ6ZzUh-DXKs1WBNyJ2
X-Proofpoint-ORIG-GUID: SXzowKuhsSNPCYJ6ZzUh-DXKs1WBNyJ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130087
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

On 10/9/2026 12:25 PM, Brian Cain wrote:
> Fixes: 9831d3cab168 ("target/hexagon: Add privilege check, use tag_ignore()")
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h            |  1 +
>  target/hexagon/translate.h      |  1 +
>  target/hexagon/cpu.c            |  2 ++
>  target/hexagon/translate.c      | 15 +++++++++++++++
>  target/hexagon/gen_tcg_funcs.py | 16 ++++++++++------
>  5 files changed, 29 insertions(+), 6 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

