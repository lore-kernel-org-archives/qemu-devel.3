Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC214C982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8aaM-0003no-C0; Mon, 21 Sep 2026 05:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8aaK-0003nO-FT
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 05:45:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8aaI-0006wq-Vb
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 05:45:16 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L84TS64135081
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 09:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JUKPfK9X9i84sHSKEuGk+g+GBWCvNPeFG58sFjW5iT0=; b=jwcppKtlosJIDQZf
 Z8S9orJWa0RSOElEdlsi4c1wxp9kf7sUNMS9k1P+plAq8QLkqDYZ/BortzXUIvdp
 NrKYNot87ap0wGM7fIxefcwXL3fYbckeacaHZxfET35XZ+7xzjg0dN3EJwmwLD/u
 aEzPC5t0AJoMF83jHKaOrEGk+uQL2dZDfgi2RpbFp7Yf3dDTA+m8nZa/9htnH905
 QzlWNMwDRS+s/ut7MxO2yhUlmsIdSs1qdkPiDxTP++6Ht0rj6tAAYEGXFNoRi3OZ
 UgCb5EVJ5XHp1b0wTWrksVfur1rlPvAYKzGMg/EY8mxmXluH9SmweDzr0MXCukcQ
 9A1p+w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu0rj0e80-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 09:45:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9308eafb465so423008885a.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 02:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789983912; x=1790588712; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JUKPfK9X9i84sHSKEuGk+g+GBWCvNPeFG58sFjW5iT0=;
 b=LsNCnVAbr+IxzybPOM/90u/tMiE2scfDbuEcZrK8pkpiHpN0cXIDSeu5H+5FDXRSjm
 ZTkdnECdH4OvAwhel07RolbYa3k9EISM/vX6VtUkukjmSd5PwAnPRyKY/7DaCye+2/SX
 0uDd/KPl0Sbg5tmeEyZv1K7gLoA2XvLlP/KAA9Um96GQCpRnH26K+H5TCy+2it8IdLIe
 esKfvMkcRN4Gk4NBd17doG38m1TBRC3IiTPUfX9HZtwzeP9hRI7HRmzfG0UyvTyeKzE7
 jC2U6j5gQ0MS+9KclwfPzKr+atf+ouqczJhVVidWIKSVpeEbodnV3L+taLyKh5RCKYsA
 /uLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789983912; x=1790588712;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JUKPfK9X9i84sHSKEuGk+g+GBWCvNPeFG58sFjW5iT0=;
 b=TcKXEC6QMSvthMrKEr1HrqfSnLNxfSA7UQ0hkQHXi2GntoDEI/dSCIk4ghcXUzYWuB
 JCPsWF+pBoyB5EZKSE/mAFiyVCt8GvEW4FmEJZnBVVUPLX7w4+63jq0V+3y3RmXwaZAa
 kmSZXbNy4Xliq1vyBqsjDZ3HLIc3ODBVRDuiF/eytIjpYJJV8lV74ujLUzv5210CDbGr
 vqJYb8o2I7JIww0lGZlPENHh72Ad/Ssht/Xik+zF9WaNAim8J5LEfDdt2JoWtRWUruFc
 lZGtLlEc/MFDh4D3cXmf3FGVVHNGMPMCewRpoN9dGG/6NypYRiKO+tmtgiInhaTmkbL8
 X5hA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCcEv9gFmRyb7n1Auxwg1Ajmcs7euM+bmnebMhi7UNu0D3Tj3NfeO/V+ViQ0p4yrDc0DYiCYo1XRxt@nongnu.org
X-Gm-Message-State: AFuF++nBSjC+Fh9d0oyvwlJFUu42OnbHOgXn1UWKSUrgb8ZclvO5hifz
 sF4vbqyhsRcy6YJoHp4+A1ebD/10owwg+Qfo0/PiYHBsBUauR0UY7kzVx5oUXg1Oz9RIfvDe/ZQ
 FX7BQJhjZQBEGit9dwYtf9+Kye+i4zcBEIGf5Hq/iJZwo5HGqfsPrXe0SEw==
