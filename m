Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09D7CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 17:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL2iZ-0001gg-Az; Mon, 17 Nov 2025 12:08:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vL2iO-0001es-3V
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:08:33 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vL2iM-0005bl-Da
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:08:31 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AHAKNnG3932608
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 17:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=MSMS2/Re4686HpSiKUFypoXw
 gR1vihYzyaMDooz0T3M=; b=gPI6r611eadCg4oKpYBZryf/nco/SDiwxbmdiZ/t
 s652X23JctU8RRJgcbDLeQhd+K/4VE/YO2cCX4FUfOpAWMmqlW5fRLGMt+HwPZQ1
 ldPxWdV00u5d6LfxCN8jcAiGszSGlrXnp5gkDIMj5DyDH3o4wINTQyxQFgyijR9q
 5dbUuS+SVJPh5vAh0ESwOiZBj7wF1BOu97fR6SgeCPoVNFQbqu4bZGorttVuecpC
 E9ApFx6Wo4SA0lBgcW4dHc2GY5pJQv0GO4ufChAL0A9UKPVwxftRqyCYYcU6Ywes
 gH9R2YvH0YbGifszcmFjnPwHDuxKB4yF2XFw02RVsWDDHQ==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag1v915tg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 17:08:26 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-640b8f1f66cso7193881d50.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 09:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763399306; x=1764004106; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MSMS2/Re4686HpSiKUFypoXwgR1vihYzyaMDooz0T3M=;
 b=NvcKbzVH4zgcJmjiZUnuRjGrbiCl48gxLZXMnekrbq+XLkzXUfyAxj028yiWr9jrIn
 E1wjKs5HRN3pzmKPIvLrhMHA4+7M3QlQTYPdab7KvSEyLCK7cefMsm+SweHOnvNmVPLC
 +7dRHiaZY1bVijkKpxkgODW9wRUovRU13f3k5JU2PurGug4XUsxeYzZQTma4F10nbd5H
 c0Gnpb+6N+aB+lD6/xOTb0/5eo9FDjUsAh1OgMtFE5QttndhY62vf8Z86WKkdTg2kjVr
 qtbfJzfu/2A7pgcYjnTJgfDpUt5oL1M5HpSREmLvaFqRbgJ9KqL8ey/0ZCdgqkjL+x4s
 Zsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763399306; x=1764004106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MSMS2/Re4686HpSiKUFypoXwgR1vihYzyaMDooz0T3M=;
 b=gj4x/nDzzxdJtgGjl2YFtKCy6+1xHvCYfZb/zooby+hKPSYgh8lrrREzc+zK4dYxa3
 kEJ3jukvN8xWS0RXzBvw/9tHqwtcFRPZth/NsAZmzEVteIuQu1MnryirGgxCQoHA/JdF
 1H0Dudji0ZRsv6D4adchWZisARyg+rDJhWuFEGSljxc0ByOUff4Vv1pXz/qIo+EYhXli
 jt/oZDnPNEP6Z+5eUIJcW5Yj9rAUuCNv0lJh9EMVUMPmTBZMNtCqLz2s/826K1FeyRVw
 QJH4jLuUr9yoWiTJTGM8ZHZ5IASE9YjigYrBXNzFfrmYB+1Jcnx1Fdtidaa3He82Unnf
 4TKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUArCIh5qUar4MIYH1s9VCea8xFbZWwILwwEVXgmUbJVXdMRYux3k7JytBndU38cvPT0gBlhilusE4E@nongnu.org
X-Gm-Message-State: AOJu0YxtHfwBzReZ4kohbZ4Hx9WMLshcEH5tUyZ02d1npiPhuVvlGAdr
 fqd+iTa/qLz+WaqwrLOdhm9YQp8yKJeMxksuI8uF6Z2Bw5oeLVRUtofab/T44TxNmyNRtMCybZz
 NoWJAw0Pr+FkzZGXML0OizK35GxpXNRjmTsO5gtpz5IlaN4hPbMFqsczbmc3funm0On/SO38OBg
 GHFDQ6AaVjGtJ/YX8AgJgQHp7NV+lmNmTO
