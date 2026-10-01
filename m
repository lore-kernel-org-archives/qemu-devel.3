Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92545CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCP21-0004ZE-7T; Thu, 01 Oct 2026 18:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP1h-0004Dg-IT
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:13:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP1f-0003Hd-OA
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:13:16 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691IvqWZ3519929
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 22:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7K63zxwYyyuo23Dr18/mTlwKCHsXlFHXYttvSvAFLn8=; b=Mh43lHFaKJ4+B1fh
 bbVu0rPOuQi0xUMtZzri0a3D4VcY6IytcfBDor+Xl/Rk//eKnFQ1yob1/IBunW7C
 jPumyJ3DccIhd20HoXOzaevUK//6747VRrbeSDZNACBsTS+veqJnHrkYd65TLE/o
 y1ZOg3Db/gGazSYb3yEBoVigcRV3jROONyW0OKsozrLwgqZU9+A1qme0hORSan65
 JjArU85Wi92UVBAbZRrgLyXq+f1o+1LgFgnEm5rYXokRkPoc5BsB1cC/6s40ug3I
 D53OvYsLKsWlFYToAdqg8jmqWBB39AoA8KS0xScIRueZSyPyyFOiEypOwThlv3qs
 y+43rA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1w8tgmmb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 22:13:14 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-34d84114044so6271885eec.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 15:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790892793; x=1791497593; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7K63zxwYyyuo23Dr18/mTlwKCHsXlFHXYttvSvAFLn8=;
 b=e6H/t2JyGqDQ2Js+gtcKzONCWSjw95Plro4oJm0wt4os/q5eJzT8K+VSZsIunNJCVj
 G6YfxSmm6Xyw91fztZMKDMpdbz2F5sumsQId2obJ4yS32DnQkkMwFBnFrlxNcjIbpb6u
 1LW2ZJljHgxVzvscWCOIMcGkuW00Q7RxLUY/F5tqsY6p8k9JRwwVIUdGR3NWwgX8gT7J
 oXn4skCFsmDksAjCY5eW7A5T/JL3sYz10DmPIPaHJ2jjpX5wU7GeWFfGfCWmVXE0n4Y7
 8Ens518FcWbRl6WXuCFjAWNxqzYIZUsfWByBRV2eGlyfxAe/wXZf7Z5Mws88KNEr4A8A
 AaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892793; x=1791497593;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7K63zxwYyyuo23Dr18/mTlwKCHsXlFHXYttvSvAFLn8=;
 b=p7KmL9XYykkrNxLtCT7bCATaJokslFSOiExN4cap4h93EcyMOm854KDPy3fzkxrdZD
 rIrGZ++Zcq7Y91fnFJe/bHRr80095LC4nZDxhe0QKeNr/eXiVVe55VxXv3Ofl5bwygRt
 PSsdxUEU6ulR9Re+dp5neSvEv65bnIuIpnlMh9oBf4Jr128ne11iDfHfejhdE7cgI4lp
 TLzunWmuF1iwxShr5tW8dvzIO8koehzgc7V9ZSbmTc3ymed+WcHdW08m/IvIR6h9KXj6
 tMxPfvm9fMmjmD2fplFOMAOJe17HWX5IOewj4ZAHhg+bF8S4Ep/khL66zoJZEVQWrQC4
 OKmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcjnxMyrOmrvQX7FOj3k6bwngG40r2rzkRdVIT1ehaHXecdiuxd0qkZeZz/Bu660AkbZ2dKS0myuKl@nongnu.org
X-Gm-Message-State: AFuF++nniMD57fulEidWJu1QpXuA4Fs0gkXrnsgsG/TgK88++i8QPlkc
 CVyp9CU9ojnZ/05iY7RRG7bGOHJ2VtHBg4Ci1Qh+lQTG0sDlHagQ6V6snY77MPlq0Y6EoB7G4IX
 3VVH8d9+8+vhIlf1X5TsiD61kU+5i7Mw8V2qJCt/UgdGjN+DyJUero1lSdQ==
