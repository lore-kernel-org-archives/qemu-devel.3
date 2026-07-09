Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78174C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 20:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whvpc-0001cy-4L; Thu, 09 Jul 2026 16:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whvpY-0001cT-F7
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 16:58:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whvpW-00047K-Oz
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 16:58:48 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HXdPt2473867
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 20:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9AIAaNmvsL8ISBpc2YtYQnRmupFI/LoqbxcPdGn5ebA=; b=KB6SBkAS1RlXRY6C
 8bLyWgVB+t71M10a82F8GdTmd4ISHN7gFvcI12TtS1p8LluPDnxpWo4QBU6GHJgC
 DulSR2252nD1AH0nTTE1FvDfkMquHXfbVHpaNQ+hBiLX8i4YGiefbfq5EQ85xYQY
 2WV1Y149H1UfS0TKi0d8aNjZABbaW+wGYWWSxCs6Uy7WcvpuLsZaLLoaWe5jv+dQ
 WIP6oQE/tgaAzVFln5vZIn3Lvttts1z0aSyx/NfnzukLzO50xfBQCz4vfJuz34xQ
 A6b2bCkFG/dnf1MUUMwyw56cHoKdUsBxyAzMo9+YYsSeKUEvh9LZji9VvDyfzeOp
 tNY7rQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqpj0pm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 20:58:45 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1e6f602cso3610881cf.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 13:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783630725; x=1784235525; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9AIAaNmvsL8ISBpc2YtYQnRmupFI/LoqbxcPdGn5ebA=;
 b=QJZ40ZO56JIEWpN9AuIV2C5QxgTOhSGrfd/9cEuWr2wzMr+mXxc3h1fq8dQ2oNpy6D
 rFXp5Nz0b4bXYJWoUsbYPrJQwa+r8dmeAOrtqilnuilagmwL5tEu0g9Wmz9OGGbWmuiW
 Vv5kNkpaHSVKQVFhHxz9BUTovNgdQ50VJhM5bLTXbLUL7cGQ7/CEPe8ZyJYApKwyYzRz
 j+t4QwqFBt/HI37n/6ImPb38DAy01HFEFqUrhj29JlJtTmQ4Upoh0HtM4NnvpLyFGWaj
 kHYjFCjO2xKndosIhsiSaxc2ghNj8UiLD/kPIKvEFOe8gvyLFokI3vTjb8LaRG1txBNb
 2POg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783630725; x=1784235525;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9AIAaNmvsL8ISBpc2YtYQnRmupFI/LoqbxcPdGn5ebA=;
 b=FeMUdwVFP6OvPjxsV51MikN8a9BOVPznRVJiCoxYtRr1yX4J3a6ZqiWeKFVKX1vwUJ
 R1RTmwGm8FbDQ7JD7Vk25xF8cZzR5MUG2/BV7aBVgiBQK/k2D+AbrqG0UuuIq9feLpT6
 iXEdnPJQC5p6PRbToZqmtKaEv0gyh9kGeAATcy6GEk5pykdt82iNIoZWWlK8TtHtQ5E6
 nTqji2bX3aKDomBi+9/qHdpJpU38Y8kisAsjMHleKw0CCuHQFX20tMfYF5PTU8LuRLzf
 TE+9xhvhJ3gVoNblLG+9TErZjraslyS6NUiZXNV7TWBIXONoPKGhIFxpFtXQL/Vu0U98
 zPaQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXhnM9C8tl2pkZX2JNYAN/tW399o5QA7Jk18BjR/6IOQZ6ZfRSzNwGPoRQ4Oz3EuPpyzsffQ3E3rQ2@nongnu.org
X-Gm-Message-State: AOJu0Yz2eP8VbxkXzFcARHVXjkSrwkceSC2+XPhSO1RVGvMPWcs54vnc
 TvtPl6PSpebyKGvAe4z9T0rWa8ldpmNT1MCy5wrVhoA6Zz4TpGnVSbBxpVmJ3uJShrshhCg++/d
 0LLJACG22g/F+JxFXa/498X/sld+VfE7WkPEq3ijnVapcYblonlzbMg51EA==
X-Gm-Gg: AfdE7cldA1x5IuTWr26cpO9BGEvLsCMzQMJqYOKDn/U4HS5KdQtIZ6CPAKhoYLXhXdG
 lriO6ZyPSIf4ZOgagsuF7sh15aYYM2R0FdC5gylLLcDmQ0I5IrUk4V7DDVXU8rMlBS//AiW9hFw
 y5GM+Khls5b84lVWUi2G9KAjznx/pHtJHCyr3/9b0JZ6igHwyuhp+bxy1E2BvWSLu/k+OKsrB8M
 OL6gecqDWcthdUpy4LcUAmCSbo6SBPMVsfH4A8Iqy8KA7jRLinRP5TTph7kHsAIPspVJQpNOwM4
 2aR9sUJjuUGYvRkX6YQA7SzEnAW/ESNGUYrJOhTgVCNdfFWpBOpnKLQ4umHHWkiA3XtFKvL+teE
 86d96OANmWApAaJRa4dwSgUbi2ekDEa9usze8gG3arn2kITL0sXAEozi+9GGe1Q==