X-Gm-Gg: ASbGncsJjGo4DbwioYRvuF0mB9909Gr5kpsc4JS0+Fr9fZG5ME6KZAhAQgFAYqwUMTP
 LawafugCgUtPyDmKLpK409t1AG1uLchYWZNGU+X9H07h9xbjk/bJxbfwKfXynT91VqI3uXLpdGT
 iGkggFlcjxyfsSe5RoAawu/ENaYveprcx+VKAwllxd/EHbhd7rKqfSQ7K7zRd2YzeozBM=
X-Received: by 2002:a05:690e:161c:b0:641:f5bc:6989 with SMTP id
 956f58d0204a3-641f5bc7230mr5291690d50.85.1763399305926; 
 Mon, 17 Nov 2025 09:08:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZqSKaa02IiOWtLxudG80zA9uYmhWqxTfRMK4z70AnNQGNwr4/bpbvc4gn7hGDpu6cveDnbhslgOCewnOUdhg=
X-Received: by 2002:a05:690e:161c:b0:641:f5bc:6989 with SMTP id
 956f58d0204a3-641f5bc7230mr5291675d50.85.1763399305456; Mon, 17 Nov 2025
 09:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
 <d3323b18-5822-431e-aad6-cbe4470d1a2d@linaro.org>
In-Reply-To: <d3323b18-5822-431e-aad6-cbe4470d1a2d@linaro.org>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Mon, 17 Nov 2025 11:08:10 -0600
X-Gm-Features: AWmQ_bk-2bld_5VtwRwmcmhksaCxj1WjcPW3p4lRRF7_YwA_jfua0pnkVzpWE1c
Message-ID: <CAEqNhNYCUwK6UDXKSONA67yfmLPaSt14gtgrK26AfAQqyBopTg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Clean up end-of-instruction processing
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org,
 ale@rev.ng, anjo@rev.ng
Content-Type: multipart/alternative; boundary="0000000000003302d90643cd6522"
X-Proofpoint-ORIG-GUID: 7mcgb95laMoD-0MNCqFITl8i3nZn6uSU
X-Proofpoint-GUID: 7mcgb95laMoD-0MNCqFITl8i3nZn6uSU
X-Authority-Analysis: v=2.4 cv=acVsXBot c=1 sm=1 tr=0 ts=691b568a cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=7EXWJCMzVWPKLfAbhC8A:9
 a=QEXdDO2ut3YA:10 a=6juJ3AyqxGwA:10 a=hAFiRbQmDXctTRKjzIkA:9
 a=N1_VIt0Ke5UA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDE0NSBTYWx0ZWRfX3cwgilON3k38
 qUFF3uHxfXzg2oCRLqf2A8/kpRSZAb4WjgVZ+BcaP3jm2VMrLPKoQgFXxSDsuj4sghfXE9KaRhk
 jEa5JLUrRMjfU4c66REOT9dYBLdmLJZ3wm74Bm9bKoiYlGcQvElNnvB8E6UgbrJOIhVm8ZHKsRT
 NufsBRMx88Ae5sAUTVGuVLg/ia9O/64O3wLJrReZKsu+XTb+78j0gc8fCVeqov8aUYKXGLH7bNz
 BYxvJTAi8XFWS68ubxCvfQhYPKlO8V1DvTd4IjzFOzSIzQIEwI4nSlrvnlgGRB9CPLULRCDFrXS
 JfgkWuxyTU/1Oz13X018y6LvC7itI0rTaxjjzzYVSpgKW3aDoNw7VbFayTnlkzqWBdSazxeCgpD
 asfGKP0zP4FqaZVSeedOfqVUZmd1NQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170145
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000003302d90643cd6522
Content-Type: text/plain; charset="UTF-8"

Maybe they're based on the other commits on my tree which are queued for
inclusion after 10.2?
https://github.com/quic/qemu/commits/hex-next-express/

--0000000000003302d90643cd6522
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Maybe they&#39;re based on the other commits on my tree wh=
ich are queued for inclusion after 10.2?=C2=A0=C2=A0<a href=3D"https://gith=
ub.com/quic/qemu/commits/hex-next-express/">https://github.com/quic/qemu/co=
mmits/hex-next-express/</a></div>

--0000000000003302d90643cd6522--

