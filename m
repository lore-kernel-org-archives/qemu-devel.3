Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEA2C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 21:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udxwq-0003O1-I1; Mon, 21 Jul 2025 17:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1udxvs-0001rc-0q
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 17:20:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1udxvW-0002mx-8w
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 17:20:05 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LGtf1A000926
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 21:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=JssYDSr7IY2zcFNDNLBhEx24
 PNrJgt0ER5Z8R6R1hng=; b=U3gWUv/QGnpCPsuI1lkigCE2FWLwk7L5E4Zx2szK
 NiDrwDd9P4wz2HJ+RhldGdDE0f3gNID4zfs8XIwR1V7AsxrSTcSlyA0Of3JuN+D/
 rt7yKxAWfPSnnuzZGfQXVMxtLrS7n3TtrTfU59TVxmI2PLYxbyWX4DoK7rS+VcLb
 vOCzS5dHudl8+LJEK3rnTcAfFkM68G0V6khVyOJnPIXLSXdOGW4XhobEoHXNVSxn
 RxkrXq3lGc2c9fWlotnqBXCFvzGvaKaT3XlkuDY1JCneQeYDPWHYvkCwOIHh11Ao
 uupbsGMFqeKivjj/SAf3x2Kfth3k7MZshbrI+KDqt/TA2w==
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044df4f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 21:20:00 +0000 (GMT)
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-e8bb5b1a519so5781962276.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 14:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753132799; x=1753737599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JssYDSr7IY2zcFNDNLBhEx24PNrJgt0ER5Z8R6R1hng=;
 b=oMLzgMNuONASCLfWqQWqOmrqszCinTc8F+p/zl31QBpNFOTlBq35E/DzKXNDQRGN09
 b1D3+pg6L5NardERVb3/YQ7AtXnbBmSStdYNZgNeMOTXdcYz1cPWCxFTRsA+0Q+4bFGM
 hLDdfxnJE5JNFmWQASMT5IPT/RN+083e37Gwm1goUC5ibAFVCtQ3oitrl+n/V8dPVU4r
 4SNxQDLsf4AuO0fwqf7IY079LMiq+lN6gcAEl+PhCCNq/TPxjeCWnLIhTaq2nak/j+3x
 ne6EUtxFLmydGqfVtpH7xpXxzPreXOhNmwQifQ88EnfpSK+MfL8wqKSH8GkXmsGD0AVu
 6G0A==
X-Gm-Message-State: AOJu0YyqQmi6S+6oHQgOaZMFeC6gGpCRtcWazqjFevxnvcIS2ho4j5xD
 DhEP+JI7ZRdsaVXIE4tTyjKoUa5BD6hFW9S05V31o4j8IdjpJBKcpPJ3HLvM5bG8OsI0+Z7J+Dl
 Kmb9t+BygwjD+nNdJHB1YA7EBjDTrOy7xHzTMd78vrdF37G01jMl66k3m8fG9waEfSgCsVBHsXP
 Z5qanyOZrhhW7N3RViitHg5RqKc9OHeJw/
X-Gm-Gg: ASbGnctSnDmsjyP46DnBgyKM4C58PAcbwnValWFsnuuJL4DkS9skjQu8fPIGIaefclI
 XewbUh8MzHxHBRmRaqYmcC/sVQfvmkhj/ncAeXJ2y8rSJB2F2CqlFHlV+PkBlrLsF33VNp3bW+x
 +P8X57ejmlntBT8NlN5/fyknA=
X-Received: by 2002:a05:6902:220d:b0:e8b:7491:d4e9 with SMTP id
 3f1490d57ef6-e8bc24e7a93mr27923061276.26.1753132799549; 
 Mon, 21 Jul 2025 14:19:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF23gdmZi5Zt7+chkqHIJQBIt71uoyBg76l3e2VPCDMRnSzms4zs9wgx+O5Y5/Riw4hYk6yTFSRBEz3WlAUk4=
