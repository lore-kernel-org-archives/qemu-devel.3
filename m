Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72D4D6A22C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 20:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBg5O-0008Dw-3X; Thu, 14 Nov 2024 15:05:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBg5M-0008DR-0p
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:05:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBg5K-00043a-Lq
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731614696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HeRle9Ocz3qSeKUGq+EU5DdeZEcOhJQqbrkK7YhkKAA=;
 b=ZPnkAXCHXzVyztnro3Viu+VUhcPZl4hH8EZUkA9Bmm7e39fHewUeocZSx3bYn1YD63w+y8
 V+dJHD9kP49Adr7Rhrt/LQleyNLEugJ9G/DKDKS7p5WhVfTwykInJUEOBeRFcUrma8c2x6
 HaSP0nGnaGI/1WGU/GIBbiLZtfJn0bQ=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-Mk_ChhAuPhKcBlmm7Zy1Ag-1; Thu, 14 Nov 2024 15:04:51 -0500
X-MC-Unique: Mk_ChhAuPhKcBlmm7Zy1Ag-1
X-Mimecast-MFC-AGG-ID: Mk_ChhAuPhKcBlmm7Zy1Ag
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-71806ab1a97so844794a34.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 12:04:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731614691; x=1732219491;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HeRle9Ocz3qSeKUGq+EU5DdeZEcOhJQqbrkK7YhkKAA=;
 b=uHazG6YZDV5F1vavfjfi4rDa8yppk41mn81KLNUiGOCiUKb0xFRYP2CvDK0QdhOiCy
 vy4i08wJWuf1SR+kfMiGjk1BZeWD8CADEm82cucBiyulOi29ZzpFzfGRr52K2Dsycign
 JUOEmlTqPFgzjW35UmDN4ViknJMRS2JePSY++VGkrRSMtXZ+AUHlMc2hApyuk1f6W0Hd
 QfGH327oWnSQh+bY9fCbu7dO/XB+qDG3WJBniRJAP8SKuPrfeazKb+2St8zzm20dC7PM
 /na/J82QWfCBtOjYV2ECUiV8OcqSKZBEgbT6xkYNWhbThXjIEftDviqntfKpf7NnLiL1
 4BSg==
X-Gm-Message-State: AOJu0Yz13TkghZcsE4MdKT83jsZh0vELe0HTAnnUVOvKSy+fTGxFvs8p
 tHdkb03PJRvQpnVM8i79JPb/WnxK6dEeDPtWS66I2D+Kkh6KHKZI+fAk1Tug1SCtcDYxUGVWrgX
 yM4+MkvmHDLZumir/CMa328x9y6ZDboyeCLPUVRZiZPvFOaZ3avgM
X-Received: by 2002:a05:6830:3c8c:b0:718:5bec:30fc with SMTP id
 46e09a7af769-71a7797b841mr280564a34.18.1731614690780; 
 Thu, 14 Nov 2024 12:04:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3Q/B5BCF4LLnNy30ncxRsY1PaiSYTBbRDzIZ2hPyI8fxlGCGZI7/CNJvoTPQluseYhOORLQ==
X-Received: by 2002:a05:6830:3c8c:b0:718:5bec:30fc with SMTP id
 46e09a7af769-71a7797b841mr280534a34.18.1731614690512; 
 Thu, 14 Nov 2024 12:04:50 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e06d70d23esm125173.63.2024.11.14.12.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 12:04:49 -0800 (PST)
Date: Thu, 14 Nov 2024 15:04:47 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 2/8] qom: allow failure of object_new_with_class
Message-ID: <ZzZX39AShxOGyqrW@x1n>
References: <20241111155555.90091-1-berrange@redhat.com>
 <20241111155555.90091-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241111155555.90091-3-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 11, 2024 at 03:55:49PM +0000, Daniel P. Berrangé wrote:
> Since object_new_with_class() accepts a non-const parameter for
> the class, callers should be prepared for failures from unexpected
> input. Add an Error parameter for this and make callers check.
> If the caller does not already have an Error parameter, it is
> satisfactory to use &error_abort if the class parameter choice is
> not driven by untrusted user input.
> 
> This conversion allows removal of any object_class_is_abstract()
> checks immediately before object_new_with_class().
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


