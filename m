Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8C4606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fJlhW3Bm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTi3C-00010N-C4; Wed, 18 Nov 2026 10:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1xTi38-0000zO-FE
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:58:18 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1xTi36-0002ov-OO
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:58:18 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-5430f70c827so16377531cf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 07:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795017495; x=1795622295;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SmiYKmKhMJKdc6v5Z1QJMm/wFfG9coAJJC7PvUOMIVQ=;
 b=fJlhW3BmSmhXrvXbzcnj24rMxJYnlza27S2xkr+igAuLLda0MYYZWzZlBjA4kp8I9h
 Ypciwc0mlFXN4TzoFxxD+EkrW77CwZFRCommyUed/wcHb+zVQoCtMA/2YmBs1lKLdKUo
 SUdn4H6nwQGVmLKzk4LJCHEIyCSqg55wD25U+ZJqOCSLV4VL1KF/hvzWfHViCGCDlVW6
 9m4g9q5T+4gjeNWgDWq96KL943aaZgkCmqbmu+o8HFJd5o6dyVQmgFVLy7A+LVozgmkc
 bcAUDs82aR5rMPE8slKZA05sweUwIILNCLLeUoQTkLSzERrmedLACR+/OgxmmLSQgkRZ
 N0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795017495; x=1795622295;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SmiYKmKhMJKdc6v5Z1QJMm/wFfG9coAJJC7PvUOMIVQ=;
 b=s/fybRqW55YN/FyevMQKs+FejNBIHIC6esZUAid3TTr8lH2OWLh7IReWN7fEl34BCx
 Gj/odngx1XDdm3nYmYTdz4SkGhHdm8FMZXsVSDLt1dQucxE12GgAq0kAHfPtT08gliYw
 V6V64OXwwJpwCbg0pv8tuzgsXNPg/SIE9CkKocEzn0NmHoBBUCrefAmQfDI+u2S/n9A5
 589brBA9dmRS2ggZXaH8oTTCRsR6qCPhxO6e3lvInIGGj+mbjNxR+AA3AJNplwhpmx5c
 dIaL4dV1uRHmVYLsWobXIm2qJmpIzfNfQoQhRg3pI8f+rGTw4wFdhjNOZhBLFAxvHf8p
 qcMQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH1p4XCJvoCVJJRvNDnVw56gkCdSQIbBLIGnTA48tKjhUui0y0pjVGEnPq1cSvpBQGyy+66lBpKZlK7@nongnu.org
X-Gm-Message-State: APuU4Z+0XDfYRHtMTMyPAklt2ZjCCgqL4DGXYG9W1ZFoF0Qdr9oybGo6
 iC9RMdLK9FX1mdL+lLyxZ3KOAj/EM2byuKtd1MSIZLjxZ6udpa5MBBY7FA/T8HooKGg=
X-Gm-Gg: AZFdTZfQglB2OKOwW6/I1KCbIUlVi90/LKUJEGgM1fjXTvLzRT1BlqKTpvERsLpFGee
 C8Sl8wwj3XGNT2cmzP3n6tikMZ9rnuALS4VShWcowgdgx2otzZXXEfrF4jpK1NYmD/t/4X+65Nb
 QBGUKR124tIWYHg5mfeDxtC5qpqF1tpfr1SdVXUnrMZgxXc9BQgVCtmkhEle9Kj3KaumqYHQDVs
 dHd24FuRfBKrg3Z1PAtX95ftbqXOL8NIysLnkhw40h2vKwyNqUzrB2V4xOdB20Ot6gp2FYMR+HG
 28U+Hhv2IdUXJgogVqAitULvCS16n8VNBh3VnclNJmC/mloSEnxAOwHm9kSMDLhFEau1Kkourti
 TY6ypOeeobtgjYQKQe8lbWSK3zYRpqyQrMSc61n1emRwT6BiE3kFFdFg3KbowLlXzy7r0QKfRAv
 WMMnO6ssmQD4dTpJO2dCCceKy9JzoUe4at3r3h+hNa7HnA5G/Yy4ijWjCUuaUSwiEAvX3mULIy/
 nKxBSca68R6XK8ntsoCOLTSSwG94l/t1D6LnL9460FD2EWlcpnBWolhAIJhvfEWSqDpW4NaaM6l
 MGkFsxlZImBM+b0/mSkLxBlfmAprgmKPxlYt7Ym3smXybVZ4jr1eO4V7PkEi6X2mREokFBxXuOU
 Rlo74Oi4HrxE/94euj28PXRhrlU8VBdh7aCCaPfUmrWQoV7kJW5g=