X-Received: by 2002:a05:622a:5809:b0:51c:7b12:120c with SMTP id
 d75a77b69052e-51c8b4bc4a3mr115917201cf.74.1783630724744; 
 Thu, 09 Jul 2026 13:58:44 -0700 (PDT)
X-Received: by 2002:a05:622a:5809:b0:51c:7b12:120c with SMTP id
 d75a77b69052e-51c8b4bc4a3mr115916811cf.74.1783630724235; 
 Thu, 09 Jul 2026 13:58:44 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e6ccsm54352057f8f.5.2026.07.09.13.58.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 13:58:43 -0700 (PDT)
Message-ID: <1f4c48f1-55a6-4565-a008-2a265fb88cb2@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 22:58:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] pvscsi: add a comment to explain the endianness
Content-Language: en-US
To: shankerwangmiao@gmail.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Arvind Kumar <arvindkumar@vmware.com>, b4-sent@kernel.org
References: <20260710-pvscsi-endianness-v3-0-27fe1c4d1f6e@gmail.com>
 <20260710-pvscsi-endianness-v3-2-27fe1c4d1f6e@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710-pvscsi-endianness-v3-2-27fe1c4d1f6e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDIwOSBTYWx0ZWRfX81/+PwDfI9G3
 P5VdWGnxz9JKxYwW+V8jZXH1/XzZqS6lQqIJAFBxL/6bD1UIVq+2rqHUE1UlsmCv+o7ssqEjNRP
 8nQ9oUes40KAEqSTArq2faFD64m7yBF1zace7QfUAbVOVtfLgY/NwHjfqyIb7fv9v2BWwXFBSQ0
 qxXph5HqW/aXITxbk7uHZDy6AmnxRXfD+ft8JVS+3tYwYyaOywp24vGZDOMntxJaN5vFRD+Yo17
 VCNeTlTzOS69QUoNL84nSw2adIj/RU23rezlqOes8c7vJpV5a1SMAcpS6TMo3o7hYHkOL/+qSjH
 fdod5Xyahr8Jr6PYOgSuX69GrnHfQ7P2D2tVLVyN+wjOfD/FKLRtWQu4NmypciG4x900N79GKc8
 epuqu3MYrbQ6LUBBuy6l7IEr85UIGuVv30L3yHLeFDSG2ChKv7MfsY1514SnzHvY6n+Qz0E6h2x
 d9vYbpPsSU+WC0/RQHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDIwOSBTYWx0ZWRfX0F76aUWDsu3s
 GvfR83UO3HuYtVkGorNkv1mU3eXvqiEQ3IS9N1iZobhL2nzbzzDs7meKllI26UVD96lKfKhgT4r
 FI52rdY6it5d60iYi9n9aVkTT4ROhVo=
X-Proofpoint-GUID: lLwRNiguHtwcnbsK7wTdbe46M9T-bPBH
X-Proofpoint-ORIG-GUID: lLwRNiguHtwcnbsK7wTdbe46M9T-bPBH
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a500b85 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=yIBoU1TpJL-JTJq4:21 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=HOgezo58BSYASfIYu38A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090209
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

On 9/7/26 21:21, Miao Wang via B4 Relay wrote:
> From: Miao Wang <shankerwangmiao@gmail.com>
> 
> Add a comment to explain the endianness of the pvscsi device. We have
> no information about the endianness should be little-endian or CPU
> native endian because the current driver code is designed to work only
> on x86 and is not endianness aware. We assume that the pvscsi device is
> implicitly little-endian.
> 
> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> ---
>   hw/scsi/vmw_pvscsi.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/hw/scsi/vmw_pvscsi.h b/hw/scsi/vmw_pvscsi.h
> index a3ae517e19934c2377cd84efe993264917ecefde..defff9e179ecbe888194e3f31547ecbee801f432 100644
> --- a/hw/scsi/vmw_pvscsi.h
> +++ b/hw/scsi/vmw_pvscsi.h
> @@ -108,6 +108,20 @@ enum PVSCSICommands {
>   #define PVSCSI_COMMAND_PROCESSING_FAILED     (-1)
>   #define PVSCSI_COMMAND_NOT_ENOUGH_DATA       (-2)
>   
> +/*
> + * About endianess for the below structs:
> + *
> + * These structs are used to describe the data that is exchanged between the
> + * guest and the PVSCSI device. The endianess of the fields in these structs
> + * is not defined by any standard. The current implemented drivers are designed
> + * to only work on x86 architecture, so there is no endianess awareness in the
> + * drivers and thus we have no idea whether the fields should be in little-
> + * endian or target native endian format.
> + *
> + * Considering the above, we assume that PVSCSI is implicitly little-endian and
> + * expect the fields in these structs to be in little-endian format.
> + */

Thank you very much!

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


