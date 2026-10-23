Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBB5606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=YGJCWftf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKCpH-0006HW-Mq; Fri, 23 Oct 2026 06:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xKCpF-0006G6-53
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 06:48:41 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xKCpD-00085e-Ht
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 06:48:40 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b2232d8ef5so1120706a12.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 03:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1792752518; x=1793357318; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GOL5cZuTt/MBKBHB8JFSxAemcVtQtS8v4xrphYk6+sM=;
 b=YGJCWftfmorauzq/cCHSBb/Xbe+ttNYuHVXOc/d3pZKl1+Qe4Y43nNCJal+RlLzoCH
 7GAaFHNttJWeRyij++I3DuD8mEXCMczKq8IL2F2ZM5eGEgUKEqJLHk/jXRLavXmVlb2O
 ePhKpRyRtbMap+Z5TyMTcnMF1722YXIp+swCwi/E0OOqSofVUHy/xsqivibc9vP2mJoz
 yhwqMO3B1t4wRG3VP3WaoMygg2FCOxOrg428eyM3ylBlGmYHDNnvix3TqMVh0vDecd3k
 Af4mkok3DlAjhahxrgwOZPS9sQklcEH00r2zFKcdlhWa6i9Msl2TBZRH7rLtXuSet+9c
 rHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792752518; x=1793357318;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GOL5cZuTt/MBKBHB8JFSxAemcVtQtS8v4xrphYk6+sM=;
 b=e+92KMIxG3wVpxhHk4WE40JFAqakEbEgDhoxoyoLNev/B6QBthkwHDnlpzx+CfOu6u
 OsrTHCVGSMwZSxpk97KN0Xy30Bwj+uvgPGddzxJuUZbyp6ggA4fV/4BHIfB9hg8ixj70
 /07oFWAloF2huX8pssH6lWpdbfTE5aUGbKTgNZQ4LhJkCYsfJB7NNR0lBXzWod/XiW6D
 5oXk5D6+fKtqZ36bQMQRGlv8D/8IaomhIZVpvYn3mMvLlJiGlNHPC+qCoKiYm1SuM8Hr
 M9RgTKewXSxHkX6r/z0+UmwyjtJ6msFmN2s3WppCsd35QlytxGnG1HWgUD1uMEu1OvQB
 /VWw==
X-Gm-Message-State: AFq9FYLiXNFG5g40PFDCnrP5Fwz8gtbIwtMoaQTmbQeCWdoi75Zpi+Pt
 3mIvXW7OCIVm5iQq4R+J1uGD+kpI3zFPC6+qTbAkNR+l0NSVMkt2Uhfm1sWToBrEB/R/ucGzKDH
 fhGjYoLGwWE4DaCquaD1IlYgpOl3KKJ/83jlYUNCa36dq2AV8ZhTZYtN0Vd3PZR06r7K5kg6n7D
 ZGxrPbyr4NTHcPPexdWU0luR2jvvNmxEfmsojtJuRiITM=
X-Gm-Gg: AYBFou0cMR3FZyCRPI/9n4vqytl3WaV1JNTjziPLKLZ06SjWPeVmHj3qD7hdEyK8FlI
 cUwfDOUemiRS9MW0hS7R8a9pzz8AKoagfMS3bCdHTqKia+FVxEgP/VT1kH7w4JoV4KKCIZoTehn
 wXaJJBHLBEZhSKuDD7KE476sFAlkATD2z1bWKi5mExUYe7YEd1uHRMumD9nOdkdjaOvEUO79jpE
 8G8YNYNYQVevSm4IuarA3sjXteHC8kR85Vr+rKNcQD7RxvsuFLmnwF/O57SejuCwBD7TIQvYpmi
 aA+QjqcHmZf52c3X3vwmOJ7DTtaUgkBkrMDx2MLQfUc82nM4Mjq30xt59YXcp8rgPz8sDEYEqnV
 h/lMYTwetZfH/CuTIz5e/a+afegrtx8fhdfOvq+g8+ilATkqUS4KOjOU570bpB3W05fbJCKPRSa
 KGxSbWOutliIkXcakuayrIRYWYnoxjKSaS5Z3YsqGydibPyCfG1ZxFsczUHFVgqzgcR/YuAFOo9
 nlp85Yz1VZ2UyeEuWu3vVr8pxVguR8GiQg0ZxuaXjQuPDdVYj+1wZIEDLFqj/StiVyBwfGtufjr
 F6yawk6fBGvARZ2OBQ==
X-Received: by 2002:a05:6402:e8d:b0:6b3:b648:3170 with SMTP id
 4fb4d7f45d1cf-6b432b14490mr2705647a12.4.1792752517591; 
 Fri, 23 Oct 2026 03:48:37 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com.
 [209.85.218.53]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b432c00eaasm1016656a12.5.2026.10.23.03.48.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 03:48:35 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c40e02b2ebaso116833966b.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 03:48:34 -0700 (PDT)
