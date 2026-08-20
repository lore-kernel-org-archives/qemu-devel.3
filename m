Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCB3C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 01:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwrKu-0004uP-EP; Wed, 19 Aug 2026 21:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwrKs-0004uG-T4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 21:12:50 -0400
Received: from qs-2006g-snip6-3.eps.apple.com ([2a01:b747:3006:202::42]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwrKq-0004eu-NA
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 21:12:50 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPS id
 AA32F1800105; Thu, 20 Aug 2026 01:12:40 +0000 (UTC)
X-ICL-RepId: 01a01cba-3508-7bc6-b217-0c494e257109
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQBIHVoORQNGCVYLWhcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0KWFsIWwQPH0wMUQJCBVZeSAsdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDjZ/THZZAl0CXX1BAFgaXwJBCVULVXUvH0cBOgYvcVgAMQhJAy1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1787188363; x=1789780363;
 bh=K2tue7a+CAeIdHQOnCNGDmUbQA2KhQiQ4QUoOPguBJI=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Wh0K0K81tg3cAnF9sI1HT/QHDXfAJwOj7ukhzHR1Mw/FbiOe9vaUCXmEeHbrNcJ8Po285I2QcRT7ynAXnLImxkk+xQ+OkbuaGcrLWlpOZkDdJq8Op9QB/Rq5KvdWpJ2DayIx8VKiy0VIQ0mh5nAr5W8vxyX2RwNmDmhR47RaGeSOG3hy2HWATd5f//WN9+6ZR8WJ+9r0TAzSrvN7AqT35chSwWdot6Obm8p3BYqk5l9K5S3EZgUGJS7lTY9b0Z5vXbCoRldRHI2XRhfOCVwZmT+KByLyveTaASC9fLLqs3eiJh5t/jtavH3saoqKimAZcSGv5BG8zJqbmVlW5RTD4Q==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPSA id
 0E2F0180014E; Thu, 20 Aug 2026 01:12:38 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH] target/i386/whpx: whpx_get_xsave_state error handling
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <LVXPR21MB70090CD62E78CC3BA2EB7E52ADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
Date: Thu, 20 Aug 2026 03:12:26 +0200
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF4E4560-D935-4010-88BD-78B5BF32A110@unpredictable.fr>
References: <LVXPR21MB70090CD62E78CC3BA2EB7E52ADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
To: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Proofpoint-ORIG-GUID: mv0GnHGXHxhY-n-CELWP6M2KvSdisDpn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAwNiBTYWx0ZWRfX5hknt8TT9mDQ
 wd0MmPs4i+7XMnG5rucUaWa45AhnE74g4RzCxpzfQ+ISpumhFW7eqqqr/P2mjN0unT/Kk2NLULi
 ExzWBS+EDSoLKBvccxZfAXaw6mABxCSiBzdpj+5SUmzC9iWJe4fkYZrZ2mgMUHoCPO6C83lKKX6
 ieC4fEcYuEZVPeo1Xlm/jhSV1d7rszUjTqgiGWihLy3eFTVFe+qAHyL4g8ShOXhuumQbdJhVTze
 cXq9eIovZNR3xWntyfKta7TIEsoTmtarfOldeaPQVI42ZkymqJw9XcQTeruZfwinTkaJf2jBZYB
 2J7ZZdtxNp2uVDBHHfnC+oGJpRDowg8vTZtj1h+MaYe3z9zh+FR4qOreAs9CxY=
