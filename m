Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC02CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 16:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLNf7-0004ia-3a; Fri, 08 May 2026 12:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLNf2-0004YW-T7
 for qemu-devel@nongnu.org; Fri, 08 May 2026 12:02:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLNf0-0002wz-Bz
 for qemu-devel@nongnu.org; Fri, 08 May 2026 12:02:44 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648BwN4e2777831
 for <qemu-devel@nongnu.org>; Fri, 8 May 2026 16:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bbvLhHVBfSP4Uz3No0BvbzS5tqmHcT6h6pdsBZq2R5c=; b=hmOAgBkGVUExfeMD
 MkCvZKpLM+a4wcV8Pu2C/2IwrpQPvKtFLXFZoUD+afX/K53b/x/B+b9kkJOx5s3a
 9IwPCrVO8E+NqEutwM5ww+nrOlP++LuWa97aRpdOpdbI6K3T20mvjQGOmD9RHdZu
 Y7neBoKKvUCh77/+gHaD03oCuuHY0IXihpJHw14sOYwfOhB/DtmopN1xrc2bOFFf
 TLdMdDXYF5D1KKf7mSROo9OaxiiLmJb5Ftm2L3K2Fo/D442xF5HBqfu4bwebbjh+
 A0OPchvERUlEvyAfHQKR/fZCDN0XLOSudWs2oLZC+vf33IAAAoVcyN7jwcZe+BlE
 o42w9Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1285m2pj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 16:02:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ee34588671so3145609eec.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778256160; x=1778860960; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bbvLhHVBfSP4Uz3No0BvbzS5tqmHcT6h6pdsBZq2R5c=;
 b=Tq8b2TgDwOCoCDm3GeBSyxbPg5OtZmkgpMD8ODypOHJeZjPCtnIiuTvB2gE96AjcwI
 lA0l29ILpfnIgoQ4X+oZfQuNbfVYMks+2h3f0uFT+b+2rm3jksCKE03pazN3DteHgWAf
 124211TllEbeeqfKJBNnTcjC8dYwV7WyigaNEnUQXjEWz1r+zLmweqLVN+3K8+R4EP+I
 Gd9VpEGQcvWyKO6rWoKZyy9q7lSxF0rPg3GWxKFASgr9RCEeKU8jjKTb0LZ1lGuCDphI
 cFAyjAMga5zQzehLdreDuZKcziORakx2IGE1Z9PYQLZJRM4E91MGbm2NeYCWXbhkXjW7
 wTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778256160; x=1778860960;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bbvLhHVBfSP4Uz3No0BvbzS5tqmHcT6h6pdsBZq2R5c=;
 b=hsQK+duyHOXTw2JyeDQtS4kyroNygRpYD3c2PwDNDNbwxhg6CDDpMTBx03N/evPdav
 /M3nBhhqoZ2T4eXpMjlBi4up6gv+t+FsEw2nuO0RKVYB4G+PaUVe32XvrAUqG8J3nrID
 mY3PkKAOVOQ+C83YvQcHco+ekj9RHhSZjai0tf6+MrCVrx0+qS0QmlRGS1IHJqVOhB4i
 sOmr5ov/NWsAXBx3inJC0ZjgLAFn0zAA+hg2Aeq/IWePYVTrzbNP7/CX+k7AgVE9Q3kV
 Q7FByB5UpIu10IgPqXEXJHZCPbMhKkWx1YYoUzlHKPa/+xR+6Cx2ZKWzHVKXBtKzpblD
 yT7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+v6yKOAzQ7F8Wqfu0BHpuY53c7MDmnmC5LA+gxC3aqP4iFctY3CmU9IlYRBjma2Vbg3m5TmzdoDNi9@nongnu.org
X-Gm-Message-State: AOJu0YzkjdMm/0CIpiAM8ygrtQUAD9aclo164ZhszajkKVrYKL9JJG5h
 u7GTGTc/4xXqeCmkb1wPvV2W0UhTFh3mbZ6lDyLkbm9dR2XmuX/CbOx2rBTMVIsFAFNl+9AeQxv
 VHYskHSebF9m5Y76eQs26kCGY+XbRWICWHPdIhgtSjJo2niqt/L+62wRAFg==
