Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0ACEDEBE0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 18:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUG1-0006Ek-1l; Tue, 03 Mar 2026 13:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxUFy-0006Cx-71
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:14:07 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vxUFv-0003MA-4d
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:14:05 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623H0h4P1512046
 for <qemu-devel@nongnu.org>; Tue, 3 Mar 2026 18:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=9/sCYa9L4JjapI+5oeN04D5J
 wpCz9MX3bzNySnUQE+E=; b=l/gSzWKU0maXXnh/Pw8d4GCA4y5a584AICBli8e1
 roaQloj2oX8uRuFIvf75r4SraqnNCdB5bspEKZVGjlUsnnl7nqrGoGWhIbKF2PFo
 KNiOUrNxTnEO7/HXtLHKJ94lyWHcj29lZCjge+1BbxwLhMt5CXhAYsFCA3f2bR05
 qZGEcJ+H0mvQYaq8kirpZi8hr7Af0SCLOPHak5cHRxHsthE3HoDXpfISM4YBUVMK
 8DJaKP0NRYKGVKOjWUEj2ruRgwds3chQ9QF2jCUUuRR4QtwCRn26ZG3DdhdPPCN2
 e7EZU3CkgJJmg1OC6Hyu2aIZqJuchTX9Cj/NzfQcAKgd0A==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnh6uc35n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 18:14:00 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-79874ae3e49so94224467b3.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 10:14:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772561640; cv=none;
 d=google.com; s=arc-20240605;
 b=YHIM949Xw1/gwtn0fYZR4zfVVWYPtkQp6SRQgv+WNENsqSBPXOFrTLu4b18ALfoWiO
 GJgdPXSou+yQIOGBVH39jkxYbW04luTRjxcSzTs5jvL4T523MgMFmGGfnLLWgMNuPPq7
 MMhaFLiUVqi8QubZ2RyqLYtL6VsUUB8CirBKDFO+O8vs+AGQSkgbWOCU3eAvXiaxjzCz
 TFL7zndfLXJiRW38WHXWHX+cSANgcVo7MCHwC4WSSr1SK0/b4O3xNwiaiV5qDfkISqGf
 K1wAUCV5uufqAFVjUgrshCLbrVWTOj/WO35A0Lx9HOhyMo3/kk/V9bxzPeVl3ZXGlAZA
 nUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9/sCYa9L4JjapI+5oeN04D5JwpCz9MX3bzNySnUQE+E=;
 fh=LVfszL21/WHTfDZmq9lF6NsCNiLUixDYO6IBCXf8cGY=;
 b=Hh4AWLu899GNvrtIb0LjjmxF1vNh8dtJPj2pgsWvOZ73Lkman+YVvJT9kOuBqWEi7k
 g1lWlDFBUaETCfoegnIabiN14b0aQmAkzHQKEKziNDMKtB/Zz4konv+yBdWYI0MdabOJ
 E1ZxTNt6wNEnjByw2DMDlbSuBNkSxew3ZdOyNp2Jb8+qlytLOVI/5P3Wwlqhuozms0oe
 dIHsBkGz+jszAyIBrqpkcZ4VF8GRK1erH0P7mX/GOaMb48QK52WNYN6VKxfKAam/MvYk
 DFVba57ImBdcZV+mdsNKV+bGI73SyVhv87sefgGPq2y1OlleJWz7QyIcRYQLkknEArdh
 yYSw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772561640; x=1773166440; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9/sCYa9L4JjapI+5oeN04D5JwpCz9MX3bzNySnUQE+E=;
 b=bLhLL6qH/GEZzjD2jnot7zYx4olRMfu49iIU2+tc43gn1Gn3u+aaKBrxHEXaCKJtX9
 YOlqz3Y5Td5R56eddQ/rQqucEQ12YaLBwOkpeOtc6RoHqBycpKBoKP8Umt119Xjh03cW
 PWEuEVwUz9sotmUKRDYWf1lyIF23tQ4uDaDZBbsLWn7D66HSO06noeMv7qwYFYYMzpMs
 nU3uh7wsoIc8ivfAXjEmw2pKbSSvepPKcCWLf5fDxKObnmSxBSOExGlRK+oz8VZjv/6y
 CkvWA7e65gFqgc4vM0McU/UNW5uMLvg3Rw6Op7G/fAgv0JZRYq0fPdshcA7rJRV6jJxL
 lP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772561640; x=1773166440;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/sCYa9L4JjapI+5oeN04D5JwpCz9MX3bzNySnUQE+E=;
 b=aHFmZLpZiVJ6ptLiVJhmfKySGN3zpchByQyRjhLUoZ4gF2l4CwfJ22qJ0hA6RgZN1Y
 A8zlN3fd1iAjumEtzRZZ469iuZIYK+mf9IuQSlSvMkP3mnWL2y7IsdI06EWBuazPywXM
 YoUeH2rXMqZRsrGuHW5lif2rD8d62MJY7LBgSqxis4T9yf1Db1D48SIlUE+bEa9o+/Y6
 43qRtChs2+ItTbRmaAdYeYT0zXdcAviqw6jLMSy9VTJLE37kqqhpx2dhjUaYV5mGfeks
 Oib0fdPQonC60vimLt6+Lf2XBGQ/ivYtx2BsHSMOGAW+NqC/5WRly4gbH86+es+D+gtM
 zNJw==
