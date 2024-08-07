Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF96C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 10:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbdWX-00027a-3N; Wed, 07 Aug 2024 06:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1sbdWV-000276-Gg
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 06:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1sbdWT-0005KK-8I
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 06:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723025038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=910fYDrhaXdOiZ4cfEcRxZZP0pcmBEwkklmDLs+AiyE=;
 b=iw3mRVf7hLyC9pc+rUHifvXfOQMEeBPOPsXac+E1As7imb+bqghwCsT27j+DyC8xo2AcaF
 ckKHDlofab1wTVYauNSWsnXO9ge+a1EokjiOERGc8Wap30Kmz38rpoGccRdZhdtqD+7PlZ
 gpfGjF9a8Iko35p8wDVkdmTCU/XJR2Y=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-JVQAdEyBP7G3a4AbiLtA6Q-1; Wed, 07 Aug 2024 06:03:56 -0400
X-MC-Unique: JVQAdEyBP7G3a4AbiLtA6Q-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3dc16d65a58so256589b6e.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 03:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723025036; x=1723629836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=910fYDrhaXdOiZ4cfEcRxZZP0pcmBEwkklmDLs+AiyE=;
 b=mPlP/XWWZsSCahP4wv3bmR/ZpEcSQPNT2rOlYg5GYuqLtHvo5j/Ph3FrEzeiGqRPse
 pCTyUqhCus4c2lxSusWbVq3LgFw997VKqy2GD+bNo1SAoPWcyTUrTv+YYjg7CZ06W1xq
 y+IVnSApbC3v64vRbfx2U1aYTD0tA03MdwQo/ca65Ns6WMhQoiixIz8xLf3LIqtmOZb6
 Xq83Vd9eMSjRX/xb3PNkIgfGEh0PROPtb5tH8dn08V5w2iQDBva6C1OpGclsP71SrlFV
 UmooV3XM3pOwa+gFIlmsWgfI9Bd19Ji3tuz1bMKGJifqfPj39oPi3HHeFIeG91DR0FSt
 LFsw==
X-Gm-Message-State: AOJu0Yz3W5sKwu3zSNVbhjwsuchyE+phPRpQ15+3aJabmkBr73HuLHRP
 N+dXK4LdCCSejDLJRTIBwLlRPNU53sOM48BJUO75rr2cxEzdc5yE1K22PpkgfZbFrrPDfludZ6i
 B7HsAP5dohW17H+xez+4AOIIbDjm6gCW3cvgmeMmKrMu2WCrmefd7H72Y++qYW2236BnUT9ZB8x
 qp7ms/p4TYuf3vrnRWBfgWxM2EV2U=
X-Received: by 2002:a05:6808:19a0:b0:3d9:29e3:7df1 with SMTP id
 5614622812f47-3db558181e7mr24751337b6e.27.1723025036107; 
 Wed, 07 Aug 2024 03:03:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ47phYx38Pgx4LEeWIeTI8hP1NFLfTz6y/Art7bH5M20BHBwheD8TaGsMUGDpRRCKnmiAYQhMi7q3lSedgOo=
X-Received: by 2002:a05:6808:19a0:b0:3d9:29e3:7df1 with SMTP id
 5614622812f47-3db558181e7mr24751300b6e.27.1723025035639; Wed, 07 Aug 2024
 03:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240806160756.182524-1-jmarcin@redhat.com>
 <20240806160756.182524-2-jmarcin@redhat.com>
 <39475af7-9090-4304-80c1-fb08c7360e83@redhat.com>
In-Reply-To: <39475af7-9090-4304-80c1-fb08c7360e83@redhat.com>
From: Juraj Marcin <jmarcin@redhat.com>
Date: Wed, 7 Aug 2024 12:03:44 +0200
Message-ID: <CAC2qdxDqFeMUdJnc7M_mjGM459b76YDKYFTYLSSrT71AEr4UQg@mail.gmail.com>
Subject: Re: [PATCH 1/4] reset: Use ResetType for qemu_devices_reset() and
 MachineClass->reset()
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 6, 2024 at 6:40=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 06.08.24 18:07, Juraj Marcin wrote:
> > Currently, both qemu_devices_reset() and MachineClass->reset() use
> > ShutdownCause for the reason of the reset. However, the Resettable
> > interface uses ResetState, so ShutdownCause needs to be translated to
> > ResetType somewhere. Translating it qemu_devices_reset() makes adding
> > new reset types harder, as they cannot always be matched to a single
> > ShutdownCause here, and devices may need to check the ResetType to
> > determine what to reset and if to reset at all.
> >
> > This patch moves this translation up in the call stack to
> > qemu_system_reset() and updates all MachineClass children to use the
> > ResetType instead.
> >
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > ---
>
> [...]
>
> >
> >   static void mps2tz_class_init(ObjectClass *oc, void *data)
> > diff --git a/hw/core/reset.c b/hw/core/reset.c
> > index 58dfc8db3d..60c9c66d81 100644
> > --- a/hw/core/reset.c
> > +++ b/hw/core/reset.c
> > @@ -25,8 +25,8 @@
> >
> >   #include "qemu/osdep.h"
> >   #include "sysemu/reset.h"
> > -#include "hw/resettable.h"
> >   #include "hw/core/resetcontainer.h"
> > +#include "hw/resettable.h"
>
> Curious, is that change really required?

You are right, it is not required. I will fix it when some more
feedback comes in. Thank you!

>
> Apart from that LGTM!
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
>
> --
> Cheers,
>
> David / dhildenb
>

--=20
Juraj Marcin


