Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCF6E81BD3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 17:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpUdo-0005nK-8M; Mon, 09 Feb 2026 12:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpUdH-0005ZE-5K
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 12:01:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpUdF-0002dr-HX
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 12:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770656462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wrJJ9xCwLH3MOxQBf/m/lX1hHQDlE0XvMhRqS9eSA7M=;
 b=Bg5Nw22v5kz7rYajLsFQU+ygsEHvIR8M+uvYmJ4tU3SKbWuv7JK9lbrM01zXH0/jhGVm3a
 0rgkbeVYTUIMCHL11f5KBu4xH4eEoOC7PrxpR178BZU7KtO/EFT70GNlD+M5nz/9C463cw
 bTVwobdeTT23Dkx6O3JRWpq1nlrwQwU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-L2q12CbZN7qtSP4DMU5jcw-1; Mon, 09 Feb 2026 12:01:00 -0500
X-MC-Unique: L2q12CbZN7qtSP4DMU5jcw-1
X-Mimecast-MFC-AGG-ID: L2q12CbZN7qtSP4DMU5jcw_1770656460
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-501473ee94fso174325701cf.3
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 09:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770656460; x=1771261260; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wrJJ9xCwLH3MOxQBf/m/lX1hHQDlE0XvMhRqS9eSA7M=;
 b=tBtbM6WwZUbYDy+/3gDqUxmxoSNrx12ykbBlLEd3Nm3XafdtKZTtgztPXRuZmdJEl5
 ZUdZ/VKYfi6Nn+fI22Bgq+hN4fzJe+dz2eFcZouVkhVC+B68D2WT/ay5m+q9NxiZRybz
 uvsVAoouLDrx9mIXOcs4KyVh2nq/wzyNOVWu86srgQEcLZUEpcL8qe8AuFcBWz7EyljU
 QUdMrcTYaHrfT553pkWstRKvFSIO3WbKQkTK8UxtZ4TszT7LviAWzmNSgNl3dMP2Lt0b
 3xjNuL3+kal7DR2TiqGfj4fPnFfG8OxTtg5Nxe2q3DYVPMzduJaTA99tP3X4w+xAUd1g
 eaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770656460; x=1771261260;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wrJJ9xCwLH3MOxQBf/m/lX1hHQDlE0XvMhRqS9eSA7M=;
 b=oSw95zstFlUCWbO/9A4HhY9ihBL/+89iWb1os9/lcn95JkKWaz+STT5D/yEa4UatHj
 BV2BX+uDfuS0e6AJVm4mSJRVS+hQZNrkBpKh5wmwZYItuLtjhPXnxJQpEXEF14L5Q2fe
 xf4fqHyBbJnxOmtWYL8XUpDfpBHQQSnr4SFMt8NLpN5zZV2rPm7i17Dd/i3TzRS5uDrm
 N8Lme7uZALishamHMYk+NS+xnYbAlvr3a29mlmje9khkW0tV8geJbJhbVea2EG8dug2L
 6syaY/rTsxPek8qmF/xhkwu19qspZfcEbbb7qEkFZcufi0U+Ggft0j6RVjTA/yZ21/Qp
 Xl4w==
X-Gm-Message-State: AOJu0YwbsB+dy9PorTH+YlkIkvLZ3vuvTKS2K0hJ3lHG0xK80syVNp7b
 A3kKyC0T9JbDIoOWNMl+6UsydN94L4u6L/o1H++Yy2VWRcIa/hCFr+U1PdjV6OqL6DoTwQCeXKU
 xZyoIQWMSzdXjvBJOBAGZFRpvtV8DDTsa5iyN9SqPcb/YicRKze8UZwxH
X-Gm-Gg: AZuq6aImX7YpM+giNUD4cJohWZX8SIHbg4F7/qZDUR8c5z2xTY3qw5J5eM/h2ypDgxD
 8zTZu+bIGvq1F5yW+SW53ke9nyv5Cazp7nw+YsULUaErbJWix8M34uAnHx2TJD/p8c2L9aVgToW
 Bu6Ncj8osIR/yddQ4zKIZNGJg3axFYShEGWg0zAUIzLNUBEqnndzkk3WGz0thhiI7Ffl2+PFYcz
 3f3XfzrYve89wVFHKaQ+fQRcQGB4qkCGSEBkM+/9G1vfN2w6pSIEv3yYlLYy/GO4L1GBoZnlWXd
 g/NpjRaVgAKd5Y3Uq0cbm9QKtlr0glV71gEBoJsLyuTKPo0/OicPytHhvGJD8zPM7uA5zda3TIk
 BPGQ=
X-Received: by 2002:a05:622a:13ca:b0:502:f0fd:183c with SMTP id
 d75a77b69052e-506399b1dd2mr167915881cf.78.1770656457532; 
 Mon, 09 Feb 2026 09:00:57 -0800 (PST)
X-Received: by 2002:a05:622a:13ca:b0:502:f0fd:183c with SMTP id
 d75a77b69052e-506399b1dd2mr167913181cf.78.1770656455743; 
 Mon, 09 Feb 2026 09:00:55 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5063928e05csm78264301cf.19.2026.02.09.09.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 09:00:54 -0800 (PST)
Date: Mon, 9 Feb 2026 12:00:53 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v6 12/18] colo: Hold the BQL while sending ram state
Message-ID: <aYoSxcr3QhU3krUV@x1.local>
References: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
 <20260206-colo_unit_test_multifd-v6-12-27779dda139d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260206-colo_unit_test_multifd-v6-12-27779dda139d@web.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Feb 06, 2026 at 09:03:10PM +0100, Lukas Straub wrote:
> qemu_savevm_state_complete_precopy() requires that BQL is held.
> 
> This fixes a crash when running with TCG accel.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Didn't see this new version coming..

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


