Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D04CCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 16:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLNdB-0003Sn-49; Fri, 08 May 2026 12:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLNcw-0003Pp-9j
 for qemu-devel@nongnu.org; Fri, 08 May 2026 12:00:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLNct-0002FF-Ub
 for qemu-devel@nongnu.org; Fri, 08 May 2026 12:00:34 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648D9uOt3891021
 for <qemu-devel@nongnu.org>; Fri, 8 May 2026 16:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a48uqPf6+u166lO0LvMDMpw0Ex/LwC2zHp3SF/XfqzY=; b=goyDD2hjr/40DC+n
 B5xmprLpEU2jwXQzvgWnuxrNHENoaf/57U/hzPM5Nd/NzNaMURZ9wAYGjpUNcv08
 oR484THo6sKmiAZUOa5BR0X5AgwupW5/N+KmCP+vFHVfWSNFUDVtCJ/4bi3w/uwq
 PB2D7w8eP9pKG4yb6P7C4470oxftPr/bb/Sese8z0YcICPAsBk82mLYxEk0Jz1P+
 RR2SWCoUKTI+A5eWWIc4oDeu23rvZUEXhIz6KoDD1IyRcizSnRZrFsxOnbp/IBDe
 07jNbAW7+NChN07qo/bFEAe6dr7tI9A0bxJMPgWB8M6E4B4VlDtPuFxjsoL+ew2u
 guxC+w==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1gfqrtgp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 16:00:26 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12dfe06b670so4754347c88.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778256026; x=1778860826; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a48uqPf6+u166lO0LvMDMpw0Ex/LwC2zHp3SF/XfqzY=;
 b=kEfrNagUrevPKXyfmSmRYOumFHSXXRf6yOolTzQ8VGQVOWeEvMTpG3xda3yMbHgczs
 7rc2gRcKBxyZaDBMgAaBbLFVVzzLZ2lXYahX1Gx5qDk2mpF2vg8JZovMvWAasAKGPDEP
 rdqRhFPtzvvLZuhDj5L5W0pCub9dRNLv3JCc/aRbMI3vBzoMowbfAB1e2qNZCBSFHJTQ
 FDg3g30lH9/6FhKE8VHe7+2K2tO2UEdEcbrCTtCHas+uxjHK10dcK2SpYZJHz5Gbp9Vj
 I4tGFH32oFRYdblBr8uaufUQQbYKdFKxLKoIs5U2o7eDRJtwbRcIjgxIwerG423poJo4
 i7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778256026; x=1778860826;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a48uqPf6+u166lO0LvMDMpw0Ex/LwC2zHp3SF/XfqzY=;
 b=DTDZ8P4RXvxGipJh5DumsolSj7U7PhAV1TER1Mc3h/Xwh0aeLraUZSUd6j8VBDbgyd
 rS0Un7BetHW9nJB0BzIM/EVohgYI4RlCdtAUj8JM+ec0ZqS1XulA93usk/GWzfoCmTRB
 fwwtQZPknncdLQyvxj8+b3s4imOehfC5TVAX0zZl4wOHJw4cXJ3aKS22muKRh4Hx7ImG
 g0b5npOm5NroT25M4b522iBmJaK5+6ixowTYIGBBDI64JoTTnV3Tt7v/6LT78WLAC2in
 YUzCPZrPcLXJJcPpDtIJUrYd4BDzIyaybaakxotlRkcIncxxZsk4a0zpUWw4jsFEjhko
 sMSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4IQaJysicatuSQvLzNPJpZmpm3StFmktyhQnbdl5z5rlBKYyrECIaO+7gpskkByLfJGXNu5/LZgtX@nongnu.org
X-Gm-Message-State: AOJu0YwNu3RpmSbV3sDuV0rl9h4OYS+fSUSzOORdCueuobwzFhVSTAak
 RIw1T/1NxWMXC7UWuJ7PRBU2wEW2dgMmgJgD0ExlBP2nDesxhwbpNQRBeQzQcdMcyROAKIy7lwy
 9kzbidWVEsah2NaAEfGRPav0dMf4EXbFLzlve/uJ3JjaGMIv7+wqKSmD7gQ==
X-Gm-Gg: Acq92OF/j4RmrpHI4sY1oy8OL6ee7kZnEYWiJEkVkiws0/rvxX9ATABR8+C7RYaorEV
 /uysj3WMPE2Eb18Ky8de/sb2wopMQnbMtV1PDYWnSqAEu2LSqCIwiShvXFUdoqp0xdbbXWNWNuv
 nk8vVTzya8vgENdYZS6Ch0gfNzSAITkKBwQkoFiI/7Av2NeWvOsfVoJfJWUkOuiTQunO+18rLIw
 ZSqji96dDbFEkKLgDXNnC+qsgKkiye93lD7prTZDCQShAR0Zl/zTr884FVj/Cxk0BUaCSePdKCM
 B0isrC1+4EC4ObXAaox4ZftJ0VoeLxkaXyfSb29RrESH6ezxe80C6cMmIHYM9YKn30rfS2PAPbj
 iiGEfuSq84U/NDhlVwlq++JZx683iptJUPPf35vCPbT2F/y5GGnnS4Iz+mtFPgkxv1oR9JgH3o0
 KN/tjBYUzePMkMiQ==
