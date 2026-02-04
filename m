Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8FCE95392
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 12:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncSO-0003pF-T0; Wed, 04 Feb 2026 07:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1vncSN-0003p3-2X; Wed, 04 Feb 2026 07:58:07 -0500
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1vncSL-0004i8-AP; Wed, 04 Feb 2026 07:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1770209883; x=1770814683; i=laurent@vivier.eu;
 bh=QkfDRCP3B8v/mQwWWGU/i1HYd3F/DeGJ3//sJXM1cGg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=TCIhw7+vXyQ+n/DCi9oru1x9tH1FH8xur9+gq1MNWS6PRcFEx2A4Fd6j68zhvgHE
 XtkbrTjV7X7Bl8GSV68tOhKKWlKd8AJf6+jTXlei2jb12/86T6m8us93l/+rEVivP
 S3FJOIjVRjBCr8XGYypqqzBO+fia7XNrM6UatZ0eAaN1E9JA5bvkLx8Xikb+RI4os
 VqDxvog30fZwtMPPNKODdZk12X3QiAx0Wz4rVYJKdWJB6/7ACY9FEFoTwVzN0+1an
 1Dhtr/Q9/6BQNOHCPiIdOPlnpB9ox0gh0HTqhmxlrGJkNN5KieXFiFykJioCjJP90
 f6aAis7wbwef00NXWw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mirb8-1vK53m3bL2-00bSiV; Wed, 04 Feb 2026 13:58:02 +0100
Message-ID: <842d76d5-0485-48a8-8b34-fea986797b72@vivier.eu>
Date: Wed, 4 Feb 2026 13:58:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] migration/savevm.c: reorder usage and assertion of
 mis->from_src_file
To: Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20260204075754.21078-1-heifetz@yandex-team.com>
 <20260204075754.21078-2-heifetz@yandex-team.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 xsFNBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABzSJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+wsF4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +c7BTQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAcLBXwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
In-Reply-To: <20260204075754.21078-2-heifetz@yandex-team.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Eu+jdKWqi3PgWfM7QFnnCtpCq1u/ODgazH47z9fmnxC0Knp15+N
 Aqm5VWlRT01BZXhUsFA+sO1TPUIRcBY22km4BTwnr7rcYMJfJmbDyBIWkYAOckA7gxMLTYz
 6bZfTl3TiBGIaEqEuZOgWUhWesMg+HX56FxuSvTB/iyW85xly3oqiXCpWSGPp8oV1gtYWA5
 R3rwOODphvPnovhkZHApw==
