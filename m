Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AD2C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn99J-0006EA-Cn; Fri, 24 Jul 2026 02:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wn99H-0006BU-Iv
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:12:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wn99F-0008W3-Vn
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:12:43 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O4lLoQ2276405
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 smh3LSciesxSqc3YCLUMrZNpARHwKK7TLt2SXHkrpl0=; b=dbnUaDYDD2lsQaA8
 wqLa7mKmK7CC6AM90ee76u3Hb+JPmmJSqykrRJyXbTKIyV7xeXbGa0fUH/gEXPos
 bovkxZtbr0IWCZEbIn7XnnsmNiVxCzZ87yonIJSShMvwgyx6innR1nNXPug/Gpkt
 6ksiQ5JQBBuFwbVEcVEYfvxQpyEQg7x4dIOEswrG3AUQqI4M0hj8RLqkRq5r2oAm
 IGE+drGRYB2yfOgpN6hcxRTb6NNSNxS43cvCoJh1B2kKlslKICPBfees9Jo+18KN
 420Ia3oYQtD/OTeVdwj0LBQlKrPU7BTZVcEjlnheusQBZSwaLZLtrMmSabaaozh/
 vwTDSA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa0aakc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:12:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8db414c7so1305261cf.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784873560; x=1785478360; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=smh3LSciesxSqc3YCLUMrZNpARHwKK7TLt2SXHkrpl0=;
 b=OJstr38azz9xJIv6rwcXVRIMSvwcn1ai06XFsrUUWvAMbBphkzUMFUb96izvopdU64
 skqlm0R7o04x2eMVPFWv4dNz0uRdcun4p5mvLz1GYHlnvS/fVvQGJANVJQLpSJp8DtVd
 +vyYHO1SgInyg1XL2zaqX0x60Rv97ywAQRaiox+eEKBE1k4CM3wknN6vC6pnNXYk2vGV
 OS6d4LCVnOwohN/MhsQ281GhzIpeEf+/v1NcLpVe3kO4fJ5wQMRqWAm1h2VnfdsjRDUA
 O8BxDrZwhSb0Fb30LVaydxq/2E44UHXf/S7ApYuq/FN+34CtFJcZMNGC7ucV2D2ChDrC
 +u6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784873560; x=1785478360;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=smh3LSciesxSqc3YCLUMrZNpARHwKK7TLt2SXHkrpl0=;
 b=pd91NFEgFBDNwBgoEtgBkZbFQQuvBdYI+0AUwsgq1XSqvg9dn/YUJB+2IcrOhRe8FX
 ehWQj3fwKtdGtHH8Pyn0mxNd9/U+ADWhUU006DvQ0Y4Npsfd1/4ij01gDlM72lUgxgba
 70E0csJn+bzJW+5f7e1M40DQxogcqzVu0MTefpulAOwNc0S5WT6eS0iDgG9d8nIOg9mK
 W1OD6xHs2rAbRTKMaQAT1nrH+CcgrqrnP9kyYu+yI8AifaDZ9RrUnRVPAcWHBUaZ6Fl0
 +dBStwoGpBVThBx72JpivKCrZTnhUJI5RyrfVP1daRBpTM/lRMCU0vTa/54m+HPpmiPR
 efow==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq48RoJ0acyfBsg7/g3VYugyWRrFv62LDt2x4hf+9LFZRCs0o84TKuz5rrH94aAoqrmOp9q3DRRk6a8@nongnu.org
X-Gm-Message-State: AOJu0YxGqrOAgDRc3/VMvAjmF5jvSMasq6x6ZTEaPX3CtDl0i47fuSJ1
 oQldtJLD03ml3wpSWkJDnQXbghEO0Pn3lTrWQdxeZKMwvwZzsWTKfp21POBGmCabPBwnI+ybF2y
 eFa4bym6O3/lfX+sI8P/qHMF0ZNXzbgz7DUSAoY0ZRqarLvzDI3D8AWMRcg==
