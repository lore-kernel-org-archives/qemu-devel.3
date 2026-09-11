Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E7BC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 11:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4z1p-0007nn-W8; Fri, 11 Sep 2026 07:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x4z1o-0007nS-0m; Fri, 11 Sep 2026 07:02:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x4z1l-0005JB-Kd; Fri, 11 Sep 2026 07:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789124526; bh=5yO+NtNZIrXaU7NWRktWqw5hLSUPASMysdCeN6GN+uM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=YtrpV2FTf1IfyfV2xBLH8K19sTvPC3LdX/QwED2oVmFuyOzUfBnJ0vSq7sokZiXuD
 sdo0o7XVwQUnXwyxCB05dgipp+G1LXHGajK9w+ZJWAJv6DEi17NZdD+7zErLWUATs4
 z0GQqSReDxYnrA8d3Q8NEtXV75jfKc5qOFhRRwLsTUrWLrPDXjFsHN56Avok1pK3wa
 vEX+N2Ny1QfszkwGjkj5doGreaRjR5C8AjjCVJerU4Mmi95mwXgg2P7fBg4WdeCm7V
 aQDnMhs2ZCecu8TvmYQ/47V0IK1ZxTOXl8eRygOVIyBBIS6sbqby535aqKOfUB1bt5
 HObgUzohcXwdQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CF0A41D3B92;
 Fri, 11 Sep 2026 14:02:06 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8E62E425E04;
 Fri, 11 Sep 2026 14:02:39 +0300 (MSK)
Message-ID: <23f23783-e70b-492f-b765-ccc74c2bef59@tls.msk.ru>
Date: Fri, 11 Sep 2026 14:02:39 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PULL 00/12] Misc patches for 2026-09-09
To: Simon Scherer <scherer.simon89@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Andrey Polivoda <apolivodaa433@gmail.com>,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260909155624.1082893-1-pbonzini@redhat.com>
 <ab12c39c-5d5d-4c4a-8486-3072f85c25f6@tls.msk.ru>
 <CAEQwQtLVJa9du6KHb4Aoo5TbDOiO++AkVnpYfR8hrnirHxrOcw@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CAEQwQtLVJa9du6KHb4Aoo5TbDOiO++AkVnpYfR8hrnirHxrOcw@mail.gmail.com>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/11/26 13:42, Simon Scherer wrote:
> Mostly yes, but one caveat on "target/i386: clear C1 for all x87 compare
> instructions": part of that commit is wrong.
> 
> The FCOM/FCOMP/FCOMPP/FUCOM/FUCOMP/FUCOMPP/FICOM/FICOMP part is correct and
> hardware-verified. The FCOMI/FCOMIP/FUCOMI/FUCOMIP part is not: the SDM lists
> "C1 Set to 0" for those, but real x86-64 hardware leaves C1 unchanged. I
> caught this after v2 was posted and sent a v3 dropping these changes
> [https://patchew.org/QEMU/20260902135705.261863-1-scherer.simon89@gmail.com/],
> but
> v2 was the version applied.
> 
> I'm sending a follow-up fix on top of master now that reverts just the
> fcomi/fucomi changes.

Thank you for the explanation.  I'll wait for the follow-up patch here.

/mjt

