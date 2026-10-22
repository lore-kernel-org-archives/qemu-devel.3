Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5C6606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C55Mgl3E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzKL-0000Id-BO; Thu, 22 Oct 2026 16:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xJzKI-0000E0-9V
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:23:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xJzKC-000747-PE
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792700623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kISKuJlgt0i4wucwJNGi3o9iGRUt3pXVaDqjuEf3guU=;
 b=C55Mgl3EzesKQtU+vYgzWiuY3L51D5mFFEdw1UonVngSWXv95ZE2RbBVSpFVaW6C3Ggh94
 uZ+UpMeRl4CWpUq/gmoVh3Es+qxsj7lk/xFQO7AQYXhx2Zi81OTZ3H/bX3nO/tGpvMQtxf
 tnfbdoVWye++MTxh6+vzdvwO4PHaNPI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-Lm4j7fCPNmKZHWmJa0neZw-1; Thu,
 22 Oct 2026 16:23:39 -0400
X-MC-Unique: Lm4j7fCPNmKZHWmJa0neZw-1
X-Mimecast-MFC-AGG-ID: Lm4j7fCPNmKZHWmJa0neZw_1792700618
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E62D1956043; Thu, 22 Oct 2026 20:23:38 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0AE801954107; Thu, 22 Oct 2026 20:23:37 +0000 (UTC)
Date: Thu, 22 Oct 2026 16:23:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 'Daniel P =?iso-8859-1?Q?=2E_Berrang=E9'?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V18 05/13] virtio-vq-mapping: track iothread-vq-mapping
 references using device path
Message-ID: <20261022202336.GH20810@shajnocz.csb>
References: <20260929084416.1600199-1-zhangckid@gmail.com>
 <20260929084416.1600199-6-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929084416.1600199-6-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Sep 29, 2026 at 04:44:08PM +0800, Zhang Chen wrote:
> @@ -120,13 +124,19 @@ bool iothread_vq_mapping_apply(
>      return true;
>  }
>  
> -void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list)
> +void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list,
> +                                 const char *holder)
>  {
>      IOThreadVirtQueueMappingList *node;
>  
>      for (node = list; node; node = node->next) {
>          IOThread *iothread = iothread_by_id(node->value->iothread);
> -        object_unref(OBJECT(iothread));
> +        const IOThreadHolder io_holder = {
> +            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> +            .u.qom_object.qom_path = (char *)holder,
> +        };
> +
> +        iothread_unref_and_put_aio_context(iothread, &io_holder);

If the `object_del iothread0` monitor command was used to delete the
IOThread, then the object still exists but iothread_by_id() cannot look
it up because object_unparent() has already removed it from the object
hierarchy. That means iothread can be NULL here.

Please implement bc->prepare_delete() in iothread.c to return an error
when iothread->holders is non-NULL. This prevents `object_del` from
unparenting the IOThread object while there are still users.


