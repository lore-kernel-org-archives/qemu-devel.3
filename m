Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9454BC5AD44
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 18:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtUp3-0004gf-Au; Fri, 20 Feb 2026 13:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtUp2-0004gD-4i
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 13:01:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtUox-0007xG-ML
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 13:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771610500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZAQPeXFQm8RDIHKLfz4DTbpYv2PDHYFhsab6Epr4x4I=;
 b=FiuZ23mRfknVv/5iusFsgz5xz0HFJ09uoF2edzQG+aeYWw+nNZKIb6DP0/K3wM8dRSD9ye
 Fx35EjITU6Sra2O83LY6PdcXb7PLsD2AIggr+f2CNQQHmPctftfWDtIk9XeoQ5CjONlUgt
 AuIEZCzmvtasUZHwXjQGLGsqowiZJ7I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-_j-LF8KcPxO3l1RGcuoXLQ-1; Fri, 20 Feb 2026 13:01:34 -0500
X-MC-Unique: _j-LF8KcPxO3l1RGcuoXLQ-1
X-Mimecast-MFC-AGG-ID: _j-LF8KcPxO3l1RGcuoXLQ_1771610493
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4376b624589so1378480f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 10:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771610493; x=1772215293; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZAQPeXFQm8RDIHKLfz4DTbpYv2PDHYFhsab6Epr4x4I=;
 b=GwWldJrGP+xkktnb8pM13O/Nbg3M32xeBm4vwgqGYvtGOXNa9ESg0ukXLjzLjoS9sk
 z96MgJjBuy+j4b1nHwF0qUdzWKCCkp0C+8/Qxu8ioX4sg6NF/ICB5LCyDX1qfFcSaNuu
 bzVJO3iqFi0zVthSuX+X95VLu0mcbr6igY8lsQvsjWjlIIKBK1bXnWh/Gq9ucTLvKBfH
 dTcVnABOAySLcHd6d0MgeXWLTDsk3JbNFU49NccvSmdkvL0FAFhdzY6EfVbehuus0l1a
 5ocq/Kbm25zkohFwT3SMN0FMcFkmItaZDBRp4sQdDO7zajbjudPzLz7vmThu1ShlB0nZ
 /aVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771610493; x=1772215293;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZAQPeXFQm8RDIHKLfz4DTbpYv2PDHYFhsab6Epr4x4I=;
 b=eI9BlhX4ewKOzKg3Fpgl6YD5uZr2tmqmtMPRjQUXd5vhiKIH8jJiD7lGbho5a2VNzV
 fwxpqngZazZZqhE5EKVBdjIBUhmQ03OudKbPtPxf50ZKePmLVmq4ZvazoDiyncrrMuuL
 +ayL8ZMzKc7DFjt/fIqzoxPtYsOWosFdWmYPRhfQrMGp31XNd2y3YRAvals8KAzW5qt2
 r1MT+e4iRA0rALQfqaAofOBKyyHNq9thQONsUtf387hO6dQKXBDu9E8sqPXiTUpwlkz0
 PTbfawPn8jVKPavDRHiUFj/nJuP88vmiHHEx+VMa/8DFvSkW3fW6qRLrIfbRjeSJ7/3h
 fEyg==
X-Gm-Message-State: AOJu0YxsTD2WvTAKfumAfTx3HmEOganMb8sdbr/AVZ1RrFMh9lG84qXS
 JJqcqiGK7t5i9hs8Ytz49TI65jSbvRVz7KcGehLvvbqXZcIfQr0cTta4tjllNdrsp8H6vN8kz/7
 R80noO/vzFKP2r9e1T+6Fe6uWQKtPCdBKI5hLvqRL9cd+cUQj9cqKT4rm
X-Gm-Gg: AZuq6aLDvTTiXV9KnGLAV7qQmfeCg6tAlh36uLAc3mcCNS28nVjr50s5hPXD5tTkydi
 ze45XUoP0XMoxIGr/Sl9PgTUUmfs6l2d+/Wtd64eti9aNk0A8bpYp2cGM60w3s4wNubZQAVBSED
 r/OHEc08m7RTmGb3GwcXygNigvokTKcMX0ysS3KKA92GVUXGM7NJaGh9rNVq0xfCV4LbqXXNr1l
 kLwHV9z4rR9jlfG4cEICSHMZ5BP7hS08oarF0or4MNYElNz9NO01Orv41RQUaHV+DYyV9ZgFahb
 bNyAt1vsq5t3F46vLj0q87Sl/tV37xVd8taLwmbPz1W+0lhI3XHGu6GWqO6oUuXCAceE/kVaXCj
 Dhln3nI5uv0gnzdax9GnKk9GxiVpZir5hOs0TeZlor7gKDw==
X-Received: by 2002:a05:6000:24c9:b0:435:bbd7:18e1 with SMTP id
 ffacd0b85a97d-4396f16e418mr1283263f8f.9.1771610492749; 
 Fri, 20 Feb 2026 10:01:32 -0800 (PST)
X-Received: by 2002:a05:6000:24c9:b0:435:bbd7:18e1 with SMTP id
 ffacd0b85a97d-4396f16e418mr1283187f8f.9.1771610492178; 
 Fri, 20 Feb 2026 10:01:32 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5b07fsm58961318f8f.2.2026.02.20.10.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 10:01:31 -0800 (PST)
Date: Fri, 20 Feb 2026 13:01:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v2 09/13] scripts/ghes_inject: add a handler for
 PCI/PCI-X bus error
Message-ID: <20260220130034-mutt-send-email-mst@kernel.org>
References: <cover.1769175069.git.mchehab+huawei@kernel.org>
 <35c61dd959e8d2687fa282c44471a9de5ef50ad5.1769175070.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35c61dd959e8d2687fa282c44471a9de5ef50ad5.1769175070.git.mchehab+huawei@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 23, 2026 at 02:35:23PM +0100, Mauro Carvalho Chehab wrote:
> diff --git a/scripts/pci_bus_error.py b/scripts/pci_bus_error.py
> new file mode 100644
> index 000000000000..5abfdf11c868
> --- /dev/null
> +++ b/scripts/pci_bus_error.py
> @@ -0,0 +1,146 @@
> +#!/usr/bin/env python3
> +#
> +# pylint: disable=C0114,R0903
> +# SPDX-License-Identifier: GPL-2.0

GPL-2.0-or-later for qemu, please.

Or if there's a reason it's 2.0 only, pls document it.

-- 
MST


