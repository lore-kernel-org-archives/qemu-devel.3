Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D9BCA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxTN-0002pN-9m; Wed, 30 Sep 2026 12:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxTI-0002mn-5d
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxTG-0003Bd-O8
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:55 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UGjO4s4035473
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4e8R1nioCLdL/WYy1ipIEd22cMF8IgajANlm3emMgYw=; b=ESg9DmuP6luiYj4J
 tVtuJZZFQ3ZRf4FvV0li7e+Mzb4NyXi90Fo9Bw+z6NduA+3DrGIbRBMJn13cY/kG
 JUn8g2XFKsFZM3TFQgEA+wh3HL4FTydzipbCRuD3MdQo0uglbmn8tHmVxztMhjMI
 AOnbr8xVAUF92NxX8TWDTAsw31Pr3u0D55GU79C7FRQWCnPUaM6yzaHp2925u2W4
 bh2Bj/gBbsB+5nsl5X3U1g0iPCCc8/7jpjOIILAbmRAMCFhyUJ1WIMfi8wQwwr1M
 mlW9B5e3Qet2+5+2Ud/OVVxsRZyQJY0Es9ydd4S6fircmB9s6EKoLCzlbd4HV5zw
 OAIFkw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h167pg0r6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:47:53 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7bf67e46ae0so49473137.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790786873; x=1791391673; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4e8R1nioCLdL/WYy1ipIEd22cMF8IgajANlm3emMgYw=;
 b=V5JXEm4JKGRVYyNbwv6ifOyj4CZCfsUCyPogdlVLkzEtqOiiqYcRmvz9cbyQkwEMWG
 +0r0RbAWoPXKzJG/lmvrYkpT8ce7nGqaD6Dl/2zN6I3W1kL3/ZA7iGVbHdFfYwdEf8+q
 uKjo56jzsBW3zCK5n3qQn9+TOYRocJRs9tQvXF+jCD3hqb0wucXFTymZZpBMStEthOYi
 yUV/v9xTXmi+SgoPUHyFlBdYEDMs1pRZhkVMdsSv7sGcdCxSiTQeB86Bx2JVO1+8RDRJ
 QIFINa5s4GeHln5To+p37pc/n/sU+z+vzr/WJScBb/ip7wuHQxXU32PlYy+RtAxKeRlL
 fyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786873; x=1791391673;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4e8R1nioCLdL/WYy1ipIEd22cMF8IgajANlm3emMgYw=;
 b=bjxe2M9oYRFI8ZHee1qM/WZ2psho4x9difntabBjqi0BmG7VinwI0i9v23hMx0Da64
 k4SDhUv+NDgKVHjyCvDPala8u0DeOBXQ/4/Q4NcatZ9KF1Ahcq6jArR2oXlJD9oZgQYu
 roKo5y6181ULOtFGuBDv5z+iMau0jkdjIqnYBuZ4g38Uzwebvl0jtOJAhQo1FIQB7k/Q
 5yt+i4lb1emGCxF9qGsQpKnDtDnv1AxpnhJgsGytnFHFFnI0rZDLjrgTde7/sV8rLKbk
 FPTYoABXoaORpO3OLCqR28+rBcW3AnBXiCVKxkBT6WJavRqO0B4Dq7gM3if9911IqkbW
 jqUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjFFDV4Bkj/OO66KhYED3xfSYNL1zkbAlBZDD6T84NNSpUoTHUemKPe89o+AKm1at5MfKNrFcD980z@nongnu.org
X-Gm-Message-State: AFq9FYKjSJCpwR6S3PqoETvOpHSmL06wemzNCfYCYZKVfHWPK8NIUde5
 ZrU3ATcatXU3P+ePi7KwCapbFfSGkgYUr1l7Lxya9p7Rf+uvkmQvZhDZblbGnPeY/jn33//L/hj
 cOyViqWFuMc5QQKLc1vkg4jmuoewiop7wjB6TydmsDP5mI2CY/+163bdME2DuPmlAUw==
