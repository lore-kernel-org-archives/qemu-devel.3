Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFA4C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZrb-000466-C9; Tue, 14 Jul 2026 05:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZrZ-00045u-Nk
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:55:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZrY-0003ka-4B
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:55:41 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E77SP43932438
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3L/pEHY1qvaPexVwcwXFXmFwX/6jrjOpQASTdPQH7tQ=; b=cJprnD860MMSx1Xk
 6tcrUJhEXxmAvjXOMNvb4PPm4RKDLhFrScPiN8fh98S8P/xpL6S0fo93Qp81PKvj
 MTxknw6bKdffeBHB34RmBXderK0Z5TK3eKOsjFGslxsApyR0mSxTsbtEeqXNefbB
 eUDBnC6k/IDqSnMifn2blDCBOj4ZFdWW3TvIBFL8Qtsi+2ZZ2g6QCfEDdbG0Ie6g
 gElDaMQC3z7eGLA8Gc0GFVkoPx3OkykC8bTJX/Ob1aM8y69ylMasVt0kK6ErqmXu
 ipw1bOe1SWXzoT+o7qGgsIEV+P/woHjb97S01pqMBTCzGPr0MxPHmdsBGCReQAsI
 20aakw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgeq0mpy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:55:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bf321d786so9335491cf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 02:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784022938; x=1784627738; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3L/pEHY1qvaPexVwcwXFXmFwX/6jrjOpQASTdPQH7tQ=;
 b=Q3zRZHgiL1Yf54f/QkCJY17NmEW6EWiNKIMUGpXWTHWY5YNbPvfl6Xa8/kZj+PzwXS
 O1GKpGNiVCH7SYizsnh21yilG+VjG/WlDfQLIKHRQ5bGQQ0jSGkUxh2bM0HoE19gXb7q
 5UuIGkr3dj7hzLlwSfhSoBXQwgpYGGqjSWpiT9Kgrf5UAGxNd3PBBJe8Y1vDpgaVIgLY
 IWH29FULv7Bfb5F0SzDxyl76RMN8ahZd9n7Asi3KNNlSZe6z0erIcjvSzzfLZpu4m2LX
 V8gGbdpbZT6lraBu7lLt7SaAbZJGsrbxEmPngMg8HP747OPXzKgK4ewTMZ1TlYL0is4N
 /OVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784022938; x=1784627738;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3L/pEHY1qvaPexVwcwXFXmFwX/6jrjOpQASTdPQH7tQ=;
 b=InFj4Ia6LwzaP3IBnW8UNltjad9S/kapBq+qPKb1BBa7MqvAFvjF5Z4i+T/PlgQbvn
 FvD4oW6KpdWPCKjbkbMWokEhiox72MT9VlNz357YkPA9Z7U+/qbe9l1o1bio3cOlh5VY
 IEIUtP53aNjFVHxWExAIEijXWiE2D5KlHLkE/aRZK9rGrgHc8JLqTq5RsmkOGpBY7obj
 gc74bihR9JdxWAXwWnzJWVJkufBRV4XIDqI4GlU/Jt1F4l33eO/lLVrMiY5WownPP4X6
 znp6eNMbm+gFtH1PvozBIG45L0vf5nam/pudMOFHvlHpgoFWU1gIU4345MyuUtSWG7ae
 g7MA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwXCM/kt6jjSIMIHTrjsI6x6kaVam7FKjgruvt57nqz22Cy04beNjfFPyAocCFKIbFrMG6/gjTtVbg@nongnu.org
X-Gm-Message-State: AOJu0Ywi/deZdiOYK8zEiS651nhZFriyCnYfSQkwa0Q6634GDlbD/GNj
 3sBNTbTN1+iiwX8zg/vvDqr/MuEvrBwotbUhM+WZvYDqi9vz56QugDQFN8UJ4tPGjBZgPmPbSgy
 i58ykzG7+ApGfx7NB2fQvbbQxDYcSYMBfhXHvWGv95tvkNl3lTxWOQN+nHQ==
