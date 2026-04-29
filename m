Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D34FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDtn-0002l7-Uz; Wed, 29 Apr 2026 19:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDtm-0002kt-0E
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:00:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDtj-0008F2-Mj
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:00:53 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbjqH3203450
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YGwBi+sYquQJR7uDVeJDs7hOT3XWkBEq7bPIAxFvUVs=; b=EMzjHUOEGV4RWdR2
 WRvXCEm3IjpPCqcfxRExPH0UJE9tealh9RVO3sd6IrF4xpLJkbAorFk4A1Fv5/FF
 CDFfbvazeXB2zDItwBr8U5/jQxpvCeP9lzMdOHgIMd3/Yj24uDb4fh8356S1xXlH
 XeKeGpYWiVrAfjeHSbkGyB5IH6+lceMvkM6oOgkIIR0z5ofBtoXFvfHz45bQdbJF
 kmqA6o8ZJp5Fj3y3JvSbTHzGuP4+FpErU5WCmwQ9RFYA8VCkfXS9PdRQmL+7YciH
 jdykS6uIE+zp8w4TXJ3519GJTwtUFP94kIFcRTP4mVMkvMeItW5euPp0RRYHrHJN
 XRDaWQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ducj83spr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:00:50 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2bda35eab74so348159eec.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 16:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777503649; x=1778108449; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YGwBi+sYquQJR7uDVeJDs7hOT3XWkBEq7bPIAxFvUVs=;
 b=P0cdI4GS4MaDsTTAYqGBpGYL54k9gEIX8sHVb5lILTmV1kZd/Lg+tCrZtKVAJUheCx
 DzLN829UxsoqExNMJEV+AR24OZLFM19CdkLrpbri8/a35fK5vC419lva2v7hcZCNg3xj
 vYlGu16bO42xwZ5jb2sTYq0/fk73eSjT9oCuBJRvNi8o+qChwfU/1AUHjT9wZs2XqUVO
 tjc9baxvNUTue/z8TvgkCO+p2HHjJ6+Ra37ImktxZegEX5QGzQV5J2XqMytK1xj07aKi
 udniGaQLFlBwX3TF2xHPZvxQRnditPerluSaPYlnX956DzdKOD2fkYtnyLwPYgJcSdoe
 eBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777503649; x=1778108449;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YGwBi+sYquQJR7uDVeJDs7hOT3XWkBEq7bPIAxFvUVs=;
 b=U71ek6bxMLqNZo640mBMTKQ6FHoU9Pk/IJgQyY9ERp5rLnlePA5vJ1Loe5sDxTYahV
 wM1yprXapBat4a1ZQYMHELWbuYz5uvnhuyq+Kw3uu/Vu7GE257f+plEMTtCCx0eGvmSF
 /jl0eGy/HSyJIpMP0+IXWHafXQMMXuwpemhH5J/0EYBWwf8BnDpPl4j/fHj4qKZrMrOO
 ib1oHRonKkiPCvb6tDRo8oTHI3ATJsq2yK4+K4tscX6VMA+qQrlx1BXqV7m36jfYrsVQ
 UF+RKjodoe4htf2pGie8sQrcbErq8ss1BWZRkQ5iewKXezpk9Gn/G9t9+6gSxedjpUS7
 sikA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1PYd9cMuGyBNWEXRdXYc4KELgsNXbsux/TMp6SCya8D+buwIrnfFj6ZInBG815tfYKLt4hjIKCgNw@nongnu.org
X-Gm-Message-State: AOJu0YyVL79+vKBYPKf2iwN4pphhewgl9YAXZAwnDEyKxhLr8saEMGU0
 fBmqq9wFY1P4VwA6dDjb4jJ2JfZAIDtftItkXyUGVOGN3/vRFlgbIR7C2U04itrAAg/2X1sHPfD
 GUlBSfMNdwvDCPsrjUS5p1XKxP5Ao0cvBQgHmCtcZbUdfo3FN/nwDUXPqlQ==
