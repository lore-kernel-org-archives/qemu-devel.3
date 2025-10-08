Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AFACCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 15:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6WRM-00068Q-AQ; Wed, 08 Oct 2025 11:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v6WRG-000687-A0
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 11:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v6WQe-0000Rj-35
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 11:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759938605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOKVYutEh44KnwoDwnn/ZGcCYUHyC4r8douHmVQTZ60=;
 b=UxMnuyqY4fa10t7A9TxnCNmmq2n0+BSTNt+NRe/WvgVHGryG4lNp+teoS+KI4oZ/IrBteR
 +CKDeB0nCe6YDACrhntzWUPCodMmgXOwrm0NT4ahvqFdWOFI3zfrzuGv1K1MrfEelpFc1F
 x5c4NphqPPAT315Fz1DUkwWRcfqcZek=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-lFLd5_DGN8W_7PnzEB7v7A-1; Wed,
 08 Oct 2025 11:50:03 -0400
X-MC-Unique: lFLd5_DGN8W_7PnzEB7v7A-1
X-Mimecast-MFC-AGG-ID: lFLd5_DGN8W_7PnzEB7v7A_1759938602
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CE76195419C; Wed,  8 Oct 2025 15:49:55 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 833483002D0F; Wed,  8 Oct 2025 15:49:52 +0000 (UTC)
Date: Wed, 8 Oct 2025 10:49:49 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org
Subject: Re: [PATCH 3/4] tests: add nbd and luks to the I/O test suites
Message-ID: <fw3tw6sr577fyn2czsq3ltng2ox2qbzr5546ynjfibaauoj2ax@33lp37mmodv5>
References: <20251008113552.747002-1-berrange@redhat.com>
 <20251008113552.747002-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251008113552.747002-4-berrange@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 08, 2025 at 12:35:51PM +0100, Daniel P. Berrangé wrote:
> This introduces new suits for running I/O tests on NBD and LUKS

suites

> drivers, giving new make targets
> 
>  * make check-block-luks
>  * make check-block-nbd
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  tests/qemu-iotests/meson.build | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


