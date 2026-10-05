Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C22CA5FF5
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDimU-0000ED-3S; Mon, 05 Oct 2026 09:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xDilm-0008To-MV
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:30:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xDilj-0005ak-U6
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:30:18 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695CFbOT472550
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 13:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /iCgxSwi3RoPvij3TTorlI9rkpxXQmuhLqHpTg4Dmx8=; b=mWC55rueulo0cyec
 4DHpszLix4/EbA2Z0EiF4sqEFype7emqWTYRQylDT/227otnYQiXxSeKo8vhh4/n
 pBVA2/zSDvKYkZ6HI1TD+m5HHQCF1SdD25Z5Rv61xMFW5vVr0oxH8nODXq7wotUP
 8kAHBJhjMqrd8hG+Wliekw6YFsw8r2LAsYw8QKQ3dqpsZ8o5D9jYkn/MDVJK08PA
 5zoWWRSubhPyFCziXILClpx9wnt5/vMFGLD/eeYki2ZezcLzItmzcB3cyTN2izRA
 oHCYIDEu/pe3jPOH3rdC6TRgALil+PLrtHfOC49ERP0RvUGb0B4umAj58UfDA1gy
 xHe7zg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2tvewyqy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 13:30:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caa0ce0cdso191625385a.2
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 06:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791207012; x=1791811812; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/iCgxSwi3RoPvij3TTorlI9rkpxXQmuhLqHpTg4Dmx8=;
 b=Bigu7sV4MfQI21tdQ8sOGLJ53NgKEoEWY58+1BNnhdxNRM/AHZ32hzWjzgI6ptzY3b
 L1wC6oNMk49Z09Ho6asBzBkrgVTkPE+W6fRjxLhiPPAVx8jDWl2Wqt4hMAhC/fwVW61F
 Z+yhU591UABNknKRXx8ggB/RVFYDdyrFJp2+oawCnCAgYa2Fldv3UMLvy9MeHbF0ab+v
 0n0nqlOP8mKgtCdK9K0giGOw0HPJDgeMS75xg3w+pxGr7BpSNXt1CfrJ6EypmvLO7QTV
 ZON4Nh3P5jrX85RCKudUcpLLDrPuc/CbzCyOa0DT9PXv3BsWu61bqxCrYQ7u8w3Q5dbp
 hZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791207012; x=1791811812;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/iCgxSwi3RoPvij3TTorlI9rkpxXQmuhLqHpTg4Dmx8=;
 b=XZl1x5Qbw8b2+ilRj6+XKaBokZtvQhRcLUcJBvxB/4+N8xXhj3WCQZMzMJ/ltgAE9W
 M6jC/6mFU7mmMt4marcma60ZUopSncK7LX76a3VfCBINa6Fn5g6NrDV9h9qL5wsstKWr
 QytPJrFgkQd/lwdLLZc6Yj7kIIVGCezbGLl0HPpuTsQBDvhS/KNZuKG5VTmWH732LFJs
 7gON28otCxDyq6RUw1jNU9K6jh4QGZ7z1wQZJoJ2mNeKK4X5ZZRgHojyio3wdniyzwpT
 ouDj013qlducXPwqlsbgorIba3LsgMmB7SA4qxWPBxfGGUNaPncxErOxnM9ZcNLe+8WI
 WWRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOcbipU1z9TpIkkseTv+EoicBKyg08HaBuaXEgr/9d+i6wEG+kPKhbaxgnKiqep5dn6U7Wg+FdfVRE@nongnu.org
X-Gm-Message-State: AFuF++nWheLOsk0TKBaQpZJ/FE4uzTMwMOJjrbFeAQeBM30h38J7JbeJ
 ttI1555Wvt3Y6G3PMcgr8ukEUkGTjfVEegiJY/zag564JJYkLeqB3XU5pGMiYXVP32B8QvYS/hf
 XkDg16ftjkC1cK3AjiZ4OKCy9w9kCSwqfnP6waVnGw3W56LJn/MIITC1X+A==
