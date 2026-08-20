Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6114AC5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx7u3-0000sc-VZ; Thu, 20 Aug 2026 14:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7u2-0000s8-4r
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:54:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7tx-00018I-0a
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:54:10 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIIsBX3705812
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D7NmhovGnQ+1FWVwuQ96Mfw2QdHciPfd7f+vAV6SW3I=; b=LPCLeBSSh4AqHq0k
 DgV8awuzzYgbsJ6z91JBNbXHu41O5PtI0bwy08QNEp9I4zpTkgLoBzrMeqVjCwim
 kb9ZL+X86sCNzHBVGhUrRCpFOvT1/CNeU1nRj+28Zr+1ifHNJwL/0F/eoAu1l9Q2
 LCoSt72vN5/eDFt0wkJvq1RIiMIr9rwqS2wUEIEaIE7jWPjADyEkT4JqMB4umxPA
 aJT40pn3zE/We5c2v76egDqCxixXOd8uTv86wa0Xuh0P3gU9zE5AMdZ68nSAUFAS
 36AVjRh1/MTzcfCUP58BT+mk4OU8c5LmJSkL2MrmLro1KpQGgobWK3RCtY7pKYHR
 K8OMVQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7u72c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:54:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc73f47bdcso2333725ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787252045; x=1787856845; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D7NmhovGnQ+1FWVwuQ96Mfw2QdHciPfd7f+vAV6SW3I=;
 b=Q7VmIDZDU8iRq199zDIEYoS5SG03a0oGiWV59WCMDLaNXsQJT8wF5/EdVwTcfMlANi
 D8JYQmGFQU4JqHDrSlkQOgVgoLWWNwRLgxL0HxVK0EQFbA8L9dmRmFXrI1HlpGoFeQrW
 SFUZJpIpIcm5g/DbjxDQAhY5/Vmf3Srk5eps/C6xExIeZsiFbszPRjO1vU5j1ll/dO92
 AK87tb4MD7iS/SYxby8aTPFFEdUBN1nEyQ7inYcwLaebgjO9dDbHVCVsNzg/IFobB0C7
 ix5IO+EhU5UOe1OLtTcXewKpRs251ndIU6rNPvZCgty1FF+vYwLp+V4R1us4kBFQJbMh
 CHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787252045; x=1787856845;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D7NmhovGnQ+1FWVwuQ96Mfw2QdHciPfd7f+vAV6SW3I=;
 b=NnIdZz9uXOG8bKOQQ6lHQyul3CQb9KwytCmmAdUKNzb37DbrBNQDvHS59ow7HaVjSg
 3jYxvFWe5FZt01ntCiMnHSraBNKfh0CarWq2fwwCs7ik0441tS/kdzuxMaFRbEQgmXnj
 UWbtiZD5PLZoU4PcmNzleA8H/bOgOJYNWKUoXU5Gh8gaW8cf8OFurJ9UVUtZzJoIq4F8
 KFnDIlOJ2OkCFF6j+9H/F7dIjiaLrDVm6jcWO0Fn9/imTmWEpvOmueJ6aSx7eNq+Qgjb
 zGDQnZ5DFh14zz/I+KyIvNtd/hnAf4ij1gzyEIPuYw3NKBVyXlvBNUKvjUFX3FMpUVAl
 jiMw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHqz6n7dMD4sPzJIyJTiFsn8rjmW07Z9R0HL4QjPzXWrBvJ3YjsRPqtHznwl2ur6s7WpAl2gXDq5BP@nongnu.org
X-Gm-Message-State: AFuF++mhGYfXzIJ3Eopqwy21M8LSqULkBmJr6SUvJDImLTYO4EcrRtwu
 utkuLF2Tw9aYyuVy+vBV/ELqLo5sjcoXCi6bupmMqs1Q67uScR95yGgjW9JG9DBWBmZmm8LRaqS
 qtlHQ95OYUjZVxqv6ViFgjbxKQjXB/IP/Fa1fyX/qsO4/ljplrzJdoal0Dg==
