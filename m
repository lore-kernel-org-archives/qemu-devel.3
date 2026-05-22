Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C29BCD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 23:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZg3-0007Fh-KL; Fri, 22 May 2026 19:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZg1-0007FV-CC
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:53:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZfz-0006Jq-UA
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:53:13 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MG0Z1o3476953
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tQgwuXY1e0v20MW698VgZytCoQ7ZaaoVFKM8YBoRzNI=; b=dYqT0gjAq07qOwEC
 QhCdq2Tk6NgxbCIj1R+qaDyKiYE4e+Oah7orKxW0WOIpMlUYS7YdJF2NdDs2/4lD
 ObUbJ0LTozrY9CaKDxNJ7nJkQ+nHCXHu9TJHPMRVTmG/n6HLFU0VUrpePv/Xx9SE
 baFomKzbQ1FjjayEWfphoOvfJGo8hzxp7ysmYRMUk33rD/4MzPOnSXV8UXMbPX8+
 2WZvd4b789HtoYfX0Hr++nXomFWB505DRzNVsj77ovMvbq/l5J3XWsDug9r7TJlW
 avV/yI8eCSlJjVtjUUmv8zbw+gf7ZZDyZ2DxAimq/hOU3GoNOHWpGe1BGmdQN+xR
 HirnWg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eat9r9d3r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:53:10 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-135916eefa0so8368773c88.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779493990; x=1780098790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tQgwuXY1e0v20MW698VgZytCoQ7ZaaoVFKM8YBoRzNI=;
 b=GtJV6iu+dQ43h1igWUl0mDkE4ytus9AcR+puKzwsf3vhVybUjs8MZGjz31MqFYdh7g
 1wrXM2IMHHKtAIUvAahsiSOPjgHSbD1QNRkafHycDDFW1tfmvNO4TKSLpYYDQ77yYdP3
 jmbEabDVf4JLlaGAVLfp97yp8z5b1whMlI1UfZ+sByLTjkRINyHBH3uXUa/n1lXAB4Jj
 CrfnCc+S+ZNx3atmYLpDCOQtEufrwVksRgpcHXXyncy2ONiC5yVSdy46x7vcKOzbnnoD
 JGSCK0GZSFVYGHxR4w/6utOMvmyK3hD8xjLs6GPFPdXgg6VjrLohfuMDCSLpDAUJ437o
 ltxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779493990; x=1780098790;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tQgwuXY1e0v20MW698VgZytCoQ7ZaaoVFKM8YBoRzNI=;
 b=Hgx0L8EZ7eUr3RNilWDs4dC3q6iUgoheyxiVjmJadMr6EhK+Ibg3SaX8bVzbficjNW
 eP7oRCZK2zno1P2zIzyNRiiH9juns6/Xl7tVpPw9afYQKHBytF17HluXbWWK5I/g4/V8
 8jVQZyb8RQgfg0nLHCrCJs0ipIGgbFtBUcFVsx50LJkwuKzh9EjC9Cz+cM+ZS0LF0yFO
 2uRxfd3Do1yj0jc9QrT0SPOxhxRtbt1HAiO9NLsag5uUi0WK6oi00GZdwoz+B5mXeTyq
 se1ZxWur4qzS1S3okOlU2p3ifPavHnA5J1+daBo1s6YjxeZWi87rKtUVftMAcIOFtwAX
 yPRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PoIvaq9jh4Rb7dhiQVSnLSfIPnjdoiUz54v62xQIy9my3IoryJEb2aZ6d/QXsLzdlzmMDQZSyePas@nongnu.org
X-Gm-Message-State: AOJu0YyGZtmveehMMKyL8x/ITxaxG1Yk/pHS0BVgs4G9MduFode2wvcp
 jZZHQGCfhBT72fgA6MstZE2zQHYarhuV3J0iJ7a+WRzsJS9wI8aF1ba5EIZxUImm03bhYphvwh2
 l7ZeX3tSaivnmc+mCaot9TNcI37QyNopBXtsm7PH9s7tKmpQ7INqXZGY9qA==
