Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16144C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 06:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcJyR-000405-7E; Tue, 20 Feb 2024 01:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcJyP-0003zi-Bj
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:51:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcJyO-0004y5-3I
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708411883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZxxdjQANxVC91PzBJOpK0fHUtpAuMkabrrIRYI/uE3c=;
 b=hJN0YcUhgp2TO6zPsiSwdUDFbnoUemJ2iOHmFuBMgm0ATflDgZZp4CnQhCcTv+v/hPDfeP
 nmHd5tVHP2j2dWYlHjfODOywkYZC8YWpTtGppWNiX/XRzMk4qySS/8T7T/p2mJ+O21WCml
 NIH3NUXh7JhctFYONeIp6g48BZPNuqc=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-ANrBHBeAOHiFybJLGRXrnA-1; Tue, 20 Feb 2024 01:51:21 -0500
X-MC-Unique: ANrBHBeAOHiFybJLGRXrnA-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-59f74be84dfso913212eaf.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 22:51:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708411880; x=1709016680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxxdjQANxVC91PzBJOpK0fHUtpAuMkabrrIRYI/uE3c=;
 b=PaFYaDpNrNisV8dWEwRcYm/Afm3Wec6/KrqaGx8DdPjIYCgqmetlrey04m2fX4x0Go
 My/S3+6LDPA/bxDlGrxQaCv5dy9RaRn5DFbLZTSRreEKZ1LQOBqZ8h2thUxVGlLlii1q
 z+juFLfivZUX2jjM1Cmqpqu57usT4xqofYw+ORbwxEd1MSq+N1PgoOYVyunSNg7Zb/S5
 vY4bowdghgEDn2addG3wPHW7BN35JHJ3xofBWgxHLb0eWBD3JIbMUraV4YIhtN6WWbBn
 xDQxCcRuEfvNb6Fa9SpNlgfwKcXrP2EU2xy+XMx3EOpGjqrvnoR/sAbUDCFUxpzsszdA
 +dfg==
X-Gm-Message-State: AOJu0YxTYexf+KYgDyA+2YwCRJPME+mqaVFCcLi/1geBfsr6yfipL0GW
 PUdk92SS+i7tT0qGsWDLliBASCjoKo4MyYYZfWdQGe28ieZxiGpPRc/j15cf1bnc50oW1PmIUAV
 yuGuDCV3Hun4L5igLQACcKCfKVM+1HlSS5VCg+dvdS7n2wZIAt5tk
X-Received: by 2002:a05:6358:5925:b0:178:f482:6e59 with SMTP id
 g37-20020a056358592500b00178f4826e59mr13277850rwf.3.1708411880686; 
 Mon, 19 Feb 2024 22:51:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbQC+Ch2T/n5UV4G+wEeyynAhNSnp4HVJmWKglreO5EqLBmcyMMHI6y5o28rYHEzXrX+cVew==
X-Received: by 2002:a05:6358:5925:b0:178:f482:6e59 with SMTP id
 g37-20020a056358592500b00178f4826e59mr13277836rwf.3.1708411880357; 
 Mon, 19 Feb 2024 22:51:20 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 u21-20020aa78395000000b006e0ad616be3sm6029019pfm.110.2024.02.19.22.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 22:51:20 -0800 (PST)
Date: Tue, 20 Feb 2024 14:51:09 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V3 07/13] migration: per-mode notifiers
Message-ID: <ZdRL3XzXVUS3tYdT@x1n>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
 <1707418446-134863-8-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1707418446-134863-8-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 08, 2024 at 10:54:00AM -0800, Steve Sistare wrote:
> Keep a separate list of migration notifiers for each migration mode.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