X-Gm-Gg: AeBDieurmywcthLDUzxaXKcNO6aOxBxOLMCmftklOUq1FlMLYs3soCUBhWLMuCwlDqj
 JLBmsDjleFDAoWeAWjCkJ+LIXK8Dwv/d06yGmYy4f4jDToxgLCf9mAruBvx03xndwJk9sgamU77
 pa1PN6ySUwFWOEbt8GjgiCYJ5AHoxXrSTDlBo9y157MHhJQA1uePRVmDIHyzVj9CMGgNtlpDiIO
 Yfe+X14TmzWHM4vZ1FzL3BbhilRJLONwNO2lOfEbMWUrSShm1mrPjxMUyOuFEoFa7A29fRfUEL6
 56E+14DpdhKJT/wv9sAv30x24uyQD8P0uso7U38xPqUVojbAgN3qpRNZgBN0Svi9qUbR/e+vSHu
 XaUoHnos3LA0TfdPXgAGq3oOz5Eg9lG9RiukkUJi4tlaHlGRGkJuC3fZhWnJnNZzh0j9uabd8pu
 Lj/aaw8cHuUF1WayTPlTWmFuUL
X-Received: by 2002:a05:7300:3248:b0:2a4:701a:b9ba with SMTP id
 5a478bee46e88-2ed4edd506fmr30328eec.14.1777503649264; 
 Wed, 29 Apr 2026 16:00:49 -0700 (PDT)
X-Received: by 2002:a05:7300:3248:b0:2a4:701a:b9ba with SMTP id
 5a478bee46e88-2ed4edd506fmr30308eec.14.1777503648588; 
 Wed, 29 Apr 2026 16:00:48 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c07058esm5638484eec.15.2026.04.29.16.00.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 16:00:47 -0700 (PDT)
Message-ID: <523cc81f-afc9-4790-b984-576f38adcc8b@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 16:00:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/17] bsd-user: Add bsd-ioctl.c infrastructure and
 termios conversion
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>, Sean Bruno <sbruno@FreeBSD.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <20260429-ioctl-v2-11-288639bc2427@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-ioctl-v2-11-288639bc2427@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iH-3HzAMakdxVrQLrx3P7WhETlWT5xA9
X-Authority-Analysis: v=2.4 cv=RI6D2Yi+ c=1 sm=1 tr=0 ts=69f28da2 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=OG5E2G-EYVFjY02b_6IA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-GUID: iH-3HzAMakdxVrQLrx3P7WhETlWT5xA9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzMSBTYWx0ZWRfX3hzcvvb0EMpG
 CiY1Z+80JsY+QuW7RSnSCK1EhR7oLHaa8ObcuYCQYlKAhsSTsgn7T8NssLQ+gip975ZD/kP9wlS
 vVvXPVbZQpRi12Yx2ojKzqKxLL5QY33CHsUPs+Oi+sosSS5So7+2KXtBdQQEfCTJNYSYQbR0zbD
 msVy7ycWCwrVt4HHxlXqLvwJGYqxYHH5yGT6WKKKDeRglXqZeM4Ct1ijs2ljjVb1+MaJfKuaR+c
 FjRooZ5jFzZyHXxxLkkT0D9XZvSUdkYO2n/k/zR2TT82S1fXNruK/rhMkh5LlhFDlCv+8P1CKs5
 fLkUXL27uYCocpdCDzfSa2A0kO9+uRkQycw+Rsv+yJ7VjjPBJHY/EIBfdXERlGfaSzjsdAlQqSQ
 nnfiCTcQDeVKE6aQVEWjXSCcG1GHd41ONl8CNtw+yxo5jcCOvV5EmMJu2EQNLZu57/f0p6r4Zi1
 Uwcvhbm6NU/P3DIl98w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290231
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

On 4/29/2026 7:45 AM, Warner Losh wrote:
> Add initial bsd-ioctl.c file with termios conversion functions,
> structure type definitions, and ioctl table infrastructure.
> Includes target_to_host_termios and host_to_target_termios for
> terminal I/O control conversion, along with the ioctl dispatch
> table framework.
> 
> Style complains about STRUCT and STRUCT_SPECIAL defines:
>   ● checkpatch.pl: 197: ERROR: Macros with complex values should be enclosed in parenthesis
>   ● checkpatch.pl: 198: ERROR: Macros with complex values should be enclosed in parenthesis
> but that's fine. We are doing weird things with macros, and it's fine.
> We can't put parens or do while (0) around these since they are table
> building macros for files that are included multiple times.
> 
> Signed-off-by: Stacey D. Son <sson@freebsd.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> ---
>  bsd-user/bsd-ioctl.c | 221 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 221 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

