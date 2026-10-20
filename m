Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED95606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hk5/HNjJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ajyc34Yy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJBom-0004mo-5W; Tue, 20 Oct 2026 11:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJBok-0004mG-EN
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:31:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJBoi-0006kY-Jw
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:31:58 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KDA4jI1575152
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 15:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s+1oVBLYzf6jl8kU/wtHbcH6EbDgKV9TlUHTmLp3lgc=; b=hk5/HNjJC0baP4GC
 M+09oqHCu9weizXwV3Dfpz4/ywQyxz0KL+MQQ3lr8QUdXCRm+ON2F+fgxzX92Moj
 am6UET9YnIO4kiR95ldnaeC5fvbUSi/uY+zrLp6yQwNIjlVd41ToW4pVkZyWPrro
 93IQkf/CGuZgCN6cNAB3nai7KpvDruUWCTEKQJDOD5s9pMnHbb1lyHRiHDFDLp0a
 AuoAvOdbDPJYs8rzwn7blcCbCWY6wKr5oViasN+OCYPxehWMbdxrxJGhDgp0TV4C
 BfCQ8aGPQVKDyqdPltV2KJMstw54XOa6N9YHfQbhXs2KGzsKPRYURu4eGR0Mhhk0
 RPQdQw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n35f6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 15:31:54 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-84478a97bfbso5432193a34.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 08:31:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792510314; cv=none;
 d=google.com; s=arc-20260327;
 b=X4OmBU8/Nm2mIw4gcEK23m61d8qaA8Kr1vrcTzzkb6BOnEqJLCt2ts/cKzFZfoWcFA
 5heGA9lPLNBNVJlNCEqASmy3FzINeBCoEM5NAJiary0cPUqYeku69EBbh/2+wGLw1NUV
 T7e+b8z6m6IpXQLUmEsgftTb1d2mptC6c6PTOqMw5NZo7QolfBDc/KL9x74t15XT13Zf
 Q1zodgpQ3TwRsyfWyYc2LDxFhNajBGetSsnAmrHCU//uCuoyTKQ4ycmuUD5gZRO22rIT
 WM29qjzbsHcU/IRLX/PeG6V8gHF5g35h3gw1vGksKzrnCl/PPUKOxZNgu9xL83CT7z+F
 Ioew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=s+1oVBLYzf6jl8kU/wtHbcH6EbDgKV9TlUHTmLp3lgc=;
 fh=DkbXE4ccMsTX7HmhBC7cW9zKYDAyLxQ+nKGU9uhWHTg=;
 b=A3uUG9i//m80zvHz2h8gHlzkmTMmgbqTUVll6IDlWOlAXnWwwoN1tVDQfFuhcKM+vX
 0au7KerDhJCUr+8jRYH4rM1kPs3SMb+oUOJNYSrKUaqVamcLpjyXUncidsEysx2LRUIa
 xJbGFtIoe6eSikByN+W/GV1TlYYMgUqkSRwMt/TPgYg2MoJkuHrth8N2gkTVeysuhIst
 tpy9Dqq+jvozUhykokUrvn33miRdOJb0vAGyxDJ2fpGGF0YgVgQ9V/FZOwlRyfHKKo3t
 ScwAwJtVnHBILwZgF+NuXq74/t6xDJ0nzzJe3z3rBWCHRLZCEWw6Ix7yNkSc0p8lkbXC
 4vXw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792510314; x=1793115114; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s+1oVBLYzf6jl8kU/wtHbcH6EbDgKV9TlUHTmLp3lgc=;
 b=Ajyc34YykaIIMR7BUx3JAB14Za7mLWPFUx5O1McNAX/TvPfobY3LmZLXjMnH1ZJvM3
 EW9+NyPhIj5m2UNrHh7z0nlqxY3nMJj59vcUQJ0pHlm1ccTUogiuwYAzDWu+gh3ihymL
 lC3nuCq71vk0P9u5chh1wonAXVbgemJTaxZkYUqeVMobsRWm2W9A3N8lyxzVhJHgfWNI
 EMFvCEXpm3wEetexJ4XP80+BNY1Hh5HimDafG/NGftBiOJqlHnlFnjaLNXT7xQnOGCBm
 kHaDYNbGNGUEzgQyzzvVWeEYujPFaPXO0ZlzqwzIDznR5QoFEZ7J/zx+/pkbdO4pk6ie
 aAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792510314; x=1793115114;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s+1oVBLYzf6jl8kU/wtHbcH6EbDgKV9TlUHTmLp3lgc=;
 b=JvqlU5CEs79fDMxAgEyaBqnFcGvYT73ySbepaaEVLV5jXZ37VC2EL9EJPQw2XnegHm
 Nhaajg4KlcF2H6ZAykYzsaHO/j5wBuf0JD8xVkaE4wJVIhgyFLzjqzsgauQkFE/ILx8+
 MErMEL0XBIUsVgMbwFCpbBNT5GYkz+lirjBi4/ZnLNKQqL75nohWdSH9cJxQEkGgyfbi
 rKyq51V+rIeT+KB3WAPBXvnqe0c9Qb0lSN9Jp+hGgw2MBldpEMacuHkvDDft6e5jYAc0
 zS6AjiOLNczSuzruHux0VsDIEHMS6yw/sivnCsCmDUSP7PsYky2gJ043wZ4oWRvczib9
 mDiQ==
