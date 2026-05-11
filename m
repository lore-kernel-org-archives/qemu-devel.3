Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2408CD3427
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNGy-00084c-QI; Mon, 11 May 2026 05:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wMNCA-0006OZ-CE
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:46:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wMNBs-0002Oq-M3
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778492670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=72Y4d8NawRpNTYn0L3jDnBkyTPkYGSZvNLE0HCORhig=;
 b=WmA3GvylSVjYN5bw+cVSYvyZcccBgcwrk8G5WflR7Hr95o+trxqaj/wsjUO6zapDUide8d
 098clVRshJkN9fRXxFv5DygFQ1YfQZ/EeljMZHdl7154UDEk9BTsavjhy0u7e09pr5Qm67
 bl4gw/TsEGq/LHnkOrivH+dZ4H1yGAM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-fexlXVkPOzOpwdqtIxCLxA-1; Mon,
 11 May 2026 05:05:35 -0400
X-MC-Unique: fexlXVkPOzOpwdqtIxCLxA-1
X-Mimecast-MFC-AGG-ID: fexlXVkPOzOpwdqtIxCLxA_1778490334
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAA3D19560B0; Mon, 11 May 2026 09:05:32 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.170])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A65791800349; Mon, 11 May 2026 09:05:28 +0000 (UTC)
Date: Mon, 11 May 2026 11:05:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/9] tools: Move more tools sources into tools/
Message-ID: <agGb1m4paju1pIN9@redhat.com>
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508152428.2648560-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 08.05.2026 um 17:24 hat Peter Maydell geschrieben:
> We have a set of binaries that we call "tools": they're built based on
> the --enable-tools/--disable-tools configure setting, they're
> documented in docs/tools, and they're standalone executables of one
> form or another.
> 
> Currently the sources for these are a bit scattered: many still in the
> top level source directory, some in contrib, one or two actually in
> the tools directory.
> 
> As an initial attempt at cleanup, this patchset moves the sources for
> qemu-bridge-helper, qemu-edid, qemu-img, qemu-io, qemu-nbd,
> qemu-keymap, qemu-vmsr-helper and elf2dmp into the tools/ directory.
> 
> The patchseries also moves the ebfp skeleton sources from tools/ebpf/
> to ebpf/bpf-src/, because this isn't a tool by the above definition.
> 
> As per my thread from a while back, I would ultimately like us to
> clean up contrib/:
> https://lore.kernel.org/qemu-devel/CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com/
> But parts of that clearly need more discussion. So this is just doing
> some parts that I hope are not controversial.
> 
> Annoyingly, meson doesn't seem to provide any way for a subdirectory
> meson.build to say "the foo.c in this subdir builds into a foo
> executable that lives at the top level of the builddir". And we have a
> lot of test harness stuff plus user muscle memory that assumes that
> qemu-img and qemu-io live there. So the build runes for these tools
> have to stay in the top level meson.build (and tools/meson.build
> remains an empty file). The exception is that contrib/elf2dmp/elf2dmp
> is now tools/elf2dmp/elf2dmp, but I think the set of people who were
> running that from the build directory will be small.

Should qemu-storage-daemon be moved as well? I never particularly liked
the storage-daemon/ directory that Paolo created in 7c58bb76 and that
singled qemu-storage-daemon out among the tools. If the binary could
move whereever all the other tools live, too, that would be even better.

Kevin


