Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B44E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 15:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSI5L-0006Wn-GO; Mon, 30 Dec 2024 10:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tSI5K-0006Wd-7r
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:53:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tSI5G-0004Ek-AY
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735574012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AS5Bh5sX85melR8fTJiUPd5+KNHEvPSpjEH/jnrfhBY=;
 b=U2zMEfKaXmAyWgue2MsGDF9huUJSl3b+OLiw5wgH4D2tusEmP0wMMFtUMLnrWtgY58p1mS
 lW3d4FaHR0UcKzncITPiSAhJH0STgYBJsdPPwUfePmjZz3PygcKp4fS87EzO7cJWkOI124
 wS9FY9rFbHtxbHQ5g/ZXLy+no3Pf5/I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-q3hC-OwjMiiBqICml1qlOg-1; Mon, 30 Dec 2024 10:53:30 -0500
X-MC-Unique: q3hC-OwjMiiBqICml1qlOg-1
X-Mimecast-MFC-AGG-ID: q3hC-OwjMiiBqICml1qlOg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436248d1240so46546885e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 07:53:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735574009; x=1736178809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AS5Bh5sX85melR8fTJiUPd5+KNHEvPSpjEH/jnrfhBY=;
 b=NCMj7kLsZJ5xGavI1o5WGJLMqMDaOk3e/Y3zVhfXJ8IBAfY7913bwSNQ6sttLlQqoY
 HVffu2m1lLe1DrINtoN/SYFW5FGpe+SDNoZ+Y+PBiJRxX07BLi9TEvSQ6ODg3VKt8a6D
 DXN+rN2yuuJhEc7ZX+2JI3THcs0t74C8ez4Hubo5wexHBw9N0294/7daUOKonQMLnQRL
 t4v/bKSLWnmt5/xB1KJcERujjsDdqtQ4PwBhn5eVqhginRnWLErOyfsfo5oZ04g8p3ju
 TiuSqCk5rba5cOHB5jR57q4K5wmXcpw5w1N5LDIAd6Nrnt7H/p1qB9UD2ueuZQpmWVtf
 BdtA==
X-Gm-Message-State: AOJu0YxlRYoSxEF0pKvnqwK5PkurliEvben4zocORgMhfdrFxI9KzLds
 EzhhVMhyiDU6Ijzo8zA3pHpHdB0Umye8SSBnxyqXi8WtjxK3KhSmK+Pb2BjqO217PGjVui/nW4+
 N4Vc3lD3VbtwGpIs9BnCQQqvpSac/AG/w3xsH6Ff/LL7Yl238gCsvkdwn366i5vKUt0RsebWtaU
 3yMwBUjtdYV7SjeONJTk1zHSWG3z+M62J2LStX
X-Gm-Gg: ASbGncvb4wJtW/U9hmnGEvZdg7eDYMtAIo/IrDcGd61fZe5RaumcxBE6fqoLsZtG8FW
 4scqb+/rhnBnDfuEXBTDlmLZv0fwOJuitqw1dMGLTFIw4CA8s60Mgr8o8Bv0p3hPE2AIZXNlAtM
 YYm96TvUiTKXcFVF2tUtgVk0iWv8aHANYuBUFHUP+sF18GjZskXM7PTTPvvr4/JQp44T1x88gq5
 cO8Y+4ugF/9tstkBWQII8OPx9Lj1XwRaUttbAa2jmoRlC97QjzY9JvZrFLV9DPZxJ9fP/eiSMEz
 XRmXFWYEPU0g7C9rAo3P6rS1Gdo4
X-Received: by 2002:a05:600c:350b:b0:434:f131:1e6d with SMTP id
 5b1f17b1804b1-43668643203mr377939305e9.10.1735574008739; 
 Mon, 30 Dec 2024 07:53:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaLSDwSFWA9e5Gg49W03l5xxUdL3582hGwN6ZSNr4s6CLVLqWqJI0VaZuEAfxfToTNoU6owg==
X-Received: by 2002:a05:600c:350b:b0:434:f131:1e6d with SMTP id
 5b1f17b1804b1-43668643203mr377938965e9.10.1735574008300; 
 Mon, 30 Dec 2024 07:53:28 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e357sm31208837f8f.72.2024.12.30.07.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 07:53:27 -0800 (PST)
Date: Mon, 30 Dec 2024 16:53:27 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, Linuxarm
 <linuxarm@huawei.com>, mst@redhat.com
