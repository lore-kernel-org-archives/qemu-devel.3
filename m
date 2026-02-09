Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AFBE81BDC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 16:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpToX-0003QT-Dm; Mon, 09 Feb 2026 11:08:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vpToM-0003Q4-Bm
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:08:32 -0500
Received: from k62.kb8c70eb.use4.send.mailgun.net ([204.220.184.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vpToI-0006si-Ls
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:08:30 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 60d7339544822972f0e8519ba5e1e1935cf7f5424221e30418ebc9edb98a229f with SMTP id
 698a06709ac41031d69f0933; Mon, 09 Feb 2026 16:08:16 GMT
X-Mailgun-Sending-Ip: 204.220.184.62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1770653295;
 bh=IRW9y5sksTmYFzPGHzob03PJ/KPsPvOO/DM2EoS8Ksg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=YsqPNiig2A5R1Dlax/hWV+Txf+fO8PTq58r2kTobmkfXBqxaUV5aDvXNsEgUpmFA2
 RvsZru4tMrINEOWz4pdMG2SSCuUrcQsbGh+0hW4OtHOe1OGCiYGPxryatUay6VAcLX
 c1xQtE16L2bkuetTP4welJ+OaWsXAQEyCEESUpp3JPAjHJHlha2PbHAYh+0drILpKt
 qP6chVfE/6Ut0o2luFTyHODDmkL6ThOTF2wmX9md1Ld0yq4i94z7HnBx3nPU/HN0lH
 XeEwEI7TlxyUHBnnRkRMdOT3J0z9BgKqJaGlQ1hX/YSKy2YlwZ7ko7TSGvsUPF2YFi
 RvqyY4urhf1/w==
Message-ID: <cba38de0-38c0-4d99-9d50-a028fa6510e0@yodel.dev>
Date: Mon, 9 Feb 2026 10:08:14 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] vhost-user-bridge housekeeping and test
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260129133049.119829-1-yodel.eldar@yodel.dev>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <20260129133049.119829-1-yodel.eldar@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.62;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k62.kb8c70eb.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi,

On 29/01/2026 07:30, Yodel Eldar wrote:
> Hi,
> 
> The existence check of the vhost-user-bridge file checks for None
> when it should check for False to determine whether the test should be
> skipped; a trivial fix.
> 
> Changes since v3:
> --------------------
> - Fix is_readable_executable_file() check of vubr for skipping test
> 
> Link to v3:
> -----------
> https://lore.kernel.org/qemu-devel/20260120215021.30711-1-yodel.eldar@yodel.dev/
> 
> Thanks,
> Yodel
> 
> Cover letter from v3:
> =====================
> 
> This series (1) moves vhost-user-bridge (vubr) from tests/ to
> contrib/vhost-user-bridge/, (2) introduces a basic functional test of
> vubr, and (3) adds UDP receive packet logging to vubr:
> 
> Patch 1: Moving vhost-user-bridge
> ---------------------------------
> After the introduction of vhost-user-bridge and libvhost-user, new
> vhost-user backend daemons were placed in dedicated subdirectories of
> contrib/. An F: line under the vhost section in MAINTAINERS grants these
> daemons coverage; in tests/, however, vhost-user-bridge lacks coverage
> and appears orphaned there. So, let's give it a home with the rest of
> the vhost-user backend family.
> 
> As part of the move, vhost-user-bridge also gains a section in the
> vhost-user-contrib document. More can be said about vubr there, like its
> client mode feature added in aef8486ede8b by Marc-André, but for now a
> short description and usage example will help folks interested in using
> the daemon to expand vhost-user support in QEMU.
> 
> Lastly, Patch 1 makes the necessary changes to the meson build files in
> tests/ and root, and the new one in contrib/vhost-user-bridge/.
> 
> Patch 2: Introducing a functional test
> --------------------------------------
> This test was inspired by discussions with Cédric regarding build errors
> from recent glibc const changes and was the subject of the first RFC.
> 
> The functional test introduced in the second patch starts vubr as a
> subprocess, then launches a single QEMU instance that provides a slirp
> stack and serves as the frontend of the vhost-user protocol, much like
> the testing setup described in vhost-user-bridge's initial commit in
> 3595e2eb0a23.
> 
> For additional details about the test, please see Patch 2's commit
> message and/or the test's header; in short: the host serves a file to
> the guest via tftp, then the guest serves a file to the host via http.
> 
> The guest's kernel image was built with Buildroot in a Containerfile
> that is based on a snapshot Debian container image, so that the kernel
> image remains bit-for-bit reproducible indefinitely. For the image and
> its build files, please see:
>      https://github.com/yodel/vhost-user-bridge-test
> The repo will be placed in archive (read-only) mode if/when the series
> is pulled.
> 
> Patch 3: Adding UDP RX logging
> ------------------------------
> An existing transmit hexdump of UDP packets provides valuable data;
> adding a receive hexdump to complement TX doubles the fun (read:
> visibility). Like TX, the RX hexdump is gated behind a currently
> hardcoded-on macro. Another new debug print separates transmit blocks
> from receives.
> 
> Changes since RFCv2:
> --------------------
> - Promoted to PATCH
> - Collect R-b's (thanks to Marc-André and Thomas)
> - Add test to .../x86_64/meson.build thorough suite (Marc-André)
> - Add encoding= args to open() (Thomas)
> - Add pylint disable=unbalanced-tuple-unpacking on find_free_ports()
> - Minor commit message rewording
> 
> Changes since RFCv1:
> --------------------
> - Remove external host dependency (Marc-André)
> - Use user netdev tftp feature (Thomas)
> - Use check_http_download (Thomas)
> - Remove wget
> - Inherit from LinuxKernelTest instead of QemuSystemTest
> - Use hardcoded UUIDs in files on the guest and host for data transfer
> - Use a Popen context manager to terminate and wait on vubr
> - Add test to MAINTAINERS under the vhost section (Michael)
> - New patch to move from tests/ to contrib/vhost-user-bridge/ and add
>    docs section
> - New patch to add RX debug logging in vhost-user-bridge.c
> 
> Links
> -----
> RFCv2:
> https://lore.kernel.org/qemu-devel/20260112230127.99125-1-yodel.eldar@yodel.dev/
> RFCv1:
> https://lore.kernel.org/qemu-devel/20251230002604.113632-1-yodel.eldar@yodel.dev/
> 
> Yodel Eldar (3):
>    tests/vhost-user-bridge: Move to contrib/vhost-user-bridge/
>    tests/functional/x86_64: Add vhost-user-bridge test
>    contrib/vhost-user-bridge: Add UDP receive hexdump
> 
>   MAINTAINERS                                   |   1 +
>   contrib/vhost-user-bridge/meson.build         |   4 +
>   .../vhost-user-bridge}/vhost-user-bridge.c    |   7 +
>   .../devices/virtio/vhost-user-contrib.rst     |  39 +++++
>   meson.build                                   |   1 +
>   tests/functional/x86_64/meson.build           |   1 +
>   .../x86_64/test_vhost_user_bridge.py          | 147 ++++++++++++++++++
>   tests/meson.build                             |   6 -
>   8 files changed, 200 insertions(+), 6 deletions(-)
>   create mode 100644 contrib/vhost-user-bridge/meson.build
>   rename {tests => contrib/vhost-user-bridge}/vhost-user-bridge.c (98%)
>   create mode 100755 tests/functional/x86_64/test_vhost_user_bridge.py
> 

Ping?

Note: All patches have been reviewed.

Link to v4:
https://lore.kernel.org/qemu-devel/20260129133049.119829-1-yodel.eldar@yodel.dev/

Thanks,
Yodel