X-Authority-Info-Out: v=2.4 cv=TN1Iilla c=1 sm=1 tr=0 ts=6a865489
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=POd5bVGQ_sbSSP8puIgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: mv0GnHGXHxhY-n-CELWP6M2KvSdisDpn
X-JNJ: AAAAAAAB6G40NUq6mj+15eH0ymkZKPblXoQ2IxM23QBK5Y3zxe/tlBeJYuYV4oIlpAAdjifdqRZyqNM61jEHltT4NCUMPtYs6BZY22ttk6KfoPOTJnV2cW37w/oAe5CZKXlcJ1lancgJu4Qz10AfQSU5hi3AxaaB94aFCEjYdJuKT8287AIZGAtHcAUcrmGqbvl5D2i8RytOBiPwFtaVN5AVUWf8Y5HQa37jaHwbL5epeAYzhEQQHrh+wgDviwbmpdvQ0U6JJC/uyl8U6eyalopDkFXgU+h4ZrRPNk3DzdeO7IBGahb82pSj9MIxhQfpoC4J/KsV+ZS9/XrNAdXczsLUmYRE3vIaVWcmbTV/wkt8D6i5w4zbVGhUL/Hl5MCTNu3N2FGBnWsrV6fPc9xsGIolqsN6xK8uFY/UrDFFYuSDR92Al6x1rm8cIOzGL+x9tKh/UsBMPRD8HyJQ3IorcU3fTiIQPNAxKTUz/WV69o9AdYWA1doy/mNWOOvyIjjP5eMiHsTbVlKJx0R6fmA7iAtrkdc0JkNHXnIM4dhQ8qzIbzH0OJVPjsSRppciEy9oPtCuEvtkBMh9PEYPexla+xLWXPXRLzbK3Dp3eF/Ct0aaT5O+8KEe+UdK0oOh7l53p1HO340/k4J8ErHig5O8oJ+wd+JpAWdoAN7W8G3JlAYFEkGiW2RmgVfNBGWKeTjnWBxnhMGYNYQdFoxIBFFZe7kWPv1yfv25flS4hKgBk3zgWYZOLJDJHOIxE93jsrIBYB2VFfXRFXOWUcfSoVzhSYS2ocTszdKXiQJnECt5OKqwjJR4OFNb4029SXCqEHfgWKRWR2WCf8jATrWkYq5bzmaHGN5iP4iBfrBJhZy3hy1QkG9zCysTGC4Pz/iGjF82fZRT+UWh4xqi6AL2nMxz66dYTNWv7hFmNpaiRwhh6DXUGtLkMefqxX4ct8laFQHfwXPmTms+jAIiC5ygbp9cbB279gXyVcY
 +lHY7t1MAv5z9/SAD6nILVrdo+aMgpe2X7jL/Ox9rn1hB8SXxVUBMr9cit6dFysWLrnTnyYF00K8FETMbTVvB4OAOn/uX9di70XHej8P02x7C7sdX6YIhjWlCQksefMH8qK2ebB15uxrK2Ozfl0pBaZJcaKQx5R4uDfKkUfn1pxYEIyH4LL1bGXTt3K9O8wQkO5USx3jI5HYlDg6sdRAg3j486wp/X58tUKZy32yBNDJGwSSYAwf5yX0pcKJd1L5pDLOidFXh/+XayU58g3sfFTLaJVOegINH+2Fsh+PWs73M3LVydSgAxqFplWjUHwTU/TciREC6xx2T4fmHWLB5n/YPob8n7hpcnZDDvgE=
Received-SPF: pass client-ip=2a01:b747:3006:202::42;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 20. Aug 2026, at 02:56, Doug Cook (WINDOWS) <dcook@microsoft.com> =
wrote:
>=20
> Several problems with error handling in whpx_get_xsave_state:
>=20
> - Does not handle WHV_E_INSUFFICIENT_BUFFER, which occurs frequently
>  in practice for XSAVE state.
> - Does not free xsavec_buf when an error occurs.
> - Error message and return code use errno where they should use hr.
>=20
> Fixes: cfaa3b6c9597 ("whpx: xsave support")
>=20
> Signed-off-by: Doug Cook <dcook@microsoft.com>

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

