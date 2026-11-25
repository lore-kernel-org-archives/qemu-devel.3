Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F8D606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Eo66iJsk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWJGP-00065J-23; Wed, 25 Nov 2026 15:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xWJGM-00064C-U3
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 15:06:42 -0500
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xWJGL-0004NZ-4z
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 15:06:42 -0500
DKIM2-Signature: i=1; m=1; t=1795637198; mf=PGRlbGxlckBnbXguZGU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=; d=gmx.de;
 s=s31663417:rsa-sha256:ULzyEWAx3vAY7h/c0FmSBHOhlD/t
 5vbbGWtmc40PxVuzVMj9gHIhbXwlMxQV2YoDuPl7OFTbWKgSnKR6FGMh1kVxCAw0qZchwez753g
 dBcZkQaSaEGSwUkQ6vZl1Ztvmzfh/rm0pXrqabMmACkd2LF+tRATMA5uhLEvIpZ65JkgXdN3zK2
 seBtfKy0bw7Zfad9vLVjw69ekANPEzeUsM0788x557SCcaqJmEIumR/8Uh5+xrbXVR7uJvWTeoc
 2Mr5Dig2t0CsRAhCvMtBX1h8B+8LGkxbB9w/05S6fPRXrlHJyRgHkCqFQYkLEmMy3B9ZZSeUJva
 rTPyYW6mkE+xVg==;
Message-Instance: m=1; h=sha256: rfc2ND66Mk+e162+lSawTmrggwyqxaQZqRJ3LadtDuk=:
 25g+pvTutCreFSc1ybfiHMnie8kPkPE9/rx8KQwluAY=, sha512:
 0o0gWnyzjEZ9SBn0tPpjF4oD91pUh1NlhoabRSNhL8hTOQzWlQtDtLi2B9cd0cWwhFNur/J2YaiUFbXbeyjHjg==:
 PF9suuUYtRfdw9aoJhq5dkRJzS2o/D+5bXQwl9xP02KXRzVLkHus6ZLgoQJrZXWMnKR9jrLUrDFXIOtMtsdRTA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795637192; x=1796241992; i=deller@gmx.de;
 bh=ggtlZMkobNsaHXyR3wfP5r+ixronCnmVP1BuhRNyeKw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Eo66iJsk08DlG3XdWOK86R1rKdM3KvvNvFcp/n1K3VreyCbb/cZqj7TpD1NlMtSm
 Kkb3M64LioNCneZye9xZFrumaTPYAhQ7TstADfxWblHiOoPeUmxAWrM4AMM5j+b8T
 ZJwDWLMtqIPmFE90xT++FWUW6NmhxlcXCKhXGhvKJ6O0VQafy5i+HcUIEBwpUXGGa
 /OHASUXzYssTU7w1y2hKJdelvEX1rr0yrp4y4D/KqR7DczWjUZmY4RMFREBCR6Wtz
 1qImiBgMrNyMRVvbRwM0Ft0VycThCTDkRY9d2BRtF/0+voCXEaxz35SFqA9+Zqor4
 p3aLnZfAz2YUOG/5mg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M59C2-1xVCnc2lxE-00EB9J; Wed, 25
 Nov 2026 21:06:32 +0100
Message-ID: <e41fb31e-0e0a-436b-8303-b5492f7a717c@gmx.de>
Date: Wed, 25 Nov 2026 21:06:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-12.0 1/5] dump: fix e_ehsize in ELF core headers
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20261125194855.3154845-1-brian.cain@oss.qualcomm.com>
 <20261125194855.3154845-2-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261125194855.3154845-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZHlvW7qwd+bFGIes6nC2XDniYBK/XkL2rrKZh+HFIlS5xOPuiBM
 7JkV0PDZhQdqr7QHLGWfqPJgPEgOQ/sA2Ez8ofiH9jbx26Fc0dTnS374p51tkg+Q377Bme+
 YOBGyTtVJ0TSXJoHTptMR36Y7Q1OaoeR/KYN3b0K2CIvNgs8R3e26XlVGq+p6P/90Xhswld
 j8yEd2UHIcJpO/zjTM7tg==
UI-OutboundReport: notjunk:1;M01:P0:0nuI0wjDH/U=;eM0Ex6KEsHEOBbPVE4wNHcPF/Qz
 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
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/26 20:48, Brian Cain wrote:
> prepare_elf{32,64}_header() used the wrong size for the elf_header.
>=20
> e_ehsize field reads 8 on a typical host instead of 52/64 for ELF32,64.
>=20
> Use sizeof(*elf_header) instead.
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   dump/dump.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>

IMHO this specific patch is actually for-11.2 material....

You may add for the rest of the series:
Reviewed-by: Helge Deller <deller@gmx.de>

 =20
> diff --git a/dump/dump.c b/dump/dump.c
> index 23ac689907a..6b568516960 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -157,7 +157,7 @@ static void prepare_elf64_header(DumpState *s, Elf64=
_Ehdr *elf_header)
>       elf_header->e_type =3D cpu_to_dump16(s, ET_CORE);
>       elf_header->e_machine =3D cpu_to_dump16(s, s->dump_info.d_machine)=
;
>       elf_header->e_version =3D cpu_to_dump32(s, EV_CURRENT);
> -    elf_header->e_ehsize =3D cpu_to_dump16(s, sizeof(elf_header));
> +    elf_header->e_ehsize =3D cpu_to_dump16(s, sizeof(*elf_header));
>       elf_header->e_phoff =3D cpu_to_dump64(s, s->phdr_offset);
>       elf_header->e_phentsize =3D cpu_to_dump16(s, sizeof(Elf64_Phdr));
>       elf_header->e_phnum =3D cpu_to_dump16(s, phnum);
> @@ -184,7 +184,7 @@ static void prepare_elf32_header(DumpState *s, Elf32=
_Ehdr *elf_header)
>       elf_header->e_type =3D cpu_to_dump16(s, ET_CORE);
>       elf_header->e_machine =3D cpu_to_dump16(s, s->dump_info.d_machine)=
;
>       elf_header->e_version =3D cpu_to_dump32(s, EV_CURRENT);
> -    elf_header->e_ehsize =3D cpu_to_dump16(s, sizeof(elf_header));
> +    elf_header->e_ehsize =3D cpu_to_dump16(s, sizeof(*elf_header));
>       elf_header->e_phoff =3D cpu_to_dump32(s, s->phdr_offset);
>       elf_header->e_phentsize =3D cpu_to_dump16(s, sizeof(Elf32_Phdr));
>       elf_header->e_phnum =3D cpu_to_dump16(s, phnum);


