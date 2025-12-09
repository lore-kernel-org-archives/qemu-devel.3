Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2A6D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 13:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSxJt-0001h6-4f; Tue, 09 Dec 2025 07:59:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1vSxJq-0001gr-9w; Tue, 09 Dec 2025 07:59:55 -0500
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1vSxJo-0006sb-Jy; Tue, 09 Dec 2025 07:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1765285189; x=1765889989; i=laurent@vivier.eu;
 bh=O1j68peabccqDFRVX9E9Qhmx1EelFQ2oluSO+1DsbhU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=EyimblTg5x54BYMVggev6TmPn/rZ0U3j7UPrKWBgV5NITvi6hFbKbiCraJHpacEG
 BAjtObck7gvin3yg0tO4s6vFEX/Ui1H2Hg02nwLt/Eoubb56rKdvthSOqU430JXK9
 Atn2+zPuPLZFWW/CMF0JcyB2TXa/ibQPOAF3AwGi3Kq87jyUyOcmiuir44LtauTrt
 yup+R9PKkRgUPyKiTZufGlzRbYDcm5dYwkZn3PNPeRKY+RWyGOGi5gbA0Wj35RM4A
 v4A0ImJDoDJvfBmVDGpmR6HZohD0Fbmlw4lKeV/8jLY0qrfKb4AI4EElajgN2gAOZ
 tJ8AEy5X9aiECr4b9A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1ML9ds-1vlAvO41kw-00Iq1C; Tue, 09 Dec 2025 13:59:49 +0100
Message-ID: <7103802b-6a9e-4603-ae35-c3222bedac77@vivier.eu>
Date: Tue, 9 Dec 2025 13:59:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH-for-10.2] Fix order of function arguments
To: Stefan Weil <sw@weilnetz.de>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20251209125049.764095-1-sw@weilnetz.de>
Content-Language: fr
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20251209125049.764095-1-sw@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g3QUhRHDiFN/afAOBlMFKnQJhZiwOqtzpEe7YXZUrrtcBuy8x1u
 RXizEfWGZHMKcE8k1mbKpSG6vImATXNdgz1Z6hhpFLDIO7WP99SvurA2Qzv91lJGJxED0WU
 uwumNy6IJGArAkH8VNpzW+MdympC8D5/KKHEizreNLG4cUhrfGdCf9w/+ss0uvgGIDHH5t9
 M2ibAcBZWpKP8dAMF5YwQ==
