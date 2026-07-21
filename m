Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E70C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmBjv-0000lM-Ii; Tue, 21 Jul 2026 10:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmBjU-0000cO-9L
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:46:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmBjS-0001bi-Bi
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:46:08 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDg6Fj1958707
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 14:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W4tax+4womrDHSVHPvO7xC7d9kwFEVcyiYJ+ETSH6QQ=; b=mQKR4n+PHS1MRRS8
 gKnz9VZBhgrbAOcECkoFx5TswT8s4YaqDgYALymhLgF6G/TrsrmIf7kMVp7mGjz3
 4IFa+KgtGW8MNTWiNrpIbefKwrbtp2YFQVQKRKfIUBNh1xDBtWXSG37Oz+R/1bCw
 KA26BWJh3bH9hs4BFYLtPRmVZHPQWpOfwd1UFzN61eoOfHQiPOr+zHeWpJX3sHHZ
 vfWn0O4xHKQUCFuQms3ygBpCm8OEZxLx+lWrUp1ThIH8IYu9UDbCUx50bJZ2V+Si
 x+MJCLws8VM4XvH68YanOTJdAfdU+y6D96KAvrFDvDUqQwICYJwKUv31zDf+l1Wn
 bBAtSQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1bvu0r8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 14:46:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e11baa66eso8699557a91.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 07:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784645159; x=1785249959; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W4tax+4womrDHSVHPvO7xC7d9kwFEVcyiYJ+ETSH6QQ=;
 b=eC+HwdrrTrkjBKyGK2F8moeCVkvEkx/Yo7Tr1MHO/CyT5QYybe/Pzc9XByAZWyA/Bx
 hb59wcj07MEdLGi9+By4PeMmOkcibrLgxNai4r17uV5n3y/nMu1XggyCGoPUtgi2tWeJ
 tT24q9DAFZgCyW+zUpGAVdgKO1PovGsH+gizk/JfQCDENBUQOCZS196f8WpZOr7uAG77
 Xi73KP7Jxv9GpQlMC0nhnsGOc7Gu3zTaKua8FyCDDuJ5+9zijPMnILZLRnN5xmNNc1ZH
 wEI7z5aTsWuVUwamG7ZnyFojh+OvOcyyxG5PsEI073/5+zKdE8IppNoycKy853E7iItJ
 ov+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784645159; x=1785249959;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W4tax+4womrDHSVHPvO7xC7d9kwFEVcyiYJ+ETSH6QQ=;
 b=jYRUo9A+32GLvNX4CHG69OE9QIJK9CwpaX/HQytOyKjkNfCIBFMNmJbw7Q0KVgvCo5
 SEYn+Wo8Zh+srqrY8IyqcBxhT3xG+7811EjLZDbc6AgOfBZ+xwh8K6wnAIWfOHuqEmvy
 9iiKJpYM3+++VQkST7kikiugYm3pTm1qZYiZMQLbDWwlgMZOiCf+ZJhsC/7V3izcNDXC
 DB/q34RwNjX/BnIQj8Pq4noEQE+YBn3XsQiBu3pobfSQUfjmX0K9GpbRDjPGlSWtUrHT
 VFhZ++BWX7YSFmKcAonny9Qb6XhtVsr0u7zDvAXmVRqh8evuZf6bOgdQKNIbgtHY150u
 1isg==
X-Forwarded-Encrypted: i=1;
 AHgh+RowdQW6jBSJXvbVBlwBoLkdZvp6E20EzknfeQjydmc33wofcpCn1WWfD17RUfkEHAOrvfixVmJd1nKE@nongnu.org
X-Gm-Message-State: AOJu0Ywo+YE+COgU2zN9Y+m1kcB+du3w3jTAn0jZZWQS2ETaos5+lkZ0
 5lJvy5GbY/4rqSpL/XFvYpwtflCPSUJx2puCZr8h7K5n+cW8uGzqCXZ85Qos1ZWdo39PIAm0FFg
 ObbKq8kDJe6PTlE5Mr/bjurb3a+bnf9Q0rHWXv83mOIDSQcONDWKWyQ8PMg==
