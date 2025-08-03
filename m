Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5BDC87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 01:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiN9C-0000Oq-JK; Sat, 02 Aug 2025 21:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uiN8g-0000Jo-UI
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:03:54 -0400
Received: from p-east3-cluster7-host7-snip4-6.eps.apple.com ([57.103.84.197]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uiN8f-0008Lq-4l
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:03:50 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id
 C426418000BB; Sun,  3 Aug 2025 01:03:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=nap0o9gwsij1nokzz8SvD9ARpkqiuo1rE/CWSFU758w=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=eWleU6vqPx+mckHPGNhEs2oopooj1lQztLjsenW7GEabC/ZCOOcDrynh/N3sOz5kDcQblCI+cfnHkLS2sY5BMTZ8BZVf4kLRMIi9Oo8Cm505UH/rgT8KC4X5BwzBkoIzXO4viXOkCIsw+1K0RlE+GogMIrehMzqd6GfIohfpgZO7XQW5gjRyFODUsla+d11iog8tPpduHoT82WeVHJZLxh3YOWEDGTcHQV5CFanLwglfO7DwkazdHOGIs67UHoqYrh9eG5j443XBYhM8a8LyxjF73NBI8QHeBiwefxNggyPgye2SGSTdliSLky0C/h2RRg5sGsACg97sf496AxZ/Dg==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id
 5F49918000A1; Sun,  3 Aug 2025 01:03:44 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [PATCH v3 07/14] whpx: add arm64 support
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <b5e787c2-347d-4009-80c4-8ec29c497ddb@linaro.org>
Date: Sun, 3 Aug 2025 03:03:32 +0200
Cc: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EA3D3348-6256-4554-92BD-37ABA1138449@unpredictable.fr>
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
 <20250802081800.76030-8-mohamed@unpredictable.fr>
 <b5e787c2-347d-4009-80c4-8ec29c497ddb@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAzMDAwNCBTYWx0ZWRfX7tZwFfmP7dLt
 /GZy+B5oEk4aEjUd5Us71f88ovdjvwEab0CjE2hZnthLUmcmR8RMpiMrfP253R0EcxbuCBcMy/4
 HQ9O9sjTAzYLK+hNhU4XIdNwNXQ/8OuZ6iLRCJQ1R9WdiT8H96JG9byqAIEDUaNn6bMwpICGSqp
 8qPLfkSDL5RjfyIO/8M72B48NEH54yDgMtbpSzdVcDbEp1wTSB3RH3B3+4JH6ow94Zz2ceSG5+s
 ssbfwJ84t5rIeq27oY3X2QEQF8JlDxPst5Nz4C2WO8uI22KJtzzzfcPxlxCZi/ObtPI9vmMXw=
X-Proofpoint-ORIG-GUID: mP4f18m6FrdfNR4EEr6HZJVK6_0R3b66
X-Proofpoint-GUID: mP4f18m6FrdfNR4EEr6HZJVK6_0R3b66
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-02_01,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 mlxscore=0 clxscore=1030 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508030004
Received-SPF: pass client-ip=57.103.84.197;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 3. Aug 2025, at 02:56, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 8/2/25 18:17, Mohamed Mediouni wrote:
>> +struct whpx_sreg_match {
>> +    WHV_REGISTER_NAME reg;
>> +    uint32_t key;
>> +    bool global;
>> +    uint32_t cp_idx;
>> +};
>> +
>> +static struct whpx_sreg_match whpx_sreg_match[] =3D {
>=20
> const.

cp_idx is constructed at runtime (in whpx_init_vcpu) , so this is not =
constant.

>=20
>> +#ifdef SYNC_NO_RAW_REGS
>> +    /*
>> +     * The registers below are manually synced on init because they =
are
>> +     * marked as NO_RAW. We still list them to make number space =
sync easier.
>> +     */
>> +    { WHvArm64RegisterMidrEl1, WHPX_SYSREG(0, 0, 3, 0, 0) },
>> +    { WHvArm64RegisterMpidrEl1, WHPX_SYSREG(0, 0, 3, 0, 5) },
>> +    { WHvArm64RegisterIdPfr0El1, WHPX_SYSREG(0, 4, 3, 0, 0) },
>> +#endif
>> +    { WHvArm64RegisterIdAa64Pfr1El1, WHPX_SYSREG(0, 4, 3, 0, 1), =
true },
>> +    { WHvArm64RegisterIdAa64Dfr0El1, WHPX_SYSREG(0, 5, 3, 0, 0), =
true },
>> +    { WHvArm64RegisterIdAa64Dfr1El1, WHPX_SYSREG(0, 5, 3, 0, 1), =
true },
>> +    { WHvArm64RegisterIdAa64Isar0El1, WHPX_SYSREG(0, 6, 3, 0, 0), =
true },
>> +    { WHvArm64RegisterIdAa64Isar1El1, WHPX_SYSREG(0, 6, 3, 0, 1), =
true },
>> +#ifdef SYNC_NO_MMFR0
>> +    /* We keep the hardware MMFR0 around. HW limits are there anyway =
*/
>> +    { WHvArm64RegisterIdAa64Mmfr0El1, WHPX_SYSREG(0, 7, 3, 0, 0) },
>> +#endif
>> +    { WHvArm64RegisterIdAa64Mmfr1El1, WHPX_SYSREG(0, 7, 3, 0, 1), =
true },
>> +    { WHvArm64RegisterIdAa64Mmfr2El1, WHPX_SYSREG(0, 7, 3, 0, 2), =
true },
>> +    { WHvArm64RegisterIdAa64Mmfr3El1, WHPX_SYSREG(0, 7, 3, 0, 3), =
true },
>=20
> All of these are id registers.  I can understand reading them once at =
startup, to populate -cpu host, but they need not be synced otherwise.

Will need to sync them once somewhere for targets other than -cpu host, =
but no need to do so for every vCPU (as they=E2=80=99re global values)

>> +static uint64_t whpx_get_gp_reg(CPUState *cpu, int rt)
>> +{
>> +    if (rt >=3D 31) {
>> +        return 0;
>> +    }
>=20
> assert?  Or return 0 for 31 and assert <=3D 32?
>=20
>> +    WHV_REGISTER_NAME reg =3D WHvArm64RegisterX0 + rt;
>> +    WHV_REGISTER_VALUE val;
>> +    whpx_get_reg(cpu, reg, &val);
>> +
>> +    return val.Reg64;
>> +}
>> +
>> +static void whpx_set_gp_reg(CPUState *cpu, int rt, uint64_t val)
>> +{
>> +    if (rt >=3D 31) {
>> +        abort();
>> +    }
>=20
> assert.  Or ignore write to 31 and assert <=3D 32?
>=20
>> +    if (cm) {
>> +        /* We don't cache MMIO regions */
>> +        abort();
>> +        return 0;
>> +    }
>=20
> assert.
>=20
>=20
> r~


