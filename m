Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2677606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Igoe/qlJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HZV/cHhz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJF2P-0006sx-Pj; Tue, 20 Oct 2026 14:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJF2K-0006s4-Dv
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 14:58:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJF2J-0005FC-2W
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 14:58:12 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KIkAAt2470906
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 18:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D2FLAhnOgHy28S8xF/Fa3TbxKJ5JP8kKmL89TNWvHt8=; b=Igoe/qlJBygD1t+A
 m64LkAxkyWEU5fAYKbcax1Bsrxq4rAfTWArENFA9KT+bhpMN/dmHRehnQMY5a7zy
 0PmeXOekPGjINGUyzNXTB1KkLjLJ9qUFOoRrgebYnfFrdCE5DY2uVlWYqWl/a0Qd
 S7BsNkqqBBCb4XH3wS9dskQkqHUO24+ok23K1WQ1QWl/X3EaJg+J4JD3m8aO/UoV
 0STNGUl3KTKG2b3QlUGIe7yeDFXuV9IBw4rgFOLsWBHSj7v+VPnbMvCSwyDZuVTT
 7/+Ca8JFg+hR2SjoWhJsiM6RTmwhqQVreFrwMzCKw3Fg9mfGLMA0Z+6YQQO+wGJb
 a61S7A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n42u4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 18:58:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f1e62510cso839159385a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 11:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792522689; x=1793127489; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D2FLAhnOgHy28S8xF/Fa3TbxKJ5JP8kKmL89TNWvHt8=;
 b=HZV/cHhzAeVZ3k0/Jd5mWd8d95BP+2OWiCKy22P5d0Un7CUo4B6/gCu4/N7tbQcmB1
 tvQfSz2rfYR+3kosQZFv2qCR4GQii7uYYYx/KBGFZ2fIUkOR7XxLtzJvohd8j49xDJFx
 HcW6eOzoafg2EHlmeM+HCAfSwVjIixaIawZjIWtL3klJ92fFbr8b25Zi7GlNph0x78j9
 ezWotNKFDcAClVv8oOvoezb196F51lX/+dm60fje7wrT09/jEzAnTmEa+lgflxc4QKeg
 /wM9PFvs1cZLR3KEG8zjwOnSJU+KYfNkvClwH17WID0+Lr56PMsX1gk6DMU6Mil8cSF+
 f1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792522689; x=1793127489;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D2FLAhnOgHy28S8xF/Fa3TbxKJ5JP8kKmL89TNWvHt8=;
 b=mev3+sQW1cMFY3OVdCML4JxVpJkuW4PI/QaeB7al8EaPUQqkAyKb8rGNY5McSl+1Eu
 66rbrwQFnhdLyNpjQ8d+nUwwNORHKaGQCxzTuFr6i691sD/c11mflOxHQfDOEyBF8wXj
 qZy8bolNtMQXif/SsJK3xVrZK7f7hTVoS990Ew5vDVPkLSS6W9rS0QJjszbWrffXmyjw
 DZxXBQMBIsAc2vCl/FDOTQWFt9wgOUG6TroZrMr1kn6uDgOiwX4TR+w6XzTESw/GqxCX
 2IGSALYiXiIfZEDuDdybS8jt/ZzwtSQLbhfXEmCxznAOAjSAQuNvuypjAIBCgt+QimBi
 RnRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw73qjB2BgyngAO3Iw1q6IAIRpkvn+FOpMeZ1tFTtgSqAjutL/NyEiJ7D8IFui/ukOvo95BLQJCyIdC@nongnu.org
X-Gm-Message-State: AFq9FYKsJmYdtMrQjpqUuhb8bNUhHpH9OcxccQonnYAPtEqELCFfpqDI
 xx+ewAQ3CLgUfCI+JNMXxqTAMrJ2tQhUKX3oC5HVQxhrmfCbH9hyUrmcvVTQPptBOhSrkv0PIqx
 l7zpGUEK8VYjprAkEkM95SKUABN5Z/eRVNpsn9m2sLcEzy36L3nJ5E1braA==