X-Gm-Gg: AR+sD11/5QmpDWxLvofcrBCoQVgzJgrXH8Iyg91afGcvSWHEhqUSQAhvO8EAeEtqi4C
 YCmlh5AZwZKxAQpHynk303woF27XX+vMnQFXQ2LuVkZBXnHLkojhgjHQ24tIuwPnRvaNXcPy8Ef
 dHtG04v4D46fr6qhETbse1TBX9POB5b+qEjQUWG6Jnvo8AplzhJfUODImUhUma66zfm26CwpBqS
 pKOOCx3AGSZooIGpxFHoLnPHr2+aPwbro4zwymyoZhjSbj6tGKpunTeeybDYbhm/w02vJLvplh1
 +Gcci+6o959hEsy196knkya6cg/lU8GQPGKNmFkpfCEDHyeOXAwl1LqNhj2tz+B0uSfsOTfwtkP
 0dDKyGdp0GYx7yAAJAbN8n7abW2Q0E1Yd+5+HF6/JG9Folbx8Xdt2Uw==
X-Received: by 2002:a17:90b:3886:b0:36b:944b:fd81 with SMTP id
 98e67ed59e1d1-38e4b3d27c3mr19244493a91.4.1784645159109; 
 Tue, 21 Jul 2026 07:45:59 -0700 (PDT)
X-Received: by 2002:a17:90b:3886:b0:36b:944b:fd81 with SMTP id
 98e67ed59e1d1-38e4b3d27c3mr19244457a91.4.1784645158557; 
 Tue, 21 Jul 2026 07:45:58 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d093bd8f6sm5989272c88.4.2026.07.21.07.45.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 07:45:57 -0700 (PDT)
Message-ID: <5b5619c0-8a1f-497d-b53e-ff9e7d0c0253@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 07:45:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/listener: Remove unnecessary linux/kvm.h include
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20260721062745.3793066-1-clg@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260721062745.3793066-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PElk-LBOZNeV0_yjfYE2XbyiN-8-80nT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1NSBTYWx0ZWRfX/cpfmYIwV04R
 MAb29304ymhbIYb20l3Nqv2oaksEqxaIbCV1h/C8kxGIsw1F6D5D+t6GDH9XKeAm7rW8LvI612t
 YNHFT4fkvUxiTaRIY50gMcrbmLIqzCU=
X-Proofpoint-GUID: PElk-LBOZNeV0_yjfYE2XbyiN-8-80nT
X-Authority-Analysis: v=2.4 cv=Sb7HsPRu c=1 sm=1 tr=0 ts=6a5f8628 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=r1p2_3pzAAAA:8 a=20KFwNOVAAAA:8 a=wm09KQs9GwRHF5DUd-cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1NSBTYWx0ZWRfX9QoTrrLjt7zq
 wUJpRCNShoWOim6tQgMGTYP0TyilWXfAW3hwfLoLa6qUrTn8GTZKb6kc8fg76xQSV5MIJGCRkp+
 WgSUL316PHjXLkNmZ60gjNuoBugxB6ljTxrwufySP5KjNYGFMz7vZsynVHPWX9Xc4qDUx8Saftk
 gJ3nQRv7JxWHUmOLHhoD8TkM8ftbmLDd1QZXscM1uZ6ZiqGzpr2GHeBQzs+WLj6O2ZfbGC+PKB1
 CUnSM2Aj2vE+rZCap4D4X4Vvk0o888AjKtWFIT2PwwxDTlh7XL0oCZNkFVTqnn6o2bAiZw1mzHa
 Y7dysWRqTAFnzJTd+su9OyArUQSi2TUsQVaFC+0UqJ7AyHokZxBwwuWzC4emjwjWN3aVOz0fm3B
 gNReACpYoZKSZSoBGHGlCqqqVe6swUvySw+ZZVxUGEKVP6lORYF56GcpbFqIYNwZSyu89Mk+afv
 k3N9ShfFibYJAMDQmBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210155
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/20/2026 11:27 PM, Cédric Le Goater wrote:
> Since commit d0e8bccafc23 ("hw/vfio/listener.c: remove CONFIG_KVM"),
> the linux/kvm.h include is unconditional. This breaks the build on
> targets that lack asm/kvm.h such as sparc and sparc64:
> 
>   In file included from ../hw/vfio/listener.c:23:
>   linux-headers/linux/kvm.h:16:10: fatal error: asm/kvm.h: No such file or directory
> 
> This include is not needed in listener.c which only uses kvm_enabled()
> and kvm_get_max_memslots(), both are declared in "system/kvm.h".
> Remove it.
> 
> Fixes: d0e8bccafc23 ("hw/vfio/listener.c: remove CONFIG_KVM")
> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>"
> Suggested-by: Alex Williamson <alex@shazbot.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/listener.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

