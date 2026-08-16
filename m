Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230FEC5DF66
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 08:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvWgC-0001ts-DJ; Sun, 16 Aug 2026 04:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvWgB-0001tj-9m
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 04:57:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvWg9-00078w-O7
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 04:57:19 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67G72A1A2629815
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 08:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 35MVTY2u+/6VWnEncHT01aq5pHYCLnvxSJE1gJ3pV/k=; b=S41D450pOP1P03lG
 W/JwGsn7EpQfoI5dz70YBLkPNEg9cJlvXk6axW+MgF7vm9bM9F5HuewBPBIgVQ7H
 5cfLgoGA4CPWl6BFPi72/MuEeR7/zGIGnEnHwXZ8LlOZsWEM4g69Itz8UxYDH6ux
 W4iwrQdHM82VtkXY3NVxI4J89uhD7Tm4Y512sIg96T6DVyhFFwSG361BsO32lDV/
 3pM/+2BC4v7yaVi2SEO1v3XBuSZa714rE9Lnjyb30boLFcQH9NFEy1UbmEgyRWSi
 hcn/Bvso12yJyf15y/MWcWpxGSDRYO+kIc5fpLcDYqhZ3Lyulsa4JdyaEovUJ1JL
 OiLaTQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghk34h0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 08:57:16 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bf321d786so34420601cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 01:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786870636; x=1787475436; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=35MVTY2u+/6VWnEncHT01aq5pHYCLnvxSJE1gJ3pV/k=;
 b=B+vpa9quN7+/vxpBi3QqGDKjfR+kDWW7mt6+fNeS1qAyZpmvs4zY/OHQGFw1OTXVk1
 mn7RrkNB9HUFkKae9Yk56D40TQ5GT/HD2DwZk+1AtVCrtVZ1JlOr5VL+lZ4e1dHhyIbv
 jFA5WEuGPjsfC89kyUjHiECoNMmCtsZaeA9CtuXj/BBuAuZJENGXoNKd4mnUvIA0s9b0
 wuqM1AmGM+j1YPNiQKKAOOuyRulWzXPQ2EBqHxMfTGGxW3ZE5fEccD7hyR54rB0rLaoq
 A2OibO5/Hc/cOgUMmj5DqUMX1zZqhV+u38tCXV42am92NnaY0pgvQVWyIZZ+Tu4T89v5
 6ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786870636; x=1787475436;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=35MVTY2u+/6VWnEncHT01aq5pHYCLnvxSJE1gJ3pV/k=;
 b=UJTma47auZ9NwhqUKtR9EWXeOWPMf0bUw6Kr+LhxJ8iTRWtmYrGK1+SkMy7VapE84T
 OJWqcBSImoO80WCM3hIwzKCK6FlNCq/6jjGxy55wJVgApXsBfGaGNcVmPZ8riBQVoh63
 j1i0Rl2sZ7Ns9hAJbeAhiz5KjLPdpCSiUEYs+0ZlzTW0PTuY5lV97dFvLUityYO1ZFYH
 yskGZAngue/b8H45sJH1VagZ4CdVhcWxKmi67TxqTuEiotGCXbEdhVVNNBVecjGBUCDU
 Gh5c45voEkHxWJiE6Azz+MJMKU954Y81BYpB8VcdSRKsBDzZGlI7FPwGYBfJwKxQSUM3
 1qbw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHKe3vtbVpWim9GZohgpN8kIdhkas0MVeGZ1/WW5OJBoKCPWjsmj4FPLNuL38cO6R1GaN+I+k95UOa@nongnu.org
X-Gm-Message-State: AOJu0YzDz3XqF5BFAgLwKka3etRT5e4lD/UziuOt4o2MN6dtFoFzbWvC
 0KnJpZtrU8wVBV4kmeQ7NmTwxQg++151t2tlJgDIk+EIUvgjMz4l/OKOMxP+jT10/l1RHLoHO2E
 HG8WU1fdqUdM7//Wd1JDo9Bx8F8Tf+D9ztI/dvRXv6yVITEnhBRgx4LRIS8CZRRzxbQ==
