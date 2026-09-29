Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66787CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBd0o-0001eW-AQ; Tue, 29 Sep 2026 14:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xBd0m-0001eG-1Z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 14:57:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xBd0k-0003La-6E
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 14:57:07 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68THgIZN3300548
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 18:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mbEYwYSz+q6l4frroQQiH2DpwITqHWZ2q2m9qgRMFDM=; b=UeZKGOYbJYZ9s79n
 L+WHqKHE/iZfZwC+GSUJ4fQS8/tdnfhh5kyTUhdKJeR+0JY3OX1p9EFDwCdagxIY
 9vxs0CLML7ZTqnrgh/+cWd1JsyrvaBIpWf6MNV30JJrF440zL9rsFlvdIIaStImz
 fRUJxalBr5dtNJ69TPRaOAJr9LSG2i+0+8RxSPJmg3mWC+/WQENO2TH7otqzjLgD
 cFHGmpeBfC7zeIyAZcyvfNodEmu8v0bXuVmzccG3vHhDlApFnwgwEZ/b6xBMi1Nn
 nOs/CDPBTS4KAKhlS+C1rv508zZAZSbGKRP4MDoVhMxRgEraxWETJX174k1b/TcX
 u/uSyw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0dsx1q5g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 18:57:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936708f129aso911040985a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 11:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790708221; x=1791313021; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mbEYwYSz+q6l4frroQQiH2DpwITqHWZ2q2m9qgRMFDM=;
 b=SwfqExwk9vUwa4iih30xL9+Vc053sm1em1BdzukLouxFLUqBxe3G+5pqn9kCqaiEeS
 7w8caG4Cd5ZiVbXfM87FYDUOBYz2N8Yp23SX6+oJVCFJT/OCgVZXnnxJ1HJe0fpnwe08
 eiUI1gelXZGQZv+PUf965dt7zWB3qsbkOKX1uhVovmZ2WDjofFn7uE/ufmSoLqpAqlTz
 v3eenD/bU/gwXwHF09oGIUBY01MDAVA1emdh5o9fCe+buhOAgyskOfWt51qLg5m/GmiE
 zb8T7kTEpLCZYiiabWvPt4q7yg/BFfhVww3MLX33RZ98maTv9lTGOjPYWZfWlmZOWkg6
 Vsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790708221; x=1791313021;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mbEYwYSz+q6l4frroQQiH2DpwITqHWZ2q2m9qgRMFDM=;
 b=Z/ENuGGbzUo1Lm3+rHe2Q74goFZf9J+25RwCEr5WinEwkQIg3jWYKAwqlOE8mMdwXr
 udcaqni/HKzHgER5mcZ8N9bXjqBIoCooAvVg4mqML5UxUhSdSWvrlhtdpOFM+J86WRS7
 FOcDsGMoq+y8VAn+uoyq2R44gayL9iNIh9kvR4AZ1ndoZcRHZ3YqveoRNnmtypmaaBmW
 4s8v+zNpKDgjOpG5DwPrNS1uGwCcbsUDu2YBW0T1u0ZvfanlSfShIfqm0ZX9OEaGnK5i
 BIXLk17oKwwq5HPnobLXtAc68WgguVPgwvKdZVmkv+Qr7S+Nk7Kg7OG1z6hMm/ivzPmS
 lasg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1HhNxlEAjkXV9bEstAQ4fgEfXbioJ0951HST9BV9c8XjQAWo+eP/+ZVQdrO6nhhnpveb/ejrEMx6Q@nongnu.org
X-Gm-Message-State: AFuF++kPxrp9oe01QyFuqHNvA5MF0tMzuArkaEnGRSLrga/xZcUQXYA8
 Og2lq+Halltc6tUK4a5zdnCPoaIpvhvoQ6TQFM0vmjiASH63fvJGdsYzUMEBbf4Z14+ztVJRkTb
 NOSTMpK4h1ZPtiqsvjuSKQeh69b9AJZIoZAbRmYQ1oms6k/PAujt6TR8JDg==
X-Gm-Gg: AYBFou1DZY9YBVjmFlKOBeV0qzbrvZxgGbjec0vjTpJTuoCFiSH2SBAndG5UkG6ke/7
 k6McC1aat+3jSCzmH/MiemE9AKS2ksdFani5d8MmzZVxdQTmCmBsAY8Wm2cwEVuyYMzEEja24Ai
 b6OpvBSzUfex4+d+EAxSLkaEf8eNNbio6ZjPcSm+7vhgTfatdl8rMwSMMvHJbw2edRfjdRZnDlv
 Nl72j4Ly4WO6973sSLNVAwyDSiKZ6e/m0gOnHTzkt9hhGFEf1QQ2iIQ+7CxFJSv/qYpnjYeI8BQ
 9cq3DwIcU8hqIVhVX7BnOCyQqmWeljt/HTWM5S3RqMYAoHx1h4hBew+QHGJskzDmW8Inx7Rf0we
 h+n6ppzfU/Hj+GNR8AugDy5HYp6IcF2NSFckLHpq3rTWy87UChZa9AlPrlEarnRZIHzj7c0NJhR
 pPWbsYEPOJT11dfUpQ7vZJ7wE=
