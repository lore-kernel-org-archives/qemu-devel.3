Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07200EC1438
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 12:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxPFh-0002xp-1l; Tue, 03 Mar 2026 07:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1vxPFc-0002xN-D8
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:53:24 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1vxPFX-0003EM-Fu
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:53:21 -0500
Received: from example.com (unknown [167.220.208.51])
 by linux.microsoft.com (Postfix) with ESMTPSA id EB0F220B6F02;
 Tue,  3 Mar 2026 04:53:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB0F220B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1772542393;
 bh=uJJd3V4qqjLxcoJnD9alZaP99aXpaARtZXArRkSrgBQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UmS1RxdaApfOHNJqp5TVFwQX09DEZ54JKtGU0UBYg++3j+vSfI0anwjga4apC7lyF
 VCDmROREOuqxUjb/x6iH5LoKGmdAOTrpEluK0gxC2FYXc49gxc1kJhzWVY3tYEwOwf
 bhC8DuY0JrzKMrG4baMYmbFpxes0RGepv+0ytXSE=
Date: Tue, 3 Mar 2026 13:53:09 +0100
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: Re: [PATCH 01/10] MAINTAINERS: fix magnuskulke email-address
Message-ID: <aabZtbPdj5TgrAEi@example.com>
References: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
 <20260211155410.203883-2-magnuskulke@linux.microsoft.com>
 <CAFEAcA8HNBgd-u3mtpPYq=UhEdu6WvSJ0+yHZTsd3i8KRRF2Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8HNBgd-u3mtpPYq=UhEdu6WvSJ0+yHZTsd3i8KRRF2Vw@mail.gmail.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 03, 2026 at 12:14:21PM +0000, Peter Maydell wrote:
> Hi; I'm going to pull this MAINTAINERS patch out of this series
> and apply it via target-arm.next, since the incorrect email
> we currently have listed in the file bounces ("550 5.1.1 :
> Recipient address rejected: User unknown in local recipient table").
> 
> thanks
> -- PMM

ack, thanks!

