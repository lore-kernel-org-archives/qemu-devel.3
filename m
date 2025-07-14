Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB19AC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 18:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubOKz-00045u-PI; Mon, 14 Jul 2025 14:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ubNE3-00084e-RG
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:44:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ubNE0-0007SF-J7
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:44:27 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGL5LE018725
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 17:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=v0mNUT3t4pJ7WP0OTN3Syjjs
 JCa2JH/LSyxrwHR7jY0=; b=KQ53ejZk9jbfHAOVMnkPzXPElY7mss36/qY5DVY/
 odBMJmrBPBzK3DNfluXrJqk2QCTOmNS0CTfHivwwrn1jpVxFyyP8DwPWXfnVPJB6
 RXfUKWhhiqk2NkeyWgimQOn96cIytLtJqSd6ze9PZ1mbCecPcOqMTAv1xsULIwMV
 eDhhEhrLnlWxHWGl1+YQFwcNN9zICBKt3W4oBDyMu71N3H0L78j8kXb3usUM4PlJ
 qz626/vJzqYz8Xlje9+msdqoPxC1Nx/4n/+H9aB3wglKk/LriSEWeUW6FMv6eQvy
 8LZ8BEBtYe0l8+SibuYtEg+yDqs+euDMAGB8zamauRFa7Q==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu85dus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 17:44:22 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-70e86a2a1b8so70188747b3.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 10:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752515062; x=1753119862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v0mNUT3t4pJ7WP0OTN3SyjjsJCa2JH/LSyxrwHR7jY0=;
 b=DqqJ3lfuVFhP+HShmKwsiTavvo/AXHFrj+4xLbxlew4K9+L/hzuB+wg6E9P5sx3dF7
 b8zUS7XagAeI9b4Kv4Zbls5hScuMPzwfCMktDsRJ5RQoKD2p+DAD9Gcq7mhhCWUIRPLk
 rN+ExyUUFKN+o5GMbY+zLPqgiU7wXmbSGiMbrGW3u7ZuIjBEa9fAtsW8xAk+Lxb1KSRG
 2Lo2QVpkIuoHczVQ+uwS+zLbbAe60nV1EkEIcmIWcnOmMQBtCv3mXfKQoDjqm4ik7PSo
 3jHG5e98muj+R6rNHvBy+adDzYWnUw5tyPI7yRnH9/1UL6FRJGR2Hi/O3rxl9dpkR6v2
 Pk9Q==
X-Gm-Message-State: AOJu0Yzoh6WnXvHb7Hw/x5Z7eCTwTeivaVdeCJJlRevgIbVoZ6QtRGea
 F1N6mxav+0phXcibGAN+T6aO/aKZoRZ3p9+8olZ2UcOuNjKniyMP6mmrXEGXX8iKuLJ6ak98dCP
 +NDEi+Oin+JiT2OwYd+NMcDgCR8xP3V5JoCytJCbwCpAn23WW8aIHMCrDC6mvumDwJk3NfRB5rM
 Py169C5waxkOpkX+t3khrvyhrUyvno66+Vpk1NwnWhx54=
X-Gm-Gg: ASbGnctb4eLr5OStNk4gNrbb4VMerhI+1nt5XUuQW7XjjDJmrrAjXcCgE/1vGr8e9wi
 73PKtQd8eXs3kWcEhFw0qV9bSq+Wc0iZHqvKzkqax6Ea4/HJaDCW+8gsAAS3o7y7GkORXO7RdY9
 vSg7C2VHnt13Vm8hAvLNH1pQ==
X-Received: by 2002:a05:690c:3383:b0:70e:2a0c:bc5 with SMTP id
 00721157ae682-717d5e53c60mr207643467b3.38.1752515062214; 
 Mon, 14 Jul 2025 10:44:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOOJD3eWIQvQNC+s80C7nnM8Vpqu4UMDcml6Rcr4y0x6/LzKPJzvyTqdb2l/fgM1bf2E4DlgiSwvcFgXZfRXc=
