Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7403FC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlqnP-0001sE-A7; Mon, 20 Jul 2026 12:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlqma-0001ak-8C
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlqmV-00017J-SW
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784564630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M8nKRPxPC6ymhugCq68Me0xHhlFVNKD1n2tWDhMa2ME=;
 b=WZyu8CEYy6bCGVMIr7qWbnaP+hQmPLX6a8py5v8fZFiPLH0zWngs02eIwLwZboTP3nff/f
 3jGYORp7j6QgGrThL09Glk5Awxbuln3+Yzy8ZTbviP1UpWLYHlbMbHW/GAVq761k+oLGPM
 CIKspIP9dUASeQONdBM0GCChi944aHI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-VuVjeRE2OB-8r1fcBMwsvg-1; Mon, 20 Jul 2026 12:23:49 -0400
X-MC-Unique: VuVjeRE2OB-8r1fcBMwsvg-1
X-Mimecast-MFC-AGG-ID: VuVjeRE2OB-8r1fcBMwsvg_1784564628
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ee593a5a2fso104864186d6.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784564628; x=1785169428; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M8nKRPxPC6ymhugCq68Me0xHhlFVNKD1n2tWDhMa2ME=;
 b=elLODTxleutzTQFXZHl2KT3F6OMrRF9TXEL3aJceEfghTMzu9NcaF5N2/wNxsuaJS4
 xWVJf4/Ly8K2UT8ntBIRjYQ/ndkiBNbC0Lc+NHskHBlOCugib1WWtT78wnYF3CwcVHyr
 TROD7Ya1EiaohvcRMqSIZ6YymBtzaB9g1eqx3abJ4e078FWQo4llN5d9DDJG0Wpm0d90
 vuJkLHFRHoMf0L1uCCiVrMp3lq9I/4xNimijiQ2IqLT9mTkcEnrMbOPv4WzicVhkfMb2
 FtGbCFoNraTWwianJPegvM2798yqEJpAAvqnbYE/opfVxE15/5Gv+FnpAbpDE02CmA8L
 savA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784564628; x=1785169428;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M8nKRPxPC6ymhugCq68Me0xHhlFVNKD1n2tWDhMa2ME=;
 b=YrJD41KpYmAjwPyI1P9hKkUk5bIpaN5eFIaMFxhNE1fK+FSmhg6cYJJUR9QwAW/MEq
 vz0j+KD/7O+OQq48pLu7JdCCz2TXaFjoKUCXPlL+f5Sm5cJETiivTW6HFQ87uy9FuPS4
 YmmIBofFEv0SKSz/JJNWrJEQheGn0JAjSYhxab9IH2Qintrf8ymWpckLRc7rBOFWKAts
 jJczB0wV7xTuG9DRrDTX5PxqMEPSfsYix5MECFXlQ69zbcKc6PYUYknrKZgFlPQhJ8WU
 3vIbMEKfbkyp/Ob25AL+6+8Tny3DjjIcxNMTtABdKm4Ab9x5LRclqtfIL1sWBocoWIwj
 bPfw==
X-Gm-Message-State: AOJu0YybQzmG/CK1kAB+XbpUyW5EoqF+heCqn/3tBJ9PiJ0yYa6DhkfC
 RoQTrqtz14SYNweM0jNyuGbALvJDTXDGtzT3cidtW/vF4JHxC/8ahLqk6ZJhuYFh7/qCEyN8YI/
 uNWueCt6kiOKSyW6ImTXznObm0IW6X+Lg+31/2RGrG7+IHOVnqMqBhvn4
X-Gm-Gg: AR+sD11s+d4vQ6wuet/bT5wqJILboUIJofj9BUpg2fPXuXTi5Zbx/RTDctT61aEFWBM
 2QmB1U3wDohJGHAoisTNH6BA/me+oxK8DvfhNtzMqSFwVy7QNV4s+uvuiBU0ZU/D7V61vqexR+r
 EtKDGEV+wxtAHzBfYv9VOzjY1Q1vZOl0A0eGdFjowLY1OV7QoWPbCEFYkIoiarfqEa8Fcn3m/gv
 0uG9oxtaEot3xQ90Mwc/i5uWktDy9hh/hPX45bAYaVzv5zO7YNMLCQ/hYaMrQ2SLukDGJqNNkUU
 x2cq1qez000b9ipitpln/q6u0i9kaZt1Zl8ZnmxuMBogZ0valanjPkkeFHUkL5Ygl1cz
X-Received: by 2002:a05:6214:daf:b0:8ef:dde7:bd69 with SMTP id
 6a1803df08f44-90768eb5662mr201147376d6.29.1784564628265; 
 Mon, 20 Jul 2026 09:23:48 -0700 (PDT)
X-Received: by 2002:a05:6214:daf:b0:8ef:dde7:bd69 with SMTP id
 6a1803df08f44-90768eb5662mr201146946d6.29.1784564627737; 
 Mon, 20 Jul 2026 09:23:47 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9077856a9e8sm93913796d6.17.2026.07.20.09.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:23:47 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:23:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v3 06/11] migration: add RAMBlock field and helper for
 fast snapshot load
Message-ID: <al5LhsKPCUXL4Npm@x1.local>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
 <20260714141547.1268000-7-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714141547.1268000-7-aadeshveer07@gmail.com>
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 14, 2026 at 07:45:42PM +0530, Aadeshveer Singh wrote:
> Add pending_bmap field per RAMBlock which is a Bitmap to store
> internal state of which pages have been read by some thread to ensure
> coordination between fault thread and eager load thread.

The other way to do this is squashing this three core patches (starting
from this one) into one big patch implementing the idea.  Otherwise it
might be hard to review a newly added bitmap when it got allocated but
never used.

But it's still fine when implementing a major feature like this - people
may have different opinion on how to split patches, you can keep it like
this if nobody else complains.

> 
> Modify parse_ramblock_mapped_ram(), to not load the actual RAMBlocks
> data in postcopy case as that will be loaded by fault thread and eager
> thread after the VM starts running.
> 
> Change ram_load() to use new function ram_should_load_postcopy_pages()
> to decide how to load/read RAM.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


