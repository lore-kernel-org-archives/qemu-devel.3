Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297A5FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDrt-0007qt-II; Wed, 29 Apr 2026 18:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDrs-0007pc-Na
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:58:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDrr-0007g7-81
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:58:56 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbL1S3992786
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7xWv3VUamkN76ywINtsbIbNrMYfkXIaAa/gU/P4rS6Q=; b=KJ+sVIEnZxaxdJgK
 TBXcnbj5uT5emTCKCJr0+PcXobc0MiKoU9K5+vcT4TkUMADg8uJbWEI0yvcvGedo
 rYai3keEAgCoMADd9yTFsrYzx26McSvEz/V7/qlgGhLnFrGm3CG8HXSb0U9v6QNp
 jeKN5TOnhnsWTnM/OgKUEb3ZjcGjRDaE3J7du38sfsUI8eM2X7W57L0Es887lDQf
 gT+ngOfl+Brpiz4TC4FYN5LqeyQZcE4BIqACoo+UJWiHLH+JnRTRxTdrWTLztQKU
 Fu1LoLVINm222YHU+XC0ZBbbP7+TSoaGa6Qvbj2T/xGm/W5aucjc52mQdX0CPk+i
 L2mf0A==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duhx928vk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:58:53 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12dbf4f678eso1447077c88.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777503533; x=1778108333; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7xWv3VUamkN76ywINtsbIbNrMYfkXIaAa/gU/P4rS6Q=;
 b=RNo+9ejq4GhJ17Z14SELXuqqrhNd4LfKEKJxmk7m/KGBe1+z2jZNoxG3LPKRANoutz
 KQxrn3ioIMolTxkemRDQQxy2eAkHNwTaDg03xFtd2gTsszxks2gqAHvLk72GDsIf8hCa
 EvZOn1TLlx4v4FdhQSGYZlE8nNIJNzJEvdhMEeogQcH98yAz9OKuoGXmN6G7Ou9tmPsA
 wEgCIg+vW4Zb99nABuiWLu9TvFkH3KelKvhsafo77eSkhoByoXn06bVCwi8PW3OQMj8D
 tF/lHxXepwAJco4k5zfz0vUf8leO1B6o5xLI7mlT2pV2sVtP/Wy2yyNtMjstUQmj5iK9
 Uy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777503533; x=1778108333;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7xWv3VUamkN76ywINtsbIbNrMYfkXIaAa/gU/P4rS6Q=;
 b=S7uRgBf5DbypdfFT5ol64Mqo45v+sSnItyyAYtVzFT6fyyHEj7eq0R/cGGUzB1qjxi
 Q/ulMCDPqfccUM4gW/pwnwqcTM1hkSJq88F+bKIBafgxeRxufkWIA6kATfQTUF/LPUee
 8vOnRp4XlbR7eSAX47fHeojI88Z9C94Wx2itd0gYOlF4fGHMcMXQT8wcyPUoSQc3p6dL
 arN8sfs8YHum7Hu4estUcCoTEeXBiO33VVDZOzhCkF3jxwFjadDVo1KDmkh6RdRDotVw
 B0A1eT/p+PV5VnUgPWq/kO9ZnSWAtMxyWXiLmIvZJxCfr4OOr38Guh5LT3J12/aO00xD
 E22A==
X-Forwarded-Encrypted: i=1;
 AFNElJ93uAEK6OigRx4vkWFKeYwWMy1EPqwm1gZ8okqXBm3u1CiKief07c5Nxgmaw3Kaey8M45OgiZfp1PBL@nongnu.org
X-Gm-Message-State: AOJu0Ywr1T95AdIB69xGi1O7akQj7nJI0L2x0xd2C9cTV21hbux3TWTP
 mBwS14q9WmVQNbEppasfBGCu9nNdOuCLIEnx7cIhSxe4TQg27O0lVuDO+eTjZIzXe2bAcPx6LLj
 jSiXGL6n8psi4r9SeKN27eSsnNoPBNyBgjNoI23epIaIWlFHUz2ALnxgUhA==