X-Received: by 2002:a05:690c:3383:b0:70e:2a0c:bc5 with SMTP id
 00721157ae682-717d5e53c60mr207643097b3.38.1752515061756; Mon, 14 Jul 2025
 10:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250708221438.347643-1-vacha.bhavsar@oss.qualcomm.com>
 <CAFEAcA926Tur8wSvSyMQYJ6XXdiU9mNJZ=weW5x67sJJhjvBtA@mail.gmail.com>
In-Reply-To: <CAFEAcA926Tur8wSvSyMQYJ6XXdiU9mNJZ=weW5x67sJJhjvBtA@mail.gmail.com>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 13:44:10 -0400
X-Gm-Features: Ac12FXyCVBv7QuDmKEU73OMW2k1G1h4l8sDmPUQEKITGLAHlYgFf7K8n5h9GaMk
Message-ID: <CAEWVDmvQ-f-S0m_4cJLHkL=_YFRd_XAsoT9ENqPkirS7S8FMfw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Added support for SME register exposure to GDB
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b848130639e7357a"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDExMSBTYWx0ZWRfX2LL9ae2A/TkG
 NqJJ7ZKrHv+PaLOEwydJfjV+I3QG3PUZ6+wLqPJ6iFhLVbt6m3WzsUWH/oBxlJMniH2mWBIaszY
 Ern42C3DvhhmHdniXfUtYy9U0Z2R5SBh67WDHaL9QAkMeN5XFm69S875iQRVPzLX/hfvu8UcD4Y
 7+jYmcTKsjoedr+xV5rAMFbam+uMFK+2jQI9DRvg6UxtirY3BPHuEpVAn/47eptetft9+ig7Tgr
 v+4b6LKn/BlfqEBuMnTRoUKXD4J8Y0cZ54avbxjHrmGdKXosI2lwfgkPXhMdEUg3JWkVZ3j8Hjf
 ZyMWMFzrbTnwQF+5t0rvsVVH9dL9zKiyEVB6+JE3rG9LI9VSG4DPCUzq8mKZkoUW+CwTRAwax2d
 hX4EaGFGfQgY3+T4H4PgN1OJN86LZL0W7hVW1RhAWrnKAcEuD2l1Tx42P58AW9bY/DzduVjG
X-Proofpoint-ORIG-GUID: vB_D5MUSqhVUm-Cntug92GPgqhOyJ9OM
X-Proofpoint-GUID: vB_D5MUSqhVUm-Cntug92GPgqhOyJ9OM
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=687541f7 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=Wb1JkmetP80A:10 a=CCpqsmhAAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=-xDvZEp21uBOt8-AmmQA:9 a=QEXdDO2ut3YA:10
 a=HjjZBBvkAAAA:8 a=Tx_GloIAqaujV6Ljk-MA:9 a=__uGHG7-Az12UziK:21
 a=lqcHg5cX4UMA:10 a=kA6IBgd4cpdPkAWqgNAz:22 a=ul9cdbp4aOFLsgKbc677:22
 a=cvBusfyB2V15izCimMoJ:22 a=yryXaR-spxf4diMYRkVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140111
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000b848130639e7357a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Thank you for the feedback! I have sent over a revised version of this
patch with appropriate changes. I have removed the unnecessary comments
regarding the zregs, and also corrected the typo, "out our" to "out of" in
the comments. Additionally, I have used aarch64_set_svcr to correctly set
the 64 bit value of SVCR.

