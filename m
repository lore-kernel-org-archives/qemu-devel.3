Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6DEC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weDsf-00067s-Fl; Mon, 29 Jun 2026 11:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weDsR-00067a-NU
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:26:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weDsO-0008QK-S2
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:26:27 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT6Lq2627938
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 15:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AFyOESO+/WNR1mTkSFW9hEOAlbcFBb776hUaFkffCRA=; b=SWNQ4heOfAs082sI
 WhsIt6fIHblh93rgzTgaeouX4QrHy61W6QHNxPoJjWuU9qxSgQxtNInuPB+TolJR
 jn+2vAYL5LFDYoKrRM5sJQIq5+3jdOPx+9ORg4qKdO6FU0zswj9Dp2WM2nO09JyF
 FPxFAXgXgkpSguiqRwzEZPS6LBymj0VYVgXuv7zTAX2AmvofxHKgFbszozDdgVXA
 yCW40Ei3IwP4OZ+0eq/tKpCnOvBcVqHLCME/5Q1V3YzXFNnXEJ0JheOlJdKwqUik
 EJMY2qR4cXX3YNqIWkGhZs0XUQZ6Hmj6kCC0A/ewF3le36ID5Oa56RpaQY4yE9DV
 6UbBgg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nbgsmxj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 15:26:22 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-137f3465368so4227801c88.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 08:26:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782746782; cv=none;
 d=google.com; s=arc-20260327;
 b=KsMfIWLfuY5ebktx8M1buBbQZwD3Xv0roBQOEldAJ/FXqJgGf5WV10M09w3/5Jf1Ed
 5OUGMpJbRPpOpzdbuvhh7tMo+kZ3LbEulUNI+PJV+omu36iwXzcouIJfDD80GxnMklui
 krfpACrvAjum+JGYhtqaP6NdxmhXdQwm39oLXqz/zadJ5YzfacD3w5YfNkABoCNdcMX6
 24CAl04uQeA7syfmBfFNFZvQB/RWBWTnriTeVStnQW7NJ3H7POPgPYYxfKtzKoZ6Onw4
 GBtD5483ndARZk1WZiRxNJUXRQfhawEFe03kNqCNEEWcoB7hnYe4+t8gQFIyLoac5pYU
 0QTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AFyOESO+/WNR1mTkSFW9hEOAlbcFBb776hUaFkffCRA=;
 fh=iXaGwEf+iMAymjNeFD/yd0eELTBhB7olSksT67XHMyc=;
 b=rkS9WbPsQ/NpOjHV4HlGz0dnUo7DsnbVSzFB5AlFAnS5UvKKJ3CBqJ0iCJlenwa9Wi
 zj4FC0p35uQREtdhZPxGodZRygAncQMfak3h4LZd2wuZsKrxgJtD272J0z84FnHFvqST
 aDvRTxc4SnOAPJzqmgbaTe2Pj1EvfBAmeBViwbg55dIA0Q9e7Vlffq9YxnKJwVoRF4rg
 jM7gOK35MYyvLo8Ml1+HHTAchpkuqUHvZLUcMBPxnITmhSyIMcdexvhmudMn8hX0DW+q
 /ip02KpFdlsBZEn9hXXTD4CJyNEz41bgOqgt98ZO/dhCpT0d8elGfNBbh0FuSabqS/le
 Xd/g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782746782; x=1783351582; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AFyOESO+/WNR1mTkSFW9hEOAlbcFBb776hUaFkffCRA=;
 b=Df+CLtVdMhkCpbjVuXwATaWJyZv7alHRDTVibBAq4M/pUZCsdZ0k0DM1CQOk2o5Az5
 LMYl/8rQPccoJLVumWyNTO0PadFvGKnnnEf8V6RWclqxczAwvYyzEOGdMfPsy4pjk1Gp
 MMiGGEKUV/GToEUFDgPY3K5gGULapU7/zRrqNOeHepYF4X/wC6UQsEumbcPSjzlwWj1a
 TfYGhRNPnjeK41ajVYLx4jTEPMhPRAY1wQSmocE9LvmpPy7viEfy0II5r52kTuo9G/6A
 BBemPW6nZs0D/SmrSQhNlr/WmxhqkriSreVze1TBmll47Tp2Fg/j4ayZf1GFOl1OWNDY
 VTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782746782; x=1783351582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AFyOESO+/WNR1mTkSFW9hEOAlbcFBb776hUaFkffCRA=;
 b=gTIJbyJYPSBYXe/NYlcf4ktd2VT326Q/NY7ssnkK7FT25fzGGJ0uvsBLWJPoyQjTr9
 B5UDgNsljw8azTaGDBeF6LfoHcKLDHWdKNn4BWFtwaVzRjsdhuQmBCPnHkW6rk9KzShD
 85cB2U6ULapzNCxO6Grfhn0wxi9ywjkFpyTo4mBL521lZGiaZlZETckeRD1VuOJDTyAm
 W1+RcUBlDpIoeWgG6uJwcq+92DIddE0LENa/Vgf+DpQTrFOBmoyLxGXBjO7gpMkUvYqo
 ft3r/3L43Z4rBXxMvGJ9EEjh+N92OZOJpRse1UVvOENYrOxJ/R/4DeN2npKMnZkjwWM0
 3tNg==
