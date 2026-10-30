Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BFA606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EZnYBdn2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IqgxlQx4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMbne-0004oz-T8; Thu, 29 Oct 2026 21:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMbnd-0004nt-GV
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:52:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMbnb-0001kB-Om
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:52:57 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TNKSAm2554046
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 esdXAKd9a+aINhwtGeEfR/Sb8Xl3MO/iJNd6KEnaLqQ=; b=EZnYBdn2a4LdO0Bx
 Ek90MDc06DxF3azla7ZIQXRz2FT2wMyGyB0JnI8nS9/y+lxKYspg/RPfD76jB7N/
 7jx5qDZSzd4olh/uDbGcyqN0xB3Xq73wKN5jTAVXzpfvt9dAz7DZpxCYds5dQlco
 B/Pcxo9IfrpcB+iUe5GFc+MHWfPWOKy5l/5SGxIldhn0anFugbksdb2O98Ii3gUq
 Cz3zqO9RzoNfou8fXZMt7h5OpH+QVj3Ebb/zYovHviWB49jvP/UICogsE8B7A9Av
 khPHwAPbwJkm0uU2hN1NIXuWf7XysJ6YiNq5dqHceIg6AiuGidm/RNSItH9uuvAH
 1ADG+w==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6rgqy2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:52:53 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-7051c542f0cso201182eaf.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 18:52:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793325172; cv=none;
 d=google.com; s=arc-20260327;
 b=AY7tjs+IVlRlKPWKdBHEMdJ9PMhRcafnrbtTBTotJ5DzaxPK+DmDAa54lL7Xz73LFe
 OZ3UjYzB+Z0VScn0AnbYY0GI0AlODkLIdqajuh4fxKuI7xNFQyERBh4APRCq3K0yjxr1
 SZ41TExGDAwpTPfwTrvY3O+ekt9mZo5ZhQBIyNRmP2jzVbG+H/gf9YnCrnfET/jU+kpA
 IJHYhw3Yyka1jq0Z/0EgVsoFy2u8uYYgj3XmBc/VgI8V+8sCrf61VOUOB90xiZsmoiN7
 j1DtdmX2QF/sttb4/93lzpcRMs4I8kJc1GjOwPpCAu3L1Q6VUgyQXQydcxEebwhoy9yN
 7zow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=esdXAKd9a+aINhwtGeEfR/Sb8Xl3MO/iJNd6KEnaLqQ=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=DHCWtbMbNFzL6ZsgczNcB8SkV5kUzrVfc6+6enzU9LkmPylnhuXybvjlQDyBf0hAOP
 hmQtZUxkL/NMD+bh/QFIFMo3H4YgKpgDgRCcWkcTCI7ip3fKPHDwfR78o7NlLqGYBGAU
 4pAkNBMWNqJSu3G7NEtrL5Ap3pNdWgvDn5IIm240hAldRYFI4cqFBGAa+aEhQwwFCHyk
 7yBWcl2bjm5zEkcMMa1qMlp+iIll+lIbGqyYorMabXrWE4hnd8sAqu5Bm73bb6QJjom/
 VAAoz9PEvkgm/HowZOpZkdLo3wC3wZtPWCwEIs9wjbMrOrzU/Fc/UXLWQ+PRlCdEEBlE
 M50g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793325172; x=1793929972; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=esdXAKd9a+aINhwtGeEfR/Sb8Xl3MO/iJNd6KEnaLqQ=;
 b=IqgxlQx48SHF7mqBwk/o/qFG4WQBhcOBJRiCwCpwq/FCy4m/xQXCOuyaPKnzpUh6kP
 LQxA8reTKI770Tkx1DoAJXmxlcEGHtrW1JWRZL5HOcOr5nDfclW4kpCzIwZXZus/0SDD
 b5yvEaiRWPkMmgALzjb14zPLEFYXSFLqNOBnFz/3E0sQA0PZcN33sJp/RPhSKboAny04
 iJl7Oa7r+B9mbc9bpXy7VL9VPY+2lZE7HVz0ntTOvyC3abLkpk8i5IknaRJf3FQJga/m
 BgUbjIVIJCAY60GTxLx/bsnipHbRFIRAvjFxLRTXEwDKoixAMo2DwTSPKcT1HCHAQwPa
 DJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793325172; x=1793929972;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=esdXAKd9a+aINhwtGeEfR/Sb8Xl3MO/iJNd6KEnaLqQ=;
 b=kIuQckUWzZ0Z3xu9QL0hCDrJOk9iG10lukscuFxaYiMgwYeIOqTJd4fVS3DQ8VdIIA
 V62Q8zM3A+3QS2AkFr7594SHudYHO7Nla7Z4EeeXb8XEnIB7H/QJzHqBfctFuf6jO4aU
 9XnYJhLT6/4zPjwqHCVblQRVJcsebIu49ZoT8TrMB2SglJwdSetxuit15DQ0nAHBw0BU
 rEeOjXEYxR4/HdqK6tmKU2hSbu6EPHyrballDzPvWerKIGVvwEEauSKXdmAnlU882DDS
 CpabTxY5yNtnlDqMaVOsjyIOII/Lq/jdEt0BdDKOlmR8CXgZGxzZKMZ/dv/cIWo6NM8s
 PhZQ==
