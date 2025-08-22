Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EC8CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 17:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upVdH-00016Y-IX; Fri, 22 Aug 2025 13:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1upVdE-00015t-OP
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 13:32:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1upVd9-0007ST-GT
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 13:32:52 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MHUls1012275
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 17:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=JX5SrrUdSCZOUreW0qPwoMF4
 RofeXyMdUexDWfFZs8A=; b=dCMw5CWKplRZ5Xf2/JtF/Zpi+j02HzFzoxNAC1en
 nYGlg+giR0WtPAxQkCiQL7ua+L6EbaAEAaFSxpLnjc5/LFxdrzlnxKOyGePvgxMg
 1qPczJ1htWy2m4KF0+5RFQXFD+5zJwIFzcJPyjzqEWE5ZUyM5wh6NcLSYeTwTRpw
 Nnli4No96qMHYvmcK2+y72urfhf/GblMlZuOv7Vyevzz82sr8tnv4VdXEa6uZCSz
 z8y7MotL8Zt3aE51zinBDe+muejIopE2IEjNaWORGgm5TBj2577j7quf+c1VymO8
 Y4KZFeBxhlK6ZU2tWqr0LCrDyU69dCgthA9E0j2q4gDWZg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48pw11006d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 17:32:40 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-71e6dd71698so34571737b3.2
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 10:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755883960; x=1756488760;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JX5SrrUdSCZOUreW0qPwoMF4RofeXyMdUexDWfFZs8A=;
 b=muQSoWzkcUGz55wSGR4MXVcn325ypELcKp4Q+e1iwD1VelMNj7wQwKRcgte9kILlpF
 OTiwC7FX97JoOi9mD/86lr+5Tv8BFeKAbTxz9SINqrOMhrggzrXDNGCmhXM3n6fcMfCg
 nvZjW9+P3GTAfnkyDsSYpBfBBSFu0fcq1GMP5l6ovXIE2uBhHxTxldJeumylwNpsP4+H
 C7Q+C5b/pW+p3jKh7WnGrW60FF7cqO3wvmurbps+AZaI7FXC9FeP0mYgnzB5L4uY8hyK
 3OJKxzkyhyAQB1DpZwuOSzZyZ+Dp9Nmz0Dg+xFoh9agZrlHjuXcoySvD+NrSRR50mrt2
 D9WA==
X-Gm-Message-State: AOJu0Yx/a2iBzDoKfe91BIfBOyQ5lHsX1NwRaAcaGavYZUgyW1gbkCQb
 TAcmN5jxYonRQqlw9+0OCXQPxHgRZhC/NTr+MllsHpVLTT9eXmx5w0uDMqeSLc0cXpzyO7WJ5ts
 J3QAQmKrRTySZLhydHnxWPwvvwrqQxxbVv5JmSHOLOpwCCDaSS9vJlN2OQqkiHiW1bOz+VnDlYJ
 qk4tTNUI78ox+GEo1C794sjzvk4BCdJxY4
X-Gm-Gg: ASbGncv5P0xhUWGVH92D28ixtJ/SQtDiZwG1m3vPB82ZmjnrFEbdzZ9sKnO+ua/reW+
 xsf8Ex9z7xLYeG8pDdlK7cyGUqvasXw44qmsoTe2CmPGy3sDAd2h/gJHYMMkTURTm7v9QNpowod
 QlDQ+f7FuEhCCZvjUiSWbiTpE=
X-Received: by 2002:a05:690c:7401:b0:71f:96b6:370d with SMTP id
 00721157ae682-71fdc56653fmr37186367b3.43.1755883960059; 
 Fri, 22 Aug 2025 10:32:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRlo9X5TWsvsD9T4GiB7l/PxDveCQJjd3APMpZimE86qqLbd0lNz32BRmYq7FWsQrdjQGNrsM/ba2AR4MkGBo=
X-Received: by 2002:a05:690c:7401:b0:71f:96b6:370d with SMTP id
 00721157ae682-71fdc56653fmr37185907b3.43.1755883959463; Fri, 22 Aug 2025
 10:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250811193654.4012878-1-vacha.bhavsar@oss.qualcomm.com>
 <20250811193654.4012878-5-vacha.bhavsar@oss.qualcomm.com>
 <CAFEAcA8FchF06dGdixBwY8GWSF3kREuL72ZmeyG_cYqzAmuEjA@mail.gmail.com>
