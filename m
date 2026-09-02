Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619D3C624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1r0o-0006RX-6X; Wed, 02 Sep 2026 15:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1r0k-0006Q3-Sp
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:52:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1r0h-0007Uf-HH
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:52:42 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682Hrgjx2484327
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 19:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o9lf+tLTFMt2mBgZsTQ5i9dk7TIdp2RTwx0PI03Puvk=; b=Tapz965ySgCllyjw
 Eop52McWbL92n080PJ+VPQu6Jpdht5AErQYqlBH/oOBfiRWWSuWqAdjVDdl0+Rqp
 x9d2cuxSX3S4/zYg3De0x9Qr0OCeu0G4TYgmTCzFmofEuhx/gpCzDD7qQYrTZw6B
 O2AtEBNDPuksr348lgVSKD+Z7J4x6X6Rdpt9QsGCa9kn7QQHrMnW5gAWPsLle0iI
 cS+2PIzHMX9Ub4aB1jCSZS/3BzqB1TsKcaAMPHvwTmOWdDSN30HWzhU7MOL/Zyxx
 vNas4EITLiAW5oCNtyLoKkLyuWLSYsAvuGuIkIfzqBLyrNIOqH2AWVeZYpTxOHDM
 dAymAA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemjh9mma-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 19:52:34 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso1360708a12.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 12:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788378754; x=1788983554; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o9lf+tLTFMt2mBgZsTQ5i9dk7TIdp2RTwx0PI03Puvk=;
 b=h0YeQI5ekvSlhKROsDPgIfZul+bvrC2Un4uYm2siDeffe83h1e27jzFx/rgIXGLSGh
 jEzM+srulAwKL/EG+5oMxR6QfnOwh1AMf8jNtBhOZViF6BOfatT0IDzY4I0hiAplC4Vr
 SqhIsfsSA+QJH0XDb2FLZP+8t7KAeIYfhwg/GXm5OScuwOxRvNi1XBTqIZ2Ih68APXt8
 3RBqpqbDWm3gBznKfsiYdM827C4ZQuaVnd8CjVvc8jsYtn+uKFrFJ5DnWtm0bR03SPD7
 2zRuQ3ToCnAxnXbw8NHwCzoDk2HbC8q0lWwdhzD9u3awgOhO3I77+BmcdyBfZFsNC7TJ
 8GbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788378754; x=1788983554;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o9lf+tLTFMt2mBgZsTQ5i9dk7TIdp2RTwx0PI03Puvk=;
 b=NzDmTr4R4VngcjPAEw7wBShw1Cc3CQC9xOqPWg2z8aJoEJxepOxNNp0PRgo8zxbs6Y
 ZUzmpPA+GR+tXCN+cJ+ynB1st18yW/1WpLbBtY1QUGuy7k2WRdVH9/PshudVml7vQiup
 kJGQOu0b9L/OCxkthvWPO2XghKM/n9l1e+5WiVb3TqcUFO+WHCStzQb7O0FL2DrLnIQQ
 XZKAgwrA+6at/4VL1eFmtDnmwkwcCcAnyI96R0fwB/0ImzH0aC12iw6JQA4ysK3Z9DXb
 NmXjmNuAsYue7/vN1uSHwHcpxBxHUcTPPR2gYVHKw+YFNDS7F+EigbO9jTIuLgFAsEtb
 IHNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzCA8REo1mRL4lhfeS7VIfmeypDKUn7HJFoJ2ooh9h7FhthjeRBysnvQNUPSvp4qyd+3uMz/sh9Lpk@nongnu.org
X-Gm-Message-State: AFuF++nKPUh0xkPnIDhqPP+S2kw9N5Ohbyg4DDoXs9VtmWwjCu3S3km9
 kAxwWN8bxeyBoXZgGXAm/00/XoXaKVxaqHBFsp4KKeuEzTuGG6ayuH/F7Y2NY6yj6HkyfPDiuah
 ncaQlvLJlXDiJyokOXhN2kwpNGdawHIOxdUwMU9cPhrHs1fWouP+rcPP+tA==
