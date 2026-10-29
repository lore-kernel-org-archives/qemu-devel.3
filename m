Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AA9606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yxz29+pN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZyFysmRX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTm5-0003cb-Ki; Thu, 29 Oct 2026 13:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMTls-0003bk-I7
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:18:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMTlq-0000Tb-Bh
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:18:36 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDIfF1654937
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8X48nMc6CfN/sqLoFgNDKeQz605LG+FdJly2BVY1zjo=; b=Yxz29+pNqbhJ/8Tb
 qKmp5/2W1bLdsT0VmTUR3xbdZzG/8Hvy7GrrUEtyn0nImgKgw9q/aMfHxaVn3g+B
 qzaBWM66UV8kn+BLrbPJcd7d9RgntrWVHdqdaSZffdCa758n1Ti49g9T+Fl+Pw8w
 q0ftIedIy/3FIBCVoFN6yJZ/zXsuksRf8/kQ6t9y4zWu5cTpwFYvTiKEzQSTHwIM
 hKtT/OpEYDZ7rrgJg/SyeKJF2xxhrQRRnWXCgRm8isbPNRb+MTAuBFmWikvBkV/y
 WhDAo7fwKqkKE5/EjRqv9RmgDI750vGywOjMhuwQ1iw2Cjuh2BII04HxDtDaXmHt
 PScnYg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm4a21rms-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:18:32 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35cbea41088so3113685eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294312; x=1793899112; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8X48nMc6CfN/sqLoFgNDKeQz605LG+FdJly2BVY1zjo=;
 b=ZyFysmRXFYyRmUJBD5d5wGxQQRGMHGBUCH1/l17/xUbcpk0iswaBnmtiT9pccyZUhG
 rU5T0lssD4M5iKGWUO22ZHFsvH4+KUHSMwjuAfjl90ND+socBk+o9B1n2tVE/T3SVI42
 g6rvkVTYO+h/va4QgiCrg3cNsBUDFiCwSwGchU0hlzS6FYe8bT5tDTPOMrtDyoahUBsx
 Je0wKU7nRKFM6v3LyZcxh37wlGe4K0c6sO7ajqMjGoARjitF+IyFKDMzkRzoMaGKKe1h
 wCqqRDknzWW6lc7S3vC2obZFZDoDXVUM3dtSgrEOmsIofN89Y3suelrPUxaEKGAiuAqd
 3IEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294312; x=1793899112;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8X48nMc6CfN/sqLoFgNDKeQz605LG+FdJly2BVY1zjo=;
 b=txMInAOAuC93Uf2AxNLi0n7rkVENuRKHbKNK8RgPIAV+R9fjLPADnyC761f4whsATf
 NF4w7qnr8CwaisTIE4QzayHf/R6V2AAeHUXg9UhacLxL4FnE1FdhCF4+8b2LFUC6JBqX
 fTFKVkswMh0ZqKf0vC6PVJYoc/DMbU3MOpWMzLFtBzFfcPId4HvjbsaQc6qoX6wmFnB7
 XpnyB5iBk87sgw5ttMIKKH1XLIKTmLShX0BR5yBxaWaBI8MVktgjIlKRIqh+M2eiAPRV
 l++U25w4XNrPu018gwOhSjqs/juv8unn5wPCZxfCttBNU1g856fwe9Z2ZG7+/IF2wxPL
 IYzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9VxfdSQTeW50FAc5utKOOWIfhHAFq2gHhT4oiOsz5ZzHgowx6FpQoMQvGI/BDNWhUP1vo6Uo30xv/@nongnu.org
X-Gm-Message-State: AFq9FYISoT5/16B+dFeITuCaM4lEDsfGA5LLPp7NPeaPiA5ry63CpYo0
 wSQC9Q8W0iWk5OWzyxDM1FzwhA3c0u1vcRHsLd7arlVXP57BzObWTmMOoMGXbZCjc5OsYIBSDGs
 Nm0gqIGdX/AMQlNw48tRpKb7SEyXAyG0Qz0W0yTDMPf2WQtrr3LntgMfVZw==
X-Gm-Gg: AYBFou3NvHk+cbIJCV+CLqBS+n6ZFRIwziiJ6FGMct7dQwxMpJf6N3ZP8hsUeVH81E5
 liafH+alD5VX48USSFyogPheqFh2rEyAbkGCTe9n+1fBPs6ZocIscl6KzXJrfGUGtkttu2hFC/G
 2GrcKuslZHoO1mBBsiLZqmqkPtLH9UnqYu7BYjoDOcr52GZKZ+usKV/Rn9H4cUyI7C8MuDsGhtD
 //cCH2dxDP4KQ6l3/KeRoumudlGGOtPgJdA9tLQtwYK2nw5VEkGhjApWL0h+7Y4RPKWoRK+OjiT
 kyTVLyuXZOEySjFbI+wQSg8pZv0MImcGS52J1QkPh23NRmyjhsZY4ujBQFmyT5HFZqSPxXLGrug
 yCBgq/FzIArmUm5uCCCpel5jxhRpeFHKf7EG0DrUf5Nvci2n9RwcXFpBwCn3BcQ28JObkZg7gl2
 tiY2bK6luwa+jnRorflCyewQ5SuzdAiP7m4kPibi9nNno=
