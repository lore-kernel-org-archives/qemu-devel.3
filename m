Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614BB606A331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9C+89rs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWUnT-0003b1-Of; Thu, 26 Nov 2026 03:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xWUnL-0003Yt-Rg; Thu, 26 Nov 2026 03:25:34 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xWUnK-00029X-4t; Thu, 26 Nov 2026 03:25:31 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5F61743673;
 Thu, 26 Nov 2026 08:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAFD1F000D2;
 Thu, 26 Nov 2026 08:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795681525;
 bh=r8h2nuU0+vSeeWeXVKTMdqyn7YTlx598qJVdF7GIWoU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Z9C+89rsggv9dpP431C05X2EOUppgwYkTZwzSng8ulPm+YMEin+YUzOKL8eU0vyg5
 HMz2mx0Q6Gjm+v0S/GcOsmtzbwH59D7rgIealre4FkILO8RXfVN7kyOftX5CsO5535
 0iQGLfdWQXtZwiDznpkOYIqVF7V/Ih8S8Pd+Wes0HZzmwQFhWQ8lfIyZ4aFNSsjxWt
 0+FPGLRM7CporRrJ7Idzuu/oA0Jyw6xJqIyA6TiofnROYt6uNvtk+tyiVlFFR0tn2x
 m77DEh0ExCgjUKfia0TOgXkvzUMtqdU+cuqqJWB0qsQPGQwdqGFlvW7Pg4URQZoy77
 vDedEuwwIOqvw==
Date: Thu, 26 Nov 2026 09:25:19 +0100
From: Niklas Cassel <cassel@kernel.org>
To: daejun7.park@samsung.com
Cc: qemu-devel@nongnu.org, Jeuk Kim <jeuk20.kim@samsung.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Damien Le Moal <dlemoal@kernel.org>, Sam Li <faithilikerun@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Stanley Jhu <stanleyjhu@google.com>,
 Keoseong Park <keosung.park@samsung.com>
Subject: Re: [PATCH v4 0/5] Support for Zoned UFS
Message-ID: <awfs77qbgRszXuM3@ryzen>
References: <20261126-zoned-ufs-v4b-v4-0-f90239d12a55@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126-zoned-ufs-v4b-v4-0-f90239d12a55@samsung.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Daejun,

On Thu, Nov 26, 2026 at 11:02:08AM +0900, Daejun Park via B4 Relay wrote:
> This series makes a ufs-lu on a host-managed zoned qcow2 image a ZBC
> host-managed device, so that f2fs and other zoned software can be
> tested on UFS. As Niklas asked [1], the zones live in the image and the
> logical unit uses the zoned block layer API.
> 
> The ZBC commands are emulated in hw/ufs on top of scsi-hd, which stays
> a direct-access device, as scsi-disk serves its mode and VPD pages to
> those only. They can move to scsi-disk if the SCSI maintainers prefer.
> 
> Tested with the UFS qtests (also under ASan and UBSan) and Linux 7.3-rc7
> and android17-6.18 guests, legacy doorbell and MCQ: fio --zonemode=zbd
> with verification, blkzone, sg_raw, and f2fs on android17-6.18. One
> early android17-6.18 MCQ run retried unaligned writes (data verified),
> fourteen later ones did not. Zoned host block devices are untested.
> 
> Two qcow2 v18 problems show with qemu-io alone. With detect-zeroes
> on, a zero write at the write pointer does not move it, so the next
> write fails as unaligned. A resized zoned image overflows its write
> pointer table on a write past the old end, and qemu-img resize leaves
> it unopenable.

Here you mention two problems with the qcow2 v18 series.
It would be nice if you could report these, including steps to reproduce,
to the qcow2 v18 thread.

qemu-io is a way to send commands directly to the backend without any
frontend, so I'm guessing that the problems you mention cannot be
reproduced if there is a frontend involved?
Regardless, the qcow2 series should probably get a v19 to address these
problems.


Kind regards,
Niklas