Regarding your question on whether the code handling the reading of the ZA
storage would work on a big-endian host, I believe it would. I think this
also applies to the pre-existing SVE code as well, based off of what I have
read from this GDB documentation (
https://sourceware.org/gdb/download/onlinedocs/gdb#Packets) which states
the following:

=E2=80=98P n=E2=80=A6=3Dr=E2=80=A6=E2=80=99
Write register n=E2=80=A6 with value r=E2=80=A6. The register number n is i=
n hexadecimal,
and r=E2=80=A6 contains two hex digits for each byte in the register (targe=
t byte
order).

From this, I believe the QEMU GDB stub is already expecting the register
content in target byte order, leaving this responsibility to the client.
Based on this, I believe the pre-existing SVE code and my SME code should
correctly work on big-endian hosts.

Looking forward to your feedback!

Thanks,
Vacha

On Mon, Jul 14, 2025 at 6:30=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Tue, 8 Jul 2025 at 23:14, Vacha Bhavsar
> <vacha.bhavsar@oss.qualcomm.com> wrote:
> >
> > The QEMU GDB stub does not expose the ZA storage SME register to GDB vi=
a
> > the remote serial protocol, which can be a useful functionality to debu=
g
> SME
> > code. To provide this functionality in Aarch64 target, this patch
> registers the
> > SME register set with the GDB stub. To do so, this patch implements the
> > aarch64_gdb_get_sme_reg() and aarch64_gdb_set_sme_reg() functions to
> > specify how to get and set the SME registers, and the
> > arm_gen_dynamic_smereg_feature() function to generate the target
> > description in XML format to indicate the target architecture supports
> SME.
> > Finally, this patch includes a dyn_smereg_feature structure to hold thi=
s
> > GDB XML description of the SME registers for each CPU.
> >
> > Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
>
>
>
> > +int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg)
> > +{
> > +    ARMCPU *cpu =3D ARM_CPU(cs);
> > +    CPUARMState *env =3D &cpu->env;
> > +
> > +    /* The first 32 registers are the zregs */
> > +    switch (reg) {
> > +    /* The first 32 registers are the zregs */
>
> You don't need the same comment twice, and it also doesn't
> look like it makes sense here, because the zregs are
> SVE regs, not SME regs.
>
> > +    case 0:
> > +    {
> > +        /* cannot set svg via gdbstub */
> > +        return 0;
> > +    }
> > +    case 1:
> > +        env->svcr =3D *buf & 0x03;
>
> This will update env->svcr but won't have the correct effects
> on the CPU (e.g. zeroing the ZA storage); I think you need to
> call aarch64_set_svcr() here. Also you've declared
> SVCR in the XML as a 64-bit register, so you should read it out
> of the buffer as a 64-bit value, not short-cut by reading just
> one byte.
>
> > +        return 8;
> > +    case 2:
> > +        int vq, len =3D 0;
> > +        int svl =3D cpu->sve_max_vq * 16;
> > +        uint64_t *p =3D (uint64_t *) buf;
>
> I know this is what the existing SVE code does, but does
> this really do the right thing on a big-endian host ?
>
> > +        for (int i =3D 0; i < svl; i++) {
> > +            for (vq =3D 0; vq < cpu->sve_max_vq; vq++) {
> > +                env->za_state.za[i].d[vq * 2 + 1] =3D *p++;
> > +                env->za_state.za[i].d[vq * 2] =3D *p++;
> > +                len +=3D 16;
> > +            }
> > +        }
> > +        return len;
> > +    default:
> > +        /* gdbstub asked for something out our range */
>
> "out of"
>
> > +        break;
> > +    }
> > +
> > +    return 0;
> > +}
>
> (PS: I would consider this close enough to being a bugfix to be
> OK with putting it into 10.1 in the first rc cycle or so even
> if it misses softfreeze.)
>
> thanks
> -- PMM
>

--000000000000b848130639e7357a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Peter,<br><br>Thank you for the feedback! I have sent o=
ver a revised version of this patch with appropriate changes. I have remove=
d the unnecessary comments regarding the zregs, and also corrected the typo=
, &quot;out our&quot; to &quot;out of&quot; in the comments. Additionally, =
I have used aarch64_set_svcr to correctly set the 64 bit value of SVCR.<br>=
<br>Regarding your question on whether the code handling the reading of the=
 ZA storage would work on a big-endian host, I believe it would. I think th=
