Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F11C79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 17:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4iLG-0007ZS-Qr; Thu, 10 Sep 2026 13:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@galbraiths.ca>)
 id 1x4iL8-0007Z1-6T
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 13:13:34 -0400
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@galbraiths.ca>)
 id 1x4iL5-0004dZ-Tb
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 13:13:33 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 9A6A61D000E8;
 Thu, 10 Sep 2026 13:13:27 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
 by phl-compute-05.internal (MEProxy); Thu, 10 Sep 2026 13:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=galbraiths.ca;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1789060407; x=1789146807; bh=YaentEB5rrZ1zF3XapgYi9R4jtdAnWDh
 g/vOg1A9Tpo=; b=nlJTotFpjD2yZO/dkubw+jEL56b1SFiHJfYl2p37X/yDsxcc
 THEAMUirb23yJOo4hLKHcDpg925XbM3Nsn0i0IzVV8LdKzAY97YBuLylmgGpZktO
 UIC0NDB0vLiKwtcMr9H75qw3CqTR7acurnQBbIHMnifwnAeOwLABhjIAbu1TxFV8
 sztb8ux2buUmSUgDGd62fq4Sraa2Vw69OmZYbta34WbiCxc+aZi3GiVJNWSn5Qwj
 ZQstfzX79REOVWLCPROCXnUwpVK9q/2u4+gKH3nvDC5I4K8yWPpmc4W32HYgOcBk
 H8Og3ltmlh7GcWLDUZhR7UtxkKVf0A47aq5NeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789060407; x=
 1789146807; bh=YaentEB5rrZ1zF3XapgYi9R4jtdAnWDhg/vOg1A9Tpo=; b=E
 qzeVwX8K+5DNIxWFA96t96xiUXZyiX/V6gds6W4lu/kPXwgpo8Dkak/RtA4raFiY
 WeFvFFBBEwEJF6d2dl/QrRPAvmTdOdTnHoKDH6lfQcfO/0/MU6E3HS8gO+YkOmBJ
 n0EW7vpBt5+0gcFGNsSdWeIHLUtd7nJtmDSCoIL3UjfqB/8PllqB9ULKnO67MWuX
 lMoyyUEnC72ItrAJ+x2XaKNXIRa2P9zCZp6i/y4zCCpgnIfTH96sVhXBIWrIujJL
 XdzbG/OPfDDiZvLYSe1l2BMu1XAlWmm39r4xJsUQ3agiuPy8ppF0XwM25Eolrwem
 qe+4hgr9mEvz7Kb6OBQNQ==
X-ME-Sender: <xms:N-WiaivRqRORIQRD93CjxyxlmAkzTSr3R7R1pkaF0VAzxE-EACWBAg>
 <xme:N-WiaiSFbepZHthgEzRGgVHeQGklvTXlRNff1YZOd8JnNiKIQzB3g_ESG94N7QYdh
 o7ggUn0tRtt1Q42VVk8M2bW23TAh3mjAGM7XNjJ1MkWOnNXs8_d_33L>
X-ME-Proxy-Cause: dmFkZTGtjgiOJyaW0O74uyaOxhR01nbXDLbr6ShoDmOe9C+McZ2/fhm9ya40RkUNleBh/O
 4W17gBtVBiHrY0lM0VUwpQLIMXuj4HlFym4/8qvNhz+oRckZfLMEX2VVSOJ0k/8FBWVM0Z
 RmKxca8D6X77oTYU2Zi9RPEJy0o6wOJs9JCMe4wRJQ7a/VAFsdtTwsu2cL3FyUhrQuffYG
 hqAH3neidR22eSZqP4sPdC98vHRrsSmNTWiMf7TTrRd6/Qz86bA1cepuWVArXM4VlDB001
 lm0V3+W2FwKPG4dnhn5VoeHfX+3qOciREv8FlgYeIToljlBwTvMfA+/K+4rDogJWHCF5kg
 REibxeUzeYNQ5l1s7D0owVivaaHW0DcxXbJlyEHVRGffuSvvHWfcRzMCebhA4j7bYHCXam
 8c3RaOY61CrZCqKJtu8EO3tm98Bw45r2ZMtUijy2ZR1acr3jAOkp+6OQ/0YBgrrFOCoYiF
 aYEXnGyZlwahLdVuet0jM/FdJtFgKX0qMKw3aO1XTefLnbauz17e1asFi1UPeJpzLMkeWB
 ggHGoG/SPL+ZXlTBjI5XwDLxeob80F7jcQzbIOmuP1skqOhJaXSgQeIKVMP2c+gpXN8Nb7
 58m1rfjZ1HkXA9rHlSfA4hb7fC/Hvj+yH36aRpFKZrJJJIyP8fznf+QIt+Vg
X-ME-Proxy: <xmx:N-WiaqMmB9mL54NSOzHmxbh9wrfhDH6PU2kUtWN0dME2A0I81aZf8A>
 <xmx:N-Wiagbd135B9xTvRFFJGYiiaWrB-2uuO1_ZJsXI6AWX8inN5Pt5nw>
 <xmx:N-WiauqHghw9TVYr0V7_7BBKjuXfMgUo5Oe6tcnj80WTeRC_aTgz9A>
 <xmx:N-WiakaeMoof2_I48QmbXbGMA6MWJMqkEqeG36VdS428qcSqMS1rrQ>
 <xmx:N-WiapnUAoD1YchvS4c4GROUaCgK_zFa96IELUdtZgZEDK066f2umWSB>
Feedback-ID: i00314697:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 096FC240009A; Thu, 10 Sep 2026 13:13:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 13:13:06 -0400
From: "Paul Galbraith" <paul@galbraiths.ca>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org
Message-Id: <b22ce8dc-023b-4de2-b821-0624deb120bd@app.fastmail.com>
In-Reply-To: <6c5fca8e-b9f4-48a0-a070-42f10d1f942b@app.fastmail.com>
References: <6c5fca8e-b9f4-48a0-a070-42f10d1f942b@app.fastmail.com>
Subject: Re: [PATCH] target/i386/tcg: fix EIP truncation for wrapping 16-bit
 near branches
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.12.124.149; envelope-from=paul@galbraiths.ca;
 helo=fout-b6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

Ping on this one.

Short version: in a 16-bit code segment, a near CALL or JMP rel16 that only
reaches its target by wrapping EIP through 0xFFFF runs with EIP left
untruncated. The SDM has the 16-bit form truncate EIP to 16 bits, so in my
test the branch should land at CS:0x0020, and instead execution carries on at
EIP 0x10020.

It's fiddly to hit. You need all four of these at once:

  - a 16-bit code segment, D/B clear, so it really is a rel16 and EIP really
    is masked to 16 bits

  - a cs_base that isn't page aligned. If it is aligned, the wrap always
    crosses a page boundary in the linear address too, and the existing
    same-page test happens to give the right answer

  - the untruncated linear target landing in the same guest page as the start
    of the TB, which is what makes gen_jmp_rel() skip the masking

  - a CF_PCREL translation. It goes away under -d nochain and under
    -accel tcg,one-insn-per-tb=on, both of which set CF_NO_GOTO_TB and force
    the masking back on

One thing I got wrong in v1: it dropped the data16-in-code32 guard on the
assumption that the new condition subsumed it. It doesn't. That guard is
there for a different case, EIP starting out above the mask, so v1 would have
swapped one problem for another. v2 does something narrower and leaves the
guard where it is.

The test is the same test with the same geometry, just split out into its own
patch and wired into tests/tcg/i386/system/meson.build now that the tcg tests
meson rework has landed.

I'll send v2 as a new thread shortly and link it back here.

Paul

