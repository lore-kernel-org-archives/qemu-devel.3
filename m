Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17198C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 13:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpmwd-0002lc-UF; Fri, 31 Jul 2026 09:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpmwc-0002kv-56
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 09:06:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpmwZ-0006Xu-MF
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 09:06:33 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VBjdLO4054639
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 13:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VSwV7LTIGbap8owHH2xw1MJU4PQgeevELg+GTAKVFyw=; b=FPexjjKxL3T40Ip3
 TiEU2QaoYHHcny3N4lWeTyYN0t9o07AF11eI169JHIDmVRBZY95rAbU855ZQclQ+
 sw7f3L/Nfy4y0uuXriYsVN1qSljQfHTAEu1Hqibi++IG7DxKGHIFzxJh5zSE3znK
 cBivD6+rmymWQb9dPIsQpmNl7aGY1N2uQy6EnaZbu0lFX6DudAWzxSfJ1SzXtKUG
 tNkddcn6+AyvQCVQXfGadUI89Sqk8mi31+gV4cJVRys/X2wV5Rc96SeHduffEY9v
 Vol4M8Soe7NSqMhNBk99Zp/MhyJQbwy23xa6moUaCb1dp+9YlWTKMXorPlk76CxU
 FOGg2g==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru4808xf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 13:06:28 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-73c040cc990so262564137.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 06:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785503188; x=1786107988; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VSwV7LTIGbap8owHH2xw1MJU4PQgeevELg+GTAKVFyw=;
 b=ZBmGjcsZP0Z1pSWOWiE84GXOP1oGZSnysyypsW1vmrxOXhbVIh192ffQgYyrmu3RNx
 HsR3HF3dj1M1GVnESg11qoCLDf6ZoEVIDeZ2OHWiN8ZgsP0e65nApY7FgAUhvXVyJHgc
 DHD90aqnrEB4yR9GZmwuZ/b0j0p2kr7pHYLsH3sh25rb6H05yopDJjeR9g2PAi1hZmU1
 OUnhVAHuqO+REmsRk4szEn24xOXbxs/Q+knSBGbIwkFgJjuGX0CKxBPiI+cXHSYsmiGu
 JMrR6KSgrmT2dI0Oq4LQqLvsWC1rspXqUIwvCgAUGMHNyncIC9AqhRO/iqXQvscWOisy
 sXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785503188; x=1786107988;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VSwV7LTIGbap8owHH2xw1MJU4PQgeevELg+GTAKVFyw=;
 b=h03OOrcsgeHyrp83tmOSIIxBLKWdqQnrWwK1JTsxdGwOKXDynBS3+skh9gki8FIIjS
 EVmwFbETDpHi9Q1iWY2pxHscIEXeWN9unZE7JhOjDCvhrwLk5d3aiWz/8OszRFedWPfU
 HbxXsA4KA6YcokspW9wAV0Ex+YiX3ZzuBAri8F7/uygwBkhUAaje3l9bfk612jY+420/
 2nY8PmmDQ9cg2wRRgt1oJxresvjKYQCpGSsHjmQXfwWyZSMKxZN5YOHZS5l9GI3+et3M
 krPSLt9FpZ9y3Q4PjX/ZkBsSSF2AYIQkR17mH4vjlHW46/qnGab84di2lr9XZYgQEJk5
 nYxw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpuK7gTgPnTMZYeSJcMjDz8prtst76XApnZOiGFzOLH20WItKlSsFjfOLFpQpv4+u4vIe/BU2UpTA87@nongnu.org
X-Gm-Message-State: AOJu0Yysuu8xVGUYFBAaYttHOV8j3qKaNWptSPjWn78m0a67L+hGlil0
 MpMGSfCMs5fwHdbpuMDOv4GSS45cIK3BXz8RPx3c8OM39oT5PeMDTX9TnuhsihB01FkTQM200h0
 uasexuStPnemtGwrKpfT0EEXbRM6GCfvKTcWE2aH75QYGzU0DSL6mNhvoEw==
