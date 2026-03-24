Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07C7FEC107
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 20:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57vG-0004EG-TO; Tue, 24 Mar 2026 16:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w57v8-0004Dx-Aw
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:00:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w57v6-0003nR-Og
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:00:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJCf0p2973924
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 20:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lxs/SjPtowMdNnhpVmujGZjLHy54pW56KPNTteorJ7A=; b=Q9MRM4bcInVcG4La
 vX3I48QJ0lSE4E5werxlviShiggyAbZXn0n+cdzPADL6idABNM1DIyIac8hOn3n6
 KK6Cd0btQCJNR/R0/a3e6Dxr/xWWsNFtDPAkhGjrnuMnEZxs4NcKgPFpP3m1SZP5
 2pq22Gwj/0dkLZXoRaIsAPcwpOb0vQJA4eH6Rv4pMy9b7veGscxWMwZLuaczhOok
 MdH4mqFvNRHrpb/G59zZczrsL9ZPjEALtKL5pft6a18eWF/nScnknWTV+pZPBxnV
 QGs+U64ni3omSHVlq5PCpehIGhp4EmI9RAKbFSxmAKanm+JCL2nDEvksshG16qdR
 rQkyWw==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d40f4g5jy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 20:00:06 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-41c4709dd9dso15345605fac.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 13:00:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774382406; cv=none;
 d=google.com; s=arc-20240605;
 b=KZr+4OCO1BKKCkK6x1n59rZrMBrpDr5+F2V1fP/cCCpn3Sc1Wy/K3g81lZPgpAsikP
 iGLoxnr+J1LKqMySq05jYyT2wALTxwLND42VJw5TYLmqqySNp4EPeUX33MPFkIFqniED
 vim2rJ3P5VwoM/vUaPrKqxfzhmwg6XfSSPRMtxU9Ba0I4tCm4WYevNkD6skBEWyN2X8G
 IEeZhXGd1y5NhllSTcs+8i0p/MaWd5GYAI/Paznq/mJkIqY1Law4+WpRAAcOoGKfEiwr
 A2xuwXbvOdMV1PhglSZuVDY0sR0U/Q5CjnBhRYVsHedfvJG4zjL6WZR0Zt/WwjvFrOoA
 ma8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lxs/SjPtowMdNnhpVmujGZjLHy54pW56KPNTteorJ7A=;
 fh=GIsXnfQ1rlTLuqMVRnuWQs1/XCKcI3goSMKmOb1sBfk=;
 b=aJRVuy0N79QCCBMvJA56epKVlFqMqDH7Lo0vlACDBa0bQ+hwscINIT4BUftSQMeKGF
 vQ6OExpPNT4J0jgaZZqpJBi6f6ArbtDFJ1IVd2ZeGs5DZbafpitvyCUm+e6uWBEtxjss
 QolQf7s4qN9yS4bQjVCIzdLQzO0lpNWnem5QU3m/ugAb/kIoGWJlNs50YDsrV4oi9q6R
 IY8CRH7e7/qz2io9D0RCAK3kHXvKxWAMnhxMLf98Cnr6yJ8Bb75skHfEKfEgBpExSETk
 Of/gN/uAZLSVfW08KAL5k8EjZqO78NEMx05/3npn2OOZTOhv6KV7JdrznyPWX1QWbCbd
 DLIw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774382406; x=1774987206; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lxs/SjPtowMdNnhpVmujGZjLHy54pW56KPNTteorJ7A=;
 b=JcjeqaLEpxz9FmXpDRkAvJiVwUmHhDUqTRW6wFXC2g1L89RosUdutPAWlUUlv1v8Ff
 lTZdADJScvU0Tn7HT4VNh0olYXHdAO6N00ndA0iy8Tyop4+b2qk86vpMtlP/+J7MiVd6
 rD35g4KRyhnXftwFRPGJob3UvbYbG+xGPoep6kMYANnMVXh4Bj1BuwHzX7QgHrpV7OHj
 jtLwhmtyvyRoy3BTibObOpDeHT7GtLUxJisRHH/e50o8keUrFHzI6CDlDmTJTCYn33kC
 0pWqksibFtLO1Z6Mvg6qj9SN8I8DJ4WddfmlTj5Y/tXoj14hY6Y0IlFSt6hTLX+Cv/um
 Gnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774382406; x=1774987206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lxs/SjPtowMdNnhpVmujGZjLHy54pW56KPNTteorJ7A=;
 b=QEWVL75IuAs0MwXOj7ncZdlKwc8SC2pp/SRHTugtAQtl/BmS4RkObcbNFRrwqfUmS9
 1AuaGNseSoB/3lbJsZ3R/JrqmlpIpEUO8N7tgxHrHkfvy2+hlO6Tf0a1wDi6im2apqO/
 dn5E5RLmYpdygv/Ve24akUGWDkRgvkNtKsqiu7YRuMhBmZWt+1oBlYTUXVJdLymscSqO
 xXhmvsEbfd2Rf3cG22vwBH/+Lj6/NkPpeRKX4DdzPcbIxQ/TaMpfFzLZy9mleJjBLYPu
 oN3sFYfhjpEuKdmN4FtY8GTtHf7sKGatgGG3Cb/tVy6vfQYixvVM+HWvIUIJsmfwD+Be
 UZtw==
