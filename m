Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88492C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 18:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZahn-0001FC-Or; Thu, 01 Aug 2024 14:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sZahl-00017l-Kd
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 14:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sZahk-0000bn-9R
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 14:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722537551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zTRzUoNwHapsdSMNntojf7QOiCcABfzYMaNvq/H8KyM=;
 b=MAs1TfZH9q0Ti/aiNRAjZneVQafuMRFQ5SsUCKi6z6b5n7Guvu4OeuJarRH0iRBrpxhHjK
 iHEGacJaQc/KzPYy5FDOyrHaJZDLAjM58ixl0bBWJvAk3Otbe02CLppklXLpMI69ZnARR2
 LjDB9UKz5QOk2scWkfecQB+DEmp2EB0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-AHcpL0N2NUm1gfKPX5K7NA-1; Thu, 01 Aug 2024 14:39:08 -0400
X-MC-Unique: AHcpL0N2NUm1gfKPX5K7NA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b7a47a271cso16496996d6.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 11:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722537547; x=1723142347;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTRzUoNwHapsdSMNntojf7QOiCcABfzYMaNvq/H8KyM=;
 b=CgiaDx+3adpE0yj/tSPjDi5eQQ3iXNb+1a00KxItDBjx/zqRmp9Hs3Kt3K2j4tE+lR
 PjToXeHYc75XfsASIuiRVewwgxv5ECV4CO0LTGctAF4E0VSRgUUQt969fYRocqRJrIOt
 qUlYiViv7l+0nOm0SVN0KiPfUwhyHdeYqqK0rIMmRn2t92ut+WulHEROnthJ/2lKP3iW
 gQQBiPHpB6AbVqLFl/fPpidTd0VxS65YW3LsWG48uieczDV6x1zrt/LPMpi3FRdXuW6r
 6SToFJA1aLMVAgjc2vHr/mlrc0Ej+rywgU/MzFujdaW09bKSW9vQiPB9uUwn28dA6XVK
 s+3w==
X-Gm-Message-State: AOJu0YxBPVyeOlmHasujv4RRFWFPP4tZ4sd7F4LohH61Wusoc3WFIbuD
 oQmqhOtg0fz2zoBWDnKBmGOBKS9mxurapjAndZ2D6sgwhViLIGmDkHzmqbUcX2aIJFM7bZe8mwP
 7nwbqDpq/fGzG/iTbPAzDY9oKonj94m8CF8G1EIOJlQKtwHQy52p3UsWblrzg
X-Received: by 2002:ad4:5b8d:0:b0:6b0:6370:28d4 with SMTP id
 6a1803df08f44-6bb983d7175mr7201296d6.6.1722537547565; 
 Thu, 01 Aug 2024 11:39:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/oFKSGYF9hDMsxn0vNPWmVMancOGNcGsulE/0ntHPh8Vrm9AjmoMhaMDo0YJ9Wu0VbvYVCg==
X-Received: by 2002:ad4:5b8d:0:b0:6b0:6370:28d4 with SMTP id
 6a1803df08f44-6bb983d7175mr7201196d6.6.1722537547174; 
 Thu, 01 Aug 2024 11:39:07 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb99a1e4bbsm1376016d6.37.2024.08.01.11.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 11:39:06 -0700 (PDT)
Date: Thu, 1 Aug 2024 14:39:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 1/2] migration: Fix cleanup of iochannel in file migration
Message-ID: <ZqvWSYlio5gOVy5I@x1n>
References: <20240801174101.31806-1-farosas@suse.de>
 <20240801174101.31806-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801174101.31806-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 01, 2024 at 02:41:00PM -0300, Fabiano Rosas wrote:
> The QIOChannelFile object already has its reference decremented by
> g_autoptr. Trying to unref an extra time causes:
> 
> ERROR:../qom/object.c:1241:object_unref: assertion failed: (obj->ref > 0)
> 
> Fixes: a701c03dec ("migration: Drop reference to QIOChannel if file seeking fails")
> Fixes: 6d3279655a ("migration: Fix file migration with fdset")
> Reported-by: Jim Fehlig <jfehlig@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Ouch..

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


