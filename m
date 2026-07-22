Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA1EC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmXyO-0006Hv-Em; Wed, 22 Jul 2026 10:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmXyM-0006Hg-E2
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 10:30:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmXyK-0002Mw-46
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 10:30:57 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MDWRRT445296
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 14:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gGnPrZ3NIDFytOJTMW3rbHCVrEHozCO+JTkR7G3iK0k=; b=i7wmSVly1uDIuKYP
 ZwgQJ4+aEzhdNthx8pCRtObw6vttaCRaXGc0FqHc3YRzfkav9+iEdEmxwu2YQJ4G
 3IlCJWWigpWTXkenNy4g9RjOfwFwvnQ+Hd/iFzBhDGJ8Q4+e9sB2BHnPKrSukcCS
 3s+A/TaqSCxQCwYoSFcJCKW95tptG+2k+5VVAkHRDuqP00Gg1hIW7eNB9eFjZSO9
 eh3W0+2SgYCjnUUAKNufJpaQxkR8ctseBaUmelYxwonfQI7svo3hqwg13nhhXHyM
 dXtIX6AIlkOCO1VpHH1+Lc89ZLuyAPt6LlZZdhBFFEeCvKRdQPvYUA+/oqvWM3+s
 Sgv5/Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjxmgg9t7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 14:30:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso258049351cf.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784730652; x=1785335452; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gGnPrZ3NIDFytOJTMW3rbHCVrEHozCO+JTkR7G3iK0k=;
 b=ZHKwk5yLLvzAKP66tvuoVfoqnDQplk6Sw5yTJRzGsfOjwC6xIlFqwsmUrAf18/Ij/X
 ukjQmrDwTCxs+FAoga+4R3VYPpGe3gwLb030B+uI2HukR39q3eofLtTfINhnMEGabWez
 dtzCGpJfqBRUwil3N0hLCOKo3/Ba3u63Hulny0YX1qGoItd5RudTshzGJR6j1+UUKuPr
 0B4zEdDg+uOeQUwr7833pZwdkc++ivMvTHgCzvAC7muC74W53xmFXFfiP4yiLrlxxrlg
 6f317/EJuEcPaD6ajx3bHMeMNmjlaxc7Ynn6r9ApAAMLCvbVeFpRVg+2ggLoACH++Ux5
 ecyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784730652; x=1785335452;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gGnPrZ3NIDFytOJTMW3rbHCVrEHozCO+JTkR7G3iK0k=;
 b=Bd4/2B6PerggcLxc00Qc9MWRXXNuPoj9SPAx/eB+taunQFpB0qITLER0ujKaWu/IH4
 21Ic5xoKutVXSStvzE0lX+y68fUr/Bkq1oUhv4ilwlNnG1zkixTrO2ldYZ9f0v/l9OPI
 XUwf1rejD+HSq5CgPAC/0Ohr4WX+NvUpVpFDHZec0bECUJBQNu5nYvHoedjaU9Jlkh++
 bHeGXCxSogShVqZ9pBaCOAa6gJKDvqbqFy1xVMtRG+DjIvg0L8YyDi16yQs9e0DcnV4f
 DIl7TIS1dVqwKhxUNmQhMdj7dhIQ4V/pv65lCILzo0Etox4hIentmIgYitFibFO9wF+h
 I6Lw==
X-Forwarded-Encrypted: i=1;
 AHgh+RodUTIVZSeDWJ4TYReHhvombQNLfVszBGrOlJtZRZWciQU63DsaoANtxH7vMpDSaf2Y5M9R5lVgFhV7@nongnu.org
X-Gm-Message-State: AOJu0YyKc7GFQPtFNcsUF8qcbkzjVjKPvlQcyCPuaoaYGztbD8b7cMaw
 GgsKJ4JCKpS1vhO9AyTa+NyO5iXMG2golrFoDm9APsWoDYSWlgMehTCBBGmBJz/VaV+9AROfDur
 Gfo8Y8blW4FUfdAIkASuTebj5BuKfddeQXfvAqwji1TBl0zDTu6Y9ZbFTdA==
