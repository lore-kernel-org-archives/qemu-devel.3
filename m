Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC920CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 14:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIoS5-0004mg-V7; Fri, 01 May 2026 10:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1wIoS2-0004m6-JL
 for qemu-devel@nongnu.org; Fri, 01 May 2026 10:02:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1wIoS0-0007MO-L8
 for qemu-devel@nongnu.org; Fri, 01 May 2026 10:02:42 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 641AXD1U1917217
 for <qemu-devel@nongnu.org>; Fri, 1 May 2026 14:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rAxGlN6LBx5CWos407s1kRn0kJe8vAyovt7wn46Wt+E=; b=eQ7NB0TTxUYZ4aLN
 PQiU9YPQxZLDvQG6hc3jFNXbtk78rFv93N3DDERL4mEaA7qA9xVnyKm/fiDiO30h
 F4M1+61uildr5qq+8OKOy+L2AjxixdGeO2FhyjYQKS13Ib7gVdW0vIeL7rBXZHbx
 bZhNQUox4F5gZ+U/yGAlGlMe4BEACny/0ufHTkSgZydUJcf6QA7Obg/Eyd4GPVqt
 3c3eXGDYVmdyVf62IvbG65YZYQOx26c8SKJPgAlDE7fCkcs0+jH7M9LuM6HjziOQ
 GlOfLA+O32JV+c6wglaEpSPu14EXwTdn6z/qzEA82CCKEKZvocA1a7pq+MCUchur
 2mJYIw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvhbthna4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 14:02:37 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c726f4019so2746161c88.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 07:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777644157; cv=none;
 d=google.com; s=arc-20240605;
 b=bo9HWFG16KeRkf4txt0GTI//XYQyqeKkBKN9M9kAsYSILky5nB0nISLjAsxZDUI5WO
 wyWR+44BfbFPTQm53Eg5LYGTYL4Z6AGG+Lrf+KiUcDpv1ARcoq6ydPAgnFTAxazGmL1v
 Hn5E8jh+vwoefxLcwt37MauhAust3AKEUaBSN13nmglZTxb/s4JBwzJu+H/kVHGhxmIm
 PCVmt7xMdFjQzHgvpV6G+1i+UYMULM0Tt2Yo3RrionNfrL1M5CYynwBe26QWKy+npHiZ
 KOTo+g6n0xaicwu+whba4zN/76bsDEwbE4qetiEdPvX5OxaLB1QVSAjngGZnsIZB0zPh
 czKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rAxGlN6LBx5CWos407s1kRn0kJe8vAyovt7wn46Wt+E=;
 fh=UlJxZ0HXcHPNuy+M2ZMN9mBTmZNiQT6KoZslCoDS7kU=;
 b=VbGq70XacmMLhk9GiTHZkV7/jO184ToFXRIqVPI9+oHK/cz4wndNRbLCWwzFgwFQ6z
 187WBpn0FsGbbJPZnWQbs8qK4gWCW8mmQAlczNHFDnpZKNQDI3esRFqf1w4LsX54y9fJ
 +XVXvRsAgUnP01oJCwO7gJhGUUPvzPZKlLEWSdmcAYyuBwF3R+Z3xtvFbjcmpDA6LH16
 rl+cc+plH4ClAXuWeXJ5sSAFDi9tETHx/Mut/nrkdZ0QllHRM6iEDhmjpdgSQriCpXNS
 2i0yLf5ADC7uJJRwEOPn79C1PB5BAeH6OHn34+3BAtfejmSsi/coRAOXCNr4VQIAaiqO
 vFTg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777644157; x=1778248957; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rAxGlN6LBx5CWos407s1kRn0kJe8vAyovt7wn46Wt+E=;
 b=QBLb+NJo7lts5F9K0SGniJN1ZV/6a1k0K2UT2DrsdF6sdP4q8hvL2V/uLis+WiyrgD
 rZHA3fBp6Vww5tBh0GQm/jfjhI776BZpuIpWnHWI8SqnHQoaIMiYeSVugweBIBM+V15H
 zHJTFMpY5sFM5h/ZpsE582o3QhSGQWd90Y17/wgID2N38cHk74F950UvemUJntzGMy9c
 psjHH85+UVIgkrx4MBOIRuOGBqDf/6Qp6pVf7An4lQ8X4+ghzphbd9GJ12OlZuTA/UUM
 FvMrE9urDdXx/rCyjY4V3vuSP4NUVQVDl6ouU0LrqMuS0cm/osMjha7ZhID+fjjcnsbT
 8HFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777644157; x=1778248957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rAxGlN6LBx5CWos407s1kRn0kJe8vAyovt7wn46Wt+E=;
 b=WR4Z/QvRHcpVZalAmqF+YBuyVOh91HNj/i5SKgQyA+exbf6mbRdBqJH2iO7mnztI1u
 5pDCHnvZBVIS6BUObjvYN1GOIlm5YyXBJFQT7WA3qi57Y1rM1gP+E6cREch/FDGQytgQ
 DhBztiuG2PYMerawZqFAYes9vxmUhqWpJEyiuGKDwU7bB1+wFUR4S+gZVcTR37QqgaA9
 6KVx6rJ1TQybfI8GeKhXH1iB018PZkB9eYaNtFs4XmEF5ip/nfMYp1+FUyIpCLe1Wenh
 0jT8yVaiQ46Fry6xe/5SgD0fBm+YyYE+Kov84I4yDk9LCOFXaSdg/McHEsYYvNNBsHRj
 QdCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/G9rQYfueOHTG88vRwvWFPqRvrjKm347RYk/QQC8mh14m3PKLPcKpEe8wZX14wVd390s2YTXiXTnn3@nongnu.org
