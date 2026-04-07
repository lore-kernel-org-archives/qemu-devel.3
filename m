Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BD6FF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABTd-0004Nz-21; Tue, 07 Apr 2026 14:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wABS6-0002em-Kd
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wA8xP-0004xT-P8
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 12:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775578032;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9MQbA2DQRtBED0O3lx71txXOFPpqk+7msQil/nwd+r8=;
 b=FQqzraFqO8NQKDLRlW0fJaScV9yehkvFgogwGUOGRpT11DtrzOC+nvcFCTTx4+gT8yxbuX
 pYJcsX6Ov0YRPWfJ77VLtqWCNr1OWCrLcXJViluA6iCQdPS+p+W+90X5DfCzEY4hm75/hC
 O3el65Pn9zd0CS9DXVByf5pZ/SV5yXM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-4xsZKmlfORyBwxooT8bkvA-1; Tue,
 07 Apr 2026 12:07:08 -0400
X-MC-Unique: 4xsZKmlfORyBwxooT8bkvA-1
X-Mimecast-MFC-AGG-ID: 4xsZKmlfORyBwxooT8bkvA_1775578026
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B64418002CB; Tue,  7 Apr 2026 16:07:06 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D11C300019F; Tue,  7 Apr 2026 16:07:01 +0000 (UTC)
Date: Tue, 7 Apr 2026 17:06:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, jrossi@linux.ibm.com,
 cohuck@redhat.com, richard.henderson@linaro.org,
 pierrick.bouvier@linaro.org, david@kernel.org,
 walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 jdaley@linux.ibm.com
Subject: Re: [PATCH v10 08/30] crypto/x509-utils: Add helper functions for
 DIAG 320 subcode 2
Message-ID: <adUrok15nPtpedu5@redhat.com>
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-9-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402221453.1602899-9-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 02, 2026 at 06:14:30PM -0400, Zhuoying Cai wrote:
> Introduce new helper functions to extract certificate metadata:
> 
> qcrypto_x509_check_cert_times() - validates the certificate's validity period against the current time
> qcrypto_x509_get_pk_algorithm() - returns the public key algorithm used in the certificate

This is no longer exported, so drop that mention.

> qcrypto_x509_get_cert_key_id() - extracts the key ID from the certificate
> qcrypto_x509_check_ecc_curve_p521() - determines the ECC public key algorithm uses P-521 curve
> 
> These functions provide support for metadata extraction and validity checking
> for X.509 certificates.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
> ---
>  crypto/x509-utils.c         | 236 ++++++++++++++++++++++++++++++++++++
>  include/crypto/x509-utils.h |  51 ++++++++
>  2 files changed, 287 insertions(+)
> 
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 2696d48155..906d5e5e87 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> +static int qcrypto_x509_get_ecc_curve(uint8_t *cert, size_t size, Error **errp)
> +{
> +    int rc;
> +    int ret = -1;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +    gnutls_ecc_curve_t curve_id;
> +    gnutls_datum_t x = {.data = NULL, .size = 0};
> +    gnutls_datum_t y = {.data = NULL, .size = 0};
> +
> +    rc = gnutls_x509_crt_init(&crt);
> +    if (rc < 0) {
> +        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
> +        return ret;
> +    }
> +
> +    rc = gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    rc = gnutls_x509_crt_get_pk_ecc_raw(crt, &curve_id, &x, &y);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to get ECC public key curve: %s", gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    ret = curve_id;
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    gnutls_free(x.data);
> +    gnutls_free(y.data);

Use g_free here instead of gnutls_free

> +    return ret;
> +}

With those two changes made

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
  Acked-by: Daniel P. Berrangé <berrange@redhat.com>
  

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