X-Received: by 2002:a17:907:60cb:b0:c41:5a0e:3356 with SMTP id
 a640c23a62f3a-c46a946bc33mr257510266b.41.1792752514283; Fri, 23 Oct 2026
 03:48:34 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
 <20261021231346.2452179-2-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261021231346.2452179-2-daniel.barboza@oss.qualcomm.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Fri, 23 Oct 2026 18:48:22 +0800
X-Gmail-Original-Message-ID: <CAMXXpfZoU2jU2y=SWdjk3jWNZ6qiSaRvsdQ+_es3YFRL0h+K2A@mail.gmail.com>
X-Gm-Features: AclHuK9m5snQAdLRdRHa6ofxtGV0xwnXiWQ-k7MsoLeFNrXKhgT8sGBBwkhRyoQ
Message-ID: <CAMXXpfZoU2jU2y=SWdjk3jWNZ6qiSaRvsdQ+_es3YFRL0h+K2A@mail.gmail.com>
Subject: Re: [PATCH v4 01/18] hw/riscv: Trace Encoder initial impl
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, antikostya2@gmail.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 frank.chang@sifive.com
Content-Type: multipart/alternative; boundary="000000000000c8c0b9065e7fb8ae"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=jay.chang@sifive.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000c8c0b9065e7fb8ae
Content-Type: text/plain; charset="UTF-8"

>
> +#include "hw/core/sysbus.h"
> +#include "hw/core/register.h"
> +#include "system/dma.h"
> +#include "qom/object.h"
> +#include "cpu.h"
> +
> +#define TRACE_R_MAX (0xFFF / 4)
>

The Trace Control Interface register map covers offsets 0x000 through 0xFFF,
i.e. a 4-KiB window. Here 0xFFF / 4 evaluates to 1023,
which is the last valid index, not the number of 32-bit entries.
Since TRACE_R_MAX is later used as the default reg-mem-size via TRACE_R_MAX
* 4, the default MMIO region is only 0xFFC bytes long.
It therefore covers offsets 0x000 through 0xFFB, leaving the final word at
0xFFC through 0xFFF outside the region.

Thanks
Jay Chang

--000000000000c8c0b9065e7fb8ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">+#include &quot;hw/core/sysbus.h&q=
uot;<br>
+#include &quot;hw/core/register.h&quot;<br>
+#include &quot;system/dma.h&quot;<br>
+#include &quot;qom/object.h&quot;<br>
+#include &quot;cpu.h&quot;<br>
+<br>
+#define TRACE_R_MAX (0xFFF / 4)<br></blockquote><div><br></div><div><span =
style=3D"background-color:transparent">The Trace Control Interface register=
 map covers offsets </span><code style=3D"background-color:transparent">0x0=
00</code><span style=3D"background-color:transparent"> through </span><code=
 style=3D"background-color:transparent">0xFFF</code><span style=3D"backgrou=
nd-color:transparent">, i.e. a 4-KiB window. Here </span><code style=3D"bac=
kground-color:transparent">0xFFF / 4</code><span style=3D"background-color:=
transparent"> evaluates to 1023,</span></div><div><span style=3D"background=
-color:transparent">which is the last valid index, not the number of 32-bit=
 entries.</span></div><div><span style=3D"background-color:transparent">Sin=
ce </span><code style=3D"background-color:transparent">TRACE_R_MAX</code><s=
pan style=3D"background-color:transparent"> is later used as the default </=
span><code style=3D"background-color:transparent">reg-mem-size</code><span =
style=3D"background-color:transparent"> via </span><code style=3D"backgroun=
d-color:transparent">TRACE_R_MAX * 4</code><span style=3D"background-color:=
transparent">, the default MMIO region is only </span><code style=3D"backgr=
ound-color:transparent">0xFFC</code><span style=3D"background-color:transpa=
rent"> bytes long.</span></div><div><span style=3D"background-color:transpa=
rent">It therefore covers offsets </span><code style=3D"background-color:tr=
ansparent">0x000</code><span style=3D"background-color:transparent"> throug=
h </span><code style=3D"background-color:transparent">0xFFB</code><span sty=
le=3D"background-color:transparent">, leaving the final word at </span><cod=
e style=3D"background-color:transparent">0xFFC</code><span style=3D"backgro=
und-color:transparent"> through </span><code style=3D"background-color:tran=
sparent">0xFFF</code><span style=3D"background-color:transparent"> outside =
the region.</span>=C2=A0<br><br>Thanks<br>Jay Chang</div></div></div>

--000000000000c8c0b9065e7fb8ae--