X-Gm-Message-State: AOJu0YwYvv5fFGDaN761xQREoQ6thfFAyur0oswzRkXTk/1z1h0HvSeG
 e2g9+hulRxDfmAsVhLatvGLFzd5xYsIQZriD6V3EXx0iDUcmlNMoAs3X8p5bEOMSDczJ/k4aGXK
 OVzrWyiRIg+0fVVvtkBU+tUMlKvrz8OXsSfaE+aDpt/Le8Xm6iJW1ZlMThl4UI5Y/UKFHETnDrQ
 9OBI8HZSOVCGJ1TTTkSY+WY2f90KV98/Dr01HSWy26
X-Gm-Gg: ATEYQzyrOcZrWCzHPsq6U/HtLk/7bf1KgRfg/kxYuphAHgbpcy0RsGiBn8R8hUn+V4H
 lTK0WW2g46nULXAqJpT5/RIvm9i2lm+0Rkdn2fDqOfzWUFP4Wlj9+ihMYH9/RJ1NClSlH+/swFj
 xgxULARn6WOnYkNPm3dF1ML8eIFGNNcKlE5U82UzXkttOj6YiEThbBevGNjXFunVlMDaXswHQFg
 hRzR+U=
X-Received: by 2002:a81:be06:0:b0:798:53c0:f4ad with SMTP id
 00721157ae682-79885477e47mr97960567b3.7.1772561639732; 
 Tue, 03 Mar 2026 10:13:59 -0800 (PST)
X-Received: by 2002:a81:be06:0:b0:798:53c0:f4ad with SMTP id
 00721157ae682-79885477e47mr97960367b3.7.1772561639280; Tue, 03 Mar 2026
 10:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20260303175444.1540049-1-brian.cain@oss.qualcomm.com>
 <aackLWHOKc4ZgHrU@redhat.com>
In-Reply-To: <aackLWHOKc4ZgHrU@redhat.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Tue, 3 Mar 2026 12:13:42 -0600
X-Gm-Features: AaiRm51iJd4-hIzb9xEClMaHuHLKn6h3CqXlQ9zg55OkKEyG12yxUpCyQri79X8
Message-ID: <CAEqNhNa=7iG5nZ1Bg7pqwredOq1fgsKK0Vrg6wKW8K4Cnjk_UA@mail.gmail.com>
Subject: Re: [PATCH v2] tests/docker: Update hexagon cross toolchain to 22.1.0
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Content-Type: multipart/alternative; boundary="000000000000da2232064c22aac4"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE0NiBTYWx0ZWRfX8TwJLY0S0CYF
 /o426ax4ZBS/reXzdoYcv8o04NafCqCifM43sTPe6omocaNP4TJ7gQV+2sm4vw92wExiV9rkcmr
 wYRpSb7h6/1CPIqccDRefGt6fJXAZ/BLCaNsQle1RFSPmNvpkKMNbLIUX7CvCG62N0TF/cRdzGc
 OwCaxfk9t1Bxm+FUq2+P2n1TcGQUD7hB2btFssf+vAdBqIcMSWIjL8skm95T0LVSEGAYEcTD21q
 t1c1cO/sGNvQRKxTBqH3Vf3qMJeAXyO4gDoHlSrkwLH1CUWrwt0C6xufPOZ+u6UnOU1ySOesaoN
 AxCBNz9o/ipa7dGd49zEX+qzys9c5c2Zgn6NaCmE4lFWXU58LNAeHssNTb2p5npEqPoEar69VkR
 2r6sAo9aKlfAv/5+JVo5E0MFhD20vUlkPdxIZwcstHHgjkoahJBBWUqRSGqKBnXffXrN2Nr+lxF
 W5SC6XNoLV9u4RCkShw==
X-Authority-Analysis: v=2.4 cv=MuhfKmae c=1 sm=1 tr=0 ts=69a724e8 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=E2OFlpCjAAAA:8 a=vqL-DJG3AAAA:8 a=SqMvC5kiAAAA:8 a=J7Vs0gARAAAA:8
 a=iXcLlBOuAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=eiq4cRctz5pzk1b8hFsA:9
 a=QEXdDO2ut3YA:10 a=cefaDkQiAAAA:8 a=bk47Q1N_7GAENjVVX1MA:9
 a=kVSYkK1pXjtN1t1z:21 a=lqcHg5cX4UMA:10 a=MFSWADHSvvjO3QEy5MdX:22
 a=l0t8tTNIJzRGstKQVvrs:22 a=N5whb6oI2XAsh5LpMrx1:22 a=_o8VnCo6Hb5Oqlm6Mk7M:22
 a=GK7RtA2AnwkbbjW1WRsD:22 a=U82d2PgYpd_3u6iqMSvn:22 a=G5zjLSlu2lozinEgn0u2:22
