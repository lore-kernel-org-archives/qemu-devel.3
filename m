Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621C2CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 11:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoKXx-0000ln-Ch; Tue, 19 Aug 2025 07:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoKXj-0000Y7-72
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:30:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoKXd-0007oq-6g
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755603011;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bW9r81eTJO1+NmEj9X04r9TChtLY1Al95K6ojglJGNI=;
 b=CgRJ0nHE1L/D1cvxq8ADvs3RDp+t26s6cpTEJ6L1dph6rZrJsbgLrX0VLIQK0q4CVvrEbw
 wotMWNJmy1Jgddlfo8gFdPg2p3OVR4YYLHFnevl2RqvIyzzG1x+f5WxEpnVMzgLXjLY+3Q
 lBoYKTktBLUuMai4QwLCGPIGiJNV9t4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-APqv5sDXOQ2DYJ_Vj3EvyQ-1; Tue,
 19 Aug 2025 07:30:07 -0400
X-MC-Unique: APqv5sDXOQ2DYJ_Vj3EvyQ-1
X-Mimecast-MFC-AGG-ID: APqv5sDXOQ2DYJ_Vj3EvyQ_1755603006
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A97F319560B3; Tue, 19 Aug 2025 11:30:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.237])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9508F19560AB; Tue, 19 Aug 2025 11:30:04 +0000 (UTC)
Date: Tue, 19 Aug 2025 12:30:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] tests, scripts: Don't import print_function from
 __future__
Message-ID: <aKRgObageF20y5Xm@redhat.com>
References: <20250819102409.2117969-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819102409.2117969-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Aug 19, 2025 at 11:24:09AM +0100, Peter Maydell wrote:
> Some of our Python scripts still include the line
>   from __future__ import print_function
> 
> which is intended to allow a Python 2 to handle the Python 3 print()
> syntax. This particular part of the future arrived many years ago,
> and our minimum Python version is 3.9, so we don't need to keep
> this line around.
> 
> NB: the scripts in tests/tcg/*/gdbstub/ are run with whatever Python
> gdb was built against, but we can safely assume that that was a
> Python 3 because our supported distros are all on Python 3.  In any
> case these are only run as part of "make check-tcg", not by
> end-users.
> 
> Commit created with:
> 
>  sed -i -e '/import print_function/d' $(git grep -l 'from __future__')
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  scripts/userfaultfd-wrlat.py                           | 1 -
>  tests/guest-debug/test_gdbstub.py                      | 1 -
>  tests/tcg/aarch64/gdbstub/test-mte.py                  | 1 -
>  tests/tcg/aarch64/gdbstub/test-sve-ioctl.py            | 1 -
>  tests/tcg/aarch64/gdbstub/test-sve.py                  | 1 -
>  tests/tcg/multiarch/gdbstub/interrupt.py               | 1 -
>  tests/tcg/multiarch/gdbstub/memory.py                  | 1 -
>  tests/tcg/multiarch/gdbstub/sha1.py                    | 1 -
>  tests/tcg/multiarch/gdbstub/test-proc-mappings.py      | 1 -
>  tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py    | 1 -
>  tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py | 1 -
>  tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py  | 1 -
>  tests/tcg/s390x/gdbstub/test-signals-s390x.py          | 1 -
>  tests/tcg/s390x/gdbstub/test-svc.py                    | 1 -
>  14 files changed, 14 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


