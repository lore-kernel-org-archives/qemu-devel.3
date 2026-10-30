Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF7F606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jFKOU5eL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bvaHHPa/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqD8-0004dX-Py; Fri, 30 Oct 2026 13:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMqD3-0004cZ-2O
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:16:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMqD0-0004bI-Mn
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:16:07 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERDmX3552366
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sdGLD/AOPbzfJQdnI7IBsUoJDAATMtKB+zYCe1FmK10=; b=jFKOU5eL5JA2Lu5v
 nKmqpY+jNh4keAIDT7oElWpSuq4efX22GNNCkTUAVmAqE7qu0snfCE02FXHlP79x
 5yvI0SshJv+oCOtWAE0hOJLnjYiG0H5vy3EqO82N3lHeuB8ruJ+09eUo7piTgxKl
 TVYIycWSM6NScv33sXwec7Ychnn9iblgjfaQw9jLZaeCQ+l1yLWeON4Vdr0sTyTi
 Tltks54z0JtRyuVzUvSXXpgZX/h9bSdeBfq/YPgayimOdLpg9vSI0JYfYZu9syEG
 /O6Q9OFKojcZeqFMXgQHiijwlJEoqps8q71h5PywbgbKL933XrEjEqoitN0AXVoz
 nc0oIw==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qm3nr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:16:04 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4db3db8687fso1472456b6e.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793380564; cv=none;
 d=google.com; s=arc-20260327;
 b=PANR5JC96vWHpR/B8vFBqbfkwIDScUzqgZbtbWLesi1gzG6y/F0a55/QUedE0Kp+bZ
 yXV0czJUej/LvvfIvxJn+0ef4IdqsWgXlAcbw5N4laeqBbsVSrfNjEBPDiARtL+QtV+X
 v2O0bzlCTzy7r3wsuHauYa717eG85e2QpZd4LjrAokIekRXI1aDySjX27U6qr2d01T2B
 FyiJFjv1cDoMQ8lebQk72Roncm+arT3nbh9XBR8+WJL+pqxIzIb7rv5Ulzz2ThixTxlj
 M61sFoQUvD13d/bgzSkqVWanDucdN9RsmpSuISNbJwoQszn/EmxiXua8zecviZzsooEV
 5pDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sdGLD/AOPbzfJQdnI7IBsUoJDAATMtKB+zYCe1FmK10=;
 fh=Xy6+9SnBPIbeeLHzdlckXW1U1F26D2M8s7PO8hcj5vE=;
 b=Gn960YHb/Vcuh6raYroGmorvZgv/vh1cUr/BGc9f0VqQk4YvnnHbkvU4c59Ihu7NRQ
 xsWUSGQ381pJ3RJACfhCIlN6RZdl2gsjZsu078WnEJFnArBre64+S44aZ9uO1scy9lUa
 bh3afKevAv8UYMMkOouk1plN5ZneBf2XyXeWWzabZPy0g51Ywj4cFNXlRWlLDprbpmhH
 10vhOyCuKmHievvmGLo/g5YiXEguSzw0rTwIVlkTzAoH+XJ0aYBVBrcLq90DaOAoslMm
 wKFzQqIcO7917c0SVl7mGuxkBSEY1PP1XVMnYNdFp8nTPhIfNK2boZPEX+wH8PYoDayy
 RQWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793380564; x=1793985364; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sdGLD/AOPbzfJQdnI7IBsUoJDAATMtKB+zYCe1FmK10=;
 b=bvaHHPa/dG8vnOL7XmfVIqXC3QCrBiDlvZgzkdDfgBDiKV9fKz3n/yblZOKztgSYpn
 4Lr1/jws1zgkG965yRw98QFhG6ILxINRKdmjOzGBHdLRDmE11ltj37mCLkvsLHZTJvdy
 alBK3i3oE65WtXSi+v/QW4p2N3T6ly1612zzVko406ix1fBwmcxB1WOD7uKOIS4W5QQk
 qH0mWyYSUJq/bbBPpKHcj/nP5Wu5tbbKLP0maAsVUSslvWM5I0tBPpIchMm5dbPfxQ+O
 T/sGb8PpDNDDBfF0EV5DcdQGWleri4qijDvcreqocJZiFHGLeszLRFTl0TmiFnWUqK8v
 ovHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793380564; x=1793985364;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sdGLD/AOPbzfJQdnI7IBsUoJDAATMtKB+zYCe1FmK10=;
 b=0eDjZcLRrYLm4cTQ9tJ2KuQ1da34iPB19tiXOvmE6ZRHMA1RHk/uBwPe1UWDlDzAxq
 nXC/SzrIRMUxCzWNu+HvkdlhlgC0VBkoV5z1XVFB/Cn9P+TZF1HuHr5ioCh3/342WvBB
 kbaP9TMuG2MM0k8QX7pstEDHsosuwhH9hH+L4qjdHkyiyXiaZ0HQZ48l7zqM5ZQ175H0
 tHDnJAkd6uL6XPLnJBIdhtPBNiE19JA1CQFOxMPzSnC+BduqURTFqBiKylTQtlPk5G1F
 wg+csv7oT7lILie1tARn8eVY8FCNk0MbOp9TbftbtDXLCF6EPPZGrGKN4o87d6EYxVVX
 Ibgg==