X-Gm-Message-State: AFq9FYKYloXJI+HSK+yLXTIRWrFUQJKuG3jyqVXi/9JzgpYQfYA15aN/
 TGzwpqRu9eBwdLex0B7FHHXyIw7eVAs5petEUW0WoFrKH8UpHIxp8X0iKMwl075/AO11wWLzfpM
 o6/1cFrUgmdCvrQp+Qk7kAAAEMdjlzuEWR93h8h3Wk5zkTC1w20INWmnZBZaXpFr3cuAaqioojd
 AoxtkIc+ewszxRFPcuB8vIMTQ6ZU+5UVLi
X-Gm-Gg: AYBFou1o2ZVXobR8EVXDS4tY7nbY/f7Xw4etfSbA/N1I6Zck8LRqQgbuuKWFpPbKa90
 8Wrsy5I6yFlZ6BhZdqncT7EEj5moUPCxwxkOaKhGMc5OC4oi1RZHlv+bbaALX03jkxqXXnK0K08
 SxcqJPxy2V7JG/cKUkmJPosi610x9jgxvIKp+4MA0Ks6sNFoBxEy60yFO9Yh989fg1ytGzc1oCF
 5bKeRJ7PJgirtSbuQ==
X-Received: by 2002:a05:6808:198d:b0:4b9:a829:f015 with SMTP id
 5614622812f47-53cd40bad6bmr9614542b6e.33.1792510313827; 
 Tue, 20 Oct 2026 08:31:53 -0700 (PDT)
X-Received: by 2002:a05:6808:198d:b0:4b9:a829:f015 with SMTP id
 5614622812f47-53cd40bad6bmr9614513b6e.33.1792510313186; Tue, 20 Oct 2026
 08:31:53 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019172603.2625677-1-brian.cain@oss.qualcomm.com>
 <20261019172603.2625677-6-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261019172603.2625677-6-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 10:31:40 -0500
X-Gm-Features: AclHuK_gKAbS8gW2FHtWHDuoOUG3JGTjrXUxHCPkCUdaBsyZoarBazfHmrUt7j4
Message-ID: <CAJ+KCYPWh1hu+wGAe+kino5f-vqJHJ13AWhozDQZ2zRxexKxyw@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] target/hexagon: add v85 scalar atomics
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Helge Deller <deller@gmx.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: jw8p5tB33o6-ilS-Z2TUCx-m6tWejvU5
X-Proofpoint-ORIG-GUID: jw8p5tB33o6-ilS-Z2TUCx-m6tWejvU5
X-Authority-Analysis: v=2.4 cv=L7qI0OT8 c=1 sm=1 tr=0 ts=6ad7896a cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=BwizOYfK5jDITdj_Rc4A:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2MSBTYWx0ZWRfX9LOg9WM7YSz2
 pYZy8lyeKelzzvx6bvoyuKDHD2eTjfbzVIcoq8kvKJdJGhLKHLpNtaOjAGeyb9QTTNetGINsnRo
 u/jQL5YftkpUs7oyjy75XtxtyApIfXaBKFjR8OWhFEAV5eqhXFIoXSdd5oSXBvNwzCQ0EpqYsae
 vES2RVoVz9BgEKlHRSDrtozYPAqGYzhi23iTuodFsRHRmSWWwayXo/OMMmxxtXYGzMSkaqqnyHw
 LIFokjaDD0jsmdWQ3Pn9a4HWIwCIWXX/bCSQyd0oiQvZWkPS8nk/QAj29BOq1p1ALt5LzbaeTFe
 wO8VzncMWLmPiB3wsn5VQEOKuYX+pdeQEN3sxbsLiWC6KbJouW0mHM5qw1oGWhaV9fmzif+pEHH
 9L1aojszGlXMSbyqH5KXE0bzkHvZPDL3mOGnaNvu1vW6cQ3ZBtnNMMXREDCOhpiJMkVKrC9C5TM
 ri1WISvFRNKBwCtvmCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2MSBTYWx0ZWRfX23/3v8B6/3YT
 hxPC2rPXUcGrwAACBb52/opRT6bFxxXyZV4Z/5FefHtVJoi02dPFEdStLOYW+bskCXcnKNfPiW3
 SqgILUh4z+0fCMI1REz/S1l3igXABk4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200061
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Mon, Oct 19, 2026 at 12:26=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com> wrote:
>
> The scalar atomic instructions are able to perform a word or double-word
> read-modify-write atomically.
>
> Also add the v85 dcfetch_multi instruction, which prefetches multiple
> data cache lines.  It is modelled as a no-op, as other dcfetch
> instructions are.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg.h                | 27 +++++++++++++++++++++
>  target/hexagon/genptr.h                 | 11 +++++++++
>  target/hexagon/attribs_def.h.inc        |  1 +
>  target/hexagon/genptr.c                 | 32 +++++++++++++++++++++++++
>  target/hexagon/tag_rev_info.c.inc       | 15 ++++++++++++
>  target/hexagon/gen_idef_parser_funcs.py |  2 ++
>  target/hexagon/imported/encode_pp.def   | 15 +++++++++++-
>  target/hexagon/imported/ldst.idef       | 14 ++++++++++-
>  target/hexagon/imported/macros.def      | 10 ++++++++
>  target/hexagon/imported/system.idef     |  1 +
>  10 files changed, 126 insertions(+), 2 deletions(-)
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

