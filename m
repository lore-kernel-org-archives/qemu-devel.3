Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5B8606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CJZptq4q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VhodJdAo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJasX-0000w0-L9; Wed, 21 Oct 2026 14:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJasU-0000jp-Du
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:17:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJasS-0008QN-H0
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:17:30 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpQB61873061
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7abohhNcuLZ/TwysXavPvov36UqxNLwY2pX+6OI9yig=; b=CJZptq4q1IdnwIlu
 QWbr6UFJsYj+nKUZkPZyoU9t03KktXNU4gW9Y8KEFBZyF8RDDb1SuDpawXxTUSh/
 t2Vez4noc770Pjhamw9/wm1fdwW/sWYb4M7Y/CsAJ5MNTDNdwArgK2/uRMelKVB9
 1LUGAieeZCyJ3MDKSzwllRer9iyIE8TuxbUj0rF+756xkOWLTfL5MfT2R2Kj7DQe
 qJPIbgDs10N4kXDzGBLM1fdjaOS1Bl0SsHox4srnjdvupxdNzJdwBeOd3KMa24wb
 Ce3TKUtvX4uMfAW2ReJg/fdLEcLR1cXvrzyOtPWiWnZAlgGJlvi53VejbFq2sxa2
 ULob8g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0v88fn3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:17:27 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36637676140so1728377eec.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606646; x=1793211446; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7abohhNcuLZ/TwysXavPvov36UqxNLwY2pX+6OI9yig=;
 b=VhodJdAo07vHgb2sIUwdDDmgqDBNwtJF/1OhmeGPWfP/ZAYfjyaHbOaLk4XMzY1Chg
 99sOlbu68g6y3x43rXKYBWP4ODxHL+1TB44VwSe6N8VjjIezEVtB2ulRmgK+/SfsMi4C
 b8NaDrThfilRNsDhsQr0uV8WtL/JLbvufHjyJQnZ5yv8mduI8gKgQhhBtUg3aVKe7hzI
 dLSEDiTw8BmpROykLOJgIT8TVYdPZKMNzOvUlA5E9jlGkHpIC6eYzqGQO7fOcOIOlm2F
 B/APqGTGEoYg/lK9eo6xN9YxGxq9aDnofYjKbNsy+o5EoE+WdHi2KiSZPfd0SX+n+ihi
 GmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606646; x=1793211446;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7abohhNcuLZ/TwysXavPvov36UqxNLwY2pX+6OI9yig=;
 b=QXVz9iCSKXMzagnCp5dNkxncTfdn09a48RmLYMfSl/rtCOzGNDVE5SD04vBXwaPWdx
 GDiI2m0/tdqibd6EwtXT+Z9QXwANRDueHWDZnrz5k04z5B248Yy4qJsDRvvHxfDsSdfd
 HlzwLWvLKSioiwL/wdOj4adxcg0UQFVHqk25kc9G5UdIReAu9Cl/dnCGD58fPpOBdbyw
 st4Sl825c2Zy0JJRhNHKxUPs47Mbk3zCc7GfdudlnC39hhT1BeXqQLGjr7zYBWUgpcnI
 ph9UI5gbDGnRRaAGzZxck1fHriBiQNZxJ2kDevAsTXR/jkT+w1nDM4mOYLpeO056vU8A
 SOsw==
X-Gm-Message-State: AFq9FYJBfANj+qzbH4wV3hL9XrmlgP99xoNNPJVBBX5F00K5Ji8FMYsy
 acGVDlw7VOYtc0+q3Qtup+vAcTJ7UftHTttwIcHnLO7D/JQ/IfuxAUpevQ0qSz/GDx+A41jG6cI
 /NjW0vgGlHbPA37GqeACmXhjBtLX4vhxixFV8zZcbHUDmRM8WcomVCJ9cw2o4J8hT/A==
