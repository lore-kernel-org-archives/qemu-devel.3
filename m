Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53229FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDm0-0006Rx-QT; Wed, 29 Apr 2026 18:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDlz-0006RW-7O
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:52:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDlx-0006Lh-P3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:52:50 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbf1V3665369
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u3T1vYx4aLNtR3v8QUPKVBB58GsddQhkSxgYDyKfptk=; b=PMYBzESP8CVP/nxR
 jx5TaXhaOrBd4gC5RGsaQjiEoE3D1xbYBTEbXzJssNHLA6k3+zlWDyjZCBI2cP9u
 6X7DSD7JUO0VMr2acVDjZ/IQWsNCVyJ+rSmqtw1aDZppOebDTO40qfF9jHOhm/lO
 PEpI4/dCuLUPl8DLw7CcBKrGwRBFzWl/qUQg31b9E6cPucM4vxaLSiOEGPJOVOtt
 Z9IKWt+dD1kfV3neoIjrNdxwa05nqpSHYwHI7JHYwaKF5o3dIrMRq8ZcZ4dJqv/D
 iwF3v7jOKRtnOfnj1vmfN3EsrDdIBqrkx8fMuYod3cHmguIXXG6aCkOUWGDAvhjD
 /zsUrQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dudh3ujxb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:52:48 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ba8013a9e3so613498eec.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777503167; x=1778107967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u3T1vYx4aLNtR3v8QUPKVBB58GsddQhkSxgYDyKfptk=;
 b=UHMyEqAsqu83a/u2VxsaVhZHw8zYomLDHHWEh/vItVJUBbagsGsJ5FsgIt1jV2CWl6
 z8LqCUxUHsmi5+VtkZilYNM4AjMJWVSzo4uZN4w+hiHEPBO7IkFVUo96iScmqVn4ytnz
 KCyenjGZ3CuQs98B2NDG8qLzqBPfhHbVHVYBeiUUYTiRU7CtDApEGsVJ4mhPT455pg6g
 H9WEdFoBBLh1yoSI9Z5J2kalJ1+JCcvVN+/wScXzeviFCiY7Dosq3h+fZQ5iGoRkuDQ0
 StMGLHZrYV6xhkRqg3sUzG//Tms5jtXphY5Ro2KOY30EvUBgK2FxXefysAkjqrfAthHP
 lP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777503167; x=1778107967;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u3T1vYx4aLNtR3v8QUPKVBB58GsddQhkSxgYDyKfptk=;
 b=JYf6vRySfgQa6Rw69UNHji8wuS2UydL4ZA3cjRwuaRUtujVxdjVdycjaHmh/oRO0Bd
 0YQICuL286XeMf7Nko/eViDrduAzGPIGoQUT3cW2PmEyIlKeaRTbI2X8V+26j0DJzwvg
 +wkgSUQ/mxe+bDOJp08c+0NEQO5WZ4rcBAeYfbLvgFd48+YS2Ees0iwIpwAEQjU36ZuZ
 8iAapnOUdee0L1LdHSif2RhoyqvfYt/1vg15IE4XZos2KZm41yKHIAUKq1BbT0UMorwF
 FM95dpQf62aGzblTeoTaOgGvNx0/09fBRMIfuyR33G4KdTexSIHdAGmGnvUeu4/804nK
 outA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1PCkkG4P/3L62wZm05SFBAyN6o57PiUB7cRbzg7EmdkDQrBP+tHiKE4l8SnWxlrIOUU4c8h8NKjQz@nongnu.org
X-Gm-Message-State: AOJu0YwT63gfT/EDA8QYqSyDu5yXcPMHSjoPqUk/XjF/7YSMNIeOrbNl
 NvZi+/cdWTJLip6mV3kf5N4PozyefzdPeDSIqyc0eOm4NQ2tcDbRuL15L9bjiIv88MGIN84IWOd
 Ira5bwnkbNIHX8j/9d48ff6Ut9eC2dUfrRGFMh/homdJN3QozgN9rQoyIJQ==
