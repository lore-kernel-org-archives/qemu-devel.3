Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B81D16816
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 11:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veApX-0002PH-Hr; Fri, 09 Jan 2026 06:38:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1veApW-0002Or-Df
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:38:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1veApU-0003ap-D0
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767958734;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/wuhbvOiXZpbPwFbF+zLdXpLOC7wJNe8+f48ayub0E=;
 b=VXn79xItV+q91ZoHqkkl+QBkrf68wCZSKnL2jqQSLsV71h+cM/ppYErq9J9eNc1L3TQPc6
 +fZkh+fW1artLMmkGD4s3//7pidk0SztUZQ/s6DeMC8KlpEwIgLpXYHj3FlDW7wh+nVXw2
 ZzA8atbBJ42JW5IryNPMDH4vvPFu1ts=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-2rK1jj5bPnaV22jvaF0m_w-1; Fri,
 09 Jan 2026 06:38:51 -0500
X-MC-Unique: 2rK1jj5bPnaV22jvaF0m_w-1
X-Mimecast-MFC-AGG-ID: 2rK1jj5bPnaV22jvaF0m_w_1767958729
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F94318005AD; Fri,  9 Jan 2026 11:38:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B107A18004D8; Fri,  9 Jan 2026 11:38:42 +0000 (UTC)
Date: Fri, 9 Jan 2026 11:38:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, brueckner@linux.ibm.com,
 walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com
Subject: Re: [PATCH v7 08/29] crypto/x509-utils: Add helper functions for
 DIAG 320 subcode 2
Message-ID: <aWDovtQX2IEwg-NA@redhat.com>
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-9-zycai@linux.ibm.com>
 <9f622221-5012-4f12-8fc2-3a721a0ce111@redhat.com>
 <aWDi7gh4uiwA7JOA@redhat.com>
 <53a6f846-2a65-49d4-aabb-021e9c2f590f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53a6f846-2a65-49d4-aabb-021e9c2f590f@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Fri, Jan 09, 2026 at 12:24:32PM +0100, Thomas Huth wrote:
> On 09/01/2026 12.13, Daniel P. Berrangé wrote:
> > On Fri, Jan 09, 2026 at 12:06:25PM +0100, Thomas Huth wrote:
> > > On 08/12/2025 22.32, Zhuoying Cai wrote:
> > > > Introduce new helper functions to extract certificate metadata:
> > > > 
> > > > qcrypto_x509_check_cert_times() - validates the certificate's validity period against the current time
> > > > qcrypto_x509_get_pk_algorithm() - returns the public key algorithm used in the certificate
> > > > qcrypto_x509_get_cert_key_id() - extracts the key ID from the certificate
> > > > qcrypto_x509_is_ecc_curve_p521() - determines the ECC public key algorithm uses P-521 curve
> > > > 
> > > > These functions provide support for metadata extraction and validity checking
> > > > for X.509 certificates.
> > > > 
> > > > Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> > > > ---
> > > >    crypto/x509-utils.c         | 248 ++++++++++++++++++++++++++++++++++++
> > > >    include/crypto/x509-utils.h |  73 +++++++++++
> > > >    2 files changed, 321 insertions(+)
> > > > 
> > > > diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> > > > index 2696d48155..f91fa56563 100644
> > > > --- a/crypto/x509-utils.c
> > > > +++ b/crypto/x509-utils.c
> > > > @@ -27,6 +27,25 @@ static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
> > > >        [QCRYPTO_HASH_ALGO_RIPEMD160] = GNUTLS_DIG_RMD160,
> > > >    };
> > > > +static const int gnutls_to_qcrypto_pk_alg_map[] = {
> > > 
> > > Could you do me a favour and add a line like this at the beginning of this
> > > array:
> > > 
> > >   [GNUTLS_PK_UNKNOWN] = QCRYPTO_PK_ALGO_UNKNOWN,
> > > 
> > > and then also set QCRYPTO_PK_ALGO_UNKNOWN = 0 in the enum in the header?
> > > That way we can be sure that zero values are not accidentally mapped to a
> > > valid algorithm.
> > 
> > That would be special casing just one enum type in the crypto subsystem
> > to have this special unknown value. We've got 1000's of enums across
> > QEMU and don't generally add such a special zeroth constant, so I don't
> > find this suggested change to be desirable.
> 
> I came up with this idea when reviewing the qcrypto_x509_get_pk_algorithm()
> function in this patch which is basically doing:
> 
>    ret = gnutls_to_qcrypto_pk_alg_map[rc];
> 
> My concern is that if someone ever extends the QCryptoPkAlgo in the header,
> but forgets to fill in as much entries to gnutls_to_qcrypto_pk_alg_map as
> there are entries in the enum, we're in trouble, since the wholes in the
> array will be padded with zeros that then get mapped to QCRYPTO_PK_ALGO_RSA.
> Having a clearly invalid meaning of 0 would help in such cases.

Hmm, looking at the usage of qcrypto_x509_get_pk_algorithm(), I think
the method and the QCryptoPkAlgo enums should be deleted entirely.

In the next patch, the caller does


    /* public key algorithm */
    algo = qcrypto_x509_get_pk_algorithm(cert.raw, cert.size, &err);
    if (algo < 0) {
        error_report_err(err);
        return -1;
    }

    if (algo == QCRYPTO_PK_ALGO_ECDSA) {
        rc = qcrypto_x509_check_ecc_curve_p521(cert.raw, cert.size, &err);
        if (rc == -1) {
            error_report_err(err);
            return -1;
        }

        return (rc == 1) ? DIAG_320_VCE_KEYTYPE_ECDSA_P521 :
                           DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;
    }

    return DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;


so the caller doesn't actually care about anything other than
PK_ALGO_ECDSA, so IMHO going to the trouble of defining an enum
and mapping gnutls enums is pointless.

This caller should unconditionally call

 qcrypto_x509_check_ecc_curve_p521()

and then then qcrypto_x509_check_ecc_curve_p521() method should
check whether the pk algorithm is GNUTLS_PK_ECDSA internally
and just return 0 if not.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


