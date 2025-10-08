Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DF8CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 17:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6XlG-0001Hm-6C; Wed, 08 Oct 2025 13:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1v6XlB-0001HM-UC
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:15:30 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1v6Xl9-00008p-EJ
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:15:29 -0400
Received: from example.com (unknown [167.220.208.72])
 by linux.microsoft.com (Postfix) with ESMTPSA id 37EFF2038B7B;
 Wed,  8 Oct 2025 10:15:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 37EFF2038B7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1759943724;
 bh=YN3eMj/EpOTng9HZSwLCQ3fBR4cy8tadx9svDcTrJM8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K5dttYXj3PlzzyF5ts8FRvSHw10JD12CBHlI/nqjFWf5WvDcfKce8vz4sj6Fr23kK
 MXMPNE5Ikh9YUxj7esxbHcsE9KlcpJ9fZZXS1DA5tYil1OcmdbXgqxb96dFC16IWos
 r55Exl+jFB9BNc4C//n1d7GcvLrwKPyIzD0imYeM=
Date: Wed, 8 Oct 2025 19:15:19 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, wei.liu@kernel.org
Subject: Re: [PATCH 01/27] accel: Add Meson and config support for MSHV
 accelerator
Message-ID: <aOacJ7f6Io0l75ff@example.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
 <20251002171536.1460049-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002171536.1460049-2-pbonzini@redhat.com>
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

On Thu, Oct 02, 2025 at 07:15:10PM +0200, Paolo Bonzini wrote:
> From: Magnus Kulke <magnuskulke@linux.microsoft.com>
> 
>  endif
> +if 'CONFIG_MSHV' not in accelerators and get_option('whpx').enabled()
> +  error('mshv not available on this platform')
> +endif

should be `get_option('mshv')`

best,

magnus

