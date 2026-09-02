Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF5CC61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1clM-0007Et-Gf; Wed, 02 Sep 2026 00:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1clK-0007EA-HM
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:39:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1clJ-0008GL-56
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:39:50 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTJIO4097928
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x0QUym8+kgtbOHqYto825Yw4mBcyj+HTiqp7eJwbJ+k=; b=oMwi8uQgBv7XPLf8
 LDDOWfs+UPQqdt0w4toBUjBOSCZwWxFzTFFMv7GJYmpYtRe9NHjYkcGnm3V4PPRi
 yzXDvINOWBwmFnP+8ncc0Z4ie/aRwNB/PjUB2qa83bPjXM90XjaGfsdRg76gJG3y
 bcSXsTSYGQXw6PdhuyewuOiRwCIaWXc311Bp0olVM3RVpTLU7/wF2eTL06V/zqVL
 dXXEe6rno2MNzuLjR46uJifLG5yXcSIe29qQp7eMRDOR7lvaKCvIJr8XxxR8Lud+
 qM+Y1j8cqduW+Pr2RWBbURdWSAydxtl6wsa0RmE0pMcqQ8eo0Q92udRHOLmmW77+
 JaBT2g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdynt3f4h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:39:48 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90e8472ee1eso12417876d6.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788323987; x=1788928787; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=x0QUym8+kgtbOHqYto825Yw4mBcyj+HTiqp7eJwbJ+k=;
 b=CieIAwGmSSe6hiwIHs8J/Pdq9Aq4V8/dR+bxFqMe8ckotnwCFxLjOcezqqBBLYcKC8
 IFd7E9YIcMDfdY9cfUJN4bz9sFFt39mWFpu9OCguJuUSngqK4GzBjJgi4IXu2tEeJFhm
 xHj7CblYVoMHUKXE/ytfTv1yX1VVjyq7rk2FMNuA61JHFtStKUKo941kAsGZ0xtFZbG4
 v1GpQt2XwtH/gVQmDHzE7d1Vf3w48W/hyQI1bZyEL90gi7/Odax4pK0c8tHVfOLGuvps
 wmnkpZrge8NcGV6GyDo3JfJDBJ/PUp/vvHAR9pqdfnY/eQ0D9Jbb5KghPnwXjD9Ia/uP
 r4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788323987; x=1788928787;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x0QUym8+kgtbOHqYto825Yw4mBcyj+HTiqp7eJwbJ+k=;
 b=kPqgpCZnfNw7DVTHt0gOWdwoOjgL6hHSzC0b2WiJcjWGXu8i/TU8ocCPXUunTfff3N
 dgX8BWT1AJPuWapcZZdYxxpAMdAIFI3PNcBeAPfkXTxCQ07y6osSSDVTdbFB9BfprUUy
 jSBZyMnTNCUN9p7zWJK2p95S7x10dDcr8A+5l6h1iJxOVm/OAkKy4H3YIuMOynbbLanc
 PptZgjfY6KMvBez17BtVKFS4QQIItb4r+hKZgLIU+TUl2rJQIhDvV3uYexwRq3UEEhhQ
 y84WBgN9bP2OBOoQw0blLgltUZ1JPpiySu7U45jokbc/L2e7fzDT+vekIPNhtn/uLJ5J
 dJIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9O6oIy3mOtyTY9uYwrkKQsl4mqVYIQjPsB3y+Yc6RBfAJpzCbeFfUMuYjcwd3cGimvOUFhQ/bWREp@nongnu.org
X-Gm-Message-State: AFuF++n0aHY70ZHzRrEMLNSvYHRqWUhfYKvKo35Z9j39d+2Ym1c6dUx3
 +EYg1vgZAG8XrbuyCrpC1z1tq8bxyxAJtkJkMcUuuLtwv1KKZKW6DUVbQz4hjBVGcr6+d2lcepe
 94cBjXoo8Qc/lVZfa4XwKyBzXwEEKA4bGfqA+1Ynbpdy1deD4SJGxacO7zTf1O6q5lA==
