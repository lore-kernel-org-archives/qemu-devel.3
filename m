Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9CBFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHNyr-0002WO-1k; Mon, 27 Apr 2026 11:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHNyj-0002W9-IU
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:34:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHNyh-0000bR-Ak
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:34:32 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63REGWIo3639686
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 15:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BVMiRiLjXwYoue94OhbzC2h4DdgvBg7Yu9zZAvYYDk4=; b=e9BJlQtazaxFHrYw
 rQqUs3iVkFjTnaxQ/1uLh2X2gra/nMhqwyp8F+4iBZVRJEnAv/1a8beqT+s/v6qF
 OfxkTIl6NrfSdsCzSGYuqdSXQ0QmCerdzmhi0Bd4B3pHjepraaHNts7mN/ivYYct
 T0AEQUuvPlPvvDodbs1CaAFu855MDNzTMjb8ZFQueiza3rebfVa4KT/Cx1DgtGIN
 Tc4RwDCBjJpXtM8bGS5Y/ffNibL01A7aeHpQuJwn4wi4APgI9G5lYdQ7HnCMpBLV
 F2i/R0RLGxudKsrWCIT6Q75/nMurfdPg2DKF2LJdwjq1Se+s8p4LO3zDyAUm2fwR
 SZ+vxw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dsya02r1x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 15:34:28 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2bdf6fe90a9so16244809eec.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777304067; x=1777908867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BVMiRiLjXwYoue94OhbzC2h4DdgvBg7Yu9zZAvYYDk4=;
 b=BJwiCRaR6qVcyqy0qVG6hGbUSBExI+ADZ27W5pdztWtnyVsEUmcuDV+SFW8UrCfyNA
 v3X4AF9pJTIERJtqo0B0LuQKonNbanHxK4AQgwddHc9ibT1HBNNxpIeSN5TsNVNSbQxo
 RyQBrrxJlT5yVO305F7XwouWKCagKIbBB2uU9Q4zospZwVdr/WKa2RdQ4gDPAQ7ebu/P
 rRV6MV159i65KRVB/yzARf7h/fGQJgJeJ/Eppa/fgw2FPsiqpC64rvbvdfndZONH3abG
 Co1hccXSWA5wAaX4EAj/wYm7TwANk5ub48WikADKyVAbITWXZfWDReFXyvdT/d3XH30q
 49wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777304067; x=1777908867;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BVMiRiLjXwYoue94OhbzC2h4DdgvBg7Yu9zZAvYYDk4=;
 b=mg6LGL4WiMsFPuHvW3NBcOh8KF7iwC7emEWFWvzNvP48r8brZg+iHPzViBKNwJFI+G
 USj64lZv2+KgzWrEw+0EzrlUuLQXPrh6441dKV7pkRR+KbNoA1LW6toc41lHAicOax6X
 sFCASHJftdb5YXjbj/+a31fedU5BRemUVpM8F3x9/o2CrtNStW+uIwCnpiju+of+sE94
 Qqcq8LGtRulXRu6OezaIT2xxYCXMnoM5tZniVh6/tgTGL5YuIQSq2rG0M939soPDULzk
 7dolrMUh5BZfLzTG6EBnQRldhh5yJvaLcg6FX/DQSmHkpXApplRtVVzxOGJ2Bv7yeNdN
 F7Bw==
X-Gm-Message-State: AOJu0Ywup3T8MIwavg9EJIRhfUOxFWlZ2BWgiMVh6VnZffuflpnZKgZi
 hDDIpXIj25TEI3ORJTzNCAW3MXUS87fBcIRnmqEk5iYQlB/v6pE8YtJxSMrvc2Nv7zIM7pRqWLr
 AtrChHDrjaY242ZWnh9bOWXF7KWsIWCBgUG8CNrVN9Ozo9cHb1HxxCr3eka5Di8Omzg==
