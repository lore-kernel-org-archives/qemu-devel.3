Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D552CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 06:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8YkM-0006Qc-0o; Tue, 14 Oct 2025 02:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v8YkI-0006QG-4k
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 02:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v8YkF-00075k-2q
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 02:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760424168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f3njgFPZTEgXIwLuw97AAgM9XlnNLoe4sFCLoEdh8Bw=;
 b=gdUrZlwMdrxwlSafEWSrH6ZlzDx6EzRzJaYbFy6QjfXIfAzMaRzZgg3O372/VKUEWDH7df
 UNPY0myE/qli+qHC9ugtivaBO548sdYL2cXi5jtwbIId/RWSOYYhGhND9PYMoVqMIWBBQc
 gPDAhbuOHVThCOPSORBx5J/Rl6M5EBw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-m3VOcgzvN-WGXVmoFELPLw-1; Tue,
 14 Oct 2025 02:42:45 -0400
X-MC-Unique: m3VOcgzvN-WGXVmoFELPLw-1
X-Mimecast-MFC-AGG-ID: m3VOcgzvN-WGXVmoFELPLw_1760424164
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69AC718004D4; Tue, 14 Oct 2025 06:42:44 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.78])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90EEA19560A2; Tue, 14 Oct 2025 06:42:42 +0000 (UTC)
Date: Tue, 14 Oct 2025 08:42:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH] iotests: Adjust nbd expected outputs to match current
 behavior
Message-ID: <aO3w4NoXneWRPSHQ@redhat.com>
References: <20251013213638.494193-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251013213638.494193-2-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Am 13.10.2025 um 23:36 hat Eric Blake geschrieben:
> 'git bisect' confirms that the NBD iotests 94 and 119 have been broken
> since commit effd60c8 in v9.0.0; but as Dan Berrange's efforts to
> improve CI have proven, we haven't been reliably running them to
> notice.  The change was good (moving coroutine commands to run in the
> right context), but it meant that "execute":"quit" now waits to
> complete until the coroutines tearing down NBD have first reported the
> SHUTDOWN event, in the opposite order of what happened pre-patch.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Fixes: effd60c8 ("monitor: only run coroutine commands in qemu_aio_context", v9.0.0)
> Reported-by: Daniel P. Berrangé <berrange@redhat.com>

Thanks, applied to the block branch.

Kevin


