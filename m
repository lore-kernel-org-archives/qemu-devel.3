Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06616C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2aDE-00017X-Rj; Fri, 04 Sep 2026 16:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2aDD-00017I-Lc
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:08:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2aDC-00011x-1s
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:08:35 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684HHscB014668
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 20:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vJ7WC0ur1xi4/UD2PuY0rMWRemW5TJtZe7j8GHWAIp4=; b=fE48YGc5BgUHBlJx
 ize00A+XWsNINbJwKL1+J8pXuBAsRtceZEWw4S7keAIba/YAI5om0s9N0UeXufEx
 aHtx36MdY/SPemKdEbcFTGNc2LHZ+UlgjSQT22rYpK+4NK4kSDap9knBi0YMKTX+
 4R0Dc5KNNXG0+nhofFrZ8ybvPTakuWfE9FkB55PbOKR3dDqd3XHFPTvJa4s98XLm
 hh//p8LmuVMRlB3rxWoVs+zre9fGKXzp+IsKlfWJsNIOermfSi9KyXmtyJpOcxue
 woTYdns7nkUb3vnfdcLz573wAJTyPU2IF2jd951WPPGAmAa1a+vXRHaAH09uDAp0
 YObmXg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg00yhg94-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 20:08:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-398e1fafe17so1919548a91.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 13:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788552511; x=1789157311; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vJ7WC0ur1xi4/UD2PuY0rMWRemW5TJtZe7j8GHWAIp4=;
 b=g0Vwkdo3pm2IfsT3i22dZhvnJdUQD/1M59ULVAHv8b6lMH8US5ufbf+3kbe2T4RUB8
 iedPmAiS96WJK5793j7Ec8sVQH1anu7tDrtTaaZ8LMi+Zof5/Y8/sSJPoNCeIQ73LRZp
 Cha2k6/tz5MiNbzT76T21pjd2ujdQvjmvntTAPGpN4oHlVpsKJFTDPG3dQqmCDkpwpKH
 v7l1Ar578XxMUqcIc4mUULW+0p0Q5qPNAwpQujYIJFHBSVMupo94fBCiUysvSwFUs+Wb
 /J5G2ZV6dpr2pMWVLNiCXzlZm4Ba7tqIIGcmj96hoj335tHHCFgCrn/c/6m3kSM+yJ/a
 SkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788552511; x=1789157311;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vJ7WC0ur1xi4/UD2PuY0rMWRemW5TJtZe7j8GHWAIp4=;
 b=YtD9tMukah/Fymdv1NtxAG45589w4j1tpd3VaRtoM+7V0+sFYtTJFJUFomAt4eA2MG
 YoHzsDgLzXo1B0SeH9ZoXtitDVMa0WY+dAT2nKG1StdnCuy5HjidUy5Cm1L80AK77q0B
 rxRlg6LVYJYT6Y/vriuH9UM3SMQ6IJnQn7p7uirpM3aoX7M/vVmZqDJqxYkM02d+gdRQ
 Tnb/AbRX+IWpU1LRTJ5GDiOLuhUkUH/7By423Xhh/h90TSfRVyirxnGpOHqaZA5lKQTY
 eqdGIN35cBNxW4IDSa0C9kiB5D4kJAUNkSUdYQYauLhRvCRIdNWZFfEuMvzORPSZwyi6
 rYqQ==
X-Gm-Message-State: AFuF++l/NyeEVkMtnl3OQ9RxWL2TPJjc8xfmtMJCaO6sgFbdb+51vmHa
 oqkmO7iONRTQnf9QYNbJv81xFeI9p9a18aWySLYQ8WlcfROAiYmcw+ICUrYNTz8r1F0B8ZMZzuo
 Upu/kOssGqrafnCu8VgpVX9Z3/wgedLl4Brt/aCzUKihnl7p9T4QfwskO9IfwFmx94g==
