Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56088606A689
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A0EQBhOg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i+Rp3mpC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVsr5-00040E-VU; Tue, 24 Nov 2026 10:54:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xVsr2-0003wC-Fk
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 10:54:48 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xVsr0-0008Hp-Hy
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 10:54:48 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFKscu1603809
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Umc9QrX4MjFKidz7F7/A/HX/
 oDV+t1/Efg4TeUqDBbY=; b=A0EQBhOgK1ilT7N3KT9MFdXaLiDwQgutwYnQmfXv
 KYerc12Odg1ulIa97EYCrSF6EKCf3UZ2HitU+E7V/Wdl6OSTiRSOf9P+RAh0S3Br
 Gx7qEyERcdg9XBtpzBr/dUpkRrknQKuyjLBI0XNLpGinpBbjXY52Z+weMDbxgSqc
 C62AYG1rhNeZ+CB8M1cIsNmGwb7/6hr+n7WvU9vPCHkGrKb/5ySQ0cZDt+Kjji0J
 1Q0hVCcPZSJwwzBZZ74aLFVOurKmsa9U+V2tROrW9ZbccdlRyj4hB6hWxXfEw0f8
 N2X2U4Dfb5679NPOb5jCXIzSIUJgiBh+rpZNUqmFVpa4gg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yyt3me6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:54:44 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4ab8b4887d4so3280120b6e.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 07:54:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795535683; cv=none;
 d=google.com; s=arc-20260327;
 b=Ca79yWj713msdP7zHCgm38bMlOgmdWuaKaFM/sRCurJn6Cp/KY5x+to2O2L/srCF9h
 GDFdtCLQ2Ay5xqGCCFdogTi1kaqv7Jynp57TKiP1jPl7Xl74FiuuQ7J9GrHWvlYpYq82
 8ikfCHUBCl/B/h5DQKJrIljF/7m+YThjtH8qnTvAlpSvJXXrvsqobaP0GKJkrvCDdb1D
 8Akn49bMu754506/UDbhvUmS4e26+CJPYTvPdUcnjLVzVAPEv6uLqjaERlTw1K4jGVhT
 x2vbKJ1Pb3dGwYofmi/dX1EEW3rGl5Bc4+3o6KxSGE493Iv6ulIwv2RUE8nDMt/ibfe8
 Npqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Umc9QrX4MjFKidz7F7/A/HX/oDV+t1/Efg4TeUqDBbY=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=EcNOEUiyKhgKH/8XmInyt9ajxCIW/Y8bil34Ycb9ul3PlBZdLZBifpl52izw9K8M3W
 Y/DXvxAjECWMqsfKyqoFE90O79+3u2RgUZGgd+ZFUMgreuMol0U/tAzd1VWYu2jmh+V1
 uNppNUQUhR5efordKxbl/ydTDJr8H6664so4HlBOwTucXdBU18z2W+6y65iEq5qndJ2/
 W59tyqeZSffgqanYqQ62ek4KaUKIS7EWjRtQpDtucbzMmMmedyk5NIJzntenyL2CVGNA
 oVFWRzZTnaXJoVtah9m7IUaP/M3vxdHU1U7EQfxGRykZYTydyyyiNYRnr0ECDK1DM32C
 Zvuw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795535683; x=1796140483; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Umc9QrX4MjFKidz7F7/A/HX/oDV+t1/Efg4TeUqDBbY=;
 b=i+Rp3mpCsr/fJWe13tg4bi83pp1c0y2kxowa9NQGFbTDxlkhpNl/0kPXjnZhngQtMw
 sFO88+Vx2BkD4GADxYi/SeMDe4vfrz86bA+emO+QQYgqpHxxzepMBxvG221tOM5dbGNm
 vZzs2DPr+AZtLiZFRxh5BrR0GazE2VhJ9naAz+1iTEOrAqhBygR230NFarj26TW1cNJz
 335UA3bYI0Y1wd8vHxBg8f4bozvux3KD7Hf3Ix8vw9MjyC+zQ/9sFKuiOkHAKxPuf4Bx
 Zvk45/2SbYJoID8Fzqe4BkECQIVxItrLAE6Oy+ZLTZ/bbJ5rjwP0mIHE60AXM1jPFSyV
 78jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795535683; x=1796140483;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Umc9QrX4MjFKidz7F7/A/HX/oDV+t1/Efg4TeUqDBbY=;
 b=N2tG9/nsPPlq/48pKmc/PE+yddKuV6tVVHwrXSJ77zy8mHXnw8EE3XUsrMPHRZAClT
 +m1dzzxJWZobEXIb1lHJo0bFwTSAUstSHQ576Okavlb2CBZPJPO10f0g0kUgH9550nHv
 un1B98+7OsQtfvepWsuPa+frCpkvmAeyPxlL5qLPZQh0TR7gJCbdFzvHe83R3oHx0H3y
 c6OBwvaVeo8PpbhMUJuOww9LAuoYbOO6y8V1xaPdPqMdXRDBWx+B3HEjPf+Seo4rcguq
 tUs8xE6wdSqfbog/+zuInJSCbsEoXwoSoxyIgwu8yke+EzwXUwjQvNgR7pMZEoXEHSzh
 0gqw==
