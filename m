Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F220CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 23:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZdj-0006R2-69; Fri, 22 May 2026 19:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZdh-0006Q6-Kp
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:50:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZdf-0005Ub-UM
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:50:49 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MIOrvh4007840
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XpFxWEVBjTh0RuGJNhrkbjkwuM35qLcDsC+0AMQBYrE=; b=gHnPiFVfdz3cm6Ei
 cxriYvsKeUzKx0Qzo7HA9vDb+ZVV/fZlFq7m/vPRM2Fi2dqN8Yl3Puyg4FRlatiC
 bGX7SzVHWAj6G+AdpEQNOsuJla6m1kskZIp7iLPenE2eIMKNA3rnx9DNUPZ+hZ6X
 yBhLYUq1p1dmosdUuYSspVW3kE0woBuVyYX1Q6DYs4mYQf0ekZYBKLBrbkkm6LYI
 6B1aOi9SBcpC0cM7fxp3ZETHoPOoYbcdz4Up3mRaVuwBn1gUAYtmVI2qeuSwEb/P
 hEN895tssLlbaEiGJmRQREvNFokU7ZPHb26bFNoxIdk0WLd6E3rXnLOHtz5wbWKQ
 QHKbEw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eavd98v12-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:50:46 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-135fe34cb98so6031063c88.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779493846; x=1780098646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XpFxWEVBjTh0RuGJNhrkbjkwuM35qLcDsC+0AMQBYrE=;
 b=as7i1XfQ31mV7jgccEvZw9YvWQoDTSJxT9UX8ZHWkeOKLmvhUj+E26bpCL7mnF6b4c
 J0yvmsj4srzIG5NjnLPH1ty0j+GK8BSt3uQgkQImTXoWSUqYzZaBmVLZ7M+d2hof3Pxd
 UWV5nRgcGQsHOJIVC6PB6deyZAK32WbNU5b11pKCDycZJ6aYBwWfN23Y3ZJgyeWv96Wd
 xKHhu2Karu4gcH8KUiSQsmyu1LCdPWppVDzPa2V9ZinzUUUSdwosjDTVtwLChfGPXQFw
 qkMigiZDIeaDr2YSnLe+Kdgk+jsm03VDRFezB3zi/HEbxzdYp0wlcGRgScl1mPloCbij
 uqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779493846; x=1780098646;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XpFxWEVBjTh0RuGJNhrkbjkwuM35qLcDsC+0AMQBYrE=;
 b=T5e74yW/toNET5flLj1dcThDWfygIfFjyUIdiPKZHkKAYIXlAfOSKeBKeUOwygyPm+
 HfbKFoRjnxIawv8Oo3rbwwciBZhL4wGNoID/kfSb7rE8iSM0c0TGTzqDKVG1WggClBGM
 rQBqSi5HlC3xAxKpIpM+Adeww4XwOpHBsZietywXWyprVP8+9qUtoX8vpr1ve7CGqOtT
 a2SW95lPzQfeWPj9p96A4Pmvq7CuA6yeB4zO6HUjTXxqO/QORD6fQKEZykltVA0+HJKf
 Rwa4SkQXkUv7ycPOcw7B7mtx+nOCsmx1NdDSUM75u4K3bWddIO9Sh3DGhYpSKD2qZuPm
 RUuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+Brlp+q0MTS5gnKMeOc4KqUiQsm9WYOamtTmKjJqw7N6xfuBOo4F9+8YWGNLsCxozgkTQj7U0nwFG@nongnu.org
X-Gm-Message-State: AOJu0YxL/OPU3rMuZ3IkIA3im/qmuBGAdBzQq2lV+LgHdCPycmOhBNar
 XGrAjcHVBDsT49+n8QAJDqjQzJdudud4ioiny65dS/kqX2On0kFdQ0uUSTzxkzfDe/4iDHFoqwA
 0qAtWBHoo5ch5hbOjl81HxrdHdqUrmHgOAwCdoY7bEt4SoER5WsY/bp9LgQ==
