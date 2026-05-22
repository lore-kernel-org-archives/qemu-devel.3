Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7566CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQYcj-0007Bh-2K; Fri, 22 May 2026 18:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQYch-0007BW-9I
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:45:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQYcf-0006PL-K6
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:45:43 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MGalEU1733014
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 22:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6ewi474XBRhR4fGUapy8V3M97lP2hEuu1GyQQJDeYfs=; b=FpxoRCLnJmbE4My+
 XUa8U1GyJMR1p3SuRGxiEFUAQSlB+UOJsmCiP1AAAAHky983/jgSHbP84g04QJ5h
 uPNwpQOsB0FmFpmZp5Ese0yrSLDmhbznAv56GyO6tv3sAcHrAJsCOSc2695kq0ro
 9UDqo/T+dWPysE+5cMAIdxhWt45TCwtbCUKkh6LPSTIP3QumCQ8tmtYwNelEstTp
 5uImpqTZx11OTmE4OGohoDXPAIo7JW5LdaqRgUTomscj6XAHPn1BzGwKLCB3Zexk
 ch1l3XzP/kcv/TWGIF908fKGp2sh3UykQn0BjaX4UTrbkoYcT+wAy0cr9gy+GuIc
 5QGsWQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eattq94u0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 22:45:40 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-135de949041so6546708c88.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779489939; x=1780094739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6ewi474XBRhR4fGUapy8V3M97lP2hEuu1GyQQJDeYfs=;
 b=Xhe4yFnJ/yBxNQExoFGpzfH6i7wKJ7GK0W442RhKQRS45JIV9S9/ZMy7BIvVAVKtDW
 YfFLtGsFaALFxhWx9HdoPvUNGpv4RE93fhEiBRUEHh7yqaazOYQ6tQfm57U0DcxSGpZZ
 IyrWAbY1MTX8koeTtpL2dhOEd7LN0tzVagwt7Z19R9Zfdr3hOqvvRE4wa1JpHRsoLF+w
 AwuDtyGDbkjccuMKhG8z2kNz0KR5VAJenJUI0ZfR5TTeFMU7RWX13J5U81dV0pktDkcV
 9nvatZJeiLIuPuf/nD0jDoRh/5KJpxs6RkJGHoeyo2+aJDDN4c8Xkxte4xfflm9e4J9S
 WcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779489939; x=1780094739;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6ewi474XBRhR4fGUapy8V3M97lP2hEuu1GyQQJDeYfs=;
 b=lp9MlIEzEMy8TJ4oy9VihaFW5GIxkSVxM91UF2pg3vtccNVB+FHXzZ1rRlF7be9Rlh
 ZI6mj3wIe+9jL83u7K0BL93eHdQQy4eF+ghMF7bZOvxECOxQksGelyLXVLRSWhFyB+RU
 XvRhJfmaszG/N/MjDBYl/bLm1aZaUdfVlAnb6biH9Ghcod5wrxgYm++5Up9NtF/vvlC5
 tXrQP0ATu1xAFmuv+X2OKnTJ2mSR2f7dgvSZxU3fiijB6Ou/e24n/xDzADu6EFo7XJKG
 L9u8xT3lz/uEHMv++2q093zKjNxiJNEk+zSHgR7kmisgY+zUG7cbLqxw8gc3zWjJMb6P
 EJnA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Rhh9l0MDuBnl6fNvQw7JPx+9G/z5/3gBjNo6HgNL3CTZXo2eUtrwMTiWal9YdJTCV5c7EMhwxfBLf@nongnu.org
X-Gm-Message-State: AOJu0YzrfJ1u0I8KyLtcB+jCKYebUWX9cfJlU6ImIEE17y5OGNZfnnpE
 fsxDSm/U0MA+CFotkphxR/d/8KdcJV5jv6GWmlTf6sQyZ0fl1X0w1tPPOfSTprbk36s94PJAC8x
 w5NcjDYctPZliSG7GIBQanNSBxsDFfIAucHWEf6ZPpgfFfhKIi2LU+DTzkw==
