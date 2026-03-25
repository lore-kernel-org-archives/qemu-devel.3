Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B4A109C03D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RH6-0003c9-CP; Wed, 25 Mar 2026 12:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lawrence.hunter@codethink.co.uk>)
 id 1w5RH3-0003aW-A8
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:40:05 -0400
Received: from imap5.colo.codethink.co.uk ([78.40.148.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lawrence.hunter@codethink.co.uk>)
 id 1w5RH1-0003Ni-9F
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
 Reply-To; bh=3rIH4W0DPUEYdLNMSMbUre7ZSuzB7pOdYtVMvUaVvZY=; b=sCVRudSXRuf21B4B
 13P5C7vrIrz4pXFmnXleTJ8K1jrDYvjREUKjB8VvbubzU2YkH2KvNRt4dEYxOorZo8diDBCHLghCR
 VgkZmSMwJ1eHqSwXRzGqvznUJalKNneeaj+3+EG04mhfVtB2O7c6aKO1In8/Iauo6I6//ukV4QQA7
 LYxCH3qOmuQStl/KCUPNytiiugfMYlpzSxEPFHAOpf1zy8Imo8hBjXRcyFkMRb8V0opEBIj5+Wj3t
 a1VB9vOGKuaRiAirX8THspSD3GVcXOP035BMmNpHI5KSLPOmmWxCTEnVyo6jBfcZJGJmpMM8IC69l
 Cud4/uGWm9oezlGdMQ==;
Received: from ipa12.colo.codethink.co.uk ([78.40.148.178]
 helo=webmail.codethink.co.uk)
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1w5PZx-009AA6-Ip; Wed, 25 Mar 2026 14:51:29 +0000
MIME-Version: 1.0
Date: Wed, 25 Mar 2026 14:51:29 +0000
From: Lawrence Hunter <lawrence.hunter@codethink.co.uk>
To: Andreas Schwab <schwab@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: Generic way to detect qemu linux-user emulation
In-Reply-To: <mvm1puuiqvu.fsf@suse.de>
References: <mvm1puuiqvu.fsf@suse.de>
Message-ID: <903bec01a83b0c5580cd513ab85b0552@codethink.co.uk>
X-Sender: lawrence.hunter@codethink.co.uk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=78.40.148.171;
 envelope-from=lawrence.hunter@codethink.co.uk; helo=imap5.colo.codethink.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

I don't have anything to offer around cython but I am also noticing this 
posix_spawn issue with systemd >= tag v255 running inside a cross-arch 
container. systemd specifically is fine under full QEMU or on an ARM64 
host but when ran cross and therefore through qemu-user I see systemd 
failing to fork off any processes i.e. immediately after posix_spawn the 
child process is dying with SIGCHLD.

```
[  OK  ] Reached target rpcbind.target.
Wed 2026-03-25 14:08:10 UTC src/core/service.c:1627: rpcbind.service: 
Will spawn child (service_enter_start): /usr/sbin/rpcbind
Wed 2026-03-25 14:08:10 UTC src/core/service.c:1658: rpcbind.service: 
Passing 3 fds to service
Wed 2026-03-25 14:08:11 UTC src/core/execute.c:345: rpcbind.service: 
About to execute: /usr/sbin/rpcbind "\$RPCBIND_OPTIONS" -w -f
Wed 2026-03-25 14:08:11 UTC src/core/execute.c:472: rpcbind.service: 
Forked /usr/sbin/rpcbind as 37
Wed 2026-03-25 14:08:11 UTC src/shared/fdset.c:71: Closing set fd 40 
(socket:[1181504])
Wed 2026-03-25 14:08:11 UTC src/shared/fdset.c:71: Closing set fd 39 
(socket:[1181503])
Wed 2026-03-25 14:08:11 UTC src/shared/fdset.c:71: Closing set fd 38 
(socket:[1181501])
Wed 2026-03-25 14:08:11 UTC src/shared/fdset.c:71: Closing set fd 41 
(socket:[1193529])
Wed 2026-03-25 14:08:11 UTC src/core/service.c:1269: rpcbind.service: 
Changed dead -> start
          Starting rpcbind.service...
Wed 2026-03-25 14:08:11 UTC src/basic/log.c:1456: Received SIGCHLD from 
PID 37 (11).
Wed 2026-03-25 14:08:11 UTC src/core/manager.c:2804: Child 37 (11) died 
(code=exited, status=1/FAILURE)
Wed 2026-03-25 14:08:11 UTC src/core/manager.c:2769: init.scope: Child 
37 belongs to init.scope.
Wed 2026-03-25 14:08:11 UTC src/core/manager.c:2769: rpcbind.service: 
Child 37 belongs to rpcbind.service.
Wed 2026-03-25 14:08:11 UTC src/core/unit.c:6066: rpcbind.service: Main 
process exited, code=exited, status=1/FAILURE
Wed 2026-03-25 14:08:11 UTC src/core/unit.c:6024: rpcbind.service: 
Failed with result 'exit-code'.
Wed 2026-03-25 14:08:11 UTC src/core/service.c:1980: rpcbind.service: 
Service will not restart (restart setting)
Wed 2026-03-25 14:08:11 UTC src/core/service.c:1269: rpcbind.service: 
Changed start -> failed
Wed 2026-03-25 14:08:11 UTC src/core/job.c:997: rpcbind.service: Job 91 
rpcbind.service/start finished, result=failed
[FAILED] Failed to start rpcbind.service.
See 'systemctl status rpcbind.service' for details.
```

I have narrowed it down to 
https://github.com/systemd/systemd/commit/bb5232b6a3b8af075ee06cc87416e5f49a6170d3 
as being the change which breaks qemu-user mode with a bisect, and the 
key bit seems to be around 
https://github.com/systemd/systemd/blob/7e37e01768e2f223750ead2c9e08b4490243b8d1/src/basic/process-util.c#L2110 
other fixes I found online around credentials or protect/restrictions do 
not seem to make a difference.

This can be reproduced by:
```
docker run --privileged --platform linux/arm64 -it fedora:40 /bin/bash
$ dnf install -y systemd
$ exec /sbin/init
```

Any help around this issue would be greatly helpful too.

Best,
Lawrence

On 2025-03-18 10:18, Andreas Schwab wrote:
> Is there a generic way for a program to detect that is it being run
> inside the linux-user emulation?
> 
> The purpose for that would be to work around limitations of the
> emulation, like CLONE_VFORK being unsupported.  For example, python >=
> 3.13 needs to avoid using posix_spawn in that case, because the
> emulation of CLONE_VFORK as a true fork makes it impossible for it to
> report errors back to the parent process.
> 
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA 
> B9D7
> "And now for something completely different."

