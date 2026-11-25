Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4FC606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=od8vt3EL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWE05-0008Jz-9A; Wed, 25 Nov 2026 09:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWE01-0008JI-Kk
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 09:29:30 -0500
Received: from qs-2007a-snip6-11.eps.apple.com ([2a01:b747:3006:203::d]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWDzz-0006lR-Hy
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 09:29:29 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-9 (Postfix) with ESMTPS id
 BA6BC18000BD; Wed, 25 Nov 2026 14:29:21 +0000 (UTC)
X-ICL-RepId: 01a2131c-7459-7a03-897b-bad6b3be76da
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1795616962; x=1827152962;
 bh=KfIy8R907eHvarSGDbafb4likVhfl4xinGQBmyzn8Qc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=od8vt3ELjDtUy9dPFFh3glEZqcStL5Wa01ntzGlBtAqiMFPZlBdseidqsB2jqniHOvr9+nOMd0DaRrrdqVs7OGcJ08Bqerior5a6UUsy+dwZftRBjnGWa2ZGnncgwzFW6aJV9JMk9l6U9Am8YKxCEYk0+421yiQBX442BnG6e8L4fqEtKFzk+ZJhGQ9z6PluwfqIBoCjU6ZSV5fxC2AT0npsmccUhLo1HyfGA8dMQSkM9xH5+e0oF/G2d6k6Mv3JXdQEs6znX1VcVsRGXo9oCBP1aY0caY/Tsp3XQ8ZX9i8TT4mmW/iGz9jxfv2kOJJshr0+UjcH2YNQbTrKxogpXQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-9 (Postfix) with ESMTPSA id
 8E65D1800153; Wed, 25 Nov 2026 14:29:20 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH] accel/mshv: mark VGA mem as dirty in mshv_log_sync
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20261125131114.49490-1-magnuskulke@linux.microsoft.com>
Date: Wed, 25 Nov 2026 15:29:08 +0100
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Wei Liu <liuwe@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <47BB5DB2-727F-4232-AA01-0B7F0BAE99A8@unpredictable.fr>
References: <20261125131114.49490-1-magnuskulke@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-GUID: 6vmyG5QJAgPX3nKewO3x1UwRU67vzQWs
X-Proofpoint-ORIG-GUID: 6vmyG5QJAgPX3nKewO3x1UwRU67vzQWs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1NyBTYWx0ZWRfX2xZDc+Mm8JA0
 aOS74d6qbG/2fm4MMCfW0pjgorPVXP5OkP71PXQeINzzGD0MAPrk9dOkLbszYqEfiK2bJXPjLbc
 iINdZnja1EUccfjgT0s+S2IhAHTzuiPEccAky0l7HrBcfq9RGYKt/0vl7DnCCPC5vJoHfrtj1nJ
 l1UVLkcP0aQ+2XuCNUCpNTNAyhbGcXiST8opST/eRr1KUkQaUt8n0yxN1oE9iFEhkVUKOVCPbHX
 csSMU9isFRM3f5Bt2qUP2ocYP0death4Mxk/8O1K9pbDK8Dx9Rnhco1zSNi9F19r/zhATqrx/+n
 +YcJtL+1tFoCF3No3cYTtX2h8/dLk4JWUezzvVFWsf79RWnuHO8cD+huT60LCU=
X-Authority-Info-Out: v=2.4 cv=JYEpPkKV c=1 sm=1 tr=0 ts=6b06f0c1
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=c8vfPlyRl1mTKFn8zNL0:22 a=Ov8Tim2OtLt7Q1VHhWno:22
 a=yMhMjlubAAAA:8 a=INBVDpUBafKRtQQbavUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1NyBTYWx0ZWRfX07g9gvzalbd5
 oekxAGCD0291Zr51x7evJuGALxg64JL6Qu3PeNuqq4XxUgaz1M5e/E0qIitkzsfZdGjIGlUenlU
 IT8SwCjwGr8dwiXTuJBHonNv36fHg/I=
