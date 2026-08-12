Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD5CC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8jJ-0001MZ-Qh; Wed, 12 Aug 2026 09:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8iJ-00083P-1a
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:09:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8iF-0005k0-9t
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:09:45 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4JXR2860020
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b/kxG7kE0rCEhGqwMqWnhtcfMqF/GwK/0xuH+L1m/v8=; b=XW9aAWNL5apiKk7e
 lpiBhSQbsC4Hk46GusSvFOluB/mAzaX1tgpCEyDY+CwbrNyo9RDN7gPWB0Cn8Rqn
 /y1LNGM2Nk6p/726h12fwhdi6Pyq1jgSRQ5hIwygWPxvu2JdddjrUnB/3WlspWyL
 oua1Z1xFuGXdv9+qRmxBKBBvjgOzft6HyRXRju5C9Ar0eo6IS+7QTg6xJBqwxIbq
 D5ZaFI0Q4hCMVL7RTsqyxofVg4J7SQ5feRV2Scwghd6qDJ5vfQkW95YRRrz2LteY
 MOmjiTgWnwOZK9NMXCind/53qtbXkcGLgvZv+MHfZnWTHgOOuR3DBRWD9a0Ept0J
 H8CvHQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0mnd96tc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:09:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5276aa86d00so10715601cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786540180; x=1787144980; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b/kxG7kE0rCEhGqwMqWnhtcfMqF/GwK/0xuH+L1m/v8=;
 b=e96rIQSH6wd47VAPCzIKFrb01Dy66PekyG8Loy2iieCXOFRtK/fkTNdXrp/CkH8BZn
 6z2Xp8HyWUZJcBV4l8Ed+maR+3MnpevYQAfq6fpsHTMN4kv9e9DQAXS5BpzPOQv2Ubm+
 YgtqxSH04uu6nrhO0eqJIXfYck4LNVISq1/+uF/F4UB0FytE6jPd/xdM7VvUZWqkVB0i
 wvwfSXcZnmKrLvA+PHvkTqJCi3a5Q3k8jXTmdtSQaFws6+VygCGEf8fv8f2zxvrrNr7J
 z+VsSkUi3mboIc/VUQPUo9/Wkeqs/BAxxiQLk/kgjXT9KD0ApydXf9D4ZtZeG2X9vY0t
 fK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540180; x=1787144980;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b/kxG7kE0rCEhGqwMqWnhtcfMqF/GwK/0xuH+L1m/v8=;
 b=kvQDdEsTyVwGHZi71hlmfOFpQvqIekiewuNtROCsbFsgKuYh3End4JgpzWhtNnCMXe
 8hqvtr3a1WSSYiY34erovun3ad2VcSdcjb2cPaRY169TOjPIA7HtmAK3WaSPyQ6wYpJ8
 6vZZZLhrLF1VVmA9rmn4Q9WwBY4wN1EDP6UnWHZd0c8F+qRadusuXjXg8d9ZvcAAuEGv
 +q+byb1PzvOfW5wKBwVEokkRxA7sjLDi+Sw9N2mGSzT7zvoyBv5iK6UTuY+x9UJ1k4zq
 S4o420m9ylG6VwDsbG4HgexsTKsgIT7j866XD/EARA8j9Sv95pE00M745KIuNipVPKnz
 YhWw==
X-Gm-Message-State: AOJu0Yzn7NZVPARV25VV2dZPfeco8gwoSODuSSaUVRzjolnk5sxPuljY
 Jb8SmtzgvJixptz/8f4wt7nvDQE3vTR7GQWDMv00rC0lm5snWM3dRLh5vI00iigl5BN6AWHoLjY
 o6dM16F2VNQ3cly615kSpyJUyU31juj7pXo6MZ/BghqobX46WdcV+ofmEaSHI4TB04Q==
