Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D63DC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 05:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWram-0007Xj-EY; Mon, 05 Feb 2024 00:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWral-0007XK-DW
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 00:32:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWrae-0006eH-UY
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 00:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707111140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cHhGYM5YEeu/08Jhq1OlWNs0XfPN7drojTbc1PyOOU4=;
 b=aUzIlY66fa6zul1dILfPYxH0qFmuH2IDIIfICDIpzs4YklSIDn8epaKzLqpyHAdftld/qU
 Mry6ixEKpcSZd9vDZrrCXwMXv+Q5Do+BjteD9DUCTheRS0NCh4VANRjGyiJ6w6sDGA/2+9
 H9ko5nzqwuz3b3WsomZGdMHK6ets1hQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-VOgAdrlYMwSvkrtir7f9PQ-1; Mon, 05 Feb 2024 00:32:18 -0500
X-MC-Unique: VOgAdrlYMwSvkrtir7f9PQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5ce9b15f4ccso1591930a12.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 21:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707111137; x=1707715937;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cHhGYM5YEeu/08Jhq1OlWNs0XfPN7drojTbc1PyOOU4=;
 b=HmJjVvu+hFcxs+meifgaOOS8F0OdmLJv1gJY3KCkXTB+w8uaGD6AmjA462C93l2ovr
 YJrTCDyuQlEMIRa42yocAngL3HsxGPcnvLHLffZmI4LgORNTlY96HSJQhe5Ci2cxAnc2
 iTogFPApTQfodRhXG6G+wwwbk8B92VtGTzoZjjZpeWARU68CiNYKKOfSZGqhFIYB64UW
 bIx63vJIm/p+2/m20RoVTl7cRNy55Snubx7GnO+FfjL6S7vWRePa/FQ34DZvZt81wmyv
 Fh23uA1fbQXglMV+rtCF82y8sYfBa/qCNVPEl1CYoYZCr3Tq3KWEThgkgrw1Kq9HwfGG
 OYeQ==
X-Gm-Message-State: AOJu0YxbMpj5cc2uuoTevRT5MxzgsdWLRqYy5FZgzgHhGSKAzaVEaf+I
 JLGW6NGl5PSbkMIbLhcHrP0B1dezRgE0TXHF9eGzAkslCfeZcb6cio38+G2oJOuEdOkfPSAAvKc
 aKzkCXc2fjiYWySR0pqtxVtalXvDSC+5Du5Dp/ku2DvhG1fI+dMHP/4L9toOqP2E=
X-Received: by 2002:a17:902:e812:b0:1d9:3411:b10f with SMTP id
 u18-20020a170902e81200b001d93411b10fmr15840022plg.0.1707111137145; 
 Sun, 04 Feb 2024 21:32:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEP84185gVBr4YMtSIMO6zlrya22ON60j2OygkRpUoSisPvkXGpsQD74ctoRSB+I54CdgPuxg==
X-Received: by 2002:a17:902:e812:b0:1d9:3411:b10f with SMTP id
 u18-20020a170902e81200b001d93411b10fmr15840009plg.0.1707111136804; 
 Sun, 04 Feb 2024 21:32:16 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU3oMWLHaD5BfeoOso1LDlLeNsyNAa2JEjUvLOEU5d/SJPngofgco/6KETzTs++nVQ1O8iOHNO1H0rwaXxyU4O7pEk=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 mq3-20020a170902fd4300b001d7273e380fsm5397129plb.153.2024.02.04.21.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 21:32:16 -0800 (PST)
Date: Mon, 5 Feb 2024 13:32:07 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH 1/5] migration/multifd: Join the TLS thread
Message-ID: <ZcBy1wSZTp1A1wKD@x1n>
References: <20240202191128.1901-1-farosas@suse.de>
 <20240202191128.1901-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202191128.1901-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Feb 02, 2024 at 04:11:24PM -0300, Fabiano Rosas wrote:
> We're currently leaking the resources of the TLS thread by not joining
> it and also overwriting the p->thread pointer altogether.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

Does this deserve below?

Fixes: a1af605bd5 ("migration/multifd: fix hangup with TLS-Multifd due to blocking handshake")
Cc: qemu-stable <qemu-stable@nongnu.org>

-- 
Peter Xu


