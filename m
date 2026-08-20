Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EE1C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 00:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwqjX-0002zx-8C; Wed, 19 Aug 2026 20:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwqjU-0002zP-8F
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:34:12 -0400
Received: from ms-2004k-snip6-11.eps.apple.com ([2a01:b747:3002:205::6f]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwqjQ-0001NB-3k
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:34:11 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPS id
 B60231800213; Thu, 20 Aug 2026 00:34:03 +0000 (UTC)
X-ICL-RepId: 01a01c96-daf1-7869-b6ca-c6062b8aef07
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQBIHVoORQNGCVYLWhcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0KWFsIWwQPH0wMUQJCBVZeVAsdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDjF7OQcucVNzXQ89digaX3QxClUKLAUpHzR9SnIpBloLMgk5Cy1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1787186046; x=1789778046;
 bh=u5qKWOFj3j3FFKgjNthjjnMnyFbD7Dn6qV/bEaa0Hx4=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=fiXNoPKvJfhczF+/ZWUOJPMISKmgPRTqzpZX6oz9UEE6a9+h426b8J9pNf+3OlJbVVu0y/UTWenfgddIoW4aKQ4gqVIVakR1ZW8zzasW2PyzbMtx0fl1+l11RtsZi7t4YAv2dGgMedfplY+2/XZU1GkMHRGj+za38BwckM8slv40IhVMmXx2zAryFrBpXM6wbF0gnihH8xvdpGcBEd2gGhtEmfC2nqMbTOHb+NLwEZANpbIe5wCOGwYu2Je5QQUIcdKipk0zVvjbrT3UYDNTSyajH3ZVjuj2jwbOCBPotYpjIe0gq5PYTCLO8i6xMb8jnlA4HcKEJJ4O/bOENSwxAQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.208.39])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPSA id
 B842D1800137; Thu, 20 Aug 2026 00:34:01 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <ABA4CF8A-6EEE-4FA3-9A2B-DD2AD119B0A8@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_CB59F25D-39F2-49A6-8EBA-F7FC28BBF995"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH v2 2/3] target/arm/whpx: incorrect ENCODE_AA64_CP_REG
 parameter order
Date: Thu, 20 Aug 2026 02:33:51 +0200
In-Reply-To: <LVXPR21MB7009F5C9E8D9C44602816944ADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>
To: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
References: <LVXPR21MB7009F5C9E8D9C44602816944ADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Proofpoint-ORIG-GUID: wjpQw_oEFrRpddJJG3Fh_eIlCXT1UYgR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAwMiBTYWx0ZWRfXyYAXqS909ef5
 0Fya4aLi5bgDltuY6WLpCYWcm860CSLkipcGhV8Db8J7ryhkPYWkRiVWtfDxBp+sUuS9JXHT5yT
 u2eiXoJ1XIs/qCJfqjsk8v7d16/11wX85BXJ0ewY5DqhfdXT14pDOGaSAF2EvME/PUdpIVLMCrC
 MZbZJe5gECAvTdy+PMzgfyixlbrc7I1+usBgUH9pm/dfC9JYa8rKZvHU7AYbISxH6UQceBhX0LB
 XI58wvpwtrqZDcSQAuzVJZToZQa798lpldvaR/cbpPRGFDfWDnhz78bPk+6/3z31XK7sVoESaWs
 5qKjBu3ct4yuGyzscEzATxqXujygIwVPvB0iG/ZcSfN4wGsLr85IyQmMnNm4f0=
X-Authority-Info-Out: v=2.4 cv=YdCwJgRf c=1 sm=1 tr=0 ts=6a864b7c
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=Oe1WN_x2kNioOlMv7ZYA:9 a=CjuIK1q_8ugA:10
 a=GVFm8D4Oeg0kURvr8kIA:9 a=dXsh_BcMjQVhODJN:21 a=_W_S_7VecoQA:10
