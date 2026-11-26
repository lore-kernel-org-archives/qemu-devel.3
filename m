Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9DF606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=MkEk7YtP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWiFD-0001YY-Au; Thu, 26 Nov 2026 17:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWiF4-0001Xu-Vw
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:47:04 -0500
Received: from st-2006f-snip6-11.eps.apple.com ([2a01:b747:3001:203::3d]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWiF2-0001ek-HQ
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:47:02 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPS id
 C78BE1800198; Thu, 26 Nov 2026 22:46:46 +0000 (UTC)
X-ICL-RepId: 01a21a0a-36c2-7b61-a7e7-b1e9de21cb9d
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1795733209; x=1827269209;
 bh=r6NoNXR5+3O5cjqWQmKXRnjfLW3IHXMe3iEOodEYPGM=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=MkEk7YtPCHq+Q7i55xkxjR3vS3glVTay7R3KpzzXsDbhBK8T1jJ24zaZ+BKO35RBYH412jFzpkhWseYmLWD0ANryMDLzqmIp0SpSB/n6LfFPgSr7AEX2rh7XAml0ob04MRMl6gky59LMIaZ0oL41a6HO/htgfQ60eIpcXt+X2lyYwOsVq2qP14i0ozlp0rDoo9vz1dRuuZ5jeYcmyVrC4/k2+o8EuZjzUjIGN9FApX/AkTBLGuBcxJsAUU9qH/BmaDChCgnMJvft8HYiYfqoDzN90x/WsVhnQfnMlEhpFMCJJ5OW6Z+kszpZQgtMvq5wecV1aZi73AwKEO6ckhs1CQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPSA id
 1D5B01800439; Thu, 26 Nov 2026 22:46:45 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 1/2] target/arm: Split ARM_CP_IO as ARM_CP_IO_ENDTB +
 ARM_CP_IO_BQL
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20261126223959.62899-2-philmd@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 23:46:32 +0100
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <33E9DD67-CFB7-4CC5-8B51-78B61F838020@unpredictable.fr>
References: <20261126223959.62899-1-philmd@oss.qualcomm.com>
 <20261126223959.62899-2-philmd@oss.qualcomm.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA4OSBTYWx0ZWRfX0i3ycfLDBoxi
 2RYun1GvRj8hkPy5u899AET2jgL/grHM8cU7oo52dxyeQ0fij1lRSns0lIQ1K9gLJ+jpqyNUCgt
 CxpBXCD7ANa9OIOjAbv1hLMoMe6hQWo=
X-Proofpoint-ORIG-GUID: INOnggC7VNMriuO-pNzRlMrkewp5c_ic
X-Authority-Info-Out: v=2.4 cv=Dq/Da2/+ c=1 sm=1 tr=0 ts=6b08b6d7
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=wbbCu9YnSpm8ZdSLOl1R:22 a=871Mr51So83XRmefo0B0:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=g0UTid85SeQCHO8TUEQA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: INOnggC7VNMriuO-pNzRlMrkewp5c_ic
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA4OSBTYWx0ZWRfX8YukFmcgR/9T
 tyaMl25Vmn9c3+AKG8jFFjj2GJHSdlUyBj4EDC4wWPCtRKEv/ck524+WDfX7ps3bYqCJY7hSHBR
 2OYr9qLNh4H6AW0Q9ZocOwmPi9gtaehTFO9X3i0pyIFgO6GVCxoZoAh280MgXZxZB/SSNKKAETe
 1I+F6SSArtf/EuQJRKU/CqE2P2VTMcLdnZpVlqMQnIf5wT40cQbpxmvfjj2OGZ7Llso42co8RVb
 NVN9r+LsuQjtujR7oH+bB5l/BXTRMuaqY908OMl6FnjVGtqAstQuQ6/qj424mycmAbk0kLFMfce
 xs/mqg6c2W0Tbnd5E0C1qr2/F6HS9UIYNVc5fnK4O7p6xRQ4TaxhlayaFb8dPQ=
