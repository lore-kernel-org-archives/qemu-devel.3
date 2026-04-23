Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB84FDEE39
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFyAt-0002oo-UX; Thu, 23 Apr 2026 13:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wFyAY-0002nn-Ky
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:48:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wFyAW-0007Np-Jv
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:48:53 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NFr4Wf154568
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 17:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nfMxYQJxg8+mGbRamnvjr1sdowj0kXGbVCqCrBnLsUM=; b=fxao5/AXrKGDWgxv
 CuZRFu9s4ZhAaguKSIzXTDmkZby7N8NPJNZ02wVsPSJiwp+jUEWYqNj9ISblUp8A
 9lrMiOCs08I4ceFF1YI2gznhOYq4zdZrYz7/0p9tC2hrFlHWRRxDSk5XAwu0jgey
 i0eQpEoOSRzUX8p8T52gMBpSC9oDpbE3gK6laNnOB/fSaSlKEVYKnO/1HNaPHnBQ
 Vs6paXg0qja+jtnZg66Sa7eorGWljTkbagQzLjfPe2lgjRixroRg7+ihYaM34Q38
 Y4gemIcLNcEn7kw28cm4UFaieaUTkcf0GbF3D5EGbEaf7Kcl+y/K+UdtmBh3oRxX
 d33mKg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqpf60gj2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 17:48:50 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2c0ba59a830so10894259eec.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776966530; x=1777571330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nfMxYQJxg8+mGbRamnvjr1sdowj0kXGbVCqCrBnLsUM=;
 b=j8nxt7JVf3382PUgyUfkVJ1y95seiHsZ+KeH0R25Mt4D8hu6W4N6ujr6U+Gj0/gDJ+
 0HJAON4O1BmjDTT6in9YGuPkuf5+oUbon5B7YEPKVpZpf1/e14d8DxMBxG7USUhW5rGw
 W19gqTuN/GTTmBP3DewbRVnjSR/KeniwrIIo0jq4LX3EOiEAJv484kKbWsquap5p3q+b
 zLLdPFt+3UBMGqIWKIzoIdox6wtwgIulnLESKqkI/iwE1ilIvhH74jsDFfkhtjtTP7Ys
 +5TzxKPrh3B4hLAAOQtdrwfwUmYkzI7VXV57ZM2fIc6UxQtENAjPFFsi4GVVxooCAwZa
 juYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776966530; x=1777571330;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nfMxYQJxg8+mGbRamnvjr1sdowj0kXGbVCqCrBnLsUM=;
 b=kulDzB3hxSIxV/WUIAyFSGTZYMIorH03e5QKCyVxHhlo69sYzpm1Aqhr5DvD+0TUhq
 45qtDTtkOBjbn58PLV1WSUfLVaIrfUypsv57cuIRxFh8pzhja8/ygC4sYbDteAhjrHsl
 LAyGX4Uuvmiw1CpO+t/OI7Cf8nMZHclxXXaCguGW6m47fwhknqiyJq5HjQJUt7BJOKNh
 tQWvKNcMC+uxqxwcAqfEv5673WKh0fudwOwrCRwr2zcv/nYijP4w3kpzIt3ocDTHYEVT
 lkqrQpWl53wwMBkzSMx1gDY+E/rikrd7QIr20oX09jcXz7tvJBvzR9fy43WvBB13BVOu
 1CgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8boURj30ZxEwanogTUyreBw/b1RLTxWkTDHFWvykuB7zPeolPZN7VCQopQDXOCM1EBYEvxCAuQV0TK@nongnu.org
X-Gm-Message-State: AOJu0YyoVtfHYV04NlebVpU6/BSKvsc1JXR+UczMgYNiX338PdrOtaE3
 i143AwYN91lImnqjoVGgsN4cveGQrgvE0DL5ppbB24A+wlstaHpyxUQldlCa8mWNBUlei/vnrEv
 R85p21bUw3g9rsvQoV/AhD+uBYXxQI6bMCpuu5yDioPQurRlnNcl3aZAqTA==
