Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DE9D68B29
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 14:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBam5-0003CG-5Q; Thu, 14 Nov 2024 09:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBam0-0003BP-RR
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:24:42 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBalz-0001qY-3Z
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:24:40 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cf0810f5f9so392591a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 06:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731594277; x=1732199077; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=899tgWHHYKlC677694SvOIpne1mjHi5RCut73ECGLlA=;
 b=vz9xEndDFbGQV9wsARUpUiRWiM97SbVTGsv/L/5qANPPb+WO0r+G69zps85aSuz5Rg
 sXNLyUMadIO9yg/yR437SmrI9YEaBHlKl9BE6B/zGRaPlgNXA+xpItaOAWwlqL7ySMwh
 at933MSzCVj/PnaVkw+MpBCKvSnfTDGM/xKsBvYR4PJhJ/acTsqT9RPJ3rQcFp9r9KX3
 DY6imZU+fR7Tf1+WkIN/vMlP/QMusZO8lwOLbgbj20fCYIAO3JyFSEOpEjpTslcMwLpM
 etzmTQFH+F7n8Vaoc97Mzz6j7xhnpnJsmUn4y5VJsBCJeLrRcrtQPX7s7+LZpW0JV6fm
 RDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731594277; x=1732199077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=899tgWHHYKlC677694SvOIpne1mjHi5RCut73ECGLlA=;
 b=sk1GYM5g/GyxviK4AR74B9ucH7tpSQSoydAqWP+BMYgSIsTPDqFM6vkYY9ZjdX6f4k
 kB/M65+MXXH/ncRZ90DJ1KO9rrrR1N227WxhcnCXdnpHRlbo653/nwCF3pJwqVrQKA5M
 5XgknNN1NiX2gxk4oyhlJbAU8j3roYi4lTkGH1lHQVDI6BxBGXKVDinHBB4bZlGv3iKX
 vf23bQa9dXKNDlfn8yh9+Q+RVbiibyyDp9UWjUDFFt6cQFxYkmPH/MIYOVmeKgSiH/jr
 HhwZE5vRsO78Uxhv6tGDdWudxRBcAthzkMdao5C+uucCsPX/IaQUUYu5K7YaCeGfWfsD
 DcpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQYn/HKMzOuGd0lrMBbfbZ/YnT4G9b/aMhkfWjLvSt7KJCYx0AWxPj66i5MSrG/TzLSuPr+PkypfVX@nongnu.org
X-Gm-Message-State: AOJu0Yy0p5NUIpvL6V0ZhKR+LqCYgJgsqskko1fFGYRQK0nipa+ndV15
 VLtis5T6vhkm1CIVmfLRsEl/i+fA/oChMnZpnjr/BOrSKN8Ejz1jyHIbjEzgUsfd85VKSAENbpm
 MLbC+RJK6wlmQf4oYwdXTV6EgRRfJoHQnogH32Q==
X-Google-Smtp-Source: AGHT+IH0cG70ZmCA6w99pPxOY9whKGRvN1t2fLPAFQLZyPmEw+37YOxNYHcKnzXOsiXlQ2Dx14+sxlvdqEhXaiieRQk=
X-Received: by 2002:a05:6402:2351:b0:5cf:3d11:c795 with SMTP id
 4fb4d7f45d1cf-5cf77e88fefmr2899035a12.7.1731594277316; Thu, 14 Nov 2024
 06:24:37 -0800 (PST)
MIME-Version: 1.0
References: <ac98a734-5de5-e107-6257-0c5fcd2fdfcd@hisilicon.com>
 <864j4avvu9.wl-maz@kernel.org>
 <3bd1c8d4-d5bf-75bb-bd22-089ab591f026@hisilicon.com>
In-Reply-To: <3bd1c8d4-d5bf-75bb-bd22-089ab591f026@hisilicon.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Nov 2024 14:24:26 +0000
Message-ID: <CAFEAcA-DiFfc1kJkuLy96-YrvdJnz6oBmB51vsnJ=TERR47vXg@mail.gmail.com>
Subject: Re: Question about migration on ARM system
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Marc Zyngier <maz@kernel.org>, qemu-devel@nongnu.org, 
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
 "Zengtao (B)" <prime.zeng@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 14 Nov 2024 at 13:48, Zhou Wang via <qemu-devel@nongnu.org> wrote:
>
> On 2024/11/14 20:33, Marc Zyngier wrote:
> > On Thu, 14 Nov 2024 09:03:24 +0000,
> > Zhou Wang <wangzhou1@hisilicon.com> wrote:
> >>
> >> Hi,
> >>
> >> I am tring to heterogeneous live migration on ARM64 host. Now I just use
> >> below kernel/qemu branch to have a try:
> >> https://github.com/hisilicon/kernel-dev/tree/private-v6.11-rc2-hisi-migrn-wip
> >> https://github.com/hisilicon/qemu/tree/stable-8.2-kunpeng920-initial-v2
> >>
> >> Currently guest on GICv4.1 and GICv3 host can do migration successfully. I am
> >> not sure that it is expected.
> >
> > It isn't. Or rather, it shouldn't. Are you reporting a KVM problem or
> > a QEMU problem?
>
> I think KVM checks it in vgic_mmio_uaccess_write_v3_misc, however, current qemu
> does not consider GICD_TYPER2 during migration.

That's because current QEMU's idea of a GIC device assumes
v3 or v4. We don't emulate v4.1 and we never updated the
kvm-arm-gicv3 device to handle anything newer than GICv3.

-- PMM