X-JNJ: AAAAAAABu+fcV1ieVS9GXyXVPBi+BjvR2yomdFkt3fyTSGCfDK6TpWJxpArEXf05nWVvtx
 TWrTUFSazi/0b+Ffmsn5vqvWS4Fe4HltPVJuVYYw74aiiOh6zyxwLaq65DDn+PEe7hs5j+
 KupBNvZ8jVgltgAp88OjPms33knNdAPHT7nVqz2vWeWDLwfxrusa/lZK4ZLlbk2FAVHwMN
 7jg080yfKcMwkfsFOfFCFzgEaga2ws6mPOspEnBVS+H2S8Mr5bRzmuqQSEF6eB69C2WNxs
 qvmou4XXouy2OKm7r37TYylBHzhITXmXBKEydA4ykQ3tKpYvYnPQFySmkX2EaLjtK013Nl
 dA9qevl0qGZjp5AVXbZV8+V+qgE/XWWUTbHnDxszIKZw2NAfhYrc/TqMtus6/OggXRUcqS
 vsF8N6leZJeagFX7EqTO9oFMAC//aXW9sHrfEdVk9TQxG9VZuF8JJ6vkiWhzdKSDQcx2O5
 XVexULeD0K2Rz+ZBtzZQ5MFH2ZiFLzk//uPt9FMWPlTjmhZgQ5giJerfoLTMiDXwM7dVzx
 v67UIAjSEfGpFAPtmt3zG/LbGQ3jayBNOLzpSgmhy2/MkV4tyEMsIHuZL5xGLJR/nyIz/g
 945qezAYdOWnJB7dD9iNP989ioM8D5fmc3Ip6I5JLlH1GA0/wFAGpNSKvk9K95ZVxr9s5f
 4HOb5cZSKjr8ujOKpzi5Wkj3ifmKlDovPBbOu3LkG8XKKO9q4jVrDGsRmGhAcquvozFSlh
 v0jdMp5I/HoFFe/jMOlXufM7vzim/CNRWLQDVwbYcQFFZa5CK1ZiFV5MtA5W7dCvwXpLdy
 4rdO3v88Sg88gHXVyiTdnQ4sj1Va/W0qoIT5ttEQcV6e2dg8wItQuhK/i2I1ptp7y6mAu2
 +mECngUIU1d6S79aHDTJrlXWL1rAroyy8EysC24MpfhOqUgFNy0Sp6iAwAzlSHpG49W3e7
 DSjZkWgGHM30o8+kZuPX2CPTHL6bLuOXvQ4Ju2emyWoSou1YjbLLGCRvUQ97h+o2XZCMew
 dKCd65d9uF+fi+XdX0ld4NyoaLUxKB5Qy+BBEVBDSBTV40afErpn7wF7NFNcQUlk+iB45u
 kGXjIZ2RVLVzdisOBeFNQaORLwrUHQOMkdVKswv+ZfJCMHXji62xySaY17Vv7VYXrSOpYP
 +vm10r8JbdLPFwSsR/5L8vWr5+0GJM409WRsDfScna5GoeU0hws1ALkX3+thoBKDNqi+Vp
 luqUe7cigoyMIm0KqEpyTS+aXePY/iyWVUbl9u3UyOrEytXmP/sIYeDiBPD3mia7GjC49V
 ApvcIeIvFzRxQKmGpqkUdNwUxG8AKi33U849pBGHvWp27YrOiUrTN9D0e6M/TZ28GpEiCf
 BVtSk/ls7QlLEXB4Cp0KQdAfKRRmzVXRoB806Qnyl2125RRhC71lYiNprbAgj27sPzp7XT
 X7g02n710mdc00tg==