X-Gm-Gg: AR+sD13w5BR36IYzPL1yZyQ29h3ed6j6oVZPBQv2dylRi+9O1UXmKRFqeh7WSAPWozD
 pJNrOFkrVyvquyVmU7imaw2GH1eGhPYo6whbgpQCnx/AGdYtNgnstxVmS/JYQIRTvwhjveB4gnK
 CMe+hlHNhRr0hSsiiDxckG9eAHdT+j0lUkwVTYEdwOQUQHrORYLsGJzvCReNqHWiSmtnSkyzzJ3
 OIlTMsn7rtLa1VrSniT5TKCjcr5EB8SEhNUaUVzeXY6yYy5Y6CTQhhpe3NjPvFZMT0qXRwgihXM
 skaoClC3YS030EdZlnWSCOX8SWH/8iObd3QN7NvH2JoroDtpQ/UY4RxQ2SQBSoPSURRpIZ7y2ew
 4upkuOITpdje3l/3p9ygwj7ZOOsqgPEBrDOsAKJ9DHRdUQTIcHAE=
X-Received: by 2002:a05:622a:a591:b0:51c:9224:398 with SMTP id
 d75a77b69052e-5213e67b7c6mr215397161cf.60.1784730651845; 
 Wed, 22 Jul 2026 07:30:51 -0700 (PDT)
X-Received: by 2002:a05:622a:a591:b0:51c:9224:398 with SMTP id
 d75a77b69052e-5213e67b7c6mr215391871cf.60.1784730646920; 
 Wed, 22 Jul 2026 07:30:46 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b03a93csm51229845e9.4.2026.07.22.07.30.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 07:30:45 -0700 (PDT)
Message-ID: <bec005b1-3467-4018-90fe-b315c86cda6f@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 16:30:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/kvm: Fix UBSAN shift error in MTRR mask
 computation
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
References: <20260722120437.697986-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260722120437.697986-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=D+V37PRj c=1 sm=1 tr=0 ts=6a60d41d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: TBt0tjJa-VcWsxb8trgcMBOVkYPU_OtI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE0MiBTYWx0ZWRfX1tKbWWCofArt
 FiLPhr7VzdKtsGzV187EN+1UojPsdZp7lIlJ6FZNVA0slmoR1tnjfED+BcmHOJWL1VYJdEucwnB
 kHB+/xTl/GEDM1oGYVLLGpLrm681k0o=
X-Proofpoint-ORIG-GUID: TBt0tjJa-VcWsxb8trgcMBOVkYPU_OtI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE0MiBTYWx0ZWRfX9X5JGqSaWwHS
 ZmJJ31uj3akLFeZBcHzXV3BM/z0t21fbprnZ3DIvJBFxcXCFBf1nPcB0bdi4LgQVdPrKDp+V8We
 H5GY544S6uw5FZYaTM871HfeNF+djiugLS4yPgjMHMN4xhYchH8QZ9dXLDNI/b7gkN03vw01fzo
 wytKBYmIIqjeilGLEKocIcnTvERhFGXeV11xxs86kaCR4eKKXtwnJV8uovn7nZKytlPu8NDQeN5
 5BAs++JMdDXTZ9Yo+N1sEqS0ydH+nbi09PiMRMg/NDikqvJNZEmup8t2NxvJlrb0UcUGpM4HeRe
 tG+38GwQfhQIGTG2ZgWVdWqatp5k5V7YlcfoZzK6LGqQ92FsexecKw4HHhIOvCSc/H/FJGhmLxb
 RXooR5qPyzTfYiTym7WPtvxIW12o3z5+V3P7KPWgijioM1mwU5+cNksHZvk0vgoxsY8qfAVuqg1
 aH5vQh9hqaa69C5a3Mw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220142
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 22/7/26 14:04, CÃ©dric Le Goater wrote:
> On AMD EPYC processors, raw CPUID leaf 0x80000008 reports 52 physical
> address bits. When a machine type such as microvm forces
> host_phys_bits=true, the CPU ends up with phys_bits=52, causing
> MAKE_64BIT_MASK(52, 0) to shift by 64 — which is undefined behavior.
> 
> Fix by only computing the mask when phys_bits < 52.
> 
> Fixes: fcc35e7ccaed ("target-i386: Fill high bits of mtrr mask")
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   target/i386/kvm/kvm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

