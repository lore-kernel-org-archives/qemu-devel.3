Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68246C54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 14:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uITDa-0006m4-K3; Fri, 23 May 2025 10:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uITDW-0006lk-EX
 for qemu-devel@nongnu.org; Fri, 23 May 2025 10:17:47 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uITDU-0006NV-81
 for qemu-devel@nongnu.org; Fri, 23 May 2025 10:17:46 -0400
Received: from example.com (unknown [167.220.208.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 95C422068352;
 Fri, 23 May 2025 07:17:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 95C422068352
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1748009860;
 bh=P3zKMS3IUy8W5yQHX335lEv+c+Kd+vBg2QWwBuIo4Ec=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LtNjvgDik4dANRSPs25I0rhknfIr7cs53eNQVn6sdPyTnSbDGpfBdzBZW0S8cV5Q0
 3xuhF5yEOMTMQ0il2BudLcD/g5DuoNoQHSb5dAudu80Q4yfSs2d6yMZHo3X7RlvJJ7
 owpWl4h0cC4C8bWGKxK7VoNNP76AkmUFfGyFPXjY=
Date: Fri, 23 May 2025 16:17:34 +0200
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
Subject: Re: [RFC PATCH 09/25] accel/mshv: Register guest memory regions with
 hypervisor
Message-ID: <aDCDfrqNG9y6zSkv@example.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-10-magnuskulke@linux.microsoft.com>
 <aCzg__6lGlvypZMB@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCzg__6lGlvypZMB@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
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

On Tue, May 20, 2025 at 08:07:27PM +0000, Wei Liu wrote:
> On Tue, May 20, 2025 at 01:30:02PM +0200, Magnus Kulke wrote:
> > Handle region_add events by invoking the MSHV memory registration
> > +        return set_guest_memory(vm_fd, &region);
> > +    }
> > +
> > +    region.flags = (1 << MSHV_SET_MEM_BIT_EXECUTABLE);
> 
> Should this be always set? Is there a way to get more information from
> the caller or QEMU's core memory region management logic?
> 

HVF always sets the bit and as far as I can tell KVM doesn't have a
KVM_MEM_EXECUTE flag, so it's implied.

Still, there might be some criteria to determine whether a region is
executable or not, I'll look further into that.

