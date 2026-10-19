Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19360606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=awH8Mjjm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iKK6ASyS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuvg-0006DO-2I; Mon, 19 Oct 2026 17:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIuvJ-0004rz-I6
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:29:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIuvH-0006RV-Vb
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:29:37 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKCOx3329048
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0UR604e67b50Pm5D7QcfiT7jxbCGtxxvLEGqJfuOFJY=; b=awH8MjjmeG7oykNg
 nmcbd7YRINCFJsrPXYRIwgXcflpibsEnH3x0onBz3wEYc6wVIW8E77k2aFkFllX0
 fscPNYG/xB4qIDIS2+IrzkLeVlfhWLAoHQN+TNgmZ6Rov/Ca5EamLHwOBlED918w
 xt6yd1sQmca1l24xiG6/gZDCDCaEX1fYpzEB2JDMIsPHJNP4n4B6xwTyUk7d5fHC
 SrfoY+9FXS/kGt3U6ZyQ5klv4+Z8nRAN7ZbPqMgF85wFosTids8EqnzV+8w4LDLJ
 LGKQtxN9tql/98cgA1FeM116kB92vFecWnrKSDLdXg14yePo0yzPy811mrSjQORJ
 56PsCQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdkmfj3bh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:29:34 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35a04491c56so115138eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445374; x=1793050174; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0UR604e67b50Pm5D7QcfiT7jxbCGtxxvLEGqJfuOFJY=;
 b=iKK6ASySlzCxSZ1juOzNBk81G3m9Ap5uc1+al9xNKL+b7sXp8YyKJE9JeLyDKQxlsG
 4j17e9hPC0oNLp9K1FZrY6qX8SG9S6LCVEbMtJHqhveArvZegZVayTqtkFuYbqGGexME
 yhn2ntU0g+/mUh6OgGeii0BCwX2XHwf01VOLZd0E59egB9zBYhW4un4T3gfi7IF2ibg5
 ob6NTNBlBjq0TyJcaBRYKcB9P7o94r/dAv+16/sHBWXNVCtuRQvJLC7nlabWLsjbGN2G
 BttYSCvXFoe3z0swJ3RroDCiwcR15eXh9NaBPnlGuwo6h4KlQmdp703GXfaW73SKv/Y2
 /1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445374; x=1793050174;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0UR604e67b50Pm5D7QcfiT7jxbCGtxxvLEGqJfuOFJY=;
 b=2io57dmAGpLXNH5pIgtZQJMQAbpwt9Z1wNBc0mP0eAzfbQc0mkYRK9ceY7MYkmemZs
 i4EBReCdjVo7hM7Etr8VRXdKW662x6Qu9y6g+FVLEb3akWNqI/P/0U5NWf7Ip/sCh7Yt
 Pgp8DpGjCjywhDha9wO/nG9UMeH3dYAUie2jff0wMxThRRaPd0cKxvjM/GhfB32DTcmR
 nRBfrdG8xOQ5FV0C6xVQSRkE2ZEFSIGSyd8fYJwfsf/hErKqT+YbRJxrBQ8mc12kx6SZ
 suIvnQXqKegEKx8Z7qhPl+H0dNMQpldB9k25mMNZPM/t6MltHDjtdYfZw0FIxs0S6go7
 eOAA==
X-Gm-Message-State: AFq9FYKuJpq10dTSRgln7KBgZQIlZu7dTfMgFRXz+oD7SUuMMeUtB2DL
 6uIj2V4RR8yPxurkqtQowBKuTQ7E7xl6XraV7x0lS3LKPbZHocFGzFZMl+bK3J8iyhxysxsdW3O
 iIvVyvmt6fwiXz7oNXr8Yqfe6otgZ1qtc4prUrib2HhlyiabYAPAedDW5A1q7H6qrKw==
