Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE0AC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlikT-0001nr-Kp; Mon, 20 Jul 2026 03:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlikO-0001nN-0h
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:49:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlikL-0005v0-8y
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:49:07 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K7YFtZ2043824
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o9nsWt9WpS9nqB1WsctidtM9jOjDD6xc28LJWznCrLE=; b=cE5K3ar1wmTE8Tf6
 hPSHkl28dy4KUP9qpo08GwN7hDyLVu2JyhJM22yAkvL7/nM1xX7fmx7oNrA0GKIY
 68gLHBLle/NT8UK2eYvfO8bhJBsnuMzg1wS5bldsMdQZ20Lwgnud1TeibBVWWoP6
 htbr0ITtC7wvH0h8DqtHh0dJnx2t9VSirzGHJNQa78FoobnQWk6zrGAP6wtF9cfj
 sIjDT7MFHTmTglkpgpbnFPfnT/sLSDFpPxLOwRnP7vQRsPmo1EtNajNxZr0XBgF8
 5GN0/CFpWs82oeFfjQG8waBd62VeBlS+WNy0cBTuOR6AwnliP0tj8UMko1g2cCI8
 xlxAsQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfdcg1h5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:49:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so191946971cf.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 00:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784533739; x=1785138539; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o9nsWt9WpS9nqB1WsctidtM9jOjDD6xc28LJWznCrLE=;
 b=O02KwCLphCpygbDoRqkvErVDD6f2T2c2SJ5WWFviLmhD7L1vbcUobngPotCONBW2Ku
 Gnm8dc9TXG9AtvHb2WPs46VK1DhWtHVuHavZovazIgP8mw+tOKWBx1zZOmLJCOaNHAxf
 p4YNAs9LLVJalHnn7zWyQ8ZvWjU8JHck6qbz1pYxglsHkhdBmRUbXPMCbZiWSEiFyF3x
 Wpi+vep0MR1NIqcKKrtbReVkVjjpIA7iDpu01TXu9r+Zt7GzSl0g7eFivI2Nahmj4OVw
 RpY8fz82FC/j92QBXf3WpuR4SjfxTVoJCoRsq2ylW9LiVr8Dh6t/COy8l5IS2YwXvVJx
 UT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784533739; x=1785138539;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o9nsWt9WpS9nqB1WsctidtM9jOjDD6xc28LJWznCrLE=;
 b=WfdjD4HXaBnyPq1qcCXVp7gXWQlYl492c4NeyprOdUaoF0qFDohS+2fT34tRMDaqE0
 PoesxwSv1gNK1Cj5idKC+JtnEP9coMiNk+0XjRYsTtPAcAuNUEAkGYczReOuUVg1iIxQ
 512fCRYyiNlsNy/BlRulH8EEnnfgfBnEiXsalGQt95VZGsApXwvHInAu3V7KJxodSBzx
 cRhNziumO6o6cvKF6RaZRWbJYq2H/7TA7/hQbNZBH2lqYqGAfgVetZBhWjclsmy/L2JX
 AmN5GvUdseHQ6xly80lBudZYX2kbkcqFZmm6GiCelom5wUjt3IZE9TjygGRP/oWIoVvr
 Iacw==
X-Forwarded-Encrypted: i=1;
 AHgh+RprH9eSu05Vmj2xp9hOv933+CJMIIqOb27uXnL+RmVs6KlDBqfEYwUaHwzTMCFoclagaW/4I9Pj2FpN@nongnu.org
X-Gm-Message-State: AOJu0Yw+oHHkp7DevBsOt8nURiwW6sffYzHT2+UjpnoPwHjxbPtZD5TT
 Er71kF0Yp+3xOx2LtX8e6IWDa/OakEOYX0sBWcxBTnd+uGPRmfuNnGjOtLgIJeXY7b+hgYaG3TX
 k10dGHDgUzCTwG7KhU9E55obPG3YqS2p7MHzcoOiF4e68Z3CHymgCseMskw==
X-Gm-Gg: AfdE7cniQPBNxJ41Bedy4SMD3wbMzsuJDFIWr605U7r/gl8M8t9RynAQYN4LsjXv/Fx
 lCe6WMM8K+3WIyG/4pDPzwwfRkSxH9qKiim9eimFrodDzfgXuI2BVJa+MKKNyVl9uCfiV3ueY+g
 ZaL7aVGtU6w97ty772bHKmiUJEpAozv/Yz22YiFZPthBmnkgx2BUJTc3s/NLMDFe7V9RG4syBad
 DNXOlJDx9ofllg8qFC6RiHy5MS+j7bU1Vy+4wa4J7ytr4wAcXL9Wyl+Dp9lBVaqpgb03iq3v3HW
 XyALioJUB1kSPvGsJgTU0sPJ4g0Ur4mcu36Z2f3m/b3Z3mTmgcEMk8S+mFWa879E9Fr56EeSCnO
 7SJnHCp43Sq1THS2iy+jkSJvzbvKe0ZOSRguTfci/epqmbb2R48I=