X-Received: by 2002:a05:7300:3b08:b0:2c7:3a7:c7a7 with SMTP id
 5a478bee46e88-2f54d15fe7amr6303938eec.25.1778256026052; 
 Fri, 08 May 2026 09:00:26 -0700 (PDT)
X-Received: by 2002:a05:7300:3b08:b0:2c7:3a7:c7a7 with SMTP id
 5a478bee46e88-2f54d15fe7amr6303907eec.25.1778256025452; 
 Fri, 08 May 2026 09:00:25 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f88885b87dsm3156489eec.21.2026.05.08.09.00.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 09:00:24 -0700 (PDT)
Message-ID: <735327c6-f23f-42cf-9b8e-a651d8ee7770@oss.qualcomm.com>
Date: Fri, 8 May 2026 09:00:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] tools: Move more tools sources into tools/
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260508152428.2648560-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE1OSBTYWx0ZWRfX09Pu5wWbp3hs
 ZGfBkfJNuvEDi6CfuDlb5YWsAjs9vNOkiIykp2k9YvjaFEWLE3isZu+/gmZsQMjSuHdR0VuJsj5
 pvgS1kpqwysQ4X5ypoX9R8NtduKzsrLzDeb3SjJ1sheSo4y6aMhI+DvY6Sio4GxhRU34u1aEQqF
 YCZDhllj5hYtcZ619bVR16AeptfHmMtFaapkSpT8LDlnnC95F7h3PjraTKCuxVeKjLiPpPrz9zt
 rJukrW2oLBqw7KGDTBN5kolToulZy237AZS9udaDvFyhXlg1uuafUjveCOb/T89iHxvRqBEKzuu
 xyrNAc6KuF8PfhpNG0fKRcvRbtj50LsF9nq1AmpTOluunyt4mW+kjiCJdDwPm0d31j6xixXuU9p
 r0zWHUHjigjlTwM1PkBbOYKlCIxtzNiI3Zei9gXZrcaHYDLo6uWGpDccvBYmWJN6WF97qSgrZA1
 fwz7B37GmN+3TCbv8bA==
X-Authority-Analysis: v=2.4 cv=W80IkxWk c=1 sm=1 tr=0 ts=69fe089b cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=w-yBC8u__v6bVZDae54A:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: hlT5IvJ4lHsT6nCCOQDwB_Th11YOmVMW
X-Proofpoint-GUID: hlT5IvJ4lHsT6nCCOQDwB_Th11YOmVMW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080159
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/8/2026 8:24 AM, Peter Maydell wrote:
> We have a set of binaries that we call "tools": they're built based on
> the --enable-tools/--disable-tools configure setting, they're
> documented in docs/tools, and they're standalone executables of one
> form or another.
> 
> Currently the sources for these are a bit scattered: many still in the
> top level source directory, some in contrib, one or two actually in
> the tools directory.
> 
> As an initial attempt at cleanup, this patchset moves the sources for
> qemu-bridge-helper, qemu-edid, qemu-img, qemu-io, qemu-nbd,
> qemu-keymap, qemu-vmsr-helper and elf2dmp into the tools/ directory.
> 
> The patchseries also moves the ebfp skeleton sources from tools/ebpf/
> to ebpf/bpf-src/, because this isn't a tool by the above definition.
> 
> As per my thread from a while back, I would ultimately like us to
> clean up contrib/:
> https://lore.kernel.org/qemu-devel/CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com/
> But parts of that clearly need more discussion. So this is just doing
> some parts that I hope are not controversial.
> 
> Annoyingly, meson doesn't seem to provide any way for a subdirectory
> meson.build to say "the foo.c in this subdir builds into a foo
> executable that lives at the top level of the builddir". And we have a
> lot of test harness stuff plus user muscle memory that assumes that
> qemu-img and qemu-io live there. So the build runes for these tools
> have to stay in the top level meson.build (and tools/meson.build
> remains an empty file). The exception is that contrib/elf2dmp/elf2dmp
> is now tools/elf2dmp/elf2dmp, but I think the set of people who were
> running that from the build directory will be small.
>

It's a deliberate design more than an annoyance. It pushes users to make
things explicit at top level, which is good to understand what is built
and how, and hide details in subdirs in variables. QEMU's top level
meson.build is over complex, so it may appear more as a burden than a
benefit though.