X-Gm-Gg: AYBFou2RKatewkj1m3xNF42sa2NMy0q4fgtKgjbz7mrq7iuETypB4x7G1aSQlNdnt3N
 1og+aouxpFgUl05Lap/XXWElKGsaxAq7V3w+X850vZpq8KgJVgx4QKoRSpjmVYxjWmAW6rgx8YA
 IqQkugqA0M/bWETsMN1k5JfWDdXE70gKOTeA3kcoMzxJ+NQIJOELSpFge2/JlMwAb6cu0RZeNGQ
 ZwkDKDg7NkHVk8G3sqx+DL9YASLhVmBa7jv7DZbcMzkkySBTITzyccXEpjpxfFWhOJW286AgQPh
 ec7RAHQgm0wIIZuQM9WFKkP2WKeQ17iIt0e3fa2UQdzg6seWaGzqhwwCe3hJmDRzjd9s5ysag0r
 0sjYYRPRpfiHwTvJ5H0Zov+LfxnjJQnBLGg39bnuuHh5YiTG/lkP1rJ0kDVPU4OxwbxHa
X-Received: by 2002:a17:90b:4fca:b0:38e:5b59:c2ff with SMTP id
 98e67ed59e1d1-39b260dd278mr12368825a91.3.1788552510053; 
 Fri, 04 Sep 2026 13:08:30 -0700 (PDT)
X-Received: by 2002:a17:90b:4fca:b0:38e:5b59:c2ff with SMTP id
 98e67ed59e1d1-39b260dd278mr12368756a91.3.1788552509547; 
 Fri, 04 Sep 2026 13:08:29 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339befe870sm9625233eec.30.2026.09.04.13.08.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 13:08:29 -0700 (PDT)
Message-ID: <fa81062b-5a89-4bd8-bc84-9d82fc67dde6@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 13:08:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg/meson.build: fix build_test_depends
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260904200614.2808877-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260904200614.2808877-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hWZ6IZteeI3PqWu5wspaJcN2OTEWUltm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE4NSBTYWx0ZWRfXx4a3S0R8TEt0
 Gcq4VBYX6HuK1klZOgLi7X/wJmpfietn2vwPRWsmvR+Jbbxx18M2wJeXp6on+rn1ABMqQd2Rkms
 izsqCV1EyTSplPS2lVfDxHxtt5kxk+TW/Ub4RDcbKjBpfnkysg5Rpx6c2MORzvpsijO1b8GSqXi
 Oh67wbmFGukYaTT3m/AC3SQsxmyqIoiWkU5i7ON302psxbWakRxVQnl5HOQNckCkxD0It0mpGw6
 1vJJ5NROrEPuNqSUz4eoCM4380xI6salyepDl/5R+OzJQjcp15bZYNVDVSi9Ak6eGcN9Q1WYJDG
 BXVBmrrWhCDA28TiGlXYLvk06x4fCf1w/TkqUoSgqNwihVWNa1iYokt9B2UJ4gFk2UKbnxEBAq3
 G5Rkx3NktuquCFKuie64i/z85xJEIMXbqiF0YW4M+2nkAlI1gbSeMHEIiy9/CrZMR/2mXMes4Yv
 WS+iR1VNjx+EujY+M2w==
X-Proofpoint-ORIG-GUID: hWZ6IZteeI3PqWu5wspaJcN2OTEWUltm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE4NSBTYWx0ZWRfX5NjBHwF+LRxs
 A4VfX6OOM//1fe8cHfHSuO6fTyXS7GVokza7WYA1cAloeVYquWhkv7mHhjwjcERNqfzEIub1tok
 2RCqQOFjWyOK3+15xodcoTRQQl3FawQ=
X-Authority-Analysis: v=2.4 cv=eZcNubEH c=1 sm=1 tr=0 ts=6a9b2540 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=vPurY90SqSf-aJcHuzUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040185
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

On 9/4/2026 1:06 PM, Pierrick Bouvier wrote:
> build_test_depends is supposed to be an array, not a custom target. In
> case we go through this path, we have an error with following lines:
> 
>       exe_depends = build_test_depends
>       if 'depends' in setup
>         exe_depends += setup['depends']
>       endif
> 
> where meson complains that custom target has no += operator.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/tcg/meson.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index 243cdb5fc8c..d41a228fb3d 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -263,8 +263,8 @@ foreach target, plan: tcg_tests
>      endif
>  
>      if not has_cc and has_docker
> -      build_test_depends = image_targets[cc_dockerfile]
> -      build_test_depend_files = dockerfile
> +      build_test_depends += image_targets[cc_dockerfile]
> +      build_test_depend_files += dockerfile
>        mount = meson.project_source_root()
>        mount = mount + ':' + mount
>        here = meson.project_build_root()

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

