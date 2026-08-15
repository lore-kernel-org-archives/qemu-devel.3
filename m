Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B13C5AD5A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 14:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvFGP-0000vp-Dw; Sat, 15 Aug 2026 10:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvFG8-0000sZ-F7
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:21:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvFG2-0000ar-UU
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:21:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67FDNrf9666775
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 14:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3tTNb83ZfsPlLrEZOMHb532+2LPJxmEhmRRznI7zAaw=; b=AuVc3+W+BPHrNbtO
 7em+Bi7SZ9MVrUscweTHoSAvc86uKgaOhQNJMo3Kkjg+oNDqcKmv/hO01CXZSyK+
 YAEWWw3k2W/eQ6ytSxGoY/H+pBs8CAnYrB06Nt6WwftjnOzYT+wpd1YS88F+oKI0
 I6L10UhYeu1ARWaM4d9evnUYyltSCs8DKqFnaxc5nAAErIwO+GWaV7FLFe5SMB9Y
 wCks4ZSNY4kIZXX8dnri9mQxz5bXacVm3lVQzNfCdMDUq0KB1kxHvb2gF1qRcima
 FfdIAHkxDKc92wRnnPrW2PtI1+UzXYSMAQObdxzrGdbAO7k06Hi5KPO7P/2Lghn6
 jCtP+w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2gheh6ac-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 14:21:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5276aa86d00so21083761cf.2
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786803667; x=1787408467; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3tTNb83ZfsPlLrEZOMHb532+2LPJxmEhmRRznI7zAaw=;
 b=XsmwLxDvB4mc79i7Hbgg614GPDJNlPZ4arjwZAc+7rXx4MvMRTVaPygyKkeWlAhao/
 8JkzR8Y0fGab+fgOQ7siZil5E/GKmmoKmqzxQwL8qwuZU7Xoh1uIJI9Iurkk/ZKIQ1Z6
 Vtw0d572UVRfAiA79oeVzgqJNtMCTow/NrfAEG+nxbnYvDO11BlOq0Mrk4cOjKwzwl6+
 NSrAVuyGjHgvyQFScgjH+9jng9oqtUDZKANz6Cy3zL58yDfJFwcufECg7gcDtospHTRR
 6zoBPYEvw59vLIDLIhfM/Q55OVBH8iRlQ1GHPBSLcoCT5iEo9A5BSjsmyIKTU+PQH43L
 LR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786803667; x=1787408467;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3tTNb83ZfsPlLrEZOMHb532+2LPJxmEhmRRznI7zAaw=;
 b=GzsPTe+kv04vt5E7+9eF/tu8jg/WlucheIX5jWR2a72E71hxnD84jqeJPLwuqwaaX6
 t8Q0DIrxRpjR+NBGFeeflipM1dyndhG6gxmBnuBPsxez0fw39WodZKb+CWF2DxdDPmFQ
 npqsuLSdyIOsxJ5Bc0e2yP8141RxqFP0yV4H/lT1+71PXMXDvBcOQ7ohISgDUits3bB4
 cbClZGCNN/TVj/NXUVT16DnKuTqjAKoEOkMZuj5HCAdXVOYN2fVIokvbyf5pldIghKg8
 HxR/sBy2KEg8uNWfTaFtvomIKXkNhXduWBKBY/7nrT2RmRGe2ErBmPki6Bm2YW1lgDob
 Q8Ww==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0ikVpmSPjoZLu21Agr9KeOQAwWsmIM9mmRFxMwoYqDnUv/yVPzboE9DtOD7Y3pE4ofIfqguu+fidt@nongnu.org
X-Gm-Message-State: AOJu0YyPW9nLkEVqOUDnSG3CkxLOuDmOycdzGkXDAsOHYypEPLePKb71
 DngaA1Wljf5wDoj/WJb+QtM3PWK261G5FHZPoXvgXHyQuKphiKK1mzeQGlgEjUH4eLufDJUSDag
 EckgjTJz4GkpIxP2ywfXNnxmLtvd+aKvvE4obP5Cw6RW4IGbQdRzSAFpcaQ==
