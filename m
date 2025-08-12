Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0921ECA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 19:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uluj9-0004SC-CO; Tue, 12 Aug 2025 15:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uluj0-0004Qu-VW
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 15:31:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uluip-0003LS-0Y
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 15:31:58 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CH6TEX010796
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 19:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=YYaasBngXKjjx1M6VasJ697+
 mhkQU7i8Wd4wpoSGpnI=; b=pH9a3QywK5a+kit/IgGhSaabjmO9hXLD2suxSka+
 TVpYKPTCWjSK+7ZpaDvPMOSy6TD2gBLUxaAu6yUgzy3OPMnQjbTYfZNJUEEGilTI
 kf0f2gP6pbw60W7KM1FImj/nV14Lq8pNQhAxdti20HobBtnC2mY/dk1yODfVDcq7
 WUIiU8GNwrBrA1WZxadaJCP5j61jHRYJoefv1c3ESlsvMOQkSUCoM09jOtj6rN+D
 5NSO9DYJaXRn2TitF/gq+59swHxUT4aH9wWT2UvMvC0iWgEtbWb7gnEugAabERA1
 nI8nwm/cBfRwwV72F7tPyYhhi/1hS3rcb1ZPeSJ+LOFmpQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g9q9rd8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 19:31:41 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-71c031dc52fso51309057b3.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 12:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755027101; x=1755631901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YYaasBngXKjjx1M6VasJ697+mhkQU7i8Wd4wpoSGpnI=;
 b=VYtv1E06UzpuZKzvOM27inyNK+pALCIKub5K3be1OaMhKloz0yRmIxk86HBhiseXYK
 EpEnN31LT6ILvBQotrUGpA4FeQX5p2eJjRm3ur4j3ONeTqGZz6bYU+NuW8i6wLqZdJ3M
 ayDzcWn660LtlKSNd6b12NL1NS8LKR7muvFHwzDT0SyGcGHvMGgKiZ3hfI8soCGmVQeN
 ZeQU+BYO2i8v73MxPT8kuQpDr6S3cJzarswdHSSAc6e2UXuMXY9aozk0/A1iLXzUH7Gv
 nIvFtPBSYik/wngPRBYa+eYJTLQfy8aCZf+ckTxVaxD8oEFtRLj7Wq0NqTZgss34JTyA
 ZGDQ==
X-Gm-Message-State: AOJu0Yx9ph1b0UFhn8phDuIdKnEDxULVcAvoAkhfEWSXY4p1JMl+lzcq
 VFSbf3ftExtekeUmZwZsW3E5tz3RkVVg7hi9wqjsbYpPm9vZPT1UvNdQvO1R//Pix/XBWdPVJIK
 TPfKEDqpRntODu7d6BENIPjUIbVlNZi1l0cWQnGcUGgQvqMvUrSBFsZ0Oq6eA4BAU34N30b8XHg
 9Giq8dJaCX2IVNkg7dIYLvEBg7aM0O+kp5
X-Gm-Gg: ASbGnctr37SlUAjOzPfQ70E3gSA6XWkVI7/5+KJNLmNMSfScSVBsapn3JrdECkTkxal
 y2t+M2v5b7bZgdZLzBmZ/PPyrJdyTdLBQCwMk5c4grJhRDdNoV+ZonLia63SptSX+SC1ACZaTry
 Nj+3RXIipmSDIiBdNoXgDu9w==
X-Received: by 2002:a05:690c:64c6:b0:71b:f755:bbab with SMTP id
 00721157ae682-71d4e44c6e1mr4675097b3.14.1755027100604; 
 Tue, 12 Aug 2025 12:31:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH635BmBnLElSUA4UIMuFSrd1ufSJQbCuiM45+CJV5kjGOEL5rMcQOGeU5F4Ov1GFW2BjrLICdbkk6li1OwlZk=
X-Received: by 2002:a05:690c:64c6:b0:71b:f755:bbab with SMTP id
 00721157ae682-71d4e44c6e1mr4674787b3.14.1755027100060; Tue, 12 Aug 2025
 12:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250811193654.4012878-1-vacha.bhavsar@oss.qualcomm.com>
 <20250811193654.4012878-3-vacha.bhavsar@oss.qualcomm.com>
 <CAFEAcA9PXtsj5nAZ47Fv3h5gDdir_QT5pavUF6-Yc1tZZP26ag@mail.gmail.com>
In-Reply-To: <CAFEAcA9PXtsj5nAZ47Fv3h5gDdir_QT5pavUF6-Yc1tZZP26ag@mail.gmail.com>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 15:31:29 -0400
X-Gm-Features: Ac12FXxsZQ9N_2v0hfqET1SRiQYZq2Z5tNmHPDID2f8XbIdaNxC6WtxIOtUrrd0
Message-ID: <CAEWVDmtNm+AZs_+YvXvOFn37nNJ1GDwo-9mEEbynsdPT-bTD0g@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] target/arm: Change GDBState's line_buf to a GString
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000dee974063c301616"
X-Authority-Analysis: v=2.4 cv=CNMqXQrD c=1 sm=1 tr=0 ts=689b969d cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=G6NPWgVwcJKO82ZUuSAA:9 a=QEXdDO2ut3YA:10
 a=tDyR_WS0kGeW7OT8YLMA:9 a=Z44rsDyPwT4x3bYm:21 a=lqcHg5cX4UMA:10
 a=kLokIza1BN8a-hAJ3hfR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 2OG0i6y4Ds84VAxKRdyhHGU02Ho9ENWe
