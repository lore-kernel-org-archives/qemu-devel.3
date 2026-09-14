Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B154C88E67
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 05:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5zeS-0000G2-Q9; Mon, 14 Sep 2026 01:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x5zeO-0000Ft-FH
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:54:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x5zeM-0006Hv-E1
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:54:43 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E5j4nt2628351
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hHZECLCLMACc08/99VSgdJPYg6CQ9Y9w5aMWYOlHLjc=; b=b00KL/SymPV647pZ
 87Tl6qTbvfmdsKr/Aox9LlyCGagVZVV1oOXL1ZRjK6ldaU7XccppBMG3seDUVZfO
 mGjbiqxoMCTGO/GOEGePCAJw6Zvzun1zCDTXVA13+2RIvMcSQO+1t81qxX8TNqAi
 cMeV4E4zs6J1HJNvmYHvHLOd74QsGNB94LfNM45J+mMWKWr3Tfaw0mfDsMbU5BWn
 r0MbGhQqRtPQbiJAAfIPFzu7ZPv0EplraI4hmnHqk53Hcmc/ZgmZ5u6Lu4dSTRHy
 17okQ9uUSiChjN6DXPYVCtl3tACB6JABmcvYG6jVOsbJ2O2Zi/cKt38RZBkfFtVu
 mN16Ug==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmywh537q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:54:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so5167230a91.3
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 22:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789365279; x=1789970079; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hHZECLCLMACc08/99VSgdJPYg6CQ9Y9w5aMWYOlHLjc=;
 b=h+dEflozBERqGxYIPUL/d9cTQFKzFKNHDO4p4s4Q1uwIkaUcJV15ZNjJzr58O5RgOu
 AcgrzdkRUei8rPHp8rE/NZfBq0vr4WG4Qzu3s91zJZzEq/rjbDYXelEBa+PDEDoGvhm7
 TS/ipfD4e83enMOCZTTIRqfEb6CK+52rCxtWuGx2YLYomVQbFIAblNNcGRp7llXIakcE
 tBkJwjWRemNtbxJojLNayNLSLj3oiP+bHt/4QxlXcX/+eo2LQGoe2YtEmlogsP56hTwx
 VPEUg1wLBreZLsz+MIKwKJeP22GTskscRC+LyZwQsrbrlALJRe5V7GAvMWyLLITuYq1X
 XeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365279; x=1789970079;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hHZECLCLMACc08/99VSgdJPYg6CQ9Y9w5aMWYOlHLjc=;
 b=RCFDFMeypypyIjLRYIjkG53U+eol2QIhtBCCB8m1UYPiTG2EIZEA4iMFrIN6v05+aX
 +zHFyOKLB2Cdd1/N0x6Y8+dNXomnGy4MeWBYnK59OIOYAgGXmUZ+MJ/EVg1I65F3E6p6
 xJUjU6NchApm+xnM0GZMo0KHzUf3oVZU19pilQ2G/9TnRCiXQMK+92xcG746WB241+Wk
 wxRK9iD970x1PHahb2ur1WMcSnPQZpNSKC+BtwFP5QX4ABpPC5/Br9hMmiRkHQVTPuq1
 8aOCX2b2jCSzFC/iRuzePtxDA6V2cWRxC9/btMu0DFvh7Py4Fkn8l+bYqQBz0IYCGKjE
 ikFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLEhOZ22FZJOVyksEl4pM1Uxdo+CpFT/EJntDJRfLqYzl5MfATfi/zMbHbBYQxVCnVht7n0ByUlsO8@nongnu.org
X-Gm-Message-State: AFuF++k6Jqn295CyXlXWQm9jP4blpSzIvuhbQ1KpBGmNiZqmcNefX16Z
 Nq/Odk+JYXaP0xlpoXJBtVyQHIEhh0f0ZSsCEaa1cP/s9ZnnnDzhuGjcefJ6J2XhCu0CB0K925F
 whVkxSAqjpaUyA7jwtr2IKx1imm3WOxHz0bc+7Qx6JEP42064LOe/FGblEg==
X-Gm-Gg: AYBFou1EHBfqBixJSwmvpUW0IAhRrFNela6ykQcxP9JphAK0ExrLvShnbpSkltzrqfv
 24QittwnZdVSXzSklg+x/CNMIsfiJofaN6ODk0FgwXLFNp6d+Na7oLnPStOUeme1l3/+sv+3feQ
 RqUj53ALSxFMhjc+JqcB1OxoubYV7snV5LRILH68FjeDMVVVbbzXsBnlajJ92KJvpHWq1Wa5QeP
 yKGJGsSPCtxt8dsYyDoPa6g2SRZzLD4S+wEheW05lZvzyKT4Vn+z6esCCuzbcO59BXslgwtmk6J
 jstCONC473ZHvKIjwSEb/+qT6bX+0YFLZ2PBoO466tUXG8ufysJHcfv+6/T4GweRxqnfYsw8TSy
 nuVehj9TLs4j4Xg51sCmLvUwmU2jvxF6SNOQjLx1cvQtlqWTaILRvr7E=
