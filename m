Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110E6C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CKL-0002x6-7h; Mon, 14 Sep 2026 15:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6CKE-0002vG-Bc
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:26:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6CKC-0002sY-Kl
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:26:46 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EIoSG51459098
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m13jukTxSWBbbSPc9HV3LDc0mYIPpGcyLvW0845Pa/g=; b=GCVyzxAkNvwJod81
 FqnMSK9u/gWAjD02liapObTL4GT2+LX22FNfsYeawqUyQVVr/OTKbQyvaYRY51C9
 sEWzxyfWWrLLjjF5n8UwAAcfPzMekKS42z0Ml2GVbJ5KpE0h02ITYH+nWBXlyH6W
 4K3bbTH5uTvA3E3ywRikE3f+8//q59lYtPkIGgSkiFD/3hEomH8/nVTmD01qb4hI
 IhX65yca3Q4UZvLWty2GI/0lPighIC6Z3sByrDCuVrikJYwLFOj0T2Eph9ZMmbY7
 k27dcJQzWaZo6NJekmEEQrdvrNhNliU9ZnyYR8gt3d7nfV5qLRVo89a+RomMtLXo
 uQ80Cw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpnet0cq1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:26:42 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7f4e8568ccdso5955181a34.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789414002; cv=none;
 d=google.com; s=arc-20260327;
 b=SUOR8jHHVQ6KWXtj73YUch9lJaUItZbMBK2wfXngZfja80X+MKIgoTJdm+m5W11z6k
 Z7QCvaMAdC2NOXWyQ0sfcEB+Nof/nY3/cQUUB8t5Ee0Ff4xaE24ydOHPk8oPnRGRjgi3
 mx+WlCPvFH5nACtgFob4r1kwAZ8Cl/akN0ZLwj3yDhOzKX684yIDLnODg8ifrcP52YAd
 WV88L9dpRi89GwF6WtGvfr2QAsVcXnQPaPG6FKHtoXgT4QBOOqei2tEpkSeNGijtPbXX
 u/sSUg/5Hc0l2RpIWID85Y26yIdcxlqPEUovC9tclxF5qcL9T85/EFIYpufhmrw1EiwM
 9Czg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m13jukTxSWBbbSPc9HV3LDc0mYIPpGcyLvW0845Pa/g=;
 fh=OSkAXfMXEjEHEK9eR4/7X1OkKzMaRPS7D6WMhg2fqKg=;
 b=dN+TQIDLpIFvP3QqdTyPvl4cvIn7t+QX+wigcm+mQcRHEfZXW+Wdza9puxitrlKOTa
 Ew6sUon79rNGefhl/bt/G7NnVq3Y0q5xnFfJvjZ9deBXbho1sgvOTniD+D4wgAMPaX9m
 PgCj6WkdWHxWHyJW/4KMAjvHDdiwtRNLTfgc8UtKCe4IOsSVWwFUln1ZXYGOwcTuKKRk
 j1RkdUAs6fYaMlEv84D/c9S99kiwHv9IR1jUjPg3vGbWVYWBfYV0fHf4D7qkvPZSGG5r
 nQak96QKODuL4yO8HiXBGieuO1mooOZMg2T5OaHa3cDie1ypDirWgzJbIaCiJsgJkX18
 8TOA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789414002; x=1790018802; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m13jukTxSWBbbSPc9HV3LDc0mYIPpGcyLvW0845Pa/g=;
 b=Ansv++UUf4UEFet5tPe7hX97uWWm803efDqoqPCE0T4Y7QxHcfP756te6e+sPZjV9l
 obivNfQZtkhAJDDyplYyFm3fiYdHiLeUKSvbY6aEo7dn+RdUyB+Pnvyp3SxQOGxi9rDR
 kq0rIBJruPv/MAFrBoYt/DxQg3J+lEL0U8m1isIWKx0O3lWDo7+p4o0SH7SJWEK4rH1F
 OJKu2gRVDfIIYlxaZU/V+thCaGAtRa6quSxWl0g06NUdGuoFv1rHucPhMvXMRzByKEB8
 MjuBMilx8tnVLDy8jQrdjHm86hbgpx+D0AFpakctXNlBG3j5xyeAVaVJCf1Sa8he3tXL
 JURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789414002; x=1790018802;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m13jukTxSWBbbSPc9HV3LDc0mYIPpGcyLvW0845Pa/g=;
 b=WmwLCiMcECwAlRlobeTHNlVx6nShl6mN+IcXD62QRehuqIdhYQyWbXMPtMtGCXeDRX
 rwRPkADcDmA528ziqhrC/6RJEO0dop4NedKmCb/4OWZm17ZudvjWqpydHmz4MgLPQ4Uz
 K/nc5ohSCVBxR2a4X2938PQhM72TTXInf091sWurYDheJ2ybdrplu4B0JwWQqPY+WOgX
 8dENWAtjWvB88iBx6g+i6VF5r6yCJ/6KArLgyuniY5uy//6+rRjUcB1xenxFkZVBP4vi
 2C2Yvolb0U8AQMYx9/W5lLj/s8Z7+7XCxDU5nGhmy0PYDNEeMOH05Jcnio+BU2aXtOEZ
 w8ug==
