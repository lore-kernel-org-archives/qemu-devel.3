Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC47C624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1nzJ-0007eX-Td; Wed, 02 Sep 2026 12:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x1nzI-0007e0-DJ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:39:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x1nzF-0000Kc-Ex
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:39:00 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682FcotV1806927
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 16:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K3FzYttzXz9yCD2Z2Xx+n0vbxD4+LxbpHf+3nt5WHd8=; b=SCoWJcZa5JnsJitX
 15kkJAvaYmz50Cbqrr9fZrkfENRvgFt9oNiAao7cNktuqPEB8JtJFJwwOL9VkRbp
 lqBT1grOyrVyBkiZ3dRAueSfcSxC/o8lcT2xOUzDlVLij3VS+qbgp4KXAVoVt3hg
 LSLGWXovNST6lKbpCP0sqpZXtq8qKweiy4ckUy3uVXjp96kSr04SpBfUX4Lb1bGV
 liqtZrJTJW+Jv1cR0n1BdG7HJQXzVNLYsste2GLX9Cy/WkRVTOmDszpvWvq3fSTu
 AM6IomHgw67KvdUUJj6swUIFPfNF5m9H7dqvMn4oPa/O64edwK1/7v0A+bKMGaEL
 J35d/A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdrfev-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 16:38:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e53b8a302so266099785a.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 09:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788367135; x=1788971935; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=K3FzYttzXz9yCD2Z2Xx+n0vbxD4+LxbpHf+3nt5WHd8=;
 b=IVaFG2UArykcCdFohphlkCcisI8X9G+aDbWQVKuyGHXQsaV5B0ixAuU+LjAB9RrUtC
 YvEgNJCWP6FdkyLRhu6liurgGu/jguo09u8bLr8dW3UoSqhxzY2N+NwlCpO5Q/Hy/wRo
 IdygL4AyxCwLaFdTz6kTlaX9QHuYbOLKDK3gt+5vZWkwZ2Oxa8AmuFhjrFZOkNgFvPxM
 FgNc3EwqT2AZKTPxo/j5fjKgCuE7+dTsM4DuLPJWc9pXmHUbKZ0o3DhXGKf4vYs4XlKL
 FUNbpRzdpBrYOEUlE+uFIVMxR/ubghS2rIq3fk/L0wcTpRSUV/T8MZ/Ir5ukTnBByPq4
 zj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788367135; x=1788971935;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K3FzYttzXz9yCD2Z2Xx+n0vbxD4+LxbpHf+3nt5WHd8=;
 b=Ut0TvnUOWPd1mR06anEWwbsEh5fjTvn+gnl6Z0AGF9n9Y6SmbfdhMmqbX5zJ5DbljB
 tBiGsM0rycfHZK4f6esdgXDiBQqvRGCGcdVxAGy7edjxp0JdUC/TXs32UI5EGli4gxYj
 Rh/6/tWkKsBwGG9a0SzK8Wc7QoxevRLobcC83MiYgmT+Te61tdpsmFIwjvmbkDaVX3Hz
 vYvx7eRHY2Q+aKSZQP3+bkwIhKOTIATwauCAixuaHcdQofSMqOMjdMeHa4Vpc31LUqNh
 AgwPDgm3VW2JQvbkZFVn9d7zALruBpgYlaYVivHUbWCpWjvBoB3Q9A5SGJVXjiVZHV7s
 d0kQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrK6Zzv0i8z1n6pPpi3WNrBkMUazH29qPyc1R3ROxbTSHf52Z/Mq3whLypD7m/d5u3++He6DGNMrETw@nongnu.org
X-Gm-Message-State: AFuF++nfKFM/vJz995lGGQ4gmN9aZSQf3nkDkHAA1e3GpTjXQS5fwjB5
 vbCighFoZxyI17bgeth/T/s081GlK0FRPioKv1+lEScmzB0vTq7RCBpeTW+1XL3XKp9dm93WA4s
 OpfvjJ1uj79WnnLckLADHRPROoCyps43XU6vutza5vsi41hZkL3Yy5snUyA==
X-Gm-Gg: AR+sD11ptJIoICe0UWL+tn52Y2cgSrlRLORtGK+Y5pPngAgof4o0/Mijmq7eu0fTVU8
 NaGt5JwLz7RLbPUXhfAdpFDGdfBwQwYlGSJKe+LwCj9iXRIlSjIWcWkld46T7RRlkBLi7aQzKoT
 cgJ1egJYJ+2XxUo3pp6k5ql1zS21XHahu8mtbliU64WHPIoZ+wAwmzvWtiAOxp/6C5gQBXs7pX3
 q5YF+ZhsOUSo9qu05hzB5ejE6cdG0HH+Fh7ukOWCl5yZra3xlNVnttHR2y6neuaqnL/Gix73JRz
 x3wXABDH7SYZeLE7Gvt7ZTqJAPDRE0Ur9CfDVwc+pYKudfk8FYNHZ886ATL9cSEsrJ5wWS/tw9A
 EUcLXmJUEms/uiwmpTSg4s2h26t1LYFzSnp1u
