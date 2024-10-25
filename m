Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4054D0BB56
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 15:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4MFg-0006uh-Kx; Fri, 25 Oct 2024 11:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4MFd-0006th-21
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4MFb-0000i4-Qj
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729870158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sx95/rZCRcP4TaAlrQw1bsqtAnWPmDOUo+4Gs38q33A=;
 b=H5DAoAjNiaYqoWnMpUSRKqUN9lTXthrX2ZHZvVE8j4+Ya0q7nyPY+0VA7EzdqDQJLCaA5J
 MGf/lVzg4iR3fnIo6OPPCiM1zqg7JMUOsYUB1MblWtuT8Y31c5xHDFRMQRkjTYD4X+MgZI
 onRzpuswDTpw5U0pLgFgkG7rgIbiv0Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-pi3wCwNFM2uOhDodICl7xA-1; Fri, 25 Oct 2024 11:29:17 -0400
X-MC-Unique: pi3wCwNFM2uOhDodICl7xA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d49887a2cso1164005f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 08:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729870156; x=1730474956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sx95/rZCRcP4TaAlrQw1bsqtAnWPmDOUo+4Gs38q33A=;
 b=i78ua5SP4/YKQQcZrBKzEwpZkcOKlaZJ9yx3dA1dICd16K9jGNFjoPAokR7DoxrrPT
 MpdTuZUmEkKV8HmYyc6uf0tilN+dEKPp04GfQbuWKjeDFj2C3kL3lo+Lf9/gUE5gPPq2
 4rxt3e0TPJBl2cZRbj8td0X2WW/Z41KNuG/tXspSJIF3woS9beEkyuTyD/CGYEy2/UJX
 NNyEcxbiOPaxqhS0VxwpghidR41JEpwawNa1TFZK2W8lqPHxriH8mr1Z4yFC6GYx4eSS
 vVEvtE29GKz22R8ig8e+IOdtsWZiN2dTPucKbzurjrVL+wbTvDH14AYXDmAyCl54edfN
 +qVQ==
X-Gm-Message-State: AOJu0Yw77XUwhTbRl1j90/U3FVR1vHszjbvK9GMse4z62RuEc1wZP0HE
 odH5n2j4jr1+m1D/aR2NgcW/CPgjIXIB/3AdXLlY+/2E0vXrkce7WNLVoWoXVG9BYOmwuVZ39Lf
 D6wAgKWAohT+/GgP89NgkBnSsbQ9ILyXdCqyOn/PC2YkdnewpKOe4rb8ywDcl58NGVb6SOYOptf
 MYMrglNmzUtQB6Rg88r78NqRpMq9U=
X-Received: by 2002:adf:ec0d:0:b0:37d:4660:c027 with SMTP id
 ffacd0b85a97d-380458826a4mr5364994f8f.24.1729870155732; 
 Fri, 25 Oct 2024 08:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKp4S5VSSp18QfCyYZxvXOPUWZS4RBJOa4L6SRYnAhjd3Ip1e2mXh6ambd4kaxRqyOne9YqHn8QhnYMVV0rk4=
X-Received: by 2002:adf:ec0d:0:b0:37d:4660:c027 with SMTP id
 ffacd0b85a97d-380458826a4mr5364977f8f.24.1729870155403; Fri, 25 Oct 2024
 08:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240710062920.73063-1-pbonzini@redhat.com>
 <20240710062920.73063-8-pbonzini@redhat.com>
 <806baf9d-5549-4298-99e7-f50fdf69f99d@tls.msk.ru>
 <c82f5323-9fa8-4c65-83dd-fbfa38d26f4b@tls.msk.ru>
In-Reply-To: <c82f5323-9fa8-4c65-83dd-fbfa38d26f4b@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Oct 2024 17:28:52 +0200
Message-ID: <CABgObfb7aoChrq=TgUqfjTkPMxhbeoW70EYFq188hUcsdUT-zA@mail.gmail.com>
Subject: Re: [PATCH 07/10] target/i386/tcg: Use DPL-level accesses for
 interrupts and call gates
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, rrh.henry@gmail.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 25, 2024 at 5:26=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
> > It can be picked up for 9.1.x, but for 9.0 and before it needs a few
> > other changes in this area, like v9.0.0-2238-g8053862af9 "target/i386/t=
cg:
> > Compute MMU index once" and v9.0.0-2236-g059368bcf5 "target/i386/tcg:
> > Reorg push/pop within seg_helper.c", or it needs a proper backport.
> >
> > What do you think?
>
> A friendly ping/help? :)

Hi! No, this is totally ok for 9.1.x; it missed 9.1 but it was already
submitted back then and it's okay to apply it there.

On the other hand, Richard wrote some large cleanup patches to enable
this relatively small patch. The bug has been there for many years, we
can keep it in 9.0.x and earlier.

Thanks,

Paolo


