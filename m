Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1169AFD2D9A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxXs-0003Zu-2j; Tue, 10 Mar 2026 09:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzxXq-0003Zl-Uy
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:54:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzxXo-0006J2-1p
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:54:46 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62ACahun3296538
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 13:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=aF7Odv2lJ2vGs2IQJYdttjTb
 32bnzpDPKJ5Z+ebKduA=; b=O4DzZXdTA2aRXz0NyXcssKUgzR+p5A6sScy+krVP
 uNOB+2CYdZXhxXmWdmlnIrWSZuuSm4U0HYWUrut5A9zuRG1ICHnpu+mLQvIj+f0u
 REerQTbEgia/8AGVeLgYVOMuEu3oaBuSiqH0BNhrjMCsqGWdTj8ikapSpvrJin5a
 3CMq8cJSnSMGjxG0T0B5uWUVgRKtGh1OaYMRW96FJjid7ONQaJDy26aGTZW5EJUr
 D4hs0FTOOE3zSTmgqZosePf7Y9nVmWT2DSoAJDIgiCL9oiHGu/HMkQuqgmecTT3G
 znEX3BW63suLivKy8PKQhMZJos0Qk6Lcijsrnz/iFqQzyA==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctg1ms4wu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 13:54:42 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-79832285fa1so235966247b3.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 06:54:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773150882; cv=none;
 d=google.com; s=arc-20240605;
 b=LQ60I8pZAxz2UzDhRpAsh+R855WcTV/NagTWx9WR/WBqaylEiicQh4oew+MNIHQhIp
 TSAqp4yXOm5S2PxXH7cvTizFneZFMIvHLh8zQA4XpuaQhDSIwfAtdH8JXRbsGhyGYdN0
 UbvUwnzvz+czrlhMT+Bag0UGo5M23kNAAWckBvbwnCintL/JCWx7pRMigIpJiTllOdGk
 nS8n7EclMbckM6QxNouA6LnVQfs3yZez+bjc4kqAZUbmTGhcBZEmAg8xTYIAGbty6Bps
 dc4FgZtpGSR97oBbFXqf/zpO4GY13P6o/R7gba/jQxqlvFQGaDlD77DX/aSOmxrXc/jM
 gPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aF7Odv2lJ2vGs2IQJYdttjTb32bnzpDPKJ5Z+ebKduA=;
 fh=rS2nDwKDt4KjCcoLbfirdIFsUpx1rRdzn3zLrnYLpWM=;
 b=PtYPra+AolILytQqluWjXdCa1Q3ZluQDqkzgIklTaVb7s0ivUL66PopA4O5U4k7JW+
 Es/QexMrt1X+6fordNGzeDlY7x0SyuTjEOZdA4o5uVYZQZJAf6BvicCelIJA4Q2qYF5x
 725vryKe/OoNWOQJm6aS/aFUg8y/DlWM4SZUs/YdDU7tdoOdIIsjNkuEyp1/+YRlcoOv
 KSJLMCbUI/T3ZRyHOwQ1vcaUvki4jkZ4Bc4aj8sb2QiWVHmi9kKDtS/uwmGNuoNkwBPr
 fkPVSgSor69lwgrZOzEIarS2EAMOMVRl+Fx26g4fDZBh52znDSUT2lMQnyeJlYaTYmk0
 WnQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773150882; x=1773755682; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aF7Odv2lJ2vGs2IQJYdttjTb32bnzpDPKJ5Z+ebKduA=;
 b=dxpPxmnMZW4Xf5S1pREePsWrQJqK8avwQaOW1tZi6lwTtzKClogKwpwaEDV3wWMeU/
 7EqbFVJv6JbM8EV3GBv1nbtYvt5CrmXYh67bRyZ3Ra5Zwv4HAtFGsqDKTea1EU66HyAB
 belDGzh5O8BBMmyUBCGOZ4/cNqBFLUgBFPFaopn2gQSAZP3p+28m9k5UFYNsehkfYMaw
 DwiGvT3rpIP3wLLOlgSUPcBVzyrpzBGxWuy9xMBWo41u7aQ8Xxk33XAAWJSIGcVflXd+
 8Wdl4KrZ0IiqBmd2T8qWL1goAx1HEJLLrjdfJfwA37L9FtM8SX2NDgHRptdnKzuybauz
 ScIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773150882; x=1773755682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aF7Odv2lJ2vGs2IQJYdttjTb32bnzpDPKJ5Z+ebKduA=;
 b=wdLS3CoGx5JPLxYvsFIlpvxaFgjS8dcX4H7KRcEafHBJG9jxjFXvrrZeZqxmjBm4yO
 ggorlJmc+f6b0SMJCMLV2nncdRSYh7xKG+cOOdw4J6ed/IkXlYlgV3MbLkyKERnYA4fq
 JRyOEu84Jf9jOuBQ/akmCVRPQG3RFOFFgluogWjdYNlqA8Boa1hVYh52IBC62WbgJXrp
 z+U2pH9XY8B2k1Sc6Ws5YyxY+NYcmNGXGCPG5gf1E/qRH5iFbOjzJG3/Eyyo5u0kSztc
 QJlyasdL0MBeXShqpfzSpeJn2eWgDsQfOdOh3Y9Pjy8nOqUNC+qxX4t1U44DAHouYuW9
 uB+A==