X-Gm-Gg: AfdE7cndcPJsSm7mxqcuAkMyThYVclPKu6enyxRozgFMVGoqA0Ii+SSjmzCrtzFbb6e
 gXp8qnHtBi1MzDlPVkZTVTb2dS7mr3u+rR7NA4PBdXbMtusdf3zRhf0zHjslNJ2yuT50xsue4xQ
 I7IzytjNFwcuzRkOXLfnCzYVb5elxy7iMOoPXvCOrDY4LV0oqF6I58Q5bhaEll4s6V8LQVibvH7
 TgzdSddoniJ+EP/INkw1GaxuNAcG/m0a3OxGkOK9XLoKphvVxSMbSOmQVSJeGYhxaXubh63UQ0O
 jZW9SFBu4KZ/DEWPkJN/8rQi4eTTewornzx8hAj5uhvay+Ts3Puq9CL3XmrfsW7sqv1z9QvjYF9
 YYfBwhSmW9UDaXylBCbXKAjwyv3Pw096wQd20Zu9Ct4IpK2ylj7K588w+Iovp4w==
X-Received: by 2002:a05:622a:5887:b0:51c:44c:6ad with SMTP id
 d75a77b69052e-51cbf0be5e6mr124155521cf.21.1784022938122; 
 Tue, 14 Jul 2026 02:55:38 -0700 (PDT)
X-Received: by 2002:a05:622a:5887:b0:51c:44c:6ad with SMTP id
 d75a77b69052e-51cbf0be5e6mr124155381cf.21.1784022937681; 
 Tue, 14 Jul 2026 02:55:37 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69cd289dc26sm1162866a12.10.2026.07.14.02.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 02:55:34 -0700 (PDT)
Message-ID: <da1906c0-edd1-4c93-9d1f-264ff78b92d8@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:55:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sparc64/niagara: use int64_t for vdisk size to avoid
 truncation
Content-Language: en-US
To: Dmitry Pimenov <sun4qemu@gmail.com>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20260710222350.9185-1-sun4qemu@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710222350.9185-1-sun4qemu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwMyBTYWx0ZWRfX5qS7Og3LPKe7
 3FTepY7yhLyLji+7qEN+b5xJZAtrpzxdc+c+VERQjW87FUP1ptdGlZEffOPIeJvB2SEvUtNr8ek
 xIVG+xPsSu/yD5AwgA0MzxMPHuyD5pnn+rEKVkze8Pzx6FTFKbf8iUshN6WXFfEQ0js8f4+9aTc
 u6tXATm28ZMNaUWmfMfZ4DuV45fct3gt+JwSgzAdbCv/31yGI2qDFw2UqfWWRcQ3BATEIuUQi/N
 1fHqSmsdDyHvhTlGcRzm9wFqWpxUDhnBZFIrjQCgKvIoaO4nN5up9bXLRr28OUzg34KSB6oCiUZ
 Fi5ni6k0Cb/mnISdlaz+IjdwaSu22qhbsZo0AyHDDsnM82Ns5dSwYhRkSB1JaH48VDLydoU7psp
 zntJCntg2flLlHttYe9rcrVvKRtcbgm0ZqYdf0f+W5ICt8C60IjcstaIfYElMUIh+2R1qfGgRLK
 KH3iZSrbO60qYei7PGw==
X-Proofpoint-GUID: 1QrWGSiL4_Y2OP1uiGHAUYuhSKbxUIHg
X-Proofpoint-ORIG-GUID: 1QrWGSiL4_Y2OP1uiGHAUYuhSKbxUIHg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwMyBTYWx0ZWRfX5XFqukVdnY/j
 eigEEJbpncIR9W5N5oT1Y2zjt1li4SyT1g6hanvvczvvXCl3FbXz+h8Qd4xZxeb4FDLpPm/OLQs
 EimcZShHkUtfoSNEGG9W2eLPUqCGAc0=
X-Authority-Analysis: v=2.4 cv=V9VNF+ni c=1 sm=1 tr=0 ts=6a56079a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=snPeH2LoqDSn9hgqQgQA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140103
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

On 11/7/26 00:23, Dmitry Pimenov wrote:
> blk_getlength() returns int64_t, but niagara_init() stored it in an int,
> truncating the if=pflash virtual-ramdisk size for images >= 2 GiB. A ~4 GiB
> image truncated to 0/negative, failed the `size > 0` check, and exit(1)'d
> before the CPU ran, ending with:
> 
>    qemu-system-sparc64: could not load ram disk
> 
> AI-used-for: code (bug fix)
> Signed-off-by: Dmitry Pimenov <sun4qemu@gmail.com>
> ---
>   hw/sparc64/niagara.c | 2 +-

Queued, thanks.

