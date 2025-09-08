Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E51ECA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 18:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvgfq-0002hb-3y; Mon, 08 Sep 2025 14:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uvgfb-0002Xh-6g
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 14:32:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uvgfO-0001yA-2a
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 14:32:48 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588DjwTO004644
 for <qemu-devel@nongnu.org>; Mon, 8 Sep 2025 18:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=lhzPCkQDSpNVv10uj20sZPIV
 +UTWt5WKZS3KYsbM6QQ=; b=IafSVwIAqm4eaGPT5/DObNfWSth1YKhvhuisuWIv
 00l+yMu8D8oCbPw1ndKspoM7L/wTqH11hwMz80qNCwdQh/eHNrZWjbR8vujwJrge
 ItkR1raWI3Vj8riBAanJXKlpyJYJkxoOSJD6UWO8eUmJ4F7zcViX1JUfMt0yAmCo
 PbgbWwe/c5ZwDP6R5CmKe72EdXnWTXZDcIZbGeOeV5UWfhgY4R5D3igUHztPABfQ
 tSXcvzGaVMoq65G1nHaXgpk9VbU8q8i/5x6DWXkP83sQwfK0ooKzSJMR33zJLprQ
 hoSVqlT1RK4O1FuvnW/fEkzoyBvf8Nza+smP1Q4eingUNg==
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t37t3dh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 18:32:33 +0000 (GMT)
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e931cdd05a8so5810471276.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 11:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757356352; x=1757961152;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lhzPCkQDSpNVv10uj20sZPIV+UTWt5WKZS3KYsbM6QQ=;
 b=gSkkErGvnCoDlHoh1z6kTH6mbzA8+tbvxtMhHMhY0qiWm2pXlW9kGGmL18vSnK1XdJ
 ykimaTbNOzqll2roLxjme1bpfp0K5XunqXSlYKR8DOpYNOqiLLnALZylENU1Kwetkwv4
 MbMnG11D3LODXQXZodua6FRKYdMDrhfKPS+ziH2crTqbQmOvb9STMcTRC7q/epuncPm1
 vz1/5gnSP4IqLPYKvXbnNAlao9YI6xHgQmSzogBFBiS6b/KgvHa5A6/++wKk1IvJB0rV
 lFoTmeFgX1hog3wuqrPrv+0cUt6giJtcin7Wg/cX0t5L2pQfIQ9+7ctQb0A46FW+cM2t
 kGLQ==
X-Gm-Message-State: AOJu0YyQ/e/gboRvBpqZFz+JhVdeMCnRUkqoxXKnUN5xWOgDdVM8PVLd
 ZH/9NfhRPrJNeRyj+UroiXhtavKDAtue2mXDzyILXglKsrFHmrZpVcVEeOlumtCiWGBDLhljJKQ
 nuj7C4Q94pyDIFEaOW+SL0dV2Q2aRSDEbK7q5KMFP8LKOAJxMK3c+ZuatAgqohuvGZSSOqf1LwO
 bPmDJCIymXTm82LTSeqq2IaVINAYOCGtlS
X-Gm-Gg: ASbGncv9GIpkR2v1cLBEQx5AbNY1TScHrtDpf+LBWWxIJaIOaf7EbNPKpVT9xsc4VOT
 sDQVVkQx+GGpIwivhpeiUo+w4mvYiBr9m+Al93IgaXbPOPR+aY0xV+2Y0sTF6oyETmxsqkMxfDs
 be0yL+H+yr7JJovmUP5zhXskY=
X-Received: by 2002:a05:6902:18c4:b0:e97:dfb:e41c with SMTP id
 3f1490d57ef6-e9f69276108mr6009397276.50.1757356351561; 
 Mon, 08 Sep 2025 11:32:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5jlpltLFIgdKiKC+7OxUJ59FdtVkJ/fYOH5YsKG39xGXPqxqWMRxDtw6zn5ARquRiqy0s7T3SidOZZ6hJR+k=
X-Received: by 2002:a05:6902:18c4:b0:e97:dfb:e41c with SMTP id
 3f1490d57ef6-e9f69276108mr6009352276.50.1757356350801; Mon, 08 Sep 2025
 11:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250826184504.510279-1-vacha.bhavsar@oss.qualcomm.com>
 <20250826184504.510279-4-vacha.bhavsar@oss.qualcomm.com>
 <CAFEAcA9_wXKT6zfpCSty2bRjVpCSyzLcdfWuJofJEZcZuqRgYQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9_wXKT6zfpCSty2bRjVpCSyzLcdfWuJofJEZcZuqRgYQ@mail.gmail.com>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 14:32:19 -0400
