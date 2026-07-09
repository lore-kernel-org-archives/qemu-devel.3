Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BC5C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whrfG-0001S0-Jt; Thu, 09 Jul 2026 12:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1whrfF-0001RV-8t
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:31:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1whrfD-00026p-CV
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:31:53 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669Fe5Ne2302973
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 16:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 12037eYPWT16wRw2DLIF3ZBs9T5xqFc59jM+y+D0gyw=; b=UogmMPtvPLUmXgUO
 8QI7IfkgJYNDdTIbdPeYNdsWGaELCpjfuOlkqv5QE5wLBCxpuyWVGSM/uS9adLID
 iyY0rtT6BwevmuQwDV1v/yedtpgOGWbFWQ01pyH/iWwXF/9XiH4b8w1WCYdPHkHv
 AhI6C059irvAr4DHjpmqiKwaSmvA3mFokFhzH7XtcZ+fdRRDZdR9U1zUV6qMHK7r
 YsESPxeRVKqJ7cJUiuvH+3FM128hfJZcQQEg0XduN+acx2b+XGVA97ZRHZ+jssen
 FkGq6JCQ2Zf5rRVCEogpBi5F3fkIph0XBbRRSIzYadZ+LTaS0yQ9cZ1FxGxNuXuv
 Mh0fvg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3g8x5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 16:31:48 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c8894570b58so17294a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 09:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783614707; cv=none;
 d=google.com; s=arc-20260327;
 b=p4OwAubsz4BPEBI2vVFxZ4ZZ9m1KlVtyJRALDTo66+xpkDANa9kyBVRw0W2U7CVXAa
 qKX/A1wyvT/DydzIjcXD/iBray1F9QqPb2nwU+RoMZoOM0ddvw7a2fHuJ4JXByVyoCO2
 heeNUJzCP3XZOjklsg97gOzhxAHbOcHUz9hRtimCx73tF/ZSpkxbBV7hI8xyptPvmuM1
 Dn/K+6A1PD8t4TOdrpbHkxXb6Ksp3unIUwWs018dLKTFiTw7mJt+sQ5PjN3SnwYlsGRB
 i+UQSgL97953V1rIcxRT0sXIxQ2hFrNXGEIWgPoq5+Qac87oOkeEJRXn/LNOWmV5h0aU
 /FkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=12037eYPWT16wRw2DLIF3ZBs9T5xqFc59jM+y+D0gyw=;
 fh=S8rr1nb3VnO0o6K8z4ZF1F/U+bnCWBd+EKNtloucPc0=;
 b=rpRY9n+y459VMQF52+Rs1hbGhNUCCoIMvTFGZH3jeGsyITHGmLP/cWhThFjbk5EKI6
 qUIx+UgEO7GHy+XIi5UNqIJ8mAtuomrXhPC00J1tkg4eLZdZXnvRWWM0Uc7ef6a63jCG
 Pa0lHw+auvt256GZNuV6hk8byKNnk7tO9Z0Yx3clGRFxu4kFKacCXesUMyydaVQ4iPge
 eDlKMBAuAbgLaPVwjP4VXNt8WAmPNPfg/7nsT83wFPl8CMtq7e9snbn+mG0Kk6tmGKgg
 VA2fgqBxuQVH7U26luKboKNMbnNW7tQkW05WsBSSdPuWuI8XABy0J3kF1F1sjAUdS6Qu
 xh1g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783614707; x=1784219507; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=12037eYPWT16wRw2DLIF3ZBs9T5xqFc59jM+y+D0gyw=;
 b=gMd5eU03NB4guc8qO8bVQZgDW5lzwk4LxEhJBxZ1O8SR1qcdLikhtq/NRFZ/YXRF58
 LZDwd41/rPoGPGMqWaXqhy8rhbWQ1yrxzySZR5P/9SVBrZBtQXYwBk0ndcy32Q/YThZ3
 Fa2ibhBtiVDIOAgtk591JJGNqVsM0Ou+nr0b/pCGGzGNUAsph7bWfmsRPIyok76z9Zyr
 Sm/0C2sJtUYSBIRH7CjXwmTKLPKPduqsEFSJrfSHGZacfOxLbgEIG9w0j6ZnAp3PeLzK
 MF0LkETxGeV0Zka2faMBi1L1BRkSZiOBNxRLU58uzwaVEEaCIFjJaKs0/zIcm4JExAAC
 i6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783614707; x=1784219507;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=12037eYPWT16wRw2DLIF3ZBs9T5xqFc59jM+y+D0gyw=;
 b=O3guAyant/rSiPr2oO946fgC+lcBtDE9ECNPSLcHyItLK/WGxyW/Lr4bbx7rO8M8s+
 v/aQyeDOtZ2YZvrI/NCuBydHtyo8MDeTSS1jDC2M74oTh6sUabrf5gavLxpcFP9NX4Pn
 tA2YIGvxIv/LGE/9OB+5aYFTf2tL4VFwjMzBgkGxmR5/VsJmGpsLMtK1pQB6i/EUCK3e
 isFV8hosnVQkDQ71WfB/o9uoEWF8s0zWcmYN4GtoPvWfQDXtNOazMGChY6i2HNDymNGI
 C4sBaq9LvVo/zitqv4ENscVy0tj/0nBohb0Z0vld4LuxZ7ttQLofrtDuMwzYRvCUqh5N
 63Eg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq06Qm+pfXsJgO8AepyhVQyiXkHvdoGNDTSqx8FQUtEbyFSBGkZDHOae9t9CArBSNw3o/fMn+pVhyOT@nongnu.org
