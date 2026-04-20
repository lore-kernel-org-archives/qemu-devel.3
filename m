Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D368BF5A8AA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 18:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEt7j-00065L-Sy; Mon, 20 Apr 2026 14:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wEt7W-00062I-ED
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 14:13:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wEt7U-0006ZR-99
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 14:13:17 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KBwKLo3212182
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 18:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pQ4MKGjtiAWA0kTUzX5p2DX30SXFiIW1T6G+Ccj4H5w=; b=jvY9I+grKdSJBq8k
 1TOd0iS4oxs6+nDeihljNote6VMs/5pzNUhGlJNpJ39PY6kdo6Udo1KUfx7gvrCD
 xGyXcdrj8KynsL8WB6H8v1WdUVYXabEvr2towrFrDR5bCeRn80H2QmSOTFSYLEgP
 /jQBy6/BNGSLYajmR0nADPSy3+gzvOWfxG7SFt1AoA4eaAHNMnB2QeBvSgVlxjCG
 KiTubfyg9kdgpmHS26AeyeT7Kgcyl6/UjgDafsWDmBPU362HAjFhgNTqsSk+43KZ
 74/1bIQTUmGTkx6XHYwEr7h8jhrIOaP6/v5vbl2IF64G80mmB88S+OUMBubNEGde
 u1Yx7g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfcfjqgb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 18:13:11 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c91ef7009so3362941c88.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 11:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776708790; cv=none;
 d=google.com; s=arc-20240605;
 b=b8y9TdO20BTrrPZuCqDtjmcsnzkm0l1iiwMBAu/XuCvPDAR9bEa/XsXVhhd5HpRdcB
 SUxggnDkmUTglxCZHmBwUxE75UY9wmmaxae+jaN5HQURn3j2WC/+JCM/13wVr6Ps66TF
 Gt5OfAtLS2xrOqx7O49h9B9qaQXxkYYHBmhAm+wBNj5glaH7jMimtK1u4qzaiHlGllWZ
 tZWAZ+h8xBm3YHhwIdeNSYPhmjDdBbH4iQYiV9vZVIysXS2Y3rpt6k9BUWFJUJ0nQviI
 B0Lpr40Q2yJLbD6iO8/jN3vcdzqbkWK8sdsNffQg2cpQdkFdFHLEredhbPGVSmiWF4KN
 GYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pQ4MKGjtiAWA0kTUzX5p2DX30SXFiIW1T6G+Ccj4H5w=;
 fh=rochm7WjibBxeybjt7QSvri68svLKjklZ3oLgs7fuxk=;
 b=P9tdKBIAYIXE5vPPEe5NHQD1qRZ+TwmOMXye+puAkWS7ZHLnOwkUOupT7npwUtHwgk
 1vcfGz8shSXxbI46zOiAQaCBV/OKDQKgqLXr5KjmJJPjpTAy6SYWGTAkp1X9TYbYBVFl
 MmkXo9/NTlEaHK21MRN+BEAGYPaxkKc+aagqaL1bJGyWlB9bkhQcejB8WpZQmL8DQp3G
 10EMZ9w4MU7mSlIP/O1LGsdfqyrUdVftVkBrBVNUnJ2qKVq54waB/I2IWftw/JizMfdc
 DeuV9nZ4RCSR2o35Eq9Ox3xFWrMi2LVDZv5w2Q38VjlAq1zZIL/OwZh6USVipMyodcgd
 1iUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776708790; x=1777313590; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pQ4MKGjtiAWA0kTUzX5p2DX30SXFiIW1T6G+Ccj4H5w=;
 b=jQXjEx9xA6OwRQ3xu9aGpFS22JWf+bnOgSNcijWFCXNQ7dFdwNf+lslsPZVCFFdWfn
 /scOHQjatppDhaQCXLbAamiFfSUjP/qw6KtSOWpckn/mLHCF4e3jCsClkMZnHiQk5Ww7
 xreG9vYmq30aTaZVn0retKd18lmrwofkffbVrF7pjKqVpaAJfwFXNPYAIGKoJnnKg//+
 4yHVWGMFsx/TqPF2tG03FM7HbKL/V2WBMRz4A5JD72UjFWDogBtksVeDZ6HRthLIzCTF
 SwqGzlSw+j65xlmGB+HGbAHI4ecWRbeMk8qX+VScegQ1igkfsGnFLkF+nKz8EMVSCGCQ
 D80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776708790; x=1777313590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pQ4MKGjtiAWA0kTUzX5p2DX30SXFiIW1T6G+Ccj4H5w=;
 b=PTM5NMmkyurUAyZ1Ohv5w12GWA0xhNvpGLwtErNecbfVduo1aTLClmiZmBkLSZkn+X
 PkzxkBoaacAw7jRwVlGkrbO+DQ2vWvlPbwPz1ZQBdY34qmI8Nh+vN6vN/UTNSvmWJVdi
 1F+cPtdujFconGwyN++7P3wlgtKmmpAVxr033jd/mKqVyAo10/bzD6JVZJ81W9OPsXjj
 mYfgPMcD4VbHrTfBxGfmOCGL/GkH1LsgGgUsmMjxrGqo3CaWBuTnpawt/Ue+7Hl9lcwh
 2W2lWtdHr0G15bmmNk8DjWgmi+o7IUO51+0r14c8jZCJrf96MKc/mY51O1SpTSEf2eXS
 rr9Q==
