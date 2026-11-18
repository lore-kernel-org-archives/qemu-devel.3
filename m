Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D23606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ft5CwThh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTlgn-0003EH-GF; Wed, 18 Nov 2026 14:51:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1xTlgl-0003E1-65
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 14:51:27 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1xTlgj-0007VC-0v
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 14:51:26 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-71ad099391dso809931eaf.3
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 11:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795031483; x=1795636283;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=j6UTOkFC7Y6Rqa9DT4E5hIfH71FNY3Z1jFeEooceKHI=;
 b=ft5CwThh/OOdtzMfg3/RR+TPgYnBideVWGxSBEuOlWK3T459MHvhAhsib1qeJ9J3wk
 HRF6Y32SJLWP5rOXOApRXxfVTj5HDHshZ7r1fOWkJH9OwK62CHwG3iMiPyk4+V8tX7qx
 scHioCUbDwRT8tZhaBs3sCuzslCguBQ3jGqPunQtUZdcS1sq4PDsdVpBUZ5Y++kQcZ2L
 eSQupJffSY6xezL6TAhUDaYAoduvrqFNGbBLRbOzUAO3ROr4rlHwRvhRb32IqF/DYYSh
 HaeBCsdr+iNBc2RoFBsc7TcT+5QMltqa/sCSxjflmv6+lSTopII9uB2FFjSzi4+Mv3Ap
 LSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795031483; x=1795636283;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j6UTOkFC7Y6Rqa9DT4E5hIfH71FNY3Z1jFeEooceKHI=;
 b=t5PEro04NQfkf1mkUSI+TJjkZZj+qm9wno/99QTzK2zV6o9JX0ZinRClXegtUpykYw
 5/r+WahQZ2Muh3nSwVhv8BD5ZrXQN1seWMuRp3VKyMu5DsNMmvrUycd0qzmxzWFVhaH1
 nf2Mhb7n+JePwH66G3Xrvx4/JEiIfDGc9DCaPgNWrl3kxOQ/OOMOajEENb3O5JvwclH9
 RLUOIQkjVovS1LCS9vTaW3ZkYjpD4diMD/vFHLSjuKEQHh9ky0HFpHDwnX7rGuz7CSQo
 5PlnCzV+fBVQMU3f1Uu+as7FEjsuyNVqvUCNaDLlbkRSbGSH/fyfEUXWBZVFih5EWsg+
 mMBQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFXbQWW+gikpslXN36wM1HItt9JiTzE70eTVYdDTId3HpbrBgpYfWmI+Z6fQPVcXMN+RLKB8FcJ41c3@nongnu.org
X-Gm-Message-State: APuU4Z+fja5hMim51aTZ+owTXdnlmeVPSlxsr76Ce+3cc2gJZG8Zunhc
 q8JR35XH9yFUcXYJ6l2cCx502FJhrvDBfDefj3EIwKnPHDnX25L9ela1A+FXfoCRrK0=
X-Gm-Gg: AYBFou2DkD1tNBybqu6o/BFsjlH92/VRh5/GeM6w6992es1s9d1dIYvbw/D4bLiaGPO
 M0RqFsZWR2xRJg2SzlqgoQgbIn1E5PZY4w3DDmTNnHGcpXfIWrWT25h0Ak/ha4qpwlBYKo61zWK
 2EP8ayb2lfsrN22riEET7F8wELF0moxzHsOxOBRW15oitBjj3ImTkA5R60BWhYiEJ36dL7p41GP
 0PgRMfE4KUQm/jGQKACy/Md41d+WRG9U7/1T0s7UzjyfcLIBLuG9pyeXwVJleJVy86SNiDizppD
 D4GeP11hQC6NTLbtGo3/eJjg0nZEslVeXfHnajJwr8hxUzXptq2cJvQzEiVNa8Cp8A8jtmcjoxU
 iFnT2qIqsBrNQUyPpkWXbY1/UexvL/uAihTGfCqLcPYaI71VN2PoN6BkoAFZ7f36tR4XRE28Yu9
 XFez2pZkRvF/BVkymyoVoZDQjXFS1+xDbZ0lXwySU3PsLH/IGljfarzANr1W7WVWD+wFVh52980
 r3EgcIobQbdAf2Jk6m4Qy50mpI6CdG6yXoRbWjQ0Vt8sr5zn7lSYmhEJ3wi30mNWmDYjs/kGUCT
 VpuxPlvF+KeYlvcOcl/qBUYEI5NVTvSMzQRBQlrFoqM4xWFCGuuG7yde9eimkB8Mh0gibCGu/9R
 mpMkwLdFVqTQE4YZu00sd/pmtk+ke9l6p5SO2CHbhbRUSa9k=
X-Received: by 2002:a05:6820:83c5:10b0:71a:ecfc:442c with SMTP id
 006d021491bc7-71b18609a5bmr1945991eaf.71.1795031483032; 
 Wed, 18 Nov 2026 11:51:23 -0800 (PST)