X-Gm-Message-State: APuU4Z8uMIIH0ryW3sY64mvSBsVU9d/EFOqM9OaPbAK7NEk/xub3V42b
 +9Ymi8DQvaGbXCxQgniqUN8+klNckVq2E5bsjRE8cv8JansNMymw585JTa5d2qC96iHqdyZpj1u
 wusitZRHP5NTtBP0cRRXoDOG12SFQ3U4jj0LWw/w4Ib1mw2fOKAW09hYhQFCwKbz0CvINtqzRYD
 hjrWp0kME4hchEwktAFI70f+8eFQpJotTK
X-Gm-Gg: AZFdTZcUSgd0Hgdwh7n07E4c6czWedYKS5ugVIbpUW/jioWqDhh1eItGh3M1Xk628a4
 gc0ku3U7qyfGJxoqBBAZYmwfrFtbWsoFsFoe7jU+a7pyFIWVYqmGg5nzNRrdB5P79v5gUS8AyZl
 Id7LSy52JhNi4S9NvpzRbNsqaM2QUv/TnyTUebp1+pkewkEtiKe7pZwhS/K7m643Xguso9JTsKV
 h694Mp8hoZbI1AwmA==
X-Received: by 2002:a05:6808:1528:b0:572:5316:2301 with SMTP id
 5614622812f47-57a0c1a23b2mr15310028b6e.58.1795535683627; 
 Tue, 24 Nov 2026 07:54:43 -0800 (PST)
X-Received: by 2002:a05:6808:1528:b0:572:5316:2301 with SMTP id
 5614622812f47-57a0c1a23b2mr15310018b6e.58.1795535683174; Tue, 24 Nov 2026
 07:54:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
 <20261119215853.987158-14-marco.liebel@oss.qualcomm.com>
 <c3ac9d48-cf67-49bb-bb7c-f24fd001e4b1@oss.qualcomm.com>
In-Reply-To: <c3ac9d48-cf67-49bb-bb7c-f24fd001e4b1@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 09:54:32 -0600
X-Gm-Features: Aa3M54pgG6L-RqS08kOdnaHU4IDWSC50XLgIInZWWX0nGXKS5w2KkUZm0PMBSzs
Message-ID: <CAJ+KCYOaa3g5kspfS-4KL0Anquq=s6R-GCyF2apt3+HEM17vfQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/15] target/hexagon: validate both stores before
 packet commit
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2MiBTYWx0ZWRfXwT5a4luMfmTE
 m++t1zxvhI4Ahjbnd5UJ6k09ac8T8jTbnBJO3m8ughuw5PCpjQlIrIlO61VxpcjcKtetBL3lDI8
 RZ0wEmJAWdA0MHOpwMRa/MNhWWvqLiU=
X-Proofpoint-GUID: q1r3vbjX2pcBIYN8575K9XnY3UBe4W71
X-Proofpoint-ORIG-GUID: q1r3vbjX2pcBIYN8575K9XnY3UBe4W71
X-Authority-Analysis: v=2.4 cv=W9OtxhWk c=1 sm=1 tr=0 ts=6b05b344 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=Nsn1KA5sDsxzgxPNQb8A:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2MiBTYWx0ZWRfX1YDqU/TQDRHC
 fKvilmLvyEEWCmF2vnu1SVZCXaXR4XAdzDFWmhtqQAyvK4iFVSI69JqJWXN8lFGMy8WpwiURzMp
 4FXaQs5tYwXvDyZpbuSX4Nd5tZFuMLT+7r49quL6rAcZ62PcH9uOLlNMjnotIxwaKJr9z3erYO5
 3fI+gFNpAq+bhIjujia/qp355DhRB6VwhNOUP6cytwt2hsy9/TIwTWdRqEH0xAYxO7nuM/Uglq7
 Q7WGgJ3S5VHd2ikuwMePPc5LFlWsnDDT09LYZ6IsumdHtTWxcxtupiApxw1uNdGvg9U6n+i92xb
 p0Zds5e0FlPv9FEzAmylfD/uzLoCEK2/PfOAI3HVEW7sJaA1wNjgV8AdvRcf0OKklewQSMaW0m3
 UXF/cWDBt63G1z8zlBFlWclMGPV4DzSUWWmqBidqaBddrnt4bR2e2oXaxcNDz84IJx12cW377ym
 PYyiBr8ZpBgcyF/FI5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240062
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> >   /* Called during packet commit when there are two scalar stores */
> > -void HELPER(probe_pkt_scalar_store_s0)(CPUHexagonState *env, int args)
> > +void HELPER(probe_pkt_scalar_stores)(CPUHexagonState *env, int args)
> >   {
> > -    int mmu_idx = FIELD_EX32(args, PROBE_PKT_SCALAR_STORE_S0, MMU_IDX);
> > -    bool is_predicated =
> > -        FIELD_EX32(args, PROBE_PKT_SCALAR_STORE_S0, IS_PREDICATED);
> > +    int mmu_idx = FIELD_EX32(args, PROBE_PKT_SCALAR_STORES, MMU_IDX);
> > +    bool pred[2] = {
> > +        FIELD_EX32(args, PROBE_PKT_SCALAR_STORES, S0_IS_PREDICATED),
> > +        FIELD_EX32(args, PROBE_PKT_SCALAR_STORES, S1_IS_PREDICATED),
> > +    };
> >       uintptr_t ra = GETPC();
> > -    probe_store(env, 0, mmu_idx, is_predicated, ra);
> > +    probe_store(env, 1, mmu_idx, pred[1], ra);
> > +    probe_store(env, 0, mmu_idx, pred[0], ra);
>
> If there's only one store in this packet, probe_store() is able to
> figure that out?
>

The function is only called when the packet has two scalar stores.

