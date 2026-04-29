Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A958FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDwt-0004cH-44; Wed, 29 Apr 2026 19:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDws-0004c4-6T
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:04:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDwq-0000TW-JZ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:04:05 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbk4r3203482
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YiPw9t06smp/3niIbpzodDGXxTn8teJ1hDjW5pUWHco=; b=Cc/dm9NRHNk3s/kf
 EZVMfDcDWpwLyRmXhkNjSEDboyyZvVfp/A7IHsvbfHqFLRBIu5BzUHZm/YJE5lpf
 uHYb/wWA3iZXI6Yf6pI40fPBCCo+W2FPjBhIBqRYQTwt1mlLSCwJe/kTjWI3nIuT
 zvD/GS8mHUsMk63M3qOfL9NTuQepnfRQhD1YzPoWLadlXo/L4sDRlP1iPSXikXdu
 H+BsKxIlpZjTyyK+FkyRS5g1foJxmpMuOg6LFqPpFC/oqZjlebFZCDwAP/c5BlO9
 2bSnV/APiIVFjw8WdPbqbZwSLNAOpEtJnDqX5R8ZDt6Y4ddGXhOf+ikVmmso5TsN
 1PDnJQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ducj83sxr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:04:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2eaf70f3b5fso434488eec.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 16:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777503842; x=1778108642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YiPw9t06smp/3niIbpzodDGXxTn8teJ1hDjW5pUWHco=;
 b=E5n10V9Rc5rbuG/FqkhQ9kOPq4cgAfnz5Zd4kaHVgTc3TcPA25wzCWsmVLugdmwZRz
 N59YTZ5+mE+4J7zHSL1J6Uugf7YrMpIrHZVfKObql2xjliVnnL76Cq+COxU9EBkuJ7hE
 j8JaJsAfy8VNaPC9d3RAOt9EW9lU1Vl/bK7y26d692AvZiemKPjofxZaKBd11k+dngLT
 2pjITM1spg6u6iXy0g4XOH2SPpWTabApzyHyhtMB5XqHMtA4rgYmOhP5AOYB15niX+cc
 lqUg1j+t4AsN4QvEXDKpf+g4p60n3kLfI/ANxLrt0Wc1Z7d1uWEj7grqrB07JnJFewIC
 yzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777503842; x=1778108642;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YiPw9t06smp/3niIbpzodDGXxTn8teJ1hDjW5pUWHco=;
 b=O60nwtfoN710gQvBWiXMl1ry5BEihEablSAyNVnbANi48SuoAOG1y5ndP0K+g4O79u
 55/cpzrurFuTUjAZDBClUXReQUrBUoJw72y9p4BjnZSOGDASlkewtO8gVaBcuf2asNg5
 SdohTg8is+WU/q4aKkrsBzomPOg25XgZxcHohBWma2Ip8fbygEiNUE/yXjsd021F998F
 3VStd3/HOKEKzfPUqYD2DYcu19NIW4zASVBsjXNtfFc28KYOsO+xyrE6+GtNRvzu6T/f
 u1bxuO10+rxhxgPaXMzlL8aLCJT2t4mCBeuJopXrXIzSRrAprxjwYgP2Wb268EyU7s5b
 EeVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CzUqBMK03JZm7ZfgVZjHY6h7qBhU02XRrQPBPIgs8cAdwXKN5R//3JsWy4W9E+DykdoLF3soNGP7A@nongnu.org
X-Gm-Message-State: AOJu0YwG681nLGlScQnw78I24wHu+l07F7UR22SnLBxu/QtPgBaqHp9c
 HeKvQsQweVkSHWMT6BaNPYFg620j69VMKpN5suLvH4lSGsp4FjgiHzbPr+nqK14yEuICChoFsUi
 We5GPdhnFBu8nMGJwV2yRSvlZeJ+k9VuAjQlGHZqfcEG82XgUqoyp00sL2Q==
X-Gm-Gg: AeBDieuBQfB9PO4lbxewZWp80v/uWOs4iWjzmSeyRkIW0ppvR8n7iAh2/gIa0GYsDPB
 /zJwBarPyiTutTCJZMlxlNt5YZH2fI9T7HauInrUVRyEfZUTO9eRP3c6L0anGx4G/J0vpdYoDwT
 VdedKHTksO9IxE8QiwYSdcdCGlJCJtHIBniT1nl922NGQ/C5xqeUUgvW/9qatBpjh8mbSSvQOWk
 cyzxayvF5Ac0JwkS1frVqzZzjO0jOBit+0ZJGlHlK9K1wAFyH4AQj38BSOG8wL/oOe252LhoMg0
 4qwJAD/RjQDTTuMWOGKvo4nwENoSP0d3rj2AAwCHp9MQL9TCgLG4WvuYxN/lRp/0xmkZjLJLSvY
 VSIfCDgm3/XgwDBiXpeyDua4VeKssfClG/WTYhki0nJHgqtp9Z03fM+xT50j722TLegiyCM6n/0
 3vnCKWhJrW27G0+dbtlAfagsLx
