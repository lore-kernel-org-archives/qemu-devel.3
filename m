Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B72AC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjXlo-0001lo-Cy; Tue, 14 Jul 2026 03:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wjXlm-0001lP-TK
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 03:41:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wjXlk-0001Ro-3e
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 03:41:34 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6SZmZ4005264
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ZPRNHi68FDWPtrocLSB4O4iO
 uZAv9vtYwpqiGW0Tehc=; b=nBRVIXMDT0SFpSSC6FUTwTbHLRWJ5C6Aw7cKiiy6
 KY6vWdmzeNv7JvGeV8NECJ+xNQxTbNNWc4WB3SdOZ10EWmwOGyv0ZfWTAhvGYkwf
 V1XLkn0Xpi5qFOvEPp2m9PnKEHF/uRftub/vCsl6+i8p3uTCB4dXubvaTTapXPcr
 Jn4f8pn6ycNxDeTdcdi6P3i23g+wjk6IuCh16xtABdM/lIVsrgjRGZOkoxWdBvkl
 P8bEVSDFeVMXNpmr2zuehPq7lhL5bh9S8Rbb8I2vuMI7EaQzGiWwNyLYY6bztnUm
 okOxQ13PhasrjKIqwp/5npb6gboDmxQbE++SxwMxLGP6Ww==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44ctnck-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:41:27 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5bf8c573ca5so166744e0c.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 00:41:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784014887; cv=none;
 d=google.com; s=arc-20260327;
 b=ndDJ6e0hN8auXp+At770QE65PqqrDLMsfAdHepvXjCHqo9eNbWqxCNEoOdaHEiQK8x
 glASgv3wGAoAUmmeQSBDzIDp8CfJPuI9UYmiQm9PCSSQYrdtDVLdE43kfLP4puO/YXMr
 zYqxlJMKTSsSAlJddYR1EWcepc9b3dF+7IB7+CiVPQWGjeQP557zAurqoVb5PjVV2tQr
 +eAFqDwLUVVGghh8FukO4JcBv8WQ2Vfq699JMNDupAGnNoDI8Kvg2hBVLv/m6K8FluJ9
 K5AVt07QLTPctnT9rTKCeEI2QylmmMVS7Yg4g+FCg9Yfcymvey5iqfFvLStVelg+Og8q
 HtAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZPRNHi68FDWPtrocLSB4O4iOuZAv9vtYwpqiGW0Tehc=;
 fh=SPrFJU9zNA88f7cqli5ErI09SOy0ThQiM2CZxE6ayJI=;
 b=ZmT7E4Ezul68iDSfZbSi+tT3KmLHVCLzVXscU1igM9ol3zTG+JM1AvLjOla+YpHH6A
 jV6XUyY821hgtvwjoVfyZ0bSBjw5gr5obgN1VW0LApL6rnBtRUQA+xEoa+GRs3Pz0bvw
 6D0EVprWYpnL2EEqe2yMRNPghnNCnTS2xFNy9HKFkyNCP1dcO4F+Ta1Ve3GqQWYhKyzo
 TpIDTC6vQW0bKHYeCyhk3Ln/gRf1cFbOLa3rEmToeqx7F3rzHOlNVNT3smWnAnw7TytV
 DTRbxqBGa1VG6Mngk6Z4AYVxPYRhlMYaqZhnp/zdSl96cQ4B3EKPlShqoM1dOunlAgmQ
 t2tA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784014887; x=1784619687; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZPRNHi68FDWPtrocLSB4O4iOuZAv9vtYwpqiGW0Tehc=;
 b=KrDVrvokIuA8qwl8wKyJxTBNAUJHM0LeSogRsJYK4s5HU+7voBsNQchtoCh6JrstLN
 zmdNYM9bYj225f6heWkBo4kixmHaGg64b0ly2IQVte68AKpECUJbkkQ8qDfNd+Rn42NV
 gq3gk92p8Vy8QFGph9kUuDZyJwyAcN1Wq/YWFLfbXfhnlcqqD1kMk47/OAZMlZEpX8KM
 b87f38lv7eWpB444coBEiSs1gBHhgUGtkpoLounl1a8WhX+65C06eStuoGrGUQcOYrsc
 mJ2Tp2FfbPGQTuWmdnMe5i7iBoPy1X7lt7efQ5thDZG4bM20Qmby/8T83OH8QfiwDaZV
 KwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784014887; x=1784619687;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZPRNHi68FDWPtrocLSB4O4iOuZAv9vtYwpqiGW0Tehc=;
 b=gH0MiVzexMj8Aw7IMkF9Wss+MuFdZGhm9JiwHR4+DwrUOMLQbGRqn5LaBwHXNZY0P+
 bzzLyqAuW6MpXRiXf5JUkzXaK3AXb2ZvEJK43SjrR/1RY2hC9cclisDHs7Vhz9YLFRq3
 Tb48ScWRkb+G2DtW2eyKqlT6FJRTvImap8S9/QO6sr8b3goQ5+lWqJ3JeKA/6NAZdQLO
 VKs1cvK4Dnipst0TETOpF/2qjqGFHprsdAVGEd2QOtMZEpg7WouHO3UmcAsEl2tvjTxq
 ulM9VkEXz0cwIpJ2qVraj8DzPq/AVsn6E7Ok/17huJDc27WCe+gT316kbpmyCMI6waau
 DGhQ==
