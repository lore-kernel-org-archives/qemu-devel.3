Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AF2F428C0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 18:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD59p-000508-9c; Wed, 15 Apr 2026 14:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wD59h-0004zZ-75
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 14:40:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wD59e-0006VU-66
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 14:40:03 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FFFfUN1792380
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 18:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3JBAtpTKNUQDD0eImjJG1gJksCjqyzXQqBttZO8OUYY=; b=dYV9L9TjqHKw5bnT
 UpzIsuDO1Uv/P4KrEdRUKvnP3i9HoK5dg0mJnsKki7BcKYABj2J++RkX9glRwjwb
 tAIOEFYrchEsV3ldVEQTrZhj/R89mWQIqi2z7kX73NDnC0tyHD0W66PuccFHaZp1
 ht+WZD2yAMvYroiMqYiHvD0YQlcjZYHjlUfOsXMkgQkx6ENLFO48U34MDQV94oFx
 N5mM6VnNJ0ymNCqOjYhY5Vs+blfE0jWQ5M40D37lgQc8bwh2fpsQ4vKbBStGfKOv
 +OL9Mco77vpKR6LrAjniqPqWHEwe1BMNeKoRuNXvA3wMWLXhWcFWjTJKk+RhMKBS
 dKTuMQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djd5prqeu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 18:40:00 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12c20d5d7f4so17532626c88.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 11:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776278399; x=1776883199; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3JBAtpTKNUQDD0eImjJG1gJksCjqyzXQqBttZO8OUYY=;
 b=T63Mn69XtJLPqU+fLNI3EjK2L3JgZ9HjJ6zkolrQD3Qd1M7kJyozF0sCKOrKvhsMti
 YbasVkfo7q/KQkpHANi5HIhlIqCrfCxHl8gy6afQszTi4nFdb26FbGrDm1hyNLMmKNWj
 R9vzVWcR0jzycyRl/LSccPdINlvtewYSjtooL9v85k3SjDrga0eZkPzBfyr5iZQjQreS
 3Xhtw1XL+k7x+SM6DQUOp2chqrSo+p2RHkZzP/NMgmdANu7qMwCC19jSqDFaCHX5FQq3
 P4nQnr+m7oCPqW0FgPmWOeIYc9furJrERLQHrD0ib0ps89p+1AARFU+eMIZ0xeeIxjRs
 0m2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776278399; x=1776883199;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3JBAtpTKNUQDD0eImjJG1gJksCjqyzXQqBttZO8OUYY=;
 b=Pc6uxmieULqekdIYzBdxEBfKCcWV2PYqje3+UFudEIotcZ9VSUBMWm7nQLY+KfA2cA
 rHx/MN/O0OpKpE/lCCGhCtD4syYY1+T45FvYrZpDKMDBOs0Cjv83/LhCf4cihjJyJY1o
 e/KcPCfn9mIKhT3iMJ8FjQU74S6Jg/w7zeu2s7uP/BIGFzXcZcn0iYG4y7AZYZmyfBRe
 S5ll0vbUY+0zJUumNTTCsaz1HYFc2bs9ul6/6qqcnKfODrrV+ARDQtDkNn2yukAE6jGX
 Nxaa8yVAAxccVkRJlJrw5+NKjvRFxkWTWR0Q7eWf5SmP8TGtIU4yfZVXTb2dieC9yYD/
 tw3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ91WhOAhFPLmAdkdU34oC567Q2UccPFZ4Bb6arGD8kYODM0a/ONjoIiYD9WQx0/ZeOBZcgERBim0ael@nongnu.org
X-Gm-Message-State: AOJu0Yz1wqwLwI1er9gWqKgrJKoJe2QkGwzsnSz9ArK1xcDk1aIZuA7C
 s+EDzDqfQt8kp2Y0s9jPHyxik/tO3OX6d2ntjTm6HGxrIo5KXyTfkswFMR2G26kxUSTsSlZJ/38
 HvH2NsB7mo/SxgVIEsNGvPcPRFH/TWPVxTSMleknaPCGREwmgP6u/jONi8w==
