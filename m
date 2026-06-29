Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E5EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weEJT-0008Tc-Kp; Mon, 29 Jun 2026 11:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1weEJR-0008TE-NX
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:54:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1weEJQ-00010L-0u
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:54:21 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATSot2579625
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 15:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 58EuEwO7kE//jIOQouz/WDVIxHHUjmRwJ2Y1lJsMDAA=; b=P0OQpEwRgCG57WeF
 XC2S6RdRDbWMuttmQlbkbOSIsn2bVXbnptCG8TjoTxMMTOSNvO2Fe2stEskqiCF4
 imjoxsshljcRu/MA4v6mDoQPNifoni2pWJn2hnMavbUG6xLl/A80MR30xZh3gFru
 WoPaSxwAmmnu2oZGXzt2OnEiLpi1qDm7+BPt54yriK5ElS3odLtakIhQ0BjhJnVj
 SBhsciTwVAdr+pojw7wTiqkc71hQGSzNkwFUDWHNMclSV6qeZ36NovEz+LYJISMA
 YRQL2HVneQnhrUasOKuZLH42uHq+a8CXmgKsRfR1yTSFL+a4ycSJn+ZT8TlMrroy
 zqzjHg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7j82p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 15:54:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30ca3374c6aso9478495eec.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782748458; x=1783353258; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=58EuEwO7kE//jIOQouz/WDVIxHHUjmRwJ2Y1lJsMDAA=;
 b=gM45nZrqD36W/Z+jL52TRUl7KG6BiH5muvLVVQl+8iJUFud7EqC16Rn6S8LykPJFkW
 cgPSz9sHRDX7mJf9COwYPCHSJ+q86XFXLQPG5l9tYM38IC40GpneaNSRvLErn+QRUfPR
 HakNeXIA+ym/6VeIRSld49lIh93Oh9KVFIN4qz2WP0/Y4hN6glEuMN1o9gbyNNhdPj2L
 mJTJC0BUwTSMlWXGBJMz9ymJZkllTSZ1AFG1eLfum8MFGl0ZKo9hzfFW89gMlNypheeW
 dA1d3uZlIGx7Tx9OMd671MbFf8L+gtyMgoKS0+NFAHUjyJmF/FksJC83U8Wgp3S7cd3A
 CILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782748458; x=1783353258;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=58EuEwO7kE//jIOQouz/WDVIxHHUjmRwJ2Y1lJsMDAA=;
 b=PFF4v3fYNivRNsZwSqkJRRYny9jTxvE5NhCZ68Loxcnkj0h1Byqq4vTANsU4FRDmee
 QrCoOTG9gEOFofjOOpfUZP0smZN49FeZaEtoUkYjEZ0Gy1QlNtUF0lyNN/yeHAMr5Re1
 UT1Nx1lSCWHibwZt/F2vMEYtFTWIDm7z70eiPmeYtT6o3kMsmBmBhPN8AZFCbnvPrqVr
 SbgMIBMvL48emi+tuiqD97ZFYEnvX/g2WeT7TAS8mLwcsBbO7uJ/GQM4535yCBJRI7A9
 b00cq/E4Pfo/f2epUbOXhXQJGtH/2o201RS+OyylYio2gPHcMI9nXnXQ4fy5hT0bpYb7
 MYGw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrUdqU3jDVv6ldNoN8fICtQAMYl447epL1hXmHK0yycHXWcyAho8WxOlr3mgkRczZ2Qz4XvcyEpHdPy@nongnu.org
X-Gm-Message-State: AOJu0Ywb5SLhBfgHOp2t+TJ2AYLAGIZxIFY6v9g357Jae1vq0Km38KbA
 LdrEgyzfvNea/N+GojmWdSsEojmjG+wqiQmTUlZI9BItvcvzbfzjm0Zfcs5uGjfsJUlPHwG/TEy
 wnU3D/VosUpdGdfBAJsC4qMlc9mW1NG3KxYhnV1apL/xCF/VlTS7f0VB7hQ==
