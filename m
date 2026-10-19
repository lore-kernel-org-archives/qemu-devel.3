Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0AE606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VZCbb34I;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PJHetUxV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIv0F-0002Wz-4z; Mon, 19 Oct 2026 17:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIv0D-0002Wo-Mg
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:34:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIv0C-0006x7-34
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:34:41 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJJu4x3672229
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8rC889pgx3gKbohYbTz5SQsXGyGSC+hnT8C5NJrlUiQ=; b=VZCbb34I+9hzg64a
 +I4WGUXWniWqIU3W0M5znEQ5kY2aRbuvqeZaG+krYxbhiimcl4qaKz2NO4qKSG34
 YTb+HsXiKKZ62il7yk+uqXpXw3HDvc3K6Fpvzg7r3M8wJoGCbDKOot0INk8CrOrm
 wfG5TX/wcun8PSuHCdkCT9s6U/Kv76As25mpnTNco8jDy+3dmTEh3MRzA5b/FYjo
 aRYfcjnaOJHIaRll3Ysb12rY7TLfQs81tNmQvJ6Zv3WGjX49mbHsawJsL2IGAvHw
 stCg9y1gWgQCNAHtC9RUyHJ28H7ksMDMk0xnbFieHXcz8KwM4ZXpZTYdP3R5UzHB
 cgWR2w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3xbcd0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:34:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso4940560eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445678; x=1793050478; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8rC889pgx3gKbohYbTz5SQsXGyGSC+hnT8C5NJrlUiQ=;
 b=PJHetUxVO26XlNM0fGQXxP/uIzdsywUA4+JXbIPSytSjVnZpTwTAjkAS3u5Z8uBMXO
 R7zfTo/9UMZSY043g7Hw1jM9gxWYUevZB7z1r0Sim0qUpJx7EffkkkUHG9oh/rcbdI3r
 6ijfQimcB4FRWpaN2uIu9qJRCSPF+LbOH5GC/nDo4fToI+hoCNfHa3XlENMnACce1Van
 2+nziLxQEY9MavbONEa7NJnXulsqdcb0ISCBd/JbUcgitc6yjt6PocZLbAnF/RDhW/uG
 96KSGXfrh8vUPg46HSNLO1gn/YuifV2OyOp5uuCIkmisZa7qFwVRWJjoEdr+SbsddTRq
 bkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445678; x=1793050478;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8rC889pgx3gKbohYbTz5SQsXGyGSC+hnT8C5NJrlUiQ=;
 b=SRoE74xO56/HLgD0+HVxLCN7ncLdSp4VgQC8pN/kWzY5/XCx7yAvQ0NzvyQwUooVdi
 +uFoBcWLXJ0F+hx7tFrX2MEOK1XN5pdyc7PM8TQm6g+1PKLp7IdFJRHgMiu0LCUOwPG2
 1FSNxMz0L2x990iFQZHXfftI4ryVdCF3i4gcGFAgzxF1AX8W6TEtxYNSP2/cxHzoMbf6
 Uof0AVJ5OAXTwyttSY4aiXU5rttzLkoGCL5dzXxqKK4th4oyia2NPChy/k/G/KXreSpD
 h9mLb2YZ9DFLFcVVn9XEPdP6ZSvfAKZpmgXTgn81y5Gh8ifCT4VRpQfiF693abc84oCw
 BWrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByT33D/p52t+UbvTCeTnbnp4QyPME3dgdgdd4+/ynM0rqQvow6ZAjlsfKQvqn8nLR0Sym3JdLHUCiZw@nongnu.org
X-Gm-Message-State: AFq9FYJuuyVhK+uFyEh2fhqkEZ2v4lHwNBNP1Sc0QbjddJr5K6sGHjvw
 JGQLDtluKypKhxdwhMie4aSvu7lHPYLkWieATic93wXz9Vxp+DoTc0wkLmgWiaUgBoacL6BcMO3
 gVqVrK7CzSFg7mnQXmttxhq5a2emArMkdsTnj3J5ER09xzM0Rw8Dv5e8pXA==