X-Proofpoint-GUID: wjpQw_oEFrRpddJJG3Fh_eIlCXT1UYgR
X-JNJ: AAAAAAAB3hF63rOezeKMterQUIWYDoLC3o1o83mGVo1casrF8kYsYvWQ/QLv6hzQzP3oVWpiRqP34do0ZR68I6Ib76Ra7LJYIcUkk1H8ZsvFA6iP5biqu9kWjqdOWmVqMMAl84jFf7rmG7QsMuRduUK54A9DUC8jo3vrk+/m0nS2AqQH4X+chUjYtYhQT3aDiwxiqZHHr7P7eSh0sL8FykIjYdzfEXHsQ1i1Ee8Ejwl9/PFBGPcqanHwjoivJ6dVdjvl2OJUs4eT61iZUcb9K0IL+NUq1WXW+mZVSG9Ye0RJXFOhyi75cDEjXsz6wwwhdZAEffxHfAX7NyiP2F/ywVsHYbqr378KLWj9nbDXfkhCy6ocvN7f0+NhMpS1V3ZTjzxNHLia9BA+6CXKe/b+lCclcaJtT/949hwDsPMqDCYrNa18Bu1NmQt/dtxJ/tcgtVfH4Cgb6zjnRGNxbNzTgB2RQbOb/6PbtlCsLwxKXwcgX6nRtxPDejfNgVleMsTlOmj/s/xGsHjgbhIGAt0gCPDdzfFi3IRr8Z8HP+mqCM5HOm+10zDvAT569QRDw445/SB27UkxWOBCuZDfJYbfvpcuQO41cjMe3UAmXm5dOVnAIkBPQ5kQGyJNEms0hHcp+Cmzwy1Bizw1ItovXlLcuHYOAoqLTn1KS2db3fhV7x9g6Ii57D7c4/kFOQlJirVb5RAAGfP9LfeSNhAna6Ocqyi9//VcPnusV5XIl5WlwSAb3lJhpiFPOjxpwaSmMpwlr0FaWsv664K2x7ZCVMn6zPg5cPcuow==
Received-SPF: pass client-ip=2a01:b747:3002:205::6f;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Apple-Mail=_CB59F25D-39F2-49A6-8EBA-F7FC28BBF995
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 20. Aug 2026, at 02:30, Doug Cook (WINDOWS) <dcook@microsoft.com> =
wrote:
>=20
> ENCODE_AA64_CP_REG expects parameters (op0, op1, crn, crm, op2) but =
whpx
> was using parameter order (crn, crm, op0, op1, op2). As a result, =
every
> call to get_arm_cp_reginfo() returned NULL, cp_idx was -1, and both
> whpx_get_registers() and whpx_set_registers() were no-ops.
>=20
> In addition, several encodings were paired with the wrong WHV register
> tag. These are inert while the encodings do not resolve, but would =
sync
> the wrong register once they do:
>=20
> - the series 1 debug register encodings used series 0 tags,
> - the SP_EL0 encoding was tagged WHvArm64RegisterSpEl1, which would
>  clobber SP_EL0 with SP_EL1 on get and never write SP_EL0 on set,
> - the ID_AA64PFR0_EL1 encoding was tagged WHvArm64RegisterIdPfr0El1.
>=20
> Fix parameter order (using a regular expression). Fix tags.
>=20
> Signed-off-by: Doug Cook <dcook@microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> target/arm/whpx/whpx-all.c | 252 ++++++++++++++++++-------------------
> 1 file changed, 126 insertions(+), 126 deletions(-)
>=20
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index 9a5a575b5e..a05df7d2cb 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -135,145 +135,145 @@ struct whpx_sreg_match {
> };
>=20
> static struct whpx_sreg_match whpx_sreg_match[] =3D {
> -    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 7) =
},
> +    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(2, 0, 0, 0, 4) =
},
> +    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(2, 0, 0, 0, 5) =
},
> +    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(2, 0, 0, 0, 6) =
},
> +    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(2, 0, 0, 0, 7) =
},
> +
> +    { WHvArm64RegisterDbgbvr1El1, ENCODE_AA64_CP_REG(2, 0, 0, 1, 4) =
},
> +    { WHvArm64RegisterDbgbcr1El1, ENCODE_AA64_CP_REG(2, 0, 0, 1, 5) =
},
> +    { WHvArm64RegisterDbgwvr1El1, ENCODE_AA64_CP_REG(2, 0, 0, 1, 6) =
},
> +    { WHvArm64RegisterDbgwcr1El1, ENCODE_AA64_CP_REG(2, 0, 0, 1, 7) =
},
> +
> +    { WHvArm64RegisterDbgbvr2El1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 4) =
},
> +    { WHvArm64RegisterDbgbcr2El1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 5) =
},
> +    { WHvArm64RegisterDbgwvr2El1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 6) =
},
> +    { WHvArm64RegisterDbgwcr2El1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 7) =
},
> +
> +    { WHvArm64RegisterDbgbvr3El1, ENCODE_AA64_CP_REG(2, 0, 0, 3, 4) =
},
> +    { WHvArm64RegisterDbgbcr3El1, ENCODE_AA64_CP_REG(2, 0, 0, 3, 5) =
},
> +    { WHvArm64RegisterDbgwvr3El1, ENCODE_AA64_CP_REG(2, 0, 0, 3, 6) =
},
> +    { WHvArm64RegisterDbgwcr3El1, ENCODE_AA64_CP_REG(2, 0, 0, 3, 7) =
},
> +
> +    { WHvArm64RegisterDbgbvr4El1, ENCODE_AA64_CP_REG(2, 0, 0, 4, 4) =
},
> +    { WHvArm64RegisterDbgbcr4El1, ENCODE_AA64_CP_REG(2, 0, 0, 4, 5) =
},
> +    { WHvArm64RegisterDbgwvr4El1, ENCODE_AA64_CP_REG(2, 0, 0, 4, 6) =
},
> +    { WHvArm64RegisterDbgwcr4El1, ENCODE_AA64_CP_REG(2, 0, 0, 4, 7) =
},
> +
> +    { WHvArm64RegisterDbgbvr5El1, ENCODE_AA64_CP_REG(2, 0, 0, 5, 4) =
},
> +    { WHvArm64RegisterDbgbcr5El1, ENCODE_AA64_CP_REG(2, 0, 0, 5, 5) =
},
> +    { WHvArm64RegisterDbgwvr5El1, ENCODE_AA64_CP_REG(2, 0, 0, 5, 6) =
},
> +    { WHvArm64RegisterDbgwcr5El1, ENCODE_AA64_CP_REG(2, 0, 0, 5, 7) =
},
> +
> +    { WHvArm64RegisterDbgbvr6El1, ENCODE_AA64_CP_REG(2, 0, 0, 6, 4) =
},
> +    { WHvArm64RegisterDbgbcr6El1, ENCODE_AA64_CP_REG(2, 0, 0, 6, 5) =
},
> +    { WHvArm64RegisterDbgwvr6El1, ENCODE_AA64_CP_REG(2, 0, 0, 6, 6) =
},
> +    { WHvArm64RegisterDbgwcr6El1, ENCODE_AA64_CP_REG(2, 0, 0, 6, 7) =
},
> +
> +    { WHvArm64RegisterDbgbvr7El1, ENCODE_AA64_CP_REG(2, 0, 0, 7, 4) =
},
> +    { WHvArm64RegisterDbgbcr7El1, ENCODE_AA64_CP_REG(2, 0, 0, 7, 5) =
},
> +    { WHvArm64RegisterDbgwvr7El1, ENCODE_AA64_CP_REG(2, 0, 0, 7, 6) =
},
> +    { WHvArm64RegisterDbgwcr7El1, ENCODE_AA64_CP_REG(2, 0, 0, 7, 7) =
},
> +
> +    { WHvArm64RegisterDbgbvr8El1, ENCODE_AA64_CP_REG(2, 0, 0, 8, 4) =
},
> +    { WHvArm64RegisterDbgbcr8El1, ENCODE_AA64_CP_REG(2, 0, 0, 8, 5) =
},
> +    { WHvArm64RegisterDbgwvr8El1, ENCODE_AA64_CP_REG(2, 0, 0, 8, 6) =
},
> +    { WHvArm64RegisterDbgwcr8El1, ENCODE_AA64_CP_REG(2, 0, 0, 8, 7) =
},
> +
> +    { WHvArm64RegisterDbgbvr9El1, ENCODE_AA64_CP_REG(2, 0, 0, 9, 4) =
},
> +    { WHvArm64RegisterDbgbcr9El1, ENCODE_AA64_CP_REG(2, 0, 0, 9, 5) =
},
> +    { WHvArm64RegisterDbgwvr9El1, ENCODE_AA64_CP_REG(2, 0, 0, 9, 6) =
},
> +    { WHvArm64RegisterDbgwcr9El1, ENCODE_AA64_CP_REG(2, 0, 0, 9, 7) =
},
> +
> +    { WHvArm64RegisterDbgbvr10El1, ENCODE_AA64_CP_REG(2, 0, 0, 10, 4) =
},
> +    { WHvArm64RegisterDbgbcr10El1, ENCODE_AA64_CP_REG(2, 0, 0, 10, 5) =
},
> +    { WHvArm64RegisterDbgwvr10El1, ENCODE_AA64_CP_REG(2, 0, 0, 10, 6) =
},
> +    { WHvArm64RegisterDbgwcr10El1, ENCODE_AA64_CP_REG(2, 0, 0, 10, 7) =
},
> +
> +    { WHvArm64RegisterDbgbvr11El1, ENCODE_AA64_CP_REG(2, 0, 0, 11, 4) =
},
> +    { WHvArm64RegisterDbgbcr11El1, ENCODE_AA64_CP_REG(2, 0, 0, 11, 5) =
},
> +    { WHvArm64RegisterDbgwvr11El1, ENCODE_AA64_CP_REG(2, 0, 0, 11, 6) =
},
> +    { WHvArm64RegisterDbgwcr11El1, ENCODE_AA64_CP_REG(2, 0, 0, 11, 7) =
},
> +
> +    { WHvArm64RegisterDbgbvr12El1, ENCODE_AA64_CP_REG(2, 0, 0, 12, 4) =
},
> +    { WHvArm64RegisterDbgbcr12El1, ENCODE_AA64_CP_REG(2, 0, 0, 12, 5) =
},
> +    { WHvArm64RegisterDbgwvr12El1, ENCODE_AA64_CP_REG(2, 0, 0, 12, 6) =
},
> +    { WHvArm64RegisterDbgwcr12El1, ENCODE_AA64_CP_REG(2, 0, 0, 12, 7) =
},
> +
> +    { WHvArm64RegisterDbgbvr13El1, ENCODE_AA64_CP_REG(2, 0, 0, 13, 4) =
},
> +    { WHvArm64RegisterDbgbcr13El1, ENCODE_AA64_CP_REG(2, 0, 0, 13, 5) =
},
> +    { WHvArm64RegisterDbgwvr13El1, ENCODE_AA64_CP_REG(2, 0, 0, 13, 6) =
},
> +    { WHvArm64RegisterDbgwcr13El1, ENCODE_AA64_CP_REG(2, 0, 0, 13, 7) =
},
> +
> +    { WHvArm64RegisterDbgbvr14El1, ENCODE_AA64_CP_REG(2, 0, 0, 14, 4) =
},
> +    { WHvArm64RegisterDbgbcr14El1, ENCODE_AA64_CP_REG(2, 0, 0, 14, 5) =
},
> +    { WHvArm64RegisterDbgwvr14El1, ENCODE_AA64_CP_REG(2, 0, 0, 14, 6) =
},
> +    { WHvArm64RegisterDbgwcr14El1, ENCODE_AA64_CP_REG(2, 0, 0, 14, 7) =
},
> +
> +    { WHvArm64RegisterDbgbvr15El1, ENCODE_AA64_CP_REG(2, 0, 0, 15, 4) =
},
> +    { WHvArm64RegisterDbgbcr15El1, ENCODE_AA64_CP_REG(2, 0, 0, 15, 5) =
},
> +    { WHvArm64RegisterDbgwvr15El1, ENCODE_AA64_CP_REG(2, 0, 0, 15, 6) =
},
> +    { WHvArm64RegisterDbgwcr15El1, ENCODE_AA64_CP_REG(2, 0, 0, 15, 7) =
},
> #ifdef SYNC_NO_RAW_REGS
>     /*
>      * The registers below are manually synced on init because they =
are
>      * marked as NO_RAW. We still list them to make number space sync =
easier.
>      */
> -    { WHvArm64RegisterMidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 0) },
> -    { WHvArm64RegisterMpidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 5) },
> -    { WHvArm64RegisterIdPfr0El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 0) },
> +    { WHvArm64RegisterMidrEl1, ENCODE_AA64_CP_REG(3, 0, 0, 0, 0) },
> +    { WHvArm64RegisterMpidrEl1, ENCODE_AA64_CP_REG(3, 0, 0, 0, 5) },
> +    { WHvArm64RegisterIdAa64Pfr0El1, ENCODE_AA64_CP_REG(3, 0, 0, 4, =
0) },
> #endif
> #ifdef SYNC_CONST_ID_REGS
>     /* ID registers are ARM_CP_CONST (writes ignored).  */
> -    { WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, =
1), true },
> -    { WHvArm64RegisterIdAa64Dfr0El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, =
0), true },
> -    { WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, =
1), true },
> -    { WHvArm64RegisterIdAa64Isar0El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, =
0), true },
> -    { WHvArm64RegisterIdAa64Isar1El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, =
1), true },
> +    { WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(3, 0, 0, 4, =
1), true },
> +    { WHvArm64RegisterIdAa64Dfr0El1, ENCODE_AA64_CP_REG(3, 0, 0, 5, =
0), true },
> +    { WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(3, 0, 0, 5, =
1), true },
> +    { WHvArm64RegisterIdAa64Isar0El1, ENCODE_AA64_CP_REG(3, 0, 0, 6, =
0), true },
> +    { WHvArm64RegisterIdAa64Isar1El1, ENCODE_AA64_CP_REG(3, 0, 0, 6, =
1), true },
> #ifdef SYNC_NO_MMFR0
>     /* We keep the hardware MMFR0 around. HW limits are there anyway =
*/
> -    { WHvArm64RegisterIdAa64Mmfr0El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, =
0) },
> +    { WHvArm64RegisterIdAa64Mmfr0El1, ENCODE_AA64_CP_REG(3, 0, 0, 7, =
0) },
> #endif
> -    { WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, =
1), true },
> -    { WHvArm64RegisterIdAa64Mmfr2El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, =
2), true },
> -    { WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, =
3), true },
> +    { WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(3, 0, 0, 7, =
1), true },
> +    { WHvArm64RegisterIdAa64Mmfr2El1, ENCODE_AA64_CP_REG(3, 0, 0, 7, =
2), true },
> +    { WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(3, 0, 0, 7, =
3), true },
> #endif
>=20
> -    { WHvArm64RegisterMdscrEl1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 2) },
> -    { WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 0) },
> -    { WHvArm64RegisterCpacrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 2) },
> -    { WHvArm64RegisterTtbr0El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 0) },
> -    { WHvArm64RegisterTtbr1El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 1) },
> -    { WHvArm64RegisterTcrEl1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 2) },
> -
> -    { WHvArm64RegisterApiAKeyLoEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 0) =
},
> -    { WHvArm64RegisterApiAKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 1) =
},
> -    { WHvArm64RegisterApiBKeyLoEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 2) =
},
> -    { WHvArm64RegisterApiBKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 3) =
},
> -    { WHvArm64RegisterApdAKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 0) =
},
> -    { WHvArm64RegisterApdAKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 1) =
},
> -    { WHvArm64RegisterApdBKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 2) =
},
> -    { WHvArm64RegisterApdBKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 3) =
},
> -    { WHvArm64RegisterApgAKeyLoEl1, ENCODE_AA64_CP_REG(2, 3, 3, 0, 0) =
},
> -    { WHvArm64RegisterApgAKeyHiEl1, ENCODE_AA64_CP_REG(2, 3, 3, 0, 1) =
},
> -
> -    { WHvArm64RegisterSpsrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 0) },
> -    { WHvArm64RegisterElrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 1) },
> -    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 0, 0) },
> -    { WHvArm64RegisterEsrEl1, ENCODE_AA64_CP_REG(5, 2, 3, 0, 0) },
> -    { WHvArm64RegisterFarEl1, ENCODE_AA64_CP_REG(6, 0, 3, 0, 0) },
> -    { WHvArm64RegisterParEl1, ENCODE_AA64_CP_REG(7, 4, 3, 0, 0) },
> -    { WHvArm64RegisterMairEl1, ENCODE_AA64_CP_REG(10, 2, 3, 0, 0) },
> -    { WHvArm64RegisterVbarEl1, ENCODE_AA64_CP_REG(12, 0, 3, 0, 0) },
> -    { WHvArm64RegisterContextidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, =
1) },
> -    { WHvArm64RegisterTpidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, 4) },
> -    { WHvArm64RegisterCntkctlEl1, ENCODE_AA64_CP_REG(14, 1, 3, 0, 0) =
},
> -    { WHvArm64RegisterCsselrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 2, 0) },
> -    { WHvArm64RegisterTpidrEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 2) },
> -    { WHvArm64RegisterTpidrroEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 3) =
},
> -    { WHvArm64RegisterCntvCtlEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, 1) =
},
> -    { WHvArm64RegisterCntvCvalEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, 2) =
},
> -    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 4, 0) },
> +    { WHvArm64RegisterMdscrEl1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 2) },
> +    { WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(3, 0, 1, 0, 0) },
> +    { WHvArm64RegisterCpacrEl1, ENCODE_AA64_CP_REG(3, 0, 1, 0, 2) },
> +    { WHvArm64RegisterTtbr0El1, ENCODE_AA64_CP_REG(3, 0, 2, 0, 0) },
> +    { WHvArm64RegisterTtbr1El1, ENCODE_AA64_CP_REG(3, 0, 2, 0, 1) },
> +    { WHvArm64RegisterTcrEl1, ENCODE_AA64_CP_REG(3, 0, 2, 0, 2) },
> +
> +    { WHvArm64RegisterApiAKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 1, 0) =
},
> +    { WHvArm64RegisterApiAKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 1, 1) =
},
> +    { WHvArm64RegisterApiBKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 1, 2) =
},
> +    { WHvArm64RegisterApiBKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 1, 3) =
},
> +    { WHvArm64RegisterApdAKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 2, 0) =
},
> +    { WHvArm64RegisterApdAKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 2, 1) =
},
> +    { WHvArm64RegisterApdBKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 2, 2) =
},
> +    { WHvArm64RegisterApdBKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 2, 3) =
},
> +    { WHvArm64RegisterApgAKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 3, 0) =
},
> +    { WHvArm64RegisterApgAKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 3, 1) =
},
> +
> +    { WHvArm64RegisterSpsrEl1, ENCODE_AA64_CP_REG(3, 0, 4, 0, 0) },
> +    { WHvArm64RegisterElrEl1, ENCODE_AA64_CP_REG(3, 0, 4, 0, 1) },
> +    { WHvArm64RegisterSpEl0, ENCODE_AA64_CP_REG(3, 0, 4, 1, 0) },
> +    { WHvArm64RegisterEsrEl1, ENCODE_AA64_CP_REG(3, 0, 5, 2, 0) },
> +    { WHvArm64RegisterFarEl1, ENCODE_AA64_CP_REG(3, 0, 6, 0, 0) },
> +    { WHvArm64RegisterParEl1, ENCODE_AA64_CP_REG(3, 0, 7, 4, 0) },
> +    { WHvArm64RegisterMairEl1, ENCODE_AA64_CP_REG(3, 0, 10, 2, 0) },
> +    { WHvArm64RegisterVbarEl1, ENCODE_AA64_CP_REG(3, 0, 12, 0, 0) },
> +    { WHvArm64RegisterContextidrEl1, ENCODE_AA64_CP_REG(3, 0, 13, 0, =
1) },
> +    { WHvArm64RegisterTpidrEl1, ENCODE_AA64_CP_REG(3, 0, 13, 0, 4) },
> +    { WHvArm64RegisterCntkctlEl1, ENCODE_AA64_CP_REG(3, 0, 14, 1, 0) =
},
> +    { WHvArm64RegisterCsselrEl1, ENCODE_AA64_CP_REG(3, 2, 0, 0, 0) },
> +    { WHvArm64RegisterTpidrEl0, ENCODE_AA64_CP_REG(3, 3, 13, 0, 2) },
> +    { WHvArm64RegisterTpidrroEl0, ENCODE_AA64_CP_REG(3, 3, 13, 0, 3) =
},
> +    { WHvArm64RegisterCntvCtlEl0, ENCODE_AA64_CP_REG(3, 3, 14, 3, 1) =
},
> +    { WHvArm64RegisterCntvCvalEl0, ENCODE_AA64_CP_REG(3, 3, 14, 3, 2) =
},
> +    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(3, 4, 4, 1, 0) },
> };
>=20
> HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
> --=20
> 2.55.0.vfs.0.3


