Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196BCC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 12:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sewWy-0008UT-BH; Fri, 16 Aug 2024 08:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sewWw-0008Ta-R3
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 08:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sewWu-0004DX-LD
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 08:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723813085;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e/tDeubGZmIKECYGc56eU8Qwc8FDl7jIS7S9ewaVBAY=;
 b=JS0rD0CVoNhGFZ6DTtjAS0bgLkAcVjdk0BybpyXpYfWQwcANpCQmbIF0qVCn84Oa2j5Lv0
 auJS95qMEwXm+qmu58x/M02H0HAkUNGLYN58amaoVF32aGBL+UvgycY3pRh8WlS0f9U847
 lLKrKT/G4IlHbj5N0/6ob5xYEaFVIQU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-jbhkqbdrOaSizY0YF1puCw-1; Fri,
 16 Aug 2024 08:58:02 -0400
X-MC-Unique: jbhkqbdrOaSizY0YF1puCw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D91E1955D45; Fri, 16 Aug 2024 12:58:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.143])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 166201956054; Fri, 16 Aug 2024 12:57:55 +0000 (UTC)
Date: Fri, 16 Aug 2024 13:57:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de,
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org
Subject: Re: [PATCH v3 4/5] machine/nitro-enclave: Add built-in Nitro Secure
 Module device
Message-ID: <Zr9M0BqDEdF5D5xJ@redhat.com>
References: <20240810164502.19693-1-dorjoychy111@gmail.com>
 <20240810164502.19693-5-dorjoychy111@gmail.com>
 <ZroXDY3YulpB4SCt@redhat.com>
 <CAFfO_h48q9Lkt1BmtoPxtZ1a8HJsoQCTTdBMTFkB568+v6B0Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFfO_h48q9Lkt1BmtoPxtZ1a8HJsoQCTTdBMTFkB568+v6B0Sw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 16, 2024 at 06:50:34PM +0600, Dorjoy Chowdhury wrote:
> Hi Daniel,
> 
> On Mon, Aug 12, 2024 at 8:07 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Sat, Aug 10, 2024 at 10:45:01PM +0600, Dorjoy Chowdhury wrote:
> > > AWS Nitro Enclaves have built-in Nitro Secure Module (NSM) device which
> > > is used for stripped down TPM functionality like attestation. This commit
> > > adds the built-in NSM device in the nitro-enclave machine type.
> > >
> > > In Nitro Enclaves, all the PCRs start in a known zero state and the first
> > > 16 PCRs are locked from boot and reserved. The PCR0, PCR1, PCR2 and PCR8
> > > contain the SHA384 hashes related to the EIF file used to boot the
> > > VM for validation.
> > >
> > > A new optional nitro-enclave machine option 'id' has been added which will
> > > be the enclave identifier reflected in the module-id of the NSM device.
> > > Otherwise, the device will have a default id set.
> > >
> > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > ---
> > >  hw/core/eif.c                   | 205 +++++++++++++++++++++++++++++++-
> > >  hw/core/eif.h                   |   5 +-
> > >  hw/core/meson.build             |   4 +-
> > >  hw/i386/Kconfig                 |   1 +
> > >  hw/i386/nitro_enclave.c         |  85 ++++++++++++-
> > >  include/hw/i386/nitro_enclave.h |  19 +++
> > >  6 files changed, 310 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/hw/core/eif.c b/hw/core/eif.c
> > > index 5558879a96..d2c65668ef 100644
> > > --- a/hw/core/eif.c
> > > +++ b/hw/core/eif.c
> > > @@ -12,6 +12,9 @@
> > >  #include "qemu/bswap.h"
> > >  #include "qapi/error.h"
> > >  #include <zlib.h> /* for crc32 */
> > > +#include <cbor.h>
> > > +#include <gnutls/gnutls.h>
> > > +#include <gnutls/x509.h>
> > >
> > >  #include "hw/core/eif.h"
> > >
> >
> > > @@ -269,6 +284,125 @@ static bool read_eif_ramdisk(FILE *eif, FILE *initrd, uint64_t size,
> > >      return false;
> > >  }
> > >
> > > +static bool get_fingerprint_sha384_from_cert(uint8_t *cert, size_t size,
> > > +                                             uint8_t *sha384, Error **errp)
> > > +{
> > > +    gnutls_x509_crt_t crt;
> > > +    size_t hash_size = 48;
> > > +    gnutls_datum_t datum = {.data = cert, .size = size};
> > > +
> > > +    gnutls_global_init();
> > > +    gnutls_x509_crt_init(&crt);
> > > +
> > > +    if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM) != 0) {
> > > +        error_setg(errp, "Failed to import certificate");
> > > +        goto cleanup;
> > > +    }
> > > +
> > > +    if (gnutls_x509_crt_get_fingerprint(crt, GNUTLS_DIG_SHA384, sha384,
> > > +                                        &hash_size) != 0) {
> > > +        error_setg(errp, "Failed to compute SHA384 fingerprint");
> > > +        goto cleanup;
> > > +    }
> > > +
> > > +    return true;
> > > +
> > > + cleanup:
> > > +    gnutls_x509_crt_deinit(crt);
> > > +    gnutls_global_deinit();
> > > +    return false;
> > > +}
> >
> > I'd suggest this go into  qcrypto/x509-utils.c & include/qcrypto/x509-utils.h,
> > as:
> >
> >     int qcrypto_get_x509_cert_fingerprint(uint8_t *cert,
> >                                           size_t size,
> >                                           QCryptoHashAlgorith hash,
> >                                           Error **errp);
> >
> > there's no need to be calling gnutls_global_init() / deinit() either.
> >
> >
> > > @@ -299,7 +433,9 @@ static long get_file_size(FILE *f, Error **errp)
> > >   */
> > >  bool read_eif_file(const char *eif_path, const char *machine_initrd,
> > >                     char **kernel_path, char **initrd_path, char **cmdline,
> > > -                   Error **errp)
> > > +                   uint8_t *image_sha384, uint8_t *bootstrap_sha384,
> > > +                   uint8_t *app_sha384, uint8_t *fingerprint_sha384,
> > > +                   bool *signature_found, Error **errp)
> > >  {
> > >      FILE *f = NULL;
> > >      FILE *machine_initrd_f = NULL;
> > > @@ -308,9 +444,33 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
> > >      uint32_t crc = 0;
> > >      EifHeader eif_header;
> > >      bool seen_sections[EIF_SECTION_MAX] = {false};
> > > -
> > > +    /* kernel + ramdisks + cmdline sha384 hash */
> > > +    GChecksum *image_hasher = NULL;
> > > +    /* kernel + boot ramdisk + cmdline sha384 hash */
> > > +    GChecksum *bootstrap_hasher = NULL;
> > > +    /* application ramdisk(s) hash */
> > > +    GChecksum *app_hasher = NULL;
> > > +    size_t digest_len;
> > > +
> > > +    *signature_found = false;
> > >      *kernel_path = *initrd_path = *cmdline = NULL;
> > >
> > > +    image_hasher = g_checksum_new(G_CHECKSUM_SHA384);
> > > +    if (image_hasher == NULL) {
> > > +        error_setg(errp, "Failed to initialize sha384 hash for image");
> > > +        goto cleanup;
> > > +    }
> > > +    bootstrap_hasher = g_checksum_new(G_CHECKSUM_SHA384);
> > > +    if (bootstrap_hasher == NULL) {
> > > +        error_setg(errp, "Failed to initialize sha384 hash for bootstrap");
> > > +        goto cleanup;
> > > +    }
> > > +    app_hasher = g_checksum_new(G_CHECKSUM_SHA384);
> > > +    if (app_hasher == NULL) {
> > > +        error_setg(errp, "Failed to initialize sha384 hash for app");
> > > +        goto cleanup;
> > > +    }
> >
> > Don't use GChecksum APIs please, use the qcrypto hash APIs instead,
> > as we need all code to be using the designated QEMU crypto backend.
> >
> 
> Thanks for the reviews. I was looking into replacing the GChecksum
> uses with qcrypto apis and was able to do it in the extendPCR function
> but I need some help with how I can do this in the eif.c file. For
> example, the "image_hash" needs to be a SHA384 hash of the kernel,
> cmdline, ramdisks sections' data as they appear in the order that is
> in the EIF file. Using GChecksum it was easy as I was able to just
> pass the hashers to the "read_eif_kernel", "read_eif_ramdisk" etc
> functions and call "update" on them. But the qcrypto apis are
> stateless i.e., I would need to pass all the buffers in a single api
> call so it wouldn't work right now out of the box. Do you have any
> suggestions how I should modify/create qcrypto apis so that I can
> easily do this (considering that I would need to implement for
> different qcrypto backends)? Thanks!

Looking at the read_eif_* methods:

@ -213,6 +218,8 @@ static bool read_eif_kernel(FILE *f, uint64_t size, char **kernel_path,
     }

     *crc = crc32(*crc, kernel, size);
+    g_checksum_update(image_hasher, kernel, size);
+    g_checksum_update(bootstrap_hasher, kernel, size);
     g_free(kernel);
     fclose(tmp_file);

@@ -230,6 +237,8 @@ static bool read_eif_kernel(FILE *f, uint64_t size, char **kernel_path,
 }

 static bool read_eif_cmdline(FILE *f, uint64_t size, char *cmdline,
+                             GChecksum *image_hasher,
+                             GChecksum *bootstrap_hasher,
                              uint32_t *crc, Error **errp)
 {
     size_t got = fread(cmdline, 1, size, f);
@@ -239,10 +248,14 @@ static bool read_eif_cmdline(FILE *f, uint64_t size, char *cmdline,
     }

     *crc = crc32(*crc, (uint8_t *)cmdline, size);
+    g_checksum_update(image_hasher, (uint8_t *)cmdline, size);
+    g_checksum_update(bootstrap_hasher, (uint8_t *)cmdline, size);
     return true;
 }

 static bool read_eif_ramdisk(FILE *eif, FILE *initrd, uint64_t size,
+                             GChecksum *image_hasher,
+                             GChecksum *bootstrap_or_app_hasher,
                              uint32_t *crc, Error **errp)
 {
     size_t got;
@@ -261,6 +274,8 @@ static bool read_eif_ramdisk(FILE *eif, FILE *initrd, uint64_t size,
     }

     *crc = crc32(*crc, ramdisk, size);
+    g_checksum_update(image_hasher, ramdisk, size);
+    g_checksum_update(bootstrap_or_app_hasher, ramdisk, size);
     g_free(ramdisk);
     return true;


For the kernel + ramdisk, these methods are freeing the buffer.
For the cmdline, the pointer is held by the caller.

I'd suggest that read_eif_kernel+ramddisk are changed to return
the data pointer instead of free'ing it.

The caller can then stash the kernl+cmdline+ramdisk into an iovec
and calc the hash in a single stateless operation.



If you really don't want to do that, then you'll have to wait for
this series to be finalized & merged next dev cycle:

  https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg01173.html

It is getting close to ready, so might not be too long, but I can't
guarantee a timeframe.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


