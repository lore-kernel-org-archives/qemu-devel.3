Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D56ACD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXZ7M-0005wv-Kg; Thu, 11 Jun 2026 02:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXZ7K-0005rX-GX
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:42:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXZ7I-0004Iu-Su
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:42:17 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GCue3843632
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 06:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YECmlo7aJiRbP47VD/l+b+/MFnM13XFMeUDH51iOGxE=; b=VTmUZis8tWDhTt8U
 VeZckeFr8v5SnZZfR+NBoi8gkkReLBu+i6IXrZd3+FA7e5Esb/Dq2hdwg68BNa8l
 5Z1ujChsqvbIHsYUnI5JHvZsuxkuvjJnWGT/WcZ4hmt+Zip87kzKRdFiwqMJVpOX
 GHrZb/WUDTVdJv6VIJJUL0W2FZMZRiSWl5hUhsqqJ75o6/EUwCDBcVy2Y7G/Q4Ln
 eZmuuwyAIDvuU6GndY0e/8RYDeuDI5bD0y1kaw97egMBzsCIP2UzcL1Jk6Il9Hlt
 4pECnA5LhpiKdVD95LOqVYhLLPKkJzXj/nuiMV+7zOyVOYz/Bm1MJMhabHCpqsnD
 wLrg7Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe7020kk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 06:42:15 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51768072950so104822331cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 23:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781160135; x=1781764935; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YECmlo7aJiRbP47VD/l+b+/MFnM13XFMeUDH51iOGxE=;
 b=f/bbIbfE4cY5Wi1xLxE77t1GSGLC1FrvCUVemRr3fpq7rwWekMCZIXYFvYK9qscbXO
 9r1Y/teHHBEQ9fTuJLU8ARANeHE70mXnN9wTt7F9IpOd9PD9PNXoAkvqpm0nNBHfzfnw
 QzDzWU9vy3HOblYbPv8AZklsHDSXTgOnSfkeV8jikDLvG9Ki0+Jb+z6dlrnzEjORBvDR
 TpG/Wxdy4jjN/DZRUtn8CrVLzIadgfm8zMT/bopWJNsVvBEdQqRXPXt611RsDdV/yb5I
 XtK3w82K1t2ODKe+tl07kCK4anDha/6JnajjaT4sm8QReS6kunCk7X2qA3BnFxnTXRS/
 8D6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781160135; x=1781764935;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YECmlo7aJiRbP47VD/l+b+/MFnM13XFMeUDH51iOGxE=;
 b=YtmWAOrVscsBiBxgCI0gitFlD4cBouysPhrypuiFFqsIt0OouIO8RY0+tYUSv6dGRA
 ma178DfXcdYlbFajsLVXRsC+HmHpdCbWBiqc0cPKEqVp0II5CoXn4userr5zHvrDbjcn
 eHk7L4atwvaJ3+0mK/K8xf9H+Fk/b7HFEseVH3cebfQdikoENNrveLfC2hOHe2h2fFDM
 te91K3NerSBbU9TlsqfH7UR+DOR4wEnRu0s6atTMVYfJY7pYZeBx6dMa5Wxnx9mz42Ls
 /UXy+SCdpFlw/tjwvt1Eg17OhzUIor2LOgpI7xLzkcTaY917uxnn9NS5cFZ+ZL4rrD1T
 5/Vw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UXMBiGEnGGxOVxVJrl0poz+YTILhUEJ7gOvoVeE+HlgtzMTx7JsSCAP54wEtAZAgXAvtqMbyIKp+j@nongnu.org
X-Gm-Message-State: AOJu0Yw1KIHfZyahetq5q2o1rCuK0xpMsTTtSNfYETynyziXJtPSDBSS
 U2r9k6CViSnHomHZNG7CF9Li1dTD6EkH9shkn2p2jO2BJw1W8e4mdbG5L4IEDoEJ+bENPxfZwbt
 qWEUTZGTrphYRtuSM5vRpdvjnsQUUdYQAoh/XXBS7lwEH+jL6mKCA0xNnJA==