X-Gm-Message-State: AOJu0Yz00edeL67n0PWjdOnKQYqeKvZELDklbroTXTkw7xzyDSlOIB4o
 UGfV5SVIpj4on9yOdTCXEYM+6nf34MxMvbgk9HNLtBCr1wuQg8uhGw19l1yx8R54rjodDer7s/l
 7pdEjUuSjcXG7ZDLTH3+zvGFxSYtifNDq2Qemvg2/eBnf9gNnQnUqRPhM9KNCHLlAX1No61lh5w
 Py2/XQNetksgGI8ryLNDV0VWd5uUg/0H5h
X-Gm-Gg: AeBDievBM3t7tQkXK/WUw/ao2/XFv05DopDOqCgsP1N/88ZEdHwZxpGrvZuzisn7uEh
 FmTthYaYvbOJcjw6HwQJIMFtrLamh2C2BE9FFcX2gBPbTFBf5p7Vcd4SnOhfdmnVGVmLJMng2ze
 1tBNP8qpSUvSm0FidCSnVjcWIcxRld0MLRU2b6o/61F3IpJADcXYjNXbwiYE47m7JuK+mn69Duk
 iUZRbGbDkU6icmziA==
X-Received: by 2002:a05:7022:388f:b0:123:348d:8576 with SMTP id
 a92af1059eb24-12c73f6d905mr8560575c88.6.1776708790240; 
 Mon, 20 Apr 2026 11:13:10 -0700 (PDT)
X-Received: by 2002:a05:7022:388f:b0:123:348d:8576 with SMTP id
 a92af1059eb24-12c73f6d905mr8560548c88.6.1776708789656; Mon, 20 Apr 2026
 11:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
 <20260401152657.314902-38-brian.cain@oss.qualcomm.com>
 <ebd8b10e-90d9-4267-b117-9e9a8a564cf5@oss.qualcomm.com>
In-Reply-To: <ebd8b10e-90d9-4267-b117-9e9a8a564cf5@oss.qualcomm.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 13:12:51 -0500
X-Gm-Features: AQROBzBU7xvM4PLI00yCtlTf1ldmQ3o-rmvdkQvkpB-BnqKtIJuSxTjPKG2sork
Message-ID: <CAEqNhNamfBvyhE4JFp5xDwgB3S6dxN8UnL04-VM2juKoTY2OzQ@mail.gmail.com>
Subject: Re: [PATCH v6 37/37] target/hexagon: Add hex_interrupts support
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>, Michael Lambert <mlambert@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE3NiBTYWx0ZWRfX+w07qmlnnxr6
 yH637I/SXz9OebcHB6Wv1m0YVQSu0lHNMhjRuzNN7Gq/oDdT4TMOPthgXWLgWtpOGeh3gVzH2BJ
 rj6DXFJXmmGyorvp2jBTi1s7+ajyuNQxfK/ZRlYdg4vht/pAmkzdf0wO4oJB41BDsKsGQypk5xp
 LLQbSGHewBnDw9GCMVRvEkmCixzftSjOeWVRUUa5xq8YDSbWaZOTVUROe7du7HqagYOW5OvtPXK
 R1tWmsg2KG0AEaQK0g91x51P+k+++tMqk/8nId+zfxzZN/m6RXe2qcs3xH9buEASJJ6sY3HTPeZ
 zVLHZ/Atsz3auWc2OzDRUZMAH81E9a1Hrdw38yYnh6SxlyvLh9cGmfnbZmICJREEUxwvlFHNGBD
 3lj77PT7On6qv6ky8VzQndxPJomGeeHBG/0bVjKsstxxDX5yPBmn0+RJZbxrs2KuHJaYyTQs5Ml
 WxOQtsVMt0fU8a+KW6A==