In-Reply-To: <CAFEAcA8FchF06dGdixBwY8GWSF3kREuL72ZmeyG_cYqzAmuEjA@mail.gmail.com>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 13:32:28 -0400
X-Gm-Features: Ac12FXxdxyoi14IzS2BP4n_oiF4C-PYORqOCduW3r2CldAmvWAtc1y1-6JGZ75k
Message-ID: <CAEWVDmsqgrnXgte0Sb+uzHmu=jHkXWvfHhYme-9hwng3XvrwVA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] target/arm: Added test case for SME register
 exposure
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000abcaec063cf7970b"
X-Proofpoint-GUID: gQITU-oQyC5ykECmcHcLqqg9YtekyVM_
X-Authority-Analysis: v=2.4 cv=I6dlRMgg c=1 sm=1 tr=0 ts=68a8a9b8 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=N8Y_t98UrGyp6rbt4BQA:9 a=QEXdDO2ut3YA:10
 a=Jh5nBCchH6AuH4sgvLcA:9 a=EmIINo0mkmH8z9NT:21 a=lqcHg5cX4UMA:10
 a=kLokIza1BN8a-hAJ3hfR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDE2MCBTYWx0ZWRfX01NXFqHgyqUG
 amcAJppbVErDYaFAfBaUNbTvDkKT0jrvDtLDGAl1W4/Y59/GBZYtNRIhtAjY9frzsKM5bMfpISl
 AwBFddfDfHdmPvOxsaIT4meJHXVc2nDuTyhDNjngBjLv9Al0vGj5oQo9/XYkKt4uWFcJn/Ml2K3
 nSDbOaU7sBweFOZlACAWQcqEQ190EaI7iE7YSQzGDFugpV1pnedrXLWUIJA/Ng6EbZEgYfwhNBl
 7icsCiwi3ycUimVQuvl/M3ly1yFO40W4hnHJlTm/o7Fd5FAXyhp+cMQOy0Egk8lH/7bUXgUjCN8
 +JtspnaYBcYCOeCu7itJIUO0gAjfLjBg7Lczqdi7cxYkvlwpdwPWKYNaNgQqDPN1EpYcZfgOvta
 Txne5HW9
X-Proofpoint-ORIG-GUID: gQITU-oQyC5ykECmcHcLqqg9YtekyVM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508220160
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000abcaec063cf7970b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We have tried to replicate this issue on our end and it
seems to stem from the int casting of gdb.Value type of
a 128bit integer. We have run the test with different
host architectures, gdb versions and python versions
both with and without the int casting. The results are
as follows.

gdb     gdb target           python   host          int cast status
version support              version  architecture
16.3 --enable-targets=3Dall 3.11.13   x86        yes        pass
16.3 --enable-targets=3Dall 3.11.13   x86         no        pass
16.3 --enable-targets=3Dall 3.10.18   x86        yes        pass
16.3 --enable-targets=3Dall 3.10.18   x86         no        pass
16.3 --enable-targets=3Dall 3.8.10    x86        yes        pass
16.3 --enable-targets=3Dall 3.8.10    x86          no        pass

16.3 aarch64             3.11.0rc1 aarch64      yes        pass
16.3 aarch64             3.11.0rc1 aarch64       no        pass
16.3 aarch64             3.10.12   aarch64      yes        pass
16.3 aarch64             3.10.12   aarch64       no        pass

15.0 multiarch           3.10.12   aarch64      yes        fail
15.0 multiarch           3.10.12   aarch64      no        pass
15.0 multiarch          3.11.0rc1 aarch64      yes        fail
15.0 multiarch          3.11.0rc1 aarch64      no        pass

15.0 multiarch          3.8.10      x86            yes        fail
15.0 multiarch          3.8.10      x86             no        pass
15.0 multiarch        3.11.13      x86            yes        fail
15.0 multiarch        3.11.13      x86             no        pass
15.0 multiarch        3.10.18      x86            yes        fail
15.0 multiarch        3.10.18     x86             no        pass

Could we get some more information about your testing environment?

Thanks,
Vacha

