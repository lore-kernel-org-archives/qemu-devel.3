Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF86606A331
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mYmJx3xE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bwW9zCah
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT2Lh-0005pS-1d; Mon, 16 Nov 2026 14:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xT2Lf-0005pF-H9
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 14:26:39 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xT2Ld-0003Yj-Sf
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 14:26:39 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGGI7cU3045205
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 19:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CbCLtOOrJgNEweYyg7H3wpChiSDl0NkIVcoo/HuUwp0=; b=mYmJx3xEnWXkVH0N
 H+ezup0cAOvZ6sj8FUXCCR5Z+MqZkaDWbgzDHJQNYIkfzWxvyQMnSWKki1FV1DTl
 6QWlqvM7BZK1Aj/wp77S0cJ8052tf5zYTayFUm0yCP8sNaU+HXgM4pxj5plfHEnm
 6umQMVABKmB4Dl/u/XfKQhBJ878/eThw6Q4opIuGdZK7fVXUJXX2mh0j4x5aU2hI
 XX5uQqoz0HNpMciudMdhTNq75iIlY/oBvvcxn5v0SlCmgnFqqSpSJaA4BcuPBN0B
 D0GyP6uYME0pKTcx/nQ2tJ3Q4lRc3v5NjrioupllJygihsmLpTRx3p+KmmELP5PC
 AOmRPQ==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j038m9baq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 19:26:34 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-574f8578e48so881119b6e.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 11:26:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794857193; cv=none;
 d=google.com; s=arc-20260327;
 b=aNcHBIA77Ni3iLV3QSZz6qJdR0DUKjJsDWIeWrj6Cmkd9WxHC5n9kPrZm+FdoAovij
 I0wVLRnJd9hf1hvC9324peOdFkcsvhTE6zE/bcHrwb/luIKsiH+Cyp2HPh4aV7f25vhp
 e94tE9nL6dufq7xV7W8Xr1SWdO8i8CqlPHJ3vXnFYOWBRO85cRAnc5BE9FWjc73n52z1
 3a0vc24JxvNeJ6yAG/3AJsGaG5rRhov7aLBP5rnx5ul2CxUZporELDp9GIM+LzSJy/Bw
 /I/7JUGq7+GhiIb/8sMA2d6nSvJSNvcFxac0ePQZI6qXVYULjPD+dXTT4LY8gclCjs3d
 l3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CbCLtOOrJgNEweYyg7H3wpChiSDl0NkIVcoo/HuUwp0=;
 fh=/1lq0lfR1GnA6ZK1FUVPbYmtvfdWCEexdPZ27kjzpc8=;
 b=qtyg+WPKMxXk8YP/j9rgZ3wvdEZQ7g+KltfSPaYEVGFQXq8uuYvbStnjz++4o7bfsZ
 Jl89gl7fpnCClxIJdv2OCI5ZLne5tE5YvffsLXW46eVf6XCB9upCpp2vcNQoyh59BzyE
 WVrkwD6etBfJi2RL9x17nLR+YiMNSBG6O5RU+fZvcw2h8h4rEY46xohf1mNpRby3XLqi
 XLVJsxGq5CATru7tOQCF6V/PuqHekSFXMW8qJgViuwivmM0KhpAukN7bhyfJM5juu0My
 z1xWSW8s4hsD6C1tCIfheudC8ami7BqRJRw+ubm7+O9pM4xs4cSr+jnJRWoKx4HlrPRh
 IjwQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794857193; x=1795461993; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CbCLtOOrJgNEweYyg7H3wpChiSDl0NkIVcoo/HuUwp0=;
 b=bwW9zCahVsPNXiiBC79BTgHElbyk/vD4EDIzC1SYSsq5M95GMqCE+8inKAbUCOj7F/
 kKSt8c7MotTv5aUeOQ3LPZLrM6aL/6V9941umRmoNJtzyxcUkm3bQQ6PHpBBp3VkOVau
 29xGmQQ6V4TisCoGUs4ObCGFIeieKZNLNCfyvv8GkRHIdJPzKgKKgaTi1cUgzWCxzXea
 Ae1phtIyNDq8kHAqjCnDSSbWDKZ7RksAquHXtUeEWK9Z+IO+x3/k3ibJWrZswLfYbLqo
 PaO4rAgnSLu3kCbBxa2GQtgeoA0arhzch5lkBsD4mpBNLzM/0HvMmq8dqCoPPB/wmf2p
 +X6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794857193; x=1795461993;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CbCLtOOrJgNEweYyg7H3wpChiSDl0NkIVcoo/HuUwp0=;
 b=M9r6/NuA1OLOhZWWb0ZU0rOwxWHQMzTRnHjJwmMFnkng2HYQzdVFPRNybn73WgMcSc
 TjQK/0GItnS/+VxRW4YzH5YxT5Li0NtbN8qg0VipkDuWRW1XXfcq9LE0JCxcRpCeJpxB
 YdmXMgybzMFbk5p086q83sPl9rwdOsTQJjER4GeVBbnwbitnDr8LcGiAlEDbAwwyS2/y
 ADaMbyAYeMSL+QjHaygiikQs4gaxUxBQdc2A5brh4og0sHvbpqFa1e4ekerBDSsVOxvr
 Gel4UUsGf23MoC2r89LzUkcgsAQQi9+YGu6WMwRfV44NHT3TYu4jdWdVO1Q67/6CaM7J
 4S+g==
