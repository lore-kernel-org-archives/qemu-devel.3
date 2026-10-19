Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2496B606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AYtAeheh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HzYBTNZx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIvfZ-0005gV-8M; Mon, 19 Oct 2026 18:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIvfX-0005g7-Gw
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:17:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIvfV-00027Z-ND
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:17:23 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZkLf3914833
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yD0KXTfmqeBt/O0VoBTpq9lH6QCxQiMPpjC9z5uL/8E=; b=AYtAehehWolwZJ2k
 nqtulKH7EaC8BTpG8H77kU3o7ms4F3V+jApPOFrHBLxzDFyuUpgNZ8wMWZ4uywbw
 KlweIaPpcu+kucXtMPupHmSo9FK8CrFUuBhLmrNE4Azb1EkmOa2YsPSCtGIWeNCc
 WbsjzR6NVEIjg+EIBXmRcX0JqUgzknPmGX54PAARXfKzmBJSZkg3/4sjMqSSQpdH
 2lsZbML/I1aX7zQ4ZyVgr8uQunShKML+1xJBHGzroIEIGLQDBldkIUyQj1t13zel
 YMvGJLdkRbEIchPku74oHZSTcO1Sx7t/pB1Whv6i+b+Bpy/LgPNWL/CrMamel9v0
 D1/daQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr42guw7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:17:20 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35a04491c56so149965eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792448239; x=1793053039; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yD0KXTfmqeBt/O0VoBTpq9lH6QCxQiMPpjC9z5uL/8E=;
 b=HzYBTNZx9b314UauTX8yqSxnYf3ziFhJatjMDUUq61IIqTxAakOgM1nPpUwr8ur7q6
 H5XslUAiEaiBvHmQidM0cQQiIzLQk9J6MwGQKHmPfB6fwpC82ukR2mTLI2JQ3NJ9vq22
 bKtuv1YOTlqSvARar3d2Vn1lxvhKPIAUM0nddHkfGJEyNundhZIxhrxjSwg+SVuRfxC/
 hgKuZgvWHfn+8AXmNZOJmoVLyl7bBXaORNw/IyB27BA1aNZAnFKNLd8YHG8gChCduWTz
 G8NVexcSn/5x06C2QmyLj6T2nxn1s5hiLwNj8FC+VB4H1DqToifChiJlO74e6KJjsjgf
 TYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792448239; x=1793053039;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yD0KXTfmqeBt/O0VoBTpq9lH6QCxQiMPpjC9z5uL/8E=;
 b=iLrpXuRLUUUC7dflac8hRi+lff0TrnSRak96UTrP4p+8zDfYXNjy2fK33ECd+tSKya
 Ea0C01xqFh4G2/j3U9C+TozQRlWrkXQFvyxEx7UzOe40kfC619lWMUvUvFgL/0EP/xaL
 wyJw18L7dk6B4sqdckSy99NE3KDngBDODDVh22rVrEbjBGlqDyDhWELmGD/laTPmIlAJ
 9j3vTFQLL5M/Ldrvl0Ju8FBr0RDVh4ITw731KgWzQoSFRlt8X/3OiCHxgYYuhEKH21pv
 0lyY/VQIMZPwRGSeUByAEPRp2l5CRQkwp/8UQlma7aHutMgds4C3eFedt/p9VVLMDRi3
 3Q6A==
X-Gm-Message-State: AFq9FYLyKmMCdwEgskN2sle8wQ3NTZ1eMQDYVnYQaiuGatgsHn9+kkqw
 zaEu/IGVH1pSflBuQlAsenXVBmDC066oigRluebBve51Xj5tD4YWVtWFnIH8LH1YaRIPzDzI9m9
 NgxORSjKskkVjHgPID85rDhA69KdzI339JSiPEXHQr0iHjjobJvdkcZwz7VUVUo9Pew==
X-Gm-Gg: AYBFou2az0cwU6phTHZT9tHjTBWwOEsXd+afBOfb23c+ENkPAAp9MLsKmjtYtlOlkgb
 4PWGm2OyWhP7EwP2zO5n/XhrRTrDdIsrZiafwNBy3zqRUGpyTUd9pDo0eX/bCYGMfoITxXdq6XB
 i0boMINQGVDA29V5paKnUB4LrymtFvTtgybbsjr/9zL+lfWo7AKc+rHc8cVxNIeMo8wykvajHCu
 UuvobNlM5hGBLWZ07Ghz1otR7ydseOH+KJwYWM8ICtWxAA9qkleXJyxdDDKzC6y0YnTN/MAD3aj
 8gkENkJoi2iD75q88MYTgGLlj0i7G+d4lEFfYvoRcglNK4bkfyplZOA6Xy3Qu6bGVByQcMLbTzN
 tX3wuWCfCaPPog1myyq4BKPHUcO2vrd8+/2neShZviBSNegwajU5pxF0JxA0Cn+B19L9QwQ==
X-Received: by 2002:a05:701b:2616:b0:185:6c8c:d860 with SMTP id
 a92af1059eb24-18db8538935mr469179c88.5.1792448239116; 
 Mon, 19 Oct 2026 15:17:19 -0700 (PDT)