X-Gm-Gg: AYBFou1SSMy30RSXjYWNsmW5pCNf0Q4ptHxdohF9EObHE3mxY5y5eENbuWqFJWAws6h
 Nf95gaRi+aWLLpa+ejtw9rCt3orl+KXBE4sHggNKlFPAo3Xt9TQ4TYYDmYS8sQrgfYhes+VsaGu
 R06CbRSUmMZRiFmvMfsf6qxeLgD3airgExiex5YVN2nz0s/E7+ZK/NL3BhMCGYe3z8Ui5QLrxyf
 oHGov1BLSgjDA3MgadlqYHxe7vQS4wjxn0cQZcJyS51ZysnS593sq376vk4H24NzIFi8+xq+EDj
 ChPW4gZhcu5v04eGm2nzVHEzncoXFzGE6QUtG1Swhq8BJwbfDyIWMPfbsXqly5fhUphjyLMuAtH
 J/F3Y9qpA09Lzu4lWT3E=
X-Received: by 2002:a05:6102:3ec1:b0:7a7:5355:7fb6 with SMTP id
 ada2fe7eead31-7be73a8e63cmr363151137.24.1790786872823; 
 Wed, 30 Sep 2026 09:47:52 -0700 (PDT)
X-Received: by 2002:a05:6102:3ec1:b0:7a7:5355:7fb6 with SMTP id
 ada2fe7eead31-7be73a8e63cmr363142137.24.1790786872334; 
 Wed, 30 Sep 2026 09:47:52 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01cd002bcsm24562525e9.4.2026.09.30.09.47.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 09:47:51 -0700 (PDT)
Message-ID: <a5a9a630-c9cd-4520-a49b-0412a5c6e5af@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:47:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/27] hw/usb/dev-smartcard-reader: correct
 CCID_IccPowerOff
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
 <20260805-smartcard-fixes-v1-26-187ee9122441@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260805-smartcard-fixes-v1-26-187ee9122441@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AFQCtTupKEfXhH2Dd6cWzszNYRCX1fFw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfX+ilyE2lCEolN
 lubjdEYvIMzAlEnE/TcyBacoCuFCV/xVYF4XMEDG9B2iipYHNXag0PPkjVIU9Ne6gpCqRVxEKjz
 pM0z3duRp5JUhHFlZza5DMPSmQ7tqYg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfX/7tEGetHMhVr
 Z8glYfzX2KppqSteVOC9oNFHVPBDIGT9+EwfTn7CcxLQ/o6RrIMZr2uF28WkxyeNtqUF8ybT8c+
 cNnJ9el5YvzEtvYZ4piCWKZj3UaZVX+/1gUI1h3MUVXjrAJtlmM0dZFx8zc2NnL6QfZoB2odC2W
 cM0jLSKM844bjWcaEu9FQMvk3hbH9R1EccJ0JTc0sIbVWU+IJAh8qqE38C1B7VTW+TIZiKzynor
 pA1soAMOQTIeOiwQ3zZd/o4hvI4kdBZc/UFfCUcBa6YidTmrN9RyRwyD/NNIFnyxgQDbvYokC5G
 2hPaxR4rjQpzIee1fgx2k9oQ+eGqd8bUptUiwJyrn1JfHEFE7g86pGmwiH0LRt7lV0RGe+duW3P
 BAc4uwFi8wVmRZqHPhnf7mOUim21/ugMTwnCV6yksG4O44+EvckZ+Y4KA+Ix78NN08E13MUsVoF
 HtS4CxAjmozwlGoVFwg==
X-Proofpoint-GUID: AFQCtTupKEfXhH2Dd6cWzszNYRCX1fFw
X-Authority-Analysis: v=2.4 cv=WpC+otfv c=1 sm=1 tr=0 ts=6abd3d39 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=7g8aA7A78AY7OC82r+w+4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300066
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

On 2026-08-05 13:51, Marc-AndrÃ© Lureau wrote:
> The struct has 3 bytes reserved according to spec. Fortunately, it's not
> used yet.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/usb/dev-smartcard-reader.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
> index 99086befe0b8..752571043ee6 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -264,7 +264,7 @@ typedef struct QEMU_PACKED CCID_IccPowerOn {
>   
>   typedef struct QEMU_PACKED CCID_IccPowerOff {
>       CCID_Header hdr;
> -    uint16_t    abRFU;
> +    uint8_t     abRFU[3];
>   } CCID_IccPowerOff;

Nice finding...
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


