Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3633BC982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8cmw-0005Iy-2P; Mon, 21 Sep 2026 08:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8cmp-0005IZ-C8
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 08:06:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8cml-00060Z-Gd
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 08:06:18 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAe1OO1563557
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 12:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mvKfr+3PO2ADtvAjEhvfAL3D8sVyCHJwIzFbOfmKy4s=; b=iVEQkTPDRaSBFJo3
 JFgPwcFWmLoeB5a4NVd7pxhH33PRNtgw60+s17ZmKb4vqcY2jfaskz9/T6YpuVKl
 mlwFyKXpbTuaKdouwLsBYgF8bRDoPpw1lxU7TTOz17f40g6AJ1J0F/WY9wg0bWVb
 /7X0w6rEDNrLP3yuLJBB3BnNnIm18q2vVoWg+/0/1WR3bxwon6yUGJYCc6YMBqP0
 5XzQA15EnKbE37Gsmuh00WFu4JcLFtPZygUFwdZlAwkqDzjrrbmxcnz+MrSChvEv
 21cT5RtoOeVC3t+7JUrYYQCn/3SLWVyvYRsLRnpfBZxU1AKOsUfZjmfrZr6SZd9+
 50NSNA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtysw168y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 12:06:13 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c851df59edso580705e0c.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 05:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789992373; x=1790597173; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mvKfr+3PO2ADtvAjEhvfAL3D8sVyCHJwIzFbOfmKy4s=;
 b=gY52SQTQQqOogODlw4gcN3TKrPkM+EUtUw12UDnEiHifbCse8PgcIJn0IPWBSq8QpQ
 BJXITtjQXVgC5qeE1lZJg6jRIohxXhEyhd+WrUNFFAu/opCVGiUly2dC8MwfK6/DY/CY
 uVAO+P6uDkfQ/hVvvG24knrM9PTgHqYTD72a5t3821i1rFeBEUFg0oKYjOvUBhrFFNn0
 RpPbwgWv2Tf7Uax8DmV1CaVxW5R2ugz8lpFsYv7G957ijrDDD0U7GTGWqknVrHZxuNuz
 1SeMuhr9XLWl10o1o2GAYEVmFrzxfG5V4/Lb8tdqE526UiuH/zWGqmCd0ixUDzQ5Obvs
 5UWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789992373; x=1790597173;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mvKfr+3PO2ADtvAjEhvfAL3D8sVyCHJwIzFbOfmKy4s=;
 b=vsnbM+JkJvb/nDebbDxb4grAiZJwr9Hk6BhKYvKJ/Z1Bh8NT3DVYCGLlWOuyS9Aug5
 04GTn80UZbVn1KIXfK7Hm58I8V6a39Dflr4/d9Apb/hEKAT8FPvjhkz8+wE2G8npfK0I
 qkPAe18bw0O1FxG5Mfc30qMABMXNOpnBxbyDqF1OnncDNN9gwKqUKVOCE/1JxLiAFxt0
 7mldLR4uMJWoMLLgBnUfy5FTKz1GF9bW8gW2LsIdgYYH5E5k5eCPsyfLqubcTSEXdFct
 24BCgAC3wQQkOKglscyafY3jwnn/qOSl9almJYgFcfzTvqSHjQGYHAhVO0LfMfWVAeyJ
 ckog==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGdV1LNvvmlkV9Vd81/LflYh3I4hPRRTWNJnWa+71cWTP44Llbmm+75Tu/6HnxYEDSnMr7kRzMkW1w@nongnu.org
X-Gm-Message-State: AFuF++mJyKsLwsVgLbEWfta8nxsAhiHHVnpqWro4/IQjSJjBoPD0Mhdm
 d1yoDtyQ1Bzph6fZ4FsBE7bDwH8cbc02GSznFCVkMr2DWqcckbc+Dqca0PTZrD/VG7V+uwLesSC
 XkH5cPpmI69iFoujzZoT/vM9vwcsakw8UoOlQQU5y5hsOW6k4g6xijp8mkw==
X-Gm-Gg: AYBFou2iE3zDt48eJjuWN+zDxoAZFxFxOBdpeKghjZlneqR1YbwghanLsrBkNgF/H6x
 mVJqbH0NAdOC1nOMtMThfqQGHVD01GSH+we316oHlzRfNhjAz1fB3sQefoDXsGGDPWeVfNC164g
 6RyM+NbCdR/PaA6xsLIqG8JDa65E0DmiJ4m8vVJl8BXnSwPO3ucAYh6+CDVixTSJqAtSEsWchZi
 GtSacG6tqIl4ooF2USsFgZESARs/j+2KLBwp5+yyI41orhfhB2pIAO7GeDKJI1OaDJ6ZlqL6FTh
 Gdv6CBBwy/ryxLBFVNd93Z9D5Qd+OsqIHQh+HcxPte2iFm0LKj2+3kICjgvUunZBHSvNRvgPgwA
 F0Z5Kcdh6gzVknZ0AzQ329mqXAhjcfNKOwA==