X-Received: by 2002:a05:620a:8010:b0:939:fde0:a71b with SMTP id
 af79cd13be357-93c9f315edcmr112204385a.0.1790708221499; 
 Tue, 29 Sep 2026 11:57:01 -0700 (PDT)
X-Received: by 2002:a05:620a:8010:b0:939:fde0:a71b with SMTP id
 af79cd13be357-93c9f315edcmr112197185a.0.1790708220844; 
 Tue, 29 Sep 2026 11:57:00 -0700 (PDT)
Received: from [10.222.168.145] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c9f4b52a8sm37336785a.19.2026.09.29.11.56.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 11:57:00 -0700 (PDT)
Message-ID: <2574f946-74a3-4025-b147-1bc91c532ab9@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 13:56:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] target/hexagon: use vector payload size for HVX
 operations
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
 <20260926192338.2702952-6-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
In-Reply-To: <20260926192338.2702952-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA3NSBTYWx0ZWRfX71ja9RwWf55/
 i4aPfWjUfISlTYD46Umedh7w954Ul4o4UO8qGJ9ti335/+KukQtrj11/Vog/ES+wAV94HRIhEQe
 RiTHj9QiYlXpydIDJjcoo/Ofs4AlPbiWBofOwEZ+T+C1JDSkdtH71w3BgherLUgqLnos1gwEW81
 gLvXeQvQBnom8K4x7QkWNECTNW4QvqB/BhS8UYDxwGageN4D6/KC441fgI16M+d192FxvNaSgiz
 uiHQ9qtwGXnyK6mLSkndsglgOd4X8yurgU+CF4l6nIMHEP7aIg/H1O7B18Cr79FGxpRj4uI9QAb
 kCUhTG4DsYh2DYmzCuyLBw4x0cTpR6X/gdHEv1UGxI3c/dZf1THNPtRQoB2VNE8EqLyrYTkSsyA
 KvFRYkaulTzIWRBUyhRJcj2vLHIqxcbjCJxUig5A7FvUbQNvaucA0p0s4ZcU7dw0jSF/rjKCEwo
 5uA7linfpvu3MYy9KJg==
X-Proofpoint-ORIG-GUID: cdIqpsZKq-hfs12jWD1J4lY6LzMHTFCs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA3NSBTYWx0ZWRfX84h5WCNrzdPX
 ugq93A9gn4gWhOpkefDUeKWfFGJ4t58kkPf6oAh9KueZl3nXD3xdjBsdqoMJnGWWF9uRe+ToJWz
 /uqO/oXcA5TydZ74LhlnJSq1PhTBgKE=
X-Proofpoint-GUID: cdIqpsZKq-hfs12jWD1J4lY6LzMHTFCs
X-Authority-Analysis: v=2.4 cv=DqvDa2/+ c=1 sm=1 tr=0 ts=6abc09fe cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=XkjCc0faG8W-Hq6Ck4QA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290075
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 26.09.2026 14:23, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/gen_tcg_hvx.h            | 242 ++++++++++++------------
>   target/hexagon/mmvec/macros.h           |   8 +-
>   target/hexagon/genptr.c                 |  18 +-
>   target/hexagon/mmvec/system_ext_mmvec.c |   8 +-
>   target/hexagon/op_helper.c              |  34 ++--
>   5 files changed, 152 insertions(+), 158 deletions(-)
> 
> diff --git a/target/hexagon/mmvec/system_ext_mmvec.c b/target/hexagon/mmvec/system_ext_mmvec.c
> index 081cadd814a..b796bad72a6 100644
> --- a/target/hexagon/mmvec/system_ext_mmvec.c
> +++ b/target/hexagon/mmvec/system_ext_mmvec.c
> @@ -21,15 +21,13 @@
>   
>   void mem_gather_store(CPUHexagonState *env, target_ulong vaddr, int slot)
>   {
> -    size_t size = sizeof(MMVector);
> -
>       env->vstore_pending[slot] = 1;
>       env->vstore[slot].va   = vaddr;
> -    env->vstore[slot].size = size;
> -    memcpy(&env->vstore[slot].data, &env->tmp_VRegs[0], size);
> +    env->vstore[slot].size = MAX_VEC_SIZE_BYTES;
> +    memcpy(&env->vstore[slot].data, &env->tmp_VRegs[0], sizeof(MMVector));
Shouldn't memcpy use MAX_VEC_SIZE_BYTES too?

