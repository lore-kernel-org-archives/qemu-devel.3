Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7AC606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pKUhX/+K;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OMHbFhjB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT47K-0004CD-1h; Mon, 16 Nov 2026 16:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT47E-00048U-VH
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:19:53 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT47C-00036O-GT
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:19:52 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfqkj4147373
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GFXlT66WPlnwurr+oJvh8R9FElumR7TawmVyE8BhoQY=; b=pKUhX/+Kbw6EsGRU
 X93qhankl+b+0fFRcJXC+XGfY+zXsm9al8QniPPEwzrceyO8ge9rn2cESvMWxsG9
 8YpLKYI1u7TwXEU/joalTuvOOzc/J+JPMPOQpMUErDsFEwoOhiMfk5NakNXelpzj
 ewzseWF6/w/XC9zx7p3hxK9PNerDzN4uJxVxVEM/fNV4qNqaBJGQ6VlFBr/ZJ9DO
 FtVznFVVFWNxDAqgce+FXTQn0XFLZdDy2Ei7pJiAnSBU6aqAY+Jc+lIOLwaPHZoH
 B7/QVEVWqFpxxLgMZbQy74Pbih5An7a3lleNTiiAhgQ+aldXSr3FUi1V34pRLQaG
 sGp3Yg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j01f824es-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:19:48 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36f479b9819so2194573eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794863987; x=1795468787; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GFXlT66WPlnwurr+oJvh8R9FElumR7TawmVyE8BhoQY=;
 b=OMHbFhjBJKZqihKODcz6r9pFw9VC66K2z5SYjO93NAX1TUxIDca6VtX8nReVjIrDa/
 EnG6zTq6pQqLPPWLUDJBObrYdb4y6pSf6BdIPSnnrgDn2N4IO4hm453WBToSXGyAz9AD
 7H/O4QPLsUGQ/6Mr2upgnD12okot2NgYfxU065D2dQGyJkfNbowQzlsP6NvQC0c2/0Sz
 q0r2OigOzz0cdf+iVsr0vBKJxXLV4mCkY9pGzrRiksGsKOHwLh/bN+RqI0DvvbDR5I+D
 2zDkw3cuT0UGI2R5PVfRK+3ScWHeq2iIB5/y5sqbnB3p0bwfsU05V0CNESXz6N94z+Fv
 np2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794863987; x=1795468787;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GFXlT66WPlnwurr+oJvh8R9FElumR7TawmVyE8BhoQY=;
 b=FsK8YeJxh+/3G6ofzVS5kuGRqtKlm4I8N/peN4iPeoRl567+ylCC4s0FAKwwyqKRND
 68omtcQtF4gSGKLIgX1QHLqAneiEKGmia2X6uAhkQxl6xYUBDyeBTz/OvV7UJ7Fqlolh
 0RpQz0cHC3V5R0WRVvw7XenDAU5gWlurytqFln4nM4IloXkw7oTCBjYYiEL2DVVjnCS3
 YJ0hvbF9wZ+vc7p66CJxlvp8VoQUpFD43CeljblTUk3GKEKgVNyLtkFGX7F8GwEaq4Zb
 q7ZdBlfVnVhb0nSbtc2HUN4kovTIyD1qzal9TgvPsqZtXM5F4T+BntSNpdae/w/Y5Tjl
 BOXw==
X-Forwarded-Encrypted: i=1;
 AL+hErFBbMs7lz05bnF+CLM4H7AloqfcI/TkW6WvzNWQz3R5j1p17xcfOvZ4+ylq3FGtBTP/OCUVW2w57gk4@nongnu.org
X-Gm-Message-State: APuU4Z82rTFFUL8j1yG8VJlxh7wh7lR5Og3Db3hIBMrM7kh+DD6unwC3
 nEuBYaYCRG/gP7kp7+eHKyVBU5p3REvArutw8tXV2wpiYV8fxOZnFfwVK8umg/V1tKcjGgvkQwD
 5fTotWe4YL8TVRZrO2u5Khzgou/EURM6Ssj9JudcYczVmOgt+f6XWY4VK0A==
