Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA14BC55162
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 05:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqOiq-0007Mr-Vs; Sun, 02 Aug 2026 01:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@netscape.net>)
 id 1wqOik-0007Jj-9V
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 01:26:48 -0400
Received: from sonic304-23.consmr.mail.gq1.yahoo.com ([98.137.68.204])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@netscape.net>)
 id 1wqOii-0006Q2-PN
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 01:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048;
 t=1785648402; bh=LH/ftC7GkUWQq6FB6XQBny4DcVZLjeM6/HaeFg9bv3w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=Yah76xINiQI8Aa5SpWbJzbbV8erP/BHCmrBwMDQXSzEc7PeE2PEnVpsAOQfTCNRFRH4wCbkqgbQwZvmVX//B9xURciuDHjCwLUrgXK3YdfR/RGmvWRcHZxP8vxfUmrFfbabWwuE9nACL5iZbREkYmoOitTQkYoxGVKo2FrLGPUM2wjk3f9JaTP6IjE0T4SmD2VKwrdyS0p4khaKvIDPstYPu2IrefrijQBWe/CeB2RrmocuhP/ksBoV5HCexU7Qsiow54+gCOHzMz6YjUrTFOvd+oGPxAkafQldFBBFEWrWj6KkISpPvqEtORDLXxt2mwGMJj+1kAapcE88Rl0UxzQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785648402; bh=MAFVCLLvA0klvEZcVA5etVjnRgqlL0lGl7k0CnhiFb3=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=nZk8q/7/fq/CD2AbOuARFOh3y0FI79kWvSlWMiRySvCh+pk07CQulJKMf9NCanDCKaXxzg1iK9MAeMftQ6A1YvkprwdaGFQVxRt77vA0tTC1xd6Z0wJyey1zowSDO5dtF0mpYkoZ4dw1NVAVBTH3idmmEvFDrE9uEQ98VBXwRkk6RCLmeFIX+wBqFRNm7Sr5OuTExy+rznYmCzsfUPoLpCI9O0dYsV/7HJmkidt9CK9FIcp7lyjiiQk3SV6vPiHRCBOJV2ctb5FVkpht34zhs7txDE6+GFzErfEgK5OcJka4YEkQiYxBGzw6Jx4CCY2pMzHFtFaYc6ONpa3BN3H4pA==
