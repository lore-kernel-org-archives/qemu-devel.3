Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C450EECD9B0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 22:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo8Id-0000Ei-3m; Thu, 05 Feb 2026 17:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vo8Ib-0000EE-8O
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 17:58:09 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vo8IZ-0007kl-Gl
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 17:58:09 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 615EI4qk890430
 for <qemu-devel@nongnu.org>; Thu, 5 Feb 2026 22:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KONd5CgKNsu6htILWGSp55OuoiR84r0Utp5L/2dq7Ok=; b=Amm2D2+sWzBfXY3v
 mWTQIe2b0IukKiA1DPnR2lVGFHktxvFijPgv+95LuJuInwshebcplvhhFOOiswz9
 jyaKGVafhVg+43TFagUd7BnTiyVGU8jsieLFNN8K2Me3th2ZMmg60tE4p3ur+k5b
 MR8wmlU9c8wa7sKPRDWFgohcwYW0k2q9Jm4/isF3CAMcZdTTf1CDD60cZAvgYvCV
 nl0dKnmb4W3E8StBORg1tqS/IbUhT2QOjzPT4l9HYyTc2BhP7LueIr6/BFrlYxov
 SUKqDJlczDydk3h6Rr/qHnGTrHq8IFmsrK9DgoeQm/VbYh7tdKCKPlOB63Tyn5hR
 9DE9xg==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4prxay3s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 22:58:04 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-649b2db7b8fso254954d50.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 14:58:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770332283; cv=none;
 d=google.com; s=arc-20240605;
 b=fMtU+dOb/xpWij0pV72ybAhKcwkU/ovPzAK7yY3+sv+fzZlEPgoXZX3a0uD59rXvIp
 vydNMxdEU45ZH+6Q7i/po2zmlSOB3GB5sY5h4b1iVOU9m6VLlbwx2EG9IcLJfAbCQKyl
 IPt4fMACKvgnHBlPN6xkwMhuN2I840PZOsDtH01SlK+Rky1CZVqWwtkJnnhpgrEhm1fp
 E07CsM8anUMkd6xxmGXW1v2mhDsaO/YRlxXlhvcFR2fSj1HCX+tVg10rkZT/Qh2tcVdG
 D/TeuHxHybZ7A4rwQ4oS4yQLgpjG2+OC5QzYmAHOwUFnA30mEDtgZAd7PbH9nq7QPYSz
 V+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KONd5CgKNsu6htILWGSp55OuoiR84r0Utp5L/2dq7Ok=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=IFOZZBHPvCKKYisPnA0edBr0o68Bso9VTNZz2YfMSflWHV8LLIUUhwnPEJizEwMyIs
 qus+UNIDvTEERrQ3JYldoqREp8TjV0b2kebDVsdRvqQXx390l2VFZjcGi29zpYy5QTJK
 xHmLJcMbZuanCJopDXk3y7ARn+2Mv26YTxRbwTLoxCmzBICufxKawYVPFAF5erutZcjb
 KqUMK4XiH1jHPbJ/2J/XSPyC4XLLn42XdAkOscTaReNn3xWaem4Vml8wVDQl3i9l/tZR
 75wM5MWMWVNtjnyn1tKk1gb5GVTEPSe78389y4qBNqvwAmKYR0cIL124mGFdNHT8FMrZ
 d74A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770332283; x=1770937083; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KONd5CgKNsu6htILWGSp55OuoiR84r0Utp5L/2dq7Ok=;
 b=cqgU72V15Sp7rpZ2OYJxTDaI8TP7Mj98NJagEN0qCUO5JPH5vLkGuEmiM/06YHanzE
 kCOXfIIBJAwWFeb870iFeBR+b7L4xQi7+M6EUotoyEo4f4cmb75UJIpZKNgCEQOU5JyC
 M/T3cm6Ogp0Qck8jjKl+cKvCrclJeKfmwPrS51q2+hlbEGa5iyNOeo4lUSmdQcckB32n
 w2123S0qjFmgGvmvJmfkF/CslLNYFTx79iyi5tQ57taJPm4eiQBZUptsOJo6AC0sxwBL
 VykhuXREWlCksl7E2C6OlNqrltY8V4xnnl8m9zm4kUCjwO5FXv/SbwQMQ3CTcgnM0ydZ
 JDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770332283; x=1770937083;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KONd5CgKNsu6htILWGSp55OuoiR84r0Utp5L/2dq7Ok=;
 b=hL3HHS8+626PgfDCEVfBeqzT+pwaVEJp2uxZv3Nd4VN+TzbAoYKEqBLYqU37LF12JW
 aSNQ24DWNL/nx9iSh0JnwqwqYGSnpnsvT+qXkIjGKDL5QF4J0aVmNy4Lc5YzhFyv/hid
 TjqAyjCPWiuTbZK1Vn1e56bHD9LCd90aZvECemHAqVyR24Nyo+azi2gZIz8zN2gpGp4o
 v7XaUh8HnP67WJ4vPXOvS5Un7vy5aVe7/lKhq/gggceE7+Sbi3RJOdH6m2nP+1HYEhNT
 nGf5wjJ2/4uYskgO26hgHrtr8RmlVETcx9nZgYei7Q+SJkbaGhYe8RGb/OoZ/3dvKQWQ
 BWsA==
