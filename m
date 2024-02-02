Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AFDC47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 03:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVkgt-0006oG-Qm; Thu, 01 Feb 2024 22:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVkgs-0006n8-FU
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 22:58:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVkgq-0001Wj-69
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 22:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706846286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J4SSsFO6axNLWYmnSBFmsWmOiH8znU0S8a0VQkBmW+o=;
 b=VlzmbpRD4vl0ItOoEordPj2g9l6rgwVYAsmUAX2xRM/EQjYGAXpXY/FWh2zpb821JU+Cy4
 EjEDchBno/bsTMiOyilg05IzeAVZmvNhmJ953hMUVIu2J4LasDpEHYbQvQ2igF0AtRHZi7
 c35AtCP7AyQQT6kWxaeUzXguZ08VTrQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-X7ziBIZFPWW6ROuWW-YwEA-1; Thu, 01 Feb 2024 22:58:04 -0500
X-MC-Unique: X7ziBIZFPWW6ROuWW-YwEA-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d95551c141so636325ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 19:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706846283; x=1707451083;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J4SSsFO6axNLWYmnSBFmsWmOiH8znU0S8a0VQkBmW+o=;
 b=rUgssZirPoJRB3AplBXDcfLXdrkju8JH83aYcWFwebrpO0fbp+4U7Z/h1qJh1jLvT+
 i3jA+dvmmP2EV0P9Nz/TXrrfqB45G/RSXeC2UyS0jIPV5f8NoBZfRfCFGLkuSRYlMzg/
 Pu0b5Z93pR0AMMNf0x0S4SRnfaP90FwBZINXlgSAIyx31LuWn7yf5VWt/OPTnvvp27Ah
 rMFsx/u9KBAXUmeXvoc7xBvXXG8fZrMfODoWSV1oVmqG10B2KCXQqlvYHsM05ed6zYpP
 inCJLuVti4bCHeMXAMAkLEqKq9jpfL/rDDURE02y6sZX81T7DlbQdjYqirP9QkU5cWNO
 5w/A==
X-Gm-Message-State: AOJu0YxciEZWi3bV4j1iK0HGfeUXq7CTtYSTTadrinbvQVcY5yH5kuUh
 TbIrALCF5qGXGfRan4J/vHE2zK83iJ/SNk0tX29fC0xTKaHWcCU2k7GCx3XMWkSTGaNMIubi+P8
 4oZCtP/0GeO8WQaOYfY4bwJH9MWhO2Cz7nw+eC2veZ1gwEYJPy/nM5lig6q1GwptFOWD2EFO/4c
 KJerpoYlo1oJ9jY4syZMMIekUPQnHizbZwEclg
X-Received: by 2002:a17:902:7289:b0:1d7:1480:6538 with SMTP id
 d9-20020a170902728900b001d714806538mr4882003pll.1.1706846283292; 
 Thu, 01 Feb 2024 19:58:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4O4v/9VoaRikm754qeiGpVqrFg3YUn6b9NEiWHQ9qyWgSy/Ql1r2DmNTgKynn46mAJKisgg==
X-Received: by 2002:a17:902:7289:b0:1d7:1480:6538 with SMTP id
 d9-20020a170902728900b001d714806538mr4881986pll.1.1706846282838; 
 Thu, 01 Feb 2024 19:58:02 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV3UCK3U8ofiJlx8olfY/OyPHPXC4X+Yu5LM/gsbLl0yUUnXEchFJeEP8djUt716HBOyQ83oa2b4IdDG565/FNG9JdNC5Ym86CrsrMYSaqeL13ylT+JsRpxEVrHy8HMnhdKPPLdx7z8iIZ+3Obq5k/Y10xV4twYOAHTNBoRRHphyj5qO+ZgwnB1jm5jqlQr7NwYsGcT1w==
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 l5-20020a170902e2c500b001d974ffa1fcsm67008plc.173.2024.02.01.19.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 19:58:02 -0800 (PST)
Date: Fri, 2 Feb 2024 11:57:53 +0800
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bryan Zhang <bryan.zhang@bytedance.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Yuan Liu <yuan1.liu@intel.com>, Avihai Horon <avihaih@nvidia.com>,
 Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 13/14] migration/multifd: Move header prepare/fill into
 send_prepare()
Message-ID: <ZbxoQbQcCFT8QISB@x1n>
References: <20240131103111.306523-1-peterx@redhat.com>
 <20240131103111.306523-14-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240131103111.306523-14-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
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

On Wed, Jan 31, 2024 at 06:31:10PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> This patch redefines the interfacing of ->send_prepare().  It further
> simplifies multifd_send_thread() especially on zero copy.
> 
> Now with the new interface, we require the hook to do all the work for
> preparing the IOVs to send.  After it's completed, the IOVs should be ready
> to be dumped into the specific multifd QIOChannel later.
> 
> So now the API looks like:
> 
>   p->pages ----------->  send_prepare() -------------> IOVs
> 
> This also prepares for the case where the input can be extended to even not
> any p->pages.  But that's for later.
> 
> This patch will achieve similar goal of what Fabiano used to propose here:
> 
> https://lore.kernel.org/r/20240126221943.26628-1-farosas@suse.de
> 
> However the send() interface may not be necessary.  I'm boldly attaching a
> "Co-developed-by" for Fabiano.
> 
> Co-developed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Just a heads-up: I plan to squash something like below also into it.
That's mostly Fabiano's:

https://lore.kernel.org/r/20240126221943.26628-6-farosas@suse.de

But instead of overwritting write_flags in the hook, I made it a
conditional "OR" just in case we'll extend write_flags later in common
paths and get it overlooked.

In short, I'll keep all zerocopy changes together in this single patch,
hopefully clearer.

=====
diff --git a/migration/multifd.c b/migration/multifd.c
index cd4467aff4..6aa44340de 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -50,15 +50,15 @@ typedef struct {
 /**
  * nocomp_send_setup: setup send side
  *
- * For no compression this function does nothing.
- *
- * Returns 0 for success or -1 for error
- *
  * @p: Params for the channel that we are using
  * @errp: pointer to an error
  */
 static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
 {
+    if (migrate_zero_copy_send()) {
+        p->write_flags |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
+    }
+
     return 0;
 }

-- 
Peter Xu