X-Received: by 2002:a17:90b:2c88:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-39debf9d0a0mr2673087a91.10.1789365278666; 
 Sun, 13 Sep 2026 22:54:38 -0700 (PDT)
X-Received: by 2002:a17:90b:2c88:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-39debf9d0a0mr2673042a91.10.1789365278174; 
 Sun, 13 Sep 2026 22:54:38 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d995a42a5sm18603568a91.17.2026.09.13.22.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 22:54:37 -0700 (PDT)
Message-ID: <231c5426-b1b9-4465-b62d-a61dcb41c041@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 22:54:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: Eric Farman <farman@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
 <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QGunPxo6Z-zJCrRQ5JNefiKEYMWV2sTW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA4MSBTYWx0ZWRfX1bW7IZhZHqFi
 tA0V9gy8UGxCZfyTtId7tnMifsd+1EIQp1gBv+oXMSrhFMdz5dKHEiSm8GCINYaiosAfxUM6fy4
 zj2c6tCAeMd9ZDTWFN8JtLHGvfSYmX12mxvUM5ky5ziSOiiqWO1e4ldKd+WJUwy5h779DwdZDc/
 YW1lEd6oOwiZtD5OOaRe0LwP6ux2jJQemB4txOxNjJU22/HLpVahoSr42xYd8fm3Lmg84qPc8AT
 qrj9Fj0AcZtdNK4vmDBlSFGTtSSMZL4xarVaofHIpO84jAJhx17mE+jz6ZSZgHEzXLlSzBgfp85
 VuvWbgKfAoR2Sr6RcPeDzLAOieymb5QNlXM9B9541wS8JLpgJhDzybD7ZtgXkNVyUha8qkqxY8B
 9TUqOMnSv38ExL9GL7TQKem1Ng3pavGKtUA+MqEc6EM4eefvWrRZU0Vea2HxGPe4X66vaqxcSbj
 i6nF/Ob3yY/uvEkunbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA4MSBTYWx0ZWRfX5pQCdfr5tjjd
 HVNfDI+oIVtorveSuTN+/JEmjBn3i7h+xJ0aZUhZf7NHsXXmSrjq9pKU+DIoJx/yEthgqqD5JHr
 GwXgdwN2Ic0orJoGzAKSWZ4nXaRCqxo=
X-Proofpoint-ORIG-GUID: QGunPxo6Z-zJCrRQ5JNefiKEYMWV2sTW
X-Authority-Analysis: v=2.4 cv=PsUG/AM3 c=1 sm=1 tr=0 ts=6aa78c1f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=otcBQviB3wxpRpj5BnkA:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140081
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/13/26 9:57 PM, Paolo Bonzini wrote:
> 
> 
> Il ven 11 set 2026, 19:49 Alex Bennée <alex.bennee@linaro.org 
> <mailto:alex.bennee@linaro.org>> ha scritto:
> 
>     Thanks for pointing this out. I hadn't noticed the issue as I guess we
>     don't build firmware in the CI. That said on my current tree:
> 
>       cd /home/alex/lsrc/qemu.git/builds/all/pc-bios/s390-ccw
>       make
>       -Wno-stringop-overflow detected
>       -fno-stack-protector detected
>       -Wno-array-bounds detected
>       -Wno-gnu detected
>       -march=z900 detected
>       Assembling start.o
>       Compiling main.o
>       Compiling bootmap.o
>       Compiling jump2ipl.o
>       Compiling sclp.o
>       Compiling menu.o
>       Compiling netmain.o
>       Compiling virtio.o
>       Compiling virtio-net.o
>       Compiling virtio-scsi.o
>       Compiling virtio-blkdev.o
>       Compiling cio.o
>       Compiling dasd-ipl.o
>       Compiling virtio-ccw.o
>       Compiling clp.o
>       Compiling pci.o
>       Compiling virtio-pci.o
>       Compiling secure-ipl.o
>       Linking s390-ccw.elf
>       Stripping s390-ccw.elf into s390-ccw.img
> 
>     So it seems to be working. How do you usually invoke the build?
> 
>      > Fearing the worst, I started converting to use meson directly (which
>      > is probably a noble goal anyway). I still don't have a workable
>     image,
>      > as inheriting the common meson cc/ld flags exposes a bunch of other
>      > problems. Will keep poking, but I'd like to know if there's an
>      > easier/better option here?
> 
>     I suspect the easiest way would be to move the rom specific cross
>     compiler detection into a configure script within pc-bios. Paolo wdyt?
> 
> 
> I would prefer to revert this and load the config file from meson instead.
> 
> Paolo
>

I would be happy to see only the related part reverted if possible, and 
not all the patch. That said, no strong opinion, just a preference to 
avoid seeing people start depending on this config file for other 
things, instead of doing things properly in meson.

> 
> 
>      >
>      > Thanks,
>      > Eric
> 
>     -- 
>     Alex Bennée
>     Virtualisation Tech Lead @ Linaro
> 

Regards,
Pierrick

