Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DCC606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=QW//8VSo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU3hY-0001iA-Ma; Thu, 19 Nov 2026 10:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xU3fQ-0008Ur-Ay; Thu, 19 Nov 2026 10:03:17 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xU3fO-0007O9-2E; Thu, 19 Nov 2026 10:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795100583; bh=nDsLCVfE/2iaNUsP6YhrDyRFCEU8shfnj1clPInfuG4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=QW//8VSo/PAhwsm2FeXGD8EH+V/69Q+MW+1VHWtnFaLItDGDmA5mjs4pzQWwFm2Fz
 Wl6/6Uonu8VjAVpEGfBoBAe6VxmVsdHHOz0XEgBoOW3jk6ZvMkc3sJvrbrtksxZcvn
 eBaWLhcnSoy5P4g/7VO0o0FNQb8N784HjRvN4FviD72zYScx9hgrUh2Wlqxt8Q0OzA
 v8AzUal5+Ny9TsePyU4E7clfB7H62ZG6vxIwa6kqQR7XhU3OzFzhY5/x8o3zCKbdh+
 st5ffTUFAlWrnQ13QNqqieCu8s0XoVOumFyqVjTHb2DX1saJTnZeqQxD3dJHRYwSG6
 nDNURBXTmUr0Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 06DD51E7FC1;
 Thu, 19 Nov 2026 18:03:03 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E8A30461971;
 Thu, 19 Nov 2026 18:03:02 +0300 (MSK)
Message-ID: <48bf4cd9-bc69-40fc-b54d-1744c2d2c491@tls.msk.ru>
Date: Thu, 19 Nov 2026 18:03:02 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] i386, Rust for 2026-11-17
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: QEMU Stable <qemu-stable@nongnu.org>,
 NickSampanis <nicksampanis@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20261118171838.38195-1-pbonzini@redhat.com>
 <b5f942b2-63d7-44e6-a86b-71f3e3980579@tls.msk.ru>
 <679cbec6-db86-4bed-88a3-aac36d958781@redhat.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <679cbec6-db86-4bed-88a3-aac36d958781@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 13:18, Paolo Bonzini wrote:

> I would pick, in order of importance
> 
> - fix lea address calculation (this one is the only regression and I should have Cc'd qemu-stable indeed)
> - fix load/restore for test-avx and test-mmx (otherwise the test is broken)
> - set VM ioctl KVM_SET_TSC_KHZ

I looked at this one.  Unfortunately it does not apply to 10.0.x due to lack of other
infrastructure there: kvm_arch_pre_create_vcpu() and subsequent KVM_PMU_CAP_DISABLE
changes.  It would be good to have it in an LTS series though.

> - fix latched INIT lost

> If you really want, the 64-bit RSP fixes can go in too, but the other TCG fixes are corner cases that we don't really care about.
Heh.  I already picked up "treat ENTER's size operand as unsigned",
it shouldn't be that bad even if don't care about these corner case.
Also 4e61c4bb175d9 "target/i386: raise #DE for INT_MIN / -1 in IDIV
helpers".

Thank you for the hints!

/mjt

