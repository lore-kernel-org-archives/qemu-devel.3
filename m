Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0CE606A32D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j4GdL1Xl;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bri2+25H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzsd-0001vP-Ny; Fri, 27 Nov 2026 12:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzsS-0001rD-RN
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:36:53 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzsQ-0003Te-Fr
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:36:52 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARFpGm72925216
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bZ8DTiK/E+Ggq+Q5Ke9egN7l00YpEraPhNoxVF8KkE8=; b=j4GdL1XluWwCd7rg
 EvYh4KFm4fYuCJcBoEgw+GPFzo18W1bT9n212gGjz69tnkpcAkJIdHwavgbRNrJN
 vMegYGHQS2EaL/Mu0oH8wJ6O5s93iGrjOP7AvFnb1lyAGz3u/uC0JWZT+fHVgDhv
 Jb4PCt75ec0mlFduAF/2ipswjzvHMjrzhV8ua9yHGlOIpU1mXl4pRYc4XNRznNCC
 5D0M3y9DR5TzQ8D08tt1qrcbwXn0/2Oof3XNCarBITfnfOslEfSqpkg+gK/1QD5J
 79HWd68lgMm5bCm7Y3mUUpxRqDwuaIQhF9hetIHHGF+xo8oiDhQVY5ehMZp7ZCO7
 Jrifvw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhjnnn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:36:48 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1b592e9841bso3495798c88.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795801008; x=1796405808; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bZ8DTiK/E+Ggq+Q5Ke9egN7l00YpEraPhNoxVF8KkE8=;
 b=bri2+25HZ2DPkUVrI2YR1HeWA1q3mkze/ytR+7Tkm294HzGJMrJuEsqP470CbgutLA
 47ik0GIeTAKz5NZwU7yGf7CxDf2HMBDep9u3R/fX79W9lSE9O2qmfUPXwOBn4ZvM1u77
 Bept6NJDscB8FX+c5TwpG40UZZCxiJKJs7rRBPQ3HnfPk9X2XFgfq5vr4qwE9sQXpAS7
 2VqLl2gZVkER7Ty+d9PMFNITMdCUYjyvy54y7a6+mNy6hSUvupB4NwUNc3c+FqxCPJCC
 PDWw0lxkuqMVDjXvlVk4mPg3A9rAwUz5n2MyNcF4BajIpLXkx1nJ2Gd8pi26PmEFD4oh
 bh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795801008; x=1796405808;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bZ8DTiK/E+Ggq+Q5Ke9egN7l00YpEraPhNoxVF8KkE8=;
 b=V3PGg/HrB+WK0B7x9igAXb9A9nE6ET7rxN+ridY91rRTUBhNXgj0AAUOak5zHk6EN4
 Cy0sBPV6UI3KuFd8AikREWz3i+TkLFVr6FBc+UgtrFA5FAWz76CfQH9wQ8a84fZCHCDa
 zmFVgzYchOavEny+6m+hj90G/PYQC5KxpVuOBTm8h046tAgthN6AEeRd7GuY28RndiCd
 6aJzUoKfSNsikbZ7Z8SBZZdSHaRjrHCnhlAkSx2jCCBRbPDT9/G3B2G1FFsifhJ1QzC2
 +f+3Ouz+DLHkFlDZNgnkpwAAWYB40MV9Tg8e9iJLv1aQf878Z+j1GM2/kbRihJEUsxMy
 2jqg==
X-Forwarded-Encrypted: i=1;
 AL+hErEPkmIUB/L62164nE/YVV68q3QGkGqRHvvlYEpl7bL1Sjb1agJ+icJx6xCf4JCiEaFbizne41Oau2EN@nongnu.org
X-Gm-Message-State: APuU4Z+xOUNnz77X+/KHFMDy8krUaRY1Sij+rVRPnl0wOV1Xi4Vh2xKq
 FbcRcSMhtpoc3oQP38lWuKbSyPZNhUgYJIvxgfDGftNaupqTZw0TMijZyP1u7PvBBqGbh48vfNe
 wdXqXNZ0z20AJVFOfJN4su5veK/8aXB39xRJdUjFmUaNhmu44+DBGcskMSw==
X-Gm-Gg: AZFdTZf9S6/HAMOWkPPLjDdo7QyS66yYRBOgVDB9l6zwbiCEfxPrzJC5G8EfXHAFg1d
 vj34z8GIlpxqslw5fyCKKuqbkuhYD8TgWUn/1lqgAlNjFXaqEiBKfpvd9wfR7+ERjY2WVa0OH0Z
 GPwxoDaaVeq1RRRd2/72FAOrjW1ceaIBE3YzCkS0NCRUmGe+KD9clpq/WwmrrQzsFEQc6oiSMSE
 GZMa27avSQMsAZ7DPM1J0GSEaL95AfEp1KhLL/EwdkhpVgMEv+dJrim4sS8MEHsOuf2fUCG+u9w
 BINZqngRKNnh1Cr+pEktCO5rcI/UXR3AvWCeXT1kLQsbHWru6V0TOSWIJCIduepniNeZ6BwEXyg
 gllOhsz2qDQOuucRK4iwegQGEtSnlw1EnaDs4IfYpiFhHzyzEVyBiHalQqfM6ltS/5tvejx3Tvm
 uXTAtifrim1f7nWaCoQKyxfsoEGcyR3WNCb8s9wUYAxO0=
