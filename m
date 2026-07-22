Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C473FC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmXzo-0006hM-1t; Wed, 22 Jul 2026 10:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmXzi-0006gs-I3
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 10:32:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmXzf-0002d3-8N
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 10:32:21 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MDWgr11033848
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 14:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 25kKZ1cjXkcsKXWC6WoGQnO0qGXuQvr7bzsVoFW+D0c=; b=a00PLdLEmuz8fVla
 Upwl55PenRx4FZupnAI+r5kwLa0OuMSB4uGXXROeXYPhVxxXw9kaxjq3C35/LLlS
 19sBD2KEjTxEh0l5bJ28XiFFK9MD412+yN8ZfYILPlOrWQZxjxY1/UmABnIS34k5
 bcEtRYWqJA5wfXrBhTggFF0h9oOW0pGmtfn+b+V9d0KLxTJFk99i1uacwLXEHEHk
 9wvhv7Fn/agxIdcHYgsQPkmUPaCKmz2eCXAWsMFUYrOZ4pHYaLpoeB9hfOJPqE/l
 nx36Pd5FZE7xQMtGONHKAiztR2ukpKQTgCVixMvO0aJWXvJBWubjdCUMFnjhNi5B
 Tpou0w==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjpxdjawj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 14:32:17 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-73986bb438eso14394777137.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 07:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784730737; x=1785335537; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=25kKZ1cjXkcsKXWC6WoGQnO0qGXuQvr7bzsVoFW+D0c=;
 b=X612acNBJGsv+SXDwlakqgDdMb12KfCFbjGA0Zonx+hWgab+tujOfZQgQDNoT0cYa7
 gVt7vAkskqOwSOk9P+jxGrtHCifcyNC9PSmml9Jgx8jwKFutFmyelN+grulcc4nAWHUH
 Rbhg3oulwre/oR2Sz3LGj13aPyUMWHmV2EZU6IXb72U33ZK85Lw3lp7HU/VxPc05qjSX
 2Zqt59u+NzdN79iRuUimlJhKAKeUXpx4dkgyWiu78xsaybM+5XruA/4JK7OOWfHHbJc9
 xtydvUtvTOOO61Ibm5RQh0mSaw7G6V0BrPTtAVVXUKrFX/3DGy7pZTFLfcds3BqWofld
 dDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784730737; x=1785335537;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=25kKZ1cjXkcsKXWC6WoGQnO0qGXuQvr7bzsVoFW+D0c=;
 b=q6kuMDTDmUrLGREfLSwqQok/tIDHozjHZKDHNtT+gRJNOlX3CZIA2A7kLm7qar++51
 U3qLMF2PAwb6w3+O0qkDOd9DwjhCjfATq9b4UklJpC06ludw+1eiBQScVmzgMALpSrNi
 fEep1ldVf4TTU0KbAVGnvoDrihAi8w3afKoX5OSC9VHWMfWML/lnOhszSeU1jSwK3kMh
 5HosVuFZEvUk+so0HuhDc2oFVkz7F05k5nFP02LZMM4ShGtIut+mcu/qGxY/ziPlfwXr
 gq550SnWUmFVuTxtSRao1RlxOKdJcftruZ296dLm4kromNpqLwEk0+1pjEzYFCs0a6mV
 zd5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqK/maFHQTtGzAi0PLCs4q9KcSRfedjvpWxv1ddW2AJkn77He2ct1FV1nMFVddSU07ZSMoRHCXDKFol@nongnu.org
X-Gm-Message-State: AOJu0Yz/UzL4xkBDGbtJtGV4/HP6daYAOPq+JoFt64ijxrzXtLTV18OP
 uOAAAMzQdiv4q352e6kgh3F+AfAoVSElYEhsBMN1j+zoGRIV4k4skKvUvUZen+JLvRnC7FsWhE3
 R1AU28XvwsTDt91h5aqdEFo1Vv9oi62+6zLaaSk2F+Y3YA8gkX9Mh8JmOPQ==
