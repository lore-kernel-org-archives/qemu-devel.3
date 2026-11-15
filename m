Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D0D606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 01:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xh3S1y0n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSlFd-0004MI-3M; Sun, 15 Nov 2026 20:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmaguire2013@gmail.com>)
 id 1xSjHl-0005d2-E0
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 18:05:21 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jmaguire2013@gmail.com>)
 id 1xSjHj-0004nV-QQ
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 18:05:21 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-56431524c22so864390b6e.0
 for <qemu-devel@nongnu.org>; Sun, 15 Nov 2026 15:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794783918; x=1795388718; darn=nongnu.org;
 h=to:cc:date:message-id:subject:mime-version
 :content-transfer-encoding:content-type:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SCxRiTneL5OsZfxKIjLFU67ZVb9Ij2rytydEUX8fHnw=;
 b=xh3S1y0nVg+9rU4N1964EnHsX+pS6sidHJQ5xgLDEwWRZMcHOh7QciyBfs1PdAVgWq
 FXNYfdFPuSEveCb5TO5m0ouhiDPk7GakGRoTlF//rnHcn637CuCUrdzQ2d2E9NL3NgEW
 FfKQgMQ2YtmyMJCf/18PkYdhz4NN1z/BZ44oRTJKxxjjYcY/GmELUfLF5Bpf7pl4vAZM
 u0mtmwPzTGPTcBvRVj8kgpFRaB1lF+S3rvUy802xj9gB2rhTyjrzBUhoFFUvEAdd3TC7
 jBPY/bwRAhiJUqqgaexbaMV6Os6txtW5pPf54DXQ5xYJnvTD6wc/VpPe1tTvfDhvmEFU
 0sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794783918; x=1795388718;
 h=to:cc:date:message-id:subject:mime-version
 :content-transfer-encoding:content-type:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SCxRiTneL5OsZfxKIjLFU67ZVb9Ij2rytydEUX8fHnw=;
 b=oWEMGnaLJAjvtuH4X38pQg06lDpMXTSdSANvUzQusyX9RrLxeCOVKkg40HXGX0hkuN
 C4X2ZdIRqoiTAAYWYQq6ZxrLu9hB1MB/KKqf9EEWMWXh/u8qTpQu2i3Dupl8SBbFTy2L
 isba+sagBkc+pjJNrdq1M05C07vyTSRPxUjj+a+pPhn9n2e7OWUyxveUzEReAQ1BitjQ
 9j3LIUOsXku5CXD74Gnb6D9Xyw2WgmObRchh0kc/JX68iq45opi9jLOusL22T1ugZEVd
 wmRLGDjMXPP/VoqE53ttnoYuC//ggOPpX3WcwEvzaH2D2fNUgjIYRkcLWr5IeO5a7Xxu
 KxrA==
X-Forwarded-Encrypted: i=1;
 AL+hErEACoHf1VP9SJ7uv7b6fpRR6iaC35o7EhUDJTifejr7W3wXPAzam7+bW9OqOt4tsZu3rIzKa51Grs2R@nongnu.org
X-Gm-Message-State: APuU4Z+xhZ0AeI92LHHt4GrasVQqtyywHg33QzmhhkdYjw33wpD/3h3b
 YJuek37HsMUx1Ef8d53TCGKFhKFP72QJxZfmj/VXVXseJfQYOdIwnLzn
