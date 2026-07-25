Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E285C531D0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 04:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnTwM-0000tY-6u; Sat, 25 Jul 2026 00:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@netscape.net>)
 id 1wnTwL-0000tJ-LC
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 00:24:45 -0400
Received: from sonic309-22.consmr.mail.gq1.yahoo.com ([98.137.65.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@netscape.net>)
 id 1wnTwJ-0001JO-UN
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 00:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048;
 t=1784953481; bh=ekKaIobZZ1Xy/FIfQt3Y4wffbq3XwiaTedgBPMjLcto=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=MX93i5P0OrhWMRJGeo4/rtNiQxODYr3f8Aew6yij87XCBYZdY+PgIdmEFfkjD+B8oIOVC6qwFvOvPulcrrUSLWV5bp0qirKdb+AEv6eRyvcv0hR+kr/Nqs1CWE5x+tkt6fjWuPrTvKdHdakLRK+uOPI/85C+MjuYy0kKFymJ41cawU+zgWTRgYit7LFrG7aKRkLRnUbyhkgXxO8gemHXMmzPDBMV1IoPlA9mW7H+/p+X+BjmwHkuQVE7ekY2fWWmvsuBNYOlzW85fbulKZ/0NCsTWRoPjWFJMF12uUXKv1J9U5xD3Nh5986crmsVRpFbVTlPC1AsQWNx0v1sEIy9qQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1784953481; bh=SkWIsgEEniKXmvwCUlzMrO7W7V9Wmkp4O+XJ1oxvU3Q=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=Y9+Zd59zrlfoOe5ABgd2oiJidlwuaAZs7attgyO1QK7X5Unl6VS2l39u4hOGAwa8xWRTFvYKjfw4nVqB4PnrwF1Cyf3qDumau4cquUhoq0fXPRRmAzKOYsK2Q5BSgEXsY5U3TCjdehG/HONb/lbsWVcwqBsi8Dy1u88z3Xa1wGNmVfqicJ8/RtzDnUSVGmc1u9BYEZdo6cuyysGRzg+/3ldpDcjG7TGwpnmh1o4L3UvY4/1YpOOgEA3qEhQoK5+R6oS8aio4VtO6vcUYCjh0Be+iBebpIxSArecQwGvCzU6EzfUid0rl17fGlYLDlLJySpK0crLxNkEmTiKTYgS0qA==
X-YMail-OSG: qgbLQ4MVM1k1k0GI7kIMV_xPiXb6JuoT6.zw7s0zPowEUl3OfvoaFD4XjjONRRS
 z2UzyZ_YWeO7k_csSdHhgWABg0PCtyF0dDOq3QqjM0mDVcUoiCZcM7yVV7TX0uF8FnBI79UAawQi
 49.LImtRDVheoJPnhSI3y8F3mC2T6wx1KphjtL75.HlI8cR3Y5zVdoBCxD43fYNbdVFsvajxO8uP
 VWNc_Ti21pxtCJdffFjAro0ZZsiz0P7YVa2laB0OrkfWH2va7zSr8BxmFBGsmW3qUl5b0LeS4PYd
 bFbRopTplqPHCneXdm_wbKCyPXg7vXo0rkBkge1iDmWY0b6dvDXZAvV56c7NAubrLBEdeEXcjkCS
 wIjyopuZHst_N9HWyE7eJQZ707AjliJR73jZmdA9lfQewxsw3hVu53GvrxpJEfxrifD0oIfOo9w2
 gADJ81AlmhzFfbNAzjCZMidKqCgNwwluKTTKR3m866mFQbdpKZpJ5xJ5s22STmBw2LTRrAoyKYv7
 EMtBYDhZs3JeGnd5DC2cZ7x20uDEYOUxYFZTfIwDQmQj1yG9GzLiN1gY5ZB_rv5y24rzjTt67mKL
 ZNsV.w8tLGL_FNtHFYmvquP8FZ5UVY7ngtjWEkaB6Jm._YN9R3ikKaMycot3ngk8AxHVMOVHCnH9
 JIGe7Ip9rfvFsH23FBs..in3n41_PecgDOg8baqfoB812jpNpH6q4wv7tSjENigaKMeKGY48Vtnt
 4jZK5WAycVCenqZRH7b.uwHML.Ww3_G7HgSZSQ4jj8wnqyqBfpLecBaK4c55V.bJf5ylgCaa1hin
 gNwIROYLSqrSxNh_RRiZPWisuJTGIPDjFQ2CWWVz3602wj2oNqmFQlrHd6Sl_lOKwI3rn6evxN_M
 jKIHXuXR9GRUQooglKYg.tU7SMhD2U6XAF6ucf1vl0m718xDQDZzgqtF08PQCgta98rmd9EPkHzx
 6ON.IWN1HmdLj0DamX.79zq6asmYgjqOLsdNRCUFpPMVNqi.98_UggLgx6NibQA7s1iX5kSlBXHu
 3_0THJVZ.o0w8WZ7KsGBGb2kn.ttZsH70MSgsgQOPKVBjpbp28r8t1ISyPkA2N3GDc.k.HngPQ44
 jHgtJ4nxRZmrGYKYYT2IkHU8zAEpMlQF8uoNrcnMkfyC5Ehi4SZOGXxuM1dukAMGL1JGK4dB6MyY
 .qrpoMe1B0gmV8W5uEJH9P25jK0N3_bfPKgtZRoJEnB_goBFJOzsUboZyqBPI016c4a3QEUsL5Am
 cFXUlVLmmST.kaiep1zwBlgzrKJE5_kVxMe1DxT5qWubag5RleUyM3W9_5gqj1Yr4ds2iRqmwFu6
 aonJyEglsXXrDec60BhUHsA6piw4LZ88mOr9EIcVgSrHRCu5qUoFmBWu5076UHwiNXZ1qLK9w08S
 I2NjLqvXmQhC5gijNOyDS_LzKP8eb_oo92xOu5HwtWkyjqAqaje0ufQEGWw4pZoM7mnMi93hmPIS
 5zTYIEjPUVZHd3WJTQAjJKhUSthYNcrpcZp1uEGlWFoYWZla2Yoxb1GE8xHnbjVj2NFph0xbwowH
 tG3GWo0g23wJJPPCEPC.19sDy7AZHoOfiRcdkSdzQZwJMVWvADzZbli9zdcUmCffdnxfsmOhvF7g
 7JKttS01RTClwVPbyExLz5dbVYJv4NnCmJUrMyBFR8JAP.2dp1NusYn31kCJOtqrgYEbXdZFOQ36
 .3lVC9.7cOnIcxsDza39TNZlXW1aXRSrYwGIfQlQZ5ThAR2l0QC9GLVFnwDGjcAHmJrW76tv_zyh
 B49BkQMU2.l1T9zBPQZGmoQ3.HaXHu7IMLaTZCQo1xRKGZ8BgnchYpOmcMSAQl7EZZ04q27IoCfy
 cQMTKpzSuAvMvmnBSYpWWDNDxTG0aoL8HQfWB0rKGUplqFAtql68AkJYJNzH_snzVIdkl.T6TBhS
 FZttmumqEvm4Kn21_mC.iAa08Cwcr78vu4ffx.rX29wi4l.zkG9ryret6Y1DaJXsTOr7DIMXMPHu
 H1tsiaTLdGEl5R5ORDnlkS2dPL8hVy0NJVYrXxLAATisrFDZKChHuJvETNhfNZakCclXIF9w5fIK
 WaMyWbaqtwc.GBz7EDaqWmH1thLI5.yjURnu0foguEJ8Ub9NJGYQ4TmpkphtegHlX8tIszrvY1bN
 F6xrGR27BD8YiC1PCrF75nhJfLxfgsWkmYUw6RtNr1WXAVD58r9YJYSdiIk7x9swVF4T.j5N5UJt
 STKNyC.WGnAuv7r0_0mmPYIEYtUDW7dHz3wNwk4XoCcxOpv.lkQ--
X-Sonic-MF: <brchuckz@netscape.net>
X-Sonic-ID: 901bdd82-b497-4685-bfe1-b677888aac6d
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Sat, 25 Jul 2026 04:24:41 +0000
Received: by hermes--production-bf1-5f4bf6454b-lrr4g (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID b3f7f8e4b62955cf6d54d4688d9d61da; 
 Sat, 25 Jul 2026 04:24:40 +0000 (UTC)
Message-ID: <8340528e-1683-44d7-8014-937fdb9852df@netscape.net>
Date: Sat, 25 Jul 2026 00:24:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] xen/igd: don't register rom bar twice
To: Tomita Moeko <tomitamoeko@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
References: <20260709183517.25866-1-brchuckz@aol.com>
 <20260709183517.25866-3-brchuckz@aol.com>
 <f722320f-205b-40d3-a727-753506ba5473@gmail.com>
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <f722320f-205b-40d3-a727-753506ba5473@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26215
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.65.148; envelope-from=brchuckz@netscape.net;
 helo=sonic309-22.consmr.mail.gq1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 7/23/2026 9:12 AM, Tomita Moeko wrote:
> 
> On 2026-07-10 02:35, Chuck Zmudzinski wrote:
>> This also fixes a failed assertion in pci [1] for Qemu
>> version 10 and higher when passing through an Intel
>> IGD with an option ROM to the guest.
>> 
>> [1] f6fc01c ("hw/pci: Assert a bar is not registered multiple times")
>> 
>> Fixes: 881213f ("xen, gfx passthrough: retrieve VGA BIOS to work")
> 
> Please follow the QEMU standard way to reference a commit
> `<at-least-12-digits-of-SHA-commit-id> (“Fixed commit subject”)`

OK, I will do that for the next version. Thanks,

Chuck

