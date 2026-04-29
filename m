Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF82FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDlM-00065e-B9; Wed, 29 Apr 2026 18:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDlK-00065U-A9
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:52:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDlI-0005iy-GO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:52:10 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbMtL255422
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Gnl4f+d+/vy/3242FCIa2pV0tKFWUgI7pgZEic5fd7U=; b=J0BKGwf5fUlwjz3w
 MnWHvGDTZgu14pr0MYdwVPfpFgtxA4lj9gTRAo00Y58azA//m6pq/le52o2Zfi0J
 xCPzWFalGmMP7egeKSUKCpj2RMBthqWXNLHM1+IChI66Iakd6ofnjaid64nbNcDa
 nju/s8dm+JnmSOT3xByFedp3rLWeOJDYwQw3DeEZE67JVOZhjRfkbePCOZcinv2z
 WIxDZ83XgZhH+UWmkSX9HnhQEqjSh5K6Fd6LjQTq6j0WyPUcl4fxQW5VEBRaxL/h
 vmELmbhbCU7dWKkPmMOsnsM7b6PeOpCzqUt2IAii61fcoeqYy2d7VtKDjfFKTq72
 KXQZdA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dun71hctf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:52:06 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2eaed3d96d7so395314eec.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777503125; x=1778107925; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gnl4f+d+/vy/3242FCIa2pV0tKFWUgI7pgZEic5fd7U=;
 b=NH+I44F6yQRCrJi3upSkrW+g5qsNUQx0bF0lz5Z5coSJMHc56NGH+d3cRWQAkHqr3q
 m/a71TS2GJbko8NYR6EPwvy0wcuEwPhhyo4gGB0BXsq2Z4dpWIPXV+YUZFGSiF47VzZ0
 oPGO62YDKju3tl1w3cIsGP2QGQZLiL2m7SpvWZhl5YIxXsyv31BIWrKZclmJMTlOwiAW
 6eSBuTwHq6sDmWk5ehqb6PRimJM9VS2BmDMqyyBX9YYcdtYmJ/YT4n1P40fdJGs0SFHb
 BB1dVaUe7XffGS5DBrOQo5vZMuZL24dIL+ZDk0/GJIQZ0e1e3BtO2OQLW1bZDOJFRTzx
 3j8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777503125; x=1778107925;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gnl4f+d+/vy/3242FCIa2pV0tKFWUgI7pgZEic5fd7U=;
 b=pYIx2+1Ubn++hcBMm8wWDkjjzuBz94w1ktVE0ZOgMIzn1enb36g3kQrHfZYo90trC+
 J8cQxM5GoQHKalqQTTfxKpolmdLLTC0ILO1d6VxjxD2BVkFBtjLr31cWYsqzAq3afSqV
 Wx+mGDBgORzD9PNfbnQhOCTbw7KWGHckQLu5aITsCPMwtMIR+8NcW87zIxhJj9w65GKO
 yd/M37cn349lpYS6izk8qUYuGV8dmpd3aynbN7Hjz8CCD/9b+kb7MNvFWQRgMTSfSUee
 tcbA+dcFoKmNxFFjyKLhJcagP0u1aCnLvCYgYDupAdZ+MrfW6u0tNdv2qgPrCbaZva44
 lIHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/x9aS6PzQWglMZfDd32MRLdLFeHiBhCyGyoATmmF9VfdZZqtH4F8R63/BLykomXjQRud5/q1d8CYlw@nongnu.org
X-Gm-Message-State: AOJu0YwNNuvING2MnR1hIUrX4HFx2o4oNL1qb8/l59JrLJK1xwzTM3iw
 lbcKN4D+QzJPqr4RduS4CKOEPcTj0kzelTJElcqL7S0f70Iz5s9rf8MmOO49L2I07jiYFRdSLJ0
 DAMOpTX1MyyVuZdkk4o9UuGUOXUmUVYnppPHJRQw0/DLwxmjqOBEwPGPCcg==
