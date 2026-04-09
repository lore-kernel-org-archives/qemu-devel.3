Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67394F364A6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAsv0-0003JW-Jw; Thu, 09 Apr 2026 13:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAsuz-0003JL-Se
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:11:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAsux-0007uz-Ua
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:11:49 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639Eqrbn115449
 for <qemu-devel@nongnu.org>; Thu, 9 Apr 2026 17:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8YSFNoQMEKH0jaXamrOALT5dbH1oM7pZBVxA+gOgufk=; b=nrlZ6F8RShWxlvZL
 Riga0xgy5IRO7Hiv1Gqf0kDPQESPYkbrCsGAnRDYMD42nc7Z3sUrwB+bkWjNlHCS
 8CddTKW1Kua7j/GI1NRcFvefq66QGHc1ILTirZDDG4fZ2Cnf0z6sCjtItnYCD9+v
 03oMZEoNMJOLI4YFr4xw5WDctZIh2NzY/Sn6iyFkL4kT0lSvhYFrE8V0YbgqHscv
 21jhT++7g/D1xw6VxH+JfDh5Ek+bUSnXxzTNmwxxYPNHyz8+QnAVoYD70xcrfjr+
 JzsJrdpVJr0Sdiz8vGk11Ez2kOo4oCcucwtRbpyOvRl64w9/39gFZJmEgXN0Ag5B
 DYc7hw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dee8x8hk6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 17:11:45 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12c20a91932so6268112c88.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775754705; cv=none;
 d=google.com; s=arc-20240605;
 b=Yv0fmAGBfOum18tkmxmBLbVKwQaqLAzbcLHNUFNYW4jEuQPHFtq/cbY0z/wHsOdavM
 9YL/C87LGnBPf6zBiDkc+rHG2EoQ1/K2pEkBcKbms/N1eNVWoZxO3Ljw6Lcg6uswniPu
 f/6VRiRLMy4YTO7izTDkiHMRhOL0EGVW+HMai9JjQ82MztO5bDHHi6/LfucT6ukdwMJS
 v6q7GIyM9WmAI3PVDLyxsP5hu/huFFfdeq/PxzppckyWzAVVCgBTth6ElVPUWc55ilDL
 2sGmcL1vnX98sGrMk/GmJyUqPlKWNpUO8dyvBNuUw/q54N91HwBZ7BY95IJVpXBQFMvq
 379w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8YSFNoQMEKH0jaXamrOALT5dbH1oM7pZBVxA+gOgufk=;
 fh=yu814cA08wuY4V8jItBqeAdCck7y9xjLffuAyMr9Gfo=;
 b=dRyCJAxd9TubVVttqjN9M56XPfoBxfLxLu/RlDV+2EUINBJBSfi6eqSPLpsmkfv6Aw
 NMmPcvHruenXsM0XGYm7CIYC30T05L0qDvHLlOI6naA/QzEWyOPMNs5UA8Kzhzkxx8aZ
 lzZg4onEapXOk7UsieT6bs1KCaCRWHMOeNwA8BPdl1xbHNcIfMn0w2EIfOQcclwWjjfM
 mRCOeDWAaKViVXq3ICqbN2F1UsVb/OukhSRPrragqpJvgSKc8lnFdNIuSEHmv6TOxmpb
 3v0inEpGOLzQ+wbqVqu1uRSEtP0vPZHcyMG1KAKf1XMVDBX1cqQvNN2YW92L5fhv7WoH
 ESZg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775754705; x=1776359505; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8YSFNoQMEKH0jaXamrOALT5dbH1oM7pZBVxA+gOgufk=;
 b=iMZIcek584VjUC6OkwLmxCVzLbhj3bmJTxIWCXrE+jn4sr/ztnQMZJSeWgS3R/3dR4
 ZMKBa8nffDLkvAkY//AO+IKZJba3UB+3m/pBY3pNO2rsyYtSQONvuIoQXwv0NPYiYz51
 /wm+QJhQ8WObx7XFExR/n3qzXeY6Tc08Md3svz/djQR/zzchZw5Uzy4q1VxNfzVxZJQs
 oAJkiTsRD1rZMENwpDOfznObZsA4gN8Ip1T+vchEFJBBTeLghVHoyJpmeouMh8tf4c7e
 rxHaX04s4IrHnQDjBtej2cdJvmpjAk0sJJdaCwORvYwtyCAw9TPT1nsDSEnSIFtaYRJ8
 4gNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775754705; x=1776359505;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8YSFNoQMEKH0jaXamrOALT5dbH1oM7pZBVxA+gOgufk=;
 b=MRnchni7H9opRBdF2dsQFFHH+hxzBCu9tIgZQFz3lZWYJHMiB40XZod/Urgg/D+9Is
 6bz8qqZqxVRgTq3xW7xCQA4ss8uWomUPU/pwRXT/m8nOcYJLjs0GiM9PKOi8WvI4NHAq
 Q5MsErjL7RgvFV9LVe5d7YTaAi7LqLzMDjELjdJFyglxhCO9uGyE2srq801RLXiBxnwQ
 vMmOoEU4M7+xKFbiYx1hoebQglJoivsFC8XXbTKehfHHMlt8ZCaluuTMkWvmGg5YNkiw
 ns895uCF3X0qmh2bNIwp7Hd9rUuSTNG+rFh6j/j1kQ144wGespBiWSS3YnFrrjWqaMFD
 tmkg==
