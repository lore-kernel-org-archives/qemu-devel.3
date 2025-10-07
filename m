Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C359DCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v65WR-0000Sc-IP; Tue, 07 Oct 2025 07:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v65WO-0000QE-0H
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:06:20 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v65WK-0003UY-LY
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=gX8VQCWJR7zDbpsXgSUUkpDD6khT+8oQhkwzLEGx3BY=; b=fuhr3gi7wGr22E/
 L4c/m222AM4SrzBWKtUkyrKll4oablBySBCkscQM/hk57jt8qevOn+l/f+ZT66xfL0JoNR+AdnQVk
 gQjFeNKAK1qfwPmhtxC7gGWvZaPXy7wYzZrWA+8KVj5zHHDzQx2gndeytc8Q8/fhZFsU4ngHR6GbO
 qk=;
Date: Tue, 7 Oct 2025 13:08:56 +0200
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Subject: Re: [PATCH v2 04/33] target/riscv: Bugfix
 riscv_pmu_ctr_get_fixed_counters_val()
Message-ID: <vca6pziwhxzd3pliu3jggzy4e2slsmrea5luazwmz4vav23qwn@3fzj75kzprya>
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-5-anjo@rev.ng>
 <CAKmqyKMSViOs=knzH0bi7k776FvqUX2=XtnKmGrHaeG79=qYEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKMSViOs=knzH0bi7k776FvqUX2=XtnKmGrHaeG79=qYEw@mail.gmail.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 03/10/25, Alistair Francis wrote:
> On Wed, Oct 1, 2025 at 5:43 PM Anton Johansson via
> <qemu-devel@nongnu.org> wrote:
> >
> > From my understanding the upper_half argument only indicates whether the
> > upper or lower 32 bits should be returned, and upper_half will only ever
> > be set when MXLEN == 32.  However, the function also uses upper_half to
> > determine whether the inhibit flags are located in mcyclecfgh or
> > mcyclecfg, but this misses the case where MXLEN == 32, upper_half == false
> > for TARGET_RISCV32 where we would also need to read the upper half field.
> 
> If MXLEN == 32, upper_half == false then we want to read mcyclecfg,
> which the code today seems to be doing correctly.

Hi again, I might be missing something then, when would this function need
to access mcyclecfg for MXLEN == 32?  AFAIU mcyclecfg and mcyclecfgh are
modeled separately for MXLEN == 32, even when sizeof(target_ulong) == 8.
Since this function only checks inhibit flags wouldn't we always want to
access mcyclecfgh for MXLEN == 32?

//Anton

