Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CF1CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 17:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJwef-0008KX-NR; Mon, 04 May 2026 13:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wJwea-0008K1-D8
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:00:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wJweY-000713-Vd
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:00:20 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644DlABh366327
 for <qemu-devel@nongnu.org>; Mon, 4 May 2026 17:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xeridikDA+zVYxpTOIQ2N6qCx7X4b5a14+OjxszUr+E=; b=FEQy5DqGwTsAGFma
 uZ0foxfDDgAkYuUEaFTy79Tbpk3GRBwTFPAdUT901lMTHVMr6Ch65z/VECXoHROJ
 Rz3N7n/nH/YUgugh/jlloaAZ9vqDuvrAv2vpzcBhFpaAJ/5Pjf6elbh+axxB+Luv
 5a5Itb1HehUdn6A5/UkkYJuF/8/ctLrvGlvh4bQAd7BVRlzUtM9x7F7gpx/BdL3i
 iBXY2ZLQW8YsztguC2Y8Um8R1CpAG+wf2QCPUD5MUhLCL41+ij71KSHuzpQJrWgv
 UvkVEuOnPLRYUFc42Siz1cBXVInF4woRuqLR0SVzthD54g+PE8M2LQBrOBtZKdOs
 nFzI8A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvn6rq8b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 17:00:17 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2cc75e79b97so8297536eec.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777914016; x=1778518816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xeridikDA+zVYxpTOIQ2N6qCx7X4b5a14+OjxszUr+E=;
 b=XZEe+qDX0kDV5KRyNxFmEG8+owMV027jTJiyBK0GNWx8nHQ6Doeox2SRSaozsky/AL
 vvmf2TmSJSlluk3WXnv2xFjDgtK2kr4/8VnfnDQV1+Yxjxj27FY7fzKBoC/fBWA5wZqK
 FDB2moxtuw4/By/vXioY6EEBgUybjXifoB5TWrSQKRoZFuO8oBCgt2ybaO1ObfdfeiJL
 YM6bC3MtdiWxFCJumG1lDqZSplVz6Ss1sKkML/FFEMTcPPyk4tMN3Aw2yaj0tszo7O/d
 p2MyVlLOiqwfngaLHbApgoDY8QLbXjvESA4/Y9iQDu6ar36D5vwyDD6cOEAiimrFyLRU
 qgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777914016; x=1778518816;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xeridikDA+zVYxpTOIQ2N6qCx7X4b5a14+OjxszUr+E=;
 b=k2LrKjh/3F19UVoHClMxlbbEqvCSbvKT5UeHKp8pbay6d5O3KVfiHc0YpXrodNr51o
 UtC8iOJ0qhSmfDuZsyf2ZCt0AwmDp0JkeMqarch+PEIEstD6LeNfM3xCoB1ml34Jwf0P
 e0XVukGOxfgfhQ9I2OUG/muvExEGUi57nUwHq3h3Jw60dopDsy8s3HzEAcWC/8/Y20Gz
 Fxh+7yTcFg/6S98vQ2WUwBA8mZ3ubw6trkckivoLX6H6fAyCq5KdZkdZfwJyKReOmNz5
 I0uyxCu95t6CO1l+nM7f1WD+WhwpO3GhD2p6oUzI4pF/Yj+tvpn+F3LRFuVV6c3ANmC5
 vejw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/McrGJDxhaAAoKpeMct3DxPX9DbiioaAFFNo5W+5Skn1LI3e4jyAAttgWTug9vLchseEjy1xYkcHG5@nongnu.org
X-Gm-Message-State: AOJu0YyPXHZVMXNwkVSP0YOXrj0OaNd+oU5weYjzGi02yUYD8owskFG6
 VJwkTLIqfIq2eWH5vHkbr5zg+jYCIl9X6RTk6EHO1MHR1dy57HcH/Wa2JepWrVHuCGrxfhdORuT
 QfXJ1a/efRePnhEKR+bryMW2JFCaUDG10gDu51T6HwsAS91Wl5R+aH5fEAg==
