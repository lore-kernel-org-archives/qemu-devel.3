Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA24CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQYZY-0005N0-UP; Fri, 22 May 2026 18:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQYZY-0005Ms-0m
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:42:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQYZW-0004YY-Es
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:42:27 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MH6hLt1800728
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 22:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zVs9j+uZjzdZALuxD312YmHr7x+Q9ygCpYJlPQhUQ8w=; b=FWFLcHw0kq4bA25c
 iQupmxjz6Vha1GTOnAEUGO5BArHjanIDnuuZNKoqK/ZtlgO7nYGzNCpy8O90PVpc
 6j9fFAKlCUuK5MKn98P6FwMFe8S5tXwIU930jB3BmDHHFJiVl84w5zCML4UBvXni
 WG/FXzv9UCUDegYDROZqp3IVR6C9IOoR2vvw7ByCKGYKjItMJUildabo90tir8Et
 ewGRtuHMW0wgeUBIYCi0I3CINa8sLFWpyCp7aO2DoOa9x6KYSk58wTVtmw4AlXLk
 XrUG2E8HsLgdBx1uyg/1IPgbA8Agc1ahzpAlAJk2O8pwrhktzwFAilMSyvotZewv
 d2HjTQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean9g2kh1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 22:42:24 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12dece274b1so10443750c88.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779489744; x=1780094544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zVs9j+uZjzdZALuxD312YmHr7x+Q9ygCpYJlPQhUQ8w=;
 b=FmdXgqkuSZ7jnguj/Cn4LBhZp4+XrPwrC5d3GKOyVSsWIxVhlrjNz9ujzyOD1/7r6L
 oqC3IFA1tDfcsP+P0XyDido99mIH641UqljndCNUsFlMXN+M/UYclbMWlu7BlOVlNn4U
 KSVqQ91ayXQmY6ZLNydpoCCJtdQlx61yTbGFBcAWRboDJhSofjGVCZun8lO0yYMx2eNC
 qyQ/wNN/CWz7zAjUco5yR30DkI8Q0QQHFOJziZEg//kEn3WKdKn1SIhlJk2YD1y48fAS
 O5PWy/hQIYkB/zNZ9kOW67RtArc6sz5Wa6l7q4Z7MkYnrv9cKy/yi0BOLmKx2sA3vyQe
 SV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779489744; x=1780094544;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zVs9j+uZjzdZALuxD312YmHr7x+Q9ygCpYJlPQhUQ8w=;
 b=E9Qhk09goZOsRbLMBFUq+QoJeXfguC/6Z0+WorreQLDCgkyv05HGxR9ozrs9/z4FnW
 /F890myJFzUyAIrozjrJd9U2Qgf9qZUnipc4+nvFR6Sv9twTc7P2ti1cIxBEcKbcLpRI
 zB3Sn6zRGJXABcbb4/ogIefZW+YBf+wY25Nmb67qe3a5qoRFYur8prcMwvQSqd6cMJWN
 k/lHQsP91D5g1gT9/1tRDgZmk5bBIellCnJWnSEf1qu0sDUtsybNhVIuznbtOxOhST7c
 zCNgsR5eEY0rhpGem5cGKyU/ipbmrBvtZXdHirt179cpVtMk9l0hJSRi3vaiEweGCAH+
 luCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8L+eajus3Ju4g5XdsSz7XdkaFL3d1783gBrZ3DVegJwqj+crt+Ft2CFcLhZoSL68vVn37HWkCw7VgO@nongnu.org
X-Gm-Message-State: AOJu0YwM4M7HBAcxf9UjdG2UatCtMcL5ESfnY1iMGuEHGHLF7+Amvl1F
 3pYoJvBqraVxFItp5GA9uU8rOzeExmXu/fIIQKU8dZDFeRwru46d0LewLeEfuYxwSS5T3D8Vwiq
 mISXf6F++io4TnZ4h5dsqYpn/5X6WbVx2ygW3hthe9qE3gC0j0ecjV2YrbzJ8Iyo6Fhvf
