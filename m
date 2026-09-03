Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24213C624D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x21yt-0005QA-Ga; Thu, 03 Sep 2026 03:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x21yr-0005Pt-Ie
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 03:35:29 -0400
Received: from qs-2007b-snip6-11.eps.apple.com ([2a01:b747:3006:203::17]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x21yl-00039j-GE
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 03:35:25 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-3 (Postfix) with ESMTPS id
 709971800163; Thu, 03 Sep 2026 07:35:20 +0000 (UTC)
X-ICL-RepId: 01a06631-93f4-78bc-8327-4b9fa9b3f474
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0LWFsIWwQPH0wMUQJCBVZeSAsdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDjN4SwIvcl8HXXtMCygaXwdJfVVxVXMvH0MATwMrDi8HNH05ci1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1788420921; x=1791012921;
 bh=hb6lgKHt6iLbL3VM5uPPgEU+WK+XvtHYF5ZpO9O7Fuo=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=aYWYEI9HNjz+2v+vkwGmykfmRPjLtkne9rlORP2x8+DElEusz2USINf7TduT4HKZhKfKTBLzu9bJIMP24wkgIRHOLVTiSX3R2e/VUlNLyuGtkbSGB60jKwsdN7Xkcfx3tBKLsqopiRAmKJQxoPo42Yn9LhnmsaH5EXpYwWDOsUDVyxOoDDI4ruE6qZSg+AhtGo8dUxUa5cjV2/SrcntWV8Gvt8l6khFP0+UP22C7R+VH78fDcV69vbVg8V7rMK4fIcsyskk8RywGM/4XsYqWSccstdKwZWonY4zufo1Aq155hgE6k5qKxVFPa9hakIreIxfBu9Jg0AY7UWhzAILVYA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-3 (Postfix) with ESMTPSA id
 A6D311800170; Thu, 03 Sep 2026 07:35:19 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: WHPX: stale page-table shadow after delivered #PF stalls macOS
 guests; VP recreation bugchecks the host
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <tencent_1D76D0E3949EA74891E11E5572119CDE2E07@qq.com>
Date: Thu, 3 Sep 2026 09:35:07 +0200
Cc: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CA31BE45-B48E-459D-B8DD-3970F9D5DDAA@unpredictable.fr>
References: <tencent_1D76D0E3949EA74891E11E5572119CDE2E07@qq.com>
To: Jiajun Liang <3138947285@qq.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Proofpoint-GUID: JHk-7FXryk13g_UZCjRforkviWID-Nju
X-Proofpoint-ORIG-GUID: JHk-7FXryk13g_UZCjRforkviWID-Nju
X-Authority-Info-Out: v=2.4 cv=IfeKmGqa c=1 sm=1 tr=0 ts=6a992338
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=dZbOZ2KzAAAA:8
 a=UU-FT-e5E98bwe7asIAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA2NiBTYWx0ZWRfX8NhNKtbXFMIQ
 w1F1veqVENQavPKGv/IDyojaLXfr8UwH6bQ2ZMWdIAp96X3wkURfWx4RKn4k+NBQaFTS+56KaPo
 6odr59TvV2UUgItFTL04tgvWAGmSAQQvo8TKNlChVAEMhBTozZMA64PRUC+MBiJ19YK3MYBguIa
 FgWJ+cM8M1hd8g3qJB13V/5e2q1Jo9gP7KL0hOkLyCL0vl+MlrPaB3OL1zsa8jK2gK+AQC4Or17
 NQvHo96/sX3QwuEZu1pOa2Lbgatyunzk6f1GgzA6iSlQ88LpevthkNZ7qhEKtBHtXs7zCutj2Ej
 emiEB9LNGYxqP1K1Wqp+g7vfeoEVUvu746if02VnvlmjOefSokYqhbSRhDsyX4=
X-JNJ: AAAAAAABrhgr7dyiGnvgsQxWnWoiJl+oSzkKiHkGlNU1F1s1AIYFtVaXMO1GvyK2NRZo+xoTx8V9ZREKTLiUPW5Odc3ja7IDO+hPXERM3YhwFC5EnqD7TPKfxrW65FR7o+SxFioRHpmMfwS9GlbKzvmdqyN0qhFCx+GcTUIlvtwDbLFUUZVEbt24ebQcnnfJVb0DBfuJzltQwKmIJHaNLIUQjSxfBcZPWUXaHiqhOM4J/G8CjLdKebPEo8VEdhonE0GeEmHY/qtJJ68ERwizMeIGPvUXIOi32bBHkGVxdn25FGktTUa5AYDmKw2oiiu/u7dMfnQabbx3AWQtBQslKwS9J0LmX07B+cBHY3CYYJRccbGNrFB6LBWxYYEcUcbC6LeE3S+f1e/Nqj4900qVpB1IZjHkiiSjtFuPSwveetwtMpGIwo37s8BC/qA3RoH0bUmicptRpM0jx+YxTQRjr2U8eiKIAUAxHFnjLT8pwrwBXJhFTzZHbZA2XOyPP+KMmPjdNFnFbpCwVJEVzihRmwc22Fuo4hE2DPrRxbBbwwsWx6sGRPTfvydRxos6XIkx2EjeMUjfr3lOFgX/aO9MYt0d1hTFL0fEW1D1VrYYQrGNg2W8enBqTjBt0zRECiBpX7xOjm25GKvIAt3OYUcPMLia6yVRvC+UhISmnf9+xJwZQ5prFpRugRUKd3AzZzNUi/HXm9XuAKnT4EvmKI3fL/IjcN9vk8IHGCfS37kPvzWMFp5o8iQZHjtYIZeaoGJoeOKXFMrcuZEcnPT/VJV2nUVIR6pjvjJSEJ/JP15Zwjct4LokanUXMrMNL6u1XUa1pgdNOfoHqFLuTC38s2rsPa3rszxFe4M4WYsS8XwAKN+psetTiaaAQfZ8+jsSSciDnT8cL+lOIWn8Np1cAILbcy8naySB6M9sL4Ma8KTHo6PAejU3bnlgJOlY6jW4XnCP/BGykXT3A+ZNBtJHcyT+Xc6TmZq7k29
 KIhKRCe0lRY5FtGnmpV2Q/P7/6aePYkiN6cKHPvMUS7UEGXZGx+iakQeDuOWTNa38OkpuKmcmEpjBLxQY46SPEX1TTql+Adxmd4rijIk2/PwUGEYIdFUT3LC0/lifa2zpMrlyqBb7VVgApJ5M/o4GrnKzWLpKWjbDU/HOK9ZgFItcUHoFodNy1rCxToVJ7b1/Pn3Rqzw1RY7a5ulwiKWgfIDjm/VuYlVpUyvcFdUHjmUa0lNQnOVxbuKmT3plfKBRPXB360+TheNJiMxQuypRn5daREnKBxzlAQvESFJe8NMKUT3Fl42QD2/bL4OiO1HuIz7FjiHVOrndJwPvPr0yCDAs5a2mxhrI9Q0JKZo+rVtZHmfH2vKznKVnCAKokhBjy6RdniisXZVG0rg8tXXC4uI3jTbMwWN8lpVJNgfQ8KHGcOGXSaajjBoynB7thvrB26JuyndkDXieaG0=
Received-SPF: pass client-ip=2a01:b747:3006:203::17;
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



> On 2. Sep 2026, at 23:46, Jiajun Liang <3138947285@qq.com> wrote:
>=20
> Hi Mohamed,
>=20
> While running an unmodified x86_64 macOS 13 guest on QEMU 11.0.50/WHPX =
(Windows 11, AMD Ryzen 7 9700X), we hit a reproducible shadow page-table =
staleness: after a #PF is delivered and the guest installs the mapping =
(host-side walk shows the PDPTE present, e.g. 0x1f56c6027), =
WHvRunVirtualProcessor keeps faulting on the same address forever. =
Same-value CR3 writes, PCD-toggled CR3 writes, and host-side page-table =
repair do not refresh it. The guest loops 15-20 minutes during early =
boot (kext-load memcpy into freshly mapped kalloc pages).

Hi,

I looked at your #PF trap and re-inject path and unfortunately the cost =
of adding a vmexit
on each #PF is way too expensive for general purpose use. It slows down =
the hypervisor a lot.

It=E2=80=99d be quite nice if you posted your patches upstream with a =
DCO if you can too.

However a side note: was AI assistance involved in generating those =
patches?

For non-modifiable state, the Hyper-V way to reset it is =
WHvResetPartition. You might want to
test it with a single-core VM and syncing back the full state =
afterwards.

However we don=E2=80=99t have full state sync yet so here be dragons if =
you tried to use that=E2=80=A6

Also a note that Hyper-V uses EPT, so there=E2=80=99s no shadow page =
table maintained for the guest.

>=20
> Trying WHvDeleteVirtualProcessor + WHvCreateVirtualProcessor =
(registers saved/restored) instead bugchecks the HOST: 0x00020001 =
HYPERVISOR_ERROR, params (0x11, 0x3578c0, 0x1005, 0xffffe70000c04dc0) - =
reproduced twice, minidumps 090326-10984-01.dmp / 090326-9484-01.dmp.

Can you upload those minidumps somewhere? It=E2=80=99s yet another =
crashing the host case but that=E2=80=99s never supposed to happen.

>=20
> Full report: https://gitlab.com/qemu-project/qemu/-/work_items/4385 =
(notes 3778137598 and 3778146512).
>=20
> Any pointer on how a WHPX consumer is supposed to refresh the shadow =
after guest page-table updates would be much appreciated.

I don=E2=80=99t think there=E2=80=99s such an issue here, but =
https://github.com/steelbrain/qemu-reims-vgpu/pull/3/changes/0bc11ef4cadd6=
c25c4814ea07c594caa1e855170 is definitely intriguing=E2=80=A6

> the hypervisor delivers them to the guest only when the guest's fault =
path is mapped

What do you think is actually happening there? I should maybe look a bit =
more into macOS
guests, it=E2=80=99s not a scenario I=E2=80=99ve tried.

And which CPU are you testing this on? Does it happen to be an AMD part =
instead of Intel?

Things that I=E2=80=99ll take are trapping the CPUID leaf 4 for now.

Thank you,

>=20
> Thanks!
> Jiajun Liang


