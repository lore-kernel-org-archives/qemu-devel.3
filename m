Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3EECD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 23:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZfh-00072m-GK; Fri, 22 May 2026 19:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZfg-00072a-Af
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:52:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZfe-0006Ek-PJ
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:52:51 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MGbHG31734187
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xhJSMTJrAE76yhSWWfS4NtgNwnjvhn01GU9fDhXjH4Q=; b=dj3zVjkXak+m2r6+
 okT0N4wapE7HRzbScJNELtJyI5eRF6mLeD0ggq2gpSsckiwPEYRaYp177ksFOr6W
 +J5iMdLeDonc0M6uAfeswhi4T6ogJiBRxzGYmkLuHqTP89IzBTl4Iv9C38x3O1EU
 vTNKCcFZaVBDUVHwcr1CxppIvTtbsay0vGlFKZ3Jm6Yv73xvPIeE7H9Bc8MqT9rg
 FbvIRjffOyzumRsjIudL0IfiG6UM+vfYqCQZo1+AJvNYiPsjSMrfdxzMLn21tcyG
 Gdyr7ut/DoRubMqohOTtXAOjjulXzugIovHWbV5UYSbUxMRvtBUZYksVImefdAUG
 UWErCw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eattq99bq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:52:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2f5943ca81aso28938248eec.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779493969; x=1780098769; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xhJSMTJrAE76yhSWWfS4NtgNwnjvhn01GU9fDhXjH4Q=;
 b=X+nDT0U204f1rUCqoq/72u200z4fp/tVd7bRdajEeMoXIub0rHjde+ASba2Evgu7OX
 xN5mL5mifNP/8lmzMhINGu4ueoN/rR2pTTY6GzI3j7CX0Sry6yNigHXDpWN+J5biNi7y
 24OQOWv8atSVBHbr+29QjUMtYHguKsSFFon3o49dcwUS784AQtPEGFto4o+4WV2QX0Lm
 nW2HJgcMJOsb/xIDCSEZawOyOqXuQ+YJdehPXyGGv1v/wenlCm6jVfxRnqkt6uLjY82O
 mA8g562he/og1fKb6Plbwlb75BlPGsfxEAvcQWbLEIbQ432BotijPlfD5G2T6PME7i/1
 19SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779493969; x=1780098769;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xhJSMTJrAE76yhSWWfS4NtgNwnjvhn01GU9fDhXjH4Q=;
 b=jf8VmrEbrrgQcV48yO56whgQtEGNEMxcFEnR0+QPUPxHENvOHqSftiyvSQhfa6+zu4
 kho/vZPLsVj/CFx85fyDpeup4qdeLJWPFNXVW7NIsD/Cwu4meNCqyLPZlP2yVhj+hixp
 8k37B9lLZ2WudyYD/br9X9Y5MTjkNGOPhqzhAnmwW/CwG/RO6cZYSDTATTFIuSMNU9lb
 LnfT28UuxF7RoksLOGxm+X8mz0HB23URZmAHjdXxlaggeyrJn0FwRXR4nASP0IhOARmu
 3ti7Xg/aOYN+3DB99C+5kjo/KnQHaYZwtuQ7ixUephmJr33lqh17Fxk4KwTDJEMtMgNK
 OfCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8U4D7Q3eXxdDG0+AHVdISFyBsiBA9O1RLLdmBxZ1K2/oVpJNNoCN5XerZ2Q1uO9pjLhQlvgfgvg+WB@nongnu.org
X-Gm-Message-State: AOJu0YyCJrzhxHvp/drLYALRSQNz6/3wfsSV5mdiWJyFQR3KqT/v+ixB
 xpSH8xodm1LXsB8JPvuhfqaxSkFizBUegN8mkf24PN52vZm157oNbKW+iE55rg/bQHs0fFXM9S8
 EM8HzywtCdOngo87zXV41Y/ZPfZs51kHzNMr6chE6j0X7joGMs7224aQeww==
