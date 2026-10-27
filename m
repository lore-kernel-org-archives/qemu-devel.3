Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1635606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D12dkxDU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YUOW5ZpF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLlxe-0003L6-Vm; Tue, 27 Oct 2026 14:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLlxY-0003Kl-D2
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:31:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLlxW-0005gN-FA
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:31:44 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHWR52452020
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JpyDJlbY07/L75+dcsQ/amzKA7iiAeSjB0shFUBzipM=; b=D12dkxDUjz2WlKh8
 MLOQZDjjBwVDgQzRE6KOL5uifWLT5NFZF072NUedjfKV8uze9bq7u/coEXuGzqcu
 nuvKgETrxyPHzsvSd2hlzHjgmQVGke5HaBqra/j96RRilxvTifB26OYDqVDmN+nR
 XXptrSNdIoLzhNc93/bAcnnQJ2lihD0mdTKyoq93yYMCSYICtbALTnyzHnbdtRkL
 ho0Fabz2kDWQ0SlJzCFEN0hGS5d+5MfdE/1B3GPjZq+Bsuq0exyru+OGbfgJhspN
 cF7cKRMI9EC5fQkhMmDpfOCeIFudHVg/aOQBrYvAvF4wljRH6sC8o45PxPOW9niQ
 89d0oA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy6g0n6e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:31:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36637676140so193472eec.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 11:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793125899; x=1793730699; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JpyDJlbY07/L75+dcsQ/amzKA7iiAeSjB0shFUBzipM=;
 b=YUOW5ZpFvzkDTZ7aW8U6HHa3dPFyZVE3mGGg1ABmJxOzOOW/Kb2FyeWWy4XOXX+5oi
 y3aCiECVjCEYytkVp27a5hxjhNYBUbshSLq8zHKoBCm36+r2OvLpeVDQaSfOSruVgG20
 HQPK1V0sgpoOle1+nLcMUevVJflgSUj3oUavqaCBlDk0ZyIzC66Nbk8ErpVf3AS32Deh
 xVBXFjlG8XHZu8+uqQmFU+RxYsr2V6Z9cAtaBmodw1iLsipBPtPWucjYO+C6wjJ7bc78
 NubJ0v53KttCX9G74ff28zSLHwWNScXlyACJlsR3fEtA9ir8WQYHYdaQF8+0IsI27aeR
 Ps/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793125899; x=1793730699;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JpyDJlbY07/L75+dcsQ/amzKA7iiAeSjB0shFUBzipM=;
 b=x36SnuQTgRght+FtIvVJZJitdoQLrp2kdracI/j5hf3/OOOjTH3S4RyvsXpnmIWn+5
 oe4YN3Ix9aAtxi/qetqf6O37QwhpjTC/hV9VN5XQKuUGxz+SgBIRiDSjpr2EQv5ke0dq
 VhA5NDA5B1G6K8ngK/qQC8k6PSzMlmB22pqTXTz5hFnQY30TKvAGklWjfB3qksZyCDzS
 vxiZFoAsQLuZBh/YrgGp/ZJZaxe0a12B3LvvrQg8MydrrtZaWWYqYa7cFHJqOdeaogP8
 7pdcKsTmvdSxXO+DTokrVnBQyGeMqzyZwvzDbyK5EVE5O5ZBjk1kzThbJWWno04FVE3Z
 ZE1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzr97xf2ZfBJ/nNUu58IE16hsTcTtFjSCzFuhznqbKijz5fFSoinvt/QYMlvdKAHu+2MVsK1uHL1vxT@nongnu.org
X-Gm-Message-State: AFq9FYLcgxDDGhjtN6RImhMfCcmsmMsDtw4Cm34PGHgPcE3oDpuprzh+
 jw8Ea5Xck/JXsU36uLC8/PdlNvmELb76tKUx4k+lScbF88AeuIY6yTKl7GTPmlcL+SGuHDN2BNQ
 LPgjTrkT27uujTz6qK5uRg1jr8kDcl2AziE7c+VoMRu+jpRD6EKHnKUvcNA==
