Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7016FC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 13:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAUHs-0008Qd-Tl; Thu, 01 May 2025 09:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uAUHk-0008P8-23
 for qemu-devel@nongnu.org; Thu, 01 May 2025 09:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uAUHX-0003vZ-BH
 for qemu-devel@nongnu.org; Thu, 01 May 2025 09:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746107329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7RqEd0mQGX3qA+t4qiyds6+3BbaYAEU/Hw+TLjSHeZU=;
 b=EYufkU5Bu/Z5VOO30TUeBJewnMJsN3qAmlxNwgN28gT2HBptkxYSOSKZRwT3ZgFT1qa7ai
 6jcxzosrI4sKrFbsvRj+Yjf9T2YHMVxelUWoSbKvgHf5TVuHfGREfm+qhLuT8zkInRZKWb
 NWr7MBInzQiWja3UwLLNVzfw4XqX6Cw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-7ukF0ukmP9-0HJUBTn3udg-1; Thu,
 01 May 2025 09:48:46 -0400
X-MC-Unique: 7ukF0ukmP9-0HJUBTn3udg-1
X-Mimecast-MFC-AGG-ID: 7ukF0ukmP9-0HJUBTn3udg_1746107325
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C5E0180036E; Thu,  1 May 2025 13:48:45 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.84])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A3F319560B1; Thu,  1 May 2025 13:48:42 +0000 (UTC)
Date: Thu, 1 May 2025 08:48:40 -0500
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Dario Faggioli <dfaggioli@suse.com>
Subject: Re: [PATCH] docs: Don't define duplicate label in
 qemu-block-drivers.rst.inc
Message-ID: <s3h4pvu3movhianyqjpc6mkwnbljswlmxeoejbjcrpvs6rztls@jg66bbqyaeex>
References: <20250501093126.716667-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501093126.716667-1-peter.maydell@linaro.org>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, May 01, 2025 at 10:31:26AM +0100, Peter Maydell wrote:
> Sphinx requires that labels within documents are unique across the
> whole manual.  This is because the "create a hyperlink" directive
> specifies only the name of the label, not a filename+label.  Some
> Sphinx versions will warn about duplicate labels, but even if there
> is no warning there is still an ambiguity and no guarantee that the
> hyperlink will be created to the right target.
> 
> For QEMU this is awkward, because we have various .rst.inc fragments
> which we include into multiple .rst files.  If you define a label in
> the .rst.inc file then it will be a duplicate label.  We have mostly
> worked around this by not putting labels into those .rst.inc files,
> or by adding "insert a label" functionality into the hxtool extension
> (see commit 1eeb432a953b0 "doc/sphinx/hxtool.py: add optional label
> argument to SRST directive").
> 
> Unfortunately in commit 7f6314427e78 ("docs/devel: add a codebase
> section") we accidentally added a duplicate label, because not all
> Sphinx versions warn about the mistake.
> 
> In this case the link was only from the developer docs codebase
> summary, so as the simplest fix for the stable branch, we drop
> the link entirely.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 1eeb432a953b0 "doc/sphinx/hxtool.py: add optional label argument to SRST directive"
> Reported-by: Dario Faggioli <dfaggioli@suse.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Acked-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


