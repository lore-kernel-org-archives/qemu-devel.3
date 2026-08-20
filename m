Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FCCC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 00:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwqkY-0003tp-HN; Wed, 19 Aug 2026 20:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwqkW-0003tW-N5
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:35:16 -0400
Received: from ms-2004f-snip6-11.eps.apple.com ([2a01:b747:3002:205::3d]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwqkV-0001oG-5C
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:35:16 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-11 (Postfix) with ESMTPS id
 EA9E0180010D; Thu, 20 Aug 2026 00:35:11 +0000 (UTC)
X-ICL-RepId: 01a01c97-e57e-79ee-9ced-cc0b49e3700a
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQBIHVoORQNGCVYLWhcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0KWFsIWwQPH0wMUQJCBVZeVAsdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDjV7QQModC0BXXxNdikaX3RBf1VxXQBaHzJ8TQtfA1N2QwlNcC1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1787186114; x=1789778114;
 bh=+jTdn8JxD6nclM1XWmG41oJzILJG08z/89Dl9C9zDO8=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=qaPUVuWqZq33PTjhbm0jjvkJ/PI+xbnbKWqmkQCGz3uyTj8/EVnJxPm/2izaK+UauCnuZVQgIJ9gFOFx/J+AfDDBdAzOK1HoFfsBDzMxOLnoyQXRhzfN0k+OdRj5V8+H7fGuOPG5XGjTQ9DiUw5E7I71b3tPwD/d3ojisn8bisDpeXuDkluAPMzRv7go+DOPsgCt53tEdRxJMR6pbmpqJiIMBCAALePn5yySWt6IZQ+rNvvxNTTTNsAsi/642C3CFd452FSELfNdOjO35eXi+lKtqISxr/s7R8ly76ey5BLJezASFcrLRhxvb2L64K3LovnR/xzA8JyuS172F7cxyg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.208.39])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-11 (Postfix) with ESMTPSA id
 97E2F18000B6; Thu, 20 Aug 2026 00:35:10 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH v2 1/3] target/arm/whpx: Don't try to sync ARM_CP_CONST
 registers
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <LVXPR21MB7009C0007D22503C38FE053EADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
Date: Thu, 20 Aug 2026 02:34:58 +0200
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EB90ECF3-E5ED-4F1F-B071-BE58248D305C@unpredictable.fr>
References: <LVXPR21MB7009C0007D22503C38FE053EADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
To: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Authority-Info-Out: v=2.4 cv=KYXfcAYD c=1 sm=1 tr=0 ts=6a864bc0
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=b2yJOJVvDGAxA0_GH54A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: pYuV-JhqCmsUmIbBT2FvOHru0VX2lFm5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAwMiBTYWx0ZWRfX6T5ChF1rvasD
 6kHJODmKqPHcXxiYJM0AY9cuxAcKuldMfXwKg9Z3A2epop4p2NwjOxR3CTw1ARNDrTJTZWavBX7
 S94fyMAXvwGd9Lb+KWxN71YkRpfvfa+ogx6wOP1G3/zybljaCL+fsHr6q+QgwrXbIT1UJ91LrpT
 1k4jKnfn4Wt9GrxWCaKPnvZZgPWPqCZGPGYE0EcBhZ/ecveYAiqFigHbeF5R1RTEECKxDs+UInr
 JALYsOOhkxVyvjvsOeiCa5volrvNK0svBSzsu3YGRq86Q4bb6S6lA6JnrLQbxqSol72sukUZWja
 Sq8so76jjE0gZB0B4RXoM3bPiGL7AxpBOTGoRZdOu4EnttKE2r9hOb0FZ7ZRTM=
