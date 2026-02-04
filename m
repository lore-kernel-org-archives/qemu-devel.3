Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9859CE9539A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 12:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncT1-0004DO-Sd; Wed, 04 Feb 2026 07:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1vncT0-0004Bi-GE; Wed, 04 Feb 2026 07:58:46 -0500
Received: from mout.kundenserver.de ([212.227.17.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1vncSy-0004l6-Se; Wed, 04 Feb 2026 07:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1770209923; x=1770814723; i=laurent@vivier.eu;
 bh=F7HrnsKPZPvojr8kLM6lK182TN4yxBA5Tu6qvgS2mlc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=SB2W+1es37nbZCYq49MtC+8UcDStb10QHBevyAIzS4TAQw7lqG3kifuX4tMuUsir
 X5eqT4rJFRTDN6NcYVbj+/KaBTdtM4TUV2MimIEXb4I3euVR8m1meuuixUK/AbG+E
 GzKZThjuazhtxodJhQKg1ffzATG3eWrDClOKPwbyqXMK2NTFmN9IwNH+eKjtKJb2G
 Y7BcQbysOJmSJCO35assPAmWFuipG8t7tjfyZlEi5aj1om05L9Aljgw1o0qxPB8bh
 Nd4cYYK4EEkHDjzSaXzhd94g3zLLYOGaZJmdXSCmuz0HX7hlpjwyQUxb+RED3ZNwq
 IR94KZdbZHNgu9flHw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MJn4B-1w75II0YNl-00Sl5X; Wed, 04 Feb 2026 13:58:43 +0100
Message-ID: <d205fec6-6f5e-4c4f-82ad-ffb64d4c8f71@vivier.eu>
Date: Wed, 4 Feb 2026 13:58:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dump/dump.c: reorder usage and assertion of block
To: Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20260204075754.21078-1-heifetz@yandex-team.com>
 <20260204075754.21078-3-heifetz@yandex-team.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20260204075754.21078-3-heifetz@yandex-team.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tHItisgMDb/RwsYZJwKxTFWDmqOLIddVYtXQCCYDiq/qOFINpgL
 j+EAA5fgQAOX+6JS4u2HceRv2J7cmy0Udqye/wlNociXODUC1CFphV+WDdsDxLguC+yuoS1
 KJh6numyvlVRBJ0BYOI12uB7yB/YtVJhBDvWkPWz/1SEfVOK1yWE/pM9WB9JpuGRYRF54BD
 tlpfozqW8h+M7qQM7uxZg==
UI-OutboundReport: notjunk:1;M01:P0:TGSeX4FgSTY=;Ccul4/KbfP4VZQNnlLoZjb/sOsE
 jxb0MjuR3VwGnoFWuJAgcLz1Xk8arykb61aWN/niIjgLU8zPBgNRc9XHy+uu4VWrupLuuyu42
 qceZJCButx15phlvqk3aeJCzMYYpIVBhP6C97QyR86lmifubUZtW4dYVgFpTH2P9FiJ7SJ3pZ
 VRiKEz/bb8Ip9NBmN6fwjDgvAR9CxOcZucBOk7kEhiOUyajrwbxUfzeyEub/Jhi6EYHB/gXVA
 yreFLTR+cpgkIu+oKdA9drPQ/Ugq8CbD3rYrNSvjO8l7DCif73sIwk4KKM0A/gejQc5c7SjjT
 bKIA4ikETZcNwpWnXp97ELH9VLiI28d8s2pNgm8Mp5naLoFqfUmHDwToDiFFSkkdJOKR8BvYP
 PoVcoJCwRKq35LS9BnsQYi0ve1C3lo71dMQfJl9SuyRRxXiFeOYEGSbU6HWrgeMEDhS3ukzPj
 +Vb596I9nQ6DFuvjbBwWN3xJbphKHQRlFtxTeGcMJroVT80lW5feKdlGf8l28eqboyIXpeg4Q
 GzvaR9oDptryEDt8BDwFzIl4Fbz6JiBQM8eOfiDMLRXnz5shxbs03TjZ9mw6qEJ6iFR+dpafV
 5MJOfyhaicJo4a0sK39VfdbUqL+g2G3B6ZE/ro6mVMG3zh3VkTPm6gscoCDpI07JqxhjK8/9u
 oDwGsVUxoDPQpniGnEeZefmPQ/marpFsQxsAUKX178ux2xed6azzpc5v/dOBSNZOWYh2i8QKa
 7YKbK8NDNX5fBdKPL/3rR1VU29Vl3ynpnxKkBIThTVadQa0wuezFQUNh5PxovALtKTayyo0ZB
 2+8qOY8puDBC0D5Jo8035fdCeJMLwHI0F4cgKZ9laUOmR/jcpm1+l6rZvw7nSNlinlQXTmYM5
 kwnAQ1O+TLCczeN3Cw1o4MFRyEpzaAaNY8xlqiTg+QzVUrqLb94s0V7PaL27mkyQoawXJ/ymg
 RDnNzTLfIEwpDqjkD4hDJejmpK9LFDwlgvAjSND7Tf1g0baGx0VZhVBEAAMgFMQRgVoDy8Gsp
 heoW6WIMv5CTo4AXD1xAy3fsea9Djo6Zcw6z17auoKAq5Ymbm0cw9A18BRMiX6pk9tUdSESl2
 6IR8WAIG4ePJ2btaphXZFTjK7eawEvT6NZ1OC2wda6A1G8IPuMy8+RBj0gb/w0bT5TMldDH+W
 AdZn4MaYGrTfix6BVtShwCCW32VLUqMMYm7gDrYD+FIDpsdb0KD/Nr88LFu7+vLtdGIfB/Gfi
 2etktrWFpXt2uX1MXLcgtCY3Pw+TRSkxmJuTI7YK+/SisyREkDkvvJZnVfq36xSNk4BYGyOMW
 z6pwj+22W7nVwdmX0i6MgxmTzj5UZSnWaa8HlAJz6AJLy6xeX1+C4R5KkYohVv5TDEe0HLLsF
 03gnH5EI7+ST6c6Gcz1yfTpHXGHo46r1ShTasvhCEKcTw3uhSCtWxmlYTeWuUV92FyNHa9mGn
 iNIvmz5QOsE+MSizfqCQKe7hkRSkyc5FiglUx1mi4A61h0bfadN8fgQWxmKkyv7unFn+MrYyV
 uBWBunA4CcfBSa6a1O/OaHLDCBKM/s4M+x5HP6MzPvehv/cTvuVMtD5rKyft+priVDHZ4MsWO
 BJ9P19MW+krVatdetBvMSmKJHG1eaOnCwK/Fs5a+aFxsZJS0A9OWgliVzDlwfSblchkbEM0N+
 dsCURDllnzPBshDwFr0UCHfy9O/sU4jw0FI9E3KTEKRDYw8sWtZCAZqiLSKjisjX8HaHNYLem
 sXHlBNr7aKQ9HjbbtVFbvefAT8TG0oWFD3NUnhW1zGHvm/HPo9GkC44Y=
Received-SPF: pass client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Le 04/02/2026 =C3=A0 08:57, Sergei Heifetz a =C3=A9crit=C2=A0:
> Reorder the code so the assertion of block occurs before it is
> used in the subsequent lines.
>=20
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> ---
>   dump/dump.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/dump/dump.c b/dump/dump.c
> index f7a99a7af2..80ed6c8d21 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -1288,6 +1288,7 @@ static bool get_next_page(GuestPhysBlock **blockpt=
r, uint64_t *pfnptr,
>       /* block =3D=3D NULL means the start of the iteration */
>       if (!block) {
>           block =3D QTAILQ_FIRST(&s->guest_phys_blocks.head);
> +        assert(block);
>           *blockptr =3D block;
>           addr =3D block->target_start;
>           *pfnptr =3D dump_paddr_to_pfn(s, addr);
> @@ -1295,7 +1296,6 @@ static bool get_next_page(GuestPhysBlock **blockpt=
r, uint64_t *pfnptr,
>           *pfnptr +=3D 1;
>           addr =3D dump_pfn_to_paddr(s, *pfnptr);
>       }
> -    assert(block !=3D NULL);
>  =20
>       while (1) {
>           if (addr >=3D block->target_start && addr < block->target_end)=
 {

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

