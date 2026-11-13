Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80625606A339
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=taktcycles.com header.i=@taktcycles.com header.a=rsa-sha256 header.s=takt1 header.b=iEgvtMY/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrkJ-0004Au-2k; Fri, 13 Nov 2026 08:55:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry@taktcycles.com>)
 id 1xRqWL-0006If-K0
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 07:36:45 -0500
Received: from mail.taktcycles.com ([136.243.71.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry@taktcycles.com>)
 id 1xRqWK-0000hk-8U
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 07:36:45 -0500
Received: from mail.taktcycles.com (unknown [192.168.64.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
 (No client certificate requested)
 by relay.taktcycles.com (Postfix) with ESMTPSA id 294398ADC;
 Fri, 13 Nov 2026 12:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=taktcycles.com;
 s=takt1; t=1794573397;
 bh=iYiA2dhFQZibTFV2bisn9nVAVcJp4GpHOr8SsnXEhUw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iEgvtMY/5KZB42Zk8zccyCKmjhkAiVZHKd4+fqNwOu/oxh3eipmUEzPMMs3GNoL7G
 wcnBf9QpKZvqy0piso/FLmjHxsWyS0KPlMYNTFSna+WJyNVXqrehN8qHAY+h+2Hsua
 WZ+KzSR5ZSP8dbywNCmDm5iUu12kKCJ009wTnyB2cl7U1N4La4UYJ0y2bHlO9wdNON
 jv3PPp9O4/B5FRfhY2SG1gpAFh+u2yTAsa3aKYbmMEc8Jk4vM7q96+cun1+C8EKszQ
 oZVKcMDVYPHWYV74B/zTt0veg3h/zU4CZt3jRAVetC38nSpmCCbsPgBBJIfffT4Jqz
 9OA4lQ7+fOTwQ==
Received: from [192.168.64.27] (localhost [127.0.0.1])
 by mail.taktcycles.com (Postfix) with ESMTP id BF10B1DF88;
 Fri, 13 Nov 2026 12:36:37 +0000 (UTC)
From: Dmitry R <rdmitry@taktcycles.com>
To: =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry R <rdmitry0911@gmail.com>
Subject: Re: [PATCH v2 0/8] vhost-user-gpu fixes
Date: Fri, 13 Nov 2026 12:36:37 -0000
Message-ID: <179457339706.955135.11315419667382138941@taktcycles.com>
In-Reply-To: <20261113-issue-4848-v2-0-631414664bca@redhat.com>
References: <20261113-issue-4848-v2-0-631414664bca@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=136.243.71.244;
 envelope-from=rdmitry@taktcycles.com; helo=mail.taktcycles.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Nov 2026 08:53:54 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marc-André,

On Fri, 13 Nov 2026 14:42:12 +0400, Marc-André Lureau wrote:
> Changes in v2:
> - add "hw/display/vhost-user-gpu: reset scanouts on the main loop"
>   patch, similar to virtio-gpu

Thanks for the quick v2. I ran our tests again on v2 on top of master
49559567: none of #4846-#4849 reproduces, and 4/8 fixes the abort on a
guest-initiated reset that I reported on v1 3/7. The only problem I
found is in 4/8 at finalize time; details are in my reply to that
patch.

A small request for v3: please use

  Dmitry R <rdmitry@taktcycles.com>

in my Reported-by and Tested-by tags. I use that address for upstream
work from now on.

Dmitry


