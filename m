Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91882F364A6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAtNG-0005rh-FR; Thu, 09 Apr 2026 13:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAtNF-0005rQ-37
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:41:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAtND-0000s9-4A
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775756458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VywX1/inGwzjM3jfa9kpvzZzXkHCnrCsZrzg3SS6GF8=;
 b=iEJRJCSdztzbPovTG/xXeaNPV6F4CSkAln2y7kJUQVP3mhLWAzi/nqwVbvZ4asgZoyFng2
 h+n3FCEewCk8QiWPusiSJb3EcOSKey8NEoxLATQKd6GP+11Xz+fSlrT/GyvBE9jfGGT0ga
 3AoABpyRS8r7b0UavMtkH01WgVoGXAI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-ephMG4EnN9aUWdvXxkgsYA-1; Thu, 09 Apr 2026 13:40:56 -0400
X-MC-Unique: ephMG4EnN9aUWdvXxkgsYA-1
X-Mimecast-MFC-AGG-ID: ephMG4EnN9aUWdvXxkgsYA_1775756455
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso9148175e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775756455; x=1776361255; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VywX1/inGwzjM3jfa9kpvzZzXkHCnrCsZrzg3SS6GF8=;
 b=f5JOD90TYf9iAgICzjkLls62FMsXlCeGbPoSBs7dtcaiSXc2RrwamL151Fv7N5BINa
 XbZMktDUYB5VbOQYXbwzDsoSA+V2AbX7IH8SyJBi296ifS/7pVBfoivRrWa5AjAHGKSR
 SkeF/zzUv7PaDva8Q2ycg3c3t1iXD9Dy5Yjw7ePsAWsQX5ChIvNj0njIbbDkxDyPyqkZ
 SfZhZpYFcyK6X3NsITyY+ydMXIf8g+ySPR3VMFHFfIaJRLMad5so7JU/CV/1BkQ2zpor
 +SgSNs69AKT2MSwjO9fBK3YqY2fbXgRVsBpR7GffYCKv7XLWFM45U8lCUWlkS1vg9yZw
 gU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775756455; x=1776361255;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VywX1/inGwzjM3jfa9kpvzZzXkHCnrCsZrzg3SS6GF8=;
 b=c91Qt+Xuas440rgendsJ91bROpMxoy5fZRhN+fOaBvQloaw7Gp1NvgsVANdb1rQmcj
 GmNzwM/Npxhxf6IjlcwClIgrYYhIACZcWy2zosJRh/IiCZkBD+N3Tix8suAMzV2DzrY1
 nICmgMsWvLB54l2YSFFmxMyMQ3gS0FHjDXziAq3rK9Hxiv24yeR2399v+yWMTtTiMlcN
 fJ6XuhzRAOvTWLOYyUvXiEOKVW6Wqhx3kZbZQhhSplWpEw2Nnx8PmPtDKz1p39sWKzPB
 gsZvjsYLtRFARHVViBl441XrNEkLRdj0QzqrUsiLKmXyNpleFpZYsfLP6Jil8N6ZleVm
 fbpA==
X-Gm-Message-State: AOJu0Yw/28mtCov9LOpZJYkjrx++OFX6oQGzYqB/oiKEYryxXzBCjoXR
 lrjMPWeVSZcM1aFLKO5pXoeX5PYL10PTTq9dC0+neZQg9duJaeAa9DOKHqtj2lcujG2ns/maAmq
 dvg4i7Aubt79NgBRsdkbx+x7fHsNapO7jUqpxtDqFb/oiZ6pCGe+UuUCn
X-Gm-Gg: AeBDietcVPT6Wi4V90g7iFSoq9HlSIMm/xaRsCezGEgr0ovt2ViY6efdoJJAYs3TeOn
 lvxcEBC4oRcXAaVVEqPmxFcnuk+GMkXrIWPuQE/Niin9r1Sw3OjjDCzk4BAznj+qF1/K3Q/E6DO
 9nDIdj5Np+SU8yl334zTtWgH6128Pe+iLRzOjVxZW+FHCcS7xAlCOlv4szdI1odizBANcijfd2G
 6CQezX4pLxM42aIYS/qGtoKhqO+DBqqK0mAl7kGUZSS/owCFD8QKUW+3rdKX/bhNnGJpOyXezgM
 /iTAUgDyE+V60mUB/gjksVNujPQXJJFw2GOTbjbOuRfYmCcs3PCqXLYI8T9DLTFOwUgODX+99tx
 yDCAZs/YUOq2vAUQYeppSDrgvRo3C3lDD2OMOTUs=
X-Received: by 2002:a05:600c:8b28:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-488cd0201d5mr75192515e9.16.1775756455287; 
 Thu, 09 Apr 2026 10:40:55 -0700 (PDT)
X-Received: by 2002:a05:600c:8b28:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-488cd0201d5mr75192055e9.16.1775756454784; 
 Thu, 09 Apr 2026 10:40:54 -0700 (PDT)
Received: from fedora (nat-88-212-17-233.antik.sk. [88.212.17.233])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cd1a028esm28072185e9.35.2026.04.09.10.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 10:40:53 -0700 (PDT)
Date: Thu, 9 Apr 2026 19:40:51 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Zhiyi Guo <zhguo@redhat.com>, Prasad Pandit <ppandit@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Joao Martins <joao.m.martins@oracle.com>, Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 14/14] migration/qapi: Update unit for
 avail-switchover-bandwidth
Message-ID: <adfkjgIqMGCQeIRg@fedora>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-15-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408165559.157108-15-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2026-04-08 12:55, Peter Xu wrote:
> Add ", in bytes per second".  Unfortunately indentations need to be updated
> completely, but no change on the rest.
> 
> Cc: Markus Armbruster <armbru@redhat.com>
> Suggested-by: Juraj Marcin <jmarcin@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi/migration.json | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index a6e24b5685..b7518b29c6 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -921,15 +921,15 @@
>  #     (Since 2.8)
>  #
>  # @avail-switchover-bandwidth: to set the available bandwidth that
> -#     migration can use during switchover phase.  **Note:** this does
> -#     not limit the bandwidth during switchover, but only for
> -#     calculations when making decisions to switchover.  By default,
> -#     this value is zero, which means QEMU will estimate the bandwidth
> -#     automatically.  This can be set when the estimated value is not
> -#     accurate, while the user is able to guarantee such bandwidth is
> -#     available when switching over.  When specified correctly, this
> -#     can make the switchover decision much more accurate.
> -#     (Since 8.2)
> +#     migration can use during switchover phase, in bytes per
> +#     second.  **Note:** this does not limit the bandwidth during
> +#     switchover, but only for calculations when making decisions to
> +#     switchover.  By default, this value is zero, which means QEMU
> +#     will estimate the bandwidth automatically.  This can be set
> +#     when the estimated value is not accurate, while the user is
> +#     able to guarantee such bandwidth is available when switching
> +#     over.  When specified correctly, this can make the switchover
> +#     decision much more accurate.  (Since 8.2)
>  #
>  # @downtime-limit: set maximum tolerated downtime for migration.
>  #     maximum downtime in milliseconds (Since 2.8)
> -- 
> 2.53.0
>

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