X-Gm-Message-State: APuU4Z8baqO96+MVQvmHkMavZXd+9ROt2jswSv/GwQWD7vuy1mtVRNBy
 N5dFM69NkVkg9ZPr6d6Dp+fVV7YmewBGfI1YGuT6w5J0FW6i9YT6/vJYqUTw9CF3hL9oLzyO9NP
 9JQegXXd0LqfPdlV1Y9aYVRy25jqMrYxaGGy/9wgODUfiNEbEXlzV6BAM5jybcd+w9Vsv5BaSqN
 k8z4DmFDAzdQB4w+ZbGeyBY3iUJLBDrq/U
X-Gm-Gg: AYBFou1xYMaBvCSttQ/d+snqjzXAmFkgR1Om9v56UMQ56ogC2A13i2J5mWH8pZXVeQ2
 3sIvv89MpWAlLHMTXb5dbFJuOTcIu4BEFUPJGS0+r5jtJ1t6aRPI/IWxHJZ+rMc7VBgw25bb0dn
 WYmQnYCMh3cDhgjbm2t8Gj0d1wELkM3ch20QTY467yJJ24sgpXL2/nBLeZ+oRyDRsFeGYWxLdnD
 2NQAXmdR+/kK54qEdY=
X-Received: by 2002:a05:6808:244f:b0:4e9:7d56:846f with SMTP id
 5614622812f47-56e640bc904mr10030519b6e.41.1794857193482; 
 Mon, 16 Nov 2026 11:26:33 -0800 (PST)
X-Received: by 2002:a05:6808:244f:b0:4e9:7d56:846f with SMTP id
 5614622812f47-56e640bc904mr10030494b6e.41.1794857192958; Mon, 16 Nov 2026
 11:26:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112232032.396-1-anjo@rev.ng>
 <20261112232032.396-3-anjo@rev.ng>
In-Reply-To: <20261112232032.396-3-anjo@rev.ng>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:26:21 -0600
X-Gm-Features: AclHuK-X0F-rRguWq5Tho0uXPEFZyV7BD7F4RnK0t5zrOeL6YMYeMa_mKXkpRIs
Message-ID: <CAJ+KCYNwc=JAaKkMTuVTqrRPbT0RY8xWTXoUcawoT9cUDwk=sA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] target/hexagon: HLX, search for .new values in
 pair high register
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, ale@rev.ng, brian.cain@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA3NyBTYWx0ZWRfXywCSqcju7G4r
 m2b0USkPPkREdY675fPlrGW6/iFIShpMWLZoWatC6c401UvpvhakNIw+IkrZ8Laz3UeNSBnSIYX
 1R0DngTLwafaz7Om08CySwnUGuVjWq7dry/hVE4KqqgegOAPpEHyY1ReZKrhi2UOwnUNBxK9flh
 7v5rBJw8DWiqLS8qQd6MPj/UFtLetXy1t649+62xvsaMbdbhqi0z5BZMkB9vjBhWtygupr+ShOl
 JBRvFMR+jrKY/1mp0EfKbqxFH8Vi1a2TAU0xIdSu9UPIv9RfxvImTIs70MSvFTybF0PxbNxB6ix
 phyHEvffl69I6aF/RVRBUwXed2fA1wPZdU3Vt0f+3tz+2SEOh1eymbuVN1qtfrQVK9z7aDWtAlH
 unjpNwtmppScHclte/1OvhVBu+hYV6BoP7wKgshppe5/CeCyVlSat/2hsTRXuXPwZ+Wh5rU12Pv
 nTF++08ApHQPpRfqILg==
X-Authority-Analysis: v=2.4 cv=TckDJhQh c=1 sm=1 tr=0 ts=6afb58ea cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=QuWEBj-B7TH10SFIKpcA:9
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-ORIG-GUID: zdu_L7WFJX9_yvh6lQwuXZTzMhltelAK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA3NyBTYWx0ZWRfX8/nGG4jkc60j
 2foSlQdby9pWHENGbrqxCw6J+YZTcMWwEPmaM7kYNyhCDYfRfFOF55D2KhtXRVh1M6aBbIM5tWt
 0ve7gbz0xnR8VD8ptyM4fuzpF+T3CtA=
X-Proofpoint-GUID: zdu_L7WFJX9_yvh6lQwuXZTzMhltelAK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160077
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Thu, Nov 12, 2026 at 5:16=E2=80=AFPM Anton Johansson <anjo@rev.ng> wrote=
:
>
> Otherwise, the following packet
>
>   {
>       L7:6 =3D combine(L0, L2)
>       mem(R7) =3D L7.new
>   }
>
> results in mem(R7) being zero-initialized, compared to L6.new which
> would correctly write the lower bytes of the pair.
>
> Compared to scalar and HVX .new instructions, HLX encodes the register
> number rather than an offset to the producing instruction + an odd/even
> bit.  In order to find possible producers which write to register pairs
> without the odd/even bit, a Instruction::has_pair_dest field is added
> for scalar, HVX, and HLX registers.
>
> Lastly, we move the new-regno patching in decode_fill_newvalue_regno()
> to the non-HLX scalar path to avoid overwriting the consumer L7 with the
> base register L6 of the producer destination L7:6.  This is safe as the
> patching is only required for replacing the scalar offset+odd/even
> bit with the actual producer.
>
> Fixes: ef81d1b047337e81 ("target/hexagon: decode HLX packets and add load=
 and store")
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/hexagon/insn.h               |  1 +
>  target/hexagon/decode.c             | 29 +++++++++++++++++++-----
>  tests/tcg/hexagon/hlx_assign_conv.c | 35 +++++++++++++++++++++++++++++
>  target/hexagon/gen_trans_funcs.py   |  5 +++++
>  target/hexagon/hex_common.py        |  2 ++
>  5 files changed, 66 insertions(+), 6 deletions(-)
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

