Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4107606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iSIrf6wx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eohW/1zv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXtF-0005KE-R4; Mon, 23 Nov 2026 12:31:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVXsi-0005IG-Su
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:31:10 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVXsg-0008O7-VO
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:31:08 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGH5dD847547
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Coqw1hk4eYN4QEhsjryW6RcTMbE4J9Up27b+MpqtREQ=; b=iSIrf6wx3aSytmnu
 EhWNWrITNvVsIc0DOPNVbjBzwcRL/uxQlm+4KfhGMWk4RWweHm7LINKmjB+pfLaw
 qDH+nN6D+RVLdt6IZ2C6uNPkkQlbQxhw3TX+98eU5btF9e9YALWGvNmr2tq+CLSZ
 uoFVxzWUWhHXMVLvoKhNe1JbjPHH0ucq6qO3Oe3DFlPUEGsqhPvpmazJYcyFmGGD
 dFPfp05q/zJWjNc9HPBZJAma8l3bF9VTm6XUbwZgv7TulXbALyfTe/0kcNams9KQ
 /sGnv4NuQG9KzDLi2HdhuUHjUFWcPC5VgaeYGWXOtpEDLatbhBfuew2509S0vPtS
 RpdGCw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g742ks4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:31:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2f08196b148so15200525ad.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 09:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795455064; x=1796059864; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Coqw1hk4eYN4QEhsjryW6RcTMbE4J9Up27b+MpqtREQ=;
 b=eohW/1zvutnWhA9S5MLRmKcTF78yu7MzzpGrvY440sFfbmhBXJJp8ZjQdfYptncH7f
 nt0mmSZNs0z0Wv/j1kdHlIH6SgShaHk1BC1rRrkBDIRc0YN+Ni4kDK/ehXrmQBPCj+e4
 xt6RCyloAkVyTHQbk8S7RHzLS3FM1OsgNZ8RulSjMDTfveJ7vCBiKnlLryCi0FeL7kRH
 SUVKi/YTmcbjrblZFJj49UBNK8rilLeAGddhH1y+iKTWgNEzsNnMNBLQPbVn4hIIleYR
 tCv06Sb0btXY4GO9UtyQknEU5+ZAaWvCpX17PWsdf9RGJPHTmWi6P3me/93LP9U2Dwwq
 Ot/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795455064; x=1796059864;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Coqw1hk4eYN4QEhsjryW6RcTMbE4J9Up27b+MpqtREQ=;
 b=01lfzXd5DrIXTQLeIWqE7QlCKRlFcDL35iwBuybEOYt3HtUTAFZKIk0vNZ+IA91OVx
 ho2cUDd5ONqogh+fxgfL9ivkLx6XFS/mlnhjZSlsAicbOsIuxs2TrI7Z+hlYvM9rYK1P
 jNz+BZAiYbNncJrrNK3ROGZdeKBERpwddSeFwBwM8oZ8J1MdZy+Cs/2XqQ9dMJj9O1mt
 HRI2nEHNp1Uah0C3Z3Aay6WlvLapW+yxWctcitzJEq+FtRMEauOQIvTH+SddvbL3mw46
 2FpOvGXraOSgAlMKaBEU54sL64PlSdQAOHTk9QNT6jMIGIa6MPyIhzAIdwus5Ojt5SZ2
 z6Hg==
X-Forwarded-Encrypted: i=1;
 AL+hErEJyrB81K2XscRbEBO5Z452cSTgYIVMPTjN1knc5ZuY92YGnQxP8USeMwKxInDprh7Tc42Mc2rd+XqP@nongnu.org
X-Gm-Message-State: APuU4Z/9Wm31pNuYqSiRwrwfJvDJkpUSRWgJxZRezWKfr24lACizoJjp
 Uqy+DM8/ysrRlEGKuLFUAswW7sOHvzKunHPZQ3Ea+wJoAxDP4v47KK3vgqtn9mRxV86F+/Ry5dN
 ikq985HfZp6LzE+En9TTLUqbdqwdfWy84mQxM2aE8Jkfr7WAVnt31ChfKXA==
X-Gm-Gg: AZFdTZdS6cVkthCYH87u8UmGHhtSIcD4wB/9huUX4dmhEE3qCDoIQvOnLRJ0o1ParG9
 xbhWqrzWkxdK9Aw2jBqn2pDebYARlCn3hkdbj+XWXqznRn5Fr9c5Ohd2Orv0VApie5+ouRSK3jI
 PPFAoyDDxK9k2H1FynEp+PJZydwxRmmKn7E0QSwrXkUrkAWuqYijmTF7YOtoSgjM618K/t8btwD
 YsuxC9FzC7Isp5jzF4f7oyCtkvEJQuq10IXbcIw4txd0QFv7oVqU5ndjPvPfjSPcTMeRSa4owfs
 2tEtwDqOM7sCfsGBmc+sZCczyqqCec2oK9AEmF5NggLmU60i+9CkPL6hEeZPJwziyMRDf5E738i
 NnW4VDNygapdAcvoCHeGKCXRXRPiQiRsImJk8YyOhxyMJVvY1QPW6akRr/+lLf+D5OMpuP1gbvw
 Mxrs/gxhMeNB22PhHmUHSUYPPqBsTao1KPXZA7ZFzGg4g=
