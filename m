Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C28BC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MpL-0000Kr-Lw; Fri, 04 Sep 2026 01:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2MpI-0000KM-DH
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:51:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2MpG-0005G3-EM
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:50:59 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6845Id032519483
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 05:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xgWC/X14fR5CMRgDDE6vpBhmIL7SRS7NdR3GBYpmyBw=; b=F/vNsSQgS9Yepx5p
 +pYmF+17aShZinL6ADLSoiCzkVkZqv8YD6iS/lByvAqeYwfp8IcfR0Ot62xZx0Re
 mHwWHXPI2ecXRE2I0tlOh9pucAgIGSOTdvVvbOnWCu17sJjfS1FJ/wJnUNNw9aCa
 TVK1Jfa1EMP9Orgd4PsJ/ZhvUoYCgejae9TbZAsuYPXjxkG3Qb2bmzHHuy8EGWA1
 PuNR43dMeYKMG2BHp0Tn3vkjgoKKdBg3MWtI0HS54BHNr8Xk6eCHrgO6XSrbnk0M
 EZpS9Ex0gswcKeFu0vjmDxnVnU5d4raW8YdKesGcimhGwvztmXFn8CILw73otkl/
 hWLVag==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqtr47n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:50:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cf7dd9fd91so6728195ad.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788501055; x=1789105855; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xgWC/X14fR5CMRgDDE6vpBhmIL7SRS7NdR3GBYpmyBw=;
 b=XMU6vgOn+OU00jTZWU9cUm/1qCcTxUUZNdCqN5YUf1TjKHKAJ7MT7dj6cs3vaONmT0
 bsiniGjqNTg3SPD9Arrqt9mqXL03qlcBv28L/YAsaRcVSBit2nuJE+CfoTHLVc2mQOlw
 QKqZEjEgqDrVmO8aqWQKaa4Goxpn84xVDaL2g1BW1aiH3eWtqOzymeDrHFTEfpffDmFZ
 fh2UDK8T7/J6NnBGgoDzPWvTyEhUb/22ZXD8WfZA/8sjn84TMT0UR6BrUxjjyLFagzrA
 DURYCGWCTwrWDjXpOZO/DXXObEfOLkutp80cS1Ft2rdn5SaYMovjsRyq+AmV1dnX4HRy
 nAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788501055; x=1789105855;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xgWC/X14fR5CMRgDDE6vpBhmIL7SRS7NdR3GBYpmyBw=;
 b=eAsebKrKkJTMtp+4c60CBuYRM0x3rCAxRzsYDa44PmrGp1ieyVkkGN4rBIxTw0NO5a
 9qynWhJupGy1YEzaBah5ziSeKC65KoFlHDiq3X369jU1Tp97KUCG1zmc8xKIhguI0d6W
 KODfbHB64bL8hcYsqhnvkin+2eo85eXkf2u9SYPEA8cuzjSCir3KKnBpctERExARnDDr
 4gW/Xq9FsrUCfaJ5A9T7FEXlbqTK1JNvZ+y5CeTopIWyTdLkfnJvuaT3Nk5MMWOVaZlx
 Xj9nVine+gS6L4eixoDJacd/ohw9h9qGvNDFJnAMrTTYlN633BJ3c05XA1QOfsns0jSV
 kx1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJGDRGnqipLYKoYxJOt6nyOZC18WXXnUY9FgHkuaqxOQIFhBAxYFmsaVPlCHlc5AdkA2ek8W6oV4si@nongnu.org
X-Gm-Message-State: AFuF++mWb3lX4Pzh1ZMZtOar8RNx5VSRpgPeDOO76QHvpKdHdmpO1j+w
 UBWpvHPuKEZYMCluZFQGOhv7X+eCG2bP58jCzfcXuv5veoAS1OzzxXvjx+UQapv5nBsY3YhDEJQ
 oFnFk4gSFpKo6S9U7Z1WgE/rNN8w36wT+Vx7OSwFywDGLZfHw49OrBbeePg==