X-Received: by 2002:a05:6902:220d:b0:e8b:7491:d4e9 with SMTP id
 3f1490d57ef6-e8bc24e7a93mr27923036276.26.1753132799192; Mon, 21 Jul 2025
 14:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAEWVDmuS0RSwZiDGNZg4cT1jXp7Xfu97YZL7hDfTvha2TOgS1g@mail.gmail.com>
 <CAFEAcA9u2N2GsWZ+eFuqezqCPj9hWGT=qGnwjjG3M5NYO9Jb5A@mail.gmail.com>
In-Reply-To: <CAFEAcA9u2N2GsWZ+eFuqezqCPj9hWGT=qGnwjjG3M5NYO9Jb5A@mail.gmail.com>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 17:19:48 -0400
X-Gm-Features: Ac12FXyTAnUD5Efo-kAjeKPZdiEPYyAZHV15T0vU0B0oF6X0XD01WyJAFBPAovM
Message-ID: <CAEWVDmsqjN+KiRp3AC3uht1=xoQDu2+sHVZKVdDyMPBRThZFkg@mail.gmail.com>
Subject: Re: [RFC] target/arm: Concerns about mixed endian support for remote
 GDB
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000bd871e063a770921"
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687eaf00 cx=c_pps
 a=peiObFy/9J5zY6vzkL/ViA==:117 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=XuKpq1OSl9U7Vqusa7AA:9 a=QEXdDO2ut3YA:10
 a=G78pyL7yVTk7Gtk_Gy4A:9 a=C5rqynb0f5RdBcmA:21 a=lqcHg5cX4UMA:10
 a=uSskPZdq7w8du69dlLff:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: yU0PZGYOirAr_B98YowbJ7CQCW6K30MZ
X-Proofpoint-ORIG-GUID: yU0PZGYOirAr_B98YowbJ7CQCW6K30MZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE5MCBTYWx0ZWRfX2BBG8JvtOh+d
 XTcoI6Hpa+PlEpcS4bYtmTqpYzBbgoeoTYgnwxd73XeVM8Js79V4fge6q+YPByL5OGIoPFVnBAB
 gxAwCfin8T42PJSZFW7FZljBrSclpVxlcywgInFbBPZY15Zgr1YqvTqwMHIpDBPkMD7qQI/qLsC
 J9lZwVJhsOiPlzuqZnXsIiKnbU6LLlo1a7jzSDYmA4Cru7p1iMZuxSX40bjcrNua0z+ztZrzP/c
 NTKV70Kivzu55Fy5OFFj4twRKYxoxhJI9jmSmKdiRyoh+IBCgLfmQBsPBpfIFtzokkDgdw7JKgP
 Paunogch1XjLqInzSa02Q2Bi2MHXaGDETpZSvzFhPwbr9NoBdS+ils0vWsB8nU4Hg/+G7DiTqw2
 SFIhMhZj6tsy7fZSckygEgoe7gZ9lvSW4MCUpr6iizi5YiDXgpeV+m3x2Cz1t5UGg3vjxIkM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=856 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210190
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000bd871e063a770921
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

I am using the user mode emulator to test the "target big endian" code path=
.

I apologize for the error, I have sent this content as a patch series to
make it easier to review!

Looking forward to your feedback!

Thanks,
Vacha

On Mon, Jul 21, 2025 at 10:36=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org>
wrote:

