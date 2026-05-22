Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E169CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXMB-0005mE-4D; Fri, 22 May 2026 17:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQXM6-0005l1-Pp
 for qemu-devel@nongnu.org; Fri, 22 May 2026 17:24:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQXM3-0005hc-VM
 for qemu-devel@nongnu.org; Fri, 22 May 2026 17:24:30 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MDpeKM2125342
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 21:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BA/kYYl17NJe6wTDbhM0UNSqA3ulPATRj6wd7PfHOes=; b=JiK5BRIdcZIgmbRH
 P4gtly2Q3GFtSz717+SWbFQffbzwGO9w6Kr1TIp316EcWG4vzo46gx2QMtAKvHl9
 nDkxqhR2DTQpZzP1Q7bYlMb2oAjErxSNAXzkkAMlBmxmjERwHNHft+IilT+B2dVM
 hjPShOvpNJLdNxWadg7l4IdQIO9HCJDnUtlUYQML/nBvTU0qhkRUp4NqVEZepEbN
 dAIg/+S8T3RyNOvrSksuAJIGsojCpfk2HJduHY6ckAr/yOQpf9rLvT0v6qcHkNnG
 tTvF0yO95Ant9cZDUztSHUvcq0Fp6JbzkgKgmfFEOKAxM3+3C1qgxzoSezHJ2fX8
 WoYVyw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eard89q24-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 21:24:25 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3041ab826ddso5811710eec.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 14:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779485065; x=1780089865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BA/kYYl17NJe6wTDbhM0UNSqA3ulPATRj6wd7PfHOes=;
 b=CHzriehR9ayaEn76qjJZwQeGp7/np4HLrfqq2kg7VcZa8Vcb0dgGFI2D9FycGHV7Qy
 dvAJzYXfIeqBT/kpgmPUITX3OELRFn4RVogygfJ1pOrNuT/w2CCB3gy5iwMt4kEXS8T7
 RE9IEFzI3eaoPCnZGwKFL8eO55e6xh9HiRNTpaG2ditMbfqll1wK45X1obCr0UCCblcU
 171bLxuaHsRtOeYzG8QYRJzKJ0eDVs9IV/AeAjFDOQStjhXsGR2KlT+KC7IuG1j2/fep
 clniRnAB1qolfd8qC04KktAU5FFU7jzPwFx2OZjDfM249gdNJEPDaNAM280jul0sESaP
 rK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779485065; x=1780089865;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BA/kYYl17NJe6wTDbhM0UNSqA3ulPATRj6wd7PfHOes=;
 b=gjZ8hoidgKwlVyHLPLf+8WVsBnpSkkEqNs/IL6qtYVpd/dmlmVkYb2hNdEUqMjlsXw
 QZmm3rZ3rsfauU4uiCkSaopOtr1JwKzHrrXLBbss74OEomnh2YPmG8ImP4ZEJws4DlwD
 XFPwdmzxHNv7XHK3F4GKFHyizQl10SDRjSvA5QruipaQ1A4gTE5eWREIdR7zHthIay32
 D2oMHvcVxZYeYowlAKXi8XZnO0rfsqOF+zmV5DJDXhAR+XbnH/eEeTih63l97FYejxTK
 A1QWTtTjcbOxESsBq5QPjfsiEB7nfVGuK1UEro02u2grw4dtew+i2blMr2l6Q1vQDs0f
 BSpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ91hXFqYWfJMbof1UX+Dp7km30QJeZh5p+FvvF0Rt1O5HvQ5WcVYV1Rq1CYOtwhNfIxP36W1qxPxczL@nongnu.org
X-Gm-Message-State: AOJu0Yy1tC5nTFUxuFcMc20as4BWUl+67KLeIUel8ZverTBEJbsHNxmz
 6mHz3FTdCeY6X5wxVv2V0jOy7p/43p9syhNazCLB13JJkWABdx/viqgS3QugQja4kTIuxt6kDBH
 TaQg16kPP69Nvi45ysyF75b+qT0bvi7Pk16+K9K/XyHT0Mn3/VajzdrLYnQ==