X-Gm-Gg: AYBFou0sHTAsXv+Go1GhHDd9USO9SA1MBmBJLWBTuucVXBCzGbgZmu20bK7rfQiQGcG
 b/vrrkNo4hIRzmsGHuSgdJ2L0/uMthrUSIOo9/At0vPtrWBfa3EFRou9RTnbijBgVp6pyCUwPCO
 +WvGLG1cl/zfv1p3RukqAILWktP7x6qDaQXV1/abIODKGBptqC9XGvxLFh0A5Lx8nKYebm3v6y2
 JWquI1VSy3eySEoAqNcO6pMt1sm4iPMfDyR7vgiHFaYHO5mAYvg4hcLpCdYk72lG1ypESCNW3mO
 nA9bCurTy5x3FDc7KakifYncMFXJqtXEABudkd5VC8mF9sNimH+KRa+qorxm7ecYXyk3T+jkgIa
 xuwXi+JIQtKDKF3TyvN6N5AXmz3F6wQ0C65bFX8MaV+IO23pqL/VibOE=
X-Received: by 2002:a17:902:b114:b0:2d9:1dee:43e3 with SMTP id
 d9443c01a7336-2db12757f17mr36089105ad.18.1788501055091; 
 Thu, 03 Sep 2026 22:50:55 -0700 (PDT)
X-Received: by 2002:a17:902:b114:b0:2d9:1dee:43e3 with SMTP id
 d9443c01a7336-2db12757f17mr36088895ad.18.1788501054600; 
 Thu, 03 Sep 2026 22:50:54 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db190f6fb0sm3131535ad.51.2026.09.03.22.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 22:50:54 -0700 (PDT)
Message-ID: <dc915919-872b-47df-adac-d12b44251669@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 22:50:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] tests/tcg/hexagon: add vgather/vscatter
 region-length tests
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20260904012233.3607547-1-brian.cain@oss.qualcomm.com>
 <20260904012233.3607547-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260904012233.3607547-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YtA/gYYX c=1 sm=1 tr=0 ts=6a9a5c40 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=q-r6SJLbOQhasUAek_IA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: jZxPL3VmXGyhABsFnnDOe0Zq9AeOb3r5
X-Proofpoint-GUID: jZxPL3VmXGyhABsFnnDOe0Zq9AeOb3r5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1MiBTYWx0ZWRfXxw9Rftn/XpGX
 KhIZ+71xX7J4jNHuTdimlkEGEKuaKs7j+2JGsNeJltJVeMkLrS975nk2C0p832x+/0Hu6Tdm8pl
 9zqUhrgDJA+E8OOAc7hHCfZlTX5SYsY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1MiBTYWx0ZWRfX+dbVhC3uZKow
 Psc3DitIMN6TzaEDcoGknhs8vlHbDfY7MVderhrPtSg7rIoS0gWgqKwr16OPdQ6uE/JOOKK7bRU
 7t1h1Dysr5f2zmYtoD531+1vTTMizLm5RZEEJ4SLZYnYBFEZijKBuJAMZE0F/ITpn8pYRQ0yUlk
 hIZrz2iHQaZNMMEp12nXHcR5spdcOPLTQeZgOW8Kjjarh1Det4CaEaJqEazGSv7a8+5/rvGT5zK
 EmBlei81MXrFBPlJ5kKTBPm80iaezPw3pOx9B9WNx/7K21IzEMnUpen1vhTNWtlqyxQGq3ifZCg
 0DgY9JhVcYPk+AcJQsqag2crKcFDiv0qamqk2NYTM2GcHxnVjBHb6qMWqQLxjPKqGnLnSf4enE8
 CsDvUH2pN1YKe52h3d1uw8s6bER0bj6muz5CBessYv3rq7kun6rznAgXlcZ0XP5AEtyq6/p0jlR
 CFy5jLo6z9SLd83u0Jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040052
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

On 9/3/26 6:22 PM, Brian Cain wrote:
> Cover the case where an offset lies beyond the region length: it
> must be dropped rather than read/written.
> 
> Place one dropped gather offset on a PROT_NONE page to verify that
> the instruction does not access memory for that lane.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   tests/tcg/hexagon/scatter_gather.c | 137 ++++++++++++++++++++++++++++-
>   1 file changed, 136 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