X-Gm-Gg: AR+sD12zp8rvGuNG1FLevidJcbTTTCDmdY6cKeT6v0b2wmlkzjsi5HcmYkK76H5j9La
 z7zNwG5Od/ebfsC3nlxFC/hIXONf0shNTDvsUnZXnHlW20if4ROg5MNzaEkG8Cw9l243If1Mbbr
 /Rdc8RaTgftPLw0vz1/R7t/0Pfu+9yXLwDIbvrW1IhL2U37mwK9E8TU5DVah9ha59yK1C/rlH00
 1kKBvUuAgEjzXwr2hrMDkZbnAbrUDOQM9gcnw6KrnfirM4QwCgWQ0kXouKXRX3Q4DNXcq9CoS1E
 hw5CjqbnrIItEYHm5m0rb0iIdaOI7PvNjJ97WWqw+NrGL7r7YlA23OELEcXMF6d/srRK+IaW4TL
 n8HBdj7/r7lpYNBK/rPB9NtQ9f39llVWlVA==
X-Received: by 2002:a05:620a:269b:b0:937:6d2e:d023 with SMTP id
 af79cd13be357-93960f528camr238762385a.30.1788323987402; 
 Tue, 01 Sep 2026 21:39:47 -0700 (PDT)
X-Received: by 2002:a05:620a:269b:b0:937:6d2e:d023 with SMTP id
 af79cd13be357-93960f528camr238760485a.30.1788323986900; 
 Tue, 01 Sep 2026 21:39:46 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce4774a43sm35427705e9.9.2026.09.01.21.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 21:39:46 -0700 (PDT)
Message-ID: <db7119e3-8855-4422-bdb6-af760431cb44@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 06:39:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] system: query machines using TYPE_MACHINE
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <20260901202043.26532-4-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260901202043.26532-4-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfX6e4iYM8CJdP7
 4iWx7QK9c2X0D17ucpBYWZd8nB9iKwzCWEG1y8XKwrqZlrWs1hTXZO3kvlkq3wE4tpw00IVpnIG
 H7+vmAqvUWC85VB3eZNAGMHPc/faK6vQO0GUbUp4bI5QVl/ntscP8cd9YsYj7OL+dEqojKjVzPj
 IeqFQ93gCJBUWnMyrPjUK/Y2dBLGZEC1CIuCgAFwlY5v9kxa6HrcjxpbuTNNXFsCwKZS5IrQxp7
 2Pk40ECxzDLm/mezGjPZoFDs3DqAdOExei0ekf7DZnZoqVXFrXhJQuLEHgW/zO0OLGYOKsp0GET
 X2LMYIsbzthgP+a9uOAazGblKfGsntN1HBDLSs4lUIysCSaDiDMUFovAAMGv6eeRVhwy2yipj77
 sxjevTY9Pbwq2Oa0MdzXPEqgJB/LiqTaJTTTdsXC0LzEHbzIOi1povgckojYyWfXtfOXOtBwDy/
 GB0DljstF98qNw7nVWg==
X-Proofpoint-ORIG-GUID: yxIaszGK07tO9UVLHRJjvw6kjP80ODYw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfX6AOsAjcHGjIM
 9BI31fHkTup9qaIUNU6OiHSXy1YvjyytwfwSYkSkFeHhZceiLXE5R7FETkgTVmotI8LSthRrYy6
 gTYclPqX9riV1hPZsLQdqkm+ljz28WQ=
X-Authority-Analysis: v=2.4 cv=LfkMLDfi c=1 sm=1 tr=0 ts=6a97a894 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: yxIaszGK07tO9UVLHRJjvw6kjP80ODYw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020039
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

On 1/9/26 22:20, Pierrick Bouvier wrote:
> We drop the target_machine_typename() we introduced previously, and
> revert to using TYPE_MACHINE. From there, we'll make sure only the right
> types are registered at startup time.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   hw/core/machine-qmp-cmds.c | 2 +-
>   monitor/qemu-config-qmp.c  | 2 +-
>   system/vl.c                | 5 ++---
>   3 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

