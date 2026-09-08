Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA5AC79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x42j7-0000Ny-14; Tue, 08 Sep 2026 16:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x42j5-0000NY-DM
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:47:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x42j3-0006Cz-Qg
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:47:31 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688HLVCE2966652
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 20:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tN4vCqVjxZkS7nPK733UW5Eh+nRSKFywT/98LITfRdc=; b=nNPnFESHT5fN+VOC
 lFPsQ0LuUzKiZ+Oezb6vIzE1TqnPIpFUBjbQGy0nvaUELiGH2LqK+RacRhDzzcMM
 WALJk9Tk4pJTkYUPpYP7/j6fLMH5siREl/eAjbPIG+SqKFXRYoM3KQoSKMEbA7yO
 UTrnz4Ada27QISrid/9SEwW0RnqdlrJh6U10l3MXEWc+l7dMdNAyNqZNKHhU2Xln
 wT4rlSf+enEKMw5QEvNuUZqz3ffm3gYdoB+pQzONZrDRuTRlg3tz4eIvielQSCM+
 0LYG7a3RDwKoaxmox9v1fq4iSCTi4QCkRIAwOFhBoEM8kNmmx8ImE/EhxVWsB0dS
 pgcOvQ==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjppp0y3y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 20:47:27 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-456ab1a7f2cso8170771fac.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 13:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788900447; cv=none;
 d=google.com; s=arc-20260327;
 b=P97Q0u8bqSCvnAStXBZ5MSD26C6MRLSkrZ86jgiBAcl+mTbXayyWwQvrqajNP6TOUP
 hKyLGpnIt3QubACM1JYj2ae5EW/WM/Zcu1EHk5G/tEDtNjI9tLBKoSWZGteQP2O/QPRz
 qfQ/t/JWXviLzXlb2tSY8HdhMDqNbPAF9UjuziS+9Fp9JLWrTRzDnD7XGCzcn8i2MtJ2
 XZ3kJNWHFNT6WROzLuu8EGIj67PcTxFxmp2Q6ZA2tPO+zCO3TiFocZCAInao5CHakTLJ
 l/qENVdbTrRCgYWx8x2MnG9FJdw/1I245zqdobI5WIc2BND3oT8KWSNhemk3XqfDafqD
 gbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tN4vCqVjxZkS7nPK733UW5Eh+nRSKFywT/98LITfRdc=;
 fh=LfxqVHs7iB+giXalVcz/pbqkbOXeZSBmGzkNDoDAtdQ=;
 b=MJLhHy0/BSgOn0YchM2ppqnwp7FADFSPR+88YKFW/YfywqbG29yjXoUlsVMP9o/Fzl
 W4rympoyYj4ps52HP7zNONkGQ+sBu1Tso+CstwhJAxQoPzjB1cxLJcREfsJ0MxcwmYUX
 vEO/plJelci7HMLuvaFPTlqsQA+spFJ5+FARez9x1fqTDpMQFxwQ8lqDvy9/0jAp2fZB
 ulrNHs4TLRu3imF07OKvcIkP77DfKa+TvU4hPdbjDPE6u+UZlPZVWV6liS7snZpGeyeu
 iTNi+Sa2mmFGKii8Hdsa6ZHJr06hIWJMyh6zSkA96nlVs/+kf2WtK5VE+nD1tIDpIcEh
 Y1mQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788900447; x=1789505247; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tN4vCqVjxZkS7nPK733UW5Eh+nRSKFywT/98LITfRdc=;
 b=Pper9SeM2kzax6ZUJ8QsSSplQPkWQuGqgRE1zadg6nV4RuWugsEno/3KD8foBMmLUg
 DtQXyU18vCtR8jAY3mj+66Jk+4EIYLZKDIfxkgu1dIVERs/7cZ2/pzPkrM1uouJZJAIt
 C+mbcUg7b4GAZ6SSl6JgLoXqKm4swbS1dljsk45A9i0qOIhw+HjPT2B36GCZt8KscwKa
 mF/la5wrGYBwpoj4NNu8eyvwcMpciU0fFNTXKDvqgXIcLUQdb3x8ldGY+SBo/MTLr/Xj
 VGI+9Z9Plza4z4FoND0Oic9GmWVfCtuVy9N94pRfKoCTR7Bfm9Y/5Q38FWH1IaHk0kgK
 Z+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788900447; x=1789505247;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tN4vCqVjxZkS7nPK733UW5Eh+nRSKFywT/98LITfRdc=;
 b=JbOpwbQ7v1ntFqLSlM5DJeeruNnN5aIH9oreZhhG1kF6P5GOYUCTpgRFtWtSGCbwTF
 tqE2WeaxvRG1q9NMFb6ljwLGmhqs7X4CaZEFYG2wJXN2dedOB3lJbxoPPV9zF5ib2+Cs
 Y32t6bix1RKmGF1gBq3T96b6qhddrXN8hAcVAPAytRjUQR5FHuPwbGdsS7SJHE2IbJzu
 cx31SlrhTF+xV5NhcfuBTkqd3xcJIPO/kAqtCPfnMJyp/PeA7XPEir9RjUQiDmC3Nhnh
 6KtqmqvBBxKlRRFI7UhA2BbUBrcSuGX6dv7r+aAXL1CwfcLD9JcCxpD6JJRae3qPdGGM
 6pXg==
