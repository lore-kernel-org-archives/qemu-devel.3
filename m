Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609D9FED3F2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGMTx-00020M-Q7; Fri, 24 Apr 2026 15:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGMTl-0001s5-Tk
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:46:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGMTi-00080w-Fj
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:46:21 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OGuXfM3088039
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yAAxdK8Sx9nR8MWs+oMTmas8WpOwqvGr6E032l12tdM=; b=MVFohl0dbfXVgPK0
 kRpEUF/TX6W49gRE57GXg7LhXY76PESyJWlSTqgeoLOEGfR9wUgIWght+BGnMbpJ
 WENaI90UhIzmY5PrpFoy+uUwXfv9gFAMi2xme9riuz2rvMn84f8tAhGXaTYQDGMu
 UxaihM33QPExT02/axm+PkdxK8vtfjnwQSsm2qFLuy1F5SUArKWZSjXekYohWqtM
 KZgT/ci+22t+si71J7w6c7+xyy5v7qe4xFtdS+MT/xSxwy0XbHowlKj76sWVXijO
 6sRxuklG7LFMKGfoERASOzU4d2rgsiUAJw6Fp6vu0XbT6BfEu9G4SYUqc03rU2dx
 phyl0w==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drbqg0uu3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:46:16 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12c87ba0890so26347595c88.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777059975; x=1777664775; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yAAxdK8Sx9nR8MWs+oMTmas8WpOwqvGr6E032l12tdM=;
 b=EtvOsREJfFWDQuEYFAJmMb7Qv6mgLNdsvHMbY7jW4f7a257QDe6wDXRVXpJ0M+fGtS
 LNcj4ExKA+4qyg2zUh4PpcfNC+W0bWHQ2Zotn1amRuTH4Gq/47pZmM3xL/+O3dzjWKYg
 g9oR0SpjrFppOGRr921Yzcdt8BFuChTlgZzeys+E6FAZvwTLz8RO2zgfQ1qBRwHOAkk/
 AZgf0n3lacKWPwFAlvYheer76utqYVNN0AqahnZD9hkaPe8K7nlV3BL90JTh4tToGaEO
 F7v5BsyPze4hFt8XoiyrBQGSw5lO749MX0Dd4Ygn9OySpV7IhrWEAAWwKoz7BOgHaRCp
 If9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777059975; x=1777664775;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yAAxdK8Sx9nR8MWs+oMTmas8WpOwqvGr6E032l12tdM=;
 b=BfMpyhUPvosVKSiN+vlVkOd7HlxD9YtgZoYmLzvE1urt7+BP085PxrSBmiA7Z3k6zf
 vkOUqTeAtLFOVMkSmPv1tXlqrowthVWNjxN5cXpe/GEdbWXn5Ld9QVP+9/LOrC9sixLT
 jj9bxJCQM3Z6Wzb2Um+kpIflg6ayt5EP+ffVVKN+UBCqqwhkQex2hngqu0F9UV+LNOAD
 2XHGApFoo/i+6E3CNksHN6eoR71ZVi2lEHEOHsRtOkRulprro8/1ZIrapolWATKmVQ5o
 tuvpx4o+ozt9+H8XEnH2gSmEYlBGHfPvP4hwP5+5vo+XPy+IwPTex1Y2cFYMGJ1ZMu9G
 R/Jw==
X-Gm-Message-State: AOJu0Yx0E+LrSCK4JrVCsS6nNmd/WFus4wPxdvVEAxOmY6fwe6hFuuqt
 GXKzB/6sLomQ9omotIhbmLIl/ri/y0f0vpVhmgjEzoPq/zFxS4oKfXiZpFISFaMwafJFoJ5oiy1
 IyLnChOJON4mLgPK+RTd9VwHdewEyOlSnK0mnQXfShd0glFjwqALtGMw7Dcy/fEQNtPVc
