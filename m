Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D84C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 00:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXsbu-0001NV-0e; Wed, 07 Feb 2024 19:49:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXsbr-0001KZ-Rm
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 19:49:47 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXsbo-0006nx-LI
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 19:49:47 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-51165efb684so2340349e87.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 16:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1707353381; x=1707958181; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCU7mGw4R9sIEMgjS0mO/2qLWnJBcMrS1ePgXejYefU=;
 b=jGy22wua3C1/QR4kd6YsLNbXPgcLhzMvAJCGAw5BEylcNZAGsUNuRnhqBW+imgBCws
 8oPfVqEo5Yh4lQVQIy6U8J//vf6TRxNiLktquvsOSNDvQsns7qmSkxHhPBYN7OmuwmjD
 2AFh938c2PJxRiX5SEPdfjJC4eTIPbybaCohestor5JKqpUDDmIxfxkyL1SzK/tVvCVI
 l1yfRaKn/0lDM7hj9vdn/hIa3EjCAfy+ZWLQ71c2OGzCqg/EVp/TWCJeDyAVQYYkhDly
 dRhKHaMq2OFGxrrnQ4ojS0fsoZ9Ewbydiz11p5HHzK97dmGMxzZ1o1c9YARJJqM00DYW
 +GoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707353381; x=1707958181;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vCU7mGw4R9sIEMgjS0mO/2qLWnJBcMrS1ePgXejYefU=;
 b=bGyW0fcPZ7KbTmrhmKH/TLmQxAsuXOVHr3aYfRRa/MLX1vcSYYaUmeELwdX4AFe9nm
 pLcElZUj7RIi/CYdgacv5FJMj0OuMEcwXC4+yb4xr4UGxNZL8/WJmehPmd8VF17+L81z
 Ff3WN5PGdYqgVhjoGWsInT6z6a1R8O8Md3FF0Wb5RXnDLpTXwz/xU5Pfgn539kSkm0OL
 9PTG1p7ziQfa9KLLHGTO3TbfU/PBZrbC71uT7V+LOBSaXON9pk5UpDmZrzNWioCiMrfL
 zR2md+iGqxYxSR90TXioe+6f5J7CcD5Kg8So3TM2IL55n/BXPOgv211r/TXrvPEGblgV
 /qsQ==
X-Gm-Message-State: AOJu0YzSY7w4hTlsqa37zvKKj62+UlsBwVFNdYqf9rLT1LJzLh+jqSM8
 eJir7UCM1oR12NTpAff1Ic8MA/M2EHC9ywdvpDt1gGSNfMoDnspmfLCXiwpULXxqnxcG7lNTddw
 U4ZOkFSGSDj6mxp10jWI+e9x3q5vdkA7fx0Qx1Q==
X-Google-Smtp-Source: AGHT+IFQYxoeB9i81CWTp1i9dn9gqN6l9b5fz0isJj3FgnzeheItzG6gVjsZR9LJTIR56aEd9upSESTVCyYt7ZeJjgg=
X-Received: by 2002:ac2:4985:0:b0:511:454d:25e3 with SMTP id
 f5-20020ac24985000000b00511454d25e3mr5496725lfl.41.1707353381587; Wed, 07 Feb
 2024 16:49:41 -0800 (PST)
MIME-Version: 1.0
References: <20240206231908.1792529-1-hao.xiang@bytedance.com>
 <20240206231908.1792529-2-hao.xiang@bytedance.com> <ZcL8tLF7tmD0JpVV@x1n>
In-Reply-To: <ZcL8tLF7tmD0JpVV@x1n>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Wed, 7 Feb 2024 16:49:30 -0800
Message-ID: <CAAYibXgaTWEGRSRsegvN2otydDroneku57yeTQ_QRpBW-dSWJw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/6] migration/multifd: Add new migration
 option multifd-zero-page.
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=hao.xiang@bytedance.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 6, 2024 at 7:45=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Feb 06, 2024 at 11:19:03PM +0000, Hao Xiang wrote:
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 819708321d..ff033a0344 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -874,6 +874,11 @@
> >  # @mode: Migration mode. See description in @MigMode. Default is 'norm=
al'.
> >  #        (Since 8.2)
> >  #
> > +# @multifd-zero-page: Multifd zero page checking. If the parameter is =
true,
> > +#     zero page checking is done on the multifd sender thread. If the =
parameter
> > +#     is false, zero page checking is done on the migration main threa=
d. Default
> > +#     is set to true. (Since 9.0)
>
> I replied somewhere before on this, but I can try again..
>
> Do you think it'll be better to introduce a generic parameter for zero pa=
ge
> detection?
>
>   - "none" if disabled,
>   - "legacy" for main thread,
>   - "multifd" for multifd (software-based).
>
> A string could work, but maybe cleaner to introduce
> @MigrationZeroPageDetector enum?
>
> When you add more, you can keep extending that with the single field
> ("multifd-dsa", etc.).
>
> --
> Peter Xu
>

Sorry I overlooked the previous email. This sounds like a good idea.