X-JNJ: AAAAAAABtyzj0PsjPtUr/e+W6VoJOQDSsyELUTQXIK86gxQQ2V8cSbwB5uJ0AsyZUF0sRu
 fbzZsAbRcPocDt8f8FrkiwpP4BYIoIVZZ5qY4hQFVCTOyTBoy9fkB4BIi+YpogiQJOCtCz
 1FVj3Qb91zBSzBUiCjbzUGakfoIYKHO35rzyh2sioF/4Sqrr0prMNE4vbSriLV0I3E/u+1
 qROOEAWx3dB/NoYcR0iyRP7TRjX6B9hZ4sebQO1c+Phsei1fR/XzXr3vyyeQbbiQ8O0/8U
 u8CAajMkCUeaDE98gVeijBv4JHXbyJjslFyJ90hZSfvU7lP6p1NTiAF5TiwVIAclSayh5D
 ZZnVkYd7fYDFOiC5rn+stycL8zDHKqrWMvllKGdGWzIcsfUyVPrPzWJavlPn8lpxvdTijZ
 F38waStY0VAKj+lk7xCJqolC8UecCZpN5ygzbwn9KhXYDTKYZqnkawGnbYPcgvhLREz8Qn
 grwCZuecmP4bSwR1YIYs5hbxLndjNtyYVfRRvbE0Uvjh7hpeBwqLx5lxwleiYKw0Y4ESHo
 r6Juq/b3XmD0ksuc38Dg+3TiIR0N0EY/VNRTVleS3gWuGh53Hw607hmMzIgflaSrxERXZp
 RVXuUZUSCnpBcKpWF7qdRnVSRXVe/EUaCljgNdSJcEvPQIBsK3o79sqqJ257OVz5FXrBqS
 5FtCLefQ5Cir2opBl6QpdclV9LA8awzKxgLxgAk4jlp3zIBgKJKxKGVJOWowz96kCvR66e
 ac7fEAMO3kodLRzP3wrR6fKF14gy+9Rceln9lNqr1USS/QLNPk42/Ae0V4pQ5d46Jyjksa
 6TPV3sBqCQRnJYBijjNpE1x0QgqA2R4ElEdXPA4iwWDCQBCf3810iX+TgCNtOVRC6e7mN3
 OAk9T0M0XjG7p9fAPeLR7WVvU/TAfYKfeGt6y0tOIyVMVwd67GBqh2DL1cXIMauQu7PUAh
 6V76cykmfBOidYJB2Ue8VUGJHNcdwah6vV1kFg1g6E1dVASPlq/4qy8mIR8SsQaf2wvmLQ
 JtaF2pw+xgyRWndzYN03vaKGFsCnpNK8LdIh/O3ib1XNQS9bw5eF3jD2zu5isRgOKTqozL
 cZ1ClqxR1MzgZMp3RThb7VuAhjpUwX0RWKUd9xRCluAkiFa5p7MdcUr+cSVFgnUFvFRQ4d
 4CIwbYMaJpliV/+VmAw38Hss8HENI/iVZFp1r7/TrvIguLfmK6mMSahwowsG/TuyLy5s78
 UboMHWj1GRAABtan/6UjxE1i2QKYgkVNrFab3MvhiWQMoGQZPhQUkEed+foZFt0T75nBhv
 1qOHUjDEoAtdMUWix8xXEAV5cq/ystoeAZAiwZaV1swzv/piBG2m6jH5xkJo4aPSq3JT7I
 VSQ/u3vSX8c/8yyaXyJ/akM5fS+gqKv6ZwwZCmEjPiSXc90iDXchu8pE+baXTB3T9huhqq
 2D75Iy9iDIOcFxVLgvXzfAX1U6zg==
Received-SPF: pass client-ip=2a01:b747:3006:203::d;
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



> On 25. Nov 2026, at 14:11, Magnus Kulke =
<magnuskulke@linux.microsoft.com> wrote:
>=20
> The accelerator needs to report changed video memory for the VGA =
display
> update (e.g. for a VNC backend). We currently report the full section =
as
> dirty. MSHV enables hypervisor dirty tracking only during migration, =
so
> a VGA-only refresh is not able to query that bitmap.
>=20
> During migrations we will use the migration dirty-log.

Hi,

Is there a blocker to having granular dirty tracking only for the VGA =
frame buffer area
as always-on?

>=20
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
> accel/mshv/mem.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>=20
> diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
> index 00d69fca8d..98db7bf117 100644
> --- a/accel/mshv/mem.c
> +++ b/accel/mshv/mem.c
> @@ -428,11 +428,24 @@ void mshv_log_sync(MemoryListener *listener, =
MemoryRegionSection *section)
>     ram_addr_t ram_addr;
>     int ret;
>     MemoryRegion *mr =3D section->mr;
> +    bool vga_logging, migration_logging;
>=20
>     if (!memory_region_is_ram(mr) || memory_region_is_rom(mr)) {
>         return;
>     }
>=20
> +    /* mark VGA always dirty, but keep bitmap tracking during =
migration */
> +    vga_logging =3D memory_region_get_dirty_log_mask(mr) & =
BIT(DIRTY_MEMORY_VGA);
> +    migration_logging =3D memory_region_get_dirty_log_mask(mr) &
> +                        BIT(DIRTY_MEMORY_MIGRATION);
> +    if (vga_logging && !migration_logging) {
> +        mr_offset =3D section->offset_within_region;
> +        size =3D int128_get64(section->size);
> +
> +        memory_region_set_dirty(mr, mr_offset, size);
> +        return;
> +    }
> +
>     size =3D align_section(section, &start_addr);
>     if (!size) {
>         return;
> --=20
> 2.34.1
>=20
>=20


