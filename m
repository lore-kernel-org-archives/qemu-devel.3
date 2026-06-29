Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35890C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weEKn-0000kP-Rp; Mon, 29 Jun 2026 11:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1weEKg-0000iy-EG
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:55:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1weEKe-0001SF-LH
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:55:38 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASw2j2641481
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 15:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J2YcPv3LwsbecURuwRCLmCgBWHJEPX8jTtAhha31BJs=; b=mw+qrK8J+erB5pg6
 FnmOUtNC65lupFcWYjirURnfUknBNlDp9Y39EmZt3da7TYDVu1IgUk4aJzqgINxn
 1fZ6qbMdidfyFIRGQlYkwSfv/MTFyzs1uUwXqSFfMsk2hrm5k5qQOQm2OUxa+RHC
 9m/sbvcJAfsrPV7+6HrAI+E04MavCvXwsn4GM9rf9yWkpWGn17IxfR8laAdxSSuP
 aKNu1oiGE7VOztT515D0FAumLKz/DIXQr7YW7xp/KC3vT2Ro7yRJiiyW2PV27VLa
 Kh9zERv/OiLa6D2pUE2aTy3mv1z215luqsjVhiWFxAeuFZTqigT5cwDyudGofbfX
 vTzYnQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3npesqnj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 15:55:34 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139f02b1fbeso9852543c88.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 08:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782748534; x=1783353334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J2YcPv3LwsbecURuwRCLmCgBWHJEPX8jTtAhha31BJs=;
 b=MoWXrWVRBZksGxI841J+xJcQCt2sCQ6LwdqlZqMMB0zE7xXt8eYfyOJzdUBbPTxGOd
 0VDG69AJiYFQ45VcxkCUlRYvDyeGMos+71TuUT6Kb6z5Lf2qlRH/giOoMzvrGE11tmzu
 D3/6Mw6Zmi0ZZRuwLaY1Mevu0hNF6hbresXpMglphzPoO/Ke1Woarmupfz2E/KzuCI67
 0XqV9nth4UMvkJFCurWTE/zPv8U6rlw79NAi0AWvHkvKiG2mY4ouHNwI+NK/wAz18Kpa
 LvK0Gp4vebdzxqWQkbmg77VNlbbKhroXuKt1VQ+yjIQLrVUNdAUTF5UeqccWNfh+MLOF
 4IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782748534; x=1783353334;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J2YcPv3LwsbecURuwRCLmCgBWHJEPX8jTtAhha31BJs=;
 b=n1bxguJ63l74AOg1eHAIUhQDjn7D6mR/EPBxVMCBPJHqOZCpfYi0uSbQRABxPKzFSl
 jKBFFoc/pkqYSEFy8inQ5+7Q5QWRs/zXXNie4M13l95337uwb2l3YH5Wgo/RqSXlEsMP
 Rx5+GUlRowAJ//RGjFCQTtOQ4RdPcpbWuPiZXQcmifHrtB4ilFgTQohCBEs7iewF8o9H
 2h5P2ESggzO7DugsCbFXAu4sj5UDSWNnfEeM5IAwXGnaDJVnL/OxCGWoexxVHHuLpc/p
 Kef9D/Xy+Zsy87ApXLc5tx4t8C1ysZKjl1dwonTZmM31IHz5o/l2P9Hlm0omYNNb7Lbw
 fMXQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mVQo7n07A1ZicU6+/6TqfR5yT8nE5aBkyFuG5PwLXTrwCOu7NoaGCF2TiI47uXot+mrJX4Wgtr1K6@nongnu.org
X-Gm-Message-State: AOJu0Yw+2b9Nq6agIBE9Az5Lw6qZXvxY7nVHwRouk4XBtk+dnv9WD0yd
 aJNIxUgVadgxemVUo5RED6oe2ONzs2m7p4YoB2XM5tem/2sTwZBXYFfr+YW9RhcS5A95H6iEehn
 xH1/FegacqQtUMKmuhB0l9TXoQVuNHIwlluDdutgeWUhSGkFxdo9xLBusrA==
