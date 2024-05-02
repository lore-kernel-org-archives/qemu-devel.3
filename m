Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A99AC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 12:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2VFG-0001U6-Dp; Thu, 02 May 2024 08:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2VF8-0001OT-99
 for qemu-devel@nongnu.org; Thu, 02 May 2024 08:08:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2VF5-0008Tn-EV
 for qemu-devel@nongnu.org; Thu, 02 May 2024 08:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714651729;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=utvNDTrYwaJdLBcEMeei/KBGGo5NEwIoFRoals6gm0c=;
 b=a9Y/DgvcWYtiS4Zn4S7Bn7A1QQSsmUjSuINl2seNwgr7AS+tJdWhHd9YSSM/PAG6XsEldf
 F9A8uHVdVcyQF029rW/o5R+YGzb2GhyOXNAJ72k694egorgcBgTaN7XyXKICbG/b4TmUaH
 0+JA9j3+rIn4owOEqJGVJ4pHCnLjYMg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-ZO3HT5-aOQOKzyqnwoWgNA-1; Thu, 02 May 2024 08:08:46 -0400
X-MC-Unique: ZO3HT5-aOQOKzyqnwoWgNA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33064101157A;
 Thu,  2 May 2024 12:08:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FBBC400EB2;
 Thu,  2 May 2024 12:08:43 +0000 (UTC)
Date: Thu, 2 May 2024 13:08:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 devel@lists.libvirt.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v4 01/22] hw/i386/pc: Deprecate 2.4 to 2.12 pc-i440fx
 machines
Message-ID: <ZjOCSUdwB9GZV7d9@redhat.com>
References: <20240416185939.37984-1-philmd@linaro.org>
 <20240416185939.37984-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240416185939.37984-2-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

On Tue, Apr 16, 2024 at 08:59:17PM +0200, Philippe Mathieu-Daudé wrote:
> Similarly to the commit c7437f0ddb "docs/about: Mark the
> old pc-i440fx-2.0 - 2.3 machine types as deprecated",
> deprecate the 2.4 to 2.12 machines.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  docs/about/deprecated.rst | 4 ++--
>  hw/i386/pc_piix.c         | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

FWIW, this patch is potentially obsolete if we go with enforcing a
general deprecation policy for all versioned machines:

  https://lists.nongnu.org/archive/html/qemu-devel/2024-05/msg00084.html

If this series merges first though, that's fine. My proposal can
easily be rebased on top of this.

> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 7b548519b5..47234da329 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -219,8 +219,8 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
>  better reflects the way this property affects all random data within
>  the device tree blob, not just the ``kaslr-seed`` node.
>  
> -``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2)
> -'''''''''''''''''''''''''''''''''''''''''''''''''''''
> +``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>  
>  These old machine types are quite neglected nowadays and thus might have
>  various pitfalls with regards to live migration. Use a newer machine type
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 18ba076609..817d99c0ce 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -727,6 +727,7 @@ DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
>  static void pc_i440fx_2_12_machine_options(MachineClass *m)
>  {
>      pc_i440fx_3_0_machine_options(m);
> +    m->deprecation_reason = "old and unattended - use a newer version instead";
>      compat_props_add(m->compat_props, hw_compat_2_12, hw_compat_2_12_len);
>      compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len);
>  }
> @@ -832,7 +833,6 @@ static void pc_i440fx_2_3_machine_options(MachineClass *m)
>  {
>      pc_i440fx_2_4_machine_options(m);
>      m->hw_version = "2.3.0";
> -    m->deprecation_reason = "old and unattended - use a newer version instead";
>      compat_props_add(m->compat_props, hw_compat_2_3, hw_compat_2_3_len);
>      compat_props_add(m->compat_props, pc_compat_2_3, pc_compat_2_3_len);
>  }
> -- 
> 2.41.0
> _______________________________________________
> Devel mailing list -- devel@lists.libvirt.org
> To unsubscribe send an email to devel-leave@lists.libvirt.org

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