X-Gm-Message-State: AFq9FYKLL+VA+rfG+PwQwjJN0xx3Q/N1HUfdn7juSPAkD3DRCKcyVA37
 uK//NUn4LMGpVQYeX4dfa2E+GehkYVBXAA53VdtiuxOSMqPrI0ouDHSta1uhts6vcMPkrH6hJ8I
 a2GZ4x7NmoGD7gAmdiV0hU0zgFmtcnJNDczVTYz4/kx4TVr+U/0FyMWyeJOE8tkCt08Tenqfh48
 Jsz+jNYAsUv62usLHKxFm2bt6I91lWwABP
X-Gm-Gg: AYBFou1irr0yCzpSdN234DfC+K1jS6iIiOI5/oJ+ud9Ix5QoIdZi19O6EVGxNBUBSBi
 NjtLGHbmy7g7blexRn3WriccSW/Kf+lT/44wSvPcZzGYfv9ZlnKvuvN1RlD0jb0gAC8zhQ43Hhi
 VirW5OXCB9q57rfiFo53+6t1lBrc3w2g55QArqHHaoYTflJ8DCnoCuEIrvuecx/FE6k61lHyAZH
 5LI3TZNsiPV5s8alGM=
X-Received: by 2002:a05:6808:23d3:b0:549:ef3b:1a90 with SMTP id
 5614622812f47-5640dde800cmr748938b6e.54.1793325172452; 
 Thu, 29 Oct 2026 18:52:52 -0700 (PDT)
X-Received: by 2002:a05:6808:23d3:b0:549:ef3b:1a90 with SMTP id
 5614622812f47-5640dde800cmr748928b6e.54.1793325171909; Thu, 29 Oct 2026
 18:52:51 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
 <20261029230310.1632334-8-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029230310.1632334-8-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 20:52:40 -0500
X-Gm-Features: AclHuK-5GofYoLUTHHbbTaAEynVaDuTT3a1Jjixl6-BPw7tHKYWA5c5pLFfFT8w
Message-ID: <CAJ+KCYORj4yzRhejY5LPY0+sU5tg-9bFKy=q6waa02eKH1wiVQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] hw/hexagon: migrate the HMX state
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 0ICM9MYxSME2Gks--qSd3d_FsPx53OSU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwNyBTYWx0ZWRfX125ckXeU/+l9
 0U1pDnStuOaWlSs9YkMZOiEd8o6i5PRz1RknUvr5n2rCOkevlGPHrp/mo7bsY1wzkgZ1deyQTUa
 G+/8zl0+e4TOOc8juV32W4imhoGInE8=
X-Authority-Analysis: v=2.4 cv=PIqaavqC c=1 sm=1 tr=0 ts=6ae3f875 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=oiUj86p4EGMqR00RCskA:9
 a=QEXdDO2ut3YA:10 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwNyBTYWx0ZWRfX+CbQQSQCibmk
 uliAMOkEwp+TBI8Y94RS4+gpPeE9py27CyvwtHAPteYWIfMp/pmgU+7SyPwt4+Io2jh2DYMIRiL
 cLkTgLC5no72PaDBGeaqyMq3AOVdIUvQgou911S/TAdxZfpDJSAjtEvCeLhcg2GYmwS++4rGcvz
 QIuoI150EcVVr8ct3/QE5lePeKKYpfSemyUK5JJwPeZy+1mmSyLyowUyzBRbUJaI9AAm49Uw/g1
 B6r1l2S3Biyu1tYjdz+yk/+HuERnSKhNMtMwoYBSYLx9FRLuCHLhDRA2D0Er4shxWSesy0pqt3D
 /l1AHn/YrrksHcOHmn4KWnQQcW1QZMMV0lAotJunqUj11Me+wCHExJhARJoiZoetCVJonZb6QgQ
 cpJhnYp0YPrhWZnLrnBKLWCq7bqZB7sl5tGkIkXGp102h5CoW81epH54OBJKQ4+spF7qk7HEZaX
 fyFYQEePEaUka6Mk0nQ==
X-Proofpoint-GUID: 0ICM9MYxSME2Gks--qSd3d_FsPx53OSU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300007
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On Thu, Oct 29, 2026 at 6:03=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/hexagon/hexagon_hmx_context.c | 117 +++++++++++++++++++++++++++++++
>  1 file changed, 117 insertions(+)
>
> diff --git a/hw/hexagon/hexagon_hmx_context.c b/hw/hexagon/hexagon_hmx_co=
ntext.c
> index e3ea7b71474..3683bd9d416 100644
> --- a/hw/hexagon/hexagon_hmx_context.c
> +++ b/hw/hexagon/hexagon_hmx_context.c
> @@ -7,6 +7,7 @@
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