X-Gm-Gg: AfdE7cma6A+lq49Mse1JyBgQ03QYHyiEwHC9srCk5ilGinvV9Ejjr9vvshTwrL/AdvR
 Y1tUX+y4pXnhki4p3LA6kcrjjMf6Jom5h9b1lrajL/QqhKuVHwaJ9DTcOw+1l2hILQOUc/pfNde
 AqPO/L+EYGm4iJs4QZ37pdd7o4CW5mbeyEZ7+0vwjk7J3/FoQmyTKuv6To6x7W4fcvLT7atoW2K
 mp3pj9EA7pRH9rcgdg7h4PRIbEyOI/OZHri+Mt3Zw/oSjnkoIrIMl1x0JpGE2u1XvGcH/RFHvR7
 Bnn3i/u4JNlpYSjIAgxHu1Iyu4fcLlu2hQgCpjm3sCuuReSX6C9Zya+lHasVyg8k6czOaaG6gbS
 YziXtp9NUAnAONwcv9DHz//7sNffFxFjdEvK9TWcwxJYxhiNAgBzrm3rAUV3Tl1j7NMfEeQuUnv
 HPwSw=
X-Received: by 2002:a05:7022:6894:b0:139:c4e3:947a with SMTP id
 a92af1059eb24-13b2a176442mr20235c88.15.1782748533793; 
 Mon, 29 Jun 2026 08:55:33 -0700 (PDT)
X-Received: by 2002:a05:7022:6894:b0:139:c4e3:947a with SMTP id
 a92af1059eb24-13b2a176442mr20216c88.15.1782748533233; 
 Mon, 29 Jun 2026 08:55:33 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f318f3sm50094298c88.2.2026.06.29.08.55.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 08:55:32 -0700 (PDT)
Message-ID: <a6374310-0681-4660-8e87-1b10310b1126@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 08:55:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: announce: new official git repo for risu
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA9C3tLDOCSMJVP7UoCRkH=BkVkA1HaziS_am6ZNpE2gbg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA9C3tLDOCSMJVP7UoCRkH=BkVkA1HaziS_am6ZNpE2gbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEzMiBTYWx0ZWRfX2npiH6cDEa/A
 MHDfnjG/5nRai+5AoU4wfhPDru54lsP52G5+hy1wu7TWLXa/adb7EiFy60DkvnwBhMSy3wDld/u
 +hGWZxvJEEpRNtZTvOq81gsqr2sFUIETJz0opdaqcqw9ote/bdryGFVDAfKn4p/mpqBcVwdgtED
 TiViVBlinksUxbJDGu7GonQtru4m7ucxvbaBWm0xXmVJmYXvyUtmBBjEAY6bqKLW/Idm6fk0SkG
 IjPN/c+majkXN47wYglk3m+ODixhqBWbsO9IXkPhCmb0fS7UPU9dha8lDOp3gWkKplFKMkPYXhE
 DUGQCCAE79Y0TYwRT2Y7FjcXD5uGZcqk0GcWM8orQjqBQURS0JYd2kg6kALwcDfJ56dzlBBcBYO
 2St5MmIFoB4WBTg7ccdoiPpH442bQryE2XOq8Wo/BtZVfAR9lzKt19Y9ZRguSffhXJUgQI0gtiY
 6b/rCrC8rxE+afqaEcg==
X-Proofpoint-ORIG-GUID: c2NJDw4SBZfMS-N30Ed1di9XYj7-qV7M
X-Authority-Analysis: v=2.4 cv=T6q8ifKQ c=1 sm=1 tr=0 ts=6a429576 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=SzlNI-oRMvhN3JfLb-AA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEzMiBTYWx0ZWRfX/rOHe2lrrQ9U
 B/gt+U00uYkj0xwXPbj0De9A/2n8VgPCIX9AVGVxabo2u9k+geIdjfKio2YeZOPTMoQ7s8dTatY
 BbgDBn0GdJm0vCa6fnMSHXDGOYfhSMg=
X-Proofpoint-GUID: c2NJDw4SBZfMS-N30Ed1di9XYj7-qV7M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290132
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

Hi Peter,

On 6/29/2026 4:53 AM, Peter Maydell wrote:
> (Since there's no specific forum for the 'risu' random instruction
> set testing tool and we do risu patch review on qemu-devel, this
> seems like the best place to send an email about this.)
> 
> The 'risu' tool has a new official upstream git repo at:
>    https://gitlab.com/pm215/risu
> This replaces the old and no-longer-working
>    https://git.linaro.org/people/peter.maydell/risu.git
> 
> This actually happened at the tail end of last year, but I never got
> round to saying anything about it, since risu only gets a very small
> volume of contributions. At least putting out an email should result
> in the info about the move getting into web searches and the like.
> 
> thanks
> -- PMM
> 

Would that be interesting for the project to host it directly under
qemu-project namespace instead of your personal one?

Regards,
Pierrick

