Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40ECCDB47C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcKTy-0003Nq-UW; Wed, 24 Jun 2026 06:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcKTx-0003N8-EL
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:05:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcKTv-00036Q-Ui
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:05:21 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65O5txqE1892330
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 10:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uU/Ml621cQtEnZliL5dK89EJFC8pLUw2zGcbYsIGt2E=; b=S1KMG45S0BWArSq7
 jUAWPDxx8rmuM3sKXskhN8syHtvrrEWm+bmJB1uAnhBJj6cBodYqlbCX01qLYKbd
 YeZjonW8j9XejcrEMFEYjrawZzHMdRUOXzS/JZ+bhM/SOqnBEvkZlK7VCuSvVdxX
 UitYDeaNEqk6XecswTHjz/5Y8FwpFLVee5rGs611xV/mkB4uHpPrPE5FMNPkDCjf
 eAamY7Mb78ksrrIYtqc4oBL7NiYSZ99yu/1cq6GbgCH2Q28ktpa8u8EUyHS/vMcw
 ACpG9sP2SHXjqsJCsiyDTbXSheVk6RaLfVZquxQw2W2G56r2Th4vftJgYECBVTeW
 tJlVkw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05bf9nqd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 10:05:16 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6c33d75153dso277304137.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 03:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782295516; x=1782900316; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uU/Ml621cQtEnZliL5dK89EJFC8pLUw2zGcbYsIGt2E=;
 b=OsBv09/ZS6AntBdF7H4FHhMc8w3FdPEcj6PHCKpw8GT7unCLuBnansu+8sfDCGr9x+
 8W/OMnU+TV8EgSEP+3hCZpHqzl4o3Qp7wq3cTM4ly9TM9coogh3sJlKsD8vJEiSxUqVU
 1tCL718HbXhpMKDf/Awb18a/gpeKbBnkFHX0pgScBAbLba+Njd/vlO11D7c84Cz++hGZ
 PZQ13s5+/F4I6NvSWgVLdUF0svYQy/W2kWpFmg+OpAMQFHt3qOLhDFdf6CqqOFCNYBZw
 HNJJqsQMCmRzYLUEx7FeuaHdUKz7gtEiNN/FJ8XMkk6oZjhRLF9D7uTROaJHrVcbFU9d
 81aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782295516; x=1782900316;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uU/Ml621cQtEnZliL5dK89EJFC8pLUw2zGcbYsIGt2E=;
 b=b4G7CMdmPwQU4cZu0uqWyScI2Yjw956x5r9KvpcOdQMEu5tDKdwKqg/gr8Lt2DPjOq
 HaTHCS/iASHeZ+vT+EDZpbruOVQvpkqK41jxAIMJzBSo1gnGjSuGG9/jtoep29f+kGqw
 XNJYeWE5fZ/YIu6236UF9ANDLQtJ5LNeK2PLDCc4BJA3OEyD9dTBJqEb0ouojnSo10iT
 8ljZfOBR3BbZoKZhnvOI48d1ckreHyXjYSRwcyEjI5IXRuv2Wrd1BJcVICAZc6bACv7k
 eUhCk/KZe0uvoWoSo5Grmea8RCT/O/4+0sb09vvnA9/8uSgy/z+01fCLlT1mUWnLYdjP
 m2lA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VPmhfCwUWCW5x8XImK0NMTyCggiou8ITRh6F/SnX8kqrciaFBnDWVd0AUd4PPmKicoWbHp/DJIGRI@nongnu.org
X-Gm-Message-State: AOJu0YyuFZOoU64aB9Rz07gRHyy39uv1oDR2occC2UN0obW3v/Z6oPzF
 FlRcGtZLG/TWXW1jZqqUmA/0Dkx4AgS37UBiERaQ/6cJfemZvOXJptT7H4l0K9eHJzXWuUfzCj2
 BJlFaesWXS6ji1HKkse5zdLH4v1y5OIKRCvQS7wYNkqg2oc5XxeFHKb5UhA==
