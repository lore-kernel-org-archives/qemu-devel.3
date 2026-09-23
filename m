Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FA3C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 05:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9F6n-0001Xc-4r; Wed, 23 Sep 2026 01:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9F6g-0001X4-Bl
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 01:01:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9F6e-0002YQ-Hf
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 01:01:22 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N3idlF2571594
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 05:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g3IUd09r8UKQAKmuqhU/Rd4KNBbMcrPSu+S4yhNZtBo=; b=kxVRvkdeud+cSyFI
 FtNJrMvR4kNBKBV0FyIdKM7VH8fXpI1vjDCCEt9lFuSf7znmWWWkZR1dxZ8S8w75
 A7Q972BrByLar00F5H0Rj7xhlIRtlvj2vn7QJ0URMSZZvV6iv0Q9XpCvfp5cR0YC
 o+k/AOqFNG+80HcmGMQ2JNeyXhXVkvBu1ZBfq7SvCabwYazommmk+6unuv0aXK3Q
 YBvwVxF34TiAwoba7xFLyFfxrmZDzqoupe+DaZeG11nIVunKeVdju8Z7KkuIVzuy
 jSfVgdKfwvZISEuWL2xtxoeTYLq80tcHLCF+LPNiBmikHcm3Tz6H8U2c9Tgh1Pa6
 4PW16g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux862jpv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 05:01:17 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-855315ccb64so447666b3a.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 22:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790139677; x=1790744477; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g3IUd09r8UKQAKmuqhU/Rd4KNBbMcrPSu+S4yhNZtBo=;
 b=QORiYxiUtFhXp1BahQ+ytpf/ms25jaaRevh/shYbYsEtPdHlxu2UPMt5KxhyFBk/M4
 M3FCjA0alb/4BllzU+Riedi7+fCwJpE7KBbuRgkJTlDuUNZI9gOJbFZpGW58HGVmDVhG
 K+0ofUFutdfGYDsiMx9/kKfvBoBEeUY8uojfMZCd1r9LX4EwLT0p4eBK71JbAXpsV7GF
 Ziqwik/rJE+Tq4OoAs2VrVpNTuy2mS4avxewW7CM/27tjiW9ouWV4Q5/wDEkrCo46EBT
 Rh2DU/gBrFwyvA6dkN5S59tHf89h1+SxhH3fMSc67gRhXr/KB9SBU7mfJpM9oU5Sous1
 ojOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790139677; x=1790744477;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g3IUd09r8UKQAKmuqhU/Rd4KNBbMcrPSu+S4yhNZtBo=;
 b=0DMxNU+E024h/er4QUmudPzTAhmjytmt9Sp8BJ57YsNgagSTKeZtGcBl1u86vpF/8g
 OWSZMU5cf3Rw6QnYRlK0kls8JqAzuAAQwyekMjeYc9vLGEZt+fmP2l+sSNLz1ns5ODnR
 18GKwINNPrY696AcyFT3s9lkuIdaYVlI8ADYo7mE1V0AdDO8QmpOcN5LxzqJlvNzhxUh
 IYhZ4r4uyJa6pGPRWRrgdsWUOPumEqNN/DOERsiKhOX1j4Vlvq1mBrlnEitVQ5jgw1/T
 uq510ZHZcq5a1F1unJb9SGk6DkeIcbyhiodQelNjP+wJj53u1tyKzqqb0XosYiWbNw4s
 vfsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCUeUWlJaZMGKZ7R/GinL5q77gTHLL/nUX8GwnXWrQLSNScJtXeT9KP5glOXrM/8BCDtz3Wetl0jSa@nongnu.org
X-Gm-Message-State: AFuF++loeMvgv0R3VB5UGRd4b9Qp64SAW+7vq037K6JOAOaiaHGybGjQ
 K0aFbUx6SiPBj2BeGbDNUvXgr89Yxh8S3L/igDZ5dFwvZC+u8oGcqcs1Uk2SgwXfq2En8/vukqY
 kWqtE75ekd6xyMVPndKCOb/oex7NNaiLT73PCJw8HgStDyAlE9fr2JGpXmw==