X-Gm-Gg: AR+sD12pxAE9KUNPa5skQ/dw/mkg2TE8JkEkgHliqvTocnsJDfJmCOkj7ouJQfR0T9q
 d4B2eCBcSEJ0D0Qr0VWevTE7Eq7JVfdLzTa1sdZ54D3UirSjdQ8uJoowM4mcc4VrJO16opEZu5y
 VSLI4YpUo/JvPinY3Qv+OL9YuWBBNK4iCa7cYx8YD5mMYDwRLM7okZlrjX7kENv4lL0220vx+QC
 z4pTVftvqZ5DtrANRDy1GmofGABXU02p29tjkVfloA8lAVgG4fULf6eX4wY1QUyqXxeyLWXCE/C
 obwjxjNLXtN+MPofNTDhebemtmt6QQP2vUjLxO4ySB9aMufDx2TjS7WnF8ztXxtrOMZZ6vOfdCq
 SKfwQt7iewCPWJXNsPwZzBfKnVxj2ski6tgu43oWjDM7bEQOmJDU=
X-Received: by 2002:a05:6102:4186:b0:729:1a8d:b2d9 with SMTP id
 ada2fe7eead31-747536f0861mr8954637137.22.1784730736518; 
 Wed, 22 Jul 2026 07:32:16 -0700 (PDT)
X-Received: by 2002:a05:6102:4186:b0:729:1a8d:b2d9 with SMTP id
 ada2fe7eead31-747536f0861mr8954608137.22.1784730735757; 
 Wed, 22 Jul 2026 07:32:15 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c98ebsm139233895e9.13.2026.07.22.07.32.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 07:32:15 -0700 (PDT)
Message-ID: <bed181a4-8a69-4fcc-91a1-5ffbc9a45b14@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 16:32:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Guard local FUTEX_CMD_MASK definition
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260722123545.743792-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260722123545.743792-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE0MyBTYWx0ZWRfXyNHGf0ljmETN
 KENsmHJy8jrNSc7IR0V79noFkSmGtb8fRxKPDk+NWBguxsmUoX+siQxKrvHJ9BE06BA0pIS+1Fb
 EViQh714Vpu4ei0qfu3kHR6DBoUC5RY0AU6K8HCRgxEulVQuXZRCCjXm3+BN5mH8baoJQcdheQu
 vbp0RVIfphSpXyEpdclPyNbsRVsDSkbDyyhFFqQvTte3IfcshqebUttO0nBHAyEmpO9UaG3+PDU
 tYkGZV1moJR7VnirKfGxYhFF4QfKjA0l67e5qMC7MnY0hBt+CMRIhJF0q15q+myISypTqQUtmd/
 RLN1d8NxJd+XBMAlHK+VXIewLl107MuA4sdPzlIhKxYzkGbZsbIUMaQWfIPgUqXiRYo4zmJnJNb
 G6lvMWmeiIaoE6Lc0Gt06iRWBJp+yPLMdV+NGKrslBbUECE3Q3hwHz6jceDmtX40Ufo4oC/wcs4
 EeBlAuKMsbTlcTIBIeA==
X-Proofpoint-GUID: nhXtLplr8oFEKElEhrC5WByNUpwJDf-1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE0MyBTYWx0ZWRfX/8KPzoKi8toq
 BBdCKU2kRos4+MRhivTtL9FLdGHyaMgQsOiiwx6HfmiZ2mV8g1or/y4Cg69MUFAaP8R0Mqlq+4H
 kQzWTRj2gnlIX2zZd2+thTRnLpx98po=
X-Authority-Analysis: v=2.4 cv=b7iCJNGx c=1 sm=1 tr=0 ts=6a60d471 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: nhXtLplr8oFEKElEhrC5WByNUpwJDf-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220143
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

On 22/7/26 14:35, CÃ©dric Le Goater wrote:
> Building linux-user on a host with Linux 7.2 kernel headers fails with
> a macro redefinition error for FUTEX_CMD_MASK. The kernel commit
> 3ca9595d9fb6 ("futex: Add support for unlocking robust futexes")
> expanded the mask to include the new FUTEX_ROBUST_UNLOCK and
> FUTEX_ROBUST_LIST32 flags, which conflicts with QEMU's local
> definition.
> 
> Add a #ifndef guard so the host definition takes precedence when
> available. The local fallback is kept for older kernel headers
> (pre-2.6.29) that lack FUTEX_CMD_MASK or define a mask without
> FUTEX_CLOCK_REALTIME.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   linux-user/syscall_defs.h | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

