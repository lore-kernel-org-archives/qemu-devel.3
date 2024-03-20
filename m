Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17601CD11DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 10:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmtEU-000725-75; Wed, 20 Mar 2024 06:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmtES-00071T-07
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmtEL-0003zc-1d
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710930692;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jN8WXvFjEPo7LmwV9YPae69LYdDC7e6gr8Uf2LP2p0Q=;
 b=eo5+nNoS3fM2RiTvT/L/aV5QSiNXvcjOCsmJztbImIgjnw2hveH8G3DDWJCULDLKWJrvGc
 PXV2OsOeJ9WHlp4hC/s5YVVSVu8LLW43HkXvgF4UfpUx5raZ8LQbCqA2mwZm7C6S8/dVFT
 +2gnRT6Le6dtq+izSIFvvMcLB8CUv/8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-MJee4OhaMsi7UCPNRhkm7Q-1; Wed, 20 Mar 2024 06:31:30 -0400
X-MC-Unique: MJee4OhaMsi7UCPNRhkm7Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9DCE8007A6;
 Wed, 20 Mar 2024 10:31:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 343F02166B34;
 Wed, 20 Mar 2024 10:31:28 +0000 (UTC)
Date: Wed, 20 Mar 2024 10:31:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org,
 hao.xiang@bytedance.com, bryan.zhang@bytedance.com, nanhai.zou@intel.com
Subject: Re: [PATCH v5 3/7] configure: add --enable-qpl build option
Message-ID: <Zfq6-s9xRse06R6k@redhat.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-4-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319164527.1873891-4-yuan1.liu@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 20, 2024 at 12:45:23AM +0800, Yuan Liu wrote:
> add --enable-qpl and --disable-qpl options to enable and disable
> the QPL compression method for multifd migration.
> 
> the Query Processing Library (QPL) is an open-source library
> that supports data compression and decompression features.
> 
> The QPL compression is based on the deflate compression algorithm
> and use Intel In-Memory Analytics Accelerator(IAA) hardware for
> compression and decompression acceleration.
> 
> Please refer to the following for more information about QPL
> https://intel.github.io/qpl/documentation/introduction_docs/introduction.html
> 
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> ---
>  meson.build                   | 16 ++++++++++++++++
>  meson_options.txt             |  2 ++
>  scripts/meson-buildoptions.sh |  3 +++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index b375248a76..bee7dcd53b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1200,6 +1200,20 @@ if not get_option('zstd').auto() or have_block
>                      required: get_option('zstd'),
>                      method: 'pkg-config')
>  endif
> +qpl = not_found
> +if not get_option('qpl').auto()
> +  libqpl = cc.find_library('qpl', required: false)
> +  if not libqpl.found()
> +    error('libqpl not found, please install it from ' +
> +    'https://intel.github.io/qpl/documentation/get_started_docs/installation.html')
> +  endif
> +  libaccel = dependency('libaccel-config', version: '>=4.0.0',
> +                        required: true,
> +                        method: 'pkg-config')
> +  qpl = declare_dependency(dependencies: [libqpl, libaccel,
> +        cc.find_library('dl', required: get_option('qpl'))],
> +        link_args: ['-lstdc++'])
> +endif

Are either of these libraries present in any mainstream Linux
distro ? If not, then this feature will not get any CI build
coverage from QEMU.

Needing to manually add '-lstdc++' & '-ldl' is presumably a
requirement from 'qpl'. As a future enhancement it would be
much better if 'qpl' provided a pkg-config file, so this
list of dependencies didn't have to be hardcoded by apps
using qpl


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


