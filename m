Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6F2606A33C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=APLG4Kcl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IPZmSlK6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP3UN-0007J7-6G; Thu, 05 Nov 2026 14:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xP3U4-0007FM-UD
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:50:55 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xP3U3-0002CK-2e
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:50:52 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeKKT1485061
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 19:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pBQfbvEdhu+LR/+Ddvyb9Bc2QIGXITXiztssGg71sss=; b=APLG4Kclz2+i5l3l
 o6G3y7TMwR4NWFG0fY29l+mFjuL7BzfGxXomtNTrE3aeItxomdr80/RrowhRM27K
 +85RLa+/7InhwEkUoE8BtnoCVnPOfKcd2TZg62R4x5m5otrNTqrZ2tBs/nMmBIzC
 cjJCWGqtn4ovppblOUMiW7sWZ6AE2ZqDqGKk+WNNt9vA6DG+ypum+7UMB0oYx7Om
 I9Ex+ryylTwd2UNxw1MUHd085PCyEjZU05npuspEUa2lWKV72q3iet+kfiHKJXmN
 jeOv6VZ/gO3gald7lkIpWy9fvT/G+QC0SWRhkvBciY0C3ZxxMPSFdHmU87uRZQl3
 4R832w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrpaak0rk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 19:50:49 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so4265878eec.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793908248; x=1794513048; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pBQfbvEdhu+LR/+Ddvyb9Bc2QIGXITXiztssGg71sss=;
 b=IPZmSlK66JK0yhF8D6RE3Gu9kOFTlCXNNCXsQ/BtPpwPjNXGn4jQ8wNxsUBLeu89it
 2GcD4jNCVdgJQ+2jC4hbKAMUMZ0gkZLHmHXZ9rfcTqpVXk7dqJ216VOr8wEaDgoEWSuB
 w8kp7idi/PX1WmLuu1x49H+vQICdul2OsiiYB2xBzxmMbSofHha9klQWIZY238PplzAv
 WHPJTuqz+JFVQnkxhwFYxdcFIJ/EHSs8KtaS+A2UtSVos/ew8fFOpYPiqOdnIo4Ft70c
 s1fo73FZN04GC3FX80gsQEyZZ0a0+CeYjwj+adTEkbe81jETs2Im9kCzCQ8rVivGeUp9
 NDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793908248; x=1794513048;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pBQfbvEdhu+LR/+Ddvyb9Bc2QIGXITXiztssGg71sss=;
 b=uselFalzgry48CNlKLNfIpKzZW/+SMUB4UBl3ET/yrXpgbVEFxCJfzbgRtRod7echj
 ulhElByVNfWNPfU7gnZqf7fUr323kPVj6moLuzpTg8IsC+d2EHX1eh+md/A0ASpk3J/l
 d+2T1IChIEZ1YumLY/HwYgjhjzHRO0GgYIar+ETznoG8OlASmE18YghmYx0Oen/MN+Na
 x4olPu7CrGHhw+i7b7h9ey23LyMS6Wt/eid6+/r4lXPW2MWORJiKXd2pRBSBC3jK4f44
 gDy0GySR3CEWdW2o9K5L3h7UUv6JfgIjYzhRc55ZKDzQmhpVZZOhEgEg6y65OoCWYvyH
 0l6w==
X-Gm-Message-State: APuU4Z+uQ+kKOPOAZARcZmb6ly3Xoa5hRsUHp3b4toyHfl6fCmoma0GG
 TYAM7h5qbo0/5mROmpqV85V2DS9cbf6f+BBOqX/c0a2s2zrPe83loQ74+ea48Oelp1y6a4uP4Q7
 iMrbP/Mdtln+r1ZOO8e9V3ubC4wCL0iIhcsOsa/cP8Sek45U4Kqeb16qfEA==
X-Gm-Gg: AYBFou0+AYIyKC5u/Vx578WMI68m5PYPFf0jqce2KPHtJGLeZ3l2e1PgcOtMUrhXMrb
 jEhn1+wk6XkXlQguOcy0E/jo5lx0G17uEYp3U8C8XwVqBhWqrZ3lPM2s9wwGEaV2VDT11wK124t
 QcEqfbIu9NTUyd2eFw4v49YVl71LSF099akR2zvx/jFJFFlErRwiMxt8rARqod2EzE/ZeAbV4rh
 8dLmasqaPtku5mfYtzg9BwaIn7BXdtAvyWwBziLx8IoQjL4+dDnLg5v1rRhFU+4J8SYFFzC63gW
 d7XzJmDUw526DQjkYzgGFvhACHisDDvZNOMzzMDwzJdiqkhfV7DRxOPDBwUs/ZyFOHSuP8hZgai
 pUyPSMmDAQ9oIXSb3u3Bd05fcFz2Of1fFn/uShxpcwRsfajsk2j+LiD1381AVNnUMxB14RHiavz
 CqO/mg0K6WpYMzfheHkjXnY1gBxyFCb9VVTb/Igh8zdA==