X-Gm-Features: Ac12FXxJiF1rj1d162YlgOJKfEK9bnZReT-pu_gqpFtoCtP7bFDKcnrC4vkueDo
Message-ID: <CAEWVDmttumhB+kx7RExyTV1vUoUCY=ED_qbj=7tbBx0hDPeqUg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] target/arm: Added test case for SME register
 exposure to GDB
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000008a65c063e4e6977"
X-Proofpoint-ORIG-GUID: e4-eOZQ6SMTrQrV3Cv508jlGxKXSAvYK
X-Proofpoint-GUID: e4-eOZQ6SMTrQrV3Cv508jlGxKXSAvYK
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68bf2141 cx=c_pps
 a=bcYUF9iMMBfaiOy0M+g+3g==:117 a=yJojWOMRYYMA:10 a=CCpqsmhAAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Kwshshn1Dx7hVhFIJOwA:9 a=QEXdDO2ut3YA:10
 a=xsCOeRy3ZukA:10 a=Y4SkpI06CHAA:10 a=JlpplhrXhL5vfGM5tL8A:9
 a=J2WWCGS9hmrOVdRw:21 a=lqcHg5cX4UMA:10 a=MASdlorsyo4A:10 a=GXlkhN0Z3PUA:10
 a=4AvBJ3eyfGLrynxe6Eyb:22 a=ul9cdbp4aOFLsgKbc677:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX1PmAQY3V2i1Z
 khjbluqOXg3N1lt/fQQkdtiCHKRvM4m0+5FRXm3decRJMf7X8e2ZhrxElGUD1ez+Oqv/+uoHSZQ
 lS+KRMEnnA9uuFeBaCQaJMo2YuhbwA2/46qm1tzCDqG/BHHp7p0R9vQ9YKp6tjlCy0x9HdMIXTc
 IqUAzmtjpN0fjuhZlrZnVS6gdhUm7OeIZczCsu4vbvKk1lxgNQdRFdJAT4j60S6pPaRLFc2p54V
 ggKv2NsB7jvtLt5MRgvboca2YxEXTqfJ3uQQgbn+hx3JQ6/iBbeLheOelAZ7pO9dcC18pyEG+/K
 LhqFFk7L1Kp2hfYGIZZNkj0YjkAnCQkgzvp/q5wkdkPD4rnvgYAUolz0FsSJuI0n/6NzpNRJ2ai
 ysR3hhHc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--00000000000008a65c063e4e6977
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,



Thank you for the feedback!



Regarding the following:



>So the only difference between these two branches is that we are
>checking "int(v) =3D=3D MAGIC" rather than "v =3D=3D MAGIC" ?



>Is this a "one GDB only works one way, and the other GDB only
>works the other way" case? Or is there a real interesting thing
>we'd like to test involving the cast ?



Yes, the only difference between the two branches is the presence
of the int cast. This seems to be an issue limited to specific versions