X-Gm-Gg: AeBDiesyppib//PUUiV1A10faS3yMgnZIA09bdgO+KmnzPKbXYKJpxZkjMwvOo9PuTE
 CTE86EMVI13lej/S30mJ/Ty2EoReWPl7aN6Wxfxc9vK+FpEXb3jxohg4IrXaeCApCnsyP+0GZXp
 bv4cuaReldoGC7I/yCvkl/WWaZhnao3U8NalJtMm279AMCEWEZVKRYgEsTErE/pLnb8NwV5jC8h
 fkaZxCJKwF12ULXzsYr/U+WEykgpKtMKBsvES5U0alUWfUoxw8uRb6E/3+XFaT/5S63iCthg6BR
 sZowjm95BRxCRklqMmcfZWJgNLhyzlH0f6PURMghVmnUBXYrjg293aV/PB3biqLVMpYdIzfUEsk
 3DEPS/vBhWmZSyrGCk+8uHTF5UCR+bRR2w4aKld6wWZh5UcrNIdsoe2EtvH1l/sKb3sF12dW0Q9
 G58cvQz2Z6BcPKPCdt9lZY9bW0
X-Received: by 2002:a05:7022:4199:b0:127:33e0:ea44 with SMTP id
 a92af1059eb24-12c73fab049mr19209158c88.29.1777059975207; 
 Fri, 24 Apr 2026 12:46:15 -0700 (PDT)
X-Received: by 2002:a05:7022:4199:b0:127:33e0:ea44 with SMTP id
 a92af1059eb24-12c73fab049mr19209133c88.29.1777059974624; 
 Fri, 24 Apr 2026 12:46:14 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c74a18a2bsm50280732c88.10.2026.04.24.12.46.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 12:46:14 -0700 (PDT)
Message-ID: <3ab2614e-1810-40ba-b3a5-a6eaa41aec38@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 12:46:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] contrib/plugins/uftrace_symbols.py: fix issues to
 extract symbol/srcline
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260423213838.780814-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260423213838.780814-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE5MiBTYWx0ZWRfXxr10gYKIDKFe
 dAlG0qDFGfIDZLGGoyq42lCDpupW4K8KjYbYQaCG4iU8eHan/y9WTRKM5k96mTz4Yq3cmSWJcLT
 DT2d6CIwU6wFGiZBWXPsopI0nQQF0PaCpKxE5j01DNkkJ28bwerOn7AYNbylRrbpPHLj21CrgRI
 oAbzxmfWfflsxSBMi5fwxKbCQE/IPvZtAv3DkxfPOiJL+O+RSnbnBpw6RSpDUp21ycfV0aczgfz
 +14JN4Bdou2g0kVXpxuA/zMxcDfJs285vvdYIfbxVCfANU/TdFdO88zUvrOgYsdx42Phj7pxyoV
 V7hVZS/HtDkiloXYct4BUwyvbusjqKvs+0W8WcC0P5onzBqd9mLLibJsBrFFQo0C0WX+UqYy6RY
 Jg+gQ41l/V837Yo/rA1r2oTv4rVrdPT4czPNAt32vWdlSSmWqkz1aZBkOz2TUpHAOr99NPm2PPM
 FbYpPKAIAmTbcydt/0A==
X-Proofpoint-GUID: 24Ba8CXpdPQY9mldJD5m6Ltw4Rq9mfZ3
X-Authority-Analysis: v=2.4 cv=DKu/JSNb c=1 sm=1 tr=0 ts=69ebc888 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nuKj9C_xPEK4vApSM5oA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: 24Ba8CXpdPQY9mldJD5m6Ltw4Rq9mfZ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240192
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

On 4/23/2026 2:38 PM, Pierrick Bouvier wrote:
> Testing this on hexagon binaries exposed issues with symbols having file but no
> line information.
> 
> Pierrick Bouvier (2):
>    contrib/plugins/uftrace_symbols.py: fix symbols reading
>    contrib/plugins/uftrace_symbols.py: handle missing source line from
>      addr2line
> 
>   contrib/plugins/uftrace_symbols.py | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 

v2 sent:
https://lore.kernel.org/qemu-devel/20260424194451.1439316-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Regards,
Pierrick

