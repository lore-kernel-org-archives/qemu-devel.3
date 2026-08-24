Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D50C61CE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyShi-0003Ex-2k; Mon, 24 Aug 2026 07:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyShP-0002s2-Gz
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:18:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyShL-0005IO-8P
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:18:41 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O997Im2547757
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kGHByDKQuY3POaihd297d/JJPaqDlUjCYBd0RkGfmA8=; b=Ic28IGpGUOx7Xug5
 2OEyrJ5W6/pCJzYiAYskSGfpecjoQ+YX/WUGJvXUwwr+hIJC+551ADzcKnrBrimt
 I0QLk9o7dyMFPJZMxCvk6n1VI6ykPtlFVyQ16G8Wa25x74gQWZToTJMKQtrfRBTw
 bkViRHtTVCsB+wZuEf2pwcuO2mgtfCtp0DeWn/8Lu4nbZe+8DCemqIyJbfEiO6qT
 tM90pOUWvghHbBAQ01t8lnIo4bUZhvaGvdrD/xHFBKZp5RkZna3S1hUrK7KqZ8x7
 ksndVkpVyOdX1gVI6zm5oQTX+HDFlUoKGGtwkg7+ymuL0TtkGta7o+NnRsB8aLs3
 L4wtqw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88k7jcvx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:18:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0e702df8so44843501cf.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 04:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570307; x=1788175107; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kGHByDKQuY3POaihd297d/JJPaqDlUjCYBd0RkGfmA8=;
 b=kJf1UK6bJDDAstD9h1Eh4CT7EvBAcq8vtm2uj6Uqi0sexUXlI+gmVngPae3Agghf15
 3I5Lya1C5lt8mu+LSeHGjX4By8X0BMkhRWLWlJreztG4ZxLsnHyuf2svjJIpLs2cg8i8
 DTFQAznl11xVDTTOCHSdfbPKBUVP1RyGpcBCFLP5qVSHhioz1qnI8Kz9bVLN707Q9N19
 chhhiAmCNYPTY9tN5WckDysYXIfHjLj2rP8xJ+HzUeJFy2jLZGMERsZ80wZu+ZWlUohS
 3u3y5c9RuzZmsARvKRmA5+BloyRUmGqExEPwDEbOwJHwHoN5RhvHnEBPZxbaDQpjC1/3
 7kRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570307; x=1788175107;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kGHByDKQuY3POaihd297d/JJPaqDlUjCYBd0RkGfmA8=;
 b=IV9H2t2wIeD0AMSQWeoEVRRLj3qMEcRG99BD4RfF1WwKC/RzIw1d5WPnkIT1e+k4p9
 eGHVmRiXuUta9VW9WXEzUsP+9C3UDsoEivMYPzqB28zkOnBvouKs3HELGNuP0vxmNSlO
 8DBkRSZjOUqfzmERwDjzEr286T9eRwLJAxOBaS1LBMKvbCkm9P/jTFDegrCNIb1lTSUI
 QbJ9x07wcFm+2qBd/KXxsvIATmIUO9tYsUZZOprECndcf+W5l026vhP2++0vcXVZDYIK
 3LSfnFcW8YhRrN1JsqD45+9Uy5f+I5kHTwG14H9fOTVnSQlljAJmid6b56n4bmX9Tvhp
 JrTg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGY7bwLui4N+HrjC1y2ZxumLzy8ZS/dw22sv04O1M4F7xQ3CzhnvsknHLl7S1l1KJevCECY9Cevmb0@nongnu.org
X-Gm-Message-State: AFuF++luFcLCwD9yTFvvFKgCVd+HsIQnKnJArD4VMg9zph59NfF7iYba
 1RRM4xA5KeKEWBg84B5SgT0n0nZPnQwinGbh6tRT66Ak5NHx2hxOh5hEQFaPdZfItS9+aZRwMYL
 mNM+eeKt+JfALKXZNsw6zexl9flEN3InURHOqN4YRw/bF811/LkhHc1VLUw==
