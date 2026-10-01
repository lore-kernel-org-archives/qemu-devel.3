Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DA7CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCP0U-0002rP-AV; Thu, 01 Oct 2026 18:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP0S-0002pw-6D
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:12:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP0Q-0003BR-Kv
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:11:59 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691Fsgl43354498
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 22:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S1OdeFy1qkgwRfwigVbNf4lYtj9N/pY8ZOUJXeGFQ1g=; b=p68KPNEVpYAYv0H6
 lzB5co3QrUxUSLvqU0f36j9K5d0Hp95yg1O/aPaMzsnHu/egjsHh9Hfd0R/7U+q0
 seecRJD4Ejtvi1w35dk0ozBK2lNoTneoPau5+2kZY8vRncK/k8UqafOV6mh19t6u
 EXajEqo1vm9bgQe8Wo3tG1oxS3h9qwCFGEJ/qASYqsAkq/CPf/2c+iI+sLFmjfLW
 EfvW4QyObjOtiwmIYfZSMKcVcsLrAjucyD2LlSX/Fd8z9TWGtngnI96tU9rtLNTa
 Ml6w3V6M3cHuYuLxY6XYxbq2SfEjxceO3DJtcaXBRmQuLQNV3+tkgtGU0exMnPN5
 JzdlTw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1h7nv8vg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 22:11:57 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1384427c3efso10568343c88.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 15:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790892716; x=1791497516; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S1OdeFy1qkgwRfwigVbNf4lYtj9N/pY8ZOUJXeGFQ1g=;
 b=fzBIEsDp5iejQcGwYC9tS7fGaKS/V3R01y+95m/IdJs2VqbKPVAPi07X7HDUVnR4le
 QTNjLkrIS+T44M+o7U1N0ZpgCaHjVT7gvQTiO4+ccT8DUqLbgeARpfWQuhhRrBIA2BsL
 2Z1hBSIVXuBbqTY2icewRz3umtACvnHNl2Vn9IhKEuEPDDCJLAe8PK4kp8hmf4pB160W
 PgufHPGKB0OfxllPTfILm+BMsUR0ctDu8ceCB6jT8oBl8BoZl7sV0XqMv3ywgyw4AQ9v
 dQvjkN8G0Gv5R/po54fvvCcNszA83gKezz7qKEoP5fledvHmmfLHfPqZWTRDdttbzIgM
 JyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892716; x=1791497516;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S1OdeFy1qkgwRfwigVbNf4lYtj9N/pY8ZOUJXeGFQ1g=;
 b=Oxf7V6dAdRirVLgUxhtgFe25+8FB9luBtLuN/d3Md/H78Xp5OdevNp+GGFbVAPBnuX
 G4IPSjlBaiWzIQM3EPUJiBxAI9TPnTTJA03U3ftm5UVdIMBWStMpMO64VreZ+PWZgarL
 N/czJeVdebSLZRYb3+H975VdwDFFmNGl3JxDeLV3/d4wD/wLCpkQthOaBiOevAVkIiWZ
 dqMxLw1r/BG1W9qEYAF/O/nufGR3djIaEp9E/Nclvoo/cRQxCJjLJWT6aUAM2JlS205+
 Kgs1UwmHp3RxodIk/6+C0+TUcGAAYspIzIxc4z9mG4ys5JARWHzL89QA/Zbxx221+Uq4
 fn6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+iZAhBPp7sJd0eQ0FiIicGpcnuzE8oaiL1sOcL0OWwXGoUpORULN2QxJBH1MMb1HQs6z0rsC9rcWI@nongnu.org
X-Gm-Message-State: AFuF++l6yJIp1vIVoj7pHgSUPuc2JcmviVXsNcWBz4SM/s2Rza+2QegU
 0YCaHsfDoHPLizqgfZ6SciZOAmPoLzaGwWlWZGOubCCv8Rg74pg01dYesWB6C3MJRWg7DfZ8B5d
 S2mhvlmHh3psBaoJXgYPiE1y++Vj+RMQzSteDZZrBxbpeU7ih9xEdpBnCYQ==
X-Gm-Gg: AYBFou0qV99KYCJhoOGMo2aYmIo3P9iaa83QvMR0nVL+OUXD4R/gx2Rn6oP++LmR5cZ
 dU62ronftSjimJwh8Q3gtpym9iHjZhVJYk5UoeILMgDimxtUDgfWE9HK7bYbtBLoZmFeYc1Msug
 NVoszy+2ZSccclN5m0LSzxFm98oYMgQBqb4gzVhr8LiAhHYoMQMex4sb+9NBBFuox1/ZHy6bA2o
 rlQoPEH6mzc8NvUggW20qg1mgoACOxn4aCJyjdnYA0Aceuhh7WQg3GzKj8qUDgoJjiQbURHfMsB
 Fqw063Fqw7G3fAuMQE5rMNid2CrHhi4vwuIb/T6BXM45OdSR0nAk/VYylG5a6xa7JkMivC/6MwB
 Dyx5PH8CRei5q/chvikoFEV4SxeIcLYUBnvYEzBVrlRcLmHvxD7pB0vh8L27yqNIUOik0Hw==