X-Received: by 2002:a05:622a:5812:b0:51c:ecf:4eb3 with SMTP id
 d75a77b69052e-5213c9e3801mr108913731cf.44.1784533739075; 
 Mon, 20 Jul 2026 00:48:59 -0700 (PDT)
X-Received: by 2002:a05:622a:5812:b0:51c:ecf:4eb3 with SMTP id
 d75a77b69052e-5213c9e3801mr108913601cf.44.1784533738684; 
 Mon, 20 Jul 2026 00:48:58 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49500sm29121810f8f.2.2026.07.20.00.48.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 00:48:57 -0700 (PDT)
Message-ID: <cc3b6f33-6cc7-484c-901c-ffa4003c2865@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 09:48:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] bitops.h: Add find_first_bit32()
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 peter.maydell@linaro.org, matheus.bernardino@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, Thomas Huth <th.huth+qemu@posteo.eu>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260715185701.1287176-1-brian.cain@oss.qualcomm.com>
 <20260715185701.1287176-4-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260715185701.1287176-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: d9I-EQCV3ecYzioWVjpLt08cmEGkR0tY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4NCBTYWx0ZWRfX3uLcxe/nwM2j
 bUdjgrc9DFf0Aip0UvXka2XiubDdqNn5wz/inLpgn/tGSO4D5sCeqvAZPjEKn6BuWLNdGR3+RzH
 ZD9iyK69q6BejexymhEICRlmhj+xO2mQDfhdTLqviXukEs+zrTc2abVvYpHsvds9OUo/RsGoswq
 ies/cgWhEe6W//wJFqX1uo1YED6hNwy7Ekfs54AU8G46+VAGDm6iWHZwaitFaTs6XrUkliPY67W
 C4vgxpYzazR/z2coRDQBFwC2leeMLLqZ/GU/3lQF1ObkTg/gBhcpbw89LoO+4MHv7fG8ZxK26RH
 WNL89qodsl/TbUxVrCDQOyAhU9T07Rryw38NfFdZihsbT0Xo2utC4dm7DT80giGYm4RuW5QJPCN
 Qlc2uR8B3xy9AuIczdUer1V0VJHKQ1o+DRiD4Fq3lyJAePEMetfDxveqaVS4YIespkfbl3jqmN6
 UeYJ3k5D9vQfSfoihMw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4NCBTYWx0ZWRfX9uPpoAGjkz3f
 eWXnQzypdiAHE+oWFtC2Ps0dbc9NUMFWxkSePflvS+fbDnpI7n9nkEdeWaUf7ATwCuWJK2KF53/
 +EpvzBE3/IdGswfRXHF4SLj1bzeyOQQ=
X-Proofpoint-GUID: d9I-EQCV3ecYzioWVjpLt08cmEGkR0tY
X-Authority-Analysis: v=2.4 cv=bv58wkai c=1 sm=1 tr=0 ts=6a5dd2ec cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=dMYBDX6_iVElXJQrnyEA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200084
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

Hi Brian,

some random thoughts...

On 15/7/26 20:56, Brian Cain wrote:
> set_bit32()/test_bit32()/etc already let devices operate on
> guest-visible uint32_t register arrays without depending on the
> host's 'unsigned long' size. find_first_bit() has no such
> equivalent, which pushes callers towards casting a uint32_t array
> to 'unsigned long *'.
> 
> Add find_first_bit32(), implemented the same way as find_first_bit().
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   include/qemu/bitops.h | 30 ++++++++++++++++++++++++++----
>   1 file changed, 26 insertions(+), 4 deletions(-)


> +/**
> + * find_first_bit32 - find the first set bit in a memory region
> + * @addr: The address to start the search at

s/addr/ptr/?

> + * @size: The maximum size to search

Pre-existing, it is not clear this is expressed in bits. Neither if
we expect it to be a multiple of 32, or @addr to be 32-bit aligbed.

Maybe rename as @last_searched_bit?

> + *
> + * Returns the bit number of the first set bit,

"Returns the index of the first bit,"?

> + * or @size if there is no set bit in the bitmap.
> + */
> +static inline uint32_t find_first_bit32(const uint32_t *addr, uint32_t size)

Could we simply return a plain unsigned? Also take a size_t?

> +{
> +    uint32_t result;
> +
> +    for (result = 0; result < size; result += 32) {
> +        uint32_t tmp = *addr++;
> +        if (tmp) {
> +            result += ctz32(tmp);
> +            return result < size ? result : size;
> +        }
> +    }
> +    /* Not found */
> +    return size;
> +}