X-Gm-Gg: AYBFou3jusYAaAN8TJfpcUFl5jhiVg1vEhFVz7CZAMs71TmM5iUIT40ANWs8c6idjj0
 g0oEwuclt8fxthikglwWM9kXR3f8U+I0qO0AFINZVzGoQTHc6UhJns3Bt78mPJgL/wc/0Q5LqCq
 q77TCwu97m8JgJDSc/+YBrdBMggRfoM1+mBYpAwTrAdl+pLEH9T6YB6DMwz0lvNEOXZFdoOmQSv
 atXDD7elKCJlZdiK7kPjLyANpUylW3b0pQGHXP9qWcnru3YkhiXfX8KBgEnRUknJal69cPp2+KX
 1pdr0ck5/oHN5dtzUvDWhpT5G4FPltSXlTVlpHCMHEvlF5GxUZ2hZ2udlcjToZvie+7Co5D+pW5
 cwAfQv7PywzQARvcfKNqJp3/0lSrXHMx3FOcvJZiTF3DD46aC5Lk757sFFogZZu5sfJweXA==
X-Received: by 2002:a05:701b:2096:10b0:15c:1679:1cc7 with SMTP id
 a92af1059eb24-190a6705ad9mr3448432c88.37.1792606646211; 
 Wed, 21 Oct 2026 11:17:26 -0700 (PDT)
X-Received: by 2002:a05:701b:2096:10b0:15c:1679:1cc7 with SMTP id
 a92af1059eb24-190a6705ad9mr3448388c88.37.1792606645514; 
 Wed, 21 Oct 2026 11:17:25 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903aff3481sm8322088c88.10.2026.10.21.11.17.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 11:17:25 -0700 (PDT)
Message-ID: <5e1cb302-ea25-4b6b-a05c-f4b767687752@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 11:17:23 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/21] multi-target: remove dump functions duplication
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=C9Z8WgP+ c=1 sm=1 tr=0 ts=6ad901b7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FEzH-yfZ0SP5dq0QMlYA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX29T5pbthuOYQ
 hxfw9Qxxs6DLyJJOnEcdQFRMNiN8tpjApr+dKleoAvoqM20OwDDwwCmCK9qG8xpgdJrJL0eqnUO
 6a/E22FbBDFPev+rr4aD9VC8yUCL+Lc=