X-Gm-Message-State: AOJu0YyxoSt4jfQgc6tUkSq5Iogefrmk/6//xpK6SgLuYSTsmG21Xxj5
 hvYy3LHdOqn4emlYs5SwvluHDVaRMxR/OnEPQ6L58OYz91RSxk0P+NTY3xP0AwRgHKuJHPThU2z
 RwfShAHOUdpPFGAHR62aZUyJy1ab5iYmLc2ZWoMm8Q9kPMrhy+sO+Ns+JCfw9gJ2Xk2Pjb8GIeD
 4kJnxvQhgPSFiTtKVNePHh6TPQBl0llCcy
X-Gm-Gg: AeBDietsfXZFsEFOmQF4vGApL9TtSk+DmM7Olw/x/i9L7gfic5X+aJTotCEAILkc/a4
 /j8QGmOyjhrWBgVpzTxvro/mqyJ/hQmAj5LQjPdu6+kC/CZiX750MHp4e5T/jaJKiDk/I9N2AOQ
 +lEudkd8Woo8Wv4p1G+cMCafDNpLeSQBmLODueVpGCwUUfGlbyDqu+MswCkOdXnCH4haZfY8crQ
 qsn6rq/BGfGyEVCH7Cn9OfpGHtP0K5VPF+NFWNvBfLnJu0grnU/pj2v/uxM00GUcHVyGYSjQfUt
 lnKBW34jJ351KAhXkWGc0TsooYJUrIwtasM=
X-Received: by 2002:a05:7022:f40b:b0:12d:c3fb:14a7 with SMTP id
 a92af1059eb24-12df8225f2fmr1522216c88.18.1777644156222; 
 Fri, 01 May 2026 07:02:36 -0700 (PDT)
X-Received: by 2002:a05:7022:f40b:b0:12d:c3fb:14a7 with SMTP id
 a92af1059eb24-12df8225f2fmr1522010c88.18.1777644154906; Fri, 01 May 2026
 07:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
 <20260424191129.1494381-4-daniel.barboza@oss.qualcomm.com>
 <CAKmqyKNZiA=rYVD6ighyFO+qmhdYVk=UgbaznBHrZ2yt1ZvOtA@mail.gmail.com>