X-Gm-Message-State: AOJu0Yz33IHfZfYg33g+vpu6a16TBw1tfd2jKklddAvy1M693GNdGzex
 BQZwd8QFVYd5dwzfHLVzF5n+7vMaIO/r/lE+gwnlo7I0oUnaQk9v4g1x9gR24BHRjzEsedM0SYH
 LtWS9a2nYZwzE5BrP2wlCngpuiQU1WXVA2aMsqZP9ZUvjZhPXoJg67rxHDS8NaIv34oHWm2a3ds
 pPslj5POTZZJRV/BgVa7rDyENhxjKU6dU+
X-Gm-Gg: AfdE7ckmHk5Hdk9LItHG0I8fm/l0rdgxNjSQRxip445bmE1l9JHjmTXpvAbN2WcYofj
 xesJkcUscL6k3nUELLIZPCHTQ7W6/3poTiP+lsSuTs03THkPZ2GWxSWP8CApvxB8RL4toSLirbc
 zYZqw2kRHkCNoT6aXYC/rCGuuSDxycc0qQQCXGCRkazL2k1taycXhltBsZfdnUq+eMM5nR
X-Received: by 2002:a05:7022:6a6:b0:136:9ebf:3be7 with SMTP id
 a92af1059eb24-139dbbaf08emr14203764c88.26.1782746781595; 
 Mon, 29 Jun 2026 08:26:21 -0700 (PDT)
X-Received: by 2002:a05:7022:6a6:b0:136:9ebf:3be7 with SMTP id
 a92af1059eb24-139dbbaf08emr14203733c88.26.1782746780896; Mon, 29 Jun 2026
 08:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260628190358.634435-1-brian.cain@oss.qualcomm.com>
 <CAFEAcA8zD4ifpmdTxoMe4jCUGE=jQd6uwbnx5WL92GL9nWsHnw@mail.gmail.com>
In-Reply-To: <CAFEAcA8zD4ifpmdTxoMe4jCUGE=jQd6uwbnx5WL92GL9nWsHnw@mail.gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:26:01 -0500
X-Gm-Features: AVVi8Cf7eg2cgn65bSeG_YOz_kR6MoZosChMi2mQN56cEcigMtYK30wcH05XlFo
Message-ID: <CAEqNhNbCtZzqUxRy9PZ5JyMKbTPKx5jsaPChV229cYvstWLemA@mail.gmail.com>
Subject: Re: [PATCH] configs/meson: disable hexagon idef-parser for emscripten
 builds
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 pierrick.bouvier@oss.qualcomm.com, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: L88shu_xzj_c2yec42dVLZDd81PZ-NWZ
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a428e9e cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=NI4JFcc8okL2R1nn9IgA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEyOCBTYWx0ZWRfXw0Nnk99C9Hxo
 azVXhJubxywPPI65oBhEmS3TekKzBkpCEG6EwgMpSBJmQLeC2LPHVH9XgiwmV7z/QSkB21HLgLM
 UDIFynSbhTt/vyYU5Vium6Kg0AIGgKo=
