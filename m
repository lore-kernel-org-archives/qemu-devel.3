Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52749C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnJ4d-00045M-Fu; Fri, 24 Jul 2026 12:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wnJ4Y-00044B-Dh
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:48:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wnJ4W-0006Uu-RQ
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:48:30 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ODbHvV151637
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 16:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /F2WJ4MAto8F8BDkpimqR2p/UrzdXFH6WrKtkJMG5JM=; b=hNOo0R+RHnPTBaco
 accLdjI401n3hhd9cRxxViBbbFdlu2uHP9QXfaYiBwDGY7dtTlrDMkrU5IQYvyzi
 J4Y/OHf6BJmFQA9IxmFl9v+18etdlV9APo4h1l87BXBVRF5TaK76hXBFQx4d6Nj5
 o/f+iGQ+FF5Yz2PgeFfu/31rQewpFiYCZzLh6TUDPxbN3qA06d371OtGtdx4XzkW
 Bogq72x87DO585Yakod8uvSx+ttKfhpeGA83rXkZ2NP9tHhpw/Ytr1zuaMbPJaTV
 +moxB/Zkm7mHx8IN9ADsfqhwsxfPCJzNRoL5Vuprtu0yZsUP7lgAhPxLqEsNiKVf
 +2uOAw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8ck8uyu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 16:48:27 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb5cc1e139bso423220a12.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784911706; x=1785516506; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/F2WJ4MAto8F8BDkpimqR2p/UrzdXFH6WrKtkJMG5JM=;
 b=M3nHTrRFci1k5f3UKiwpenNDdGyn/uv8MnfrZhxxP4wRsHC4YXiVnafzTmluC9n7cf
 f7AXgrb9jloniILCQqyIZr26wbzVmpnpfjeQqMydSlMIrA/P8DpkR+Swh4LZcGurQOt0
 eLTwwEUM3E+lafn0sFtEoPwkVKBUZM62Uujdl03yqexjMFGvL5RVHllVx/LSSk6lp3Kf
 XBwCQWXqQkB2zPmOslLA62Qv2TkUKFwtksn4J1LOWTJBggP8x4h/u5osTYvHOuqckaWl
 G47I7yoNJjguA48Yv12uFAcY/rJ4VhSQc7D9PiHuZe2dMFYNUFoGI6yVMbTSri5CeMTW
 DSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784911706; x=1785516506;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/F2WJ4MAto8F8BDkpimqR2p/UrzdXFH6WrKtkJMG5JM=;
 b=fEYFNL6Bp9DSKga+cKQfEbTAnc+t3CvI9e0kmw6idLEP1wImOOIrFfuTkQwbgJ9Itv
 Yzc1sj1eJMyJcSsYGhCQ6qh/qhrdb4bcAjRrNmS6N+3mppYohQpb5sDGg1RNHGSc0LDn
 YR+yNlgU8Uuz/3LAraIaLJFfsGv8j1lpFSGRRGoLMzVbvrHi8fff6naCafvxpKfNIKt9
 0skHazVPPGk8BgWB3EmcQTkTgOUpeHKrXKi1AEGC9R2Sm2Hky6o4nZlQ6w+DKTW+gYEU
 6bW4vD/SEynEZHCeGqdJekI/g8qXKKxSyJ2eHXadaisR9jYtExDQaW151NwH+aO/lBls
 zD7g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLafslsmlGf+OQeTUBDr/Dq+FoqFg4BIZgi01mLxKx2W993zR/BHcg5oVz567Yz0nw9rJVAnGVPuSt@nongnu.org
X-Gm-Message-State: AOJu0YzdaDrFiBAmJHvVJPjIZZVsA9yBce0KelQuPVt1hHmhGGw1RSvk
 vvfOn996Haj3CRZLhHB8yY9UzySw3ZSpRuHaLfts6Pxq0QrnLnLIfacRTPynJc+GlxEkK9MMI3+
 W6/y7yhGJTt5ATyBZs7inhSZjRcqc6X5/+XsgCTX3rSBNwEXBB/QJ5rWQww==
X-Gm-Gg: AR+sD11tziaPzKsKs6RyxNY91B7a7YvzFQxnXg8WYugaazMla3isoBHOj0s7+AAfD5F
 klXrD7CpUQvyAFUI50JgPhC6ffVVDqoleP8W0AYT53axKF94bb1ZVYoYcSvd+veLT0s8PcMt6/W
 eMdutz2kUvFtX4SAGZoP2uCX5faux64//a6qlNug+5MzFNO7DbqG4+dhOS41OF9DA8Wt6gcjUUh
 kHiVFBxfs2cpS5CIrrVun/t0Trr5A/SWzNLzwGKTChmpIDowOeqJJll462HY2mo6Wuw//8baeHy
 hYFzRvpNEWZv+POtBWZRQ+YItMb2pOyenC6m1X4WnWCHtHKfzOmjQm3PdGHTj2H9NtnbVhAYBiN
 tSky5dtQ97nc5ZD4NWQR1hgBzv9jfGuPrgEOng2GN0yBhYKPZnDsG0AIt08lIEje7Cq/j