X-Gm-Gg: AR+sD10FCp0/naeihn2TytnCe1DgPBrAMSFdn7lvdVNUODxvqYxxOi2rFdrOG+Xc2SS
 4TuSvT/Udufm/L2gXrpeBOQnac70hpvUlDkbzw62qxzlUe/2rUQUk+ss3GFIrgmBEd43C7Dj9AN
 UleKdeFo3p8REGD6HPkjzPOYlN2bnMJ8qc+ERIh7O/g/WC6mn6DPj8H5J5Lqm9Ce3xnbkfkzhR5
 noQ7UauNSHcCFXe3OLCMKPIY8mzWt61wzcET2PTE4GZWIG3DlRvthfiKiLDKMK+2Lhq5OeDKRdz
 eSFsW7xZWKKJMJnkkNK8nVdREdtacKhzUxcvZ72IWtLV/S7FJrReko2apElMXsASKiAdMcZE6cp
 3XvcIkkGbw9cT3eulXvUUHdoS1TSjxkqaRihWBh3BZWzKRvdgfcoGVg+6NWU2JsSrmdCS
X-Received: by 2002:a17:903:b07:b0:2cf:afe8:b722 with SMTP id
 d9443c01a7336-2d64afe960dmr13754305ad.11.1787252045249; 
 Thu, 20 Aug 2026 11:54:05 -0700 (PDT)
X-Received: by 2002:a17:903:b07:b0:2cf:afe8:b722 with SMTP id
 d9443c01a7336-2d64afe960dmr13753635ad.11.1787252044870; 
 Thu, 20 Aug 2026 11:54:04 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327c3fc6675sm27402760eec.13.2026.08.20.11.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 11:54:04 -0700 (PDT)
Message-ID: <7335f952-1355-4281-9752-b835d5c62eff@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 11:54:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] target/hexagon: raise imprecise exception on
 multi-TLB match
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
 <20260819013144.3264096-9-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260819013144.3264096-9-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0MiBTYWx0ZWRfXw9heEebPhxbd
 Pn0tQ7n6bTMekphS5RNXYt57NxuTj+LQvXzEAUOkS791kQqQ46PC1SPry/5Tu22qJ8BQgypCeiS
 YTVNpwrfxHFBdikkN3SeHhOnGooUSwPtwKTUoXTRpUxcX+O73/5ODpnZ5I9DAT8YlEFDUvjINBP
 Jy57YQQIzT0V9NNkyYw/XJbBOIqk2F8dj3SUwn7z3gC2XY7XcsPx1lgZGnbCRHbFuzUMaPHw41U
 5nwjmfqVuCp+QYri5bc3E+tnLtzBI1AneDZu/VrGlVlSK02IXpRtUUowjk4C6wkfttGnz3GsIue
 HQwWa6jaDt+lQNbwH3nKk92Y0k1xEk+wF1wSJZkRFRfQyE+NlG5UazYrTrk9qawmdD1kxq01dia
 6B3ZtkFssI0k3dS0jJBbqFq6jep/tZwmK2DC5ifgUbu2x5kiCVcDn3rUKsgHNacHffqwmREUrjM
 IO2P0eH6V+Y5pJodG7A==
X-Proofpoint-ORIG-GUID: HN_HcVmhwmETv79JJJf6N8KeGF1wt3DP
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a874d4d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=DeivO_XxE0YWQaXYBVMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0MiBTYWx0ZWRfXznz8/VBMgLYI
 OoICj+SIpG1hxYDNiEhhfgO03IxCxS4RAMCYFQ7iVkWdXGa+Pf8+gA9573gTilrHXNiTYk2ZJpv
 yFgKNHCeOd8XVO8ynWdz9JtO9g5HUVE=
X-Proofpoint-GUID: HN_HcVmhwmETv79JJJf6N8KeGF1wt3DP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200142
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

On 8/18/2026 6:31 PM, Brian Cain wrote:
> tlbp now records a pending imprecise exception (via env->imprecise_exception)
> when the lookup matches multiple entries, and the translator raises it after
> the tlbp packet.  Implement the HEX_EVENT_IMPRECISE delivery path so the
> guest sees HEX_CAUSE_IMPRECISE_MULTI_TLB_MATCH instead of the exception
> being silently dropped.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon_tlb.h |  3 ++-
>  target/hexagon/cpu.h             |  1 +
>  hw/hexagon/hexagon_tlb.c         |  5 ++++-
>  target/hexagon/hex_mmu.c         |  5 ++++-
>  target/hexagon/hexswi.c          | 37 +++++++++++++++++++++++++++++---
>  target/hexagon/machine.c         |  5 +++--
>  target/hexagon/translate.c       | 29 +++++++++++++++++++++++++
>  7 files changed, 77 insertions(+), 8 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