X-Gm-Gg: AYBFou1FIjcf3FmMQXCtqpS6pbNdpw10gHsvxoytTjEcNwqI25nwDOTa11cukvlrg+b
 63y8LCpC81hlMDyXt2W9SgPf7d5ok1ScJGN4u0wJR7vml8Ee+X2oSwpwQr9APydgPuZNrTXy2Bk
 ERTO/tzw+5xdvQCbNs5A6GcB3RfqKMhkAabADrmMlFD7IW+FezIeJiJkZNoAxvXadV2U5bXlUol
 y1ZFaWaEKmwYYaiil4SjOH8Jhm8ENZBeQS8FdQXzUJYL0mYG0MjADj5A4SYj5/Y0CtrBU8aGfvE
 3uAuYfZy4S+4oNtgt+lgIwbDfWMKd3qZ1SBm2ZkJGLFtCUiPQRZhvgaXZxZKhzE1fsvyEO9AjoA
 CR9YO6uLioaGVJOrYZNLE5ofWFmnMQezsIv3l/lU2M1BL2TA8Z3H5d+hR8fr1sVAR/snTWw==
X-Received: by 2002:a05:7022:1201:b0:143:271a:308 with SMTP id
 a92af1059eb24-18515e40940mr11195692c88.46.1792445677920; 
 Mon, 19 Oct 2026 14:34:37 -0700 (PDT)
X-Received: by 2002:a05:7022:1201:b0:143:271a:308 with SMTP id
 a92af1059eb24-18515e40940mr11195670c88.46.1792445677340; 
 Mon, 19 Oct 2026 14:34:37 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831ca95700sm30499751c88.23.2026.10.19.14.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 14:34:36 -0700 (PDT)
Message-ID: <21cee8fd-b186-42e2-acd4-c4e6d7cf4083@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:34:36 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/hexagon: reset implicit USR write state
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20261019153558.2422277-1-brian.cain@oss.qualcomm.com>
 <20261019153558.2422277-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019153558.2422277-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SvGZ64KMJUimgDbjzhfjCIc08LU_4Ojd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX5nbdaUhVirZ4
 pVUKW5CdMYaco4r3N2lCQMH5/qkr5vS4vmv7syu227PwQuHAnJrFWwdmY7NST6WpDfW85py26ay
 hW7vj7JGUXNlDYItm9x7k3EpsptOSMI=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad68cee cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=_wZc9hLAplc2xb_Q-cAA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: SvGZ64KMJUimgDbjzhfjCIc08LU_4Ojd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX6MR25vJIzBaC
 ttToL1gDAmslIWemcbMMrsoVj7NuhkK2f0wHzOnzGh3+w9cVcwqkkyyTyLfRdKTM7BHq6MWZoMC
 K4SvSkw5uRcZE+dAnkS/76th5GHBP6OYKdFR3LJjlzRN5qMboe6Q8td4I5P4GWIK1i4wcVzlFmt
 ulRnvU0lG20LXBXlleDwx5M0dNpOMaTsrMPbNh+FJ/l5BQfagLyZYrWBrqH2p/aV1HiRh9nruYw
 PtDlGtluI/Oklpuxx5YQAdP6n0COnHsz9ea0BrZxBtTgNUFf/satF2scJLmvOtQlKiTGYycTDhg
 v/9cfqg4HKhwx2m/nzo6lBA3g7fM8549IUfvVqIiqCjdUnrZh73b15SWgXiCnbfS1PBvrOTPO4U
 M4ubrOwrT5VdWPtOA3Cvw0kUoio4bidrQ+Mb7P87IXCRvjCVDLDjHSfrtjYaIqDmEt+JAWkvE4D
 VG5i9ptyPPCDgPRzckg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
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

On 10/19/2026 8:35 AM, Brian Cain wrote:
> implicit_usr_write is per-packet DC state. It was not cleared before
> analyzing the next packet. Reset it together with the other per-packet
> state.
> 
> When running qfloat_v81 ubsan reported:
> 
>     target/hexagon/translate.c:725:32: runtime error: load of value 192,
>     which is not a valid value for type '_Bool'
>     target/hexagon/translate.c:874:12: runtime error: load of value 192,
>     which is not a valid value for type '_Bool'
> 
> Fixes: 3e98496691ed ("Hexagon (target/hexagon) Implicit writes to USR don't force packet commit")
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/translate.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

