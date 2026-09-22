Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37991C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x93YR-0002pf-G4; Tue, 22 Sep 2026 12:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93YM-0002pT-OH
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:41:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93YK-0001aj-Im
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:41:10 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEjLrL318103
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XktJ6AcNnlpc5c0YhjqLKWA0bcaefM6arh+1sVYCm4E=; b=IzfGjkYT57QPYY4D
 ImRhiccu8iWcumKDYycCRi54OcL2wa/z5IDdc/VtK7LGSgc0TSmPmB3MujgRcHZf
 OhYDOLVZo7vM/2ULOF0ChpyFMVhliku0QscDdoVEE37k4ot9QhR6yUav0kHWHRLg
 e8orPJhPEto+BzsiH6V0Nnw5U1QDr8DAH+hQ3EtewFx6tXhLC8JvnAvXvljOwPWv
 HDZptodcZBexNpVAOKNvuAxJxXDQwQIVvacXAOh2vGahZ8kK90w/mtKnuDe9N3fM
 aSPLi+g14pdmtv0E44eigqzVV46XNiBR5Emk7kY83cVNK+U/c6beHPdBA+tCgKEh
 cxEQew==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gupbqj5qn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:41:06 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5c683ca769dso64196e0c.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790095266; x=1790700066; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XktJ6AcNnlpc5c0YhjqLKWA0bcaefM6arh+1sVYCm4E=;
 b=EkCVccChoJjy1zCpXz6fWEAkGjAtKZ/3Cst4qVL2LfIhCcOh4/Fz+TT3MpWzpXZ2KT
 0xU+yi6/a1xn+13w55A59ObC7x7u0+J7z/oxgoAEPuQaCzenCBV5hjXWFq2UwmMbAyif
 u4nzVeQDsv2oI6iI4fnbWo/8sgalrq27QJNGFKlIPn5nUL8cIOBbl1ixmcYBH5+TxXOn
 GbOy8VgH2WUPvag4/tt74mryhEY6lwNUDylvUY/ANugHnwnDppIy/MzK6ToqiTKqnHrS
 vrP8btwTA1GzMa3vS2KcouiEgVOGVNHUp6UqMF/vDr3MDR5ME6lLBPfGam/fVmH9gbu6
 DySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790095266; x=1790700066;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XktJ6AcNnlpc5c0YhjqLKWA0bcaefM6arh+1sVYCm4E=;
 b=FioaWIeuq0R6xRqv40khyeUOASUs5m4+lQlAhtPsIrtrRJIkTvvd7zkVAgI5y4S8CU
 f0t2lAMBwrdxr2eNPUL9XAlS5aLS9VMgMvxD288d9zzBkikIZ1kQKccv7vKsqwd80LHH
 yIp//7ApmBNVzlHbdKHXebMML/5jc13b3wiJ8YW+PUZpn49YPMHLezOswXKJ9GpAc9Cq
 2LwDByfhiEn9v0d/3crCvD5CbHJKdQaW43BihmmaRBQQkPHq0XpISNPJWZrBJKnxopW/
 Jsd6AkATesUuVpAykYpJGKbJZcjgsYwogwyfXHRznPcTaw8+OWbG7oMbwNeuc1UklGaN
 geuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEhCVPw3WAi9xBDNQrbGa4y1LaVwaGjvxhtSSLP4LvwQaCCr6rV/uTpiNDemntS5+8PKTS0hYS0921@nongnu.org
X-Gm-Message-State: AFuF++kSv2RLYC4mzUCW0TYF+GR5htxX6foDHSpLn2g9ISsFneMIjHEz
 AwbUT7EQWtpdqhVt1x/cT2M5EB3jaHJaWCpK0lsrkKKaxsw8iBJd7TD1lITBc50jMdZcmxxIf/I
 jBEZBn7yQ6nZkmLTVUdEKlTu1RZLuEgeCrQ1FprMkyaAWoEP7VXHi+abfSw==
X-Gm-Gg: AYBFou3P2AquIl3uMkftAGljMAbYE5kbaZAR0SDe8fi0YeFtWF3NdeMfhxrhB2P+FKx
 A6NVS4pXAJ5SdbvK3gcPxJPv0Y4tApXqkEbDikHSlNYHABAaXcfssndmmnVUaaFHaJW1P1wbMCJ
 uKLe2NwSA0IsOFwrZ0fl1T9EjhFQaT3rNjggBWEGgt8kf4sWGkRATTkK1jTEiHxlblRp0o/RnBr
 0AwfpQs/3fueGSxySjWdE7GRhXP05Vhn7KrMkpQ8zx/nz2PFOJnmGlSKja1BDHlNoIRekcqZVeC
 YrDl4G8yCHJvLdm7A7j6vpsQTh6WLZ19LpZTOMQxP0ZYYPWvmMzvOhi2oIbNvHJTcXOcAgLojNZ
 gIr8yPRKKw4Gf3MgO8Rw=