X-Gm-Message-State: AOJu0YyDWtyYOXzbWhsN+GvvyhJbRvAeP097afhNrjupfjQm8UAHgz/g
 IOrGAPC/I2a58gHeXVOeyrGO8gUZmlDyx6WnKn6RdZAA/rd03QEP10jZ8KzzAxSrIi5JsnXSpeS
 0SXYAKEBo2/M8cQyX70PJ6nCBum5dOy5ph6WegVhhx+szS+qPvZTK4m6ZxSF8PlpxD/IfoSG1MN
 ZLA2tJNUTcew6/X4uqrDkOu2SBJujdcUik
X-Gm-Gg: AZuq6aLHd21QL+SbAASYjqAtOpHCOrATquV810QEo2Lr28Ye43D2cgKBKZHjpVvmnTn
 qtD5GXnIe1CRy46NcOJcP+9ZvgtvVJ5VTAiVFEdxBH/pmb5l/F0pdx0jSE2HNhMF36mjrypgO8j
 xtmEDye1XhgC95+saI32+tGhtkyZRzsqC86Pk8wj4TBdbLp0qRQUZQEiz7k6H/kbm2+IGL
X-Received: by 2002:a53:e026:0:b0:649:f09d:a6e5 with SMTP id
 956f58d0204a3-649f1e7f02fmr789056d50.28.1770332283248; 
 Thu, 05 Feb 2026 14:58:03 -0800 (PST)
X-Received: by 2002:a53:e026:0:b0:649:f09d:a6e5 with SMTP id
 956f58d0204a3-649f1e7f02fmr789047d50.28.1770332282843; Thu, 05 Feb 2026
 14:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20260205030617.266625-1-richard.henderson@linaro.org>
 <20260205030617.266625-2-richard.henderson@linaro.org>
 <CAEqNhNbw3EKT1Cra4-UjMxvNCa+4Acjg_OFwdLvBdW3rcLudLg@mail.gmail.com>
In-Reply-To: <CAEqNhNbw3EKT1Cra4-UjMxvNCa+4Acjg_OFwdLvBdW3rcLudLg@mail.gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Thu, 5 Feb 2026 16:57:47 -0600
X-Gm-Features: AZwV_QiWJienym6ZFWJro0QXz7OY5pSIBZFx5hoXq-SqRusknjzmdADxgctWCQ0
Message-ID: <CAEqNhNb-1=c5BrU=QELN3H-1tWGfAZdbT9n+mZcsTucmUSFMwg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] qapi: Add hexagon to SysEmuTarget
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 91UFIVvYlcQujizf4PM1uCka3kLMieIW
X-Proofpoint-ORIG-GUID: 91UFIVvYlcQujizf4PM1uCka3kLMieIW
X-Authority-Analysis: v=2.4 cv=eLkeTXp1 c=1 sm=1 tr=0 ts=6985207c cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=q5SSVc-MZoyQ92AyfaAA:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE3NiBTYWx0ZWRfXxOSJyVR/+9z+
 Ny8D+IomONhpPrWw3oY+bSjQfl9jQKqyKLKsGUL2vE+00YL8aI84LvwQJIqBMQJ5g2Y8/XYSBeQ
 2iEy3SBCduIRcewQDKDLV6n7e1ugWIRx2LtVSoR7kMZKlzJjxCGCipuAm5pUpU2WQxt9orwMW4+
 VoeT2oD7LgpxkznihUGapZjDKV3MuW4SJsAkm2qTAS5qDrCzcN/wXvy09uo7axuIEM6tI+JernA
 56zrybEMaK1bxPfkM1xhxjFZkIegZ45HVI9WL/oiKjwZfnHakDIwM6StoxxybWPnQyC+I4TOi+B
 NDRND1+OL6I7stD9Jy0FkgSwsTRM0sfA0+ahFstmLz56LyJUrrv23i8qgjoQUkY+ApMTZRoWqWg
 3myAdisq0qRihh5SULaHQNA3QcmmQ90bTKzlVq9hdXLmqknJmdrkec9QjqXH1JGkGlZH3LTwqfK
 fAbqFI2NtFV6jzvfU/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_06,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050176
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Feb 4, 2026 at 9:49=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com> wrote:
>
> On Wed, Feb 4, 2026 at 9:06=E2=80=AFPM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Whoops!

Reviewed-by:  Brian Cain <brian.cain@oss.qualcomm.com>


>
> >  qapi/machine.json | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 907cb25f75..ef8575b6eb 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -28,6 +28,8 @@
> >  #
> >  # @loongarch64: since 7.1
> >  #
> > +# @hexagon: since 11.0
>
> I-owe-you one hexagon sysemu :)
>
> > +#
> >  # .. note:: The resulting QMP strings can be appended to the
> >  #    "qemu-system-" prefix to produce the corresponding QEMU
> >  #    executable name.  This is true even for "qemu-system-x86_64".
> > @@ -35,7 +37,7 @@
> >  # Since: 3.0
> >  ##
> >  { 'enum' : 'SysEmuTarget',
> > -  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hppa', 'i386',
> > +  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hexagon', 'hppa', 'i38=
6',
> >               'loongarch64', 'm68k', 'microblaze', 'microblazeel', 'mip=
s', 'mips64',
> >               'mips64el', 'mipsel', 'or1k', 'ppc',
> >               'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
> > --
> > 2.43.0
> >
> >

