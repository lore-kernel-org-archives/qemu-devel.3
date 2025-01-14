Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E40E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 19:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXmb3-0003dA-7f; Tue, 14 Jan 2025 14:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tXmb0-0003cy-HK
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 14:29:02 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tXmay-0007hF-I3
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 14:29:02 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d414b8af7bso10327019a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 11:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736882938; x=1737487738; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fEePbZw15hVkFVYqjY+dAz7DX5WQQ+umhJx5YAmiOt4=;
 b=NHbWxAcOLnlhxL5pUXJUfHODa2xu1+L8kIAKpEEgdz58Zu0SN830CmYjaeLfr3+nIA
 uWvxvHVrjL+VtB9Kl7qSDVJtyhhe+mxMqaPKXR0NTI3PxaiGO2SEKVHt5oxLnHUHGYIm
 7sF52Kix4aLlStUgedRpoiflo4B+x3zajZjnfM4Q6YsP8qlhuNtiIwdSsZF++kgQ9p/o
 CAsKAajQ43U3VO+cUYd/+wW7csZX6rNf3b2wwpMYkq6F5L/d9uyTRSAMRENHLGgPRnen
 BedVb0aBUfJO1YUfbIhD9P2hHz4HfU0ewlla7Jj8eoajm5UD6n02sFgZhvcOm8I3WeLf
 gN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736882938; x=1737487738;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fEePbZw15hVkFVYqjY+dAz7DX5WQQ+umhJx5YAmiOt4=;
 b=gjaK+wir3wnXMtBaty8yX/Njo8ptWXV4vHtL0Fp69AMRI2tVr6306YC35oqde5n38e
 Ou97suBXCa2VEeTjGOsFoq6IGJ5cIUYiz7N3AvqmNZTApDCUUZmZURuN0Tq2ktXF6Hg0
 NZ5P8018TiqovRLMDLHXhjXBj9HH4o8yoFtmvBuTLEcM5ynLkqdalE7ETd4nKurk1UQc
 nSHE1zh1OwsfuwqcorwbYWsVFcmpHsFdodE92twRX18XuR3Hm4UJV8kS8qrIeSS56BEK
 6Eghir6zbcrpd98QWbxUh8u40R9fN3/ngOcqdxfwPztIJQu5YrWp/yx+NlQq9QjIbwY+
 cjJg==
X-Gm-Message-State: AOJu0YxzXE015ZBgdUGyNOjIei1P9xeh7mwAUcb4T806YkOnrSRCP8mF
 aOXBlWNx1pzUVClh++WSmEX8bSLr/yuZpxs9PvtHS1hA+b8Jui1t6wE/HvpCfbNidOEjrIF7Vyz
 aIZ0c5wEsaO9nLHFtRGi0N1DsxzM=
X-Gm-Gg: ASbGnctMEk4uw4bsZqaJO268MOBciBgJRmI/ILJu4q484Sp7pgptOd2Bkv94bYBt8wo
 w+Zh9V+zSxbynWCImTxcTidmvRfnRHYy4ZJta
X-Google-Smtp-Source: AGHT+IGMxtGuG67xYpf7IVBB/UIKqZ41GAq6KWQ5hsTEDwXQCy+ySjcjVJOmq7VydDUWmLTrBGz/4Nk1GKD7khRd7Fc=
X-Received: by 2002:a05:6402:350b:b0:5d9:cde9:2b88 with SMTP id
 4fb4d7f45d1cf-5d9cde92bffmr6628284a12.27.1736882938170; Tue, 14 Jan 2025
 11:28:58 -0800 (PST)
MIME-Version: 1.0
References: <20250113210833.1712-1-farosas@suse.de>
 <CAJSP0QWe+0_rjchH0hCszU-4r_PF+ZgZgWb+cgg6UZzZiYeTQA@mail.gmail.com>
 <8734hlh471.fsf@suse.de>
In-Reply-To: <8734hlh471.fsf@suse.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 14 Jan 2025 14:28:46 -0500
X-Gm-Features: AbW1kvbbrWB9Q5uKD5wH5gDod2U8vQS81zaiqKt-NV-KeSGp9PKFJ0Dc04rWrSg
Message-ID: <CAJSP0QUGfq0yPyzyjHy9D0=e2o_AVMvb1SaA69fm3oexYaH60g@mail.gmail.com>
Subject: Re: [RFC PATCH] tests/qtest/migration: Add cpu hotplug test
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 14 Jan 2025 at 09:15, Fabiano Rosas <farosas@suse.de> wrote:
>
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>
> > On Mon, 13 Jan 2025 at 16:09, Fabiano Rosas <farosas@suse.de> wrote:
> >>
> >> Bug #2594 is about a failure during migration after a cpu hotplug. Add
> >> a test that covers that scenario. Start the source with -smp 2 and
> >> destination with -smp 3, plug one extra cpu to match and migrate.
> >>
> >> The issue seems to be a mismatch in the number of virtqueues between
> >> the source and destination due to the hotplug not changing the
> >> num_queues:
> >>
> >>   get_pci_config_device: Bad config data: i=0x9a read: 4 device: 5
> >>   cmask: ff wmask: 0 w1cmask:0
> >>
> >> Usage:
> >> $ QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_BINARY=./qemu-system-x86_64 \
> >>   ./tests/qtest/migration-test -p /x86_64/migration/hotplug/cpu
> >>
> >> References: https://gitlab.com/qemu-project/qemu/-/issues/2594
> >> References: https://issues.redhat.com/browse/RHEL-68302
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >> As you can see there's no fix attached to this. I haven't reached that
> >> part yet, suggestions welcome =). Posting the test case if anyone
> >> wants to play with this.
> >>
> >> (if someone at RH is already working on this, that's fine. I'm just
> >> trying to get some upstream bugs to move)
> >
> > The management tool should set num_queues on the destination to ensure
> > migration compatibility.
> >
>
> I'm not sure that's feasible. The default num-queues seem like an
> implementation detail that the management application would not have a
> way to query. Unless it starts the source with a fixed number that
> already accounts for all hotplug/unplug operations during the VM
> lifetime, which would be wasteful in terms of resources allocated
> upfront.
>
> That would also make the destination run with a suboptimal (< #vcpus)
> number of queues, although that's already the case in the source after
> the hotplug. Do we have any definition on what should happen durgin
> hotplug? If one plugs 100 vcpus, should num-queues remain as 2?

QEMU defaults num_queues to the number of present CPUs. A management
tool that wants to ensure that all hotplugged CPUs will have their own
virtqueues must set num_queues to max_cpus instead. This wastes
resources upfront but in theory the guest can operate efficiently. I
haven't checked the Linux guest drivers to see if they actually handle
virtqueue allocation after hotplug. The Linux drivers vary in how they
allocate virtqueue interrupts, so be sure to check several device
types like virtio-net and virtio-blk as they may behave differently.

Or the management tool can explicitly set num_queues to the number of
present CPUs and preserve that across live migration and CPU hotplug.
In that case num_queues can be updated across guest cold boot in order
to (eventually) achieve the optimal multi-queue configuration.

Other approaches might be possible too. The management tool has a
choice of how to implement this and QEMU doesn't dictate a specific
approach.

Stefan

