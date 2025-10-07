Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51ADCCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 20:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6EWK-0006Zd-Eb; Tue, 07 Oct 2025 16:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v6EWJ-0006Xf-45
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v6EW5-0002ou-Ix
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759869755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oNRAGvZLq0TTCafccm1g3/dX+5jZLf0g0sAsAfVbeVc=;
 b=gYLb3iitb0jKh164QpGDVbEF0LQOUPLyyoYVdnQ6oBf0FNFA2E/Um6Na9IohzQqgyq6O2Y
 GYWUvrqxBfvxByFyH0x2JlyhgMnozwFSby26Sv+465V9Dyp6jSjxgvTyPImAjLHMMFH/Mb
 JBLoRf0BM3cIvYsVUaDRQY+vE9pVBmw=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-SAwItwxlNNOuqhDmMlZGug-1; Tue, 07 Oct 2025 16:42:33 -0400
X-MC-Unique: SAwItwxlNNOuqhDmMlZGug-1
X-Mimecast-MFC-AGG-ID: SAwItwxlNNOuqhDmMlZGug_1759869753
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-59d90f0403eso4363462137.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 13:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759869753; x=1760474553;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oNRAGvZLq0TTCafccm1g3/dX+5jZLf0g0sAsAfVbeVc=;
 b=jB/0Sz8ez9BPEyLttM30kpOyO+R64i1twIMS21nH8h+sxzJK8tXJBLYnfru+O5qyvE
 aLO2rSOC2vAs4oN2QV5NQktekbZxUnyqXIDgLA2N/npyuCXcLT3zSx2UFclAGtI6kwU9
 ADUPNBYlmFpGwEduAgnFjNNd4H69Lp+BsE3STH45T8kzoM2n/q/IVGf3nnrQY+V5RB8e
 ot7Rj6YFBdnMdN10jZWP4+KrjJk1tBbt3wlgkxnypSwfCLJ/WPEEpSMnJlHA3+Slij95
 tKw3322Z1JRzqew3YBuKZKh5LH+IcesTvQfz2mEwiaC0WUYkkGVtRKYg2ofPakBMUiaM
 qx4w==
X-Gm-Message-State: AOJu0YwDLsd5tMopzea2wqrJBVskRmQfVzjL72J/oLh+wIuomkIUOw7z
 qrtcvpmwEeXmMuhrrTQe1r05vW3ujwwZI0reRxZCl2kuk6xMPgkGePDbzl1RY4LyctmFPTcaLal
 ugqAIObwR/HLDLGbFoHOoZC1WAmJIZcViWVKPsB4K/JSS2zD1RdUn+DlR
X-Gm-Gg: ASbGncv/lJP0FW6vdqc04nzmXcRzkI8nJEZ88GGj4m/d2fhXQ8yXov0m4myk9uRAXCJ
 N9DJ/zZ8HYTHi/Nm3Tc4P1VgKIVKfxEkbm+9BxBj9+OkllrqQrbTI/86rnEUbVfR60aTAD3ZO7L
 +ltbnerbMBL8u1mRcYztZ4+ri73Z2rVpDs08d9xOYvfRwsRB2FlMndFZ0UMWA9XvKk+cHxHYkW+
 8wN4Ll9N4Nlqaazk0Md2kgAiDz+V3Xxo6jxZqJDCR2gwKVDYnOe3+t2UyGA/D8BighvQP5Ft+BH
 vG8PCfzo5bi+rVu+R3llz76zjstLcjvTIkE=
X-Received: by 2002:a05:6102:54a2:b0:593:6029:39ea with SMTP id
 ada2fe7eead31-5d5e23b44ebmr379029137.31.1759869753119; 
 Tue, 07 Oct 2025 13:42:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSJUK4VvQUk3YRYlnLFARPX8tS/MjopC3nU57ih/h38tkdFpLbRyfCKcfrHtsW73g7SFn47Q==
X-Received: by 2002:a05:6102:54a2:b0:593:6029:39ea with SMTP id
 ada2fe7eead31-5d5e23b44ebmr379013137.31.1759869752553; 
 Tue, 07 Oct 2025 13:42:32 -0700 (PDT)
Received: from redhat.com ([87.249.138.54]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-5d5d383430asm1052435137.2.2025.10.07.13.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 13:42:32 -0700 (PDT)
Date: Tue, 7 Oct 2025 16:42:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: qemu-devel@nongnu.org, clg@redhat.com, sarunkod@amd.com,
 philmd@linaro.org, clement.mathieu--drif@eviden.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH] MAINTAINERS: Update entry for AMD-Vi Emulation
Message-ID: <20251007164211-mutt-send-email-mst@kernel.org>
References: <20251007182951.1284171-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007182951.1284171-1-alejandro.j.jimenez@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 07, 2025 at 06:29:51PM +0000, Alejandro Jimenez wrote:
> Add myself as maintainer and Sairaj Kodilkar as reviewer.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>


Great! Will merge.

> ---
>  MAINTAINERS | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 75e1fa5c307ea..08de896ca942a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3891,8 +3891,10 @@ F: tests/functional/x86_64/test_intel_iommu.py
>  F: tests/qtest/intel-iommu-test.c
>  
>  AMD-Vi Emulation
> -S: Orphan
> -F: hw/i386/amd_iommu.?
> +M: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> +R: Sairaj Kodilkar <sarunkod@amd.com>
> +S: Supported
> +F: hw/i386/amd_iommu*
>  
>  OpenSBI Firmware
>  L: qemu-riscv@nongnu.org
> -- 
> 2.43.5