X-Gm-Message-State: AOJu0Yz0rRl1wW3ZrfjWdLCJkjht4bPL5/da9w4iBEgqTlW+9SNzrZoj
 wzS9ISwja7JVz611RZVALiX6Q0VjDPOPvxaVT3E1woS71eM0BebUxQ2X3PAvp+0nD75RyNxX0mq
 YifKp7WQ4jOh9XE4dWVdnD+nFIbFu2HuvlOtcGjHRGc5WTx1lM4avfsvp9J/ywAewDn1r5Rd1OH
 SXqFEuXdShfQFGWDInvw1V+pDpTuDokEua
X-Gm-Gg: ATEYQzwlu3rpmPiLO8FnKw7a8mmmEiOihk51Rgu3fPu/A6CmBHnZ68YNuYRVyN7S9tZ
 KbokWNM0ubBB//+03y8wqWcp/rLdrs9oiW8hgpGXU4bG06w9Fm48uAhm/v/1V+ACIJhbsLC+8E8
 3rEvd1wnIOLE78CyFN8tNRQ1EeXgo/7aYCKOrCz7CHbvD/zhSjZK8OujL3q2SFf5FFiZOlPqKXX
 dHObsk=
X-Received: by 2002:a05:6870:d6a1:b0:40e:f9c9:ad40 with SMTP id
 586e51a60fabf-41ca6ce39b7mr515266fac.10.1774382406271; 
 Tue, 24 Mar 2026 13:00:06 -0700 (PDT)
X-Received: by 2002:a05:6870:d6a1:b0:40e:f9c9:ad40 with SMTP id
 586e51a60fabf-41ca6ce39b7mr515243fac.10.1774382405843; Tue, 24 Mar 2026
 13:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <831949008a7266559a6f313f99a394cd68cc9846.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <CAATN3NrZVn6W0pAyshZ7mhYVcY+gtRk9tJwz5WLLzxoPTDupwA@mail.gmail.com>
 <CABrGZ+GmYG2tg0pWDoBuydWG3abTmMT2wxCu=06fXLQJQCS1YQ@mail.gmail.com>
 <CAATN3NpNvqBLdsz7euvuUGTMYxCusQ+MYSyo0GHgFrvZHTBs7A@mail.gmail.com>
In-Reply-To: <CAATN3NpNvqBLdsz7euvuUGTMYxCusQ+MYSyo0GHgFrvZHTBs7A@mail.gmail.com>
From: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 16:59:54 -0300
X-Gm-Features: AQROBzCqm5Jzqln4tfliJu44yoUkbdQ9FCVTjvgcz-9f-9pjXjaXa7gZA3I-AOM
Message-ID: <CABrGZ+GDw1PwHHiBNpp0_FTOceB=d2uTNXg7nXRufubXR48hUw@mail.gmail.com>
Subject: Re: [PATCH 04/13] target/hexagon: add v68 HVX IEEE float arithmetic
 insns
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE1NCBTYWx0ZWRfXxsqBflH+Cgq0
 BMyGaWrrgI2aNlsfP3l7Hkikt12tf3wq/30S/5yizsa/91G+R+t07txlyEFVb+W5Kaw0tORmvA1
 /9PFY2QO+rjv3zIBukOQDBXqYh2tABTsl2d9YGfRhX+TdjKioUss/syMg/Y7t7wrWOTlQsD41Of
 o+h9pTM6ZToscTexFEe1I6CXrf18FF5RgmGQTrSn4ICgy31awLfEpN3rTHZ+c/XKO4rRH6dqY5Z
 NNefINazG25UOkEcajJ2Idw+xkH8DoMRenq/i4k3aAxp4am7k6+RrDbMozqJGLltWJOORa7fAK5
 vyH5oRjghYT6ixZSb+0d0OLi5GJ66fUBqjS9DgqerZxR2ORJ8VYjIq0kJqPZlzBGIh+aj+T0xCV
 El3TXYt3G8/V5UFAQwnkbuQ5ykRSNWAKoQBnVtcfANkQPMzBrwJ/OWkFJnIhjfQyd3VFbseYDle
 X08fmfvfX0cMmeu016Q==
X-Proofpoint-ORIG-GUID: zSs_TZQGJzwBqISd3izMUJFwScnGumcn
X-Authority-Analysis: v=2.4 cv=Cd8FJbrl c=1 sm=1 tr=0 ts=69c2ed46 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=a5K7b3RvwuK5dAUjUOsA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-GUID: zSs_TZQGJzwBqISd3izMUJFwScnGumcn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240154
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Mar 24, 2026 at 4:51=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
>
>
> On Tue, Mar 24, 2026 at 1:30=E2=80=AFPM Matheus Bernardino <matheus.berna=
rdino@oss.qualcomm.com> wrote:
>>
>> On Mon, Mar 23, 2026 at 5:29=E2=80=AFPM Taylor Simpson <ltaylorsimpson@g=
mail.com> wrote:
>>
>> >
>> > Do these instructions interact with the FP bits in USR (e.g., rounding=
 mode, FP exceptions)?
>>
>> They do not. I'll add a new env->hvx_fp_status and use that for the
>> default nan. This way we can avoid messing up with the scalar
>> fp_status.
>
>
> That will work for the nan.  Is there any programmer-visible state for ro=
unding mode or FP exceptions?

No, rounding is always float_round_nearest_even (the default) and
FWICT the HVX IEEE FP functions don't track or report any FP
exceptions.

