Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11368606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J1S3fye4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQj83-0007mW-B9; Tue, 10 Nov 2026 05:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1xQj82-0007mE-2Q
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:31:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1xQj80-0000vT-JX
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794306658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y53BTpGHFnyAyP9D3jsZdcD9d7sx8jW13Hu4TPCpBOE=;
 b=J1S3fye4woGbWk/5WkLzGR/RzmRqjPHqTJiG+tbU3mp11FPPnH9xRnWbTXshzQmUgO4Bc/
 ZhyFISydcU+jDTZ371kNTEiXOE5HaRrMqGfe3PTO5xQ7CtogKTUT3QZ5FvwMgacubeC3d6
 wpLBlvKA+9+DRfaUhhALjfNz4dVT5tY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-6s4Tn5YDOEe9UlwNyt4FYA-1; Tue,
 10 Nov 2026 05:30:56 -0500
X-MC-Unique: 6s4Tn5YDOEe9UlwNyt4FYA-1
X-Mimecast-MFC-AGG-ID: 6s4Tn5YDOEe9UlwNyt4FYA_1794306655
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06AFB1800471; Tue, 10 Nov 2026 10:30:55 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 046F918004F7; Tue, 10 Nov 2026 10:30:53 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Francesco Valla <francesco@valla.it>, qemu-devel@nongnu.org
Cc: Francesco Valla <francesco@valla.it>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] update-linux-headers: strip endianness-aware __counted_by
In-Reply-To: <20261107175443.29012-1-francesco@valla.it>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20261107175443.29012-1-francesco@valla.it>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Tue, 10 Nov 2026 11:30:51 +0100
Message-ID: <87mrrhvuzo.fsf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 07 2026, Francesco Valla <francesco@valla.it> wrote:

> Deal with the endianness-aware __counted_by_be() and __counted_by_le()
> annotations in Linux headers just like with __counted_by(): stripping
> them.
>
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>  scripts/update-linux-headers.sh | 2 ++
>  1 file changed, 2 insertions(+)

For virtio-can, I guess?

>
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 3c3a0e9394d2..d3f843356507 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -92,6 +92,8 @@ cp_portable() {
>          -e "$arch_cmd" \
>          -e 's/__bitwise//' \
>          -e 's/__counted_by(\w*)//' \
> +        -e 's/__counted_by_be(\w*)//' \
> +        -e 's/__counted_by_le(\w*)//' \
>          -e 's/__attribute__((packed))/QEMU_PACKED/' \
>          -e 's/__inline__/inline/' \
>          -e 's/__BITS_PER_LONG/HOST_LONG_BITS/' \

Not sure if we would want to kill all the __counted_by* birds with one
stone, but let's not overthink this.

Acked-by: Cornelia Huck <cohuck@redhat.com>


