Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0819C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpr2S-0006FG-GD; Fri, 31 Jul 2026 13:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wpr2K-0006DE-RE
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:28:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wpr2J-0004vO-BB
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:28:44 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VFOOKE205618
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lr09Jw2mAS1ea6g6qYUIMBR8osCFRVzoh3VElJ1/tqM=; b=Iq9rnGT4Wr/4/3HE
 blEUzPFtBrN4KFkgGFr0kRYLN3Q7fvHyAiuJ+0333W97wPF93Xc6p6Jye0IZemuy
 dHKnaA6Lg70UQ/pf26MGmp8T4GB6WjGLxDu78dte+UEx6t4ZC+PJS4RdIDKSmpmw
 d9wUK6XKYP85XZ+WM3DMd8NJ8A3xDi62dH3WjAmVVZn+08mNXt54I4HtHVgtRWMG
 NYOu5EaYQ6KWGV1tlPLDXrTSSB7XSnEwdttY32+lPEcLzaWHEUhDX4l5ipyRWmrk
 GIrgzFovX4R5mj9QvF8nGSU68JBtW/lOBNKHEtZdfCWyZj63aJPiLhKxVKLPJCnX
 7CXv9w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru5dhmh1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:28:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ce7fabf76so2065437a91.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785518921; x=1786123721; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lr09Jw2mAS1ea6g6qYUIMBR8osCFRVzoh3VElJ1/tqM=;
 b=NwVjlegwwhyQT0lhpChB+KdjO5i59HPzY/Thz5oXt4QgDqZziYgiI6oKg3RdU8KGXa
 d+gQRNr5/fNKmhqQ3o7nuZIE9vbHUCRWBNsFECIr3h/rQtl5KsrWOval8Vxt3BRedG3q
 ZcD2jKZzQxdgRp4PMupubjmiN6XVx3w1vwTDlFZAvAJfH20qJmMWYwyCITEnmWSbUSHu
 l3dgD5PC4EWZ8kMpQZCOS1E2n9o49EBLHM9VSK94VrsqUmSWcvn0l6RPz4d6YN7j1IjR
 mao5LgN96eL6nDDYaPFRLGz3lMUD9Ca1T+0kIbbL+pvPupzE1Sjyv4CULrpvzKF5oykh
 NCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785518921; x=1786123721;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lr09Jw2mAS1ea6g6qYUIMBR8osCFRVzoh3VElJ1/tqM=;
 b=eUxMHyXizqThi8dIuB9W6Ohpb7qFNEQQpHQJ+4doz6JyLTrMM09dGvbv8Euae9Lrvw
 d/EqwkGuha1cb5w4DuxDAIiwf/yBNItvXxsK5mQV/gn0tiMkY9fou19cVDLa9xZAzGav
 RDIOvH4JmTcwWpYQr7J+L5hSox6QwYSoI/zBOum/7nJLvRemsKS9w5TD1TylP0VsXRy9
 X81OEFmD8t+7bdhXFoFblDU8dpuqDziNasdj1xuetT1iQuaHVtwh35gmecAXv2DDYTvR
 0yCNimsl34ehvtv+E4wffVI59rf2i7yTqWphZXyxom66E22h/sKUJs8oa1GfZc+ooWb6
 751A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZwUiHlQIGh5iVc9r03w2822tfjoEdRPBg1w881xLgqRe0pU+25QklulogdfypG3L/wu54V2g2wqVq@nongnu.org
X-Gm-Message-State: AOJu0YxZOi23E/XiWPlDbZI5p4iSwmq++4KkTuPVJm2M19Wyvfg4+6Te
 f724GdlKmpgQSLErKwNB3VmEcwsAQ6/XtQDAQ0wsUyxJZy5jJA8IYSEiFvLOSLzr99KSwkQdxra
 GYOa9P5q0b0f1wKi534hd127Cue8QLz85QYfU8mRC5HF+epxK3a5VwmdmOA==
