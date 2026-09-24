Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80BBC9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9j8O-0007mG-Nr; Thu, 24 Sep 2026 09:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x9j8B-0007lW-QG
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 09:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x9j8A-0002Ye-8p
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 09:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790255093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W1NmDhXndg+/TeD28xAFJb8Y6oHdK0eH/BWO3lUOoxo=;
 b=DfzAYu6dJwxH4b4bPEtg2nUIT7Rfh3Q0vlYw3nRHT5o8C2sUmD0dVgQDEAwwSdqz9xvGqW
 zEDO2kNEnM+hAt+/T6fGFuAfSQRVGd5XajBRXRtqR+pp9dwBPlxsYx95QbMOaE/rEhdKk0
 TdX+dhlOhUi4EnWoySlQGvmh/x6+THw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-NjVIm4C9PAeBxxAP4bCtzQ-1; Thu,
 24 Sep 2026 09:04:51 -0400
X-MC-Unique: NjVIm4C9PAeBxxAP4bCtzQ-1
X-Mimecast-MFC-AGG-ID: NjVIm4C9PAeBxxAP4bCtzQ_1790255090
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68424196F767; Thu, 24 Sep 2026 13:04:50 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.118])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E9171956054; Thu, 24 Sep 2026 13:04:48 +0000 (UTC)
Date: Thu, 24 Sep 2026 15:04:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 eblake@redhat.com
Subject: Re: [PATCH v3 1/4] iotests/nbd-in-qcow2-chain: use default machine
Message-ID: <arUf7gFJkCuVH0VI@redhat.com>
References: <20260813183740.3503107-1-farman@linux.ibm.com>
 <20260813183740.3503107-2-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813183740.3503107-2-farman@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 13.08.2026 um 20:37 hat Eric Farman geschrieben:
> Some of the NBD tests explicitly specify `-machine q35` which won't work
> when running against, say, qemu-system-s390x.
> 
> The nbd-in-qcow2-chain test runs fine with the default machine on a z16
> host, so allow it to run in other configurations.
> 
> Fixes: 24fd6d75b3 ("iotests: Add coverage of recent NBD qio deadlock fix")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  tests/qemu-iotests/tests/nbd-in-qcow2-chain | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/tests/nbd-in-qcow2-chain b/tests/qemu-iotests/tests/nbd-in-qcow2-chain
> index 455ddfa86f..e35f072eba 100755
> --- a/tests/qemu-iotests/tests/nbd-in-qcow2-chain
> +++ b/tests/qemu-iotests/tests/nbd-in-qcow2-chain
> @@ -43,7 +43,7 @@ TEST_IMG="$TEST_IMG.base" _make_test_img $size
>  echo
>  echo "=== Starting QEMU and exposing base image ==="
>  
> -_launch_qemu -machine q35
> +_launch_qemu
>  h1=$QEMU_HANDLE
>  _send_qemu_cmd $QEMU_HANDLE '{"execute": "qmp_capabilities"}' 'return'
>  _send_qemu_cmd $QEMU_HANDLE '{"execute": "blockdev-add",

I don't see what the machine type is needed for, so this is probably
fine.

Eric (Blake), any specific reason you added the machine type in this
test case so that removing it might cause a regression?

Kevin