X-Gm-Gg: AR+sD11nm8y+miScaU8edGfZXUTjM/FIc0zKbSouUzBkEtPIiF6gASU1+Oo4bO/WVPo
 VRXQl88Qc0E5WIs1QLZtnxNLpBNhIEtTWqFhjfi8wd81aLtJkpOsXXxmX/ufD3zn7tbAoVVswmW
 4qAux/BXF6CzP0tEI1KSXI6M5melAVbyC5WT2EwdYgODgZ7/wvgD3r8QmeIRmAG47RGaC2NHiF9
 lefaBuU2/uXC/Thn8u/0/UHr1RU6tZCDWdgjBlAkvPt1u1OWkoHJ9vULDyxO8gUy+1xix9IK3jE
 8G7cIjGsP1AYZNJGVag7hcn9IdVP78NQHtMt18AKtgo2JJD9mea+nSB5a0ZIioZoXcQrS9wwsGz
 frlsIq9uOet7rIaOHTQX0EPEHXw4pJrwA+6I=
X-Received: by 2002:ac8:5a95:0:b0:51c:1d18:2fe9 with SMTP id
 d75a77b69052e-52d85303d4cmr175127621cf.5.1786870635991; 
 Sun, 16 Aug 2026 01:57:15 -0700 (PDT)
X-Received: by 2002:ac8:5a95:0:b0:51c:1d18:2fe9 with SMTP id
 d75a77b69052e-52d85303d4cmr175127431cf.5.1786870635481; 
 Sun, 16 Aug 2026 01:57:15 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b25ad8sm153408315e9.2.2026.08.16.01.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 01:57:14 -0700 (PDT)
Message-ID: <6994edaf-636d-4bb5-ba15-18dbdd0df1ff@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 10:57:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hw/core/machine: Move EHCI migration compat properties
 to 11.1
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, "clg@kaod.org" <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260814032559.3381363-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260814032559.3381363-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDA2NiBTYWx0ZWRfXxdI7+bQj9tjl
 jUucNSlv81Wkl3fPHHCT/6jxJtL3ejVWScMe7om8IcT+xjrdrsIkMEwjTKmuFk9ZYo4ueQ1v/kR
 Ggzp7lTZcawFjIyHaBj9vwf/kQGm4X4=
X-Proofpoint-GUID: E0XjxGj3k-pC2SO1qVLsmrx04gDGeyV9
X-Authority-Analysis: v=2.4 cv=f+14wuyM c=1 sm=1 tr=0 ts=6a817b6c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDA2NiBTYWx0ZWRfX9rSkHWb0dhn+
 DAWhQm6yorpWeN7/vE4r7Wttb4vjZH8it/PklEspekI11HxGSqr/GC6KXkENjMKr7YooXmOWuDR
 utk8EhHwkSWLxBm0+jRTt7bvbOD+V/pIXVK/yD6laOP/Jp+saKHI089wEK7Gz4iGijm7KK/zhfN
 l+hTqfyimoOgialWkoNVqLeu4bmT+NfVeuoIU3RpPpy9eol1zC3iGZEAEz3C+umiQ8ZxolzXVWn
 /hq28J2d7g5EJQoKMHGSiIGFHIbQwL4vFmsTR+SEXa5we6WBtlZGR9wAjevZPd1/qXWbOfmIRqa
 tDApldCwYhBjrauN/M/FLu6zgERPtusd6QoleCBR50VzXoG/wCgd0x6Z7LGybsLWu+C+VdYaZjX
 JHCrjR1aSxT9DEiB/WWFHsU28DcVfPsu50MagoZa4Ih7/educDPj4IbTh4LpgU+LQHU+2KBscf4
 bmZArLmhCqMMaJNiPLg==
X-Proofpoint-ORIG-GUID: E0XjxGj3k-pC2SO1qVLsmrx04gDGeyV9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160066
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 14/8/26 05:26, Jamin Lin wrote:
> The x-migrate-fetch-addr-64bit compatibility properties for
> sysbus-ehci-usb and pci-ehci-usb were reviewed before the QEMU 11.1
> release and were therefore initially added to hw_compat_11_0.
> 
> However, the EHCI migration change was merged after the QEMU 11.1
> release. As a result, these compatibility properties belong in
> hw_compat_11_1 rather than hw_compat_11_0.
> 
> Move both properties to hw_compat_11_1 so that migration compatibility
> is associated with the correct machine version.
> 
> Fixes: 38ed803aebb2 ("usb/hcd-ehci: Change descriptor addresses to 64-bit with migration compatibility")
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/core/machine.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

