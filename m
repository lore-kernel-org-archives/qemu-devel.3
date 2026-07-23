Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDB7C44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmosD-0002kP-73; Thu, 23 Jul 2026 04:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmosB-0002jr-8d
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:33:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmos8-0007Nn-Iu
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:33:43 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N7Bg1v3434656
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 08:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SpaN2BKQIcV0rZMXSnufz+Dkcpw6RRJYHQYqA0DDH9M=; b=aIxRWlXaDf/JMeJv
 9tEB/Iiqkwpu+hagfAn2wGi4aeVmrj3PtPxHJ+/VbJO/opVVRo4B7Lj4lYykhUXG
 ufSP2Hv1/WFFMvIT3AjVm03Il2JY8NWBNWOK05bzJrLelWCNqhe7Eim1pl9cYl2R
 wsGqaFz5N0U2xiGBZkQqx6gTxt3PjQanpzCCIBgi799rr6H7wctFwOAV2yRP5Nve
 cmyH7+l9DOJ+L3vmg+VCVRSPrRkD0Hy1cFMfbKN/f8TTM3rLpAbENOkylZZqP3/5
 6pSXaW1SpqrFsHSMwD997+DM6nFeJ8xsji501pVPdtjUfUroF2GwVNDv4+70yTOd
 TOX8rw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk5cc29ep-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 08:33:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5276aa86d00so7153511cf.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 01:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784795618; x=1785400418; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SpaN2BKQIcV0rZMXSnufz+Dkcpw6RRJYHQYqA0DDH9M=;
 b=J0QqFPktKjKQcxQd1mWQVLPXCljg01wxhB06sklI7sy29ogFNLwNEekOOK7aKeKSRD
 PVHLUErX+4tIN2FDQAHDe+S7JRsVEAPGDx7wud7uvz6+sATxHYAxUN27tDbfticmHb4x
 b6Cz2R9W6FvZ+usVsLZ7x40jw9w1Uzcm4um0/eBuWkct5vDGqP2EXEM+fLlgRFqzgdgq
 co4xAUmePXgNi7Bp4y+EpyBuaScRsBBPEZGn3Lj6IoDyYqwfLYcKL5T+htqa9weYZJ10
 KwbloC0VtVwwsJV6ZLX6930tADk+CSzd86pD5W9p3hZnlprZ+syFkO0EpZsTI8C3NY6r
 lOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784795618; x=1785400418;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SpaN2BKQIcV0rZMXSnufz+Dkcpw6RRJYHQYqA0DDH9M=;
 b=oFpFGtbdUEg/kEzjwTwrcqdTpr3sF4p4ILKPIpuA2XvxBCl/CDeXUpX5lFoEH5wyFC
 YjUwXdNh4tz39MO1dKq/oc3Lr79RUxJlODmZr9UpSGNjwG91z0dSahGLPtFV/7i+8Za2
 Mq/yhxtRZknDVZzINnlYawakQvf701uAGS3veghfMjeEefA9/MhUwc3s8rp++bf5PXYl
 2ypp2bZQb9Ynu7MIdwu60CcZXeKVg/MKLtuZ1RADJjDuLdWWgRJOsGtMSlIAVOPX+VxA
 UWQ7pUrb4wFN7H1jwEmbF0sxqxq5aeZ/sodiSKVkurhEuyJMGirQTXQSDC+SVUp62HGX
 6kGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrqj6/8S3qoqk5SRKeOvRiGpDHuN5xU44IP1KYqSz2E3z6nj17ZB2tf9XovNc4hu7RdV0jxxEXcriYf@nongnu.org
X-Gm-Message-State: AOJu0YxYJUXCpv7F4MC7f+R9sYCAk45SuWza/+RhzCdt1oIPVm9X1+Qc
 1CRzL2+DFuRyJZk4VzbS+iciG04Yymh3PO4uZPhVFgpQcTWXz4fafv5I7Db033goAFXmPwBFrXM
 u/z3AQgxxNkdM9Miyj9Y3U0b+bT6+oSU5/sj+sZkTVjSCRj+35nASEMnt1Q==
