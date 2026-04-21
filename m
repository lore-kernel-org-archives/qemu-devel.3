Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0ACAF8FA78
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 14:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFBxy-0005Wl-IJ; Tue, 21 Apr 2026 10:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFBxs-0005TK-Nv
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 10:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFBxq-0006mi-JZ
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 10:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776781231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BJ2ToIKdvbBCYgT9pPnKdxV3OJLuZOOmsWL1WoKhy88=;
 b=MR+XqnnRKCbdEx9lfKDv+Jbc6sXoQxUdKmQMDlbbioDVyniKNPV3Ns20nOk8tVy7hJ+mIq
 zC9Hx7gtHKcYbQNb2DlMhyHQmCpxv1o5otsFphjnAsDoc1+v7NUD8Y4F2FO1D9jDE62ecN
 UQfEsgR099+veWWHLKhjJyNbjiu4kvk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-m_X7YhvRNpmm-zOAo_8Dcw-1; Tue, 21 Apr 2026 10:20:26 -0400
X-MC-Unique: m_X7YhvRNpmm-zOAo_8Dcw-1
X-Mimecast-MFC-AGG-ID: m_X7YhvRNpmm-zOAo_8Dcw_1776781225
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50e2592ea3bso47904301cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 07:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776781225; x=1777386025; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BJ2ToIKdvbBCYgT9pPnKdxV3OJLuZOOmsWL1WoKhy88=;
 b=YSNFjnzXCVxde3/B17HzxtfBwtm1WTIKrvk2FCfzTgIa8agcIaajiUAQZsuxw75P3+
 xO2enUJgraeHmSmUNIOglRL8y50lDEpOrNU8mJSaqUXYwaDrMVYdU1L6hSvnVmROjcPF
 dVwKvCZk0kXcQsyqOYy3XTP/GF8rnm26p9/Q0Zpor+92rzPK2ibjgd3iwEA7DSunYILF
 2bIgd/iedbRhgqpFXzBMuiHkkJc6ATIMqs98fssQYDUmHBMacRVzkFo8SAZRKQh9vHU0
 yevaHiHUlcg3LTFO/HbcY1FEOpVzmQ5aPzc0fSA+aCigVpNI6cQB9lAHX5em9497ruA/
 L+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776781225; x=1777386025;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BJ2ToIKdvbBCYgT9pPnKdxV3OJLuZOOmsWL1WoKhy88=;
 b=QoPJMvMaZWG8ry0OVUPNU7LJlEKhrrXusGXPBE+LBCNlySMFKuYIssc5Fwe5xYSRNT
 uiM9azxjRlgN0rOFgN4MA0vMOr0vA6z6gY0aW5gqwIa99yoIgztUSFwG4lI0PNo8WJTD
 nN1SOe226YvamSKA+7rcnZTwxjpM6IuODfEYDwJyipZEdN6/GHqPD0YG1BE0yXEkTKX3
 eWPLteQ02f0gmD1y3eVJR/+LilQnjfbH5QC7a7uTrVlYOhovwAwLciqHjnS6WiTaWA5b
 9hRtE3NQnU3naKJrxbQmAKr7gUWHYYX7HI9w/aKq/IOfNzYzuu2iORX9p6xkfrOPPmB8
 jdSQ==
X-Gm-Message-State: AOJu0Yz+Q5bAn/KhaCnGwTsJ1UD3GajIGTI8CyBCfWTGiKIDDyewDz14
 NORJmXjjgsEcDwLmwliM/w8DSCmOPe0Goz6iLbNNk0+lIJQZKBAlRrcuV9LV9Nj080j95/+n1os
 1Fhnw5JMlleh2D9GC/p2OU2wNEFIUBaiqa+/LG4LkyZn3G/G/TOkpHj1s
X-Gm-Gg: AeBDietjSlNUhipAQwFpexqToncGgzwCK8nqRm2dxrtW+KhWgnEBYHet8PMXm1bEuam
 titI0C7tWovjS0HG/vHMbG1X0k86bG6WcGSlX+eHVkoqbL0/NSti85DRmFduDPQglEbhTdtRD7K
 CdxXTgjQOa6QXKtxaU+f5q0b/BzGCAdZmbjQDfkyIWvmgl6rozwcl9Gr0X6uLfmnx1fa+D7IAC6
 4zKJAX4Z+Fy+Zbt8B+U/5BdXWg43wYkR/qxJN3pik9wxgQFZwBKE1mbfw3okIlioCFwfdUvNKiy
 KH8YoaO7ROPW7Nbf29UJGRyDpT53YjeS4MTP863eXQrwEeafybbYHp27VpcGgwtD51N9m1IcUkz
 3efZmNfmvExaEMzCYMlcLdq5RWoKfHvrKd43KgOxKI/u1Nxd1Ah7sNl6/3g==
X-Received: by 2002:a05:622a:550a:b0:50d:a8f5:1c02 with SMTP id
 d75a77b69052e-50e36c15ee8mr267535891cf.41.1776781225267; 
 Tue, 21 Apr 2026 07:20:25 -0700 (PDT)
X-Received: by 2002:a05:622a:550a:b0:50d:a8f5:1c02 with SMTP id
 d75a77b69052e-50e36c15ee8mr267535161cf.41.1776781224640; 
 Tue, 21 Apr 2026 07:20:24 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e392e4dcasm115367361cf.9.2026.04.21.07.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:20:24 -0700 (PDT)
Date: Tue, 21 Apr 2026 10:20:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH 0/3] migration: switch remaining positioned I/O to _all
 helpers
Message-ID: <aeeHp8QAXfqrWUBH@x1.local>
References: <20260420201317.30199-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260420201317.30199-1-junjie.cao@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 21, 2026 at 04:13:14AM +0800, Junjie Cao wrote:
> Follow-up to the pread/pwrite_all API series [1].
> 
> qemu_put_buffer_at(), qemu_get_buffer_at(), and file_write_ramblock_iov()
> all use single-shot positioned I/O without retry.  They share the same
> pattern as the bug fixed in multifd_file_recv_data() where a short
> transfer would be mishandled.
> 
> Convert them to the _all helpers and clean up a pre-existing
> const-correctness issue in qemu_get_buffer_at() along the way.
> 
> After this series no positioned I/O call site in migration/ uses raw
> single-shot channel operations.
> 
> Depends-on: <20260413214549.926435-1-junjie.cao@intel.com>
> ("io/channel: complete pread/pwrite_all API and fix
> multifd_file_recv_data")
> 
> [1] https://lore.kernel.org/qemu-devel/20260413214549.926435-1-junjie.cao@intel.com/
> 
> Junjie Cao (3):
>   migration/qemu-file: switch buffer_at functions to positioned I/O _all
>     helpers
>   migration/file: switch file_write_ramblock_iov to pwritev_all
>   migration/qemu-file: drop incorrect const from qemu_get_buffer_at buf

Thanks a lot, Junjie.  All look sane.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


