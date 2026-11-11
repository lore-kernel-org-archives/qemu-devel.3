Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937B4606A32E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dfGLHpgS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR7hW-0001Rw-Bm; Wed, 11 Nov 2026 07:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xR7hV-0001Oo-5Q
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:45:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xR7hS-0000n4-V6
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794401113;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eCzP4uZCvMCgsSiM9GqgqtzAhNl4j+dxe/yaViCyuD0=;
 b=dfGLHpgSsAiaXZt2Wtu++vi/3xIWfQ0ohl8Ru3UltNlPM28UafFMoZKMW668lti7xhSb1L
 jiGQ6uJt0q1TEHUGLXJNdjVQHUxjGJD7+BUM2XnLvP1eqnXNLaul7OMeRTZBnTQR7tbRkj
 8JoCG1maKW8gOb0rjBO+peCN5Dcnsxg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-ok_pTUAoM1KOywlcZ0qAiQ-1; Wed,
 11 Nov 2026 07:45:10 -0500
X-MC-Unique: ok_pTUAoM1KOywlcZ0qAiQ-1
X-Mimecast-MFC-AGG-ID: ok_pTUAoM1KOywlcZ0qAiQ_1794401109
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D206A1802573; Wed, 11 Nov 2026 12:45:08 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 767941800545; Wed, 11 Nov 2026 12:45:07 +0000 (UTC)
Date: Wed, 11 Nov 2026 12:45:04 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, david@kernel.org, imammedo@redhat.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH 1/7] backends/hostmem: Drop redundant validation of
 property "size"
Message-ID: <avRjUJ9-d0_RxIvk@redhat.com>
References: <20261111122342.634370-1-armbru@redhat.com>
 <20261111122342.634370-2-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261111122342.634370-2-armbru@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 01:23:36PM +0100, Markus Armbruster wrote:
> Property "size" is mandatory, and its setter
> host_memory_backend_set_size() rejects value zero.  Delete the
> redundant checks for zero in the .alloc() callbacks.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  backends/hostmem-epc.c   | 5 -----
>  backends/hostmem-file.c  | 4 ----
>  backends/hostmem-memfd.c | 5 -----
>  backends/hostmem-ram.c   | 5 -----
>  backends/hostmem-shm.c   | 5 -----
>  5 files changed, 24 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

...it is a shame this was/is dead code, since the actual error message
from host_memory_backend_set_size() is (IMHO) worse than that from the
unreachable code you're deleting

  $ ./build/qemu-system-x86_64 -object memory-backend-ram,size=0,id=foo
  qemu-system-x86_64: property 'size' of memory-backend-ram doesn't take value '0'

as a separate patch I might suggest

    diff --git a/backends/hostmem.c b/backends/hostmem.c
    index 173d042be35..f523dce6eb0 100644
    --- a/backends/hostmem.c
    +++ b/backends/hostmem.c
    @@ -77,8 +77,8 @@ host_memory_backend_set_size(Object *obj, Visitor *v, const char *name,
         }
         if (!value) {
             error_setg(errp,
    -                   "property '%s' of %s doesn't take value '%" PRIu64 "'",
    -                   name, object_get_typename(obj), value);
    +                   "cannot create '%s' with a size of 0",
    +                   object_get_typename(obj));
             return;
         }
         backend->size = value;

so that we get the nicer message:

    $ ./build/qemu-system-x86_64 -object memory-backend-ram,size=0,id=foo
    qemu-system-x86_64: cannot create 'memory-backend-ram' with a size of 0


> 
> diff --git a/backends/hostmem-epc.c b/backends/hostmem-epc.c
> index ab20b182331..e1c784249ff 100644
> --- a/backends/hostmem-epc.c
> +++ b/backends/hostmem-epc.c
> @@ -24,11 +24,6 @@ sgx_epc_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>      uint32_t ram_flags;
>      int fd;
>  
> -    if (!backend->size) {
> -        error_setg(errp, "can't create backend with size 0");
> -        return false;
> -    }
> -
>      fd = qemu_open("/dev/sgx_vepc", O_RDWR, errp);
>      if (fd < 0) {
>          return false;
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index 6ad9cad0320..08d0382d76f 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -48,10 +48,6 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>      g_autofree gchar *name = NULL;
>      uint32_t ram_flags;
>  
> -    if (!backend->size) {
> -        error_setg(errp, "can't create backend with size 0");
> -        return false;
> -    }
>      if (!fb->mem_path) {
>          error_setg(errp, "mem-path property not set");
>          return false;
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 46489212a23..11d456e3ebd 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -49,11 +49,6 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>      int fd = cpr_find_fd(name, 0);
>      uint32_t ram_flags;
>  
> -    if (!backend->size) {
> -        error_setg(errp, "can't create backend with size 0");
> -        return false;
> -    }
> -
>      if (fd >= 0) {
>          goto have_fd;
>      }
> diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
> index 6a507fad77c..0ae7b4ae759 100644
> --- a/backends/hostmem-ram.c
> +++ b/backends/hostmem-ram.c
> @@ -22,11 +22,6 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>      g_autofree char *name = NULL;
>      uint32_t ram_flags;
>  
> -    if (!backend->size) {
> -        error_setg(errp, "can't create backend with size 0");
> -        return false;
> -    }
> -
>      name = host_memory_backend_get_name(backend);
>      ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>      ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
> index adf60957c3c..0a01c760551 100644
> --- a/backends/hostmem-shm.c
> +++ b/backends/hostmem-shm.c
> @@ -30,11 +30,6 @@ shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>      uint32_t ram_flags;
>      int fd = cpr_find_fd(backend_name, 0);
>  
> -    if (!backend->size) {
> -        error_setg(errp, "can't create shm backend with size 0");
> -        return false;
> -    }
> -
>      if (!backend->share) {
>          error_setg(errp, "can't create shm backend with `share=off`");
>          return false;
> -- 
> 2.55.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


