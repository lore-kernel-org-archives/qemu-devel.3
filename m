Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6D9C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWuRd-0007s5-5o; Wed, 02 Jul 2025 06:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uWuRZ-0007rq-Oh
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:11:58 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uWuRU-0003HC-Lj
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:11:57 -0400
Received: from example.com (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id 978472016579;
 Wed,  2 Jul 2025 03:11:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 978472016579
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1751451107;
 bh=sa1v/QGPSIUFLy/UIIM5ZoePwImimh0hWpUQgysctqo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EvqqFjvLKB6rMcw37YrD+vx8y2N1zyZMZQsAF47EWxIbsjMu7YX7Y5iRYmYCY50QO
 61Wq7De7kgXeSK7PfVG1hU4flo/fCinfFioLCCLusCqdZ/VOtgZktQ2I8Jb7+wP78s
 bbkBybQxw+LGimYMgvgXW1NiNPTnOZSd8SqfmLeY=
Date: Wed, 2 Jul 2025 12:11:39 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 05/27] include/hw/hyperv: Add MSHV ABI header
 definitions
Message-ID: <aGUF28/7HAMwZEpU@example.com>
References: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
 <20250701172834.44849-6-magnuskulke@linux.microsoft.com>
 <8734bfq7n6.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734bfq7n6.fsf@redhat.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Jul 02, 2025 at 11:11:41AM +0200, Cornelia Huck wrote:
> On Tue, Jul 01 2025, Magnus Kulke <magnuskulke@linux.microsoft.com> wrote:
> 
> > Introduce headers for the Microsoft Hypervisor (MSHV) userspace ABI,
> > including IOCTLs and structures used to interface with the hypervisor.
> >
> > These definitions are based on the upstream Linux MSHV interface and
> > will be used by the MSHV accelerator backend in later patches.
> >
> > Note that for the time being the header `linux-mshv.h` is also being
> > included to allow building on machines that do not ship the header yet.
> > The header will be available in kernel 6.15 (at the time of writing
> > we're at -rc6) we will probably drop it in later revisions of the
> > patch set.
> 
> The right way to handle header updates is to split the linux-header
> updates into a "dummy" update (that just adds the header) and replace
> that patch with a proper header update once the changes hit Linux
> mainline.
> 

Ah, that's right, the commit message is not accurate any more, I'll change
it in the next revision. The driver has been released as part of 6.15.

I was following Paolo's advice to include the headers in
`linux-headers/linux` and add an entry to
`scripts/update-linux-headers.sh`

https://lists.gnu.org/archive/html/qemu-devel/2025-05/msg04791.html

I might not have completely understood the process though, do you
suggest to run `update-linux-headers.sh` on a current kernel (the other
headers seem to be updated from 6.16-rc*, so I assume the latest rc?)
and include the resulting changes in a seperate commit?

> I have not looked at the contents of the series otherwise -- but if this
> is a system header (and not something that defines the kernel<->vmm
> interface), how do you make sure that your system has that installed?
> Maybe I'm misunderstanding.
> 

The kernel header does define the ioctls and ABI for the driver, albeit not
completely, some hyperv-specific types and defines are shipped as seperate
`include/hw/hyperv` header files.

