Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08846C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZnc-0002Wa-Nd; Tue, 14 Jul 2026 05:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZnX-0002U4-3N
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:51:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZnV-000390-9t
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:51:30 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6Sf5d3954888
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0XTFd3Nn0doloWN4+94EF9f4MA0XM78nlrmW5rtjkL8=; b=lpcc+UIh7obHjkBV
 1Mht+1JdJ6garoeIqrxcoCtaNIU4Cbg4Wj3OM9kZz+dHcEnuJFPXbPA1va/mQNgD
 jNyZsfpmRK1Fxqg1tez7csmMxEKxqsPvxSjBSAJHd8GI73vIkNiSjT/7vMg7v133
 v+US7ePjT0esp6trimbB8cT7l0yYbTeC359QFkBUQK7hRup5gZ7YXRtwM1VEzyRo
 Z3sUhG9bVU7uT6p0SroWGH4xrFDOhyJ7i63RLiRP+epcdW3L5zXf1IUCZabJ+DLg
 u0k387JKNq9XizWS47tPxFUhFuoEVzEAklo0HuPoESdHuh0D4yCs7TgDUekzOvDI
 p+rZAA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44ju6eb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:51:28 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8f0867a75ecso101157466d6.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784022688; x=1784627488; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0XTFd3Nn0doloWN4+94EF9f4MA0XM78nlrmW5rtjkL8=;
 b=LLvM01PTM3sUAzU/IpwNttz17ElxdyiURDpt81SQjY2QRO+DdfRdb7jcsPX880QE9R
 xUmsc/KY7COiZdA/9YB+7JAFgYI2zvcSSPe6IsOQKMRBp5S3fmhE7DMHws0fbdicCE8H
 BDFYEdD4e7pFpF5ADJrTUAVKjfCD6o5A1N0zsSjsZXWgsfq9be7tz448gB9T3SFHC+Fc
 Ib9cZzYBLmyUE9UeLU1RCcnQ+GsUvHNinsh9L5wr1r0muKr9dfboDsWQc/IGCDVVVM4g
 lLxbjip/LOWfbW4i7RXSyBaZcsn3K1Lke/hxxT+GcFesINSMOydhLrRwqmS9FKizqbc9
 DcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784022688; x=1784627488;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0XTFd3Nn0doloWN4+94EF9f4MA0XM78nlrmW5rtjkL8=;
 b=W67IciUgWEnBlYe+Y5/nMVGomUL7apw7Xu/4i2STX/QmF9WZ3UlLXM4jdQ0e+Mds6a
 35lAkY6Tn42vu0LgBJ6SskM2DO5CM6M67oUmS1+okicA60qK8tBEQQaGBWIxJSIiBxSp
 IzXfObW5orw02seDNUH3fvg3KwT7GaqRlDm1OEmMXSnTgrdT1PNi45k6/WbSVywqrFj1
 zittYy5BSuoO5qYXzpTF2YGWy/ZVF0dUFtKfjL2JMwJqUCr9BzL46MEsdz8Xs+zHWDqt
 MSOzOMT7ZA0AywxrWErVBsVlOJFeO4phoIE0pGHb2j598g7wNb1I6sYUiOJkDEqNHYot
 xR3w==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro1HJJ3OUFI6nERYPjFDLTgbunMeWUJJ8WPJoGxNfwtABzfidM58jrlCp03zo9+ikSwGTLe5FRCqiio@nongnu.org
X-Gm-Message-State: AOJu0YyoLjGWlMUMGZBDhwofiHUwXwmS8ZPOEPYHVSFKsEeQMMhFMk6t
 SoU256Gz5PyJe6HnB+tqDWsSAL0Uk3qRCBeb0mPEwSH2UMqCsCe6okFAoF4xQIp3Taa8qHc936n
 8A3Sp8ul4JxcxLhlnniMHKbMo6f/CGFz4984PWIQfh6NVqQ0z+xz4ui3aWA==
X-Gm-Gg: AfdE7clUUI9kNjtNj3RW6RdCUVvwBw2n3dww2DtpsfUBfdmdLs9xGUfz20OqaC8yERT
 dQcUSh+x6S7rMG4ZDIqC3tZwo4VwrQrqgnwNYkJw9u+P2IXvHuTqqMp1i7hU9mgl0q4EbFxpUkb
 FrmB/EaNqbniS48qQyfz5WNiK0Rn790R10+ypwaLUVj+MTKxrJ4wI1GbNWd00Enl0ZizrhTIQpi
 NL2Vb1hsDX+xgKacS8/iQpTNBtjLYnUkFpHw6xRbmd2axjReMXk/M+UP3O5QRA2zlfTmYYWFB+K
 TjZTbjLTAxorHJ9FYp6HVu+T1fJn/l9mq5y36MjoAyRHLuhh0Zy4NAqetyoOvCBfDNhy49+kGir
 9VOF3g2sy9ozxnnbhfczTqwktcB85Tx7XDVR0kG+E1bse+ng+WCX907CqFbIdaw==
