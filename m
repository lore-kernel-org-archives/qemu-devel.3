Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C72DCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 16:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6X27-0007Rt-2z; Wed, 08 Oct 2025 12:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6X23-0007RU-BQ
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6X1q-0007Nb-8o
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759940912;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmb1/+k2ieg5sZebGl7x/NmTsZC2vdm7lt3z6ZHDvpw=;
 b=Q3cjZJiWvsShL/Zs03Gh+podq905kKCFaHAOz2AZrUxu4qdEDBM1IAbsCBgW5ojbCfqIm2
 crAhRKDCF4dRPm75ZaCR1gF40QEe3ESzNyHh4iMafK6XQcekXRTjAxSOaUkL+Y78d35qdl
 uM+0Ldw9ooNwRCvRlWpJQqr3Ts3AB4A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-0JMZbgTkMUCBJlgmOiKPoA-1; Wed,
 08 Oct 2025 12:28:28 -0400
X-MC-Unique: 0JMZbgTkMUCBJlgmOiKPoA-1
X-Mimecast-MFC-AGG-ID: 0JMZbgTkMUCBJlgmOiKPoA_1759940907
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A5B318002C1; Wed,  8 Oct 2025 16:28:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.74])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D884E1800452; Wed,  8 Oct 2025 16:28:23 +0000 (UTC)
Date: Wed, 8 Oct 2025 17:28:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 0/4] tests: do more testing of block drivers in CI
Message-ID: <aOaRI6XdgeHlMyrB@redhat.com>
References: <20251008113552.747002-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251008113552.747002-1-berrange@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Oct 08, 2025 at 12:35:48PM +0100, Daniel P. Berrangé wrote:
> The recent set of regressions identified in the LUKS block driver
> re-inforced that despite having a hugely useful set of I/O tests,
> our CI coverage is still letting through too many bugs.
> 
> This series expands the meson suites / make targets for running
> I/O tests for more drivers, and then creates a CI job for each.
> 
> While the first three patches are functionally usable as is, the
> last patch for gitlab is very much an RFC. A test pipeline
> 
>   https://gitlab.com/berrange/qemu/-/pipelines/2085907042
> 
> shows passes for qcow2, qed, vmdk & vpc, but failures for luks,
> nbd and raw.
> 
> The luks failures all have patchs floating around pending merge.
> 
> The nbd failures are problems with non-deterministic output
> ordering, or warnings from python deprecations that need
> addressing.
> 
> The raw failures are problems with python deprecations, and
> insufficient permissions checks wrt device mapper acess.

The raw / nbd deprecations are:

/usr/lib64/python3.9/asyncio/trsock.py:20: DeprecationWarning: Using sendmsg() method on sockets returned from get_extra_info('socket') will be prohibited in asyncio 3.9. Please report your use case to bugs.python.org.
  warnings.warn(
DeprecationWarning: Enable tracemalloc to get the object allocation traceback


This comes from send_fd_scm in qmp_client.py where it does

        sock = self._writer.transport.get_extra_info('socket')

        if sock.family != socket.AF_UNIX:
            raise QMPError("Sending file descriptors requires a UNIX socket.")

        if not hasattr(sock, 'sendmsg'):
            # We need to void the warranty sticker.
            # Access to sendmsg is scheduled for removal in Python 3.11.
            # Find the real backing socket to use it anyway.
            sock = sock._sock  # pylint: disable=protected-access

        sock.sendmsg(
            [b' '],
            [(socket.SOL_SOCKET, socket.SCM_RIGHTS, struct.pack('@i', fd))]
        )


As that comment says, the 'sendmsg' method has been removed
from the TransportSock object returned by 'get_extra_info',
with asyncio offering no replacement. The code above grabs
the private sock._sock handle, which is rather gross, but
we lack better options.

The problem in CI is that I picked CentOS 9 which has py 3.9
which still has the 'sendmsg' method. On newer distros
'sendmsg' is gone, so we grab the private sock._sock and
so dno't see a deprecation message.

IMHO we need to revert this previous change, so we avoid
calling the deprecated method at all:

  commit a57cb3e23d5ac918a69d0aab918470ff0b429ff9
  Author: John Snow <jsnow@redhat.com>
  Date:   Thu Nov 18 15:46:20 2021 -0500

    python/aqmp: fix send_fd_scm for python 3.6.x
    
    3.6 doesn't play keepaway with the socket object, so we don't need to go
    fishing for it on this version. In fact, so long as 'sendmsg' is still
    available, it's probably preferable to just use that method and only go
    fishing for forbidden details when we absolutely have to.
    
    Reported-by: Thomas Huth <thuth@redhat.com>
    Signed-off-by: John Snow <jsnow@redhat.com>
    Reviewed-by: Willian Rampazzo <willianr@redhat.com>
    Message-id: 20211118204620.1897674-8-jsnow@redhat.com
    Signed-off-by: John Snow <jsnow@redhat.com>

  diff --git a/python/qemu/aqmp/qmp_client.py b/python/qemu/aqmp/qmp_client.py
  index f987da02eb..8105e29fa8 100644
  --- a/python/qemu/aqmp/qmp_client.py
  +++ b/python/qemu/aqmp/qmp_client.py
  @@ -639,9 +639,12 @@ def send_fd_scm(self, fd: int) -> None:
           if sock.family != socket.AF_UNIX:
               raise AQMPError("Sending file descriptors requires a UNIX socket.")
 
  -        # Void the warranty sticker.
  -        # Access to sendmsg in asyncio is scheduled for removal in Python 3.11.
  -        sock = sock._sock  # pylint: disable=protected-access
  +        if not hasattr(sock, 'sendmsg'):
  +            # We need to void the warranty sticker.
  +            # Access to sendmsg is scheduled for removal in Python 3.11.
  +            # Find the real backing socket to use it anyway.
  +            sock = sock._sock  # pylint: disable=protected-access
  +

The need for 3.6 compat no longer exists since we bumped
min python, so that justification for that original
commit is now obsolete.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


