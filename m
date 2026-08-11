Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B828C5B569
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtg6H-0004ty-Pm; Tue, 11 Aug 2026 02:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtg6F-0004tb-Pn
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:36:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtg6E-0002cx-Gg
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:36:35 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMpruW3008599
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FbedfYpdIbx1MHwcJYN9gvAIxeDoJN5FElk9szAF38Y=; b=eplCRBeGgXzWxFdM
 Kh7BC7YWWv5ScbWICe1/FvcJjP16iTgnRPgrapSyEEX/ahzgTEtN89QGQKB0P3q7
 D7lFzg9m+ayHwlk9POIEUCQCxGo6T9QIR+7qZzL31WQQZfQXsp+jbPzlYGeuPQW3
 OGvpS7i+xZCObTP25Kxuz9e45ooBqMpORioPr/14Ue+kaTdcwUGmffqX1LccW7hx
 JbD16mfWR2JJeFawfzhbbrI3+U1TObDzD863OT8Wg3+TMwu6fwnh0jtFNTVk8zvl
 XHkYWwW5/PJhnr3VsybRz2hBgBUe1I5gJ68dwvHDF8XmPQU42E48ZO6CRYujWuj2
 Ty+qhw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjtjq0r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:36:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52827090cc5so9179191cf.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 23:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786430191; x=1787034991; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FbedfYpdIbx1MHwcJYN9gvAIxeDoJN5FElk9szAF38Y=;
 b=ej2CoqCy1q+crObdDM4vk/8FQeChxKDr/y48rjkruYNfV2mrm38FTjnTJyiuP/25lY
 GjwsKeRJm2gb52+NjMv2mHU4bNjG6fRxkAP9to5rSnmGNgum39qI2JuNatI7xQLZW32m
 IAREJTpPUVDEsFExWI5jCBgtA4NS1IvCV3OJc/GAqcSGitQRqWPuKFskEmO2UNJfkZoq
 GKLLFfLgNkui/TmcMbTFwpjW69bbfVMohWJPPdoz+yDR2d9yD2CaQI+Ck1vBrzI4z7g1
 TKgLJFV0QkvCnSdTaE99tQ++wekgqzY9098S4pEGwZSbjYUFeSP7lSAeKm3EQTbV/UOF
 lqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786430191; x=1787034991;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FbedfYpdIbx1MHwcJYN9gvAIxeDoJN5FElk9szAF38Y=;
 b=a3HLOwLwdfVOXGT0yWyrynhU67FHACRGIx4CgFpUsFXp2dC79PUKYwzP3wtLfepybm
 yOD45qUf14QUGxkhNtaxjw32PIuiTvIFhsYayDr1fPos9yehPrIQyDVwbnh2Ace7tT/F
 NNeb0FJK2pOU/obtZ9UGMZgpdCDAZVy9TWVcOv9/31yuwTUI3+DdHntxPuopwVGvfPHM
 S6CkMRGlMb4Zv3B1qB/RrbiiEm8XDq1se/FFAQfNGXP5EJVuHPnEr6Nl/trYRCzGQOi/
 tq1JzGITGCSYxAUYfGr0CMPhR0fRAWQF/S7t+c45eKccFodTDgDWAJYef91eiV2qQHEC
 +pNA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGkcAFF3qN/GlV4zcglQjJgXk/JEsdkCFP20223IxoRssn/f2S4D+aGZMS21VLMU69skftfMgE7YRU@nongnu.org
X-Gm-Message-State: AOJu0YyhghyD9dAvI1Dy12Sk/90SF6jDu0W9Ga5AcKtHoCzGIcqWE4oT
 qfvHK0qIj0kefoVJViFEZjSouI1EZ5a9n93m23bVPZnPc/kW75MMCOfj3gCSv29JYT76aawr2vU
 BaSHOEh7HEF0ZkHqMZY8zy1Y+mE669ECqnBLHP+kmzwrcHxno97IkLXLeYQ==