X-Received: by 2002:a05:7301:e0b:b0:2c5:50fe:c78f with SMTP id
 5a478bee46e88-2ed3c7c823amr133132eec.12.1777503841816; 
 Wed, 29 Apr 2026 16:04:01 -0700 (PDT)
X-Received: by 2002:a05:7301:e0b:b0:2c5:50fe:c78f with SMTP id
 5a478bee46e88-2ed3c7c823amr133101eec.12.1777503841150; 
 Wed, 29 Apr 2026 16:04:01 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bfa6766sm4200860eec.13.2026.04.29.16.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 16:04:00 -0700 (PDT)
Message-ID: <ffda5056-fa88-491e-9f2c-a71dda602368@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 16:03:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/17] bsd-user: Add do_ioctl_in6_ifreq_sockaddr_int
 function
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <20260429-ioctl-v2-15-288639bc2427@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-ioctl-v2-15-288639bc2427@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QTwxjDWovn0_-SVnosH7jW0IAHB9kqQd
X-Authority-Analysis: v=2.4 cv=RI6D2Yi+ c=1 sm=1 tr=0 ts=69f28e63 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=kpqsSCUBY61UU6rk4iUA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-GUID: QTwxjDWovn0_-SVnosH7jW0IAHB9kqQd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzMSBTYWx0ZWRfX2IQEcul+vtKa
 bpg3DKRTJiyFgRwKavee4LjpDvbcu4o0iupAsO+vfm42GU6G0JzlORMb78ZDiW1/CVzXlcSXbL1
 uakKr0uUEZ48XLO8hlbiv+zAEMXBBRi51GCy6hWZUxiV2BQMNFVzfogK6AIBxzBZFzStLbve7Xo
 b4ezgYOhtGiTgR1hyo+oIP1fdo5YdceV8Uosb+MJK5u2fxrqxRMvgtE6BqDwiHu9yl9jxsYupV9
 3qRkjdkkDBCejZRJ46oJilHyspcEg8mZ1ylbyGAxfAY7six6vNgeFLEpZEHpnj/4LOqDwPYPJMq
 +F1jGGZD5H512TKqDLfT/fNELk5LqcBQvYwFHElpvzYwdXokZpzxXP+1qqSv+6wmH9hhoO9lO23
 jBAxZK6Nm+/CanHqUxjO/bJQ8EAxQCfAY4KGTPkWd28+w4/mAq+vOhn/OFDfBi+vpxvlc51kYyK
 aXCRHLHt7EZmPRBysfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290231
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
> Add special handler for IPv6 interface request ioctls that take
> a sockaddr_in6 structure as input and return an integer flag value,
> such as SIOCGIFAFLAG_IN6 and SIOCGIFALIFETIME_IN6.
> 
> Signed-off-by: Stacey D. Son <sson@freebsd.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/bsd-ioctl.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
> index 2ff37a0817..aa0153bbaa 100644
> --- a/bsd-user/bsd-ioctl.c
> +++ b/bsd-user/bsd-ioctl.c
> @@ -262,3 +262,35 @@ static void target_to_host_sockaddr_in6(struct sockaddr_in6 *hsa_in6,
>      memcpy(&hsa_in6->sin6_addr, &tsa_in6->sin6_addr, 16);
>      __get_user(hsa_in6->sin6_scope_id, &tsa_in6->sin6_scope_id);
>  }
> +
> +/*
> + * For ioctl()'s such as SIOCGIFAFLAG_IN6 and SIOCGIFALIFETIME_IN6 that
> + * passes a struct sockaddr_in6 in and gets an int out using
> + * struct in6_ifreq.
> + */
> +static abi_long do_ioctl_in6_ifreq_sockaddr_int(const IOCTLEntry *ie,
> +        uint8_t *buf_temp, int fd, abi_long cmd, abi_long arg)
> +{
> +    abi_long ret;
> +    struct target_in6_ifreq *tin6ifreq;
> +    struct target_sockaddr_in6 *tsa_in6;
> +    struct in6_ifreq hin6ifreq;
> +    struct sockaddr_in6 *hsa_in6 = &hin6ifreq.ifr_ifru.ifru_addr;
> +
> +    tin6ifreq = lock_user(VERIFY_WRITE, arg, sizeof(*tin6ifreq), 0);
> +    if (tin6ifreq == NULL) {
> +        return -TARGET_EFAULT;
> +    }
> +    memcpy(hin6ifreq.ifr_name, tin6ifreq->ifr_name, IFNAMSIZ);
> +    tsa_in6 = &tin6ifreq->ifr_ifru.ifru_addr;
> +    target_to_host_sockaddr_in6(hsa_in6, tsa_in6);
> +
> +    ret = get_errno(safe_ioctl(fd, ie->host_cmd, &hin6ifreq));
> +    if (!is_error(ret)) {
> +        put_user_s32(hin6ifreq.ifr_ifru.ifru_flags6,
> +                arg + offsetof(struct target_in6_ifreq, ifr_ifru.ifru_flags6));
> +    }
> +    unlock_user(tin6ifreq, arg, 1);
> +
> +    return ret;
> +}
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


