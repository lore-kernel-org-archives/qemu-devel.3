Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A519606A334
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=GfcKcrBr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWi3M-0004E6-Vx; Thu, 26 Nov 2026 17:34:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWi3K-0004Cg-0j
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:34:54 -0500
Received: from ms-2001h-snip6-8.eps.apple.com ([2a01:b747:3002:203::4f]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWi3H-0004pk-Fu
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:34:53 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 6E3E218000B8; Thu, 26 Nov 2026 22:34:48 +0000 (UTC)
X-ICL-RepId: 01a219ff-3fcf-77cc-a80f-5554a35c186c
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1795732488; x=1827268488;
 bh=GTGFB0tJpmisT/ykXzeZdTdcHYYFsu4bJ3sMhWMJ3to=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=GfcKcrBrF2f1Xiu/LYKnMpqNTbPqJoj8MHeVQmPsgmnS2TtHZt1iA0K/dCuVKtiGrhczff/lXuWNMXLoX8actwACAJW6Fk2HpIxZ88FU5VnfXBmwwY7gXttaRWrtTGA61/YMCHIwtEcrMGSmHvp1gHij5YT2fEQd57obrFzAUOirD8swltUKxVP8pljXL22+TbT9SnUu43boiTO4RQq9nw7rJWY15nM1WeZaQtcE1HeQifvxjga7KHP60hO4fkhQb6pHGSujs6M2rHYIVxa5MFZF1oVnw5wF3qrI5GPP7kDcdmHp9m9EyS23RzXpI67ZZY2aS4Zx7OlM7R6wko4NGA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.208.39])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 35713180011F; Thu, 26 Nov 2026 22:34:47 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH] util/oslib-posix: Have qemu_get_thread_id return the
 thread id on macOS
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20261126220001.58932-1-philmd@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 23:34:43 +0100
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <345DAC67-4FBD-46E2-AC57-438B13FBDC4B@unpredictable.fr>
References: <20261126220001.58932-1-philmd@oss.qualcomm.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA4OSBTYWx0ZWRfX+g6HfbVXRKHJ
 B7+7GJmWBkHp8agfCCdQi5oZ7PgFGRIBrIh0++FTlxVFkrXHDzXJGWbY8ELMbSJvFi7n9S404uo
 YiEzaVNFOxKhDhQaYMtW8SqWScT/+LA=
X-Authority-Info-Out: v=2.4 cv=LsgHWXdc c=1 sm=1 tr=0 ts=6b08b408
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=fajnDIswKVxD1YtQT70F:22 a=DklAH-oqaN1iciwkUFA5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=r6wB5KQJkLeyaEijXyEA:9
 a=w16HZhMh_ex5DL1h:21 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Wiv0ppoHeARccftZ3wtszHxaAIeyNbhs
X-Proofpoint-ORIG-GUID: Wiv0ppoHeARccftZ3wtszHxaAIeyNbhs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA4OSBTYWx0ZWRfX+7VZ44THbr5H
 iwH3iaoWLLOZXA1FL9lkBd4MXjjl6ifKer5ncdhh/qH5rDXhwvKkb6r8ikQ+p3vev1PGi9BzqF+
 /srf8zj5j7VcG0knP5fU9F11cZMOt7+ddtHENQ6WKLOihPOjrlM2G9wihJuQN9EFG9jwAEXjxVL
 yuSpryBimV2pWvS+TRm4IbAEdCD+4nw2E7F4IF0feTk5Z9o94QAxEqo7x70/tE1ngLWB1+gYP4G
 mKHCmYAicvAkDGCpNkT3FqG5xFHzH3sot7sdoF5umE1BQHIzMGQ240NWVPJnAd0Hb0F9Kh7QT89
 TId0RWT5j6IgKIYfxrYQQwKf5L5zpdcRKuX1wa51ltHKjNDjQjgUH1qCmY2dt8=