X-Gm-Gg: AR+sD10xx/6iBHTtIqKBmzWJ06TnguzMzd7OGTeLPPjm7fsIKdzShMpUSDHU+PHXK8O
 Gp82NT9dYeLNNPW8bBpd6CGxmJ/pX4MsmEdMfoMRxWK4kCOSMexlCvozNhMf4onUd9PK3QPteMN
 /vzN7aDHjt0siNh/0Ncn156hiF6FRxH7FzKKd2pePyxe7Xx3ykBg8CeASczyR9/GCsKieHX7cc8
 vkJMxdLCjuqXfQ1RSmHEdjdISkhfJTK7PcxkZfs8VD6sFpS/YzxZanirM0vS7eMMYFiYjG1Mo8q
 we5YYH8YCI122R9YAPb18skc6m5eLtT1Hjl+0u9+HHnIIGoeWq6I5X9yLlp8oTtiDnOhqI6Red5
 4wlInKGK7qq/cOhPwkiZM3GV1+wJJi3TlKRg=
X-Received: by 2002:a05:622a:e183:20b0:52d:6c36:db32 with SMTP id
 d75a77b69052e-52d6c36eb66mr9193781cf.41.1786540180093; 
 Wed, 12 Aug 2026 06:09:40 -0700 (PDT)
X-Received: by 2002:a05:622a:e183:20b0:52d:6c36:db32 with SMTP id
 d75a77b69052e-52d6c36eb66mr9193411cf.41.1786540179704; 
 Wed, 12 Aug 2026 06:09:39 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aaa4a8csm76329205e9.3.2026.08.12.06.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 06:09:38 -0700 (PDT)
Message-ID: <03e45c1b-7b17-40de-b856-2347da4e8a41@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 15:09:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] system: Move runstate-related code from cpus.c to
 runstate.c
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260812122332.72975-1-philmd@oss.qualcomm.com>
 <20260812122332.72975-14-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812122332.72975-14-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX1OGcRooLzToh
 Z9dJ2CpxOh8HejFLRonG8bXvcUVrOVXDH0qzgCbCR5x68HHTNjzTyoi2v/Q2POfxPNWtwwkNAdp
 QH6srPW9HAVYJH5vAO5viULmrPezObk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX3dL74L/5UjiD
 bYc7cb1Gt3EqRWwIz2OCTFFWO5a60wZzzfeggKRVUtczXBvgrAOhChRCtMW28fxRQBp8qqt4AcJ
 WEkSWxSwTjjrjbJKHpwXGx4A3Nief/f8UkvJXDFdxW0SsqCq3CpY89EjOpw+26UtLORbnnHQCzh
 qzvqtyPRDR2KFDVd9tI0ul13INcqp1Pzznd8cmPrtaEt/wkWLBhyh4fEBGqSwR7lodFBc/ljlpl
 A36mTx6mL0AG0iS2RW+KzHUaootO1ludJnnb56HtKoFxrBXX21fElrgZ1i2V6ayzJnmX5Fkggw6
 fMhMN0zz/r9b0vviMJZp/hdNIId7rZ/TwHwNL3BJzIkrG4rvCXZpwfrSEKkJX+iNvIr7Pqcoteh
 pvpuBHSq3wD5uJ5Q/pTmD+0kpDaLi+k+vWeuwdMcIDYjaBy6Onj+J5nBN/pkzj2DHzVG6/IxvMC
 he7MQZ19iyFX2u+hwWw==
X-Proofpoint-GUID: LoyiBvR9B0UDjJV88hdEAwTEUt--BcfW
X-Authority-Analysis: v=2.4 cv=C87ZDwP+ c=1 sm=1 tr=0 ts=6a7c7095 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=uBxTIyq4M_rSRxOxVaIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: LoyiBvR9B0UDjJV88hdEAwTEUt--BcfW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120107
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

On 12/8/26 14:23, Philippe Mathieu-DaudÃ© wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   system/cpus.c     | 146 ---------------------------------------------
>   system/runstate.c | 148 ++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 148 insertions(+), 146 deletions(-)

Wrong branch :/ This change will makes sense in v2.