X-Proofpoint-GUID: pYuV-JhqCmsUmIbBT2FvOHru0VX2lFm5
X-JNJ: AAAAAAABSo65cn19G7MyCEp0R/7C2t2BB58XUy3CzgahQuBd0qMUm0zzbGzkJd6jrq76oZ9esLwEvKMGn4yiM4M+u/luaePW3M/DtYa2ynKmcWYSMkBKElBHTlEmPb8a6jYpNOKmCEPtUqa8B6DTJdq/IwvRxt1yiqHqrCS95ZN2uQqJcLvkGw6UQPJk0c/zFKd8Wk77RnGiVu+qVDLBfRsYPEc4GFue+kxv0WyOKYKGRZxXHIS1NHz64qJVpnoxF3ZU1M5XsPION06ALCfyKY/M/0h1TAMedd7B/Hl3arT6d6ACrWcuOcg96jleD8CFzZYZ/mcWGoJ85yRh76vDrSkcBYVAXzEa0Tk3YP1d9FVxXalGqzcW1QRnIHj4kkRgNFrhs5IqM4xLw1VhWAqQxkVHZF5M4nHp/YooAaBBjC1bn8dPpfwK6w/VGjf7A4a61v//V7PA8DoMvWy4ejG93XZIMBaaMsBKnexq0y6y6lq1zACVRqMow3E2ve7ioTL2YYr/R+kbqD0KFuRtaaUYXfVFfbke5svra4H0f258k6ZHmDXhItmetbwqe7c+VPz5TS+PJR8/TZSQ25UPJC/kzB7Miyepp2/DngP6TbiQwVt4WHgDmujPSk0TsXpMzr46LYkS7yu3pdLd0fbXrk3pHJfSZwwvZ4bg1fZq+QxgJ7tidWSIx5x1TVczuK0LSWk6raYnfMGxECD9JqDs8MRMpeio3jguEzEwKE31JbOgzO9sYmaviHGw98J+llp8ma53Nwle0qsYoOFd3hXKA/V3Ki4lXqU6ssgEs6AcA70/xdqPGrq9lT4gc3PyU2e/jUkJ8XNL6+imPqL39HSaVfnpz1mz3gEXY5CDExwdHvo4LhgxMy7i7Z0CQKv3LPmQOodPqzF6iE2lkofGNgjaLLSUxx7VTNkGrbQ8vMmNmQz6vN2Kl6+jYLjzucxeTggsChWrhGWrSyyI5+DYoyhj3z4dmteUAZpl+Hr
 fK2uaJYC8r0dqRWdP3Q2ZKzgj+W3eL9ehmFihuQQOSYM2UWkZwBKfYyMwNhjJ5Ve7RlaCbkg9M32W+fXK0OPEcN/O0jHSpkMVxmaRQjlGLZW99+7uOffN23QxsEgfunwxUp19bkc4CMbQficEFS7yQpmDTo1lXpM7iM3BzLWDs1RrdtIJb7QaAO6Fpr8SX+gNvIsujJrxQOeZg1w5NaR0HiiTXzOgP4PqKm5c/7NdHQlNfKmA2twZ5KHFlHRFeGf+cq3rMBXYxrjQbl7a/IJhewWblcUghdbwdTVqKeeKWrHgBNzOziOfpm1vi1n2fFqBVWYpueAY6f8CU/Z2kaaAwqnsDvAZl/zoHhQW8Pe0n5m3eVrc3NjC4Z21ZXvKI6ZQAK/kpQDg9bO6XtTCPpfg
Received-SPF: pass client-ip=2a01:b747:3002:205::3d;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 20. Aug 2026, at 02:30, Doug Cook (WINDOWS) <dcook@microsoft.com> =
wrote:
>=20
> ARM_CP_CONST registers ignore writes, so readback assertion fails.
>=20
> Not asserting now because all entries in the whpx_sreg_match table are
> invalid. Needs to be fixed now so that we can fix the table entries.
>=20
> Signed-off-by: Doug Cook <dcook@microsoft.com>

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

> ---
> target/arm/whpx/whpx-all.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index 00a5de8cdc..9a5a575b5e 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -223,6 +223,8 @@ static struct whpx_sreg_match whpx_sreg_match[] =3D =
{
>     { WHvArm64RegisterMpidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 5) },
>     { WHvArm64RegisterIdPfr0El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 0) },
> #endif
> +#ifdef SYNC_CONST_ID_REGS
> +    /* ID registers are ARM_CP_CONST (writes ignored).  */
>     { WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, =
1), true },
>     { WHvArm64RegisterIdAa64Dfr0El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, =
0), true },
>     { WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, =
1), true },
> @@ -235,6 +237,7 @@ static struct whpx_sreg_match whpx_sreg_match[] =3D =
{
>     { WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, =
1), true },
>     { WHvArm64RegisterIdAa64Mmfr2El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, =
2), true },
>     { WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, =
3), true },
> +#endif
>=20
>     { WHvArm64RegisterMdscrEl1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 2) },
>     { WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 0) },
> @@ -790,7 +793,7 @@ int whpx_init_vcpu(CPUState *cpu)
>=20
>         ri =3D get_arm_cp_reginfo(arm_cpu->cp_regs, key);
>         if (ri) {
> -            assert(!(ri->type & ARM_CP_NO_RAW));
> +            assert(!(ri->type & (ARM_CP_NO_RAW | ARM_CP_CONST)));

This chunk is no longer needed after adding the `#ifdef =
SYNC_CONST_ID_REGS` bit above

>             whpx_sreg_match[i].cp_idx =3D sregs_cnt;
>             arm_cpu->cpreg_indexes[sregs_cnt++] =3D =
cpreg_to_kvm_id(key);
>         } else {
> --=20
> 2.55.0.vfs.0.3
>=20