X-Gm-Gg: AfdE7cn1eNZ55Xyi6GIt+nvo+m3o6nYiFshFcMyN2RjO8axawoxS6ljQ6YN8X56W+QY
 o7TrPSh1P2EUri623DSfUmzye/5mO4nREiZz6DLLGKpgk8soFvxoGKzU9/pmgp2fQjs7P2yjm8D
 YgSIp/5h2EbeO2GRtYUI/gD8H0IT+Z86eroSTBBHykesK9AZS6rRJQl8hGo4YzzcCKui0AYGMYR
 ZrCnAwbao3D7s1+6EhH1332qPsVVb4VxZbsulHT3ZTitxDfAdAzFgslyZ8pBjMG75MoBLlwNZou
 8F8N3Y/SkarOm1vDC4X6QL1+pCSWscaYWIR2cg3g+nwOnXWE3/nRKkbQBJUSzyPMRaath7zLMWj
 7PSoaDEfngNnGwDQMQ8Y2F41Vch1CKxgDc0xvHxmBGHliqpgJkm0NxTSsjNP7E9G81x/U7G4hV5
 +dpfg=
X-Received: by 2002:a05:7300:6144:b0:30c:ab4d:da32 with SMTP id
 5a478bee46e88-30ee140bd03mr32458eec.36.1782748457762; 
 Mon, 29 Jun 2026 08:54:17 -0700 (PDT)
X-Received: by 2002:a05:7300:6144:b0:30c:ab4d:da32 with SMTP id
 5a478bee46e88-30ee140bd03mr32421eec.36.1782748457169; 
 Mon, 29 Jun 2026 08:54:17 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6d2e4sm46524677c88.7.2026.06.29.08.54.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 08:54:16 -0700 (PDT)
Message-ID: <f320d7bf-de2d-449f-be40-c79be30f15ec@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 08:54:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/system: rewrite gdb breakpoint and watchpoint
 explanation
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260629105837.71103-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260629105837.71103-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEzMiBTYWx0ZWRfX3OY5DNC8sH3I
 OCX/r91zF6PhE74YMsdNrrcLqv2AnWRBgFynnTfn7LQJQCMCht7wDP7SyULybpuv1Bje2qtJIvb
 U2wy4TEs/b/57qQfuMk3QMuMI7un13U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEzMiBTYWx0ZWRfX7SVqaF8EDc2p
 kEjWdHswaVddzVR1ECnSLjMHTic8L6NliKfH+PtMPZaKwfZ5sXFgn3biTeAw+dCiLsWO4/G1MA5
 DeL2dFermHvwmMSB0BJTdz6kChg+P8yqDHIxEwGFbpu8G9cB0A3ksCcpYIgy0nqGTh3vAZ1L6kD
 Jtk+xvwxBYDhIQhhH/03imTDWR1z5zvlEO8YXxyqKjrgU3XbWmuerYDQudkmyRHdzFHOHFGjcPy
 qWlLp+G9KIXcM15FL6KA9e0gqSGuTg3aMcezvOaS/hoS0zXH+hWPw8gEm4oXg2iZ9Lk7Ql/2R5I
 jcVcRgxIDNtKiPASYXzDiAAzvFFaAyeiy4MGsrzuAEkcBUOwUjnKS5osRaMw1sEeuyf674bwho4
 GuXZajD6J5kJ8+mclUCQ7+53JjYvWMfUuep82lxyojyZ9+U05sGzwKsqZI7mKb3h66T3sb0TZ93
 M4pVw2C6qekTovlAW1g==
X-Proofpoint-ORIG-GUID: cIi4J6Sd9EISUHx3SyW6HBGrKEncRLvR
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a42952a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=V9NsxrjiRnxkTc9L3doA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: cIi4J6Sd9EISUHx3SyW6HBGrKEncRLvR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290132
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

On 6/29/2026 3:58 AM, Alex Bennée wrote:
> There are a couple of gotchas we should point out:
> 
>   - software breakpoints can fail on early boot
>   - TCG treats all breakpoints as "hardware" breakpoints
> 
> Rewrite the text to explain this more clearly and call out the gotchas
> in a note and warning sections.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3596
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - made the soft breakpoint section a warning
>   - moved discussion about TCG's unlimited break and watchpoints to a
>   new note
> ---
>  docs/system/gdb.rst | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 

I'll let you pull this as part of gdbstub system.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