X-Received: by 2002:a05:620a:6f42:b0:939:6dbd:de57 with SMTP id
 af79cd13be357-9396dbdde82mr83946785a.32.1788367134617; 
 Wed, 02 Sep 2026 09:38:54 -0700 (PDT)
X-Received: by 2002:a05:620a:6f42:b0:939:6dbd:de57 with SMTP id
 af79cd13be357-9396dbdde82mr83941085a.32.1788367134035; 
 Wed, 02 Sep 2026 09:38:54 -0700 (PDT)
Received: from [192.168.68.107] ([152.250.131.13])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9395f39b594sm241808785a.36.2026.09.02.09.38.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 09:38:53 -0700 (PDT)
Message-ID: <2974643c-1e95-4cf3-b0cf-34a1ef3985cd@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 13:38:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/15] hw/riscv/fdt-common: prepend helpers with
 "riscv_"
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Palmer Dabbelt <palmer@dabbelt.com>, Joel Stanley <joel@jms.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-2-daniel.barboza@oss.qualcomm.com>
 <cf4a29e2-20e7-4b03-a5d9-e8b0e39f44d4@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cf4a29e2-20e7-4b03-a5d9-e8b0e39f44d4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a98511f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=CXdxNCAnTuDr1kYd6DjE4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=FRSEYCzRAAAA:8
 a=SUrE62rMcF1UMKfSMsoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: EKlTXr2dkDyD6Nfd0eRUCjR32otCFkj2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0NiBTYWx0ZWRfX43GNqAwrnWYP
 bZDXnPF2In69ULwsguyXYATAoXYgmTNHo57hk6AsnpMPizf7lIxAe1sq/cwVe4+jY5lswDLxMt2
 9JsX04shpgKxTxydS7zv+9VcD4nsP8J3WknrkkCgqTal7+5PUviivh6adioGJOpw6DsNNWVzw0M
 0oRFzMrwnevVNZPlMRpE01i/adX2d/DtQOfscRqIyoxz54acLlSsuudcB6eCIqnsBEctS75pSMo
 Pcl40kSYV0EfI216flhYSxgHixhMtSGlKrR27jUZsG0lgqornZvVBGvO26YnQR2DGCM+Pmiznkl
 YEcb/wG8KrjQeXPEsDSJt+iTkwkfrQUwUNENcjnRbV/d+s7sTNpNLiZWOEZjOiSGObrA556HnwJ
 dM5TyaFKwV4Vghf12pu7Mp5PNHI4giDQWnr2NC8qhiONnxFqykUNvkJgeErj8e0CKcjTjCOi+m/
 KgNHe3FA2JQ09087T0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0NiBTYWx0ZWRfX3JzUS8Cy+lgj
 SUOS7w6KO7GQQ4FAhWwe6gv25iYX++qPYEwAi5ioPZpzPZGYb5zokzvYqit9Cgm7YBMhJu09Zvq
 iFN+lCi3T8FrtzEUBsgN0zz+WOdakqg=
X-Proofpoint-ORIG-GUID: EKlTXr2dkDyD6Nfd0eRUCjR32otCFkj2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020146
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 9/2/2026 1:24 PM, Philippe Mathieu-Daudé wrote:
> Hi Daniel,
> 
> On 28/8/26 22:39, Daniel Henrique Barboza wrote:
>> Given that the helpers are public API we should prefix them with
>> "riscv_" to avoid conflicts when linking with different targets in the
>> future, i.e. we should not use generic names like
>> "create_fdt_socket_memory".
>>
>> Despite the amount of lines this is a mechanical change and no real
>> FDT changes are intended.
>>
>> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> Reviewed-by: Chao Liu <chao.liu@processmission.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   hw/riscv/fdt-common.c         | 45 ++++++++++++++++----------------
>>   hw/riscv/sifive_u.c           | 34 +++++++++++++------------
>>   hw/riscv/spike.c              | 30 ++++++++++++----------
>>   hw/riscv/tt_atlantis.c        | 22 ++++++++--------
>>   hw/riscv/virt.c               | 42 +++++++++++++++---------------
>>   include/hw/riscv/fdt-common.h | 48 ++++++++++++++++++-----------------
>>   6 files changed, 117 insertions(+), 104 deletions(-)
> 
> I had the following patch tagged but it will conflict with your
> series which is apparently ready (and at v5):
> https://lore.kernel.org/qemu-devel/20260823150731.896-6-luoyonggang@gmail.com/
> I'll let see with Yonggang what is the simpler (likely have
> his patch rebased once your series is merged).

Yeah, I appreciate if you can wait for this series to be merged and then rebase
things on top of it, in particular because the patches are already queued

Another alternative is to rebase the prefix ACPI helpers patch on top of
alistair/riscv-to-apply.next, given that it should already contain these patches.
Then we could queue that patch alone via a qemu-riscv PR.  It would alleviate
the size of that single-binary series a bit.


Cheers,
Daniel

> 
> Regards,
> 
> Phil.


