Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DD1C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrhHB-0005Sp-8B; Wed, 05 Aug 2026 15:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wrhH8-0005SN-QE
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 15:27:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wrhH5-0007dI-L3
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 15:27:38 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675HRrrF2912609
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 19:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 czcSGqEsMcF3wX4AX8yAFTUe3YCQHa3TowSE7Q0Z/po=; b=ero6OlmiqAYO+D2P
 /uYcP/W5M8DqkGoKxA3Rwb0szJ+zivOpAFLgwA+LTWHpdxyNQHdVdTuGjI44RaZD
 OW0mZj5aIqxbMCunVoH9XmIN9TD7B2Q8y88+bmbl1wifIU46POpPgW6NyNLzTj3Y
 xz0faKl7sXmtPqZ8B3xCGtUcQexhNdqOBxbJBlRkUhAnafOSWn9UI/ovkNknnveA
 jIqgTzvQBUPyvAvjJfDdvWh5LjTG88Mtahygejl6rRp4pSOPyryP6c2RwNqqryJp
 vHRZn/RqKoiu02qcViJ2330VjQ6RsnAO8PAaQprvrp5yCkut+xLLzriIyZDSnkeb
 40Rn2Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv9f58hef-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 19:27:33 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c96b4f58ddcso1138093a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 12:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785958053; x=1786562853; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=czcSGqEsMcF3wX4AX8yAFTUe3YCQHa3TowSE7Q0Z/po=;
 b=gOt+7J4fMjuR/qnXV6683iUdeOQMEK8wswtuT6HJIKWVj2GLUh5RQqsERuQTLboI+C
 +9ocDM7WRPYPVL+TLNrdmqnyHak9ZzzmVjHLlpZH7i0LuQKIkfr5WFb8zYIVHVBYnOKu
 +DfwEDpuhbXQ9pNo3EXoIYkglLzW90lYvgCD2nB660AizNL97KlM+wBChNTrdxlyj2vv
 XoulzEMf3JREqA4aqRgoUmK7J/176raQgdPdDNyuDA2hYkZ76HlF+upHZzZ6emKcW8+u
 OQWMzbcTK9tW09+mu1FXzsMQGNidmQlldhg7mRAH4RQ3H57xvdt+n8gekt7O1E6MuODi
 aL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785958053; x=1786562853;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=czcSGqEsMcF3wX4AX8yAFTUe3YCQHa3TowSE7Q0Z/po=;
 b=dOY3vo9X9HpFvuf68vqHK/xP2nV+Flsdb42dQuRg4k3ie/E6hk0IlGql22HvCfflUs
 B91sjomeOyoXwx171aKijdfqLVzV+cEhP5/L+1xSDCAByxxO/T9O8ktDPATlkbvMksNa
 A5QeCCpziF2EI8DUBCPSdUIP+Rrq1wWfz0Uh8Ri3ZGfzDVYOMo3/P2cnwRr/Y2zwORHw
 +mGhFGZYFXyzD5kHYNiksu/wWQD38m2+y5rinZRDas+hLsMeoHiWIPyPEYzFGC7cFCYV
 B6r7O11qUah/GcAgj92D+KnRqPkzrxB1aUs1QEspSLzAGpGZfNqfO+LIMSyQYGDaJngI
 D5Ug==
X-Forwarded-Encrypted: i=1;
 AHgh+RooWFjPOMpHjImxopEmOf0YkLn/2IDItTX1FVK1ydm/SpSr40dZKCG79n2sWMGtKlfBApkarUM0SEBI@nongnu.org
X-Gm-Message-State: AOJu0YwGOB2RjRJfBaiJzcMdAHss73erkLRKdS745XVuS+BGVpTklBsn
 0iPjTv8sIwm7xlXQsheJN+EBAATuTpWtPVUnSm+UnuvJkHsBHwl3YTuZ6v0z/32wWKXYIYpUv9J
 YStQkRu0yV78AXzm+iqaNtl6xUpobFG3qYRdYbck2Zd+0DFe7rnEgM5CvC6M/1dykhg==
