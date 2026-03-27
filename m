Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D38D10F284D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AEV-0005RR-S6; Fri, 27 Mar 2026 12:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w6AEP-0005Qv-Rb
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:40:23 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w6AEO-0002Fq-G0
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:40:21 -0400
Received: from example.com (p5086d205.dip0.t-ipconnect.de [80.134.210.5])
 by linux.microsoft.com (Postfix) with ESMTPSA id 1A85B20B710C;
 Fri, 27 Mar 2026 09:40:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A85B20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1774629616;
 bh=ZjjNWHSvE7Ye+VJVv0gk5N+LuoZPKugVoWIKkvxZAHM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VLzhALW7go6fiIMPs+AJJAC+4+kekeW63wNVKLJcZgSrl2pzqe3v7jKwIqNKBjPaH
 SfPsa/yos0kFN/lVhSTUnpisBIXj3Mrq4uuvr9W5YwHx17jRweNm4lDp7mU3SY5hZr
 e3XWI18EDN567BNSYlCsNF+tmhEAy7DxhcqQObis=
Date: Fri, 27 Mar 2026 17:40:11 +0100
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Magnus Kulke <magnuskulke@microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 9/9] accel/mshv: disable la57 (5lvl paging)
Message-ID: <acay6/cTPVtjp6BT@example.com>
References: <20260323115711.353793-1-magnuskulke@linux.microsoft.com>
 <20260323115711.353793-10-magnuskulke@linux.microsoft.com>
 <c0ce6be5-3a03-4020-9ca3-51d178dfa1ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0ce6be5-3a03-4020-9ca3-51d178dfa1ed@redhat.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

On Fri, Mar 27, 2026 at 05:08:34PM +0100, Paolo Bonzini wrote:
> Is this still true with the latest target/i386/emulate changes from 11.0?
> 
> Paolo

Unfortunately yes, d1d985a34d addresses an overflow issue, but we're still
seeing MMIO errors after the change from TRANSLATE_GVA hypercall to the
userland tablewalk for the mshv accelerator.

I've tracked this issue and we will investigate further.

best,

magnus