X-Gm-Message-State: AOJu0YwUMeqD47fiiqm03/vlY44wgi+njzkr1akW6A1cA5JIbXSFLFgC
 GfT6zo3SD20pXpRnrmEcGTdEm+NybHCFr3P9O+dQgkECI7oX8xUPEHnDwE2JQFUEJRLIZVZR3u6
 AHeRgh8qacoSEcZOiItusZcXGVLBmnzInVLRG/8462LbFJyQz7noXN72MKZLaqO6n840mIKgbcL
 TCVTdGkuziYPK9dixR6qD43Oi5QX7gEVhm
X-Gm-Gg: AfdE7ckRZfmXOaKgc7Jq9kxwhffIOdLThOE67cp96Im2SOQuCmlTxiFZdAu4kxCRcnD
 IBWPNnVdSYg5lZ24+EXFbugiUPDWrF/A1d2vmXtSIaOa30kKS31hS1a88n+FaHtCmNNqhOIrk5x
 uwCasgeKmruG2mt9BsEY25bbWSJUSlzTH0WdLeYSE7M6Lsgi/4UfhcUDgF3a8DLrCH30M=
X-Received: by 2002:a05:6102:14a3:b0:738:b13a:c810 with SMTP id
 ada2fe7eead31-74533b65833mr2633976137.2.1784014886825; 
 Tue, 14 Jul 2026 00:41:26 -0700 (PDT)
X-Received: by 2002:a05:6102:14a3:b0:738:b13a:c810 with SMTP id
 ada2fe7eead31-74533b65833mr2633971137.2.1784014886368; Tue, 14 Jul 2026
 00:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
 <1f2732b7220280efc1b5f69ae022b318dbbc3827.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
 <CAKmqyKPQj8wWC_f4xL9sJVg-CKb3FPG-or=34B2tF4i-pRjnZA@mail.gmail.com>
