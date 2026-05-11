Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1F9CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMURo-0004Cc-9g; Mon, 11 May 2026 13:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMURn-0004CR-K4
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:29:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMURl-0000dZ-VB
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778520577;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NHZ0yZXWzSYJ60A7cwY7RklRsp/OhDdU3qguIYET+yE=;
 b=XCWXDPkJbZMbT0z1BWn4SCLoR+sYsWYFrkFY1zcKnyOwT+ZU/fk1sxROonZKR/KXJCGw4S
 Kar3gJA79/WIDzWf6O9nAyos8rBZ/+QHKw1E7J/zSHpKYdDcrepCYBxP6pC0bk+cJF55wu
 CEi/R9g98+Qi+B8fHZc4kuYCJbqyAh4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-ZzTFY3-YOgCaFNR8DVDl1w-1; Mon,
 11 May 2026 13:29:32 -0400
X-MC-Unique: ZzTFY3-YOgCaFNR8DVDl1w-1
X-Mimecast-MFC-AGG-ID: ZzTFY3-YOgCaFNR8DVDl1w_1778520571
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A67F19560AA; Mon, 11 May 2026 17:29:31 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 781C018004A3; Mon, 11 May 2026 17:29:29 +0000 (UTC)
Date: Mon, 11 May 2026 18:29:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
Subject: Re: [RFC PATCH v2] gitlab: update issue template for binary test cases
Message-ID: <agIR9Q5xjjdu4J7R@redhat.com>
References: <20260511161757.105994-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511161757.105994-1-alex.bennee@linaro.org>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 11, 2026 at 05:17:57PM +0100, Alex Bennée wrote:
> Binary test cases are sketchy because they can be vectors for phishing
> and other malware. Lets strongly hint that source bases tests are
> preferred and binaries should have their provenance declared.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - typos
> ---
>  .gitlab/issue_templates/bug.md | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/.gitlab/issue_templates/bug.md b/.gitlab/issue_templates/bug.md
> index 53a79f58284..e20f586008d 100644
> --- a/.gitlab/issue_templates/bug.md
> +++ b/.gitlab/issue_templates/bug.md
> @@ -55,6 +55,10 @@ https://www.qemu.org/contribute/security-process/
>  <!--
>  Attach logs, stack traces, screenshots, etc. Compress the files if necessary.
>  If using libvirt, libvirt logs and XML domain information may be relevant.
> +
> +If attaching binary test cases you should describe where they were obtained
> +from, preferably linking to the original source. We greatly prefer test cases in
> +the form of source code that can be audited before compiling by the engineer.
>  -->

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


