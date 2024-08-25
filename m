Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79438C5320E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2024 05:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1si68D-0004IS-46; Sun, 25 Aug 2024 01:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1si68B-0004HL-Cx
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 01:49:39 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1si689-00047X-NO
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 01:49:39 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a866cea40c4so376770966b.0
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2024 22:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724564976; x=1725169776; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u+AXx1NranKnHe5gs6W+YUiWGU8zH6Rw9JCptNatzLE=;
 b=OVsR/dUzjeIIdpiO0S4Zb46aVO5wS1BvYWdv3pKkc4uCxyKNidpofc6NyOHKZq5xYt
 0lrXffoGq4BKOL1YmhMpksJy1Uqh3Caxuf66x1stjCIrkGdqlXTGCRy/0nt9bSDN+pct
 cUOpqYvEeJBBnaggg2GrYNFYae7+seOJeywjn06TxoaL3KscYXKKslsqjGvpkc+4I0z2
 p3wwn5YVMhqYPqagD6E4hHNeBHWqeSK4ya24S/z8alUHrmXUg3Vq7CIE7/ovdBkxpBpO
 gQpmAAK2Muvjv2YLU8dzkYF40aj9JpdFC2bXnTQfMMMWFZypVuvofEq2u+x0da/9cxHC
 xa4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724564976; x=1725169776;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u+AXx1NranKnHe5gs6W+YUiWGU8zH6Rw9JCptNatzLE=;
 b=O5NzxNPgUN2tJ/NkWvQNph8o8aBsStdnL3LiVENd6XS2Vtg+/sTC7vN5K1Q6WQ8gM3
 UvgC0eyXBLYY95fD4nd97Q0ttYD/FecpwamJF/TV40tpNynUe+be11WKBKfR8i+53OC9
 i3SshCfzZNF2swIKTrFhmOsNEP0Ec7SaAlpXY4ldtF9alM2W6+qldgqn12MpPw3FSxsU
 LZybiMbMUabnlCO24olhBE4gJdrEVXC7J/bLoq90nBc7yKyJ2eo4q853pLshnSLOhxt8
 Um33vl/7bFcgZ2hvneII9kDitQ3ktjsQRC3JvMicZu7V0ghWYUc3EQ41ewcYWfV6D1lg
 bIJg==
X-Gm-Message-State: AOJu0YxirMJwMymRfPdeLtPHGOnV4VZtspQyuUMjNX1N5cfDkIi42Lhp
 0iRHwbnsibdq78zB3Bq7aczdhl9v7uo4hDOW/QOpaOUuwdQaDMaO
X-Google-Smtp-Source: AGHT+IH+wwLLrvJPg5hCrP6C9l7eo8aRCGwxP8UQ5GUv0uCuOFmudTpmc5Bc+z9dmYn6VfIGzcsqVA==
X-Received: by 2002:a17:907:3dac:b0:a86:a56d:c4eb with SMTP id
 a640c23a62f3a-a86a56ddd24mr556527266b.61.1724564975602; 
 Sat, 24 Aug 2024 22:49:35 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f2e6102sm493408466b.94.2024.08.24.22.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Aug 2024 22:49:34 -0700 (PDT)
Date: Sun, 25 Aug 2024 06:49:33 +0100
From: Stafford Horne <shorne@gmail.com>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: qemu-devel@nongnu.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 linux-openrisc@vger.kernel.org
Subject: Re: [PATCH RESEND] hw/openrisc/openrisc_sim: keep serial@90000000 as
 default
Message-ID: <ZsrF7eDccRE2jPXc@antec>
References: <20240822163838.3722764-1-a.fatoum@pengutronix.de>
 <ZsgsG_WL7TNcM1_l@antec>
 <a90fe9aa-5835-4045-b719-8764cdb037cc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a90fe9aa-5835-4045-b719-8764cdb037cc@pengutronix.de>
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shorne@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Aug 23, 2024 at 09:23:23AM +0200, Ahmad Fatoum wrote:
> Hello Stafford,
> 
> On 23.08.24 08:28, Stafford Horne wrote:
> > Note the distribution list you use here: openrisc@lists.librecores.org
> > Is old and we should use linux-openrisc@vger.kernel.org.  I will get the qemu
> > maintainer file updated.
> 
> So this list is appropriate for all openrisc-related development and not only
> for the kernel?
> 
> > On Thu, Aug 22, 2024 at 06:38:38PM +0200, Ahmad Fatoum wrote:
> >> We used to only have a single UART on the platform and it was located at
> >> address 0x90000000. When the number of UARTs was increased to 4, the
> >> first UART remained at its location, but instead of being the first one
> >> to be registered, it became the last.
> >>
> >> This caused QEMU to pick 0x90000300 as the default UART, which broke
> >> software that hardcoded the address of 0x90000000 and expected its
> >> output to be visible when the user configured only a single console.
> > 
> > This makes sense but what do you mean here by DEFAULT uart?  I guess you mean
> > the one connected to qemu's stdout by default?
> 
> Yes. I am not keen on the QEMU terminology, but the first registered UART seems
> to have a special place. Besides being connected to QEMU's stdio by default,
> it's also used to populate /chosen/stdout-path as can be seen when dumping the dtb:
> 
>   qemu-system-or1k -kernel /dev/null -machine or1k-sim,dumpdtb=qemu.dtb -nographic
> 
> 
> >> This caused regressions[1] in the barebox test suite when updating to a
> >> newer QEMU. As there seems to be no good reason to register the UARTs in
> >> inverse order, let's register them by ascending address, so existing
> >> software can remain oblivious to the additional UART ports.
> > 
> > This sounds good to me.  I will test this out and queue to qemu after the small
> > clarification above.
> > 
> > Also, I will wait to see if Jason has anything to say.
> 
> Sure.
> 
> By the way, I botched the RESEND and forgot following two lines:
> 
>   Fixes: 777784bda468 ("hw/openrisc: support 4 serial ports in or1ksim")
>   Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> Let me know if I should resend (provided there's no code changes warranting a v2).
> 

This should be fine thanks.  I will fixup the commit message and repost after a
bit of testing to ensure this does not affect other environments including
Jason's test suite which uses the 4 UARTs.

-Stafford

