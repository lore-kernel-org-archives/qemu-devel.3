Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1DF606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=HudzPefL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQBGl-0006vZ-HL; Sun, 08 Nov 2026 17:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <domestos48@mail.ru>)
 id 1xQBGi-0006vH-Nd; Sun, 08 Nov 2026 17:21:45 -0500
Received: from send153.i.mail.ru ([89.221.237.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <domestos48@mail.ru>)
 id 1xQBGf-0002dF-Mf; Sun, 08 Nov 2026 17:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail4; h=References:In-Reply-To:Content-Type:Message-Id:Date:MIME-Version:
 Subject:Reply-To:Cc:To:From:From:Sender:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
 X-Cloud-Ids; bh=oVggVy52eR/0WPpVXGpd8dz5Vw6UNo1w9wQOT3Rly1k=; t=1794176499;
 x=1794266499; b=HudzPefLDSXV6u55lj71g4hANN9JohfJz8OLpxG3FKTSsR37rQEg+7bbM2uK3
 FKsokEf4qhrDk78PjGa0AMR/Wn7wgOc+tMiIEWporgUn9FQAt8i7NDdmig4REt0RkDcncTjHeI9cg
 u4eefE2aEt5y8ZD3KCYcgw1Ym4CR1QuJmD2H8U9X7xmxjUhwdGWvDCIDR6BDkzBH44j8gKQWVnozY
 c/uBvRqh/l2x3LVy9PGdxlBV1lu75mMYUv3wuTOnM6EOms5Y8JXszGoMJ3j+cCReIrM8XViundU46
 I8rhoJgbGTYr6XtWAGxdfGCG9+wOa/XEc/u0RLCA8vRatqGYWQ==;
Received: by exim-f-595bc55869-ckdbj with local (envelope-from
 <domestos48@mail.ru>)
 id 1xQBGY-000000003ir-3eAX; Mon, 09 Nov 2026 01:21:37 +0300
Received: by e.mail.ru with HTTP;
	Mon, 09 Nov 2026 01:21:34 +0300
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gdGFyZ2V0L3Jpc2N2OiBmaXggV1BSSSBoYW5kbGluZyBp?=
 =?UTF-8?B?biBtaHBtZXZlbnQgQ1NScw==?=
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-Mailer: Mail.Ru Mailer 1.0
X-Senderfield-Remsg: 17941753670424025507
X-Senderfield-Remind: 0
Date: Mon, 09 Nov 2026 01:21:34 +0300
Message-Id: <1794176494.8253128@f737.i.mail.ru>
Content-Type: multipart/alternative;
 boundary="--ALT--eE6363f9dAf270a2d0685716393bA63d1794176494"
In-Reply-To: <20261108220232.385393-1-domestos48@mail.ru>
References: <20261108220232.385393-1-domestos48@mail.ru>
Authentication-Results: exim-f-595bc55869-ckdbj;
 auth=pass smtp.auth=domestos48@mail.ru
 smtp.mailfrom=domestos48@mail.ru
X-Mailru-Src: fe
X-7564579A: 78E4E2B564C1792B
X-77F55803: 119C1F4DF6A9251C5D841680C7BB8F69395238F05D0F91E894436F4F2B0C11C68FD872164937FA4CA865BCC549E9FFC83DE06ABAFEAF670530760CA10E267C69CFCC53687498BD90F618F6F9AC73237B
X-7FA49CB5: 70AAF3C13DB7016878DA827A17800CE761D033F9D5DE9138D82A6BABE6F325AC1CE03F62A64D27DABCF491FFA38154B613377AFFFEAFD269176DF2183F8FC7C0364F8074C6DFACE2C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6759CC434672EE6371C2A783ECEC0211ADC4224003CC836476D5A39DEEDB180909611E41BBFE2FEB2B8DB61EC0D79750DE3972F49C7FFD695FFB2635A775A8E92DF957885B7B4DA71D0C819B32DFABC24A725E5C173C3A84C3ED8438A78DFE0A9E117882F44604297287769387670735201E561CDFBCA1751F28451B159A507268D2E47CDBA5A96583BA9C0B312567BB231DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6AD73F092CEDDEA7D089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A58E8FBBA5B7B298EB5002B1117B3ED69679639C7D064C7698886DC9BC01168B20823CB91A9FED034534781492E4B8EEADAEB4DDBFD72C8FA1BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191318BB3CFADBE9C2077DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659B44DB7F312C4609E558389FBE4D31EFD5443CD28F7871F23343D566091708811845046C63CFF4E9EB8341EE9D5BE9A0A02149156990DE5F7C71C92D99DC9E96403A3C1E6F1C6E5DE39A4D55D2591C6014C41F94D744909CEF1DAEBD50C2D18C54FDD1B49881939BFC3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+Od3uM/CLT152eL7j4ZacoUSF0MSa0v5VBmEtSutdC50BIKdL3VIRlkt/X9Gr7QWYXnzB8QdCJkB6LM/UMByHIkuslEuU8a7QkqGRTxKaKz6f
X-Mailru-MI: 20000080010000000000000800
X-Mailru-Sender: 7016F810D1C97269140FBE044B9D999086DDB086636275EE3DE06ABAFEAF670530760CA10E267C694D3EE4B1C102CB756315E18593E143A5149164E91495D2A83BC2F568E0EB198DB789D176D1322C6CB15D5A005FF75DDC285CF41CB077510D7C82001978DF54392A059828019CD210FEDC2CE99A723BC21458020726E2BC9F67EA787935ED9F1B
X-Mras: Ok
X-Spam: undefined
Received-SPF: pass client-ip=89.221.237.248; envelope-from=domestos48@mail.ru;
 helo=send153.i.mail.ru
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLYTO_END_DIGIT=0.25, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0JrQvtC60L7RgNC10LI=?=
 <domestos48@mail.ru>
X-ACL-Warn: ,  =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0JrQvtC60L7RgNC10LI=?= <domestos48@mail.ru>
From:  =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0JrQvtC60L7RgNC10LI=?= via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_REPLYTO_END_DIGIT,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


----ALT--eE6363f9dAf270a2d0685716393bA63d1794176494
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SSBmb3Jnb3QgdG8gaW5jbHVkZSB0aGUgUmVzb2x2ZXMgdGFnIGluIHRoZSBjb21taXQgbWVzc2Fn
ZS4KClRoaXMgcGF0Y2ggZml4ZXM6Cmh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVt
dS8tL3dvcmtfaXRlbXMvNDcyMiAoIGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVt
dS8tL3dvcmtfaXRlbXMvNDcyMiApCgpDb3VsZCB5b3UgcGxlYXNlIGFkZCB0aGUgUmVzb2x2ZXMg
dGFnIHdoZW4gYXBwbHlpbmcgdGhlIHBhdGNoPw==

----ALT--eE6363f9dAf270a2d0685716393bA63d1794176494
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

CjxIVE1MPjxCT0RZPjxkaXYgY2xhc3M9ImNsLXFxeHg2dW9kNWwiPjxwPjxzcGFuPkkgZm9yZ290
IHRvIGluY2x1ZGUgdGhlIFJlc29sdmVzIHRhZyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuPC9zcGFu
PjwvcD48cD48c3Bhbj5UaGlzIHBhdGNoIGZpeGVzOjwvc3Bhbj48YnI+PGEgaHJlZj0iaHR0cHM6
Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vd29ya19pdGVtcy80NzIyIj48c3Bhbj5o
dHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzQ3MjI8L3Nw
YW4+PC9hPjwvcD48cD48c3Bhbj5Db3VsZCB5b3UgcGxlYXNlIGFkZCB0aGUgUmVzb2x2ZXMgdGFn
IHdoZW4gYXBwbHlpbmcgdGhlIHBhdGNoPzwvc3Bhbj48L3A+PC9kaXY+PC9CT0RZPjwvSFRNTD4K


----ALT--eE6363f9dAf270a2d0685716393bA63d1794176494--

