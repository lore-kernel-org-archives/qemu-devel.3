Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6666DC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 10:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCFyr-0002dM-Th; Tue, 06 May 2025 06:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCFyo-0002Yt-DL
 for qemu-devel@nongnu.org; Tue, 06 May 2025 06:56:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCFym-0006KG-Ri
 for qemu-devel@nongnu.org; Tue, 06 May 2025 06:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746529012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kvLU8i4sTYOylp/4hBHbK3K6hp+qzpClbnpviMvVgrk=;
 b=bUHACRuUZsX/44BWJ7k1N8JvjIbs2FGUcMf/yHY+jwelZwILWH8JJh358uJaZ5ArXR9oIg
 sJL7H94EfSWy6YWxUSUAamzO00V45j5p8XJ/r+H//pG7YKH2YnJuFgRs5vtWF+/fIQrSFm
 6jLIymC/Tw9eZGP+dzQhdj5DKegD4wY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-r_nrn4XwMr2Wa0zpGyVFvQ-1; Tue, 06 May 2025 06:56:51 -0400
X-MC-Unique: r_nrn4XwMr2Wa0zpGyVFvQ-1
X-Mimecast-MFC-AGG-ID: r_nrn4XwMr2Wa0zpGyVFvQ_1746529010
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39ac9b0cb6aso2269271f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 03:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746529007; x=1747133807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kvLU8i4sTYOylp/4hBHbK3K6hp+qzpClbnpviMvVgrk=;
 b=JXKts+59wHOC+JTPMWFEhEn0SWp+6QYZRxeoX8x2yyukhwsjuQqRYxNk8CNE5QYJDE
 T2dVVR+RTx9MrzqtUAp3+KJo/+C4cFiytSShjGcoVdMCujb7NJtH6610wpy1r0gYQNzB
 jYvNzFbpTCcAiPC3rpu/QU3g/t4oIPXWg8Wqhlcec8T7rsMQEN6qX9UE3d6pFN2vIlRs
 7raW5gz64OPqpHGlP8ka8WDs+RxunknYq+mqZQxgXQ7Hcjic7pOPkSu6jia29qFc8Ylu
 JVAbAYKSC6xaA3YBFglTntz79YteKZMdFH7nzL4J22ZS2FPW2667Uo5PabrCvhxsEJkr
 Ly8g==
X-Gm-Message-State: AOJu0Yz1wbLyU3hSaEOaNIVcO6w2TKjgeQlSZemrPxLQyRXvQ/w+BB8L
 FbeKLqK8MZv+4yv0no5G7V8X/sdWu4e31v6Chrxwh8gqK/pODfDL660LH0wmwu3eaNIpEzh8d21
 t7tpCXRP4Wgf7lEmGRmLUXIkiwZz7UqbfuMBaCurCsUbT7xR8nOPnx4Pgyg0w2wdVcUP11GIki4
 kRdbkHwJTtD+o2dS2QoalqpIKikisNuCJ/dwc=
X-Gm-Gg: ASbGncuR4crJTyqwXdPKGIbAGuCF0ISlkc7J5dV6Ha1FyJBVQlIWVyMT6V7OPeOJVV9
 jM/alRKG9Y3Xy9mfdzp3ny+7al/WfiTVBi8uSM1iJxZfIrCjRAIduzqH2JmaSVEmh3Uyq
X-Received: by 2002:a5d:598f:0:b0:38f:28dc:ec23 with SMTP id
 ffacd0b85a97d-3a0ac0da194mr1915420f8f.19.1746529007494; 
 Tue, 06 May 2025 03:56:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7sFP5dX58k2E/Xh1xdbQ7puHXYJcIDV06y0PeV8wfKkQAUmH9eswmsEAdMi6J1AAV2gVfS4m0fp5D0C49sCA=
X-Received: by 2002:a5d:598f:0:b0:38f:28dc:ec23 with SMTP id
 ffacd0b85a97d-3a0ac0da194mr1915410f8f.19.1746529007259; Tue, 06 May 2025
 03:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250505100854.73936-1-pbonzini@redhat.com>
 <20250505100854.73936-3-pbonzini@redhat.com>
 <aBnSUzH1RuYp123b@intel.com>
In-Reply-To: <aBnSUzH1RuYp123b@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 6 May 2025 12:56:34 +0200
X-Gm-Features: ATxdqUG3NgKZCj8uy6wsqkLbcwlR69f-HcA1wtXuvWTRYicNBlKwwcahkfNYbPI
Message-ID: <CABgObfZ3uutsJUMwEcoZpJ-WwxWwfFrAfq6_9TGkFekOM3UXHg@mail.gmail.com>
Subject: Re: [PATCH 2/5] rust: use inline const expressions
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, May 6, 2025 at 10:51=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
> > -        let _: () =3D CanReceiveFn::ASSERT_IS_SOME;
> > +        const { assert!(CanReceiveFn::IS_SOME) };
>
> Do you think it's a good idea to warp this as a helper for easy
> callback calls?

I think the wrapper would be very similar to what exists before this
patch, wouldn't it? The const { assert!(...) } seems clear enough and
not too verbose.

Paolo