X-Proofpoint-ORIG-GUID: GzDEIxMH5PLt4leu0jdrIiituvTDbLas
X-Proofpoint-GUID: GzDEIxMH5PLt4leu0jdrIiituvTDbLas
X-Authority-Analysis: v=2.4 cv=L+ItheT8 c=1 sm=1 tr=0 ts=69e66cb7 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=qEcrYFqeuF9CymC7Z6AA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200176
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Mon, Apr 20, 2026 at 12:54=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 4/1/2026 8:26 AM, Brian Cain wrote:
> > From: Brian Cain <bcain@quicinc.com>
> >
> > Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > Co-authored-by: Sid Manning <sidneym@quicinc.com>
> > Co-authored-by: Michael Lambert <mlambert@quicinc.com>
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > ---
> >   target/hexagon/cpu.h            |   2 +
> >   target/hexagon/hex_interrupts.h |  15 ++
> >   target/hexagon/cpu.c            |   4 +
> >   target/hexagon/hex_interrupts.c | 379 +++++++++++++++++++++++++++++++=
+
> >   4 files changed, 400 insertions(+)
> >   create mode 100644 target/hexagon/hex_interrupts.h
> >   create mode 100644 target/hexagon/hex_interrupts.c
> >
> > diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> > index c4fac9c2d38..3049b5a411a 100644
> > --- a/target/hexagon/cpu.h
> > +++ b/target/hexagon/cpu.h
> > @@ -196,6 +196,8 @@ struct ArchCPU {
> >       bool short_circuit;
> >   #ifndef CONFIG_USER_ONLY
> >       HexagonTLBState *tlb;
> > +    uint32_t boot_addr;
> > +    HexagonGlobalRegState *globalregs;
> >       uint32_t htid;
> >   #endif
> >   };
> > diff --git a/target/hexagon/hex_interrupts.h b/target/hexagon/hex_inter=
rupts.h
> > new file mode 100644
> > index 00000000000..6b6f5403633
> > --- /dev/null
> > +++ b/target/hexagon/hex_interrupts.h
> > @@ -0,0 +1,15 @@
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#ifndef HEX_INTERRUPTS_H
> > +#define HEX_INTERRUPTS_H
> > +
> > +bool hex_check_interrupts(CPUHexagonState *env);
> > +void hex_clear_interrupts(CPUHexagonState *env, uint32_t mask, uint32_=
t type);
> > +void hex_raise_interrupts(CPUHexagonState *env, uint32_t mask, uint32_=
t type);
> > +void hex_interrupt_update(CPUHexagonState *env);
> > +
> > +#endif
> > diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> > index 4e9c65f785a..9ae8e104043 100644
> > --- a/target/hexagon/cpu.c
> > +++ b/target/hexagon/cpu.c
> > @@ -59,6 +59,9 @@ static ObjectClass *hexagon_cpu_class_by_name(const c=
har *cpu_model)
> >
> >   static const Property hexagon_cpu_properties[] =3D {
> >   #if !defined(CONFIG_USER_ONLY)
> > +    DEFINE_PROP_UINT32("exec-start-addr", HexagonCPU, boot_addr, 0xfff=
fffff),
> > +    DEFINE_PROP_LINK("global-regs", HexagonCPU, globalregs,
> > +        TYPE_HEXAGON_GLOBALREG, HexagonGlobalRegState *),
> >       DEFINE_PROP_UINT32("htid", HexagonCPU, htid, 0),
> >   #endif
> I expect global-regs to always be set, and thus cpu->globalregs to
> always be non NULL.
> Thus why should be check if it's set in all interrupts related functions?

I did this for `-machine=3Dnone` test cases.  It may be overkill, but
there's definitely *some* target/hexagon/ code that gets executed for
those.

I'll take a closer look and maybe we can omit these.

> Regards,
> Pierrick

