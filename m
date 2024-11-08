Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB168D64085
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 19:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9V6U-0004hv-S1; Fri, 08 Nov 2024 14:57:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1t9V6T-0004ha-ES
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 14:57:09 -0500
Received: from esa9.hc2706-39.iphmx.com ([216.71.140.197])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1t9V6Q-0006no-A8
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 14:57:09 -0500
X-CSE-ConnectionGUID: w8o5dGUjRVqKa+2hhrySWw==
X-CSE-MsgGUID: 7nY2lTSfQtqAWIlzNtLraw==
X-IronPort-RemoteIP: 209.85.219.197
X-IronPort-MID: 1225091
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:4dtePa1MJyoLdfs6mfbD5Zpwkn2cJEfYwER7XKvMYLTBsI5bpzUGz
 GZNWzvSa63bYmqjeNx0Ydy/9EtQvJeBzNIwQAY4qSg9HnlHl5H5CIXCJC8cHc8zwu4v7q5Dx
 59DAjUVBJlsFhcwnj/0b/686yA6jfzVLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtH8CA6W0
 T/Ii5S31GSNhXgtaAr414rZ8Ekz5a2q6GtC1rADTasjUGH2xiF94K03ePnZw0vQGuF8AuO8T
 uDf+7C1lkux1wstEN6sjoHgeUQMRLPIVSDW4paBc/H/6vTqjnVaPpcTbZLwW28O49m6t4kZJ
 OF2iHCFYVxB0psgOQgqe0Iw/ylWZcWq8VJcSJS1mZX7I0buKhMAzxjyZa2f0EJxFutfWAlzG
 fIkxD8lcUCE2u6Z/bCBdPBPj4d5LMnxLbggpSQ1pd3ZJa5OrZHrRqzL4ZpJ1m51iJkfQrDRY
 M0WbTcpZxPFC/FNEg1PWdRuwaHy3yi5KmwHwL6WjfNfD2z7xQhh1rT3GNDIPNGGWK25m27B/
 DibpzWgav0cHIOZ+GCBzkmiv/PWtBzaXJA0CJmi/+E/1TV/wURWUnX6T2CTuPS8lwuyVsxSL
 2QS/Swhq7V081akJuQRRDW9qX+A+w8WAp9eSrxlrg6KzaXQ7kCSAW1soiN9VeHKffQeHVQCv
 mJlVfuzbdCzmNV5kU6gy4o=
IronPort-HdrOrdr: A9a23:M5jRUK7UU9/da3wVsAPXwB7XdLJyesId70hD6qm+c20zTiW9rb
 HSoB17726PtN91YhsdcL+7Scu9qB/nhPtICMwqTMuftWrdyRCVxeNZnPLfKlTbckWUh41gPO
 VbAtBD4bXLbWSS5vyKhjVQfexQpOWvweSDqd2b4U1QbTxHXYld0iYRMHflLqS0fmV77FgCea
 Z0KvAom9NoQxt3UviG
X-Talos-CUID: 9a23:whcYCGO0xlNyy+5DR3lgqUI7J8IfTGT+xTSKI0+iGF1WV+jA
X-Talos-MUID: =?us-ascii?q?9a23=3A8EhmbA3fx+1hK1sPuh9cBXOPWzUjvKKfUkQxqps?=
 =?us-ascii?q?/p9CtCg10KRGBqC6+Xdpy?=
Received: from mail-yb1-f197.google.com ([209.85.219.197])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 08 Nov 2024 14:56:59 -0500
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e292dbfd834so4325415276.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 11:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1731095819; x=1731700619; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0chQvMThWyaxeCith/prFLKev4AC3C8GIs9Ma8pG/UY=;
 b=eAnpHb14z6QUQHv7zKrKjvRnwU6hyPr9UR38dN12NXkwGNWtn4YhBXXysJNptXnp5R
 gTtTw3fpOrFl/uDAcyVu/Mb3yFC4BnDELd32J0OZLmJwJPgwAYbjgTXbMrHyt3kF0tr0
 w8GjpRwD8G147TVCRPLS54NVkXzZ+bRMPQOIiPf2JqBcb6GUT8eRUyVk6RCv6L6k5FUP
 rttbq7HuLb5iCvV8gvKgScKptCwr9Nvg9khLZfxUNPj38iUuAKK/3E671wSbvZU0c4up
 s0Wc9cpNB833FeHdKoMx2flh8JGFVsBvDm9A4KVbt3pLx3FgQUehOmDJJl0jRklaLUOB
 0Zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731095819; x=1731700619;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0chQvMThWyaxeCith/prFLKev4AC3C8GIs9Ma8pG/UY=;
 b=eb+prgKwXt3LP9KSIiKFbGZA4L7tYgjNCj0TaOhW6723C8t+hT5RkxcnYEaQDWOeRA
 UsjwkdzaM6jsY9g57Z6spds1obk9Je7q9gjYJnzLQJvcoRgRMg4/ZLTsIaPtxdIkkE8n
 cENcYCXOJvuTWh46goS1yn0t1qn6zNi675e37Wt3wOdYUy5ufHnFIvqPVxYREUXZj71J
 yPxIdG77qednwGc8bT+Qy4XQDo7t3RzZn7niq1daTRti7h8K+71dDWocxH8njKbJJuGv
 KZ5n8XYgOYZzP/qeiahCOueDhXywVTST24qCIPxnDT+0Eb4GzM7DqKASi2Xb5gDgsNi9
 KnRQ==