--Apple-Mail=_CB59F25D-39F2-49A6-8EBA-F7FC28BBF995
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dus-ascii"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 20. Aug 2026, at 02:30, Doug Cook (WINDOWS) =
&lt;dcook@microsoft.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>ENCODE_AA64_CP_REG expects =
parameters (op0, op1, crn, crm, op2) but whpx<br>was using parameter =
order (crn, crm, op0, op1, op2). As a result, every<br>call to =
get_arm_cp_reginfo() returned NULL, cp_idx was -1, and =
both<br>whpx_get_registers() and whpx_set_registers() were =
no-ops.<br><br>In addition, several encodings were paired with the wrong =
WHV register<br>tag. These are inert while the encodings do not resolve, =
but would sync<br>the wrong register once they do:<br><br>- the series 1 =
debug register encodings used series 0 tags,<br>- the SP_EL0 encoding =
was tagged WHvArm64RegisterSpEl1, which would<br> &nbsp;clobber SP_EL0 =
with SP_EL1 on get and never write SP_EL0 on set,<br>- the =
ID_AA64PFR0_EL1 encoding was tagged =
WHvArm64RegisterIdPfr0El1.<br><br>Fix parameter order (using a regular =
expression). Fix tags.<br><br>Signed-off-by: Doug Cook =
&lt;dcook@microsoft.com&gt;<br></div></div></blockquote><span =
style=3D"font-family: Menlo-Regular, monospace; font-size: =
11px;">Reviewed-by: Mohamed Mediouni &lt;</span><span =
style=3D"font-family: Menlo-Regular, monospace; font-size: =
11px;">mohamed@unpredictable.fr</span><span style=3D"font-family: =
Menlo-Regular, monospace; font-size: 11px;">&gt;</span><br =
style=3D"font-family: Menlo-Regular, monospace; font-size: =
11px;"><blockquote type=3D"cite"><div><div>---<br> =
target/arm/whpx/whpx-all.c | 252 =
++++++++++++++++++-------------------<br> 1 file changed, 126 =
insertions(+), 126 deletions(-)<br><br>diff --git =
a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c<br>index =
9a5a575b5e..a05df7d2cb 100644<br>--- a/target/arm/whpx/whpx-all.c<br>+++ =
b/target/arm/whpx/whpx-all.c<br>@@ -135,145 +135,145 @@ struct =
whpx_sreg_match {<br> };<br><br> static struct whpx_sreg_match =
whpx_sreg_match[] =3D {<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 4) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 0, =
2, 0, 5) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr0El1, =
ENCODE_AA64_CP_REG(0, 0, 2, 0, 6) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 7) =
},<br>-<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr0El1, =
ENCODE_AA64_CP_REG(0, 1, 2, 0, 4) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 5) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 1, =
2, 0, 6) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr0El1, =
ENCODE_AA64_CP_REG(0, 1, 2, 0, 7) },<br>-<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 4) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr2El1, ENCODE_AA64_CP_REG(0, 2, =
2, 0, 5) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr2El1, =
ENCODE_AA64_CP_REG(0, 2, 2, 0, 6) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 7) =
},<br>-<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr3El1, =
ENCODE_AA64_CP_REG(0, 3, 2, 0, 4) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 5) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr3El1, ENCODE_AA64_CP_REG(0, 3, =
2, 0, 6) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr3El1, =
ENCODE_AA64_CP_REG(0, 3, 2, 0, 7) },<br>-<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 4) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr4El1, ENCODE_AA64_CP_REG(0, 4, =
2, 0, 5) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr4El1, =
ENCODE_AA64_CP_REG(0, 4, 2, 0, 6) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 7) =
},<br>-<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr5El1, =
ENCODE_AA64_CP_REG(0, 5, 2, 0, 4) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 5) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr5El1, ENCODE_AA64_CP_REG(0, 5, =
2, 0, 6) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr5El1, =
ENCODE_AA64_CP_REG(0, 5, 2, 0, 7) },<br>-<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 4) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr6El1, ENCODE_AA64_CP_REG(0, 6, =
2, 0, 5) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr6El1, =
ENCODE_AA64_CP_REG(0, 6, 2, 0, 6) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 7) =
},<br>-<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr7El1, =
ENCODE_AA64_CP_REG(0, 7, 2, 0, 4) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 5) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr7El1, ENCODE_AA64_CP_REG(0, 7, =
2, 0, 6) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr7El1, =
ENCODE_AA64_CP_REG(0, 7, 2, 0, 7) },<br>-<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 4) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr8El1, ENCODE_AA64_CP_REG(0, 8, =
2, 0, 5) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr8El1, =
ENCODE_AA64_CP_REG(0, 8, 2, 0, 6) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 7) =
},<br>-<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr9El1, =
ENCODE_AA64_CP_REG(0, 9, 2, 0, 4) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 5) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr9El1, ENCODE_AA64_CP_REG(0, 9, =
2, 0, 6) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr9El1, =
ENCODE_AA64_CP_REG(0, 9, 2, 0, 7) },<br>-<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 4) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr10El1, ENCODE_AA64_CP_REG(0, =
10, 2, 0, 5) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr10El1, =
ENCODE_AA64_CP_REG(0, 10, 2, 0, 6) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 7) =
},<br>-<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr11El1, =
ENCODE_AA64_CP_REG(0, 11, 2, 0, 4) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 5) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr11El1, ENCODE_AA64_CP_REG(0, =
11, 2, 0, 6) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr11El1, =
ENCODE_AA64_CP_REG(0, 11, 2, 0, 7) },<br>-<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 4) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr12El1, ENCODE_AA64_CP_REG(0, =
12, 2, 0, 5) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr12El1, =
ENCODE_AA64_CP_REG(0, 12, 2, 0, 6) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 7) =
},<br>-<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr13El1, =
ENCODE_AA64_CP_REG(0, 13, 2, 0, 4) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 5) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr13El1, ENCODE_AA64_CP_REG(0, =
13, 2, 0, 6) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr13El1, =
ENCODE_AA64_CP_REG(0, 13, 2, 0, 7) },<br>-<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 4) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr14El1, ENCODE_AA64_CP_REG(0, =
14, 2, 0, 5) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr14El1, =
ENCODE_AA64_CP_REG(0, 14, 2, 0, 6) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 7) =
},<br>-<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr15El1, =
ENCODE_AA64_CP_REG(0, 15, 2, 0, 4) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 5) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr15El1, ENCODE_AA64_CP_REG(0, =
15, 2, 0, 6) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr15El1, =
ENCODE_AA64_CP_REG(0, 15, 2, 0, 7) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(2, 0, 0, 0, 4) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(2, 0, =
0, 0, 5) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr0El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 0, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(2, 0, 0, 0, 7) =
},<br>+<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr1El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 1, 4) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr1El1, ENCODE_AA64_CP_REG(2, 0, 0, 1, 5) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr1El1, ENCODE_AA64_CP_REG(2, 0, =
0, 1, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr1El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 1, 7) },<br>+<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr2El1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 4) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr2El1, ENCODE_AA64_CP_REG(2, 0, =
0, 2, 5) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr2El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 2, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr2El1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 7) =
},<br>+<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr3El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 3, 4) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr3El1, ENCODE_AA64_CP_REG(2, 0, 0, 3, 5) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr3El1, ENCODE_AA64_CP_REG(2, 0, =
0, 3, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr3El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 3, 7) },<br>+<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr4El1, ENCODE_AA64_CP_REG(2, 0, 0, 4, 4) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr4El1, ENCODE_AA64_CP_REG(2, 0, =
0, 4, 5) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr4El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 4, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr4El1, ENCODE_AA64_CP_REG(2, 0, 0, 4, 7) =
},<br>+<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr5El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 5, 4) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr5El1, ENCODE_AA64_CP_REG(2, 0, 0, 5, 5) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr5El1, ENCODE_AA64_CP_REG(2, 0, =
0, 5, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr5El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 5, 7) },<br>+<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr6El1, ENCODE_AA64_CP_REG(2, 0, 0, 6, 4) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr6El1, ENCODE_AA64_CP_REG(2, 0, =
0, 6, 5) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr6El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 6, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr6El1, ENCODE_AA64_CP_REG(2, 0, 0, 6, 7) =
},<br>+<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr7El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 7, 4) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr7El1, ENCODE_AA64_CP_REG(2, 0, 0, 7, 5) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr7El1, ENCODE_AA64_CP_REG(2, 0, =
0, 7, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr7El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 7, 7) },<br>+<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr8El1, ENCODE_AA64_CP_REG(2, 0, 0, 8, 4) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr8El1, ENCODE_AA64_CP_REG(2, 0, =
0, 8, 5) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr8El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 8, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr8El1, ENCODE_AA64_CP_REG(2, 0, 0, 8, 7) =
},<br>+<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr9El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 9, 4) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr9El1, ENCODE_AA64_CP_REG(2, 0, 0, 9, 5) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr9El1, ENCODE_AA64_CP_REG(2, 0, =
0, 9, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr9El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 9, 7) },<br>+<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr10El1, ENCODE_AA64_CP_REG(2, 0, 0, 10, 4) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr10El1, ENCODE_AA64_CP_REG(2, =
0, 0, 10, 5) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr10El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 10, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr10El1, ENCODE_AA64_CP_REG(2, 0, 0, 10, 7) =
},<br>+<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr11El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 11, 4) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr11El1, ENCODE_AA64_CP_REG(2, 0, 0, 11, 5) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr11El1, ENCODE_AA64_CP_REG(2, =
0, 0, 11, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr11El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 11, 7) },<br>+<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr12El1, ENCODE_AA64_CP_REG(2, 0, 0, 12, 4) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr12El1, ENCODE_AA64_CP_REG(2, =
0, 0, 12, 5) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr12El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 12, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr12El1, ENCODE_AA64_CP_REG(2, 0, 0, 12, 7) =
},<br>+<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr13El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 13, 4) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr13El1, ENCODE_AA64_CP_REG(2, 0, 0, 13, 5) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr13El1, ENCODE_AA64_CP_REG(2, =
0, 0, 13, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr13El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 13, 7) },<br>+<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbvr14El1, ENCODE_AA64_CP_REG(2, 0, 0, 14, 4) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbcr14El1, ENCODE_AA64_CP_REG(2, =
0, 0, 14, 5) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr14El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 14, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgwcr14El1, ENCODE_AA64_CP_REG(2, 0, 0, 14, 7) =
},<br>+<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgbvr15El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 15, 4) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterDbgbcr15El1, ENCODE_AA64_CP_REG(2, 0, 0, 15, 5) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwvr15El1, ENCODE_AA64_CP_REG(2, =
0, 0, 15, 6) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterDbgwcr15El1, =
ENCODE_AA64_CP_REG(2, 0, 0, 15, 7) },<br> #ifdef SYNC_NO_RAW_REGS<br> =
&nbsp;&nbsp;&nbsp;&nbsp;/*<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* The =
registers below are manually synced on init because they are<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* marked as NO_RAW. We still list them to =
make number space sync easier.<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*/<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterMidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, =
0, 0) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterMpidrEl1, =
ENCODE_AA64_CP_REG(0, 0, 3, 0, 5) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterIdPfr0El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 0) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterMidrEl1, ENCODE_AA64_CP_REG(3, 0, 0, =
0, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterMpidrEl1, =
ENCODE_AA64_CP_REG(3, 0, 0, 0, 5) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterIdAa64Pfr0El1, ENCODE_AA64_CP_REG(3, 0, 0, 4, 0) },<br> =
#endif<br> #ifdef SYNC_CONST_ID_REGS<br> &nbsp;&nbsp;&nbsp;&nbsp;/* ID =
registers are ARM_CP_CONST (writes ignored). &nbsp;*/<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(0, =
4, 3, 0, 1), true },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterIdAa64Dfr0El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 0), true =
},<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterIdAa64Dfr1El1, =
ENCODE_AA64_CP_REG(0, 5, 3, 0, 1), true },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterIdAa64Isar0El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, 0), true =
},<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterIdAa64Isar1El1, =
ENCODE_AA64_CP_REG(0, 6, 3, 0, 1), true },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(3, 0, 0, 4, 1), true =
},<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterIdAa64Dfr0El1, =
ENCODE_AA64_CP_REG(3, 0, 0, 5, 0), true },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(3, 0, 0, 5, 1), true =
},<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterIdAa64Isar0El1, =
ENCODE_AA64_CP_REG(3, 0, 0, 6, 0), true },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterIdAa64Isar1El1, ENCODE_AA64_CP_REG(3, 0, 0, 6, 1), true =
},<br> #ifdef SYNC_NO_MMFR0<br> &nbsp;&nbsp;&nbsp;&nbsp;/* We keep the =
hardware MMFR0 around. HW limits are there anyway */<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterIdAa64Mmfr0El1, =
ENCODE_AA64_CP_REG(0, 7, 3, 0, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterIdAa64Mmfr0El1, ENCODE_AA64_CP_REG(3, 0, 0, 7, 0) },<br> =
#endif<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterIdAa64Mmfr1El1, =
ENCODE_AA64_CP_REG(0, 7, 3, 0, 1), true },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterIdAa64Mmfr2El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 2), true =
},<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterIdAa64Mmfr3El1, =
ENCODE_AA64_CP_REG(0, 7, 3, 0, 3), true },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(3, 0, 0, 7, 1), true =
},<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterIdAa64Mmfr2El1, =
ENCODE_AA64_CP_REG(3, 0, 0, 7, 2), true },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(3, 0, 0, 7, 3), true =
},<br> #endif<br><br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterMdscrEl1, =
ENCODE_AA64_CP_REG(0, 2, 2, 0, 2) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 0) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterCpacrEl1, ENCODE_AA64_CP_REG(1, 0, =
3, 0, 2) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterTtbr0El1, =
ENCODE_AA64_CP_REG(2, 0, 3, 0, 0) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterTtbr1El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 1) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterTcrEl1, ENCODE_AA64_CP_REG(2, 0, 3, =
0, 2) },<br>-<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApiAKeyLoEl1, =
ENCODE_AA64_CP_REG(2, 1, 3, 0, 0) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterApiAKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 1) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApiBKeyLoEl1, ENCODE_AA64_CP_REG(2, =
1, 3, 0, 2) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApiBKeyHiEl1, =
ENCODE_AA64_CP_REG(2, 1, 3, 0, 3) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterApdAKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 0) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApdAKeyHiEl1, ENCODE_AA64_CP_REG(2, =
2, 3, 0, 1) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApdBKeyLoEl1, =
ENCODE_AA64_CP_REG(2, 2, 3, 0, 2) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterApdBKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 3) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApgAKeyLoEl1, ENCODE_AA64_CP_REG(2, =
3, 3, 0, 0) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApgAKeyHiEl1, =
ENCODE_AA64_CP_REG(2, 3, 3, 0, 1) },<br>-<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterSpsrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 0) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterElrEl1, ENCODE_AA64_CP_REG(4, 0, 3, =
0, 1) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterSpEl1, =
ENCODE_AA64_CP_REG(4, 1, 3, 0, 0) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterEsrEl1, ENCODE_AA64_CP_REG(5, 2, 3, 0, 0) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterFarEl1, ENCODE_AA64_CP_REG(6, 0, 3, =
0, 0) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterParEl1, =
ENCODE_AA64_CP_REG(7, 4, 3, 0, 0) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterMairEl1, ENCODE_AA64_CP_REG(10, 2, 3, 0, 0) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterVbarEl1, ENCODE_AA64_CP_REG(12, 0, =
3, 0, 0) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterContextidrEl1, =
ENCODE_AA64_CP_REG(13, 0, 3, 0, 1) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterTpidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, 4) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterCntkctlEl1, ENCODE_AA64_CP_REG(14, =
1, 3, 0, 0) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterCsselrEl1, =
ENCODE_AA64_CP_REG(0, 0, 3, 2, 0) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterTpidrEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 2) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterTpidrroEl0, ENCODE_AA64_CP_REG(13, =
0, 3, 3, 3) },<br>- &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterCntvCtlEl0, =
ENCODE_AA64_CP_REG(14, 3, 3, 3, 1) },<br>- &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterCntvCvalEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, 2) },<br>- =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, =
4, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterMdscrEl1, =
ENCODE_AA64_CP_REG(2, 0, 0, 2, 2) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(3, 0, 1, 0, 0) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterCpacrEl1, ENCODE_AA64_CP_REG(3, 0, =
1, 0, 2) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterTtbr0El1, =
ENCODE_AA64_CP_REG(3, 0, 2, 0, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterTtbr1El1, ENCODE_AA64_CP_REG(3, 0, 2, 0, 1) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterTcrEl1, ENCODE_AA64_CP_REG(3, 0, 2, =
0, 2) },<br>+<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApiAKeyLoEl1, =
ENCODE_AA64_CP_REG(3, 0, 2, 1, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterApiAKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 1, 1) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApiBKeyLoEl1, ENCODE_AA64_CP_REG(3, =
0, 2, 1, 2) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApiBKeyHiEl1, =
ENCODE_AA64_CP_REG(3, 0, 2, 1, 3) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterApdAKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 2, 0) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApdAKeyHiEl1, ENCODE_AA64_CP_REG(3, =
0, 2, 2, 1) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApdBKeyLoEl1, =
ENCODE_AA64_CP_REG(3, 0, 2, 2, 2) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterApdBKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 2, 3) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApgAKeyLoEl1, ENCODE_AA64_CP_REG(3, =
0, 2, 3, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterApgAKeyHiEl1, =
ENCODE_AA64_CP_REG(3, 0, 2, 3, 1) },<br>+<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterSpsrEl1, ENCODE_AA64_CP_REG(3, 0, 4, 0, 0) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterElrEl1, ENCODE_AA64_CP_REG(3, 0, 4, =
0, 1) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterSpEl0, =
ENCODE_AA64_CP_REG(3, 0, 4, 1, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterEsrEl1, ENCODE_AA64_CP_REG(3, 0, 5, 2, 0) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterFarEl1, ENCODE_AA64_CP_REG(3, 0, 6, =
0, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterParEl1, =
ENCODE_AA64_CP_REG(3, 0, 7, 4, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterMairEl1, ENCODE_AA64_CP_REG(3, 0, 10, 2, 0) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterVbarEl1, ENCODE_AA64_CP_REG(3, 0, =
12, 0, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterContextidrEl1, =
ENCODE_AA64_CP_REG(3, 0, 13, 0, 1) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterTpidrEl1, ENCODE_AA64_CP_REG(3, 0, 13, 0, 4) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterCntkctlEl1, ENCODE_AA64_CP_REG(3, 0, =
14, 1, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterCsselrEl1, =
ENCODE_AA64_CP_REG(3, 2, 0, 0, 0) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterTpidrEl0, ENCODE_AA64_CP_REG(3, 3, 13, 0, 2) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterTpidrroEl0, ENCODE_AA64_CP_REG(3, 3, =
13, 0, 3) },<br>+ &nbsp;&nbsp;&nbsp;{ WHvArm64RegisterCntvCtlEl0, =
ENCODE_AA64_CP_REG(3, 3, 14, 3, 1) },<br>+ &nbsp;&nbsp;&nbsp;{ =
WHvArm64RegisterCntvCvalEl0, ENCODE_AA64_CP_REG(3, 3, 14, 3, 2) },<br>+ =
&nbsp;&nbsp;&nbsp;{ WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(3, 4, 4, =
1, 0) },<br> };<br><br> HRESULT whpx_set_exception_exit_bitmap(UINT64 =
exceptions)<br>-- =
<br>2.55.0.vfs.0.3<br></div></div></blockquote></div><br></body></html>=

--Apple-Mail=_CB59F25D-39F2-49A6-8EBA-F7FC28BBF995--