X-Gm-Gg: AYBFou2HquTypCPFQSUu9imxwf8Kv9PaLULb2Nlm4VFQg5ozDWUZ4G1Ur6gzHnpYMKR
 RYmT1qPfe9/1VscBm0GleNqLYNHKIzLU8B2kSG8pd1o8Q5IZCfH1h+rw4IuA5YLrZyIOsVt+/hn
 BVsfbk3NGk9XuM1PI+1Ditmwkne5Le2rVD1Eoikqf3TKbhWEljn41LaPmD+jRTHEppIQddUPiTP
 lNQmSsbL48CjwDYXqceTXcedrxrFvlsm+wOK24VLd1ZSoXToC8tBoLFOvWYgIB0L5UUG0mgzUim
 eMEux+H6tQWgjnT6KcrL1GItAxHXfyzaqdxGPRLlaAk2DqECuAGoHn5ATLFp8lGLjTCkLTkltNV
 fO8X0WhzqJamETacU9VGhzwg8BhiPbRU9yCxavWHb2OAUWWstkhzNwtR7HF1jr46f22krwQ==
X-Received: by 2002:a05:7300:e7a4:b0:353:5d7a:cabe with SMTP id
 5a478bee46e88-365fad8dd2dmr610669eec.13.1792445373877; 
 Mon, 19 Oct 2026 14:29:33 -0700 (PDT)
X-Received: by 2002:a05:7300:e7a4:b0:353:5d7a:cabe with SMTP id
 5a478bee46e88-365fad8dd2dmr610635eec.13.1792445373323; 
 Mon, 19 Oct 2026 14:29:33 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36081bafa7asm34104167eec.14.2026.10.19.14.29.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 14:29:32 -0700 (PDT)
Message-ID: <2a5dc803-e489-4498-940d-9f80447e7972@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:29:31 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/23] multi-target: remove dump functions duplication
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Slw4ZuI5_cqXmUve8vl11gu20sFOrnYw
X-Authority-Analysis: v=2.4 cv=O+isLx9W c=1 sm=1 tr=0 ts=6ad68bbe cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TI8A3OJVNP0_04Zy9lwA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX5oimNiEnUwN1
 v9DObONFI60Nvno970J8YbxDx0FmhY27nvdOYeVicL0kzkXSJrHhuTc3vrrvILrRkSWtjiDFYY9
 wwp1zgnen9erTNC/7NhkY8OU+3TrwTOock1mW6Q01bAI0i5mvbXbgPVmfG+sbt2j69W3KDsJEq/
 lVAogoiPQhNxTVh8iCCp1zphzfieMBDvLv3drUpDjmFOFw49fh7UyWe/byTvhZS9PziHqYx44jr
 ++X8LUt6CWkvqrSAIHBgwfhA59uj4UPT4+m4BWqGDryvZ27J3eJHeKU//JYutoKFbbYNj2s5C1g
 SDLYX3OAf8EdOamergxkFANBR0M6lv7i9igM6iZhB/s+ulOw0VXX47I2qXULK32yMFg4fh7BSHL
 Eimg6VEC4HE23sBOLeQpeK3qqBCGHG5Ebut2Le6FkpBDgTcnntUbpFDeWvQE1olvl7K3efDSvBX
 w9LXohvQjgHzsPbX/jg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX/FX9cI66BiJ1
 kBN/TAWK+kTUt+zgJbMsi0HEJW0yVuQK4DgNa2yTsfUOwICHnML4ToZjmUNCmuPXU3LtaL/SrGM
 MrXwqTgoid9f6e7vD7e4RcDyxDFf4fA=
X-Proofpoint-ORIG-GUID: Slw4ZuI5_cqXmUve8vl11gu20sFOrnYw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/16/2026 11:13 AM, Pierrick Bouvier wrote:
> This series removes duplication of cpu_get_note_size and cpu_get_dump_info per
> target. For this, we define a new sysemu operations for a given cpu, and
> implement it per target.
> 
> Existing implementations were using first_cpu, which is what we continue to do.
> When we'll work on heterogeneous later, we can revisit this to either forbid a
> dump, or perform a dump for each target active. Meanwhile, add a check if we run
> heterogeneous emulation, and refuse to dump if that's the case.
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

Sent v4, adding global wrappers for cpu_get_dump_info and
cpu_get_note_size. See:
https://lore.kernel.org/qemu-devel/20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Regards,
Pierrick


