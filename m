Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD778CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 21:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEZDP-0001lv-TB; Wed, 07 Oct 2026 17:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xEZD5-0001bU-If
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 17:30:00 -0400
Received: from out-96.mta0.migadu.com ([2001:41d0:1004:224b::60]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xEZD3-0000Ap-9l
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 17:29:59 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=EFY0K+7wFpf/Ik/AB7Yke7xcUDcK6y2DfdWmZfQj8og=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791408592; v=1; x=1792013392;
 b=WcpfX9y6vjxSa0+/MRbWL5G1UCKzNl9Rgn7wq0cRK9uad7vwNDnyVGHZOy9ukzYyMn88Ccr8
 Tz7iHffTyuvbVXAFuG44VtU3k7OMkLqB6AXGwUFD4LHDJoqsU6x58GilDDhezRhjwNMcngyqnZn
 UHrYZuHDIBp9uSXQHdlnryOM=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 3dbb2b82ff39dbe1;
 Wed, 07 Oct 2026 21:29:52 +0000
X-Mizu-Trace-ID: 3dbb2b82ff39dbe1
X-Migadu-Flow: FLOW_OUT
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6afac79b3a3so1601a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 14:29:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBxojknNXN5Ac6Q79UnG3+n2Q0xiwcQEh6Vh2YvOu6uiKOUpJ7c5BmOwwl83uCSBblxtJtVCWdsqm+I0@nongnu.org
X-Gm-Message-State: AFq9FYLCOFLeNkNlPwJ53BH4PBQD/j3/p/jHYZn3cii6B2+9VnuH8Roi
 VsErNkzhWxhwIBfxPYqqP+sUA3KffRAa8vbVjBq0AW/4W5PdnTsfwF3vJsxaJBCyUBIFuwa9iyI
 SG/6SkNK1JzAsibPT+E0570RIwwKVaHm9VOe6PjlN
X-Received: by 2002:a05:6402:184c:b0:6ac:84a2:bdc7 with SMTP id
 4fb4d7f45d1cf-6b06cad7540mr4928a12.15.1791408587956; Wed, 07 Oct 2026
 14:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20261007080019.350315-1-fuad.tabba@linux.dev>
 <20261007080019.350315-4-fuad.tabba@linux.dev>
 <4ajscli4c4ef7agtizxzdiopjseck5qwa6s4n4mmwwjdrqlnby@xit5l76dxm2w>
In-Reply-To: <4ajscli4c4ef7agtizxzdiopjseck5qwa6s4n4mmwwjdrqlnby@xit5l76dxm2w>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 7 Oct 2026 23:29:11 +0200
X-Gmail-Original-Message-ID: <CA+EHjTxsC8K1Bw6fAMs6APaqVDpup8192dCeJs+vfeh2fN+6Aw@mail.gmail.com>
X-Gm-Features: AclHuK9GL_w9fjaenMwGKT6eHXXVvWvr5zmbuhLlmuqLQjB8RqSfp1rSzFAzsME
Message-ID: <CA+EHjTxsC8K1Bw6fAMs6APaqVDpup8192dCeJs+vfeh2fN+6Aw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tests/tcg/aarch64: Add a test for the 52-bit TTBR
 base address layout
To: Gustavo Romero <gromero@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, Will Deacon <will@kernel.org>,
 Itaru Kitayama <itaru.kitayama@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:41d0:1004:224b::60;
 envelope-from=fuad.tabba@linux.dev; helo=mta0.migadu.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On Wed, 07 Oct 2026 17:56:30 +0100, Gustavo Romero <gromero@redhat.com> wrote:
[...]
> > With a 52-bit OA, walk a two-entry level 0 table through an IPA with
> > bit 50 set, which stage 2 maps back onto the table, so the walk
> > succeeds only if TTBR[4] is cleared from bit 4 of the base address.
> > With TCR.DS or VTCR.DS and a 48-bit OA, check that setting TTBR[5:2]
> > is a level 0 Address size fault.
>
> Maybe move this commit message to ttbr-baddr.c header and just replace it with
> something like "Add a test for checking if with a 52-bit OA a walk ...".

Sure, I'll move it to the file header in v3.

> I like better the test split done in v1. There there are two tests and the
> changes are clear, helping to understand which parts of the test are related to
> each fix.
>
> So the organization I think is better for this series is:
>
> Fix 0
> Test 0
> Fix 1
> Test 1

Ack.

[...]

> > +    /*
> > +     * 52-bit OA: TTBR[4] is base address bit 50. Through stage 2, the
> > +     * table at HIGH_IPA | s1_l0 is s1_l0, so the walk succeeds only if
>
> I struggled a bit to make sense of this part: "Through Stage 2, the table
> HIGH_IPA | s1_l0 is s1_l0 ...", not so much for the duplication of s1_l0 in the
> text but because Stage 2 uses the s2_l* tables. Any chance you could enhance a
> the explanation here?

The level 0 table address is an IPA, and the s2_l2_high mapping is
what brings it back to s1_l0. How about:

        /*
         * 52-bit OA: TTBR[4] is base address bit 50, so with it set the
         * level 0 table is at IPA HIGH_IPA | s1_l0. Stage 2 maps that IPA
         * onto s1_l0 (through s2_l2_high), so the walk succeeds only if
         * TTBR[4] does not also offset the two-entry table by 0x10.
         */

Thanks for the review. I'll respin once Richard and Peter have had a look.

Cheers,
/fuad