is also applies to the pre-existing SVE code as well, based off of what I h=
ave read from this GDB documentation (<a href=3D"https://sourceware.org/gdb=
/download/onlinedocs/gdb#Packets" target=3D"_blank">https://sourceware.org/=
gdb/download/onlinedocs/gdb#Packets</a>) which states the following:<br><br=
>=E2=80=98P n=E2=80=A6=3Dr=E2=80=A6=E2=80=99<br>Write register n=E2=80=A6 w=
ith value r=E2=80=A6. The register number n is in hexadecimal, and r=E2=80=
=A6 contains two hex digits for each byte in the register (target byte orde=
r).<br><br>From this, I believe the QEMU GDB stub is already expecting the =
register content in target byte order, leaving this responsibility to the c=
lient. Based on this, I believe the pre-existing SVE code and my SME code s=
hould correctly work on big-endian hosts.<br><br>Looking forward to your fe=
edback!<br><br>Thanks,<br>Vacha</div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Mon, Jul 14, 2025 at 6:30=E2=80=AFAM Pete=
r Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank"=
>peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On Tue, 8 Jul 2025 at 23:14, Vacha Bhavsar<br>
&lt;<a href=3D"mailto:vacha.bhavsar@oss.qualcomm.com" target=3D"_blank">vac=
ha.bhavsar@oss.qualcomm.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The QEMU GDB stub does not expose the ZA storage SME register to GDB v=
ia<br>
&gt; the remote serial protocol, which can be a useful functionality to deb=
ug SME<br>
&gt; code. To provide this functionality in Aarch64 target, this patch regi=
sters the<br>
&gt; SME register set with the GDB stub. To do so, this patch implements th=
e<br>
&gt; aarch64_gdb_get_sme_reg() and aarch64_gdb_set_sme_reg() functions to<b=
r>
&gt; specify how to get and set the SME registers, and the<br>
&gt; arm_gen_dynamic_smereg_feature() function to generate the target<br>
&gt; description in XML format to indicate the target architecture supports=
 SME.<br>
&gt; Finally, this patch includes a dyn_smereg_feature structure to hold th=
is<br>
&gt; GDB XML description of the SME registers for each CPU.<br>
&gt;<br>
&gt; Signed-off-by: Vacha Bhavsar &lt;<a href=3D"mailto:vacha.bhavsar@oss.q=
ualcomm.com" target=3D"_blank">vacha.bhavsar@oss.qualcomm.com</a>&gt;<br>
<br>
<br>
<br>
&gt; +int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<br>
&gt; +=C2=A0 =C2=A0 CPUARMState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* The first 32 registers are the zregs */<br>
&gt; +=C2=A0 =C2=A0 switch (reg) {<br>
&gt; +=C2=A0 =C2=A0 /* The first 32 registers are the zregs */<br>
<br>
You don&#39;t need the same comment twice, and it also doesn&#39;t<br>
look like it makes sense here, because the zregs are<br>
SVE regs, not SME regs.<br>
<br>
&gt; +=C2=A0 =C2=A0 case 0:<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* cannot set svg via gdbstub */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 case 1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;svcr =3D *buf &amp; 0x03;<br>
<br>
This will update env-&gt;svcr but won&#39;t have the correct effects<br>
on the CPU (e.g. zeroing the ZA storage); I think you need to<br>
call aarch64_set_svcr() here. Also you&#39;ve declared<br>
SVCR in the XML as a 64-bit register, so you should read it out<br>
of the buffer as a 64-bit value, not short-cut by reading just<br>
one byte.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 8;<br>
&gt; +=C2=A0 =C2=A0 case 2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int vq, len =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int svl =3D cpu-&gt;sve_max_vq * 16;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *p =3D (uint64_t *) buf;<br>
<br>
I know this is what the existing SVE code does, but does<br>
this really do the right thing on a big-endian host ?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int i =3D 0; i &lt; svl; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (vq =3D 0; vq &lt; cpu-=
&gt;sve_max_vq; vq++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;<a hr=
ef=3D"http://za_state.za" rel=3D"noreferrer" target=3D"_blank">za_state.za<=
/a>[i].d[vq * 2 + 1] =3D *p++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;<a hr=
ef=3D"http://za_state.za" rel=3D"noreferrer" target=3D"_blank">za_state.za<=
/a>[i].d[vq * 2] =3D *p++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D 16;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* gdbstub asked for something out our ra=
nge */<br>
<br>
&quot;out of&quot;<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
<br>
(PS: I would consider this close enough to being a bugfix to be<br>
OK with putting it into 10.1 in the first rc cycle or so even<br>
if it misses softfreeze.)<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000b848130639e7357a--

