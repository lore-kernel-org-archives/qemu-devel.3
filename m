Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D4FCAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 13:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyVyO-0005ma-KA; Tue, 16 Sep 2025 09:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uyVyN-0005m5-6X
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 09:43:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uyVyC-0001Rb-C4
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 09:43:54 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GDatwQ015414
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 13:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=f0K9TPrH9RrXNhcijRCQEZ9C
 uudDMD6CPKKAC1xSQZA=; b=FIyMzFnASVAsDW0SRBbGe9PIUqI4xqYlxUSp/2lt
 R9jpLD8BpXWdrnP9lsnfz/O02ophwEpDvpCwRUs4vqUyNjwauTyUEYz/pfvkpGGK
 DiPU7xA7/EbmQBJwV/52kwU2OFLb3pDlGTJ8okcw+gcyq45OsTCD/gCYaFnuL4R3
 z4O1yI2DRoiTBn31Qhjuz5aGdIs6FuSWq+9C7bi1F/ULhZfNGThAuG4fxRcRLApR
 jmgbmKlVOLf0SxqLITjl+LTYm7UJt9qz5dR4W/sr488IbofdF28QwdKqwhM2PuXp
 n+p29y3lWieUIeuEEU9nlKD4wywAGSG0738n59hxZY+I4Q==
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g5n4pqk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 13:43:39 +0000 (GMT)
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-ea40012493eso1908564276.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 06:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758030218; x=1758635018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f0K9TPrH9RrXNhcijRCQEZ9CuudDMD6CPKKAC1xSQZA=;
 b=VHZ3B50TRBO408S+zqIkfqwn0IS9sG8zAQ3yBaWAG9WNkPQhe0b6fKwqKeZYZYZoCY
 CTpaqP12yJLQnczEaWtRpsv+ce1/IevRCw0pOtzmkmwJrkEeVVZODOUtwYbWl+1UDnV9
 oc476ruFwJU3FX56Xk5y/kM4FdL1+sSP0yg2L6wUCKYyVMnp9LRLFexCpNtcjVcgK22K
 8sPhgdBHKQ+G7CuZjf6nM7NaxsryEXXqj2JMobn4dze8LBdfj6O73o8TrXB77nJGoC5A
 HC1y/lBXrDnng3TRGmEiVdtY/Jk+uwl9gHy8eWqupfKiAaHMuYWtFq9kzlrt86oe3prd
 w1fQ==
X-Gm-Message-State: AOJu0YzlM80OVkvjB9sbFTt1yNCohhcuhsuV3KV9zOmrSYbR54qMW062
 OxRvRrwzWzpNmrfPquMt4cH+EDc1v+OHrQQIB6CXkdNSD8gozTA5+/jB2r/tP+vwHfju/RPxsWN
 8D12zaQP3LFIKgY+FB6qsEnCQmN7fc/NjQMiVQO/GBrAYBnGZTWmW60pghixncYprCvpUjCkNZd
 F6FR3ee7lMMg0R6nzM1OlngkuV/ueiiis8
X-Gm-Gg: ASbGncuT4E+IyR7P6nC0tof7mixmP+whyOb9J9HmEp/+NgxwSlhs+iRksp+2myLbuX3
 bKaQIb5z28dRxeCvMhBUcpThQ+gtNopnMBzeZsLrFLr7zDazN7bcjCXz/IOSio1HIsP0UeWAzj9
 U8iIvEUruo0xfC40b8Wio=
X-Received: by 2002:a05:6902:6c18:b0:ea4:174f:bb1f with SMTP id
 3f1490d57ef6-ea4174fbf7bmr4935194276.18.1758030218324; 
 Tue, 16 Sep 2025 06:43:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn7TN/NxzfAtzqXy6t5bPCknaX08IjYkmW0gdUhZEpB651QLXV4uOvO7hkKm8BX6+3hEvIGQcshUYlqqLpAyo=
X-Received: by 2002:a05:6902:6c18:b0:ea4:174f:bb1f with SMTP id
 3f1490d57ef6-ea4174fbf7bmr4935153276.18.1758030217735; Tue, 16 Sep 2025
 06:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250909161012.2561593-1-vacha.bhavsar@oss.qualcomm.com>
 <CAFEAcA-xdREOLGyQkeeE1SxAH+27G9aepjD8jGoEJTbcLrm4+g@mail.gmail.com>