X-Received: by 2002:a17:90b:17cd:b0:3b4:1926:9e9c with SMTP id
 98e67ed59e1d1-3b41c8ff562mr11036297a91.30.1795455063749; 
 Mon, 23 Nov 2026 09:31:03 -0800 (PST)
X-Received: by 2002:a17:90b:17cd:b0:3b4:1926:9e9c with SMTP id
 98e67ed59e1d1-3b41c8ff562mr11036262a91.30.1795455062982; 
 Mon, 23 Nov 2026 09:31:02 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b4b3c71192sm2494988a91.5.2026.11.23.09.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 09:31:01 -0800 (PST)
Message-ID: <ea7f2d0f-6c71-4083-8248-dd1adfba22e9@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 09:31:01 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] MAINTAINER updates and get_maintainer.py
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FnWh8OBRS4HwbUXbaFx4WHMqyOsvUgPp
X-Proofpoint-ORIG-GUID: FnWh8OBRS4HwbUXbaFx4WHMqyOsvUgPp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2OSBTYWx0ZWRfX4rfBPUQTn1c/
 YOZ/loPlPk6MGZmA0f8lLUy3f+guWyR4XR3CHQL20WsDCbygNnO/KCfsHmv6KjHTowsYsI929Du
 J93PHNgYuQWg3iY8ZHLT2KV4RCeUVkk=
X-Authority-Analysis: v=2.4 cv=T/cZ3PKQ c=1 sm=1 tr=0 ts=6b047858 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=dOyaBjZXfel-uHxJA50A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2OSBTYWx0ZWRfX4ndSdhfMafkG
 vqMF7ra0nI8WSQPeWt4WWnm9VrlxhHa04TdvDqlG1wLmaMFflepRGM4tsX54t0OxM+2pLAEEay5
 kKVMYoZhTk96gReTzHZgJUXjVrfKBXqzUCiNxrx+qr1xIT2pr3UAsubltolTqP5h23TAGDKtq7S
 yxYrCTo+ydxK+zvSBwLp25BLSbFq584qBKZ27BFdUIcn4qqv0eBgWPVkR0S188+VP8+0KH6JG3+
 XhkLB4VHRy7JWZuyNtSoxWxXhk6rMMSBBcQrhFe3KhoeoSi5JVv3c0BK9iCudmLZLFzFGJUDyu5
 Mbuv9OVehiKjHgHkHibBkHm2slacqgLifkgcEcixOQSzJSvlCeCS+1a7dm0C4ujB3KqTXhvXllj
 r8d5mzTY4q0H+kXD0zP1voM1SV0PKt1/LeKAXbjE2Fq/AK4U/xx7HCgvU1L6ollFOgjBZRBiplF
 KX0+AS0Wbv8JuLW7WWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230069
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

On 11/20/2026 12:04 PM, Alex Bennée wrote:
> I continued to update my port of get_maintainers.py and it grew a few
> new options which I used in my recent talk. These are:
> 
>   --validate
>   --list-maintainers
>   --list-absent-maintainers-since
> 
> I also added the git and roles flags for compatibility with the way
> the perl script is invoked by the git's cccmd.
> 
> There is now an ancillary script to plot maintainer experience so we
> can see the distribution of experience in our maintainer pool.
> 
> On the way I found more inconsistencies in MAINTAINERS so I cleaned
> those up while I was at it.
> 
> Alex.
> 
> Alex Bennée (22):
>   scripts/get_maintainer.py: minimal argument parsing
>   scripts/get_maintainer.py: resolve the source path
>   scripts/get_maintainer.py: initial parsing of MAINTAINERS
>   scripts/get_maintainer.py: add support for -f
>   scripts/get_maintainer.py: add support reading patch files
>   scripts/get_maintainer.py: add keyword (K:) support
>   scripts/get_maintainer.py: implement basic git fallback support
>   scripts/get_maintainer.py: add --list-[maintained|reviewed]-by
>   scripts/get_maintainer.py: add --file-summary option
>   scripts/get_maintainer.py: optimise glob matching with Paths
>   scripts/get_maintainer.py: add support for gitlab handles
>   scripts/get_maintainer.py: implement --noroles/--norolestats
>   scripts/get_maintainer.py: expand --validate output to CSV summary
>   scripts/get_maintainer.py: add --list-maintainers
>   scripts/get_maintainer.py: add --list-absent-maintainers-since
>   scripts/maintainer: add plot-maintainer-experience.py
>   gitlab: add a check-maintainers task
>   MAINTAINERS: update Daniel's entries to be consistent
>   MAINTAINERS: make Collin's entries consistent with .mailmap
>   MAINTAINERS: make LIU's entries consistent
>   MAINTAINERS: use consistent capitalisation for Alistair
>   MAINTAINERS: update security reporting links
> 
>  MAINTAINERS                                   |  48 +-
>  .gitlab-ci.d/static_checks.yml                |   9 +
>  .mailmap                                      |   1 +
>  scripts/get_maintainer.py                     | 886 ++++++++++++++++++
>  .../maintainers/plot-maintainer-experience.py | 163 ++++
>  5 files changed, 1082 insertions(+), 25 deletions(-)
>  create mode 100755 scripts/get_maintainer.py
>  create mode 100755 scripts/maintainers/plot-maintainer-experience.py
> 

Overall it looks like a nice addition.
I didn't go through all the details of each option, not sure it matters
too much as it's new code anyway.

At least the fixes on Maintainers should ideally be fixed on this
release cycle.

Regards,
Pierrick