X-Gm-Gg: AYBFou38i6wwq72/fNCPJI5et+MYpmGeQ7dgAGEQnDD/r7SuugMU1D5FKbzPh3C/Nsg
 g5SY2O/mL/5XLwGcML5lZybtliuYNlkhv1c77pXuyVVEX0JKNKLGaSyQPoyu4IsHPWAzcr92I+U
 A1up0aKfN7ooWs0GKWZp+pMLFvIi4mZSOjKQRAf0fqvSoH8NwETWuT6R9QsqYBfTcbEqk8ih6Kt
 zX2xCQuymsPrHGf8p+ls3ugqLB7CC7CtKPsVIhbYq3VJXdcDkouBboEl6UHpF3Lm3UT5vxOthjd
 LJy4dZSoFU9fVmPWc22jSyBPHCuULuoiBrHzJkKL6Pj96Xg/seDOk0wdyol8ZqgYly9WhqNw1++
 bOK1IAQ/M8CmsVCWkJOX1bC5w7bpAF8Tumu5QrFaOvi5lUxBOEdmalLpDjtei4w5BhEFS4d4Ddl
 cOQHSlA4EhOqdGrpkd6BpgtdzPx7fZTFngJ8UJl8qAM5o=
X-Received: by 2002:a05:7022:7e8a:b0:19a:ace1:793b with SMTP id
 a92af1059eb24-1a6cf72b429mr92010c88.18.1793125898970; 
 Tue, 27 Oct 2026 11:31:38 -0700 (PDT)
X-Received: by 2002:a05:7022:7e8a:b0:19a:ace1:793b with SMTP id
 a92af1059eb24-1a6cf72b429mr91950c88.18.1793125898000; 
 Tue, 27 Oct 2026 11:31:38 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a6d7cebf50sm58210c88.8.2026.10.27.11.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 11:31:37 -0700 (PDT)
Message-ID: <d001a2c6-79ab-4f75-8c00-ae0c43a67d2f@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 10:31:36 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] accel: register CPU parent for each target
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Darren Kenny <darren.kenny@oracle.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Philippe Mathieu-Daude <philmd@mailo.com>,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20261027054026.2184-1-luoyonggang@gmail.com>
 <20261027054026.2184-3-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261027054026.2184-3-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MyBTYWx0ZWRfX28VXjT9zyTn9
 SpPi2c/zKtCcnIR7juXG/qSYFVAVF89RkQ4R7qMcxJoMqlLaETMs9RrAXxt98+w3NBycHFAc0gN
 /Y3NrHud9gE+hs23Rpk6CTbtfnsUS2BpaFoZ2zubAVHUqMAoyKrrD/9nDDQTpfzcoZZ7nI8PtiV
 lXN70EE29sweXL8EcUji2Y3HavQakWhjfO6LJ1/CmSp3tEevcTu1g8qqkev5aWovgLaI0dSlUEh
 TXPqEYYTowYWf3SXS7BA2HSQ3Qk7oPzsdSR1Mjz6+ZokLwmEpwKTLTnzTwNu7dPW4A6QDuG5brh
 XHsaUyirNxj4zZ/+eFPhuvJcDOkOyf/3T31IzzO4SLp/h7nXEJXaGSW8zaUMABio3pciGtQyJxq
 31P654aTQxFK8sbxbKA7asCLx7tfFvuRzs5wnrzBTpvDw8ROECUaz5rp7Gr0/TnfZSce7e21c/R
 UDxuxqQefVHEOqOv2eg==
X-Proofpoint-GUID: el9JOuNj4x_EmbgMBEberPAgtjxQoXev
X-Proofpoint-ORIG-GUID: el9JOuNj4x_EmbgMBEberPAgtjxQoXev
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MyBTYWx0ZWRfX69iuqqC8mgGD
 jT7p0/UbrFqaQkPZbsFdUrkHfUIqtHrG0k2bi6stPqIJe9qfVWdWCMtibnYgcdeYyhZck0VMP+3
 wHAYd5bTAVCPL3xMqM53a9mKplCD2JE=
X-Authority-Analysis: v=2.4 cv=dKgzC+Zb c=1 sm=1 tr=0 ts=6ae0ee0b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=OBV5wcaDKfne6SrtsoEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270073
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

On 10/26/2026 9:40 PM, Yonggang Luo wrote:
> Now we need use the prepared target-list to register different accel-$cpu_type
> parent QOM type. So that multi-target won't error missing parent for different
> accel for different arch.
> 
> Also add a test for it in test-multi-target.c
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  accel/accel-common.c           |  6 ++----
>  accel/accel-internal.h         |  1 +
>  accel/accel-system.c           | 24 ++++++++++++++++++++++++
>  accel/accel-user.c             |  7 +++++++
>  tests/unit/test-multi-target.c | 15 +++++++++++++++
>  5 files changed, 49 insertions(+), 4 deletions(-)
> 

An alternative would be to keep a target specific accel file
(accel-target.c), which only contains code registration for accel type,
and no global symbols.

This way, the type is correctly present for all targets, without needing
to iterate list of targets explicitly, as build system includes what is
needed directly.

IMHO, it would be simpler and better.

What do you think?

Regards,
Pierrick

