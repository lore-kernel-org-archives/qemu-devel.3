Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3450C624D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x22k7-0004Za-DJ; Thu, 03 Sep 2026 04:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1x22k3-0004ZR-HY
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 04:24:15 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1x22k0-0002vg-Pq
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 04:24:14 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 21D6A60229
 for <qemu-devel@nongnu.org>; Thu,  3 Sep 2026 08:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E1E1F00A3A
 for <qemu-devel@nongnu.org>; Thu,  3 Sep 2026 08:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788423849;
 bh=psxytfP6ICFcT+SLtMJ65T/ugPFAj1TKzzb2ssb8wl8=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=c3InyPYRYA6HHMGyX96KOA18XFikE+tBU0DYCw1+j2E/K4jjzWb9Ubv/yOzhoObNH
 JJ+VNREa7dmNxL1w84v6CIpIur70eKGZlFoPiMwUSqunwvBFQS1s1DCTyyf2pjjpyq
 2lzrQ8cjbV0H/q/K8LD1u+hPurQA+ARWNtHdYcElh7WhaC8RiPxg7sLs0YL/UqiZ41
 VC+NCPhn97VM8c2+Z/pIKDs6R9VlpDrjmFUYMTRso6ilEyyud79pWdV9TLmNxiSlpF
 Vwm5N9XHLvI3YVR0ewpILWuI6NV9/T12Na6NH+zzPP3McDoibgNM7p9h3vgwWnDlVX
 JbxfyEtglf37w==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
 by mailfauth.ams.internal (Postfix) with ESMTP id 1804A1980050;
 Thu,  3 Sep 2026 04:24:08 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
 by ams-compute-02.internal (MEProxy); Thu, 03 Sep 2026 04:24:08 -0400
X-ME-Sender: <xms:pi6ZamcrJD9qICrOAh_HdmIS__9FN8wS_IsaQ1Dzo1ZreoOWa1q4yg>
 <xme:pi6ZarDY55G4-ALBJnUhIdyNqeIQkQMqFKbwbDKDe7_6qgLpniWJgmUfoST1taGmx
 hvYN_HBXN0GMWU69DzVpElPmD7rzB0NU93HGSuf6xuJllj04eBnjILG>
X-ME-Proxy-Cause: dmFkZTFTgPsWRGzxZd24Hq45yxylMCUAPldjyj1yCLJGnuAfLXy8S7swhDDHF4cWOiC+rq
 ugDwSdoEIIm7IAuccqKejOUJCAj1owrd/VlQQwyPj7yivYP7WZ8soEfGGW5acBNy0zXa7m
 zpwzEP1xMkmraKgJuhmv6Nbt10x8iLWOzdb2j8bvvKx4CJKjDNqaoeGRUaGXrzEqaxZcGR
 7KIlY20ZACt4jzspPOu7zEHomB7mlFrOm6hAqtdPL47YVMl2KPKgrDJ6iwoiaGMmc5AC2U
 nVkZ9O+iVUjk3rKLlEfSW/3LErPYphP8iTekElyOpiZpAHFUSxNQ7qjqkphMAJJ8SJgTi5
 A1onbCoshkmZXopYH6AAfPojeNiYzelUJQZJAL6VNDtIZ06mXKdqc3NKF5mi+9dkj+NTXP
 3b6J6Y4V/qgwCuLeYsnTaoH1rhPeDb4PcasPTIyTA4bywsYCm/oMunFJ4QMtjALVg4QSen
 5852GElpRmx0hqsP6+0bguofH6unStH32lLZJOzOoHmGDl85uKlIGxxKfBcVy1ASfeLXc0
 rJvFsr9R3z9rvIqlx0PRco+z8r9ibYviZIMfecfTZvHk/bbM8AFsOxfT4mKrf6kiZRQNli
 ig5VVQRMs+m649K5tA6VEzO64dN4XBjXtDv2A/Y+Gp34vSsBY+D/L8tf5VpQ
X-ME-Proxy: <xmx:qC6ZakY_uBSJcKgFDt3MlRSoi_qlQMe3z_MkCr2brcr3sxzPvYwM4A>
 <xmx:qC6ZanJYnkxMaB_qkgc9WlYIuV3BbzPyqEOI2Kvz5JrPXGthLfy9AQ>
 <xmx:qC6ZaiCQW7Jobe4suvbeshk1xbJIEV-yf9iDCdAtahHr0PjFdBtggQ>
 <xmx:qC6ZasqeitxiWg5wywEp8iu1hP5Tb6aEuUI4hYzZINQ9ThHP58bbSQ>
 <xmx:qC6Zatghum2HA7KXMFsBhJtgqIjG6LxPnPcz2BJw-qinps8FHPzrQJ5O>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
 id DD425F8007E; Thu,  3 Sep 2026 04:24:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Thu, 03 Sep 2026 10:22:21 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Ilya Leoshkevich" <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: "Paolo Bonzini" <pbonzini@redhat.com>
Message-Id: <f0fa779c-3ecc-4432-820a-ead9f22b1e34@app.fastmail.com>
In-Reply-To: <3f5d70c1-f8a6-4b7d-aef5-66aebbb4b623@linux.ibm.com>
References: <20240929180659.3598-1-ardb@kernel.org>
 <3f5d70c1-f8a6-4b7d-aef5-66aebbb4b623@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] Fix PVH entrypoint parsing
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=ardb@kernel.org;
 helo=tor.source.kernel.org
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



On Thu, 27 Aug 2026, at 20:52, Ilya Leoshkevich wrote:
> On 9/29/24 20:06, Ard Biesheuvel wrote:
>> Fix the handling of the ELF note that describes the PVH entrypoint
>> 
>> v2: fix broken ELF note handling on big endian hosts
>> 
>> Ard Biesheuvel (2):
>>    hw/elf_ops: Implement missing endian swabbing for ELF notes
>>    hw/x86: Always treat the PVH entrypoint as a 32-bit LE field
>> 
>>   hw/i386/x86-common.c     |  7 ++-----
>>   include/hw/elf_ops.h.inc | 19 +++++++++++++++++--
>>   2 files changed, 19 insertions(+), 7 deletions(-)
>
> This series still applies cleanly and fixes the following test failure
> on s390x hosts:
>
> $ make -C build/tests/tcg/x86_64-softmmu run-hello
> make: Entering directory 
> '/home/user/src/qemu/build/tests/tcg/x86_64-softmmu'
>    TEST    hello on x86_64
> qemu-system-x86_64: Error loading uncompressed kernel without PVH ELF Note
>
>
>
> Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>

Thanks for testing.

Ping to the maintainers?

