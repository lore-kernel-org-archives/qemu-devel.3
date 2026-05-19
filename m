Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52729CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPM0l-0007XU-Hl; Tue, 19 May 2026 11:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPM0k-0007XJ-R7
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:05:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPM0i-0003jR-Qv
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:05:34 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JEx4xX2867829
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 15:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 afiz9trpx0viGsIy30noo7gJqHrpxk5oqp2q272R+Z0=; b=clOwaNwKRvuWTEch
 bgdhw0uvLiQs7J8vWEJZFyQ+P1eHDO9UuCFNP0zYsaCGbfisWnJ1ZR1YhefEcnhf
 yge/6C91OplsLAROIDq6d05DHaUXvM0guF8viGAf5qfdxayOdcSF7RhY/3NTx9p5
 VvlmiT0zY7/gqtqZKdGToMqGopLzdb6JqmI1DrIG0k6Nl90mruNOTbbIbvAjr3BT
 U1HoeSLfF1N4PS3c5Tby/kqeeSwlp3ruQXapqYs8RQvchU0USdcXSLMEt/iAzYju
 rl1FfHhA0rC7+Gwp66EUVXuiCP6Q90e5TBpSRrcA48gOvsvzW8aFqF39OVFO6aab
 gLamsg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3w81f2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 15:05:30 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12dba1e866dso2527680c88.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 08:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779203130; x=1779807930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=afiz9trpx0viGsIy30noo7gJqHrpxk5oqp2q272R+Z0=;
 b=fUzMpiTAcBKCyi41OcOa+cXzknE8OTxB9N/fU/pY0uRVmwSGcqF7rnK8/rAbN0YFSa
 +Sxu+oUr7K+2EFMINrUcO+yfz8c6pzj2u+gHkDaNj8UPTGuwXIjWe9wDIw8IKHNVr5UZ
 osr4oVbjdCaBx4YHCjc2Ilqljl+x0ynirE5+69dOqjtx3ejcGmBVsXoAn/EoI+P+I62O
 eko36NIlOzi8jzak4eTigeHym3FgZRRcqUdtjNqnWmC+AnfSvC+UMYRGGj2SEFq2rYO2
 LZipsguS9QvPHmAO6o2hSjNGSW5OcN+3wDhGiDK/5FZeZO0vACNm2HNs+cuMwyu7LNhH
 tILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779203130; x=1779807930;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=afiz9trpx0viGsIy30noo7gJqHrpxk5oqp2q272R+Z0=;
 b=Tm4bgeWRL6Xv85qjbbK9iY3tFfjbARVhjRMEjA8INCrKiqGPDr6ZP1Xn6L10HUd7+b
 DUNvaMX8ERLxaNc1eaWX+ufF12F+yO4wOJTmUtkRz5RA8bnB/7T4YwTojxLzmOoE5m1n
 mAQq15f+8ScRljuQc+i9zWvbQaRx6HmrUJ69o1V5006H0lBXlJUtgn+zcSeIMTj4nuR8
 0aMsY71BQ/w0Y+Y1xXKEJeJRyf5ep9OJmUVPsrNPoQkRZDiOXLnOmaj1yaHrtg25zEF7
 CGKL6DzXIROJcZNBFXwtN4HjcWMXH8Jz/ootzzPzWfH0AkFyB1cFx2vIKSdo3hy79hrx
 mTwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vBJewGbPRcvESELXZrXjiMCRAX3CUbbOIQ3FnkZVE45iERSyebGCX1IdYzOr6R+M2rc67NJyrkS6p@nongnu.org
X-Gm-Message-State: AOJu0Yw6n9UTv2D0P+4YttE+5U4Yr0Onn3BTm9r2fBOdtkzyGExz0+jF
 i6++Evy+xYodHnC0AXnXIMSHWmKOnxlC2/ED3W/HAc6fLwzYgp9DVYOkra55uQeG0Apuo0BEltM
 p1OpPERvjV8hRHYZQKuX+37uWZpRob52yc8bzUFLjHprCYmIDn9FmqR8AyQ==
X-Gm-Gg: Acq92OFGwuiGXHvnacKqAHoX9AW8NOnG+F+yvD5+hL9EwDRYpAXRk/kaYExi9VRftEt
 PfF7IfcQxQ9bRIkERYjyn1HqIhxYVJvyHiFOpD9u2mtA1zcDwKQ21qn26XoMGKWTW+jOgA7udgs
 tlifg1aTLeDzzedtIMJ4FvlREJpScE44SdD5PDvXkFkJmg4PA8wM77lRm9LU+GKrcpQXd4I+q+H
 aweTQSfHdEczRvNytt7ihbvyBwbOQ2/awfBG/9l44RIf8gWcVx+UebLrohFT1No9yOaaNKYGLqR
 CI26NKhP3twN2Roho4eJ+dWqKcpLLtwle9dxDvkbZaNNmEdIeI10Nx21eebrbIE1iqmTOFVdjDm
 n78+QsZbLoTLqUEFmq8yWvvHtXQS/RqcfDxsHE/M5LKs3BLNZ7IOfqtI=
