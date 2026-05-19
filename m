Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762EACD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLvq-0004bn-Ax; Tue, 19 May 2026 11:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLvo-0004Zq-7c
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:00:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLvm-0002W2-Kv
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:00:27 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JExGY61237885
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 15:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8gUg5RiUWrgekGEeSUzh4CuC33s7PeSyGDj28kcNjHk=; b=lDGJBaogCQFhjETS
 0+/syH/mPgWfnV4vr/dpQPgbOm8G8b3tOZZwJBi7WBOHMkLo8h1GPTyKOJCWUhgp
 1DwE9w2zvZUjvtl+aig5lfNCsEny+tv11/b5I4dTGq2odeHWI+NRnjOhzQgK9H+9
 VZY2qMgWzSndyPSsItrsyhx7AnkgGylabJek8fgfyG//Vr1JjgFwF3/UJmuqcfiM
 hD7uO1DQFP/TfInan3PbRWqpyQ4mkrSAZy2n2Qc0w7H1za/KTnFtk0hgqQmAevO3
 mMxJiYNqzbX9Ola8buuZQiW6RsxzVAsHQQisnS97P3sZNojXn4UqgKbzcCwczPSb
 TcKEdA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3sr092-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 15:00:25 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2efc342ef15so4923124eec.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779202824; x=1779807624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8gUg5RiUWrgekGEeSUzh4CuC33s7PeSyGDj28kcNjHk=;
 b=Z4+pva2GQ9GMdsueiuaxxi4wZnpw7nl6bOU9icN0yEn5tDLlUTOq05X9vTLQ/slcYN
 rs28v6osdKirq1EBOPAAJE5R7cKjEI9Av/mDmXtLXF9pDOZ9cEWu9QmPHEbGrSgLchP8
 +KUc1sSA1NHTOt+HJT4FxUotVz+mkAWevzsox92mvTZVUs7oOjmNxqgYTx2tgTIw2lNs
 Rpc4NaQRGg0AktUZeE/UmcV277EP4hnKtacvVjRhGgkhUTVaaAf+g8O561gPp+1hHP/l
 +8JbUWsvPE3uxNcrlWKOByLl/nzETn2oOGoAyia5O3kk372TCIk6dH2EgKuxZskXXnO7
 cKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202824; x=1779807624;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8gUg5RiUWrgekGEeSUzh4CuC33s7PeSyGDj28kcNjHk=;
 b=Eszz12poflhzZ5kSberh1Ib1mclGjGwg+a5kJ6MJR92hLp3JXozkHLuqm9MlR+wYm5
 VBjrTwcM4BL51NgE3DajnKO3oIbjOO8u90MNp38tQyu9Ahw4vGKvUm3kpprXEaDRjw6P
 1iJsogHMkL+VgSS+y07fb8lGbCvP7XiukKFGKFZJO4hVJziVXCAtYutpPsSHThNKiyou
 1SqLuXbclCUuOjnVtxjbj6+UxkzPj0FijL2+EM337LwnAPJgkIzucF2whb02UDWkxYDh
 cw27LaIjYkSZtgE7GG1WEv7l9vjhzBADDZIN1zJWYOrHEMjxtDZdWaDS154TCHpAMlvz
 QaIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xdGOH1ZfRXI0TNVbA4+bx5hXb57cSRgm3/iRSu2AjD+WE7DC/0ZZAWicpsviEK5aXOWPrULx87s8p@nongnu.org
X-Gm-Message-State: AOJu0Yw39onSLvVbkgFNhaJDMOD1g+2fqKfAc0itgmFPxApu7DWZaEV9
 lCvtt/KHpV6OEBdE0DIZt1vnyuSnFIzLYZf4e0ult+Hce+6TzvOCBSJSDxzJZvjcTODEGuRbl6/
 CTUM5Qu3N3FPKGz9Ol6WwWAqgsJJRHz70kEhvfT9zR2dr5PIKJPyg2taTPw==
