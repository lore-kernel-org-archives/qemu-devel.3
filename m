Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74717C5478C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 05:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhNMl-0007Hs-Tx; Tue, 05 Mar 2024 00:29:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rhNMk-0007HS-D8
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 00:29:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rhNMi-0008Jf-VX
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 00:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709616563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7dkAnfeoI4SxhbBfRkOMs4dg8oNOTcXD85UQL1i4agY=;
 b=jBLvhyDQeDS14heqGBU23yHgtxwlfg1XB7L0BUSULFtKObwZfg8hMMQoXF7c8Bwtita2zD
 J9zlenBfy5/uJLz4tzDT2UME7vyNytlUKKoxAilA0VuUIERULV+bSoiKXlRDeibJx3knkZ
 lbAu+c0afbVXw+KFXQKo3IDCWpzcQ24=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-YE_c2vT-OGeJOVJbY9k-Jw-1; Tue, 05 Mar 2024 00:29:21 -0500
X-MC-Unique: YE_c2vT-OGeJOVJbY9k-Jw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33e0d943844so2113997f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 21:29:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709616560; x=1710221360;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7dkAnfeoI4SxhbBfRkOMs4dg8oNOTcXD85UQL1i4agY=;
 b=OZ5nqGuXLk50ns788gbEN8UU4EFI+iDNCqEXN9plabRZ2JQpaLwQJ1wTR677oiuhlx
 gPKWJda47K8PJpYTTYHYmNMKjTEQt22rcMD+T/llYJBhJruIhrNPMjNeMrlCRdaXHqXk
 mqdweYmKr6vTxt7s1iYn6FCnBp2Ceuayyeyucn+UMw4Z//52HFZq5hFUWLkdhwzMVtvg
 jBkOE4pnT4qJ3YcI8dZX0gYJ37/4qFWKkHD6U1dP0Yy1hZfx7p8k6i/lYHEEsfF37a8o
 AuUO2ULKGoFy+oz7OdAZgfLQe8qiOhdxyro9cycQiYYLGv4/Hgo2w89CBfjjOFEflVer
 J9Kg==
X-Gm-Message-State: AOJu0Yzm23TbgtICAB7A1EjnRbZlBg3ykJ0YBCmjq196GisNT3GBF/aZ
 AwEuaKucvjzE4dRDphOdYAkRzsvIs5NK//nRdtF0Hkko7zNKzpqji1S6c8f7ErEpuff58U3VBTp
 7XUZZQfyVNzw/9/rN5HE1EWDgZRK3+bJpRj8ik+4waCggPS2KhcGpjt4e2nlR+v3JI1jzFf6LFe
 cpZlew1+v8A3D/KMntVAyCOSFRayw=
X-Received: by 2002:a5d:5981:0:b0:33d:29c1:c28c with SMTP id
 n1-20020a5d5981000000b0033d29c1c28cmr9319226wri.66.1709616559939; 
 Mon, 04 Mar 2024 21:29:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHtByIoXH4sj245mgoLPaXfeL85bYqB3Xolc5jMoIe4cyulXJ3yy9iws4QevoFbQC9glGX4c8hv2NFjb1mejk=
X-Received: by 2002:a5d:5981:0:b0:33d:29c1:c28c with SMTP id
 n1-20020a5d5981000000b0033d29c1c28cmr9319219wri.66.1709616559703; Mon, 04 Mar
 2024 21:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20240304122844.1888308-1-clg@redhat.com>
 <20240304122844.1888308-5-clg@redhat.com>
In-Reply-To: <20240304122844.1888308-5-clg@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 5 Mar 2024 10:59:03 +0530
Message-ID: <CAE8KmOyxw2SYiW20V9MZZMJGL7ioHSALknZ=N4EZOS53S_i3TA@mail.gmail.com>
Subject: Re: [PATCH v3 04/26] migration: Always report an error in
 ram_save_setup()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex.williamson@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 4 Mar 2024 at 18:01, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> This will prepare ground for futur changes adding an Error** argument

* futur -> future

> +    ret =3D qemu_fflush(f);
> +    if (ret) {

* if (ret) -> if (ret < 0)

Thank you.
---
  - Prasad


