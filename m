Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA357CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDrz-00087T-TG; Wed, 29 Apr 2026 18:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDry-00086b-DB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:59:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDrw-0007gb-Rq
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:59:02 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TMFBt63885246
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qbSvghMqlmu/xZt6nh9NUmjvB4A9mwTz/m16zC8EMd0=; b=QvMU86XpDShd+vfV
 hvbo5N/O/9etmlvZeK3v3uhdtpZSkzgJgDLlt22ypGaNy+RM3QkM8Ut23qdMPGtZ
 hqCNkAYBbHyXsTO12p6cGZJ4d4yRa2XxfHYWhM7QG4FVLWNOHYascYq20jALwzP2
 1Vumsn5wmBE/CCBoE42b6jpBMKzJglSIntw3W+cnIcsLJsIhSFSE26RPWU/yEJWC
 WEz1g5ftKS0vsGzjhQ4O8MciJpY8nuCkqppSyV17IpTtXrjqOoyTBLmw0Io2xOq6
 687z0/GIaVuEffoovqOH/ORKj2PEu5s09LJ0OSBsKNhFHZ4JOtR0ihgL90twXekC
 g4k8kA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dutmag36f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:58:59 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12dd33dc337so809322c88.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777503539; x=1778108339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qbSvghMqlmu/xZt6nh9NUmjvB4A9mwTz/m16zC8EMd0=;
 b=QZjUA+WN9NhQqxS7ZuNDttDKk79XHcgP1svp2mwNXyf6TYzZsEX8vJtzjOg4h7H8uy
 R/7c8lR9yBH726T9MEdAzCZIcGLRhKZZUeeMkg6vCMtXqxqRiKUDXfOqnXTyfWiQnIEa
 cPBcL/RlZ5BFKP8EXmZYwW39bGXJwZd+6v9ZmAW/o9GmnhFeyZzZf3G147iq6Z5u3/ze
 EBVMxAzeYGllMr+pTdelbkEl5F+nHmQ+FvrCj56Zj/HPK7tAtLzFEm15cCW/xD/4mMPW
 4k2kAJOHxFo9mEzOGPvUimaRGh2bVThDjBq/TUMTa7mjL1Ee44owh3gcERESYoUJPyli
 64EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777503539; x=1778108339;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qbSvghMqlmu/xZt6nh9NUmjvB4A9mwTz/m16zC8EMd0=;
 b=FYtzpxzro4ITwI9kBVQvQVDlreS62kjzM7Jjx7wpfaIU/XW0TPrpNRAZauZOd8n/a1
 Q0RErFVmv3+xa6ZAik0J4U0jb28rWcgabieHoE2/hRezXwxMcK32IHkvzFQNUr88juHb
 Cpo18D7+OAtrpItv7C4XVFMTFA4ek8sFmHzgUEvi5NvL3wyGNHRwJRPkKfrqeyhz0iBW
 cQS/MXlQCykFd/12GzBc7Ox2VZTVRbc7KgXrw688n1bIS/45jzkrAFAAaLUJ96gd8Eo4
 1Guafg+ilElG0IyYBqgrx9o9MKzsrWWCbuJhb6ReMqWK/DYCfDnbFEDyF30MvSq+BfNR
 Rh8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7wZ0ASJp0lnuS7+Hu0hcbPagtbNc2QN52j+te/LMWsuyGnV1LJKK2A0JV3ZCu+qW0kvAXXwE3d9rt@nongnu.org
X-Gm-Message-State: AOJu0Yyq332J5xUpwztRzvhv98z5tWUjo6IhRbLUZTFn3Xtbi67yGYHU
 nh73adMjLOGtl5Xm6NSIm7WUeUtC8+dDTFU+AfZFLzSbEfQTvEXDJBSMB1mObe/HXtvMge/NkFZ
 2rTnKJ2/CC9VlUaHXEhxQiHHhz8AguOyu/D8JjNLmuxWSAeiD/5kVyQGpYQ==
