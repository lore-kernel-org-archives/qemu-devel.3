Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619AEE74AC8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 18:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIY5C-0005q7-EJ; Tue, 03 Dec 2024 13:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIY56-0005pn-KT
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:57:10 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIY54-0001P0-HI
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=JtQuQXgxX8XivLgD9rn7O6D+5V+sd7qLOheO0wYYznU=; b=qtvSr2Up08tSj+i
 deWq9Jyet4lRY6feZQIwHo+62wUMJ0/ZoK6fci2kBFBMNmyeaPxrTnCFU48E9jn2xHIou59SCy103
 mNFhNl710WV3Jt7q//GlmP0C1nQ4pR5XzGXQhsOWj4pAeJrtqIdo0HXS6fat5t+WoeyKN440WN6YJ
 x0=;
Date: Tue, 3 Dec 2024 20:00:05 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org, ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 alex.bennee@linaro.org
Subject: Re: [RFC PATCH v1 08/43] include/helper-to-tcg: Introduce annotate.h
Message-ID: <b6agwi4yjkq5cly3fzx2o5cygwoton7gujw4oecjxhepozchaw@njgrsygxz3ec>
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-9-anjo@rev.ng>
 <0cc41877-c1fe-42ba-9a5f-b84563f25ba0@linaro.org>
 <97cd2bab-d2e2-4998-81ed-2a359f4019b4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97cd2bab-d2e2-4998-81ed-2a359f4019b4@linaro.org>
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

On 25/11/24, Philippe Mathieu-Daudé wrote:
> On 22/11/24 19:12, Richard Henderson wrote:
> > On 11/20/24 19:49, Anton Johansson wrote:
> > > Wrap __attribute__((annotate(str))) in a macro for convenient
> > > function annotations.  Will be used in future commits to tag functions
> > > for translation by helper-to-tcg, and to specify which helper function
> > > arguments correspond to immediate or vector values.
> > > 
> > > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > > ---
> > >   include/helper-to-tcg/annotate.h | 28 ++++++++++++++++++++++++++++
> > >   1 file changed, 28 insertions(+)
> > >   create mode 100644 include/helper-to-tcg/annotate.h
> > 
> > Is this really specific to helper-to-tcg, or might it be used for
> > something else in the future?  In other words, does it belong in
> > include/qemu/compiler.h?
> 
> We already have there QEMU_ANNOTATE() since end of 2022
> (use in commit cbdbc47cee, QEMU macro in d79b9202e4).

Oh this is very nice! I'll use QEMU_ANNOTATE() then! Thanks:)

//Anton