X-JNJ: AAAAAAABjKSrlhXdoV23jcsd/gr/YFogFoQ5LLzAMUOek5P5Kcw4iu6zz1M01F77o59JWT
 WtWqnyjW0z5Povs6HQGs1y4DwnkwfP3h7XpQ0rGuXWZPAC0X9FpPdLk46P793HJDTsOhYz
 IGQbz3xy0QqJjSd6iYPdVYlBJ4oOjMNHfN6U0rsSDUsy+/8giTFtZHhOzycYwb8TOc5m/Q
 3pcNQIH6XyQiHx8pD6gg4DvlC4E+UAs545OTjn1PRN5m9bqM5tmxeiTFY2pBsE/YuKv8l6
 8TQhBZQcVOtFw3zXhw3YiDYfuCXIJW5RLOMciSKTdXkz+3IYApjMFRrihP7AdivDp/wP9q
 gXIirn5TYM39bhAs0o0UKTP6F4vDFZ+YV3Jhjh8XEDmI2x6WlR+9cEaO2eRgt382NtNGB9
 TqPcG8vsdqYXsKwWBG8gCLwuwH0ZnTxe3uoOyCE43QjC/08mznHaPxgYFvRUz5GSH/dduF
 p9TSbheAWS3sxeuGHuII+Ok0W0IPp4zxpNYol1bTssj1DEEMoo+V92ctQsxM5pwSQduL2d
 JxCsXWKth/tTGpSvS9rzUbcALtrS0NZ77TDmuvFhMYw+mGyR0yZrEHzseXLTByK3kPGcjV
 BEGLZl1nVp9hj7ZSui0+wPGZzgZrUoyC/yubGQdPMH8mcr9ta/fBciOfgeg36hVxKOnKul
 zICfbhx0VbfCcMPKg1wvYi6jeRg/p+Ylx2/evFKB4OucrCuEOXMQY4GRGOShn5IEkZKSii
 yuGKg55OnlCQIE5n7IhpO24dHDAf6yWqYzpEpd8WinCyzeE4GutJsc70G6pZhN8rluNxmz
 QRcc7M9tQtnBeRtniEAsBC+SrmA8UmsfNfJDNM6DA9aJ4x4LMa+LsRCUs+5pmHAQBw5ciw
 Fzp72uJDAvPCWu+rL1jHmIlPVcHRaNdiFUeHTPpvftkVdetv/Vig6ARP9mRRQn7H2Yunyc
 Br1GG/XPretm49QJbRR1wJo+cx+WpBQkBFa1NW0kiwhrb9RziFQnMHWZP7e5kJ1t0owLp2
 NeqjJD0pyZoQfPH6nD4LFYqWZxp5AYxPJzPsKHpNC6fGMky9wYUg+4RD1+I8Z8hDbUMdxe
 nxa86MdOmkEI9Vvx9gczKR/GnySVX3gf4VRpKpmnKmbNiXJrSFq1hiYjbGoE4hMTaMr66u
 uLtW8vQ0Ht6x+YS0bWaU3YNgp4L8sQpGQVOYLglqb+Vsfvt0BecM3viKEuRlpa7LYbxhML
 7z+8ILgN4je8mD7bazDe4IPr9A4xJXiLivaY6/pNY7ll9h5UvswuZqhkq0QnfYuAI0UeNU
 iuTOkhfCZada5x9yXkctGb8rObGZowkZYYtFHO0DQq8F9HRRP9zrteVD2nR7bmKaoqRShr
 PfCcFIzdTe8i2ftsshb3SGpymnrdA9DXpRnrrRGL13d43rvSMsmEGn7YtZYcH+s82uGZDA
 KgFsV9
Received-SPF: pass client-ip=2a01:b747:3002:203::4f;
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



> On 26. Nov 2026, at 23:00, Philippe Mathieu-Daud=C3=A9 =
<philmd@oss.qualcomm.com> wrote:
>=20
> qemu_get_thread_id() fell back to getpid() on macOS, so
> every thread, including each vCPU reported by query-cpus-fast,
> shared the process id. Use pthread_threadid_np(), keeping the
> value positive.
>=20
> For example running '-M virt -smp 2 -accel tcg,thread=3Dmulti',
> QMP 'query-cpus-fast' returned before:
>=20
>  {"return": [{"thread-id": 58412, "cpu-index": 0, ...},
>              {"thread-id": 58412, "cpu-index": 1, ...}]}
>=20
> and now:
>=20
>  {"return": [{"thread-id": 75188616, "cpu-index": 0, ...},
>              {"thread-id": 75188617, "cpu-index": 1, ...}]}
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
Reviewed-by: Mohamed Mediouni <mohamed.mediouni@linaro.org>
> ---
> util/oslib-posix.c | 4 ++++
> 1 file changed, 4 insertions(+)
>=20
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index dc001da66dd4..71fd369e42f1 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -107,6 +107,10 @@ int qemu_get_thread_id(void)
>     return _lwp_self();
> #elif defined(__OpenBSD__)
>     return getthrid();
> +#elif defined(__APPLE__)
> +    uint64_t tid;
> +    pthread_threadid_np(NULL, &tid);
> +    return tid & INT_MAX;
> #else
>     return getpid();
> #endif
> --=20
> 2.55.0
>=20


