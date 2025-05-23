Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28BAC3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 08:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uINhJ-0007iY-PE; Fri, 23 May 2025 04:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uINhH-0007iG-HA
 for qemu-devel@nongnu.org; Fri, 23 May 2025 04:24:07 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uINhF-0004Pn-Df
 for qemu-devel@nongnu.org; Fri, 23 May 2025 04:24:07 -0400
Received: from example.com (unknown [167.220.208.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id BFD1D211CF8F;
 Fri, 23 May 2025 01:24:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BFD1D211CF8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747988643;
 bh=ZsrfpGPJu2idcYCxcDsbxCnBlUTK813bvUxhIR0RuiI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hECJfHwLX2hvA9obe2djDe5dCAtJTwF+0f8eFBYJfT0KV2QdKrUkkYkQlhZqqwlf2
 VOvFd5qXW34IyfAg+LI+LuyLc9nPHZWbMa+UbMN9CXCNLUb6HmzwsCAg5vZ4uWH/M2
 HaNZIJcTP+b2qUilDDNaipWE2jE7MvIn/zSKjxdI=
Date: Fri, 23 May 2025 10:23:58 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 08/25] accel/mshv: Initialize VM partition
Message-ID: <aDAwnkXFsEri/e4D@example.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-9-magnuskulke@linux.microsoft.com>
 <aCzS2h9UfGe-FZDW@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCzS2h9UfGe-FZDW@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, May 20, 2025 at 07:07:06PM +0000, Wei Liu wrote:
> On Tue, May 20, 2025 at 01:30:01PM +0200, Magnus Kulke wrote:
> > Create the MSHV virtual machine by opening a partition and issuing
> > the necessary ioctl to initialize it. This sets up the basic VM
> > structure and initial configuration used by MSHV to manage guest state.
> > 
> > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> > ---
> [...]
> 
> mshv_fd is neither stashed into a state structure nor freed after this
> point.  Is it leaked?
> 
> Thanks,
> Wei.
> 

AFAIK the accelerator should not be initialized multiple times at runtime,
so under normal circumstances the fd wouldn't leak. But in certain debug
scenarios that would be the case. So, yes, we should make this more solid
and exit early if MSHV_STATE has been previously initialized.

> >      s->nr_as = 1;
> >      s->as = g_new0(MshvAddressSpace, s->nr_as);
> >  
> >      mshv_state = s;
> >  
> > +    qemu_register_reset(mshv_reset, NULL);
> > +
> >      register_mshv_memory_listener(s, &s->memory_listener, &address_space_memory,
> >                                    0, "mshv-memory");
> >      memory_listener_register(&mshv_io_listener, &address_space_io);