X-Gm-Gg: Acq92OEAcgreOghNd7B3BcprcH640r2vaWAeme1pXpU589nGAd+rg4jSoVM7paUiKZh
 ym4kLno0V3q9r3FPIYC88VvmBM46Vf0ZfniJte0rBoGVW4n9+NUfLG+w+fWcM2j5yI4VCAD0Bt9
 z5Q+pyDQ8uQObhokU2VK2XqySd/g86DUO8qtQicAtMkH0P5Yi9B9tmYFVIK7ogm93ATSmskYUvX
 4x27z4m+wjCi+cDCh9Tbf8rz7ndwfuVtBh6UwBeda1xx++eA/Mzhk044kjcqVCUd5vEWgVky6O4
 X/Vzm6cR5J7p/PLcX4/qyzN636y1UffT7X3aCRefAyjUPvnsU7iisJdWpqF2XvvhxgoijlXDijc
 6dM++lOk9OjOgPf6P8IXbt+LT3X73UvOwR48fe0jkxO79j+W686s1aHvMwYEOsXDGrL0t1kW6Q8
 QGp63wsQ==
X-Received: by 2002:a05:622a:6:b0:517:899b:7f76 with SMTP id
 d75a77b69052e-517ee1d5fa6mr22342401cf.35.1781160135075; 
 Wed, 10 Jun 2026 23:42:15 -0700 (PDT)
X-Received: by 2002:a05:622a:6:b0:517:899b:7f76 with SMTP id
 d75a77b69052e-517ee1d5fa6mr22342181cf.35.1781160134634; 
 Wed, 10 Jun 2026 23:42:14 -0700 (PDT)
Received: from [10.156.84.244] (218.170.88.92.rev.sfr.net. [92.88.170.218])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65868049sm10401516a12.24.2026.06.10.23.42.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 23:42:12 -0700 (PDT)
Message-ID: <2610e4bd-7ddc-4880-808d-3f55bb166938@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 08:42:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ppc/pnv: Remove Power8E and Power8NVL spapr cores
Content-Language: en-US
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260610090800.3672832-1-adityag@linux.ibm.com>
 <20260610090800.3672832-4-adityag@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610090800.3672832-4-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tZA1m5nx3AMwk3ZLJ2clrhY6HbHxJVOa
X-Authority-Analysis: v=2.4 cv=B9eJFutM c=1 sm=1 tr=0 ts=6a2a58c7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=/nYmEve+L4YsDi96RCWAbw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VnNF1IyMAAAA:8 a=-EoAAwLr4A5xMGHcZ-0A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA2MyBTYWx0ZWRfX2z5x0OpQBbMT
 fT156rhmcoQnqJi+CgOWo8Hbtanto8k8hRya9rU+H9nbAPja2w/Hsty3EQMxJCEqHOUDXc4qc9U
 BWi1Ud2jU0DviZEjYSdrukE2vufi7yma06GpC0ntMvkVDSuZxU3toRVf0cdzBobf53tX+a+p/II
 qPKejQPTsPdK/czQocVwqDDsMFCVY8zZ0NCNgb/pVq4JTPOlyoYxckl9tvqUbrAS6xtXyFU+EUb
 DrOI7HEIRMLlJyWVG/+tUyz8dhsj3EM2uS78X1OrM8FevnF6tBg5y3eR+6HDLsrUMlzAJiomZE3
 k8fJvgJmZW4DWCD2buNjQ39rEQR/FD+ZoPcn08xoC521IxlK+gY5wOvvm8RZO0RjAWexgM1Nhmg
 uza0hk75mJqdfwQoCcU7OH1lU1w4p8Rn5nPNk+nsaxaKKyvBVqjLXzkZfm7t9dwhrul2EA+ESTX
 EPZiVA1Qr512Jvs5WEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA2MyBTYWx0ZWRfXx1nDos8JGl5z
 A9VR5zZ0Dm5edHwfI/LOAzckFkFIyNE12SYcA+PmZdw+eIPwQo41VRYn085qIjRmq+tOWKMvuEe
 zX87bD9x5Q4Y2/fqSTn9zct5A5ajutM=
X-Proofpoint-ORIG-GUID: tZA1m5nx3AMwk3ZLJ2clrhY6HbHxJVOa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110063
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

On 10/6/26 11:07, Aditya Gupta wrote:
> Power8E and Power8NVL were deprecated since QEMU 10.1, with
> commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
> 
> Remove the corresponding 8E and 8NVL CPU cores from spapr/pseries
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   docs/system/ppc/pseries.rst | 2 +-
>   hw/ppc/spapr_cpu_core.c     | 2 --
>   2 files changed, 1 insertion(+), 3 deletions(-)

Squash with following?


