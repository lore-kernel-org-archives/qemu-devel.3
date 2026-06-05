Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47917CD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 17:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVYjS-0004Dy-5T; Fri, 05 Jun 2026 13:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wVYjQ-0004Do-G3
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 13:53:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wVYjP-0001aZ-0H
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 13:53:20 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 655EtZYH021067
 for <qemu-devel@nongnu.org>; Fri, 5 Jun 2026 17:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xET67gGF1IH9QU+VRml1G4vqW5mNOStBo2asghDRr0w=; b=RpoZftecJjt/ObUe
 R0O8hQinc0ZSDfyRv6rl+28pxhlpeYLl1NKmuFI6UtQxXFtDiUBASto8SzgPa7Rd
 kCjiJG1HtRyKXVkI0KwdL51pZTtOGiotS3TYMmlb7EP61tN1scM/o8EAE1vZwe3z
 R3JJXihklqA4koDa1NDv9xvE15QV5BKqc5I/pw9QRl/eK3vj1zrht/HG0uCNIK5h
 K9H3+AEBHyRHY0DbeTxLpFx1nClsFJer4reoI48BUYtCXNcDqcBNOy9i0IGjotlF
 C/PR0h+dNqs9tecSN/RgBe2xUNRmykGKL+cyqAF+lamEKIVNuQaVqC528/g9cXHJ
 4Xpm9A==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ektmfapfe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 17:53:16 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-137ea73393cso4227022c88.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 10:53:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780681995; cv=none;
 d=google.com; s=arc-20240605;
 b=PW12ERs05QiyVanzVQSSomjAWe5Y4x39uXuVCpByX1yXeBA3FdplfVmZU2Ku0ob+QD
 qSeMBLqN6IMol5LdupcorwE9yLykWhiiNvFP6Or2ruvpYBc8A96NV8jFlqIia8gLJF3F
 fWZ7hPCuqrRWklZn+Q3Cg/5meAYOK42LBzoroChFd9g3Ax4XplrfXnEWbpbzTgLMPkNo
 HWk0CFol580c3I6TOegkx5cnRC1GahGENX/J9kwc5ilSIUXgixFRH4vR4HmFj9yss3F0
 Rs2MGBuNqJU1gnXF61drw0J/JMYHdezv98gLS6YP3Nkjd7yjtPgRC/LHy7OHT+X3xjiB
 Nz5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xET67gGF1IH9QU+VRml1G4vqW5mNOStBo2asghDRr0w=;
 fh=YNQ2CrohjhB673nK7omX5CcdjyFwO2PFRPpJb6cN5Lk=;
 b=jZ1HcALBamQSi5WrjvSweiQPh9JX6bi6Ke84xmRb21dJVVvF4j9C7BtE/Q0zDF+Tr5
 4koqW1R4vEdaXP4S+E7GRrrhr4G44+BbK/h++tDp9yi21QNYD7XwmTyGH0tKX9u6+X6f
 9TtLAkZhY/gv82fOx3kOV3Tob/8N46XwabyB2DGgGmCR2fzrkeZWx5YgyTy4EO60LEXv
 XxtA/ovnMfTjCs6YXCu0V7U0816GLwT3bxzDhVDm5b1ugrtxGiT7LMde6sgX6HnAuGIU
 rwj4Co4mkuR7u+QdU3aaul+PtlRdobZ2Mxxx2FoQ+fgoBErfbg0AMdtHsX3L4SnjFQ8Q
 zH1A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780681995; x=1781286795; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xET67gGF1IH9QU+VRml1G4vqW5mNOStBo2asghDRr0w=;
 b=YYgoCKtd35sUgm1ycwVA4+jc75diw23PFvG5HvxtmF0R5y2CqWuj4UoGamBIZljd30
 29dvxTvJvIhpF4m6ILGbdXuypiEbqebjBFX9x8pcZ0syQCiRmml1spJa1lAWAflvr3PD
 q9rtfGZ7CRMqz2yFz90vuGlCdAWs/HO0sIgOjhTw96f7CoEF7pGKWchQKdMvylw3tEpk
 H1LUuLZsx1Kp1YhMTBC3olbWpKdnIqrCSmoR5zXgtBgSu69VIXEWVFedUDxIrjzEht4K
 7tIzszecuWGnLW+TC4LLS7WMWPfVe7DAZbcddyYQd6oJOO3dtZtFe22oTkYesyZjxZ4Q
 R6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780681995; x=1781286795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xET67gGF1IH9QU+VRml1G4vqW5mNOStBo2asghDRr0w=;
 b=tVneTwuzbomuG0IA20s1MC+KDn9j02IFacHKaClq/W7MZKdRKuohGkfYPWHPi/+zAX
 kl+rk3ZZOMxHegFdZ+vvnN/pxnLAtkEI7VBaRnb2Cksgd/cGmB/CL7I+RivSPu6p7df3
 m6DhL04Q27igxWZJVMzA3r7aJkHitumI5m+EFKOiCZeEf/FolniXsF8bcnKGbVDba9WT
 YSAxM6OAaP1hikjhGfK4QNKiThggkUWNiHV7LFNU3632Za/Ctk78eUksJ5OpcxIWcypT
 6frH1lJoUjyyMt9MZRVfeT8MA+Y2ySj7uxC5L2zuRdiIbAVo6L2XpUPvCaKZirJxQpSe
 4Z2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/8dmBlCK1zDkMMjdSqYPuqjXqcBzHFUwvkLbkuIjAe8VLuwbJRyihSDRT79AecTV4XLG+JtCOb9uQB@nongnu.org
