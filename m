Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E5BCA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utg8s-0007mn-Lm; Wed, 03 Sep 2025 01:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1utg8r-0007mR-4d
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:34:45 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1utg8p-0007yA-51
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:34:44 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 1CBD47A026D;
 Wed,  3 Sep 2025 01:34:40 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
 by phl-compute-06.internal (MEProxy); Wed, 03 Sep 2025 01:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1756877679;
 x=1756964079; bh=YiNBx+5gE+2je0nmkePakqGfZ9tE/c4czo3b/MR9VuU=; b=
 Elmufihe6kI6/OFbiWclECPZsXkT2xRWI8pVFUF/+gRg9nEKOblw2p7bgc7YjnCe
 ah5/v8279UcmZLj6qt4OCR6kdDjiPTQtmRsSzMiRYjLQLE+0ii0QT5J2yXjT7Nb1
 cUaEb97WZnmQVQxwHyLjCuP7aCiiq5fCpjXPWvqYFwjAMrnNGSHrBpjzK4JrlyIN
 z9LLlQeDZo+kqVia02AJRgWVxuGm/B07s3kb6kIOkOMSo/59R4UO9w0/Lg2T73IA
 hikjBjCgQGXXbD138VUtELgcEm03za2/Gb6ihkvf7mihOqeVvdDd+Um+tBC+frGy
 Ks2corMfFmJUN77rtP5kaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756877679; x=
 1756964079; bh=YiNBx+5gE+2je0nmkePakqGfZ9tE/c4czo3b/MR9VuU=; b=h
 LME9z9qn8NnixMxd4wOdZHboC1kuH2naq4K8JnBZwFJBx8zjWNasMd3fTGRNeQJi
 cG50wy4/JEiZuGDQ7TfEsLW9iEU/JUe0LUDSQbuy4Gjv7tOMLfbqIK+mtcRsCW1i
 yN1eQTGzSvVieJQfi3EZGqfkAddNGxytgjzj8+siidsan7DWZfqY+sdaeTnbFucY
 AtPIb6uUqqufWpAroamkQmu+AjAeIvAX3SvJjfGT7lv3+6f203v4/aEfURcPNhry
 KBr/pAhp9FdI9RUPFBF1LAP8jg9Nvj8iyxYBAHOSccfVj4+o2whZnKp40b7GWjPP
 Vti58uW5BX8crijyUPxRw==
X-ME-Sender: <xms:b9O3aK3-vnZ43PRShf7GxsYfjEpo9VYOIgQZGvuCDARs8hJHYUpBBg>
 <xme:b9O3aNH5kz0IDaDJeZUacly8xncMN3VMe1p1dkCmAnEsd8fcLe9htFr48RN4eZKBj
 ty68xOU1D8nl6yCB28>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfhirgiguhhn
 ucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeethefhlefgvdevvdekuefffeekheeh
 geevhfevteejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdpnhgspghrtghpthht
 ohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhvghnhhhurggtrghise
 hkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhg
 pdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:b9O3aF8-x7_-T45xvRC9FdHbGoxnpPg1bJSJSQLmO8juEmp-3qTA7g>
 <xmx:b9O3aM_w8L-a1jsSeyw4vkgRQD4wspJ-NYACZTR0aw74mQQ4Yu4Eyw>
 <xmx:b9O3aMcFj5ug8R8cpDVdoD-NKkz6BFPcql-nV-lJwBQ1GPC4o7CS4Q>
 <xmx:b9O3aFG76wohDoAAm-TAazshMfT4eDyj7HwxHHvB_US6mgR9CIWLng>
 <xmx:b9O3aNvJziqLlLIX8pBWJOR-GWdScLkuXanAIXSajJZ3cZmkYBHxxaxs>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 957912CE0072; Wed,  3 Sep 2025 01:34:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AWgixAIENElZ
Date: Wed, 03 Sep 2025 13:34:18 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Huacai Chen" <chenhuacai@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Message-Id: <a4918aba-bb20-4d21-8f72-eaf0329dd508@app.fastmail.com>
In-Reply-To: <a972b6c1-5e66-41a9-b3ae-094fd98d6388@app.fastmail.com>
References: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
 <a972b6c1-5e66-41a9-b3ae-094fd98d6388@app.fastmail.com>
Subject: Re: [PATCH 0/5] hw/pci-host/bonito: Improve various emulation
 functions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=202.12.124.155;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-b4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



=E5=9C=A82025=E5=B9=B47=E6=9C=8816=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=
=8D=883:09=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> =E5=9C=A82025=E5=B9=B45=E6=9C=888=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=
=E5=8D=883:46=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
>> Hi all,
>>
>> This series addressed a couple of missing Bonito functionalities
>> I found when I was trying to test NetBSD against QEMU.
>>
>> Please review.
>
> Another ping :-)

Ping :-)

>
> Thanks
> Jiaxun
>
>>
>> Thanks
>> Jiaxun
>>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>> Jiaxun Yang (5):
>>       hw/pci-host/bonito: Implement ICU
>>       hw/pci-host/bonito: Implement PCIMAP register
>>       hw/pci-host/bonito: Implement DMA address translation
>>       hw/pci-host/bonito: Rework PCI config space accessor
>>       hw/pci-host/bonito: Add comments about documentation
>>
>>  hw/pci-host/bonito.c     | 453 +++++++++++++++++++++++++++++--------=
----------
>>  hw/pci-host/trace-events |   3 -
>>  2 files changed, 284 insertions(+), 172 deletions(-)
>> ---
>> base-commit: c5e2c4042e3c50b96cc5eaa9683325c5a96913b0
>> change-id: 20250507-bonito-482759b2b52f
>>
>> Best regards,
>> --=20
>> Jiaxun Yang <jiaxun.yang@flygoat.com>
>
> --=20
> - Jiaxun

--=20
- Jiaxun