X-Gm-Gg: Acq92OG4I2Dj6Xidyro8Zt/tmAEYun1Pl5RlsH+t53gtBd8nWFq+AeKWxzoXZ6SoDg/
 W+MvHDvdZZcGxoeZuk0Du4i5AuwIg2QaDjY2mvKrYm0uRKv1bddyfZgY9KDnvsJO8gRVIhYInBU
 hX8WFaziclGaszepurrOZdvGU1VdbQYKMaPeXY38Lbns4MuKxGoZKk9N2kkDjL/JCQsOG7uFjZX
 TgCkZg9HGGpwP5/rv3WZHOzEbeXC5PHsfdPxbWOeic8stgr73X/a/eGu+idXU8CHqVYzecBetTC
 bXGcko7i8bdz7axkFeNzzzJPgA7cpNCnxpgISe8WpZysiCFWdX1QwwodXSh+fTF0fqLRfH+MQDI
 c9aWSNMkT9eaKpXtEyDbner3LfnP6nb7YkuOYkOEgeAhekzgJgSLBwcVpR2d3nr4hbsEPQ6gSpV
 vmgZkqC6INp6p+BVnjbYqbLNL+
X-Received: by 2002:a05:7022:258a:b0:136:4317:a163 with SMTP id
 a92af1059eb24-1365fa35574mr2043634c88.25.1779489743929; 
 Fri, 22 May 2026 15:42:23 -0700 (PDT)
X-Received: by 2002:a05:7022:258a:b0:136:4317:a163 with SMTP id
 a92af1059eb24-1365fa35574mr2043623c88.25.1779489743426; 
 Fri, 22 May 2026 15:42:23 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366aa88cffsm1691387c88.11.2026.05.22.15.42.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 15:42:22 -0700 (PDT)
Message-ID: <bc7c41fc-df61-4d68-9ff2-0e2600ea573f@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:42:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/37] bsd-user: Add signal shims sigwait through kill
 and os-signal.h
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-4-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-4-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fL5TjlhNvH_ZAIxbvjPK2C5riqob5QUu
X-Authority-Analysis: v=2.4 cv=B/qJFutM c=1 sm=1 tr=0 ts=6a10dbd0 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=F_cuf8XREBoBVlO7HCgA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-ORIG-GUID: fL5TjlhNvH_ZAIxbvjPK2C5riqob5QUu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIyNSBTYWx0ZWRfX8YaYRjxvdxmx
 yO+SBdna5uG/5RLhKbHCtkGC4XvuoTswbeaI5Rx2BGS1nNXfpQZY1SNzN1Roay/+Gbh4Cdn//pp
 fpfoZQDHxvVo4s8jvPK9dsXmOsKXAmtkIyp/obWZOjfeBb+1Iz09AZmC1iU7Fe/p8upCnVuMjq4
 HGJBa1CmikVSA2a8r1JEQYVwOt2HtgYRQmYlo3FAJLy0WE5mSz9ktJ05heeyF53jboOwNHQutQC
 Qo6t2qT45RqPAYMTonZC3RAJX1aohMH5FRxKifWOfs5toYMzBi7Lp6SDJOWJQ/ZH0alfXghfYh+
 QnuD2Ti4DyPcJDp6P2bnhwHMx/kC8WXcOSUep/Zo/A75cGK9RtMglCGAZOuWD1wkUTlGdaISg9Q
 AeH+QABXp63oxbkzdH588FMlxzQ8l7h2T8tkpjgfdChqZipUmVU9wkAMF8Dlv7A9v0XKE48QtOO
 cPtTTH3vufPuvTcueWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220225
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
> Complete bsd-signal.h with sigwait, sigwaitinfo, sigqueue,
> sigaltstack, kill, and killpg. Add FreeBSD-specific os-signal.h
> with pdkill.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/bsd-signal.h        | 80 ++++++++++++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-signal.h | 20 +++++++++++
>  2 files changed, 100 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