X-Gm-Gg: AYBFou2bDMdDiVz/fUiplybf08swDUZiydJ98pQF9nnacWE+HRF/I1YMy5y8RifDS4C
 r6BYXSxw47MsBIfHmiuaTT/GsXPrWitJwouH5wkL6gPs4F/9/GHWzH409D9068ZTdvoVwKXCjN0
 qFdWd61iIe+aAluuskRYFRjiXm8NSgLH3uPe/7ds3Mb5+6WZcoFeM5P/7dkiNgxdZ2YR/xmTOTh
 5UN290uF5Q8ZuSZmQKgDgEXfRu0iy/04i/OLP9EUEYUrKNDGWcve4RId+e3CoxXchfOIXNQ7TiE
 m7zZW0K4mtVBIGpuVVqHMdj75pastsyFXIV/+FeBqEG50luGZRRMIKtHqfqRCjw/3nXLmf+ttlA
 0ZKLRT0scEWJXxhmfUAH2HDG401p61jD3NzSvFmEwzrqtGSsuW1n6hg==
X-Received: by 2002:a05:6a00:2d03:b0:878:3507:8d65 with SMTP id
 d2e1a72fcca58-87d1c6c0ad1mr1226052b3a.44.1790139676480; 
 Tue, 22 Sep 2026 22:01:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d03:b0:878:3507:8d65 with SMTP id
 d2e1a72fcca58-87d1c6c0ad1mr1226011b3a.44.1790139675853; 
 Tue, 22 Sep 2026 22:01:15 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1dacd460sm653444b3a.33.2026.09.22.22.01.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 22:01:15 -0700 (PDT)
Message-ID: <5e3818d6-c2c8-4450-a5dd-8ac8ce1d6cdd@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 22:01:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] machine: allow -M name to differ from QOM type
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <lvivier@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Song Gao <17746591750@163.com>,
 Markus Armbruster <armbru@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20260922215533.641-1-luoyonggang@gmail.com>
 <20260922215533.641-2-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260922215533.641-2-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: s-45AeBiX6VWFdb4tab34_qpySFoYxkx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAxOSBTYWx0ZWRfX2RXfJThx1QLv
 29UA7YvFoH0KuOCtCGJnbf7aO1kibTMbutCA/9jaj8AH2kkvAO6NqannOu6DvMrJWQiv18zzsqQ
 WeY1JxQ4DRBBdNhMnvXH419Sj/MtzDM=
X-Proofpoint-ORIG-GUID: s-45AeBiX6VWFdb4tab34_qpySFoYxkx
X-Authority-Analysis: v=2.4 cv=eIOGH3p1 c=1 sm=1 tr=0 ts=6ab35d1d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=lQA03COSUpqy9BbuZUwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAxOSBTYWx0ZWRfXxr2b+ciHVcq5
 2RpF5EnVnryLpLE7oYUst65wmG4X+pZx91ZyeJ5/beXZ/uGnLn8ce+28MkyKuQNZbdZ1f6WHEEH
 JfBDdYDD0j5igaZnSapPaFeRUE9tKydAq8Hy/KHbTS8Wgb6iDDVbKZhGLUSE7nBLcEv4OfCBXBY
 Gr0NKmvQoV+enjXGMryxrSrM1j+xyo4erCWD41iqdQlKNA4E5CFVWbrEaKphMoPuBe6vSKkxhu5
 iBWky9EoXQpgTD0ZBiNNAskiV8dn61dmvlSUEAEbT+kG6Pzs4L4NfujDb/I20Kehp9PtwT2SYmN
 I85uha2zzHXp8ck7gBeOBY/CJAuHKI4VcUe5WS8UkgB/v8l98cU6uTlQOL+6ZkKNnvIROflCJ93
 myep7ZDZG8wvMXVlxHVQ/9ekNzStm8nqk2l/UxGse1XEVEXUZjaycgPpwAu5GyoBMnnbv6F/OPJ
 WiH1gaj7wzV5m4SVltw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230019
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

Hi Yonggang,

On 9/22/26 2:55 PM, Yonggang Luo wrote:
> - Add machine_class_set_name() so boards can keep a stable -M name
>    when the QOM type is uniquified. machine_class_base_init still
>    defaults the name to the QOM type without -machine.
> - Document that MachineClass::name is the -M name, not the QOM type.
> - Sort -M help by MachineClass::name so order matches the printed names
>    when QOM types are prefixed (arm-virt-11.1-machine vs virt-11.1).
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/core/machine.c        |  6 ++++++
>   include/hw/core/boards.h | 12 +++++++++++-
>   system/vl.c              |  8 +++-----
>   3 files changed, 20 insertions(+), 6 deletions(-)
> 

this indeed allows QOM types to coexist in same binary.
In such binary, how are we now supposed to differentiate two virt 
machines from -M <name>, given they both have same alias name?

Regards,
Pierrick