X-Gm-Message-State: AOJu0YwXyYciKhB/5DBf/vTjTaYj8WMib1/ej3JvSZMhMdj7LpGtkDaD
 vrXCErsftLkSBsATUPnbN/Ys1SAb6vSASwlSAZxqEkembrOK51s2SXwKhcej3/WqXH+VDmWqEBD
 UnPAiVxrkJCEhTNJfidooK3X4z63d+mWX8HecmSuaPgq4U3SjB3dtlW1PpS29/yYj3z4v7GPRwl
 P9qZ1OXVvqiXSXc3M453Ajo7n9k/Q+06oN
X-Gm-Gg: AfdE7cnnta3QkyUnw1gpRIz66dzjVOQW62ROqHdnGBUk77qEy3vaIUUjC4IR0+OxVL4
 h0RUBecMMBV/7fg6BVrkFUz5+xdyvLtTdl7pQbYqu0BGP8ULItk2zuS+ThJUTZKnrxHHQPLNsq4
 LmSAgYfjuC1Ckh6ctLsDzOtk/fkP6IWiUfS5ARL1UGY+Hs9JHjqwmVMytnvvSVcDNHqGu7
X-Received: by 2002:a05:6300:2288:b0:3bf:9cbd:9a39 with SMTP id
 adf61e73a8af0-3c0bc8a3ab0mr8631234637.10.1783614707445; 
 Thu, 09 Jul 2026 09:31:47 -0700 (PDT)
X-Received: by 2002:a05:6300:2288:b0:3bf:9cbd:9a39 with SMTP id
 adf61e73a8af0-3c0bc8a3ab0mr8631187637.10.1783614706937; Thu, 09 Jul 2026
 09:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <CH4PR02MB1068109FAF2014DE3A545D5EFB8E92@CH4PR02MB10681.namprd02.prod.outlook.com>
 <CAJSP0QX+aJJKes6zbxKZ0+NEhYydXhK61+cva26jTFw3dLRZMA@mail.gmail.com>
 <ba6246ab-38ad-4d32-be51-51c1c99d2569@oss.qualcomm.com>
 <CAJSP0QV9rQSmcb-K609iSje4VHgs_NK88YXKv5-LtaLGOh-nZQ@mail.gmail.com>
