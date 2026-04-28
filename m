Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49F2FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 22:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHqYc-0003uJ-GZ; Tue, 28 Apr 2026 18:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHqYY-0003u1-N4
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 18:05:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHqYV-0006tN-F4
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 18:05:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SFsbhS4070822
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 22:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DKo9VE+oEK1I9Kb9Ry80y+JO+cqNRZQ4L8YhGB7HyWc=; b=KE+KUnFI1qZgxqyq
 WMqzW9hjOIgMnBn8dzBbSGKsOPWxWktWufVJDpR6NAg0n0cxnmFYneVn5viHIxvY
 BM2jPyxMleBdcl2lJ8sYP0pmLVSy3PEGoKF1To99b/X46Gywj8sfvakvol7omgcU
 IhXODE5IcZ4ftSpHEWO1HXKeBl47cghs5mP7JehD+51cJocX6Y8/F8e4xT1yvsGZ
 6tXxhWQowzMXSLfSluynVnUpZdSyV8D6fhYYBnJ6x5bbiq6z/2bEvSXoXWAuZFU1
 hWNZ7A2t3inqwWmsqcpd0D2/OjnEVaWDOEGSmdZmPO8KzCexSWbGMeqQ6i277Prx
 WqnA8w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtttjjn18-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 22:05:20 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2e60238adb1so30805095eec.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 15:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777413919; x=1778018719; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DKo9VE+oEK1I9Kb9Ry80y+JO+cqNRZQ4L8YhGB7HyWc=;
 b=bcnuPm+QxzUZe1edTAhmb6T6gZu5JC6Vg0bQ59gnbrsepftk1kV8euqUzp5PpXBoZW
 7gOgGG6deQOcktCXyBOMbw7gCh8ud6Oom3rs4LX2pKyb4shj51Ifn9RCOJJ54wQLzks9
 KiejpsHZH5vFRQTjsinQD0efmm87ik6Ghu3toQdaWIXPtfKz7QoOW39vtYjRKCZNY3FG
 h6ewOG1Sfr96pESc/ex2HAcDQZ+dZ/2iHUyzViE/0ttOfvqnTe3GEEB9Iu0gkuXG7N2A
 iAdT3aMppdFeGpVI7RK77IOvW28ImU62pzIRgEFThwIXOprCfDHgI4M9wt/biPAOqM85
 ybHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777413919; x=1778018719;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DKo9VE+oEK1I9Kb9Ry80y+JO+cqNRZQ4L8YhGB7HyWc=;
 b=sbkRpQRbTQSe+iyKXg7qzkzf8OPZJUKpQoUkKgJZh5vrVBZx27ZjTB+n1OMFrz5NVV
 lsOZ7SgA7BHxYGYc0kK6wtmJcQEe0mIsIFCK5/uvH+W9Gi2gchtHXdvFPr0l150IEdtQ
 c7VNO54BJwbrMRf5bUaV6lPewKGAyT8n42xbLya+k/r0vHyo2c/6wCRiVb2SbgrXjZd3
 uErcei9zeyIBQDFCfsoAV0mT1f9mLLWUis0c7HuOZqHNHVEbiTM8ygNwvEfP+YFsYGVZ
 sVzNmYZXK9ABYwBKK2BNTziXxpaorKI2KTZ1ElpbYa3V2fSP3pShDXWwdzp2hJxe9Vrc
 FOKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0TXSQZrcyruyfDXI2LhdglQ6kPKuAwF1EBLEiwGg3hk+DzU5NkU64RtuAHbBBugTfMQcmCDl/5p0J@nongnu.org
X-Gm-Message-State: AOJu0YwHRBMGHJGZqpVGdW0EvtjJvf6srMCF+Rwg/5VyCnHW/SCSAgIS
 8hITkxckjiv0G2/wTBXxpx/+46kQRx5iaq2Cl7lP7c/AUNA1zuvyk4Hs1GGn+oyXa1O2sVVOV2P
 6u5vH9PR1tFJGOP0T7kAnFUAIv37025bG1jNIqIChwUIKi30NcHqYToTDJQ==
