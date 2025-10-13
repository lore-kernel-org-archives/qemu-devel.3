Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB78CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 05:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8BNV-0000z3-Of; Mon, 13 Oct 2025 01:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asmadeus@codewreck.org>)
 id 1v8BNE-0000ek-2I
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 01:45:32 -0400
Received: from submarine.notk.org ([2001:bc8:3310:100::1])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <asmadeus@codewreck.org>) id 1v8BN8-0002X8-K0
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 01:45:31 -0400
Received: from gaia.codewreck.org (localhost [127.0.0.1])
 by submarine.notk.org (Postfix) with ESMTPS id 44F5614C2D3;
 Mon, 13 Oct 2025 07:45:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
 s=2; t=1760334319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ce15DNwFtcx1o8BE9rSi96ihc22rYfoAQEIEWN/lQiI=;
 b=km//x1/Nc761HY8uuOCVIDYfKH8FWbd7/U/xWC1bXM7oz5qPszuIMwoIHFTKP0t0bQ5308
 E9oQuHjCT6r942NE9nTIunW0ksi+AXaHT57qbCkyWfZJsWOTqxaIWXRqCAkaLK/Hpf7T5D
 fPsWG6HaKG032EXiAkMO7elGABalmcA3g33HpsA0NLaOfZ7ZGFn66EHjEAAFWbN8VMF0PN
 HPtO/lQg4fv8v80N+br8xRGaRS9+K5Gg7ufKa5h8Jb4qJnX+4ve3cw1V2yWGOT14I9nMI/
 lXe3ChVs1iZZ21EDG3K/XrVaZMq9BI0TlKuKKs+fj3Tb6liwijvFPiqS4hIo1A==
Received: from localhost (gaia.codewreck.org [local])
 by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 81845d00;
 Mon, 13 Oct 2025 05:45:13 +0000 (UTC)
Date: Mon, 13 Oct 2025 14:44:58 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Subject: Re: [PATCH RFC v5 12/12] ui/gtk: forward gtk console size to vc
 chardev
Message-ID: <aOyR2hppJDE4Zrzl@codewreck.org>
References: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
 <20250921-console-resize-v5-12-89e3c6727060@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250921-console-resize-v5-12-89e3c6727060@gmail.com>
Received-SPF: pass client-ip=2001:bc8:3310:100::1;
 envelope-from=asmadeus@codewreck.org; helo=submarine.notk.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Filip Hejsek wrote on Sun, Sep 21, 2025 at 01:45:42AM +0200:
> Query the terminal size from the vte library when creating the console
> and every time it might change. Vte doesn't send any signal specifically
> for terminal size changes, so instead we register callbacks for
> size-allocate and char-size-changed.
> 
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>

Reviewed-by: Dominique Martinet <dominique.martinet@codewreck.org>
(not tested; I couldn't figure how to make the console available to the
gtk mux locally... ohwell, it looks good to me™)

And that's the last patch, thanks a lot for this work! A few things
cleaner than I had :)
-- 
Dominique Martinet | Asmadeus

