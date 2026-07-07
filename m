Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45042C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1xF-0000h6-4t; Tue, 07 Jul 2026 05:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh1xE-0000gq-Dw
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:19:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh1xC-0004At-Nq
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:19:00 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678Dlw83243280
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 09:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FvzYHiO4VYNp2iZmxCAWw6qGGJbCSrTsYtPaxDi4QsI=; b=jfDHEYCcHh5pR9Ew
 FtGfAdC89sAY+muUhKY4YGGU2u7Nd4BeZX/395mMn8se7aDSOdNG9Ipubxti5jut
 4Wxki4bMhWmOJfEPBo84E/38JW1cHXfD+ClOOv8PvEYm8VNSJOZSjQszqFIuIW3i
 MCMd9YuczVmCqija8uJ31mPmtWyfen70J//jx5NzI1678eBqGxTmv7J9yGFEB84W
 r8ImhYqzwoGx2wYTo+CugSHU5AEjGiW72qNqOsDx5dURxrnjd5/FW9WcOgZ1prto
 Q7YtVjVX2iRV00U9Kl6mH7p4pLabOWE9Dj3GZZhxhPHGhQSMJz7D+F3TPNBg4QGJ
 si08Ig==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w11reqe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 09:18:56 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ef18406878so48391856d6.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783415936; x=1784020736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FvzYHiO4VYNp2iZmxCAWw6qGGJbCSrTsYtPaxDi4QsI=;
 b=JO+K6GMIJlSo3wN2Ht309QlYUE1v1coh4yrH3HSJugNMn9YXtgMpj+ReAkvJBxKL5e
 LJWnrJ2QQ0TYPdgrOp0dNcPKKNGe16BwRExxPWzJaJJadMmqOBbdr1TA87uOVyAtSX/0
 xohxUwba/UKhkGzNEmaoQsOfhq3v9bzlHToBuYKqb57rAgHfjjixKz5/imKUXeyPJvhM
 KagW/TKk4+MwijldXy6to4qBdIQ/DHQRljsanj7DFve4rdKVpqu+qPVS3Wrc7h1U95cJ
 JdhipDJeSzFDgFFY9QAQLyvPQ8B8hlIiWBuId2w0jjAQnDgEo4j5ZgNnxgV49+JEXurm
 FT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783415936; x=1784020736;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FvzYHiO4VYNp2iZmxCAWw6qGGJbCSrTsYtPaxDi4QsI=;
 b=BUHx5FI+Pd40uNF/wZXb5ltcefqmPl+BhEBvEtFa77ETATEjzjHZcStIGwGZdKr+8p
 CT6Hhha4MSE3Oi0lvI+r/6J+B+gmA7bzQwhzPY978v1IUrwL/3n1KfNdfTfH3XOuY3re
 Ye8f2j/vgkXi7aYnYjmZ29ZEI3Inkunz2VgdrGY749CHD+i6mDWMurc8dffMgYpuPXrR
 MJM+haXMmOjtmyXtMEXDz6D/xecwfBZcDJVHbSF+tMnI8Jxb0kaJMfUCg5tXGdfqa5Dp
 eEBGq/rCo4Z+pOEspO08STfxy1WgvbccWg3HIHqSwmRLwn8ee9lmYnteBeaRQXHfwHYQ
 er2g==
X-Forwarded-Encrypted: i=1;
 AHgh+RosY4fBPeMll9AccCfnqyUr7xCr3odFqm3/cWSQZ5zYD1yIS4/8CeXm4ygRqkSk0dPr6j6toPCRGp4P@nongnu.org
X-Gm-Message-State: AOJu0YyG6Wfz7+2QlIPAnETJi1nlA7IbInwVvAy0m75+Yhidq9qcft95
 fofMYmjdQaK5xNY3Wvwrrqu5x6GXLtYQkNoQwZPUYt7FFGNUxuYePybLl1WXF72Gt/V0wRVGCQ+
 pmNBDGRqDFmbt+5okXwIZoRRi2ntF8doZByoxltPVTO2V0WwIvHLCbG8XcA==
X-Gm-Gg: AfdE7clZ0Wyz/9FurjLiifvpKZ0pL5VAp/dOBeQ0XZX1jBv/1Vp2LvF4Kcvem7S1vdC
 vulHguE0x8AAVzpksXE3fZf8wEpz1n9PvXeW9O7qGrm9lrx7cSqTmWXpumJIITTt0we9HT/ABLR
 Y7xIbdRm8uVvC8iO20aKUW9FjOBKwmOv2hnPxgL0dyQPIGgQ+ftyjAGTTfnRIPiT+6UBEvgqK2P
 hJeTHCllaZ8YI9Oo7Ae0AyZlN3p+DjvDuwRMjc18WdvD8cWRl8liR8XTf18KKoKqotRCRCtNB2C
 DXsiXaztWhOqeT+I9UxxjujCB5KHMuyCxQNw2xVSmodvSPKAmnUdN0hwUf24BvitNSHddxZWuqU
 mNRgA0Vq6Q57j0Xoa6B/rjII6YqkBJoauAzsAPiWtXtVsCWwkmNIaZCSE3Kn4pg==
