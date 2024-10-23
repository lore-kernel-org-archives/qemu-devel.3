Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9D7CFA44E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 16:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3eAo-00080y-BA; Wed, 23 Oct 2024 12:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnd@arndb.de>) id 1t3eAl-00080c-14
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:25:23 -0400
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnd@arndb.de>) id 1t3eAj-0006KO-5j
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:25:22 -0400
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id 397861380258;
 Wed, 23 Oct 2024 12:25:17 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
 by phl-compute-10.internal (MEProxy); Wed, 23 Oct 2024 12:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1729700717;
 x=1729787117; bh=ezYfh8vGbBGoL35ugyvD9i4flPvQdh7bUpgBPSQRYk4=; b=
 UeHl3464JEn+yoSzXIvaxeQh6e0hcSBe5ww0Ds4gygXos/Ojhd05WqBiyYSXNIdg
 XGu5wEktHYRy5weGkqVd1IeDtTFwKXtDDtgAPLDtMq9xCJdW8skfzQSW2fZCWzkX
 uwBurbAo1qfO/hpPWUVzwutGqon5+6knnv0imhktmq7qmBuVP5q0RhLLIqY8ZwFX
 Mgdaat5xTd/umnkoJdg/p9qsYUFcuSTcL9TUXHB56/2FfwbqE5lqIHMbIdXACGrc
 v1o3lq3sJ9ivreuS4c5T37FnYcaFXit+Dm1K8EcfmLsyDkqlkeDToh8RQlMjrMm/
 fxkW6G7+sX3o/VqoQ2sZxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729700717; x=
 1729787117; bh=ezYfh8vGbBGoL35ugyvD9i4flPvQdh7bUpgBPSQRYk4=; b=U
 DSRgzmPXC0B22rx5tQfEA4tfrW3UPXPh07ArM8jXCUiEXFaQ4KBDMpA2l7or30Z6
 z1SQK0RGWUN6SWPhM2auj7xvPr/+FpwG1urmkZETRx56g4jWaG9lr3+S74yZYGb/
 wGnsMO8qwA6/UC4aqd+rRavmk86V2sW2VZcaqUEOmKbeArUKcEQWQoZVr+U/Q0q6
 TDGq2LdauNNmSRUAnSvWbgF1CbGsK/2nd0T0HL9eIWv1tooJpgKgXuhxv11W+yV3
 jXLXeNJ2FBnKg9PSZMGtEzYTMO6+wSO6LTqmKxL7o/ka1pitetlyDtGnf0n1gBVk
 e4we+9lB0lV//8284X2ZQ==
X-ME-Sender: <xms:bCMZZ6cgN86NZjlQ77gb_-7EQEj3WV3bermbUqFqBsR16TaydfTDgg>
 <xme:bCMZZ0MNuYjpr2z43CfpbdMNe8-EgoUTHaEotzF_-D5CmZdsEtfQ0E1pYbej7qWV2
 RjrBupl19GXR4MaRjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgleelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
 necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
 guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
 gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudeh
 pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrihhshhifrghrhigrrdhttghvse
 grrhhmrdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdr
 tghomhdprhgtphhtthhopehvihhntggvnhiiohdrfhhrrghstghinhhosegrrhhmrdgtoh
 hmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
 rghlvgigrdgsvghnnhgvvgeslhhinhgrrhhordhorhhgpdhrtghpthhtoheprghnuggvrh
 hsrdhrohigvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtohepnhgrrhgvshhhrdhk
 rghmsghojhhusehlihhnrghrohdrohhrghdprhgtphhtthhopehpvghtvghrrdhmrgihug
 gvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhn
 ihigrdguvg
X-ME-Proxy: <xmx:bCMZZ7gv2cOAzGtQ6izYwfARe9dQFEgcHUsD9NZzPHJ3PkK404tgAQ>
 <xmx:bCMZZ38N3FZ4uEiq60yrwuxzICelSSESBSVHgH7gMObr6zjJ96fdQA>
 <xmx:bCMZZ2udKX8GScfWKbHpPMRjTXUwjEReO1paH-uLugCkgT7vO5Rx2A>
 <xmx:bCMZZ-HEsPGfk_cPUCvItTIBB2VdGuF8SQ6CnOQMI6fsGw-fW72mPg>
 <xmx:bSMZZ2HyXyBrpdGtVf8NbxzkdUkyA2fOSW33YlwBMcMSwqQau3-neLsV>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 4FF162220072; Wed, 23 Oct 2024 12:25:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Wed, 23 Oct 2024 16:24:43 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>, qemu-devel@nongnu.org
Cc: "Mark Brown" <broonie@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Aishwarya TCV" <Aishwarya.TCV@arm.com>,
 "Peter Maydell" <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Message-Id: <4730e562-7d14-4f12-897a-e23783d094af@app.fastmail.com>
In-Reply-To: <CA+G9fYsMg0fA-jraEvC==0a-22J97o-uBmbLJt16_ZKBpOT8EQ@mail.gmail.com>
References: <CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com>
 <CA+G9fYsMg0fA-jraEvC==0a-22J97o-uBmbLJt16_ZKBpOT8EQ@mail.gmail.com>
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm with Linux next-20241017 tag.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.146; envelope-from=arnd@arndb.de;
 helo=fout-a3-smtp.messagingengine.com
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

On Sun, Oct 20, 2024, at 17:39, Naresh Kamboju wrote:
> On Fri, 18 Oct 2024 at 12:35, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>
>> The QEMU-ARMv7 boot has failed with the Linux next-20241017 tag.
>> The boot log is incomplete, and no kernel crash was detected.
>> However, the system did not proceed far enough to reach the login prompt.
>>

> Anders bisected this boot regressions and found,
> # first bad commit:
>   [efe8419ae78d65e83edc31aad74b605c12e7d60c]
>     vdso: Introduce vdso/page.h
>
> We are investigating the reason for boot failure due to this commit.

Anders and I did the analysis on this, the problem turned out
to be the early_init_dt_add_memory_arch() function in
drivers/of/fdt.c, which does bitwise operations on PAGE_MASK
with a 'u64' instead of phys_addr_t:

void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
{
        const u64 phys_offset = MIN_MEMBLOCK_ADDR;
 
        if (size < PAGE_SIZE - (base & ~PAGE_MASK)) {
                pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
                        base, base + size);
                return;
        }

        if (!PAGE_ALIGNED(base)) {
                size -= PAGE_SIZE - (base & ~PAGE_MASK);
                base = PAGE_ALIGN(base);
        }

On non-LPAE arm32, this broke the existing behavior for
large 32-bit memory sizes. The obvious fix is to change
back the PAGE_MASK definition for 32-bit arm to a signed
number.

mips32, ppc32 and hexagon had the same definition as
well, so I think we should change at least those in order
to restore the previous behavior in case they are affected
by the same bug (or a different one).

x86-32 and arc git flipped the other way by the patch,
from unsigned to signed, when CONFIG_ARC_HAS_PAE40
or CONFIG_X86_PAE are set. I think we should keep
the 'signed' behavior as this was a bugfix by itself,
but we may want to change arc and x86-32 with short
phys_addr_t the same way for consistency.

On csky, m68k, microblaze, nios2, openrisc, parisc32,
riscv32, sh, sparc32, um and xtensa, we've always used
the 'unsigned' PAGE_MASK, and there is no 64-bit
phys_addr_t, so I would lean towards staying with
'unsigned' in order to not introduce a regression.
Alternatively we could choose to go with the 'signed'
version on all 32-bit architectures unconditionally
for consistency. Any preferences?

      Arnd