X-Received: by 2002:a05:6122:469e:b0:5c9:c60a:e9b5 with SMTP id
 71dfb90a1353d-5c9f168a5a5mr58807e0c.21.1790095266070; 
 Tue, 22 Sep 2026 09:41:06 -0700 (PDT)
X-Received: by 2002:a05:6122:469e:b0:5c9:c60a:e9b5 with SMTP id
 71dfb90a1353d-5c9f168a5a5mr58747e0c.21.1790095265590; 
 Tue, 22 Sep 2026 09:41:05 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.52])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48862775412sm6335760f8f.10.2026.09.22.09.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 09:41:04 -0700 (PDT)
Message-ID: <7d95bc48-6153-49c5-9e58-1b6a458bf43a@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 18:41:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] tests/docker/dockerfiles: refresh images
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
 <20260921231458.3369-3-pierrick.bouvier@oss.qualcomm.com>
 <4207d4f8-a452-417f-b240-77cef59b7d54@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <4207d4f8-a452-417f-b240-77cef59b7d54@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI0NCBTYWx0ZWRfX3z2BdnVQcEvY
 hLq7F6h14IX3cy0H2Ub3Mt/JPLPlN5pYy6cb/Ic2yFiY9r4Vkct646L08TXCF/GCwYsXQoMpRmr
 hOEctDXyCgZwMEGaClb94LLjk7HFdr5HFPxU+X8xb2blEkav8DvT51GMeKX8w6RosHfjd6+B1ob
 p3/Nyrj7zSvq1Em2w6YfD9jObh1QnoROzMnSSJS4sbbrL8+3kCst/rvx7ToXvoJjDhcTWxTQgDc
 BbsK/PCPBVdzI0h8V0bplGEJw9C5zgNiMXjA7458IqIZBpSP1EUwa+kfjEbH+gSaHXBi692Zxa5
 9E+XoyB0qdlFqok22ym/YCEudvG4g4pVrUxM/9HryElf55AQfWpSkp9Tg7EZxq6VxlvRmeWsn0o
 HHL4/+aldIjd46WggBpVhdI5pEiFbiEajA9JPFdflG8O9iKuWXJU7Ng6bIEjp5hRXfyixrHmKTj
 Flq4z+iCxraKnCU/G3g==
X-Authority-Analysis: v=2.4 cv=FdaiV5+6 c=1 sm=1 tr=0 ts=6ab2afa2 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=QTt6BuOzr45adi7bDCnRgQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=3pi-ffuTCFynK3YNQzAA:9
 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: SzbkJLPDh0EePYDDNh3qSP-XJ2cA7bld
X-Proofpoint-GUID: SzbkJLPDh0EePYDDNh3qSP-XJ2cA7bld
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI0NCBTYWx0ZWRfX0wdQeBjw5jgw
 uXpU8klbo2nK+IDcBTxBPrm0A9YfzpnMFKInqvuVjBjl15cQDaO7AioOXeUUiu9QZ5drkCNQitw
 lRTVuoxT9H6xxhxR+4ZvMj0V3w7D5ik=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220244
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

On 2026-09-22 18:15, Pierrick Bouvier wrote:
> On 9/21/2026 4:14 PM, Pierrick Bouvier wrote:
>> latest update of libvirt-ci changed packages, but images were not
>> refreshed.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   tests/docker/dockerfiles/debian.docker     | 1 -
>>   tests/docker/dockerfiles/ubuntu2404.docker | 1 -
>>   2 files changed, 2 deletions(-)
>>
>> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
>> index 77869f71546..2d03ff03c8d 100644
>> --- a/tests/docker/dockerfiles/debian.docker
>> +++ b/tests/docker/dockerfiles/debian.docker
>> @@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>>                         libpcre2-dev \
>>                         libpipewire-0.3-dev \
>>                         libpixman-1-dev \
>> -                      libpmem-dev \
>>                         libpng-dev \
>>                         libpulse-dev \
>>                         librbd-dev \
>> diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
>> index bb8f4e4e53f..440699a5005 100644
>> --- a/tests/docker/dockerfiles/ubuntu2404.docker
>> +++ b/tests/docker/dockerfiles/ubuntu2404.docker
>> @@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>>                         libpcre2-dev \
>>                         libpipewire-0.3-dev \
>>                         libpixman-1-dev \
>> -                      libpmem-dev \
>>                         libpng-dev \
>>                         libpulse-dev \
>>                         librbd-dev \
> 
> Dropping this patch, as it's incorrect.
> In libvirt-ci, libpmem-dev is a dependency of targets debian-13 and
> ubuntu2404, so not sure why it removes it here. Seems like a bug in
> libvirt-ci itself.

https://lore.kernel.org/qemu-devel/37057f38-5326-48e2-9646-b356f13da11e@linaro.org/