On Tue, Aug 19, 2025 at 5:13=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Mon, 11 Aug 2025 at 20:37, Vacha Bhavsar
> <vacha.bhavsar@oss.qualcomm.com> wrote:
> >
> > This patch adds a test case to test SME register exposure to
> > a remote gdb debugging session. This test simply sets and
> > reads SME registers.
> >
> > Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
> > ---
> > Changes since v4:
> > - this patch was not present in v4, it was added based on
> > suggestions during the review of v4
> > ---
> >  configure                             |   6 ++
> >  tests/tcg/aarch64/Makefile.target     |  23 ++++-
> >  tests/tcg/aarch64/gdbstub/test-sme.py | 119 ++++++++++++++++++++++++++
> >  3 files changed, 147 insertions(+), 1 deletion(-)
> >  create mode 100644 tests/tcg/aarch64/gdbstub/test-sme.py
>
> This test fails for me:
>
> timeout -s KILL --foreground 120
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/guest-debug/run-test.py
> --gdb /usr/bin/gdb-multiarch --qemu
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-aarch64
> --qargs "" --bin sysregs --test
>
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/tcg/aarch64/gdbstub/test=
-sme.py
> -- test_sme --gdb_sme_tile_support >  run-gdbstub-sysregs-sme.out
> warning: File transfers from remote targets can be slow. Use "set
> sysroot" to access files locally instead.
> Python Exception <class 'gdb.error'>: That operation is not available
> on integers of more than 8 bytes.
> Error occurred in Python: That operation is not available on integers
> of more than 8 bytes.
> qemu-aarch64: QEMU: Terminated via GDBstub
>
> The gdb is:
> GNU gdb (Ubuntu 15.0.50.20240403-0ubuntu1) 15.0.50.20240403-git
>
> > diff --git a/tests/tcg/aarch64/gdbstub/test-sme.py
> b/tests/tcg/aarch64/gdbstub/test-sme.py
> > new file mode 100644
> > index 0000000000..c2b9d774ae
> > --- /dev/null
> > +++ b/tests/tcg/aarch64/gdbstub/test-sme.py
> > @@ -0,0 +1,119 @@
> > +from __future__ import print_function
>
> Alex, do we still need this line in the gdbstub test cases?
> We can probably assume that the gdb's python is python 3
> by now, I hope...
>
> > +#
> > +# Test the SME registers are visible and changeable via gdbstub
> > +#
> > +# This is launched via tests/guest-debug/run-test.py
> > +#
>
> All new files must have an SPDX line saying what the
> license is. You may also wish to add a Copyright line;
> that's up to you/your employer.
>
>
> > +if args.gdb_sme_tile_support:
> > +    main(run_test_slices, expected_arch=3D"aarch64")
> > +else:
> > +    main(run_test, expected_arch=3D"aarch64")
> > \ No newline at end of file
>
> Please add the trailing newline.
>
> thanks
> -- PMM
>

--000000000000abcaec063cf7970b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>
We have tried to replicate this issue on our end and it<br>
seems to stem from the int casting of gdb.Value type of<br>
a 128bit integer. We have run the test with different<br>
host architectures, gdb versions and python versions<br>
both with and without the int casting. The results are<br>
as follows.<br><br>
gdb =C2=A0 =C2=A0 gdb target =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 python =C2=
=A0 host =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int cast status<br>
version support =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0version =C2=
=A0architecture<br>
16.3 --enable-targets=3Dall 3.11.13 =C2=A0 x86=C2=A0 =C2=A0 =C2=A0 =C2=A0 y=
es =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
16.3 --enable-targets=3Dall 3.11.13 =C2=A0 x86=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0no =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
16.3 --enable-targets=3Dall 3.10.18 =C2=A0 x86=C2=A0 =C2=A0 =C2=A0 =C2=A0 y=
es =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
16.3 --enable-targets=3Dall 3.10.18 =C2=A0 x86=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0no =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
16.3 --enable-targets=3Dall 3.8.10 =C2=A0 =C2=A0x86=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 yes =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
16.3 --enable-targets=3Dall 3.8.10 =C2=A0 =C2=A0x86=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 no =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br><br>
16.3 aarch64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.11.0rc1 aarch64=C2=
=A0 =C2=A0 =C2=A0 yes =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
16.3 aarch64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.11.0rc1 aarch64=C2=
=A0 =C2=A0 =C2=A0 =C2=A0no =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
16.3 aarch64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.10.12 =C2=A0 aarch=
64=C2=A0 =C2=A0 =C2=A0 yes =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
16.3 aarch64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.10.12 =C2=A0 aarch=
64=C2=A0 =C2=A0 =C2=A0 =C2=A0no =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br><br>
15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.10.12 =C2=A0 aarch=
64=C2=A0 =C2=A0 =C2=A0 yes =C2=A0 =C2=A0 =C2=A0 =C2=A0fail<br>
15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03.10.12 =C2=A0 aarch=
64=C2=A0 =C2=A0 =C2=A0 no =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.11.0rc1 aarch64=C2=A0 =
=C2=A0 =C2=A0 yes =C2=A0 =C2=A0 =C2=A0 =C2=A0fail<br>
15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.11.0rc1 aarch64=C2=A0 =
=C2=A0 =C2=A0 no =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br><br>
15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.8.10=C2=A0 =C2=A0 =C2=A0=
 x86=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 yes =C2=A0 =C2=A0 =C2=A0 =C2=
=A0fail<br>
15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.8.10=C2=A0 =C2=A0 =C2=A0=
 x86=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0no =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pass<br>
