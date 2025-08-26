Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8933DCA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 08:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqoar-0001pF-Ms; Tue, 26 Aug 2025 03:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1uqoan-0001nK-PM
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 03:59:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1uqoaY-0002Kt-Sm
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 03:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756195165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mk+mtFupCQTAOqpcqP0lDdZhTUxVLR/tUgiM3URwZko=;
 b=E77prLGND8NxLn6TcibaAHhilbcrncX76vO+nLGF7RicPVMhe5cMIDTRvVyT6su68QEDo+
 I/EvQUMHBhZ5R/kZTKcj18QWJuG5NOPzMdy7S7FsPo1AJZt6NdnbNvCZyFvJwTOvwtALjm
 V2y1y5gZBlJYwuP5GInjmZaz91hjO6o=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-pnjaE6jKN7uBWmlGqViq9A-1; Tue, 26 Aug 2025 03:59:22 -0400
X-MC-Unique: pnjaE6jKN7uBWmlGqViq9A-1
X-Mimecast-MFC-AGG-ID: pnjaE6jKN7uBWmlGqViq9A_1756195161
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-71d60500564so68522027b3.2
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 00:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756195161; x=1756799961;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mk+mtFupCQTAOqpcqP0lDdZhTUxVLR/tUgiM3URwZko=;
 b=jAlTK8qM3oDlwYccnT5mQ6vCsfGoh7GNMGSbm4lFHTnxhLImL1L9LPRp5XoYQgnKZq
 KrNGNj+WvvqHLXw8A97tZS7T/Eb1d3GpXs1bjPf3eAeSSj3RKLCGNh3TAr6xzqGWlx89
 6P14947psvb3ey95xEQkfUDorg6lLg+5e+uA+Wuc01tlAMq55jRGLa5u5u8hWlCTa0cB
 UJI8tuktQoc4AYD6XErPGWNfMJDEgFiLYGxX2eoYZIjYftTix2KVbBN1geY/rjUhv08U
 El+HiRy8adQrZt0R2fS+Huy9BNm/q7wWZMSEpD+2iOVPx6PlGxMLnnuuCw1F/BSAdcvA
 yQUQ==
X-Gm-Message-State: AOJu0Yz2aES5owHlKSFzoVNRttQE+biDYNOhVUS3RVRlivpN3ykV3n7j
 Ye5vBUciqsYqQt6KGOYqoqSDRgp3P4IEgdMZoShbh+YL7+PQIaHDOyG+I1n90npoKi7mzLV7R08
 p9fZuWwjelepz4aRskBesB7vetyLzzd0gylhxn4db3SYkVrshDzcMm6PS+ox24obTt3XzAAxOwj
 6Z6tyb/WF4o4Z+Lbpd/jiVO8VQwybdZ8w=
X-Gm-Gg: ASbGnctEdnggv1sTkCLvOjIn3Z3Hfsf3InvXgHm5q7dtMlD/1GQcFQAU1Z4V+fdJO1f
 hqiftb2LJY5/V4EVpatnKJMgu/t3j64gS8unfMxg+xLQe7TsAxOb0CYemPFF2TH7W6XqIUCYOTi
 OEB0RRAmKj8lXFzqCQKGdgDxDbDUkP4hkxMvdMMc5nkZhOj5oxmw==
X-Received: by 2002:a05:690c:3507:b0:71a:354:ab3 with SMTP id
 00721157ae682-71fdc2b146bmr156933407b3.3.1756195161484; 
 Tue, 26 Aug 2025 00:59:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKyboT+nQP9W/4SyIDQspszhdeFkMXHQr3AkcVHKLBx1Pjw85N/Xy38E+M7q5ckxU4IGxqMbFCyHGB+mIRcmQ=
X-Received: by 2002:a05:690c:3507:b0:71a:354:ab3 with SMTP id
 00721157ae682-71fdc2b146bmr156933247b3.3.1756195161151; Tue, 26 Aug 2025
 00:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250825143155.160913-1-kkostiuk@redhat.com>
In-Reply-To: <20250825143155.160913-1-kkostiuk@redhat.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Tue, 26 Aug 2025 10:59:10 +0300
X-Gm-Features: Ac12FXyCLa5vZgEq1efHw0hCsyI_PR4LtA44eU2KGGPBlJY_035W1uusXxGUEKk
Message-ID: <CAGoVJZw+oqNGdsmDWS0f9Yrb2SY+YV6XUzVNYkAqivvXgp2B1w@mail.gmail.com>
Subject: Re: [PATCH] qga/installer: Remove QGA VSS if QGA installation failed
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 25, 2025 at 5:32=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redhat=
.com> wrote:
>
> When QGA Installer failed to install QGA service but install
> QGA VSS provider, provider should be removed before installer
> exits. Otherwise QGA VSS will has broken infomation and

typos, should be:  "QGA VSS will have broken information""

> prevent QGA installation in next run.
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  qga/installer/qemu-ga.wxs | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs
> index df572adb4a..32b8308728 100644
> --- a/qga/installer/qemu-ga.wxs
> +++ b/qga/installer/qemu-ga.wxs
> @@ -151,6 +151,14 @@
>                Return=3D"check"
>                >
>      </CustomAction>
> +    <CustomAction Id=3D"UnRegisterCom_Rollback"
> +              ExeCommand=3D'"[qemu_ga_directory]qga-vss.dll",DLLCOMUnreg=
ister'
> +              Execute=3D"rollback"
> +              Property=3D"rundll"
> +              Impersonate=3D"no"
> +              Return=3D"check"
> +              >
> +    </CustomAction>
>      <?endif?>
>
>      <Feature Id=3D"QEMUFeature" Title=3D"QEMU Guest Agent" Level=3D"1">
> @@ -174,8 +182,19 @@
>
>      <InstallExecuteSequence>
>        <?ifdef var.InstallVss?>
> -      <Custom Action=3D"UnRegisterCom" After=3D"StopServices">Installed<=
/Custom>
> -      <Custom Action=3D"RegisterCom" After=3D"InstallServices">NOT REMOV=
E</Custom>
> +        <!-- Use explicit Sequence number to provide an absolute positio=
n in the sequence-->
> +        <!-- This is needed to set "UnRegisterCom_Rollback" before "Regi=
sterCom" and after "InstallFiles"-->
> +        <!-- but, Wix detect this double condition incorrectly -->
> +
> +        <!-- UnRegisterCom_Rollback (for install rollback): at 5849, rig=
ht before RegisterCom (5850)-->
> +        <!-- Runs only if the installation fails and rolls back-->
> +        <Custom Action=3D"UnRegisterCom_Rollback" Sequence=3D"5849">NOT =
REMOVE</Custom>
> +
> +        <!-- RegisterCom (for install): at 5850, right after InstallFile=
s (5849) (old: After=3D"InstallServices")-->
> +        <Custom Action=3D"RegisterCom" Sequence=3D"5850">NOT REMOVE</Cus=
tom>
> +
> +        <!-- UnRegisterCom (for uninstall): at 1901, right after StopSer=
vices (1900) (old: After=3D"StopServices")-->
> +        <Custom Action=3D"UnRegisterCom" Sequence=3D"1901">Installed</Cu=
stom>
>        <?endif?>
>      </InstallExecuteSequence>
>    </Product>
> --
> 2.50.1
>

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>


