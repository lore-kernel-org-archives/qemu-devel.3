Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934EEC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kQa-0003dL-8l; Tue, 29 Apr 2025 08:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1u9kPa-0002XD-Q7
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:50:13 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1u9kPX-000691-Aj
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:50:09 -0400
Received: from example.com (unknown [20.107.5.167])
 by linux.microsoft.com (Postfix) with ESMTPSA id 85F92211AD21;
 Tue, 29 Apr 2025 05:50:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85F92211AD21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1745931005;
 bh=ns6+0s0UaAGhlbbCqiHdm1pFKIB+Rz0chhyo7IYM/v4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fYzcHlMeD5xHksDvVNRk1WI5r5HYT+63BSik9oUt+ppTqhBNdGlWBPnJ753Plh2gy
 wOL4seE4ORiT4yhw8d5ZdTT6cT+MbWE7q6kWQu1VO3rH5++IkNyMz0wfmc9w+F85qr
 Vw3x3pSCJnnGMevLAtoiplEfd+A1ITdasONh1W6o=
Date: Tue, 29 Apr 2025 14:49:56 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: Re: [PATCH v3] target/i386/emulate: remove rflags leftovers
Message-ID: <aBDK9Cd8AQn1H18t@example.com>
References: <20250429093319.5010-1-magnuskulke@linux.microsoft.com>
 <CABgObfaxzxdBf3f-JwKA8osOwZZQf-dqpsambpAFhPvkvjDo8w@mail.gmail.com>
 <aBDBExDzR57PcRre@example.com>
 <CABgObfbCSnQxdFzexobKr9HtoGcB_5R_6eioCzAvMyc6ZzGypw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfbCSnQxdFzexobKr9HtoGcB_5R_6eioCzAvMyc6ZzGypw@mail.gmail.com>
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

On Tue, Apr 29, 2025 at 02:27:21PM +0200, Paolo Bonzini wrote:
> Il mar 29 apr 2025, 14:17 Magnus Kulke <magnuskulke@linux.microsoft.com> ha
> scritto:
> 
> > Yes, I'm using the generalized emulator in the context of adding the MSHV
> > accelerator. (I'll probably get around sending an RFC patchset this week
> > for
> > it). There were minor compilation issues w/ the emulator code, that I had
> > to
> > fix to make it compile on Linux. However I don't have access to an x86_64
> > Mac for development either, so I can't test a HVF build.
> >
> 
> No problem, using MSHV to test if I am breaking anything in the emulator is
> enough!
> 
> Paolo
> 

Sure CC me, I'll try to keep up and test the changes.

> Best,
> >
> > Magnus
> >
> > > ---
> > > >  target/i386/emulate/x86_decode.c | 17 ++++++-----------
> > > >  1 file changed, 6 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/target/i386/emulate/x86_decode.c
> > > > b/target/i386/emulate/x86_decode.c
> > > > index 7fee219687..7efa2f570e 100644
> > > > --- a/target/i386/emulate/x86_decode.c
> > > > +++ b/target/i386/emulate/x86_decode.c
> > > > @@ -1408,7 +1408,7 @@ struct decode_tbl _2op_inst[] = {
> > > >  };
> > > >
> > > >  struct decode_x87_tbl invl_inst_x87 = {0x0, 0, 0, 0, 0, false, false,
> > > > NULL,
> > > > -                                       NULL, decode_invalid, 0};
> > > > +                                       NULL, decode_invalid};
> > > >
> > > >  struct decode_x87_tbl _x87_inst[] = {
> > > >      {0xd8, 0, 3, X86_DECODE_CMD_FADD, 10, false, false,
> > > > @@ -1456,8 +1456,7 @@ struct decode_x87_tbl _x87_inst[] = {
> > > >       decode_x87_modrm_st0, NULL, decode_d9_4},
> > > >      {0xd9, 4, 0, X86_DECODE_CMD_INVL, 4, false, false,
> > > >       decode_x87_modrm_bytep, NULL, NULL},
> > > > -    {0xd9, 5, 3, X86_DECODE_CMD_FLDxx, 10, false, false, NULL, NULL,
> > NULL,
> > > > -     RFLAGS_MASK_NONE},
> > > > +    {0xd9, 5, 3, X86_DECODE_CMD_FLDxx, 10, false, false, NULL, NULL,
> > > > NULL},
> > > >      {0xd9, 5, 0, X86_DECODE_CMD_FLDCW, 2, false, false,
> > > >       decode_x87_modrm_bytep, NULL, NULL},
> > > >
> > > > @@ -1478,20 +1477,17 @@ struct decode_x87_tbl _x87_inst[] = {
> > > >       decode_x87_modrm_st0, NULL},
> > > >      {0xda, 3, 3, X86_DECODE_CMD_FCMOV, 10, false, false,
> > > > decode_x87_modrm_st0,
> > > >       decode_x87_modrm_st0, NULL},
> > > > -    {0xda, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
> > NULL,
> > > > -     RFLAGS_MASK_NONE},
> > > > +    {0xda, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
> > NULL},
> > > >      {0xda, 4, 0, X86_DECODE_CMD_FSUB, 4, false, false,
> > > > decode_x87_modrm_st0,
> > > >       decode_x87_modrm_intp, NULL},
> > > >      {0xda, 5, 3, X86_DECODE_CMD_FUCOM, 10, false, true,
> > > > decode_x87_modrm_st0,
> > > >       decode_decode_x87_modrm_st0, NULL},
> > > >      {0xda, 5, 0, X86_DECODE_CMD_FSUB, 4, true, false,
> > > > decode_x87_modrm_st0,
> > > >       decode_x87_modrm_intp, NULL},
> > > > -    {0xda, 6, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
> > NULL,
> > > > -     RFLAGS_MASK_NONE},
> > > > +    {0xda, 6, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
> > NULL},
> > > >      {0xda, 6, 0, X86_DECODE_CMD_FDIV, 4, false, false,
> > > > decode_x87_modrm_st0,
> > > >       decode_x87_modrm_intp, NULL},
> > > > -    {0xda, 7, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
> > NULL,
> > > > -     RFLAGS_MASK_NONE},
> > > > +    {0xda, 7, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
> > NULL},
> > > >      {0xda, 7, 0, X86_DECODE_CMD_FDIV, 4, true, false,
> > > > decode_x87_modrm_st0,
> > > >       decode_x87_modrm_intp, NULL},
> > > >
> > > > @@ -1511,8 +1507,7 @@ struct decode_x87_tbl _x87_inst[] = {
> > > >       decode_x87_modrm_intp, NULL, NULL},
> > > >      {0xdb, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
> > > >       decode_db_4},
> > > > -    {0xdb, 4, 0, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
> > NULL,
> > > > -     RFLAGS_MASK_NONE},
> > > > +    {0xdb, 4, 0, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
> > NULL},
> > > >      {0xdb, 5, 3, X86_DECODE_CMD_FUCOMI, 10, false, false,
> > > >       decode_x87_modrm_st0, decode_x87_modrm_st0, NULL},
> > > >      {0xdb, 5, 0, X86_DECODE_CMD_FLD, 10, false, false,
> > > > --
> > > > 2.34.1
> > > >
> > > >
> >
> >