X-Gm-Gg: AeBDieuDtYAUPTMY22fc9Lk1SEfTnaxDbKh7rI0hQiUgMInOTx5xD6eZoH5uHCY/xZs
 hB6l1a6v6Lf/VSbcePqzSVZgGBFIyLfkVvSeHSfKa0uJvV1WpEFTjysLV1z94coeH0XJT/f4HeV
 KZFYnxtRIrMiERBJ7JZVHdfRLtXnhhKsfN11VWczrlJXL/7NKFUc6fSo/lFHHT4UsAbGG8aXf4u
 sFXhTWjNgHjE8zscGK4ZoqI3O9JNfag4l/VzvVzgkzgbazI5Gyo4N+e7M7D5SMCEjLGyXcDn/eY
 vB1rC2Ig6UR9cLwPUTimYNbJT32+944I2EX3OwngKs7FMOF5xvdqHwq8HQTZ8QMXrDNTi3J4NGw
 8uU/8eeCxJcMYpQvrPbb215HCG+tOWjtLT3pDnLOlozCa1yF5wk1NEfejiY+bgIR2wBUJeAR2fQ
 Is5HWUysQpMJ6F9iH1xwJsqJCv
X-Received: by 2002:a05:7022:b88:b0:128:cea1:7e3b with SMTP id
 a92af1059eb24-12deacdf578mr252553c88.23.1777503125378; 
 Wed, 29 Apr 2026 15:52:05 -0700 (PDT)
X-Received: by 2002:a05:7022:b88:b0:128:cea1:7e3b with SMTP id
 a92af1059eb24-12deacdf578mr252541c88.23.1777503124829; 
 Wed, 29 Apr 2026 15:52:04 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de321f1cesm6152888c88.8.2026.04.29.15.52.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 15:52:04 -0700 (PDT)
Message-ID: <31f894ed-4acf-4d0b-9335-c94d67dc53bd@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:52:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] bsd-user: upstream ioctl
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>, Alexander Kabaev <kan@FreeBSD.org>,
 Sean Bruno <sbruno@FreeBSD.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _d7ooXovTNQW3W8JKPH3E0ONHHpey3H2