X-Gm-Gg: Acq92OFXJlr6EM9SVBsDrrPg0xAYwrI+4GJ1Hy/R32orWYC2irO/dulXQ5RySvuony6
 iQ/XSBvwHMmdV4jFWFqfZen0GEmSCg2RdHjgWJSSNYni+RyuAzqnulC7PuuiyOBEAWA+5YmS6sW
 K19FjNDodWLTxpo1w3qCMUgT+ytfTShy5fD8T92RasBdUburJzj8Fhsu6EsBnyFY7zjWg23QO/X
 0aMsvE6MfxPn9SvuIawQWMHZ78nPSjREqKhMYkczQpL9wSIf4LnRfhXlSm0IpWtlu76cOQkQCgZ
 AsCeXeSI2UMXoTYQ9k3zD3wcD/o/R5ymd+Xm+x45vI6MxjTflmymf6p0F0WCcFOdkUgg33dLwKD
 2xBe7JnQIsQVXQczXygYh2FfGaElMM6bDR7dTOKpBwEyxRqtEh/LQG6T/4DImS++Tew==
X-Received: by 2002:a05:7300:dc94:b0:2f9:c83:19f with SMTP id
 5a478bee46e88-303986c63abmr8871358eec.31.1779202824222; 
 Tue, 19 May 2026 08:00:24 -0700 (PDT)
X-Received: by 2002:a05:7300:dc94:b0:2f9:c83:19f with SMTP id
 5a478bee46e88-303986c63abmr8871331eec.31.1779202823487; 
 Tue, 19 May 2026 08:00:23 -0700 (PDT)
Received: from [10.36.20.156] ([24.52.49.144])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcb6adsm18500484eec.15.2026.05.19.08.00.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 08:00:23 -0700 (PDT)
Message-ID: <c331aa94-ffdf-4cc4-b46c-660f381f5437@oss.qualcomm.com>
Date: Tue, 19 May 2026 10:00:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/37] bsd-user: catchup to locking / mapping routines
 in bsd-misc.
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-1-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-1-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pbZ2jRWgbSyWi6i1Rh7tk2Ru53sx62cb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0OCBTYWx0ZWRfX9epiLp1+STMx
 el64tF+d1kMuFg2HKQisICFyClldFUmG08EI/hihsqFyCyVu9FBvzs4+k/ArAJ8ebY7kHPkKElA
 QzVD7lewz04pFPKkHy+dZD5q20AOUigspzmCmZuPcPfX++47F2YN31GB6Sau4c/V9VHK9Gq3lo8
 EcuU5c8ihGRI18du0UVizSEK22MxdYkAQg83B9kx353Y2BW8Gpm/O5OB49aWayEz+03tRV7mVrj
 i5T0QTBPxbz0MiCL0r49tFrqOqG8n5DX3eKoYLk2i8gANVqoKMvQif7k0HC75QveJCQfAd5qSKW
 138uDEzPyzKc6jgTeeDzsQnbIz0eqKi9hrTy9VltVSPtXA4xGUX54aljbkQ2jc8qgbnuWOrFQJu
 ys0ZTHZUh1epC2afY5wFg8Hc9b25dvr8YPnHxWcPF8tsZQZVzYDiCMZ0xJ/CXmFZvkE/0uYfZ9y
 zgnbX54nGL5Hcwyy+Dg==
X-Proofpoint-ORIG-GUID: pbZ2jRWgbSyWi6i1Rh7tk2Ru53sx62cb
X-Authority-Analysis: v=2.4 cv=SNhykuvH c=1 sm=1 tr=0 ts=6a0c7b09 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=56Y9rEFZEhgGDzydt2dtyA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=Ood7t1m4Q6ZUDTV11sEA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190148
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
> These were added to bsd-misc.c in a prior series. The declarations
> logically belong here, but aren't strictly needed with the current
> structure of the code due to include contamination.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/qemu-bsd.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

