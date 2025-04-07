Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E00C3601A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 07:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1hGY-0003YW-IP; Mon, 07 Apr 2025 03:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1hGV-0003UF-GH
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1hGS-0005WC-Uv
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744012287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePL7yGI/np6XrLPSJq8DxmtQ+ASHn4hRgL9iYhqw+YA=;
 b=QoPujYu/RE3kkxsLwSn3tYsJm2IwMT4LotWtoN21lmBrtxA6577jlC0yEqyYJ2z7wQdTlC
 NoXjeIImUv6uGFJw3tlq7odsFifH1WeNxcnA5TbRmuxYnt1g3c0GoWDuEUeAOICveJC6oF
 T7530ByW65HG5a2do/oX2k22ZtY0NEM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-OA84yOv6Ody-mY8LVHS30A-1; Mon, 07 Apr 2025 03:51:26 -0400
X-MC-Unique: OA84yOv6Ody-mY8LVHS30A-1
X-Mimecast-MFC-AGG-ID: OA84yOv6Ody-mY8LVHS30A_1744012285
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d0a037f97so23528095e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 00:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744012284; x=1744617084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ePL7yGI/np6XrLPSJq8DxmtQ+ASHn4hRgL9iYhqw+YA=;
 b=a0ChSw4u+b0j3co3PH3veeULOroJJqHnSDJjNKasCuXcB4aCMbzxwyPIKljXqEMUz5
 igNXoyX1gxnPd1OkLJUc2es5SlKWbqakcFj01AN1N68ZrpKSiif7e2e23n8rrZLykvXy
 BTAmzAX0J5x6mMMBNmHLJRJeBoqaVtTUMCOBUoo84xEvYlXAgAaMpemO412jL4bYp9DT
 E/7akH2KEVhuPrUjx/+rTEIMrFvNiEN8M28K2Jd1F6hop7ZtcqaLtk95EEU6/N17Kk+r
 DnKaYOMV9m0eCUmIItpj8zcTcLT4ijvtNXssjf3MRXOHw/2SpAIEv7HJsJGIh5nK8Tr4
 aYVA==
X-Gm-Message-State: AOJu0YzU0htc0oObqVY/PjqUEpUNLI7+DRfd+sXrDdx+3Dr+VFoTzQuc
 9on3+1FZSvqyprCwuZgxcJRzKNTPxBu78FXYrPaRZkj4hJMDHZbsAgfdfWqH68uB7DwaLjrQDKw
 nzzO2m16sxwchYCgx1fyb6+zG0kVc3Wk35olEEwJnwOWVHVEb5DxRPnVWP0jzVHWoASJuKxqXs0
 Pn6OPu07dA8mt/vmcS7pKvx0n0khMz1Cm2xTI=
X-Gm-Gg: ASbGnctqxfMwNGWQe9IT5ejZcK509aaHp4zmryIKdPpvNAW0r8eFM6fo1gUoLY+t/If
 RzwB089EfWmovmY7CCSKTYwJllTxcU3haM0ku1TxAPff4o1sCwBviU5gfroVcVq2ET9QB8Rs=
X-Received: by 2002:a05:600c:4705:b0:43d:53c:1ad6 with SMTP id
 5b1f17b1804b1-43ecfa02754mr74353715e9.26.1744012284193; 
 Mon, 07 Apr 2025 00:51:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr7TQILZKlXujmHDTUJbd6BDatx6QazSGekGPH+q/TeHB3h7aemAbTkrVDtflGZtsUhDiopD14zN23CS9AVQc=
X-Received: by 2002:a05:600c:4705:b0:43d:53c:1ad6 with SMTP id
 5b1f17b1804b1-43ecfa02754mr74353575e9.26.1744012283874; Mon, 07 Apr 2025
 00:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250405100603.253421-1-pbonzini@redhat.com>
 <Z/OAtJA8DUIsmuep@intel.com>
In-Reply-To: <Z/OAtJA8DUIsmuep@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 7 Apr 2025 09:51:11 +0200
X-Gm-Features: ATxdqUH3Do-VOiv3Gmg_4vTAALdRnwUTePkmt3GN9WQt1FCbJvtAk1Wj8Ys8P9I
Message-ID: <CABgObfYtbF6btNL_sLWtE679j_N4rydSP89tpz2w6tr9CRnCpg@mail.gmail.com>
Subject: Re: [PATCH preview 0/3] rust: update build system for Meson 1.8.0
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Apr 7, 2025 at 9:17=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrote=
:
> On Sat, Apr 05, 2025 at 12:06:00PM +0200, Paolo Bonzini wrote:
> > Date: Sat,  5 Apr 2025 12:06:00 +0200
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > Subject: [PATCH preview 0/3] rust: update build system for Meson 1.8.0
> > X-Mailer: git-send-email 2.49.0
> >
> > Meson 1.7.0 and 1.8.0 include improved support for Rust, namely:
> > * support for "objects" in Rust executables
> > * support for doctest targets
>
> Is there a patch missing to actually bump the required meson version up
> to v1.8.0?

Yes, because there has not been a 1.8.0 release yet (or even an -rc).

Paolo