X-Gm-Message-State: AOJu0Yw1CJhKdoUgmQNfy+ibOHDYNYcSiq8KRBCADzkkM67QPAfjoa0c
 tng09GHHxM/lY8gRWAI8XQ72cnUmGgk0IjL99YwOcLBrvWkdQ0dtFgC0b2sWVgwdkFxDxBWPP9r
 oQ3nVIwhDVhDOi+IgwZu6HIuG7X/H4hNa6nKhtC1pzdeVQL4Wgh435cAn63plADfcaOhPNVf+Ng
 Dl5XH/oLUhWdRiwSDtW/i1jt8YoR+j7FHk
X-Gm-Gg: ATEYQzyjn2y1doboFgGmKBCmr7yMRhtmmqQ8i4a7IgdBNYXqgt7645v7Dk+FWQogeIZ
 XImtsP6cHuD4SDqMAO6yyn16B+oXMWQraEPgeyU1sEymfGYGiHqxNJOKiq3z8SYJs56RAOXc/83
 0WYlKcA0l/D0OjQSnZSS5bXIwaxYT/jyMZMSM/SeVTdvto5V1jVzugLHB03hjExwZAQeGHHJePD
 dE8g8M=
X-Received: by 2002:a05:690c:660a:b0:798:83e4:277f with SMTP id
 00721157ae682-798dd6bc387mr145605087b3.27.1773150881806; 
 Tue, 10 Mar 2026 06:54:41 -0700 (PDT)
X-Received: by 2002:a05:690c:660a:b0:798:83e4:277f with SMTP id
 00721157ae682-798dd6bc387mr145604947b3.27.1773150881435; Tue, 10 Mar 2026
 06:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
 <20260309144822.877695-7-brian.cain@oss.qualcomm.com>
 <CAATN3NqyDZN_YJMf96O7cR8wQZXVwiYD9EOM4r4L0xuXmy_VPw@mail.gmail.com>
In-Reply-To: <CAATN3NqyDZN_YJMf96O7cR8wQZXVwiYD9EOM4r4L0xuXmy_VPw@mail.gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 08:54:24 -0500
X-Gm-Features: AaiRm52drOm3bQniH6vkiWFMud02-APzPnh7Xh-vwNqopomkI8X5ya2gX4UAO10
Message-ID: <CAEqNhNZfKOTM1xgD5dVKTNXo+KeaqXQG8AMxJ_zDgo+s0T6S8g@mail.gmail.com>
Subject: Re: [PATCH v4 06/35] target/hexagon: Suppress unused-variable
 warnings for sysemu source regs
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Content-Type: multipart/alternative; boundary="0000000000006be11e064cabdc20"
X-Authority-Analysis: v=2.4 cv=YOeSCBGx c=1 sm=1 tr=0 ts=69b022a2 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=l8KzO_3iDD_WTSiGoLIA:9 a=QEXdDO2ut3YA:10
 a=PVHqBksGuNliZSPbfZ0A:9 a=9-zzTlzzQYVJApvD:21 a=lqcHg5cX4UMA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-ORIG-GUID: B4o3GK30B_EYBmamxZKGwZR0Z5FSx4AT