X-Gm-Gg: AeBDievxysCyXcMiFrSFuXoSvY93erVZuP7W7QYUltCO7liAMBaUWlOvc1GIbsQooCc
 21lQgDz6BnFxosqbt6hSHwJxjUnDkGSLvCLzPkk2afs5WXWiNJav6qeLsDbnFfvWaMWn+T+zv/l
 M2zSKg6a3ng7N5p9GNHhSOz6z59f+Aqwao1/5PvMFu4m48WgHPqavE5eGEoUNLnVqJI2Bv1/Bk9
 rDmXN7/7vjI2c78JewWmv/+IRaKuSU+MzSgL4RpGR3A0TeBxZQT+1AR9aIuGNUWcGZVVwOw9oI1
 v8jrN4ohKlikZ/Y7u+1axsZZSN/LNgUqrWklKSXkWR4Ch4JLh9l++x1ndHy4saE9AngTeXiHCHY
 6Xj39bsKYlOisIQZYifjuiO4aZ2AY7Ydc+yAF9IT2bLvQXH/ybXL1sE5Z18TGepGlP78ETynPdy
 6fShPJKY4/sJ4SZNpXVa+yAoBZ
X-Received: by 2002:a05:7300:d513:b0:2df:5715:82ca with SMTP id
 5a478bee46e88-2ed09fcfde5mr2359409eec.11.1777413919489; 
 Tue, 28 Apr 2026 15:05:19 -0700 (PDT)
X-Received: by 2002:a05:7300:d513:b0:2df:5715:82ca with SMTP id
 5a478bee46e88-2ed09fcfde5mr2359389eec.11.1777413918904; 
 Tue, 28 Apr 2026 15:05:18 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c06ebcdsm136748eec.16.2026.04.28.15.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 15:05:17 -0700 (PDT)
Message-ID: <a42deb45-79c5-4eae-8b9a-6837766a5bce@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 15:05:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Allow getsockopt() with NULL optval address
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20260428214626.13329-1-deller@kernel.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260428214626.13329-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDIxNiBTYWx0ZWRfX7CXcl368zD0V
 bCcF1nZEtYGLYykrDT0j3DH1Mqj2xUimjcJ5/HyzlWschlP8Hym8uDSTZfuxiaVDJaPhINTK3yd
 CY3r0DqsjeZKtaHoRV545uN/CaAX5Yaj/dv+WV0X9uRr2YWbDAnA8Eysphtk6pE/mz2qCNpGVoN
 pYyFYAgGMZPB3L93i/4BcvWpqA9Gm1SqmSdCXQHCWIZ6QKsZcE+S7vYPtnqstmuzRMVdxT2IYbe
 Zk6ifxjRfWL0NM4n7JWU6O/8nkztlV4S4LOneGgGtk26gKPIxPuipJXNu3XX31b26WlD+3CIkNH
 vJbl1JZaYGwIyYWBFmyqaucH6O/RkEGlFoJX6ryscKouMq+8svmPhl/dshdR6AAFuun6Kwj1LKB
 16p0S0rbLjuzDv1IEiaIcuXR5b3KCQ/Zqm0B1hm9sIv9CqNJ2tklM4TOeoNtREqjJrjvtDZeb2Y
 0x6cbr8N0KDr/vr5chA==
X-Authority-Analysis: v=2.4 cv=TZKmcxQh c=1 sm=1 tr=0 ts=69f12f20 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=tnm1e80skVYX9a8ToU4A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 3Q_pPBzbbRF-sX7XIcQXBf0wjO2Tcilf
X-Proofpoint-ORIG-GUID: 3Q_pPBzbbRF-sX7XIcQXBf0wjO2Tcilf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280216
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

On 4/28/2026 2:46 PM, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Some programs test availability of socket options by asking for the
> value with an NULL optval address, which currenrly always trigger an
> EFAULT in qemu.  Fix it by allowing a NULL address, in the same manner
> as the Linux kernel on physical machines.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2390
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  linux-user/syscall.c | 50 +++++++++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 22 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

