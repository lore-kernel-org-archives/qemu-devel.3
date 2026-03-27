Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE6B10BA426
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 04:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5yx5-0006OL-FA; Fri, 27 Mar 2026 00:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w5yx3-0006O9-RS
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:37:41 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w5yx2-0008GH-2A
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:37:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1774586242; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=J7iBHvbSyy8IOYIXqMjS8SkOYuMZg9CBXAyenA0+sjlmBc22sftN+VRf7Lv/821z3gQYbR1HvTFOJvCKIzkXssJLDwu57uBpmX/sHHL5EUXUcbFocdBYHt6QE+HugZV0yUyHtj+AXr0XeCz7nV4i90dBvxgAHsFcClPdsIY1pNQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774586242;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=BLwsECVf1EvUqBz4HwI9ZP+LzNabZequhlGYTpig7ck=; 
 b=axwEJk2TIzJOmgQvgOT8GGG4B67r3P5judUV4ryodhbQqHm2ga3LSZjZFHRSDt8QNO9dyXu+OINW7TuC69vL5vrdy/Dr6dhLodaqJjuXAO1SVaFpu4MblOQWdUIum+/NSYAJsDrZocZLv7hxC0ZEcrSXbJ2mPs65nQnfVPqbv9w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774586242; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=BLwsECVf1EvUqBz4HwI9ZP+LzNabZequhlGYTpig7ck=;
 b=c5uxe0BlzkFxQnV+qKoo71h3AbagQVcOOajJpPKIeYCrNtwzYnRF/En6HDR5sx93
 QFlHWKkcLMMFLE7pdsMnunJEe68zXhRKAAN6Oc79iU9zZeEJfupqO6WZnSjaSWyXM38
 S2ZCnXPK0F/7T/67k/0ChlMU+07NtiirSLwE2S5U=
Received: by mx.zohomail.com with SMTPS id 1774586239913700.7122433271227;
 Thu, 26 Mar 2026 21:37:19 -0700 (PDT)
Date: Fri, 27 Mar 2026 04:37:15 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 7/9] target/i386/mshv: populate xsave area offsets
Message-ID: <20260327-rich-automatic-whippet-0fe3af@anirudhrb>
References: <20260323115711.353793-1-magnuskulke@linux.microsoft.com>
 <20260323115711.353793-8-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323115711.353793-8-magnuskulke@linux.microsoft.com>
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Mar 23, 2026 at 12:57:09PM +0100, Magnus Kulke wrote:
> This function is copied verbatim from kvm_cpu_xsave_init(), for MSHV we
> need to populate the offsets similarly.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  target/i386/mshv/mshv-cpu.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


