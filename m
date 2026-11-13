Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26447606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 05:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mE9f9svA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MhguSUdk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRjTd-0007Zl-RV; Fri, 13 Nov 2026 00:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xRjTb-0007ZE-Hb
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 00:05:27 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xRjTa-0001hA-20
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 00:05:27 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD2KvZC538129
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 05:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mJBDBGidFy5qB6fm5c13yfZCOk6Hy/Jfa5gjykmHkWc=; b=mE9f9svAVUwMmHJj
 vLeWLUKqLfVq1PyZK0Z5gv/RFunF/J+tQjsvF/k3MNqPA9iBnb3DpB71OmPUvgJO
 78UyulahHWBoI+2YiJE3LXLC+UcGvJ0sFMDSd0JCg4A7nxLDvcWDu3mcMu7SHEdU
 OZIXTdJPj+WdFERcBsdYtuGXLhi0bEw72XvhIolL9iwsiF1IVFKNKVOpIRFCZLty
 NuHO6RP1R75fqLPS54cdt6CM4qu2i33bXKsnyk9nCZONvXhgc2YcOGK6/1hf0WA9
 JlgbkW5iji1rcB+HMap4wtrfEjJzqPKzEnH4kikYpMaxiXI2BraIVRI4ziE8ZyG4
 XMAUaQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwc1j3dvv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 05:05:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-534f3fe0236so11060931cf.2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 21:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794546323; x=1795151123; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mJBDBGidFy5qB6fm5c13yfZCOk6Hy/Jfa5gjykmHkWc=;
 b=MhguSUdks1jOfNyLmRjvQfBE9+/m8Jlb/aEBHDazoyMkcJDL/r1jjgFvTjJdRB1fr8
 wIB8Q9uKSzZyA6tF6rFGnyWXRbelvEc3SIPB4HfPSpxrIsaOcZGh9D9h47nE5Krj7mbn
 6lHGuWYXzXLBJmAvJpr7UYJjtzwXALzJDuKG6XVH42WATOHhAlIWTSUttmbB2wGzZtUW
 Wm2ptSpxeM6/k7iJ5xxwtG6V8WFWitibfny/cCHR+X2MSlvF0CwC6an40+qlFkzpd6zW
 XZ2Ty5gjoPLPN14BSKb0pwuAPRWEzwx4PT30D5TmshSkN0kdrTDV/Dyqmm0+J64gE2hK
 jvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794546323; x=1795151123;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mJBDBGidFy5qB6fm5c13yfZCOk6Hy/Jfa5gjykmHkWc=;
 b=1BkzQGXLi0Y91r6rYc4yu1XTUFOjXrh6ZnPSac62Y4oRAmfpftOUE80b0D/jQt4QWQ
 C192XlmKPU6IWyE3oXS/yrQSFJmmd6vRvGuATKul8TN3crw6/Rm+RCVuIjtCpev3nPcS
 TuyAutvyuuGQpwvdcYBrHH4lNgecK00SBxJgSZ3wJAAAYWujfCbzyokV9FzpayMRAJNo
 wrXTS0ekvMb/sBfEb1VL4cefmCiKBs9wV2wuac4v30av4s8W8N0FU87lEYIzWosqi8jS
 M9O4q6j8pVhCD1Vhic9b69wzO596pC7VqpIvVBE+8nZ5YqWI6/z9YLCtPWVk4o1xb91W
 98PA==
X-Forwarded-Encrypted: i=1;
 AL+hErFFSB2rPTQQ/dgX/bLru0b7k9lJzaenA/4VYwHORvlBpTGhqvcGg0yh7uPqNpXK6cFQY7hzoapWD3XE@nongnu.org
X-Gm-Message-State: APuU4Z/HvKrAjV+l28pEbor9hSz4yYQZvLLrBli2u6W5NyB9OGE2aRtH
 j+94agvvd4sMBSE+8+H9X9jFVoS59gPWX5RJKwWO8tAU3q9l1OoH0/Qb//bPVDdsMW0yUqbwvLB
 bssoyRm69d0MprLDOW685Rcn6DLSSCPjogPey9kSIPJV5Q4aWYCoMpHHWsQ==
X-Gm-Gg: AYBFou3fTXN19sAP19NZ9vwQfcvoUFgn9M/biSSJhADfcWx8uvn3Km3iLxyEA3nFJ6w
 rlRgKuL1a2p4XUiSPV+ZXApyds5DlY9lKLyTizVpcr3e6wnuN4f/j3QzEZNg3oxiTXbljZePgYj
 s2zSkrw3mrBPSFI5CN3cmyHtbpth16iPxu9mKxiVb2478p8pbQbmachjaYYwCyQPHa4E5TVN5Mc
 /PV0MvkKZqwoIqT8CS+TtYD7WOLN3dTi6O3pyer8ESrp6LZ9jXnxaB5BSTsVAKIo8qg+0VlUw81
 fGbSldnq9bcgtbhi/CS+v+l0tG4QFbyvYkZ21VCgWhFrbaZyHQ6D74U/pyYVdhccIGKh8RAxKud
 D4M0wulfPDm9gxMN8NSrM7jxYYkVskvjHs5YwG30uQSwbNetqkdyY59byOep9VHzd908ZFaz21C
 XG
