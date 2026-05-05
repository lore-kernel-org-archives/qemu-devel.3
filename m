Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A30CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 16:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKIao-0000j2-9e; Tue, 05 May 2026 12:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKIah-0000iY-Hv
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKIaf-0000tf-4b
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777998342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P4QtZAZI+jIkdJqM/LzjK65gSHXQ1CKWOJUvkq5VEcU=;
 b=SKZHCEDNHDTsNiJpt7AvKQg6qz3H8huvmrWeorG9eQykdV6q6F/SZhBABFQ/pcwEnfncVN
 lagcbBN1KTpdwuOCVaj3MkegORhtkjuZsB3iSKHegL9ByIAsFgvigVRiCLYl8IoVd33hIJ
 GWL0WJoHyrfiUd0uVrPmhOXJVFKYgcM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-7pdGge6YPrKQ0GNicm6g5g-1; Tue, 05 May 2026 12:25:41 -0400
X-MC-Unique: 7pdGge6YPrKQ0GNicm6g5g-1
X-Mimecast-MFC-AGG-ID: 7pdGge6YPrKQ0GNicm6g5g_1777998340
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7bd6f72e5aeso85173727b3.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 09:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777998340; x=1778603140; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P4QtZAZI+jIkdJqM/LzjK65gSHXQ1CKWOJUvkq5VEcU=;
 b=httsuOUObhVWmJx+lZgdtJmohJeLpGwn58K6KodYwoUP1lH7RDCF9QYvEjAcG3bqb5
 JkPbNewHnKYepP+CSJPpA1KfuSJPLWZyhsBMsuXv+dbinj382ThlaQ2UXAq05DpvEFo0
 luiaQAY1QTfOg6WVaCZGNOeOJGK12dw3ifnLFqB1BcH7S6qcnUrazZA5Az48G2D10Vo6
 //WI6bOXwshWoDf4qcljyNgtfmT1D6NkDXsVYLOXQoRq56Sqo1RCZHFJzWnBazQxPt3C
 R2Em460oXcMUa4zsGcSpB8qmdrcKHGbx7ahDK/P2AAJFNKYJ/Coe0NJU09DcUFrmPLXS
 RXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777998340; x=1778603140;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P4QtZAZI+jIkdJqM/LzjK65gSHXQ1CKWOJUvkq5VEcU=;
 b=gU1DoPy1lWtA2FFwzbfYVqaop0/7gqbKdio2HWVoKsL6YxbwaruwQWZmPvD+s8bcJx
 Q09kLoQQ2V78P3dbn+q5qGvCUtDXg3c4z6nKXXV9mBiAqTYN06L15tWDrkUBR0YNBnqd
 bUR+iwBA/6h/6PHsHTXQpNCukieVhgV2xTIYXGQyLKvfvptrYjgrlV0ZSj1d8nG1VkTd
 aJMdeBKpwNyJhuSle6d0gVIAmXL7ZVDZwzNf4cJVD+Oso1gCeASZNBKherGHvffp+B4J
 y9z9U0U31tJGrY9PO9DHFg69r9Z7WF/v62X6G2y4NMWOZteFbqMkezbfI4eEdFvlmafK
 yLLw==
X-Gm-Message-State: AOJu0YypRhJRTqI/OhJzr2Dm+d17w/7GmgUWesAijJdyRQIB3uLfAMR6
 fqqyes+12du7QaTWOGOW7MFAbrWKtpHU0iSPHyspGQJivmJhVKu3bSN2BHZwP7zx3BtvsSl/A/y
 EqpL0Eq+8r6L97ZYQsncIsOLxO7d1VTdqFuj1JAl1P8DKs00Mr/Xt5S3H8CH74eE/
X-Gm-Gg: AeBDies+nQjt5WoiDfr8EtBmsqy4gnKms5qgC7A6NxiYy5sJHlqKSXamRCzteR/j0Ok
 hx+3a4joMbznzNc1GjWJZg7m/9aYznhYATKnUfENkJte1VGstkVmwTvbRr74UOzT3CTIVlJQFpK
 G2MS9uRLg3HF9rIGmhUaSQ1uQLj+Sw5SIiq+6p4u4snEBGcKvzm7dAyZvoxNRbJbwCstOBBZmYK
 J2Bhppex96JNRSTInIpbPwmF4sfrOl61/CJz1+0WFSPCTwHf2IyvUyocXVydm8BsvCIMFTEaWIU
 u9cdB8Pts7fxHeCvW+AuPcR+2dGjjxPnviKt9Si8QFKz9slNxTiH2zDrGzxkrg3BWW49iRXfHG3
 rWnPZBn1/eAuAJWymZll04gresdIRgNe7ALRKCyuufwdyJbSdtMPIeItTtg==
X-Received: by 2002:a05:690c:dc2:b0:7b2:136d:240a with SMTP id
 00721157ae682-7bd76f57a5amr150697487b3.9.1777998340311; 
 Tue, 05 May 2026 09:25:40 -0700 (PDT)
X-Received: by 2002:a05:690c:dc2:b0:7b2:136d:240a with SMTP id
 00721157ae682-7bd76f57a5amr150696987b3.9.1777998339690; 
 Tue, 05 May 2026 09:25:39 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7bd6685d0cbsm65320507b3.35.2026.05.05.09.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 09:25:39 -0700 (PDT)
Date: Tue, 5 May 2026 12:25:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v1 00/15] tests/qtest/migration: Always defer
Message-ID: <afoaAsY1u8XB6nHb@x1.local>
References: <20260505160915.25558-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505160915.25558-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 05, 2026 at 01:08:59PM -0300, Fabiano Rosas wrote:
> As discussed before, change the tests to always use -incoming
> defer. Also remove one of the uris from MigrateCommon, a single uri is
> enough.

A quick question before reading into details: do we want to still keep
-incoming URI to work for QEMU?  If yes, do we still want still a tiny bit
of test coverage for them?

-- 
Peter Xu