X-Proofpoint-ORIG-GUID: 2OG0i6y4Ds84VAxKRdyhHGU02Ho9ENWe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfX7VIvh/9qFe27
 X8BRS970eKdbzN8B4smVtRQmqUs7t41ZBmU4Ol0BAzbLHuae3Npe4m/orWfsWJVbRFdNMAtjY66
 oxghdufqFUDouAe0daJqgCO9nDpaSBP2ruRfdVE5LiZA8L9BQ12iWOaFIsk1w0g/UlZGxDXmsw9
 9muitpf2LU3R9iV0p9U9vqSIUR1vMBA97IhRIw2O7U7PKryx//r1f32JDCQgf/TOLe7aZEY1ZP9
 VLrvMAb1iVzipZ6leaH5g29oEO4B6OepVmQeRI9OnEcEzVL8xS2C1aPimfvCrA5Ardjudf3O4UU
 669rxWB7ffF59bJgrVoQVg2iKvp6flQVr+ZnBh4bhj1LIZLcuyWyKUm1EnyMBB+sLgha+CTr9/R
 cLAm81ho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

--000000000000dee974063c301616
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,



Since this change does not directly impact the original concern

for adding SME register exposure to remote GDB (for which

the resizing of MAX_PACKET_LENGTH is sufficient), may we leave

this patch open to further discussion while the others go through

with review?



Thanks,

Vacha

On Tue, Aug 12, 2025 at 7:33=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Mon, 11 Aug 2025 at 20:37, Vacha Bhavsar
> <vacha.bhavsar@oss.qualcomm.com> wrote:
> >
> > This patch changes GDBState's line_buf from a character
> > array to a GString. This allows line_buf to be dynamically
> > re-sizeable.
> >
> > Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
> > ---
> > Changes since v4:
> > - this patch was not present in v4, it has been added as
> > suggested during review of v4
> > ---
>
> Note that since the GDBState is a file-local variable,
> not allocated on the stack, it's not an issue that
> line_buf[MAX_PACKET_LENGTH] is large. So whether we
> make this change I think should be based on whether
> it makes the code easier to read and less likely to
> contain string buffer manipulation bugs.
>
>
> > -                if (gdbserver_state.line_buf_index + repeat >=3D >
> sizeof(gdbserver_state.line_buf) - 1) {
> > +                if (gdbserver_state.line_buf->len + repeat >=3D
> MAX_PACKET_LENGTH) {
> >                      /* that many repeats would overrun the command
> buffer */
>
> This comment no longer makes sense if we don't have a
> fixed command buffer. In general, if we're moving away
> from a fixed-sized buffer we should consider what we
> want to do in all the various places that are currently
> doing checks against MAX_PACKET_LENGTH.
>
> thanks
> -- PMM
>

--000000000000dee974063c301616
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Hi,</p><p>=C2=A0</p><p>Since this change does not direc=
tly impact the original concern</p><p>for adding SME register exposure to r=
emote GDB (for which</p><p>the resizing of MAX_PACKET_LENGTH is sufficient)=
, may we leave</p><p>this patch open to further discussion while the others=
 go through</p><p>with review?</p><p>=C2=A0</p><p>Thanks,</p><p>Vacha</p></=
div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Tue, Aug 12, 2025 at 7:33=E2=80=AFAM Peter Maydell &=
lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On M=
on, 11 Aug 2025 at 20:37, Vacha Bhavsar<br>
&lt;<a href=3D"mailto:vacha.bhavsar@oss.qualcomm.com" target=3D"_blank">vac=
ha.bhavsar@oss.qualcomm.com</a>&gt; wrote:<br>
&gt;<br>
&gt; This patch changes GDBState&#39;s line_buf from a character<br>
&gt; array to a GString. This allows line_buf to be dynamically<br>
&gt; re-sizeable.<br>
&gt;<br>
&gt; Signed-off-by: Vacha Bhavsar &lt;<a href=3D"mailto:vacha.bhavsar@oss.q=
ualcomm.com" target=3D"_blank">vacha.bhavsar@oss.qualcomm.com</a>&gt;<br>
&gt; ---<br>
&gt; Changes since v4:<br>
&gt; - this patch was not present in v4, it has been added as<br>
&gt; suggested during review of v4<br>
&gt; ---<br>
<br>
Note that since the GDBState is a file-local variable,<br>
not allocated on the stack, it&#39;s not an issue that<br>
line_buf[MAX_PACKET_LENGTH] is large. So whether we<br>
make this change I think should be based on whether<br>
it makes the code easier to read and less likely to<br>
contain string buffer manipulation bugs.<br>
<br>
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gdbserver=
_state.line_buf_index + repeat &gt;=3D &gt; sizeof(gdbserver_state.line_buf=
) - 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gdbserver=
_state.line_buf-&gt;len + repeat &gt;=3D MAX_PACKET_LENGTH) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* that many repeats would overrun the command buffer */<br>
<br>
This comment no longer makes sense if we don&#39;t have a<br>
fixed command buffer. In general, if we&#39;re moving away<br>
from a fixed-sized buffer we should consider what we<br>
want to do in all the various places that are currently<br>
doing checks against MAX_PACKET_LENGTH.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000dee974063c301616--

