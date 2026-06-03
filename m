Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4B1CD6E69
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfif-0003wu-VL; Wed, 03 Jun 2026 03:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUfib-0003P3-2K
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:08:49 -0400
Received: from msg-1.mailo.com ([213.182.54.11] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUfiZ-0000Hs-CP
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780468089; bh=VeGJ1v/nlhs/G9mJUhD1PczDluYPCDvqYti20zZBulA=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=iqgNTjji0vvJaM5VlSFynwnB53+AMjlHXToZz7DdfAkO0JFDNC3W1kax54BKXrXPB
 XfzXWYmqM6P3H2SsU8Jn1d/hmzFrdBDPf/a+GlENr4xYLx8+8J0S7/m26FvtFAGA66
 xhDAO/CxJNVdRvT+rBfqju4z32oh1c3nmPb7ue70=
Received: by be1-4.in.mailobj.net [192.168.91.14] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 08:27:34 +0200 (CEST)
X-EA-Auth: H9NGmQ3qedXzEeLLY9iIWmJ8rVzrsAMrL2M3gO9jXx44qzz6Vwp8M5lVPLCcbZiJ4NS6YTwiNImxZ2edyVRTHdhu62ccgWUW
Message-ID: <b3e40f92-6544-40ba-ab18-9171b6318ca1@mailo.com>
Date: Wed, 3 Jun 2026 08:27:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] gitlab: remove x64-freebsd-14-build Cirrus job
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Warner Losh <imp@bsdimp.com>
References: <20260602162457.828969-1-stefanha@redhat.com>
 <20260602162457.828969-2-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260602162457.828969-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.11; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 2/6/26 18:24, Stefan Hajnoczi wrote:
> Cirrus has shut down and the x64-freebsd-14-build is failing:
> https://gitlab.com/qemu-project/qemu/-/jobs/14656732122
> 
> Remove the x64-freebsd-14-build job to get the CI pipeline passing
> again. The next commit will be to remove Cirrus integration from the
> GitLab YAML and lcitool since it is no longer used.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   MAINTAINERS                         |  2 --
>   .gitlab-ci.d/cirrus.yml             | 14 --------------
>   .gitlab-ci.d/cirrus/freebsd-14.vars | 16 ----------------
>   tests/lcitool/refresh               |  5 -----
>   4 files changed, 37 deletions(-)
>   delete mode 100644 .gitlab-ci.d/cirrus/freebsd-14.vars
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7752917d8c..4ff33eb630 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4511,9 +4511,7 @@ W: https://travis-ci.org/qemu/qemu
>   FreeBSD Hosted Continuous Integration
>   M: Li-Wen Hsu <lwhsu@freebsd.org>
>   S: Maintained

This raise the question, is it still maintained?

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>

> -F: .gitlab-ci.d/cirrus/freebsd*
>   F: tests/vm/freebsd
> -W: https://cirrus-ci.com/github/qemu/qemu


