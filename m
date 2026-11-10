Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE442606A332
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=tZQXC8bU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=A379yrQ+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQl9o-00055Y-GZ; Tue, 10 Nov 2026 07:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francesco@valla.it>)
 id 1xQl9L-0004rs-Dv
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:40:42 -0500
Received: from delivery.antispam.mailspamprotection.com ([185.56.87.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francesco@valla.it>)
 id 1xQl9G-0006lE-6z
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:40:28 -0500
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-ssp3.prod.antispam.mailspamprotection.com;
 s=arckey; t=1794314416; 
 b=W9YtiMuPfRHVOfBpQGf8nmJ/GqFPUqhG2wKSvBwrH8tBU6oi6ZSx84BzUg7qYOvcGUuX7WOUIT
 ReCP2nnry4d5kYHwKyqUaA2q94l9NGZLrZoKoVWKe4dS/870X1wQzE3olCf6y7hQQCpug1l5lq
 aiybRcLbkLklnV1ZLzrgZ3qRficBrqyYIQRalYH3LEZ2oVyZ/iD39fqdYmJ37SPT8g7dDIDjym
 DkaqA0Hrl0kwGsB3G8JX9CfTTyku8AgAUUUnYW+OSzkkt6UVUI4pq7Ve+OizWmUB+YzikGgg/j
 NvNeX6BFzD4n2SwwGUGomZ6uzbxglqCUZC5jwwJNEE+uVg==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-ssp3.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-ssp3.prod.antispam.mailspamprotection.com;
 s=arckey; t=1794314416; 
 bh=PlrmZtvhHQH65cK4S19EtA0P7mMM5S3UbBsmkytby94=;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:References:
 In-Reply-To:Message-ID:Cc:To:From:Date:DKIM-Signature:DKIM-Signature;
 b=oQFtQaCWpZZclm6TWANYEFGbiAtdlMgM8EbCCyfIw/vta2BMJdOxqTWoAEuilnOD0BlpIvK1aU
 nFYacKe9evrj4CPrj3VjPrppC2k+1ChktpAgYQCRh4bMDr7A3Vga/CA7H1kaVnLOirkeoqhHwr
 QVV2wnjNvnT6EkujbjxGn89JB3ljFNbP8cuVX57eGdKeU3GIhcXR+5TVGcfBJnYNd0KFYrqUSk
 Bv1Rs1JuiTgqoVNoZIP27nuUqemztkQuK6gGMPeZK8pHKqr6bRVfjx+5M7ZjaPKMdy+RCSnXaA
 BqdigUVy/IJ3S7y15Xs36g9PwQsBW+Ti8SAjwLHbecnqvg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Message-ID:Cc:To
 :From:Date:Reply-To:List-Unsubscribe;
 bh=PlrmZtvhHQH65cK4S19EtA0P7mMM5S3UbBsmkytby94=; b=tZQXC8bUlc7/th0xBcUIx9VnR8
 1d+9YdPF+DhXM//iHMFrq/GBwKle42esyREt2rkKLnrRDqG5nijfQ2h3w1f84RL3TXvPY6SKKmc7V
 MMb5zl48LjFKtUXgzLfuUouswysDxMdE7b0DnYlTn6yKIX2f2d2j0PR7dZP5PJXYY0GA=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-ssp3.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xQl93-00000007YKh-2bGv
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 12:40:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=PlrmZtvhHQH65cK4S19EtA0P7mMM5S3UbBsmkytby94=; b=A379yrQ+Kr/KtvWTzpm+PTpRGB
 /a+SVsbSAf3213orF+NT5BGMe6wmcku8LC8j5oo0x2mMqqtdeh+IwJqCIP1zIzZeGIWZ6yTOWgN7K
 B1s/pNYBUV/BUlMoXudvA2qYQzQFCwDe8H1xBmufLsABd0ya66z/GgH9Pd3W5c1EXy1M=;
Received: from [79.17.15.196] (port=61165 helo=dummy.faircode.eu)
 by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xQl8x-00000000Nbm-2p0K; Tue, 10 Nov 2026 12:40:07 +0000
Date: Tue, 10 Nov 2026 13:40:04 +0100
From: Francesco Valla <francesco@valla.it>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1d0bfca1-3ee2-4fad-b956-e28321161bba@valla.it>
In-Reply-To: <87mrrhvuzo.fsf@redhat.com>
References: <20261107175443.29012-1-francesco@valla.it>
 <87mrrhvuzo.fsf@redhat.com>
Subject: Re: [PATCH] update-linux-headers: strip endianness-aware __counted_by
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <1d0bfca1-3ee2-4fad-b956-e28321161bba@valla.it>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - nongnu.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: d4f6978b080e69eb90d2d1b6ba40b970
X-AntiAbuse: ID - d4f6978b080e69eb90d2d1b6ba40b970
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xQl93-00000007YKh-2bGv-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-ssp3.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
Received-SPF: pass client-ip=185.56.87.9; envelope-from=francesco@valla.it;
 helo=delivery.antispam.mailspamprotection.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

10 Nov 2026 11:31:04 Cornelia Huck <cohuck@redhat.com>:

> On Sat, Nov 07 2026, Francesco Valla <francesco@valla.it> wrote:
>
>> Deal with the endianness-aware __counted_by_be() and __counted_by_le()
>> annotations in Linux headers just like with __counted_by(): stripping
>> them.
>>
>> Signed-off-by: Francesco Valla <francesco@valla.it>
>> ---
>> scripts/update-linux-headers.sh | 2 ++
>> 1 file changed, 2 insertions(+)
>
> For virtio-can, I guess?
>

Correct. That's the usecase that needs this at the moment.

>>
>> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-head=
ers.sh
>> index 3c3a0e9394d2..d3f843356507 100755
>> --- a/scripts/update-linux-headers.sh
>> +++ b/scripts/update-linux-headers.sh
>> @@ -92,6 +92,8 @@ cp_portable() {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e "$arch_cmd" \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's/__bitwise//' \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's/__counted_by(\w*)=
//' \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's/__counted_by_be(\w*)//=
' \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's/__counted_by_le(\w*)//=
' \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's/__attribute__((pa=
cked))/QEMU_PACKED/' \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's/__inline__/inline=
/' \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's/__BITS_PER_LONG/H=
OST_LONG_BITS/' \
>
> Not sure if we would want to kill all the __counted_by* birds with one
> stone, but let's not overthink this.
>
> Acked-by: Cornelia Huck <cohuck@redhat.com>

Thank you

Regards,
Francesco