X-Gm-Gg: AYBFou21jF1A9zj8YbBw4/J5vzmLWK44Khufthu+eY6DSyBHjybZk4q2OCob+e//LpC
 zvxRtb3C2BRCROGqPIz9i76PwMSNWxfSzTZvB7l5H8fROaDJwgdde1mS3/oPE8LfkiuadRt+1mC
 XYXNamhrvTIbTeqqqCP49syzBm8y6z1YAvNw+TQvIVZ3zAU0hVqh9l4auCT3ErrgccO76aA84S+
 PQb786zz5t+yrVKImiBUfu2UuFp+31NUODHBgjChVSZUyY2RegEQ6Z+UmGDe9eBMxVt77fK1Ykj
 rrBEyPzyE/JND9yZnyQG8IrgtNByd6abBgjcOSb4ZAmEFVgItoBPkzx5gu83UUxW8RAqmgHCxJE
 lNuoX2LZLR6xq2OSdqLlKadb4POM6avK5hw==
X-Received: by 2002:a05:620a:690d:b0:93a:10b0:aee7 with SMTP id
 af79cd13be357-93f57f630d4mr29740385a.44.1792522688681; 
 Tue, 20 Oct 2026 11:58:08 -0700 (PDT)
X-Received: by 2002:a05:620a:690d:b0:93a:10b0:aee7 with SMTP id
 af79cd13be357-93f57f630d4mr29734385a.44.1792522687895; 
 Tue, 20 Oct 2026 11:58:07 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd234fasm750865e9.3.2026.10.20.11.58.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 11:58:07 -0700 (PDT)
Message-ID: <77e977bb-f559-4023-b996-b1ae81cb74cc@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 20:58:05 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] target/sparc: Return CFR when crypto feature is
 enabled
Content-Language: en-US
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261020145530.3385376-1-stian@itx.no>
 <20261020145530.3385376-3-stian@itx.no>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261020145530.3385376-3-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mHKqbpHVPNyDenf6s3vMBUudxVm6oATY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NSBTYWx0ZWRfX82aUxSM3jZy/
 A3oWRTws55kk8NwQGP8/8Q9H29FrJEwgyG1Jo4BRZX4yE5abQJvSliQkjGRcOvnLD7Gug9GwWS/
 6nBnfkKmBBwb7Yg1PzFG1bMUesYRuSo=
X-Proofpoint-ORIG-GUID: mHKqbpHVPNyDenf6s3vMBUudxVm6oATY
X-Authority-Analysis: v=2.4 cv=A5z5rKWG c=1 sm=1 tr=0 ts=6ad7b9c1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=8kYpjyreD_7gif-t3IcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NSBTYWx0ZWRfX18au2b6GFxR6
 ps/3jWkxlBIFCtY+XFCmQwk2yMIsHfkCLH+1miKxExwMTL84lLKZmDCVXR5Bb01VjANLuZpBuSj
 s8Y89xFnnGa6MibqcOPvIBujaPcCY00pZyhQShBEyhmQlBfrM8j8lLQkzumH4gz4GdufpwPtumu
 Aetg7v5I8+ek5HgGOJ8hInDVvOSyx0Lgqlir3ZPKqrgD0pwsehrlcYRmjcybNOao60+Ut8mxqim
 ga0fKV2r31zQDVCSg21vPUv0JH+8fb5roETmmWCyskIB8baNqGA4H4xA1CjeP8tJNIp7XvK0UQl
 MFYRg1qRLZgP1WRSPMPBNFrGmKkJimx2iM+qdrsWPk6TZ/WzL7HeGkpCaDifr0O8MfTFYn1k/J/
 /fomj2DkIOMeiH0jIFZRjeaWDJZFv5KKjcJXyC20lg9kJgMO03PIt90tvNdJK50kYzMBShCxhHx
 NoKaHjtaHhjOaeJmT1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200075
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

On 20/10/26 16:55, Stian Halseth wrote:
> ASR 26 returns a Compatibility Feature Register (CFR) when the
> crypto feature is on.  Without the crypto feature, a read keeps
> strand status as before.
> 
> Reports AES, SHA1, SHA256, SHA512, CRC32C.

IIUC to keep the series bisectable, this patch should be
re-ordered *after* the "Add FOO instruction" ones, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> Guests can read the CFR before using each crypto instruction.
> 
> Based on OSA (Oracle SPARC Architecture) 2011:
> - 5.5 (Ancillary State Registers), table 5-8
> - 5.5.11 Compatibility Feature Register (CFR), table 5-15
> 
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>   target/sparc/insns.decode |  5 ++++-
>   target/sparc/translate.c  | 15 +++++++++++++++
>   2 files changed, 19 insertions(+), 1 deletion(-)

