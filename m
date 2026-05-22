Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90346CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQYno-0001PI-La; Fri, 22 May 2026 18:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQYnn-0001Ou-54
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:57:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQYnl-0006rP-Hs
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:57:10 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MIOls94007647
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 22:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dRfl9NaFA7RNrlTC5h6lexlsUG04GZ4B1dfCrePX7lk=; b=A5aumqpxH4m7kTNB
 hM4/KHuagXU+bgZrW9ysDEbui7Dv3WVFnvsX6wZB+QckgAcu5ycGt6eu8r1Ix75R
 ImujxfnsbLU4CdUnAKc74P3Igade1Xl8xx1eDHfEbnytfk2pWzaW1DDrYxtMKB6F
 UP9SFi0VNw/Y2KeaASCz46GoCRIV9efqZdMiyF2kPt0K9hCRAiGhFbKJdcqjPHKf
 A0UPrph6SFQ4A4iJcnxYTzuQYqy4+C1bEsgCcN0q2Mb5CXccmajWyvjgXmVUttdb
 xNbVhQrahHT0TRWyg/0xg0YSGWUwRUXVfRaOIFSO8VB/JAPqydvhzeMHe1FA0fDy
 wDRT6Q==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eavd98r29-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 22:57:07 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-135405e4035so37740140c88.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779490626; x=1780095426; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dRfl9NaFA7RNrlTC5h6lexlsUG04GZ4B1dfCrePX7lk=;
 b=Q4Xx2iUIE2DCjVLjdICCe+K8Y8dZMu1UbkIn4Avs5AnII/GfdYfhpnX3pDlrULeZTc
 VHYLZDFNFvIa3Uks8hXup+ksMiy8Qjc98EDBKyQNlii0+RpH07lLF8nb32giyO9efyL4
 jd/+d9zSJeCjBr/TcS8i5DU8UQDIw3KgP3TM7ScFpdFseDsBeQoqejVonne8I4X0uy+P
 hRC6VdXDKhJ/0ABpdzvudkN/Rxx+TaNcOx3dd0j3e3VNMYq1YO4rWx5+kNZxtS8UZTqR
 8gwnwLWgjSDdWrjYjx916BmkLIIwOE8htRwRmy+SzezwzE/QdbYuBT2sc7LDv6PzbPIS
 7+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779490626; x=1780095426;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dRfl9NaFA7RNrlTC5h6lexlsUG04GZ4B1dfCrePX7lk=;
 b=exDIHptqIkIsUAaG/BKfq1YUnZDaO++pT4jQmpsCyQrebRZhNQNfnZp4bV9A+gIwrB
 C+gDd4FYtR4NZK3Kt5SJ9pAisnALUczGaFyZ08O80KQwnRnf1tAmhC2dHfTNgWiJrB5h
 VbhGlaekUpJ4Ui0PYabyjYgBl42sv+xH6GAZzg6sl/eQS+QnDpw9jiZr09buHo25OSMx
 k9qXfcrTlqBVs9KO4ZgWKYucnxwAfZA54ctK2hA4Ggvs64i3iQXILqxC5l9IzQSphSLX
 Sor0ywPl8OfJZjBmo28mjh6mg3PXROtcQOLl+T31C/Fp/YzJw6n5uyH9t5eaz1WBJJ3f
 VBHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6Cc+Yquo9nh2gd0xRLf9lybosEipp3KX1aQp3ckpSwJIx6AgR0DmxuFr18VgOwQ1gqipKZOSzo1Ft@nongnu.org
X-Gm-Message-State: AOJu0YykzIflV3PeBiBGmwi9iCzKyuW6jKm/wHzZ3qKBNyyGXWs4/zOQ
 7TiE+uT87Z0nAwqkneV+SvBB5Ok6bPmnaEbIuenKtxxGRUfBTI5GDpzUfTEGFsAsOQxGjFEAMOE
 SmvsXyzx9gKXc7el8Fp4PLrJuE/2nx6KfyihPvw+qd08R7qZif4bM/ThJSw==