> thanks
> -- PMM
> 
> 
> Peter Maydell (9):
>   ebpf: move ebpf skeleton source to ebpf/ directory
>   tools: Move qemu-bridge-helper sources to tools/ directory
>   tools: Move qemu-edid sources to tools/ directory
>   tools: Move qemu-img sources to tools/ directory
>   tools: Move qemu-io sources to tools/ directory
>   tools: Move qemu-nbd sources to tools/ directory
>   tools: Move qemu-keymap sources to tools/ directory
>   tools: Move qemu-vmsr-helper up a directory level
>   tools: Move elf2dmp from contrib/ to tools/
> 
>  MAINTAINERS                                   | 15 +++++++-------
>  docs/tools/qemu-img.rst                       |  2 +-
>  {tools/ebpf => ebpf/bpf-src}/Makefile.ebpf    |  2 +-
>  {tools/ebpf => ebpf/bpf-src}/rss.bpf.c        |  0
>  meson.build                                   | 20 +++++++++----------
>  {contrib => tools}/elf2dmp/addrspace.c        |  0
>  {contrib => tools}/elf2dmp/addrspace.h        |  0
>  {contrib => tools}/elf2dmp/download.c         |  0
>  {contrib => tools}/elf2dmp/download.h         |  0
>  {contrib => tools}/elf2dmp/err.h              |  0
>  {contrib => tools}/elf2dmp/kdbg.h             |  0
>  {contrib => tools}/elf2dmp/main.c             |  0
>  {contrib => tools}/elf2dmp/meson.build        |  0
>  {contrib => tools}/elf2dmp/pdb.c              |  0
>  {contrib => tools}/elf2dmp/pdb.h              |  0
>  {contrib => tools}/elf2dmp/pe.h               |  0
>  {contrib => tools}/elf2dmp/qemu_elf.c         |  0
>  {contrib => tools}/elf2dmp/qemu_elf.h         |  0
>  .../qemu-bridge-helper.c                      |  0
>  qemu-edid.c => tools/qemu-edid.c              |  0
>  qemu-img-cmds.hx => tools/qemu-img-cmds.hx    |  0
>  qemu-img.c => tools/qemu-img.c                |  0
>  qemu-io-cmds.c => tools/qemu-io-cmds.c        |  0
>  qemu-io.c => tools/qemu-io.c                  |  0
>  qemu-keymap.c => tools/qemu-keymap.c          |  0
>  qemu-nbd.c => tools/qemu-nbd.c                |  0
>  tools/{i386 => }/qemu-vmsr-helper.c           |  0
>  tools/{i386 => }/rapl-msr-index.h             |  0
>  28 files changed, 20 insertions(+), 19 deletions(-)
>  rename {tools/ebpf => ebpf/bpf-src}/Makefile.ebpf (96%)
>  rename {tools/ebpf => ebpf/bpf-src}/rss.bpf.c (100%)
>  rename {contrib => tools}/elf2dmp/addrspace.c (100%)
>  rename {contrib => tools}/elf2dmp/addrspace.h (100%)
>  rename {contrib => tools}/elf2dmp/download.c (100%)
>  rename {contrib => tools}/elf2dmp/download.h (100%)
>  rename {contrib => tools}/elf2dmp/err.h (100%)
>  rename {contrib => tools}/elf2dmp/kdbg.h (100%)
>  rename {contrib => tools}/elf2dmp/main.c (100%)
>  rename {contrib => tools}/elf2dmp/meson.build (100%)
>  rename {contrib => tools}/elf2dmp/pdb.c (100%)
>  rename {contrib => tools}/elf2dmp/pdb.h (100%)
>  rename {contrib => tools}/elf2dmp/pe.h (100%)
>  rename {contrib => tools}/elf2dmp/qemu_elf.c (100%)
>  rename {contrib => tools}/elf2dmp/qemu_elf.h (100%)
>  rename qemu-bridge-helper.c => tools/qemu-bridge-helper.c (100%)
>  rename qemu-edid.c => tools/qemu-edid.c (100%)
>  rename qemu-img-cmds.hx => tools/qemu-img-cmds.hx (100%)
>  rename qemu-img.c => tools/qemu-img.c (100%)
>  rename qemu-io-cmds.c => tools/qemu-io-cmds.c (100%)
>  rename qemu-io.c => tools/qemu-io.c (100%)
>  rename qemu-keymap.c => tools/qemu-keymap.c (100%)
>  rename qemu-nbd.c => tools/qemu-nbd.c (100%)
>  rename tools/{i386 => }/qemu-vmsr-helper.c (100%)
>  rename tools/{i386 => }/rapl-msr-index.h (100%)
> 

For series:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


