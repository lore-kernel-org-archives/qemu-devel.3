Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C05C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrcG-0001zY-4l; Mon, 22 Jul 2024 07:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sVrcE-0001ug-O9
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sVrcC-0004xE-K9
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721649242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7t+ZSKa4nlskc6kI5581FAFmnYMMP4iTrelA6/NetKc=;
 b=Zqi1iAcLQIBV4/fLpkX5Dvf6A5C8QvoMCn/CFLXLF3/JvYRYhIIG7u2vNlTz3cN9A1zhGU
 xFzCRmnnPd6bebH/qIc3lQUERMFoDq2qM+jWbiACnO/Q1eOEnIUld/mL8a175forJ8ywRB
 DivV8LEfjHa5CgASGueUr9WsJpSy7kA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-Ssg413RBMluQujiR9mDZFg-1; Mon, 22 Jul 2024 07:53:58 -0400
X-MC-Unique: Ssg413RBMluQujiR9mDZFg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36873ed688dso2472683f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721649236; x=1722254036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7t+ZSKa4nlskc6kI5581FAFmnYMMP4iTrelA6/NetKc=;
 b=KryrVfO2jeznXcDogbOHGbkfzq5xgf2tPagZ9ih1zMcoZcOcOwdFolfkZ4T5TTy7rI
 v+N+gdUACWSlJnnYNbxgMkvdJd6C89y08MDk2zpaI7yhjt6CMqAcfw9Id4yNSbpW29OJ
 afkmpKu4QftqSrvk1SCHcwinX3UqhWtZQeEnWNB59gPsbasTo5UBOKKUBoteNI+oi85E
 i0SRCIlv3YJtKQSJMJaetqiAzq00I8oQEwUap7kRyqTea6KS6o4a/sZlrCBhzM8RgVmA
 AlvIw7n9Ue5tc+ddAJ9J8poOBqTx8clshOdbNC56vlrfY8xvRqQaVWIMnfSMaFs01VRG
 PrLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0h2tIMF4AvD7Co7XA1dvgVaiCLcPDT5JSvE+c8vSSzankuBgFIz2aXRlfHCaWNpwuaX3HiO+Wb/kxX0hYROrT58HNyo0=
X-Gm-Message-State: AOJu0Yz4AP4yA6yTiLeFksT9qyTUveTIsdZ+msFztkdkZ5DdFATZTGHZ
 7gO8Q+RpbmR44Gti1xWOAhjNza49x7XCOBonwQsw/v0aDTICCr6oOSviYTvy98xqimK9r9ln3dz
 sU1/a7a+C8DlF08TgtEQ4x1m95vXJfPeUWUe+/oDGpfb78Ti1Or818RoMmo9MVkoApKwj0A0xVO
 TunFpu4icFotKPc7A+JTX9Jd2wn0lK3qy54Jt6vA==
X-Received: by 2002:adf:ed06:0:b0:366:e89c:342b with SMTP id
 ffacd0b85a97d-369bbc930f4mr4083910f8f.52.1721649236573; 
 Mon, 22 Jul 2024 04:53:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQK/+fg6O2t8h6iuvN3F5NJ9zor5+6mVjeOZdg7OJuYcnIJLepNj+HxMgXWaycEW6h4v01rfHEG1Lx84xQ9TY=
X-Received: by 2002:adf:ed06:0:b0:366:e89c:342b with SMTP id
 ffacd0b85a97d-369bbc930f4mr4083901f8f.52.1721649236261; Mon, 22 Jul 2024
 04:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <TY0PR0101MB4285D5A3587179A5788F3356A4AE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
 <CAFEAcA_vY769Yws9t4WWitsShBK01Oua5zgarTj3YHgUuvpzTw@mail.gmail.com>
In-Reply-To: <CAFEAcA_vY769Yws9t4WWitsShBK01Oua5zgarTj3YHgUuvpzTw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 22 Jul 2024 13:53:44 +0200
Message-ID: <CABgObfbdXXXbygNn3DbN9Q7xB=kTFTFs5yxFQapSn6SAXdpQZw@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] system/memory: Fix max access size
To: Peter Maydell <peter.maydell@linaro.org>
Cc: TaiseiIto <taisei1212@outlook.jp>, qemu-devel@nongnu.org, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Jul 20, 2024 at 4:30=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
> If the HPET timer device is supposed to permit 64 bit writes and it is no=
t
> doing so, then that needs to be fixed in the HPET timer device model, by
> making sure that its read/write functions correctly handle the size=3D8 c=
ase
> and then setting access_size_max =3D8 in its MemoryRegionOps struct.

It does, and I've started looking into it[1].

The replacement for this patch is simple (on top of that branch):

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 5e60fedc089..ac55dd1ebd6 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -637,6 +637,10 @@ static const MemoryRegionOps hpet_ram_ops =3D {
         .min_access_size =3D 4,
         .max_access_size =3D 8,
     },
+    .impl =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 8,
+    },
     .endianness =3D DEVICE_NATIVE_ENDIAN,
 };

I'll now look into the other patch for interrupts. Thanks for testing
my changes!

Paolo

[1] https://gitlab.com/bonzini/qemu/-/commits/hpet


