Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579E5CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 10:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v64fJ-000456-RE; Tue, 07 Oct 2025 06:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v64fH-00044n-TF
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 06:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v64fF-0005YB-Ty
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 06:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759831883;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qDOm1Ne9Cb34BEdu0/H4cN+Uyq27Tdq1eXXMMoqBH8A=;
 b=RzWuBfgpAbdcmpMkQ1ULPZLTlfP6Pye8wtZSh5GVTws9RP35oZtrSAZy3xTTy3jQHU25NZ
 WJP8eUs7ExCsqSRueAVNakjCcrERdroGuUaMJJ7+kTVKpuHpJCF5WPhBfJv9/H9y9zDKim
 e2itsH6I5qR+eHo61grWQPjEujHNlZo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-LN3DNFFLPgWSPRo-sNXKhw-1; Tue,
 07 Oct 2025 06:11:20 -0400
X-MC-Unique: LN3DNFFLPgWSPRo-sNXKhw-1
X-Mimecast-MFC-AGG-ID: LN3DNFFLPgWSPRo-sNXKhw_1759831878
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F97E180045C; Tue,  7 Oct 2025 10:11:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.83])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D98AD1956056; Tue,  7 Oct 2025 10:10:52 +0000 (UTC)
Date: Tue, 7 Oct 2025 11:10:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
Subject: Re: [PATCH v6 11/28] crypto/x509-utils: Add helper functions for
 DIAG 508 subcode 1
Message-ID: <aOTnIy6vzoMNp23x@redhat.com>
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-12-zycai@linux.ibm.com>
 <896998e3-9e11-4aaf-9900-1ab1773fd18b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <896998e3-9e11-4aaf-9900-1ab1773fd18b@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 07, 2025 at 11:58:03AM +0200, Thomas Huth wrote:
> On 18/09/2025 01.21, Zhuoying Cai wrote:
> > Introduce helper functions to support signature verification required by
> > DIAG 508 subcode 1:
> > 
> > qcrypto_pkcs7_convert_sig_pem() – converts a signature from DER to PEM format
> > qcrypto_x509_verify_sig() – verifies the provided data against the given signature
> > 
> > These functions enable basic signature verification support.
> > 
> > Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> > ---
> >   crypto/x509-utils.c         | 109 ++++++++++++++++++++++++++++++++++++
> >   include/crypto/x509-utils.h |  39 +++++++++++++
> >   2 files changed, 148 insertions(+)
> > 
> > diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> > index 763eccb190..8f3c895d7c 100644
> > --- a/crypto/x509-utils.c
> > +++ b/crypto/x509-utils.c


> > +int qcrypto_x509_verify_sig(uint8_t *cert, size_t cert_size,
> > +                            uint8_t *comp, size_t comp_size,
> > +                            uint8_t *sig, size_t sig_size, Error **errp)
> > +{
> > +    int rc;
> > +    int ret = -1;
> > +    gnutls_x509_crt_t crt = NULL;
> > +    gnutls_pkcs7_t signature = NULL;
> > +    gnutls_datum_t cert_datum = {.data = cert, .size = cert_size};
> > +    gnutls_datum_t data_datum = {.data = comp, .size = comp_size};
> > +    gnutls_datum_t sig_datum = {.data = sig, .size = sig_size};
> > +
> > +    rc = gnutls_x509_crt_init(&crt);
> > +    if (rc < 0) {
> > +        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
> > +        goto cleanup;
> 
> So if you go to cleanup here, signature is still NULL ...
> 
> > +    }
> > +
> > +    rc = gnutls_x509_crt_import(crt, &cert_datum, GNUTLS_X509_FMT_PEM);
> > +    if (rc != 0) {
> > +        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
> > +        goto cleanup;
> > +    }
> > +
> > +    rc = gnutls_pkcs7_init(&signature);
> > +    if (rc < 0) {
> > +        error_setg(errp, "Failed to initalize pkcs7 data: %s", gnutls_strerror(rc));
> > +        goto cleanup;
> > +     }
> > +
> > +    rc = gnutls_pkcs7_import(signature, &sig_datum , GNUTLS_X509_FMT_PEM);
> > +    if (rc != 0) {
> > +        error_setg(errp, "Failed to import signature: %s", gnutls_strerror(rc));
> > +        goto cleanup;
> > +    }
> > +
> > +    rc = gnutls_pkcs7_verify_direct(signature, crt, 0, &data_datum, 0);
> > +    if (rc != 0) {
> > +        error_setg(errp, "Failed to verify signature: %s", gnutls_strerror(rc));
> > +        goto cleanup;
> > +    }
> > +
> > +    ret = 0;
> > +
> > +cleanup:
> > +    gnutls_x509_crt_deinit(crt);
> > +    gnutls_pkcs7_deinit(signature);
> 
> ... did you check whether gnutls_pkcs7_deinit() is able to deal with NULL
> pointers? The man-page does not mention it ... so just to be on the save
> side, maybe it would be better to have to cleanup labels, and only do the
> gnutls_pkcs7_deinit() if it has been initialized before?

All gnutls APIs for free'ing objects accept NULL and act as a no-op,
so we're ok.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


