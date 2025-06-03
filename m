Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807DAC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 15:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMTSX-0006Ao-NE; Tue, 03 Jun 2025 11:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMTSS-00069q-0O
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMTSH-0007Ba-2x
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748964087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h8G2NpZWF37ZnxQMdsyXcKxzQUWp/6jyXJYYUDIwp6A=;
 b=c1cJJl6cJyElKgh/ybrJ9oJaPZJScj64t+guj+paDTPQulLQpy0qQjWYfb1uwOh/NH573+
 1R8T5f1YDqgjLMht0W14oImAih1u9fdrQgCxHQXqzGV24unkG48oc84ohpLwK43yeoogqm
 s+RWoUTBDdeDGfZsEkmxhaQTWyyMheQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-jeb151meOrqbnkOBiUgU_g-1; Tue, 03 Jun 2025 11:21:26 -0400
X-MC-Unique: jeb151meOrqbnkOBiUgU_g-1
X-Mimecast-MFC-AGG-ID: jeb151meOrqbnkOBiUgU_g_1748964084
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450db029f2aso20073695e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 08:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748964084; x=1749568884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h8G2NpZWF37ZnxQMdsyXcKxzQUWp/6jyXJYYUDIwp6A=;
 b=GckT6xY9ogLqp1k/Kjrkoq80D7A+RQcaeLG9VcFa0sE03E3Lhf3jZTiXuqYTOqn/gY
 7RQc86U0v4Nw0uz8Ynl11zHuB0nx3jI/wbtbk0go9HTp23HEnrwHev4589qUgsK8MIdC
 +iWuIEWGKU3UvNkkzTyxZHsxVhQinL/2UwUGwr0E9oj+niA7Ej+9xTc1eiSpsRCUwkzm
 wwoA2X39K0sl3fUOQHKOybQrr0oIf+xa/ak04L6wAnGb6AO8JQLqWFhmwhbIxb7euDAx
 o7iOIArEj6KmxMxb+YqWNh/umtF+vIqNfgQ7Qhrc8f87XJP7P/5AK8XuqwYT4nNQwHd9
 fvjw==
X-Gm-Message-State: AOJu0YyDG/HLzt+9HC9Y1nBIrzh7WRo2FYz+8sr0XseaWhiFxk0fkxzR
 taQUph4dgK6jdTuhWXjnOzhnyoiVw3VfG2H0Fre4gXb/JKmWz+kbx6DZrbNc1UXZ+nHkU/lQEFE
 kM+9C+emYkdNqEs6ojnLZtwWGQ4uNdYenjQpoGAOHhK7CH8WeXxuXhfMO
X-Gm-Gg: ASbGnctuUdBNEdzsBrLGAEZp5+CD3PJujpsN6oyOt1ElDbUupmwVYY8TRa5mjLeb+Ar
 SMGzZy10itEHsjBWfGpYAfUEvZcG6Kgb1GcoXjPuv4ZcOK6Zdu4WbhZNWTp7Pip0h94fk+HpTQz
 TTvTuNm3GdTKmH9bkYxBPuCnw9O8R64K5WQNNcsTGopwAPFk2NIcpglRexpSuMeFM6yGu8G8GC4
 jSC2qVVIkbpE7mZ85+iNKJmjQlwnAf/p80jXTi6mv5L8QnhkulZOswnriX+cjxPdrHvV2ylbLdM
 fgjKaL3ajyIw1/RUvGvIZkP1dGPHsLBkjKGOviUP+fg=
X-Received: by 2002:a05:6000:4313:b0:3a4:f6f1:faef with SMTP id
 ffacd0b85a97d-3a4f89ddd63mr12141908f8f.32.1748964083731; 
 Tue, 03 Jun 2025 08:21:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE45MwL+K7W37edCmani+So1RbTIOrBIHoEwkMXyO6kqF8G3s3U8wu3tGFQoABnYXIoWH4rw==
X-Received: by 2002:a05:6000:4313:b0:3a4:f6f1:faef with SMTP id
 ffacd0b85a97d-3a4f89ddd63mr12141888f8f.32.1748964083270; 
 Tue, 03 Jun 2025 08:21:23 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451e505d40csm24265605e9.0.2025.06.03.08.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 08:21:22 -0700 (PDT)
Date: Tue, 3 Jun 2025 17:21:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>, Hanna
 Reitz <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Ani
 Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas
 Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 01/18] hw/i386/pc: Remove deprecated pc-q35-2.8 and
 pc-i440fx-2.8 machines
Message-ID: <20250603172121.27141cab@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250501210456.89071-2-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-2-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu,  1 May 2025 23:04:39 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> These machines has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") they can now be removed.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc_piix.c | 9 ---------
>  hw/i386/pc_q35.c  | 9 ---------
>  2 files changed, 18 deletions(-)
>=20
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 98bd8d0e67b..0d6ad9db627 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -746,15 +746,6 @@ static void pc_i440fx_machine_2_9_options(MachineCla=
ss *m)
> =20
>  DEFINE_I440FX_MACHINE(2, 9);
> =20
> -static void pc_i440fx_machine_2_8_options(MachineClass *m)
> -{
> -    pc_i440fx_machine_2_9_options(m);
> -    compat_props_add(m->compat_props, hw_compat_2_8, hw_compat_2_8_len);
> -    compat_props_add(m->compat_props, pc_compat_2_8, pc_compat_2_8_len);
> -}
> -
> -DEFINE_I440FX_MACHINE(2, 8);
> -
>  #ifdef CONFIG_ISAPC
>  static void isapc_machine_options(MachineClass *m)
>  {
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index a1f46cd8f03..54c18100122 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -639,12 +639,3 @@ static void pc_q35_machine_2_9_options(MachineClass =
*m)
>  }
> =20
>  DEFINE_Q35_MACHINE(2, 9);
> -
> -static void pc_q35_machine_2_8_options(MachineClass *m)
> -{
> -    pc_q35_machine_2_9_options(m);
> -    compat_props_add(m->compat_props, hw_compat_2_8, hw_compat_2_8_len);
> -    compat_props_add(m->compat_props, pc_compat_2_8, pc_compat_2_8_len);
> -}
> -
> -DEFINE_Q35_MACHINE(2, 8);


