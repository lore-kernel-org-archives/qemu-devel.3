Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBC7CD1296
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 15:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruDAb-0004D5-09; Tue, 09 Apr 2024 11:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruDAV-00047I-SN
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 11:13:52 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruDAS-0000bD-5H
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 11:13:50 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-516d3776334so5889418e87.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 08:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712675625; x=1713280425; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5eDym/nhwaod0NfpcUKKcWLCKPEO2wu/o264/80bkfE=;
 b=rjIMb5kGEv9CR7PEvyLP3BSZhaN4zte1nlBgRcq6XpUZOSI+PrC+XJWixJC453Muex
 xwt0xX5tjuoYr4z5ulNIKFHPAIeIrt+NkrIoGc6pCSTB01lyoCjkXS2zHI+WFYngR2pP
 Yku1HUV7kE17pzicBNLuBVHZLMk0+rjLXxQwDOZFEMQTM1KeVp7TqC/rJ8hP0RRiOpIr
 w3oI/LCznpZvxJnLIGInLhClFzlU/ORS0uuDtKLTkWabEGVU8F04dt4dc9s0GSZ8VsBo
 D+CHhUD2IuTJS6OTw26X5g6BfXevX+MB+ZzZjkUyIMwMAwZT+QP0aXrU/OQGKAff949y
 TC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712675625; x=1713280425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5eDym/nhwaod0NfpcUKKcWLCKPEO2wu/o264/80bkfE=;
 b=k2LkAR/nVr0vgkrgIkioJPvJb9ZzkDkrT1mGdOrTV1z6XuQIeF+cLFOtN5jDRRgyFu
 Err//HAjRnYMxWPB33XfRIlkB4m3wkZizErFyp2y7vs+ivaOFiQ1UqmBnqDg3Bv1rSdc
 si+FAibiLxACXM25Cwm5ytcXH+D9/k9tVtKA/RDae9E8thYCQ+dQik8LMsFceiocns4L
 vAhIHaktp/BggvEPRbu2t7hqHNkYL6sm8jVqTYp1QT5sKRuiGIFdCqauvbMoxNd0ReMr
 0o3fKvRusFTP0ues3rVRiBTBlWSAs26a3roSaOIrIETAU7uDkjATKzRaDW1gXjHpFP1u
 wGWA==
X-Gm-Message-State: AOJu0YwI/jKNfVkkpHxmQbjj0TNdb5x0ZgkgH5g728VHpIAqQx4g6z5L
 EMvEikaYoEO2ROVvNjWHyPFBNWIAzfAp14GvDTnIQL3a/RqNoD5PtP258HtJYlsmZh307hhhuzl
 /pmUv3OXYz53zaNwP1OGwDVGtItLnoFqI5ZufrQ==
X-Google-Smtp-Source: AGHT+IEoNlwrfVHhovfLe64/R83PRfJehdgsY08NUoh1lPfvY0AwseTqiFG4uPgF7DVlvjZc1sgZjUqIG9Dz8zvFH3c=
X-Received: by 2002:a19:ca07:0:b0:516:ced5:3afa with SMTP id
 a7-20020a19ca07000000b00516ced53afamr8068433lfg.5.1712675625255; Tue, 09 Apr
 2024 08:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240325144440.1069662-1-kraxel@redhat.com>
 <CAFEAcA8eX=-6yXCZ2+X6niJPcgzkzXfHT9F6LpbfqV4b9VRW6w@mail.gmail.com>
 <sevlzxonvgps5m7r263bkzouabg62tbe6vknvv4rbvjfnnhkqg@jnqkst5xetwn>
 <CAFEAcA-xEK6_eT-TUP+adMsgoTU6kRQoz+9vfXO2Tz_PBLdmyA@mail.gmail.com>
In-Reply-To: <CAFEAcA-xEK6_eT-TUP+adMsgoTU6kRQoz+9vfXO2Tz_PBLdmyA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 16:13:34 +0100
Message-ID: <CAFEAcA8Nty9zAvn9PB-azwvR7mF5tYOfz27AXi-vbuZDoS_ZVw@mail.gmail.com>
Subject: Re: [PATCH] edk2: get version + date from git submodule
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Tue, 9 Apr 2024 at 15:19, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 9 Apr 2024 at 15:14, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> >   Hi,
> >
> > > > +               --version-override "$(EDK2_STABLE)-for-qemu" \
> > > > +               --release-date "$(EDK2_DATE)" \
> > >
> > > Hi -- I've just noticed that we never made this change to
> > > automate the date/version for EDK2 ROMs, but we also never
> > > updated the version by hand. So at the moment we ship an
> > > EDK2 blob that wrongly claims to be an older version.
> > > See this bug report by a user:
> > >
> > > https://gitlab.com/qemu-project/qemu/-/issues/2233
> > >
> > > Is it possible to fix this for 9.0?
> >
> > I've posted v2 (series) a while back, no feedback so far.
> >
> > https://lore.kernel.org/qemu-devel/20240327102448.61877-1-kraxel@redhat.com/
> >
> > If there are no objections I can do a PR for these three patches plus an
> > edk2 binary rebuild (which shouldn't change anything but the version
> > string).
>
> I guess that's safe enough, though the very-conservative
> choice would be to take just the EDK2 rebuild for 9.0.

Would you be able to get a pullreq in for this before rc3?
(I can delay rc3 by a day or so if necessary; I'd rather
not have to do an rc4 if we can avoid it...)

thanks
-- PMM