X-Proofpoint-ORIG-GUID: D4xE2bL2HQY7jUJlBxYTaMR2Uj6kJEhb
X-Proofpoint-GUID: D4xE2bL2HQY7jUJlBxYTaMR2Uj6kJEhb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030146
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000da2232064c22aac4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure - will do

On Tue, Mar 3, 2026 at 12:11=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Tue, Mar 03, 2026 at 09:54:44AM -0800, Brian Cain wrote:
> > Update the hexagon cross-compiler Docker container to use toolchain
> > version 22.1.0, replacing the previous 12.Dec.2023 release.  This relea=
se
> > has valuable compiler and linker bugfixes, but more importantly it will
> > enable us to target DSP arches up to v81.
> >
> > This requires upgrading the base image from Debian 11 to Debian 12
> > because the new toolchain needs glibc >=3D 2.34. Additional changes
> > to accommodate the new base image and toolchain:
> >
> > * Use DEB822 format for enabling deb-src
> > * Add libc++1, libc++abi1, libunwind-14 runtime deps for the new
> > toolchain
> > * Add zstd for the new .tar.zst archive format
> > * Replace pip3 install tomli with python3-tomli system package
> > (Debian 12 enforces PEP 668)
> >
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > ---
> >  .../dockerfiles/debian-hexagon-cross.docker   | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker
> b/tests/docker/dockerfiles/debian-hexagon-cross.docker
> > index 23152b4918..00d7834506 100644
> > --- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
> > +++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
> > @@ -5,10 +5,10 @@
> >  # needs to be able to build QEMU itself in CI we include its
> >  # build-deps.
> >  #
> > -FROM docker.io/library/debian:11-slim
> > +FROM docker.io/library/debian:12-slim
>
> Can we go straight to 13 please.   We just updated all the non-hand
> written docker files to Debian 13, on the basis that 12 is going
> end of life in June.
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--000000000000da2232064c22aac4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e">Sure - will do</div></div><br><div class=3D"gmail_quote gmail_quote_cont=
ainer"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 3, 2026 at 12:11=
=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.c=
om">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On Tue, Mar 03, 2026 at 09:54:44AM -0800, Brian Cain=
 wrote:<br>
&gt; Update the hexagon cross-compiler Docker container to use toolchain<br=
>
&gt; version 22.1.0, replacing the previous 12.Dec.2023 release.=C2=A0 This=
 release<br>
&gt; has valuable compiler and linker bugfixes, but more importantly it wil=
l<br>
&gt; enable us to target DSP arches up to v81.<br>
&gt; <br>
&gt; This requires upgrading the base image from Debian 11 to Debian 12<br>
&gt; because the new toolchain needs glibc &gt;=3D 2.34. Additional changes=
<br>
&gt; to accommodate the new base image and toolchain:<br>
&gt; <br>
&gt; * Use DEB822 format for enabling deb-src<br>
&gt; * Add libc++1, libc++abi1, libunwind-14 runtime deps for the new<br>
&gt; toolchain<br>
&gt; * Add zstd for the new .tar.zst archive format<br>
&gt; * Replace pip3 install tomli with python3-tomli system package<br>
&gt; (Debian 12 enforces PEP 668)<br>
&gt; <br>
&gt; Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcom=
m.com" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .../dockerfiles/debian-hexagon-cross.docker=C2=A0 =C2=A0| 19 +++=
++++++++--------<br>
&gt;=C2=A0 1 file changed, 11 insertions(+), 8 deletions(-)<br>
&gt; <br>
&gt; diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/te=
sts/docker/dockerfiles/debian-hexagon-cross.docker<br>
&gt; index 23152b4918..00d7834506 100644<br>
&gt; --- a/tests/docker/dockerfiles/debian-hexagon-cross.docker<br>
&gt; +++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker<br>
&gt; @@ -5,10 +5,10 @@<br>
&gt;=C2=A0 # needs to be able to build QEMU itself in CI we include its<br>
&gt;=C2=A0 # build-deps.<br>
&gt;=C2=A0 #<br>
&gt; -FROM <a href=3D"http://docker.io/library/debian:11-slim" rel=3D"noref=
errer" target=3D"_blank">docker.io/library/debian:11-slim</a><br>
&gt; +FROM <a href=3D"http://docker.io/library/debian:12-slim" rel=3D"noref=
errer" target=3D"_blank">docker.io/library/debian:12-slim</a><br>
<br>
Can we go straight to 13 please.=C2=A0 =C2=A0We just updated all the non-ha=
nd<br>
written docker files to Debian 13, on the basis that 12 is going<br>
end of life in June.<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer" target=3D=
"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"noreferrer"=
 target=3D"_blank">https://entangle-photo.org</a> :|<br>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer" target=3D"_=
blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =C2=A0 <a hre=
f=3D"https://fstop138.berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div>

--000000000000da2232064c22aac4--