X-Gm-Gg: AYBFou0RbPIeGkBNYGrs2Fza8GZDEMKFPy1ZUXgyTM62BZl6w19/B19i4LdhFraXU2E
 x62pn2/rl1AFVFitDBVdzLsZtvteBBu2eOM1667deWt8W4Lpnvx0Xev+dZ22DIUI3WrEB15klAy
 g0t3MrpOC8zCLwySEkBeUMvO80dEbsxkoJiJb3F+3P5qap72RO4rsch9p/ApDNjWVyEc/FugFdG
 sWwxZq5SVfZ0BBuoqnZn7jAVDXAXjG5WHemx82lz8c0bz3BtSJ7H6FwZvzOkzdhL1N2bHtGFfs+
 zePuaiIDnYNsJ4mSZ8w29P8LyEYMPc0I9o/KBT03M77vFduMaY6g2ZJ3pHjToLFF4eJt/vNLl3j
 UNXyq4FGydRBjpCOhtjlO0fiJYC53E+PXIQ==
X-Received: by 2002:a05:620a:450c:b0:939:3f4f:324d with SMTP id
 af79cd13be357-93bf56efaa9mr940820985a.43.1789983912596; 
 Mon, 21 Sep 2026 02:45:12 -0700 (PDT)
X-Received: by 2002:a05:620a:450c:b0:939:3f4f:324d with SMTP id
 af79cd13be357-93bf56efaa9mr940819085a.43.1789983912273; 
 Mon, 21 Sep 2026 02:45:12 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd7288169sm7327615e9.2.2026.09.21.02.45.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 02:45:11 -0700 (PDT)
Message-ID: <4741b9fc-2cae-4a38-9f7f-b0d6f0503575@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:45:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: install pylint for functional linters
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260908193656.2787108-1-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260908193656.2787108-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE0MCBTYWx0ZWRfX7wMue/cph9hA
 eIqpESfZJguBeSE2CGB0nSDLlFuo87Wf0WTK0BknOqFk6lan8iWsfoQlVUn+t6aLButzsHL52Id
 b/4GYX48/fB7qV1gMTtYCEG3HiUu5tw=
X-Authority-Analysis: v=2.4 cv=AsR7T+9P c=1 sm=1 tr=0 ts=6ab0fca9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ZzRz4fdQddg7O6G10b8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: -H6-VglhzfWGZwW2SbzjLK40EPDphYJv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE0MCBTYWx0ZWRfXxxJh5jx7aWRc
 8A8Rg4RzJF+m6HCjm6loIfj14zJMj6OovFnOdpEKMJiOF4D6uoH+knh5VbNE8HmF7dApkUV0+5w
 yAp57XjHSJ3QWfuvLzarHbIJXC25YGbZ7GLaKG8GxvFDif4mlRrbuwYSkpyzZ3WbRRaqNlst9Ap
 kXddp15gBiOIkF5DDPrqKa1hcHu6o6Njm4vGcO7kLBBbjl3saSV8i4JK1LcOXtCW8BuVn4l3Csy
 oogdjXtIDqZ7Yf/3bGtmHIYojpRbdUD18u//Io+fozM/rUVlUNKhQ/1vzkHUsBMQvR/I8f2zW/G
 rJd3ldJFPuQe20K0HvqgEi4crvpejJH37gVM6NG3qa5oZpQ9wCLbHXMqbWWzOoNKXuxooZcC8RE
 27rRrgXJ7yckgztTfgfISaLT8M8o3hbgb23DHL60nHocZefsX4X994vSGs82VMN9Z+4mz2envH0
 bzX3rNqeJq8e5R3bLIg==
X-Proofpoint-ORIG-GUID: -H6-VglhzfWGZwW2SbzjLK40EPDphYJv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210140
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

On 8/9/26 21:36, Brian Cain wrote:
> The functional linter test otherwise imports the system pylint 2.12.2.
> On my system w/Python 3.12, its wrapt dependency would fail with:
> 
>      ImportError: cannot import name 'formatargspec' from 'inspect'
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   pythondeps.toml | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