In-Reply-To: <CAKmqyKPQj8wWC_f4xL9sJVg-CKb3FPG-or=34B2tF4i-pRjnZA@mail.gmail.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 13:11:14 +0530
X-Gm-Features: AUfX_myFnNiqFxc7G_sfPbIdkn_x9Fza54qPHtYfiUpgPCx8UAcw8Wj1tyjZAr0
Message-ID: <CAPxK-6eshHt0yiwdg8F6cT1WjAWrHRH0fAEZz0zXRvbFae-LAw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] build: add optional librpmi dependency
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000093871d06568d5519"
X-Proofpoint-GUID: siwgrAaZI2N3kXXgXg3x5b3W_hPZfKj6
X-Proofpoint-ORIG-GUID: siwgrAaZI2N3kXXgXg3x5b3W_hPZfKj6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA3OCBTYWx0ZWRfXwavik97zHhuF
 bV/1Z7kyrAznEeXX/Fw9Do6iImmb1/N1pHGlqPCuWnpmiRC74f0psKr54F10CWp2wq16VXBzHja
 fS8GkLlh8+Q1A8avmoNtNrlQmBMbrBg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA3OCBTYWx0ZWRfX87ahpSR8JBwl
 PPO4eB+9w3xhbvNV4EZokUBzik/c/ylaf4rW4yNB2WhR6XJc5tqUkuITAp+eXdYslSFwYci+s6W
 VxE2/S9iKGoW6QFy/txSIZ259sDwg4BoNK7PYExzZ/HWBQzcWesT30jD6KtaGLRTTnIhI8cOUwz
 ifsFfWRBbbU6iP6iVAbS3LQArj0qH9w/dfUVBOerIdi75FLRc5S4NKr0XpUKEqutDX5KeRvtY6f
 Ooqso2vicAMnonxnTybPp5cpwMIXDtrPN/WwE64+ZmTsqi1c77Lc5qdSLonuCjeSRwT5WDXMQSQ
 04ulwkso29V9cvmHc8e4nT3/9Xe9svbughbtkluQzFWyoix8k8TZ2asAwNqIV4JCrEok5Jf9vZz
 PQhCy4ZEIuRB6RoI44YByMmo8GBllt6lo0BFb7dj2fBvcjdRbGAzc6mPhxZzu/rQw5P4mGDjIph
 JeUxAKmABtVbAdUmSzg==
X-Authority-Analysis: v=2.4 cv=P84KQCAu c=1 sm=1 tr=0 ts=6a55e828 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=xroA5A_WfHnPwR0Km7kA:9 a=QEXdDO2ut3YA:10
 a=hR24SDHdJTCqSHgsR7gA:9 a=7KZUPVWGMy1_9dSH:21 a=lqcHg5cX4UMA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

--00000000000093871d06568d5519
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alistair,

On Mon, Jul 13, 2026 at 7:11=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com>
wrote:

> On Fri, Jul 10, 2026 at 10:23=E2=80=AFPM Subrahmanya Lingappa
> <subrahmanya.lingappa@oss.qualcomm.com> wrote:
> >
> > From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> >
> > Add a meson option and config probe for librpmi so RISC-V machines can
> > opt into RPMI support when the library is available. Keep the dependenc=
y
> > optional so default builds without librpmi continue to work.
> >
> > Signed-off-by: Subrahmanya Lingappa <
> subrahmanya.lingappa@oss.qualcomm.com>
>
> Can we add some documentation of how get librpmi support to work? Do I
> just apt/dnf/pacman/apk install it? Do I need a certain version?
>
>   Yes, good point. The v2 docs only said that librpmi must be installed s=
o
  pkg-config can find librpmi.pc, which is too terse. I will expand the
docs to
  state that QEMU requires librpmi 1.0.0 or newer,
  show source install steps from the upstream librpmi repo, and mention the
  Debian/RPM package targets provided by librpmi, while it's also documente=
d
  in detail within librpmi repo.

 Subrahmanya

