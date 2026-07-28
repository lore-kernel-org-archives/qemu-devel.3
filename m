Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CC3C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocmS-0001zf-Cs; Tue, 28 Jul 2026 04:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocmQ-0001xz-Ff
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:03:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocmO-0003pH-Ih
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:03:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82t1r2309909
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1eRtdWyw2mAwIHvcUrxHKKG9AcJPcS78sJtVWx555h0=; b=em2n5y66TpxeHnuc
 hglg1EiH1Ausiyyn3D0HFcFjZGqP4zdKxBDJ6Zr9lT1KDHYDCHXYkLMe4bVtVQHO
 qmRh0r58LDzqrVNVIaeJqrQ7yQiSnaT7BfomgbB1CsmmCCEI/U1az92X+hzNhcCr
 9ZjCrp6i1MOVfrxkJojD+b44Td8ksroMqb6CK92OT8StGPMMpJz5H9ZyRA0JeZvV
 h60DR0gWBf4Vev6FYm1naRj/q3z8i6S7sXnTO2qTVytUvhGvMbqsS3qvrb7aEVJs
 TlT8XIWYHpMMJZf4F3PW5+MQeDkWsQWgWDAg7YySRY5Lj0KwlYuijR9Kr9AINEhD
 saNvKQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fphh7hnrv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:03:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e66f9e2baso403831285a.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 01:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785225790; x=1785830590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1eRtdWyw2mAwIHvcUrxHKKG9AcJPcS78sJtVWx555h0=;
 b=C9BlZ8n5LNhM0GMiSYNUmwmhJtCLSOeUuV7vs+OF20NB5nEP2qP0bruNQoPtVYq604
 8HCd0Bbfx/4ZQXzjG8EFRqYKlrbEUEh33BZ8yspYDg0hWGCRZHeb+2PROv8gK4jvCwxq
 x8VoEJIr+uc4Wpl8ROewUpkZRXk+LqC/GHvWg7rFwx3XDz3Uj+pjBm6uFCe241qOC2Y/
 s1ioS6PUueorudyB/Pwak9/fB3ELt/BcfLOyTTcjRVxZ6ohYxvO7t3irECWWy8KzW2yS
 istaonvDh5y/D0yWozYCLIHbcHX2cmm/DWasLXmvdirxOvGR+QRDrpBD5dg/hFgfO/1H
 t+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785225790; x=1785830590;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1eRtdWyw2mAwIHvcUrxHKKG9AcJPcS78sJtVWx555h0=;
 b=HRoP00EF5UTCNeUIOHX8aXrw+NzDOdiaVdnOAGUps5IOXBwEWEagzWEXMKjTdYBhWR
 du9dLXlpY5IcIK0a+2TI8aHtEK/GvFt+e9087XE0azPE8sUzM15QwUI6qI2QI07kzvbP
 D3bv9fC0TtiwEZKh60leTEzewkf2znsP94HsMMM6OsvqMw8zReUCqg7FAXlbDCDOVcIw
 TNg6ZuLb6VTPZF3lR5v3dguFNU9VyR0H9+sXfP9AMnruZ+ehT7Qed+Oy84vIAphoYDDL
 6f3hkLPeIa63LINRjfPtktYbZPtYuMslTqBiZfWd7jiahs8VDkVVqAkJ8NN23OO1VOmd
 lPlA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rofb1LpBD0UwMNQ6uoE1qz8aXT5me1aYsaYh3/4m9qZe/xO8Wv1/mALRAWO1rlL02XxJue5X1kuUeJ2@nongnu.org
X-Gm-Message-State: AOJu0YwTQXw2h3NCpnug2d816gVY3zL1xJPoxWZkLIGD+j4auqg3nXPu
 2qI+ZKvdgTfjUz2Ur1ObCgEHFdys/3iMpY6xdY0rWs7veW6TA3LdrZcsFeVIwMLx90egdYTyVK9
 +I8j/6mzKlJRg1Jc0J58F9upNkkK/U3n+Ftk5+EZ5f71zLMQ8elrF7I4HDg==
X-Gm-Gg: AR+sD126F8Nn8tAy4IjN/BBY+5krZsKDtw1oQfQQLcxJFUXLr8b0rnLdfso9W/n29tY
 D9Brn1ks00PzOBpE/nA4pSG7hqyhNsXUI730xddm2mm4LdEFhTPl3ezhX7cN00UPTEICwyZg47a
 jtWZq6pbQbQ+020KWZbWAj6nCmUK2g8+gXwY6CzAjqM5A1qZdmYNd7cI8K8MKgg3v0X7TI4kTfv
 uD6xaldcWIAoRuGvreFBnSRAOXiGAx18GHCy+qZe2i30pLXUxW1HB65UUmCYuewAxe5fBy+PeeB
 zxURbKr4gfM5JVhSP2pEp51tQRMsLx1GYS2f3wa2RKiA3rbbN2aUWzab8AXpQqTJ+Ozu3p6cbi3
 Ve1sQBNbhwy+0iW1gym21wN0mtXRnI4fEsZsvFxUrMGqE2qn+xvc=