X-Gm-Gg: AR+sD12rPii8iXjQeRfGHoWFDj1DzpAKf5mwVfV7HAtngsD24twnq5mIM8Xa6WmyLOD
 fmkpX0jqB6ZwO80mCnwgyhWCJcbmaUCNEMwt6rqzqCb/z1d55QGjmy7wGUU3PAKerYrWbUviobR
 7G3onk42ZiqlzsgYM7cG3KuOdHWxC9IGoQmsvN2OdelRmq4D9tq+x4K5O5sc2eawp7kXBByAzdI
 6Pm/Fdc8kPMDBWhdxR8Svup4RWCRSO61mT3U1LdX16NXQgbvLI+4ZyivUdHYzQw3jNartwGWabg
 P9OykFplSj2lEMiGlk3FRcL1lTNOPdjrdwBDQ0aJDk9dH80iyzLBjPI3h+X2+938WHwvAVAHq9S
 rpQYB5ikisfD65kE9cf5d+c5xsj9D486BMCjW1n8k
X-Received: by 2002:a05:622a:2290:b0:516:82e2:7788 with SMTP id
 d75a77b69052e-52d5949a3cdmr6202681cf.1.1786430191183; 
 Mon, 10 Aug 2026 23:36:31 -0700 (PDT)
X-Received: by 2002:a05:622a:2290:b0:516:82e2:7788 with SMTP id
 d75a77b69052e-52d5949a3cdmr6202331cf.1.1786430190642; 
 Mon, 10 Aug 2026 23:36:30 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499788a5be9sm24610605e9.4.2026.08.10.23.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 23:36:29 -0700 (PDT)
Message-ID: <278d9d7d-954a-464f-8652-c59337e95ccd@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 08:36:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Hexagon (target/hexagon) Clean up disassembly of
 control and system regs
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng
References: <20260811032206.58501-1-ltaylorsimpson@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260811032206.58501-1-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA1MyBTYWx0ZWRfXxi/2ePrZ1xdu
 +83ZJk+QFDdKltczxZ1mEv+Jo7gn9foJFjSnMR0PiCpwTl2CjAtbEiwOprzW/h9zmuUm2DFp32P
 gv7FsOUPRv6Fy2iwWocvOL8hltDlC8r9QeFAk5BXq9wK4xfzjDISHmAMUVyMcYxvbP1N1bAWnOU
 FiJmEG+z76ZzgBTwdjwNdIV+5LFrb+RqOxo1ut37iLQEC7pbGBJxejoA7bMSOZAyJUs50ylYywD
 HKaPke1vAAewRaDn4eGTylxdnP0UE/tgSe4oArbmpVe3EnXtOewMYcAGHoV9SIBpKbYqQ8jnOcO
 MsVIFq5TKtBIxf7Eq8rWfHqOMXKXz7kLI7ar6BDW9pQgIQ7TO8YbDJ0qsaFlFh6cbOZroNAtpQp
 hIim2CHXEe5DgQUbPktCoE/+SEvlVhDKnKwXTULXoPjY7fAblou490dJO1OeyxccXoaLJ9X5Sql
 in1bAuVQuADJN9pBGUg==
X-Proofpoint-ORIG-GUID: URnYVZ8RH4PvBOY1xBjVvLa8WR6gMxlr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA1MyBTYWx0ZWRfX44zgfje48Hww
 UvWeYvyFG/iFnGVkV88aomRuSeLewhuUn2+HTfVtRWjyhyeWSUYaR5IsbiyHszwMwsHq7e+cFqD
 /UJnHjf3jO1uL5MBL+zFJTjQoZSYVDM=
X-Proofpoint-GUID: URnYVZ8RH4PvBOY1xBjVvLa8WR6gMxlr
X-Authority-Analysis: v=2.4 cv=JsHBas4C c=1 sm=1 tr=0 ts=6a7ac2ef cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110053
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 11/8/26 05:22, Taylor Simpson wrote:
> Change disassembly of control regs from C{num}/{name} to {name}
> Change disassembly of system regs from S{num}/r{num} to {name}
> 
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>   target/hexagon/printinsn.c      | 99 +++++++++++++++++++++++++++++++--
>   target/hexagon/gen_printinsn.py | 14 +++--
>   2 files changed, 101 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