X-Gm-Gg: AeBDiesX8DedlYveGDufBCWY903XFLGLdHdWH+ml/70x5QUD9ensciHtm8h5r8Ipjov
 aoaOId5142kkm0i6vUo5EowzM36B0onT36M1hGH6WrBWot36UAaith+ZgYqoyLtJ6vS12Ow2N4m
 Z/HuleSRzCOvPPpDUYlWfut5fxBv/yK9HlRwaHhCkG8qLGrXbdvFfTQbHxycvpMg2cz8sM2ciZE
 IYqm5n85AXdP9bFCr4Mk9e8ZT35olm0Ig19b0JSDdQUrk/z9JwKIwXqxiD1oz4O19Pr13YyfC8U
 ObOkFiQ/MXBs62B245is1QLdcnBtV5UonbfV8bHL8CRz4Uv3JEMXdOcYApuZaaILHfXeofwqzUZ
 qTtmOY9rnmfuGfKr8OtvcdtoujsroOE44UjPWZ/cXA7YX5AyKXEuQAq3AC6ZWCBsJdNTrifqPdv
 JayHr/+n2uMh9oWFJcUiglchOH
X-Received: by 2002:a05:7300:fb91:b0:2d1:e92c:f7ff with SMTP id
 5a478bee46e88-2e464dae99fmr22437555eec.1.1777304066764; 
 Mon, 27 Apr 2026 08:34:26 -0700 (PDT)
X-Received: by 2002:a05:7300:fb91:b0:2d1:e92c:f7ff with SMTP id
 5a478bee46e88-2e464dae99fmr22437536eec.1.1777304066189; 
 Mon, 27 Apr 2026 08:34:26 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e79c2954f6sm50326908eec.30.2026.04.27.08.34.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 08:34:25 -0700 (PDT)
Message-ID: <2322d056-f05b-410d-a479-99a84612c69e@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 08:34:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] contrib/plugins/uftrace_symbols.py: fix issues to
 extract symbol/srcline
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 manos.pitsidianakis@linaro.org
References: <20260424194451.1439316-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424194451.1439316-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: z5xYfmAGhGC3wdjD8KtZo63l9ZdF8m0y
X-Proofpoint-ORIG-GUID: z5xYfmAGhGC3wdjD8KtZo63l9ZdF8m0y
X-Authority-Analysis: v=2.4 cv=DZEnbPtW c=1 sm=1 tr=0 ts=69ef8204 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=auLrnYdI3Uf-mLSafJ0A:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE2NiBTYWx0ZWRfX6kDLTG1GYIBE
 plqmJb5waq6D4D2ia6+IpmiCDwqEM7zjmvBop0hMD61VLoES9KgT9JloMFgLGc1w6vGotH8LOvw
 aqH6oKn3YdTIPoJFk2A4hu/laJIkN1ewIIsZZyJXiqsoels3l8GMBd/lLp89k44B7yx73Vr8O40
 aoE9eshxFke/WQeZ2y64Jl3fiEpbRma4vv1nJAUXJQ02N7Qgv1gDPIsJbUQGVBX0peN3Vi7W6MN
 BvITmzRioLRCcTHSCYiSdTP/ZkMB34V9tRKgiD62rvH3mEC1pB4eELaVmjuuNrcWhZwOx7HWasD
 cauC/EAnMo/igdf9iSjtGUJTyszf2w1GuhrTPg3oUIuC79gbhW2iLNbpj+IK/9vyJc3EcF5Ne0t
 /RmYZ5Ek7y0fVteM8E8uX1PD2YILBDWc/D6qvla2C8ukR+UVnlYBoxPjTy7Z0IDfvQKFxS5JBXU
 rgZwUHUM3FzTdfBV8hw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270166
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

On 4/24/2026 12:44 PM, Pierrick Bouvier wrote:
> Testing this on hexagon binaries exposed issues with symbols having file but no
> line information.
> 
> v2
> --
> 
> - fix first patch to deal with the case nm returns more than 4 columns for a
>   given symbol
> 
> Pierrick Bouvier (2):
>   contrib/plugins/uftrace_symbols.py: fix symbols reading
>   contrib/plugins/uftrace_symbols.py: handle missing source line from
>     addr2line
> 
>  contrib/plugins/uftrace_symbols.py | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

This was merged into master (aa15257174da180c6a8a9d58f87319cfe61c5520).

Regards,
Pierrick

