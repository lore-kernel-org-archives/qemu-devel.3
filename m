Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813B2CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgWj-0002bS-4y; Fri, 02 Oct 2026 12:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xCgWg-0002au-Re
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:54:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xCgWf-0000RP-HS
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:54:26 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Giop92467280
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 16:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +wXl/pyNJ9bDo5X285hOBxChTtHrKcEQjxHDBkd1bbs=; b=EfAp+Ms9csb7tmLO
 hg0Hy9pedM15YQ6ey8+zOFX66gXoz8TzIEKYhXcSvaTZGsts2jlwGT6DWL0lHCBr
 o1XvTf5WHGDmWINYMEkFpJht34pz6qIb/HXtm8qhJ3QFNbBk9MVx/Ex6rkVlOFJN
 ef3sWA14wvpZHRFZ7DlJKWrYcclrE4GM/tcEXAcw8bCPdqjQAesil6nIpq36l2Pe
 qcAtWfBOljNb33WxssZke4CRJ5BmdmZaPE4ckFmFJ8feRvjoqn460VDcCdEMsj9v
 gp9SO+xpG6NEafP1BV/h6qS7DSoSz+No84EPkrLQF9OrHr/XqDrtycUxZm1/2Z9w
 tGyorQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2aj01e6b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 16:54:24 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4cb254da90eso12224003b6e.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 09:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790960063; cv=none;
 d=google.com; s=arc-20260327;
 b=RLkXBr44iAzZTWPZ0msZEl5EvYQkyzJMKqognRlejUzmL8aILZDQW9idPrAhfIVKSY
 pY64lAJppLh/raOJKVNQUTVzJVL2WUvyvTp/uttTFjN3vOFyDLbQX52Ma9fiiiPsudM/
 BYxzlcA9XuyJSbIGK9oU6Xr3ARfZaPx6txZNlibZWPBwpUVa0ciHgyv3QJRQ1l21oYK7
 lCbB+RUTQyfJJAQtNisbUDGRFC612Mx2v7WYZzePm2JzcUESeGChjD1ztdsQNLhDuDbs
 6hGY/QZ71o70vP9NW69p5j9KL0yOfKhSFzVauHHb1R3arW/jOUfJMuZvMIhb1lrcdPWf
 cvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+wXl/pyNJ9bDo5X285hOBxChTtHrKcEQjxHDBkd1bbs=;
 fh=11nfX6Do8EaL1FMi+r6eKWxDDoA7QEpVbFRn3KjheFE=;
 b=dBT/HJeKoK3utbZICiTkYcE8BbTFaGJ6mPN71yo5UxZvfLhqBqWVWnQHtSzagcwA7J
 kn7vW/fhpGOL6Ym/JIsKlpV8P0VtEvbNghOV/ZURptxCMRN6Wtq25MpJPutdf4y5n1CR
 2odRW1VxW541nblYyjiGNJEzOwEBATZWd1Gg1WPw+UhUtCfSsugal36Gjy5/Fqy6VHOz
 PHZRnPD5h5LlAnDhGwZmxnvw2GILKfVKFQWg6I0OAnrdbWGarvOepdeET5d7zLIsnAGD
 1CCf+f+sp/V6edHuulLnCCc1uX50o9RH4M9lVwzDsBn+Tm0ztUBEFALAz5vj45+x+ohx
 RWRQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790960063; x=1791564863; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+wXl/pyNJ9bDo5X285hOBxChTtHrKcEQjxHDBkd1bbs=;
 b=kBRuPKdFW/yNgmvFSPVrjVTsoz42VZHmmy43JhIZ2d3XS26u7hu9LeDICEEoAH0Zia
 GhPSGQ6VhX9HpzyH/agRR2eRxo4jtval1csfHigka4q9faPdak/8cktik/58OIw1fEJ+
 A02pYyjdS+bdSZ57/M6q2Yrq6dtYk5Pd2Xevh3QsaYUm0IcrYaQp2lyGmks198z6Z8Zc
 NYezc4NTCwQ1YQMeN8OmmjtnlBPiMKr7vs97rTMTMKW4tia1PBG3DGpDhoqeaU724Rvz
 o3FjaxIsLd2+6cJQWqZHOfnc/O7NJTsGJrseb3dvQsnan0KaYPglkCkcJp5eeKdPfBAI
 MUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790960063; x=1791564863;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+wXl/pyNJ9bDo5X285hOBxChTtHrKcEQjxHDBkd1bbs=;
 b=Lzs1xInW/4MFLX1EtKaDEcOlr6MOuzEHc52MzF/jMbhaMDNq2ecYMOts1HWeyk+koq
 4WocXauwT3JGf5zv/A7bZX2y++pxOPYw/QzazirFOJtdfdEFL3NDXCaXxR9VUfpPK/jZ
 fUOSI3y8tYD2lGESRUtXduWvvcfU1jyXc7z5JMF3DZ5H5fOFeOP2AcONnhsPW7GfgZZi
 M1LnGbnIoulNAaYE1wgEVUoAXe4/s0NGbCHfqDO5C9ngTwePZPJ4Z+62/87UeyYJBQtL
 jleH9YqA8z7VZ8IASajOaUu/NjpixmH5dUARuNGltGhAznV4ApZbG6AtqgaAQ6pr2c1a
 urJw==
