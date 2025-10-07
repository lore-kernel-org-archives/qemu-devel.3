Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E12CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 09:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v64AB-0002HF-3k; Tue, 07 Oct 2025 05:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v64A9-0002Gv-8h
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v64A7-0001vE-1S
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759829952;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gZi2Lee67V4qSUzY1HqLVYRPZJMF1+OpXlxag+nvq5g=;
 b=dqWIeQwXosSYJ01oTTSZaPCRiaYNGNqEyAoL0v+bMRVO4plI42AUuhqYWRwUYICTZ6ffz0
 CgLgH64i8dH/z1eBUIpUiOBwd6+6gqnzvDxQNjnbmyVp08KubUfKmQZ+zMbYgBMwhFmBvy
 USoUQfoEJvnQETwlcl0ubgselbTdLYM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-hPp3eVInMRS5JmULnRVvJA-1; Tue,
 07 Oct 2025 05:39:09 -0400
X-MC-Unique: hPp3eVInMRS5JmULnRVvJA-1
X-Mimecast-MFC-AGG-ID: hPp3eVInMRS5JmULnRVvJA_1759829947
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67A78180057E; Tue,  7 Oct 2025 09:39:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.83])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BBCF1800282; Tue,  7 Oct 2025 09:38:33 +0000 (UTC)
Date: Tue, 7 Oct 2025 10:38:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
Subject: Re: [PATCH v6 08/28] crypto/x509-utils: Add helper functions for
 DIAG 320 subcode 2
Message-ID: <aOTfhXQHQ69eG5yF@redhat.com>
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-9-zycai@linux.ibm.com>
 <dd3ebdf4-3d80-475b-8739-65b6b771a0b6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd3ebdf4-3d80-475b-8739-65b6b771a0b6@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Tue, Oct 07, 2025 at 11:34:29AM +0200, Thomas Huth wrote:
> On 18/09/2025 01.21, Zhuoying Cai wrote:
> > Introduce new helper functions to extract certificate metadata needed for
> > DIAG 320 subcode 2:
> > 
> > qcrypto_x509_check_cert_times() - validates the certificate's validity period against the current time
> > qcrypto_x509_get_pk_algorithm() - returns the public key algorithm used in the certificate
> > qcrypto_x509_get_cert_key_id() - extracts the key ID from the certificate
> > qcrypto_x509_is_ecc_curve_p521() - determines the ECC public key algorithm uses P-521 curve
> > 
> > These functions provide support for metadata extraction and validity checking
> > for X.509 certificates.
> > 
> > Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> > ---
> ...
> > +int qcrypto_x509_get_pk_algorithm(uint8_t *cert, size_t size, Error **errp)
> > +{
> > +    int rc;
> > +    int ret = -1;
> > +    unsigned int bits;
> > +    gnutls_x509_crt_t crt;
> > +    gnutls_datum_t datum = {.data = cert, .size = size};
> > +
> > +    rc = gnutls_x509_crt_init(&crt);
> > +    if (rc < 0) {
> > +        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
> > +        return ret;
> > +    }
> > +
> > +    rc = gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM);
> > +    if (rc != 0) {
> > +        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
> > +        goto cleanup;
> > +    }
> > +
> > +    rc = gnutls_x509_crt_get_pk_algorithm(crt, &bits);
> > +    if (rc >= G_N_ELEMENTS(gnutls_to_qcrypto_pk_alg_map)) {
> 
> gnutls_x509_crt_get_pk_algorithm can also return a negative value according
> to the documentation, so I think you should also check for "rc < 0" in
> addition here.
> 
> > +        error_setg(errp, "Unknown public key algorithm %d", rc);
> > +        goto cleanup;
> > +    }
> > +
> > +    ret = gnutls_to_qcrypto_pk_alg_map[rc];
> > +
> > +cleanup:
> > +    gnutls_x509_crt_deinit(crt);
> > +    return ret;
> > +}
> > +
> > +int qcrypto_x509_get_cert_key_id(uint8_t *cert, size_t size,
> > +                                 QCryptoHashAlgo hash_alg,
> > +                                 uint8_t **result,
> > +                                 size_t *resultlen,
> > +                                 Error **errp)
> > +{
> > +    int rc;
> > +    int ret = -1;
> > +    gnutls_x509_crt_t crt;
> > +    gnutls_datum_t datum = {.data = cert, .size = size};
> > +
> > +    if (hash_alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
> > +        error_setg(errp, "Unknown hash algorithm %d", hash_alg);
> > +        return ret;
> > +    }
> > +
> > +    if (qcrypto_to_gnutls_keyid_flags_map[hash_alg] == -1 ||
> > +        hash_alg >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map)) {
> 
> Since "||" conditions are evaluated from left to right, please check for the
> boundary first before using hash_alg as index into the array (i.e. swapt the
> two sides of the "||").
> 
> > +        error_setg(errp, "Unsupported key id flag %d", hash_alg);
> > +        return ret;
> > +    }
> > +
> > +    rc = gnutls_x509_crt_init(&crt);
> > +    if (rc < 0) {
> > +        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
> > +        return ret;
> > +    }
> > +
> > +    rc = gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM);
> > +    if (rc != 0) {
> > +        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
> > +        goto cleanup;
> > +    }
> > +
> > +    *resultlen = gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[hash_alg]);
> > +    if (*resultlen == 0) {
> > +        error_setg(errp, "Failed to get hash algorithn length: %s", gnutls_strerror(rc));
> > +        goto cleanup;
> > +    }
> > +
> > +    *result = g_malloc0(*resultlen);
> > +    if (gnutls_x509_crt_get_key_id(crt,
> > +                                   qcrypto_to_gnutls_keyid_flags_map[hash_alg],
> > +                                   *result, resultlen) != 0) {
> > +        error_setg(errp, "Failed to get key ID from certificate");
> > +        g_clear_pointer(result, g_free);
> > +        goto cleanup;
> > +    }
> > +
> > +    ret = 0;
> > +
> > +cleanup:
> > +    gnutls_x509_crt_deinit(crt);
> > +    return ret;
> > +}
> ...
> > +int qcrypto_x509_is_ecc_curve_p521(uint8_t *cert, size_t size, Error **errp)
> > +{
> > +    int curve_id;
> > +
> > +    curve_id = qcrypto_x509_get_ecc_curve(cert, size, errp);
> > +    if (curve_id == -1) {
> > +        return -1;
> > +    }
> > +
> > +    if (curve_id == GNUTLS_ECC_CURVE_INVALID) {
> > +        error_setg(errp, "Invalid ECC curve");
> > +        return -1;
> > +    }
> > +
> > +    if (curve_id == GNUTLS_ECC_CURVE_SECP521R1) {
> > +        return 1;
> > +    }
> > +
> > +    return 0;
> > +}
> 
> Bikeshedding, but IMHO, if you name a function "..._is_something", I'd
> prefer if it returns a bool, and not an "int". Otherwise this might get
> confusing if you read something like this later in the code:
> 
>    if (qcrypto_x509_is_ecc_curve_p521(...)) {
>    }
> 
> The caller could use errp to distinguish between the error case and a
> simple "false" as answer to the question.

Overloading one 'false' return value to mean both success & failure
is an anti-pattern IMHO. We have 3 separate return values we need
for this function, so using -1/0/1 is the right approach.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