X-Gm-Gg: AeBDieu1xIdEfLKyopah5TWLwAM1lXVQhzI50A9p6EAF/bjWyCAVRi2eQlYkLgyuneR
 Gc26ShRsT6HKq7i9VHvf/joA+g3YW5acE8Mz7e6xWv5vnP/d+ZbuCGNkraW1LkuWdcphitpKb47
 bjtjn8LUzSJJvNHNoE0LlFH9XRkYT2oQsYPvQntdsxLKFdaukM+DzBesRl1rIOe/V7/u31tVXfq
 Ele75qpX9GTqFEHj+Gj8CxRR1AP6c8zJBxriQynzBkSjgEu9mi67Pvmoq1ufwe0Zyf9evaZ9PWy
 i5Z21bRv40K5gxQ4CtPa9TDBS4S8yEcRfn3+PyPaPuVFT0rLQP1vdzEgiWSwAxg3WTF8MX8KS6J
 xLeMhrIpofdIXGjrF7Xr7U5JstjUyIySxiVnRw+cJzHZND8qt80AB55A2+9u2O5iiqny6r1LPfc
 uGzetMhXh/kHADkWgazIfS63zX
X-Received: by 2002:a05:7300:690a:b0:2e7:120:137b with SMTP id
 5a478bee46e88-2efb4f2c0f8mr4644307eec.0.1777914016203; 
 Mon, 04 May 2026 10:00:16 -0700 (PDT)
X-Received: by 2002:a05:7300:690a:b0:2e7:120:137b with SMTP id
 5a478bee46e88-2efb4f2c0f8mr4644263eec.0.1777914015481; 
 Mon, 04 May 2026 10:00:15 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3537d300sm20225226eec.0.2026.05.04.10.00.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 10:00:15 -0700 (PDT)
Message-ID: <3a1ffbb1-2a03-459d-ba6f-8b7f36949f63@oss.qualcomm.com>
Date: Mon, 4 May 2026 10:00:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/19] bsd-user: ioctl: add common definitions
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stacey Son <sson@FreeBSD.org>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
 <20260502-ioctl-v3-1-a05d4cb1bdff@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260502-ioctl-v3-1-a05d4cb1bdff@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QNffe2DgTbD-83cYVENTbPBFpMqyWqQj
X-Authority-Analysis: v=2.4 cv=Z+vc2nRA c=1 sm=1 tr=0 ts=69f8d0a1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=6DqhdSMD5i7-Dn6CAkYA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-GUID: QNffe2DgTbD-83cYVENTbPBFpMqyWqQj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1MSBTYWx0ZWRfXzIVt+ugtx0WB
 tjRt/hr//JVb/a7FNJ70AI9WQrjTakyRFdDoRCm5fEEMZ39dVkXJyAcN6EeNFofAyPn36smRjVS
 WXFGlKQSZhZDNp0rZwO4+zqv8k4tatkP0zdf1AaX9o3kIo34zG+bC3kHimN6hpXOOim/lwyHJhl
 slqreG2jXXgB7rvYA8SuedvBnOlxzaCi5SuajBjJ8GnKdV9h2MFICUPqB48rT+FIso4tBgQKZPY
 CvhWFLJ8R/F2kN45N6J9So8E8gqi+D0cePNFegGvgivK3IJueVBZicqbheZOsI0TSnUkEnjeRJI
 3DAAIn2Bw0xIG7ox0kmXKSxnbRwQJ9a65NYJJ+f0dvLT1lfiQaV+4mBE5RxOBSQEJQhaDGUUnXW
 dYcUchHUpcz94j6+8T87DlNATsnUpHB6JyIkbGcHF9ogeDtV8aLVQ6NaUP/BaxENxPglL4sLsQQ
 MoVydPoVtw2iokffNYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040151
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

On 5/2/2026 10:09 AM, Warner Losh wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Modeled on sys/ioccom.h.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/freebsd/os-ioctl-ioccom.h | 43 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