X-Received: by 2002:a05:701b:2616:b0:185:6c8c:d860 with SMTP id
 a92af1059eb24-18db8538935mr469150c88.5.1792448238496; 
 Mon, 19 Oct 2026 15:17:18 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314b16f57sm31842335c88.2.2026.10.19.15.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 15:17:17 -0700 (PDT)
Message-ID: <4070aab4-ba81-4ecb-8144-e0b1c7415ed2@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 15:17:16 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] multi-target: remove qmp_query_cpu_model_expansion
 duplication
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfX1tey7LVyR0pS
 psfD+w8635tMGLR8TwhYChwKvFlnVucdTe6Cs0KyNEKYRszhGBCdJ/5lxaI/gRKvN5LebjW/GG5
 AVDgmD75Mtxus3p/PWv7ukGliH0n3Yv6z/cjIciaOM+AMh4DY6ebcpHCMBsI4mzaQKG1RTrr/oR
 uwIPF30hlg0btjurX3hqEltm3pb0dPVvXB9ik3LOx62dX84v0J2M3wsBGa1NGFHwimxirtthfW2
 NC2S5P8Cnn61ijXAThdNy6vPY/34vaKqo5peewcfVZriFzgZBm3fwrDIjwjv0FFcvgDsZ8jPeyi
 b68GtktcvqpzjIky21RHVQ3w7ba4M5dT6MqC5M46XtZhD+AmeI5TkxzF+9OOFDMdPeCOYu3Q/sp
 pXhzF216VqWlgdtkAlZrcZW5JpHl86hHUwEo1Wo1ayFWVrHoG9IvnLH9GVuu6lt77GOFTQSbCNM
 XwMsHDvE7jlwVZ7k6Wg==
X-Authority-Analysis: v=2.4 cv=Ve9ir1p9 c=1 sm=1 tr=0 ts=6ad696f0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JEbRuu-vPki5EhdbkP4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfX5b9uWMDoacdn
 cTGEMv0pdZBDrKv6Kk7fuU7JNFet3bqsFoGmHJDwvOE33M5w6AIdWPcvjHcrJyWUA3bm1PyfneT
 BbK89dCc6N/iFscOHuFwn8bNoTRCymU=
X-Proofpoint-ORIG-GUID: yzvhXsoMK9fOmIJnbqaykvsnlm4AywrS
X-Proofpoint-GUID: yzvhXsoMK9fOmIJnbqaykvsnlm4AywrS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190088
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/16/2026 9:25 AM, Pierrick Bouvier wrote:
> This series allows to link multiple targets that define
> qmp_query_cpu_definitions. It simply replaces the duplicated definitions with
> target-specific ones and a single dispatcher.
> 
> It follows the exact same approach and structure than:
> https://lore.kernel.org/qemu-devel/20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com/,
> which was merged yesterday.
> 
> Pierrick Bouvier (6):
>   target/arm: rename qmp_query_cpu_model_expansion to
>     qmp_query_arm_cpu_model_expansion
>   target/i386: rename qmp_query_cpu_model_expansion to
>     qmp_query_i386_cpu_model_expansion
>   target/loongarch: rename to qmp_query_loongarch_cpu_model_expansion
>   target/riscv: rename qmp_query_cpu_model_expansion to
>     qmp_query_riscv_cpu_model_expansion
>   target/s390x: rename qmp_query_cpu_model_expansion to
>     qmp_query_s390x_cpu_model_expansion
>   qmp: reimplement qmp_query_cpu_model_expansion as a dispatcher
>     function
> 
>  hw/core/machine-qmp-cmds.c            | 26 ++++++++++++++++++++++++++
>  include/system/qmp-cpu.h              | 21 +++++++++++++++++++++
>  stubs/meson.build                     |  1 -
>  stubs/qmp-cpu-arm.c                   |  8 ++++++++
>  stubs/qmp-cpu-i386.c                  |  8 ++++++++
>  stubs/qmp-cpu-loongarch.c             |  8 ++++++++
>  stubs/qmp-cpu-riscv.c                 |  8 ++++++++
>  stubs/qmp-cpu-s390x.c                 |  8 ++++++++
>  stubs/qmp-cpu.c                       | 14 --------------
>  target/arm/arm-qmp-cmds.c             |  7 ++++---
>  target/i386/cpu-system.c              |  7 ++++---
>  target/loongarch/loongarch-qmp-cmds.c |  7 ++++---
>  target/mips/system/mips-qmp-cmds.c    |  9 ---------
>  target/ppc/ppc-qmp-cmds.c             |  9 ---------
>  target/riscv/riscv-qmp-cmds.c         |  7 ++++---
>  target/s390x/cpu_models_system.c      |  7 ++++---
>  16 files changed, 107 insertions(+), 48 deletions(-)
>  delete mode 100644 stubs/qmp-cpu.c
> 

Ping (sorry for the short delay) on this series, to try to get this in
before freeze.

Regards,
Pierrick

