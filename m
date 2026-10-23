Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614FF606A333
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=azfpA3Hx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKCMg-0008J9-Qi; Fri, 23 Oct 2026 06:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKCMf-0008Ip-8c
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 06:19:09 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKCMd-0004Ex-GF
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 06:19:08 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8ac525c1f05so6616187b3.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 03:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792750746; cv=none;
 d=google.com; s=arc-20260327;
 b=sUIC5YM57eIV2VdIsTA28LYmdol9LS2nqrE73Tpxf1grJ2jjiB3G8zSPTUz8HkDzUl
 2yYwx7MyN0HmvohYrJLtzK9CFxYNteCnl/du2h8ivg6iI5zdWKBIkffnhqax/1ibuhUN
 44ghxkCp06bqfh8owp5n3uLeVqvGPtg16rJy8D+fQo703SfrfnonCQwRn/w3MvXeBf9x
 6qLRoeakrZ8aS3tLiU2jcm2kGV3XvhFi/lq/iMTqpy/rCT7znGkWyuTaWqfH6mFdJDbb
 AXPvJdlH8W3vjHqLlAB//CeoEte6pgN/A4Ir9YHgxsiwy8tCMS1pYeLGqWow/mO0pqhW
 PrPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UVa77CmCGoNTH9cWHwzF/QvGY+ELP93ZdUCUzNwlhf4=;
 fh=K+WvGj2Sl/yZZqswbnmovzk5aHdWTxjh9/OXfB8k55Y=;
 b=aQ8jurwPopfLgtjFmog2a3VWJwLMUNVeX1EpopnT2ZMlFgYb5D8oa15mdSNSakUtoU
 tE5YpcYWIZjn7oQ+CLa+taEY/ACDzh5+eR6OVfn6tDsTR3ykrYAEQ2xJjIrUF+aAmFU2
 U0HSchnffLvMEIdjiFQMUJO8y+XXcT29nlimCEuBjsFlpiavkIxfx/tjOJXHeIoq7dDs
 3L3sFAoDD/cSXMlPPDjMD9NHGHBD393/HvLHpyRzDvA4rFGp29cW2wd85Y9r46y6XQp3
 Ql55x0hMlBQRcMlqgleoVEQMa3t5TPHaGZbNgoBOIYClhaw65BtfuA5VzEGy+Ho0bcK2
 q8Tg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792750746; x=1793355546; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UVa77CmCGoNTH9cWHwzF/QvGY+ELP93ZdUCUzNwlhf4=;
 b=azfpA3Hxp0gSR3tiz3M2MNulIz/DrxZYMoqN5iBef+vlRo9AieTHWI1j/tQqMadhaZ
 efKvWHjsO9nJ8KmCMJ29g1/JCnC9c3PVFNsV8QCCQ3XSWF9hQXsUI8SZUJ9n7U3PUlpa
 P37SDKk0s9EpfPaCL9Hh1fJbxl9AFzWvVcSpN6NttuT7FY9grMC3a6qgnTBuoLk7rdP5
 3zdBu959rjmDMOEAkH6imCmzWQyi96Z6+/wtzKCf3NNkJgpfBCLtrhlCSWRFVp5lfJLP
 mdqDiJQ0k09oyM+/E9LAK3u+kca2sNKqsTUxfAEZQE2woVwR2CJ5IM15pJoJMBjAn5Vk
 aDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792750746; x=1793355546;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UVa77CmCGoNTH9cWHwzF/QvGY+ELP93ZdUCUzNwlhf4=;
 b=rHBbQaFr55jdUlSlw9y20m/WAhuDXOZQGIY4JYq69y1mPMQIAE3+oD/25RxUdQzz9T
 kvVSUfBvRrtB8xKG+lb3GIx+8uaVAjWlLT8fwaM9wMlu2nmvCx+1py6VeDHF0oPZxgz3
 sq3KDVqpydHfMHmDb98FLo/AToysBuOIt6tNaqKYBSt4EaSUBLQP4uQZPG5IBzhzxphl
 R6nN69XCXVaPoj+VZoXd//e3ytZXMq0mJ4+62bPcGsl1dsRAufUSsXHuadWBPpbURE3c
 a///9JkPv64G2qLSJABcGYLe7YWcb/cUt/G05vQQiFDCsBFgpEzd3IH9JOQf3fOAX8qX
 0LdQ==
X-Gm-Message-State: AFq9FYLVjdZ1rsCeXviZTyYG5RBkRRcTTtEMXhXBG6WiQBOqXH25x6gS
 e3k5XX40pcObYbe8iX/Vj2xlG+MMwov76s/uoNbrEj3sEm2ZDtHt0G4Toet9zvwSwfdyu57d3EE
 vNRqgOOjoyymJLjkWxltJaN0nNA0hdoNkEy0q6703Rg==