of gdb. This has been discussed with the gdb team
(https://sourceware.org/pipermail/gdb/2025-August/051868.html,
https://sourceware.org/pipermail/gdb/2025-August/051878.html) and
a bug has been filed. With additional tests I have found that the
int cast causes no issues with the testcase when running gdb16.1
or newer. Other than this issue there is no intention on our end
of testing anything interesting regarding casting as the int cast
was included to stay aligned with the existing SVE test.



I have sent a new patch version in which we have opted to go with
your suggestion of reporting the test as SKIPPED when the detected
gdb version does not allow for int casting of integers greater than
8 bytes (or does not have SME tile support).



To accomplish this, we have split the test into 3:



- one to test basic access to za (always run regardless of gdb version)
- one to test access to doubleword tile slices (run only with gdb14.1
or newer)
- one to test access to quadword tile slices (run only with gdb16.1 or
newer)



I have also restructured the test file to make the code more compact
and added additional comments.



Looking forward to your input on this approach.



Thanks,

Vacha

On Tue, Sep 2, 2025 at 6:29=E2=80=AFAM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> On Tue, 26 Aug 2025 at 19:45, Vacha Bhavsar
> <vacha.bhavsar@oss.qualcomm.com> wrote:
> >
> > This patch adds a test case to test SME register exposure to
> > a remote gdb debugging session. This test simply sets and
> > reads SME registers.
> >
> > Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
> > ---
> > Changes since v5:
> > - added copyright and SPDX line
> > - added functionality to avoid casting a gdb.Value object
> > to int when testing the za quadwords to address bug found
> > during review, this change is declared to users via a
> > warning message included in the test results file
> > run-gdbstub-sysregs-sme.out
> > ---
> >  configure                             |  11 ++
> >  tests/tcg/aarch64/Makefile.target     |  33 +++++-
> >  tests/tcg/aarch64/gdbstub/test-sme.py | 165 ++++++++++++++++++++++++++
> >  3 files changed, 208 insertions(+), 1 deletion(-)
> >  create mode 100644 tests/tcg/aarch64/gdbstub/test-sme.py
> >
> > diff --git a/configure b/configure
> > index 274a778764..9e2ae174dc 100755
> > --- a/configure
> > +++ b/configure
> > @@ -1839,6 +1839,17 @@ for target in $target_list; do
> >            echo "GDB=3D$gdb_bin" >> $config_target_mak
> >        fi
> >
> > +      if test "${gdb_arches#*$arch}" !=3D "$gdb_arches" && version_ge
> $gdb_version 14.1; then
> > +          echo "GDB_HAS_SME_TILES=3Dy" >> $config_target_mak
> > +          if test "$gdb_version" =3D "15.0.50.20240403-git"; then
> > +            echo "GDB_HAS_INT_CAST_SUPPORT=3Dn" >> $config_target_mak
> > +          else
> > +            echo "GDB_HAS_INT_CAST_SUPPORT=3Dy" >> $config_target_mak
> > +          fi
> > +       else
> > +          echo "GDB_HAS_SME_TILES=3Dn" >> $config_target_mak
> > +      fi
> > +
> >        if test "${gdb_arches#*aarch64}" !=3D "$gdb_arches" && version_g=
e
> $gdb_version 15.1; then
> >            echo "GDB_HAS_MTE=3Dy" >> $config_target_mak
> >        fi
> > diff --git a/tests/tcg/aarch64/Makefile.target
> b/tests/tcg/aarch64/Makefile.target
> > index 16ddcf4f88..f9304d29cf 100644
> > --- a/tests/tcg/aarch64/Makefile.target
> > +++ b/tests/tcg/aarch64/Makefile.target
> > @@ -132,7 +132,38 @@ run-gdbstub-sve-ioctls: sve-ioctls
> >                 --bin $< --test
> $(AARCH64_SRC)/gdbstub/test-sve-ioctl.py, \
> >         basic gdbstub SVE ZLEN support)
> >
> > -EXTRA_RUNS +=3D run-gdbstub-sysregs run-gdbstub-sve-ioctls
> > +ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
> > +# SME gdbstub test
> > +ifeq ($(GDB_HAS_SME_TILES),y)
> > +ifeq ($(GDB_HAS_INT_CAST_SUPPORT),y)
> > +run-gdbstub-sysregs-sme: sysregs
> > +       $(call run-test, $@, $(GDB_SCRIPT) \
> > +               --gdb $(GDB) \
> > +               --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> > +               --bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py \
> > +               -- test_sme --gdb_sme_tile_support
> --gdb_int_cast_support, \
> > +       basic gdbstub SME support)
> > +else
> > +run-gdbstub-sysregs-sme: sysregs
> > +       $(call run-test, $@, $(GDB_SCRIPT) \
> > +               --gdb $(GDB) \
> > +               --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> > +               --bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py \
> > +               -- test_sme --gdb_sme_tile_support, \
> > +       basic gdbstub SME support)
> > +endif
> > +else
> > +run-gdbstub-sysregs-sme: sysregs
> > +       $(call run-test, $@, $(GDB_SCRIPT) \
> > +               --gdb $(GDB) \
> > +               --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> > +               --bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py, \
> > +       basic gdbstub SME support)
> > +
> > +endif
> > +endif
> > +
> > +EXTRA_RUNS +=3D run-gdbstub-sysregs run-gdbstub-sve-ioctls
> run-gdbstub-sysregs-sme
> >
> >  ifeq ($(GDB_HAS_MTE),y)
> >  run-gdbstub-mte: mte-8
> > diff --git a/tests/tcg/aarch64/gdbstub/test-sme.py
> b/tests/tcg/aarch64/gdbstub/test-sme.py
> > new file mode 100644
> > index 0000000000..e27a37631b
> > --- /dev/null
> > +++ b/tests/tcg/aarch64/gdbstub/test-sme.py
> > @@ -0,0 +1,165 @@
> > +#
> > +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +from __future__ import print_function
> > +#
> > +# Test the SME registers are visible and changeable via gdbstub
> > +#
> > +# This is launched via tests/guest-debug/run-test.py
> > +#
> > +
> > +import argparse
> > +import gdb
> > +from test_gdbstub import main, report
> > +
> > +MAGIC =3D 0x01020304
> > +INT_CAST_SUPPORT =3D 0
> > +
> > +def run_test():
> > +    "Run through the tests one by one"
>
> This is a very unhelpful name and comment for this function.
>
> > +
> > +    frame =3D gdb.selected_frame()
> > +    rname =3D "za"
> > +    za =3D frame.read_register(rname)
> > +    report(True, "Reading %s" % rname)
> > +
> > +    for i in range(0, 16):
> > +        for j in range(0, 16):
> > +            cmd =3D "set $za[%d][%d] =3D 0x01" % (i, j)
> > +            gdb.execute(cmd)
> > +            report(True, "%s" % cmd)
> > +    for i in range(0, 16):
> > +        for j in range(0, 16):
> > +            reg =3D "$za[%d][%d]" % (i, j)
> > +            v =3D gdb.parse_and_eval(reg)
> > +            report(str(v.type) =3D=3D "uint8_t",
> > +                    "size of %s" % (reg))
> > +            report(int(v) =3D=3D 0x1, "%s is 0x%x" % (reg, 0x1))
> > +
> > +def run_test_slices():
> > +    "Run through the tests one by one"
> > +
> > +    frame =3D gdb.selected_frame()
> > +    rname =3D "za"
> > +    za =3D frame.read_register(rname)
> > +    report(True, "Reading %s" % rname)
> > +
> > +    for i in range(0, 16):
> > +        for j in range(0, 16):
> > +            cmd =3D "set $za[%d][%d] =3D 0x01" % (i, j)
> > +            gdb.execute(cmd)
> > +            report(True, "%s" % cmd)
> > +    for i in range(0, 16):
> > +        for j in range(0, 16):
> > +            reg =3D "$za[%d][%d]" % (i, j)
> > +            v =3D gdb.parse_and_eval(reg)
> > +            report(str(v.type) =3D=3D "uint8_t",
> > +                    "size of %s" % (reg))
> > +            report(int(v) =3D=3D 0x1, "%s is 0x%x" % (reg, 0x1))
>
> This first part is exactly the same as the run_test()
> function is testing, isn't it?
>
> > +
> > +    if INT_CAST_SUPPORT:
> > +        for i in range(0, 4):
> > +            for j in range(0, 4):
> > +                for k in range(0, 4):
> > +                    cmd =3D "set $za%dhq%d[%d] =3D 0x%x" % (i, j, k, M=
AGIC)
> > +                    gdb.execute(cmd)
> > +                    report(True, "%s" % cmd)
> > +            for j in range(0, 4):
> > +                for k in range(0, 4):
> > +                    reg =3D "$za%dhq%d[%d]" % (i, j, k)
> > +                    v =3D gdb.parse_and_eval(reg)
> > +                    report(str(v.type) =3D=3D "uint128_t",
> > +                        "size of %s" % (reg))
> > +                    report(int(v) =3D=3D MAGIC, "%s is 0x%x" % (reg, M=
AGIC))
> > +
> > +            for j in range(0, 4):
> > +                for k in range(0, 4):
> > +                    cmd =3D "set $za%dvq%d[%d] =3D 0x%x" % (i, j, k, M=
AGIC)
> > +                    gdb.execute(cmd)
> > +                    report(True, "%s" % cmd)
> > +            for j in range(0, 4):
> > +                for k in range(0, 4):
> > +                    reg =3D "$za%dvq%d[%d]" % (i, j, k)
> > +                    v =3D gdb.parse_and_eval(reg)
> > +                    report(str(v.type) =3D=3D "uint128_t",
> > +                        "size of %s" % (reg))
> > +                    report(int(v) =3D=3D MAGIC, "%s is 0x%x" % (reg, M=
AGIC))
> > +
> > +    else:
> > +        for i in range(0, 4):
> > +            for j in range(0, 4):
> > +                for k in range(0, 4):
> > +                    cmd =3D "set $za%dhq%d[%d] =3D 0x%x" % (i, j, k, M=
AGIC)
> > +                    gdb.execute(cmd)
> > +                    report(True, "%s" % cmd)
> > +            for j in range(0, 4):
> > +                for k in range(0, 4):
> > +                    reg =3D "$za%dhq%d[%d]" % (i, j, k)
> > +                    v =3D gdb.parse_and_eval(reg)
> > +                    report(str(v.type) =3D=3D "uint128_t",
> > +                        "size of %s" % (reg))
> > +                    report(v =3D=3D MAGIC, "%s is 0x%x" % (reg, MAGIC)=
)
>
> So the only difference between these two branches is that we are
> checking "int(v) =3D=3D MAGIC" rather than "v =3D=3D MAGIC" ?
>
> Is this a "one GDB only works one way, and the other GDB only
> works the other way" case? Or is there a real interesting thing
> we'd like to test involving the cast ?
>
> Either way, this code is way too repetitive. Don't copy-and-paste
> like this, it's very hard to review.
>
> > +
> > +            for j in range(0, 4):
> > +                for k in range(0, 4):
> > +                    cmd =3D "set $za%dvq%d[%d] =3D 0x%x" % (i, j, k, M=
AGIC)
> > +                    gdb.execute(cmd)
> > +                    report(True, "%s" % cmd)
> > +            for j in range(0, 4):
> > +                for k in range(0, 4):
> > +                    reg =3D "$za%dvq%d[%d]" % (i, j, k)
> > +                    v =3D gdb.parse_and_eval(reg)
> > +                    report(str(v.type) =3D=3D "uint128_t",
> > +                        "size of %s" % (reg))
> > +                    report(v =3D=3D MAGIC, "%s is 0x%x" % (reg, MAGIC)=
)
> > +
> > +    for i in range(0, 4):
> > +        for j in range(0, 4):
> > +            for k in range(0, 4):
> > +                cmd =3D "set $za%dhd%d[%d] =3D 0x%x" % (i, j, k, MAGIC=
)
> > +                gdb.execute(cmd)
> > +                report(True, "%s" % cmd)
> > +        for j in range(0, 4):
> > +            for k in range(0, 4):
> > +                reg =3D "$za%dhd%d[%d]" % (i, j, k)
> > +                v =3D gdb.parse_and_eval(reg)
> > +                report(str(v.type) =3D=3D "uint64_t",
> > +                    "size of %s" % (reg))
> > +                report(int(v) =3D=3D MAGIC, "%s is 0x%x" % (reg, MAGIC=
))
> > +
> > +        for j in range(0, 4):
> > +            for k in range(0, 4):
> > +                cmd =3D "set $za%dvd%d[%d] =3D 0x%x" % (i, j, k, MAGIC=
)
> > +                gdb.execute(cmd)
> > +                report(True, "%s" % cmd)
> > +        for j in range(0, 4):
> > +            for k in range(0, 4):
> > +                reg =3D "$za%dvd%d[%d]" % (i, j, k)
> > +                v =3D gdb.parse_and_eval(reg)
> > +                report(str(v.type) =3D=3D "uint64_t",
> > +                    "size of %s" % (reg))
> > +                report(int(v) =3D=3D MAGIC, "%s is 0x%x" % (reg, MAGIC=
))
> > +
> > +
> > +parser =3D argparse.ArgumentParser(description=3D"A gdbstub test for S=
ME
> support")
> > +parser.add_argument("--gdb_sme_tile_support", help=3D"GDB support for =
SME
> tiles", \
> > +                    action=3D"store_true")
> > +parser.add_argument("--gdb_int_cast_support",
> > +                    help=3D"GDB support for 128bit int cast", \
> > +                    action=3D"store_true")
> > +args =3D parser.parse_args()
> > +
> > +if args.gdb_sme_tile_support:
> > +    if args.gdb_int_cast_support:
> > +        INT_CAST_SUPPORT =3D 1
> > +    else:
> > +        print("WARNING: The version of gdb used
> (15.0.50.20240403-git)\n"
>
> This is super misleading: it looks like it's printing out what
> gdb version we ran the tests with, but actually this version
> string is just hardcoded !
>
> > +        "does not support casting a gdb.Value object to 128 bit
> python\n"
> > +        "integer. Thus, the testing for the ZA quadwords will be done\=
n"
> > +        "without int casting. Refer to
> tests/tcg/aarch64/gdbstub/test-sme.py\n"
> > +        "for details.")
>
> This is a big warning that doesn't convey anything useful
> to the reader (why do I care whether your test case
> is using int casting or not?).
>
> If there is part of the gdb view of the register that we
> can't test on some gdb versions, that's fine. To handle
> that, split the test case into two, so that for the
> test that needs a newer gdb we report the test as SKIPPED
> because gdb is too old.
>
> Please also write some comments that tell me what your
> test is testing. I should not have to reverse-engineer
> your intentions by reading the code...
>
> thanks
> -- PMM
>

--00000000000008a65c063e4e6977
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Hi,</p><p>=C2=A0</p><p>Thank you for the feedback!</p><=
p>=C2=A0</p><p>Regarding the following:</p><p>=C2=A0</p><p>&gt;So the only =
difference between these two branches is that we are<br>&gt;checking &quot;=
int(v) =3D=3D MAGIC&quot; rather than &quot;v =3D=3D MAGIC&quot; ?</p><p>=
=C2=A0</p><p>&gt;Is this a &quot;one GDB only works one way, and the other =
GDB only<br>&gt;works the other way&quot; case? Or is there a real interest=
ing thing<br>&gt;we&#39;d like to test involving the cast ?</p><p>=C2=A0</p=
><p>Yes, the only difference between the two branches is the presence<br>
of the int cast. This seems to be an issue limited to specific versions=C2=
=A0</p><p>of gdb. This has been discussed with the gdb team<br>
(<a aria-label=3D"Link https://sourceware.org/pipermail/gdb/2025-August/051=
868.html" id=3D"gmail-menurvs4" href=3D"https://sourceware.org/pipermail/gd=
b/2025-August/051868.html" rel=3D"noreferrer noopener" target=3D"_blank" cl=
ass=3D"gmail-fui-Link gmail-___1q1shib gmail-f2hkw1w gmail-f3rmtva gmail-f1=
ewtqcl gmail-fyind8e gmail-f1k6fduh gmail-f1w7gpdv gmail-fk6fouc gmail-fjoy=
568 gmail-figsok6 gmail-f1s184ao gmail-f1mk8lai gmail-fnbmjn9 gmail-f1o700a=
v gmail-f13mvf36 gmail-f1cmlufx gmail-f9n3di6 gmail-f1ids18y gmail-f1tx3yz7=
 gmail-f1deo86v gmail-f1eh06m1 gmail-f1iescvh gmail-fhgqx19 gmail-f1olyrje =
gmail-f1p93eir gmail-f1nev41a gmail-f1h8hb77 gmail-f1lqvz6u gmail-f10aw75t =
gmail-fsle3fq gmail-f17ae5zn" title=3D"https://sourceware.org/pipermail/gdb=
/2025-august/051868.html">https://sourceware.org/pipermail/gdb/2025-August/=
051868.html</a>,<br><a aria-label=3D"Link https://sourceware.org/pipermail/=
gdb/2025-August/051878.html)" id=3D"gmail-menurvs6" href=3D"https://sourcew=
are.org/pipermail/gdb/2025-August/051878.html)" rel=3D"noreferrer noopener"=
 target=3D"_blank" class=3D"gmail-fui-Link gmail-___1q1shib gmail-f2hkw1w g=
mail-f3rmtva gmail-f1ewtqcl gmail-fyind8e gmail-f1k6fduh gmail-f1w7gpdv gma=
il-fk6fouc gmail-fjoy568 gmail-figsok6 gmail-f1s184ao gmail-f1mk8lai gmail-=
fnbmjn9 gmail-f1o700av gmail-f13mvf36 gmail-f1cmlufx gmail-f9n3di6 gmail-f1=
ids18y gmail-f1tx3yz7 gmail-f1deo86v gmail-f1eh06m1 gmail-f1iescvh gmail-fh=
gqx19 gmail-f1olyrje gmail-f1p93eir gmail-f1nev41a gmail-f1h8hb77 gmail-f1l=
qvz6u gmail-f10aw75t gmail-fsle3fq gmail-f17ae5zn" title=3D"https://sourcew=
are.org/pipermail/gdb/2025-august/051878.html)">https://sourceware.org/pipe=
rmail/gdb/2025-August/051878.html)</a> and<br>
a bug has been filed. With additional tests I have found that the=C2=A0<br>
int cast causes no issues with the testcase when running gdb16.1=C2=A0<br>
or newer. Other than this issue there is no intention on our end=C2=A0<br>
of testing anything interesting regarding casting as the int cast=C2=A0<br>
was included to stay aligned with the existing SVE test.</p><p>=C2=A0</p><p=
>I have sent a new patch version in which we have opted to go with<br>
your suggestion of reporting the test as SKIPPED when the detected<br>
gdb version does not allow for int casting of integers greater than<br>
8 bytes (or does not have SME tile support).</p><p>=C2=A0</p><p>To accompli=
sh this, we have split the test into 3:</p><p>=C2=A0</p><p>- one to test ba=
sic access to za (always run regardless of gdb version)<br>
- one to test access to doubleword tile slices (run only with gdb14.1<br>
or newer)<br>
- one to test access to quadword tile slices (run only with gdb16.1 or<br>
newer)</p><p>=C2=A0</p><p>I have also restructured the test file to make th=
e code more compact<br>
and added additional comments.</p><p>=C2=A0</p><p>Looking forward to your i=
nput on this approach.</p><p>=C2=A0</p><p>Thanks,</p><p>Vacha</p></div><br>=
<div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"=
gmail_attr">On Tue, Sep 2, 2025 at 6:29=E2=80=AFAM Peter Maydell &lt;<a hre=
f=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, 26 Au=
g 2025 at 19:45, Vacha Bhavsar<br>
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
&gt; Changes since v5:<br>
&gt; - added copyright and SPDX line<br>
&gt; - added functionality to avoid casting a gdb.Value object<br>
&gt; to int when testing the za quadwords to address bug found<br>
&gt; during review, this change is declared to users via a<br>
&gt; warning message included in the test results file<br>
&gt; run-gdbstub-sysregs-sme.out<br>
&gt; ---<br>
&gt;=C2=A0 configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 11 ++<br>
&gt;=C2=A0 tests/tcg/aarch64/Makefile.target=C2=A0 =C2=A0 =C2=A0|=C2=A0 33 =
+++++-<br>
&gt;=C2=A0 tests/tcg/aarch64/gdbstub/test-sme.py | 165 ++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 3 files changed, 208 insertions(+), 1 deletion(-)<br>
&gt;=C2=A0 create mode 100644 tests/tcg/aarch64/gdbstub/test-sme.py<br>
&gt;<br>
&gt; diff --git a/configure b/configure<br>
&gt; index 274a778764..9e2ae174dc 100755<br>
&gt; --- a/configure<br>
&gt; +++ b/configure<br>
&gt; @@ -1839,6 +1839,17 @@ for target in $target_list; do<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;GDB=3D$gdb_bin&quo=
t; &gt;&gt; $config_target_mak<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if test &quot;${gdb_arches#*$arch}&quot; !=3D &q=
uot;$gdb_arches&quot; &amp;&amp; version_ge $gdb_version 14.1; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;GDB_HAS_SME_TILES=3Dy&q=
uot; &gt;&gt; $config_target_mak<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if test &quot;$gdb_version&quot; =
=3D &quot;15.0.50.20240403-git&quot;; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;GDB_HAS_INT_CAST=
_SUPPORT=3Dn&quot; &gt;&gt; $config_target_mak<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;GDB_HAS_INT_CAST=
_SUPPORT=3Dy&quot; &gt;&gt; $config_target_mak<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;GDB_HAS_SME_TILES=3Dn&q=
uot; &gt;&gt; $config_target_mak<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 if test &quot;${gdb_arches#*aarch64}&quot; =
!=3D &quot;$gdb_arches&quot; &amp;&amp; version_ge $gdb_version 15.1; then<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;GDB_HAS_MTE=3Dy&qu=
ot; &gt;&gt; $config_target_mak<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
&gt; diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Mak=
efile.target<br>
&gt; index 16ddcf4f88..f9304d29cf 100644<br>
&gt; --- a/tests/tcg/aarch64/Makefile.target<br>
&gt; +++ b/tests/tcg/aarch64/Makefile.target<br>
&gt; @@ -132,7 +132,38 @@ run-gdbstub-sve-ioctls: sve-ioctls<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--bin $&l=
t; --test $(AARCH64_SRC)/gdbstub/test-sve-ioctl.py, \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0basic gdbstub SVE ZLEN support)<br>
&gt;<br>
&gt; -EXTRA_RUNS +=3D run-gdbstub-sysregs run-gdbstub-sve-ioctls<br>
&gt; +ifneq ($(CROSS_AS_HAS_ARMV9_SME),)<br>
&gt; +# SME gdbstub test<br>
&gt; +ifeq ($(GDB_HAS_SME_TILES),y)<br>
&gt; +ifeq ($(GDB_HAS_INT_CAST_SUPPORT),y)<br>
&gt; +run-gdbstub-sysregs-sme: sysregs<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0$(call run-test, $@, $(GDB_SCRIPT) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--gdb $(GDB) \=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--qemu $(QEMU)=
 --qargs &quot;$(QEMU_OPTS)&quot; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--bin $&lt; --=
test $(AARCH64_SRC)/gdbstub/test-sme.py \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-- test_sme --=
gdb_sme_tile_support --gdb_int_cast_support, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0basic gdbstub SME support)<br>
&gt; +else<br>
&gt; +run-gdbstub-sysregs-sme: sysregs<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0$(call run-test, $@, $(GDB_SCRIPT) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--gdb $(GDB) \=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--qemu $(QEMU)=
 --qargs &quot;$(QEMU_OPTS)&quot; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--bin $&lt; --=
test $(AARCH64_SRC)/gdbstub/test-sme.py \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-- test_sme --=
gdb_sme_tile_support, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0basic gdbstub SME support)<br>
&gt; +endif<br>
&gt; +else<br>
&gt; +run-gdbstub-sysregs-sme: sysregs<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0$(call run-test, $@, $(GDB_SCRIPT) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--gdb $(GDB) \=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--qemu $(QEMU)=
 --qargs &quot;$(QEMU_OPTS)&quot; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--bin $&lt; --=
test $(AARCH64_SRC)/gdbstub/test-sme.py, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0basic gdbstub SME support)<br>
&gt; +<br>
&gt; +endif<br>
&gt; +endif<br>
&gt; +<br>
&gt; +EXTRA_RUNS +=3D run-gdbstub-sysregs run-gdbstub-sve-ioctls run-gdbstu=
b-sysregs-sme<br>
&gt;<br>
&gt;=C2=A0 ifeq ($(GDB_HAS_MTE),y)<br>
&gt;=C2=A0 run-gdbstub-mte: mte-8<br>
&gt; diff --git a/tests/tcg/aarch64/gdbstub/test-sme.py b/tests/tcg/aarch64=
/gdbstub/test-sme.py<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..e27a37631b<br>
&gt; --- /dev/null<br>
&gt; +++ b/tests/tcg/aarch64/gdbstub/test-sme.py<br>
&gt; @@ -0,0 +1,165 @@<br>
&gt; +#<br>
&gt; +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.<=
br>
&gt; +#<br>
&gt; +# SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; +<br>
&gt; +from __future__ import print_function<br>
&gt; +#<br>
&gt; +# Test the SME registers are visible and changeable via gdbstub<br>
&gt; +#<br>
&gt; +# This is launched via tests/guest-debug/run-test.py<br>
&gt; +#<br>
&gt; +<br>
&gt; +import argparse<br>
&gt; +import gdb<br>
&gt; +from test_gdbstub import main, report<br>
&gt; +<br>
&gt; +MAGIC =3D 0x01020304<br>
&gt; +INT_CAST_SUPPORT =3D 0<br>
&gt; +<br>
&gt; +def run_test():<br>
&gt; +=C2=A0 =C2=A0 &quot;Run through the tests one by one&quot;<br>
<br>
This is a very unhelpful name and comment for this function.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 frame =3D gdb.selected_frame()<br>
&gt; +=C2=A0 =C2=A0 rname =3D &quot;za&quot;<br>
&gt; +=C2=A0 =C2=A0 za =3D frame.read_register(rname)<br>
&gt; +=C2=A0 =C2=A0 report(True, &quot;Reading %s&quot; % rname)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for i in range(0, 16):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for j in range(0, 16):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;set $za[%d][%=
d] =3D 0x01&quot; % (i, j)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb.execute(cmd)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 report(True, &quot;%s&quot;=
 % cmd)<br>
&gt; +=C2=A0 =C2=A0 for i in range(0, 16):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for j in range(0, 16):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &quot;$za[%d][%d]&q=
uot; % (i, j)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D gdb.parse_and_eval(re=
g)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 report(str(v.type) =3D=3D &=
quot;uint8_t&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &quot;size of %s&quot; % (reg))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 report(int(v) =3D=3D 0x1, &=
quot;%s is 0x%x&quot; % (reg, 0x1))<br>
&gt; +<br>
&gt; +def run_test_slices():<br>
&gt; +=C2=A0 =C2=A0 &quot;Run through the tests one by one&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 frame =3D gdb.selected_frame()<br>
&gt; +=C2=A0 =C2=A0 rname =3D &quot;za&quot;<br>
&gt; +=C2=A0 =C2=A0 za =3D frame.read_register(rname)<br>
&gt; +=C2=A0 =C2=A0 report(True, &quot;Reading %s&quot; % rname)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for i in range(0, 16):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for j in range(0, 16):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;set $za[%d][%=
d] =3D 0x01&quot; % (i, j)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb.execute(cmd)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 report(True, &quot;%s&quot;=
 % cmd)<br>
&gt; +=C2=A0 =C2=A0 for i in range(0, 16):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for j in range(0, 16):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &quot;$za[%d][%d]&q=
uot; % (i, j)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D gdb.parse_and_eval(re=
g)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 report(str(v.type) =3D=3D &=
quot;uint8_t&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &quot;size of %s&quot; % (reg))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 report(int(v) =3D=3D 0x1, &=
quot;%s is 0x%x&quot; % (reg, 0x1))<br>
<br>
This first part is exactly the same as the run_test()<br>
function is testing, isn&#39;t it?<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if INT_CAST_SUPPORT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for i in range(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for j in range(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for k in rang=
e(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 cmd =3D &quot;set $za%dhq%d[%d] =3D 0x%x&quot; % (i, j, k, MAGIC)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 gdb.execute(cmd)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 report(True, &quot;%s&quot; % cmd)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for j in range(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for k in rang=
e(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 reg =3D &quot;$za%dhq%d[%d]&quot; % (i, j, k)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 v =3D gdb.parse_and_eval(reg)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 report(str(v.type) =3D=3D &quot;uint128_t&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;size of %s&quot; % (reg))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 report(int(v) =3D=3D MAGIC, &quot;%s is 0x%x&quot; % (reg, MAGIC))<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for j in range(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for k in rang=
e(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 cmd =3D &quot;set $za%dvq%d[%d] =3D 0x%x&quot; % (i, j, k, MAGIC)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 gdb.execute(cmd)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 report(True, &quot;%s&quot; % cmd)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for j in range(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for k in rang=
e(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 reg =3D &quot;$za%dvq%d[%d]&quot; % (i, j, k)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 v =3D gdb.parse_and_eval(reg)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 report(str(v.type) =3D=3D &quot;uint128_t&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;size of %s&quot; % (reg))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 report(int(v) =3D=3D MAGIC, &quot;%s is 0x%x&quot; % (reg, MAGIC))<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for i in range(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for j in range(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for k in rang=
e(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 cmd =3D &quot;set $za%dhq%d[%d] =3D 0x%x&quot; % (i, j, k, MAGIC)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 gdb.execute(cmd)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 report(True, &quot;%s&quot; % cmd)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for j in range(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for k in rang=
e(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 reg =3D &quot;$za%dhq%d[%d]&quot; % (i, j, k)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 v =3D gdb.parse_and_eval(reg)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 report(str(v.type) =3D=3D &quot;uint128_t&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;size of %s&quot; % (reg))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 report(v =3D=3D MAGIC, &quot;%s is 0x%x&quot; % (reg, MAGIC))<br>
<br>
So the only difference between these two branches is that we are<br>
checking &quot;int(v) =3D=3D MAGIC&quot; rather than &quot;v =3D=3D MAGIC&q=
uot; ?<br>
<br>
Is this a &quot;one GDB only works one way, and the other GDB only<br>
works the other way&quot; case? Or is there a real interesting thing<br>
we&#39;d like to test involving the cast ?<br>
<br>
Either way, this code is way too repetitive. Don&#39;t copy-and-paste<br>
like this, it&#39;s very hard to review.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for j in range(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for k in rang=
e(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 cmd =3D &quot;set $za%dvq%d[%d] =3D 0x%x&quot; % (i, j, k, MAGIC)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 gdb.execute(cmd)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 report(True, &quot;%s&quot; % cmd)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for j in range(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for k in rang=
e(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 reg =3D &quot;$za%dvq%d[%d]&quot; % (i, j, k)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 v =3D gdb.parse_and_eval(reg)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 report(str(v.type) =3D=3D &quot;uint128_t&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;size of %s&quot; % (reg))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 report(v =3D=3D MAGIC, &quot;%s is 0x%x&quot; % (reg, MAGIC))<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for i in range(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for j in range(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for k in range(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot=
;set $za%dhd%d[%d] =3D 0x%x&quot; % (i, j, k, MAGIC)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb.execute(c=
md)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 report(True, =
&quot;%s&quot; % cmd)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for j in range(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for k in range(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &quot=
;$za%dhd%d[%d]&quot; % (i, j, k)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D gdb.par=
se_and_eval(reg)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 report(str(v.=
type) =3D=3D &quot;uint64_t&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &quot;size of %s&quot; % (reg))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 report(int(v)=
 =3D=3D MAGIC, &quot;%s is 0x%x&quot; % (reg, MAGIC))<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for j in range(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for k in range(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot=
;set $za%dvd%d[%d] =3D 0x%x&quot; % (i, j, k, MAGIC)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb.execute(c=
md)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 report(True, =
&quot;%s&quot; % cmd)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for j in range(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for k in range(0, 4):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D &quot=
;$za%dvd%d[%d]&quot; % (i, j, k)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D gdb.par=
se_and_eval(reg)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 report(str(v.=
type) =3D=3D &quot;uint64_t&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &quot;size of %s&quot; % (reg))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 report(int(v)=
 =3D=3D MAGIC, &quot;%s is 0x%x&quot; % (reg, MAGIC))<br>
&gt; +<br>
&gt; +<br>
&gt; +parser =3D argparse.ArgumentParser(description=3D&quot;A gdbstub test=
 for SME support&quot;)<br>
&gt; +parser.add_argument(&quot;--gdb_sme_tile_support&quot;, help=3D&quot;=
GDB support for SME tiles&quot;, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 action=3D&quot;store_true&quot;)<br>
&gt; +parser.add_argument(&quot;--gdb_int_cast_support&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 help=3D&quot;GDB support for 128bit int cast&quot;, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 action=3D&quot;store_true&quot;)<br>
&gt; +args =3D parser.parse_args()<br>
&gt; +<br>
&gt; +if args.gdb_sme_tile_support:<br>
&gt; +=C2=A0 =C2=A0 if args.gdb_int_cast_support:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 INT_CAST_SUPPORT =3D 1<br>
&gt; +=C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;WARNING: The version of gdb u=
sed (15.0.50.20240403-git)\n&quot;<br>
<br>
This is super misleading: it looks like it&#39;s printing out what<br>
gdb version we ran the tests with, but actually this version<br>
string is just hardcoded !<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;does not support casting a gdb.Valu=
e object to 128 bit python\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;integer. Thus, the testing for the =
ZA quadwords will be done\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;without int casting. Refer to tests=
/tcg/aarch64/gdbstub/test-sme.py\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;for details.&quot;)<br>
<br>
This is a big warning that doesn&#39;t convey anything useful<br>
to the reader (why do I care whether your test case<br>
is using int casting or not?).<br>
<br>
If there is part of the gdb view of the register that we<br>
can&#39;t test on some gdb versions, that&#39;s fine. To handle<br>
that, split the test case into two, so that for the<br>
test that needs a newer gdb we report the test as SKIPPED<br>
because gdb is too old.<br>
<br>
Please also write some comments that tell me what your<br>
test is testing. I should not have to reverse-engineer<br>
your intentions by reading the code...<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--00000000000008a65c063e4e6977--

