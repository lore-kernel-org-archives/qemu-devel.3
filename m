Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5717E606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bVvcMkIf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C21FaS3l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVYNn-0004Cy-7N; Mon, 23 Nov 2026 13:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVYNX-00046u-5T
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:03:01 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVYNV-0005Rl-Aj
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:02:58 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGGmX33025324
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 18:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yKmUh9ami92KU4Yt9k1JSDAQL60SxtrLBxqgR9BvSZ0=; b=bVvcMkIf0GM70XUF
 MXe8kHZUjaZg194v9tjuUUTL4DjLRsrZ4wLcwsBXOkWD1+K2LtTm70aND+jzBBIl
 wxf34OXouXdThFhMUmQA9uhlvIhExnhvRgK8HNT9gfj2jRAD7tmfmaWvV+s3+tCc
 73QNU7Bm3kqf2E4zEpky6uuFBG99/efMwuZ4/h4HXMpEA/uvxfxupmC//QwLg1bR
 iQzWJTLN7vs/2IaGJY+LART1nBY2yzZitCNZ1FHTFRWh3oVtmmdcYuyGjvtwvx/I
 AlxOlwi79De1T8fVZ76u+NtT0M/JUG0Dt9uGNUhtnJvq82mqsFgJ/dLo1NDPD1vi
 JxEX7w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1par6q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 18:02:54 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33713e5e6daso6496346eec.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795456974; x=1796061774; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yKmUh9ami92KU4Yt9k1JSDAQL60SxtrLBxqgR9BvSZ0=;
 b=C21FaS3lBZYPYMiWAMpl49TBnPwIuzo1Ur6XGmCuRzxb6Kc231gxFBaJIiupuEbrym
 283WT68EwfAyOuLOuvFhHh3WFZXaidZUP0TZPjVHia5Wsqst13Qv7h9mH04T4yslAfuY
 W0d2CYCAPnUvV7m3sDXbTQNdaRCTtZg1JiypZpHvkibH2uwQ+M0GCFKpY6fFUlFd4b4N
 w9loLLb2YuLB8D50t87JAvi/bMspxn7fhoKMbEp5jP3FvIFVU09VzqDSCoaRKoDlBMQp
 OtsLPs3yOy6ZauHwIPwiHOOy4JZX3nPBfvsZQGJSDDkthyeqbxdP5uvytUUuVONun13m
 dS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795456974; x=1796061774;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yKmUh9ami92KU4Yt9k1JSDAQL60SxtrLBxqgR9BvSZ0=;
 b=R0qpHgWGpciCUG8CZkvsOTw3sx+tMXHAM9e/9T+pgWfcTRAVa2vtnDTe7YMKYOmNY7
 X16/hEmntX2HCguM0ZDIdTJKvjnrld51bouqJ/DicjhYmRL7puz96s/A7qaolLwy9Yb3
 tcDd/EZlc0ru1twb3ohpaIsWFhN5j2UBaqqN09/WBr4DQkpTuW/iZ1pHAsXueWv1iWs6
 TpUX4tYWAXRnm/pQJayocKAqAfIpN39tma9ls4Zre2Hi+q1zabpaiP95ui2yVOOvTTc3
 fH6x8nGJ81qiD5XeFbx9vosMYiAqO94yqfpvz/LS+6PQMctGp3UvlazPN4ejEvqUyhav
 ZVKQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE+SBptfg1mjIL+/OI9vyVYbK0OMi1v+mwInFyBWCCS8glNuwLRF6xpqm7XxL7xgZgeCTixQ58Qkzg1@nongnu.org
X-Gm-Message-State: APuU4Z9reg+iiisocREm5r/cTruFkqOHf0A27jDzxykuo34ahQ5VLrNT
 5l9XvoCIpudKYx73obNXVo0l72R/dPMsoc5qqmEJIm+BUVLngYlewyyE9on6F1MjZ6C6QwOiiHZ
 sXVG5PCe1gW617sdmQLs+dbHs2FtS8iyFK6st0ygtIigdyuA0fDYDs0HdEg==