X-Proofpoint-GUID: L88shu_xzj_c2yec42dVLZDd81PZ-NWZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEyOCBTYWx0ZWRfX46YlSYBbehR8
 UNzNM1u3qHtCy4bt25+ArtY/N4kltQ1ZB7ZQWu+DuREPmiRQiTo1YUsPe1mUSlJN4/kqgzYKgM/
 40fX69AiWAyLWWbsTUFm5lTxkNp0Jmd6Nl0LEdwn+Lq29Kfwhc3CaUa0s7M2juD6jf3t+M12KnI
 Hs5sN4LyAlulNOqnQPbKwspze/7d9ZZIFVktnIUbf5B6yUT1K2Ffe/lbnfhEwwdGTGmhiS8a3ce
 XT36jehJ5xH8eP8wY8OnhLrYUniGEKlO15HR/iolcqP2uG+X2VNkmmhHaxXvQy9zRlvt6jLERUg
 cDDZeQQyijdE937vYELO14nWL1EtBWzPiJftUSqRR4+JMA9ioYX/7FUMi8AnAuPIZdyJ7oJ7/Rq
 srUoaiTD+9XBnZ5y0XU6pbovHkOR3ZRkt9WO/bBMaK399qHdh4NRBhxcodUW1r+46qeznXz2APC
 ZUL3+rSRWJd8TFTrZuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290128
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

On Mon, Jun 29, 2026 at 4:39=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Sun, 28 Jun 2026 at 20:05, Brian Cain <brian.cain@oss.qualcomm.com> wr=
ote:
> >
> > The idef-parser is a native build tool that requires glib-2.0 on the
> > build machine. In emscripten cross builds, emconfigure sets
> > PKG_CONFIG_LIBDIR to emscripten's sysroot which prevents native
> > pkg-config from finding system-installed packages.
>
> This sounds like a bug in their cross build setup.
>
>  Disable idef-parser
> > by default for emscripten since the wasm target does not need it.
> >
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > ---
> >  configs/meson/emscripten.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/configs/meson/emscripten.txt b/configs/meson/emscripten.tx=
t
> > index 4230e88005f..c5c57e392a9 100644
> > --- a/configs/meson/emscripten.txt
> > +++ b/configs/meson/emscripten.txt
> > @@ -6,3 +6,6 @@ objc_args =3D ['-pthread']
> >  # configuration so explicitly add the flag here.
> >  c_link_args =3D ['-pthread','-sASYNCIFY=3D1','-sPROXY_TO_PTHREAD=3D1',=
'-sFORCE_FILESYSTEM','-sALLOW_TABLE_GROWTH','-sTOTAL_MEMORY=3D2GB','-sWASM_=
BIGINT','-sEXPORT_ES6=3D1','-sASYNCIFY_IMPORTS=3Dffi_call_js','-sEXPORTED_R=
UNTIME_METHODS=3DaddFunction,removeFunction,TTY,FS']
> >  cpp_link_args =3D ['-pthread','-sASYNCIFY=3D1','-sPROXY_TO_PTHREAD=3D1=
','-sFORCE_FILESYSTEM','-sALLOW_TABLE_GROWTH','-sTOTAL_MEMORY=3D2GB','-sWAS=
M_BIGINT','-sEXPORT_ES6=3D1','-sASYNCIFY_IMPORTS=3Dffi_call_js','-sEXPORTED=
_RUNTIME_METHODS=3DaddFunction,removeFunction,TTY,FS']
> > +
> > +[project options]
> > +hexagon_idef_parser =3D false
>
> We should have a comment here that briefly explains that we're doing
> this to work around a bug in the cross build setup we use.

Added a comment -
https://lore.kernel.org/qemu-devel/20260629131232.2487780-3-brian.cain@oss.=
qualcomm.com/

>
> -- PMM

