Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F2D606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n7dAzJ39;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F7880W7R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLloB-0005ZR-CH; Tue, 27 Oct 2026 14:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLlmf-0004sO-BW
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:20:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLlmb-0004Rk-MW
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:20:28 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHPxw3553884
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l/eyCz6OAbl+DS5fLuIlzjlbpRVKk1BOYI/y79dV96Q=; b=n7dAzJ39aoyMybfW
 C8p0Iyuxi7XkYk9D8imsy4nxniqVV6zmD3azOUtVTBNpRVV+Bj6JvpCHRLtFWtdT
 JVGkhz4XbmGEkyJIXpzbeXgndVngtQhudEfIzH8+eA+aXhuCOFvXXZM3JC1zpkmH
 ky8Wm14wDzko8eTGd5CtMFZB8m3oUG4P3tvueJCIPIOxAKT+RBeW2cNik6V4wRDW
 5nbI1ZAalZEaZrE1Zl3YzVdZ96aWtf7jhURrIvQBv+WnWnJl9e08lvT5x0QFAkw5
 +3ufaGu51gktQtnCp4NnKbugB0rHh9IXxkBxaD9Z1SnTJN0x9HrJvgC4cIf7Xzpc
 OWb86Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw22ngp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:20:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f13c143c8so8951885a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 11:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793125224; x=1793730024; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l/eyCz6OAbl+DS5fLuIlzjlbpRVKk1BOYI/y79dV96Q=;
 b=F7880W7Rb+hs8GKGCeSkvrMIOvuMLxk9jtabgNJBprvct+gW+VeTvweDv/81M/R2Dj
 Jw9m4D/1eqqojgVMMlKjBX82sk+5rrd611qIPc+8bcyhoZCd3NHA024Um1IZU/iFGD5z
 X+sUzwZ80CEh7lZE0GfS9XAI7xMzvO2r7PfTFxb2JwhCv/oR1pzhCGyB+umnAU1XgUza
 GDb6i6/ryCz21CbLo69HA7cH+fB96jRCg0d9no+VwAxAOSzJcu75S5GADYQTMS04AT6h
 2WdI3+4WE0M8VM5hw1BtlEuzyVcqivIUwT2oH8XYP6xwHTZC8xQmfg9JEhvS30POeuK+
 djpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793125224; x=1793730024;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l/eyCz6OAbl+DS5fLuIlzjlbpRVKk1BOYI/y79dV96Q=;
 b=T4TjlzWGsw2rziRVZJdEx1ZFArieVpsq9Pw+9mMjfJZRT60ma0RKyMMxtBSP35xyuk
 /5+yoqZM+3M6pXpZy51bFLCmuGPjOOJDSF7PEq04dD68Yhq2/RO0zSeGA6Yk17fmZlOR
 pYxS4sxDFzZSpEQV6Lmrya8agZuNjURQ7Di3KiM2mIYSRcmLgW+4AHrL3zz1ufwoL07Z
 d7RZzrzgWZqFMkyT88ZDpvZkV9YLrGQBDOaAbRae065R39220EjDEbpPZlkVryYIyO/z
 0MZFAagFabmN3Sa624lVX/AqIjyG79NakpVSoLEhIeK/UVBEfjSCkZvQt+Vi+4+pb7uY
 DGAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwe5nwb7KVA0LUCyxnfQbjVIW4ddo0RN7BqFpBW9YdBOAbyUPF0K1HrWrqOVNoL73gKvMgn1+xi/zBR@nongnu.org
X-Gm-Message-State: AFq9FYIp5NP6Xnq9ZzS7uNzEY4cIfpSfMWGLg+AEDoJKrvzvcqBNC8/Z
 ROslDEVnGaXvrxvofBnd9xw/Er5OekniYoPdCYjgq7cd5A1IjW3zESp0LT/xdeYIcOkt2+Y2fEr
 E8oB87v0hGGMut3lJUoyuluEeecSUZGFH6THQOIUdDBZ3fQzGR38i45hEbw==