X-Gm-Gg: AR+sD10B1wCzXNYH5logQXjvkX7HEL5jv4ZASd51RV9MgMbw423+lOMtsPUZynWEchI
 ZzyMmWyUve/oQprlsXhEMA+mYndIHwmqg5Gr1y+i8s22wsENjBvIyqlxePJ1ia61DIfqFLCQG2X
 LboWMFTUQY4c/UaBHy/ab3q04p3ZZIy8mdiWon2sNUHjiLsvGA3yEE7O847GD8y9xfO0dQioQY1
 TP+YWFTibnQkF2OEq9UMMbWABkMXUGMeni/6s5j3haf3NvLdJWGvVNjoPXutO27WmH/aOxv5gSw
 akZBelHICpDFRJipF/xqJOYociPKtz+fT20CwCItZzB6nkAyQpeE91KAWXvps5Bw7jUTefrZGku
 A5SLP6o+4nKNrB+hoCgok2v9ECKA=
X-Received: by 2002:a05:622a:c09:b0:519:b5ef:7fdd with SMTP id
 d75a77b69052e-5283dda39bamr57508441cf.6.1784873559808; 
 Thu, 23 Jul 2026 23:12:39 -0700 (PDT)
X-Received: by 2002:a05:622a:c09:b0:519:b5ef:7fdd with SMTP id
 d75a77b69052e-5283dda39bamr57507811cf.6.1784873558401; 
 Thu, 23 Jul 2026 23:12:38 -0700 (PDT)
Received: from [192.168.1.138] ([176.176.154.185])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85a2573csm20575320f8f.0.2026.07.23.23.12.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 23:12:37 -0700 (PDT)
Message-ID: <cc5803c8-65b2-42dd-9b40-6da358ad90de@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 08:12:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/27] target-info-qom: use TYPE_MACHINE instead of
 target_machine_typename
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <20260724000948.234657-15-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260724000948.234657-15-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: C6zJHAqmdFXB5-IVgJ9QGog1qrMZZZha
X-Proofpoint-GUID: C6zJHAqmdFXB5-IVgJ9QGog1qrMZZZha
X-Authority-Analysis: v=2.4 cv=e/k2j6p/ c=1 sm=1 tr=0 ts=6a630258 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=uVRRv9AK2fddTnT+2a2/4A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA1NCBTYWx0ZWRfX652U4XScO4Qc
 TR4s3im2a0ugg+xeaYDXzGyT874eGfu+qd5ePZyV/WC1aPp+Vv4tsC8IsvTrIi0er4nyJnd9zTy
 jda+z6EHldgMpZhKli18Q0xSxQh4FhuYXCWbA0H9ACswJIiqQP0OL4PWOsP4M6p1UKvWdEIABjw
 vpNOETWSn/IKPmEcMsBQa260tG6gIEmgVZErhJRSSqfG1N5bWZcS2d25+9t+E+DAwsVD0CNdDOA
 C1CgIPB2n2hBJRCqVPcf+5iPdLItQowNuQUIzgrsAfZbMQWaEI9ulW8LbRwbwAllqxkeebFD/li
 AtaXazlv37XyG3PEyR2ktDzBYSEGZ9yXxzLt4fsC/pTvUJe1MDdso8WjQRe+Jed5/nXZ3JXJIPw
 xhODE3K0fUlUmfF9PAkreAj19fmhUrtk5tA7515wKxB0mKw7diIy0VQZW+Di/Byx5HOrtOXuSH7
 //Mk6l2SIWyRYpHSOCg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA1NCBTYWx0ZWRfXxCjDo5Gj8G5I
 mgGdjS1XUI7edXXhHWAyA9gY9ClOsHElfFlJgJgZEjjpJ8z2i9s8HeaBIKceho0xE2J8696a/zs
 hstkEyN4Q74gV6F92bG2v3irj9vCRaI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240054
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 24/7/26 02:09, Pierrick Bouvier wrote:
> Now that we implemented the new filtering logic based on
> TYPE_TARGET_SPECIFIC, we don't need target_machine_typename anymore.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target-info-qom.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

