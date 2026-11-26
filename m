Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C78606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=rd7XQwbb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWi5Z-000684-Pi; Thu, 26 Nov 2026 17:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWi5Y-00067W-75
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:37:12 -0500
Received: from ms-2006k-snip6-3.eps.apple.com ([2a01:b747:3002:206::71]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWi5W-0007XL-OT
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:37:11 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 E12F618000BA; Thu, 26 Nov 2026 22:37:08 +0000 (UTC)
X-ICL-RepId: 01a21a01-6579-7cb7-92f4-3a653a675f2c
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1795732629; x=1827268629;
 bh=FHJ+rtytXqoiRnL30FCLs2w8/6byDvmyldZXNLlDzXE=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=rd7XQwbb7UabJ4ld4sIOmdymN1igPVoL/2Pl9RL34QQ62dcDwAqRNRDaN1fFBTbTrKVJaSWW18N32Gv7B207CP0SiGOa8CAVxuwNnrw2Zffj/8yDjULAoDABo4S/sbfToyApZWVM52MDg9OlVUYcaILcWY7IQaSuDZ5VhG0BRgKxtlIGD6hRzHv4WlhFGGV310E1UnyUJclJdYhRdXdyt/qncrMLXi1HbRbohTBV0LBCvLN9QsX347j89xiW+BA/ex161jbfT0GORB5KupiZBGheg2ql/yX3kmrZ+T/8JjRKXQpkohEH+iVrJqGJSu90PoTt52zJT03hQFvPxini7w==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.208.39])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 6147418000BB; Thu, 26 Nov 2026 22:37:07 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH] docs/devel/tcg-icount: Describe translator_io_start()
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20261126211851.49019-1-philmd@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 23:36:56 +0100
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8BAD7261-084A-43E0-B50C-38767294A35D@unpredictable.fr>
References: <20261126211851.49019-1-philmd@oss.qualcomm.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-GUID: hiEj-cD2X-p7jhD_CjPtf5a66lT4MMrS
X-Proofpoint-ORIG-GUID: hiEj-cD2X-p7jhD_CjPtf5a66lT4MMrS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA4OSBTYWx0ZWRfXwpIuRgpNWf8g
 DXIGKmVcBdDEto1mlBtx2oa9FV1JnztrBoxKOeTgfLRHzZCuARAHwhYYw0465ZTkhOS3Pu7xMjH
 gWOWZQL7uduJqZrBL1aepOpCdibGBWFneRFCA694jsh5mUfp8DEZi4nc9YGXEf59DoZTzza2mYm
 gK9mNXtHfsTu1brNDflpAII15GoHzdPGBeAT2o3pvFVRiTuShDwMYUOTcZ2M8+/ApVU3FzqRaSu
 3tpgdYy5ISjS48F1CdftpMPA4DKsnYlsJK/P7ovj0TcVmPiml6NZT2/yxOZg8d1WWlDSTxZFeKI
 nDIouFr9HcFqI4oZ6K6QzSLJMue+etYiori24YoxTEA48AgDpV7UBC1yof1LLE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA4OSBTYWx0ZWRfXykl7harLcrcM
 Y+w3NNmMCf1CiYSiTfvpHl9ZVYLZ6UyXn7cGagwCSAT0eOcfyKUw13vWBg6pc6GfpiOmywk4+s6
 4s2otLogeyNEsL5jldMYswb4ry+BPW8=
X-Authority-Info-Out: v=2.4 cv=aOhlOr9m c=1 sm=1 tr=0 ts=6b08b495
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=FseGFa0Ubrda8wqeEFuV:22 a=CULd9vD9bkH6r2h6Ogp5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=ltexYN57AkuIHw6_x6AA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-JNJ: AAAAAAABOzMvYhhWkUdnIoeu2SEBu0WAT3pjUin7kdNDZ8L+KHIPJ2Ztw+++CJNaStbilZ
 nr1TvQ23iGqZps1YFUSo8g2MdGuAaYyynQUSPS7B/f1ZBTNNu5h2XXJni/eC0Bv6V7Tuka
 lC0/euPCDD4ah5/2UMrNl/GoWoUQpb7pkEzp0cIcwUJn7N8HXR+d/EN01DY0OaV7HPlDfB
 mofl6ax6wPKToo6+tX+hnj9qoIYdJjfMr1tCvVC4J7mb+Eq7rKOhf05L7+6e2/kGFI5jO0
 gfdGHdaCcumKDOYLlSXz9eU7kLM8EkHeaMhX61noBge0QofS111joiAIJbo1ZI3wuVCRi9
 rBSmPmu5XcNh145yrjiPyedxY7KsAororVDgo+zHNW/SZeaLjXVAAndIl+S4ziO7ZhmQb5
 qSAiCNbZs6qJZXIlkbB5VjujwoylWbB6jQ332F4LRmPOYiAxjjHurKk1Wt29OWnmcPe16h
 AmFs6B5dqetxoGUiUGyr7/tY3llPC0HDRNpsQ5ZgFqXTV1YAZg/T3BMEVCZQzW7ZEvdZV8
 iVPlKAcdOlCAEGTH+NlIHbNPl4I1j69419grLPC/kXC6/DvZO7XeFcYleM7/d2OQF/hWc0
 bYGmTsRvGVJn5ZDsKKkhWLYBl4UyLXVpgcR2dmdCQr93q9VacaLHDsOqGiOUgA2ZryOJLX
 AOMezOB4JtlXCVRsx8XY2z7T3eUR4+uXQaBzHV26IcnXCGTOE9IuCAOafIttr9MZ7y0A6M
 rBkjysG6q6AyIDHcyZb0u6XwT9/nUeZQiFlWP+3AH7SQgt4hEmKVvPBsNPiuYOMYwD/cuj
 5ReGdL4=
Received-SPF: pass client-ip=2a01:b747:3002:206::71;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 26. Nov 2026, at 22:18, Philippe Mathieu-Daud=C3=A9 =
<philmd@oss.qualcomm.com> wrote:
>=20
> gen_io_start() no longer exists, and since commit 18a536f1f8d6
> ("accel/tcg: Always require can_do_io") I/O instructions end the
> TB regardless of icount. Document translator_io_start() instead.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Mohamed Mediouni <mohamed.mediouni@linaro.org>
> ---
> docs/devel/tcg-icount.rst | 16 +++++++---------
> 1 file changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/docs/devel/tcg-icount.rst b/docs/devel/tcg-icount.rst
> index a1dcd79e0fdd..6541d98e170d 100644
> --- a/docs/devel/tcg-icount.rst
> +++ b/docs/devel/tcg-icount.rst
> @@ -73,16 +73,14 @@ system registers are the common examples here. =
These instructions have
> to be handled by the individual translators which have the knowledge
> of which operations are I/O operations.
>=20
> -When the translator is handling an instruction of this kind:
> -
> -* it must call gen_io_start() if icount is enabled, at some
> -   point before the generation of the code which actually does
> -   the I/O, using a code fragment similar to:
> +When the translator is handling an instruction of this kind, it must
> +call translator_io_start() before generating the code which actually
> +does the I/O:
>=20
> .. code:: c
>=20
> -    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
> -        gen_io_start();
> -    }
> +    translator_io_start(&s->base);
>=20
> -* it must end the TB immediately after this instruction
> +This makes the instruction the last one of the TB, whether or not
> +icount is enabled, so that it executes with ``can_do_io`` set and,
> +with icount, reads an exact clock.
> --=20
> 2.55.0
>=20
>=20