X-Received: by 2002:a05:6214:238e:b0:91e:a1e1:697 with SMTP id
 6a1803df08f44-92114ea5892mr45962506d6.45.1795017494579; 
 Wed, 18 Nov 2026 07:58:14 -0800 (PST)
Received: from [192.168.11.112] ([96.43.243.130])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92114d70c5csm24876646d6.31.2026.11.18.07.58.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 07:58:14 -0800 (PST)
Message-ID: <3069e3f8-2cbf-436f-bf35-303fc90001ce@kernel.dk>
Date: Wed, 18 Nov 2026 08:58:11 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Excessive IO PSI for iothread when using io_uring since QEMU 10.2
To: John Maguire <jmaguire2013@gmail.com>, stefanha@redhat.com
Cc: f.ebner@proxmox.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, t.lamprecht@proxmox.com
References: <4EF13FE7-E6F3-42E2-83F9-635310B028DE@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4EF13FE7-E6F3-42E2-83F9-635310B028DE@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=axboe@kernel.dk; helo=mail-qt1-x82c.google.com
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

On 11/15/26 4:05 PM, John Maguire wrote:
> On Tue, Jun 02, 2026, Stefan Hajnoczi wrote:
>> Pinging Jens: io_uring accounts POLL_ADD SQEs as blocking I/O activity
>> whereas select(2)/poll(2)/epoll_wait(2) do not. Would it make sense to
>> follow the same accounting as the syscalls for this operation since that
>> is probably expected?
> 
> Hello,
> 
> I run Incus on two hosts and see misleading iowait and IO pressure on
> both since Incus 7.6, which puts virtio disks on a dedicated iothread by
> default. Incus users now hit this without opting into iothreads.
> 
> Host 1: Arch Linux, stock QEMU 11.1.3, kernel 6.18.62, 16 CPUs, five
> VMs. /proc/pressure/io shows about 80% "some" and 75% "full", with
> 20-30% iowait. The disks are lightly loaded (under 15% util), there are
> no D-state tasks, the pressure is confined to the cgroup holding the
> QEMU processes, and each QEMU process has one thread in io_cqring_wait.
> It started the day I upgraded from Incus 7.5.1 to 7.6; QEMU 11.1.x had
> been in use on this host since late September without it.
> 
> Host 2: Debian 13, kernel 6.12.116, 56 CPUs, four VMs, Zabbly's Incus
> packages. These bundle QEMU 11.1.3 with the pve-qemu patch
> "fdmon-io_uring: avoid idle event loop being accounted as IO wait".
> Pressure is about 68% "some" and 65% "full" with disks under 1% util,
> and again one thread per QEMU process in io_cqring_wait. This kernel
> does not advertise IORING_FEAT_NO_IOWAIT (added in 6.15), so the patch
> has no effect there.
> 
> So the downstream patch only helps on 6.15+ kernels, and distros
> shipping unpatched QEMU get these numbers by default.
> 
> Is there a preferred way forward? Fiona offered to submit the Proxmox
> workaround to qemu-devel, and Stefan asked whether io_uring should
> instead account POLL_ADD the way poll(2) does. Either would fix this
> for users on distro packages.

We can just queue up the patches for stable so they bubble back to
older versions, I think that's the cleanest approach and gets us
a unified interface across supported kernel versions.

-- 
Jens Axboe


