Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC70CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waA7g-0006kK-Bi; Thu, 18 Jun 2026 06:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waA7e-0006bL-Fy
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:37:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waA7d-0008TP-49
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:37:22 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAZ1581558550
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qcGw3eKLsUB8CymFI7JbvdfADEU4gCd308j/9Vmyt0A=; b=V3a1wldBIIBFGhnb
 Wyekb757iy/raOcfw76Xxm/lp7TtmSPJU1UE5WMQSYzhbIAzctJ7u+MLLpLLpgu+
 QWnxWkfxnXiduIi4AcELk56dtav4K3hj/GqAWULihkSkcSBi8QB1o6u4oJT8luZ2
 3o34EQh1ftZgPGswSdOONLfd4WyIM/YWFGXK60SJmSGy3lpi3+Va2fPdB+K70vRB
 h4CbFgXsEBkF3V8LAnW5sMHp6Mt71Q6g4BxOf7CTN+Oj5jmmyRWk0nglGCYxJPuE
 Ciecv/+dIo5BX5rJDqR3N0zgJRJok/EO7sZrI3KK/hWBXEjqcWS04D5arr1KBbz2
 Ff9GDw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2jv539-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:37:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9157db42dd8so204698685a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 03:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781779039; x=1782383839; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qcGw3eKLsUB8CymFI7JbvdfADEU4gCd308j/9Vmyt0A=;
 b=J3A2R6m1EDLDt55uipTDHTstYP9XgMf5Mzls2Yki5Q2v09ZWCWMFxxr3nOSb6y0aJc
 cqxnnWu9n2A/Re7TKz7J2Rew4j9PiG9SJ+7YVZtHx9NYO5s9m1ZDmg0yc9i8HBEp+Bz4
 4ACeVRutizqQEp7QdE2314uwJTwvCZxeYMZCN7KxK0QdDt3/G2gdzPAGPYtpr/Oo6rIq
 KeTAGed4wdlfwGQ0WBmOlnnp+kaoDiPXpugL166qR8eHvB390f0sMMtI3/FLoMOS05zv
 tmo8SnsQXzoqNtgbczuVrkf86jYCuc52F0nnzXVgdLKqVgg8KVj/CnMJ2iY/xrMFX5Uj
 /I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781779039; x=1782383839;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qcGw3eKLsUB8CymFI7JbvdfADEU4gCd308j/9Vmyt0A=;
 b=dbVAofWPDl8nATLIEQsW74IrFwC4MPuvAYv/bnDFiF7xBotH6BjsaPtqQZpZjHVAFN
 Za6r3uZX95+f5h4DiFEm85cF7NL3cQS0mNrUuE8ayeGE/CoITIQVq9LnHmYiPiEgkAH9
 9rYbA4hvrhX8qgaDKLjIPe+ixiy/n3Phl9ez2LaIw+omwb+tH8dPwqHiu/mjVTW3bMez
 dtwMDvn++FZZXZXirknYWhXL0n/uCyk3DdGpdt3Iqi9EC2dZLLJj59mG8qqJj8WKjddT
 SjCWdnz0DUOoqKBsMyxJ/mTW3Z7s7HU8R2pbqWDp6DpmH0HCsx7UerSYpVs+k8sxva5+
 dF5A==
X-Gm-Message-State: AOJu0YzBr6PF4+yI67hmM/LyNchP045mU8x65nFlxpru9+mmXgssprMQ
 JOfi4YMHpSqHD2UCmHhP4QCy8Wp66fDg3lOKLBqqJkDITxo9GWd4Q2IyOYqbWZtlkuIfuJ+Zgyq
 PWHjJOkMya80rfsoi+sTdRImczKJVjIza5+PE44jsUiTHRZ3GUWyrGEWs5Q+5q9XI+w==