X-Gm-Gg: AR+sD10G0IWQ/S0aHkUEWjfTUcfNnVMOniolmdpbDLejq7l82m1pgg/FLIO693Qs2vV
 aPNdvIBo9ZNtmZNEwuzeGNuqgG5h/y5YU7B3ef0ARpsWtbUo7+T9+GbLK2W/pxj+QWkWeKGCcHi
 S+8F+X3yjEMsZHym/VCL1oVDaU3K+9ifEErxzQJecS0PyZostR5lCfYRDgC+tbPBEOKONFsqCjh
 4zmdEWpkm7uWJvr9RXcKTJhEG5gAF6NYuKDWtbmUUM+MR5LzXjbrJDX+LzLDqcQSISOAdtaUdJG
 5b6kDDXWF/jzBBFQfRT+EdUSOEOrP4WW5GVpWcnB20EoBkdHshXDR3T5mm/fnl6LMKIeKI9f2RW
 q2VxAiUh2Lk0peMgZCZIXqFr2P/IBK2VDNxbsWNJgCkfAyrqhlCw=
X-Received: by 2002:a05:6102:4b10:b0:74d:ce65:4739 with SMTP id
 ada2fe7eead31-758f7554264mr899036137.8.1785503187914; 
 Fri, 31 Jul 2026 06:06:27 -0700 (PDT)
X-Received: by 2002:a05:6102:4b10:b0:74d:ce65:4739 with SMTP id
 ada2fe7eead31-758f7554264mr898907137.8.1785503187407; 
 Fri, 31 Jul 2026 06:06:27 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd4454306sm159195766b.36.2026.07.31.06.06.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 06:06:25 -0700 (PDT)
Message-ID: <aebdcaeb-efa1-4ab2-b48a-e0a183bb53da@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 15:06:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/net/vmxnet3: Do not abort if guest provides bad
 interrupt numbers
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org,
 qemu-stable@nongnu.org
References: <20260731113352.189066-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260731113352.189066-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IJsyzAvG c=1 sm=1 tr=0 ts=6a6c9dd4 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=UJx2ctYxQamrb8bvw3MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5OSBTYWx0ZWRfX0/+Z8or3bVx+
 1Hgf5vXL6zBY0NBFXnEf8b8RkxE2Lrgexu05TXpl4QRmcQMovM57/dLzBuxyNOcDjtlTzQRaFCO
 N/WhKFAGd+82CaabHh0uTAF/0Qw2K7Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5OSBTYWx0ZWRfX7Pwf4EHnlbue
 7uA+uQDFGbl/f8dMdpZL4+d4/743HJdc5p/Ie5qlWqbR2rrTlRr7TmUTmdiNv+WPAqNP8CISvYD
 MIh8K1Mj3hwiiRCtwwMk0boGhFlVEZKe7NIBwsAUe+Tga5MHo5qjYtMRNOwWO6I1a805jt1/MS4
 Ns4frhJFGOUSBQ6yJb1K+q7/AKRTuUThTmpt9g+N/Zw5c0qHeMRAhHiNFTIrMf0ZqNF2+To58iX
 j/wWLF1R3NvXy7jIZsiIblhbbq0Dl8owDiMQ6hLuzrhXgnB+ZuJ/uyU/xeR6be0IfC3Z7MkcW9n
 c0oZdU3taQoQ1gbhlWjyTeNkaqg90YIYwhkbS7vtvMg+mJhZiltt7iAb1ipnBRXLQKBhMrOFfFn
 sLGzMjjrY/CPukalFS9WxrXIgfJi4xgXafUEa4B+0WwR/NyKTeE0eI26IQffDH4eTk7v6viAL6J
 V+RDHaROBj9xADT8M/g==
X-Proofpoint-GUID: N7Zj5nCuwRXO1mnA3KAB6naIUSt9hRkG
X-Proofpoint-ORIG-GUID: N7Zj5nCuwRXO1mnA3KAB6naIUSt9hRkG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310099
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 31/7/26 13:33, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> vmxnet3_validate_interrupts() currently aborts via hw_error() if
> the guest provided bad interrupt numbers. This should not happen,
> QEMU should rather refuse to activate the device in this case instead.
> Thus propagate the error to the callers to handle it more gracefully
> there.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/539
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Drop the unnecessary vmxnet3_reset()
> 
>   hw/net/vmxnet3.c | 34 ++++++++++++++++++++++++++--------
>   1 file changed, 26 insertions(+), 8 deletions(-)


> @@ -1554,7 +1568,9 @@ static void vmxnet3_activate_device(VMXNET3State *s)
>                  sizeof(s->rxq_descr[i].rxq_stats));
>       }
>   
> -    vmxnet3_validate_interrupts(s);
> +    if (!vmxnet3_validate_interrupts(s)) {
> +        return;
> +    }

Better, thanks.

If nobody queue this patch, I can take it via my hw-misc tree, but
after the release (since this is a very old issue).

Regards,

Phil.

