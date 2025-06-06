Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EE4C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 11:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNUsr-00023o-JQ; Fri, 06 Jun 2025 07:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNUsp-00020w-1R
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 07:05:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNUsn-0000HH-Cf
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 07:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749207908;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U+v8bDHp5o65XUKeYn6DgDSvsAfj5GnOYZfdW60wu9E=;
 b=QyYfgpEAALu9KsQqAac2gHdrj9f3Uc6GKWR1tN+6Kr8MHNdBIdOGGbTXU4q3Jrx0+DquoQ
 368bRTe3P+Wd+18Sy+zIiC/ecYFUJWZ1pXOg74BmVLY9TIHr1BElPaAaF6mh7sfpDcm6V5
 Sl/ILjjT0j+VjAEeR4a/Vg8TpRoix04=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-ZlxfyU8-NKaKaA78RtO3Zw-1; Fri,
 06 Jun 2025 07:05:05 -0400
X-MC-Unique: ZlxfyU8-NKaKaA78RtO3Zw-1
X-Mimecast-MFC-AGG-ID: ZlxfyU8-NKaKaA78RtO3Zw_1749207903
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 929361800EC5; Fri,  6 Jun 2025 11:05:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E70FA18002B3; Fri,  6 Jun 2025 11:04:57 +0000 (UTC)
Date: Fri, 6 Jun 2025 12:04:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, walling@linux.ibm.com, jjherne@linux.ibm.com,
 jrossi@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 28/28] docs: Add secure IPL documentation
Message-ID: <aELLViTblm9chFke@redhat.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
 <20250604215657.528142-29-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250604215657.528142-29-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Jun 04, 2025 at 05:56:56PM -0400, Zhuoying Cai wrote:
> Add documentation for secure IPL
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  docs/specs/s390x-secure-ipl.rst  | 145 +++++++++++++++++++++++++++++++
>  docs/system/s390x/secure-ipl.rst | 129 +++++++++++++++++++++++++++
>  2 files changed, 274 insertions(+)
>  create mode 100644 docs/specs/s390x-secure-ipl.rst
>  create mode 100644 docs/system/s390x/secure-ipl.rst
> 

> +Secure IPL Quickstart
> +=====================
> +
> +Build QEMU with gnutls enabled:
> +
> +.. code-block:: shell
> +
> +    ./configure … --enable-gnutls
> +
> +Generate certificate (e.g. via openssl):
> +
> +.. code-block:: shell
> +
> +    openssl req -new -x509 -newkey rsa:2048 -keyout mykey.priv \
> +                -outform DER -out mycert.der -days 36500 \
> +                -subj "/CN=My Name/" -nodes

Please illustrate with gnutls 'certtool' for consistency
with other cert creation docs we have at:

  https://www.qemu.org/docs/master/system/tls.html


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


