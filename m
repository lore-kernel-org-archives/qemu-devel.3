Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C11C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 11:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYkzt-0008Bx-2O; Fri, 17 Jan 2025 06:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tYkzZ-00088v-7T
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:58:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tYkzU-0001Vz-Dy
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737115096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vgiFfaasXO8VGobwAlMlzIj6h+bzf61jzxiicScyZz8=;
 b=GGsKLcUvwUIuikt/XtbuEaSv6Ap2sPykiNPtbgX5kkQRV/3WQPYEAnnE3Bwyg+w3aSo5OG
 n4fu/tWrD/E5CipOCVnshIUn6YHPP2sDbAGxha3zLJKg1t9DmthsECXZ6xPWxLhxbgBrv3
 6MFmzaKKHg+7G5k2+ThuuhRbB8mApsI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-N_Kb1NQNP3S-xSsfKNFFEw-1; Fri,
 17 Jan 2025 06:58:15 -0500
X-MC-Unique: N_Kb1NQNP3S-xSsfKNFFEw-1
X-Mimecast-MFC-AGG-ID: N_Kb1NQNP3S-xSsfKNFFEw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 329C719560A2; Fri, 17 Jan 2025 11:58:13 +0000 (UTC)
Received: from gezellig (unknown [10.39.194.27])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F239C1955F22; Fri, 17 Jan 2025 11:58:08 +0000 (UTC)
Date: Fri, 17 Jan 2025 12:58:04 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 devel@lists.libvirt.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 2/3] hw/i386/pc_piix: Remove pc-i440fx-2.4 up to
 pc-i440fx-2.12
Message-ID: <Z4pFzJzNfBxXkjS1@gezellig>
References: <20250117102738.59714-1-thuth@redhat.com>
 <20250117102738.59714-3-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117102738.59714-3-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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

On Fri, Jan 17, 2025 at 11:27:37AM +0100, Thomas Huth wrote:
> These machines have explicitly been marked as deprecated in
> QEMU 9.1, so it should be fine to remove these antique versioned
> machine types two releases later in 10.0.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/about/deprecated.rst       |  7 ---
>  docs/about/removed-features.rst |  4 +-
>  docs/interop/firmware.json      |  2 +-
>  hw/i386/pc_piix.c               | 95 ---------------------------------
>  qemu-options.hx                 | 10 ++--
>  5 files changed, 8 insertions(+), 110 deletions(-)

Looks good to me.  Nice that it has the side-effect of speeding up a
bit of the upstream CI, as it drops unncessary tests.  I also saw your
note in the cover letter that the corresponding Q35 machine types will
be removed in QEMU 10.1.  Thanks!

FWIW:

    Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 4a3c302962..7b42d6eecc 100644

[...]

>  PPC 405 ``ref405ep`` machine (since 9.1)
>  ''''''''''''''''''''''''''''''''''''''''
>  
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index c6616ce05e..936846ed7b 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -1006,8 +1006,8 @@ mips ``fulong2e`` machine alias (removed in 6.0)
>  
>  This machine has been renamed ``fuloong2e``.
>  
> -``pc-0.10`` up to ``pc-i440fx-2.3`` (removed in 4.0 up to 9.0)
> -''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +``pc-0.10`` up to ``pc-i440fx-2.12`` (removed in 4.0 up to 10.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>  
>  These machine types were very old and likely could not be used for live
>  migration from old QEMU versions anymore. Use a newer machine type instead.
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> index 57f55f6c54..f1e74318ff 100644
> --- a/docs/interop/firmware.json
> +++ b/docs/interop/firmware.json
> @@ -97,7 +97,7 @@
>  #            machine types, not aliases. Glob patterns are understood,
>  #            which is especially useful for versioned machine types.
>  #            (For example, the glob pattern "pc-i440fx-*" matches
> -#            "pc-i440fx-2.12".) On the QEMU command line, "-machine
> +#            "pc-i440fx-9.1".) On the QEMU command line, "-machine
>  #            type=..." specifies the requested machine type (but that
>  #            option does not accept glob patterns).
>  #
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 04d2957adc..b821c32b38 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -698,101 +698,6 @@ static void pc_i440fx_machine_3_0_options(MachineClass *m)
>  
>  DEFINE_I440FX_MACHINE(3, 0);
>  
> -static void pc_i440fx_machine_2_12_options(MachineClass *m)
> -{
> -    pc_i440fx_machine_3_0_options(m);
> -    compat_props_add(m->compat_props, hw_compat_2_12, hw_compat_2_12_len);
> -    compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len);
> -}

[...]


-- 
/kashyap