X-Gm-Gg: Acq92OGIOZi8o4CkkMNvYCAozHS5saphmm2bWico3x65uQcockBNYN10rp+/ByINuGo
 hPwgQn76VQcRcLn0+bszzmpKTgIxzl3+KZxzS5i+F75UclwPsj0ujR8ERYUyFaQoxTa0AnZd0jo
 +eKFg3fV0dNhJQ/HcyymM6LcOZfgq5oOEwaU7VGEuyc4gJ/GTyX2dvv9w13aw4U2etSWFYuhWW3
 mQAsumcqv6jbo+29ZVYx7sn0YkdfQUeksg74iSAGTA3rPITaIg8J8hKtzQ6F7lDtdL7IAFZdBnj
 zLFcMzQr3Afi0ddkZbHvsJGkYFuoyNPVIrXo3387Xqt6UnPm4unLAtpf0Wszl1hezBYvr+i27Yo
 ECVwFz0EAtMfEHNQnNf1H4rnCM5tvInZPg12UIO+U2MyFbykI+jrxN2VrmmmcspO8sErH5gMQcY
 sBDMblZv/OPg6pCA==
X-Received: by 2002:a05:7022:2212:b0:12c:44a5:fb4f with SMTP id
 a92af1059eb24-1365f6fc55fmr1934276c88.10.1779489939062; 
 Fri, 22 May 2026 15:45:39 -0700 (PDT)
X-Received: by 2002:a05:7022:2212:b0:12c:44a5:fb4f with SMTP id
 a92af1059eb24-1365f6fc55fmr1934269c88.10.1779489938506; 
 Fri, 22 May 2026 15:45:38 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a3ef099sm1952456c88.4.2026.05.22.15.45.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 15:45:38 -0700 (PDT)
Message-ID: <ee2c2139-11a3-42f8-a266-d43ffb9a146c@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:45:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/37] bsd-user: Add signal system call dispatch
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-5-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-5-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIyNSBTYWx0ZWRfX1HvyfLs+dHVK
 D0Ttns7iIhMYAK7MlmivUdKD36ZnlQvCxw7tDCqih3/u5i/Kj5mY/P7Eokcjr1Are+axWe4HEkS
 xCRDxUAs2Nq6vPXWTlqpJLV+KpYqxZIT6h/2AoY/OrdbVtWkzTtvkKuwAth/dcd75YZjwmIu6dT
 myAIIA/QRbEQN6RwrMomUnCGL9Jc6guu7xsFJ0i7dla0PqBf4bq4kXbd4GMRH/jiszt1ZVhmGcr
 fpcNmfAAZnaaifU9hF9qplj+OlJGS7XSeB52S98wMlTcMhhXdFod3TPoq3JiPrQp1KsBFI0IG+5
 N4zWTlNA46hJjvC4yZUegDRKrhpV1Y6ceD5YPmx5dwp4Ei9S9pGGUZJs+6fLCOExGYQ0zgU+oYH
 YoIWcOS8UIQaOo8peYN+LU8LP+58mvGZ4bD0xk9K96wS8xvYN3VlEOTqBA8a7rx7x1v8InmlksZ
 b3TK5eS9M9K1Qp3XLww==
X-Proofpoint-GUID: nVfThet8DrYPF3fSLgKXVG8J_BKaeRgw
X-Proofpoint-ORIG-GUID: nVfThet8DrYPF3fSLgKXVG8J_BKaeRgw
X-Authority-Analysis: v=2.4 cv=S/zpBosP c=1 sm=1 tr=0 ts=6a10dc94 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=F_cuf8XREBoBVlO7HCgA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220225
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

On 5/18/2026 2:27 PM, Warner Losh wrote:
> Wire up the signal-related system calls in the FreeBSD syscall
> dispatcher: sigaction, sigprocmask, sigpending, sigsuspend, sigreturn,
> sigwait, sigwaitinfo, sigqueue, sigaltstack, kill, and pdkill.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/freebsd/os-syscall.c | 48 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