X-Gm-Gg: AZFdTZejXZXqEH+BuvaT/DJh4qLXRkflfUtlSFmi7oQxHKazLGI3Cqd657Lm9RyFlAr
 gUTgCtWh47A8HmqxuRTIP+QUo93RoZn9FhTkY6PiYcZDQq221k34cW/H6NUtummgMmDDVIjiH/+
 eYas7k+2wKs3bkV9elhguPhtZySjq5GMHSxKH4772G1V5XeYDYUN2aWVwpDORf4mJobhw9kyW33
 4PIhXvr7ujVOzeFe8ipLMVVHwmJMyQWBO4tCOdb3F3l/UwZUz3DdMybL7YgbSWx+L2V4bBcPMlc
 UKC7khLwtvw8u+hjCT7tGCs78oknxQpLd+NKHRuXaidhoeYZpoE6//L06eJQcoPrxeFKk/AVv/Q
 dTp3VLmevFV6KgRZfjuQK7gFjPH/j7mSMpu4WIwSJ/8UBedRirp7KMO3e7ZMGV4VfV7Fg+DT45p
 yWHU9O2TAd/+hLB0XRCbRwC7zm1oZ99XKVIcho1HbJGI8=
X-Received: by 2002:a05:693c:8390:10b0:36e:d060:8bad with SMTP id
 5a478bee46e88-3856c6b3245mr14441423eec.5.1795456973891; 
 Mon, 23 Nov 2026 10:02:53 -0800 (PST)
X-Received: by 2002:a05:693c:8390:10b0:36e:d060:8bad with SMTP id
 5a478bee46e88-3856c6b3245mr14441389eec.5.1795456973249; 
 Mon, 23 Nov 2026 10:02:53 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567daaf70sm39516469eec.28.2026.11.23.10.02.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 10:02:52 -0800 (PST)
Message-ID: <e2002096-3dcd-48e6-9b3e-4fba96222894@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 10:02:51 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 v2 06/12] target/hexagon: take exceptions for
 cache operations
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
 <20261120182031.560481-7-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261120182031.560481-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 36f4uVDOvnkZlC3XaGR1QrXLf7VtdCwM
X-Authority-Analysis: v=2.4 cv=K+O3jCWI c=1 sm=1 tr=0 ts=6b047fce cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0VtwvS1-_wHwKdXkx1IA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3MSBTYWx0ZWRfX2Kp2cLXxYatC
 p4c3vTL2LOx6l1SMAHv9HEkO/2K88+hLVf/axBcRMmi6q1ZI3i7Fz6+z/ngrmgptpUZrwAPgied
 U9FKS6z+4ba1gNpPLzT8vQEKmp9rVrc=
X-Proofpoint-ORIG-GUID: 36f4uVDOvnkZlC3XaGR1QrXLf7VtdCwM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3MSBTYWx0ZWRfX8jEzeH2kR2G9
 RHUAgseFQ1nhgnzwkeckarJHOWrPc0tapOKDHabRagqj1SSqZOSW1KtSsOIyBIbg44wMWwWatlH
 wyiuaz9BuafpmJBcskxdzC6RNdxhu0yceoLPqzC3F0Vssbaufp1yFai4sXRGojyERL7qRxzARVi
 LkqGCmwmj1TULh3pplBN5Z1FzNBoL6lhthtU45EEZEO+1DrDeruO3bA30oRZart499Yxwk8ntks
 beJX1vTRYe3lneWSq8GITWhdMtOAuVLyXkdMFHDMJe5hcn15Q0XirrDPhCdpO1DLMj/mVDUX5zq
 XeTUuP3V3cav1KXxC/f6SI+sr7DGg6V6JPko7dbKk9MjPA5T8Apql+SiDmuKVMLiCPOWk9BSyCb
 TiVevoj/QYhYUQuvIZiL77cR4+gk0BMW4kgqiuHR5vI817iVLCXq89dGVitf1wM6+4Y0rca7VXg
 ju/3/+jWOkGh/NEGyVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230071
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

On 11/20/2026 10:20 AM, Brian Cain wrote:
> The dcinva, dccleaninva, dccleana and icinva instructions did nothing
> in system mode, but the hardware translates their address.  A data cache
> operation takes a TLB miss exception if the address is unmapped, and a
> privilege exception if the mapping can be neither read nor written.  An
> instruction cache operation only takes the TLB miss exception.
> 
> Probe the address through the normal TLB fill path, which also reports
> the packet that faulted.
> 
> This enables the mmu_cacheops systest.
> 
> Link: https://lore.kernel.org/qemu-devel/20261117183629.2002840-7-marco.liebel@oss.qualcomm.com/
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg.h                  | 18 +++++++---
>  target/hexagon/helper.h                   |  2 ++
>  target/hexagon/op_helper.c                | 42 +++++++++++++++++++++++
>  tests/functional/hexagon/test_systests.py |  4 +++
>  4 files changed, 62 insertions(+), 4 deletions(-)
> 

This looks like new feature more than a bug fix.

Regards,
Pierrick

