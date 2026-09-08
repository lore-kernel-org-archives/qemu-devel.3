Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F04DC79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x42da-0006Ws-K9; Tue, 08 Sep 2026 16:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x42dY-0006WT-Ih
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:41:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x42dW-0005Lp-Jj
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:41:48 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688FdWt13964170
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 20:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZHbuidBdX4rMQgAWyNlL47/VtgWLs0Htr4S3oSzSdek=; b=AMjwULEPy6oCfRYc
 6+fMxQXglvjAmuX/TN6P0BocUp3ndZX3GNccNWnc1Jkp4ZPXwqBYHUtozu2BeWfB
 uD0R54h9aN4O+Y2LT1gQKOU2KO3B547fwPmPS9mwEL7PrjgPk9oBo+Sm+V8PDX2G
 vMUU/bQ9xEUvI/iUVgISm6kyRkUT1XEztSbhaxLOUBVYJrkFP7KuGaLq8VaF50yo
 2Irm4eBq0qFP3p7RCz1I13qcS1WdqkTMr+QLpoaot78agIbTrbAWOrtWQs/mh/PL
 emJhRq1AVS3Teq/TSm54zLfYeRAV3SOg0UXJ1srPPHdJv97tj0tj6L43QJ3OL2Ue
 E5kXTQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjfp4b16t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 20:41:42 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4ab260600easo6437616b6e.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 13:41:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788900102; cv=none;
 d=google.com; s=arc-20260327;
 b=meEzvtdVWM6Lbzonz9EYc+92v87sB6NDdVN1tofm+SyOEQqj/5XMRnb6UtbkEfyRSj
 Ha4QDZGpTgdgl6rKou39p5rTLVxHculib7YObywS478ZBWLDBILl2cgfM2F9Zu1i2Dko
 rzOd9kosRhC/Tx4MgJmX6lbaMwoce/ujmBqAeIggwKG/xlzjdkhECW8qVzX/uWtKHcGC
 LNqfV0NFkBmu0vD8q7K6aDHnomigFvtOrwjtVhrQJan8rCLN5JT9yn++nv4rJtspKLlh
 0HrQDCPPkx7eoN0vddpqTf5j+63eAx0QzEpwZiGyj9sObqnamoNHOP9oOHVaRIwwEQeA
 SC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZHbuidBdX4rMQgAWyNlL47/VtgWLs0Htr4S3oSzSdek=;
 fh=LfxqVHs7iB+giXalVcz/pbqkbOXeZSBmGzkNDoDAtdQ=;
 b=GGDvD3Sj8zVmnABHlupsymmHwoBh7J4U7kC45yWA6uMobzPkGBr9ue4V3Y8bv2TXI/
 UuVzThT7kCyZqiAdoqgBdkjrfEANGVVyo08EzgwHwGf8L6K3LHVbN2JahbEnHkSF92eR
 gSR1soo3zSCz+ww4QJf8/N4XJsYsAK7qPZ7bxJJwxyuyS/68Hr2jv8U3vtlZGIGE4kuW
 EYMwyaCRzYr+/Y30RtVHBJ6G1wit97xCJwGagQcl7WH/WPtgKQkW+oIwheXjKWqmuYb1
 lGl5BWAl510DrTdwrOiZq8APNsghem7/DwOrNyXjUxaaEsbGXilQw50bWwSmUBPqko9n
 rkOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788900102; x=1789504902; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZHbuidBdX4rMQgAWyNlL47/VtgWLs0Htr4S3oSzSdek=;
 b=iBAf2dPm/ep6pPRTFEox0GKMiI7jnz3jodHoY4YM6EQ9aAuqb7PCnIvlxqheIhXDAN
 USq7c+5A7s+ugjlkLgkVQwh71gC4Y7Jq6nES/MiOJegaNpE+bBAqDtyi8i7JzZZuMfG0
 lNJzSBLWBrrFcWnRa9PNjwQc8CohGOoTZ2oeWgiPbMzNau8btQLZti5MFqosBe7ik+Ql
 dK9SvMbpzFkvEXvyYrlJE+Hr+j2XhANIAgY20nVAa7Y4mGKu34VBB+7jknUeHnB0hMVx
 b4YPQWLODH8Nm7PRkwTGV+4d9EyQTFdip5ekqi/oDbMEWxfsD4rdO5nCFAMzAUj9oviA
 Ru7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788900102; x=1789504902;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZHbuidBdX4rMQgAWyNlL47/VtgWLs0Htr4S3oSzSdek=;
 b=MBPOJe0LhlWS5KqulZOQe4Iq0suinBDMPjgqDPzfMcItx48dejMtMRN9oZWy0Wh0RM
 uWjRTpols/iL8qgDpkrpAr5fnqujhdWyyBoD7k6mOgow8lpaLdSMHj+9xFjgUriv2Ch4
 eBpalxnlewi8NtmET1EmPtI650yOoNXwXPjNtQCsEBwE3Pa7Rn2x9tec2BcXVK3I/CRf
 F4kB27ecUSz07xgKoJMi0fIXsRBquHmLMqVuoiyQXQ97/BfOUgr0KKYB0bUoOe0+d7rA
 GCykdmImiKwiDTUCHb4ug2s9yKiOPMk/vQ4u6/BXj1z0GK4kBF9N4O6Pb4fJLDBaKLmn
 HxKw==