X-Gm-Message-State: AFq9FYK4UD0kq1zM0zjh2VGYAmYdZ8gGDp3BceQWSFh/7U6XCnNV09t9
 9tVoXti4+ESMYK6yWyYlyV7V1dCW/iXVeilsm1qc1cnzBF2W8H/oyqsFcEwuaTnxFp+MZOYDpiP
 3twvOvse/n9fbLC2bUwTSSa1ndCCpJJGuwJKgwqqTessWvd+EB5FlGZJLteeiUcsBiWzqEWjSnU
 jWVGR9w8VNPoOyUVOPEH0toy/pD/jvVU4d
X-Gm-Gg: AYBFou3O+vdD9KVIXqwBmppFBryJHiLvbXysZqA1FwTJUjQH53Pb132ckmsBEv2II7k
 8B51FX90E5Ca13AlA7ySyVdusD7r4FPU83PjsSPIeBRLKHH3B+zNptGWr47M509Q9Kg4OcfVx9M
 lTUsWJcUx+YnQ60LAqbQtZjgzJszJajW/ls/T9Q1uRYI321tLWfiIMTX/rxJgwB04ku2XeYRRl9
 jxVZcn8cgppdTSUqgE=
X-Received: by 2002:a05:6808:670d:b0:4d6:90f3:74a4 with SMTP id
 5614622812f47-5640def68demr2243305b6e.47.1793380564142; 
 Fri, 30 Oct 2026 10:16:04 -0700 (PDT)
X-Received: by 2002:a05:6808:670d:b0:4d6:90f3:74a4 with SMTP id
 5614622812f47-5640def68demr2243274b6e.47.1793380563699; Fri, 30 Oct 2026
 10:16:03 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030024110.1986536-1-brian.cain@oss.qualcomm.com>
 <20261030024110.1986536-7-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261030024110.1986536-7-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 12:15:53 -0500
X-Gm-Features: AclHuK_i05NlqAiDv80LHQNSzS6F8c-l-i82mtdrhkpoybOY2ODrfeygfJ-ehEU
Message-ID: <CAJ+KCYMfTMH34dkFwCpmq8=tQY25MUF7CVo_XYe8G4yw1ghtsw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] hw/hexagon: describe HMX in the device tree
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 8NAQfZAiZ77cKk-ksJq9VjP2QSawHzFv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX2IX7nFCdOF/x
 ssmEPVK1ekzPpnpOTIwUZdfyt+m7eg6FEuqudqz0njQR0RPR5Ly6nWGYBNdA0WPVhEH8E0FdZ3g
 MWt96Xd4yMBcQ5t4o9Pt2jkNvsAdhqI=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae4d0d4 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=oiUj86p4EGMqR00RCskA:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-GUID: 8NAQfZAiZ77cKk-ksJq9VjP2QSawHzFv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX/HYeh16K4AW/
 UaJj6IBD40VPTVYDDJAtJqPqNub/I6SoohK1ZJQxOqGD+8ba06th9LSPvr5VPDnp2n09pkUKFjE
 Jr0rix6D+Q+fh3cVFjnkns8SiDmPx2mzC4+jziGtSUMoQUiCoW1LCw0E0yY57H0NORkby2GxASk
 d8UwWcKZIp5pgeiMcaW9zMMGE790qEkXpsUV98kbb0v5N/ILw3BosE07lCjnSjd+VxCM3GK/EZG
 b/6/lZwao3nbkt0TXv8ZHYyEJW1UTao/fKpXFJzd7vmRFpetuoNOSXStE8Le6G4InJIe6BGxrYl
 gSczLPUrYZtyU/vwlEXiqKjF0qGeoeKVLaE5Uj19NzFVlENyh/yAIlpJBqDOSWg29rDBRItlTh1
 0dtNu3bAtb6c8IzwQ1nC1qzMtsVQl6jEupyqiVR0qjF0/ALoxvtuC5SCfw3d4cTpDIa63pAOj7M
 FkUplaNnt9BLrdpV6KA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300068
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 9:41=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Add a /soc/hmx node for HMX units.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/hexagon/hex-board.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