X-Gm-Gg: AYBFou1g7XGcuEk9eYy1689wVUEgd8N/D67zaFkwVfXSyQ+q3UuB+76VuS3oTfAQcZB
 78lZMLwS55AAQeXV2JaVIFTTY8smfQf6mWRIsZy4yiUBkPNfZBMgHINxC1MpFeE80gSg8gG0d0o
 1VYWxNmwGsvz2Hby35iDtJ/xR11k8eu1yuj9cwiC6QBIlAzrC/w7N6gQRMNis/XOY8iSpZuSLDI
 mvmFUQIHKPQ50CdQIpMr6ga35nT7tRQEYeHDO/niE6cXx5KCUU/WP0Ed9KNPaKnb5Nnqa2Ez7wm
 XGrykbva/J6mw1hgOuQq76Qp6NMCytBzrbuX7SULl565JD2buaJuy5FvgD04pdd7ynWwYqbRiTD
 setMuJ0QiYe2FedCCXx8ix9vr4Z6yZf/g7Lo7lzDxm2N7Rr7FYA==
X-Received: by 2002:a05:620a:a992:10b0:943:faab:aabe with SMTP id
 af79cd13be357-943faabb32bmr278236985a.62.1793125223719; 
 Tue, 27 Oct 2026 11:20:23 -0700 (PDT)
X-Received: by 2002:a05:620a:a992:10b0:943:faab:aabe with SMTP id
 af79cd13be357-943faabb32bmr278233285a.62.1793125223141; 
 Tue, 27 Oct 2026 11:20:23 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd48e0sm24775219f8f.38.2026.10.27.11.20.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 11:20:22 -0700 (PDT)
Message-ID: <02d394e6-eafe-4a3d-9f63-61b639267aa8@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 19:20:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Junjie Cao's email address
Content-Language: en-US
To: Junjie Cao <junjie.cao@linux.dev>, qemu-devel@nongnu.org
Cc: jic23@kernel.org, mst@redhat.com, anisa.su@samsung.com,
 linux-cxl@vger.kernel.org, junjie.cao@intel.com
References: <20261021134307.874867-1-junjie.cao@linux.dev>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261021134307.874867-1-junjie.cao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MyBTYWx0ZWRfX9dEVaS5q8xPy
 OJWthF/2O+Ssdd7Dk6u26FyXSYFuNmlMRwOTWPcLK2/JnshgXO6rHEMnUy7tZ+lJBfFCoFmOM+r
 BazXm5u1YoPXAzIFTmza7Zm1SaZGtmbSAhU8woWAZEP5+lqr9//tOsseR3YAwkzcVu1GWnIk+Xn
 NA00jF6xEdD+84Nv0I0JJUTFI2ncXLRTkI+TWexqWu8Z/SqXzwh/XqBz3ShYicKaTIOm1c2zblN
 aK9vUTou796S/rAf5HXGT3tsjMGQ+2c4cFLnYkV6AWbTLyjjx20Zg4PHgcNk9EBe9Zg9WohOp9c
 jWT5IidRs0fXiJeaJWOhI85zhjlpJm38EYrFEugy6SD+vtnBzn8Zi9OHGKOE0T2uIRg+e2V9Y3X
 pFcOcUKs5Crc5JKL+629jC5jzJg26wEmXT/sesPCqCY4fjT9ZsLBu1eyKPubUokOvuIji/skIT6
 e5qb/l6VXcnpHIN9jcA==
X-Proofpoint-GUID: 88h8POu1OYpz5AyBLfq1xpM8n9AXd6V6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MyBTYWx0ZWRfX10cCr4Q96YJ8
 ATX3dFUvnXCD/kf0MsqNwkyHv9Yynlk8INWAypqD6YKFBwFK3ynGN72YB5DEni6VjP3lV2I2aS7
 deD03xvrRO/sF9Wm0Spu35iEmTf9CpM=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae0eb68 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=hD80L64hAAAA:8 a=njIK7alONr2zF-bboPIA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 88h8POu1OYpz5AyBLfq1xpM8n9AXd6V6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270073
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi,

On 21/10/26 15:43, Junjie Cao wrote:
> Update my email address to junjie.cao@linux.dev for future correspondence.
> I'll continue contributing and reviewing CXL patches.
> 
> Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d9209f043f..2b78316436 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3370,7 +3370,7 @@ F: docs/devel/migration/CPR.rst
>   
>   Compute Express Link
>   M: Jonathan Cameron <jic23@kernel.org>
> -R: Junjie Cao <junjie.cao@intel.com>

Could you Ack from your other email?

> +R: Junjie Cao <junjie.cao@linux.dev>
>   R: Anisa Su <anisa.su@samsung.com>
>   L: linux-cxl@vger.kernel.org
>   S: Supported


