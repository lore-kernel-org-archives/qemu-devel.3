Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4185AE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 18:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ9lI-0001jV-S3; Tue, 24 Dec 2024 13:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQ9lG-0001j8-U5
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 13:36:07 -0500
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQ9lC-00026f-Gr
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 13:36:06 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 0005E1380145;
 Tue, 24 Dec 2024 13:35:58 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Tue, 24 Dec 2024 13:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735065358;
 x=1735151758; bh=zddK0onktdVaqb4oTtKVV24zXyLiIWLoxhZU8WSfYrA=; b=
 VLw/RirRreCe0LZqs9iNWVzoPFNPC+loTRsazjlHh2snQlfD5us0aM69dLvRe+cP
 /pk4evy3ejhn8UyQ5CxjSm3ZSkp3/ADjJNEFGXeCG1SG/YovUrUG5WdAv7a73z4f
 OCMCl927Hkz85i9WORJnCDjiMN8OlVLjKF/gpkG3vwE1OijQklM054cbdd2GAPJI
 Fo7I4D3jLYIVMFrQCQeARRVFFsEBV/LAS3hJ05rJVG8jwvLSZmZPcWprvMcNlSpe
 uShpc23s1xKYFOowzbXEIQI0H+wV5tAxi86XRIOb6I1yAHsssL5g0pxBMgsaOHi0
 rnQCgSrhh0NnKrAhqlHHoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735065358; x=
 1735151758; bh=zddK0onktdVaqb4oTtKVV24zXyLiIWLoxhZU8WSfYrA=; b=D
 gGVAGS6rzefXngF+9zez1HQyrWE7gxtwoMDVXIek/aDgCvRXni2YyDei5s/u8rTy
 2k3ly1qN1ZtVXQmgfo2zCVYZ4uwNApKuv8yqObH4YWdB4WV7Iv9cJQdoLC6Fd2Nz
 ynP85HOJrq54twU3gLk55KjXNZmuxFjMErOD3jdGhdPWrmkVUzDmR3V6L63SYogC
 Gqyt8s9lCGq+fhHrki4vXsOoAZ6QkN7o9e+r+7a1uhfdA/u10PlwMYEbzhNTaZQR
 LctjBJPjo+hEXGvhpyMkutZOl283J72X+1SNdt4RgJQqOAUFIUPprRDbzd6lNH8n
 eXTQQaAC2BxrHm8bltyzQ==
X-ME-Sender: <xms:Dv9qZ6JQKMELqFMyriMMpyMe66FpkDXVFhI0tV4Z7E2Xa3KubQVUVg>
 <xme:Dv9qZyL96Y8Ig2_FlfiuGg8_YLvW536VR16GB7bhdVkmFRHM1a4FTVv-7Q9Z923g0
 z7j5GTY4ZI6tdH5w6Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugedgudduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
 jeenucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgse
 hflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeejheefuddvtdfggfdvffek
 teehhfelgfdvvedvkeeuffefkeehheegvefhveetjeenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghho
 rghtrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
 htthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhrtghpthhtohepghgrohhsohhn
 gheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehmrghosghisghosehlohhonhhgsh
 honhdrtghnpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:Dv9qZ6urxU4hwosUXtwnCNMW_hAmK0_iFJ9AF-do8xEgaRLSjhdf2g>
 <xmx:Dv9qZ_Yl7fJgHt7fZ58lMWrxE326NWPt0jnEkVPFbaOBNbC-CiDzDg>
 <xmx:Dv9qZxbyHw6J4ARjimn9BmsIBePEyW86qX9RRwtqe3wy1i4WM9A-hg>
 <xmx:Dv9qZ7BzSHhmbcVnSeYmzQhmyb4nOsqEEcfLI7jFLtIpi6lSkIMAZw>
 <xmx:Dv9qZ1GfSW9t3d3MbOCioL1ydOy3rMlMliO7xY12wYjiTTsfBqi5tfKq>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 5105E1C20067; Tue, 24 Dec 2024 13:35:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 24 Dec 2024 18:35:37 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Song Gao" <gaosong@loongson.cn>, "Bibo Mao" <maobibo@loongson.cn>
Message-Id: <dd6c87e0-c30e-4d0d-b31b-d5aa48a13f72@app.fastmail.com>
In-Reply-To: <c138716f-baa5-4fca-82b7-972c66570450@linaro.org>
References: <20241224-la-booting-v3-0-a15bee060a43@flygoat.com>
 <20241224-la-booting-v3-1-a15bee060a43@flygoat.com>
 <c138716f-baa5-4fca-82b7-972c66570450@linaro.org>
Subject: Re: [PATCH v3 1/3] hw/loongarch/boot: Refactor EFI booting protocol
 generation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.145;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a2-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B412=E6=9C=8824=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =
=E4=B8=8B=E5=8D=884:00=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=
=93=EF=BC=9A
[...]
> I'd prefer we avoid macros and use the ld/stN API, passing the
> size as argument:
>
>         stn_le_p(&boot_memmap->desc_size, size,
>                  sizeof(efi_memory_desc_t));
>
> Ideally splitting the patch in 3, first convert to use the API
> as stn_le_p(ptr, 8, value), then second patch propagate the size,
> and the third add the size=3D4 case.
>

Hmm, the data structure of 32 bit variant is not exactly same as the 64b=
it variant.

That=E2=80=99s why those macros are required to select the proper struct.

Anyway, merry Christmas!

Thanks
--=20
- Jiaxun

