Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F381CC41513
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPkwP-0004jm-2A; Fri, 05 Jul 2024 11:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPkwK-0004Yf-Ml
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPkwI-0000hC-SM
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720193612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xk3vA0U4TENu6hHY5znsH0smcSS/zwl30tPzqtEmqLQ=;
 b=OAP6i0GOtpzIPGPS+oaPGIcFUBBznAdLQGFb27J/ZJi5oVjRhbZjN7Y8m+P80efJvfkoS0
 pLe/tdgkm+yr2a6aMHow4EFg55HdfMAk2NNP0Mdn2DCEG2T6PRj+2T8Cxsw50yOQnWPmQY
 4QCoTtr0skJcOJbrON9CV3fdrZ/klhU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-cwTPFDKEP_uqDqc9rsXFtg-1; Fri, 05 Jul 2024 11:33:29 -0400
X-MC-Unique: cwTPFDKEP_uqDqc9rsXFtg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4264dc624a5so8847005e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193608; x=1720798408;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xk3vA0U4TENu6hHY5znsH0smcSS/zwl30tPzqtEmqLQ=;
 b=hE7e2wETrJo40P6hitn48C8P9jH8cI8XwYZQRvTzfae8ZVR9VNlFlTTua9hc3o4gVu
 vJjV/WHv477SWaVheCj9r0iANe+ACIifQI/OucoAuRBky7py2G0JFmgIbDmVSM+x3cVi
 DJ/IVjxagJSR1XUInOcCEDQy8Xsu4vkBKkXcdeAemOi15ZsE0BJVddweKvX2eSZKMXSo
 jRCVYy6o3+NRNbAvg71UJDUQvvWeP8W0H9nBL+qFC27lzecx7NeLgt5fMraQJwEzqmop
 hN3VnJXMDE6eoLSOTRDDSiICUDsyvQkqxbrPAVLQcXFtnJrM5zwP/H6zsNqlMXtKTm5H
 lObQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhnNrQQ8+YshAZ5/n0oW7KjeCp2VWJwmx+FGyqleIb3XV57vTxAouhgvIqrjcwUgxHi3u/M5iDt62bplyXFrDr6nSYMj8=
X-Gm-Message-State: AOJu0YzSW2hGPmIdEAauFuflCc6DYrtrReYJ7562cvvvBmUdeCpp8AHV
 zq6q2VTtXQ1tV6SoIwEq9+PDEBn6v/nEdIteemWGRBHYG04i2Lulg1B4zSopl/N0hYTiWgMRp1e
 wzzbdkmPqjrAUFxq+G9UWLBgoW1JyoLzfM27hg1JDH0SaWjqIG7uaKfS0NiJD
X-Received: by 2002:a05:600c:21a:b0:425:641c:5f46 with SMTP id
 5b1f17b1804b1-4264a44d471mr36436535e9.30.1720193608271; 
 Fri, 05 Jul 2024 08:33:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtdKXd8/CP3N7qb/hRC9Hkxy2F8mTsiesjF9q3KZ/RvBiX2LLTl/ksw+yE/wGILJW43af7+Q==
X-Received: by 2002:a05:600c:21a:b0:425:641c:5f46 with SMTP id
 5b1f17b1804b1-4264a44d471mr36436245e9.30.1720193607517; 
 Fri, 05 Jul 2024 08:33:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:1b5b:ac5c:b82e:a18c:2c6e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d50b0sm66990645e9.7.2024.07.05.08.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:33:26 -0700 (PDT)
Date: Fri, 5 Jul 2024 11:33:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org, fan.ni@samsung.com,
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <nifan.cxl@gmail.com>,
 linuxarm@huawei.com
Subject: Re: [PATCH v4 1/1] hw/cxl: Support firmware updates
Message-ID: <20240705113248-mutt-send-email-mst@kernel.org>
References: <20240705125915.991672-1-Jonathan.Cameron@huawei.com>
 <20240705125915.991672-2-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705125915.991672-2-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


just a small request, pls use same prefix for all patches in
the series including the cover letter.


