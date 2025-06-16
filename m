Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04230C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 17:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRDYZ-0004tY-1g; Mon, 16 Jun 2025 13:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1uRDYJ-0004qE-Ne
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 13:23:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1uRDYD-00028S-Uv
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 13:23:22 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G8kfMX002991
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 17:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=m6YqyeBy7Ov8800VxqTiWsN8
 BrbBZn4cTFMrsDcYbSI=; b=S6PEvpM2FK9QmfujM/rysSmgb1/oEy93bhEOL41i
 SVT8BVDmdrX+zP/gecVNELZZi9LCo+a4Kxm63PlqKSSVfKyFLb+aQPoUgl0WMsH/
 qS9wYgGon27ZVCQ5N5ERnePMrJ/HWgQFx3RzPSCBmO/glRPTAwAYwrRIEIqf+qzW
 I1jyzMw0e0yXCc4vuJ3QHASDNB/br+k172qQIARCKvhVKFGCGMIFkVglnwQLpNMB
 mMx0m/UAyLg4N510tigFSRBcXUoBIC8lrFI8oYpsC3UaSx3uiA1p5Qwu0IA6Bk0O
 SwQpAvOl5uB/lkDQd+foYPAorubkcWsZmU387sHQiJLA2g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ag231hjq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 17:23:12 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b31814efd1cso1679541a12.3
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 10:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750094591; x=1750699391;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m6YqyeBy7Ov8800VxqTiWsN8BrbBZn4cTFMrsDcYbSI=;
 b=iGtbmIBRS8hfv2xb5SbLog/P0HkDR5VCwOKEOMY/KP5mbKsGBBPdURRWQC3uuXPq4R
 SYgaTP/vciAxpUJYaHZR791fIpQCxU6Rfhf1r3ykt5QmnUe+4aUt5YwkkL8MMrRP/aOg
 jPJldbXSz5OpkzHBUyd2imXm0hX8ymidPmEnydtEH1zqPYUslnkn5vwnFFn79LfgPJb9
 1/PJz02ZjHiJVQhjpyT72qAGTylAiMiOAcTxad4YZp+vqjWMprr/HuWezVXVjgI2DQMC
 LE9gejW2++HmAw6lUzvzJ/8Ii6GXMkNeICMAAGgZx/6Bd5p7e6zl/+KyUBov7KEdEZhf
 tIvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8FLLpCvL6PAB4a/nX/ZXtKYq9/ia4LSjA35//G9Ij1Vqg0l9Xin2j5GlJfDwlq7pD04oxhqwpvX2u@nongnu.org
X-Gm-Message-State: AOJu0Yz5OCHWWhGk4Zu57W1vnF9gN8tCUPObFB+kSjmGRcSdoPCplLFg
 /fdQUrWZvsuHHlBkKJ0s86np7Iz5Mqm6UNpexVN1iA7DDt/gk5ALQgftk5h/5bO0tTWqR59PdrA
 YI6dmCGWZsryPcotYrUZdvMKMn+cwVJj9ivUrNJnezv7/2Zc3Kb3/20hom8PBYS6Fv+xkJ+fMDO
 Dy9eoNr4RbEYzXhrM7ssCYKgd/uV/joAxuUCPqSg66
X-Gm-Gg: ASbGnctkkBM9B4Y9LpAz4M3L6BppfA0ToTCnGPylOyNiwKuN2KWaI65yARZX/A1BEr6
 VtjLaPwQgwnyXkYRLxYKd+Kdf724hKL47dH+oNVI8PioCplO32IVF85NXFHEcN1APr0POa3DrLW
 au2ut3nlStaq7i2x99zs7XpLkLIH7WK145KwPQ
X-Received: by 2002:a17:90b:3805:b0:313:2768:3f6b with SMTP id
 98e67ed59e1d1-313f1daf338mr14972217a91.27.1750094591535; 
 Mon, 16 Jun 2025 10:23:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/RyDJ7K3KS6GMwbYw05w1eiNNPGaBZDamZbMnsx1mEbSqlH2ArymUN+7RmqduX/J1dxCXmqmceqnjgeN7Lbk=
X-Received: by 2002:a17:90b:3805:b0:313:2768:3f6b with SMTP id
 98e67ed59e1d1-313f1daf338mr14972173a91.27.1750094591053; Mon, 16 Jun 2025
 10:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250530105430.1662-1-wangyuquan1236@phytium.com.cn>
 <20250612161739.0000400c@huawei.com>
