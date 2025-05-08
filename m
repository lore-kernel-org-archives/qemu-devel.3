Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9972DC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1l2-0001KS-De; Thu, 08 May 2025 09:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uD1ky-0001IN-Cp
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:57:50 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uD1kv-00074g-PS
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:57:48 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e6e1cd3f1c5so877003276.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746712664; x=1747317464; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNGAaC4JL5fkwjOwkC9063F/efaLmDxygNFoplBSwug=;
 b=G8JivEN0PRNYECGlNoJLqVAhCiFLgJ+r2TLLRFJymjGxWjtfs/kQCIht0fqwUz1yMO
 BtogEWsb5GeuBZMFVuYckT01frjQN2sLni4QKwcGGHeXAn1atH1ViA/qXVjYXWzblh9B
 UVkk+Rxe7NJivYF31Cx5BK18CPEmgVZvPsuHj1XcH71M978kfBXU/DLUT/ozi3g5f8dt
 bF08MOYlm6Xs1vXMDm7j75M1H9o9b6hK2dbAPf4yd/5VugKndAM2b5kPS0FAz4j8zaSs
 IJ0aYqqkPMiUN2EQ/jQgxH2+gNTaKCFu3xFSWc0Aq7OlLTsXrXK5eYPPZlTO54ZsyQ0u
 I1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746712664; x=1747317464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZNGAaC4JL5fkwjOwkC9063F/efaLmDxygNFoplBSwug=;
 b=YG1TFEpJj3XY3sdnhUI2fnwAf95TX/5a4vwVpsU78YKXyDmMBKj3HGrL5VpoZ8yU6f
 rmgZVhrGuYTH2Jgj9ESACdclxCwfUHdYHnNY7nG+IOJ6eHD9aL4Nbd9gevJZ8yHR8iXK
 4aWrCViKucPXuQtUfgYSWK6LgoqNIYtaRyNI7KY2rrHtpKZvD+JOXv08kYcGdbFtahaR
 X9WAB6P1ZcSdCc8BlpEX/nuivqxAecvhgQfSsWW7nFhV2hkdOzkyKWuCh0hLZDnhHlbj
 9vHkj3eExoeFb+MWUY9STEi7zoSLHQJ0u86zlhVW1VAHUKFaPZVZoCVYAFwtzUocFfQV
 j/2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAChHmKTqHlWN866W1tGg6u8aI84zRe3OSdjmhRE5L9n/ifNUxs6mHYglOYr2+pc1saIXpTeEFqVLn@nongnu.org
X-Gm-Message-State: AOJu0YzPXH+K9s9dIHuXbBfm1ZOU69LONeIf2AQnVG7fMYDJXh2zAjXX
 hXihYAWoUQYZuYxbK8jfP/G0KolOHlNSL5fDwkV1ZnvyETAynHufbc4FIFLC8mLGxi4I6Qh7ii/
 RCB3hoc4rhblNY5MMIVPdFCh/yh+7RDIPc99Wuw==
X-Gm-Gg: ASbGncuFJRhnfgJ0K/Wrs/0FC8iDTUGJGBze1hx/cApUeZzO/k0eWl7eIQRL11GudrB
 zUZY9n32Jgl1ndkvyLygx3kfTPbtuIMp9oftuIHOyWIZ308RBSh9+QnKspMAlgAbj3QA1ZWwgcK
 BUbarKmgwDKnuGt84G284AVC0=
X-Google-Smtp-Source: AGHT+IHnpTqzbr4Mr3qz5bAdRPNdkV9retyp4nVkU4yx9hQE663826DpF51ls30IhiLwwAoQUuslMWu6onV3JNRV3J8=
X-Received: by 2002:a05:6902:983:b0:e78:25a6:f061 with SMTP id
 3f1490d57ef6-e788173c4abmr10026895276.43.1746712664192; Thu, 08 May 2025
 06:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
 <877c2ut0zk.fsf@pond.sub.org>
 <e02e884b-0f3d-4426-8a67-2cbd23e80e8c@redhat.com>
 <87frhglwjl.fsf@pond.sub.org> <72f9043a73294bfc9b539ae9b94836d3@huawei.com>
 <d21e0c57-b89a-4c79-958e-e633de039e4c@redhat.com>
In-Reply-To: <d21e0c57-b89a-4c79-958e-e633de039e4c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 May 2025 14:57:32 +0100
X-Gm-Features: ATxdqUEHgN3H-9LvXiyA3UnCVlHPx487TV0IQw-ClWqusnHlp4Oax_W12qu68SI
Message-ID: <CAFEAcA9bZ6Rd4PSMG61mJ5Ja07j3--DQE7KqA8RZwxGH3N51sA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
To: Donald Dutile <ddutile@redhat.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum via <qemu-devel@nongnu.org>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>, 
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>, 
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Thu, 8 May 2025 at 14:46, Donald Dutile <ddutile@redhat.com> wrote:

> I would refer to the ARM SMMU spec, Figure 2.3 in the G.a version, where
> it's slightly different; more like:
>
>   +------------------+
>   |   PCIe Devices   | (one device, unless a PCIe switch is btwn the RC & 'Devices';
>   +------------------+   or, see more typical expansion below)
>             |
>      +-------------+
>      |  PCIe RC A  |
>      +-------------+
>             |
>      +------v---+    +-----------------------------------+
>      | SMMUv3.A |    | Wide assortment of other platform |
>      | (IOMMU)  |    |   devices not using SMMU          |
>      +----+-----+    +-----------------------------------+
>           |                      |   |   |
>    +------+----------------------+---+---+-+
>    |         System Interconnect           |
>    +---------------------------------------+
>                                 |
>    +-------+--------+     +-----+-------------+
>    |   System RAM   |<--->| CPU (NUMA socket) |
>    +----------------+     +-------------------+
>
> In fact, the PCIe can be quite complex with PCIe bridges, and multiple Root Ports (RP's),
> and multiple SMMU's:
>
>      +--------------+   +--------------+   +--------------+
>      | PCIe Device  |   | PCIe Device  |   | PCIe Device  |
>      +--------------+   +--------------+   +--------------+
>            |                  |                  |        <--- PCIe bus
>       +----------+       +----------+      +----------+
>       | PCIe RP  |       | PCIe RP  |      | PCIe RP  |  <- may be PCI Bridge, may not
>       +----------+       +----------+      +----------+
>           |                  |                  |
>       +----------+       +----------+       +----------+
>       |  SMMU    |       |  SMMU    |       |  SMMU    |
>       +----------+       +----------+       +----------+
>           |                  |                  |   <- may be a bus, may not(hidden from OS)
>           +------------------+------------------+
>                              |
>              +--------------------------+
>              |          PCI RC A        |
>              +--------------------------+
>


> The final take away: the (QEMU) SMMU/IOMMU must be associated with a PCIe bus
> OR, the format has to be something like:
>    -device smmuv3, id=smmuv3.1
>    -device <blah>, smmu=smmuv3.1
> where the device <-> SMMU (or if extended to x86, iommu) associativity is set w/o bus associativity.

The problem here seems to me to be that in the hardware we're
modelling the SMMU always exists, because it's in the SoC,
but you're trying to arrange for it to be created on the
command line, via -device.

We don't have any of these problems with the current 'virt'
board code, because we have the board code create the iommu
(if the user asks for it via the iommu machine property),
and it can wire it up to the PCI root complex as needed.

thanks
-- PMM