X-Proofpoint-GUID: Ly2uXYaXUSS5nwxgMzSgkmfqQk-NX15H
X-Proofpoint-ORIG-GUID: Ly2uXYaXUSS5nwxgMzSgkmfqQk-NX15H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfXzWu/6FLcqMOF
 CaYyJUzgHkvKAacXhXTvulvKXQyAjOJtLgfUQ73sOV0U7VU8R65qAoAwdDISuxeVBL8tWvuCxoN
 nSLrMgD2DwF6/Z8Ro2QKmqd3qotPSKFKSJ0o/xTp4CtVa91PdQX8EqwfrWF+BCAkhVB+Q4xgyEy
 pkOaK0xkyPo3RW75/lSlIvGFUo0JKjz1wbwplrej8+tP5oKw6pPtWkcX9TJxuB3yoLtcAF6Dvbj
 JX1xeHRX1Pbxn+E0kPZ4VyV9cSTeZoOJ+N57NdtmVqy2Xvq+NHCwlxjJite1PtY8Db1wsmUcic6
 nGzPiMNPnAJ6A1k/sRqkeXMSVIDu7fpRm7TsmbJb43SykSh4pYl8lIWGJeQdpUV2AGNXtr971Qh
 KZRorvH/c53o+FoIqV0FgJLmsEzGmHGfmQIXERItgwfOzYX57IPcn7SGLNjP+xsDXZkSzX/ZaaE
 EW8mzgLV3A9fjSI1EFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210072
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/2026 2:26 PM, Pierrick Bouvier wrote:
> This series removes duplication of cpu_get_note_size and cpu_get_dump_info per
> target. For this, we define a new sysemu operations for a given cpu, and
> implement it per target.
> 
> Existing implementations were using first_cpu, which is what we continue to do.
> When we'll work on heterogeneous later, we can revisit this to either forbid a
> dump, or perform a dump for each target active. Meanwhile, add a check if we run
> heterogeneous emulation, and refuse to dump if that's the case.
> 
> v4
> --
> 
> - define global wrapper for cpu_get_dump_info and cpu_get_note_size, both using
>   the sysemu op we introduced.
> 
> v3
> --
> 
> - riscv_get_dump_info: add const to riscv cpu
> - use forward decl for ArchDumpInfo instead of including system/dump.h
> - use forward decl for GuestPhysBlockList instead of including system/memory_mapping.h
> - update comment for get_note_size sysemu ops
> - add target_heterogeneous to target_info: returns false for now
> - edit commit description for dump_init changes about why we can have first_cpu null
> - add target_heterogeneous check in dump_init
> - rebased on master (previous "based on" is not needed anymore)
> 
> v2
> --
> 
> - Add new ops to existing SysEmuOps instead of a new DumpOps.
> 
> Pierrick Bouvier (21):
>   target-info: add target_heterogeneous
>   dump/dump: do not dump machine if doing heterogeneous emulation
>   include/qemu/typedefs: add ArchDumpInfo
>   include/qemu/typedefs: add GuestPhysBlockList
>   hw/core/sysemu-cpu-ops: add get_dump_info
>   target/arm: implement get_dump_info sysemu op
>   target/i386: implement get_dump_info sysemu op
>   target/ppc/cpu: constify cpu parameter for
>     ppc_interrupts_little_endian
>   target/ppc: implement get_dump_info sysemu op
>   target/riscv: implement get_dump_info sysemu op
>   target/s390x: implement get_dump_info sysemu op
>   target/loongarch: implement get_dump_info sysemu op
>   dump: reimplement cpu_get_dump_info using get_dump_info sysemu op
>   hw/core/sysemu-cpu-ops: add get_note_size
>   target/arm: implement get_note_size sysemu op
>   target/i386: implement get_note_size sysemu op
>   target/ppc: implement get_note_size sysemu op
>   target/riscv: implement get_note_size sysemu op
>   target/s390x: implement get_note_size sysemu op
>   target/loongarch: implement get_note_size sysemu op
>   dump: reimplement cpu_get_note_size using get_note_size sysemu op
> 
>  dump/dump.c                      | 14 ++++++++++----
>  hw/core/cpu-system.c             | 18 ++++++++++++++++++
>  include/hw/core/cpu.h            | 24 ++++++++++++++++++++++++
>  include/hw/core/sysemu-cpu-ops.h | 13 +++++++++++++
>  include/qemu/target-info.h       |  8 ++++++++
>  include/qemu/typedefs.h          |  2 ++
>  include/system/dump-arch.h       |  5 -----
>  stubs/dump.c                     | 27 ---------------------------
>  stubs/meson.build                |  1 -
>  target-info.c                    |  6 ++++++
>  target/arm/arch_dump.c           | 18 ++++++------------
>  target/arm/cpu.c                 |  2 ++
>  target/arm/internals.h           |  4 ++++
>  target/i386/arch_dump.c          | 10 ++++++----
>  target/i386/cpu-internal.h       |  5 +++++
>  target/i386/cpu.c                |  2 ++
>  target/loongarch/arch_dump.c     |  7 ++++---
>  target/loongarch/cpu.c           |  2 ++
>  target/loongarch/internals.h     |  5 +++++
>  target/ppc/arch_dump.c           | 16 ++++++----------
>  target/ppc/cpu.h                 |  6 +++---
>  target/ppc/cpu_init.c            |  2 ++
>  target/ppc/internal.h            |  7 +++++++
>  target/riscv/arch_dump.c         | 18 +++++++-----------
>  target/riscv/cpu.c               |  2 ++
>  target/riscv/internals.h         |  4 ++++
>  target/s390x/arch_dump.c         |  7 ++++---
>  target/s390x/cpu-system.c        |  2 ++
>  target/s390x/s390x-internal.h    |  5 +++++
>  29 files changed, 159 insertions(+), 83 deletions(-)
>  delete mode 100644 stubs/dump.c
> 

Sent v5, addressing Philippe's suggestions:
https://lore.kernel.org/qemu-devel/20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com/T/#

Regards,
Pierrick

