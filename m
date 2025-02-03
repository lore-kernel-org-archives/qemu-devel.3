Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5A2C02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 07:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teqdW-0002Uc-SS; Mon, 03 Feb 2025 02:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <midnight@trainwit.ch>)
 id 1teqdV-0002U8-Ab; Mon, 03 Feb 2025 02:12:49 -0500
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <midnight@trainwit.ch>)
 id 1teqdT-0007xQ-4M; Mon, 03 Feb 2025 02:12:49 -0500
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 141F213800E8;
 Mon,  3 Feb 2025 02:12:42 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
 by phl-compute-01.internal (MEProxy); Mon, 03 Feb 2025 02:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=trainwit.ch; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1738566762;
 x=1738653162; bh=l3rRSvqBN3E6hRNo8yjAbeMMDbHM8Yo6JHDFc/dTmas=; b=
 TiBL+Li+l6BL6v2XbUojkxpflXlRwqJhp5dKLSopZfJAncGfXtfzXoCpL+5e9dxE
 KuuiguINgv0WZK6xy+l1yt+NDhpNeHHw5bBWJuCzjX+FZufg2XJ+A5Zs/OBQbMI0
 6VPW0YfR0sSh1aZxq8D4m5fIBwR/xZ59zmS3xGr5rgrEElWylbmKpdKvkbewpXyv
 8hXgP+NZ85HzK340yc+2pSTFZA0OKGw9wD3S204pvzZGyTWk3uts+qzfTrqyvskx
 +3hCsimclpZkXswSxnoBiptY+AEkE0pXrvWmWtTsEA/8K0xYHVW8b9+LyS9QgLRd
 fw0YDLnuDtU17Fxxy/899A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738566762; x=
 1738653162; bh=l3rRSvqBN3E6hRNo8yjAbeMMDbHM8Yo6JHDFc/dTmas=; b=L
 i4GjAVW7pvVyCjXxoYXIlvJYSKTgQqTfTx4nilwBuM7uStTwQt7sXkkQDTNVaJDU
 nqNwtzX6Gn3ArRINvd4HwVRrHVBMm3eAyKs6nrgF+cUuKIDJzPR4j5TvsFyF8lF3
 eB34tjvCRfmC8uSH+sd284fAsOwRrPUOHXM7vXSIw8LCFtXd55zAnIqaE7GIMeqg
 h6S9y7MK5AOt7tjWUhBi9HPEJWoLH1L5CHc2C6ema//usAKf520LT84eX6Ykv/Lr
 Ip+oeH8+WyZW3IP9TeBp5XnWS/VZ+1oULCgBEb7juIx5iDHxhKuY2ZMAcrDNDm/S
 GtdmkfEkc6DOLR8oShEGw==
X-ME-Sender: <xms:aWygZ9sRlOPnjHsxkjTw24q-vq1HKtuhhyBLs83KRwmHhJlSGjTovQ>
 <xme:aWygZ2d48JXx3o7KWLiS8EFxHpsuSA524wPkX88TBxlxw6n56ABdxJGiTvtOBeloR
 0-D4QBjWqPhETpWzGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieelhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
 tdenucfhrhhomheplfhulhhirgcuoehmihgunhhighhhthesthhrrghinhifihhtrdgthh
 eqnecuggftrfgrthhtvghrnhepgefgfedvudehuefhiefhhfefudetvddtkeejueffkeef
 ieevleevhfehuddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepmhhiughnihhghhhtsehtrhgrihhnfihithdrtghhpdhnsggprhgtphht
 thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlh
 esnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdhrihhstghvsehnohhnghhn
 uhdrohhrghdprhgtphhtthhopegusggrrhgsohiirgesvhgvnhhtrghnrghmihgtrhhord
 gtohhm
X-ME-Proxy: <xmx:aWygZwwm5CsEpjtULTY7vWUhgotlWuVqvb-EzA_xYLrYav4f5Be-Fw>
 <xmx:aWygZ0NnRmrMv9BMg6ScG6oLcXJFxUrrqkM_csiEqsWZos34X8gSQQ>
 <xmx:aWygZ9_txwhHWyC9Q8TA6DATIQaqgthM2vGk2JJfrPN0gSwmSV-JCQ>
 <xmx:aWygZ0U-UYmT95p9fM7coeRtFGRT2Zd35Qnno5rMniEj4uCFfgAEBQ>
 <xmx:amygZ_I3ie2egRO1yDX9MDqRkpLbzjFpoIpU6KuRUjCooTBTfFeLnoC->
Feedback-ID: ic5914928:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 712F7780068; Mon,  3 Feb 2025 02:12:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 03 Feb 2025 18:12:21 +1100
From: Julia <midnight@trainwit.ch>
To: "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Message-Id: <8149beba-66b1-4707-93f1-083b8bc5ece0@app.fastmail.com>
In-Reply-To: <b76bf940-ff55-4619-a9ae-fa65c47e864f@ventanamicro.com>
References: <20250202051505.1846933-1-midnight@trainwit.ch>
 <20250202051505.1846933-2-midnight@trainwit.ch>
 <b76bf940-ff55-4619-a9ae-fa65c47e864f@ventanamicro.com>
Subject: Re: [PATCH 1/1] target/riscv: log guest errors when reserved bits are
 set in PTEs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.145;
 envelope-from=midnight@trainwit.ch; helo=fout-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

> This happens because 'pte' is a 'target_ulong' type that, for riscv32, will be
> interpreted as uint32_t while the FMT being used is PRIx64.
>
> You can fix it by using TARGET_FMT_lx instead of PRIx64:
>

I've sent a follow-up patch fixing these build errors, it builds on 32 & 64 bit on my system. Cheers 

As for the Signed-off-by, I'd rather not, and the contributing guide does not require it.

Regards,
Julia

