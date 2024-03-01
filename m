Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD1BC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 04:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfuFw-00077v-LZ; Thu, 29 Feb 2024 23:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfuFv-00077n-8B
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 23:12:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfuFt-00081h-OW
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 23:12:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709266336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CWMi6stCLB393Y4YI1tBjbSiUFyhpSIqmAvIz2ItVi8=;
 b=P5d31km3e7NTb7oaGbUCRpOmmrGrfM3fUVXcP6UFKRwH1mw3nzlpa8XaxD0OTVZKcn3uP6
 0FcJisZbk7Gw15hzVaPcPVcIYwo7po/xpLkdisyyBp4hKaOtk2BdCJuS3yv4eTfqXEZ9X9
 yheLo7jRGYdIoifImlSxBOMwXtj5L+o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-_ulu2T5ONMeqWA_LQbVDrw-1; Thu, 29 Feb 2024 23:12:12 -0500
X-MC-Unique: _ulu2T5ONMeqWA_LQbVDrw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29999b97b39so503039a91.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 20:12:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709266331; x=1709871131;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWMi6stCLB393Y4YI1tBjbSiUFyhpSIqmAvIz2ItVi8=;
 b=Rc9CsOHJl3Wm26V5WVDtp4aiNGDtnZq5fLEr4+D5IaGGj6sequkiMh1/h9djWBZDBV
 4KKJIs+sIyYRSpzsSL0/GEckLklBmGc7on6iV1hxGomWOa6LbybuHuSw9vYQoJWmBKmi
 oyY5YWJ6oF5Nhbpuk3HlQp/nTbeKi8EauISGmFVBW/Fymkzr3pPaP/ZMMT8A07cQtzeV
 C6YNp2IoT9fs9kpebVDgFAGjsxWAWcFsnqOwQ4/d2e7Ej+DG3UZcqJO6ZoOVBxxWr3oH
 QXTJChVMs9Z1OZSkFgoqlaIGsEQgbrxak+4w+Va2WOVNUV0RR5U3llbTUjXNNJTB9nva
 +u3A==
X-Gm-Message-State: AOJu0YxYH42/k6zrx9LuppEZG+zN155Gtadt2yC+ZcGvu0gbEy0P5ETS
 FWNuFEv8K/ChAlyXOVVHrNPaSvntAquKI+BQttbCVf8GCy0hpYObWR5zOitEjEgEq+59ybHytSF
 qOHfYAdXgscFUxKLyFLBDL0RbwI8OHfUdDFSLq32KEcUhOqsIfEVD
X-Received: by 2002:a17:902:7285:b0:1dc:d8c9:6a7f with SMTP id
 d5-20020a170902728500b001dcd8c96a7fmr547085pll.3.1709266330971; 
 Thu, 29 Feb 2024 20:12:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuOTcQadBapqcqYBJX6auR+whmjC1Bz9m72jJXaFCVAOUFf9SeppzaimM2ATU9nowHWJtSFQ==
X-Received: by 2002:a17:902:7285:b0:1dc:d8c9:6a7f with SMTP id
 d5-20020a170902728500b001dcd8c96a7fmr547061pll.3.1709266330655; 
 Thu, 29 Feb 2024 20:12:10 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 y9-20020a1709027c8900b001db717d2dbbsm2304439pll.210.2024.02.29.20.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 20:12:10 -0800 (PST)
Date: Fri, 1 Mar 2024 12:12:02 +0800
From: Peter Xu <peterx@redhat.com>
To: Bryan Zhang <bryan.zhang@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, hao.xiang@bytedance.com
Subject: Re: [PATCH 0/2] *** Properly apply migration compression level
Message-ID: <ZeFVkgRhAHuY7j3v@x1n>
References: <20240301035901.4006936-1-bryan.zhang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240301035901.4006936-1-bryan.zhang@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Mar 01, 2024 at 03:58:59AM +0000, Bryan Zhang wrote:
> From: Bryan Zhang <bryan.zhang@BYTEDANCE.COM>
> 
> There is some glue code missing, such that the
> `qmp_migrate_set_parameters` function does not properly update the
> `multifd_zstd_level` and `multifd_zlib_level` parameters. This patch
> adds the glue code and also adds some function calls to the existing
> migration tests to make sure the set_parameters function gets tested.
> 
> Bryan Zhang (2):
>   migration: Properly apply migration compression level parameters
>   tests/migration: Set compression level in migration tests

queued, thanks!

-- 
Peter Xu