X-Received: by 2002:a05:693c:65d0:b0:353:7d17:9a86 with SMTP id
 5a478bee46e88-36a423eefe8mr35103eec.26.1793294310532; 
 Thu, 29 Oct 2026 10:18:30 -0700 (PDT)
X-Received: by 2002:a05:693c:65d0:b0:353:7d17:9a86 with SMTP id
 5a478bee46e88-36a423eefe8mr35068eec.26.1793294309886; 
 Thu, 29 Oct 2026 10:18:29 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a410c8099sm574955eec.21.2026.10.29.10.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 10:18:29 -0700 (PDT)
Message-ID: <585112f7-ecd3-43bd-be14-c651b7c0d673@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 09:18:28 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tests/tcg: Allow tests to report results with TAP
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20261029152009.19812-1-philmd@oss.qualcomm.com>
 <20261029152009.19812-2-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261029152009.19812-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NyBTYWx0ZWRfX5aiVaaZEo35G
 CtCUU3TXxLrcTfbEl36ug9Kykqm8PmGoNmCSJ6uaiYYktIN8afF4/1yxXxfR6No9Yhkeceg0XCC
 7YssipvdIhM94EZx17ZOEqE0Ay40b87B3GjAL2fyF/K9aoTZ4rQqe79lvVHxw0+V9+SoKkMyPMW
 boWB6aG80kmtZcuTrRln2DLLohpaZP5RNQ/tHF+NkYX0w2/MP+c+xRJZoBVr7uTA1QzFuzuzqtk
 afmNFXP5/Vld3Kwx9UELA69MsIFUVJ8Msbib2nhZ988OO1rxxkM2QlUyGJJaaXGbbhjmAfTzgIu
 ul31N+OvzzLXsTcupuduGO2q2ZSWyDu9oNfa5nererAnicvT1nLsn20OB/xiwgPXNwT7RJ4VNDT
 1RDofc2xMikb1cS0or2E4LE6KVp/P3mExL0k6qI2H3MP0pDa3bC+vfvQCIDLUi5G6qUzjmuTtJL
 Rmb9zA0UDWKTodYvTbw==
X-Authority-Analysis: v=2.4 cv=E8tYNqdl c=1 sm=1 tr=0 ts=6ae37fe8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=YbEPBKlZGmpRM0R3T70A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NyBTYWx0ZWRfX14M+yZQc/fcG
 /RZL8fedIKaD44+x1wxOx8t0rjhVxC+Pz8AYpKHBuoVxXdRhQCbB7iO/LELJw+BVu+TSmt3XQkC
 q2Xy9G6skbWqNhu6MgY9yUF82h7wO6E=
X-Proofpoint-ORIG-GUID: e3X_ZwUjW2LgTgOWsnfcgVYidIOBMj-O
X-Proofpoint-GUID: e3X_ZwUjW2LgTgOWsnfcgVYidIOBMj-O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290067
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/2026 7:20 AM, Philippe Mathieu-Daudé wrote:
> Add an optional 'protocol' setup entry, passed to meson's test().
> The default stays 'exitcode'; skipped tests (exit 77) are forced
> back to it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  tests/tcg/meson.build | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index 06f013fbe3d8..6666d0dcea2a 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -323,8 +323,8 @@ foreach target, plan: tcg_tests
>        # return a clear error if user misspell a setup entry
>        foreach key, _ : setup
>          allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
> -                   'depends', 'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
> -                   'test_name', 'wrapper']
> +                   'depends', 'gdb_feat', 'gdb_test', 'plugin_test', 'protocol',
> +                   'qemu_args', 'test_name', 'wrapper']
>          if key not in allowed
>            error('unknown tcg setup entry \'' + key + '\' for test ' + src +
>                  ' (possible: [' + ', '.join(allowed) + '])')
> @@ -519,7 +519,9 @@ foreach target, plan: tcg_tests
>          skip_test = 'gdb not available for ' + gdb_arch
>        endif
>  
> +      test_protocol = 'protocol' in setup ? setup['protocol'] : 'exitcode'
>        if skip_test != ''
> +        test_protocol = 'exitcode'
>          # still declare test, but skip it and print reason
>          cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
>        endif
> @@ -530,6 +532,7 @@ foreach target, plan: tcg_tests
>          test(test_name, env, args: cmd,
>               depends: test_depends,
>               timeout: 120,
> +             protocol: test_protocol,
>               suite: ['tcg', 'tcg-' + target])
>        endif
>        added_tests += {test_name: true}

Please add doc for this new entry here also:
https://gitlab.com/qemu-project/qemu/-/blob/master/tests/tcg/meson.build?ref_type=heads#L35

With doc:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