X-Gm-Gg: AR+sD108CrpQsjLNrEI2I3EusuX4x7JK4NS3KNghOOntxpckn5434yj6h2YqPN2AAUE
 1akvs00+ZA/N6eXqQzMuY/i/uV0zWbVy/TC9tWrfxZsSZRrl0sgB6EbfBoKswAjagU/0lFy/tCv
 fp4SrIo/r+ipT8Hl6MLSLLPsHYF9AUd7fg5HTq/C/azdFzqgPwVcqHw9gOlW2I/UmE0P6nFiM4b
 cwHPzPaPyOxVbbEP6xu8u4/DzSKRiJZwkVC6yCFKchY7Ta8p7Z4ZbEqAVWTWQ+TlJXIQ3Wzbrg3
 6ZqYM1cARUlWF/p8jw4PJEhDs2Kf0fCtkcKqcybl8O1QZFJ0sEerNUVHMWgT9QDZy2Sd+Xdl547
 kHSKbzuwWaLIS7lYEsdMLGlUhC7BdzlRMEN0g3IP/sr4PnwcPDvw=
X-Received: by 2002:a05:622a:2a12:b0:51a:8c9b:649d with SMTP id
 d75a77b69052e-5283df77456mr16861021cf.65.1784795618089; 
 Thu, 23 Jul 2026 01:33:38 -0700 (PDT)
X-Received: by 2002:a05:622a:2a12:b0:51a:8c9b:649d with SMTP id
 d75a77b69052e-5283df77456mr16860881cf.65.1784795617657; 
 Thu, 23 Jul 2026 01:33:37 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5d9sm12856725f8f.5.2026.07.23.01.33.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 01:33:36 -0700 (PDT)
Message-ID: <e7d3e9dc-be97-40f3-b426-3e93a242410a@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 10:33:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in
 gpa2hva callers
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
References: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: B29VmCMZF9hH6A2smup4_wAtYSwx21Wf
X-Proofpoint-GUID: B29VmCMZF9hH6A2smup4_wAtYSwx21Wf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA4NSBTYWx0ZWRfXyJf7tU3mc3m1
 Op29e0mj5W7XOLJefeozWy+kS9Puokr+OayT+ScVmq9wgq+wsKSOJm3BoHvTa+o/XZ4MFIb93iz
 oxkFrtyfTcuM8Gc1zjfklcUOTMsMy/w=
X-Authority-Analysis: v=2.4 cv=L/ItheT8 c=1 sm=1 tr=0 ts=6a61d1e2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=27Jx0McfqUJ7E1xIHb0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA4NSBTYWx0ZWRfX1he5gRcAN6yQ
 AyTmaH2tycT2U0lFahtgag8YNk6y5qWsKwPe0UvNwE0eRg5fbO7GEoNCxkWwBHwDdPeHL5QRgLv
 46BcEzDS5yXOjJm06pg/HfLYs1P9p2+5/xga2ItxRFY/Se3rWUj5h/bA9Fu66509iAnGemtMT66
 lWkExsWK9xaDVTva7LDcFzBLRGXx+14DDAzPKfWfXRb6PNZy+0sNJ8/1yY+OrVLCAr7ppLlxinV
 nkleNgn7pTKeIciqVkp/VWCFVFB1h1KPnPGZy4kQWuYeTlfunqWnDRi2edgkeAWOHTSbObh48Qy
 W49oP7BKP4QjxiD3IbBVpYSEondZLgRktmCTwsDUxEaNfjnBEzV9Bs9EUAyD8ubgmrT58i//qnW
 Dp88d8JJzXilftZJ0PfzGeK4G2m5UgL4+cpYbQ6gEcr0s9Jcf99CAIXUfzUBDLhZXURpt6ysE7s
 0s2QheTlWGbaVYEJpPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230085
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi,

On 21/5/26 16:54, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> gpa2hva() returns a referenced MemoryRegion via its p_mr out-parameter
> (inherited from memory_region_find()), but both SEV callers were failing
> to release it.

Comment orthogonal to your fix; odd to have a non-monitor code
call an undocumented monitor method. Should the method be moved
out of monitor/hmp-cmds.c somewhere into system/ and documented
(likely in system/physmem.c, also moving the declaration to
"system/memory.h")? Besides some day we should be able to build
without monitor.

> Fixes: c7f7e6970d3b ("sev: add sev-inject-launch-secret")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/system/memory.h | 2 ++
>   target/i386/sev.c       | 4 ++--
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 1417132f6d9..53f65a224bb 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -1343,6 +1343,8 @@ void memory_region_ref(MemoryRegion *mr);
>    */
>   void memory_region_unref(MemoryRegion *mr);
>   
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(MemoryRegion, memory_region_unref)
> +
>   /**
>    * memory_region_init_io: Initialize an I/O memory region.
>    *