> ---
> include/system/whpx-internal.h |  5 ++-
> target/i386/whpx/whpx-all.c    | 73 +++++++++++++++++++++++++---------
> 2 files changed, 57 insertions(+), 21 deletions(-)
>=20
> diff --git a/include/system/whpx-internal.h =
b/include/system/whpx-internal.h
> index c295c5a529..b15f3d8faf 100644
> --- a/include/system/whpx-internal.h
> +++ b/include/system/whpx-internal.h
> @@ -58,8 +58,9 @@ void whpx_apic_get(APICCommonState *s);
>=20
> #define WHV_E_UNKNOWN_CAPABILITY 0x80370300L
>=20
> -/* This should eventually come from the Windows SDK */
> -#define WHV_E_UNKNOWN_PROPERTY 0x80370302
> +/* These should eventually come from the Windows SDK */
> +#define WHV_E_INSUFFICIENT_BUFFER 0x80370301L
> +#define WHV_E_UNKNOWN_PROPERTY 0x80370302L
>=20
> #define LIST_WINHVPLATFORM_FUNCTIONS(X) \
>   X(HRESULT, WHvGetCapability, (WHV_CAPABILITY_CODE CapabilityCode, =
VOID* CapabilityBuffer, UINT32 CapabilityBufferSizeInBytes, UINT32* =
WrittenSizeInBytes)) \
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index 634d542821..682c85cef1 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -442,8 +442,8 @@ static int whpx_set_xsave_state(const CPUState =
*cpu)
>=20
>     qemu_vfree(xsavec_buf);
>     if (FAILED(hr)) {
> -        error_report("WHPX: Failed to get virtual processor context, =
hr=3D%08lx",
> -                     hr);
> +        error_report("WHPX: Failed to set xsave state, hr=3D%08lx", =
hr);
> +        return -EIO;
>     }
>=20
>     return 0;
> @@ -810,9 +810,28 @@ static void whpx_get_legacy_fp_registers(CPUState =
*cpu, WHPXStateLevel level)
>     idx +=3D 1;
> }
>=20
> -static int whpx_get_xsave_state(CPUState *cpu)
> +static HRESULT whpx_get_xsave_state_buffer(const CPUState *cpu, void =
*buf,
> +                                           size_t buf_len,
> +                                           UINT32 *bytes_written)
> {
>     struct whpx_state *whpx =3D &whpx_global;
> +
> +    if (!whpx_is_legacy_os()) {
> +        return whp_dispatch.WHvGetVirtualProcessorState(
> +            whpx->partition, cpu->cpu_index,
> +            WHvVirtualProcessorStateTypeXsaveState,
> +            buf,
> +            buf_len, bytes_written);
> +    } else {
> +        return whp_dispatch.WHvGetVirtualProcessorXsaveState(
> +            whpx->partition, cpu->cpu_index,
> +            buf,
> +            buf_len, bytes_written);
> +    }
> +}
> +
> +static int whpx_get_xsave_state(CPUState *cpu)
> +{
>     X86CPU *x86cpu =3D X86_CPU(cpu);
>     CPUX86State *env =3D &x86cpu->env;
>     int ret;
> @@ -825,27 +844,43 @@ static int whpx_get_xsave_state(CPUState *cpu)
>     xsavec_buf =3D qemu_memalign(page, xsavec_buf_len);
>     memset(xsavec_buf, 0, xsavec_buf_len);
>=20
> -    if (!whpx_is_legacy_os()) {
> -        hr =3D whp_dispatch.WHvGetVirtualProcessorState(
> -            whpx->partition, cpu->cpu_index,
> -            WHvVirtualProcessorStateTypeXsaveState,
> -            xsavec_buf,
> -            xsavec_buf_len, &bytes_written);
> -    } else {
> -        hr =3D whp_dispatch.WHvGetVirtualProcessorXsaveState(
> -            whpx->partition, cpu->cpu_index,
> -            xsavec_buf,
> -            xsavec_buf_len, &bytes_written);
> +    bytes_written =3D 0;
> +    hr =3D whpx_get_xsave_state_buffer(cpu, xsavec_buf, =
xsavec_buf_len,
> +                                     &bytes_written);
> +
> +    /*
> +     * whpx_get_xsave_max_len() returns the size of user state =
components
> +     * enabled in XCR0. The hypervisor returns an XSAVES image, which =
also
> +     * contains the supervisor state, so the whpx_get_xsave_max_len() =
size
> +     * may be too small.
> +     */
> +    if (hr =3D=3D WHV_E_INSUFFICIENT_BUFFER && bytes_written > =
xsavec_buf_len) {
> +        qemu_vfree(xsavec_buf);
> +        xsavec_buf_len =3D bytes_written;
> +        xsavec_buf =3D qemu_memalign(page, xsavec_buf_len);
> +        memset(xsavec_buf, 0, xsavec_buf_len);
> +
> +        bytes_written =3D 0;
> +        hr =3D whpx_get_xsave_state_buffer(cpu, xsavec_buf, =
xsavec_buf_len,
> +                                         &bytes_written);
>     }
> -    if (FAILED(hr) || bytes_written =3D=3D 0) {
> -        error_report("failed to get xsave state: %s", =
strerror(errno));
> -        return -errno;
> +
> +    if (FAILED(hr)) {
> +        error_report("WHPX: Failed to get xsave state, hr=3D%08lx", =
hr);
> +        qemu_vfree(xsavec_buf);
> +        return -EIO;
> +    }
> +
> +    if (bytes_written =3D=3D 0) {
> +        error_report("WHPX: Failed to get xsave state, no data =
returned");
> +        qemu_vfree(xsavec_buf);
> +        return -EIO;
>     }
>=20
> -    ret =3D decompact_xsave_area(xsavec_buf, xsavec_buf_len, env);
> +    ret =3D decompact_xsave_area(xsavec_buf, bytes_written, env);
>     qemu_vfree(xsavec_buf);
>     if (ret < 0) {
> -        error_report("failed to decompact xsave area");
> +        error_report("WHPX: Failed to decompact xsave area");
>         return ret;
>     }
>     x86_cpu_xrstor_all_areas(x86cpu, env->xsave_buf, =
env->xsave_buf_len);
> --=20
> 2.55.0.vfs.0.3
>=20


