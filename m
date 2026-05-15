Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DFBCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 17:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNw9p-0006eg-R5; Fri, 15 May 2026 13:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw9P-0006c8-1w
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:16:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw9N-0006Jc-IH
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:16:38 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FGQNfC481148
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uznIPfDpqBH7IzakmLkzprdunlUvW/2tFhf24tqqAvs=; b=W4epg64eTTEWuePV
 dioXozPUznnUXiMwzaw9yqHo+89C6f3wV1CD/MsqosR+IlZCBv0mGYN/wYU8VHgY
 jNDMbWvQ4LSk4bwzz9v1lYu36VUOlIjbYDPM1pm66/MeW1I+O2xitZoOV1EwIKuf
 4eR6pDC9ObRD2PZ0C/47N8TC41i9lnji8FZCyTapIeY4fM47iZjRlKi7h/lF6cJ4
 8KJvOczw8rzkX5XkZFcgKlV2RfKX9cptD+JYojmZl/S0X0tnlvVMYulBkSI4IJn6
 pRo+8qldulGNO0eNvY9+jgEYgqze7VDgZUgc9aT9up2zCPMHr1Zf0dntk1xGFp6A
 3gon5g==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e670u858n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:16:36 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1353a6f29deso930491c88.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 10:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778865395; x=1779470195; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uznIPfDpqBH7IzakmLkzprdunlUvW/2tFhf24tqqAvs=;
 b=DT6ugfHv0gY8MWjuwziyRD0TxdKYqcH8V9NhhAJZA9vVYaAp6LEDywLeO1bZGHhMfT
 Wq+ok+q7JBfImK7wW1MKWYGTgOCET1jV34hNpNc7wmJ+UHUP3JqlulyHvf4vYrxo9zik
 ZkN0D/hSFNasdwj1f/FfL+OQJF7FHtmwuOWiBqfEfRzda/LiWG7pqhDlf0Hp63+RhJRJ
 5xvSjDz4mkGQPg1D7TzUER08zHMr0yETZfRsD24S1Ty2oJDR688mHO2TxxTtHJrt/VJi
 g56ZsilR68xGTvpDHZUmJ4jC0BekdBUY0yMpiXyVsXMaPBVaQuNj9/8otI25fR3hR4Kx
 oL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778865395; x=1779470195;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uznIPfDpqBH7IzakmLkzprdunlUvW/2tFhf24tqqAvs=;
 b=lmCOXBYO/Ps7AaZFQRNTYxeFY/HWzhRbgVIuBhXlKp69d0CVqRrwEcH4oyKFx2CoJf
 4KS+EJWTG7Ujf8s9fp7TRk+GT6KutduTnpt92xBy169TBqLXBCz6d5UFZSUTm1Hnbmtt
 yo34nW6foFbGRxLniR1SzY1BDqjdjOPk7oI6ul15zR+itscWO7goSVlZntk0kVnY7sIm
 HaUyh7q6Ev7bVWo+Tk8na2QwE+B/uWKeqFjg9VPLb9HWeb3KmN9dHIuEGJ6ZYZ38pR7z
 RqEb1nD5B0R4IVj/NzSDqii98mOK/zxNT0IUyzm1KvhK6ELjJOlByh4vm0DHD14VFK8A
 WKeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nDEhz0vL6v4FA4tJzppT34sM+SGdaU73UgsWKQJO1UuOB1rzj3RYtXLmxf3p3WrEc7TbDcR2Wanyp@nongnu.org
X-Gm-Message-State: AOJu0Yz8PfucoliBhD1D0LwjNzZqGTa9PwGOiooQJvnsP01WvwJhdOJv
 MaBU3leccQ09t7VnFSyB0lnbmze9hX7ykPGauzY5QOH8VwwY45t9iAAOcJcxkVFkRNqnwcP2i9o
 4YCPeWCh65pfPgVSzlxaGWZnhRi9EBbghlNyToBImaPbP3UDth0JDa36dyQ==