X-Received: by 2002:a05:701b:4289:20b0:14b:2397:d8f1 with SMTP id
 a92af1059eb24-14f5bff48a1mr622628c88.9.1790892716012; 
 Thu, 01 Oct 2026 15:11:56 -0700 (PDT)
X-Received: by 2002:a05:701b:4289:20b0:14b:2397:d8f1 with SMTP id
 a92af1059eb24-14f5bff48a1mr622595c88.9.1790892715310; 
 Thu, 01 Oct 2026 15:11:55 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14f984e4sm1048798eec.17.2026.10.01.15.11.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 15:11:54 -0700 (PDT)
Message-ID: <9d9ae1e8-064a-4128-82bc-eb16ebf795b0@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 15:11:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] target/riscv: Compile cpu_helper.c once for
 system-mode
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-11-ea69b07afd31@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001-rv-dedup-v1-11-ea69b07afd31@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OI6yTiaB c=1 sm=1 tr=0 ts=6abedaad cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=khtv66SgP7qanp9UTMAA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX9cN9VpJpTynl
 N+d8dqO/7NhY20ecM/OIbsEwHVlDl8FJKt8mNo249tnDwJJJgcyKjdOKHMd10a6LrDJjLkEWilO
 X572cVwQ5Rsx/+Ez64knsS++Qb4aW00=
X-Proofpoint-ORIG-GUID: F9dLcAbFbnRBpI_V5BhocvPNt0lbGNhm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX5l1R6hkkKchQ
 MMdz+T3TV2Uw/30CUWs4ooL/qLNg+8rZqkimoV7t1ii4xmnMe9iJLCpNKAv4+SZ2UKCtOv6HQEj
 YmAp/bMA8VRnTJGfXHOFFg2YTVPZEUjLLBEqHq7Q+VZIUSQ/CUOtltYR+WHMNYLGlh8qGVor1Yf
 Em3dA1LcN6MU+xQ+NeuDbmqqKen5c9hgB6zkcksUEHoh4xR5Zn+A78CbrYI0LwlmovBSq2DbeeS
 dN2UEtI0aOU1kAAgfzCABpFqGSzysBYD5svHlKLh3ATEUrQ8Yp4mPAX5R0OVWb66cogbuW4W9vy
 wreoAtcmR+KCgSIkw98J9nl/M2BoTs/9V6+s1eRMydKhJZqjGRPiCOEXFSW5Ul7ljxANO619BQW
 QlkV9W4LzU468DvjG2MpWHuAn4NXBqj5oSv9K4EZ4ZfasDJ6OscCfNyDho0YIBgww5xFSBZjx6H
 xi2vTfA2XXmqeDUKZWg==
X-Proofpoint-GUID: F9dLcAbFbnRBpI_V5BhocvPNt0lbGNhm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010088
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/1/2026 8:59 AM, Anton Johansson wrote:
> Makes cpu_helper.c agnostic to compile-time target specifics, allowing
> it to be compiled twice (once for user- and once for system mode).
> target_[u]long is widened to [u]int64_t and runtime target_long_bits()
> is used in place of the equivalent macro.  Most changes are straight
> forward and no behavioural change is intended.
> 
> Note: the following change might be a bit unclear at first glance
> 
>   #define PTE_PPN_MASK 0x3FFFFFFFFFFC00ULL
> 
>   - target_ulong pte;
>   + uint64_t pte;
> 
>   - ppn = (pte & (target_ulong)PTE_PPN_MASK) >> PTE_PPN_SHIFT;
>   + ppn = (pte & PTE_PPN_MASK) >> PTE_PPN_SHIFT;
> 
> but retains expected behaviour as pte is written a uint32_t for
> MXL_RV32, meaning the top bits of PTE_PPN_MASK or chopped of in the &,
> rather than truncated.
> 
> Note: This commit will print all addresses as 64-bit values, even for a
> 32-bit target. If breaking this interface is not an option we can
> instead opt for more runtime branching, as done by Joel Stanley
> in commit 409c7d8682a.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/tcg/cpu_helper.c | 79 ++++++++++++++++++++++---------------------
>  target/riscv/tcg/meson.build  |  3 +-
>  2 files changed, 43 insertions(+), 39 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