Alistair
>
> > ---
> >  Kconfig.host                  |  3 +++
> >  meson.build                   | 14 ++++++++++++++
> >  meson_options.txt             |  2 ++
> >  scripts/meson-buildoptions.sh |  3 +++
> >  4 files changed, 22 insertions(+)
> >
> > diff --git a/Kconfig.host b/Kconfig.host
> > index 933425c74b..6f98dadb2e 100644
> > --- a/Kconfig.host
> > +++ b/Kconfig.host
> > @@ -8,6 +8,9 @@ config LINUX
> >  config LIBCBOR
> >      bool
> >
> > +config LIBRPMI
> > +    bool
> > +
> >  config GNUTLS
> >      bool
> >
> > diff --git a/meson.build b/meson.build
> > index 19e123423b..103b4649b8 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -2005,6 +2005,17 @@ if lzo.found() and not cc.links('''
> >    endif
> >  endif
> >
> > +librpmi =3D not_found
> > +if not get_option('librpmi').auto() or have_system
> > +  librpmi =3D dependency('librpmi', required: get_option('librpmi'),
> > +                       method: 'pkg-config')
> > +  if librpmi.found() and not cc.has_header_symbol('librpmi.h',
> > +
> 'rpmi_service_group_logging_create',
> > +                                                  dependencies: librpm=
i)
> > +    error('librpmi support requires the RPMI logging service group API=
')
> > +  endif
> > +endif
> > +
> >  numa =3D not_found
> >  if not get_option('numa').auto() or have_system or have_tools
> >    numa =3D cc.find_library('numa', has_headers: ['numa.h'],
> > @@ -2427,6 +2438,7 @@ config_host_data.set('CONFIG_LINUX', host_os =3D=
=3D
> 'linux')
> >  config_host_data.set('CONFIG_POSIX', host_os !=3D 'windows')
> >  config_host_data.set('CONFIG_WIN32', host_os =3D=3D 'windows')
> >  config_host_data.set('CONFIG_LZO', lzo.found())
> > +config_host_data.set('CONFIG_LIBRPMI', librpmi.found())
> >  config_host_data.set('CONFIG_MPATH', mpathpersist.found())
> >  config_host_data.set('CONFIG_BLKIO', blkio.found())
> >  if blkio.found()
> > @@ -3258,6 +3270,7 @@ host_kconfig =3D \
> >    (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=3Dy'] : []) + =
\
> >    (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=3Dy'] =
:
> []) + \
> >    (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=3Dy'] : []) + \
> > +  (librpmi.found() ? ['CONFIG_LIBRPMI=3Dy'] : []) + \
> >    (have_rust ? ['CONFIG_HAVE_RUST=3Dy'] : [])
> >
> >  ignored =3D [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR' ]
> > @@ -4971,6 +4984,7 @@ summary_info +=3D {'TPM support':       have_tpm}
> >  summary_info +=3D {'IGVM support':      igvm}
> >  summary_info +=3D {'libssh support':    libssh}
> >  summary_info +=3D {'lzo support':       lzo}
> > +summary_info +=3D {'librpmi support':   librpmi}
> >  summary_info +=3D {'snappy support':    snappy}
> >  summary_info +=3D {'bzip2 support':     libbzip2}
> >  summary_info +=3D {'lzfse support':     liblzfse}
> > diff --git a/meson_options.txt b/meson_options.txt
> > index a07cb47d35..9f773a7886 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -204,6 +204,8 @@ option('lzfse', type : 'feature', value : 'auto',
> >         description: 'lzfse support for DMG images')
> >  option('lzo', type : 'feature', value : 'auto',
> >         description: 'lzo compression support')
> > +option('librpmi', type : 'feature', value : 'auto',
> > +       description: 'RISC-V RPMI support')
> >  option('pvg', type: 'feature', value: 'auto',
> >         description: 'macOS paravirtualized graphics support')
> >  option('rbd', type : 'feature', value : 'auto',
> > diff --git a/scripts/meson-buildoptions.sh
> b/scripts/meson-buildoptions.sh
> > index c003985047..e8a20068e7 100644
> > --- a/scripts/meson-buildoptions.sh
> > +++ b/scripts/meson-buildoptions.sh
> > @@ -140,6 +140,7 @@ meson_options_help() {
> >    printf "%s\n" '  libkeyutils     Linux keyutils support'
> >    printf "%s\n" '  libnfs          libnfs block device driver'
> >    printf "%s\n" '  libpmem         libpmem support'
> > +  printf "%s\n" '  librpmi         RISC-V RPMI support'
> >    printf "%s\n" '  libssh          ssh block device support'
> >    printf "%s\n" '  libudev         Use libudev to enumerate host
> devices'
> >    printf "%s\n" '  libusb          libusb support for USB passthrough'
> > @@ -376,6 +377,8 @@ _meson_option_parse() {
> >      --disable-libnfs) printf "%s" -Dlibnfs=3Ddisabled ;;
> >      --enable-libpmem) printf "%s" -Dlibpmem=3Denabled ;;
> >      --disable-libpmem) printf "%s" -Dlibpmem=3Ddisabled ;;
> > +    --enable-librpmi) printf "%s" -Dlibrpmi=3Denabled ;;
> > +    --disable-librpmi) printf "%s" -Dlibrpmi=3Ddisabled ;;
> >      --enable-libssh) printf "%s" -Dlibssh=3Denabled ;;
> >      --disable-libssh) printf "%s" -Dlibssh=3Ddisabled ;;
> >      --enable-libudev) printf "%s" -Dlibudev=3Denabled ;;
> > --
> > 2.43.0
> >
> >
>

--00000000000093871d06568d5519
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Alistair,</div><br><div class=3D"gmail_quote gmail_qu=
ote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 13, 2026 a=
t 7:11=E2=80=AFAM Alistair Francis &lt;<a href=3D"mailto:alistair23@gmail.c=
om">alistair23@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On Fri, Jul 10, 2026 at 10:23=E2=80=AFPM Subrahmany=
a Lingappa<br>
&lt;<a href=3D"mailto:subrahmanya.lingappa@oss.qualcomm.com" target=3D"_bla=
nk">subrahmanya.lingappa@oss.qualcomm.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Subrahmanya Lingappa &lt;<a href=3D"mailto:subrahmanya.lingappa@=
oss.qualcomm.com" target=3D"_blank">subrahmanya.lingappa@oss.qualcomm.com</=
a>&gt;<br>
&gt;<br>
&gt; Add a meson option and config probe for librpmi so RISC-V machines can=
<br>
&gt; opt into RPMI support when the library is available. Keep the dependen=
cy<br>
&gt; optional so default builds without librpmi continue to work.<br>
&gt;<br>
&gt; Signed-off-by: Subrahmanya Lingappa &lt;<a href=3D"mailto:subrahmanya.=
lingappa@oss.qualcomm.com" target=3D"_blank">subrahmanya.lingappa@oss.qualc=
omm.com</a>&gt;<br>
<br>
Can we add some documentation of how get librpmi support to work? Do I<br>
just apt/dnf/pacman/apk install it? Do I need a certain version?<br>
<br></blockquote>=C2=A0 Yes, good point. The v2 docs only said that librpmi=
 must be installed so<br>=C2=A0 pkg-config can find librpmi.pc, which is to=
o terse. I will expand the docs to<br>=C2=A0 state that QEMU requires librp=
mi 1.0.0 or newer,<br>=C2=A0 show source install steps from the upstream li=
brpmi repo, and mention the<br>=C2=A0 Debian/RPM package targets provided b=
y librpmi, while it&#39;s also documented</div><div class=3D"gmail_quote gm=
ail_quote_container">=C2=A0 in detail<span style=3D"background-color:transp=
arent">=C2=A0within librpmi repo.</span></div><div class=3D"gmail_quote gma=
il_quote_container"><div>=C2=A0</div><div>=C2=A0Subrahmanya</div><div><br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
Alistair<br>
<br>
&gt; ---<br>
&gt;=C2=A0 Kconfig.host=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 3 +++<br>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 14 ++++++++++++++<br>
&gt;=C2=A0 meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 scripts/meson-buildoptions.sh |=C2=A0 3 +++<br>
&gt;=C2=A0 4 files changed, 22 insertions(+)<br>
&gt;<br>
&gt; diff --git a/Kconfig.host b/Kconfig.host<br>
&gt; index 933425c74b..6f98dadb2e 100644<br>
&gt; --- a/Kconfig.host<br>
&gt; +++ b/Kconfig.host<br>
&gt; @@ -8,6 +8,9 @@ config LINUX<br>
&gt;=C2=A0 config LIBCBOR<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool<br>
&gt;<br>
&gt; +config LIBRPMI<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; +<br>
&gt;=C2=A0 config GNUTLS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool<br>
&gt;<br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index 19e123423b..103b4649b8 100644<br>
&gt; --- a/meson.build<br>
&gt; +++ b/meson.build<br>
&gt; @@ -2005,6 +2005,17 @@ if lzo.found() and not cc.links(&#39;&#39;&#39;=
<br>
&gt;=C2=A0 =C2=A0 endif<br>
&gt;=C2=A0 endif<br>
&gt;<br>
&gt; +librpmi =3D not_found<br>
&gt; +if not get_option(&#39;librpmi&#39;).auto() or have_system<br>
&gt; +=C2=A0 librpmi =3D dependency(&#39;librpmi&#39;, required: get_option=
(&#39;librpmi&#39;),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0method: &#39;pkg-config&#39;)<br>
&gt; +=C2=A0 if librpmi.found() and not cc.has_header_symbol(&#39;librpmi.h=
&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;rpmi_service_group_logging_create&#39;=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dependencies: librpmi)<br>
&gt; +=C2=A0 =C2=A0 error(&#39;librpmi support requires the RPMI logging se=
rvice group API&#39;)<br>
&gt; +=C2=A0 endif<br>
&gt; +endif<br>
&gt; +<br>
&gt;=C2=A0 numa =3D not_found<br>
&gt;=C2=A0 if not get_option(&#39;numa&#39;).auto() or have_system or have_=
tools<br>
&gt;=C2=A0 =C2=A0 numa =3D cc.find_library(&#39;numa&#39;, has_headers: [&#=
39;numa.h&#39;],<br>
&gt; @@ -2427,6 +2438,7 @@ config_host_data.set(&#39;CONFIG_LINUX&#39;, hos=
t_os =3D=3D &#39;linux&#39;)<br>
&gt;=C2=A0 config_host_data.set(&#39;CONFIG_POSIX&#39;, host_os !=3D &#39;w=
indows&#39;)<br>
&gt;=C2=A0 config_host_data.set(&#39;CONFIG_WIN32&#39;, host_os =3D=3D &#39=
;windows&#39;)<br>
&gt;=C2=A0 config_host_data.set(&#39;CONFIG_LZO&#39;, lzo.found())<br>
&gt; +config_host_data.set(&#39;CONFIG_LIBRPMI&#39;, librpmi.found())<br>
&gt;=C2=A0 config_host_data.set(&#39;CONFIG_MPATH&#39;, mpathpersist.found(=
))<br>
&gt;=C2=A0 config_host_data.set(&#39;CONFIG_BLKIO&#39;, blkio.found())<br>
&gt;=C2=A0 if blkio.found()<br>
&gt; @@ -3258,6 +3270,7 @@ host_kconfig =3D \<br>
&gt;=C2=A0 =C2=A0 (multiprocess_allowed ? [&#39;CONFIG_MULTIPROCESS_ALLOWED=
=3Dy&#39;] : []) + \<br>
&gt;=C2=A0 =C2=A0 (vfio_user_server_allowed ? [&#39;CONFIG_VFIO_USER_SERVER=
_ALLOWED=3Dy&#39;] : []) + \<br>
&gt;=C2=A0 =C2=A0 (hv_balloon ? [&#39;CONFIG_HV_BALLOON_POSSIBLE=3Dy&#39;] =
: []) + \<br>
&gt; +=C2=A0 (librpmi.found() ? [&#39;CONFIG_LIBRPMI=3Dy&#39;] : []) + \<br=
>
&gt;=C2=A0 =C2=A0 (have_rust ? [&#39;CONFIG_HAVE_RUST=3Dy&#39;] : [])<br>
&gt;<br>
&gt;=C2=A0 ignored =3D [ &#39;TARGET_XML_FILES&#39;, &#39;TARGET_ABI_DIR&#3=
9; ]<br>
&gt; @@ -4971,6 +4984,7 @@ summary_info +=3D {&#39;TPM support&#39;:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0have_tpm}<br>
&gt;=C2=A0 summary_info +=3D {&#39;IGVM support&#39;:=C2=A0 =C2=A0 =C2=A0 i=
gvm}<br>
&gt;=C2=A0 summary_info +=3D {&#39;libssh support&#39;:=C2=A0 =C2=A0 libssh=
}<br>
&gt;=C2=A0 summary_info +=3D {&#39;lzo support&#39;:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0lzo}<br>
&gt; +summary_info +=3D {&#39;librpmi support&#39;:=C2=A0 =C2=A0librpmi}<br=
>
&gt;=C2=A0 summary_info +=3D {&#39;snappy support&#39;:=C2=A0 =C2=A0 snappy=
}<br>
&gt;=C2=A0 summary_info +=3D {&#39;bzip2 support&#39;:=C2=A0 =C2=A0 =C2=A0l=
ibbzip2}<br>
&gt;=C2=A0 summary_info +=3D {&#39;lzfse support&#39;:=C2=A0 =C2=A0 =C2=A0l=
iblzfse}<br>
&gt; diff --git a/meson_options.txt b/meson_options.txt<br>
&gt; index a07cb47d35..9f773a7886 100644<br>
&gt; --- a/meson_options.txt<br>
&gt; +++ b/meson_options.txt<br>
&gt; @@ -204,6 +204,8 @@ option(&#39;lzfse&#39;, type : &#39;feature&#39;, =
value : &#39;auto&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;lzfse support for D=
MG images&#39;)<br>
&gt;=C2=A0 option(&#39;lzo&#39;, type : &#39;feature&#39;, value : &#39;aut=
o&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;lzo compression sup=
port&#39;)<br>
&gt; +option(&#39;librpmi&#39;, type : &#39;feature&#39;, value : &#39;auto=
&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;RISC-V RPMI support&#39;=
)<br>
&gt;=C2=A0 option(&#39;pvg&#39;, type: &#39;feature&#39;, value: &#39;auto&=
#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;macOS paravirtualiz=
ed graphics support&#39;)<br>
&gt;=C2=A0 option(&#39;rbd&#39;, type : &#39;feature&#39;, value : &#39;aut=
o&#39;,<br>
&gt; diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoption=
s.sh<br>
&gt; index c003985047..e8a20068e7 100644<br>
&gt; --- a/scripts/meson-buildoptions.sh<br>
&gt; +++ b/scripts/meson-buildoptions.sh<br>
&gt; @@ -140,6 +140,7 @@ meson_options_help() {<br>
&gt;=C2=A0 =C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 libkeyutils=C2=A0 =C2=
=A0 =C2=A0Linux keyutils support&#39;<br>
&gt;=C2=A0 =C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 libnfs=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 libnfs block device driver&#39;<br>
&gt;=C2=A0 =C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 libpmem=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0libpmem support&#39;<br>
&gt; +=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 librpmi=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0RISC-V RPMI support&#39;<br>
&gt;=C2=A0 =C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 libssh=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ssh block device support&#39;<br>
&gt;=C2=A0 =C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 libudev=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Use libudev to enumerate host devices&#39;<br>
&gt;=C2=A0 =C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 libusb=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 libusb support for USB passthrough&#39;<br>
&gt; @@ -376,6 +377,8 @@ _meson_option_parse() {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --disable-libnfs) printf &quot;%s&quot; -Dlibnfs=
=3Ddisabled ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --enable-libpmem) printf &quot;%s&quot; -Dlibpmem=
=3Denabled ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --disable-libpmem) printf &quot;%s&quot; -Dlibpmem=
=3Ddisabled ;;<br>
&gt; +=C2=A0 =C2=A0 --enable-librpmi) printf &quot;%s&quot; -Dlibrpmi=3Dena=
bled ;;<br>
&gt; +=C2=A0 =C2=A0 --disable-librpmi) printf &quot;%s&quot; -Dlibrpmi=3Ddi=
sabled ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --enable-libssh) printf &quot;%s&quot; -Dlibssh=3D=
enabled ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --disable-libssh) printf &quot;%s&quot; -Dlibssh=
=3Ddisabled ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --enable-libudev) printf &quot;%s&quot; -Dlibudev=
=3Denabled ;;<br>
&gt; --<br>
&gt; 2.43.0<br>
&gt;<br>
&gt;<br>
</blockquote></div></div>

--00000000000093871d06568d5519--

