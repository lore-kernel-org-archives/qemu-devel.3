Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0E7C9EC90
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfI4j-0003JS-Dr; Mon, 12 Jan 2026 08:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konstantin@linuxfoundation.org>)
 id 1vfI4C-0002xX-W1; Mon, 12 Jan 2026 08:34:52 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konstantin@linuxfoundation.org>)
 id 1vfI47-0005bN-UO; Mon, 12 Jan 2026 08:34:43 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 28588402BB;
 Mon, 12 Jan 2026 13:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D839EC16AAE;
 Mon, 12 Jan 2026 13:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1768224871;
 bh=fXdqGVkgXiqcLdOvWk7WXV51lzrFUZYOOyeTyVAs4RU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=w9frkmSpR1HxFdtnMDLmbhb7z6jZXLFixBwUT5inqUOz0eECvpiF6IoyaY0+JVtog
 wf+toOZWbF7hC5lWKse2dUiNPL5hTzKpH3Fug68DQIXIFnqU7RA1d2hdL6CJjpyoAx
 IkIzCjGRCx9DEtB+CwZZfxNcPOXim8vGVYkgJHC8=
Date: Mon, 12 Jan 2026 08:34:29 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, 
 alistair@alistair23.me, chalapathi.v@linux.ibm.com, kowal@linux.ibm.com, 
 angeloj@linux.ibm.com
Subject: Re: [PATCH v4 0/7] hw/ppc: Snapshot support for several ppc devices
Message-ID: <20260112-fuzzy-idealistic-labrador-9b5cff@lemur>
References: <20260105160138.3242709-1-calebs@linux.ibm.com>
 <1301eb7b-31d8-476f-a12a-06470a349771@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1301eb7b-31d8-476f-a12a-06470a349771@linux.ibm.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=konstantin@linuxfoundation.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 12, 2026 at 03:32:13PM +0530, Harsh Prateek Bora wrote:
> > For the series:
> > Reviewed-by: Aditya Gupta<adityag@linux.ibm.com>
> > Reviewed-by: Chalapathi V<chalapathi.v@linux.ibm.com>
> 
> For some reason b4 is not picking above tags even with -S (to avoid

Because there is no space between the name and the address, which is not
correct format.

-K


