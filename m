Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E386BC25B77
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 02:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9EzU-0001nh-Ai; Mon, 20 May 2024 22:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s9EzO-0001ms-DG
 for qemu-devel@nongnu.org; Mon, 20 May 2024 22:12:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s9EzM-0004VH-9Y
 for qemu-devel@nongnu.org; Mon, 20 May 2024 22:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716257547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9wYTlOwIsCc4kNL0DH2yK+vO7f7tihGv3LLR9BQNUsU=;
 b=HKJ3KvXEOKsdbhj1eLHItzHjoTMqsRJpWzTjF1c27RRJLgomaXEZzIV19bEPD2qWAJPHzA
 qoBlae5vIJThQGBtDwvYi7OVJok7QKNoHKhIaRo9Qe9yPOW9s5U3f/EkDJ4VNJrn64Q/Oi
 UYhFHF5BTTgCBVUI8Oa6TfPSKO+b/2s=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-8qZaVjcPO8aqJOsHG4afaw-1; Mon, 20 May 2024 22:12:23 -0400
X-MC-Unique: 8qZaVjcPO8aqJOsHG4afaw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2a49440f7b5so10815939a91.1
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 19:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716257542; x=1716862342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9wYTlOwIsCc4kNL0DH2yK+vO7f7tihGv3LLR9BQNUsU=;
 b=Af7MVY/lM72HTyU1wiXykhwWH5eciKK7jcyIxzJ4OMfxlIpVsED+RpprfzzLCkULxj
 KcavRqZ/m5sq6b5IDW3BW8T3GZkYQqsarAszaFk4BluwlyDotXvkv87H1aHn0l8X59zI
 C5OZtAHMWYdp2ucLReOg4g4SbBmzoWV/3OO2y5jvg3fTfnvYfenC3NLUEXEcAznIGisK
 Wre0jiSasjSDwL91Y1R4ruvmb9g+XVS3Pa/Grj3DMYOYdODripxT5nrylZeTO8zUCW52
 qmmOB3dbMl7ECEkuX2s/oZIDM6pNO6HenyqN3mAxPurIzZXJk2K2W61duLbKRnM7b2cp
 mV7w==
X-Gm-Message-State: AOJu0Yys9+TaIyZE8nJ5i9VX1QBUICechpwp5PN6UdhOkGEN/cBAPQDO
 CzeAtdVqdF4f3dh+12bHW6bZUGnEU19M8aLT/3NtU1wGNclEEEYyVXbfJPgpweM8c5io72hi1Cu
 dIeullf2n+3REFMombUZM7KfVAuSSgRQ2NDxMOkWCK/mG2E00YAUKxncAPTF1GfjwJErHkOvGrB
 o9QryRWOz1olwkVO/Y3zFkhTyROew=
X-Received: by 2002:a17:90b:894:b0:2b4:32ae:8569 with SMTP id
 98e67ed59e1d1-2b6ccfed280mr28833064a91.40.1716257542012; 
 Mon, 20 May 2024 19:12:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7s3zBwXyvgxArq9kFNC7+95MZR5EYlpY1xYis3xOpmK5ZcGVIIT0pPOBCsLxUa+fvFwtlbdvqjYGlRGLTZg8=
X-Received: by 2002:a17:90b:894:b0:2b4:32ae:8569 with SMTP id
 98e67ed59e1d1-2b6ccfed280mr28833047a91.40.1716257541619; Mon, 20 May 2024
 19:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240517075336.104091-1-f.ebner@proxmox.com>
In-Reply-To: <20240517075336.104091-1-f.ebner@proxmox.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 May 2024 10:12:10 +0800
Message-ID: <CACGkMEsn+vtjX90OcfH+ntJfoNXEEp94PzOX2FL80KtitL9Zaw@mail.gmail.com>
Subject: Re: [PATCH] hw/core/machine: move compatibility flags for VirtIO-net
 USO to machine 8.1
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, wangyanan55@huawei.com, 
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net, 
 yuri.benditovich@daynix.com, andrew@daynix.com, peterx@redhat.com, 
 farosas@suse.de, t.lamprecht@proxmox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 17, 2024 at 3:54=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Migration from an 8.2 or 9.0 binary to an 8.1 binary with machine
> version 8.1 can fail with:
>
> > kvm: Features 0x1c0010130afffa7 unsupported. Allowed features: 0x10179b=
fffe7
> > kvm: Failed to load virtio-net:virtio
> > kvm: error while loading state for instance 0x0 of device '0000:00:12.0=
/virtio-net'
> > kvm: load of migration failed: Operation not permitted
>
> The series
>
> 53da8b5a99 virtio-net: Add support for USO features
> 9da1684954 virtio-net: Add USO flags to vhost support.
> f03e0cf63b tap: Add check for USO features
> 2ab0ec3121 tap: Add USO support to tap device.
>
> only landed in QEMU 8.2, so the compatibility flags should be part of
> machine version 8.1.
>
> Moving the flags unfortunately breaks forward migration with machine
> version 8.1 from a binary without this patch to a binary with this
> patch.
>
> Fixes: 53da8b5a99 ("virtio-net: Add support for USO features")
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