X-Gm-Gg: AYBFou3EcpoplHM9XHdnvkoMX5e85mryj1Qh069inzKFurh8VNs+bkU3ogIr/P2whRP
 DD/g1DgnuzMxhaVUO+1stJgyJCMFYdTzR2SoXeuWPTvYrSpzP1E9dAyeMhxQgXSG9fZ23vcFOe5
 TFnuIxSsZI245PLV94Rbj7l936gvCEmsZ+nEXUJp51AxbHAj8dbllzwlP2jifHOu0/ZVTVRelTQ
 0atIDXrseFECX39dqvhLuN+jRUFM60C6kjgVvCfTejs8PDIVqeIz+nw/YTQTwST2L9Rk9urxOSj
 /4W6TNv6enZ+hSvqhbxvTIfL8HI9HmtY5oodJwhaxUTTmqTW5LDEt+00ju/6z/hat8vgpGvE9iu
 hEStUPaJBE7KvwoOKgC7VS8gZBeP3/Wh4IQ==
X-Received: by 2002:a05:620a:6f93:20b0:93e:78b7:fa4e with SMTP id
 af79cd13be357-93e78b808d5mr219632885a.37.1791207011884; 
 Mon, 05 Oct 2026 06:30:11 -0700 (PDT)
X-Received: by 2002:a05:620a:6f93:20b0:93e:78b7:fa4e with SMTP id
 af79cd13be357-93e78b808d5mr219626385a.37.1791207011240; 
 Mon, 05 Oct 2026 06:30:11 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622bb17esm3500119f8f.45.2026.10.05.06.30.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 06:30:10 -0700 (PDT)
Message-ID: <63427797-e8ed-4345-b8c7-469d20865165@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 15:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/28] hw/ide: mark ICH9 and ide-hd/ide-cd as secure
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-15-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260911143627.2743803-15-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QIYyfkmsFADOmWmZi61T_gFuuX0goM4L
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1MiBTYWx0ZWRfXxSXD4vG4N97C
 oSlSy0V6TU8movC2LRo8Zss3OnXrpDwDyijT3uvu0/ZOWD5K7+5cqOqgZD3JatDTFQrUQx/ACWC
 IKPby+P57ucsdR02CoAyiKDFK42wvZc=
X-Authority-Analysis: v=2.4 cv=YoGa1IYX c=1 sm=1 tr=0 ts=6ac3a665 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=6wYS7wvJjY0OpNKrp4sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1MiBTYWx0ZWRfX7ZnyLL8Z+2E6
 egQ8WZuitnUAqqfgKdS4XMOlj1wIX0sq/L7VkTYhCT7V/FgZVcKjGuBQNV95zF2XYJpExWc78ru
 oB4ECJpFT9/a1nj1XNPkEpZsf0VkQxy0URuaYDHqH7LhqRKoH5LDfjw4afoag26LTWdIH+YzwLd
 vNrK89u3q9fkpaMYAOemW8izMmDpiQLa1A1BH73NbNW6ufPxwRyYb983qqc0+sIxSuoF282kIIK
 yvsgZx6bd9BOO90Ams5XR0pYlte/CKWq3TyM4Y1AZmcdq/IyxKgjG85EHnfCZhAzor2gbxMDWRN
 giFNF30ju1eiCKjz7X4Oqs/2zeWQWweCGPZjypzebZ9OSAhUdISvUmocmY2uVEP5U7rkERScqo2
 aYfehDZd/9D4ttKBuF689pMVNCYFRJsASzc9ZIwTPsvfzojkP7yhag5KHMUTU4smjFHcHE1S43D
 aSaTTUPI54H36cuMnWg==
X-Proofpoint-GUID: QIYyfkmsFADOmWmZi61T_gFuuX0goM4L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050052
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 11/9/26 16:36, Daniel P. BerrangÃ© wrote:
> These have a long history of usage in virtualization scenarios on
> x86, for OS which lack modern virtio drivers for storage, and thus
> must be considered secure.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/ide/ich.c     | 1 +
>   hw/ide/ide-dev.c | 3 +++
>   hw/ide/piix.c    | 2 ++
>   3 files changed, 6 insertions(+)


> @@ -252,6 +254,7 @@ static const TypeInfo ide_device_type_info = {
>       .parent = TYPE_DEVICE,
>       .instance_size = sizeof(IDEDevice),
>       .abstract = true,
> +    .secure = true,

We shouldn't accept abstract secure device class IMO because it
will be to easy to merge new devices that ended secure and we do
not want to consider them. I'd go a step further and assert both
can not be set together.

>       .class_size = sizeof(IDEDeviceClass),
>       .class_init = ide_device_class_init,
>       .instance_init = ide_dev_instance_init,