X-Gm-Message-State: AFuF++mTuwpZT3d9VimxduefvKUnYy4kK4mBKDbCQQSVPjv6KLrbprNl
 jG7twTxtcXrIzDi4U3AwDd8Rp4JkB70gxfXr36VYvLHN63jg7ttPG0wqBR7nxWpcn5c4uyTOgz9
 XktRLH1dbyQJWYLcQzPhSDo/SFEHOwWTMNFEoXu6ak8Rl8XiwuFYS2aF4IAxu+9WsCLVqWtCZNA
 KaMQ/Sa1omWPjcST8WkIUMnC+GpBJVvP3h
X-Gm-Gg: AYBFou0x//+dnYuXl2Qi54i/OOCxwytsAD7Aq62tUtllhIRVYFvTNhIKONCnfKhKPK2
 Joi6ijck/x7uHekBpZXMx86LX1b/zg6lrtI/FVUKKF4I+C8YMVEXLWhIE6UWtG+wZEEEeq2JQv5
 oTE4LC0naj4NDpxoVFU0W6l7kOFJMSYM5MD2GkD839B/aST+9BCfs2sy7Ahw==
X-Received: by 2002:a05:6820:4b0e:b0:6b1:19dd:f2cb with SMTP id
 006d021491bc7-6b584ba523emr13967525eaf.12.1788900102190; 
 Tue, 08 Sep 2026 13:41:42 -0700 (PDT)
X-Received: by 2002:a05:6820:4b0e:b0:6b1:19dd:f2cb with SMTP id
 006d021491bc7-6b584ba523emr13967496eaf.12.1788900101744; Tue, 08 Sep 2026
 13:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260908133512.2353957-1-brian.cain@oss.qualcomm.com>
 <20260908133512.2353957-3-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260908133512.2353957-3-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 15:41:29 -0500
X-Gm-Features: AcwNN1XELvp9afAItIRc6NWXj4h-ScUhUaXVShsNk6bemjRvRnjQL1g4VvYQLDg
Message-ID: <CAJ+KCYOUpOmoR-kiYq==7W6HY9CaeQGF1HZdsMKXFRHpm6XT7A@mail.gmail.com>
Subject: Re: [PATCH 2/5] target/hexagon: add the v73 J2_unpause scalar
 instruction
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Qu9uG1yd c=1 sm=1 tr=0 ts=6aa07306 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=pNrECa6T1zHNMNfhpU8A:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: HoXfWc8dlGKhKYfzUxAtuk1TAK6WFpnX
X-Proofpoint-GUID: HoXfWc8dlGKhKYfzUxAtuk1TAK6WFpnX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIyNiBTYWx0ZWRfXzjWh7VfUOTwl
 R7M6DM5emZ+dHJQn2o98XnQrP9BArsGduZkWAqpjxuFdPXY0FFamkfbrVkz0WCKlsq0hyqtpL4u
 Cbuk09dI0ABbn7rCg3DLjF69QOvTic9uGDV8ci4vDq5x+p46suYA+oQTbjVLZs63pKI6y//MG/o
 Z0ABx7Vs7RJLO6H46cAWeB5O0FLwqBZEXR1meanT8+vFi82d6LEXCQjAEV5qTIRYSzHuP0Vwfq9
 4u5tT3xbYqNkT3qDt7SHs4Whc6GD4ZQ3iuZPNo7i35t8exhgb30Pk50Gchz125O2gtUv1Zgfxhl
 SFij5Zt2JreM8YyRWX+xwJwMU89mHy138tuPQxnVNWpreI1ofl4xdd/Wp8fHRhb9MsYBd54GWxm
 TIEy1BVD0V1qnfxh9As+CYsurvzh+2oHOYeu8DUzJcDSvmtP6y31ccSfitS2GfWYtzzUQlSd8y0
 OJNoIYfp7TdyaZUKxOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIyNiBTYWx0ZWRfX7LsJXaFDMhyD
 /ZowDq7pLX12p1/vTjHfZW+9PjbUi5NTB4XhTAumJwNo6WynfBSGb/ZeVQ2Fjfgw2YGoipwSaNE
 biwYFr6DJ7u1BKLDMuOPwRZmNgGB+18=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080226
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
> v73 already added J2_callrh and J2_jumprh but unintentionally
> omitted `unpause`.  Its effect is to cause other threads' pause
> instructions to cease pausing, but we treat `pause` as a nop or
> a yield in RR, so unpause can safely be a nop.
>
> While here, spell the other two v73 entries' version as HEX_VER_V73
> instead of the literal 0x73, matching every other entry in the table.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/check_rev_gating.c  | 12 +++++++++---
>  tests/tcg/hexagon/v73_scalar.c        |  7 +++++++
>  target/hexagon/tag_rev_info.c.inc     |  5 +++--
>  target/hexagon/imported/encode_pp.def |  1 +
>  target/hexagon/imported/system.idef   |  3 +++
>  5 files changed, 23 insertions(+), 5 deletions(-)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