X-Gm-Gg: Acq92OFwVPI0CF80pubNxVnYVW2WGhpJCbb+3edVHNKwfHqDIVOqVgImD/tucCiGhpx
 035j6bs3YOyREPd32/fmIVi9orzDwwihKZcN1wyvX5k7uXjb+XJVCT3bTsmQ3QtEeA6CHyCDgSR
 51ObLuwU05VgHBp9d0RyVhN0Ipr9ygpkCEYo8VfyjgWAcDDb9sEA3zv5oE/tI2z2DgUNmzxF8FJ
 XZyiLfjBdd0FpkHQ7b4wCB8UJuzYfFByUYp5YQA3HTalPlXN7ZKXplTLuwR4f12w150VThs+puR
 yPZA2fZYHs8hkCEMxHdP2QO2jG5oNywh9RBmQcat4qsjzgC6T3HCYwFBErDhtpMGzpcY4q7iQ25
 9umv+ak3SyIxcj3Gup080UGdsaVzH8y6h9SvJCuqVykPJuG7MDfRdxbRschaDe5Q+Jwiqf9gRJ5
 4XB94Kk5k2+KbL2g==
X-Received: by 2002:a05:7022:3f8e:b0:128:cedb:33c6 with SMTP id
 a92af1059eb24-1365f81f816mr1845324c88.16.1779490626471; 
 Fri, 22 May 2026 15:57:06 -0700 (PDT)
X-Received: by 2002:a05:7022:3f8e:b0:128:cedb:33c6 with SMTP id
 a92af1059eb24-1365f81f816mr1845315c88.16.1779490625897; 
 Fri, 22 May 2026 15:57:05 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13669c6a2adsm1987130c88.0.2026.05.22.15.57.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 15:57:05 -0700 (PDT)
Message-ID: <0af4dbab-8cd3-4666-b663-0a20b1150744@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:57:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/37] bsd-user: Add file operation system call dispatch
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-8-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-8-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIyOSBTYWx0ZWRfX5CDjrX136Vig
 dv4bzL7EjRvqe3O2iqhReGps66QtadoEJDVxy507p5+8/KF56I5pB0zYZ4AOYSRS7PoUXw+dzJo
 q/NN93MC0O3xGeGXINGm8KkpQ0hSQ6GUkDswMySyoGTNP75G0UCnEdEOxHMfGWpUs6Z2kQcz123
 EHuDTZ65hbMjNxX5eubDO3u1JsLu8hgD/h+rkC2nczrRYZDfUNSzgDjdMyIhIOqM4LoNuvdgxC/
 U9ZriKmXVrjpZzPQVPg4Fxg2FM0xd9wZc+RHkyRyPorbM+XFOQ8mr8C+yGW+9nqqRjmu937bm30
 SjrKRjI0QyXl4mvg1pUorwiWwKiXIZcgO1Bc+OoWK3jdVQEpbsnZ1l5EaNZ5VuHVAe7YqlxKnbK
 FOiRr7MfBYOgDxdeQTE8fbeuaGV6vkNv06J3V6bzO/XdIZYO9GLFic2xp7sqXjr13qa/b4K7JLQ
 LO57QAwgQrICRzFYBkQ==
X-Proofpoint-GUID: YsR5relu6ghhh_UG6Qb0uvYxzzPXaHdj
X-Proofpoint-ORIG-GUID: YsR5relu6ghhh_UG6Qb0uvYxzzPXaHdj
X-Authority-Analysis: v=2.4 cv=F+dnsKhN c=1 sm=1 tr=0 ts=6a10df43 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=rQpUGyzeagwlD_LXrEwA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220229
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
> Wire up additional file-related system calls: poll, lseek, pipe,
> pipe2, swapon, swapoff, chflagsat, close_range, __realpathat,
> copy_file_range, and __specialfd. Also fix __realpathat to use
> __sys___realpathat on FreeBSD >= 15.0.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/freebsd/os-stat.h    |  8 +------
>  bsd-user/freebsd/os-syscall.c | 51 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 7 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