X-Gm-Gg: AeBDietKRs8vbu2okDt9oTlkYZLG89bh8FtfRrRIZpPfjD9N4QqTk/AtKigkRvdgqDK
 8UJVKoo81jxFM3Zp+EFU5G2/XNLsGwTtATrDfGkimm9naAi8YhLpZFf3ASS+LzmK72cv3PjIbBA
 9WN7aWjQPrH172xbOQfpPVnPxp3vhSLWtqLybQ72GiMMEJQOx3V/IBKejMu0Uk7zXgKsslguiMf
 7HPpZL7NucFm68MHevPOIgtmSTe0OPpsAKPIPX0AI/qHUM2AGUSmravTPy9/ol2HXvUDgVqC7i7
 YdkGQHFWL2fSA0ATCDSBzr+PBZYBMwN487icHbHJI3iYGpLwAV3O/p33zVINyTcwbSE4HG3ZjoJ
 k191peHP/wQy570AvO0S243QdB4i7kVWOrMY0PELHSiQm+SDrGS7Rj3VoH+XmJCzH6UDb3EsAyY
 ig/yjCLRUKyP5M+mFf3kpU4aef
X-Received: by 2002:a05:7301:4e04:b0:2ea:ed29:5a73 with SMTP id
 5a478bee46e88-2ed3e486dc1mr126967eec.19.1777503167418; 
 Wed, 29 Apr 2026 15:52:47 -0700 (PDT)
X-Received: by 2002:a05:7301:4e04:b0:2ea:ed29:5a73 with SMTP id
 5a478bee46e88-2ed3e486dc1mr126951eec.19.1777503166949; 
 Wed, 29 Apr 2026 15:52:46 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c07057csm6291868eec.18.2026.04.29.15.52.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 15:52:46 -0700 (PDT)
Message-ID: <30ae1194-8c77-4f57-8aaa-8fe74bb893d6@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:52:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/17] bsd-user: Add FreeBSD tty ioctl definitions
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <20260429-ioctl-v2-1-288639bc2427@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-ioctl-v2-1-288639bc2427@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: F_68hRXgAbCasesIXKby-EABuQuKsfpC
X-Authority-Analysis: v=2.4 cv=A4dc+aWG c=1 sm=1 tr=0 ts=69f28bc0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=CNTGfkPRrCkcOj8_CuoA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-ORIG-GUID: F_68hRXgAbCasesIXKby-EABuQuKsfpC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzMCBTYWx0ZWRfXz/Pqgkt9/S8X
 jk00F2IQExV7Njgw+MGEtE12XxhMWlR34x5CtkKHaX4ykTSKx3O25SqYMt8y/b7e5VkYXpM2R0r
 7+F+/ka+EFC2gFozUH7TF7EKc3ss20lhgbcAQdfvgyYeAidnpatcJb7myLlcTqjQ6kuo3bnf5Y2
 oYBQUGazB6JlwVZbXGKNQ4xpOJYmjeruEaLUUC0FLgHZjak5ABvhueBU9/dIdutMO4I9NPDgYpC
 1jQ4TIDwbuPc3sG5553C7hZmU7h3XB+QGZlKKoejQXUXx7FUyppyJEv5RKluBGILG+2tfg05XC6
 /JesRd9vSx1reCxn28qh8APXcLmPXQWMGd43XwZbmET9F3sWMsvtS2J34p6iUXve5ednwwn5w34
 Brt9E64TB6CbVQnVDBHbWTuhsofDeJ4T7DV83uOxD1tCiWRLgnrhIfwA8shKaNEKPhbiLZbzY05
 Qoh/JfscMTnxM7cEMOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290230
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

On 4/29/2026 7:45 AM, Warner Losh wrote:
> From: "Stacey D. Son" <sson@freebsd.org>
> 
> Add os-ioctl-ttycom.h with terminal control ioctl definitions including
> TARGET_TIOCGETA, TARGET_TIOCSETA, window size ioctls, and the
> target_termios structure for terminal I/O control.
> 
> Signed-off-by: Stacey D. Son <sson@freebsd.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/freebsd/os-ioctl-ttycom.h | 237 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 237 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

