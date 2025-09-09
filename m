Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB623CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvyic-0007lv-L3; Tue, 09 Sep 2025 09:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asmadeus@codewreck.org>)
 id 1uvyiW-0007kT-Kf
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:49:05 -0400
Received: from submarine.notk.org ([62.210.214.84])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <asmadeus@codewreck.org>) id 1uvyiQ-0004eJ-PS
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:49:03 -0400
Received: from gaia.codewreck.org (localhost [127.0.0.1])
 by submarine.notk.org (Postfix) with ESMTPS id DC58B14C2D3;
 Tue,  9 Sep 2025 15:48:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
 s=2; t=1757425730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=at7AVJorJIMuWVkJuLP5d+F16G8f8CsNyroKjlTyKEo=;
 b=GxxYdZoJtB98TSdc4RN46daRJzPlxNwZ8BIPuGOXFeLxOBzU3SjsyLMzLbLJBcXm6LFAx+
 GzfITu/tnWFXNpg6punUwnIgLlT41TIJNnY+nq4NAu+dZ//ot4GHhZCzWio5kqnvSdMA9W
 RH3wpV0ZLdzTGxyFFtJBR1PBeQ5eNO40frOuplJqXktDeyGU4EVFpGgAUzM9y+Odck8Sny
 1Yf4pszfZKEIG7TlYwBEQpFGR4GjWw693eKC/p0nBCDEugLx9oPsobqIVzzyYCBsADvsFs
 tBWvxbCllims/8BDZl+M9GEHh+TacHdutHm3ud00LhqZN9FwEmO3QApcddqh4w==
Received: from localhost (gaia.codewreck.org [local])
 by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 2cdacef0;
 Tue, 9 Sep 2025 13:48:46 +0000 (UTC)
Date: Tue, 9 Sep 2025 22:48:31 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: Szymon Lukasz <noh4hss@gmail.com>, qemu-devel@nongnu.org,
 lvivier@redhat.com, berrange@redhat.com, amit@kernel.org,
 mst@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v3 0/9] virtio-console: notify about the terminal size
Message-ID: <aMAwL8q0i6pqcAOn@codewreck.org>
References: <20200629164041.472528-1-noh4hss@gmail.com>
 <3913e8227c343a5d9bfcc2ac1f01d9bd8eceac7a.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3913e8227c343a5d9bfcc2ac1f01d9bd8eceac7a.camel@gmail.com>
Received-SPF: pass client-ip=62.210.214.84;
 envelope-from=asmadeus@codewreck.org; helo=submarine.notk.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Filip Hejsek wrote on Mon, Oct 23, 2023 at 05:12:14AM +0200:
> I have found this 3 year old patch adding virtio console resize
> support, which seems to have been forgotten at that time. I would like
> to see this feature merged.

It's been a couple more years... :)

Have you had a look at this, or did you find another way of handling
terminal resizes cleanly enough?


Thanks,
-- 
Dominique Martinet

