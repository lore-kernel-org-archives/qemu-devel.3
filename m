Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C547606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=POY2GIY/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MxL07SiP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTLzB-0002vT-Oe; Tue, 17 Nov 2026 11:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTLz7-0002vH-1e
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 11:24:41 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTLz4-0002FC-Vw
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 11:24:40 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFQXcZ4169474
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 16:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mNbcX628NHGzkbM8hsfmmjv7pentYVP6T2ZZCY5rLjM=; b=POY2GIY/H+6YQELy
 viPTZSDfCYgIzXoVbOkYdY4aMc1KCKyQp57Xia5NajnSuVfo0nevfFCG3uMP3xkr
 Rmnmxc8wL940iOej6vHDcz/lnAtuTKeOdEUZ+pEV5ChcpmEri4d2qOS4l8W0C79P
 LNbuhKL/YaV0LIxEzdoxnnJjlSwIQPK6BUlBES2JqJvGg0SHib+hetb2pujM7pv8
 ToyDwyR0RQDsCdMYBGr2yPR7+lph7BDK4tB1dc+bUL16f29aBB5QgWykvnNVtSED
 MlUhJvBDpV5FCfkCODuRRTBgenhSO/c39zBTPAsaXrzbeuamiNsi0hpz/wO6dH/m
 +gFKkg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0hve2epx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 16:24:36 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7d2d60a8bf5so699125137.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 08:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794932675; x=1795537475; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mNbcX628NHGzkbM8hsfmmjv7pentYVP6T2ZZCY5rLjM=;
 b=MxL07SiPMrOtlEMb4N6k4wRw0egJhWaAcdUK6aSEPwrAtf4VPePp5SVIGe9HClrpYI
 W3OIy4fodWWWOnyDTOk1Vx2k5IN0VIks++ZyfAlBGwZZ6SI3ngVbnyc8twOy125du58x
 MMNCjbriJKSxkuij7e3/Yf/dkw8ysWoq1Y1u3aAYkWqNhoXE2X8s3VUiwxPUp2jtQHik
 Yfc57rIvYky7duoBcmizn9fFt8RgD4hhb7QntPZ8n9Wujaz8abPhEn4ne0riPSKfy4CR
 1oDWUdJIJVTRzCexo9ggAysPPL6olvBJuovxqFUlvqBfw/KPndEHwUaOM8jAG1mlcE2q
 MJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794932675; x=1795537475;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mNbcX628NHGzkbM8hsfmmjv7pentYVP6T2ZZCY5rLjM=;
 b=zgxKcrwKc8UQCtbH5ib3fmYkslLFVCvsiJ8LObS/BEiElE1M1H/ITS8ktQoymXqnDd
 NIswMKeWt3fJNRDB2WZ+bFSXtcGtCMlvZieuvUndYdHF1UwnLhzNL7Eq7NksNUTrIAVW
 pybINcq3HnDfGkQeGA1ZJFwDM2JZChEOqsUmGygGeyLrUAmUIefvKle+E/iL2TtbqZD1
 eCOWa/DkTTSV315NQiSaxQrbjM8HEHLaJ6lnw5wsshrsfdvli5Vb4zZMhXkBCUwxHKD7
 ubPJgtWa4oNsfQcth0z498HEuKynxrg/Zk7Gny/EjYV6CwTzsW8jyg2/0Pe8k2S6N570
 4yVg==
X-Forwarded-Encrypted: i=1;
 AL+hErFUteMWEWIkzOMI2OvOqIBJfBqheFmiULVwhD5OiVISX9+gsqB37OrAF5hmobD5cVTDtzsqc73xZmbv@nongnu.org
X-Gm-Message-State: APuU4Z8RmbpK2k87g2zau9BuJByHilMPenZKO7PFv2qHCoPL5jufd1D3
 D7z9y8JREmyHn5YjeBPKfCTruRgaQ05FZkgR8pJBS/k0A9wFX2Uo9vzteHRW2ymTfPcXUyeCNOH
 RAQz0glKzk4gBaT4XzuemctylEbKxfTIGza19XG5lGx+PxaOJ43ec86VdUw==
X-Gm-Gg: AYBFou2pkU/L+QaZM6Z86znyZZekFDCKj4oqiH7EgmrPMS5xKfeG/bx28h2+x91RbxJ
 SgshTaGAH6JVPyzIx+BLMVj/egzhmbdie4S+zoS3d3/+dz3CcQdEqYuqCcuWD46oD/eE4YptBm8
 YQezVF36FK4x+RZWN1MENgUBhsLDaBo0onGTLLPCzUFMl09v2ePLXLqZR0m20jh5vtn1vmuK1GU
 KuDGJPezFWgG6+FjqpNW0kW2HZn3MklKxigB/R3KFz9E23HVKYYTU8YKIpJRTDzJuHHbYjYRsoj
 8C/8A6fWP4G86ybDeNfQjCIb7fATUEz/Yhk6LbgnlyKX6ORnWM+gBF4OU3HqnhPUmbhQ13k8uGE
 C6swfKrlK0hMK7zcPBqzgGkDk7jMRZRllEBYx/2KUjA10KWkEus9Ppfk1HrprLZ1DMbbqvjqRxG
 EDCCq7rts=
