Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D1CCD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbyo-0001Xm-97; Tue, 19 Mar 2024 12:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmbyk-0001XR-7q
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:06:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmbyh-0001Jg-5j
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710864373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9n1fbHhaeu7kwKLQ6ZzNSeQbIjss6D8thJm9hAqnsq0=;
 b=gK0JiESx+7lKuQR2fn9Infs5CM/C7uUnM6U/7dDnd2ELwW9r9xqm3fVN+jepTy90vBDX6y
 UQm5/q0p/FyuKHZNvE2+SH+l9iYZG2RENbrMZGzE8YvZPIbwTGweYeB6xA8NJN3SItDrU1
 m+W9EJZ3/8s3E1Pg3KI6cCgJrxBUldM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-YeIligtLNsm-TKYTSUtQYg-1; Tue, 19 Mar 2024 12:06:12 -0400
X-MC-Unique: YeIligtLNsm-TKYTSUtQYg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2329C852009
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 16:06:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0217A200AFA3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 16:06:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 16C9F21E6A28; Tue, 19 Mar 2024 17:06:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH for-9.0] qapi: drop unused
 QCryptoBlockCreateOptionsLUKS.detached-header
In-Reply-To: <20240319153908.194975-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 19 Mar 2024 15:39:08
 +0000")
References: <20240319153908.194975-1-berrange@redhat.com>
Date: Tue, 19 Mar 2024 17:06:07 +0100
Message-ID: <87jzlyyzo0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The 'detached-header' field in QCryptoBlockCreateOptionsLUKS
> was left over from earlier patch iterations.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qapi/crypto.json | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index 931c88e688..ad9e3d0297 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -226,8 +226,6 @@
>  # @iter-time: number of milliseconds to spend in PBKDF passphrase
>  #     processing.  Currently defaults to 2000. (since 2.8)
>  #
> -# @detached-header: create a detached LUKS header. (since 9.0)
> -#
>  # Since: 2.6
>  ##
>  { 'struct': 'QCryptoBlockCreateOptionsLUKS',
> @@ -237,8 +235,7 @@
>              '*ivgen-alg': 'QCryptoIVGenAlgorithm',
>              '*ivgen-hash-alg': 'QCryptoHashAlgorithm',
>              '*hash-alg': 'QCryptoHashAlgorithm',
> -            '*iter-time': 'int',
> -            '*detached-header': 'bool'}}
> +            '*iter-time': 'int' }}
>=20=20
>  ##
>  # @QCryptoBlockOpenOptions:

Glad you caught this in time.

Acked-by: Markus Armbruster <armbru@redhat.com>


