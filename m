Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F53C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJa1-00060u-5F; Fri, 10 Jul 2026 18:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJZy-0005xG-Uh
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:20:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJZw-0005YE-30
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:20:18 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3cBj1846374
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EXunoHqOgcq+e6ruDWuc6fgIe60dFPD2aPrHMzdaIdU=; b=k1QACYPFzr+/g3yp
 364g+VWo4CD5QHnEvkm/hBcrupAaJSbtebtXFW3dwxB0Qw1wiAjhLkF+y7VRhVTH
 wUt9Ily6TY+ptHjFdr1VaX5XD3AqElElLiLsmM7NaR/gAW41p2XJ61YBz0GnNtwf
 umyBNsh2jBHVMYYKaWbwVQrGdT8aYSF+pVFZKnIuC4SuXzlv5TyMh70dpaHySVFU
 nK+2aATS9d2EXDvPmql3dZmDxcL64TSdjZVlFi/1GxLzlfgRIJr9RCNYr0KGaHCO
 7ms/8J01GqiAPcY4VvmFKRMOfhtxQNp5TBODx+Th5ZnVVHjqVj+UlBZmgD8zC6Fj
 gt3hCw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb649rnf7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:20:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c07f25de2so11454531cf.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783722014; x=1784326814; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EXunoHqOgcq+e6ruDWuc6fgIe60dFPD2aPrHMzdaIdU=;
 b=eFAsXsZrmYJd+9lwLCg4x4vR7b/M6R8pwdlQyCmDfuv9Ux6/x/c1JkRC7PH5YJScG6
 x32T8+O487vhQxChMqpozd3Ojj95k2UzjmHa1qaZie/thpOMWOuYFoKXTE6O1WXW5gAi
 PAmjUi72Dr/pHpyiBqlRkZs7WDGWsS+Tc1Y5Me2Rm13Jv1EBTAsRcGQnsjCT05MY5qq/
 3ITFev55StY6p3Ibg281VIVMfipGUu9ldRUFhzduKdsPmkRViqew27/zSi13LP6egLrs
 7ViNBVmwYxSpWFU8LtashrNc8mmToMV85sK9P2kfhw+E5ifcEjabE2NWcZUYxSK2D8Yf
 P2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783722014; x=1784326814;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EXunoHqOgcq+e6ruDWuc6fgIe60dFPD2aPrHMzdaIdU=;
 b=SzvhkOSRC/5XS0O3dxsDIy4Fm720mzMT0kypj4fENy2S4QxJ1gISF9CYtUMJao3PYX
 NEisWK90NxRJw4pHEfPRCGHiefDA7UWrQT/QOpbr0XZDSqbXClAKcOYTFZYhRsNQDm0k
 bTPLSOI5BFDD1nawW08fH9No3TvrU1QigdefgG7tiQtRTusf/bu4sIqzffc4F/YDi43q
 q5AFJJEnnfOsU011FOakvNIIcc/A4Gy6CmOTNnUuoc7NWjufXESF8VCGVRHznFdYQD2e
 N9Y00CLFzbhg2Bx/eG/tqr37cZg/TbMgXkXxsAKzIvBhhlXZ1Nz2Xp2TJrYZvMtj4jRh
 UrVw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGsM+N+x6e2+KW2INXnbKNNxQmVuGLbgIqacksMdj8RbXcraiaCEkfdJBXayKRS9eG7b8gEXGX76ky@nongnu.org
X-Gm-Message-State: AOJu0Yx+bnbaMu/PkxTAmVPBUvwBBRiIC13kTg3Ctsi3zTjuKyZTY9QM
 GcztK/GNsBGZ2dbEL3mAMCr5ern51/Lo4BgPoRPC74boLbFWJ6PTFNvB+DeLYoXaFssZTsKjvJw
 1CIQKMvoP4IzWS0/d3T748mqSz9ib0u57nFijw9nTUuDaFO5tCl5JSXXm2g==
