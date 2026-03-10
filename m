Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC7BFD88C9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w069V-0006se-Vu; Tue, 10 Mar 2026 19:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nia@netbsd.org>) id 1w069U-0006s5-I0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:06:12 -0400
Received: from mail.netbsd.org ([199.233.217.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nia@netbsd.org>) id 1w069P-0001Fg-DH
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:06:12 -0400
Received: by mail.netbsd.org (Postfix, from userid 1524)
 id E160984D55; Tue, 10 Mar 2026 23:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netbsd.org;
 s=20240131; t=1773183961;
 bh=FzQYdZU4pH6qMbJ/jbz71yF11h/xgz2CKwxIC+4f4z8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QXI1n12ISHSeZajAk90DHWFDRfY3X4wbRgXLguQ2S3nw4RECaaWfoCckJYy9bN/xh
 CfhooNgRrHJud+3Y4WotH6uwT1AxGQo8Q857iHTUhry+TbvC/cJmVIXeW9ZSNBGV5v
 tTfh45FzMZQBpHYLqp8QGeglJxff7sbyj67nd8BA=
Date: Tue, 10 Mar 2026 23:06:00 +0000
From: nia <nia@NetBSD.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Minimal GCC version for QEMU
Message-ID: <abCj2IxC44wlkmqo@homeworld.netbsd.org>
References: <20260309155219.62400-1-philmd@linaro.org>
 <20260309155219.62400-28-philmd@linaro.org>
 <87h5qn23v5.fsf@suse.de>
 <CAFEAcA-vsS0Q9kGVbmwEyLQcoANaHg5S754DNvqXOOnqoY-LMg@mail.gmail.com>
 <eb7c065a-ff9f-41d9-a80f-51123af20603@redhat.com>
 <abA5BBSQ0cHstmqM@redhat.com>
 <6660d0a8-c5f8-4f4c-a097-9aa1fb1501b6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6660d0a8-c5f8-4f4c-a097-9aa1fb1501b6@redhat.com>
Received-SPF: pass client-ip=199.233.217.200; envelope-from=nia@netbsd.org;
 helo=mail.netbsd.org
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

On Tue, Mar 10, 2026 at 04:47:30PM +0100, Thomas Huth wrote:
> According to that URL from NetBSD that I posted above, they are still using
> LLVM 10.0 in NetBSD 10 ... which is also our current minimum version of
> Clang, so I assume we're still stuck with Clang v10 for a while?

Since I was CCed in this discussion - can I ask why qemu is targeting
compiler versions instead of C standard revisions?

