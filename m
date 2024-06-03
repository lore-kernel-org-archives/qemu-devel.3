Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C5AC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 16:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEAjq-00027o-Jw; Mon, 03 Jun 2024 12:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEAjn-00027G-Eo
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:40:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEAjk-0002Js-0n
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717432841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jm7/c17pCmhKplPGMl3cwEXH8vw38dSXlJDxmUHGtRk=;
 b=PnCExvQHorqZPLW7MGFowR6Aupu2arl2AkuxIn76UChQiSbKFMmj2sCPqWOe2ZkuGtvG0c
 wQRrv8lv7iUUrwqOTME9b+8vGpND5RMw1GRj5Uom1I2nTkcI0sVYGOHIlCPrrOi0vNutq+
 VVJfw/JITPBJj8tEBfgSgUni2/xDORU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-ZlasAvw9PB2kvt7AiGdbWw-1; Mon, 03 Jun 2024 12:40:40 -0400
X-MC-Unique: ZlasAvw9PB2kvt7AiGdbWw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4212ddfb1acso19651245e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 09:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717432839; x=1718037639;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jm7/c17pCmhKplPGMl3cwEXH8vw38dSXlJDxmUHGtRk=;
 b=MHk39HIcdilxqIxueWSPeD1CCqWx9gZbAToiDR1RWeFRDQfwHZiVk9NdGJAyjftPYT
 l1mkSoVi6Lk1BvxmsgSDNGA5Lh74vBQtdWuDfXFY6EZrhI7ZuLDF201J8xOlp2ukmKp0
 Zoo8qqR7k3j47PV9m7e5VrjbO74PT1/YoCQoS8+h927zjHf845PxLe00zVcVr/YGlKTJ
 BzYeey9Rrx0KHbgpU+DDQS49oQi2Qn2hvkYen9jf1R4x5Zdbv8xSgpnOrx1ayW9OgcZ7
 FbqvR/eciTS9K3hw8TVWKy9x3979prM9yox1hG8+bA3IHHtfSDHm1IgnTMVkHgn1+RE6
 uFOA==
X-Gm-Message-State: AOJu0YwSldKhwTko0uXksFTdccF16mxZhNNW3up5VgBFTfbiieTXP+/7
 wUWq37m1M1rygEvJkr9H5JhF+h/ercPUvHXiPozLYYIOLaudRr0/TlMPz114mr5Kq2MunbKsanH
 xfeFmDI2QpCu5ggLNA7EsXVizcFioiMuvpGL2i3Ufb3EqEb+WgJZ63AftUiLT++/C2dStCVgkXS
 gcsCcPKOLKgzyjwD3bVN7HWGaABGU=
X-Received: by 2002:a05:600c:1550:b0:420:1fd2:e611 with SMTP id
 5b1f17b1804b1-4212e0adf99mr60328265e9.27.1717432838851; 
 Mon, 03 Jun 2024 09:40:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0OaZUjle2CBmUTaxDO5pAhAzccE8SUD4WBEM3Sf6D+m3qdtOlZmCF1c68CcaK1UjrqLEqPFSKkqLATUb41gc=
X-Received: by 2002:a05:600c:1550:b0:420:1fd2:e611 with SMTP id
 5b1f17b1804b1-4212e0adf99mr60328105e9.27.1717432838505; Mon, 03 Jun 2024
 09:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240603131141.834241-1-pbonzini@redhat.com>
 <20240603131141.834241-4-pbonzini@redhat.com>
 <874jaam30g.fsf@redhat.com>
 <CABgObfaROVKsGD1sLk=ry4PSRzBbEHe9GZzew7F6Pqf6QLBDwQ@mail.gmail.com>
 <871q5em1si.fsf@redhat.com>
In-Reply-To: <871q5em1si.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 3 Jun 2024 18:40:24 +0200
Message-ID: <CABgObfZiORJVO5pfsGeXKTsNz3rQjQA+PPeXp=xr-Yt+eMGSFw@mail.gmail.com>
Subject: Re: [PATCH 3/4] linux-headers: Update to current kvm/next
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, 
 Pankaj Gupta <pankaj.gupta@amd.com>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jun 3, 2024 at 6:25=E2=80=AFPM Cornelia Huck <cohuck@redhat.com> wr=
ote:
>
> On Mon, Jun 03 2024, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> > On Mon, Jun 3, 2024 at 5:58=E2=80=AFPM Cornelia Huck <cohuck@redhat.com=
> wrote:
> >> Hm, I'm not sure updating to kvm/next is a good idea ("current kvm/nex=
t"
> >> does not mean anything without a commit hash anyway.) I think we shoul=
d
> >> only update to something that's in Linus' tree already... how stable i=
s
> >> kvm/next?
> >
> > It is stable, things are only applied there once UAPI is set. Even
> > rebasing is very rare.
> >
> > The problem here is that if (as is the case for 6.11) the merge window
> > only opens once QEMU is in freeze, waiting for it would delay merging
> > the QEMU side by 4 months. In this case, the patches barely missed
> > 6.10.
>
> If we're confident that it's stable, can we please mention a hash?

Sure, it's commit 6f627b425378915b6eda30908bedefc21b70b8c4.

Paolo

> "current" is not very descriptive :)
>