X-Gm-Message-State: AOJu0Yy712gsjlEDvR2FSI3g2h6MhcslBU7Si4MFEtBaHPW8fFMS/lEW
 nGQhg3R20ZK0VXTulCiJt7qfohhKoaYhsZyKMiu/ea67vTb2VGRUbmmN4Arjh+0Ed89EsSlk8DD
 5fKaX2YRudEsn4UcXsndh1wXyPScxREKIKqYYcXIF/rCW4DpHCDRr2Ov2MNqkIQC1kndBRMXyGQ
 lA
X-Received: by 2002:a05:6902:150b:b0:e22:6a94:f22f with SMTP id
 3f1490d57ef6-e337f8815bfmr5030151276.28.1731095819129; 
 Fri, 08 Nov 2024 11:56:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCo+4zgW+ssKLTH38u75C9ow4lM6M0YBi83Dq6SpEtF5kWJwSSNcQEy9ZbytIPmjo0azAEMQ==
X-Received: by 2002:a05:6902:150b:b0:e22:6a94:f22f with SMTP id
 3f1490d57ef6-e337f8815bfmr5030128276.28.1731095818798; 
 Fri, 08 Nov 2024 11:56:58 -0800 (PST)
Received: from bos-mail01.vrmnet (pool-173-48-150-109.bstnma.fios.verizon.net.
 [173.48.150.109]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ff3eca49sm23841961cf.6.2024.11.08.11.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 11:56:58 -0800 (PST)
Date: Fri, 8 Nov 2024 14:56:53 -0500
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 Philippe Mathieu-Daud?? <philmd@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Bandan Das <bsd@redhat.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>, 
 Bin Meng <bin.meng@windriver.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "Daniel P . Berrang??" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Jon Maloy <jmaloy@redhat.com>, Siqi Chen <coc.cyqh@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v10 0/8] memory: prevent dma-reentracy issues
Message-ID: <jsmj5q7adyvvkuvspny4xxvfczdsrxfbjqt4irattz3gfrrhfh@bmpvza45wkze>
References: <20230427211013.2994127-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427211013.2994127-1-alxndr@bu.edu>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.140.197; envelope-from=alxndr@bu.edu;
 helo=esa9.hc2706-39.iphmx.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 230427 1710, Alexander Bulekov wrote:

<snip>
> These patches aim to solve two types of DMA-reentrancy issues:
> 
> 1.) mmio -> dma -> mmio case
> To solve this, we track whether the device is engaged in io by
> checking/setting a reentrancy-guard within APIs used for MMIO access.
> 
> 2.) bh -> dma write -> mmio case
> This case is trickier, since we dont have a generic way to associate a
> bh with the underlying Device/DeviceState. Thus, this version allows a
> device to associate a reentrancy-guard with a bh, when creating it.
> (Instead of calling qemu_bh_new, you call qemu_bh_new_guarded)
<snip>

Later on there was also a guard added by Akihiko Odaki for
network-backends.
7d0fefdf81f: net: Provide MemReentrancyGuard * to qemu_new_nic()

Recently a talk came out about re-entrancy bugs in qemu
(unfortuantely I could not find a non-video version of the slides):
https://www.youtube.com/watch?v=wL3LK9Dp4os

The talk gives an overview of these bugs and also demonstrates how they
can be used for VM escapes. It lists the following vectors:
 1. MMIO
 2. Bottom-Halves
 3. Netqueues
 4. IOEventfd
 5. Timers

The first three should be covered by the current defenses. However,
afaik IOEventfds and Timers are still unprotected. The talk demonstates
an attack via IOEventFd, but not one with timers. In any case, it might
make sense to revist the guard to ensure that we are covering all types
of code that perform DMA.

