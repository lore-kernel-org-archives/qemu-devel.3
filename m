Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EC0C71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ5LX-0006cP-Vz; Fri, 13 Jun 2025 10:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ5LW-0006cA-TG
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ5LU-0004CD-IR
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749824726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gJTn+NvgEVXmOaDiTB5Fx6TPuNnbmCPhshaUTh2Pews=;
 b=Mz+gDUQW3OQQrNb5/8wDweEAzTsEsrYK1eZ8XvfWVUs/B0X3g4AAS+y/Xj6IRM/x7LRx+Y
 f1MX+wDwCuskqKolcWZQpkuBmKo5D3TE5g0E3grMiqZ6hE+DlNewE+g9hyuD2Ute+Dd5kt
 rbb94L0VQJvRwHcW09eUinJQDFoLFfg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-y8n1VFm2PzGbnMO8p-atdw-1; Fri, 13 Jun 2025 10:25:25 -0400
X-MC-Unique: y8n1VFm2PzGbnMO8p-atdw-1
X-Mimecast-MFC-AGG-ID: y8n1VFm2PzGbnMO8p-atdw_1749824724
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7caee988153so377456485a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749824724; x=1750429524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJTn+NvgEVXmOaDiTB5Fx6TPuNnbmCPhshaUTh2Pews=;
 b=M7o8toqJIy7mEtj5xr8VRe4iYczjfP9U9+Nflj5n4lGoN6lGZm08ImgU+E9KrOpi3P
 LqAnfWfIbKLOpP06W0XioYK9G/xe3N6rKCl6/RQoCxRSIms6TDHs31nONW3TOSuQeacV
 gM5NVrxu1zBWjtdb57nLDo1y1mJhEVcth/4ZYDScid0BTk+lsXxnRws6LHvIL4T6tBwc
 T3XFUJ+73r12+NMjPwsDeATsXfuVwoY+TXZ8tS9wDMdGTkI3KW6r/8W9VgViTdjYto6m
 LwulmE8+/hZtvv6jlxoNVV8bokmeYTsXkMZLHwa+eWOD8Zy5MEaImIJmUGm+adZJrJU5
 hHqw==
X-Gm-Message-State: AOJu0Yy70eLtND64tMaTh9GTJsq6OvsNLA+UZ985NHoHdZfHIzBuIwxJ
 hXidBA/rFaecSFmc9pt5N0DD6TDBXpQIaWqWqH5uGWiwysYMgte2z2WXdjkJOM0WMHYxMHbvjsQ
 LM8oMVhI6//mYsHDK0yqKr5GwLGDcb2rpkVm7Wq0D0VMkD5S/77rHF9dkDmE2I4SFpZZ2jwCvJ6
 dL2lHaDRS6i3pbQhgNNoFSMeM/W1AB0WUd+IvYYw==
X-Gm-Gg: ASbGnctvGIpxYe38awVBIGEusl2NA7vGZRCeoSx7wpBDBWKmbJiC2GQycYzBGN9vpjf
 UgQFV+MoP2p69bM7fz1mj/w2BSUtUcJk0zb9b4BGoSIQsS+Bkk2ggkF+erD9Fvl+QM+TcbfZwrv
 CadnZUFpshlDllnLUOk4zTEEtiTaj8izt/w0OlC6fP4VCRFPJSyg3JIrfK0sKb3aD6xpwOp4rFj
 tJIh7tdQRN7VXBB+EVb07xINd0z40YCKE84IOtqiZQuy60sI3YcJLR1RDMh1ne4U0rjxLckkaXr
 oOq5wk5r5UlpzQ==
X-Received: by 2002:a05:6214:21e8:b0:6fa:864f:87cc with SMTP id
 6a1803df08f44-6fb3e613ef8mr44550816d6.33.1749824724099; 
 Fri, 13 Jun 2025 07:25:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlBmeLk2dIJCunsiPGqMHwy4r/Kh4m3uuZrhqyTgQ8BcL8XzQJFKluhs/R3AC5u4MIm78mcw==
X-Received: by 2002:a05:6214:c41:b0:6e8:9b52:7a1d with SMTP id
 6a1803df08f44-6fb3e59a035mr50694996d6.8.1749824713065; 
 Fri, 13 Jun 2025 07:25:13 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb35c316e7sm21985976d6.60.2025.06.13.07.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:25:12 -0700 (PDT)
Date: Fri, 13 Jun 2025 10:25:09 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] migration/postcopy: Add latency distribution report for
 blocktime
Message-ID: <aEw0xUO6t_Z44ruM@x1.local>
References: <20250609223607.34387-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250609223607.34387-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jun 09, 2025 at 06:36:07PM -0400, Peter Xu wrote:
> Add the latency distribution too for blocktime, using order-of-two buckets.
> It accounts for all the faults, from either vCPU or non-vCPU threads.  With
> prior rework, it's very easy to achieve by adding an array to account for
> faults in each buckets.
> 
> Sample output for HMP (while for QMP it's simply an array):
> 
> Postcopy Latency Distribution:
>   [     1 us -     2 us ]:          0
>   [     2 us -     4 us ]:          0
>   [     4 us -     8 us ]:          1
>   [     8 us -    16 us ]:          2
>   [    16 us -    32 us ]:          2
>   [    32 us -    64 us ]:          3
>   [    64 us -   128 us ]:      10169
>   [   128 us -   256 us ]:      50151
>   [   256 us -   512 us ]:      12876
>   [   512 us -     1 ms ]:         97
>   [     1 ms -     2 ms ]:         42
>   [     2 ms -     4 ms ]:         44
>   [     4 ms -     8 ms ]:         93
>   [     8 ms -    16 ms ]:        138
>   [    16 ms -    32 ms ]:          0
>   [    32 ms -    65 ms ]:          0
>   [    65 ms -   131 ms ]:          0
>   [   131 ms -   262 ms ]:          0
>   [   262 ms -   524 ms ]:          0
>   [   524 ms -    1 sec ]:          0
>   [    1 sec -    2 sec ]:          0
>   [    2 sec -    4 sec ]:          0
>   [    4 sec -    8 sec ]:          0
>   [    8 sec -   16 sec ]:          0
> 
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Just to keep a record, the new version of this patch is included here:

https://lore.kernel.org/all/20250613141217.474825-15-peterx@redhat.com/

There're trivial changes there, on marking the feature unstable, meanwhile
adjustments to suite the us->ns conversion suggested by Dave.

-- 
Peter Xu


