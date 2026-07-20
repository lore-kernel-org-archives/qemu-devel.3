Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F4DC4452D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wltmo-0002ba-WD; Mon, 20 Jul 2026 15:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wltmn-0002ar-Nk
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:36:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wltmj-0001rv-Va
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:36:20 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJU3Fd3623992
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 19:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gkljyDWtgK50XX8fhgFT2t7ZAw0dzr+Ecg30WjrtxUo=; b=H/e++jzccLCxC9ub
 5Nul8hfJnCyzds4YVqtX8k/51xUBaXwmD5KzBeIIRhperLrHgmP3VmT87R7Ln+Xt
 CBTeWIwyeNTrpIeUUv+jwMkz8VoHRQR93iSZ0D6DC0XEyN8yUgm4gsCXXisnTf+u
 xJVEpOHYxoo3/kUlPde+MNSIXa0zZR02SaYlE6X22oziqQhaoaXnRWGCQpjQ/hAf
 TkkeLjzeAbgDPSnr9aDB8EF9EHyb/NJEFkT+BVMtThujOY2R+c4DSnXaKs3wF2qD
 BRxm2o2/x0qN4/U0yEBLSxpkuH9ldl7OED5v0VD9+Du+SumT/YucMTtFuJF/Huub
 4jEEdg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfvxk2xv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 19:36:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cea6a46766so160194715ad.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784576176; x=1785180976; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gkljyDWtgK50XX8fhgFT2t7ZAw0dzr+Ecg30WjrtxUo=;
 b=hEGGSDgl/c08kaWX/y1j21gILvds8Os1vXTwY2PTTcgi2InNAZBVlqQq28nCZFBmvC
 MnWRjAEG+EUWDkUgJRaDwYC81qtyKv0MfB0rbRsrD8m3RKBPKbGdQ5DVEMAs54dpDsTP
 QnXBx/qX7uGiGmP/UJHm5DafAPOOKmm7lr9HRzYhvqsLfFnjoTiBAWyM1tN0f08yG9U3
 r3CSLV84mSAgyYac03oEeWcy8FLlm4ti2xTso0EfZ0Da0+1OY4INO1k+hNiPyhnpr2sa
 S8fkhnCORlLEU2rT9hAFREbmzQAViJN4oQOzOEglD8j6DQtBHv+H94aGy66hvT9vv/CM
 gZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784576176; x=1785180976;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gkljyDWtgK50XX8fhgFT2t7ZAw0dzr+Ecg30WjrtxUo=;
 b=hKTJdPMeU8thcFgfKPqmRjZ9K2of6Dra9+0KIOaXlcA157wMBiKwWAyQLJBzy1dHJH
 /UjnWfPMubGjljb6EdjVQPY5Ij4jWrFguMCSY+RDHYYhmJEO/fSmOaHKcFuVoaui1vgd
 zPozm9rO9NvgXoLnd2zrCBTX3E7Bsiu1p6BM2JoD+OFmCXgsDa2cdj5rUgsgeHc11Rvp
 FQOBgvEt5dyO62uBAEinxv4UwqNF/mmC+2OP8I7HIqiJxxddDt1Bij39Qb4+G+Mi1k8t
 MruzeoL8YAdDBa2SuYXnEW0bDPNEpc3v1AOiM8p6ghJUKvWw742xIG0zTjEK3LiYXBzA
 5axQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrazzjwhYWFGRhmQGEyiTi1+73QSAGJ7+cZixg0iDDT8n7LJGF7wP2X293mJJqVa5X1tpHH2i0owBEz@nongnu.org
X-Gm-Message-State: AOJu0YwAshczcH4F4aygSON/z4+FkRB/O11R4d1mn/v0f7lluiKpyJSJ
 lG1b2CVxx7jD+7xZ7A0k/Sqy8EdT/vIBSe9/gCIDg0b0oSK7izHeaHHcc9cjz7L+9e3zUwjsxYa
 3bh/NEmmG+AzBpWXvZUqUsU7rWyV1w+wnccKQTTSAbwl3RQx5d5EDPvjq7w==