X-Proofpoint-ORIG-GUID: _d7ooXovTNQW3W8JKPH3E0ONHHpey3H2
X-Authority-Analysis: v=2.4 cv=TvHWQjXh c=1 sm=1 tr=0 ts=69f28b96 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=7Qk2ozbKAAAA:8 a=NEAV23lmAAAA:8 a=yd5CBJZFXA3RxMJ23p4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzMCBTYWx0ZWRfX7GpQZljSIE24
 xEBZ3qiv7oPdyaeXS2frw204vLY4fBZyshvVszoc070NyYY56FutMjSAe9ZXAiwCDRfhfIDXRZF
 QNrJP8IBd5N6KKkGROVeaLIRy41b17fk6cYgToQchc/wVYuWlQBgMffOUiFJq3LxaKnmzLVefzJ
 K3fah4mq8mxmhQ8fD5cNf7X9YPsfJiJz1puuDLJK6cnqgdv0GWX/iLJXITmWcn7otdZO/5Diklq
 nZhAZniOYGNrbldQ8RkPaGXBDh1JwqAf+OVMoc5+JICJusT2nh5geVbh8mpiv6deq8DhuY9YTij
 0O9kP8+AHsBSJoo3oYiALkyQVLtdMT+NgcU/6jtF1Krms/YhUWR+Umrzwf0zrUCXI9Me1i/JjuW
 4nXO/4rGX3FnlIZqiTvJVftZSTsJrAz3g73ToSPfHNYP/M/yk/dLWk9jpbiBB0Yy9jqZzNXs04N
 DmnRb4/OuOuk5DaElMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290230
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
> Again with the help of claude, harvest the ioctl changes from
> bsd-user blitz branch. These are a bit messy, since ioctls tend
> to be a bit messy. Ideally, all this would be generated, but
> that code isn't ready yet, so we go with what we have.
> 
> Please note: All style complaints are false positives. The > 80
> character ones are fine: these files are semi-generated from upstream
> and fixing them makes syncing harder. Harder syncing in code that's
> basically boilerplate is worse than lines that are too long for
> definitions people are never going to read.
> 
> The two errors:
> ● b64902a56387: bsd-user: Add bsd-ioctl.c infrastructure and termios conversion
>   ● checkpatch.pl: 197: ERROR: Macros with complex values should be enclosed in parenthesis
>   ● checkpatch.pl: 198: ERROR: Macros with complex values should be enclosed in parenthesis
> are impossible to fix: they are what they need to be for the macro
> tricks that are being used. One cannot add parenthesis and have correct
> code.
> 
> This is largerly unchanged from v1, which didn't get any reviews.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
> Changes in v2:
> - rebase forward, minor tweaks for blitz branch evolution
> - Link to v1: https://lore.kernel.org/qemu-devel/20260412-ioctl-v1-0-1d998a460560@bsdimp.com
> 
> ---
> Stacey D. Son (10):
>       bsd-user: Add FreeBSD tty ioctl definitions
>       bsd-user: Add FreeBSD file I/O ioctl definitions
>       bsd-user: Add FreeBSD socket ioctl definitions
>       bsd-user: Add FreeBSD cryptodev ioctl definitions
>       bsd-user: Add FreeBSD disk ioctl definitions
>       bsd-user: Add FreeBSD IPv6 ioctl definitions
>       bsd-user: Add FreeBSD ioctl type definitions
>       bsd-user: Add FreeBSD ioctl command table
>       bsd-user: Add bsd-ioctl.h header
>       bsd-user: Add target_sockaddr and safe_ioctl to syscall_defs.h
> 
> Warner Losh (7):
>       bsd-user: Add bsd-ioctl.c infrastructure and termios conversion
>       bsd-user: Add log_unsupported_ioctl function
>       bsd-user: Add do_ioctl_unsupported function
>       bsd-user: Add target_to_host_sockaddr_in6 function
>       bsd-user: Add do_ioctl_in6_ifreq_sockaddr_int function
>       bsd-user: Add do_bsd_ioctl main function
>       bsd-user: Add init_bsd_ioctl function
> 
>  bsd-user/bsd-ioctl.c                  | 438 ++++++++++++++++++++++++++++++++++
>  bsd-user/bsd-ioctl.h                  |  14 ++
>  bsd-user/freebsd/os-ioctl-cmds.h      | 151 ++++++++++++
>  bsd-user/freebsd/os-ioctl-cryptodev.h |  74 ++++++
>  bsd-user/freebsd/os-ioctl-disk.h      |  41 ++++
>  bsd-user/freebsd/os-ioctl-filio.h     |  34 +++
>  bsd-user/freebsd/os-ioctl-in6_var.h   | 217 +++++++++++++++++
>  bsd-user/freebsd/os-ioctl-sockio.h    | 240 +++++++++++++++++++
>  bsd-user/freebsd/os-ioctl-ttycom.h    | 237 ++++++++++++++++++
>  bsd-user/freebsd/os-ioctl-types.h     | 104 ++++++++
>  bsd-user/syscall_defs.h               |  10 +
>  11 files changed, 1560 insertions(+)
> ---
> base-commit: becd22fdc2a071783d9e04421526633772b3b98c
> change-id: 20260411-ioctl-68c80a77ad32
> prerequisite-change-id: 20260312-share-thunk-ab1585477999:v2
> prerequisite-patch-id: a048e442d9dda7ee4ed1070ef5eb524e078b9a3b
> 
> Best regards,

Hi Warner,

a few checkpatch warnings:
https://github.com/p-b-o/qemu-ci/actions/runs/25116258138/job/73604077805

Regards,
Pierrick