X-Gm-Message-State: AFuF++lwrs8vlKHlqyh1eb0d+25XYibM9Z55++cePcmfEGJ1ErVcKU4I
 FCaNuoMeFu/lmSsEyo0Gqgh5Vfbx2YKEL3svvVoK6z1NIxkhYaGBmbQJtHrUZg+Ql8Fsz3/kgqY
 xqL50J+zVw+som7brX1UIl740Yj7wQufJ/4JFyad3cpv7jNYyP8Y94Sm1dr/LRMahUGXXVdzEyU
 4HwOfELhBxQUKQbjmmgCm5cxJaX+3iW4X8
X-Gm-Gg: AYBFou3JMZSCFHh6QkJEGwlsAbrBvnjU/4LzWWAc9PV/EYTiaVKGVWTGukD82PV4PTe
 hQ5y5Utlo4lPUtxBN330y9R+E4d1LXwd/nzARvl2R1vcy021VCy5ta2vq5N4HSmIaS4avBva7P5
 wDPm4L5f8jwfp1hGryCfzhXcCaGqkUfo5X9qh8JERmtVVI8w1NyNMe2BKA2w==
X-Received: by 2002:a05:6820:16a6:b0:6b7:8415:d779 with SMTP id
 006d021491bc7-6b78415d96fmr14943051eaf.36.1788900446751; 
 Tue, 08 Sep 2026 13:47:26 -0700 (PDT)
X-Received: by 2002:a05:6820:16a6:b0:6b7:8415:d779 with SMTP id
 006d021491bc7-6b78415d96fmr14943027eaf.36.1788900446334; Tue, 08 Sep 2026
 13:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260908133512.2353957-1-brian.cain@oss.qualcomm.com>
 <20260908133512.2353957-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260908133512.2353957-5-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 15:47:14 -0500
X-Gm-Features: AcwNN1U-2HQ3H55v0FJRz_n_CeNQKVbDzRhNxpsXiQY4nr7vqqc-9zt1NwU_9gM
Message-ID: <CAJ+KCYN8+tMekf1HtX=2JZaAGzFXbOM=b5jdWNO8TSNyKz60qg@mail.gmail.com>
Subject: Re: [PATCH 4/5] target/hexagon: add Y2_tlbpp as unimplemented
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: i5jlI5tmHnjktw5CqJ78psTK9rSvC7yh
X-Proofpoint-ORIG-GUID: i5jlI5tmHnjktw5CqJ78psTK9rSvC7yh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIyNyBTYWx0ZWRfX8GV++4HM6JQM
 evdfhd1F0YFcosokG7DRWMhqOLd8NV7uFhDDuEaLGrjrk7yIPi6R4xguYUqK0rQgq1K8SBIaRpB
 3XSiI79LcVVMhI2z2ieJ2zzo9ToyOGeSwLh61HlZSEvPvH3pZJY4pZWhkqKhQyjHfTCq5a+7uWU
 snEnyXq/7GdaTOo6sKDwusWrdXcnqFQkih6v942od6H9mUBqvQAYn1n3AoNyAzmIj7CVRxAb5G1
 ULauwbflklsC/30NuC1oKsuvHTGa/CO2QcgqM/L6DLDwOO61OizBPWCEKbUgnNiVfBFU26RuTSx
 PzNT7g0n3XMnIA48Nl+QeUmBvbOYoN72zdAI0xWOvrYTLk/kZZnZGyUeBTK3cNzIeCoaTLUBfLg
 NwrcBmuIP67rXcawwkTV8lLw3UejFZasB0/+qoLTP7a5CLvUc1qszRTsCJI468RmqyA79gPt94g
 lbIai0nJLWDmgeVwTqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIyNyBTYWx0ZWRfX2Yc/TX+gwGrk
 dp+pd/0fAlZbXM4oIKYhyLYXLsPyAcYH8a1J/OeEONkCsGrkXtY4CfhLQhLJCQtgKGVkWlkMbhr
 UdyxpFUa+vSlQEUO9+NPMTnjtYL80P4=
X-Authority-Analysis: v=2.4 cv=DcInbPtW c=1 sm=1 tr=0 ts=6aa0745f cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=CflDV7B1V62bKSi_a9MA:9
 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080227
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

On Tue, Sep 8, 2026 at 8:35=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm.=
com> wrote:
>
> Y2_tlbpp is mostly associated with the not-yet-implemented DMA
> engine.  Let's decode it as unimpl for now.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/sys_macros.h           | 3 +++
>  target/hexagon/attribs_def.h.inc      | 1 +
>  target/hexagon/tag_rev_info.c.inc     | 2 ++
>  target/hexagon/imported/encode_pp.def | 1 +
>  target/hexagon/imported/system.idef   | 2 ++
>  5 files changed, 9 insertions(+)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