X-Gm-Gg: Acq92OHWVnSwU784Bfcb8AxkJz/7eMrl44gKW2XZrXjBw+bTNQURArK+JTyoyFPG8sH
 hd6Z2Bzq9ea0+/O1Dfuxb//GEB1zB1ZS0Cm6mE8n136/31dBe/idKgTF1Yk+LJY8yfsrc8sKsp0
 esPIpvV8WkVPzHnd+R/Al+MJXd+1Ww8iKCWOchodm7Tt5LflssTY7cXAXL8v3R+/JIrnGJ3uL91
 uzD2tOVRF7Hz96Uz+QwsamEakCotGAV3uCa8vNvr1GWxtjSgpgrTvcxZ6pQfPAdFRmk+Oo351g9
 ycqU0JVvN4OnxFhmHoRkUb5sxz8rZHEj/7XNXJq2tk8Uqkc20hfsHE+T5LrDfwMiN6hwSouazfW
 k+4R67ES/Vl470wdEsjc/XGu8PPMOI+P3rdkzGqJEoWRMHk8y+m48uiEON1yOM3DZB8KL5mz4WY
 eZd/1Kj4JaYfsxyQ==
X-Received: by 2002:a05:7300:b104:b0:2f3:3daf:3496 with SMTP id
 5a478bee46e88-304490b7eafmr2761185eec.26.1779485065351; 
 Fri, 22 May 2026 14:24:25 -0700 (PDT)
X-Received: by 2002:a05:7300:b104:b0:2f3:3daf:3496 with SMTP id
 5a478bee46e88-304490b7eafmr2761167eec.26.1779485064775; 
 Fri, 22 May 2026 14:24:24 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f20e71sm1862490eec.12.2026.05.22.14.24.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 14:24:24 -0700 (PDT)
Message-ID: <a6603d4f-9265-4afb-a216-61a4d45b8906@oss.qualcomm.com>
Date: Fri, 22 May 2026 14:24:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] tests/tcg/hexagon: fix check_rev_gating with newer
 toolchain
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, alex.bennee@linaro.org,
 berrange@redhat.com
References: <20260522212147.3089295-1-brian.cain@oss.qualcomm.com>
 <20260522212147.3089295-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260522212147.3089295-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Fus1OWrq c=1 sm=1 tr=0 ts=6a10c98a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=pAVlmjVTVtnPLKg_uloA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: TfjL24zgTAO3ZgrLGGAwp0bgxlNQAX1d
X-Proofpoint-GUID: TfjL24zgTAO3ZgrLGGAwp0bgxlNQAX1d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIxMiBTYWx0ZWRfX/VuML27dCbQl
 NyLuUChb8Hjf0slZPCQYmvf4psLHQ6jZWxaxfvwmeKDD5PrRLbylxIrL/BtDHqyrLnJUsN+xtyj
 n4JBOvjW4+DQg0zfDXX5GQec6DDzhaYSqKS53tY3pURuIGQAq04QeRSyJqufaXep2TYv66yEGsc
 xhfMkPCnAOMNoIOBGbAmf0qGOw6kBpH0cKEXJSyAAr1WfFC2CX6844pBRrpFziqlQJz0gJbNoy3
 H6LP2An8gdYzsxkb+zTxRkxRwUwQe9x7mqdddFiJOtw+r4VA1isgnUOt3IWAwbZ2a/iaFxJ7H0V
 dESFFd5Sr6Wcl8mD70BJaobCDb5TPa4/ZskLO8EPZxlULuwG52oAMVF44wivq69tFfYkGEavf4d
 TcB39E4bcz3kbMwJXp3hcUb+vPp0mCfE/S+OZZPbO4FdWJsuQXxEQYT3j9RKoBr/y60pjDNYMsW
 3Lyk9bgTqAvCkg/Pi+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220212
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

On 5/22/2026 2:21 PM, Brian Cain wrote:
> The check_rev_gating test is compiled with -mv66, but the final linkage
> step does not specify the CPU version. The v22.1.0 toolchain contains a
> crt1.o compiled for v68, so the linker resolves the v66 + v68 linkage by
> selecting the highest version. The resulting binary then executes v68
> instructions without gating, leading to a segfault.
> 
> Fix this by passing -cpu v66 to QEMU when running the test, so that the
> emulated CPU matches the intended v66 target and the revision gating
> mechanism works as expected.
> 
> Suggested-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/Makefile.target | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