UI-OutboundReport: notjunk:1;M01:P0:fWxT9YcU4+w=;dKxI8Gb7rDdrRSOJVKNzw1e4Zkj
 hBY1SJbde9uT5YdeQy4sAgYQ/hZrRO1xcqjjoG7w2oeZoF9l+ienhoW7IH1FF2zK/AwQ5hXZm
 KIqb/ck2i+gFysbRefFyRbEPaXXnfkJjUE3lMCYtE6IA4uHmM3BCFrrZSMv+pQpnPAkXQJkxY
 Ky/YHTp2Pw9EOkkVQpm405HA1BrU4kUbQOy3sUCdnbgEH/p+nLhkEvJQOc9ykhhS4z3zByfWS
 WJnQiJuG5Jw/kmdhFV4vVBVoAc2OjueToZcI7rOr2XRuLAb7efRVuiVvk0hL6IIDZASyhXkfB
 KHVSAB2itK7/nFmVk6GuYvz0YBe5eIPm7BymuVrhyXII/fmuowmScLaFS11YvsOc5B5XSfrVG
 Q+EsVBqoE4K0LFAZj9xqRz6j+o23yvpm2eRsxGYmcSIGoKao1ywVLIOTFLA6ZSG3ELJtVPCsF
 ImcoqXgCdAeN54QvNqVNjdmoOtky3/Un3H4PInjpWY3BekNjQy7vEOvxy09zBii5umDc4ONwZ
 H+7F8bsJD49K0FHHxPp927JOpTXyjCsn0RxQ29e+oHaTF7uAZifpmS8AYjmOhAu/gQ7v4tmGE
 /Y0yfkCJitN2UaYcusdIIC3HlpuidO4MNGYyqdfltlweHWA+igzapxjzKmdYC8gyja9gSN3Vf
 SvNm34nQ1lWcjhAG4ITr66q70lUQZXf3fDF4WAf76J0PRYQmiX2J/l9JXOlWwnfwVN6nupkAC
 t5TLTICAu4vuU77quC79Rz7o3NOdysqi3/QBNOZBwaGJXN4KpJUZJ171DS982bEYxPQgi/Z3Z
 r5yrzZD6D7F6pAqeetjArZO88M6buo98yGxEQc5NSNHzTGr64MNn/NceRwfvg/sIpd5AEsIxf
 izyiLKqVulbi1TdsVBfomSIF/PQCMoGYuGk+SqQHWjA2aT/rpOpMYfUjPSTYafYHUBeyeyYYk
 m9+0rM181Y0H7kfqW6PbFC84aAlvG942N1nSEUMCcCw70EZqU3XLpAAXBsGqX7+FrI0dlwUga
 9meULpNfiYFicPTER+U2vDq80H3zMHt3NGBCkrMlAlhHYP9lnjdTACRXiTwOovXk4VlDHTIxT
 tiPc6GG/WLwokxwe5SQ+iM9tDbAT385tl24uQ+XSb0kYaeoovPUfsEYbz9l+W7o+b4Gqq+YPj
 dCuiUwd5GRavBosCZwi6GtioqaM+ccvjFoyB5CfdolQUn+fvFOel3NpZcweIT9SofKtAWXj11
 KbZSYcTMP84lK6gMN/55Sc0FWJ25HyD2W5+w0Wo+Eooh8gfIvmTVUgOOFOLbz2GPj2QkiqSyV
 XoFdgWlkbUk1PLFVZBVoCqHcPPQnTllcKQMB7yyw0j0gDVqkhBmGRtJb4LEDCf3QPIPiP9FKC
 /2KkMqXJjmWEFKAO2GcBAkDEYBylzr2vw9+azkCOwJO4t8g+YxjUEPG2YMfVwpOWOrBoaPtNj
 sq9sCQHN0tLYCf91MrmZDj18RgYpDHbkH6Ff7k7Ud739WTA/VVFB7UIALN+1jZeZ88pekuRO2
 +aiyz6WJuQgXDAZdjeOrPvtpqSz3jkmeiAVQgX75qOdhiwVO+azkx41WGrrdAUOtIUnQEqhYR
 Q10ZZUCa1uRkkjQlkMqMrGZz2jn++74fEo2RvUFLD/tnBXucRxktGrBKVTiZAP0Dao3gecLS9
 4gNRcOnq9eIJHV5T3DrGwRJS/kxg2Amfze0EZ32I6rf09RxldWZd3EhZZpRnKKahnKQgvyQ+T
 MZzuMN8v7kQClZzH6rjsOYE96bqnW3ELJteX9HNet6u6YKnY1iWqkJLCEZiufuxXWXIJhc3DQ
 LiSy
Received-SPF: pass client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
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

On 12/9/25 13:50, Stefan Weil via wrote:
> This fixes a compiler error when higher warning levels are enabled:
>=20
> ../migration/postcopy-ram.c: In function 'postcopy_temp_pages_setup':
> ../migration/postcopy-ram.c:1483:50: error: 'g_malloc0_n' sizes specifie=
d with 'sizeof' in the earlier argument and not in the later argument [-We=
rror=3Dcalloc-transposed-args]
>  1483 |     mis->postcopy_tmp_pages =3D g_malloc0_n(sizeof(PostcopyTmpPa=
ge), channels);
>       |                                                  ^~~~~~~~~~~~~~~
> ../migration/postcopy-ram.c:1483:50: note: earlier argument should speci=
fy number of elements, later size of each element
>=20
> Avoid also a related int/unsigned mismatch by fixing the type of
> two local variables.
>=20
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  migration/postcopy-ram.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