X-Gm-Gg: AeBDietvXar/N7b7Dx/aDa7N5XMBEKJY6K8fqpbUPlPaP5Lnvw6e5WC2nVx173uf2A4
 WPV9DPbeYSlAaI72VcJnmYvXHH/5+A+TJE5llyCXLg7gml4lM+nQXBMG/9OXLdN+PrwH8rWaLaz
 zCVZU5Q3VO4WyfEIVxOxXfAQyjnUJoeW4YUzjy2svW80ev2UpZyCeyV6taNaTCGlcd8mW/EX75e
 O2q/YrIhqBQd8t967g4TEs6Sg3bgwQXZT9sl9vwKQJgUnaEVKP2NPWutTPaO7qbV9pnGiGumsVa
 8qe0th9/YOi6e3teVuNJMUzd0AQ9AAHHnqzGFnUrSkd+ehZu0c7/odOy4P+btsuz8qC9dGi5Rfd
 h2wQgM+WLGeKfl3H3ZJKUJCTvmVaol+7IYY5ZrPnN8INLzve+doHTeNwk59npeq33OSPl4FY/3o
 wJnjwLwyc0sQ==
X-Received: by 2002:a05:7022:60aa:b0:123:34e8:aec2 with SMTP id
 a92af1059eb24-12c34e4531dmr14365071c88.1.1776278399394; 
 Wed, 15 Apr 2026 11:39:59 -0700 (PDT)
X-Received: by 2002:a05:7022:60aa:b0:123:34e8:aec2 with SMTP id
 a92af1059eb24-12c34e4531dmr14365052c88.1.1776278398769; 
 Wed, 15 Apr 2026 11:39:58 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c5e61d0bdsm3052349c88.2.2026.04.15.11.39.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 11:39:58 -0700 (PDT)
Message-ID: <2f3cc111-8715-4b9c-b6b0-04a2236c89ba@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 11:39:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/hvf: fix double hv_vcpu_destroy() causing
 teardown error on ARM
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: agraf@csgraf.de, slp@redhat.com, peter.maydell@linaro.org,
 philmd@linaro.org, richard.henderson@linaro.org, mads@ynddal.dk,
 brian.cain@oss.qualcomm.com, mburton@qti.qualcomm.com,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <ee6f642af1dab29aaf99f86ac9254ddd25765bf8.1776172276.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ee6f642af1dab29aaf99f86ac9254ddd25765bf8.1776172276.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uZc7w_vly50fgsbp2LtrD1JKGMNSZAdx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE3MyBTYWx0ZWRfX+DXiJxdkO2lR
 B125hBt/pZsXPL/AOBllstADpcDwc+qaMd57lfAfmgDKkl6QRIUDaMMMCZM4bX/y4mpl46MJwV5
 7DwgpscjniUVEk7o5Bj7P9nW/JV/ah52NlrHIvzHMbT1wmccU6zru6Ro0m7zslK4fxTIjWJ0Lby
 FuqTB+ilafH5eFjLQIZarADeDOsWEcH39Qy3UX2f3YzqjtHxk2J9i4vmIEwjZbcpZrwWK6XXTii
 +2DoKrogUDtE57JHupNV0pBTX4N7QJdrb9RpMC+kv2NeTo+qeItRo8EIAAqAjygiDRoaf8QLrwi
 0fbkKOmVWtWM1YVOGFLZQUzeF0P2q76eeEmdzkMv8hJklytFzSBi26VGTWobnOHMnNkId1cH6Ng
 NiGlJC+PwW4Jn7XBFbLvvyOZxc/hLit1XjXeGzyYiJ7Gm4E3sqfw2pFrd1xKvPwgr1keI1+2JDC
 k1vKLVtF2pxCey+jjDA==
X-Authority-Analysis: v=2.4 cv=AcmB2XXG c=1 sm=1 tr=0 ts=69dfdb80 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oqUwW9mxLViUxGmovuAA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: uZc7w_vly50fgsbp2LtrD1JKGMNSZAdx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150173
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 4/14/2026 6:11 AM, Matheus Tavares Bernardino wrote:
> The following callstack causes hv_vcpu_destroy() to be called twice,
> producing HV_BAD_ARGUMENT on the already-destroyed handler:
> 
> hvf_vcpu_destroy
>   |
>   |_ hv_vcpu_destroy
>   |
>   |_ hvf_arch_vcpu_destroy
>       |
>       |_ hv_vcpu_destroy
> 
> The first hv_vcpu_destroy call covers both x86 and arm. Let's remove the
> second one, as it is redundant.
> 
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
> v1: https://lore.kernel.org/qemu-devel/70cca2a5cdde3e6531e5c8f1e399e0b584d51ad6.1776096073.git.matheus.bernardino@oss.qualcomm.com/
> 
> Changed in v2: removed second call instead of first one to avoid
> breaking x86 (thanks Philippe!)
> 
>   target/arm/hvf/hvf.c | 4 ----
>   1 file changed, 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