X-Gm-Gg: AYBFou027zMMazUTeWQn76OK8Ks46dQZEhli5op+U4NDDRhyb64y1nQ6EvINbsrZKVb
 OqJVQbGP3Qzzw6zBIn/9bSfvsGyZXlrGWMZohlZnhZWM9rP6+aOAepxkaizJfS7ZCrBwHkDzByq
 yaNukbN9ba5kAhuKOtzQuQnmtDH0gHEeEPBirJ7kBnYfyPf6KVQ74339+attxpOhqJSIaXyl2/7
 l4JVtWGqftViR07vHISR+XccRQl8Q3BfTAnFv+LBPjK8WcYP6nZjqBDqhxsxvRqJ4KJY1aMIB1i
 EU5bDS6MHl93DxHlsr45q1twQ8joB0YNw/+E77E9kGJ1U0bM8jy17wO47kUNEOOMPNBFTE1/nf1
 l44+8IUei27DxdZZ5fZyFsXSxZ/iUVmOn4JPwHhH3hnyf2kKr9V96nHqw5AgU6ZKOiEECLQ==
X-Received: by 2002:a05:7300:ccaa:b0:328:2ea5:bd39 with SMTP id
 5a478bee46e88-34f14f10307mr703424eec.4.1790892793451; 
 Thu, 01 Oct 2026 15:13:13 -0700 (PDT)
X-Received: by 2002:a05:7300:ccaa:b0:328:2ea5:bd39 with SMTP id
 5a478bee46e88-34f14f10307mr703399eec.4.1790892792727; 
 Thu, 01 Oct 2026 15:13:12 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14f98527sm1008570eec.16.2026.10.01.15.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 15:13:12 -0700 (PDT)
Message-ID: <ce86b143-1b1e-456b-ad31-ef90dc7833a8@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 15:13:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/18] target/riscv: Compile machine.c once
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-16-ea69b07afd31@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001-rv-dedup-v1-16-ea69b07afd31@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: u6kfOadcFRCMNL9A99OX8FaJDA69hXWE
X-Authority-Analysis: v=2.4 cv=ML/1C8Zl c=1 sm=1 tr=0 ts=6abedafa cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=fxbZCB_lKdZGEhcooBcA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX8qF/ah3iGhaA
 oOnlvmV7vlN0mjZVkabea8u3DISeDxNoJpxfAtY4Tihg2qlL4GK8Szbj20txmEzcVyslR15tD44
 qL/7ThccJlvxdsCL+pK3jmu7OUfpx3Qo/NRiUeHOx1j2NlU48Ip486sKVUiBtoxIHtPeBTD9cpE
 +A8K+nZ52ZI2E+wa9V87//xuw7dmvKJYyS91DNFFlXw17ENTLeMzS/veh9Hrj+rAFYL/ue5Wcfz
 Z4WF9qjPTMdTOdJnxRFAq1NmXbhoKgJ1EbblpCWuJmetURx9K6UH/VeXi4izOJ/8CzUtxzcDTmA
 rf1KwBbeWP5AAFixCYa34Z+mtL+PxiMO9NrzzUQ6UAE72qNOYJXIN7ev+dgExStbNPTmATyYG0r
 7oDbzAqPXfMvm92Wl22376XEFVmKKoDxkBtOZ+P91qmGEK21RbibeFYKud3bAWQ1L7NuLEwFxlW
 ZKI+VE54Ai3ziiU675w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX1zThwheOrNvm
 BnDGyD6HsqdP6Mm9YvF4GauCgda/EBzDmkzYq/IFsM7LxyHO8E225R76k4cXxgN6nCRuot/tuQe
 rc9oBkeNcdFcZqcMFZOHoVtHgkdFYDA=
X-Proofpoint-ORIG-GUID: u6kfOadcFRCMNL9A99OX8FaJDA69hXWE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010088
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

On 10/1/2026 8:59 AM, Anton Johansson wrote:
> There's now also no change in migration stream between KVM/non-KVM
> configurations, KVM fields are filtered out via .is_needed().
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/machine.c   | 10 +---------
>  target/riscv/meson.build |  2 +-
>  2 files changed, 2 insertions(+), 10 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

