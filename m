Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1867EC982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8czm-0000Iq-EQ; Mon, 21 Sep 2026 08:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8cyt-0008Rr-0F
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 08:18:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8cyr-0008TQ-5r
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 08:18:46 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAeSFd1564800
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 12:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F4OoX0/Fx8SVAcVljeJXU1QZe7ziL1iNgue/y49drME=; b=G7urV1buPQ5tGm4O
 ZGwFIQx7tCDwRlX77kmgUF7HoIZecXFMScgiN6z0YUZKg1Z3rnNb2gKkW234Q1lP
 XVlftHeUDJT+Id3Ppy+KpEjOHtJY1TmzJLb03fOb4dCe9lyX7bk4vopgwSYYtkGR
 OXz4fndxQa+owMn3h+5BWoJRmAkqawzjiZDl1xzEQluS9bGKnKCahwOY14/IjJPU
 K6Aa8Zxef1SPs6I61OrH8B0wZUeV4Hy/IiA2JytotlMvGjippZnfrDcX6JJtjtDg
 SMYPaD/EY++9xfKmsNTLBLF4Z6fS6wa7/VYP8yLLVC0A4r4KhHDt1iFireIqyGIe
 5Oa53g==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtysw17h1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 12:18:43 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-97cc46a7765so170528241.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789993123; x=1790597923; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F4OoX0/Fx8SVAcVljeJXU1QZe7ziL1iNgue/y49drME=;
 b=kjvT1eP0Fkem4bpZ4FpX/Lsnr902QrtkGTC8OzcWyfsSJbYkhAJ1ZHQDEkQXY7IFD+
 Yz2SSe6C7+JKMyije4v92ihfKW9gtZ7HpxJSvCfOLkbs/nUSA+pFQfOenVUTTvcwBK2j
 qRizKuXt/K5VavW/eKT2HWwX2QYQQsR8jOJm9+D8vPyJwg89ou4aHPgmeWckI50KimHn
 aN/NYcm7OyEHkZm5dbviw51Xvjcf5gv8jbWPoBWUl+nZInsW0wTdgv9RXzK/WFTVTBD/
 +Q6JttnqFhvf7mpwyHkYsfK2//mv9SADM714LUL50eRSXxe40HtIA2e1/x3X55mB5U8f
 DrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789993123; x=1790597923;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F4OoX0/Fx8SVAcVljeJXU1QZe7ziL1iNgue/y49drME=;
 b=FpFi0GLH/zC8sOsZObh7D/ZCwGslDawrqu02/7C33dk57TsXzVPiLEQ4GyrbLaasX5
 kMtHGDM5DJ9nosvkG59l1GKCdn2YAKhNOm8+3Zs7XV1TkxfvgNdUgzNgSs43pJCXO1wo
 2YEeztGrjh6kI84OjePIWxwoq4H1q/O1yvGZx6FgWIkOD9p/L8h/lEhDAIHcRTqKxKfl
 EOCJzyTFKWV8Wf0c9e++91BH4Ge8JFX9jeS4gjEA1X2NT3I302ORakiKlGleCu2nG545
 xngELzura1GaWHyYlaVJsSAniMJzCVdPPxQ0vjKpG0owFnN7GbcbtSJjpVIdgHeDGRgk
 uFAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9pNAn2iDXMgUe9tppOKWOPMnB/48dxn0n3gHFBgBXvTACMuhj/yglaRmlrQ5E5BoztKSG92JP7G7r@nongnu.org
X-Gm-Message-State: AFuF++lQ45/JdlX8YvoizXt3sdCpURIg99FVUStajY7piUIofgXKfk0t
 Xov9FSs+BZzO+N5YZwRYo2WZ74ebYMnjZbg+fRo1cVzDFgOixBucXknpBJsj0nrP+hS9QIOxBrr
 y7aloXa7OLWubYfHANJcXxndCbR6QRPM4YcVJaewOb/KGtj3F4/kznFTv+Q==