X-Received: by 2002:ac8:5ac2:0:b0:54a:755d:6fd4 with SMTP id
 d75a77b69052e-55ac4390eadmr27834571cf.9.1794546323363; 
 Thu, 12 Nov 2026 21:05:23 -0800 (PST)
X-Received: by 2002:ac8:5ac2:0:b0:54a:755d:6fd4 with SMTP id
 d75a77b69052e-55ac4390eadmr27834251cf.9.1794546322785; 
 Thu, 12 Nov 2026 21:05:22 -0800 (PST)
Received: from [172.31.27.103] ([69.196.88.181])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55ace15ce7csm11067771cf.1.2026.11.12.21.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 21:05:21 -0800 (PST)
Message-ID: <7be46208-0e80-4244-ba63-7b4f8a328d43@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 23:05:19 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] linux-user/hexagon: Reset hlx_ctx pointer on cpu
 clone
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, marco.liebel@oss.qualcomm.com
References: <20261112232032.396-1-anjo@rev.ng>
 <20261112232032.396-5-anjo@rev.ng>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261112232032.396-5-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAxOSBTYWx0ZWRfX9wagXhhI+BQo
 /rX9y7t/Sy/o5PZa/J3jmkD6iBl+H/coIu5m4+sCF2pawYZcBq1dzXPbePON9m5L6hh3fmWB2rS
 GCAD1fsJtTvQ2CounNLCYdm+wbLVSO4=
X-Proofpoint-ORIG-GUID: OiXSKvidPYl3o40NCkUDqkjC7QisClsS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAxOSBTYWx0ZWRfX6fi2vl1ElNGW
 OQ9ozGS05YnM6UGE7XKkwVmTD4B0GgFPjq7swFuV5doBdLGlnEzF1HL5xAaKD1AbL5+c/NjMbb6
 HEnGKr6ExvOggaffoErHd9Obyhq9fHll8kqEUZ94GwYgQvmatWBKiNiRkXcTT/wPs5n6tXdgu49
 0I27XauW6qIktw9T6BsAGxjbsTSrdwnAOhmE8DSb1FtkRPFOzsWfJ+JzHiZxbxWVjSNOsFVZokn
 OwkGUv77IRjwVcPikQb4il1iLz+rSXhHJHij7BjogmKJ2xvE0h30bOT8IAqjBA4Cb0tjoyVHdew
 /2vHUQotp1h+C3DHesiUWVJt5ZUWRPYoFfP/fO6jN+KaTgy4Iw6/wlm20YOo2yk3uppLvbQe5cg
 OE/B2luZrM7XaNYmzIlp1Rb0KDXjT7Na+jUDtOfAmpEF7zni07v3sPItIOtHe5xAgtw2O30+ULq
 PuECCDihWo0IEjnlHJw==
X-Proofpoint-GUID: OiXSKvidPYl3o40NCkUDqkjC7QisClsS
X-Authority-Analysis: v=2.4 cv=Vqe2kO2n c=1 sm=1 tr=0 ts=6af69a94 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=cE0r1ZmtaMrRAdDjMn+EDw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1Exx3FwW-9S6y15lVdwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130019
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 11/12/2026 5:20 PM, Anton Johansson wrote:
> Currently hlx_ctx retains the pointer to the hlx_user_ctx of its parent.
> Another way to go is similar to hvx_ctx, which in user-mode, is just the
> struct itself rather than a pointer to the struct.
>
> Fixes: cf0bfbc338eaeef2b ("target/hexagon: manage HLX contexts through CCR")
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>   linux-user/hexagon/target_cpu.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/linux-user/hexagon/target_cpu.h b/linux-user/hexagon/target_cpu.h
> index ecb76e9268..6c36b7166f 100644
> --- a/linux-user/hexagon/target_cpu.h
> +++ b/linux-user/hexagon/target_cpu.h
> @@ -25,6 +25,7 @@ static inline void cpu_clone_regs_child(CPUHexagonState *env,
>           env->gpr[HEX_REG_SP] = newsp;
>       }
>       env->gpr[0] = 0;
> +    env->hlx_ctx = &env->hlx_user_ctx;
>   }
>   
>   static inline void cpu_clone_regs_parent(CPUHexagonState *env, unsigned flags)