X-Gm-Message-State: AOJu0Ywe+aJuPVZ34APUC8SxXmftCJxeDJhbYF+aN/wTYc/eiMvmj6TB
 ek4THkak5s82tRb8rGHtDb4Jvg65UaYXT2ACDQXzkUtZWhW4+aosyu1EH1JkWPDivEspR1LO5mi
 lv6rhipCAKX7NiljvzLlCZR6OJ44EdgwBYe2MP4gMoRGBxnhWeLJ2LRb/0nCc468f9R21loWwQB
 EMf9Pbu+Kld2uJOXuY8+zwBqAyPX9c339r
X-Gm-Gg: AeBDiesAODbU4l8lDDxtv1TYpS11+jPpgchiRN1l1zr6v/ZUg1xSqroG9zFskmIN7oK
 qB4ZMl+a7tKgf4gSrrzqBaEy6PvPF8UdrKoo94QmtO8CGJ4kYbEfv3aNCStqRmEymhwt99YkwP9
 ivTS+zDwSl2Zz4hmO8xbPvXEJKyYXVAPrHEA8Zv70wOrpWfYizf4DzMyl+f2tjXyPDu2x+HXq5h
 +H1rV4=
X-Received: by 2002:a05:7022:62aa:b0:11d:fd26:234e with SMTP id
 a92af1059eb24-12bfb70ffeamr15552019c88.16.1775754704908; 
 Thu, 09 Apr 2026 10:11:44 -0700 (PDT)
X-Received: by 2002:a05:7022:62aa:b0:11d:fd26:234e with SMTP id
 a92af1059eb24-12bfb70ffeamr15551983c88.16.1775754704332; Thu, 09 Apr 2026
 10:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
In-Reply-To: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 12:11:27 -0500
X-Gm-Features: AQROBzBPTDWMfL1rgZO7JHkNlvbgVw4NTuFC5kZ8dRvEq4eWR-kVXoxjUsnQQkk
Message-ID: <CAEqNhNaZqOG6m2hTOEo4YFZB9epXr_frz+kXYp56wRz_w4A+0w@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Hexagon (target/hexagon) Check opcodes versions
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE1NyBTYWx0ZWRfX0neli2wwvM5b
 0ShlnPbrVO60ufEhRpe5759QNfml/3IPmDeM07YUN0VoPI4XqtRYhbITKZbfq2BMq0GxXkJwlUK
 XoZ0LyjzJdrtOIL9KPlZ7Tu9LFKzlo2X1QpVVekG8XlO14JcqOlE4Rymb5ThbH1v+3MlvwE54Mq
 aHrMd7JdTp5w8YaA5BbVkc8eqXv86nvFm1JhOOOvZdCnNkksnQMLCf+TjgG+oaKRo1Z6Pifgo1v
 6/77KdV7lyZchjcD5tSssblaJKOfhcdMbjZPO6+IEnxplJGnj773HQEwaADM68PaPh7mQ6kA8gC
 JPEHix3WingdfTH7D7V3sjEis2PRCWPROj4iWST2uwUEji0l2xWKfILR6VI4R4IDo4UuGLqkW2J
 1Dtx8ijzleq6T+inbpz6s8eQcXGXYkzb/EIsZfIxjHr25s7ZRSoZFwSTU/6/5ruheEIDPEj6ZL7
 HV97+A3BFQhQZHt1Yjw==
