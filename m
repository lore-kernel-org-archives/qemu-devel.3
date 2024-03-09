Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E90EC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 03:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rinOv-0008DJ-5E; Fri, 08 Mar 2024 22:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1rinOq-0008D6-UV
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 22:29:29 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1rinOp-0007qJ-L6
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 22:29:28 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-567bac94719so1687386a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 19:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709954964; x=1710559764; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Va8ogusGZwdaKepctfLfXDDaga65WunO9ZGuU+9NtAE=;
 b=Tc5/VxaKeNHrQCTRJPFfb6FhALA/UMDYeEAgKcSMs5na8rABTruNRNHlJjQ81ZttFP
 KIN/4VjUCx/w+R/ih+thgEpsfG+0ZqQyiz6ELKQ9EeSrZAnaAl17Eaxa0yxmwvssMCzh
 Pkr2UfBlPkYSBbzINttzfeZMp4N/Itl2V5quu1T0GahE3S10jhO3Om7Wn8lsS95aosul
 lfIr35KZ3TGOZbxf+matIxkb2DJCAev7WJwpBJvwkBDqh6MaWe+ZUUvcNbTOu8BFx2PQ
 F7Vc14W+/JoBbxs6ahsUdx14/PLt9cOQe3DOoUrRmWwjcDQMebyCR83SzIGjdTtbdnix
 nyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709954964; x=1710559764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Va8ogusGZwdaKepctfLfXDDaga65WunO9ZGuU+9NtAE=;
 b=bxUMyfrcOJJ6HHD4NNbTfvHKu7st3ZpTulH6s1Len6scehDN3cTH16BReOwulh/v7y
 C3Fh/eWrHLHgrQLOvI6boTVY6p/zX4iUG648bzc3SXtKWoTBAl/kkirwSF09erjNGfN4
 PsaWk/CiXDUYAozI3o9ejf3ZdhBF3+W1pssYMN6T8FYjLoegv3oygA3A8riSkLetEhQk
 WRTyhoCMEpckJ3vozaMHL/HwYh2EIhSw40z0rQR8KBsITV4yhpB6aUqZfGdnn188RocN
 zu948KZnM/XL5BaCAjRDrJcymt+5Piakpj7bRMKqMHQ7lc8skzHHbjbnPBLVKvRyDCS2
 fx5A==
X-Gm-Message-State: AOJu0YzOK5y5y2pGzEXBzwm2whoV9xou7IvZbHBnSzm+CpZwWrT3ok45
 4wFYZiQJR5Ze1epbmqWjMrLHRw9lVzTdP8EHLN+kQNV/D8TYurnEUUVU2+vFbdBxVND2daw6z3e
 GG+D1sfK0MHK+Gm/9rw9AZoXWcA0=
X-Google-Smtp-Source: AGHT+IGAGGrOzMwhBAKfnLe170l7WdnKP+Is5I9SeSwO++dhjS2Gz++v7KuOxzYPkHCn5T2VAxp61pjrLtMX0iV+cac=
X-Received: by 2002:a50:d6d7:0:b0:568:1f9f:eca4 with SMTP id
 l23-20020a50d6d7000000b005681f9feca4mr553180edj.42.1709954963873; Fri, 08 Mar
 2024 19:29:23 -0800 (PST)
MIME-Version: 1.0
References: <20240305191312.321127-1-marmarek@invisiblethingslab.com>
In-Reply-To: <20240305191312.321127-1-marmarek@invisiblethingslab.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Fri, 8 Mar 2024 22:29:12 -0500
Message-ID: <CAKf6xpte=2ugj187gw1cxY361XGgM2As67PgAQEEheVYbG2n5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/xen: detect when running inside stubdomain
To: =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=jandryuk@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Mar 5, 2024 at 2:13=E2=80=AFPM Marek Marczykowski-G=C3=B3recki
<marmarek@invisiblethingslab.com> wrote:
>
> Introduce global xen_is_stubdomain variable when qemu is running inside
> a stubdomain instead of dom0. This will be relevant for subsequent
> patches, as few things like accessing PCI config space need to be done
> differently.
>
> Signed-off-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingsl=
ab.com>

Reviewed-by: Jason Andryuk <jandryuk@gmail.com>