In-Reply-To: <CAFEAcA-xdREOLGyQkeeE1SxAH+27G9aepjD8jGoEJTbcLrm4+g@mail.gmail.com>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 09:43:26 -0400
X-Gm-Features: AS18NWCDbiRVbuXU25qdrKJpkupKEJO_V7MwmVneLMRA2MYvXS3pjyRwV3Pp03U
Message-ID: <CAEWVDmvZDJnfz47NBGs3HDkAmQL4y-1Pujs3diUOm1UUvgPMcg@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] target/arm: Added support for SME register
 exposure to GDB
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a2005d063eeb4ea3"
X-Proofpoint-GUID: LVoCk4pXSDVub03_s8oaKsJIpKb6W1WQ
X-Proofpoint-ORIG-GUID: LVoCk4pXSDVub03_s8oaKsJIpKb6W1WQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NyBTYWx0ZWRfX4GfOBn3s71FD
 O4/jkxtLupvomelwerCkh7JB+WP50d4icFJ5r49lmiNW6D2WzHlz+4xLnsryV5ZtTxHmR1Xzn3f
 T2PnBZ6/+Kjtbz63vTvjRGkuH3hGsCBr3hBUPk9YgwiaqcaIXBwVz9knpDj2n0zoB3Oe1FmerPr
 1NvZks/7cSwnuyqPny7UP4PF9gum7DRkOsBjVTGcxs5Z//eKRptfLwIKvZW7MjxmbmOYlDVroJW
 a5hBwy5wC6KJapObxKDuR3k9PeT0TCfrVT8n8BmBEza7XIQm1J20Pp+7/xJBI/uxjnLHUIftKQ0
 oTjif9rUhVdp7GcG20GbZ4cGHaxW4JHPY7Y0RiFpZY+L+mjzTETN3KmQUfbhXn2wmMT/LYWT7+C
 6gjqxlCL
X-Authority-Analysis: v=2.4 cv=SaD3duRu c=1 sm=1 tr=0 ts=68c9698b cx=c_pps
 a=5rZgxjGdQ1phXw1xqkF1vg==:117 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=fIeqX_urXbaYukCIe70A:9 a=QEXdDO2ut3YA:10 a=UDFYyeKIAAAA:8
 a=l8T_Kw-7r3-X5QYjpLkA:9 a=A-ZZsG7qi72MXd9y:21 a=lqcHg5cX4UMA:10
 a=FvMT9AR2qkiEEVpopuB7:22 a=cvBusfyB2V15izCimMoJ:22 a=ItlKd2BftxWApCZtRiMt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000a2005d063eeb4ea3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Noted, thank you!

On Tue, Sep 16, 2025 at 6:39=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Tue, 9 Sept 2025 at 17:10, Vacha Bhavsar
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
> > Additionally, this patch series increases the value of MAX_PACKET_LENGT=
H
> > to allow for remote GDB debugging of the ZA register when the vector
> > length is maximal.
> >
> > We have chosen to drop the patch related to changing GDBState's line_bu=
f
> > to a dynamically re-sizeable GString for the time being.
> >
> > This patch also includes a test case for testing SME register exposure
> > to GDB, based off of the existing SVE test case for the gdbstub.
> >
> > Vacha Bhavsar (3):
> >   target/arm: Increase MAX_PACKET_LENGTH for SME ZA remote gdb debuggin=
g
> >   target/arm: Added support for SME register exposure to GDB
> >   target/arm: Added test case for SME register exposure to GDB
>
> Thanks, I have applied this version to target-arm.next.
>
> I had to fix up quite a few style nits reported by scripts/checkpatch.pl:
> for future contributions I would suggest running your patches through
> it. The script is not infallible so you have to use some judgement
> in deciding whether to make changes, but it catches simple issues
> like trailing whitespace or mixing tabs and spaces in indentation.
>
> -- PMM
>

--000000000000a2005d063eeb4ea3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Noted, thank you!</div><br><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 16, 202=
5 at 6:39=E2=80=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@lina=
ro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Tue, 9 Sept 2025 at 17:10, Vacha Bhavsa=
r<br>
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
&gt; Additionally, this patch series increases the value of MAX_PACKET_LENG=
TH<br>
&gt; to allow for remote GDB debugging of the ZA register when the vector<b=
r>
&gt; length is maximal.<br>
&gt;<br>
&gt; We have chosen to drop the patch related to changing GDBState&#39;s li=
ne_buf<br>
&gt; to a dynamically re-sizeable GString for the time being.<br>
&gt;<br>
&gt; This patch also includes a test case for testing SME register exposure=
<br>
&gt; to GDB, based off of the existing SVE test case for the gdbstub.<br>
&gt;<br>
&gt; Vacha Bhavsar (3):<br>
&gt;=C2=A0 =C2=A0target/arm: Increase MAX_PACKET_LENGTH for SME ZA remote g=
db debugging<br>
&gt;=C2=A0 =C2=A0target/arm: Added support for SME register exposure to GDB=
<br>
&gt;=C2=A0 =C2=A0target/arm: Added test case for SME register exposure to G=
DB<br>
<br>
Thanks, I have applied this version to target-arm.next.<br>
<br>
I had to fix up quite a few style nits reported by scripts/<a href=3D"http:=
//checkpatch.pl" rel=3D"noreferrer" target=3D"_blank">checkpatch.pl</a>:<br=
>
for future contributions I would suggest running your patches through<br>
it. The script is not infallible so you have to use some judgement<br>
in deciding whether to make changes, but it catches simple issues<br>
like trailing whitespace or mixing tabs and spaces in indentation.<br>
<br>
-- PMM<br>
</blockquote></div>

--000000000000a2005d063eeb4ea3--