X-Gm-Gg: AR+sD13QszMZNIDTO/CSjsR7MmsOfw6sLJvTNyrkkLc+cgmwwqmfvmr2SgpMYpgsa9A
 lHNBUbch7o3R8MnOuTiDtRY8bJ37ZG8H7Gbx89L6uJ+CaIjwsT752VhI2iz95Hzje1H5cs5skW5
 IFdPWFLmDOHobyAPxulqeBhU3B1nOmZHiPh0rP3/JrUi64h+auNOvpuWIJU8Z3Km6o1GmD8rjGb
 s6NGO/RWYC007CAMhqdZpuqGuNuTaYIQxEW1qgIjNyrl9V9rjoE9RMB0+WM6Ml2FfeAGBpt9Qsw
 JKASQ6hYgpl10a8gBrZQjxpxYU8RjRbLKZF50hl6q0cyXdRQ0NNez7pxYBZKQW46jGvBFZ32Nsq
 7zOVhyTBvXKioACHbVmfl/XtdfYgdxJjBK/oe1RMFbJimiLawL1wY91NBDYcWmSMEaMTO
X-Received: by 2002:a05:6a21:1b85:b0:3c8:d3a4:7b40 with SMTP id
 adf61e73a8af0-3cb85ded978mr11938869637.2.1785958052652; 
 Wed, 05 Aug 2026 12:27:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:1b85:b0:3c8:d3a4:7b40 with SMTP id
 adf61e73a8af0-3cb85ded978mr11938828637.2.1785958052243; 
 Wed, 05 Aug 2026 12:27:32 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b761asm28320997eec.1.2026.08.05.12.27.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 12:27:31 -0700 (PDT)
Message-ID: <db5b4848-577f-4a3e-b9dd-31d890825a34@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 12:27:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] tests/tcg/hexagon: add HVX test for V6_vsubwsat
 saturation
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org
References: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
 <20260805165225.3117924-7-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260805165225.3117924-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _T256nai-ktS4JrNgWq0P_fEcLaROR09
X-Proofpoint-ORIG-GUID: _T256nai-ktS4JrNgWq0P_fEcLaROR09
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE1OSBTYWx0ZWRfXzIF98k+4iwar
 LCrNlOk7YdGcpcF6OYojNlBjrgwSRqaWQUYXg94hxERQL2XcAZfy1x55jDd9u3lB8UzM2HTx21U
 da4JHJKGTiUCpLXUXbnwVZMAB9omHps=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE1OSBTYWx0ZWRfX1Ik12tfLa3pH
 bE62/4S/5RWWcF8abFQFXCS9W3WpJxY4WO9hswIFhFUHpmNi3EhUlzitA79tibpyl6O3WLPXDay
 Va/3ozVrG3pIvX6w7CpjsvG5vbpe759Nd68UFjkt1eHafUxjhWywbkONSFzmBCSBuwcWUjqJQBZ
 HFepa5+6YPua0IB9LjhywtosLloSwI5bsQOdkddUDgROElCYw5Hu3LBWlYV+r50Bi7AvDQqXiTs
 rR8C3TnC5cCkuUBVcCsyblk0ByPA3B49IV4BY59MRNyWY6y7OGQ4G3cn+De9/xJICgrH3FPMjiE
 2uKDbR5oOEg+1f6tqpO82wgYm6ZDg5F2lHQ6YPdVFuvkLBQEM8CIKo6DYhXx/iY4UOgdOjAxFHQ
 Wbg0x4UdrGH5KQaN4yTWRh6/b8wU6Pc25VgDx55OOi9bm9VaHgBpVUgU2ZrPHTBOgwa8gj15JNA
 Wj4wIAnjuXIIpvXM/IQ==
X-Authority-Analysis: v=2.4 cv=d4bFDxjE c=1 sm=1 tr=0 ts=6a738ea5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ClwQ_02E_FScROrZTKcA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050159
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

On 8/5/2026 9:52 AM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/hvx_misc.c | 44 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