X-Gm-Gg: AR+sD11p3GSjYNO1MUT2ssZ5EmWQgVMZ7pXWb0CQbMor0eB840bAQ2tDSx/pnK4loal
 KBWkBW8TqSosajy4HNn/MK9FR6rWBRTvrPs6Tq7U7K9dO4ZVaZ56OF8fWATnSzOH8MEVr4490oH
 ytc6qCBzZRtbbn/sUfUnhD+sd/LUZq6ZvbR602aDmVTyg4hdsaaPWHdHabUOhCS4MPQh4+nhWWa
 oqYLXXTnT7q0Bk7AHJkgxiFBnuPnB3/waumnxzCt8V5Iond9I3Ft800IYWMjmG+/W1Dq7ddTn3D
 Hcx8t2FtG5u4pdYr2CM8+Gs+F6SBxW1K+4gejgMDtEXoy6v2Ssspd8FrHWYsg5iL3Qf0I03aO/Z
 4lE9YT+79XihDY2tmNlzpPi1xN+vqQDCNiOYt2dQipBtZ4JV850u6ttgxhaTow0OMkvhx
X-Received: by 2002:a17:90b:4b41:b0:38d:e658:595a with SMTP id
 98e67ed59e1d1-38fbc409a24mr717618a91.2.1785518920832; 
 Fri, 31 Jul 2026 10:28:40 -0700 (PDT)
X-Received: by 2002:a17:90b:4b41:b0:38d:e658:595a with SMTP id
 98e67ed59e1d1-38fbc409a24mr717599a91.2.1785518920409; 
 Fri, 31 Jul 2026 10:28:40 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38fb2e10549sm1012935a91.2.2026.07.31.10.28.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 10:28:39 -0700 (PDT)
Message-ID: <4faa56ab-6191-494c-a948-51fe70122b21@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 10:28:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/18] hw/hexagon: add hex-subsys
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
 <20260730012824.1135905-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260730012824.1135905-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wHWs6MNuIi32mgTONfxtLMU1lDUnVzx-
X-Proofpoint-GUID: wHWs6MNuIi32mgTONfxtLMU1lDUnVzx-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzNCBTYWx0ZWRfX90c0IEsDgkUP
 v/6+MtEMxPfDZZe3b9LKCOPXF13M0gyzZ37cZvXOZnzszZUTpJCPyaCBGrbIqNMSj7vZtqSYzJk
 tkDsGb7MrKSl+Fy15VRKzkZl6O38tKqi5wy2b84Zq7VIvLbOzbJ71WcHVXggP/OLQJ6yrfUHQZW
 OryLitML9ouCLyQlfoGwCkrMQGBvdFdD74nMvd6tPLyEJB72enymVeXjmFo9iaQS0uOfFHVoO9d
 KsYcEPtV1WJsRdd3HW3038JyM2PCT7ZBs/z6gPWw2z+rAjs+NpZQhfcJcNSjZOXnX99v/tAd6o4
 RPeNYrM1z0pt0RlPolkJfEJjGH5A3iEqtjUlLyjfx080nYW+1iibk29AiJTkWAtHB283HbjPFA4
 Hl62rMVz6I2txuT6wAUO9qwhy2B8BO1RXyBv8UteyCl+I1w0JnrLixf5VEHvkMxZiQMm1cCsF0n
 kUcMdL7lGOrY6OxlpOQ==
X-Authority-Analysis: v=2.4 cv=SKZykuvH c=1 sm=1 tr=0 ts=6a6cdb49 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=l8B-B4EVe8m92A7OZBUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzNCBTYWx0ZWRfX8st6q7MQZSXn
 JPXPUNi2mtxjBPDPMWBWDiDXxNTNppZCJkt4rEuZy8IZin03AztzdEyhW3+aXooeLrqtPZUkuMn
 SWUHsm5Hkv+PFR/+pGTw/ah5gfkKcW8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310134
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/29/2026 6:28 PM, Brian Cain wrote:
> The virt and DSP machine models build the same core subsystem, let's
> abstract out that part.  Start with the DDR and config table ROM setup.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hex-subsys.h | 17 +++++++++++++++++
>  hw/hexagon/hex-subsys.c         | 32 ++++++++++++++++++++++++++++++++
>  hw/hexagon/hexagon_dsp.c        | 17 ++---------------
>  hw/hexagon/virt.c               | 14 ++------------
>  hw/hexagon/meson.build          |  1 +
>  5 files changed, 54 insertions(+), 27 deletions(-)
>  create mode 100644 include/hw/hexagon/hex-subsys.h
>  create mode 100644 hw/hexagon/hex-subsys.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

