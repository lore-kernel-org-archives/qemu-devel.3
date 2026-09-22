Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E56C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x93yF-0007jL-Gj; Tue, 22 Sep 2026 13:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93yB-0007iF-26
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:07:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93y9-0004Gp-4M
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:07:50 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MG5rW7884523
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 17:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Yodo8FKkLRDwokUgHAxXrm1Z7rgg6LvvkpERUUT2ukQ=; b=oHTtLTC+XBIgZsZa
 hkFoDJsPkln/vP/E32ceTtvyIEyxlgfu/8YclSrtagWb6D3FZyKR1xDpwj5QK/3g
 vy2k5q7+7fu7iUv4FYqw27wlErAE8Y+6GG5OeFPxO7gKkHupyc2A+rDKsYpO2VUD
 Os1mcQe51r98K05fhAU9wlmvDWZx7KlqDXC/u9qwvzXknO7pTG2gRGFptSfCOJvT
 eFLgEfCUpUtcaYoNyH34Ms4JDIddR898Gz+Ed/jDgl3O2UPzjdpR7QmEkcWAVjJb
 0CSfPicwmI+Y74GvGuH5Uzy+Ff+hvwWcbyoWlLH4VY50IyC2MXdsMZzUWidyu6xc
 eo7eXg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guvw7g9q6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 17:07:45 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-982a39e0c4dso19742241.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790096865; x=1790701665; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Yodo8FKkLRDwokUgHAxXrm1Z7rgg6LvvkpERUUT2ukQ=;
 b=ctX9GcMGnwCNhpFZyVwnuFTFDNCCxbsaodgpJg/ktWbKpVsq4if1ln40t/mO3eL4TY
 3684amqEBHvMTtecPtIvBg12F8QVCE76WprHJqv3/9GpTvHDbWoM2Vms0OfYmewUrMJE
 Ocn7tduOnJRmVGJY0hurBnVFvKFHWqQ9dRWdaO0tUTDu2fh2f5xVu/E7pdJl0qD+x/m6
 DZEk6Birq9xWhLjltkfp87FvQh1tUGeqQalJmTwV8SYOmYd9x6mHGyxMQOdVWO7BbpKk
 tkc/IVr5TlIxaI5NgCbSVo3UWacto6WwKUSqfro6V5FLFgOcTM0NFfoEAvRHBa94yvLC
 UrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790096865; x=1790701665;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yodo8FKkLRDwokUgHAxXrm1Z7rgg6LvvkpERUUT2ukQ=;
 b=oTipXIF71h0R85i5jmrbzrpXCYGz+Ls2DiRwG+V4NwyioWCvh9EXv62WKgw6te8s0J
 pjp81RfrgM93SQjrd0kFUYp7YXnJsYriRQ+NPk8r9T2tlN+bb94Vadh5JmyhVqG4eGDn
 TfTU8nm7CYSj6Z5s6/excANsKP8KUg81lAG4HGbaP5vcqHVmcvtT80rS8q0hXE+k5z73
 tSf2GjBUzhhGhQXMXh7+/gr64cDHvma28wnS4pk0iY5u59/UdAn5zT+c6/I1adzmsDK1
 6mRzOiz+8Aec/3xQV6/niBuBn6R0WQ8Vc1F3a8v9T6C+7OyJ0/Mrv8kIY2wVTxYVAyua
 8R3Q==
X-Gm-Message-State: AFuF++lc+ztT7C1H0loVEplBaOv3o30KpPVJ0F1ts4SqF6n9GEvSTSyj
 FsNJOySvw2zSDYHeXF3TJPsba2Oa2Y5owWhT+HMiqBs8UkUjXlXkmJqR/I62lhPkyYPvmzX0uil
 URvxXG2RRiWec5bNeYpDAb8+rxhURoDQfWEmjAh5e5DW+GZwFRtokz8aCB2eWAST521tL
X-Gm-Gg: AYBFou33d05ZeXhRUABB5YDFKvja836l4XMPp3Zoo48OKQfa7I+b0vomnqiwy/OtucQ
 C2vJeXP+cFvP33yBt+n+8ywSVu13NMoN1sGCy1XP6LcsfMqWVB9pgvvt+w0zuG+aqxclyWtwPIS
 cqkygkWWXqoJm/Znj5PGtKgkw6l7+fB47wRXFHMnRG8iE8GksxwbrGcDcAODLBnMx173Uyf8wR/
 M8SmYeSon7UiPLWqO+UgLYn+bPipzb4BFSPVpSI3hm7AGWmxjq8bJfep++WacdG4NyCveGs2eFi
 4L5lVz5gY6YvJXaG4jo16/OyGxrmxjWiWlU7/RqH54A+LIu5SzLgJnlJHmSVudqjvsBQ0YtWEik
 HAVtgTLtD6a4LydjC2CYE