X-Gm-Message-State: AFuF++kzhHFrdDza4oAXVrXmkEXwwqZN8/Fpj66QaVYxjo1yWqqtvsyU
 Mc35jtLi/bYdQgpWitIxpENg1L3iOPeliKmVeEwhtBTrdYDr8HLkJMUq96IquWIpIAD78+AaTAI
 zPmIwQEH3sTadf7N+tZdhmDoAZMhvhsF1p6znbMsGRFpD27h/16YYgckBQjAQLZE1ahTF3THzZx
 c9yWTeDyD8uYvobe+9DLFsfBHY0AYQq0sw
X-Gm-Gg: AYBFou1ItWjHdyuOwVhZVZfRDvUVBsPH5O2OAdBgnpSGA00vt5X6aN1puTyK5J4glB1
 u8++XLMEjzwljWMRcARmJL4ZAt9hAd80qtJ/aSnWYXwgQfUaQf7+mlpJ/hzhtswYvNkAdwiT2f+
 t5/Nkb5GrkEioWl3xnwtjTfwn2eC0VVzcT9Sfb1qM1Poe5S7T2hDC5sY4PfWemc3XPm+WgG5A3d
 RJVOG6KOujH3PTp9A==
X-Received: by 2002:a05:6808:5028:b0:4d6:9222:99f9 with SMTP id
 5614622812f47-4f67b22d2b1mr27687b6e.57.1790960063372; 
 Fri, 02 Oct 2026 09:54:23 -0700 (PDT)
X-Received: by 2002:a05:6808:5028:b0:4d6:9222:99f9 with SMTP id
 5614622812f47-4f67b22d2b1mr27662b6e.57.1790960062885; Fri, 02 Oct 2026
 09:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
 <20260926192338.2702952-10-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260926192338.2702952-10-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 11:54:12 -0500
X-Gm-Features: AclHuK9gPw1vkGZ-_d5CUgBfainkrk5vMzEuLGCsq52v_NFK21ZiWTYizeIrWHQ
Message-ID: <CAJ+KCYO3p8CkdsXPFK5z9mvt3HEesEytS6F7KNziHx7sFYq9yA@mail.gmail.com>
Subject: Re: [PATCH 09/10] linux-user/hexagon: add v75-v81 HWCAPs
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2NyBTYWx0ZWRfXyGhTHbN9qojq
 PJPcSwKL99+kZxxWKhkOwSRULtMut692gL3Tom8J0lkNzWkXuz9v2jY+b+BHR1ExriAPFd/ADyg
 /LyJRzP/S1j3VBXlW6zaLSP+5AT9rdE=
X-Proofpoint-GUID: uvx4TjvWtXNMdplHhWNGECbnr0FrvAA_
X-Authority-Analysis: v=2.4 cv=UJZIjyfy c=1 sm=1 tr=0 ts=6abfe1c0 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=3CPOdGnvzCBmRfmrnTQA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2NyBTYWx0ZWRfX3JqX9+iXcbjJ
 VAM9j1nxTST57R8uWL6V6EipdiMQ/H5uNEkwh1ecZ8UNIZFlpEDOjnkBpIHLAGW0K77X37iL31l
 9Q43dSzWai63CKG4V97qv/aN9/+y5agg65VqmifVeI34DJflQvs47Jj0LnVp8Zitt66aNSvqCNi
 057kNo83XaOa7t93OikqQ1eGt/D78aphY9WORJB14LzEAxE8ulM/QKLU16ovbGm3xSrG2XSFS9u
 6QhZ6DwP1LLRczmnPEyeINn57tkIaK4Qk1rSAbNiWgw7fBBp7dUSo3aMDwBtmYP5fgkdaw9kwzU
 luoFT4DoyHb/qqPO3S8Tuus8vg+ipnrigNlx5nV4VM+f14ZPie5OYYu2vTqw41VsjQRkfZ8aWYJ
 a+1EM6gB7TOl5DYw9/f7IJZl0VlgHOvyVUG3VcBoIJlTDVPvjPUkJ3bE6WvCW1aHfSkdNXtCQ5j
 PykqY4aeQqootii0QoQ==
X-Proofpoint-ORIG-GUID: uvx4TjvWtXNMdplHhWNGECbnr0FrvAA_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020067
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

On Sat, Sep 26, 2026 at 2:23=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  linux-user/hexagon/elfload.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

