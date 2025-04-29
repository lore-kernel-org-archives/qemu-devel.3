Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1877C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9jtv-0002WI-G0; Tue, 29 Apr 2025 08:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1u9jtj-0002Uo-El
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:17:17 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1u9jth-0008NJ-4E
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:17:15 -0400
Received: from example.com (unknown [108.142.230.59])
 by linux.microsoft.com (Postfix) with ESMTPSA id E09E0211AD34;
 Tue, 29 Apr 2025 05:17:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E09E0211AD34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1745929027;
 bh=1XPxPir8lra0UNtYxSHBdrPL662eZyHFWKwACucdB8s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VJKNy9Ih1Njm+/PZ/lL+luaU1CaL6kwLHfN42NwXBc/HFbLZnjDjwtdDRVgWZTP7L
 ZKtbUa7eTgo+uwba13Pli+OoRwl1vzI5YBcuy3E8wHKdNxC06S4GvqSMRaFV9Vu3O1
 5IFiaSjnosFAlwKcioi3gLi4KLgG8R/7g2Gmv4xU=
Date: Tue, 29 Apr 2025 14:17:01 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: Re: [PATCH v3] target/i386/emulate: remove rflags leftovers
Message-ID: <aBDBExDzR57PcRre@example.com>
References: <20250429093319.5010-1-magnuskulke@linux.microsoft.com>
 <CABgObfaxzxdBf3f-JwKA8osOwZZQf-dqpsambpAFhPvkvjDo8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfaxzxdBf3f-JwKA8osOwZZQf-dqpsambpAFhPvkvjDo8w@mail.gmail.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 29, 2025 at 12:02:48PM +0200, Paolo Bonzini wrote:
> Il mar 29 apr 2025, 11:33 Magnus Kulke <magnuskulke@linux.microsoft.com> ha
> scritto:
> 
> > Fixes: c901905ea670 ("target/i386/emulate: remove flags_mask")
> >
> > In c901905ea670 rflags have been removed from `x86_decode`, but there
> > were some leftovers.
> >
> > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> >
> 
> Thanks, I will queue thos; I have some more emulator patches but no way to
> test that, could you please help?
> 
> Paolo
> 

Yes, I'm using the generalized emulator in the context of adding the MSHV
accelerator. (I'll probably get around sending an RFC patchset this week for
it). There were minor compilation issues w/ the emulator code, that I had to
fix to make it compile on Linux. However I don't have access to an x86_64
Mac for development either, so I can't test a HVF build.

Best,

Magnus

> ---
> >  target/i386/emulate/x86_decode.c | 17 ++++++-----------
> >  1 file changed, 6 insertions(+), 11 deletions(-)
> >
> > diff --git a/target/i386/emulate/x86_decode.c
> > b/target/i386/emulate/x86_decode.c
> > index 7fee219687..7efa2f570e 100644
> > --- a/target/i386/emulate/x86_decode.c
> > +++ b/target/i386/emulate/x86_decode.c
> > @@ -1408,7 +1408,7 @@ struct decode_tbl _2op_inst[] = {
> >  };
> >
> >  struct decode_x87_tbl invl_inst_x87 = {0x0, 0, 0, 0, 0, false, false,
> > NULL,
> > -                                       NULL, decode_invalid, 0};
> > +                                       NULL, decode_invalid};
> >
> >  struct decode_x87_tbl _x87_inst[] = {
> >      {0xd8, 0, 3, X86_DECODE_CMD_FADD, 10, false, false,
> > @@ -1456,8 +1456,7 @@ struct decode_x87_tbl _x87_inst[] = {
> >       decode_x87_modrm_st0, NULL, decode_d9_4},
> >      {0xd9, 4, 0, X86_DECODE_CMD_INVL, 4, false, false,
> >       decode_x87_modrm_bytep, NULL, NULL},
> > -    {0xd9, 5, 3, X86_DECODE_CMD_FLDxx, 10, false, false, NULL, NULL, NULL,
> > -     RFLAGS_MASK_NONE},
> > +    {0xd9, 5, 3, X86_DECODE_CMD_FLDxx, 10, false, false, NULL, NULL,
> > NULL},
> >      {0xd9, 5, 0, X86_DECODE_CMD_FLDCW, 2, false, false,
> >       decode_x87_modrm_bytep, NULL, NULL},
> >
> > @@ -1478,20 +1477,17 @@ struct decode_x87_tbl _x87_inst[] = {
> >       decode_x87_modrm_st0, NULL},
> >      {0xda, 3, 3, X86_DECODE_CMD_FCMOV, 10, false, false,
> > decode_x87_modrm_st0,
> >       decode_x87_modrm_st0, NULL},
> > -    {0xda, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
> > -     RFLAGS_MASK_NONE},
> > +    {0xda, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
> >      {0xda, 4, 0, X86_DECODE_CMD_FSUB, 4, false, false,
> > decode_x87_modrm_st0,
> >       decode_x87_modrm_intp, NULL},
> >      {0xda, 5, 3, X86_DECODE_CMD_FUCOM, 10, false, true,
> > decode_x87_modrm_st0,
> >       decode_decode_x87_modrm_st0, NULL},
> >      {0xda, 5, 0, X86_DECODE_CMD_FSUB, 4, true, false,
> > decode_x87_modrm_st0,
> >       decode_x87_modrm_intp, NULL},
> > -    {0xda, 6, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
> > -     RFLAGS_MASK_NONE},
> > +    {0xda, 6, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
> >      {0xda, 6, 0, X86_DECODE_CMD_FDIV, 4, false, false,
> > decode_x87_modrm_st0,
> >       decode_x87_modrm_intp, NULL},
> > -    {0xda, 7, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
> > -     RFLAGS_MASK_NONE},
> > +    {0xda, 7, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
> >      {0xda, 7, 0, X86_DECODE_CMD_FDIV, 4, true, false,
> > decode_x87_modrm_st0,
> >       decode_x87_modrm_intp, NULL},
> >
> > @@ -1511,8 +1507,7 @@ struct decode_x87_tbl _x87_inst[] = {
> >       decode_x87_modrm_intp, NULL, NULL},
> >      {0xdb, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
> >       decode_db_4},
> > -    {0xdb, 4, 0, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
> > -     RFLAGS_MASK_NONE},
> > +    {0xdb, 4, 0, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
> >      {0xdb, 5, 3, X86_DECODE_CMD_FUCOMI, 10, false, false,
> >       decode_x87_modrm_st0, decode_x87_modrm_st0, NULL},
> >      {0xdb, 5, 0, X86_DECODE_CMD_FLD, 10, false, false,
> > --
> > 2.34.1
> >
> >

