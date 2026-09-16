Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76006C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 17:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6t1p-0006jG-D7; Wed, 16 Sep 2026 13:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6t12-0006EV-H4
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 13:01:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6t0y-0004Jh-Bs
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 13:01:46 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GFeD0J4056107
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 17:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZolQz/GGoOdBiEJnnGRQvS+1BwghJEpbEm1nAnYYteg=; b=QlFCDl8da/YfQmKz
 VyjmGJmU5Mu9etk82d2C30YRRsEloqJofMx7Htos1k1ViBo1R1/uWm+PLMvThv+1
 iSOs7czWR4ImSom09lX7vN1mRUs6f3+6uQcyIgJ936oma+EybmJaRExlQz9HjR3p
 iXjQWJE41yL++6IRAZPH1NoqcBe9oUGwrasIvVwUFhL1eD3ACEauM++nPenbhxOZ
 kFt35/fjr6PW65M9hHSfliq/xcJWxwa//N2AdePQQxfXLb2m9rOeqYVuQZXjmale
 xVG8twBSRPdIxP3Vb8GtuKfxwED3pLpLZtLJ+NUzomO1zTYhgnccgEK+0BEIcKF0
 EFkDwA==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqpu2te48-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 17:01:33 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-6c2474b64bbso5387594eaf.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 10:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789578092; x=1790182892; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZolQz/GGoOdBiEJnnGRQvS+1BwghJEpbEm1nAnYYteg=;
 b=gqbHiNH63TJDpphVUTwE7KfrMLptTnSOjTG3HKGhITFfWdkl6oQ15YrD2TJTunlI3s
 4Wi+ZFF/9FnSlR3L8MAkS9S9tpXypisdtpGD/s5IJO7NDsd/Nsm4MFLuZViOSWYqAXQG
 xWU7GzFRNCyTfBwp4nD2A9lAdeR/EGll11kRvHq4ZmUAwdraMnpoTvejceYox1EMSyxX
 y8PP2Xxol4UVoncKJafBgGeobhUZPtM0fkYypj9lVPbFOeQv+B8pFWE6EL1Nfd3jJzsY
 N25pCda55f7KKqeDj+PH6pnHFN5YxKsWkmxOXsREQ1JPIBEf5wM2NsQrHDTAOt6a7+JA
 0Beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789578092; x=1790182892;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZolQz/GGoOdBiEJnnGRQvS+1BwghJEpbEm1nAnYYteg=;
 b=K9kr7bwXeJbTsh3zydpPK8V5G+w+5vAjXaqvedrPMPRQDaTtep2wLuKOdtvgX6CUDD
 wVXYwsBzUaNdLAaCim8NWSfRqf4sSJgppEpnPJjXLf2XrgrNOUp4/Pe2HY8V5HTP1WOc
 INN37qyCu0UsZsF1UoCQt99M0ZUabXcARB8km3FT3A6+FN6j2K/Uf9G3s4+Aq3r5cWL0
 brGPdZ2N27Bt70xQ/M/lyyTJWK2uj8hpIjXTJEDK2c2THtkh0lmjRRcL5Aj/yd1M9x9I
 eCP4KyRV51cLHVMp9wqrKowGu0KXFa651dYQXfpVHlzE7+YzW3aRxx3AiBs+h6IG6h+Z
 ARaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgyi5q0G//7lYsM16WIt0o0/8QVWPUe3tdAo+tThBmzwSTZm8pBqNqlvrhL2KiHnQ69MJLodAP1Z3t@nongnu.org
X-Gm-Message-State: AFuF++kMIZwcjaUImgzcsldWxBv+0QIOmHtpJ6TSZ8sAcdOyi7Pqusz5
 QS1erOovVajmiuLeRGHjkmjHtGXWeUacENigdTDLZWLYulQngGhoBe6eD6Rj9NOSo+/uQrrerr3
 MHUpBTtjizoHjYEbmsycSrFeN+doBGkbrnMIFWrigTREkJ07bCfUS6W06MQ==