15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.11.13=C2=A0 =C2=A0 =C2=A0 x86=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 yes =C2=A0 =C2=A0 =C2=A0 =C2=A0fa=
il<br>
15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.11.13=C2=A0 =C2=A0 =C2=A0 x86=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0no =C2=A0 =C2=A0 =C2=A0 =C2=
=A0pass<br>
15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.10.18=C2=A0 =C2=A0 =C2=A0 x86=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 yes =C2=A0 =C2=A0 =C2=A0 =C2=A0fa=
il<br>
15.0 multiarch=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.10.18=C2=A0 =C2=A0 =C2=A0x86=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0no =C2=A0 =C2=A0 =C2=A0 =C2=A0=
pass<br><br>
Could we get some more information about your testing environment?<br><br>
Thanks,<br>
Vacha</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D=
"ltr" class=3D"gmail_attr">On Tue, Aug 19, 2025 at 5:13=E2=80=AFAM Peter Ma=
ydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.=
org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On Mon, 11 Aug 2025 at 20:37, Vacha Bhavsar<br>
&lt;<a href=3D"mailto:vacha.bhavsar@oss.qualcomm.com" target=3D"_blank">vac=
ha.bhavsar@oss.qualcomm.com</a>&gt; wrote:<br>
&gt;<br>
&gt; This patch adds a test case to test SME register exposure to<br>
&gt; a remote gdb debugging session. This test simply sets and<br>
&gt; reads SME registers.<br>
&gt;<br>
&gt; Signed-off-by: Vacha Bhavsar &lt;<a href=3D"mailto:vacha.bhavsar@oss.q=
ualcomm.com" target=3D"_blank">vacha.bhavsar@oss.qualcomm.com</a>&gt;<br>
&gt; ---<br>
&gt; Changes since v4:<br>
&gt; - this patch was not present in v4, it was added based on<br>
&gt; suggestions during the review of v4<br>
&gt; ---<br>
&gt;=C2=A0 configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 ++<br>
&gt;=C2=A0 tests/tcg/aarch64/Makefile.target=C2=A0 =C2=A0 =C2=A0|=C2=A0 23 =
++++-<br>
&gt;=C2=A0 tests/tcg/aarch64/gdbstub/test-sme.py | 119 ++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 3 files changed, 147 insertions(+), 1 deletion(-)<br>
&gt;=C2=A0 create mode 100644 tests/tcg/aarch64/gdbstub/test-sme.py<br>
<br>
This test fails for me:<br>
<br>
timeout -s KILL --foreground 120<br>
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/guest-debug/run-test.py<br=
>
--gdb /usr/bin/gdb-multiarch --qemu<br>
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-aarch64<br>
--qargs &quot;&quot; --bin sysregs --test<br>
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/tcg/aarch64/gdbstub/test-s=
me.py<br>
-- test_sme --gdb_sme_tile_support &gt;=C2=A0 run-gdbstub-sysregs-sme.out<b=
r>
warning: File transfers from remote targets can be slow. Use &quot;set<br>
sysroot&quot; to access files locally instead.<br>
Python Exception &lt;class &#39;gdb.error&#39;&gt;: That operation is not a=
vailable<br>
on integers of more than 8 bytes.<br>
Error occurred in Python: That operation is not available on integers<br>
of more than 8 bytes.<br>
qemu-aarch64: QEMU: Terminated via GDBstub<br>
<br>
The gdb is:<br>
GNU gdb (Ubuntu 15.0.50.20240403-0ubuntu1) 15.0.50.20240403-git<br>
<br>
&gt; diff --git a/tests/tcg/aarch64/gdbstub/test-sme.py b/tests/tcg/aarch64=
/gdbstub/test-sme.py<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..c2b9d774ae<br>
&gt; --- /dev/null<br>
&gt; +++ b/tests/tcg/aarch64/gdbstub/test-sme.py<br>
&gt; @@ -0,0 +1,119 @@<br>
&gt; +from __future__ import print_function<br>
<br>
Alex, do we still need this line in the gdbstub test cases?<br>
We can probably assume that the gdb&#39;s python is python 3<br>
by now, I hope...<br>
<br>
&gt; +#<br>
&gt; +# Test the SME registers are visible and changeable via gdbstub<br>
&gt; +#<br>
&gt; +# This is launched via tests/guest-debug/run-test.py<br>
&gt; +#<br>
<br>
All new files must have an SPDX line saying what the<br>
license is. You may also wish to add a Copyright line;<br>
that&#39;s up to you/your employer.<br>
<br>
<br>
&gt; +if args.gdb_sme_tile_support:<br>
&gt; +=C2=A0 =C2=A0 main(run_test_slices, expected_arch=3D&quot;aarch64&quo=
t;)<br>
&gt; +else:<br>
&gt; +=C2=A0 =C2=A0 main(run_test, expected_arch=3D&quot;aarch64&quot;)<br>
&gt; \ No newline at end of file<br>
<br>
Please add the trailing newline.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000abcaec063cf7970b--