X-Gm-Gg: AeBDieuEsogrMqDrNzEiBCIuMOGDjLZjBOxdgwHTLH8sLexIkh7UTfU4zh7rr+7pR7e
 xs08nGXfnI9I3iT4dlP9+0cWocllyk/HiCdACj1s1Ieid1AJfOWtsPXbpHozu4i9f78btcJ032G
 RNLfl9sQUqWeRBwlHLmbIET+5davoyyLM2hS+2dLBUtNCu66pz8m1FbsYhseUK/dskygosglNax
 wG3K59wTKEtCrvSqBDz6vJZZZLO0PwVrkcdgS8DgOO3dOippZukObNrqCXFPHhULex2OXA4GI5N
 ankR5TgdKKAhtbjJ//Rz9BHdg3MYvQMmKyDmI1ekdN49SMXAiLsDaA70c4a8qYQUrkXvG+HiMWi
 MkXkuT8+W2KlV2qj6Evx2Lo4R05bHZjRkMGnk0gJiywaiIF1ViImpd4ImXabycM6OPBn0vlN5Rx
 qHt1nTnJ6vGkRkCE8qzsCc13wq
X-Received: by 2002:a05:7022:92c:b0:12d:ea50:31ad with SMTP id
 a92af1059eb24-12dec60218emr45089c88.5.1777503538777; 
 Wed, 29 Apr 2026 15:58:58 -0700 (PDT)
X-Received: by 2002:a05:7022:92c:b0:12d:ea50:31ad with SMTP id
 a92af1059eb24-12dec60218emr45075c88.5.1777503538160; 
 Wed, 29 Apr 2026 15:58:58 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de31ab65fsm4588792c88.0.2026.04.29.15.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 15:58:57 -0700 (PDT)
Message-ID: <157b3909-f60c-4c07-af0e-e62e4aa15c18@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:58:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/17] bsd-user: Add FreeBSD disk ioctl definitions
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <20260429-ioctl-v2-5-288639bc2427@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-ioctl-v2-5-288639bc2427@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: R48dn-7tZdvejjDftuM_LSo29RL1xEmQ
X-Proofpoint-GUID: R48dn-7tZdvejjDftuM_LSo29RL1xEmQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzMSBTYWx0ZWRfX+MArcOLdPVaP
 NBp6zNwN/HKyWLQaxHjMmnv3gfGI9B2ZqjtnXXh2ku4qTVaokuTH5FEOMBQw/ZGVum3712upAv/
 O434V5q2KHvmG+9y2jmvMEIDVuBd/PW0XdJIF0Ok+v9m4TAEA8E9/EdCcBZ1pxZlrCibLjTq64p
 A3r9RxZ7mqIS4KrK7JFX0IfIE6C5bJ6I3yuz2G9KngMkFIUtEB7WPLJ4mtn70924NlrBaB38XqE
 bddgta1yaI9rCXWfU2i+UdiW+5G7OZ8OYQzRXmbT85qFUpgLbWZMoMOkNR56ad2Il/onHJjsXZT
 THNw1ylkvY7oS4zjxnb2qm3/0yUwNw32huUYJ+Fatz1jfRIU/gMwn9xZtcrz9MRi60wOdZmBAGP
 g4n7UrHSQCnUm16HhvzkIgRbfx0Ndf3DhsAmm5sxolTSFnEok/3/TzlGNOg0xO6Azmx+E0RIrDJ
 kgi+x1LrSuK5VmuRZpQ==
X-Authority-Analysis: v=2.4 cv=Fpo1OWrq c=1 sm=1 tr=0 ts=69f28d33 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=9yiwgbtT8N5BWU4cbgcA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290231
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

On 4/29/2026 7:45 AM, Warner Losh wrote:
> From: "Stacey D. Son" <sson@freebsd.org>
> 
> Add os-ioctl-disk.h with disk and storage device ioctl definitions
> including DIOCGMEDIASIZE, DIOCGSECTORSIZE, and related disk
> management ioctls.
> 
> Signed-off-by: Stacey D. Son <sson@freebsd.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/freebsd/os-ioctl-disk.h | 41 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

