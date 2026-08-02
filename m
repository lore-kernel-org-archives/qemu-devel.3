Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D305FC55175
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 14:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqX1D-0002Nk-7m; Sun, 02 Aug 2026 10:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX1B-0002LW-DC
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:18:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX1A-0006Ur-4O
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:18:21 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672B6oso1791329
 for <qemu-devel@nongnu.org>; Sun, 2 Aug 2026 14:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cyGJbPOh/GA2iXPjLis00KdtdPYuuDRO8asMSLi3EX4=; b=l1rM8JP+udTzEhfr
 GgJj4HsS5RKfBw8kLP4yttncKykjPcGv6u6ccgwVOQJHncNaF2KR55N8MaMmnQ8J
 uzIN9ICPyyKl48r60loji8xra33eOjQYbrM5bKn9pTczDp/muSE2HEuuqMy0IQkQ
 NQFRwkeQzpF3C833L8aVDcVN0R9WVrkYpwG/H2K0spIZD+MUWhFwM9y46BbB6lic
 o/v701ogB/+Wh+Nf+xVZOfJ7K+gRZ7pi8KTFI450MSGQKgi3Ni2+4BwSddoVmLsK
 oqh3sFqEhy8pMDSjvGuHrxgI1RPMMqpkMUQeFflvtm25QE3+yokTs5XaKuP73MTf
 swOXww==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8tx30ue-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 14:18:19 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-907c59bd65aso21362156d6.0
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 07:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785680298; x=1786285098; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyGJbPOh/GA2iXPjLis00KdtdPYuuDRO8asMSLi3EX4=;
 b=ZGguaRmlVs+AzFT1wim9616bF0Z6BoatlMDdKY+9CW9BTwGaoAqQq0GH8pxUILZdR6
 Ny+41t/jB4j4OQ+SuA/VQeHST0blJ0R53i4al7hZHCvNGc+EOtKuCTko23oUdqRD0b8s
 DdCOd8W+AgcncQHcVgO88t6cmQTfdP6SBQ9Ej9wr6SAetSKDshs6sx/ywO6yJCHmOAgE
 PDbjYa5y4iDN6EeJ6+dTH5hGVWZv9KqxAYhjigzC5fQfJ7kOcyQ4Iy/3V0QYhC7SOCTh
 x+/ef8hc+Kgv9W0sa+reZDJvKrDrG3o2wKAREnirg5CiPJgB+0S/RklQMprad1rMRcB8
 3IpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785680298; x=1786285098;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyGJbPOh/GA2iXPjLis00KdtdPYuuDRO8asMSLi3EX4=;
 b=i+WfJm8IuCXh+u/A7Yyt8bVIgTwoaJR6FDF8NXpP5ZwJzUNd/D4uMGKluVL/X2AVkv
 Z2ZQWsYyABQOsJRkYOefMc5Rty54XVVzgkY0ie/v7hPCfWqcWZbI3lcjkxVpVrPp37hD
 beTo+FRF2XCsoFz+IwOmTc2g+77X4Nbkn60WXTg6xbKT6JsW6cgI7XQGVqPXSvh0F7qd
 Vufv3wDI/VwZamHX3jshJL9jW3xsTdJRvWF43NZksYUAVDnWuiEgc4DKza4n2REyxdRu
 un/hiJbXRoGuTSjqNFuMjkrwOfzMAM5Uc+2oshOmTejn8WAKBeZYzw/jcPWyxaRNZT3q
 9U6g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMqICwgjCRvDywJ+f86zV+SdjMHIbzmhCmKXW93sMmFWAmKDgWQgxPzYwAMqerM6cO2Gpf64cWuW4q@nongnu.org
X-Gm-Message-State: AOJu0YxFinnjwpjK6I7irK21RdEPaVqUAzhkFCdzybf8X/8iNlbehJeu
 T49IS0Dgqm0bJcfTxvHlG5lL/xJRDAxoNWcbnVLgJ3co+5/DpBScrSUXiJyRkb0u6yWXbsCHacv
 RVnsaoUbNt9y9t2aJJbtM+vwNv0dHLlShQ8WAjbNl9ToYBujxvpwzV9Iy4A==