X-Gm-Gg: AeBDies4/9d/PXf98jaBFps+N9zETKBPPmEFXfkE7d5zMG+t4iCLnLezA3fIn2aue7F
 4iU6K8LBNQMbewSx/PugFOAo/m2WEHWRXtxXmC93U1yFQnfjDDOHWAfMIeCQQC4/7SZYcD8+Dvy
 1Rj8yIAb7zXvr5i571Tx6ZOHcK1eq9Xu1x8TsAcKzhjzY1QWnK1rW16ARNYgjjvoWXhpntvlkCB
 YaHKMuDUKi6m4gGfy9ZI66EMppYKHZr/AAh4rGAyLHZHnTUAwCTKLNkmZ7oEW0DFOHdvSmCQAmi
 TFqQT39SIuIlG3w1uTEDzrWoquw35pmfhClSG/Br1tahwFr+kSyMkganTpSE21gogxgw0gahNUT
 XH578P9xnoi1VWdQeQnhUtLW4mKiGmc75foXOVw9ZW7sc2FH6wQEprsHmzGalO869dYm1VpcZoC
 If6UEWk+VNzQyqwt0ZRczMg1io
X-Received: by 2002:a05:7022:f8c:b0:12d:de3e:86ac with SMTP id
 a92af1059eb24-12deb0a063emr224920c88.42.1777503533282; 
 Wed, 29 Apr 2026 15:58:53 -0700 (PDT)
X-Received: by 2002:a05:7022:f8c:b0:12d:de3e:86ac with SMTP id
 a92af1059eb24-12deb0a063emr224906c88.42.1777503532750; 
 Wed, 29 Apr 2026 15:58:52 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de31ab65fsm4588792c88.0.2026.04.29.15.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 15:58:52 -0700 (PDT)
Message-ID: <53f10ee4-5785-40ec-92af-c7b1fe688c1b@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:58:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/17] bsd-user: Add FreeBSD cryptodev ioctl definitions
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <20260429-ioctl-v2-4-288639bc2427@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-ioctl-v2-4-288639bc2427@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzMSBTYWx0ZWRfX+8tK0FNEuyTk
 h1qKXlY7C/jyxaST09kxSBP1Nd+TiBbsru3gBK0a7x0a5WT1ti7KHCfP8f4x4SWHM0DPdwkxbLC
 R0Abn21YDvn9cGMVhehDr7zzfytHxL8vGTpUqnQnXmbWrKNkGMG+U5tnNLOsUKDqnr5iKq13sef
 f5T7C3OL+7/geXHj66kGvT84PmD/mMOUYOXNcZEqVfWD7d86IlK7iOVSeKwyxkiHmCrMYWyK+7J
 6EYeT8f940MVqFrNGN1pSOyOtHPlUHkfNBYhmUhuxFML2RprBN/1ilkKJWQnwBpmUN851H4tLl6
 ElxRd2GXyt69KCvHf2UHwvBWBJxPCeMUu9vx59OOHf0vov5gSAPL3Q7NUPgXOqlyDr256ul/InX
 EcE9BoOJI0Y775m0BGMxcGgBkhQieR1A/K6QLm/smI+gUrneIkSORjdN8+xkzlQStZ1g4HiD6uS
 Ja9it1EtdGrxdWUyYmA==
X-Proofpoint-ORIG-GUID: 7cg6H1GE6htiHE8RqNh8v1vI6RJJ4Py7
X-Authority-Analysis: v=2.4 cv=O5oJeh9W c=1 sm=1 tr=0 ts=69f28d2d cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=9yiwgbtT8N5BWU4cbgcA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-GUID: 7cg6H1GE6htiHE8RqNh8v1vI6RJJ4Py7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290231
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

On 4/29/2026 7:45 AM, Warner Losh wrote:
> From: "Stacey D. Son" <sson@freebsd.org>
> 
> Add os-ioctl-cryptodev.h with /dev/crypto ioctl definitions including
> CIOCGSESSION, CIOCCRYPT, and related cryptographic device control
> ioctls.
> 
> Signed-off-by: Stacey D. Son <sson@freebsd.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/freebsd/os-ioctl-cryptodev.h | 74 +++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