Received: from [192.168.0.102] ([96.43.243.2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862f0239a3fsm2834648a34.20.2026.11.18.11.51.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 11:51:22 -0800 (PST)
Message-ID: <962d44d3-ca7b-4cc8-b0f7-77fb8d63cf41@kernel.dk>
Date: Wed, 18 Nov 2026 12:51:21 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Excessive IO PSI for iothread when using io_uring since QEMU 10.2
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: John Maguire <jmaguire2013@gmail.com>, f.ebner@proxmox.com,
 fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, t.lamprecht@proxmox.com
References: <4EF13FE7-E6F3-42E2-83F9-635310B028DE@gmail.com>
 <3069e3f8-2cbf-436f-bf35-303fc90001ce@kernel.dk>
 <20261118185617.GA670091@shajnocz.csb>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261118185617.GA670091@shajnocz.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=axboe@kernel.dk; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 11:56 AM, Stefan Hajnoczi wrote:
> On Wed, Nov 18, 2026 at 08:58:11AM -0700, Jens Axboe wrote:
>> On 11/15/26 4:05 PM, John Maguire wrote:
>>> On Tue, Jun 02, 2026, Stefan Hajnoczi wrote:
>>>> Pinging Jens: io_uring accounts POLL_ADD SQEs as blocking I/O activity
>>>> whereas select(2)/poll(2)/epoll_wait(2) do not. Would it make sense to
>>>> follow the same accounting as the syscalls for this operation since that
>>>> is probably expected?
>>>
>>> Hello,
>>>
>>> I run Incus on two hosts and see misleading iowait and IO pressure on
>>> both since Incus 7.6, which puts virtio disks on a dedicated iothread by
>>> default. Incus users now hit this without opting into iothreads.
>>>
>>> Host 1: Arch Linux, stock QEMU 11.1.3, kernel 6.18.62, 16 CPUs, five
>>> VMs. /proc/pressure/io shows about 80% "some" and 75% "full", with
>>> 20-30% iowait. The disks are lightly loaded (under 15% util), there are
>>> no D-state tasks, the pressure is confined to the cgroup holding the
>>> QEMU processes, and each QEMU process has one thread in io_cqring_wait.
>>> It started the day I upgraded from Incus 7.5.1 to 7.6; QEMU 11.1.x had
>>> been in use on this host since late September without it.
>>>
>>> Host 2: Debian 13, kernel 6.12.116, 56 CPUs, four VMs, Zabbly's Incus
>>> packages. These bundle QEMU 11.1.3 with the pve-qemu patch
>>> "fdmon-io_uring: avoid idle event loop being accounted as IO wait".
>>> Pressure is about 68% "some" and 65% "full" with disks under 1% util,
>>> and again one thread per QEMU process in io_cqring_wait. This kernel
>>> does not advertise IORING_FEAT_NO_IOWAIT (added in 6.15), so the patch
>>> has no effect there.
>>>
>>> So the downstream patch only helps on 6.15+ kernels, and distros
>>> shipping unpatched QEMU get these numbers by default.
>>>
>>> Is there a preferred way forward? Fiona offered to submit the Proxmox
>>> workaround to qemu-devel, and Stefan asked whether io_uring should
>>> instead account POLL_ADD the way poll(2) does. Either would fix this
>>> for users on distro packages.
>>
>> We can just queue up the patches for stable so they bubble back to
>> older versions, I think that's the cleanest approach and gets us
>> a unified interface across supported kernel versions.
> 
> Fiona: On the QEMU side, please submit the QEMU IORING_FEAT_NO_IOWAIT
> patch upstream and let's merge it on qemu.git/master and
> qemu.git/stable. Given that the kernel feature is available, QEMU might
> as well use it.
> 
> Jens: I still think io_uring operations should perform accounting inside
> the kernel the same way as the equivalent syscalls do (e.g. poll(2) does
> not count as iowait).

And slow everything down...

> Pushing the responsibility of deciding what counts as iowait to
> userspace via IORING_FEAT_NO_IOWAIT means the decision is duplicated in
> every application that uses io_uring. That only makes sense to me if
> accounting should work differently on a per-application basis and
> applications therefore need full control. I'm not aware of applications
> actually wanting to do that? Or is iowait fundamentally incompatible
> with io_uring so that applications are the only ones who can decide?

iowait is fundamentally incompatible with sane accounting in the first
place, that is the problem. It really tells you nothing, and was
deprecated since the days of uniprocessor systems. The problem here is
not how iowait is done in the kernel, it's that people are using this
metric in the first place. Which is why you just want to NOT do that,
and do sane accounting on your disk drives, if you care about that kind
of thing.

Which is why I refuse to cater to any kind of iowait accounting metrics,
it's just adding overhead to support a metric that is largely
nonsensical in the first place. It doesn't answer any questions that an
application/tier owner would want to know. Those questions might be
things like "am I I/O bound?" or "is the device I'm using being slow?".
I wish people would realize that, rather than continue to place value in
iowait as a metric for ANYTHING, and stop trying to work around it.

-- 
Jens Axboe