In-Reply-To: <CAKmqyKNZiA=rYVD6ighyFO+qmhdYVk=UgbaznBHrZ2yt1ZvOtA@mail.gmail.com>
From: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Date: Fri, 1 May 2026 15:02:22 +0100
X-Gm-Features: AVHnY4Ia649qGmoT8S8M3cXqLoAWogZHODhQyihxCJQ4x7l45rh9FRDWvW590cQ
Message-ID: <CAD=n3R15=vCCgQQhEWXPRc91T-8a02JJs2t9s88dVDLqTi_QZw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] hw/riscv: server platform reference machine
To: Alistair Francis <alistair23@gmail.com>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Fei Wu <wu.fei9@sanechips.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=cP7QdFeN c=1 sm=1 tr=0 ts=69f4b27d cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=uTRCLKPYAAAA:8 a=Oy0uSXd22lWd2as0m0kA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=T-agBWn15iSmxapsA1lH:22
X-Proofpoint-ORIG-GUID: mRKGOkTYFjtfIDJLH6xPehYfiFkL50UI
X-Proofpoint-GUID: mRKGOkTYFjtfIDJLH6xPehYfiFkL50UI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDEzNSBTYWx0ZWRfXytaGcPixC/i3
 +HNSLmcDdGpYSxmn8jmqoJybgokmeOufYZSgsU0Gsp5OnpuxDr3R9GHT8yC2NWuxaio7GYXlOvO
 3CIMKy3Iukbur4hpky4mVMrhLY588MWG7JnCqIj0aTWE9fy9I+utaC20f5zEqPXPALkRshuF8ZX
 0E/Wn1M+M2h0qsjr4hbwyLlFaao1i3sjyjvTQg+rRCOZZYe0hsqf67jFi455Y8rW06G0qk6uIXc
 cqU2W64Dd0caTbYc+sW8F1fuPOuD8hEbaJtUZP49ie4ttXlffPrXkTizviWhrY1+IGAJyRzSm0W
 lceEIJM67k0oH8Vjz2dVgjEz+pf1APRb4hfwO0KEjMSWbN31mscfbhKXcLlAcPLT9rM4jL7v3YI
 mL/W3OjoUVGc72DaF8g1ER8B8x746tz9KKBo7lF+Zn3SR0jrOizhUwQXO7DHNWSsZJjGWiWUkAS
 6raAogCREIGizl6efNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010135
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=leif.lindholm@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Fri, 1 May 2026 at 04:28, Alistair Francis <alistair23@gmail.com> wrote:
> On Sat, Apr 25, 2026 at 5:13=E2=80=AFAM Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
> >
> > From: Fei Wu <wu.fei9@sanechips.com.cn>
> >
> > The RISC-V Server Platform specification [1] defines a standardized set
> > of hardware and software capabilities, that portable system software,
> > such as OS and hypervisors can rely on being present in a RISC-V server
> > platform.
> >
> > The main features included in this emulation are:
> >
> > - Based on riscv virt machine type;
> > - A new memory map as close as virt machine as possible;
> > - An always present IOMMU platform device (riscv-iommu-sys) that uses
> >   IRQs 36 to 39, one IRQ for queue, similar to the 'virt' board;
> > - AIA;
> > - PCIe AHCI;
> > - PCIe NIC;
> > - No virtio device;
> > - No fw_cfg device;
> > - No ACPI table provided;
> > - Only minimal device tree nodes.
>
> Can you describe why we actually need/want this? The virt machine
> already covers a lot of this and OSes and Hypervisors can pretty
> easily target that. I'm not clear what this buys us in QEMU. Maintaing
> a machine isn't that hard, but it would be nice to have a good reason
> to support it.

This is an equivalent to sbsa-ref for arm, and the reason is the same:
QEMU is very useful for development and testing (+CI) of firmware and
other software
targeting real hardware, whereas virt serves the purpose of being a
thin and light way
to spin up virtual machines or do less-hardware-centric kernel development.

> Also we need machine docs that describe why people should use this machin=
e.

(Yes, documenting this would be benefitial.)

> Also, why no ACPI and why device tree? The spec talks about ACPI
> tables, but I don't see a mention of device tree

Because of the abovementioned, the firmware would provide the ACPI support.

> >
> > [1] https://github.com/riscv-non-isa/riscv-server-platform
>
> The first line of the README says:
>
> """
> This document is capturing discussions at the Server Platform TG.
> These are not official specifications and everything in this document
> may change.
> """
>
> So this machine needs to start out with version support (like the ARM
> virt board)

We ended up not doing that for sbsa-ref, partially based on advice
from Peter (added to cc),
which I can't right now bring to mind in any great detail.

I would expect the same argument holds here. Peter?

But basically the development of this platform will be tracking
developments in various
specifications as they expand, as well as having hw features added to
it over time, as opposed
to providing a solid foundation to run virtual machines reliably
across generations of QEMU.

/
    Leif

