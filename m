Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85F3ECD99F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5nJ-0005dL-Ay; Thu, 05 Feb 2026 15:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vo5nH-0005cx-Jw
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:17:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vo5nG-0006e3-55
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770322657;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=koFvp7KekaLxedjMTVIS/k+usVOAycOi6RO3s5XveNA=;
 b=JJ9gZ1uWyocmeV1dMGicPUT6lAi4mb5hPd2a/Szhw1f4ShbReW+y6D5Bmrp2nlljCZP6b5
 fVeWTGXwL0UDd3wo5hi2eUzfOR7IMzlOLXKsSH9k+W41Z7dldMGkwKKzgRdo78OWFI23rU
 Z9OU2FwYtrw468JRJLATMpwB+tYXVuQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-91dzQTZ7PN6NBVdEPuAOng-1; Thu,
 05 Feb 2026 15:17:31 -0500
X-MC-Unique: 91dzQTZ7PN6NBVdEPuAOng-1
X-Mimecast-MFC-AGG-ID: 91dzQTZ7PN6NBVdEPuAOng_1770322649
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 505C51955DC1; Thu,  5 Feb 2026 20:17:29 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F15919373D8; Thu,  5 Feb 2026 20:17:24 +0000 (UTC)
Date: Thu, 5 Feb 2026 20:17:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: Re: [PATCH 06/29] system/vl: Introduce -machine-path command line
 option
Message-ID: <aYT6xbPUa4O5mnVT@redhat.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
 <20260205195824.2610192-7-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260205195824.2610192-7-ruslichenko.r@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Thu, Feb 05, 2026 at 08:58:01PM +0100, Ruslan Ruslichenko wrote:
> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> 
> This patch adds a new command line option `-machine-path` to specify
> a directory path for shared machine resources.

We have a fairly general principal that we don't want to introduce
new top level command line arguments to QEMU anymore.

Could this perhaps be modelled as a machine  type property, settable
via -machine instead ?

> 
> This path is intended to serve as a base directory for devices or
> subsystems that need to automatically create coordination files,
> such as Unix domain sockets, particularly in multi-process simulation
> environments.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
> Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> ---
>  include/system/system.h |  2 ++
>  qemu-options.hx         | 10 ++++++++++
>  system/vl.c             |  4 ++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/include/system/system.h b/include/system/system.h
> index 03a2d0e900..0cd012004d 100644
> --- a/include/system/system.h
> +++ b/include/system/system.h
> @@ -57,6 +57,8 @@ bool is_mlock_on_fault(MlockState);
>  
>  extern MlockState mlock_state;
>  
> +extern const char *machine_path;
> +
>  #define MAX_OPTION_ROMS 16
>  typedef struct QEMUOptionRom {
>      const char *name;
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 6dd3e04e38..b7dd2a64f0 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -765,6 +765,16 @@ SRST
>      Preallocate memory when using -mem-path.
>  ERST
>  
> +DEF("machine-path", HAS_ARG, QEMU_OPTION_machine_path,
> +    "-machine-path DIR A directory in which to create machine nodes\n",
> +    QEMU_ARCH_ALL)
> +SRST
> +``-machine-path path``
> +    Selects the machine path.
> +    Multi-arch machine nodes will be created in <path>.
> +    This option also sets -mem-shared-path to the given path.
> +ERST
> +
>  DEF("k", HAS_ARG, QEMU_OPTION_k,
>      "-k language     use keyboard layout (for example 'fr' for French)\n",
>      QEMU_ARCH_ALL)
> diff --git a/system/vl.c b/system/vl.c
> index c890da586c..4750b1cf69 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -182,6 +182,7 @@ static QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
>  static BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
>  static bool nographic = false;
>  static int mem_prealloc; /* force preallocation of physical target memory */
> +const char *machine_path;
>  static const char *vga_model = NULL;
>  static DisplayOptions dpy;
>  static int num_serial_hds;
> @@ -3128,6 +3129,9 @@ void qemu_init(int argc, char **argv)
>              case QEMU_OPTION_mem_prealloc:
>                  mem_prealloc = 1;
>                  break;
> +            case QEMU_OPTION_machine_path:
> +                machine_path = optarg;
> +                break;
>              case QEMU_OPTION_d:
>                  log_mask = optarg;
>                  break;
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