X-Gm-Message-State: AFuF++mo7O32QLYeL1uBnf4fv3b68gOe3eNLQzeLMAjHVtUbyM5T3nq7
 RIck//HdGpQo/4DwXjYHad8ZMF3p1aLOrOa7Jb6q325pdY1/pym5X3NYqg4IdN3kZYjWpWZpkSk
 cQUpnWT3Xjq2Ufl7vzVqHlK6/XZUIUd3QpLegLSi/OJHM2AqS/PisSCMq01j8vx9kVTAdjx6ejD
 XOrccuiHaNQGw4RIhoigsuR87x9CzREb5U
X-Gm-Gg: AYBFou3x0Q/zkS4wBQuZ62b5hJwuGHcC0MYmbx8TkcF9zptQp09b955X+uJ8eVdWmlN
 XLRzsed+qVcWSWmnE+kdw8sXxNOhHT1s2n8e5KgdKJ9xZjZ65AvhnCqEAe/K/FpdpNsAbmYSVYZ
 Brf/eHin8DF1lM74EnkRIo1TIkxHynd5fl8CTxaeDSsm1611k34uPEft9uxEglyOFwCtnVquDs5
 x3GAETr6J6BEYHyEQ==
X-Received: by 2002:a05:6820:1988:b0:6b3:558f:706c with SMTP id
 006d021491bc7-6c542b35ffdmr2542062eaf.30.1789414001681; 
 Mon, 14 Sep 2026 12:26:41 -0700 (PDT)
X-Received: by 2002:a05:6820:1988:b0:6b3:558f:706c with SMTP id
 006d021491bc7-6c542b35ffdmr2542037eaf.30.1789414001324; Mon, 14 Sep 2026
 12:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
 <20260911220825.143115-7-ltaylorsimpson@gmail.com>
In-Reply-To: <20260911220825.143115-7-ltaylorsimpson@gmail.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 14:26:30 -0500
X-Gm-Features: AcwNN1U2mEh5fzURLDtMaUd-wIwONBWE_AlhLI5b5IyOW0wrtYMzgd5ljPEAoCk
Message-ID: <CAJ+KCYMNEWEBuN44HM2z1mGrmO-YO0RQ3fLc8mkx-vdWoVvL0g@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] Hexagon (target/hexagon) Check for qreg
 multiwrite in analyze_packet
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI3NSBTYWx0ZWRfX/z/L1+aZ1hP5
 s6y6FrpaLhIUhaC+rB7FWc4iwUPG4BN/4wy9Uf/e+xtCEiNljqsib5l5Qp19LMlx7qs1o3rfcEs
 ARfj3JkgXi0Ode4lHQ9+C0WvpsLcZhU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI3NSBTYWx0ZWRfX+ZrXpTLhCK+e
 aahGbCKZa3PzuBHM5W5x09TyFqNZoSinX8f5vGCYaGgMyKGT3cjm7HTjn/x3rIFSNLij9yxEROh
 /o5n3b5JPj0MHw2zI741tDKqkkpZIGTYr6Nzy+bF4hA4hMvYI/bjoqbGTEZo7Q2lvLqM1tP5yxT
 kdJq1AIXrEU++jVgUOJJ5IVaSe17AI5BmoHRLM7Ri8vQwYa4ByBGKznPvdb12zmmq8YTnM3VvLX
 TljIqQ+BqXPQ7vcSNmiO1+fg2X+sZttpio+Z3XSxhPZzkXVEhx0maF7Oz9fj2O1P/bccee4hqSq
 peCLfOmELv6JNXg2X0JaipAIkI8v/mmFsvHQItA/t4ww/ekiF/lz1th3wMwQR40l4XueaF56nmN
 x3b6uXfIb4Sd80TDUu3YErhYaC7zgHGqug9jYeMgURBJvsZIVm+wMdzOmy7BXWdQs08Mk69/XrV
 qnla1NxgXpWxUxpe6ww==
X-Authority-Analysis: v=2.4 cv=PKKaavqC c=1 sm=1 tr=0 ts=6aa84a72 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=oiUj86p4EGMqR00RCskA:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: o826qtZaoFiD8YWkKAMNJLj7foo0iaez
X-Proofpoint-ORIG-GUID: o826qtZaoFiD8YWkKAMNJLj7foo0iaez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140275
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 11, 2026 at 5:08=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  target/hexagon/translate.h | 7 ++++++-
>  target/hexagon/translate.c | 5 +++++
>  2 files changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

