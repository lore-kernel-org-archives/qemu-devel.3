Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A0BC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtjRx-00028b-OJ; Tue, 11 Aug 2026 06:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wtjRv-000287-NO
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:11:11 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wtjRu-0002wb-66
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=qNyPZWqoTlnTGi5ui4sHCzOa7hCR+B1RNVXGPGCYdxk=; b=Ds3b4O0F9vrfeF8
 7wPxDtctw2Kq2kvvnMrGKmZst/ZVx/I6lnkb+pJMhxSTbygaPbvOuUBTEd7OC0ljiKArV+5wMiA4n
 bDWm5f2pHPlt4H+wzLWtxEIO8EGXaQf57Qv3yeBE1VBRzV1lGsr0X/26qaTFXW7dg21Y1ouT4IXNq
 t4=;
Date: Tue, 11 Aug 2026 12:16:26 +0200
To: Alessandro Di Federico <ale@rev.ng>
Cc: Anton Johansson via qemu development <qemu-devel@nongnu.org>, 
 brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com
Subject: Re: [PATCH v2 30/50] helper-to-tcg: Introduce TcgGenPass
Message-ID: <anr1e_pCcekeUiUn@hive.localdomain>
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-31-anjo@rev.ng>
 <20260807122720.7bda66c3@spawn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807122720.7bda66c3@spawn>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 07/08/26, Alessandro Di Federico via qemu development wrote:
> On Thu, 30 Jul 2026 05:10:04 +0200
> Anton Johansson via qemu development <qemu-devel@nongnu.org> wrote:
> 
> > +    std::error_code EC;
> > +    ToolOutputFile OutSource(OutputSourceFile, EC, compat::OpenFlags);
> > +    ToolOutputFile OutHeader(OutputHeaderFile, EC, compat::OpenFlags);
> > +    ToolOutputFile OutHelpers(OutputHelpersFile, EC, compat::OpenFlags);
> > +    ToolOutputFile OutEnabled(OutputEnabledFile, EC, compat::OpenFlags);
> > +    assert(!EC);
> > +
> > +    MPM.addPass(TcgGenPass(OutSource.os(), OutHeader.os(), OutHelpers.os(),
> > +                           OutEnabled.os(), OutputHeaderFile, Annotations,
> > +                           DebugInfo, TcgGlobals, VL));
> 
> I'd move all the `cl::opt` from this file to `TcgGenPass`.
> Ideally, passes should not have constructor arguments and should be
> runnable from `opt`.
>
> Make an effort to have all the passes be default constructible.

This is a good idea, maintaining all the `cl::opt` changes in the patchset was
also really cumbersome, this is easier.

I can make it so passes are runnable from `opt`, but I'm not sure how
useful it would be since our pipeline sets `TargetTransformInfo`,
meaning if you run all the passes independently from `opt`, you wouldn't
get the same result.  So you couldn't get to a point where you can run
`TcgGenPass` independently since you wouldn't have access to the correct
input IR.

-- 
Anton Johansson
rev.ng Labs Srl.

