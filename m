Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E839EEA870
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 09:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqptB-0005EX-KV; Fri, 13 Feb 2026 04:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1vqpt9-0005Bw-MA
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:55:03 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1vqpt7-0007xo-RC
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:55:03 -0500
Received: from example.com (unknown [167.220.208.59])
 by linux.microsoft.com (Postfix) with ESMTPSA id 68B2B20B7165;
 Fri, 13 Feb 2026 01:54:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68B2B20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1770976500;
 bh=cAezaO2BMvVT0tXC67+pEc8ihpyyFufwx1YG0JWkw14=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FgGhZfEqJvolSO9ProR/sDJPqvfIYeiyo5jlcUlPLUFDC9XuJe33aQGaemHMoZynd
 9AWwgCPM5CScU0KVmsJfr84ohglLv3/+P3LMvvST/Kcb6O8RXWvQa9noeWMjLG3XdU
 APfhUlmwRJhuHh/Okd+wWYevGMmC0uRz2rYJok7Q=
Date: Fri, 13 Feb 2026 10:54:54 +0100
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: Re: [PATCH 03/10] accel/mshv: use mshv_create_partition_v2 payload
Message-ID: <aY707sEkEPxt02ZS@example.com>
References: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
 <20260211155410.203883-4-magnuskulke@linux.microsoft.com>
 <792A279D-EA08-4174-B55D-BD94098541B8@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <792A279D-EA08-4174-B55D-BD94098541B8@unpredictable.fr>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Feb 12, 2026 at 12:43:11AM +0100, Mohamed Mediouni wrote:
> On the 1st party Microsoft headers side (as in WHP), the two banks are defined separately.
> 
> For example: 
> 
> ACountMCountSupport instead of a_count_m_count_support
> 
> Any reason in particular to diverge and would you prefer to use the definition here in WHP too?
> 
> Thank you,
> 

I am using the rust-vmm/mshv crates as a reference for the MSHV
interface. I'm cherry picking the definition as we need them from this
source usually:

https://github.com/rust-vmm/mshv/blob/008ed04a85f98c376ea728f1db87f7de07d79a66/hv-headers/hvhdk.h#L1384

I think in the future we want to move those definitions into the
kernel's mshv UAPI header, so the WHPX code is probably more correct
in this regard and the MSHV will do something similar in the future.

best,

magnus