X-Gm-Message-State: AOJu0YxVEzCzEhUbbZ27XJJjcjo/TZHW/SKXC6qUU7qVyCqnfJSpe+Nl
 PzCobGToM40y39muL7MFjssDCntg6JXSQH/YqSN5h6Olqdc/kylj0ZOhPAWs04bhjRmeNqtKTz/
 OtFr/H6Gs56297bEnSkRPtB8ETtnvu3DcTiPgpXO4numpuqqbT10s6/pfCKJHnyoBja7Mm1jQaF
 mCPJ1TauYbsInyWPReinhw7vmCige1Emh+
X-Gm-Gg: Acq92OGPJ0kUZ81WF2mObtNY3QppW9Xp/w0c8z/eBsaeNCR1GHnnBxe0XLiq93FqDkt
 zHXZbTu+FLskNaxg8JRfbOJtpb83nkF5HjThk5dJMuaLhfHAu0T0c2i3CvHRLLw59Gmyp82di3H
 +4+72cbGIMZjm2WkZxT/HaOsB5fjuhxcFdOItGsycgWIZ+XKpKT2lUCQOKOVIgwksZynrfngPGY
 LMIIYuxEZdwEFslRg==
X-Received: by 2002:a05:7022:1005:b0:136:ac69:b0e8 with SMTP id
 a92af1059eb24-138066be6a1mr2188298c88.15.1780681995051; 
 Fri, 05 Jun 2026 10:53:15 -0700 (PDT)
X-Received: by 2002:a05:7022:1005:b0:136:ac69:b0e8 with SMTP id
 a92af1059eb24-138066be6a1mr2188280c88.15.1780681994513; Fri, 05 Jun 2026
 10:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
 <20260529215554.606133-39-brian.cain@oss.qualcomm.com>
 <c71f8159-5c3d-4e02-aa08-7d979f5454ab@linaro.org>
 <CAEqNhNaJx6_KPW8dxsoN3WdoVLAxhVQKKD=2S92ya9KONMdboA@mail.gmail.com>
 <f74e2828-921a-46e7-b6e3-83508a40ca90@mailo.com>
In-Reply-To: <f74e2828-921a-46e7-b6e3-83508a40ca90@mailo.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Fri, 5 Jun 2026 12:52:57 -0500
X-Gm-Features: AVHnY4ItNoxImZgUicN-_Cb_tec1EZZoHQBcuJOarzN4MmaS3lIwtuhSrWB-jpw
Message-ID: <CAEqNhNb_nMuMOB95nWMH8M_3_nzrNLuhFGRky+rGuFJzY5DUtg@mail.gmail.com>
Subject: Re: [PATCH v7 38/38] target/hexagon: Add hex_interrupts support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 Brian Cain <bcain@quicinc.com>, Sid Manning <sidneym@quicinc.com>,
 Michael Lambert <mlambert@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: P-LbbuAKPLxwfki80hCgdNHu7V3VynSK
X-Authority-Analysis: v=2.4 cv=GolyPE1C c=1 sm=1 tr=0 ts=6a230d0c cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=S56xvJB5AAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=reYZjIyCPtZuHwhyz44A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=MH9Ivq0PDQRhlrFuIVvX:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: P-LbbuAKPLxwfki80hCgdNHu7V3VynSK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDE3NSBTYWx0ZWRfX9kgY+m3W9V3i
 +dWD/F2iLqgHvQ5fWUD5IlFLjDIfuDCzTzAkeJISRrMZ1VtlSX01sKQVWayzu7iPfbGlDSbqGdG
 1GPKYoEfXpklYg5kQfuOcQjEgpxEPOAS1Hqs13e8oCvUqk6rSqIHWOhh85YAsTTmirdFwq2BCgt
 ZqEODnrSFBHBF9Cgpq3DMWJDFPMxALyCt0C9EhcO4k/16kpsPmUDZssQ35/Psgp4Jxg32v+CFJJ
 XvGjq+oy7XM5bO8aG3JBxTHl50r/jRcddgfOFIGErOPMffJP6ENq3ind6p1XLryiOD5Sa2HIfi9
 Mko0q763dXQICtPBWp4iJezEm6vkddPtGT5w+M9g38Nw88fGIYhIFJW+/Xey3XbMsZgtVcss/Hq
 pzZCk8CLBOz3TdKbyu8X1hTnzKTKz+lUjWH2QuykSbyeo6iZJnlO9nr9IbSmYlK4l+1XLuxAbtU
 sHRmfP2eMj15D0lMI4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050175
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Fri, Jun 5, 2026 at 10:24=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@mailo.com> wrote:
>
> On 3/6/26 16:00, Brian Cain wrote:
> > On Sun, May 31, 2026 at 4:31=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org> wrote:
> >>
> >> On 29/5/26 23:55, Brian Cain wrote:
> >>> From: Brian Cain <bcain@quicinc.com>
> >>>
> >>> Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> >>> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> >>> Co-authored-by: Michael Lambert <mlambert@quicinc.com>
> >>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> >>> ---
> >>>    target/hexagon/cpu.h            |   2 +
> >>>    target/hexagon/hex_interrupts.h |  15 ++
> >>>    target/hexagon/cpu.c            |   4 +
> >>>    target/hexagon/hex_interrupts.c | 371 ++++++++++++++++++++++++++++=
++++
> >>>    4 files changed, 392 insertions(+)
> >>>    create mode 100644 target/hexagon/hex_interrupts.h
> >>>    create mode 100644 target/hexagon/hex_interrupts.c
> >>
> >> Patch #28 mentions NMI, how is it handled?
> >
> > In these three patchsets, the nmi remains unimplemented.  Would you
> > prefer I include the nmi implementation?
>
> Could we simply drop the nmi helper in patch #28 and add it along
> with the rest of the NMI implementation?
>

Sure: I'll omit the nmi helper and include it in a future patchset.