X-Received: by 2002:ac8:6107:0:b0:51c:f3:34d9 with SMTP id
 d75a77b69052e-51c74802e15mr46045511cf.27.1783415935619; 
 Tue, 07 Jul 2026 02:18:55 -0700 (PDT)
X-Received: by 2002:ac8:6107:0:b0:51c:f3:34d9 with SMTP id
 d75a77b69052e-51c74802e15mr46045391cf.27.1783415935230; 
 Tue, 07 Jul 2026 02:18:55 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d8410sm32629544f8f.15.2026.07.07.02.18.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 02:18:54 -0700 (PDT)
Message-ID: <9f20ba93-0856-4058-9b2f-9eac79c028c6@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:18:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/i2c: smbus: increase MAX_DATA_LEN
Content-Language: en-US
To: Titus Rwantare <titusr@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com,
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com
References: <20260706230056.1888992-1-titusr@google.com>
 <20260706230056.1888992-5-titusr@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706230056.1888992-5-titusr@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DMe/JSNb c=1 sm=1 tr=0 ts=6a4cc480 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=k-jolHMNAAAA:8 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=r7jnlrndRL5-H-CgCs4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=yeu0PtCsVa5VB5VCVbnF:22
X-Proofpoint-GUID: 5SbUL1Z0EGh_Zc61lc8tgHU1R2A07Xq1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5MCBTYWx0ZWRfXwlZWFgDDTrqF
 jz6E52p88poRDxqCEIsrDBIcqutib0K05IIS7zEfpLh4lhFdSpFlWX2dNCQslmUtRJEIOebZ9sa
 5HUUnZCi5UvWlAdF6GAjrmIwMDQXwXU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5MCBTYWx0ZWRfX1b9VNpgiutSm
 NfVIVgPMB1dYM54Qhf6IkOLBczQHzwMChmwQGNAmuSND9GfaUnvnKLiXZWcsnbVsRNNlI3HlL4i
 f23U8OeRnegzSefbhDKqd7Jz4j/ofv5TNFZ2ibAtKijIcQgLSM+72mbN8iMAwHZNFkd8j9RAAsf
 /0AMNVEBd4mh3VVzHU9Y6Vyi3s9HDLuHfpQO0mygUfULdgTV8PXrB8+IhC83kdoOQGtftYriwde
 zFOP4KitzgvEyvmIbvLvjP4+XiKkxuWhC1kyRzcbs0qggm7kvgPDHEzzmjbeCN65t4IJ0RCg+g4
 LLPXXg6h9WWzsioS5lVsnKJb0iC/U9p+AljdC+XPG/fYxT7lBgKfzaZgtvF36+xaeem2T5B6Dzt
 OcI70x5v6/NCCLm1YtXyeAXCc1nEvCuAOVYAjMy+B70gDWvpZzcilFAzOaQvmoEdh7MtKLK9+Zd
 0pysZxUxKwOcMgY3WJA==
X-Proofpoint-ORIG-GUID: 5SbUL1Z0EGh_Zc61lc8tgHU1R2A07Xq1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070090
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

On 7/7/26 01:00, Titus Rwantare wrote:
> From: titusr <titusr@google.com>
> 
> The 32 byte payload was raised to 255 for block reads in the SMBus 3.0
> specification. SMBus does not provide a way for devices to declare which
> version of the spec they are designed to so we must allow newer devices
> to return as much data as they allow.
> 
> Specification: https://smbus.org/specs/SMBus_3_3_20240512.pdf
> 
>> 6.5.7 Block Write/Read
> The Block Write begins with a slave address and a write condition. After the command code the host issues a byte count which describes how many more bytes will follow in the message. If a slave has 20 bytes to send, the byte count field will have the value 20 (14h), followed by the 20 bytes of data. The byte count does not include the PEC byte. The byte count may be 0. A Block Read or Block Write is allowed to transfer a maximum of 255 data bytes.
> 
> Signed-off-by: Titus Rwantare <titusr@google.com>
> ---
>   hw/i2c/smbus_slave.c         | 4 ++--
>   include/hw/i2c/smbus_slave.h | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

