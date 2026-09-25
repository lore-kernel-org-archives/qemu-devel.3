Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E6BC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 22:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAEFR-0000JW-Mk; Fri, 25 Sep 2026 18:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAEFD-0000Bn-Ec
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 18:18:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAEFB-0001XH-QN
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 18:18:15 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PIne2F2034777
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 22:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VjpsHIJ4tgSia9aayQVpJKJX39piOO3VTwi5iuaO+oM=; b=mfmsp0T79LDogCbw
 Nl79jbnqjAyluFPtcjKfPw8e4uP7XQ5i/E5cp06Yq/xXpwVsUAX/V4teSduJnTHE
 Q6Cw97DeCypw3uLhpbovmzVctQddGp/SVePQz0a0nnQZtY9utAcAP65flk0roFoj
 jau+AiXEUpIP3ok6tokG48ZS7aqdHsQbDsr8XjwA5TMTwclGPfp/g8DFlotUekbd
 LlbMCb1bRwJ2gpDuqBrsgmxGJSbjqn4uIC2owBbew4qfidx/3nwfWDmigi58NKbf
 ecLV30zVRiXnDbMyJyLOHd4I11puZX4jhVV2/6t0XVUfo+KzzijCqvvK+yyDm+Fp
 LB6O9g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwvd3s6c7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 22:18:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3282d5302ffso1775524eec.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 15:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790374690; x=1790979490; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VjpsHIJ4tgSia9aayQVpJKJX39piOO3VTwi5iuaO+oM=;
 b=BR5KEcTYujNALfUtsE1tZgH12Wdkz+c9k5+ydS0uTkNiZVcvR3ROA21oSFoHJjBUFR
 Dji3e2Mbfub/cZRa+hOhDSB38oDo0sym80NkQTW4CRqB/5VJ7Yu11eVywleMYQxSE/uL
 4LBceNgKFJKonIMU1Nj8iBacik5Yv6I7iGnqDC6XqAZXsPkfC98oXuwPCDy8iWrNYUbD
 JFd6sWYtSlw2uDGOo3xsrfofuPdA2FQju86191tfOZINr86zRkti9A0rUeLhJkOb8DcU
 NA9DuJ/7PYfR7gFK1RjjhQztShGaNtF3B4l6WsJ6+OoWind6kkmskzHxpEaYw4erB+1P
 O6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790374690; x=1790979490;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VjpsHIJ4tgSia9aayQVpJKJX39piOO3VTwi5iuaO+oM=;
 b=FEG6ekeKDC1h6oNTdmDm+rsnHkz7m5Y17Svi9ulRpRWF/6G7aWiCXVcrK00KFJVOgh
 /kkt/i8c5x26BZDdvbKv7bW7Ou5T/+9yJCakSZEXDZKHJDsJ92GFymTwDIqyTCUpeE5r
 c17qj6Zr0lDntclon1HrsZRacCLAPXRJehLaj2vmgvaeEY3JNB0kR7qwnpHWsQehDvxu
 FWaHmlNAA1T1moOLl8f1VbTo2EY6oJsX0T4wFBveSnJP1iPZkNx9QZsEIRkCn52SG0hr
 SfmaaIQpgtuZEmIMIYLoif0xb/vCNc56zTgSN9AIEnvqrSrcfp4o/u+7Z7f4D1Gcfg8N
 xHug==
X-Gm-Message-State: AFuF++nvMHLGA8ym1rZvVi2TvEYPF7U8jRDP9e2/4iPNmpXfOP2BU/mD
 fg1S4beS23bcDL6ZWGe9knscDyG32PzU5GYTXaHpxkkVry2fbma6ragcyPLjw6HFJTTeLt3skSV
 g+M1GqZQAyoA6uA9VQdxxj0keY50qoLueD1dP8j51IppdqFddjjowx+1gDeycTHkZJQ==