Received-SPF: pass client-ip=2a01:b747:3001:203::3d;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 26. Nov 2026, at 23:39, Philippe Mathieu-Daud=C3=A9 =
<philmd@oss.qualcomm.com> wrote:
>=20
> ARM_CP_IO both ends the TB at translation and takes the BQL
> around the read/write hooks. Split it into two flags so a
> register can end the TB without taking the BQL. ARM_CP_IO is
> now their union, so existing users are unchanged. Update
> multi-thread-tcg.rst document. No functional change.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
> docs/devel/multi-thread-tcg.rst |  8 +++++---
> target/arm/cpregs.h             | 11 ++++++++++-
> target/arm/helper.c             |  4 ++--
> target/arm/tcg/op_helper.c      |  8 ++++----
> target/arm/tcg/translate-a64.c  |  2 +-
> target/arm/tcg/translate.c      |  2 +-
> 6 files changed, 23 insertions(+), 12 deletions(-)
>=20
> diff --git a/docs/devel/multi-thread-tcg.rst =
b/docs/devel/multi-thread-tcg.rst
> index da9a1530c9fa..22d760ce3729 100644
> --- a/docs/devel/multi-thread-tcg.rst
> +++ b/docs/devel/multi-thread-tcg.rst
> @@ -240,9 +240,11 @@ minimise contention.
> (Current solution)
>=20
> MMIO access automatically serialises hardware emulation by way of the
> -BQL. Currently Arm targets serialise all ARM_CP_IO register accesses
> -and also defer the reset/startup of vCPUs to the vCPU context by way
> -of async_run_on_cpu().
> +BQL. Currently Arm targets serialise all ARM_CP_IO_BQL register
> +accesses (included in ARM_CP_IO) and also defer the reset/startup of
> +vCPUs to the vCPU context by way of async_run_on_cpu(). Registers =
only
> +marked ARM_CP_IO_ENDTB, such as the generic timer counters, end the =
TB
> +but run their accessors without the BQL, so these must be =
thread-safe.
>=20
> Updates to interrupt state are also protected by the BQL as they can
> often be cross vCPU.
> diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
> index ce651a4faa60..d9efb9fd6b75 100644
> --- a/target/arm/cpregs.h
> +++ b/target/arm/cpregs.h
> @@ -82,8 +82,10 @@ enum {
>      * Flag: Register does I/O and therefore its accesses need to be =
marked
>      * with translator_io_start() and also end the TB. In particular,
>      * registers which implement clocks or timers require this.
> +     * Without ARM_CP_IO_BQL, the read and write hooks run without =
the BQL
> +     * and must be thread-safe.
>      */
> -    ARM_CP_IO                    =3D 1 << 9,
> +    ARM_CP_IO_ENDTB              =3D 1 << 9,
>     /*
>      * Flag: Register has no underlying state and does not support raw =
access
>      * for state saving/loading; it will not be used for either =
migration or
> @@ -154,6 +156,13 @@ enum {
>      * ARM pseudocode function CheckFPMREnabled().
>      */
>     ARM_CP_FPMR                  =3D 1 << 23,
> +    /*
> +     * Flag: The read and write hooks are called with the BQL held, =
e.g.
> +     * because they touch timers, interrupt lines or other cross-vCPU =
state.

Not including reading the timers if the next patch is any indication=E2=80=
=A6

> +     */
> +    ARM_CP_IO_BQL                =3D 1 << 24,
> +    /* Flags: Register does I/O and its hooks need the BQL */
> +    ARM_CP_IO                    =3D ARM_CP_IO_ENDTB | ARM_CP_IO_BQL,
> };

Hi,

Is it worthwhile to add an assert somewhere in case somebody does =
ARM_CP_IO_BQL
_without_ ARM_CP_IO_ENDTB by mistake?

Apart from that:

Reviewed-by: Mohamed Mediouni <mohamed.mediouni@linaro.org>