X-Gm-Gg: AYBFou2c5E5gHyIsWnyJTgkuSmXUWkl/e4CdCzpE9OdDjv5YIu7kA8hSR/ftVr2Zo0h
 mvRPv4UqHfS1pwzwJXLFuqPxJ34Gtv4gMhBl88bBhOzztQEIdfdT6g9LQSYM4LAO19GoAjBmp1X
 qXeiBeB4X7La/YEnDvTDkBaZOw6zSKTnEdLpV+37oGUbGkfOTxL+RT8slIJLXk+YeUkbXoz5hWV
 xas7w5F7sxtXVbYRzRhBFzNaP0llW5TO/t1e/DpIW9E8H6iRPNJPypVKpU7XWd3gPYEW/ijZRn6
 RvqvluWe15BI/P0YVbPOaJpBECAJdV+NhAusV2KkGMsRbP2JsRwPk2zTvEmq6Pt8WIcMTapPb/y
 LLjgjcMV4UgRcSCcGgGBhrpoBdtH798NZEVX7Wg06dSC1xx3YmrBjsfmLkgFPJsOHH7NGOQxXsr
 Aqo/uPQNIji7mkAu+sOF48cuJCqA1k3YeivGUawOD8KB8PyCZkkxokeY7k74hv42VJOXBOAB3Xp
 EdWoW+r/DGncnRwELiFZtLGzTuBerowFZ+yZKpNhDzNtUmZQpwCdj0Md1JYLQ52LR/lG9ismNXP
 D7+mphRl8iJBhSnbtKI4v8i4DpuEHhTkL2zXBLkqI7DKiIqwE2cdHBD0dkFLdMrLaRGiHJ6SS5K
 226gujTUCcR4hG0PUl6u+crsEwQU528lh1ObcpBmmQnE7Vtl75W/AOaWFqglftCeNeepw1MPos3
 4SPg==
X-Received: by 2002:a05:6808:1687:b0:55c:6aa:14f7 with SMTP id
 5614622812f47-56e63ba9aa6mr6692316b6e.21.1794783918108; 
 Sun, 15 Nov 2026 15:05:18 -0800 (PST)
Received: from smtpclient.apple ([2600:1702:6402:e70:dcab:e7c1:b01f:56f1])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e6fc42a8asm8517095b6e.3.2026.11.15.15.05.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 15 Nov 2026 15:05:16 -0800 (PST)
From: John Maguire <jmaguire2013@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: Excessive IO PSI for iothread when using io_uring since QEMU 10.2
Message-Id: <4EF13FE7-E6F3-42E2-83F9-635310B028DE@gmail.com>
Date: Sun, 15 Nov 2026 18:05:09 -0500
Cc: axboe@kernel.dk, f.ebner@proxmox.com, fam@euphon.net, hreitz@redhat.com,
 kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 t.lamprecht@proxmox.com
To: stefanha@redhat.com
X-Mailer: Apple Mail (2.3901.200.71.1.16)
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=jmaguire2013@gmail.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 15 Nov 2026 20:11:14 -0500
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Jun 02, 2026, Stefan Hajnoczi wrote:
> Pinging Jens: io_uring accounts POLL_ADD SQEs as blocking I/O activity
> whereas select(2)/poll(2)/epoll_wait(2) do not. Would it make sense to
> follow the same accounting as the syscalls for this operation since that
> is probably expected?

Hello,

I run Incus on two hosts and see misleading iowait and IO pressure on
both since Incus 7.6, which puts virtio disks on a dedicated iothread by
default. Incus users now hit this without opting into iothreads.

Host 1: Arch Linux, stock QEMU 11.1.3, kernel 6.18.62, 16 CPUs, five
VMs. /proc/pressure/io shows about 80% "some" and 75% "full", with
20-30% iowait. The disks are lightly loaded (under 15% util), there are
no D-state tasks, the pressure is confined to the cgroup holding the
QEMU processes, and each QEMU process has one thread in io_cqring_wait.
It started the day I upgraded from Incus 7.5.1 to 7.6; QEMU 11.1.x had
been in use on this host since late September without it.

Host 2: Debian 13, kernel 6.12.116, 56 CPUs, four VMs, Zabbly's Incus
packages. These bundle QEMU 11.1.3 with the pve-qemu patch
"fdmon-io_uring: avoid idle event loop being accounted as IO wait".
Pressure is about 68% "some" and 65% "full" with disks under 1% util,
and again one thread per QEMU process in io_cqring_wait. This kernel
does not advertise IORING_FEAT_NO_IOWAIT (added in 6.15), so the patch
has no effect there.

So the downstream patch only helps on 6.15+ kernels, and distros
shipping unpatched QEMU get these numbers by default.

Is there a preferred way forward? Fiona offered to submit the Proxmox
workaround to qemu-devel, and Stefan asked whether io_uring should
instead account POLL_ADD the way poll(2) does. Either would fix this
for users on distro packages.

Best,
John