X-Gm-Gg: AR+sD12B1uDUwrdwMMeAilxw+4ijJtIXWNQPp7w2E52qrzxRi+XnRSKVkUGKpuBkOoM
 ht7zWr6I/j9NzgRQMTRloY47W6Agqu1A9X5zdASCChitozD9Pf43cjViPPMU0Q9swc64+16Yiqn
 NX2CSm09wmwTYaLV1wtjch8nxPX5jf9YhtfzTOoGt/urkL8TM/vba7lzoJvCZc8eAD/P4896YRt
 5dXmnBeH5Gh+r3L9dLnyjr0aCkUe5jGknd9y8MXqgWt058HS2LQRbjQS71/05R8mx/vSHh696wH
 cUFMTlpVbdunZXWq/Mq0LAue4QUAsRI6bBNJjjHj5yTPOhAvj33Go4GMJsFDzMWzeE464BImNg0
 p2LNfdvhuAigORZ1E2Y1NM6EfEmtpqek4Hr6XrSVorRWaHhPnQGQ=
X-Received: by 2002:a05:622a:400d:b0:51b:fde4:cd4f with SMTP id
 d75a77b69052e-52b56793ef4mr137621821cf.30.1785680298548; 
 Sun, 02 Aug 2026 07:18:18 -0700 (PDT)
X-Received: by 2002:a05:622a:400d:b0:51b:fde4:cd4f with SMTP id
 d75a77b69052e-52b56793ef4mr137621171cf.30.1785680298022; 
 Sun, 02 Aug 2026 07:18:18 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807eb12c5sm86264055e9.3.2026.08.02.07.18.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 07:18:17 -0700 (PDT)
Message-ID: <4b08b235-0db7-4f44-95b4-405e55bb19a8@oss.qualcomm.com>
Date: Sun, 2 Aug 2026 16:18:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] target/s390x: Convert op_ld64 to op_ld
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731185628.23161-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfXyx+McqhEBA6V
 rA/UgvKahPXaXrWSTmN6EEo0pk1JSj9G/qHO0Z/lVToe2Ma2g7FDlHq/ojfV+3Jhi3XuvtwKM4h
 GPkmM/+DmNACjzoTdfyzFAT7KalZ8T1q2XcgMJnqBJomuiuTgcLQb4BuqcK1UlXeyBJ+Dety9+1
 +mfDNxIUCbcF+lX28FCjximxlM2WNBteKvx3UrOPGXk2RT9JOu3Y+8lJV66/D2omcwHG3KQ9TFK
 sd9KZaU6BarY2dWVEg9m4IjYm+L8jwzUdc+VCEwcpOuJTSYcC6rIsO4fwuW6Sie0zxrEMDwzXlU
 BgBCE+9oKhlPEvS2fXNw58WY/lEfZ68H58JNN82+G4GFH2IQ83qpGfyPie+dbT712+ayj3fHA+O
 WjB7neWkKI3wBP49sleb3xBAORUWgRke6KUKGmZThUjiUuYZi3PZ82JUvB783bDkyFuTxVp5Osq
 LW6IT/5zd5AqFOlgZfg==
X-Proofpoint-GUID: ylJ3XK-rLsiol_P7IRYyGpHN2fmlzjKU
X-Authority-Analysis: v=2.4 cv=T9C8ifKQ c=1 sm=1 tr=0 ts=6a6f51ab cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfXxZgx4rSfqFtm
 pSnOiMWiaB2Q0sNtwLTbVR982RM2cLnjPje/+4IPfK3nY6bQQWFWlA8f19Prt77uzcpDLJBnrZu
 baf8W6HWM6utQLUEvgzGDHfRnEH70cU=
X-Proofpoint-ORIG-GUID: ylJ3XK-rLsiol_P7IRYyGpHN2fmlzjKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020126
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 31/7/26 20:56, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     | 7 -------
>   target/s390x/tcg/insn-data.h.inc | 6 +++---
>   2 files changed, 3 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

