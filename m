Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2FECA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 09:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umr66-0004h6-E0; Fri, 15 Aug 2025 05:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1umr64-0004gk-W0
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 05:51:41 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1umr62-0006I7-H8
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 05:51:39 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 4AF6BA5818A;
 Fri, 15 Aug 2025 09:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21A9C4CEF1;
 Fri, 15 Aug 2025 09:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755251497;
 bh=ab5UTvT/GCDban1iJ9Tp94X+3oXAu2MSA0YXBlB6PM4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ThOzW7QTs5VatZK6uiX5+1ogK/vOyBMGzlP8oUEMp8CnBTUBBJx6FJZVQ/Sk0PtR4
 NgV+v71Mo0BYwsxXlzCdHlazebSZuhgC562vhMIZBPGzWZccrq4B1TfO+32s+tXUqX
 amXyLpYUE6Z+nu4DZal7/wjpjW1PUe4cv8nwILJZuskBqwreAUMe1KIm1PCbrjrUY3
 1PYpweTUDXyyT0zi9m4VJO9q3W0CRLtLFiNPYn4xUJ5JxyCRPIsdo+OmsekyVREZJV
 RoZD2/GNL5407NJFrup9L80MyFhjfv7WlaO6/06tEaPkNNLhNyJdHPA2rLBwtaurvw
 HcNq+dxIAdpzQ==
Date: Fri, 15 Aug 2025 11:51:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow
 <jsnow@redhat.com>
Subject: Re: [PATCH for-10.2 2/8] tests/qtest/libqtest.h: Remove stray space
 from doc comment
Message-ID: <20250815115132.4af17dfa@foz.lan>
In-Reply-To: <20250814171324.1614516-3-peter.maydell@linaro.org>
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
 <20250814171324.1614516-3-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Em Thu, 14 Aug 2025 18:13:17 +0100
Peter Maydell <peter.maydell@linaro.org> escreveu:

> The doc comment for qtest_cb_for_every_machine has a stray
> space at the start of its description, which makes kernel-doc
> think that this line is part of the documentation of the
> skip_old_versioned argument. The result is that the HTML
> doesn't have a "Description" section and the text is instead
> put in the wrong place.
> 
> Remove the stray space.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

LGTM. Even the previous version should have handled it wrong here
(if not, it is a bug there - or perhaps QEMU version was using
a very old kernel-doc.pl  version).

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


> ---
>  tests/qtest/libqtest.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index b3f2e7fbefd..fd27521a9c7 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -977,7 +977,7 @@ void qtest_qmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
>   * @cb: Pointer to the callback function
>   * @skip_old_versioned: true if versioned old machine types should be skipped
>   *
> - *  Call a callback function for every name of all available machines.
> + * Call a callback function for every name of all available machines.
>   */
>  void qtest_cb_for_every_machine(void (*cb)(const char *machine),
>                                  bool skip_old_versioned);



Thanks,
Mauro