X-Gm-Gg: Acq92OHePBylP+/XP7FjgL4cnqc9Zl+K3jsqk7OqqlS6Xryz03ak6pzpnvfkpfzJqGo
 Ey6o2qPEbB3VPC24MyZ94OM2fOE0Tvio5QJeQF+A1+/WfHhNWvVie4ZXmY3MRzb4W4hzNd3QkRi
 Ck5Vj5KW3z7uWGBixlHShcmSuYCihLwJEI2afZ8bBXa59gBwMVnTGbEgq5YmSHNzL66TaZKDlET
 JRbLG9xwyB7N0TbypXneg4/oV/HsFgs0anTNsPCiyWLmtIS9pqH8Gs5ST5TabfNCSGnMg1jz9J5
 BdJjiALhKgjLrzskCEzf122DpcEyIbPgx+T6mvewS09Sr5MyGePqLP7lpGUaFHFETESuE40uTVr
 0jKldNaCOsW0oTB9l/o2YeK5mkl1gUVnrETmxeMiZ5lEppqq8IxT4DnZzQh0dqeZF0kUzxs+wQe
 952BO+cPWZj4qBph6W+1fEGF2S
X-Received: by 2002:a05:7300:2216:b0:2c5:220c:5670 with SMTP id
 5a478bee46e88-2f5482663b5mr7007564eec.2.1778256159458; 
 Fri, 08 May 2026 09:02:39 -0700 (PDT)
X-Received: by 2002:a05:7300:2216:b0:2c5:220c:5670 with SMTP id
 5a478bee46e88-2f5482663b5mr7007395eec.2.1778256158130; 
 Fri, 08 May 2026 09:02:38 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f88847502fsm3063521eec.14.2026.05.08.09.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 09:02:37 -0700 (PDT)
Message-ID: <6aa27613-97e6-4568-8b75-cb804cc0e445@oss.qualcomm.com>
Date: Fri, 8 May 2026 09:02:35 -0700
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE2MCBTYWx0ZWRfX8kOT3+kGUZ+7
 1DrHfd0KYgohofCE6ISMmirjSXhk7S2S9qwjRwuyOGDs2PAJaU1+MZ5Q91MiAGkeClonHX7MM/Q
 KNMEoptiRize5hsyyH4G1qjTrUkhtbJKH7JHY2Is1rPUQ+/FSjp7GXrBuHgsqJlvrPBHNWhw7hb
 ERufP1VQIwSYjZZp/hYDujiQvczeUfGW4CZDLsBCV8swiC6iVvVbaHkzSt6xEpc+c7RKlCZ5QtC
 HvsiCPnQ0hbQl+4IRKk1LSuyn3KTi/vU2u84mpsMRLMl3oNUTt1ElgypOFQaQxvGXzyGeLR/oTN
 6lV7X3e05v3qpCvvFiKi7rlMnCz1KR8PCp68Oj8DCPQa6/unwshwka7uEhGg6SWEriG56whc8WN
 jvLpYY+DOvDhz+j8yrNSVcpZ8JvQ3sQd/kqougHKPLCFRQZCafOacBg+dofLnnZRiMHj3E5B99/
 kfyjWbqYifKO4x+5I7w==
X-Proofpoint-GUID: cl-yukSoLKHrfqYi0c3peHFeZktiznX_
X-Proofpoint-ORIG-GUID: cl-yukSoLKHrfqYi0c3peHFeZktiznX_
X-Authority-Analysis: v=2.4 cv=NKblPU6g c=1 sm=1 tr=0 ts=69fe0920 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=w-yBC8u__v6bVZDae54A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080160
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

As well, feel free to send a patches for contrib/plugins, moving them to
plugins/plugins as you offered first.
We didn't find a better alternative, and it does not really matters to
be honest. You have my reviewed-by.

Regards,
Pierrick