X-Gm-Gg: AZFdTZcoPNWTJKa2BsWxscZTZeA4YC84IVBLoMF2Saig8eF8uanew4CnJ7YuzLfqO4a
 TyQH4trDbW4RFx9ajm1liNxU3F60gLsp9ZSy/0d7W5AVi62WRTkbz6ip5YUEjlJsTZh231eMv1N
 PBv8xqwSYn/B/wMC7RSqJB/W8+CGHJO4a6HsPSMkiSJ2peFaFvlA02idgWVdlHjsbJIDbzoQcNk
 1g7MzgomY+uSOLnStZOax0zFJ50kWNP8kt0vaUdR1dZVWZz6hAhFfpSUoI6rreUYEqocY7oEYwK
 RYQlPWGnbx6xo2mHMZtI+fGR3RLubUQNY1LwLdOtZvEK4EYZ8zxihz1n6RNIwYETDxj4k3UNyQ5
 9DcnNHbTslVo+avdeLftJ3In/BjG5J9t0eD+MiKqYoOKb3if3J0kELf0ZcePQCSt1z44UU85y8y
 nPo7RSt8BZTeFhPxgauwvPRrMNigPRRVPYp/ABsM69w+k=
X-Received: by 2002:a05:7300:e9dc:10b0:369:f9c4:1fda with SMTP id
 5a478bee46e88-37967ae8705mr13453911eec.27.1794863987489; 
 Mon, 16 Nov 2026 13:19:47 -0800 (PST)
X-Received: by 2002:a05:7300:e9dc:10b0:369:f9c4:1fda with SMTP id
 5a478bee46e88-37967ae8705mr13453890eec.27.1794863987005; 
 Mon, 16 Nov 2026 13:19:47 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955ffcbc9sm52576621eec.18.2026.11.16.13.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:19:46 -0800 (PST)
Message-ID: <79c25e3e-1195-4823-9110-4e80d20ca7e4@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:19:45 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/48] hw/arm: rename the 'virt' machines to 'arm-virt'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-23-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-23-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX/T5ajh4Zk5LT
 yBDFb9S2A9qDhU5YjFg94LRG0UJGOtvH/1KTjxLCtzpS01gTPEOQMbm226MI2zyzOTlCDZYi4Mu
 M9qGOjTWJwphUhKqD11+NTmLez08eKATd2CQUlir9CzA1nydJGboJZl8P096OazddN8h+mcpRAt
 kCXYv/hNMn+RNnFGx1WqKrmr8+M1zo6hwZns0TwXBm+U29XwM6DyrJoSpRDnuDwwJdaDkNZ4RNz
 6mXBMujSJg39ZNy+4c6M5sC3HR38Cot3XPpuK/dGzA35upjaY836rLtGTFipdGdtY0VS5PbuTgP
 uYDUD/EQgVVLzPmbN9EOSDUyA5yHUxtEpRUKhETqLscqCzGdN4dptbo9HEWLKNUrfTzjfb3eiR4
 XlsC7KmnQFRobs9ZPa9ryRlP1NYdehV2B0DobvvtklXEOnnwbP8NgCOzG+uEIXzdDj+upqrhh7x
 vI48M4BjlbGRU2eNtBg==
X-Proofpoint-GUID: iwiCpjLkXwxra-rM-J8qY2Pa61Lp-Q3H
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfXxMz563RFZ/ZE
 UOhpwGtMk72koel7/T9edLX6c7mCThXFkBPwlzj6kZlyy6Iy+R3k0JyDxyhf3HOG58K4Pf9OFIH
 yEEhvuIk00l8N7yT5c67g2ddWRpgjOM=
X-Proofpoint-ORIG-GUID: iwiCpjLkXwxra-rM-J8qY2Pa61Lp-Q3H
X-Authority-Analysis: v=2.4 cv=VMpIDNPX c=1 sm=1 tr=0 ts=6afb7374 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=KipVUwB-fmeObyUNlbkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160084
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> This introduces a globally unique QOM typename 'arm-virt' for
> the virt machine types.
> 
> Aliases are added to resolve existing convenience names
> 'virt-$VER' and 'virt'.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/arm/virt.c         | 17 +++++++++++++++--
>  include/hw/arm/virt.h |  2 +-
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

