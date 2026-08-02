Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07400C55171
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 05:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqOdK-0006Tr-Np; Sun, 02 Aug 2026 01:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@netscape.net>)
 id 1wqOdJ-0006Tc-JH
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 01:21:09 -0400
Received: from sonic313-21.consmr.mail.gq1.yahoo.com ([98.137.65.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@netscape.net>)
 id 1wqOdH-0005tx-W5
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 01:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048;
 t=1785648064; bh=tj8RIhqOXdYnx1HcBJgeOZ7JZFvUwTdqF2qHquu6/eY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=uM+GbcJXRELucFBpSuvdtKd651VUtycEdshz8fG/EiRQTobl81p0wUbTNIH/94GfkzLtYIOSgWp6md5FHLZWigqffnUQf16VyoV59oa9u+VpeDvmQI8qiIAW7IzLVpFYYjWj0hF2Hh6UPqCWArNlfOzHbPfP6BLcU1Oe7lBGPkTEgpe7p+dntSLfOxKOomM6kYxy0GReFSzIWGk6uLllg96poEFKHd8OW0w0eqZ7aSyFR1Bw6xgWiQVjSvPa3e3C328KSCIPg4r2rUZN9ybWRobWvNTach37Tz2HUSxKAqH331w8P9Ppaj2S+z7diZMN9Yo4YW94q8JtOA1JIUuQTw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785648064; bh=t8hnSLzTo5kXfTM5hXR5EvB4kIcyJhJM2cMOg/DaYOH=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=q9XFzQB+uRnY/8nG1EyN6FiEDVpjw3CtgJBtwvV3xt4i7eFoPpLfhFN1xdCcGwJ1XDYR5/uVkOXQgMOa6ODDU7PSQmtGq4Do8JWB6NgOV/m9LU4c1WI+ANcTuPysyfCIHVUC9vKqb3b59Ule5q+Q8FrB0DNIg/KExaZt+YTo8UqmYI4H0xFPnVn3+PN36cRTxMOn8InpWrFhc+m1hJQ7oNeK8qCxqNjxK5Y+w5pvX8m6VcJj/ee7+AOnnVqND3ulvYP1ctCwKLs2frVwW8vsmw4wHIiUnmvWu11XMcPdrnwXfu+WPa6bM7xH/G19ry/kOtb9ECxE2ZJzNDyOeE5HIg==
X-YMail-OSG: B20biegVM1m4M_E0_N8TgVHgJZVXgPEFW.EPK7OG2ck_G.8tS3APhCpKfINB4BR
 iNfxePBW22b.pAV8RV1jE61zJLRWwLB3fgxSkSA3Rua3bGZnezUxc4ThKkm8_JhG8e.ZYztgiHEE
 1qqvfCsm7bq4A_bfai3i.SvQ4q7donDdGwRd828_V2j7ZrSlaR40tFc_7gbM8lD1APqJKYkKyTXj
 0JRG9_vxgj.4mYuY2X_BJwa.x93P553TsyJ2Hw_0V3v0Ihg_OkcIcXi4Y3SL0wSOFAVDJlXIx0qz
 U6RRgk6fRIftJZD4MpOYVSI7QulxWb3VTQLEBJWG8VQs_jw7toL9ncE2U6CyZOvnH6f_3SidGIe9
 XscUkOMgCZTuA0CN5_3G46qA1yiga9Bwl0G7Qrjg3WTIeQk0g6HLUJmhNbCvmTaNtVxLMNCwh4UM
 UNm1dQYPR.U83X_zGHeJJ9xRLd2ZVT6EviMeXoFo2yNDzzKXVk0irlzxLRvlDajnnOG_oemKpdae
 DsHjdAKn2yKa57WN3k_nf5nMQ2BalpXLiS8lcNHekwWbK3mmAqx37oJtNkqKlMTc2Uhx6YHWRY8o
 efxOgBKhF.VRc9lOJHgDKRfzZ9bB0qvMQyy_JOouP5kFc_CMwZUtvDBmmLo7PT90VeududwI80fx
 UDd06PbEwkVUOZDAFs9EyDyMzRtlTsaDhkuFqLwpXoDGzoiZbfecZ8BmV2ss1sb5URIeP9gS51Ul
 p76kAClPUP4iWVjq5C5lZYe5PH4NCBPsp72b9NK1N5XI_XxIRdVqgrSOHrAivwBMnNEEDr3uLc2M
 bpO8DcFlT71UqgJC9euVBqY4PVQdYd2W4s9RWkJZJNcjlGZZYR7_.hnwJB8oDS3aXbM2Lxd5tvXQ
 9Tw2TZ7zlxIrp_9qWZucCRWsYpyoonZ8Ko9CkpUqASOXQZSJLG1Ai3SzsZFqFywFlYYTAKsLGAVO
 Bw8Lji5QlOKmuuaXA368eSzt9kitbpy7H8GMa8YlGlVGW8CUQQ.b5HeiJFSx2C7Go6nQ2Ujj4c48
 2hQGvVxHXZ8NLawhIcz_onMH628gjjkxzhlpet_aEGNUNjuFv8FfB8hSJJtqqY_0GSrCqHHR0M3G
 JtI1ypRF6ty4mk7Upkv2Zpo_8WbR1Tttni5Ag_kPlY00Fo8tH2Vy6VjIvb6znRvwc7fIcUXWjctK
 TRXqOngvpIZTl4BWVHXurAUgq._bS0YWASxuqm5j1V0eDQCEfelSC4.M7hZcGewWyrtkpmfce7jL
 X2Vq08vfQhuN69egjkJdXEz7p7FTlK8docrjeVJ_iu2YRyFPHa.f0sfd8Wu.XsIGRsSxI3WLVvc3
 yk4h.0whU4e2n15r7JooWOIwB6BVBEiEiQYiW2erV8aiHw2y_Ny1xokZRboUFNw7hBE6oG8MhdvW
 XxmhINjJZsov012WaqUMI7gcnd03au52YBg5lX177k9pGsXBo53UNaO_oTjGm._paLVpKV0jNlmP
 NIzKrwSbujZrIJliKbFU.PxRErl3v.sD0ytrNWl7TpW5u2TMf1p7eh5J_CMv_FfZix9vkNpAyPY6
 jwglvLaJAEWlwT6Fli1.bX3JfuHt7tF.2bx4kflHRAQOk55f7aDfuE.w_0VSb3IeQo9uLfSuT2ZM
 NVkIJ6Dx5OgIzNhqlnXYQLVySZpoAucJATkeDpDNYmj9IRUTTuDdijGUEh7b5tcKxrxL7Mi8_xMl
 K6TulRyRn3933ydvBnQ7QX605_jM0NVsBQ563lwZvm.UR.BweH2IcqWANrC6_ME7rCIZ.rneMCB0
 kCqjJhqlxzUqDWRudre5WfFCYIdizhMtoDGS_KJcAKsFKQBsZv2LWhUhIODE3KMSwew73dSJ1r0S
 4ZXyLKxwjfoVGm8Xxl8NJuV0_dJ1WU4yCLVied4OB0Vu0SG3jVilMxzjRHmlrX2vgLlLR8Q6u8kw
 gvyJ3tdP_QVt2zrMGyVC9QbWz8rEdDhKNDsGgjcFTnJmpRIu.h7C.5JRmBRLAgzV3JxK4iywNf7r
 nbt4jia3is41lqIZ.j1WZ_bhr4qJhi0WDaEr5brB.p__FT1jcyY1k8KUbSvlWFWd99Dn0nAgY65V
 KYkaie6JQ0DvkwQsVYEVGqH.5h7xDE5NDf6OrorVqjRgGCIPqZ2jJGRveUxj_ahe9nooHR8ad.E6
 x8X.5VUsTTN8W.L.Fj0P7fVPxS2j7cOdGLJCpyKISGHgZdQm7LB4uQwaVJDYBLkPXo9rRhrab0gP
 6_KHg3VKhh8Qa0do8eQFV4m3ArFa5ug5MwjlzaRUd
X-Sonic-MF: <brchuckz@netscape.net>
X-Sonic-ID: d6e338b6-534f-401f-a6d0-d7bde3049c82
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Sun, 2 Aug 2026 05:21:04 +0000
Received: by hermes--production-ne1-6f6bdbdd7c-6qsrs (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 5835b75ab342781156a842e5dbde47e3; 
 Sun, 02 Aug 2026 05:20:59 +0000 (UTC)
Message-ID: <60f1e89b-f0a7-41b8-a9b2-e0ae97b69b36@netscape.net>
Date: Sun, 2 Aug 2026 01:20:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] xen/igd: fixes for Intel IGD passthrough
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Jan Beulich <jbeulich@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>
References: <20260801001737.16509-1-brchuckz.ref@aol.com>
 <20260801001737.16509-1-brchuckz@aol.com>
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <20260801001737.16509-1-brchuckz@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26215
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.65.84; envelope-from=brchuckz@netscape.net;
 helo=sonic313-21.consmr.mail.gq1.yahoo.com
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
> Please note that Patch 5 of this series also requires a patch
> to hvmloader of Xen for the new support to take effect that
> is available here:
> 
> https://lore.kernel.org/qemu-devel/20260801000354.16446-1-brchuckz@aol.com/
> 

The patch to hvmloader of Xen that is required for the new support added in
Patch 5 of this patchset to take effect has been updated to version 2 and is
available here:

https://lore.kernel.org/qemu-devel/20260802050824.10554-1-brchuckz@aol.com/

Thanks,

Chuck