X-Received: by 2002:a05:7300:dd49:b0:36e:aa5c:7851 with SMTP id
 5a478bee46e88-36f7651e63fmr185328eec.27.1793908248016; 
 Thu, 05 Nov 2026 11:50:48 -0800 (PST)
X-Received: by 2002:a05:7300:dd49:b0:36e:aa5c:7851 with SMTP id
 5a478bee46e88-36f7651e63fmr185296eec.27.1793908247304; 
 Thu, 05 Nov 2026 11:50:47 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f736a1da4sm332142eec.7.2026.11.05.11.50.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 11:50:46 -0800 (PST)
Message-ID: <5de7e4a0-70dc-4a0a-936d-d66b1eefcc09@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 11:50:45 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/10] i386, AGENTS.md, meson changes for QEMU 11.2 soft
 freeze
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20261103133500.2295582-1-pbonzini@redhat.com>
 <CAFEAcA_=L36WixkY-KMXOhwRZ26_pEFXmicVOYMueKH=WYv7uw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA_=L36WixkY-KMXOhwRZ26_pEFXmicVOYMueKH=WYv7uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3OSBTYWx0ZWRfX8p8GyqKeU4PA
 aEBsaNKKOiFwBIMVKdDxgoLMk5BqhB1ef6LWrZouGMtGrqCK0nTvIBSwgrBxHoHBOuCIekpJNjO
 3AODxL0cz17y7QFvrwXAUaW7ouhQUlO7LtNr6M2pVCAEXYf0kyxaiILAcd4Tj06bxyn2z9TN3GN
 GuFVaUK4tpyk31/fthS4t5YRQ+y+L9Fazi29OauRqBQPaL5xFe0twE6xwd44i6w3HJagW4NzFaB
 zkPmsyytL9x6xb5Nbvb32Pe6aTpVcpzzXrQ6w5js7USixIVINb1j9+mUBVUl7Vn8R/N2AUo6HZb
 +IHrbIuILudlcyxNLi6ai/LmI6ATYwQJXkKYfTgch++2EviqkSeQDxSd+08Kve9CdW6gmz1Dh6U
 vg3E4AljHvzeT6aPXyVlHaKwaAy+3KWsVs7xl49TEI6ZjHxsJY6F5Zy/yLlvepbn+znrc6fQfC6
 sjq/Twk9LwU8S2SkgRA==
X-Proofpoint-GUID: ZaJ-QY9gRQEyuqH62Zhlqnf51BswMf-s
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3OSBTYWx0ZWRfX+xvxZk0KRerr
 dSpHOgMtRsWoSN7VpPPHN2TsAciWrKJN9X+D/QHEflTsJ9WmM+hU+xIv2YyeuU0cyO+qENQf8OB
 22P3J6q7MIX5iCaxzYh4gLi6SaNEM/c=
X-Proofpoint-ORIG-GUID: ZaJ-QY9gRQEyuqH62Zhlqnf51BswMf-s
X-Authority-Analysis: v=2.4 cv=WOXqzXsR c=1 sm=1 tr=0 ts=6aecde19 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=mqAZ-kGaMtYP5kKsifEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050079
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/2026 2:27 AM, Peter Maydell wrote:
> On Tue, 3 Nov 2026 at 13:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit 74f7bf4c59e6b6d50dbc6e124d93440be8be4386:
>>
>>   Merge tag 'pull-target-arm-20261102-1' of https://gitlab.com/pm215/qemu into staging (2026-11-02 20:19:27 -0800)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to ab78ac76f44a1241e76fd32d248df62d83f1ea58:
>>
>>   meson: rewrite scripts/qemu-version.sh directly in meson.build (2026-11-03 14:31:24 +0100)
>>
>> ----------------------------------------------------------------
>> * target/i386/tcg: bugfixes and cleanups
>> * AGENTS.md: add final instructions
>> * meson: rewrite scripts/qemu-version.sh directly in meson.build
>>
>> ----------------------------------------------------------------
> 
> The qemu-version.h changes here seem to have broken incremental builds:
> 
> In file included from ../../monitor/qmp-cmds-control.c:28:
> /home/pm215/qemu/include/qemu/version.h:11:10: fatal error:
> qemu-version.h: No such file or directory
>    11 | #include "qemu-version.h"
>       |          ^~~~~~~~~~~~~~~~
> compilation terminated.
> 
> This happens even though the incremental rebuild decided it had
> to re-run configure.
> 
> Blowing away the build tree and doing a complete rebuild avoids the
> error, but it would be nice for incremental builds to work.
>

It works fine on my side, with both ninja and make. qemu-version.h is
correctly regenerated as the first target being executed.

Can you reproduce this with a clean build folder?

> thanks
> -- PMM
> 