X-Gm-Gg: AYBFou1ISe7pKsK9kAOkxfZKV8g3yFkhihMFvps2J3TirwPYFin6IXXDhjVKkTnEbz8
 wtwxJ+m3MaAfHKnts7FBCvPS7nUeEliw2dly8aRMNE8nmmef9tzfCwNzZytnOGqbIA69LD4k3pa
 /AN5LCxfw5XhoznEE0QhooOQLO5lSn8nx2xvblqO7GkFgcK31GMXPs5Pzqi7cZVBJjIWeypcSDX
 LavgGUSrldSg2+aTOpfq7yGtg08mSDQSNC2h6fYtBjoKnUHtIrsb+Td/aLjHnaa1123jMrS2642
 YeAhpjh91jmdU2X69arQWNW1gF41sjAiMBrLbhDomMKyioXoF2iIzPM0veSyHmmha8iRc8cqI+8
 nyz6SesGJLIy95wOO8cEQG7b6+GpZcHoB0bZJJL6f/wqX1KQ+7rcCeUHwMIk9DdT0u9ZTJ7t3FK
 jH2IJjLaInPBzx02yNoaUj
X-Received: by 2002:a05:690c:f06:b0:873:5bb2:6c06 with SMTP id
 00721157ae682-8b157db5f77mr16062697b3.48.1792750745639; Fri, 23 Oct 2026
 03:19:05 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261018133603.64323-1-marcelomanzo@gmail.com>
 <20261018133603.64323-15-marcelomanzo@gmail.com>
In-Reply-To: <20261018133603.64323-15-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 11:18:54 +0100
X-Gm-Features: AclHuK-CIayPEcMCmy0oApD3882Ms4IGP9PvzvXQ4tzv_f7pdExhOTn5-aCBlGc
Message-ID: <CAFEAcA944adKVe2uKWHnKpL==b0arv+XLiu4VLQSMyih2e1goQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/17] hw/net/bcm2838_genet: add migration state
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@oss.qualcomm.com, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 18 Oct 2026 at 14:36, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> The device had no VMStateDescription, so none of its register or PHY
> state was saved or migrated. Describe the MAC register block and the
> PHY, shadow and expansion registers, and re-evaluate the interrupt
> outputs after load, since they are derived from the registers.
>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
> ---
>  hw/net/bcm2838_genet.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
> index e20358c8e7..643ee3ec0b 100644
> --- a/hw/net/bcm2838_genet.c
> +++ b/hw/net/bcm2838_genet.c
> @@ -17,6 +17,7 @@
>  #include "system/dma.h"
>  #include "hw/core/registerfields.h"
>  #include "hw/core/resettable.h"
> +#include "migration/vmstate.h"
>  #include "hw/net/bcm2838_genet.h"
>  #include "trace.h"
>
> @@ -1129,6 +1130,37 @@ static const Property genet_properties[] = {
>      DEFINE_NIC_PROPERTIES(BCM2838GenetState, nic_conf),
>  };
>
> +static int bcm2838_genet_post_load(void *opaque, int version_id)
> +{
> +    BCM2838GenetState *s = opaque;
> +
> +    /* The interrupt outputs are derived from the register state */
> +    bcm2838_genet_set_irq_default(s);
> +    bcm2838_genet_set_irq_prio(s);

You don't need to do this in post-load. A qemu_irq() itself
has no state, and you can assume that the device on the other
end of the interrupt line will have migrated its own state
so that it is correct for whatever level the interrupt
output is at. So you don't need a post-load function.

> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_bcm2838_genet = {
> +    .name = "bcm2838-genet",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load = bcm2838_genet_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_BUFFER_UNSAFE(regs, BCM2838GenetState, 0,
> +                              sizeof(BCM2838GenetRegs)),
> +        VMSTATE_BUFFER_UNSAFE(phy_regs, BCM2838GenetState, 0,
> +                              sizeof(BCM2838GenetPhyRegs)),
> +        VMSTATE_BUFFER_UNSAFE(phy_shd_regs, BCM2838GenetState, 0,
> +                              sizeof(BCM2838GenetPhyShdRegs)),
> +        VMSTATE_BUFFER_UNSAFE(phy_aux_ctl_shd_regs, BCM2838GenetState, 0,
> +                              sizeof(BCM2838GenetPhyAuxShdRegs)),
> +        VMSTATE_BUFFER_UNSAFE(phy_exp_shd_regs, BCM2838GenetState, 0,
> +                              sizeof(BCM2838GenetPhyExpShdRegs)),

Almost nothing uses VMSTATE_BUFFER_UNSAFE, and I don't think
we should be using it here. Among other things, it will
likely not work on migration from a big-endian host to
a little-endian one or vice-versa, since the data we're
pointing it at isn't bytes. The VMSTATE_BUFFER macros
are intended for byte buffers, not for registers.

If your state information is "we have a struct with a named
field for each register", the logical representation for
that is to have a vmstate with a set of VMSTATE_UINT32 etc
macros, one per field.

(I do feel like this device model is awkward because it has made
the decision to have named struct fields but then it really
wants to be able to access everything as if it were an array.)

thanks
-- PMM

