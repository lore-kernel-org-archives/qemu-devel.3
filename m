Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70805C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 15:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuvO5-0006Z0-Uv; Wed, 19 Mar 2025 11:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuvO2-0006Yf-VR
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuvNy-0004tU-Gw
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742398270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0h8SwIl8Hb9cvElXPhLALKGX6X/b72ls3prZ+smJfw=;
 b=anLWmbuFdOqA64qvYi/MHrT7SKOXzQr54w0qDv7lr9dJdyXfc0ahm4+ljvbTGDZvJB0xIf
 TiJhdSSqwbSdQ3Qwck6VnxNnjvA+uVYYrWr1AySFGUHV7+99oQE25mJmuyX3cF2MCem6ZU
 pPUxkhVrPztplmAM4CuXzRYOhPSNzO8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-sVAWZ1ugMnWfmhDBk3apxQ-1; Wed, 19 Mar 2025 11:31:09 -0400
X-MC-Unique: sVAWZ1ugMnWfmhDBk3apxQ-1
X-Mimecast-MFC-AGG-ID: sVAWZ1ugMnWfmhDBk3apxQ_1742398268
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d08915f61so26641645e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 08:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742398267; x=1743003067;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u0h8SwIl8Hb9cvElXPhLALKGX6X/b72ls3prZ+smJfw=;
 b=o9b9cQ3KLleS6WtfkakEEA5PpxZVZuOm6rWY1eSfSFc4/OAgPeMqCWao4wyXbOR+Ti
 LiOcduGs0Ne2g3P7d01zYO/KL/u0yhv/x6ImIUGCJbFkiPdeIra1HV3IFugkmS3JVpEv
 VIi6WfdDUi+i3swGtpyvVK2QLQHx3M8roY1HWTcZmrWTOtFNGePXEuNP8kMDmtUylFID
 p/WmUMrXjGs5F+SeN71pGhhr6uPXHMotFoeKmhoCYcSora5Jl6C6G3oVd32Nsr4VwHpu
 44KgX0WuKE+X0rkxydYLZnez/VeArkHDBJx2z36nvpKTpVHr+HSnifFxkVSALQqwgJka
 wUgg==
X-Gm-Message-State: AOJu0Ywq5mrTbJYvB+6wTxq3EQk9Tm5SXpfIvKUIwIcnzFywjCDZ2gn4
 05pSKTI4tQYB20A6YBUHAbPTY2y4ATeIw/5AZ34uGr//3bsAYnljTQKZ1tb//KPsX0Z6iZV0rfe
 6iurbVI8mt9jB2/eyJglC5bV58jIPfhklm7RJITLDkZMKcZ3XqL3HvCxoNf3QuCOJLcjkIPX0SQ
 1Vx9UpXI3qC4m/klDT9l2yrboou7Y=
X-Gm-Gg: ASbGnctwZdTcUnPpnWX6fH/BK2NsR3HuL8t3M8stO/VrqUVrPnCvZadxMf6/zZMVMXE
 C9fURU7Lw6OjsCBkjx7CaOQrAiOincs1Yg9kXbhb0y8wZios0B2XCCYEZGXB/ERHbAl1ZBVmxdQ
 ==
X-Received: by 2002:a05:6000:1faa:b0:38f:2856:7d96 with SMTP id
 ffacd0b85a97d-399739de3f9mr3425345f8f.1.1742398267547; 
 Wed, 19 Mar 2025 08:31:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE80KApdR/zh01TFGtYjlO9O1430u8L0eIa/V13dH31Fvn3k74msfKYw8+bm/3Sf01Ize3N9yZ2grIC6go1WpY=
X-Received: by 2002:a05:6000:1faa:b0:38f:2856:7d96 with SMTP id
 ffacd0b85a97d-399739de3f9mr3425297f8f.1.1742398267061; Wed, 19 Mar 2025
 08:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240723141529.551737-1-pbonzini@redhat.com>
 <20240723141529.551737-6-pbonzini@redhat.com>
 <8183674f-a9cc-4727-bb52-fe3d3e44804b@proxmox.com>
In-Reply-To: <8183674f-a9cc-4727-bb52-fe3d3e44804b@proxmox.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Mar 2025 16:30:55 +0100
X-Gm-Features: AQ5f1JqSJqgKHZUi1QSX-_ckitpufkAC3FADYSJgHuDQjbvQTuFy5cD4pbKknHQ
Message-ID: <CABgObfaKJ5NFVKmYLFmu4C0iZZLJJtcWksLCzyA0tBoz0koZ4A@mail.gmail.com>
Subject: Re: [PULL 05/11] hpet: fix and cleanup persistence of interrupt status
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Mar 19, 2025 at 4:29=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Hi,
> If necessary, our management layer downstream could disable the hpet
> timer by default and make users explicitly enable it if
> desired/required. I just wanted to ask if the issue is known and if
> there are any other suggestions? Thanks!

We can try to skip the timer if the interrupt would have no change -
similar to how the RTC works, it's more complex but very effective in
reducing CPU usage.

That said, if you can disable the HPET timer by default without
problems with e.g. live migration I strongly suggest you do. And in
the mean time you can also revert these patches, they were actually
reported as bugs but it's not clear what guest OS was affected.

Paolo


