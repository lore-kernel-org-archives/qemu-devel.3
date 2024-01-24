Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EFFC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 17:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rShHd-0007NZ-3Z; Wed, 24 Jan 2024 12:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rShHa-0007NE-88
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 12:43:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rShHY-00033I-RE
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 12:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706118202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z9WlEsi/AsyZ9BP5ixRG8hBx19L5nfQN00RwzJz2njo=;
 b=eWzOA8eM2cueOYUv/rrHp7LAHdKtCZ45M3liT37fgnPizqfCOHv92pHwgi+wNkvTUZMl37
 Ds0C6GOCOHADhHBjp8zR1Declg4wZJJE20MVI304+MoPmbdZvoLC3pOnvccco0JrQQtKob
 uYGHxK8/IGyyWtsVCYVqf+zOiY+J9Gw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-j2c22SLiO6O8r2GZexRV2w-1; Wed,
 24 Jan 2024 12:43:17 -0500
X-MC-Unique: j2c22SLiO6O8r2GZexRV2w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCE94380673B;
 Wed, 24 Jan 2024 17:43:16 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B463D492BFD;
 Wed, 24 Jan 2024 17:43:15 +0000 (UTC)
Date: Wed, 24 Jan 2024 11:43:14 -0600
From: Eric Blake <eblake@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com, 
 kwolf@redhat.com, den@virtuozzo.com
Subject: Re: [PATCH] iotests/277: Use iotests.sock_dir for socket creation
Message-ID: <3v7hvc2kt7obfhvnfrgmtwk4ofvy5dmrkiho3cbqsm2vnfhnl2@6n5i47olcp64>
References: <20240124162257.168325-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124162257.168325-1-andrey.drobyshev@virtuozzo.com>
User-Agent: NeoMutt/20231221
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Jan 24, 2024 at 06:22:57PM +0200, Andrey Drobyshev wrote:
> If socket path is too long (longer than 108 bytes), socket can't be
> opened.  This might lead to failure when test dir path is long enough.
> Make sure socket is created in iotests.sock_dir to avoid such a case.
> 
> This commit basically aligns iotests/277 with the rest of iotests.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  tests/qemu-iotests/277 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/tests/qemu-iotests/277 b/tests/qemu-iotests/277
> index 24833e7eb6..4224202ac2 100755
> --- a/tests/qemu-iotests/277
> +++ b/tests/qemu-iotests/277
> @@ -27,7 +27,8 @@ from iotests import file_path, log
>  iotests.script_initialize()
>  
>  
> -nbd_sock, conf_file = file_path('nbd-sock', 'nbd-fault-injector.conf')
> +conf_file = file_path('nbd-fault-injector.conf')
> +nbd_sock = file_path('nbd-sock', base_dir=iotests.sock_dir)
>  
>  
>  def make_conf_file(event):
> -- 
> 2.39.3
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