X-Gm-Gg: AfdE7cmBtSOlNoY1AweTt2Sgt5u7GuLdyqfp9Ci4wLVHCS1nBczHWlaor1cStrMfW5I
 NRqOSwJrvin76ARZDcf4k5M/kFvfR16nzW5YByt+e718mvnXHsveOGNG8WY+aan0y9cQbtfT8Hp
 IooT/caFm3PS0aU+dpNbCnC7IMUMUevcSh6xDtwSMQ/3KFzNrZazQSavFnTPqeW4O/H1SDmIZDi
 x2StBCjj7euVSX2kFM5fRtsbwpnVsxZ9C+9phQbRnVFGu1b/6cdr5WlE3ZkfcHvbObJmecJrW6Q
 sg6KpINwyWGlBYW/Rr1oQ3GEmjX4Ov8D2dVl45GfPzjrly0iX6kf1OzKj+Wg18WLWx+fThTpkJd
 hLkWhHODERllyMeiXhQvw/Vv6YNTUzEkXldgAq/s8JoZduvwG+djGfE8XpJLUXw==
X-Received: by 2002:a05:6102:2d07:b0:6a2:b2a1:f16a with SMTP id
 ada2fe7eead31-72fd549000bmr3831322137.2.1782295515839; 
 Wed, 24 Jun 2026 03:05:15 -0700 (PDT)
X-Received: by 2002:a05:6102:2d07:b0:6a2:b2a1:f16a with SMTP id
 ada2fe7eead31-72fd549000bmr3831223137.2.1782295513611; 
 Wed, 24 Jun 2026 03:05:13 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49260915286sm104344865e9.1.2026.06.24.03.05.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 03:05:12 -0700 (PDT)
Message-ID: <29ecbee8-2452-47cc-89cb-7d7a26abb685@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 12:05:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/18] target/s390x: Fix wrong address handling in
 address loops
Content-Language: en-US
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 iii@linux.ibm.com, david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-2-freude@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260624081029.23815-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X8Bi7mTe c=1 sm=1 tr=0 ts=6a3babdc cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VnNF1IyMAAAA:8 a=nqnWPUv0DkUVY7dcfF8A:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: HWhXa3VdUFXHF_spUj3KEoBJE3T822Ra
X-Proofpoint-ORIG-GUID: HWhXa3VdUFXHF_spUj3KEoBJE3T822Ra
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA4MyBTYWx0ZWRfX5ixCh27z73dj
 kCrB1DX22njT3cRVruuEJVR8vrLOnlKtQFU4MAVKAD6HomctrbCS0/aul+2U72V8l9orMjioaz7
 3wHmmZ1wLVpxx69EUYIwG3IybkW4krc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA4MyBTYWx0ZWRfX1OMFq/VBnyWL
 NOPYzZp2epzIeEsq5gjPcq9sl4qUeKUthEwMgotzY6a5gXvDYy6lFBPIatZacfenR6JXSgxEETf
 o7n3ad4EvI46Cjppv2+UlSu+5LuINlcbebcwUNit4nvJ2ZZASQdEJV+sNRtRfaj0NsEIQCwQEm9
 ogA2UlClzZ1ZguOQbXEtV883iJKPZFaARhExxPc+lmAG1C4m8af955URss0pP6u5/NkYd6pp1pb
 9fHV0AQhCwkJDmzEVmFXwvgVR/30r/JithkX35I64zW2yzU1E17pd4sDi9dxsXLfTDwfZJjLG4t
 G4NSfXSGOrza4wREGwwzaXN2E1R/QXTFpIbna9mrUPfw/oirL6FoaTBJj7cBaYDU8H+fcr8iF1X
 8H/L9opAQg4xsNQQtLfiad/GaX8E0V6RE0wPI1OJG2TJfDwVRRsBj7jN9sTuADnGzkcQXNNUA+R
 y1bqaAhtYNJKzVpY69w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240083
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Harald,

On 24/6/26 10:09, Harald Freudenberger wrote:
> With the introduction of the address wrapping function
> wrap_address() the result can't be used to walk the
> source address any more. So introduce a new local variable
> to hold the wrapped address to avoid mixing source and
> wrapped address value.
> 
> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx argument")

This commit merely added an argument. I suppose you meant
9f17bfdab42 ("target/s390x: support SHA-512 extensions").

> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
> index ae392bce0e..29ad2aff43 100644
> --- a/target/s390x/tcg/crypto_helper.c
> +++ b/target/s390x/tcg/crypto_helper.c
> @@ -126,8 +126,8 @@ static void sha512_read_icv(CPUS390XState *env, const int mmu_idx,
>       const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
>   
>       for (int i = 0; i < 8; i++, addr += 8) {
> -        addr = wrap_address(env, addr);
> -        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
> +        uint64_t _addr = wrap_address(env, addr);

s/_addr/wa/ or even directly inline?

            a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);

> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>       }
>   }