X-Received: by 2002:a05:622a:428b:b0:51c:805:1be3 with SMTP id
 d75a77b69052e-529d6ff41b6mr10322991cf.31.1785225790540; 
 Tue, 28 Jul 2026 01:03:10 -0700 (PDT)
X-Received: by 2002:a05:622a:428b:b0:51c:805:1be3 with SMTP id
 d75a77b69052e-529d6ff41b6mr10322751cf.31.1785225790139; 
 Tue, 28 Jul 2026 01:03:10 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f9ae5c3sm396100465e9.3.2026.07.28.01.03.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 01:03:09 -0700 (PDT)
Message-ID: <39528643-33c1-41d8-b973-b351b04e1efc@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 10:03:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/ide: replace assert with proper error handling
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 thuth@redhat.com
References: <20260722104836.351387-1-f.ebner@proxmox.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260722104836.351387-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2OCBTYWx0ZWRfX8j3uuvZGPCcK
 +aWd0iQyWyvI+o5KS1w5IJwyDYFBYe7JPQMi7hyb4amKt0KZGQ0Zb0v4lr0nNUzFG+zCnYA2/rd
 njggWgFO5aK7IJSgzwtxnDK4jakfh/bbThtZn2JkStow4C9SWr2Cf4g/+orwdcuV5rzo0YSdFrh
 ImEDZwX+HRrRCsZdWfgOSWqdx9Y2qdyWtlpz2e6ubCj+DUhBGTCehUc9JBH98kWDgk2Q+DfRtb1
 DUmb2sXn7zA2GmBWqHsXXpwZIJqh7DYkxm7e9zASv03Cb2/bbred8UBoGdp60hqq+8aynqp6bQz
 d8R/ufK3kD4FKW3mN9CqU2af9CJisuwntEd8ZhQ7CwQqWXBUD5EcLYs9DF3jDRf5pb1YUOlcaD6
 rsZ2SYoLkX6S3leCn1SYnBipy1TyQA3/hg2mCajqhew3DnBuXx53RtsCxzgfykJ6P/bEo0KGLUO
 yY+oz44B2lNLdYb1ANg==
X-Proofpoint-ORIG-GUID: PpVKRGqLh2-EtdODU2oQ80UFOg-YxG7E
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2OCBTYWx0ZWRfX9vy+xRK3pC9l
 4s6ySqDTpdnAc0mZWQc6q567tdBeiIipV21tk585aQfmz9gqb8w8DZlrnpfeq/qlMjzm5HyceOR
 BrqL0e+7WxZz599C+Lgnp76qI5qQUpw=
X-Proofpoint-GUID: PpVKRGqLh2-EtdODU2oQ80UFOg-YxG7E
X-Authority-Analysis: v=2.4 cv=b+6CJNGx c=1 sm=1 tr=0 ts=6a68623f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=KP9VF9y3AAAA:8 a=HH5vDtPzAAAA:8
 a=69wJf7TsAAAA:8 a=Qm8iP6mkAAAA:8 a=8CrJ0rojDnMlStpYSngA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=4w0yzETBtB_scsjRCo-X:22 a=QM_-zKB-Ew0MsOlNKMB5:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=kDhhxE42lZnxL3pOKqYK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 22/7/26 12:41, Fiona Ebner wrote:
> From: Artem Nasonov <anasonov@astralinux.ru>
> 
> In ide_dma_cb(), the call to prepare_buf() might return a negative
> result and cause an assertion failure. This was found during fuzzing
> and can be triggered with some qtest commands. Replace the assert with
> proper error handling in case the result is negative, but keep the
> assert for failing to respect the limit upon success. If that happens,
> it is an implementation error.
> 
> Found by Linux Verification Center (linuxtesting.org) with libFuzzer.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: ed78352a59 ("ide: Fix incorrect handling of some PRDTs in ide_dma_cb()")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2777
> Signed-off-by: Artem Nasonov <anasonov@astralinux.ru>
> Link: https://lore.kernel.org/qemu-devel/20250116111600.2570490-1-anasonov@astralinux.ru
> [FE: improve commit message
>       keep assert for failing to respect the limit]
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> Changes in v2:
> * Update the code comment accordingly.
> * Keep the assert() when the limit is not respected upon success.
> 
>   hw/ide/core.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Merged as 443e02410695b35a27fad18217424b6370358be7.