X-Gm-Gg: AR+sD11dvSiGQoISZS3VJ9Vpto4i2O1Amzig5Mb1JeCqtgZbePVaYCcMZGMwr6TwHPU
 skk6PuQ86uLXvvU2PWCUHWIfxEn/qj1YUFhYMJrSWQUYCwdhIGOf8m+HANuUFWZvbHeL3dB4dC+
 V8TzU4mImWflCLaDl4dbdH1tSHGxwW4QbUtwisBBu3eGr8ic4DlA4jYLD+LwQ5DQUU4HPxZKT+S
 QuJohWYd2Rjvs/1VA5Q5p2wBvJkJ5pGkjGIOta1S9EptsyUwDPebt9nxnu1NLqt99Js1cJOJInd
 Cu4otoDLrbvfLXW6pO/MueyW3SX6lsIGzQo7wY1uDuTzHSvAY/NNfTkrJrzR49huMyvVniV9W5x
 FnUK6CPBr5vcdb2nlmxc9jp+m1n2Pk2wtdyQ=
X-Received: by 2002:a05:622a:1787:b0:51c:f8f:13d with SMTP id
 d75a77b69052e-52d8558f7e9mr148251161cf.37.1786803666714; 
 Sat, 15 Aug 2026 07:21:06 -0700 (PDT)
X-Received: by 2002:a05:622a:1787:b0:51c:f8f:13d with SMTP id
 d75a77b69052e-52d8558f7e9mr148250541cf.37.1786803666240; 
 Sat, 15 Aug 2026 07:21:06 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899afa39sm138334435e9.2.2026.08.15.07.21.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 07:21:05 -0700 (PDT)
Message-ID: <e8f95158-dfea-4858-aa66-47693add06d9@oss.qualcomm.com>
Date: Sat, 15 Aug 2026 16:21:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/26] hw/sd: sdhci: Resume version 4 SDMA at buffer
 boundaries
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, qemu-block@nongnu.org
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-12-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723151853.2143177-12-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EKc2FVZC c=1 sm=1 tr=0 ts=6a8075d3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
 a=dawVfQjAaf238kedN5IG:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEwMyBTYWx0ZWRfX4EB49O0qo8N6
 k8Tbnd9KxdrwT/ME9g6x0Uq2kQdP6TkgzmF8jvPvQIqd54+fXPvi6Ekgpza2U9Tpdpf9sOPkv9r
 zdar9RvyLUu0rnUq15iLZ12TsyUr74s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEwMyBTYWx0ZWRfX1Qlnm6/y7HPF
 0/wRGz/jp8mPbVsfwVR9Y6FGTofBS3tqXGYeIclYs0iX+8YUNo8vI3bLlNTjapD2gZBhV/Jh1Zt
 s2idh//qLgUnVDtaOdAgJdctCP9qTFE6mm2Kj0gOLr6NBxifo27Z6CfNgYsut1LwvTIle40nDGb
 YEuu3YpA2Y4QwZnWKVTixr4JK53lt1F7wlmDEzNL07DI7wy3Uz458Z2T/5lgVZhkK+E0SJaMuel
 mqsz6BT+7NqQfXaWGUxeI2eVE05PbVWXHT3efmLqjOYnQNqDwkhhOvJmaGLU0eEXtPNpJojeZMw
 lnzD2Jhwa6X/8NW9sQXuK3R65QNekKyP6GrzMOZVSUdIdrW4FPr48+/7uV2Kb9TqIZ+stKGgz+F
 qt19EWgykM1LjiIggH14l0L8E4SPcEgdH+kGgrXRuX43dXNqVNc06uKHPhzAZEJ8wTtH+llG/Xy
 pBtX6UL6TFHXVB6TrcQ==
X-Proofpoint-GUID: mxyLct24FGOOwAu_kfHvq7L3iDLVl5M-
X-Proofpoint-ORIG-GUID: mxyLct24FGOOwAu_kfHvq7L3iDLVl5M-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608150103
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

On 23/7/26 17:18, Bin Meng wrote:
> Version 4 SDMA selects its system address from the registers also named
> as the ADMA System Address registers. Updating those registers does not
> resume a transfer that stopped at the configured SDMA buffer boundary.
> 
> Resume 32-bit addressing after an access completes the lower 32 bits of
> the ADMA System Address register. For 64-bit addressing, wait until an
> access completes the upper 32 bits so software can update the low half
> before the high half without starting from a mixed address.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   hw/sd/sdhci.c | 32 ++++++++++++++++++++++++++------
>   1 file changed, 26 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