UI-OutboundReport: notjunk:1;M01:P0:tJmma872pyQ=;209OV1rGTzA/QPVw3pHGSO0ZoR9
 YdehlITwCTN3VhhK0jwDx+YZporAFcHbtjbdUYFPc0/iu0Mt3DS7+dJ44Lk1ytDfXg2UBS2S/
 v2Nd9+9PetcxO4ZN9K+A7U6cRzq6oz/CNSboqt6qI+Sx7UYrdCz1436uZF4lRnUzOlFknqKgA
 rg03H+7O7234aMLVlO1TBv77xakV7KW+aOG/MOZIn9FlTxiuYdPQlyYgZV7/ffFFhv2l1LoMT
 5k7wQ9ByhPvZicdhdC/eDY3zuE5MoPWqaJn8JpCYMeybM9FCfxq6ULIDEXSCLZV2VeYRpGbo/
 xdfsEc8RpRNnwJqGwvjr6kgu1/Y1eHCa8Zo5z5oz0/rTFt9ZBaN4/cqaD53gSoKSUR80xJQDt
 pxkxWs6PqwNlN8Bz5s9N50bEFiwiwZmfebrKEnFV5pO2d+IPcUQ9ANe60zGLWDO/3wbS1hHVg
 oRGdJHEdcEnbVxSZfgeszJIvFtYJGspwPXBMaSoV62bG73/qvhzni7OVZhScH7eDRqu0QF/xn
 HhikX4z1Y9Oh5vgalepSoWJjuaZDqWbLK8gypvB7LbKN7m81KeUYwGJA0uB/FfelBv75oWupj
 GS+y4LU7XSKtNQpIDMA8VUsC3op+k6b8b8bPmQgdPG/jDq0ZhTvQlGOCacT5j4u57HPR9W1aH
 3VD6pl6vAqpfp0788wIoBiepYXLukLx/9vUEtmJcFXH3xk3oZw83oxtmu8zrjSsdQePCeB8IC
 L3oZgxNZktWBnQDfPjSGo08pOn6n+mF2vd0RZG/uE0lkG0nVQwAUoyWxaVoGugWzdWG8M6Irs
 pdXxRbihdn9LYxTGugvf672yK+Sh+f1oidxb4fLvCVs+dOpsX0pEceTH/AJItYwdHmTGK2Dtw
 rtfN8vYAlS6A943Tzd0p/Uo9DgI6nxBxnJsJCHcOTb3cb0c1ZvcXVbR52tBLnFfsyUdjUONuZ
 pECmWrS5TlrAYYAngzwPaBDLsWXHinFautF0D/sxgbTd1p48wsOtTEtlWZi8gxMGIb/q6UKEo
 D9aNgLKkR60jwotJ0/ZGA0TrTFJyKVdljhAawEPXmW9n7xGEqWzMIQpUOYzrfaHPQfJuk8Tyb
 E6Riay+vYxBsum7hUT2V+zrOrUjoZpiTluLpJOdomtLBzuNyp+hJUen/aaKM3J/B62J74BkAK
 EDwAue+r+Ew0gdC9wNChd3DYGZWv+01n8F+AH6InWrA+kCA/Izggk2lq41P/8BkJIXzYeu6PL
 cOz2VXsee4S/jUSvnBLc6phmOMBiUQ2lTF1rWZTXHqpCsLTBl7I5SKWqnAPoKfS6kQTt2Ixew
 TufZvMSSMrfmBMV1Ti22R04DBZXaKDw5CkG3A6TQnqbP/vLsYTGiPA7a+DPq1cXXwdGPanGjE
 Mmz9sgs3Uo41gtpku73ejH+2vX8mnfeHWbp17JBdyW+98o0WjOx2eH1UGL80gm9DR7i/j+9Bi
 C+gK37UbOdBAcL44oED0Om1GiMHH9I7mXj7OcePdFA923pgf29vtQO5LUc4GcsyDhIgR0HEHJ
 MgYCD0GF3R2H8FO5u8WlbKoVtkE13NoC4dW1YhJXmVqqbDwPD3berZJq5KxUMYZ31Zr0K7CR8
 HdY7uRsHpJQmi1sdhTXohDXETfHqh/Jnv189595jcFEjTQdUKiRijs5ejyeC0fxPHdUbboIjE
 wx/BQAdiPecbk62WPa7KRLQaADiCXu0CMhuR+lU8CN8Docd1FZm/erxTMi4Vn99Lu+d62kKP+
 bZRFTOhZCfIBFuQpRkYPw5jlAbDVNVJUDDe+AXlVxE+oejZ7CvMGkbm0=
Received-SPF: pass client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Reorder the code so the assertion of mis->from_src_file occurs before
> the call to migration_ioc_unregister_yank_from_file, which dereferences
> it in qemu_file_get_ioc.
>=20
> Fixes: 39675ffffb3394 ("migration: Move the yank unregister of channel_c=
lose out")
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> ---
>   migration/savevm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 3dc812a7bb..930a3391e3 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2885,13 +2885,14 @@ static bool postcopy_pause_incoming(MigrationInc=
omingState *mis)
>  =20
>       assert(migrate_postcopy_ram());
>  =20
> +    assert(mis->from_src_file);
> +
>       /*
>        * Unregister yank with either from/to src would work, since ioc b=
ehind it
>        * is the same
>        */
>       migration_ioc_unregister_yank_from_file(mis->from_src_file);
>  =20
> -    assert(mis->from_src_file);
>       qemu_file_shutdown(mis->from_src_file);
>       qemu_fclose(mis->from_src_file);
>       mis->from_src_file =3D NULL;

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

