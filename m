Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113CB606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cLxwJfV6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJDcA-0000Pr-6m; Tue, 20 Oct 2026 13:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oss.patchbox@gmail.com>)
 id 1xJDc8-0000Pi-Bc
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 13:27:04 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oss.patchbox@gmail.com>)
 id 1xJDc6-00019b-Qc
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 13:27:04 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-3ab3dd9670bso18226121fa.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 10:27:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792517221; cv=none;
 d=google.com; s=arc-20260327;
 b=q2UbTF0mIXOYXnG6Rt4jY9CFEmp0ccQFfNpRgk/cNyrxDxj1Hr44zmUGAuQVTRPkaU
 enKeYVM5byBTamXhx3nO0UPYAvux6sW0bWSoZRewf50D+JE5ZU5y8DNZoPqloYJM5GTg
 moLuYlqhe6cF0bCBSvjrkaVhGx3DMHkxl0v2YExEZPOdKtyo+edt4b927greOcqcOKot
 nHOiihQd7xdhQVCmeiUIxmlApwE3CnOR0CC8tylJL0AGrCynZ53+NN5MAWzlxPfm11X0
 taN+Aoef2t/pqlC6co1AKqgu3Y8y2WQLCDkKknNkmDxJQt2TRQMG5oTR2aayEQIY5hoE
 Tbhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5J870ro6h1DOB1uf1ImYxFNA3p2yu/UaM9p7U5fDKOo=;
 fh=GOYPAS/jC4RMV/TbGjSuY1+rJ9IEO32b/1v3fnRtzu8=;
 b=rR4qXS24SfHzbnNYcByjp13bAZVUqLv4+WY1EkBpu+xEcmpx51cJ5Aga2YNHu65+fk
 cNs3QNiqZQEMVAklE66Xqh8LSRW+3ZsFHssIFGIKDPKYQAlws/ku4sWd+9RI8N5/eJc8
 0JYT2OyqubGhmN7yPqNLuEoCS7K1H3hy5K4PAOuPSWmLIAQgaYMYgLcyd/yqlb1PMRxk
 WneQg8CaP6G2J2Cq3ktQ15bnsrb1MiOCd66KI1nw3ZoPzpbPTQ2ex5iGyWK7bHV5pkUZ
 Y3vc8BKGnj3Ke89exUI/+Ntie5HFoQ4T42Q59zNPmseW6X2fhzRs/kCSd4XGdkXPo6V9
 Yqjg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792517221; x=1793122021; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5J870ro6h1DOB1uf1ImYxFNA3p2yu/UaM9p7U5fDKOo=;
 b=cLxwJfV6bur167PaEM11WK6YSixXr45msNes0degeJhu0hh9Q+TJc4n1tpYHlShKA3
 WON9KWvEifUMi7rjoyr9lQ5S71ffEm1mKTO4/h9DWmG0kzKNfqWriu+15NN17wgn5GB5
 07uIqRtjj+jr0bIXtVpmp6ltOaghspzBawsptxqgQd7TQ7TBt8nA/ld38OVEFM/Zz8yM
 wLTfKcHTrH3KH9iK51YHeimFT04wFjw9FGBgqD9Ou8+PalNtIrcVphM8TKg0qjbfKE41
 dkTq7uFh/R/DAp0PKEOFuK1RCu7+Zm2E36bN0ATFECUWBpxeLRLVDXj2cM3eiOaCp9QN
 9zWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792517221; x=1793122021;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5J870ro6h1DOB1uf1ImYxFNA3p2yu/UaM9p7U5fDKOo=;
 b=SCte58ro2rDgcvA01Ezcen1SRPAG3KyB/USnIEhcssGxzH70ETAVopVdw41BBQeSot
 aa5zEhn0R41f5m7HkvKVmmeFBomoMYODvpa8Aj7+d4PdA3QD3NGzhatkACNXBbmX3gC4
 qngZPV9RMqIhSXgUnxu3iuP8DV2w1qFzKpaPjUNrDK5E4jDfSxVKsu/gNByD7bTgIM3y
 jWHWkRATELnpSMGkptEho8Sal3hDAH7QIs6COM1Jxu0iJrmYT5aa26QJExFKjcno85aX
 qu9Bf0db7TyryVLOYW0TJXntLa8ma1TwFq7EJbhN3GuCU7+r4p5MZvLxwI6zv3WdsGaC
 mHpg==
