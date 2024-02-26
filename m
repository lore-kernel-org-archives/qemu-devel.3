Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFBCC47DD9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 02:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reQKu-0003v9-9c; Sun, 25 Feb 2024 21:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reQKr-0003uo-Uh
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 21:03:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reQKq-0007rB-Fh
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 21:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708912995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QcDs+tSqSpdltAaa9Ycu0BVqqjvcywJgcllGARgWQg4=;
 b=VyTl6IGfsulH+yK+KW42wE3ABsaa1JVIinCu/OrOM4YkV1JCwVlp1q4qoBKdumVnZh1i54
 N/oUpGCuwdnElUDypw929RhhQTUN4hpDF0YUEv/addgh0dZ46SOsx6mrMz6YZLvS/V3jkN
 Jwdgv9nLRlmD2VuFeoShfg2Nso0ikwI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-pTvo1CPOMCm49yyxcwsc5A-1; Sun, 25 Feb 2024 21:03:13 -0500
X-MC-Unique: pTvo1CPOMCm49yyxcwsc5A-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-29a16254a66so899371a91.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 18:03:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708912992; x=1709517792;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QcDs+tSqSpdltAaa9Ycu0BVqqjvcywJgcllGARgWQg4=;
 b=kD/sRzoeCFM5OWx+UdrSJbgidJRceAzmza/nnbsyGgH836GmcSkR0qn5JqCMO8VhNH
 KHmYt9nvi8g6/sVfgM1o4vAilMKtI4BVAn7GsWzhTdgfjzA/9kWHPZ8smvrMCbP4/2G3
 QMNre22CbvAkgy1YcZZeMH/y7KWC7YHsSNBnG8DEgB2IpMArHBwWVyZJigkNKHoLGSru
 XvgQ2cJTZvGuNYnzh+stGkCxHnD2Ir3fsIM1tOEdC3O3BrTM0uChwOMig+K2bBmHlLrW
 Xoi5pHvaMDGaSCJrzoNVwIJgwTZRvMT5sE55NOWieA4ZpA3XUzx+jWKvhu0D9HaIYxxO
 kZcA==
X-Gm-Message-State: AOJu0Yy87jjDC7YXYBMd07Gr3IdwwDWw2BZ4zDOyiH06Yk7Vc3eLeGa6
 HqoIBwnFMvERopX4WIH7gv5hr00zDBN5mrYQgvi3d7Wh8b61ZjnWSHIfocvmu2u7TGOhnGU3w4b
 uQ4tgAXdwA1r2Nd4bU0PBFnKuMx3Dz26F+JZgD4UdjtfaP6hzvb9T
X-Received: by 2002:a17:902:a711:b0:1d8:ca3a:9d2a with SMTP id
 w17-20020a170902a71100b001d8ca3a9d2amr6486666plq.4.1708912992010; 
 Sun, 25 Feb 2024 18:03:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9YfRsOCANSW8w4hyCOlLvwfDdrIHjaazWknC8pqhnWq9KfbTcs67KLi7WEQAITG7p/VFiCA==
X-Received: by 2002:a17:902:a711:b0:1d8:ca3a:9d2a with SMTP id
 w17-20020a170902a71100b001d8ca3a9d2amr6486650plq.4.1708912991662; 
 Sun, 25 Feb 2024 18:03:11 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ko8-20020a17090307c800b001db3361bc1dsm2807902plb.102.2024.02.25.18.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 18:03:11 -0800 (PST)
Date: Mon, 26 Feb 2024 10:03:04 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V4 09/14] migration: notifier error checking
Message-ID: <ZdvxWAQJ8bdUd6cy@x1n>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <1708622920-68779-10-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1708622920-68779-10-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Feb 22, 2024 at 09:28:35AM -0800, Steve Sistare wrote:
> Check the status returned by migration notifiers for event type
> MIG_EVENT_PRECOPY_SETUP, and report errors.  None of the notifiers
> return an error status at this time.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


