Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45409C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 16:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKgOR-0006EF-O5; Thu, 29 May 2025 12:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uKgON-000683-36
 for qemu-devel@nongnu.org; Thu, 29 May 2025 12:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uKgOK-000773-OE
 for qemu-devel@nongnu.org; Thu, 29 May 2025 12:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748537163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b+yNaSRNNydwpQNVvyf+n1Kv6DKtrJqLIa/98QQYvcQ=;
 b=aM4U0YFVjPFlZ/CrQWmi7B/Mz4S9Ilm2hEsIL5lVnbkxYrbeV48EA08q90OIzZrONPqzh7
 jc3XJ3wE92awsfRSBNr3AJejhhyTBrFjdQg6LzDD7M1+zIXvZFXBYPzU9aotFw58nnuiIV
 9IXmZTxK05MYljUNM9qbmDQqRN/6Pl0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-J1NE7913NrS-nZiJX8HrTg-1; Thu, 29 May 2025 12:46:01 -0400
X-MC-Unique: J1NE7913NrS-nZiJX8HrTg-1
X-Mimecast-MFC-AGG-ID: J1NE7913NrS-nZiJX8HrTg_1748537159
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d209dc2d3so7570355e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 09:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748537159; x=1749141959;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+yNaSRNNydwpQNVvyf+n1Kv6DKtrJqLIa/98QQYvcQ=;
 b=XEoPw4wc+RJUzx35QzhAYs/c7Ca7kmcM3jvuetale8nbL9q5sQh0NJkVPuWto4N1BE
 2mJnNUkeSKaQOOJTzvwM+0YOvvsx4cXnsyMEkjO5Jfn9YnWq6GLdIoxm/5jSgrPHjBOq
 evtwvbg4Qatet2Lep3JvlcZb8omIMLN/CcAeWZWjbCbBGRR0HSZ9OzMJSUX/a9BqQR6j
 5/ihS+gOVPYjeXsym3Umr46eqmKbG+jK+/o+Ex+74NuK5AVtKDdeJFLpu7UuaH5Y0FWo
 mI6w8NVpDxmgFzC3OA+bpd+R14uSSt5hUMIrE7tZCzO+Th78R5VdRxYRw8Os2lIR0Qax
 xe6w==
X-Gm-Message-State: AOJu0YzUgsDO6qZI61wfZoloQCM4xbwSZDEI4fDNfbMaJbuE6TnMfRpA
 KhPXJMqxQHNmFWpdppY6YDM6MDmbg4hFmv2VT6Rq+87oje0OMSXKB8J4goxnWU5SQdnOpmIHfGQ
 y7Rhq4hZnVINhYB9GVUuiKAF7H77f0RHJrbYWrA7WUz3MMQILRxmGjZll
X-Gm-Gg: ASbGncvxseNvQ/J+CleidFF3TZhc68ClsIpznShSsXnTjc/gwa+Pk2LItgt717Sq+10
 TSzNye/WKqUTQgM3xaV3Snaz8x5ah61jPUoH0cpLkCUkN/aZF5HaS9psNetsrY15n+wVl9hIewV
 4BAt1+24/Ir3/uQfGLm7+y/C7RRglkwdAFIVJP3mEwQrdZnHhoUiVm1swp2L4HgJp2b2X9QuPBh
 m/koYXSOd9eirmmRayn4EVF19n4ZwXeFhyBtF27nm4dBPIdUIgXkj9KSp8TCzoxOPmi59il9zqU
X-Received: by 2002:a05:600c:5109:b0:43d:cc9:b09d with SMTP id
 5b1f17b1804b1-450d6550697mr3771295e9.20.1748537158930; 
 Thu, 29 May 2025 09:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnujjjR+frIWD77I8eMZgIahCn9xoCXuX+uZgCM9oELg3aWeDl1ImUNWddql5dfeEw6Zwtdg==
X-Received: by 2002:a05:600c:5109:b0:43d:cc9:b09d with SMTP id
 5b1f17b1804b1-450d6550697mr3771115e9.20.1748537158581; 
 Thu, 29 May 2025 09:45:58 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d6377edfsm3570075e9.5.2025.05.29.09.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 09:45:58 -0700 (PDT)
Date: Thu, 29 May 2025 18:45:56 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 04/11] migration/bg-snapshot: Do not check for SKIP in
 iterator
Message-ID: <aiuvpqe66cqdhz4wjqpyqdph2d2vdah37lp5oo2u24rf4dmxkk@knlvpjgtyu5l>
References: <20250527215850.1271072-1-peterx@redhat.com>
 <20250527215850.1271072-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527215850.1271072-5-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2025-05-27 17:58, Peter Xu wrote:
> It's not possible to happen in bg-snapshot case.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