X-Proofpoint-GUID: 9m0QIpFJAio3Y46Pf352t6DDDJbtK9EP
X-Proofpoint-ORIG-GUID: 9m0QIpFJAio3Y46Pf352t6DDDJbtK9EP
X-Authority-Analysis: v=2.4 cv=O7YJeh9W c=1 sm=1 tr=0 ts=69d7ddd1 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=nOuyLlN8sapJGrm8WlAA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090157
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Feb 17, 2026 at 3:22=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
> Currently, all versions of Hexagon CPU are treated the same, and all
> opcodes are able to run on any version.  This series changes the behavior
> such that only the opcodes available on the currently executing Hexagon
> CPU version can execute.
>
> Changes include:
> Mark which Hexagon CPU version is currently executing
> Check that each opcode is supported in the Hexagon CPU version
> If not, generate INVALID_PACKET opcode, which is converted to SIGILL
> Properly handle disassembly (-d in_asm)
> Test case added

Thanks for the patches Taylor - this is queued on my hex-next-express
tree for post-11 inclusion.

> Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualco=
mm.com>
> Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
>
> Changes in v2:
> - Rebase with Brian Cain's "Handle some invalid encodings" series
> - Add older opcodes to tag_rev_info.c.inc
> - Change tag_rev_info to use HexagonVersion
>       Suggested by Richard Henderson <richard.henderson@linaro.org>
> - Disassembly includes valid opcodes inside packet with invalid opcodes
> - Remove unused function - snpring_a_pkt_debug
>
> Changes in v3:
> - Use a struct to hold Hexagon definition rather than a simple enum
>       Suggested by Anton Johansson <anjo@rev.ng>
>
> Brian Cain (1):
>   tests/tcg/hexagon: Add test for revision-gated instruction decoding
>
> Matheus Tavares Bernardino (1):
>   Hexagon (target/hexagon) Introduce tag_rev_info.c.inc
>
> Taylor Simpson (6):
>   Hexagon (target/hexagon) Properly handle Hexagon CPU version
>   Hexagon (linux-user/hexagon) Identify Hexagon version in ELF file
>   Hexagon (target/hexagon) Add Hexagon definition field to DisasContext
>   Hexagon (target/hexagon) Check each opcode against current CPU
>     definition
>   Hexagon (target/hexagon) Disassembly of invalid packets
>   Hexagon (target/hexagon) Remove snprint_a_pkt_debug
>
>  target/hexagon/cpu-qom.h             |  27 ++
>  target/hexagon/cpu.h                 |   2 +
>  target/hexagon/cpu_bits.h            |   4 +-
>  target/hexagon/decode.h              |   2 +
>  target/hexagon/printinsn.h           |   4 +-
>  target/hexagon/translate.h           |   1 +
>  disas/hexagon.c                      |   3 +-
>  linux-user/hexagon/elfload.c         |  43 +-
>  target/hexagon/cpu.c                 |  48 ++-
>  target/hexagon/decode.c              |  52 ++-
>  target/hexagon/printinsn.c           |  40 +-
>  target/hexagon/translate.c           |   1 +
>  tests/tcg/hexagon/check_rev_gating.c | 141 ++++++
>  target/hexagon/tag_rev_info.c.inc    | 613 +++++++++++++++++++++++++++
>  tests/tcg/hexagon/Makefile.target    |   6 +
>  15 files changed, 911 insertions(+), 76 deletions(-)
>  create mode 100644 tests/tcg/hexagon/check_rev_gating.c
>  create mode 100644 target/hexagon/tag_rev_info.c.inc
>
> --
> 2.43.0
>