X-Received: by 2002:a05:6102:c46:b0:7d2:da5c:6f73 with SMTP id
 ada2fe7eead31-7d64d81ec2cmr4754146137.26.1794932674715; 
 Tue, 17 Nov 2026 08:24:34 -0800 (PST)
X-Received: by 2002:a05:6102:c46:b0:7d2:da5c:6f73 with SMTP id
 ada2fe7eead31-7d64d81ec2cmr4754137137.26.1794932674157; 
 Tue, 17 Nov 2026 08:24:34 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb70105a98sm134812715e9.5.2026.11.17.08.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 08:24:33 -0800 (PST)
Message-ID: <f385f947-aa36-4e13-aac4-1602b4844b76@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 17:24:32 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 14/15] target/i386/tcg: treat ENTER's size operand as
 unsigned
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: z Y <w1355457260@gmail.com>
References: <20261117133750.322253-1-pbonzini@redhat.com>
 <20261117133750.322253-15-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261117133750.322253-15-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2NSBTYWx0ZWRfX5vQQNlMMSpaN
 Lieqi36bJXVd0FnXElz3odgSh6xDaDgCBEDmlbjSyiJ2XzK+MzQ89DmNxlpFO2DgI1j7viP/WDY
 FUuhbAJcfbwKtPlm+YG9irc6VdoAIYA=
X-Proofpoint-GUID: EjtERrS7YFIudkg3vE8ytREQrWcpICgs
X-Proofpoint-ORIG-GUID: EjtERrS7YFIudkg3vE8ytREQrWcpICgs
X-Authority-Analysis: v=2.4 cv=dqhOmFg4 c=1 sm=1 tr=0 ts=6afc7fc4 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=viYH7b9QVlzJwkHlwBUA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2NSBTYWx0ZWRfX9asvLFYGqIKr
 F/ItPGhHFbZyf4tHthpZaJMgDlWKnU4/gHBauHPc4aSVTcYzflKAnfVtiHfUzgcUbaVttGbEWpS
 JCqJmxUS5vtL0M6YGo4AedWZXhSOcMYlWZD7jFbTS3ALTZZ6/feTlsS4nGr4pDZJB1m8NAb7Z0w
 Y+CAcWmkxT2m8N/m79ZaU01kNk9Q4CgF42nG9sxKxHIVaSi1vYOs+b2kx++GsXYd0Gna/LxeH8e
 8CIhYn9KL4U4LXmBZfCxKFL9EiuV2jvvyNen/KDUGpt1aMtQzYJPwe7saPTIUVU91zMVjapdd+J
 PfjoYFr/PocPQLpI116Sxaeuib5Kc3sTZbx5UqyiOBnynDZZmnDmkWzqUPuEz8KZ4Moek0tdca4
 wJiZ2YFlvssgWJ0oROg8M5T6qUfb9bwBTeJKG+nSJwPKh6HZvJ1NlTzfnoJoDZ6N7sDHJF51Ap0
 0vb4mI3IdPzr+RFvD7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170065
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17/11/26 14:37, Paolo Bonzini wrote:
> From: z Y <w1355457260@gmail.com>

Zixin Wang <w1355457260@gmail.com> as S-o-b?

> 
> The first immediate operand of ENTER is the size of the dynamic storage
> area and is unsigned.  Decoding it as a signed immediate sign-extends
> values with bit 15 set, moving the stack pointer in the wrong direction.
> 
> Decode it with I_unsigned and add a regression test covering 32-bit and
> 64-bit guests.
> 
> Tested with a minimal x86_64-linux-user build; the new test fails before
> the change and passes after it.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4643
> Signed-off-by: Zixin Wang <w1355457260@gmail.com>
> Link: https://lore.kernel.org/r/CABG6VKODisrETOuH5thhimg_DtJLH+1wmARKL5OsoND5Qse_TA@mail.gmail.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c      |  2 +-
>   tests/tcg/i386/test-i386-enter.c | 42 ++++++++++++++++++++++++++++++++
>   target/i386/tcg/decode-new.c.inc |  2 +-
>   tests/tcg/i386/meson.build       |  1 +
>   tests/tcg/x86_64/meson.build     |  1 +
>   5 files changed, 46 insertions(+), 2 deletions(-)
>   create mode 100644 tests/tcg/i386/test-i386-enter.c


