Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C955F36B96
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 23:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAyxa-0000wI-28; Thu, 09 Apr 2026 19:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAyxY-0000w9-HJ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 19:38:52 -0400
Received: from qs-2001i-snip4-7.eps.apple.com ([57.103.87.90]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAyxU-0000v8-UW
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 19:38:52 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPS id
 B1BC9180012F; Thu, 09 Apr 2026 23:38:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775777926; x=1778369926;
 bh=sYzgcaxgnfSQ7nePGqekNNZhBZIcTyPKqzV35Bjs2LQ=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=DsFA4F3T8Xeqy/gLipdZO++XfW/7ov1s+ZwVW508Rc4NNt0em20m3Od6L3jkU0cPmqjy53Ub+zeTyBk1lvVArcb+fNTTsG9eP6gcUcgetZpgH/2MniHrAW+VXqbSDWekBbnkdjVAbkcn0ms1V+Ol7Jgj8T410QAf/Dl120fRyhd2TsnXTP9ZmODj0Q2GtdZbzCU21iu2fYVY90fICkCuLPwS59OqMn2T+wvVGW8/zZQEc7bdZMufySmGYkjptC6Lqa84OU7wp0hkREZd/l1UBlwQoYd5PibYTlRYokluUnH79C3aVR6dq158YU4yx8rG33eh2dBXM3FMLShSuj95eg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPSA id
 40E5F18000AB; Thu, 09 Apr 2026 23:38:44 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 1/1] target/i386/mshv: fix read/write memory across the
 page boundary
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260409175334.181249-2-dblanzeanu@linux.microsoft.com>
Date: Fri, 10 Apr 2026 01:38:32 +0200
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5076BC48-D356-45E5-8431-B660F2C22059@unpredictable.fr>
References: <20260409175334.181249-1-dblanzeanu@linux.microsoft.com>
 <20260409175334.181249-2-dblanzeanu@linux.microsoft.com>
To: =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIxOCBTYWx0ZWRfXwRfkLy54/Sy0
 Or0VB8yBnQeeNd80d5AghiFR6sbDj5uC7/P+jpjhosr1erx31DMwe/BAfFzJ2FB4z1rx3h43hqO
 X6MZ5xfaI4sEJB5L6eGOPknqZ+gRwphctPf2vxQ8hmY+IpcU9eei1LYhjdpNtR3gp0Uo9mWdXFb
 mSxFcPKJ9TMuxCNfGMmZ0ff4rzDkqxQYvDcd4MAmKJvjYNj1ssZc0eOQWFomTrpcRWEU+0Yt8yh
 0g2UZqxgBvHJj19kxMCcaUWbSXWE6zS1eoeP1d3Hb/vz2X0wOx47gI0rnRPrddM0o7t0gaLyiPh
 xO5vV39jQgAzRDlKnXgusCV5ZCGYQB4AUdRk/ml+5L3l+u+eJcifsuLdO861Gk=
X-Authority-Info-Out: v=2.4 cv=cODtc1eN c=1 sm=1 tr=0 ts=69d83886
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=dCQT-B8v4ZhGZR95z3cA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mGeSjGiUchr2ZQvupV026MbcTlCLOCtv
X-Proofpoint-ORIG-GUID: mGeSjGiUchr2ZQvupV026MbcTlCLOCtv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604090218
Received-SPF: pass client-ip=57.103.87.90;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



> On 9. Apr 2026, at 19:53, Doru Bl=C3=A2nzeanu =
<dblanzeanu@linux.microsoft.com> wrote:
>=20
> Previously, read_memory and write_memory performed a single GVA-to-GPA
> translation for the entire buffer. If the buffer spanned a page
> boundary, the translated GPA was only valid for the first page, =
causing
> incorrect reads/writes for the remainder.
>=20
> Fix both functions to loop over pages, translating and accessing each
> page-aligned chunk separately.
>=20
> Signed-off-by: Doru Bl=C3=A2nzeanu <dblanzeanu@linux.microsoft.com>