X-Received: by 2002:a05:6102:b0a:b0:7a7:198a:c2c4 with SMTP id
 ada2fe7eead31-7a7198ad402mr7413843137.34.1790096864830; 
 Tue, 22 Sep 2026 10:07:44 -0700 (PDT)
X-Received: by 2002:a05:6102:b0a:b0:7a7:198a:c2c4 with SMTP id
 ada2fe7eead31-7a7198ad402mr7413676137.34.1790096862921; 
 Tue, 22 Sep 2026 10:07:42 -0700 (PDT)
Received: from [10.251.40.67] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde18093csm6008625e9.3.2026.09.22.10.07.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 10:07:42 -0700 (PDT)
Message-ID: <65c2d2dc-2282-43bd-86b2-476730039915@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 19:07:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] accel/tcg: Make halt-to-exec transition explicit
 and remove cpu_exec_halt
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260922164936.15189-1-philmd@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260922164936.15189-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI1MCBTYWx0ZWRfX/Gt34TpC71uI
 OZIO7ylgI2hd6Sh37obqWZ15hNhd6oMTlFnLrmtPWp5zjehjpzhqEc4dLxbIwHXKC3C2xFRbclP
 5j0rJ/A6klqmCKeSHkO4RL/Q/Cd+ZTI=
X-Authority-Analysis: v=2.4 cv=ZYqIpcVA c=1 sm=1 tr=0 ts=6ab2b5e1 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=cA1g0hb8xVe5bm8CQ20A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: 1QaGLefE2qKrmAy3J08Nl-Q1zZnVDrza
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI1MCBTYWx0ZWRfXznlvZA7pjO9Z
 3KVeOljD5bWZRbGlA28wHoGAkLM1YuCbGT+4VF8ueZZ47UWEnWQWP0MSdnw+R1sMfHwdJqRlRt/
 LYKqjR2L8MMfziVhahZ7AaKBMFNaVnqWLEF8ubjbL+wKcmF40ZjMvtP2t6NUXMq8SuzEL1vv0N0
 QfF8dMzpxYXEJUnt8TxFTb0kwOsL2ofZLvKx6aVvbEmOwsvCsKxu8n8qrm2exZPeC3VLt6gQrz3
 iGOLxV89DQwuHtu1TwleTkHUJmKFRT8mtuZpjddghEkboSJPnEPlQCwkREkRwvFj70y8M5A54Mk
 mrRpQn21/xAVrpXzuMQ29iW7V2YrPw0WiJ0QpiE1kQwD96/drFr2SQBolaxpawouWyV8dSdruAN
 CtgjuwHJ9cOAd48BMsDCTsyPs2GJ17YrNQVXBmDYnVEjEel7RM76f5C4H1ueEfoy9sx8wvLLLi2
 bhC9+pP+iLqnrjCMrYQ==
X-Proofpoint-GUID: 1QaGLefE2qKrmAy3J08Nl-Q1zZnVDrza
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220250
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

On 2026-09-22 18:49, Philippe Mathieu-DaudÃ© wrote:
> Since v1:
> - Collected Richard R-b tags (sometimes commit description updated).
> - Documented the BQL and synchronization requirements of has_work().
> - Renamed the callbacks to poll_during_halt() and leaving_halt().
> - Addressed Peter's comments by removing racy halt-work assertions,
>    documenting the BQL contract, and explaining why x86 #DB delivery
>    through do_interrupt_all() is safe without the BQL.
> - Addressed Paolo's comments by making ARM PSCI state updates atomic,
>    kicking remote vCPUs after power-state changes, and ensuring x86
>    APIC polling runs before cpu_has_work() with the BQL held only
>    around APIC access.
> - Sanitized s390_cpu_get_state() for atomic accesses without BQL.
> 
> This series was inspired by a previous thread on the list [*].

I just realized I missed Paolo's comment on riscv :( Depending on
how this series review goes I'll amend or respin.
https://lore.kernel.org/qemu-devel/CABgObfZQb8FwDubg=pZk6nRSrUgdMxoDpRwG3Kd=GwpQeccLhg@mail.gmail.com/

> [*] https://lore.kernel.org/qemu-devel/CABgObfaDAhrpnVqQaKgG6uxPQe1YDu77YOsUEx9nqrN=3M2cGw@mail.gmail.com/