X-Gm-Gg: Acq92OEp3H3NUToUaqJ8os69kqyixnTLzaLDGPZZCPe6k9Il9cTuFh46BGGnqwaOmEC
 QPhGD01LUfLUt1iawxbDvLjUx5b5pfO5RcmGYB4ynhgUJjKrK+Rn8i3uD5wqOppnptk2bDyiogo
 44VXa8bdnDtwrrsNIZzJWA6W63diJmY5MMlVYHZIPRqsnY5Lx2Oh8W+RQaJPjog8VDHS3XehGWz
 hhNaun3AHBbjZ+jNRP5pfztsyBP1cWb4RrYlt4D5O+rjeoM8NsMZClt6qFIhd12/06HognaxPDz
 YcLTyLrdObX+fWqhtXjm5kt5BCh/lUmym6EoH0lSsXEAMNLZngcVMjKlWtuUBpPQZn+pJgWqcKy
 MAtHtykohHyXsrilmMd/aI2T9yb8urxxXJHwBKX5LARrnBulGIKpW2WmkXaqL4g==
X-Received: by 2002:a05:620a:6893:b0:915:9efe:6de8 with SMTP id
 af79cd13be357-91f2a4ce2c8mr452645785a.58.1781779039582; 
 Thu, 18 Jun 2026 03:37:19 -0700 (PDT)
X-Received: by 2002:a05:620a:6893:b0:915:9efe:6de8 with SMTP id
 af79cd13be357-91f2a4ce2c8mr452642185a.58.1781779039185; 
 Thu, 18 Jun 2026 03:37:19 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c4240sm56792743f8f.27.2026.06.18.03.37.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 03:37:18 -0700 (PDT)
Message-ID: <75333211-7af1-4278-9610-53b5586d3450@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 12:37:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] system: Clarify legacy
 physical_memory_read/write/map/unmap API
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260616020839.19104-1-philmd@oss.qualcomm.com>
In-Reply-To: <20260616020839.19104-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5OCBTYWx0ZWRfX86kBbqNj2Jt3
 +SVJN2kAlsar+JGDtn4p2hZJLVGyfa/Yiv8GGTF+AvNma3turiZUamHsCF5HtPee5as8ZEdzy1Q
 /GlQFi41gWpf6bwVqDnHgRHglo0Tz4D33uSQAKkSJmLOO3/iWekc5+BcbPuzXEz6q0NV5sSs5oK
 YY/g2aqq+03TPPxCfzLroFRrOkdG0jePn5TkEmch7aDsnvCnMikA3UluiBtVgxgKsZrTApgaKzK
 r1wytdVEYngo0uGr7pbdYvg7046QHNgLmqupoLi22Z3/IMePJhFcYlNgBLOXHLtNyCDhsGzQmu6
 cRCMOIKm6n8r+eXj+Nlf6s1Ij/XnUlMw/HStDFcInT2jARgTgU8iEdaW+0cZs+bVLVUCAUrnzep
 muGNMaRo2MSqEa5Q7z+zXW5rC1Tx89LG+9YUfg4puyhj6uam8P9wHlbScaUyoyciz8bqvZKxwXj
 VxUzHQOAeJNVUOpB1Rg==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a33ca60 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=ZZ4eqRJCog10WMeL758A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: rsfSnEUi_6_Ab4BQKebpUSRXm8_D7sEq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5OCBTYWx0ZWRfX2godgOmqnPmT
 sVZ3uCANDMjxfV1AsQbTLWfGdE+PmNNPhl5NG3Y0HdfVSjso35t0Bg9SCDRdBo7xtJD+Yj7Fqs7
 vgPyIqgxwIjkH0Ky3E5EpLSVwCK8c9M=
X-Proofpoint-GUID: rsfSnEUi_6_Ab4BQKebpUSRXm8_D7sEq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180098
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

> Philippe Mathieu-Daudé (6):
>    system: Document cpu_physical_memory_*() declarations
>    accel/kvm: Replace legacy cpu_physical_memory_write() call
>    gdbstub/system: Replace legacy cpu_physical_memory_read/write() calls
>    target/s390x: Factor common s390_ipl_read/write() helpers
>    target/s390x: Replace legacy cpu_physical_memory_read/write() calls
>    system: Move cpu_physical_memory_*() declarations to
>      'system/physmem.h'

Queued, thanks.