X-Gm-Gg: Acq92OFvEofNh40Orw5PSNINGS95ZtqPVTk8nQsZQbamaLlbmpSgc7JVfbWUKU1/NB7
 CeW9PAVFxkhpImmVM0rjz2WsXO7AzqXd0ZvpweGAojrb8BsoIXZrL0vEPo9rPSL6mhfeauqq8oh
 bdebQoiTzSpCCYdJ1dZ5hlCqsAI/DSErUv7ylmMbZ5rDou2Q8zSxsAZ7Tx1DRKyHsHlv12G2k4p
 uIg7LfS3Q9ketS4U+6/5Ol8CgSo0r5IM3Eeu92rFjymfwine6d91jO+ejpf13XWKG1uMRiuqfek
 ihYJB5NunW+A8wz15mk3/shAanAD/L5BesmgAfMksUnPsTfSsKEId2t6o86b+ZEsBRrAaWkw9D0
 DKvJtKfAaXkclgrqBGfpw8FlOf5pWLZbKuwvGkDClwhFNWsy92c5dpd6WIsEUoIUpM08rTIK3Lh
 PRpNPQAA6zpDY4Zw==
X-Received: by 2002:a05:7022:fd08:b0:135:3f86:9075 with SMTP id
 a92af1059eb24-1353f86926dmr8146c88.21.1778865395288; 
 Fri, 15 May 2026 10:16:35 -0700 (PDT)
X-Received: by 2002:a05:7022:fd08:b0:135:3f86:9075 with SMTP id
 a92af1059eb24-1353f86926dmr8132c88.21.1778865394733; 
 Fri, 15 May 2026 10:16:34 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cc33a618sm10564332c88.12.2026.05.15.10.16.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 10:16:34 -0700 (PDT)
Message-ID: <aa696386-0162-458c-a218-5d20c58fbb6c@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:16:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Fix const qualifier build errors
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260515170658.187252-1-clg@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515170658.187252-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JlkTacbfRkrX7PaMblOuEBE3NCd4pYUy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NiBTYWx0ZWRfX6ioQtHidy/WX
 SfL2E/zhdmV9ttMEHcBp0ORKxllB1GQL7X5OgjNQXpvNnwvuHe6va5wpyhjmUHVc/RVFe5YHjHa
 K3PtL+vPPtVAlUKgIP4VlBGNfKfwmhSEFvj5RmQV95y14txQxEP+m087RdED6LMRjygR7fgUJ3x
 GwARuIUMDxY4aqg76kicEtLCM854eT0bKvSxhWTi9EnJ0oiQix6nEy4nnPyMwX56+yrCxPzOmUK
 PUabO42dvV/BUAZdvVCNvY7CG9vFvUmHZaNmoxXdtgK655Imj1P4nkWvK4Svl0r0SHIo8iLyZKx
 6V51dIMdXxp59og+cpG9a+0XbU742ms+WaF8QdVBI6O8pwmdZ0BwvdPitQrjwYxHEsYWmzScmq5
 yGxn3zMA9HGqLwFdMaJjEBnzgS2AmJ+vYmjH/kXLmcZ1Pw5wGnnPyb89cxRKYKw+fYwUqU4JkSJ
 woEag6CiSG6rwHtnjKQ==
X-Authority-Analysis: v=2.4 cv=E9f9Y6dl c=1 sm=1 tr=0 ts=6a0754f4 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=CCpqsmhAAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=0sww-g1G7uxw0Z6zsbYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-ORIG-GUID: JlkTacbfRkrX7PaMblOuEBE3NCd4pYUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150176
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

On 5/15/2026 10:06 AM, Cédric Le Goater wrote:
> A recent change in glibc 2.42.9000 [1] changes the return type of
> strstr() and other string functions to be 'const char *' when the
> input is a 'const char *'. This breaks the build in :
> 
> ../tests/qtest/libqtest.c: In function ‘qtest_verbose’:
> ../tests/qtest/libqtest.c:2175:15: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>  2175 |         found = strstr(log, domain);
> 
> Fix this by changing the type of the variable that store the result to
> 'const char *'.
> 
> [1] https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690
> 
> Fixes: f606321be88c ("tests/qtest: Individual verbose switches")
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  tests/qtest/libqtest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