X-Received: by 2002:a05:6122:1d9f:b0:5c8:2ad8:1484 with SMTP id
 71dfb90a1353d-5c9b58b9184mr4677242e0c.1.1789992372688; 
 Mon, 21 Sep 2026 05:06:12 -0700 (PDT)
X-Received: by 2002:a05:6122:1d9f:b0:5c8:2ad8:1484 with SMTP id
 71dfb90a1353d-5c9b58b9184mr4677205e0c.1.1789992372284; 
 Mon, 21 Sep 2026 05:06:12 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724562aebsm24013070f8f.14.2026.09.21.05.06.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 05:06:11 -0700 (PDT)
Message-ID: <9a41b3da-0e33-4c85-b26c-2153ab084bd8@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:06:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/hcd-xhci: Set reentrancy guard in timer functions
 (CVE-2026-17588)
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kraxel@redhat.com,
 Alexander Bulekov <alxndr@bu.edu>, qemu-stable@nongnu.org,
 Guannan Wang <wgnbuaa@gmail.com>, Zhanpeng Liu <pkugenuine@gmail.com>,
 Jiashuo Liang <761232680@qq.com>, Guancheng Li <lgcpku@gmail.com>
References: <20260915112213.525283-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260915112213.525283-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfX/eflgPsFVWQs
 N5V56bBiaKJO0E7VvZJeIJ8yMglyWFm4xTCknHUqO2ucwu3GS+c4Pb/1kP2GzyJxEDdR70T+/f3
 qDFOuTgmBX+868Oo9WnfRqlf0GrxIAl9s571z5nb4gT80f3KLf2JurQslxD99V0K9wYk+pS5Fp3
 XXy6dg3kzVyq6GalQaW+7kDvEBYBt3K9UhwBtWgWjYe+1FaW1gNaiUy5tBf+jMD4AebxDcY3gbb
 EVFRf6QZaGBYhch9sEdGm47cA6HJEpkWlma4eVN0pU6EioGsvdQ7fWS1yCUYPffuXhtx59+lFT8
 Si5GvQs2x3AofAcuVLWonv+HqSNtwSQgVYdgi2D6dqpQNlrK95UFcem2Fb34d+K5MhEH+9HKUXx
 F7GTcI0wsUThq4C56FXNJU4+RCvmgpn4f1KFHFO9Kdv/cswejBTJ77lhOyXyjSNdo6RVBt2gsVz
 uYrXmq1ajAGwAVQER8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfX4lCG+nyZCHsh
 0wzohYXk5gQfvcBjCDW8/Xq+5Btafuce0TGECe0KaVDvWZDeARoGK6yivO8lYNV65IxSbBw0NaG
 y8X6UWBHXRIfx/w+ROryDGao2TcgldU=
X-Proofpoint-ORIG-GUID: Jdv7i-fCwDT3PSL_9SurH0mBZ3MqHpQS
X-Proofpoint-GUID: Jdv7i-fCwDT3PSL_9SurH0mBZ3MqHpQS
X-Authority-Analysis: v=2.4 cv=W7etxhWk c=1 sm=1 tr=0 ts=6ab11db5 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=GvQkQWPkAAAA:8 a=pGLkceISAAAA:8 a=dZbOZ2KzAAAA:8
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=3001DI4PujPnJtpnt94A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210175
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

On 15/9/26 13:22, Thomas Huth wrote:
> The xHCI controller processes USB events from timer callbacks
> (xhci_mfwrap_timer and xhci_ep_kick_timer) outside of any MMIO handler
> context. The device's mem_reentrancy_guard is therefore not engaged
> during this processing.
> 
> A malicious guest can exploit this by pointing the event ring base
> address (er_start) at the xHCI doorbell MMIO region. When
> xhci_write_event() performs a DMA write to deliver a transfer
> completion event, the write lands on doorbell register 0. If the
> written value is 0, this triggers xhci_process_commands() reentrantly.
> A CR_DISABLE_SLOT command prepared on the command ring then frees
> endpoint and transfer objects via xhci_disable_ep() / g_free() while
> the outer call stack still holds references to them, causing a
> heap use-after-free.
> 
> Fix this by setting engaged_in_io on the device's mem_reentrancy_guard
> around the processing in these non-MMIO entry points. This mirrors
> the protection that EHCI, DWC2, and UHCI already have via
> qemu_bh_new_guarded(). With the guard active, the memory subsystem's
> automatic reentrancy check (system/memory.c) blocks DMA writes that
> would dispatch into the device's own MMIO handlers.
> 
> CVE: CVE-2026-17588
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3926
> Reported-by: XlabAI Team of Tencent Xuanwu Lab <xlabai@tencent.com>,
>      Guannan Wang <wgnbuaa@gmail.com>, Zhanpeng Liu <pkugenuine@gmail.com>,
>      Jiashuo Liang <761232680@qq.com>, Guancheng Li <lgcpku@gmail.com>

Should we use multiple tag: lines to ease scripts parsing?
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4195
> Reported By: Ken Hsu and Royce Lu of Palo Alto Networks
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/usb/hcd-xhci.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)

