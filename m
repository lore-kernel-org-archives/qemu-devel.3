Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A333C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 06:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twxMV-0001KI-To; Tue, 25 Mar 2025 02:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1twxMR-0001Jo-7S
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 02:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1twxMP-0004dg-DR
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 02:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742882519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=41w4XlLjCBNIAfCgh6rLc4xYQJ7WnqeLjZfz3O2dAxw=;
 b=VhE3+27HoS+ArRJdZd8vfppQTyV3yPqW5CCoW28iCO0QaSob3+yNHCCoXqHGG7ywqy8Mr3
 wusnzibtlARw8YCyC/Hg+8PpdkDx6uYZuFYM+DtgxGEti96AlTh/RszViYQhJEMGdXpWhG
 /GYZchPNDoc3S/uXuJ+QF1krwVsjl/U=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-wUO9-0QjPne1h3VCHwWf-Q-1; Tue, 25 Mar 2025 02:01:44 -0400
X-MC-Unique: wUO9-0QjPne1h3VCHwWf-Q-1
X-Mimecast-MFC-AGG-ID: wUO9-0QjPne1h3VCHwWf-Q_1742882504
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c3c5e92d41so884108185a.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 23:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742882504; x=1743487304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41w4XlLjCBNIAfCgh6rLc4xYQJ7WnqeLjZfz3O2dAxw=;
 b=RW86AXYkKsIwCB7wxUZiSbwQYt3lTIwxZajOxdFWjr4N9h1iH1uHqpjlBNYq0SYZJm
 YLMUs9ozcl/1e4K1mFw2JE3OvxA7TeQirPrTidBT9TCj7uTUCFFc/to29hko8EeayfiZ
 i98un4s164SkoeMftq9bTnroy1zrYQDCQJzrYr646zjggrPPPPoSP+H/7Xol8nEgDmjl
 hUP5384akvwgQcFf6RcAWJxEYJxofGkdsCQtnb4HYSP8zTtt90XZmDBBKWApd8lZTP4w
 XuB7ljlnNcfzv9dqw4fJljgMPcKUtNjQWoLWId2OwR+g4l4PRadVOygWe+ocoIW7xViY
 IjSA==
X-Gm-Message-State: AOJu0YwS/bzKww1hX86799q5HpsddLXSa18k0Yf32Tgsi3TJCmSvC6Ob
 nCo7kLnnAqbvWjbl9Rmc4VYel4IQge7X21ZqckUd7l7hBKEZ1nCAD+Rmim2osuh5ns5PNFs+Gbu
 G9rF533yXWmBTchI8PVGiLjOH+aK5o3wDTGF9K8OcRjSp2/aj2i9rKL0L/fjLNlMd/S9O++PZ03
 2hYDAMy1TJmJGuHLrmI0dkXlVeFxw=
X-Gm-Gg: ASbGncuUqNZPrDoPOPmKFaoxPMHr2ITIibBWEItlURq8Uw94Rgi1ubHFbdoHR2Qt+8x
 b8Gls8j2JIsHeyxBvZZAEFpvPR9vPbMFKHM68u/G0G67O0y121q1YD4Ijzd5CFGGvkMcWXQKNl9
 DLX33W1kzE8ApHPMxLptZsnnAlX1CMcQ==
X-Received: by 2002:a05:620a:284c:b0:7c3:cd78:df43 with SMTP id
 af79cd13be357-7c5ba2058b8mr2393512985a.58.1742882504178; 
 Mon, 24 Mar 2025 23:01:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzwgNTBW9V4BPvohd5XLnnM9nb0X/lZ0hZ/NgCNpCnG2/8QEMKI7QBKQOAJlXUrsjyL4TqGyPfoA7vgL6l3tI=
X-Received: by 2002:a05:620a:284c:b0:7c3:cd78:df43 with SMTP id
 af79cd13be357-7c5ba2058b8mr2393509585a.58.1742882503712; Mon, 24 Mar 2025
 23:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250325055125.253669-1-thuth@redhat.com>
In-Reply-To: <20250325055125.253669-1-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Mar 2025 10:01:31 +0400
X-Gm-Features: AQ5f1Jqg4ZwtNmvl6r21_oceMQxSDBMSbgaBuYyIIQL4SN_ijH4_MP-Z2BNYA28
Message-ID: <CAMxuvaytXkiBYyV_NODet8QFNPrSJ-UF28YW5DR6-qo2wCTfTA@mail.gmail.com>
Subject: Re: [PATCH] meson.build: Put the D-Bus summary into the UI section
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Mar 25, 2025 at 9:51=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> From: Thomas Huth <thuth@redhat.com>
>
> We've got a dedicated section for UI options nowadays, so the
> D-Bus display should get reported here, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index 41f68d38069..205fb43bf7b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4559,7 +4559,6 @@ summary_info +=3D {'Trace backends':    ','.join(ge=
t_option('trace_backends'))}
>  if 'simple' in get_option('trace_backends')
>    summary_info +=3D {'Trace output file': get_option('trace_file') + '-<=
pid>'}
>  endif
> -summary_info +=3D {'D-Bus display':     dbus_display}
>  summary_info +=3D {'QOM debugging':     get_option('qom_cast_debug')}
>  summary_info +=3D {'Relocatable install': get_option('relocatable')}
>  summary_info +=3D {'vhost-kernel support': have_vhost_kernel}
> @@ -4742,6 +4741,7 @@ summary_info =3D {}
>  if host_os =3D=3D 'darwin'
>    summary_info +=3D {'Cocoa support':           cocoa}
>  endif
> +summary_info +=3D {'D-Bus display':     dbus_display}
>  summary_info +=3D {'SDL support':       sdl}
>  summary_info +=3D {'SDL image support': sdl_image}
>  summary_info +=3D {'GTK support':       gtk}
> --
> 2.49.0
>


