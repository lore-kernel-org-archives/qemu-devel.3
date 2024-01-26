Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F04C48285
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 10:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTJHh-0007ZK-FQ; Fri, 26 Jan 2024 05:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rTJHf-0007Z0-2A
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 05:18:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rTJHb-0007ao-C6
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 05:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706264278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Js8nwfiZmvaEV9g1TfZYlFioWAuxLlMLSUhokT7Iw1k=;
 b=HviGlGt5vd4FnDBPFRqER2qKHXdtZZHlSp4CkmruQbpi/5rLNNwg3o6C7UmMVDHcWVTbBx
 ngTkmueDTkQvqIyjkm1u+vBb9I47+R2XhM4vlI9bGRmsPB7NtEA3VxL6rdiuRg7uy9q5hv
 NBkUCiY+lWIv15ZXqdg9Ves6QsudSoE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-P6MlrIorNoOcJtZ0n8TQwg-1; Fri,
 26 Jan 2024 05:17:53 -0500
X-MC-Unique: P6MlrIorNoOcJtZ0n8TQwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F17D28116AD;
 Fri, 26 Jan 2024 10:17:53 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CDFA400D5CD;
 Fri, 26 Jan 2024 10:17:52 +0000 (UTC)
Date: Fri, 26 Jan 2024 11:17:51 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 eblake@redhat.com, den@virtuozzo.com
Subject: Re: [PATCH] iotests/264: Use iotests.sock_dir for socket creation
Message-ID: <ZbOGzyQnaE4aRxJ8@redhat.com>
References: <20240125135237.189493-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125135237.189493-1-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 25.01.2024 um 14:52 hat Andrey Drobyshev geschrieben:
> If socket path is too long (longer than 108 bytes), socket can't be
> opened.  This might lead to failure when test dir path is long enough.
> Make sure socket is created in iotests.sock_dir to avoid such a case.
> 
> This commit basically aligns iotests/264 with the rest of iotests.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Thanks, applied to the block branch.

Kevin


