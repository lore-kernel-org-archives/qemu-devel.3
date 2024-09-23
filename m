Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5F2CF9C69
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 11:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sshNo-0002Rq-NQ; Mon, 23 Sep 2024 07:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnd@arndb.de>)
 id 1sshNm-0002Qx-Uu; Mon, 23 Sep 2024 07:37:34 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnd@arndb.de>)
 id 1sshNl-00062c-4A; Mon, 23 Sep 2024 07:37:34 -0400
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E961511401EB;
 Mon, 23 Sep 2024 07:37:29 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
 by phl-compute-10.internal (MEProxy); Mon, 23 Sep 2024 07:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1727091449;
 x=1727177849; bh=uCRe1Blf3ItwuxY3+KF7szu7OCVgc6pFGALyEMKDlKE=; b=
 F5ldJXp1yukVpcejdKNvH+tQsa1w8XAlV+qeFJ3AZcLxJ9AVVjf5ycdo39sGq0VS
 oX20cAFh22308N9oJKAelM1aZRMco/nZWvrF2zJj798jFv1svq8u4R1jWj74C+Fz
 46Vo/0p3DLjBqURgvIhLub6idFCHNNnW1caytyyjvmBye2W511eqX6vjzDM+7Shj
 mqsuYO2bcP/BWf1RZqK7mPAPzGoZ8vVoIlkpXYnMfEqvQ//eopl4JI9YyrOA69Ud
 aOWhYZcXd/IJVMp4EJWkXtfhXRNW1bV8UwJz5vSsxGUMe9Kcv21RkFop9+rfUN49
 Q17ax+KVnnF6I3/MlSg9xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727091449; x=
 1727177849; bh=uCRe1Blf3ItwuxY3+KF7szu7OCVgc6pFGALyEMKDlKE=; b=b
 36xuBTSXJKXyU5jrwKpgyJ1xX5j5oDCMqqvis5TU9TfF4mxEYaIjKFSRhq8XdpGi
 ZvvjPvQdFwf2ngk4Ky4YFmTthSquI7oUdWumcggFkfnLkc0PJeEE3CnIBOSTuvgG
 AwJzDsb3rSnLJWTWlkyisyIrPWz+KfJ8+c7/mQv5xv8WgUmQsK6HqFica4D+QJyD
 aGAaZuFvIxeFzdEI4SnMt1wNVz6wnEyuqgrDYPMcJLqIs5xlq7sYt7KQkReApanT
 Xe34OI3/3DMgkrrkM5j2qtC73czDgVIijgKHJmo42VO2dppAUS9sVkfHRnxwvSIE
 ISZuBB+lyWJxI5dXJArxg==
X-ME-Sender: <xms:-VLxZn5DGd3hP-bEMZ6SDUTsZPDcF2Y0tih9eExQsLs58cs4ub5Vig>
 <xme:-VLxZs4Mg5pDY3Ct4kY40nC8WbR95KEatyE7UqYom9l9_J64FDgQRZs8X8uiUGwWS
 qd0f9NRtlPyUrVfpE4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelledggeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
 necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
 guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
 gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghruggsodhgihhtsehgohhoghhlvg
 drtghomhdprhgtphhtthhopegrrhgusgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
 rhhitghhrghrugdrhhgvnhguvghrshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtoh
 epqhgvmhhuqdgrrhhmsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggv
 vhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:-VLxZufflfB_rkkKx3AOMZKY54NJ9MRIe2hZRWX66hDp2UBKYLdLQg>
 <xmx:-VLxZoJL0RZnVvHXkENA-9mhj04E_V50BjRyxxYdtyiJCk2GBlU1gQ>
 <xmx:-VLxZrK2D1UXISEsZrEk0Pl65xZykGBXGASfokVY98SwC4Slf3211A>
 <xmx:-VLxZhxS056BxhJHBIWnr9kTF6JU4q0oq13qvV2ZYZmZtUushziA0g>
 <xmx:-VLxZoH6JS13Z55_m52U3xjtfYMIqx34NhUwfqt4bkAkva__Ahca8D40>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 84D142220071; Mon, 23 Sep 2024 07:37:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 23 Sep 2024 11:37:08 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ard Biesheuvel" <ardb+git@google.com>, qemu-devel@nongnu.org
Cc: "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ard Biesheuvel" <ardb@kernel.org>
Message-Id: <fb455d19-e4ed-47a4-a410-f2b3d89f61b7@app.fastmail.com>
In-Reply-To: <20240923092233.3235856-1-ardb+git@google.com>
References: <20240923092233.3235856-1-ardb+git@google.com>
Subject: Re: [PATCH] target/arm: Avoid target_ulong for physical address
 lookups
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.153; envelope-from=arnd@arndb.de;
 helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On Mon, Sep 23, 2024, at 09:22, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> target_ulong is typedef'ed as a 32-bit integer when building the
> qemu-system-arm target, and this is smaller than the size of an
> intermediate physical address when LPAE is being used.
>
> Given that Linux may place leaf level user page tables in high memory
> when built for LPAE, the kernel will crash with an external abort as
> soon as it enters user space when running with more than ~3 GiB of
> system RAM.
>
> So replace target_ulong with hwaddr in places where it may carry an
> address value that is not representable in 32 bits.
>
> Fixes: f3639a64f602ea ("target/arm: Use softmmu tlbs for page table walking")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Thanks for the fix, I now confirmed that this addresses the problem.

I had looked at this code before and got confused thinking that these
addresses were ok as 32-bit wide integers.

      Arnd