X-Gm-Gg: AYBFou1asj1mL/RD6MdwXjMgya7XFgdeea72BEwD5FoQAbAmEDSpezMw2V6RU4oA0ph
 /XlrbUGO3bDqIyqLUWm2ycaS8pCYNm1h8oXs6SOI1PHt31JZVN4YgvPLqUXH8Glt/cIdaXaRpeR
 OfEqm9xPWeDWGAq7BWpwfUXiNR25XPLTOi8dQTk0vvBCpjgCh09LnPHt4Dkmb1NTGXK3KVKwpIX
 7jB2wDREHmMeG+ACZVqfVK8zIptC/mdtAdviY18NSs60mD0O5JYbexYn7MqsJkIhZGJgj4Y5BL6
 H2hedmTKA5zDqDKrULITCaum0CKchTDJVfLHF/DxPpPN33kq3x8R4lXC09I8zeC65+trahHmhZu
 0tIL4qGF88BjCJ4N4PJ0C6lPkMUI0zDomZg==
X-Received: by 2002:a4a:e909:0:b0:6b3:b321:a56e with SMTP id
 006d021491bc7-6c7d16c79bdmr3104278eaf.19.1789578091104; 
 Wed, 16 Sep 2026 10:01:31 -0700 (PDT)
X-Received: by 2002:a4a:e909:0:b0:6b3:b321:a56e with SMTP id
 006d021491bc7-6c7d16c79bdmr3104131eaf.19.1789578089756; 
 Wed, 16 Sep 2026 10:01:29 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c01728a7esm6168596eec.6.2026.09.16.10.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 10:01:29 -0700 (PDT)
Message-ID: <f692f936-550b-4e5b-90ee-399edf21de73@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 10:01:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/12] target-info: Introduce target_riscv32
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
 <20260916-hw-riscv-cpu-int-v4-10-babc367b60f5@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260916-hw-riscv-cpu-int-v4-10-babc367b60f5@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Iix-WwPxfdS362_hfEDWVdEJY-mtnO2b
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aaacb6d cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=n_XsretPTedRupDkkNkA:9 a=QEXdDO2ut3YA:10
 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-GUID: Iix-WwPxfdS362_hfEDWVdEJY-mtnO2b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIzMyBTYWx0ZWRfX0BhL6GwtuPmx
 wVuYlqsxZ9pzPUFKQD8Bj5ZJW5TMF/RohE/afETI0L6GgzKTzRB9ocOKKipabTPcwZIMCm6FLTm
 P/IhQDnbfK+XJ3+dcgriKnEVPAmJBLJT9a45fwMe9/eDOTO+Bdhvh4S2ehS5I6p1qsVND2IKvZD
 FDCnax9cBPSGo/zsB1xgPT5nS8Z40q8Jjz/3XchREw60mtUPtPV1R3XTVdKx9CCO0N64w0WF9Lk
 xk8/4h1zKZ8lBMh1wVUFHJESArE43eIcjbRkx/XBF5NkWZew4i/Ubde/oDw5x0C/XwO5HDqU4zA
 +MmT1K+B75jNoDbd1eoVI0Ty2ewCEMROlLI8He0P3WGViPZ4bhWiKSrIOG/44C2y0x3kHT0whbp
 yObWNO0x0w9YZ9ZEGOccfCWCrGrYCLKoR5h/QBfd3xwxDOKUpv58XZJY7AYpBcJl7PJ1OX4GQ7X
 7xuXFTFUN6Eu+tZU4Rg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIzMyBTYWx0ZWRfX38642Mvy/Rvh
 5aHGfKAQykt2NJLtOyMXX2FfPn5f0YEOF11m4MruNQstxeEBJJHCf9txfdPKd7KX6/+qlGdLIjq
 9+GZSYnooHjdRVClhUqhFniiNTJtXfc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160233
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/16/2026 2:19 AM, Anton Johansson wrote:
> Will be used in the following commit to filter machines using
> TypeInfo::is_available, so a simple !target_riscv64() is not sufficient.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  include/qemu/target-info.h | 7 +++++++
>  target-info.c              | 5 +++++
>  2 files changed, 12 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