In-Reply-To: <CAJSP0QV9rQSmcb-K609iSje4VHgs_NK88YXKv5-LtaLGOh-nZQ@mail.gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 11:31:30 -0500
X-Gm-Features: AVVi8Cf43qPqdm5yfwJAny2AnjC3A36R0VEvKu5zypLm-kjpbCzl69zMfUVTYeM
Message-ID: <CAEqNhNZqEFz9oh2jY7EDx_ZWBgzTVstQjtZL4O3xSbK7LRwBZg@mail.gmail.com>
Subject: Re: new roms/ content for hexagon: h2
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Brian Cain <bcain@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "deller@gmx.de" <deller@gmx.de>, "thuth@redhat.com" <thuth@redhat.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE2MSBTYWx0ZWRfX2uRjFj3XsBwx
 9Tm9CaoDD/tAWANlNIS5N/3EnCCzEGM9JMm6y8asNEoRE6cVg3Szkk3nnYh5NoVX0AbECyzg+QQ
 7RQcBKbPj65UM30mWSCL/9XCjmVFC/AvwMHSfTzDhzF3xKgUW2VQPzjOYv+ayvtSjqoSfS6cxrs
 ia2V2ecHa93egnxAeMEu+HzHGVeDd8EOE9ucSVT00uhv6HOwmzogOikYoa6w2AkfirnmVmRIJeq
 h6o/XSB01lxTaDT2etYdgm7H8o9K6oQQvAVOPZoOTW1Xh0NgmtPrSf2mxwNCTFYWbJ1UnuZ6XK4
 Rz8iupHJZjaEdIlUiyl+Ohbplpep9k2a3a/nWZjckaZ8rUdoeWht48aMKnERUSS8cRhtxlFKA+2
 fS6a+eX1uIvvrpZXvQyQlerL2Ume9Gee4DhokAJvyxDr5fiO9FjkV+HPYwTLyux9oY8vNOlSnLw
 +RxNGRkMqfkGbf1BhEA==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a4fccf4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=48Ruppd3fJCpEe88o8sA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE2MSBTYWx0ZWRfX9Z1pE+XyCutC
 DzXtiuO13br9HHFAfRK2CmUtMXscZkitnJiD4t4eqtcGe3/5/Vfv7/VkcMLEvZ0qTzOiUKgOwQR
 9F91iZMws3SAuXILNoCjZdzPblvkA0g=
X-Proofpoint-GUID: NBB80f413UefPdeQUUCH8hAAnci4wXSa
X-Proofpoint-ORIG-GUID: NBB80f413UefPdeQUUCH8hAAnci4wXSa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090161
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Thu, Jul 9, 2026 at 2:51=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:
>
> On Wed, Jul 1, 2026 at 10:21=E2=80=AFPM Brian Cain <brian.cain@oss.qualco=
mm.com> wrote:
> > On 6/30/2026 11:01 AM, Stefan Hajnoczi wrote:
> > > On Sun, Jun 28, 2026 at 9:46=E2=80=AFPM Brian Cain <bcain@quicinc.com=
> wrote:
> > >> I'm working on upstreaming support for hexagon system emulation and =
it'd be useful to add the h2 vmm to QEMU's roms/ in order to simplify booti=
ng OSs like Linux.
> > >>
> > >> To that end, I think the initial step in the process is to mirror th=
e repo in the qemu-project?  https://github.com/qualcomm/hexagon-hypervisor=
/ is where the code is hosted now.  And once that is done I suppose I would=
 add QEMU patches to add the build process and build output into roms/.  Ca=
n one of you do that mirror step or suggest how I can do it?
> > > Hi Brian,
> > > I have created a mirror of the stable branch here:
> > > https://gitlab.com/qemu-project/hexagon-hypervisor
> > >
> > > Please take a look and let me know if you need any changes.
> >
> >
> > Excellent, thanks!
> >
> >
> > I have a feeling that the 'stable' branch of this repo was a 'good
> > intention' that does not have a process by which it gets updated.  I've
> > asked the maintainers if they plan to keep this branch active or prune
> > it.  And I'll ask if they can generate a tag/release that we could use
> > as a basis.
>
> Hi Brian,
> Would you like me to change the mirroring configuration to follow
> "master" instead of "stable"?

Yes, please do.

> > What's the process by which we update our fork?  It has an automated
> > mirror process driven by gitlab?  What if we need changes that
> > can't/won't be upstreamed - can we make those locally?  I don't yet hav=
e
> > any plans to make local changes, just want to understand how the proces=
s
> > works.
>
> GitLab automatically mirrors the upstream repo.
>
> It's possible to change the repo configuration to act as a fork where
> you can push downstream-only patches, but at the moment it acts purely
> as a mirror. There is only 1 repo I'm aware of where it was necessary
> to do this. Usually it's possible to get patches upstream. Please let
> me know in case you need downstream-only patches and we can set it up
> (this should be a last resort).

Agreed - I expect we'll be able to upstream the changes required.

