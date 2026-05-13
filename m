Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67295CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 19:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNF13-0000h5-SR; Wed, 13 May 2026 15:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pali@kernel.org>) id 1wNF12-0000gr-NZ
 for qemu-devel@nongnu.org; Wed, 13 May 2026 15:13:08 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pali@kernel.org>) id 1wNF11-0004ML-CM
 for qemu-devel@nongnu.org; Wed, 13 May 2026 15:13:08 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 606F8600AE;
 Wed, 13 May 2026 19:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26C5C19425;
 Wed, 13 May 2026 19:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778699575;
 bh=3TMB0rk/GvXhNBXZfU1f8lOLSPZ8XtYke1PFuJW1Gig=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=thI5/Skm8vuVkf196pQb0S3LBr/3JQgh3Q+dPsHJA5Dn94QGa9MaVj12C9E8g9HaP
 RXDh5nK+wsH7uvU8O3x+upKGuc5L/PqGkfidVczgvAe929bGZmQFIzR9kxMeXec7ut
 czDEPNEZ+ehDZb3Agb4zqjg7XU/8enhLOdpM1ZFty3sbUbdfF4izZxfPyHIUe120f0
 Yt3pLzH9bL15BB/ywFvhUh7XpcQzRgzxybZXZNJ3Gqq5E0tmHK5SnwgPXkp0erGKhn
 GCRq0hYMn5IKqgs7C7UIcnyrD0/cF1Q+PvYLcRyZkkQ6kkHL39Hw0pgQBggEQMpkHW
 QTs6OFMyZuJUA==
Received: by pali.im (Postfix)
 id 1CCBBBA0; Wed, 13 May 2026 21:12:43 +0200 (CEST)
Date: Wed, 13 May 2026 21:12:43 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jason Wang <jasowang@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: Re: [PATCH] qemu-options: Improve description for -smb option
Message-ID: <20260513191243.7v2y7vrhdsebfpki@pali>
References: <20250802110549.23438-1-pali@kernel.org>
 <20250810130948.3yzymcxtkmfkgk67@pali>
 <20251109134141.ur2s3bk5e6dgquxv@pali>
 <CAFEAcA8+cycE_JvFDEtAmbJtXwRVwU026rOBYNV+cZaq5wZ+XQ@mail.gmail.com>
 <20260418012012.by2qdlkbryjf2ugv@pali>
 <CAFEAcA8VcTN1ANX0EpCqCiyBVDckCp-D99TxabAghxtLdnMkgA@mail.gmail.com>
 <20260502154649.yuf7j7224duwveje@pali>
 <CAFEAcA8KJ91_KyN6x9qhkdHPmHgEkLAxfqB5=c4c-Ts_y7gWnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8KJ91_KyN6x9qhkdHPmHgEkLAxfqB5=c4c-Ts_y7gWnw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=172.105.4.254; envelope-from=pali@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Sunday 03 May 2026 15:41:15 Peter Maydell wrote:
> On Sat, 2 May 2026 at 16:46, Pali Rohár <pali@kernel.org> wrote:
> 
> > I have one just question regarding the (English) wording:
> >
> > "... to tell it not to send QEMU NBNS query packets that QEMU does not handle"
> >
> > Should not be there word "send to" QEMU? Packet is "NBNS query", it is
> > not "QEMU NBNS packet", packet comes from Windows and is sent to QEMU.
> >
> > E.g.:
> > "... to tell it not to send NBNS query packets to QEMU that QEMU does not handle"
> > or just:
> > "... to tell it not to send NBNS query packets that QEMU does not handle"
> >
> > Sorry if this is a stupid English question, I'm not native English
> > speaker and sometimes I write or understand English words in wrong order.
> 
> No worries. It works both ways in English: you can say "I sent my
> friend a letter" or "I sent a letter to my friend", and they
> mean the same thing.
> 
> But I think I prefer "not to send NBNS query packets that QEMU does
> not handle" because it avoids awkwardly repeating "QEMU" and also
> it avoids the potential ambiguity in "QEMU NBNS query packets".
> So since I need to reroll this pull request anyway I've updated
> the phrasing.
> 
> thanks
> -- PMM

Ok, thank you for the explanation (I think that I did not use the first
form so it looked a bit strange for me) and also taking care about this
change and updating it. Now I see that it is in the git repository.