X-Received: by 2002:a05:6a21:695:b0:3a3:a9c4:3d60 with SMTP id
 adf61e73a8af0-3c44b0148eemr8966795637.27.1784911706505; 
 Fri, 24 Jul 2026 09:48:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:695:b0:3a3:a9c4:3d60 with SMTP id
 adf61e73a8af0-3c44b0148eemr8966759637.27.1784911705934; 
 Fri, 24 Jul 2026 09:48:25 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e1255sm1536045eec.4.2026.07.24.09.48.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 09:48:25 -0700 (PDT)
Message-ID: <9c278046-3b5a-4d0b-ac55-76a304f1109a@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 09:48:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix incorrect msg_l[sr]pid members of
 target_msqid_ds
To: no92 <leo@managarm.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260724160105.3787888-1-leo@managarm.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260724160105.3787888-1-leo@managarm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE1MCBTYWx0ZWRfX/Y8akQaHxGfy
 dyMmpYrdjYIq3ONMY+EHtWuL1CKiOrHZyvZ1K9pG8/Toh7vKas5eyeahLqC5M6sSW/gGYstWvtE
 0f1xyTzkbqBrpYPj5Lu2O4o1HtK10khGahaSZ912RHHy6DEiI4i8n9qAtTF2d+qvq3TC1VEQ+WU
 qyHLZuFqVcF9FGXHG76waXY9kl79hswGGogqAdX8/pmp5g4UPaZkBrwUB2p0yrbxVA+QiObmxFh
 n5viffRLfpWnasVzVQAGBTNrpFp9DfLAdxsbAmsYAEfuteHXpX4w0QTvDX4ol+WdvDGvtjt5U2J
 0VXGsiJFrpW5NYLGqqqPhfJ37UB27bXVIfvhSWCDNy6UHVvMQFFktDdz34ROwtYlxFkzWheAbUb
 1oqcVPf0nS2XCA1FJG8cNbd6O/Zzaf0kB5mSCVlrcK33fowzNpbkmGkpsILqEyZWjfnYGCj/ybL
 wYbXAMrPPUVcUs04Rgg==
X-Proofpoint-GUID: z0cf_M46J4jUWMLGMbcYrqvn6RHrKuQs
X-Proofpoint-ORIG-GUID: z0cf_M46J4jUWMLGMbcYrqvn6RHrKuQs
X-Authority-Analysis: v=2.4 cv=F79nsKhN c=1 sm=1 tr=0 ts=6a63975b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=QqsuZDsxAAAA:8 a=XpGoDWlJridapw26x8MA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=L0GjJRv8sWY0dH8UTALY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE1MCBTYWx0ZWRfX2bhvClr7YHoJ
 n0sWD3IJE+WvWzecNVlMbeuZDcmslQw/C0RJZzIZ10+eyV5akVlYeVpIsIB1md5ZuVYAg9GF6mR
 aWmVfxvsrDQDimI1d9rGuZF8vkoyF24=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240150
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

On 7/24/2026 9:01 AM, no92 via qemu development wrote:
> The members are declared as __kernel_pid_t in Linux UAPI headers.
> Analogous members in struct target_shmid_ds (shm_[cl]pid) are also
> declared as abi_int.
> 
> Fixes: 1c54ff97bbde ("linux-user: fix and cleanup IPCOP_msg* ipc calls handling")
> Signed-off-by: no92 <leo@managarm.org>
> ---
>  linux-user/syscall.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 3da5530d42..616d543c7f 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -4234,8 +4234,8 @@ struct target_msqid_ds
>      abi_ulong __msg_cbytes;
>      abi_ulong msg_qnum;
>      abi_ulong msg_qbytes;
> -    abi_ulong msg_lspid;
> -    abi_ulong msg_lrpid;
> +    abi_int msg_lspid;
> +    abi_int msg_lrpid;
>      abi_ulong __unused4;
>      abi_ulong __unused5;
>  };
> @@ -4255,8 +4255,8 @@ static inline abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
>      host_md->__msg_cbytes = tswapal(target_md->__msg_cbytes);
>      host_md->msg_qnum = tswapal(target_md->msg_qnum);
>      host_md->msg_qbytes = tswapal(target_md->msg_qbytes);
> -    host_md->msg_lspid = tswapal(target_md->msg_lspid);
> -    host_md->msg_lrpid = tswapal(target_md->msg_lrpid);
> +    host_md->msg_lspid = tswap32(target_md->msg_lspid);
> +    host_md->msg_lrpid = tswap32(target_md->msg_lrpid);
>      unlock_user_struct(target_md, target_addr, 0);
>      return 0;
>  }
> @@ -4276,8 +4276,8 @@ static inline abi_long host_to_target_msqid_ds(abi_ulong target_addr,
>      target_md->__msg_cbytes = tswapal(host_md->__msg_cbytes);
>      target_md->msg_qnum = tswapal(host_md->msg_qnum);
>      target_md->msg_qbytes = tswapal(host_md->msg_qbytes);
> -    target_md->msg_lspid = tswapal(host_md->msg_lspid);
> -    target_md->msg_lrpid = tswapal(host_md->msg_lrpid);
> +    target_md->msg_lspid = tswap32(host_md->msg_lspid);
> +    target_md->msg_lrpid = tswap32(host_md->msg_lrpid);
>      unlock_user_struct(target_md, target_addr, 1);
>      return 0;
>  }

The change looks correct in itself.
Did it expose a bug, or did you found this reviewing original commit?

Regards,
Pierrick

