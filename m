Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE5D606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=nlRnGbe/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKdXr-0003NT-GC; Sat, 24 Oct 2026 11:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xKdXp-0003Mv-Sb
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 11:20:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xKdXm-0004TF-IF
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 11:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792855215; bh=q5VN21T1TvPm7jkpw5ReY0yEZcWK6NSRFmDSlv/8FQA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=nlRnGbe/tlv3AYH2Z8RAnBOc7qGEkO4qZ4vm0+xZQz74g8L8GTq3zY/JynOK/tZml
 S4CHRmJeuzhF/k2IHoDYGKaSSXwgtbag7PdfeuKkiW8OQebnJ11rvuYDb9SrkaK2v3
 BSlU2pSbsdDSiJ1hBxXmJnKdfEOW8mC+gXUIRrvTvLzHyTLdPaf5595Cc6BuFq+pj7
 fnM5mHQ+YPSjZlUEhxb5px0HekcW+0GmtcWzTM+oaj42fd7mUTtsClqkO335MgTPbl
 hUPILBVKCqO/wB69O48Hi/y2NrGZQgKjmuIWJcuxADU/CrVlroMieLFPsdMxQAM4lq
 fiGP+3egG0h9w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 382BD1E0A0E;
 Sat, 24 Oct 2026 18:20:15 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C2B44449D64;
 Sat, 24 Oct 2026 18:20:14 +0300 (MSK)
Message-ID: <30a5032f-d82d-440b-90d2-259cbe004755@tls.msk.ru>
Date: Sat, 24 Oct 2026 18:20:14 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-user/vdso: reproducible?
To: Helge Deller <deller@gmx.de>, qemu-devel <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <c9bcda59-f2f9-4036-8aeb-1e36e1b68498@tls.msk.ru>
 <3653de48-cda5-4dd5-957f-fe86a069a2ad@gmx.de>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <3653de48-cda5-4dd5-957f-fe86a069a2ad@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/24/26 16:34, Helge Deller wrote:
> On 10/24/26 07:51, Michael Tokarev wrote:
>> Hi!
>>
>> Once again I'm trying to fix a long-standing issue in debian & ubuntu with
>> vdso files build.
>>
>> One of the requirements here is to build everything from source, ensuring
>> the things can be rebuild and are reproducible (that is, the shipped binaries
>> can actually be produced from the provided source and not something else
>> with a hidden backdoor).
>>
>> It'd be nice to just build the vdso.so files during regular package build.
>> But this does not work correctly neither in debian nor in ubuntu infrastructure
>> due to several reasons.  The main problem is that to build all vdso files,
>> one need to have cross-compilers for all architectures on every host
>> architecture for which qemu-user packages are produced, which is problematic
>> (especially for lower-power, or "small", architectures).
>>
>> Additionally, llvm/clang, which can produce binaries for multiple architectures
>> and is available on all host architectures on debian, does not handle sh4 and
>> hpps which are currently needed to rebuild vdso files in qemu, so it is also
> 
> I assume you meant "hppa" instead of "hpps".

Yeah, just a typo.


>> │ -cc0Lcfxq.o
>> │ +ccuckKYd.o

>> So basically, the difference is just in the temporary .o filename
>> used during the build process, and that name is random.
> 
> Is there a way to use a static name instead, e.g. tell the Makefile
> not to use a dynamic file name?

Well yes - either use explicit separate compile and link command lines,
or use -pipe (this eliminates this name entirely).

>> After stripping both files from debug info (aarch64-linux-gnu-strip),
>> things becomes exactly the same.
>>
>> Can't we strip them during build anyway?
> 
> If you strip them, you loose the ability to debug at runtime in the guest.

Sure.  These object files contains very little code, it's mostly just a
symbol table,  nothing more.  There's nothing to debug in there really.

Thanks,

/mjt