X-Gm-Gg: AfdE7ck2vDCnHpoRXjH2eVXk4whr0ZBUzEaLg3fR2WQNIfQm6B9AO0b9cHhu/i5+K7q
 rh2GZVy8othrAVJXnHpEMJRejl5c/5xZ6pIJdC185pqXWwUH3tG/ul31aH7VWtyCv7MNl7pU+I3
 vxsV8sYbD03Fc18aN+BowPPs7+czMM+FivnK70Xhv5bem1Bx8oPRR+3+5ErvlG5GfCiSdUcQBmW
 DNO9H9UdLHT5B8SYvwEsM7hX62J42HW1EdctJ8kvRxorgUBUit25WkiKIDZ8fvAiFeYfzMogMpI
 iFKKVGe674bskaVcZ2+8nkmoZtI2+vU0AdPBY2Jd+SKJpoxznC47FhTJfM+uTi3a1wV1HV/rBdu
 5A6Vo4HyJO4CBSpQtsuLCKbbvloiGWsWMgfGhiqgXeeWxr+s5wNex9+Fj4QMrJg==
X-Received: by 2002:a05:622a:1b17:b0:51c:c37:df31 with SMTP id
 d75a77b69052e-51cbf16dc65mr8091291cf.7.1783722014484; 
 Fri, 10 Jul 2026 15:20:14 -0700 (PDT)
X-Received: by 2002:a05:622a:1b17:b0:51c:c37:df31 with SMTP id
 d75a77b69052e-51cbf16dc65mr8091061cf.7.1783722014078; 
 Fri, 10 Jul 2026 15:20:14 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d910sm61420318f8f.6.2026.07.10.15.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:20:13 -0700 (PDT)
Message-ID: <84421cdb-00c1-4999-9c60-79d61a75641b@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:20:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 50/51] system: Use tlb_flush_range_by_mmuidx in
 cpu_watchpoint_insert
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-51-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710205401.836304-51-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0D_HcRrHd8vYmN2YRyGPg995RaTndqmY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyNCBTYWx0ZWRfX/oUjhtRU//YM
 ztdbYkjrWffhww8c4he59dsyxWwkxEcTu5s52EumAaoF+ipAN1GW/GKCUwGyPR4kfr6B5uT/0zN
 TkBc9f19xD32w4sKDivPBZpKkdyoAhBRYOaxPGqrlbCr8gzygTohr/cxqw2CIBjITszc6mko5tF
 jirfXnTCEVDwtWlAq4IPFUYhYlSELygIaC0J7qPnWckisL3MyIVryc3vV3HwyfsDeX7gYG1WNsK
 iDMgS7KCm02iI8dahKF5xzIXP+N0IFIm/h4a4iJkl/dlNvYBTMrjRX4woM8YcI9SrOlsDlA54Tv
 xah6QAKbslbkdR1VNBTx3euyTzukOH6D+IRv80l4CCpA1gNK3aCYTc0kjpSDDIS/rjVF2D7IdkE
 IyyODfD4mHF5eCfMDCDtxIc9PEOHMKDufbkJYq6ZQTpnNkElAjBMRLh6zTfxD4R19KZr7mxP3Pa
 G/MwcXifE40bLmjSe0w==
X-Proofpoint-GUID: 0D_HcRrHd8vYmN2YRyGPg995RaTndqmY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyNCBTYWx0ZWRfX73xThwuaYC6b
 itNG2qczoJwHY/UfjLdXPyjjU8Wf1dRJD4yYF8nI5MKfGKmJ0Lg1AmpjxwBWOOP5P4vYqi4i8yC
 j9P1nEsw7WsrtY/P+3MZ4EsRTn7aC7g=
X-Authority-Analysis: v=2.4 cv=VZfH+lp9 c=1 sm=1 tr=0 ts=6a51701f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100224
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 10/7/26 22:54, Richard Henderson wrote:
> Update to newer tlb_flush api and flush exactly what is required,
> not single-page vs everything.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   system/watchpoint.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

