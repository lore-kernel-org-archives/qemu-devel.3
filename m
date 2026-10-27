Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C8606A332
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cfgwSg67;
	dkim=temperror header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DMnABrFc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLlJQ-0000o4-In; Tue, 27 Oct 2026 13:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLlJ1-0000lr-9y
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:49:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLlIz-0000wx-Be
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:49:50 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RGxr801284544
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 17:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 inN2tJ5fwowb9iLsTMCb9q5D1ZBkimqbMVC8tDOsCME=; b=cfgwSg67OOlZM+ML
 Ty4rKLLcC10+v+jk+Hqnj8NfSmGeh8LXWZUUn0O5aGe/HcLuZYelSAd+Gtvcn6bv
 hisQ74lcCEWxFPTVhiKe/aidvuh8fIfdh1nthJAP32jNgsbaxom6SJnL04R5e6Ji
 hqs+NHJwvxGUg5NdAGnRp4f4fN+p/suhyQ+o5opn6BGk1x3o365WhIWZywhDF5g+
 WMh96Whue3m/h8MZXr24T6zT8Kaa2vIv43RJDAJD/Q8X0ccZ7fNLZ3yWhurqm+jl
 9/9PqGWu9GTel3ac4EV+pX+vxOlySFFsMuTAurhUzk1piyHgcCrcyJPSEZQn4Hwj
 Lxdebg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy710fhe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 17:49:45 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36a1e2485fdso211515eec.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 10:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793123385; x=1793728185; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=inN2tJ5fwowb9iLsTMCb9q5D1ZBkimqbMVC8tDOsCME=;
 b=DMnABrFc3Njy6E9ZkrAwc8DfZbkQ4J1pAh1YaQbKwjbeJwry++4ckHruEcphz5wbXX
 IFUc+TlOPwur+gTLIiO4yzDiP9cq3r2UuzU9MHbeUG18wti7A9r/MYEarLfDDLlxf0oe
 qbyJCLbHFfMWUAPMMMJkyt6oLMGx4Kas+Dl5ETIztKeXQ8//+Vg+zZ/YfNJuXCyBqZGE
 RZ51lwkfWb+aCpF/zEqWGXlom092HopgtTfCspwfFGe8zv/X8gaw1QGZbE5OZZShG0xg
 vJgkpnH+voCq2ZcKrORJNgNOuX+enZb/B3eraZL+LCva6dzUvBS2e5fBc4mxebYVNkmT
 F9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793123385; x=1793728185;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=inN2tJ5fwowb9iLsTMCb9q5D1ZBkimqbMVC8tDOsCME=;
 b=pJCOESc8+trErOwv3B+a8yRU0ZhIxUWlZVh5OZy0icAFY62RQrCGl4EtlsKdwI2D3x
 IRSGdJGEU6jWEPuP/1LFtLrIWbYMJ26F/TBHla0RTNJZ3bOMJPboLoS+4ruM1advbmWh
 6oJhUbzNjDx9nfNjobEJMlV1YsXpgeX68VnHn7cuNq38Ca6ALjVexSJRFs+GNyDre8kJ
 uqHHON7jJ5UAqxS393UwBEoPgoSR2cZwiJSD7yV0ikBiepl5RSVYVY7R+qRZIIltvRt1
 PbNYS4nvI+/Q4pNeX2cZDXaD6fccHxMx9twoOFI/634xPkzbzTj4LUlI9gU9w4Tn3jkC
 dS2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5bBCPOrchKxT1mujMRMNeOSUJMyOpEOKbqsX5G7ylvF67KUYwfpJ7mk3RBmi5crBy66Oddr4ZN1a0@nongnu.org
X-Gm-Message-State: AFq9FYL6QWawp14KV27QbQDmmBiqVyYbZYDjJpUayH+gytY2TAh8jScR
 OnQ2V1MywB43UqIv2oRS2x5wxSGnze5a0qDpbc9fSsgX9vM2wlxPgWYX13skiQmI6Uufr/5TSNX
 h6OHwwhsGm2saYRyjsaBWoIZ7jYk70mo1nsCkkKhSlpRLHqmreJxM/VUeSQ==
