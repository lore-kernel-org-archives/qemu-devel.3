Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A68460A261F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJBQl-0007ce-2h; Tue, 20 Oct 2026 11:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xJBQg-0007cM-OH
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:07:06 -0400
Received: from qs-2003k-snip6-2.eps.apple.com ([2a01:b747:3006:204::69]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xJBQd-0004Ii-AS
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:07:05 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-0 (Postfix) with ESMTPS id
 BE2251800277; Tue, 20 Oct 2026 15:06:56 +0000 (UTC)
X-ICL-RepId: 01a159d9-ecc6-7b99-a969-a2e0680dca9c
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0ISRMFUgddTVYNRw9YHlwUFwlAQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0x7TwVcBykBMxRNcl1yRgZEC0EeLw8udl17PAAodS4HQ3s6AV53HlwASx1XBFQfUxJVHR0LRVUSBEAIVlBUHkEEVhVsCVgGUxlX
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792508818; x=1824044818;
 bh=44GEjnpLGODs7iwf5OF6e73gvcBuvpK8ZOj3jqE624M=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=TkfNdKfBCL98g0T+EkQ/Vagw6OtHtWPFtUzu0ff9h+l8kxPrru6RofTNZUjtYGcBJaW8xc5E7+yIgthKZrpj/V6lhJ8s838hn6DMScHBP0vkLIRNaDe7kLe2+6DoJRqSWCxFWBjgC4XZAz4B4Z1fGIoM7zHh9RLlUMqLcnHf2M/FXzvDFXBr1PQHBCKmmzdM4c7a1gHhRZ1e3EeHgK07spR9B9UkpBT3UI/Jp7cN/RclgcfUeasjX7hTNSW5pU2uMVNgA+FM2/6vPk5rZsKpaGzXNSoFxmMRDR6x8UGaLkbuvyvgl15KCQdc81EydT64ACwbOY67kWUbsyE29O5+XA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-0 (Postfix) with ESMTPSA id
 AF9A518002E0; Tue, 20 Oct 2026 15:06:54 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: iommu recovery follow-up (was Re: KVM/QEMU Community Call 13/10
 agenda items?)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <87wlrc1mie.fsf@draig.linaro.org>
Date: Tue, 20 Oct 2026 17:06:42 +0200
Cc: Demi Marie Obenour <demiobenour@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B7610B3C-5A0E-4429-B8ED-BD3EBE53BB23@unpredictable.fr>
References: <87fqyh79ty.fsf@draig.linaro.org>
 <39ed350d-7324-4bf1-9433-54a0d74855c3@gmail.com>
 <87wlrc1mie.fsf@draig.linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2MCBTYWx0ZWRfXzXsjnJEvPdrJ
 q1syjo5ndc0yZK+uQeIktk4ATgKboEgLnWbYV3Bw1i+HuV1KykT/xq2JC1GQtsGwr130nISPonJ
 pFiEu5yCZ5Z9vv2UgHDKpL2mOp1QBtjEhSvue/cVnIkSzZEzicdtMNhg0hyOddrUxVQwpJnpiLc
 6h49SV0go406ZSVzclf8o14pJji/HS9LQxcdPgLFszJNPdJqMCfBYgfCGCvp/0YNpnvmMj5FoyH
 djENyQIsMrlDGoA/q0ChjGZQAUHj+U02N+nS+I8We9V/EyTkTLU/FZZggddEMRhgQm2qIVvMRE7
 C1cW/xmmTk/fppCy27XnQkGdgNNch4Z5I5Yinl6IM+hLuAtMkWheVAN5T1lhH4=
X-Authority-Info-Out: v=2.4 cv=dNirWeZb c=1 sm=1 tr=0 ts=6ad78392
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=4bqKx-3wjDnND_vGQvwA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: LPGDTF0hPY305ERrcTs_b0cYfGa9Edn1
X-Proofpoint-ORIG-GUID: LPGDTF0hPY305ERrcTs_b0cYfGa9Edn1
X-JNJ: AAAAAAABgEab7R5fcZS9lLLVVm2/fAFOX8QpBBIPkBr9xJwLoVGk9DQ7RLgWhx7sMLTiZncqbv408/bTc3d17Ea4/tQ6ELB6SqUMQL8mE2L9G0nWnyAkmxVRNOBbwuOzixSdR95ibkdOORvRQI4ydZzOyMsHW2KRUxOPCBX/CZLDKzKGY45Mi4NkDPIBsthgya6YvnfmiqKzevRwvY89gQ84mxFU+RXTCZHfyVHVvnxFeJrddqDd9+DpyK/saDxaJpafGxuDXSRifX4wV9w3F1ET3QyskoloF6pMLJ8QmhrwivRE6zUhStnZQkcvhMm9REcwf7hFH+FsNRcSDST2R6Q4QzMM3PpP1VlrLpPyJkMNbe6xGQB2pQtRXF6isAogoj6I8LAzjHKX8kmE+/OYZcKIy+jO7vFe7SQpo4SC6qRXwwVcLUtmd8moVTX/I0z5UkvQbedAL82CrxqlnPopKRKhE8D8fFf6fbkrYg6xl8MBQzPF2jUd1aEU8zVr4vvBABNNOLY+TJvR4k+o5F/JGIwC7mPFLUJEhmgdXOaui0gAI26MhYbEXlhpU7dywZhDfyxZZ3mNBiPQoDj3M52buoKjQXZRh/LSJgIdPGjoLjtX11JLRLaZB0H/Hi0BsAE1CPN5nFN71luuwhqIcJhwXkV5O6Hd7U8+ko5ao5TgGFtg9SOH2ra/gVYf+4rdFA6SdvvV1X+C9+HM7ZVDn6YG/IBDSF4cvsOLVyYBD2vgP2hQFjJvKNPF7QpUOzo2kzrgaalYlA2QBSYixsiqPMsGk4z6iEvRmB33HHFBIh8tA79zyiaOamMxGL5zzyxG4GI0X42C59ZIXlr9PTH5+Jzd8Np8L2U51050oENRS18SryJi8qrgYwE/apR+7Rm0uIxYuamgRyEhYZzvQtB0keYQam9uWZ2xj2R1VcM9NnDSlyFg+fAUMBJ0SjtjDMZwm8JTn4rKeSeKSI6TuJdf9jo5nnefwA8t96l
 x2nsc98zpK17zrEwGGHt2NT/wbhrTyGEzwZVsGXuY0wY+ukoTL41mAwRB8Rm003QrbUBJqIVhFDnOTU+LOh32tXRJTlh+vG2QFxNxsFeM/qAtmgaPiFv9ImyR8OiI0WTP1ExBQNGH9PBaI6RwYC8E1XbwN0M5mNnYr0WeHyN9S7J3JP66xGZYdqjUpbRCzI152Q/UA3ABhW1YjojJ8GZEmof1XrVG2/FqfibMIRhI/z5l3WdA4/lehgGwwu2ZO0OFSjZkUTKeupJsN7sXBwPn6zVFQJ/jGrQgydHGAIaPfZvkIHaZxshNGS5/8/qyuqZn3xqcU38T8LcLfTakEqA9G28CeGaMxDIEzGhtmf4KkGUjSX/lJFw7hBL3C8roWZm4R/mdf3VcCYKcUMNa+r1KgYc9vutLOa+IA2Y1ZyrnpCpxdzGuU4gPa8dIfo107GPwat/Z2rmvl82TuP4DXcAM+CFillU08Ky71jp/WMzG9wlL1LWx3tWG2fKBmFoK1OhLipEcIGHXOhdJNfFiGgNrGKDfcYuoT28P0ze5fqJhW3zorR1is+oyWXhu8y8gMtCDJyPWYZuPA0qMGrWn9KOpvks=
Received-SPF: pass client-ip=2a01:b747:3006:204::69;
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


> On 20. Oct 2026, at 16:20, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
> Demi Marie Obenour <demiobenour@gmail.com> writes:
>=20
>> On 10/7/26 12:29, Alex Benn=C3=A9e wrote:
>=20
> (CC trimmed, IOMMU relevant maintainers added)
>=20
>>>=20
>>> Hi,
>>>=20
>>> The KVM/QEMU community call is at:
>>>=20
> <snip>
>>=20
>> Is this also for topics related to KVM but not necessarily QEMU?
>> If so, and if there will be people who are familiar with device
>> passthrough, I'd like to discuss whether IOMMU faults and KVM MMU
>> faults are recoverable.  There is a virtio device I am working on
>> which requires this to avoid either crashing the guest or allowing
>> the guest to hog host memory.
>=20
> We didn't get to this at the last community call. Is this something =
that
> can be discussed on list first?

It should be I think.

Hi,

For such a virtio device (and granularly exposing it to user contexts =
too), is ATS + PRI
a good choice? Perhaps even using the host page tables directly, with a =
per-process
abstraction as the security boundary.

On physical hardware as intended, outside of the ATS + PRI case, IOMMU =
faults
are expected to be something requiring a device/driver reset. On Arm =
however,
there=E2=80=99s an exception for the stall model, which pre-dates ATS + =
PRI.

A PRI PPR reply of not present isn=E2=80=99t equivalent to an IOMMU =
fault and isn=E2=80=99t expected to
result in a crash resulting in a device reset.

>=20
> --=20
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>=20