In-Reply-To: <20250612161739.0000400c@huawei.com>
From: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 18:22:59 +0100
X-Gm-Features: AX0GCFvh6NbG-uIeTzAZqgYkufOxYvvCG6hnR9L5itpvXJCw5VmS78OBCW99iG4
Message-ID: <CAD=n3R1_rox5VQBPFK7XdXT8YR4Bk2S6demyLeir=Y30RirTsA@mail.gmail.com>
Subject: Re: [RFC PATCH v5] hw/arm/sbsa-ref: Support CXL Host Bridge & CFMW
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: wangyuquan <wangyuquan1236@phytium.com.cn>, rad@semihalf.com,
 peter.maydell@linaro.org, chenbaozi@phytium.com.cn,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: J_KGruCNC6Muls2lrot9Af_Di1GT3cs2
X-Authority-Analysis: v=2.4 cv=edY9f6EH c=1 sm=1 tr=0 ts=68505300 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=i0EeH86SAAAA:8 a=fgrLqfBXAAAA:8 a=UGI2eN1KjAFkz-9eoiAA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDExNiBTYWx0ZWRfX5KekQtMSAhV3
 5HY9zOfl5e21gQswKABqQHAdkc9GxOSCS9dtbLoX7wYPopoSLCEd9Z6/HTGCtGbe5KkVnPxflKA
 3+lz8cBDEbgkHfjZsc2/FQQIIHYDGZMZ71ODTO8ZTgcMLmhPh0naC8LNw0Dn9vn+Ugo9KpOCD+2
 4B79xSikoZ5mwZpW2YP2GCQcwXsckzrx2feQGtXXgqndr7j8WqbRhGzjLD9CBriyrSwdqJL08ws
 gt0hjHENBxWXaPrWBuo3WJFdiz89gZFD9p5vZGP1k8d9rTzFBnvkeh4TmRWIQcZC94tASyD+h8y
 SJgwPJvxZDWEQIJwmfvRS7kBTTb0pNgGfp61VMfEjNfXaJsXCLVI9K52rn2eEKJDh1fxWNC4szu
 t26FicBPPo/R2VN5LPdDAy3GyTmoblLYmBHybJJQnxRzAwdFESbURBACz4Ts+XRqg3HxLk5p
X-Proofpoint-GUID: J_KGruCNC6Muls2lrot9Af_Di1GT3cs2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160116
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=leif.lindholm@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 12 Jun 2025 at 16:17, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Fri, 30 May 2025 18:54:30 +0800
> wangyuquan <wangyuquan1236@phytium.com.cn> wrote:
> > Dynamic cxl topology problem
> > ============================
> > Actually the ideal expectation is sbsa-ref could also have a dynamic cxl topology by user
> > parameters. According to my knowledge, it should pass a dtb to firmware to match the requird
>
> Spell check: required
>
> > address space. I'm currently trying to solve this problem. I am looking for suggestions on if
> > there are better ways to do it.
>
> I wonder how many cases we actually need to cover?  If we were to support 2 host bridges
> with a few root ports each (maybe 4 or 8?) and a set of static fixed memory windows
>
> 1. Target only 1st host bridge.
> 2. Target only 2nd host bridge
> 3. Target interleave granularity X across host bridges
> 4. Target interleave granularity Y across host bridges
>
> Maybe longer term we'd want some of the more complex options such as different properties
> for the fixed memory windows or different QoS groups (QTG) but I'm not sure
> we want to go for fully configurable.  The virt patches cover testing a
> general software stack - in my mind SBSA-ref is about testing a single representative
> configuration.

No. (continued below)

> The dance through DT and trusted world is just too messy for
> a development platform / configurable test platform.

Well, the "messiness" is the point. Although the DT is incidental and
nothing that would be visible
beyond the first layer of firmware.

A lot of the general testing effort being done (across the
firmware/software layers) is set up to succed,
rather than to verify sane and functional interfaces.
The purpose of the sbsa-ref platform is to enable useful verification
of the full firmware/software stack.
_But_ it's also about providing a sane default platform.

If we can have a sane default platform that also permits specifying
more complex topologies on
command line, that would be great.
But there's not necessarily value in providing more flexibility than
could realistically be found in real
SBSA-compliant platforms.

I need to take the time to read through this series properly.

/
    Leif