X-Gm-Gg: AYBFou11fwYXQieQUNBE+Gyt/y8/5zEBKpi0+p9tWMi8IkglAuyEfUyYwLoXm0W1peI
 emRzGLNQccn2UaF79MnPKjhNs4ya/KbWnWjFn07D8vKM09l+peQu/nbmgzeGPqVCcMC5TuHgtRL
 Au7/efPXo36QqETqBU7vhQJdFCNdwwQnLqNdRLpW79eqzT42W+GbYKj6jcfvynosrB9YoT8zzO2
 IjHiPUo0r19z9Vw0mC2D78trVMQrcphI5ptNqkI3uPKZUHnrV27ucDmXRgw7iRPZW8v0VZObIF8
 XWsNljxR2R0IICBvzjB2cUqRUs8A5uBKXBcvvCOECoik7g6k3gMi8oTQJqGhlcN0eJM91x8gnik
 HgewuWdQmlbxmSljHC+xjEW56ob+TqeS0MVg4X+Iu1FsHOPxKT0d/kywBqtr2FtXF8UpSjg==
X-Received: by 2002:a05:693c:881a:20b0:35e:f1a5:9ba6 with SMTP id
 5a478bee46e88-36a202869c9mr248504eec.5.1793123384746; 
 Tue, 27 Oct 2026 10:49:44 -0700 (PDT)
X-Received: by 2002:a05:693c:881a:20b0:35e:f1a5:9ba6 with SMTP id
 5a478bee46e88-36a202869c9mr248478eec.5.1793123383839; 
 Tue, 27 Oct 2026 10:49:43 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a11b45b8csm11115984eec.17.2026.10.27.10.49.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 10:49:43 -0700 (PDT)
Message-ID: <b8c60725-6f73-46d6-a044-3a69a8bdba68@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 09:49:42 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Widen QEMU_ARCH_* and arch_bitmask to uint64_t
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261027061504.2213-1-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261027061504.2213-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MCBTYWx0ZWRfXzxAj2/n/etr6
 AZf1dKRKddzD4SNRXXaP8rlmHHRgeAaN6AYDbPwePNhxb4d/olCDLyW7HylrYXTutqNH+IljLx/
 67H/xdUx2eNvGS1PR89GxxDWfM7NR1HH55MVYqP5ZzBwabNkHD9nD47GMFCSg4XSCH8KJn6HNNu
 jZbvYF/NmQxP+ng00li5JLMyoJYjP0GLmk9+DgKyfvI/F6fpauKGYXlNKBZvI0NN+pktLtmJfgV
 kzDauzZugSpwllJiBw6toQA9eYd4UpoLSIGbrWc2ih96o+/W4UbNv9IQk7zXLREsrIVec/abB+A
 /DLoxGmmtepQFqEG9HLmRCZSCDGurNPdcwI3m1Ng0YBlEk0Jqic61K3ilfRqSbFn4pxBKPcVPsh
 lTH+uMZbWOdxAezVBv0J8u2mo/BxsX/9wp+a3PeGnw62z61Tkj6flGWY1QBmhpySx21BfC8L7od
 KDT774NYHFPzapacN4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MCBTYWx0ZWRfXxLjvjB3QWl/D
 qcC0bO0gziozeaLoDDwayb/svchdIHKHrRTMiKvJ/2A08cmGeGS/rcvQzhAYBJgA3ufAMFvvUaM
 ndEtNfy+BpA5wL/pt/oqYZrue8mQWPk=
X-Authority-Analysis: v=2.4 cv=JspkP84C c=1 sm=1 tr=0 ts=6ae0e439 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=uITOaVJ67YeQtSZD-PAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: zNUjyoSreOmcbLMaFsaWdxJz-KGACAPo
X-Proofpoint-ORIG-GUID: zNUjyoSreOmcbLMaFsaWdxJz-KGACAPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/2026 10:15 PM, Yonggang Luo wrote:
> QEMU_ARCH_* was defined as (1UL << target).  unsigned long is 32 bits
> on Windows and 64 bits on LP64 hosts, so the mask width depended on
> the host data model.  Define the bits with 1ULL and store every
> arch_bitmask as uint64_t.
> SYS_EMU_TARGET__MAX is already 29.  With a 32-bit mask, __MAX has to
> stay at most 31, so there is almost no room for new targets.  A
> uint64_t mask raises that ceiling to 63.  It stays 63, rather than
> 64, so the all-targets mask still fits in the int64_t range used by
> qemu_opt_set_number().
> 
> Yonggang Luo (3):
>   qemu/base-arch-defs: extract QEMU_ARCH_BIT for QEMU_ARCH_* enums
>   qemu: Use SYS_EMU_TARGET__MAX to define QEMU_ARCH_ALL
>   qemu: increase width of QEMU_ARCH_* masks enums to be 64 bits
> 
>  include/qemu/base-arch-defs.h  | 67 ++++++++++++++++++----------------
>  monitor/monitor-hmp-internal.h |  2 +-
>  system/arch_init.c             |  4 +-
>  system/qdev-monitor.c          |  2 +-
>  system/vl.c                    |  2 +-
>  5 files changed, 40 insertions(+), 37 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