X-Gm-Gg: AYBFou220tyjx7y5Lb59/W7voQa5xXANGVN62XdwUeEWDjmh+YJdLFX6Xnl/3GKzukN
 nGBhg9mXDbWTHzl6DPoPo9ENa+HYlKxVRNjwout8gBnQ81hQdTZifeRl0emwCPMkY6T9QVvz6dR
 O/0NM3UtpCd7pQEht94HJcrbDWWa9ngTlhaA/WfrpfxSXwLHGbSliuQ2MBZMGvB4HgehOUiZfAb
 P6s/3V5NxA3e4/DX+2nUw0PYi6BoMB1+uJkwRVjSyNzKJoUdtEyaLan0eHWyB2FWI3tUdenph4t
 l1UVo7C2f3EIlk1hDgW0+hrr0gCG7PMudP/3YWXNBukfRnpG/sw+X4ZODmmjAjJX5OyjF/HuPa8
 wQw7FFJC0CLF2um+AQSO2YrYzl9PuAM2LHG2LYYQn8LTT132XH6jNLDWaI7bfERnUGo4=
X-Received: by 2002:a05:7300:681c:b0:33c:29d8:bc21 with SMTP id
 5a478bee46e88-3427265f0abmr1192839eec.10.1790374690262; 
 Fri, 25 Sep 2026 15:18:10 -0700 (PDT)
X-Received: by 2002:a05:7300:681c:b0:33c:29d8:bc21 with SMTP id
 5a478bee46e88-3427265f0abmr1192818eec.10.1790374689551; 
 Fri, 25 Sep 2026 15:18:09 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm8289345eec.27.2026.09.25.15.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 15:18:09 -0700 (PDT)
Message-ID: <4ce6f975-134f-4812-9d1c-be7ca1fa094c@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 15:18:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg/meson.build: reintroduce build-tcg target
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260918202704.9790-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260918202704.9790-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: icS9dPRAo9Ihh15Tb9iehuy5Px5KFHdM
X-Proofpoint-ORIG-GUID: icS9dPRAo9Ihh15Tb9iehuy5Px5KFHdM
X-Authority-Analysis: v=2.4 cv=YL4KWhGx c=1 sm=1 tr=0 ts=6ab6f323 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=axNxnZTyURvM4UcqL1oA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA4OCBTYWx0ZWRfX+7nVqhLfaqXC
 wKWfTfVeULxopQqgVyuZUj6jscfgBDHw7IvXENYNWPwiexG3xR++fKW94aUzWG+EJC3FDcmj6sL
 ETJFrjt3/Ft1+e9eTpwe8DUb4bxkE8jU/CTvtGx/hR2528W59lkPCf0hTo0JsTQcSzk/tADLpFh
 xzY80INod98BBUu4eq8pALnFnaaLnmrN6ldbYq3SabKIW1ZWauOU0KaXdaKs6//adZ9lbwio2GK
 x9Eqr9kY8/IRxBQFNEno3z8MrYmE5ryfAZEWa0Kf5To+fGDOI3/XYYk5HvMWL33acptKqt52CQE
 Y6h+jzqr2Jg53sNWKQnqZP+K993XgNZeaa286l7Iszl3u1RnjyqSyPOHcCvb94y6fE7c1ABVLnL
 b8YqkPqh75yo2Cr3uSvOPVFFCEvdWKGTlnarA06nNZVPacvb7nD9jwZToOtTXT8H0rW3Md/YiJx
 66cn+/JaIYQqyqJumKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA4OCBTYWx0ZWRfX0xK/oCfslXYO
 6C7Idfxr8BcqOyYigV2s8HkZS+TDjGFAqNrsg2A7Zfn/XXRL8X0JcDp5ic7NhRxf6/BdKO8iaSn
 kjoo026El4ykAfOyX0Mqyt9V3EhRiYI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250088
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

On 9/18/2026 1:27 PM, Pierrick Bouvier wrote:
> The refactoring introduced a new target named tcg-tests to build all
> ... tcg tests.
> Previously, this target was named build-tcg. Keep both for compatiblity
> sake if people were relying on it.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/tcg/meson.build | 2 ++
>  1 file changed, 2 insertions(+)
> 

This was merged into master (efa3b9d5ac8024078225e1ab434411fdfe53b457).

Regards,
Pierrick