> On Fri, 18 Jul 2025 at 20:20, Vacha Bhavsar
> <vacha.bhavsar@oss.qualcomm.com> wrote:
> >
> > Upon examining the current implementation for getting/setting SIMD
> > and SVE registers via remote GDB, there is a concern about mixed
> > endian support.
>
> Yes, we discussed this on a different thread.
>
> > The current implementation for the SIMD functionality for getting and
> setting
> > registers via the gdbstub is implemented as follows:
> >
> > aarch64_gdb_set_fpu_reg:
> > <omitted code>
> > uint64_t *q =3D aa64_vfp_qreg(env, reg);
> > q[0] =3D ldq_le_p(buf);
> > q[1] =3D ldq_le_p(buf + 8);
> > return 16;
> > <omitted code>
> >
> > The following code is a suggested fix for the current implementation th=
at
> > should allow for mixed endian support for getting/setting SIMD register=
s
> > via the remote GDB protocol.
> >
> > aarch64_gdb_set_fpu_reg:
> > <omitted code>
> > // case 0...31
>
> It would be easier to review your proposed changes if you'd
> sent them in a proper patch format...
>
> > uint64_t *q =3D aa64_vfp_qreg(env, reg);
> > if (target_big_endian()){
>
> What config are you using to test this "target big endian"
> code path? On system emulation target/arm is *always*
> target_big_endian() =3D=3D false (even if CPSR.E is set).
> The QEMU "target endianness" is a compile-time property of the
> system, not a runtime property of the CPU. CPSR.E just causes us to
> byteswap values as they go out from the CPU to the memory subsystem.
>
> I think for the user mode emulator aarch64_be-linux-user
> we may have target_big_endian() true, but I forget. BE
> linux-user is pretty unmaintained...
>
> > q[1] =3D ldq_p(buf);
> >         q[0] =3D ldq_p(buf + 8);
> > }
> > else{
> > q[0] =3D ldq_p(buf);
> >         q[1] =3D ldq_p(buf);
>
> (You're loading q[0] and q[1] from the same buffer address here.)
>
> > }> return 16;
> > <omitted code>
> >
> > This use of ldq_p rather than ldq_le_p (which the current implementatio=
n
> > uses) to load bytes into host endian struct is inspired by the current
> > implementation for getting/setting general purpose registers via remote
> > GDB (which works appropriately regardless of target endianness), as wel=
l
> > as the current implementation for getting/setting gprs via GDB with ppc
> > as a target (refer to ppc_cpu_gdb_write_register() for example).
>
> Note that for PPC, we build both ppc64-softmmu and ppc64le-softmmu config=
s,
> so for PPC target_endianness() really can be either LE or BE even
> in system emulation mode.
>
> > For SVE, the current implementation is as follows for the zregs:
> >
> > aarch64_gdb_set_sve_reg:
> > <omitted code>
> > // case 0...31
> > int vq, len =3D 0;
> > uint64_t *p =3D (uint64_t *) buf;
> > for (vq =3D 0; vq < cpu->sve_max_vq; vq++) {
> > env->vfp.zregs[reg].d[vq * 2 + 1] =3D *p++;
> >         env->vfp.zregs[reg].d[vq * 2] =3D *p++;
> >         len +=3D 16;
> > }
>
> This code definitely is wrong, because the gdbstub protocol buffer
> is target-endianness and the env->vfp.zregs values are host-endianness.
>
> thanks
> -- PMM
>

--000000000000bd871e063a770921
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Peter,<div><br></div><div>I am using the user mode emul=
ator to test the &quot;target big endian&quot; code path.</div><div><br></d=
iv><div>I apologize for the error, I have sent this content=C2=A0as a patch=
 series to make it easier to review!</div><div><br></div><div>Looking forwa=
rd to your feedback!</div><div><br></div><div>Thanks,</div><div>Vacha</div>=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Mon, Jul 21, 2025 at 10:36=E2=80=AFAM Peter Maydel=
l &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n Fri, 18 Jul 2025 at 20:20, Vacha Bhavsar<br>
&lt;<a href=3D"mailto:vacha.bhavsar@oss.qualcomm.com" target=3D"_blank">vac=
ha.bhavsar@oss.qualcomm.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Upon examining the current implementation for getting/setting SIMD<br>
&gt; and SVE registers via remote GDB, there is a concern about mixed<br>
&gt; endian support.<br>
<br>
Yes, we discussed this on a different thread.<br>
<br>
&gt; The current implementation for the SIMD functionality for getting and =
setting<br>
&gt; registers via the gdbstub is implemented as follows:<br>
&gt;<br>
&gt; aarch64_gdb_set_fpu_reg:<br>
&gt; &lt;omitted code&gt;<br>
&gt; uint64_t *q =3D aa64_vfp_qreg(env, reg);<br>
&gt; q[0] =3D ldq_le_p(buf);<br>
&gt; q[1] =3D ldq_le_p(buf + 8);<br>
&gt; return 16;<br>
&gt; &lt;omitted code&gt;<br>
&gt;<br>
&gt; The following code is a suggested fix for the current implementation t=
hat<br>
&gt; should allow for mixed endian support for getting/setting SIMD registe=
rs<br>
&gt; via the remote GDB protocol.<br>
&gt;<br>
&gt; aarch64_gdb_set_fpu_reg:<br>
&gt; &lt;omitted code&gt;<br>
&gt; // case 0...31<br>
<br>
It would be easier to review your proposed changes if you&#39;d<br>
sent them in a proper patch format...<br>
<br>
&gt; uint64_t *q =3D aa64_vfp_qreg(env, reg);<br>
&gt; if (target_big_endian()){<br>
<br>
What config are you using to test this &quot;target big endian&quot;<br>
code path? On system emulation target/arm is *always*<br>
target_big_endian() =3D=3D false (even if CPSR.E is set).<br>
The QEMU &quot;target endianness&quot; is a compile-time property of the<br=
>
system, not a runtime property of the CPU. CPSR.E just causes us to<br>
byteswap values as they go out from the CPU to the memory subsystem.<br>
<br>
I think for the user mode emulator aarch64_be-linux-user<br>
we may have target_big_endian() true, but I forget. BE<br>
linux-user is pretty unmaintained...<br>
<br>
&gt; q[1] =3D ldq_p(buf);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0q[0] =3D ldq_p(buf + 8);<br>
&gt; }<br>
&gt; else{<br>
&gt; q[0] =3D ldq_p(buf);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0q[1] =3D ldq_p(buf);<br>
<br>
(You&#39;re loading q[0] and q[1] from the same buffer address here.)<br>
<br>
&gt; }&gt; return 16;<br>
&gt; &lt;omitted code&gt;<br>
&gt;<br>
&gt; This use of ldq_p rather than ldq_le_p (which the current implementati=
on<br>
&gt; uses) to load bytes into host endian struct is inspired by the current=
<br>
&gt; implementation for getting/setting general purpose registers via remot=
e<br>
&gt; GDB (which works appropriately regardless of target endianness), as we=
ll<br>
&gt; as the current implementation for getting/setting gprs via GDB with pp=
c<br>
&gt; as a target (refer to ppc_cpu_gdb_write_register() for example).<br>
<br>
Note that for PPC, we build both ppc64-softmmu and ppc64le-softmmu configs,=
<br>
so for PPC target_endianness() really can be either LE or BE even<br>
in system emulation mode.<br>
<br>
&gt; For SVE, the current implementation is as follows for the zregs:<br>
&gt;<br>
&gt; aarch64_gdb_set_sve_reg:<br>
&gt; &lt;omitted code&gt;<br>
&gt; // case 0...31<br>
&gt; int vq, len =3D 0;<br>
&gt; uint64_t *p =3D (uint64_t *) buf;<br>
&gt; for (vq =3D 0; vq &lt; cpu-&gt;sve_max_vq; vq++) {<br>
&gt; env-&gt;vfp.zregs[reg].d[vq * 2 + 1] =3D *p++;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;vfp.zregs[reg].d[vq * 2] =3D =
*p++;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len +=3D 16;<br>
&gt; }<br>
<br>
This code definitely is wrong, because the gdbstub protocol buffer<br>
is target-endianness and the env-&gt;vfp.zregs values are host-endianness.<=
br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000bd871e063a770921--