Subject: Re: [PATCH v3] fw_cfg: Don't set callback_opaque NULL in
 fw_cfg_modify_bytes_read()
Message-ID: <20241230165327.4cedbd1e@imammedo.users.ipa.redhat.com>
In-Reply-To: <d7800cd30fbe4d23ab019f4d35792469@huawei.com>
References: <20241203131806.37548-1-shameerali.kolothum.thodi@huawei.com>
 <d7800cd30fbe4d23ab019f4d35792469@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.187,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Wed, 11 Dec 2024 09:15:53 +0000
Shameerali Kolothum Thodi via <qemu-devel@nongnu.org> wrote:

> Hi,
>=20
> A gentle ping on this.
>=20
> Hope the fix here is still valid and can be picked up.=20
> Not sure by whom this will get picked up though.

Perhaps Michael an pik it up, CCed.

>=20
> @Gerd?
>=20
> Thanks,
> Shameer
>=20
> > -----Original Message-----
> > From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > Sent: Tuesday, December 3, 2024 1:18 PM
> > To: qemu-devel@nongnu.org
> > Cc: philmd@linaro.org; kraxel@redhat.com; imammedo@redhat.com;
> > wangzhou1@hisilicon.com; linuxarm@huawei.com
> > Subject: [PATCH v3] fw_cfg: Don't set callback_opaque NULL in
> > fw_cfg_modify_bytes_read()
> >=20
> > On arm/virt platform, Chen Xiang reported a Guest crash while
> > attempting the below steps,
> >=20
> > 1. Launch the Guest with nvdimm=3Don
> > 2. Hot-add a NVDIMM dev
> > 3. Reboot
> > 4. Guest boots fine.
> > 5. Reboot again.
> > 6. Guest boot fails.
> >=20
> > QEMU_EFI reports the below error:
> > ProcessCmdAddPointer: invalid pointer value in "etc/acpi/tables"
> > OnRootBridgesConnected: InstallAcpiTables: Protocol Error
> >=20
> > Debugging shows that on first reboot(after hot adding NVDIMM),
> > Qemu updates the etc/table-loader len,
> >=20
> > qemu_ram_resize()
> > =C2=A0 fw_cfg_modify_file()
> > =C2=A0 =C2=A0 =C2=A0fw_cfg_modify_bytes_read()
> >=20
> > And in fw_cfg_modify_bytes_read() we set the "callback_opaque" for
> > the key entry to NULL. Because=C2=A0of this, on the second reboot,
> > virt_acpi_build_update() is called with a NULL "build_state" and
> > returns without updating the ACPI tables. This seems to be
> > upsetting the firmware.
> >=20
> > To fix this, don't change the callback_opaque in
> > fw_cfg_modify_bytes_read().
> >=20
> > Fixes: bdbb5b1706d165 ("fw_cfg: add fw_cfg_machine_reset function")
> > Reported-by: chenxiang <chenxiang66@hisilicon.com>
> > Acked-by: Igor Mammedov <imammedo@redhat.com>
> > Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> > Signed-off-by: Shameer Kolothum
> > <shameerali.kolothum.thodi@huawei.com>
> > ---
> > Hi,
> >=20
> > I forgot to follow-up on the v2 and it never got picked up.
> > Thanks to Wangzhou who recently re-run the tests and found that
> > the problem mentioned above still exists. Hence resending the v2.
> >=20
> > v2-->v3:
> >  -Just rebase.
> >=20
> > v2: https://lore.kernel.org/qemu-devel/20220908160354.2023-1-
> > shameerali.kolothum.thodi@huawei.com/
> > v1: https://lore.kernel.org/all/20220825161842.841-1-
> > shameerali.kolothum.thodi@huawei.com/
> >=20
> > Thanks,
> > Shameer
> > ---
> >  hw/nvram/fw_cfg.c | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
> > diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> > index b644577734..74edb1e4cf 100644
> > --- a/hw/nvram/fw_cfg.c
> > +++ b/hw/nvram/fw_cfg.c
> > @@ -730,7 +730,6 @@ static void *fw_cfg_modify_bytes_read(FWCfgState
> > *s, uint16_t key,
> >      ptr =3D s->entries[arch][key].data;
> >      s->entries[arch][key].data =3D data;
> >      s->entries[arch][key].len =3D len;
> > -    s->entries[arch][key].callback_opaque =3D NULL;
> >      s->entries[arch][key].allow_write =3D false;
> >=20
> >      return ptr;
> > --
> > 2.34.1 =20
>=20