X-Gm-Gg: AR+sD12HEtR32DVZG61MeafawoO9VV5rKbRjSvacaW2DwSiBxzjoySSWL8Vool77Mf2
 DW8o+k7p/g7juqJzZAfE2zdYST2ofBJvKuE3Pgv3cN8/sH32pV9BbENTMj4dZlwEeQSqtVWpU0m
 50j7P/9mOrlDkT3Hx7bDiF9DEGhBEq6idzLwyZSZA9ddCcaAZj3Gdril8wtMsFkAUMORwyAqI+V
 S0YEQr9Mw/VGXvHBF25kP20rY4ppYn5ST9uXb/qkC9lCP1/P9le9iv/8gAJBnkMJGZKlLEoKWyN
 EHINiu2SKIrq8THiFLpXdL5zeHQcXJueC/Re0kAljEoQEzlyF1wIon/ynvildvAr3KpTnnwuHtr
 d6YWQGgjJrdqTNp9LHu+AW+ahhKQQOph9HhyoYo0lug==
X-Received: by 2002:a05:622a:859c:b0:52e:1e8:220c with SMTP id
 d75a77b69052e-52e01e82465mr180687781cf.24.1787570306663; 
 Mon, 24 Aug 2026 04:18:26 -0700 (PDT)
X-Received: by 2002:a05:622a:859c:b0:52e:1e8:220c with SMTP id
 d75a77b69052e-52e01e82465mr180687401cf.24.1787570306217; 
 Mon, 24 Aug 2026 04:18:26 -0700 (PDT)
Received: from [10.254.188.74] (44.170.88.92.rev.sfr.net. [92.88.170.44])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f64f6sm1287481666b.40.2026.08.24.04.18.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 04:18:25 -0700 (PDT)
Message-ID: <d2610851-5222-4bc0-92f6-f88601ee3589@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 13:18:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/isapc.c: reject modern x86 CPU models
Content-Language: en-US
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com, qemu-devel@nongnu.org
References: <20260824111054.575149-1-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260824111054.575149-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=b4iCJNGx c=1 sm=1 tr=0 ts=6a8c2883 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=s1NLoHz9uzatdv2VNqxUSg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=catcoup4RJIRKdDdaWIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX3mtvLFviI6mp
 XCPNWx5iOm2Up2qQcsZyt6o/nVhPkfVzXHvwdmqilyKO6c4QU2h6aYuZites0P57N38luA+G9MW
 EFokV0aMnMvr3BYdJpZ6NMZxw02DlF8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX0Yfqu2fOcyWv
 P5ClmV4viAbZe8zLkqovdYyGBbmKThNzu7rtJpZ7+HDykDjY0cbWSceDhq33ScYBr9VsYQHuEm0
 02X6itDDO0Ib43f5hdgrmH+CSDcUwoooN/jUnDCOxfn89wqSgIqfYVg6S0GIOBzO5SpwyuZlunZ
 MwifnIv5qZwpWsE2u8XPZvof+5kGH+PlTB1PnWTZn/IhPO/pthzKiZd+DpZQxx1ENrjOaeC30Us
 UVk4+okrASgYdZheKyqkFHQ0kRpOCUCiyJmcQm0SlnyhvV+onxyeHUOfOKLNfZ2Wge0wIhbialR
 n9RRDZ1fRHDRwP22mbgOjUrXgu9tsJnoOPTOL3NYVAQwsaWsPj2U/XeFIIcOdmz4XyfOxMKYhPX
 pGcJVncu5R3f5+L+HzBEHzss0OH4/xsYuHopqypi96NTae8bFX6aTCQ1uqLYhm0OY1Mm/M4y4Kf
 T4eK5k3wCLN31gYabsw==
X-Proofpoint-ORIG-GUID: PRQcpr0QgyKQ6w9MBmmVANu734sX-Rkv
X-Proofpoint-GUID: PRQcpr0QgyKQ6w9MBmmVANu734sX-Rkv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240094
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 24/8/26 13:10, Mark Cave-Ayland wrote:
> It was originally intended as part of the work to split out the isapc machine
> from the pc machine to restrict the isapc machine to using only 32-bit CPUs.
> Before the 10.2 release it was decided in commit 329e36af94 ("hw/i386/isapc.c:
> warn rather than reject modern x86 CPU models") to follow the official
> deprecation process due to concerns this would have an adverse effect on users.
> 
> Now that the deprecation period has expired and there have been no reported
> problems, update the isapc machine to reject modern x86 CPUs by reverting
> commit 329e36af94 ("hw/i386/isapc.c: warn rather than reject modern x86 CPU
> models").
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/isapc.c | 53 +++++++++++++++++++++++++++++--------------------
>   1 file changed, 32 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

