Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93B0C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 12:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2VKB-0006TD-GT; Thu, 02 May 2024 08:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2VK7-0006FF-OZ
 for qemu-devel@nongnu.org; Thu, 02 May 2024 08:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2VJy-00015K-Ds
 for qemu-devel@nongnu.org; Thu, 02 May 2024 08:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714652027;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hMfa/XrGYhegbpAwndAKxgfT1VHN5XMhQpu8iMYZ4Ng=;
 b=BADHBOMcBoO4KjZfQM/HEL19fx44Svz5H/opXQ1RAqqcW1kwaPe8whKj+O01g61TFAxg8R
 Mtpci/ZKDrzP3492bf38KaklteUpQleZQBqM/rxtXq38ROzrFddLV8t6DWWKN2msw+/sKh
 xe2CxuclXPMKOC06LxUrlfITPHDWCgQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-xzCSHd0QOYiKA7j74SUk4w-1; Thu,
 02 May 2024 08:13:45 -0400
X-MC-Unique: xzCSHd0QOYiKA7j74SUk4w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3924C1C4C3E1;
 Thu,  2 May 2024 12:13:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B43E1C0654B;
 Thu,  2 May 2024 12:13:41 +0000 (UTC)
Date: Thu, 2 May 2024 13:13:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v4 20/22] hw/i386/pc: Remove deprecated pc-i440fx-2.3
 machine
Message-ID: <ZjODdLACORiQ0Kfm@redhat.com>
References: <20240416185939.37984-1-philmd@linaro.org>
 <20240416185939.37984-21-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240416185939.37984-21-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 16, 2024 at 08:59:36PM +0200, Philippe Mathieu-Daudé wrote:
> The pc-i440fx-2.3 machine was deprecated for the 8.2
> release (see commit c7437f0ddb "docs/about: Mark the
> old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
> time to remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  docs/about/deprecated.rst       |  4 ++--
>  docs/about/removed-features.rst |  2 +-
>  hw/i386/pc.c                    | 25 -------------------------
>  hw/i386/pc_piix.c               | 19 -------------------
>  4 files changed, 3 insertions(+), 47 deletions(-)


> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 30bcd86ee6..370d130a6d 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -421,14 +421,6 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
>   * hw_compat_*, pc_compat_*, or * pc_*_machine_options().
>   */

The comment that is just out of sight in the diff is now obsolete
and should be removed too.

>  
> -static void pc_compat_2_3_fn(MachineState *machine)
> -{
> -    X86MachineState *x86ms = X86_MACHINE(machine);
> -    if (kvm_enabled()) {
> -        x86ms->smm = ON_OFF_AUTO_OFF;
> -    }
> -}
> -
>  #ifdef CONFIG_ISAPC
>  static void pc_init_isa(MachineState *machine)
>  {
> @@ -812,17 +804,6 @@ static void pc_i440fx_2_4_machine_options(MachineClass *m)
>  DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4", NULL,
>                        pc_i440fx_2_4_machine_options)
>  
> -static void pc_i440fx_2_3_machine_options(MachineClass *m)
> -{
> -    pc_i440fx_2_4_machine_options(m);
> -    m->hw_version = "2.3.0";
> -    compat_props_add(m->compat_props, hw_compat_2_3, hw_compat_2_3_len);
> -    compat_props_add(m->compat_props, pc_compat_2_3, pc_compat_2_3_len);
> -}
> -
> -DEFINE_I440FX_MACHINE(v2_3, "pc-i440fx-2.3", pc_compat_2_3_fn,
> -                      pc_i440fx_2_3_machine_options);

This is the last DEFINE_I440FX_MACHINE call that provides a
non-NULL 3rd parameter.

IOW, there could be a further patch removing the 3rd 'compatfn'
parameter now it is finally obsolete.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