X-Gm-Gg: AYBFou0RWVkInQFZXXYEdjAgY7ZB8CBf0ug82QhTW/I1gXofizK/vzsfFKaooYOTsUr
 IEZuKsbdIW1Y+MpiRatge6wFLQmZbvYPlMUEcu9pDA9UXATuPd0qKNOu8ZhUipqOs7hIIJFyrwB
 hYC1EaE3/AkNv709rKQlvhVOu08X0oeSwh1ZJzL/QLr1NkC1OPaXfOODr/QigUgZ2YzMJpsoAxj
 kD1Mw6dG52fuKrzuLgpAk8R7XJp6JosrdifpCdokJEnwJGzni9n9fZUgt3UD9XoslYwZDFhDZIL
 6FUoepftZ4Jn4u7pxHfC4oMJgp2ZyjfOn01NWAEJW2ODO8yQuDJ82Do32qVrG55yZQ7/DMuj9k3
 /6QGPVpFXgr5LbRkYTSSGVXL699GaFSze9jq6z9I7+KRcxp71IiZD5+MvjtDHtwJ04L7V
X-Received: by 2002:a05:6a20:728c:b0:3d9:3626:1326 with SMTP id
 adf61e73a8af0-3d9ac3312dcmr11068115637.2.1788378753678; 
 Wed, 02 Sep 2026 12:52:33 -0700 (PDT)
X-Received: by 2002:a05:6a20:728c:b0:3d9:3626:1326 with SMTP id
 adf61e73a8af0-3d9ac3312dcmr11068042637.2.1788378753256; 
 Wed, 02 Sep 2026 12:52:33 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33256416966sm307194eec.23.2026.09.02.12.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 12:52:32 -0700 (PDT)
Message-ID: <cc7bbe77-6257-49e1-a8b6-eb2c3f24f241@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 12:52:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] target/arm: Call arm*_cpu_do_interrupt directly
 instead of via TCGCPUOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
 <20260902152044.31291-2-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260902152044.31291-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Fda017-aYh_f0m227mn2ZiyPmTWs3B16
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3NiBTYWx0ZWRfX2VHJbDETIaLO
 61wLsPOOWpHeMsGDtQMNh89sWTsczBpBGq7/6KCArqEAQcEESxyLfqBukU6G2gIuOjVTGcE0FsG
 VFgVse+I1JXHuq8rOs0gaz/jO5Hb4khU9nH4Fac8SFmhqIIvu54Uk5gd02GsZd3SodWy/sD0rKa
 GYnAPDiH+FTte6P2MjsIBGC4B4Y6LrBq4KFNDvG5VVHrm8Q5mSf6YEkS+Rdo7zgIN+v73Im1PDK
 le8QF4AF8jmEz7J28mpGu+fzLr2XyEXdDOEi9c+ZRtkndQtInUZPwMZK3snpoa2J4glhcyjyubm
 27478kOXypxC/nCz7S+7gW8ZhCseuniy00pgFHlAvsQ6aB37SQ7kYB1mroQ8P7J1vKbCQXOJQtt
 /uMNrXvOkoc44KRN4kQ4pfdm1wlAtKeTpFryb4MdrpEtMN14dR0bgTQWhixQrDM0omNqI8QaEA3
 SKSoAMNry+wL4WUV4Gg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3NiBTYWx0ZWRfXxFQcpc7NTdNK
 mda6+wkD/P8gTCOin3w8jNz+b/9MMtQd9FSnHaDaILp8TKaeFqPBOIGuUgmJrWkr4yw4+oTBcLV
 7AVeO8uM9i6SogEHiP+tG32G+MPBMgQ=
X-Authority-Analysis: v=2.4 cv=ErHiaycA c=1 sm=1 tr=0 ts=6a987e82 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=uK_-vC1rlBskaMxWXFYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Fda017-aYh_f0m227mn2ZiyPmTWs3B16
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020176
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 9/2/2026 8:20 AM, Philippe Mathieu-Daudé wrote:
> The TCGCPUOps.do_interrupt handler is a target-specific
> callback installed for use by target-agnostic TCG core methods.
> Target-specific code should not dispatch through this indirection;
> call the ARM implementation directly instead.
> 
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/arm/cpu-irq.c     | 2 +-
>  target/arm/tcg/cpu-v7m.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

