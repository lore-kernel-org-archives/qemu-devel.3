Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD487606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=q/g32FXj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU2FE-00071k-Sv; Thu, 19 Nov 2026 08:32:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xU2F5-00070v-Ls
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 08:31:59 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xU2F2-0004Ik-8l
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 08:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795095111; bh=MTrgid6ueet1JIG5qlUiV7DHOoefWlB993SPkmpONCw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=q/g32FXjEzX2z7shF/sN9fupK7Q55O+sj30ffio4KTRcFQUyJlqu8ys+s9klRWrH5
 uDr/lT/l33F7S5jXnv7DKQWI/xnqyIw/inTaEelNp0Bxj3c+2bl1uZ8TcU3u3qLx0w
 3dUZCP05l4OH0wQ0v2mr2wbKJV4pHidXLJs5SvQ9A5ryNfLoTVpU2AuA9e3xN+EQSL
 /FYtP1AffRwA3BXZQBK/cwuvMwbqb4jW5md6RdW5IUSTFEqwmH2cPkdmL4TA6pUvx9
 WTeP4+7XwYu5pOsA5cD8pHJPEEikuP+Xs+7i9rmg2IC4gpFXGF9mpSLCQAkWPnzsbh
 QO1i1Mb1zLFhQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 45EE81E7F82;
 Thu, 19 Nov 2026 16:31:51 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 30C5C46190E;
 Thu, 19 Nov 2026 16:31:51 +0300 (MSK)
Message-ID: <ca80e84f-28b7-4156-823e-b00679ef8a27@tls.msk.ru>
Date: Thu, 19 Nov 2026 16:31:51 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2] hostmem: allow building without KVM support
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>
References: <20261119131518.275237-1-pbonzini@redhat.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261119131518.275237-1-pbonzini@redhat.com>
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

On 11/19/26 16:15, Paolo Bonzini wrote:
> Queued, thanks.

Please queue the v2 which is with a complete commit message :)

Thanks!

/mjt

