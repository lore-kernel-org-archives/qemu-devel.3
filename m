Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DEFCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLvA-00044Y-Tc; Tue, 19 May 2026 10:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLvA-00044L-1A
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:59:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLv8-0002AU-5y
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:59:47 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JEx4qM2867828
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uazcnBQ7oMtoNk2hItVR1GsCa16CG+2aTM3hYIxXdcg=; b=D9UkREJGJoommzCl
 UXDs0SYgn1I52HQYv6004YNM8A+9ywbMsNKwhBn5nHIUVmP+BW1dpvnBDD1vObaC
 OySDnfx1iabEb20McqeHjWr3dyMTJD1f7Xc30dMANF5Ib8PfJXwdla6RbkzwHf62
 V/4813flo6y3vqJsj/2zEjvuqRmlZSzQ3ll5lPeS56RPDaatQ1+SaMSgNXgYXQTW
 jkX2TJE4XAHUqfFyF5jJ926TqLz3YysAIfBAZZYh6EopzjQZ0dozU+IzZ4kUp07l
 G7qqz1BfSeMqz2kOoI3C9sVzqsdqv5Hay7xHTW9GWzvZgzRnOUxFyWZs+8P6pSHp
 8cyh7Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3w804x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:59:44 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ef37c3f773so3806342eec.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779202783; x=1779807583; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uazcnBQ7oMtoNk2hItVR1GsCa16CG+2aTM3hYIxXdcg=;
 b=FBw+G00Y/Bmq6bqJRjap345unw15HOPRuLiN20FPekDORcrDP83ufeSjQ/Juk82Y0z
 VM1sGMsMAjZqCTqysyF4JdKAMti3E4m4k5KBAQ7Uj8KhA4AsZ/57XqNjfo7/dGDYL1M7
 2moQbjyAohSl51W351W/qi++PMYILHAbyo9XMCEQcDflSvySuOP46bFebLw64htIheXS
 HSYhTau3F0PXGDEFA8ISxmBsF0yZD+VD5KpNt+RUETVZ2cXU+XoqorCjSabHXfreTOUt
 SNfopIRZBFPmoQUZDnn96KtAT8ni+jfUyG96lL4gldsUOcfv5WXm9S4AGdThbC4MlXst
 Igxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202783; x=1779807583;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uazcnBQ7oMtoNk2hItVR1GsCa16CG+2aTM3hYIxXdcg=;
 b=I05nQzEaN/U0ovIN85dnTZdhnSnWl7AlbskhEEkkeXJAfJAZ3bc97TGGZS6ymOzrNa
 uvMwLwEtA1vKeGfzHMPkKMx5E3QesssaN3JVqtWYqqXIpT+y+FNddf/KtvPF3NbJXEqT
 IL9MBOXFlAwkr+PZq/CRzmpG4npVpwtDSZ139VFBjhOTIR/ngvjwvM+IatT+yDCaXUOi
 OZ/oBdzEfLTfsBNosomRr4cnDgqYasI41jcggT/+fW9aTE+D76Qti4kxjomOPdS130pn
 afh6h9akQk/qR/9ofefBhC2ssr3jbp+c3bxS8KydC97TraKjWbeUQZH8A4c5BLW8GXft
 Uniw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8y5OJhXqqgARB51FCoRnO8wS5nIuRXodVnEY5wl2Vn0FAmIl6CLPen6nlIbL73M37S3OaClf0y7al5@nongnu.org
X-Gm-Message-State: AOJu0Yy7c4f/TRiFdDWhiHIF2o/ov0ojN6M5UFX8PX79XNSYDmthyIyF
 vBQNsmTrR3fLfyVjx/5MGn4DYhQq4YF+3kTO9U7xZ/S/UOkiZixQeqwTqzPZQjRQ27hyFf7xIUI
 tSVpDzsG80joMdgQvcUdD/4/K3jXc3sPwtWE8FhqUolEt7jlih/mmhPcgeg==
X-Gm-Gg: Acq92OESNwdp+D5AWAItx5fPMdWfAwm2+dr0bz3en99XIHA+d6yueXKqGoFFkv97YaW
 MIcSHrpWAyaFz524+fwwclyIfomr8+/Cdm+uH/9ijSGPrQGP/yxPrWvurjim9b7okHtU91iRi8A
 6h2iHiiHl8FuNCq8E6uZ7wqU1E0hmh0IJnoQimSbrqKg6ZlXgyzsg1FCjnmJFj6z90cr5+ZZXJA
 bBvfqqFfWpH0aziYmsq6h7B5MkGy5i8YvnykR+MhLXoKY+vXJBhgnXvp6ReuG730KvjYmSwXorK
 mRsskBuKrjPxYzIbkrF37qg3ZxPMlBgDKmmTKbtq09lQJD+t9CGrTUJvDiS5KlU2DJQR5mA02iC
 //c9wkOLi9Kzo661y93QLnpxFHuVZwcjGcawQNgtUETLBT10f+SES3yM=
X-Received: by 2002:a05:7301:400a:b0:2de:1508:937c with SMTP id
 5a478bee46e88-3039869fcffmr8548768eec.24.1779202783519; 
 Tue, 19 May 2026 07:59:43 -0700 (PDT)
X-Received: by 2002:a05:7301:400a:b0:2de:1508:937c with SMTP id
 5a478bee46e88-3039869fcffmr8548744eec.24.1779202782987; 
 Tue, 19 May 2026 07:59:42 -0700 (PDT)
Received: from [10.36.20.156] ([24.52.49.144])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e3c0sm20973936eec.3.2026.05.19.07.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 07:59:42 -0700 (PDT)
Message-ID: <6873b72b-536b-42d7-8217-33ad9c78532d@oss.qualcomm.com>
Date: Tue, 19 May 2026 09:59:40 -0500
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0OCBTYWx0ZWRfX+O66/ekmcUcO
 YHzQzaKZl9yWaNYaCIY67Gn/6uklSQSTMB4xD3RIGtr2BG7oi31zzZk7p6ivE2X0vnAuIFk8W2s
 fMlL0oHtvN/PpPBFAcxQPnz04SEOFCcPFgnnFS5/n9vNrHhBPbeaWyQ0s1uyaiKLrYrR2Vm0t1S
 1TpwnO+hQfMhvWgSw4k3NzMX1Wh5LsdhBJP1S7uS+O/0Udpb5fbKeAloITv3F6QkyRUFBPlLxWp
 tSyM2OLJ5+tP/YpVRZrg+en9nb5UB/1egbJaDJ9fCH0JxovBXsfvzsOcO86kiAHh/DEz73zlmGX
 bCombSQ8+mCU4Rk7xGTtDX9mK7P8j4jaO7NQaUWzsUY9YW1kqtbAqSlvhlhz4j4ntQAicCL0gAC
 qhsrxMICTCg5X6tHzjWc/RhflxhtUJFGZ0yxk3YmEZo9vTIIyXcAdS0BwHL24c9Sh1gHyU9cxbS
 oAJR39wA4dhAZvHXwQw==
X-Authority-Analysis: v=2.4 cv=Q/viJY2a c=1 sm=1 tr=0 ts=6a0c7ae0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=56Y9rEFZEhgGDzydt2dtyA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=mMo0orje6vIiFnOlkY4A:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-GUID: eBLucvuoIU7mRT4Ndxz_I_OwRh-KL_YS
X-Proofpoint-ORIG-GUID: eBLucvuoIU7mRT4Ndxz_I_OwRh-KL_YS
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