X-Proofpoint-GUID: B4o3GK30B_EYBmamxZKGwZR0Z5FSx4AT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEyMCBTYWx0ZWRfX1Lytejlx7U34
 +cl7XmdMDPrICOdDR4L+khWXzxKqwe6ZSMu/sbjNbfoaIFrttF2awsFCLsnfzaxdDgJkCtRisU0
 bwkXihgAF6ZH1tme7fkimmT19yx5pOnV62qzleF4kjzaJIWfKYPBvCYP689pz97o3QC4sfXKuGm
 WKmydFe0yDdCoftjYULX6hnx+pd6ovlQqYiA5pbsvaSdpF+gt8DyAGHHfiAObAFfX/80MEHB/+V
 A1gvzxmxOenx39PtaiZzpHnSFKR9cqmpNW5B+y7Wc2g9cCIRD1T8aEHVDA1H0K3X1nz/+iljD3j
 YptmvhRCFo7ySJbFkVo4EuUma16Kb9PgPkZZ9Qf4MQYEQHXGLBFjp/2Qz39aT0s8LLVvmmKJDrz
 PFe4mp4K+fSN0hSAZSqHL+cDTZELyXDzu/ACAZY9BcmPNyKSDWrlb3Y2/3XBwEb3oL9Qz0n4P51
 q7UnFv81UPCUtSTcl/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603100120
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000006be11e064cabdc20
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 12:11=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com>
wrote:

>
>
> On Mon, Mar 9, 2026 at 8:48=E2=80=AFAM Brian Cain <brian.cain@oss.qualcom=
m.com>
> wrote:
>
>> The analyze_read() methods on GuestSource, GuestPairSource,
>> SystemSource, and SystemPairSource were no-ops because these
>> source registers do not need read-tracking in the analyze phase.
>> However, gen_analyze_funcs.py unconditionally declares the
>> register-number variable (e.g. GsN) via decl_reg_num() for all
>> registers that are read or written.  When building with
>> hexagon-softmmu, the generated analyze function bodies are
>> compiled (outside the #ifndef CONFIG_USER_ONLY guard), and the
>> declared-but-unreferenced register-number variable triggers
>> -Werror=3Dunused-variable under both gcc and clang.
>>
>> Emit a (void) cast on the register number from analyze_read() to
>> suppress the warning.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>  target/hexagon/hex_common.py | 16 ++++++++++++----
>>  1 file changed, 12 insertions(+), 4 deletions(-)
>>
>
> Better to declare GsN with G_GNUC_UNUSED.
>

This will be fixed in v5.



>
>

--0000000000006be11e064cabdc20
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 9, 2026 at =
12:11=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.=
com">ltaylorsimpson@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, =
Mar 9, 2026 at 8:48=E2=80=AFAM Brian Cain &lt;<a href=3D"mailto:brian.cain@=
oss.qualcomm.com" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The analyze_=
read() methods on GuestSource, GuestPairSource,<br>
SystemSource, and SystemPairSource were no-ops because these<br>
source registers do not need read-tracking in the analyze phase.<br>
However, gen_analyze_funcs.py unconditionally declares the<br>
register-number variable (e.g. GsN) via decl_reg_num() for all<br>
registers that are read or written.=C2=A0 When building with<br>
hexagon-softmmu, the generated analyze function bodies are<br>
compiled (outside the #ifndef CONFIG_USER_ONLY guard), and the<br>
declared-but-unreferenced register-number variable triggers<br>
-Werror=3Dunused-variable under both gcc and clang.<br>
<br>
Emit a (void) cast on the register number from analyze_read() to<br>
suppress the warning.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/hex_common.py | 16 ++++++++++++----<br>
=C2=A01 file changed, 12 insertions(+), 4 deletions(-)<br></blockquote><div=
><br></div><div>Better to declare GsN with G_GNUC_UNUSED.</div></div></div>=
</blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font=
-family:monospace">This will be fixed in v5.</div><br></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div c=
lass=3D"gmail_quote"><div>=C2=A0</div></div></div>
</blockquote></div></div>

--0000000000006be11e064cabdc20--