Hi,

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

> ---
> target/i386/mshv/mshv-cpu.c | 71 +++++++++++++++++++++++++++----------
> 1 file changed, 52 insertions(+), 19 deletions(-)
>=20
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 2bc978deb2..afdb6b6e29 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -1316,21 +1316,38 @@ static int read_memory(const CPUState *cpu, =
uint64_t initial_gva,
> {
>     int ret;
>     uint64_t gpa, flags;
> -
> -    if (gva =3D=3D initial_gva) {
> -        gpa =3D initial_gpa;
> -    } else {
> -        flags =3D HV_TRANSLATE_GVA_VALIDATE_READ;
> -        ret =3D translate_gva(cpu, gva, &gpa, flags);
> -        if (ret < 0) {
> -            return -1;
> +    uint64_t cur_gva =3D gva;
> +    size_t page_left, chunk;
> +    uint8_t *cur_data =3D data;
> +
> +    /*
> +     * If the read spans multiple pages,
> +     * we need to translate and read each page separately
> +     */
> +    while (len > 0) {
> +        page_left =3D HV_HYP_PAGE_SIZE - (cur_gva & (HV_HYP_PAGE_SIZE =
- 1));
> +        chunk =3D MIN(len, page_left);
> +
> +        if (cur_gva =3D=3D initial_gva) {
> +            gpa =3D initial_gpa;
> +        } else {
> +            flags =3D HV_TRANSLATE_GVA_VALIDATE_READ;
> +            ret =3D translate_gva(cpu, cur_gva, &gpa, flags);
> +            if (ret < 0) {
> +                return -1;
> +            }
>         }
>=20
> -        ret =3D mshv_guest_mem_read(gpa, data, len, false, false);
> +        ret =3D mshv_guest_mem_read(gpa, cur_data, chunk,
> +                                  false, false);
>         if (ret < 0) {
>             error_report("failed to read guest mem");
>             return -1;
>         }
> +
> +        cur_gva +=3D chunk;
> +        cur_data +=3D chunk;
> +        len -=3D chunk;
>     }
>=20
>     return 0;
> @@ -1341,18 +1358,34 @@ static int write_memory(const CPUState *cpu, =
uint64_t gva, const uint8_t *data,
> {
>     int ret;
>     uint64_t gpa, flags;
> +    uint64_t cur_gva =3D gva;
> +    size_t page_left, chunk;
> +    const uint8_t *cur_data =3D data;
> +
> +    /*
> +     * If the write spans multiple pages,
> +     * we need to translate and write each page separately
> +     */
> +    while (len > 0) {
> +        page_left =3D HV_HYP_PAGE_SIZE - (cur_gva & (HV_HYP_PAGE_SIZE =
- 1));
> +        chunk =3D MIN(len, page_left);
> +
> +        flags =3D HV_TRANSLATE_GVA_VALIDATE_WRITE;
> +        ret =3D translate_gva(cpu, cur_gva, &gpa, flags);
> +        if (ret < 0) {
> +            error_report("failed to translate gva to gpa");
> +            return -1;
> +        }
>=20
> -    flags =3D HV_TRANSLATE_GVA_VALIDATE_WRITE;
> -    ret =3D translate_gva(cpu, gva, &gpa, flags);
> -    if (ret < 0) {
> -        error_report("failed to translate gva to gpa");
> -        return -1;
> -    }
> +        ret =3D mshv_guest_mem_write(gpa, cur_data, chunk, false);
> +        if (ret !=3D MEMTX_OK) {
> +            error_report("failed to write to mmio");
> +            return -1;
> +        }
>=20
> -    ret =3D mshv_guest_mem_write(gpa, data, len, false);
> -    if (ret !=3D MEMTX_OK) {
> -        error_report("failed to write to mmio");
> -        return -1;
> +        cur_gva +=3D chunk;
> +        cur_data +=3D chunk;
> +        len -=3D chunk;
>     }
>=20
>     return 0;
> --=20
> 2.53.0
>=20
>=20