X-Gm-Gg: Acq92OFa6twpOGga8HpewarfBa0WVN1Jf2S4lMPF+0LVwLqVk5WUxUOrxfbbhMO+Od2
 ZFopupQ6cXdNsdf7TZFK/dmEYYA+sfHHQ5IwigZJ/podEgP2SnL5vuWA8TkhsWsu9pNK/JnKvRd
 NSfeDQTbuDxe3y1EAVzvIWPaXf7u62J9DMzsLMAaRDJnN3qtiaCv+3iHb4pKV9wUsIqxWapMyfn
 WwpLWY6VLhF0qvlVW1qJJeIQvnXkuQOLF7ts5+uEkdAxlWC3lfkbsEkf8QCxvIQ7Y7tZHzpuKsg
 1pE3poz+QwYxnjkwLv22McgO0a4+LhksKtIkHWntWaCOaOpEK4gHisgOC0ZjsMR+A2CgO3CHEMb
 GDi51kKPQKHWzJPt3kouGPK74vvbaKO3vtvCWO2RIR+W1UWhfqCvRPgQYXB9l2q+nN5nVPuYKym
 1WRPpXIw8JcuiW6w==
X-Received: by 2002:a05:701b:2213:b0:136:6d82:18ce with SMTP id
 a92af1059eb24-1366d821b5dmr977069c88.23.1779493989897; 
 Fri, 22 May 2026 16:53:09 -0700 (PDT)
X-Received: by 2002:a05:701b:2213:b0:136:6d82:18ce with SMTP id
 a92af1059eb24-1366d821b5dmr977062c88.23.1779493989328; 
 Fri, 22 May 2026 16:53:09 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a4011d9sm2101524c88.6.2026.05.22.16.53.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 16:53:08 -0700 (PDT)
Message-ID: <406fbc85-1541-461b-8a4e-ace549563d1d@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:53:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/37] bsd-user: Add thread, umtx, and ACL type
 definitions
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-24-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-24-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dt/rzVg4 c=1 sm=1 tr=0 ts=6a10ec66 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=F_AVDILdZqRBnJQxlSgA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-ORIG-GUID: tkvuStU_o9d8qzRWd5rbKPY9_E3TKGuV
X-Proofpoint-GUID: tkvuStU_o9d8qzRWd5rbKPY9_E3TKGuV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzOSBTYWx0ZWRfXwGMzCxOi8UxY
 50tI3kSYL6wKVnc+00hZMVwjPWsrGE7TBIonP1awtTDwuJN/HYoJwdLTwTpnsZIVSyRBUtZ0wQU
 sTUEdo7hfiVKmrdbH6UOuMYpTX5f/EM8IdGNwipxMyNm3LJ9Wk/dT6WLFbslQ8KG/v78Ryemz4e
 cyIIE3dj7nwf8N/29GHRMFar6ZHWNr+R6t+kQkLpKRZ9ULhaCXHXNR3puGxJ4piohdrjS6XC+Jc
 lfBxpMGIdZrMcIs3GccqOuVQCeVuauf6xETXIFXGeq6ECbKHhr+C6l5sXln2VOuJjgJarw8ltnx
 3O+ioYiaWnbqkifAKyPE/sGpF/N3O79mSGWx4DUiBPMbEsc55DWRkwTJZg/6UolQutBJy6gj3wi
 GdTEZy+ZCYjVEkjzl/NPq4Qdque5bh/QXQ+xmJ/sryxBf9O3SZZV2lYzFK+vtWUJQQuIgf6o2QJ
 WKzFJl7DmuKSCBqm9aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220239
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

On 5/18/2026 2:27 PM, Warner Losh wrote:
> Add target_freebsd_thr_param, target_freebsd_rtprio,
> new_freebsd_thread_info_t, TARGET_UMTX_OP_* opcodes, umutex/urwlock
> flags, and target_freebsd_acl structures to syscall_defs.h. Add forward
> declarations for os-time.c, os-socket.c, os-thread.c, and os-extattr.c
> functions to qemu-os.h. Add thread and umtx function declarations to
> qemu.h.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/freebsd/qemu-os.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>  bsd-user/qemu.h            | 41 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