X-Received: by 2002:a05:7022:43a8:b0:12c:81b:c74b with SMTP id
 a92af1059eb24-134c880b9a3mr9298051c88.1.1779203130159; 
 Tue, 19 May 2026 08:05:30 -0700 (PDT)
X-Received: by 2002:a05:7022:43a8:b0:12c:81b:c74b with SMTP id
 a92af1059eb24-134c880b9a3mr9298036c88.1.1779203129603; 
 Tue, 19 May 2026 08:05:29 -0700 (PDT)
Received: from [10.36.20.156] ([24.52.49.135])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bc9d4sm16056501eec.23.2026.05.19.08.05.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 08:05:29 -0700 (PDT)
Message-ID: <2833f86b-6a86-4459-882c-0a6b71dfd4c8@oss.qualcomm.com>
Date: Tue, 19 May 2026 10:05:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/37] bsd-user: Rename cpu_env to env throughout
 bsd-user
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-2-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-2-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0OCBTYWx0ZWRfX250iMMDobH+3
 WfVln6c5UcVnRDMEwXJlHpnv6HGGetUYdWAmhEYE/W9LynsD63I3JUMnr5JdwBPOlemgWIOKfvc
 bgo+/4JjO0aG565kRtlSsZGkItsLirCz+5qRzppLi5gVjWniyJm9lo9eMSrnxEToh4Y2dO2fEx9
 Nmotv0ti+GInlPNPu5CxhKCrWV+MvDJMUwK9suWDTQPBW63MMCNGn++baKyk47Ek+8fVglGk/EK
 831nbrzVflw4wpuDMUWBgUmD568/+Rozp+UYepUwnU6ObHRdMtWDVtBIj/m8YMVhIf+6z4+uqaR
 HqMqMFRFwu4n+N0iB+oMoaQ1bMtXrHdh/bmpIdCs73Huc4kufTYddU9SIKZCi56yNNHkUqPaot+
 b1RliM1kVAIZ77cU7DVXWweUOj2HttIEtdTA6lL6+712vFNo4EfmF+JtnUtvnFca2XiNSihxaRy
 iAhKdewF5jz4h0f6npA==
X-Authority-Analysis: v=2.4 cv=Q/viJY2a c=1 sm=1 tr=0 ts=6a0c7c3a cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=bunxBM7YXCFQTret8gAQLQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=mMo0orje6vIiFnOlkY4A:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-GUID: R6sVv1naSEEo18u_3SdtND4UHIsriZnf
X-Proofpoint-ORIG-GUID: R6sVv1naSEEo18u_3SdtND4UHIsriZnf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190148
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

On 5/18/2026 4:27 PM, Warner Losh wrote:
> Replace 'void *cpu_env' parameters with 'CPUArchState *env' across all
> bsd-user source files. This improves type safety and aligns with the
> convention used in the rest of the codebase.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/aarch64/target.h     |  2 +-
>  bsd-user/arm/target.h         |  2 +-
>  bsd-user/bsd-file.h           | 28 +++++++++++++--------------
>  bsd-user/bsd-mem.h            |  4 ++--
>  bsd-user/bsd-proc.h           |  6 +++---
>  bsd-user/freebsd/os-proc.c    |  4 ++--
>  bsd-user/freebsd/os-proc.h    | 26 ++++++++++++-------------
>  bsd-user/freebsd/os-sys.c     |  4 ++--
>  bsd-user/freebsd/os-syscall.c | 44 +++++++++++++++++++++----------------------
>  bsd-user/i386/target.h        |  2 +-
>  bsd-user/qemu.h               |  6 +++---
>  bsd-user/riscv/target.h       |  2 +-
>  bsd-user/x86_64/target.h      |  2 +-
>  13 files changed, 66 insertions(+), 66 deletions(-)
> 

...

> diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
> index b1d4446ff1..62052c70b9 100644
> --- a/bsd-user/bsd-proc.h
> +++ b/bsd-user/bsd-proc.h
> @@ -6,8 +6,8 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
> -#ifndef BSD_PROC_H_
> -#define BSD_PROC_H_
> +#ifndef BSD_PROC_H
> +#define BSD_PROC_H
>

Last patch of the series does the opposite change in comment associated
to endif. We should pick one and stick to it consistently.

Regards,
Pierrick