X-Gm-Message-State: AFq9FYL8+3dPLcCUp9e910UngZLnsS4pWXF8iaZSJv+2GjaUEDuhmr3U
 RdG7kagB2OEm4KbQPw/IwO0G+FbGGpf0WUtUHqs1BlX7bmOAQmt376uHiFRmwud4nbYQl2B9h7v
 b347/wF6FzS07XQyOG8km6F1538UwGsEINj9Y
X-Gm-Gg: AYBFou18Sw59OuSc9eAmYKsgkzMPA06r1urAU6ybasSy/IZmJps+Thi4AHRuxHOESwB
 C3JEaRtrAaCy4pvTUPiNdYWjD+aJffSZEcSdN6PlIhHPeylKMMyRP9ojDt5KQjrE+Y1BtoyeF4N
 /ew37si+/HfvV06CJ/XjBv/CVVJrTYuF0uXRWfy4rHmAmOQAQ/3PLoMn/3R0WEMoCiz8ondqdOB
 e3gDzMWpSfCQgimCD/FdrxAh/nTo/HoGqIWFOsVcvg3W8RNZP3Ax28qdJcyQXEgRtq6DtFwrWAA
 nxZ1U1vRLVHOXVtsUoX2xsWUUwnOGzF14Yc3o93TC2OoFJSmhEOpNr4l/mTs4C2k
X-Received: by 2002:a05:651c:1508:b0:3a8:bd3d:549a with SMTP id
 38308e7fff4ca-3ab292aa968mr26018171fa.7.1792517220351; Tue, 20 Oct 2026
 10:27:00 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260911143955.1601850-1-oss.patchbox@gmail.com>
In-Reply-To: <20260911143955.1601850-1-oss.patchbox@gmail.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Tue, 20 Oct 2026 13:26:48 -0400
X-Gm-Features: AclHuK_FAECnDX28hxdOGc1u24A4oq0Nz51dUkvYgMZuedSrKVdG67hEFWQuBWY
Message-ID: <CAGG=RgDneftLvgXekjJiWSjecUUHrGecLA2kKOnrq9CvQvtOHw@mail.gmail.com>
Subject: Re: [PATCH v1] vhost-vdpa: Avoid unbalanced IOMMU region unref
To: qemu-devel@nongnu.org
Cc: Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=oss.patchbox@gmail.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Gentle ping on this patch.

Any feedback would be appreciated.

Thanks,
Yuho

On Fri, 11 Sept 2026 at 10:39, Yuho Choi <oss.patchbox@gmail.com> wrote:
>
> vhost_vdpa_listener_region_add() handles IOMMU regions separately and
> returns without calling memory_region_ref(). Its delete counterpart
> removes the IOMMU notifier, continues through the shared DMA unmap path,
> and then unconditionally drops an owner reference that was never acquired.
>
> Limit memory_region_unref() to non-IOMMU regions. This keeps the existing
> full-range DMA unmap for IOMMU teardown while balancing the references
> acquired for RAM sections.
>
> Fixes: bc7b0cac7bf4 ("vhost-vdpa: Add support for vIOMMU.")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
>  hw/virtio/vhost-vdpa.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 9e1aa4860a8..2a067afd0a5 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -487,7 +487,9 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
>                       s, iova, int128_get64(llsize), ret);
>      }
>
> -    memory_region_unref(section->mr);
> +    if (!memory_region_is_iommu(section->mr)) {
> +        memory_region_unref(section->mr);
> +    }
>  }
>  /*
>   * IOTLB API is used by vhost-vdpa which requires incremental updating
> --
> 2.43.0
>