X-Received: by 2002:a05:7022:4181:b0:1b0:4272:4282 with SMTP id
 a92af1059eb24-1b5568ba440mr38269685c88.17.1795801007965; 
 Fri, 27 Nov 2026 09:36:47 -0800 (PST)
X-Received: by 2002:a05:7022:4181:b0:1b0:4272:4282 with SMTP id
 a92af1059eb24-1b5568ba440mr38269671c88.17.1795801007501; 
 Fri, 27 Nov 2026 09:36:47 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-386b9bdafb5sm41800714eec.9.2026.11.27.09.36.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 09:36:47 -0800 (PST)
Message-ID: <899a468e-5fd7-4a99-91b9-309f83ec1d4c@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 09:36:46 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-12.0 0/5] dump, hexagon: add support for cores
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20261125194855.3154845-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261125194855.3154845-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3MCBTYWx0ZWRfX05iBxAbIZ0/f
 gU06CH9vUTNgKpjmh56x7REEW+cGI48IZ4FMAT3r33oEjv1UlQxvl8r1p8IdMiCLuNwKnBYNBrh
 LTMPc+I9kyDYTJ33OVrqh2V7lT6d/lc=
X-Proofpoint-ORIG-GUID: 08aKIF4cTj1O7vDkbURtJ1njDDOv6Xog
X-Proofpoint-GUID: 08aKIF4cTj1O7vDkbURtJ1njDDOv6Xog
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b09bfb0 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=FbE0QtbTI5SGvpqK8CkA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3MCBTYWx0ZWRfX58WYy0jmdakN
 sZ2P8IESWktUK1HH/GIJ2IsAdN93hUsSxUguyWuMn0AYrV4RABQq7iHOfIVrWVWSIwVQ8VOkqzW
 rfFXdg/GAvTFgPyrCVu0Q3mNTy1QiTLxjwOrlPYoE9UxsLxJuM61bTpZ0gAgujz8IWHv70twzaM
 iJm4XkOSZb57U/4rUo8dDhRUha5Ib5jis7JbY0bIKHqHlj6TPMloyfTFwi9csaDSox1GtvPGtAE
 ec4idOUL7Ae+XYaHJvO18KSNq35JLrw0E6GkdGU7hudP+puNmVYYyIh5CqwWKHmnRDItYpylYjx
 HcBjIEKmiBaCShJ/U4s9w8cTPS5Kwbqlot7hnvkp5aEPuP6u8LJtpvw3odlovNuwvSC8m27hI9m
 VI271e3eLBazpuDxJY7NFMBaacX9psffv3dJWFknZMLnREj3Ess9EcxZ6uQpZ6TYFRYlGS7+IKG
 0Hj6PbUZA6pQRBm7jvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/2026 11:48 AM, Brian Cain wrote:
> A bugfix and implementation of core dumps for hexagon linux-user and sysemu.
> 
> "fix e_ehsize in ELF core headers" seemed like it might not be appropriate
> for -stable, so I've not specifically added it as a Cc/Fixes.  Could it
> cause some incompatibility?  Seems safer to just land it for future releases.
>

Was it tested with lldb, or something else?

> Brian Cain (5):
>   dump: fix e_ehsize in ELF core headers
>   dump: let targets set e_flags in the ELF core header
>   linux-user: let targets add notes to core dumps
>   target/hexagon: support ELF core dumps
>   target/hexagon: dump vector and sys regs in cores
> 
>  include/hw/hexagon/hexagon_tlb.h |  10 ++
>  include/system/dump-arch.h       |   1 +
>  linux-user/hexagon/target_elf.h  |   8 +
>  linux-user/loader.h              |   9 ++
>  target/hexagon/core-dump.h       |  89 +++++++++++
>  target/hexagon/cpu.h             |   2 +-
>  target/hexagon/internal.h        |   8 +
>  dump/dump.c                      |   6 +-
>  hw/hexagon/hexagon_tlb.c         |  17 +++
>  linux-user/elfload.c             |  14 ++
>  linux-user/hexagon/elfload.c     |  14 ++
>  target/hexagon/arch_dump.c       | 129 ++++++++++++++++
>  target/hexagon/core_notes.c      | 245 +++++++++++++++++++++++++++++++
>  target/hexagon/cpu.c             |  17 ++-
>  target/hexagon/meson.build       |   2 +
>  15 files changed, 566 insertions(+), 5 deletions(-)
>  create mode 100644 target/hexagon/core-dump.h
>  create mode 100644 target/hexagon/arch_dump.c
>  create mode 100644 target/hexagon/core_notes.c
> 