X-Gm-Gg: Acq92OExdOHOQEMJW673gRybEYaWtRnhuPdwVKWxiVZVqLW3H7ZT+DdeHwBrVEBzXuc
 YE5hCuhouWSN6Dck69va5blL6baxSUcy7gxTmrEA6D9Es6rI3v5EmdW4qYiO5SRbp9lJ+bRXVUe
 uIiyLcKB56YLL263RAcR6vGE0dYa2mjZGAz0lxcqae4BXKjftKI9MI0NrXDfw6yadQMgpelb+ce
 2lU9l8C1trGnXRUGUSQ7zwivCLa2u9fBPEbqybhficYSKHKPkPhAcT9/ecrCjIhcynryZkNzLRD
 sg8O18U53KEyWngX1KKrAZZ0Vo1HB0Y5DNAeylwrMdihHW66/s5DPPvb2QwillSdvW5DZ96IKXR
 i8+yTYlszPta1ojbmOVI4GVJpVD/JahARRpq5jP3rOy5eQ3a/f5Juqoiu+TGUV01QCyqH+K+qvR
 xE3P9tsVaq9UXZ3A==
X-Received: by 2002:a05:7022:781:b0:133:1d3d:f93e with SMTP id
 a92af1059eb24-1365fc7edddmr2102840c88.42.1779493845602; 
 Fri, 22 May 2026 16:50:45 -0700 (PDT)
X-Received: by 2002:a05:7022:781:b0:133:1d3d:f93e with SMTP id
 a92af1059eb24-1365fc7edddmr2102828c88.42.1779493845008; 
 Fri, 22 May 2026 16:50:45 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f20ddbsm2115017eec.11.2026.05.22.16.50.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 16:50:44 -0700 (PDT)
Message-ID: <e71a4372-464a-4491-a60b-b8b8eb668e48@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:50:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/37] bsd-user: Add sigtimedwait, itimer, and futimens
 to os-time.h
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-21-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-21-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzOCBTYWx0ZWRfX522QC7HSLVFl
 bEgus4Lefber8kcf3/OL97yJDwoNtSV6M7jFGzOn1NO5iLnh/RBw+VkTEDjX+8WMF7n3sNhzOYK
 elXYxa1/Ir+mjuidzY6p4rgbC1MiOemkRVRJFggAGlUr+cbPS2n+LkjVw+EAZF6Ez/pNBC76myj
 6ivh4ON7QJnSjjZ0AR8gRvCGY4XsCtV+cjcu22YOWLUPhAYuRK55Kwad+so5BHIFaxUuSf3OAsH
 CYXPWaE0j6y8A/ODsAkqqtoqgGy9m0wqTKzyoK51QwmP5D1x8DyqkSGDMzpZDNW5aQFDpFdd18w
 dx783RRb+e4R0NQhimBq2ev2TUR5hxJjf3gRQAaC6Qd/m2Jhr7Z6QkDXQYnXglZAaH/d86i/3x3
 nMCIw5Mk7fm0kQBywAIIMDL6kqpCUkDgNKqb384ciDUYzIiaB8hjHJEj11dDUGfIDd2tCotir+E
 iqTsdOCV1AScv74Ay8g==
X-Proofpoint-GUID: ApyxgHvyjlxQSthBc6Be6fvgp46jC9ru
X-Proofpoint-ORIG-GUID: ApyxgHvyjlxQSthBc6Be6fvgp46jC9ru
X-Authority-Analysis: v=2.4 cv=F+dnsKhN c=1 sm=1 tr=0 ts=6a10ebd6 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=6I5d2MoRAAAA:8 a=pGLkceISAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8
 a=km-dHngV_AlV9D6AJiEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220238
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

On 5/18/2026 2:27 PM, Warner Losh wrote:
> Complete os-time.h with sigtimedwait, setitimer, getitimer,
> clock_getcpuclockid2, futimens, and utimensat system call shims.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/freebsd/os-time.h | 194 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 184 insertions(+), 10 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