X-Gm-Gg: AR+sD101D9CW86Z8tMzTK6aSiGpO/0/vJrOIuNnOMQe0RoXaeGOG05v6eSKft8XUaMR
 MtslIN/UD+foAwpiLzg80mQa9Colt4Ncpet1rtwwoS4wifW8uqjY5RCbU0Pgn9JmtlB41khat2u
 gWNcRd/zFU7KCFga13wASA2pzBSy5QzQCVpXdS3B29fBusdXB1s9YI//CzqYTM4FdRRhTBMyEQu
 GgoE1lw4smMIx4Os8uAidk6NTJvs7WB4JSR5O6cXNyFGTP0/005/hxlsmxkESEm2KcJtiBfQV2p
 yE42u5lJ10+sR1uS9xCevKeV9JeaINEFnlDy9tA/r8Yn7goe2MsBF86T+CRyc4WPv6B/hlqGpM3
 zeIXQaDfPVINYhgNYYt4GzlZoLT7xZ1Rvi1jceIvxLiFbaqKA+v40ht28CqcsLPV/EW7l
X-Received: by 2002:a17:903:249:b0:2c6:9f66:d573 with SMTP id
 d9443c01a7336-2cf3489556dmr170363385ad.2.1784576175697; 
 Mon, 20 Jul 2026 12:36:15 -0700 (PDT)
X-Received: by 2002:a17:903:249:b0:2c6:9f66:d573 with SMTP id
 d9443c01a7336-2cf3489556dmr170363165ad.2.1784576175261; 
 Mon, 20 Jul 2026 12:36:15 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d444sm45539102eec.6.2026.07.20.12.36.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 12:36:14 -0700 (PDT)
Message-ID: <629ad654-b675-48b8-873c-18bc59ccbfd8@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 12:36:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/tcg/hexagon: add swi/ciad system-mode test
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com
References: <20260717214534.1203949-1-brian.cain@oss.qualcomm.com>
 <20260717214534.1203949-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260717214534.1203949-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HKLz0Itv c=1 sm=1 tr=0 ts=6a5e78b0 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=MRSOZBytOFGkpG8DLOIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIxMiBTYWx0ZWRfX8O9AiKtkXgFf
 bfu2d7M80D77HI/bbdxxgKkbc15exdR/9T56oN81CTRfSB5W3ZhZJ1rse3mIPIAwQewNi8BBIeI
 w+eOhHnmDlpHEXvPfhUKvnMfmKxpPoY=
X-Proofpoint-GUID: mawf5jjXnXOZefMYq_rec4PRMZFCtwT8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIxMiBTYWx0ZWRfXxmK6RUdVkKF9
 eAALaPK9XqFbebZ5JRAXBuAjxx0rDMzJ5rCIb1tU6u8QpXlXbaPrBBv2tfDJjb4WNGnjj30YR0Q
 x7/znOduqmHk/TCO2LxkJEEk2yO0curuBhk6BapRMLDESibSslHFoOye0iDuq75mM1PtX7oMEKP
 nJg1PtIMnGPpOYxcQITU5RvQKzwD+hsrhwItibvnrVn16tLq5cmIsV3uwQ9WCswBWVi9HrRWJx2
 J+VOYJxFCq+jVUaBQzrTA+QaG91Dtz1xok2RZZoWzZ1mMiTJYCVhGcO4ApWa9A8oqJAnOz/kcUk
 37V3R+BQBfcCsUceUAHf3Yo657SSHw4IF3IBlHeVaZ6mFiKecjv0hl/HhTxgmidrWT2D9wyH511
 yhX/tZD3yZl9liFe9DL8WWliQSM0Bt46woJMy8m1ijI8rXj+wsw8Kqlb49K/+S5dPIVHvIhCZqC
 j8Z/dsGfdXopqYg072Q==
X-Proofpoint-ORIG-GUID: mawf5jjXnXOZefMYq_rec4PRMZFCtwT8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200212
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

On 7/17/2026 2:45 PM, Brian Cain wrote:
> Add a minimal Hexagon system-mode check-tcg test that exercises
> software-interrupt delivery and the ciad instruction.
> 
> Pass/fail is reported via the thread-0 r2 value passed to stop.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/Makefile.softmmu-target |  23 ++++
>  tests/tcg/hexagon/system/swi_ciad.S       | 148 ++++++++++++++++++++++
>  tests/tcg/hexagon/system/system.ld        |  46 +++++++
>  3 files changed, 217 insertions(+)
>  create mode 100644 tests/tcg/hexagon/Makefile.softmmu-target
>  create mode 100644 tests/tcg/hexagon/system/swi_ciad.S
>  create mode 100644 tests/tcg/hexagon/system/system.ld
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