X-Gm-Gg: AeBDietCYsNlshGveFPAXReRkPefPCwmbmm84QayjELTJXje329bLPLT+Gw8Dvkrqf1
 G48nTzgU5gusqn/wuTw3tx0TfxjDWJhBSRA9oS3AK7riSXVeHJzDn54UOYhdM6PpcWbBPuS3hS5
 JgN30zJVpSO1GL7O19nfvM3sFbydMRYoGsHZMpWyYoOLEq8aci+iznhqwt/phGnh/7gEyIlKH1n
 zsXlFXs/hjwDIFlrpg+DFnA2LBJeNWDG8t/Q8vRZl6urRnIJlRVuAznZdQU1GX8P55xf+AYIFsl
 VIOpHL42vMudI+OiW5gkZv0fz4gzrN6n9cO/h/4+kGcgABX0kDiXAwpDnyZxVubV4YmE8ASWnq+
 q24861HxNt06ugb9pDVcNkAr/EOBh0BI5QczjdV8Gm/iaFaKMuHAI6FQV4grg2Tn+4zR6ReCax3
 IDCFYdI2GmYGrZw5g6TxqYTDKH
X-Received: by 2002:a05:7022:220f:b0:128:d752:e074 with SMTP id
 a92af1059eb24-12c73f6d671mr15258421c88.1.1776966529611; 
 Thu, 23 Apr 2026 10:48:49 -0700 (PDT)
X-Received: by 2002:a05:7022:220f:b0:128:d752:e074 with SMTP id
 a92af1059eb24-12c73f6d671mr15258392c88.1.1776966529017; 
 Thu, 23 Apr 2026 10:48:49 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c831d5b29sm30101289c88.8.2026.04.23.10.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 10:48:48 -0700 (PDT)
Message-ID: <2dd057cb-3689-4cdb-aae2-8d043e4cd789@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 10:48:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] target/microblaze: Compile it once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260423100612.27278-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260423100612.27278-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Iocutr/g c=1 sm=1 tr=0 ts=69ea5b82 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=pSnJwVdOjWvzNXUS6SkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: nvgE8S-gD6CiWIikYL96d3aXB7jR7EzN
X-Proofpoint-GUID: nvgE8S-gD6CiWIikYL96d3aXB7jR7EzN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3MyBTYWx0ZWRfX9bqQojXbZbit
 7DLJF8XtgtjPpXo7DbCAjAjCYIkk0M6OhFG8shZi+EbbXITMeEgt16No9ITlmdOAI+Ruvy9bm9b
 jFx9U3WLmkHdtw7kmJD7riZMUx8rMD5FKbw2uQCxVJlrSqCONVmphQ6C4MxrOUdnUDaYp2vqQEC
 +X3/QAcHFmXX3oitFFGtk+zOc4zhV2N0tyJOTTEB4rAcNdQPgkiyaGwvu6rJlxSqc5pHBlXMsuy
 B7Uw1l5VGBNjpIYEyOu0nZBk/J374Ztyt6XHpLr3yOHoO4/z5iUBpC+FI8d89jSOpcQ3DzRbu+f
 dauyYD/g3Y1CCWuweHzQ/3Bs1ntErWcFPiw4Njq+OIY0IUemZdM0Kj5dz2B1rU0my/R0bG2SMGT
 NPr4vKBivJsjUVuKvp0cvgJApgTDTYbuYKeZnnMoIiLJiqSBz4ZVEqYgyTgD5XBiWLDgPmyCe4n
 KQAaGA1W787x4zXksaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230173
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/23/2026 3:06 AM, Philippe Mathieu-Daudé wrote:
> Compiling target/microblaze/ is now almost trivial.
> 
> The first 2 patches should be backported to the stable release IMO.
> 
> Philippe Mathieu-Daudé (9):
>    tcg: Include missing 'tcg/tcg-op-common.h' header in 'tcg-op-mem.h'
>    target/microblaze: Fix endianness used to disassemble
>    target/microblaze: Replace translator_ldl_swap() ->
>      translator_ldl_end()
>    target/microblaze: Introduce common system/user meson source set
>    target/microblaze: Compile helper.c as common unit
>    target/microblaze: Compile op_helper.c as common unit
>    target/microblaze: Compile cpu.c as common unit
>    target/microblaze: Include missing cpu-mmu-index.h header in
>      translate.c
>    target/microblaze: Compile translate.c as common unit
> 
>   include/tcg/tcg-op-mem.h      |  2 ++
>   target/microblaze/cpu.h       |  7 -------
>   target/microblaze/cpu.c       |  6 +++---
>   target/microblaze/op_helper.c |  2 +-
>   target/microblaze/translate.c | 11 +++++++----
>   target/microblaze/meson.build | 12 ++++++------
>   6 files changed, 19 insertions(+), 21 deletions(-)
> 

Great!

For series:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