>=20
> /*
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index f413b15eb747..198ffc69aeac 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3976,7 +3976,7 @@ static void do_hcr_write(CPUARMState *env, =
uint64_t value, uint64_t valid_mask)
>      * virtual interrupts, which are the logical OR of these bits
>      * and the state of the input lines from the GIC. (This requires
>      * that we have the BQL, which is done by marking the
> -     * reginfo structs as ARM_CP_IO.)
> +     * reginfo structs as ARM_CP_IO_BQL.)
>      * Note that if a write to HCR pends a VIRQ or VFIQ or VINMI or
>      * VFNMI, it is never possible for it to be taken immediately
>      * because VIRQ, VFIQ, VINMI and VFNMI are masked unless running
> @@ -4179,7 +4179,7 @@ static void hcrx_write(CPUARMState *env, const =
ARMCPRegInfo *ri,
>      * virtual NMI, which are the logical OR of these bits
>      * and the state of the input lines from the GIC. (This requires
>      * that we have the BQL, which is done by marking the
> -     * reginfo structs as ARM_CP_IO.)
> +     * reginfo structs as ARM_CP_IO_BQL.)
>      * Note that if a write to HCRX pends a VINMI or VFNMI it is never
>      * possible for it to be taken immediately, because VINMI and
>      * VFNMI are masked unless running at EL0 or EL1, and HCRX
> diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
> index c2fdad7411db..c070aeee0f32 100644
> --- a/target/arm/tcg/op_helper.c
> +++ b/target/arm/tcg/op_helper.c
> @@ -1244,7 +1244,7 @@ void HELPER(set_cp_reg)(CPUARMState *env, const =
void *rip, uint32_t value)
> {
>     const ARMCPRegInfo *ri =3D rip;
>=20
> -    if (ri->type & ARM_CP_IO) {
> +    if (ri->type & ARM_CP_IO_BQL) {
>         bql_lock();
>         ri->writefn(env, ri, value);
>         bql_unlock();
> @@ -1258,7 +1258,7 @@ uint32_t HELPER(get_cp_reg)(CPUARMState *env, =
const void *rip)
>     const ARMCPRegInfo *ri =3D rip;
>     uint32_t res;
>=20
> -    if (ri->type & ARM_CP_IO) {
> +    if (ri->type & ARM_CP_IO_BQL) {
>         bql_lock();
>         res =3D ri->readfn(env, ri);
>         bql_unlock();
> @@ -1273,7 +1273,7 @@ void HELPER(set_cp_reg64)(CPUARMState *env, =
const void *rip, uint64_t value)
> {
>     const ARMCPRegInfo *ri =3D rip;
>=20
> -    if (ri->type & ARM_CP_IO) {
> +    if (ri->type & ARM_CP_IO_BQL) {
>         bql_lock();
>         ri->writefn(env, ri, value);
>         bql_unlock();
> @@ -1287,7 +1287,7 @@ uint64_t HELPER(get_cp_reg64)(CPUARMState *env, =
const void *rip)
>     const ARMCPRegInfo *ri =3D rip;
>     uint64_t res;
>=20
> -    if (ri->type & ARM_CP_IO) {
> +    if (ri->type & ARM_CP_IO_BQL) {
>         bql_lock();
>         res =3D ri->readfn(env, ri);
>         bql_unlock();
> diff --git a/target/arm/tcg/translate-a64.c =
b/target/arm/tcg/translate-a64.c
> index 14888202bada..7006f2c8ae8c 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -3236,7 +3236,7 @@ static void handle_sys(DisasContext *s, bool =
isread,
>         g_assert_not_reached();
>     }
>=20
> -    if (ri->type & ARM_CP_IO) {
> +    if (ri->type & ARM_CP_IO_ENDTB) {
>         /* I/O operations must end the TB here (whether read or write) =
*/
>         need_exit_tb =3D translator_io_start(&s->base);
>     }
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index 9d80294c9bb2..92762a813b5f 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -1893,7 +1893,7 @@ static void do_coproc_insn(DisasContext *s, int =
cpnum, int is64,
>         g_assert_not_reached();
>     }
>=20
> -    if (ri->type & ARM_CP_IO) {
> +    if (ri->type & ARM_CP_IO_ENDTB) {
>         /* I/O operations must end the TB here (whether read or write) =
*/
>         need_exit_tb =3D translator_io_start(&s->base);
>     }
> --=20
> 2.55.0
>=20
>=20