X-Gm-Gg: AYBFou0cNiK5VDdmt1C4rUvRcxjIzEXX16VjUEHVxZlN5tXfTfA7RWlB6etFv6Qw1fo
 iawP/6eE3ijpxXzJCnmGGMgMjqr3KVmnICqvm+0TwdHd0mattIWT9GdZuMs1Xnf75VsfRYYbjGx
 KIodStl/ocHsLN1gk+eyHvt4mYWvonn8/j28PcoiMVcyH0Iz/Mhe9yUL7fTYZVHvwj3gsz7cFyG
 33LnTdbLECqU4sYg97Ijw2RqyfSNcqJl02ogaxjvZcBEsAWXj9H5KNlT3MCwvvunp+pvOVnLByU
 zSB7xyK8Y7OwtgcDHqH86J8JTIaCA4jpz6CZ2FG8pN6vm2O4rEguJF0z8IAx4gzLADRUvvT/N8S
 sJ9bAJHIXAMRlSs+hZIy0tIkpEz8hMwC3BQ==
X-Received: by 2002:a05:6122:e252:b0:5c9:a618:bbf7 with SMTP id
 71dfb90a1353d-5c9b5a50960mr4052192e0c.23.1789993122794; 
 Mon, 21 Sep 2026 05:18:42 -0700 (PDT)
X-Received: by 2002:a05:6122:e252:b0:5c9:a618:bbf7 with SMTP id
 71dfb90a1353d-5c9b5a50960mr4052144e0c.23.1789993122052; 
 Mon, 21 Sep 2026 05:18:42 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8cb41984asm1285148e87.81.2026.09.21.05.18.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 05:18:41 -0700 (PDT)
Message-ID: <9407e177-7cbb-47be-bdc7-164583fff1e3@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:18:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mac_dbdma: ensure only implemented DBDMA registers are
 accessed
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20260914125236.820155-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260914125236.820155-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NyBTYWx0ZWRfXw9ewP28BEjoL
 z2TgY71VCWtbWvlvs5ZzRgrszaeofREL0LuiC3rNsn5ODStd2GKVgMFB1zIzrBkEv5xxIrMRpFC
 BSMRq4R4uAQM/21Zr9oddnTKh37ArinekHxg3HRLcusNDQ07N8xQqyuZHlLj02+pvdJYOIIro+y
 cQekcHF8K9kl1oGgzCH/RR5sbyH4WJm1WeevJQhS9Rm/gvTFXM4+7ptzGZvXFrxj9J98A4V7wZF
 G+Kh0Q7wDiez8zPJfNVNktG9MdmViJUoxJ9rxeqPf5haDpZ2pZ7WWFnffzKFLgRhf1uV1Evpb38
 QS2rCk82wUb7eQCH5IO+CmpI6sEilVN3QkqnZqhuQ5MY6hFcyNSnDE29/tMf/dm/49J9J5EalkI
 aT8whQDSD1zQrEWrTu0YLKf9Pvcqli8ZJeTFaBmNmTukyojB+yhHdAgpoXtu2oMSnMzYXePJvOe
 as01Md0c5EEOHzKYbBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NyBTYWx0ZWRfX2TaGMYNzanPW
 2KvI9jNX/8Yi913qHVWOMKKGzDvj50DkRXsAfIGhBoOR72IJyqr+vpkSLT2illqSSrEyjXPPxqK
 RLbD0z2G0Jgk2lpPeKvWmKhwBde9yow=
X-Proofpoint-ORIG-GUID: XCXhpkC9RBZX6aWYO6ehNdBWMoSsCBKS
X-Proofpoint-GUID: XCXhpkC9RBZX6aWYO6ehNdBWMoSsCBKS
X-Authority-Analysis: v=2.4 cv=W7etxhWk c=1 sm=1 tr=0 ts=6ab120a3 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pcZqCyVeAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=SGy6VSG0Ue1xmPAwIFl9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210177
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

On 14/9/26 14:52, Mark Cave-Ayland wrote:
> Whilst the DBDMA memory region is 4K in size, only the bottom 16 registers are
> implemented in the Power Macintosh DBDMA controller. If an attempt is made to
> access any unimplemented registers then an out-of-bounds array access occurs.
> 
> Rework the switch() statements in dbdma_read() and dbdma_write() to handle each
> individual register access, as well as providing a safe default for all other
> unimplemented registers.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/misc/macio/mac_dbdma.c | 34 ++++++++++++++++++----------------
>   1 file changed, 18 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