X-YMail-OSG: IUYVv7QVM1ksrzGFnH34ZNa9tFKOa0UEiqQf8uWRUH518rC13_b5BhBg10Hv8aS
 FU.tLcrzA6dcAldNQwxkdReWoWUrWqmbk1yPxUno_wB92sn8NFLXp3rMXiUWrp.Jwr_wIk6a05ct
 mDVueUgAnXuOd_IHHGLcyuxG8BaGg29WaFAwd8Wt3CkCQYEb_46ks0Y3o34FB1NJtV.7yUAcgDLX
 hCuHV6LGD6.l6_fQrNVr.tLgfRWe20MPYRxtxEbwiKnHYsCmzxh2pD2y6W1YZdOCOE5WFNLV1tXg
 OgHQFfmIbAUSdURf6fjDV1u29yv8Af8OIj5tYTiLkYvFKe2aeseKsKDc4Qx41uyXaP60_JiQunqp
 PI8v_hSfVibZ65RTO5YM2DNm7dD9VWbl8ZZ5zM24Doiu.VQqNqrknB89wmYYN9AEOepTaefP7BeJ
 i6_AUqPY.te8V3OvI7OgXIYYXNNVKIQf_OsubclGSyXmUIAaMoJ7Kxm5xoxZNs1dq00pBSp9dV1C
 Jioq0Mg_HghYB6iJq5BzQ4GB3drAPwnUEJVSpxNKAbrMJj3HyF3s0gk_zGzA9y6etqbaIk9EfuSs
 uDeFvKVgxNrOnPCaFluN0lSKk6tC2srKBc5qoiU1.Gfx8jrT.wFa1plpNsOlEskrsm6tz.uogNR3
 ZWpUGpoxscWgBPDOqtR5dt5cggZ49CLyV1S.JalcD_HNDbfio7JGD0BP_WuEGGQRsOPMWbNlCtjp
 4mGDqg1iKqWpM.HuSOsbek4mDKfZHbLLWYQHNgXUDwliTzFgPPBg.nb2RpjhQ8yxe4NE06upj4S9
 OHRhMyugeqIGPmdH6To0wIXdGZXZIC6FmFDDUPehbtL5Luv8I3VbuACP1GrWvxttds8S8dRGFrWj
 Yr4W0IPeqdVmVrsJbuUOdW8vyQNRNnSJf3cUn027m2vY0g6u9LzsgSmMbJz1MuaKj_LzXX_98uV.
 m8XbzpSkuvjkTtpLr9gRFbEYZKOqDVrk72YDuF43jSCWQ1pM1sbhL4Qc9J3sHxhai6IloRQLLTcP
 lAjshWJ0RWbBIl5U1ut2tM0_7jCj3Ci0jbW.3V9x648RDarmxbWK0s5OOcWbYD9cxur8vpv0mBnl
 6LIt81l.a8261OM_S1o6Erh8yNzFcxNzrJsCkDEvPwqRadClrzzmCxEVywO2LFKoeItpWvxXGJkP
 sb1VgYRzAA_9o8rswI3I6utxqNbGhnUMmqBwwK0nWU52nqb2i5qvRNzKdhRJD2QmdXvdR4HSZLq_
 pkpegqCUaixQSQdQwN8mH8zUzoaKvVEccrzU7KsUcIfpcwbzei0MWx3Mca5Su_3UzD5HS.aIte9Y
 aEXw1NEObI1Dt_EZ94wZIr4fwJcafoOkHCkgXa8yxbWFCA__17aHCSEbE9laLwrRkaYhJrObrOGE
 Q2Y10r7wfdxhOsQ4u0okTzplvnSLkHHrDu6wZlvTrpgsYodk3f3g48vteAorOOP73MRQBaQZovhR
 NnqXxc9lPAnu1Gooy.G3D2H.XSGPCGy748JEEfzKc8lZgc6UEeqBhRjQgUh8N6pZ3NZLD5j7qDCH
 uBggtT983z95bZb4v6X.l8NuEzgutHRNw_u0DsXWTlQunY9kDqjTh1Q25rlRiAdx0R23ZmZTd1yK
 paQSaX0Bgjj8QNdrNAF6f2voB4qew9AVALIel07ru7rRu9Px9gax0l39SDgQe2eGLfYkN8uOEyIB
 94FcytGQAjyF1_fWNwAud5fn4Q785HkLI6r7mvydaXGFBs3afHf3bitJmpkOGDheEZ.rzcsKJ8uq
 tf86tKay6tUd4WAq9YOrBqwmrdVW1P8ndt4x9y4xZo07L5GUrfSpmbAfD7gEzjpxVOagIvPrmAF5
 YenGnj51OQe0QuKcJSYvusVbtl7Dzpwd574bfqO77owdnoCZB7xtjgSawIiH.T62Cj85c4uA8co9
 4qCCJqKCzRWERd8ZqghJFHomwUUzie0GEVfUpTeH73iiS_m5Iz9dmtsZTdaHiPTSq9q8s9eqgsn4
 hxd9GMlkEwXQcpgNIkH0bThGhoVpg2XQCdJtKSskJmyY0XbLEdgSygX1fouKklBqT7.Q4UGfUPi1
 8GHbAEsQ5wkAArOMjx0sG8.Pi.qToLk58dEMPasVQw_UbHZpNCNYBoqdtZRnwooll3GdaL3yNSko
 jG9BRCYlb4MJszbc84BKqpWBIXMO_HDNalw1T3yXH27DK8QODIvT4lmo_nTDlC0mNdq8Om0JBO19
 zeMOgC1NLmMtsm9lr0mNgYCAFD7Iy.Ols2GQ0z.w2p.q4qMo-
X-Sonic-MF: <brchuckz@netscape.net>
X-Sonic-ID: 9ef0d839-c41c-43b5-90aa-8784cfba1c62
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sun, 2 Aug 2026 05:26:42 +0000
Received: by hermes--production-ne1-6f6bdbdd7c-dvlsw (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 11499ee497b205444310b641ae38b9f1; 
 Sun, 02 Aug 2026 05:26:40 +0000 (UTC)
Message-ID: <236b6db6-ddb2-4f60-935e-fcb153c1ab38@netscape.net>
Date: Sun, 2 Aug 2026 01:26:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] xen/igd: implement support for extended VBT
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Jan Beulich <jbeulich@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>
References: <20260801001737.16509-1-brchuckz@aol.com>
 <20260801001737.16509-6-brchuckz@aol.com>
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <20260801001737.16509-6-brchuckz@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26215
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.68.204; envelope-from=brchuckz@netscape.net;
 helo=sonic304-23.consmr.mail.gq1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/31/26 8:17 PM, Chuck Zmudzinski wrote:

> 
> The companion patch to hvmloader that is needed to make this patch take
> effect is available here:
> 
> https://lore.kernel.org/qemu-devel/20260801000354.16446-1-brchuckz@aol.com/

This patch has been update to version 2 and is available here:

https://lore.kernel.org/qemu-devel/20260802050824.10554-1-brchuckz@aol.com/

Thanks,

Chuck

