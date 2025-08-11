Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4285CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 19:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulYF2-0004vh-PF; Mon, 11 Aug 2025 15:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulYF0-0004vD-QO
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:31:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulYEw-0002pW-G4
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754940675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BxgP41n1AaEH9jc6WJu/MFRI2LeESouYs5uoHwE0iVI=;
 b=HTcV9YYbLNWgaN7qM3sLiNSyT3rRdEH9o7RuTkjlBxJM4RigTBvsamBuLnS1HfMFKiHIC0
 o5mwt7wp1NIWinJ92/Fz99C/6ZQ1hzw1DBEr2T0f2L4f/eOp8ZqKSLOyPqpQy1XcNn2xIY
 I4H5kF8Qs2Jjzkr9thwXFRWBPoOZhjg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-W5naVlopMwqZDYQTDefWGw-1; Mon, 11 Aug 2025 15:31:13 -0400
X-MC-Unique: W5naVlopMwqZDYQTDefWGw-1
X-Mimecast-MFC-AGG-ID: W5naVlopMwqZDYQTDefWGw_1754940673
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70747c020daso91888996d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 12:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754940673; x=1755545473;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BxgP41n1AaEH9jc6WJu/MFRI2LeESouYs5uoHwE0iVI=;
 b=MG0T1XrP0CJzii4XSWcuvo4P2rfWE7CewJs1FHDvdZmLjdshP3B2rKJgtkXTVaS8X7
 nGp0DliUNA/9sw9AWYoW75sX5IAWQjr/KKNrsDyKJKjMn73bs+9FLQsGh1eW7TfH5Fkk
 yJU99SqhYKnOt9kMYfgTtXVS033077onIqDGbh+GdeGX3OPQTO7CJgbt/2+B4O5KsUGo
 NrevdvlpXROGDOj1ZvPpLIiyHuPkWTRveFcqYHEjeB1IY4l8FOjN9L3ZUpRM/NYls01H
 aVe65PLy5JHz1g91stHoza5cXrKi3mt1cwiY7fJXVleIsMxQQYbxmiKzbxkPLjh+1bk/
 lpMw==
X-Gm-Message-State: AOJu0YzyMCFblJCwrED2yDpYfaqmtNiZRWysBpsO4QTZpIn0kcZot1QD
 a0ZpOC7RaNOpW8xOusojPkgOi79i+5X4BAAdcFVv8ZZo1miHPpDMZMIQ/djDSDTU49L0crqMiGW
 7N3yxldYMzcwxY4rr43FkxFM9wYwnzdqTAngAy2pU2mtOnhSBVZAT9y/5
X-Gm-Gg: ASbGncsIH91CjPJR8M0eDsBAlJ18+usChDiZGNxlC5lFJVeWts7REycPaEFW+PXVXOq
 /K1RLOIcY6k0s8e7cIZ+KEaIzUeHsMq83oG3uYvtHH6RPOctiQ07TOaBE+6azpcCdR/7moBvZ96
 JJAs1w485VWQbJPSG8Q7KbIFJmgPZWo2jLZyF8UzYStcIlEqu7dzTB1TzJzz6OacQjaJgfuJpZ4
 0//W0Fsi27uwOLngOqBGvvL6dzN+5j7bC5ot9kaqDBF3N6nAFmvss2Cp8rhRkLiSvnZhq1Ew6D0
 QUHbWYKyoFdo+XqWKd1XclFDkwNQjeZqv7FWcAEN/9B3WRwH4Hz5jZa74/SLwZB7HDvls5WOfaL
 vTlVck1rCkm0Vk46k/8+vrg==
X-Received: by 2002:ad4:5947:0:b0:707:757:aef1 with SMTP id
 6a1803df08f44-709d67db38fmr9784866d6.2.1754940673316; 
 Mon, 11 Aug 2025 12:31:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu+/N448JyiqkmrRKpuccNrRENb1AUT2DgQYO7dCiyJuUyRZWcx0BkkoYpbEt+z1vfesGOwQ==
X-Received: by 2002:ad4:5947:0:b0:707:757:aef1 with SMTP id
 6a1803df08f44-709d67db38fmr9784476d6.2.1754940672748; 
 Mon, 11 Aug 2025 12:31:12 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077ca58d36sm161512536d6.38.2025.08.11.12.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 12:31:12 -0700 (PDT)
Date: Mon, 11 Aug 2025 15:31:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com,
	richard.henderson@linaro.org
Subject: Re: [PATCH 1/8] accel: use store_release/load_acquire for
 cross-thread exit_request
Message-ID: <aJpE_owW6w31OV24@x1.local>
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808185905.62776-2-pbonzini@redhat.com>
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

On Fri, Aug 08, 2025 at 08:58:58PM +0200, Paolo Bonzini wrote:
> cpu->exit_request do not use a load-acquire/store-release pair right now,
> but this means that cpu_exit() does not store it after any flags that are
> read in the slow path.
> 
> Probably everything is protected one way or the other by the BQL, because
> after reading cpu->exit_request the CPU thread often goes to sleep
> (by waiting on the BQL-protected cpu->halt_cond), but it's not clear.
> Use load-acquire/store-release consistently.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


