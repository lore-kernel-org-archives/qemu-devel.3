Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D137606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=A+IUjVCP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVQhC-00016K-4n; Mon, 23 Nov 2026 04:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1xVQhA-00015Z-Or; Mon, 23 Nov 2026 04:50:44 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1xVQh9-0000p4-9Y; Mon, 23 Nov 2026 04:50:44 -0500
Received: by linux.microsoft.com (Postfix, from userid 1236)
 id 2366A20B7167; Mon, 23 Nov 2026 01:50:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2366A20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1795427438;
 bh=5xz9qkyLMQqYRfGGP4KNzNbohUS6OLuGtDpDkjgTPY8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A+IUjVCPU9XfSJx5Zi45Kz5peBh65djHpB9aljKZmhCAzP9Q+J1P7T2tpBkzdZ72c
 scICj/uL6raFQ0QJOOkDyCYNe/CgaVhKS4g2cpM51CgeFmu+pJZW6w1uvkCGGgZXWy
 q667oBqpfxfZwMJEqIc1yCz4TcuIfdtzhU6hTG8o=
Date: Mon, 23 Nov 2026 01:50:38 -0800
From: Aastha Rawat <aastharawat@linux.microsoft.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anirudh Rayabharam <anirudh@anirudhrb.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v6 04/14] meson, target/arm/mshv: Enable arm64 build &
 add initial MSHV support
Message-ID: <awQMbg7zNPsK6+mn@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
 <20261001-mshv_accel_arm64_supp-v6-4-aefe5e76a0e3@linux.microsoft.com>
 <CAFEAcA-FfUt2AmxnAqSPkca_-WBS9WBvRgzfj9f26by2FccqDA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-FfUt2AmxnAqSPkca_-WBS9WBvRgzfj9f26by2FccqDA@mail.gmail.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 13, 2026 at 05:48:04PM +0100, Peter Maydell wrote:
> On Thu, 1 Oct 2026 at 11:52, Aastha Rawat
> <aastharawat@linux.microsoft.com> wrote:
> >
> > Enable the build of the MSHV accelerator for arm64 in the Meson build
> > system. Introduce initial files and stub implementations to support MSHV
> > for the ARM target.
> >
> > Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> > ---
> >  accel/mshv/mshv-all.c       | 10 ++++--
> >  hw/i386/mshv/clock.c        |  2 +-
> >  include/system/mshv.h       |  2 +-
> >  meson.build                 |  8 ++---
> >  target/arm/meson.build      |  1 +
> >  target/arm/mshv/meson.build |  7 ++++
> >  target/arm/mshv/mshv-all.c  | 81 +++++++++++++++++++++++++++++++++++++++++++++
> >  7 files changed, 103 insertions(+), 8 deletions(-)
> >
> > diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> > index efe19a3914..f3f1825b0b 100644
> > --- a/accel/mshv/mshv-all.c
> > +++ b/accel/mshv/mshv-all.c
> > @@ -142,8 +142,10 @@ static int create_partition(int mshv_fd, int *vm_fd)
> >  {
> >      int ret;
> >      uint64_t pt_flags, host_proc_features;
> > -    union hv_partition_processor_xsave_features disabled_xsave_features;
> >      union hv_partition_processor_features disabled_partition_features = {0};
> > +#if defined(__x86_64__)
> > +    union hv_partition_processor_xsave_features disabled_xsave_features;
> > +#endif
> 
> This is the common mshv file; if you are adding __x86_64__ ifdefs
> to it then something is in the wrong place and needs to be moved
> to an architecture-specific file/function.

Yes, I plan to introduce an ARM variant of this function. This will be
moved there.

Thanks,
Aastha 