X-Gm-Gg: Acq92OELMzEWMLpbstb0rmeuCCgTvQ0VYQ3Is8u3TRiWhpHRE4H2nCnvVkdamtk9UfS
 srG6Hs/qCjLHfc4VpXAPWg17qR/nCLOEDgETI7YWeJYnaXBz2ucMI0sjHQjsEtbkaBKqQnCgh+D
 br9JqsAinT3p1tR1QzZKrB1dZfnAzFdrCXqsIZU6tadqYq5b02G5r8hZ5s9Bu3IsThRoFWMbc+Z
 vL8LRez+qNM0U/X+xGZPxZDk2Qia1ycSld8yyAlJSQ5aQ32Akq6Oimx/CIVcnziOjZt2fq8Ioeq
 JWKabpd8OFqd4rO6s5UqElNn1ssV4FxgA4nyGVwmvRT6mlK8SfpiJIqTONPa8kDOIgff/qP9GGd
 zhfGxORZFBYRi0VbtLA7SXQeZYmOcSth7qXV5pcuthCLne8REBnXuRgZnamEDHnjxVkHX8QZCKz
 aUD0UdWyAF5Q4T6g==
X-Received: by 2002:a05:7300:7304:b0:2f5:5dd3:1fd8 with SMTP id
 5a478bee46e88-3044905eea7mr3029691eec.8.1779493968733; 
 Fri, 22 May 2026 16:52:48 -0700 (PDT)
X-Received: by 2002:a05:7300:7304:b0:2f5:5dd3:1fd8 with SMTP id
 5a478bee46e88-3044905eea7mr3029681eec.8.1779493968193; 
 Fri, 22 May 2026 16:52:48 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3045245fac4sm2042934eec.27.2026.05.22.16.52.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 16:52:47 -0700 (PDT)
Message-ID: <106bda13-0a1c-4947-b840-ee903623aba9@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:52:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/37] bsd-user: Add time system call dispatch
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-23-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-23-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzOSBTYWx0ZWRfX0K8+SXpHf9wl
 QihmmcQ19Usyflk1l4GpPHc6TIlgn/pV9+vk3peOrMNqoVYf5z3+jMfuD0sPYxEeZYjdZdLByeL
 D/HSgQ/5SCkbbhXJsxfQ6Ld37FtQRYsJo5dYhSJmR+pAAAd6BQ693oXJX4LLsdArX4yHahfB4a3
 +H98IVjnML9t+XTdDp1Ej2cI8uQele7oeT/XbHrZc47UCakhyvW0YKejpnXn/Bae4w34ciVJNDi
 26vAlOgW3BAl205Ct2oSEnXxicQS9cq9B3g83aOqbJZpRazBIcZD5Q+m3Xls6z+Nf+y0QDEpyph
 6b/rO5UT0yLjlVUrXJcSF/YDUb+Xy+lC6WL20kz3c1Uqs01brZgmUhgf5OSS4Wq6C8emq/wPIhA
 VbGO7JpVIxPdtHrQU7F+DIR42wuavTUZ9YVW27ACdTZ9PO78FgHo4MR3UAomk74fGHX/js/E8wU
 n9FgRN7CMrUJJqrfQAg==
X-Proofpoint-GUID: iJURNDXe5vmNwOicTBvbMP_ZJnFeJjHg
X-Proofpoint-ORIG-GUID: iJURNDXe5vmNwOicTBvbMP_ZJnFeJjHg
X-Authority-Analysis: v=2.4 cv=S/zpBosP c=1 sm=1 tr=0 ts=6a10ec51 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=lFVEQoN-cyEEtgSoaWoA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220239
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

On 5/18/2026 2:27 PM, Warner Losh wrote:
> Wire up time-related system calls in the FreeBSD syscall dispatcher:
> nanosleep, clock_nanosleep, clock_gettime, clock_settime, clock_getres,
> gettimeofday, settimeofday, adjtime, ntp_adjtime, ntp_gettime,
> clock_getcpuclockid2, utimes, lutimes, futimes, futimesat,
> ktimer_create, ktimer_delete, ktimer_settime, ktimer_gettime,
> select, pselect, ppoll, kqueue, freebsd11_kevent, kevent,
> setitimer, getitimer, futimens, utimensat, and sigtimedwait.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/freebsd/os-syscall.c | 124 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