X-Received: by 2002:ac8:5954:0:b0:51c:7b12:5fd1 with SMTP id
 d75a77b69052e-51cbf3403c9mr121377031cf.77.1784022687762; 
 Tue, 14 Jul 2026 02:51:27 -0700 (PDT)
X-Received: by 2002:ac8:5954:0:b0:51c:7b12:5fd1 with SMTP id
 d75a77b69052e-51cbf3403c9mr121376851cf.77.1784022687406; 
 Tue, 14 Jul 2026 02:51:27 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15dd207ab9sm816519666b.1.2026.07.14.02.51.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 02:51:26 -0700 (PDT)
Message-ID: <36178350-820d-4e3e-8abc-688391a1d92c@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:51:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] pvscsi: fix endianness issues
Content-Language: en-US
To: shankerwangmiao@gmail.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Arvind Kumar <arvindkumar@vmware.com>, b4-sent@kernel.org
References: <20260710-pvscsi-endianness-v3-0-27fe1c4d1f6e@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710-pvscsi-endianness-v3-0-27fe1c4d1f6e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FlauiyaIU_hw873icFTYtqd_cJ8ZTKnM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwMiBTYWx0ZWRfXwWw/CKS1/W/c
 arEJMC/HAv4XkODsNXFGjCLsgVXSv4dw3kW5KrtxoDxFjLY3Z6nBRpTN/AI8cd4t9oOmLE+ccYJ
 l0OaQSMLczMVGm2l1gr8y+b+RmYyOKtyR2c/pl8/zAGQS666SXFtRoh92LGpAnC21Xk8+NMXI73
 ngZ6CqW8h8AWGZ/pA0Zdz+ee0eb+dCcoOovIxxhqj8t53Y47cvnCdexwX3g3Pu4oe/opwzPqaRJ
 DwW3WRTmrq5fVfIoA7yJQ27YWS8OOmL5VnBO5ObZtRu4Nkiy9DmW6hDLQhZA4fSGzfnREGxZbww
 TshKfin9t9ak1nKi8fEwjB4zPiXoslr0lIGBS2YN6+bbYUkqYiGzgo4kxp4heDoOKnb7Xa0V1mC
 G+HTeCnNzsEV+wMxXIbr8mA3GOOUQSFBVGX40cxdYjYR3n7UKkqVtNjINgaJEXhvpKMm5tvne48
 lR48g/GkzhgkXIZfDpA==
X-Authority-Analysis: v=2.4 cv=XonK/1F9 c=1 sm=1 tr=0 ts=6a5606a0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=rnIrZImMdkQKgJfejEUA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: FlauiyaIU_hw873icFTYtqd_cJ8ZTKnM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwMiBTYWx0ZWRfX44YLzaQDQjVR
 hwoYMtYYS6Mq232GxOMoGIWtkI7wguu15loFrXDZiLZVcn2BQd3h5qLwSGOqM6JAjn9Ol1sNiUp
 cPCbOn6MhuR+NTbloRLLUbDup1t4jEg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140102
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

On 9/7/26 21:21, Miao Wang via B4 Relay wrote:
> This patch series fixes the endianness issues in the pvscsi device
> emulation and clarfies the endianness of pvscsi data structures.
> 
> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> ---
> Changes in v3:
> - Remove the unnecessary struct keyword for the structs that have
>    been already typedef-ed.
> - Add a comment in vmw_pvscsi.h to explain the endianness of pvscsi
>    data structures.
> - Link to v2: https://lore.kernel.org/qemu-devel/20260710-pvscsi-endianness-v2-1-c512e6c8849b@gmail.com
> 
> Changes in v2:
> - Assume pvscsi is little-endian instead of native-endian, and thus
>    replace tswap*() with le*_to_cpu() and cpu_to_le*() to convert the
>    endianness of pvscsi data structures to/from CPU endianness.
> - Link to v1: https://lore.kernel.org/qemu-devel/20260605-pvscsi-endianness-v1-1-b0bf472b0f59@gmail.com
> 
> ---
> Miao Wang (2):
>        pvscsi: translate data endianness
>        pvscsi: add a comment to explain the endianness
> 
>   hw/scsi/vmw_pvscsi.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>   hw/scsi/vmw_pvscsi.h | 14 +++++++++++++
>   2 files changed, 70 insertions(+), 1 deletion(-)
> ---
> base-commit: 29c042c6e9d4a09d4a0ac3fa54aeb7ee08ce0bdc

Next time, please rebase on the latest master branch.

Series queued (fixing physmem API conversion), thanks.

