Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3E7606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WC6um9P7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AVAMVF3r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmou-0005Rs-50; Tue, 27 Oct 2026 15:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmnd-0002wX-0k
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmnZ-00025g-5M
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:31 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHOxK2945716
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YdBLSSiTe0MgT2+483ZQ+q8hsZ2eZLBhIZZ4qN+tQCU=; b=WC6um9P70YnNOUPh
 acbSF7i0vZCFEirbtdZxkkFT+u+1yNSJztmUH7SF+0rrk5UOFS/6XYjaUdXLLw82
 Fx9f1MORQRbmRXuPYqNo7E5bYQ+4hlE+qZva99Na7mIyMwIYYOBFLv2angFEH1/h
 SYnVWpr7BiWHGDGnDaQGiwWhQWfBHghuf58j8BulH+3L9p+wZxLvaXhGoI0/etSt
 C0qGQE/MaPIYa6J4oFq6H4zqHYZT8YYhNXT1w+jzRjSmqpu/lznWYXjv2Rx9xS5w
 Ccql6AK3u5V05ba88rY3JXpr0rBvuFxIuzr9GlQix+A/efD2J96BwIS8Vp6OeOnv
 gzHUKg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq6apbj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:25:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-943e8ff02d0so11621085a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129127; x=1793733927; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YdBLSSiTe0MgT2+483ZQ+q8hsZ2eZLBhIZZ4qN+tQCU=;
 b=AVAMVF3rX0YteA4KgfUgDroV6UDbH/lOYlCKynNZmuxZY0k/6RfjYueRg1PzEmR5JJ
 Ap+penDXxrvJFjbLzMYUqERQNWLVFTcjaQpKI+wb5bvsYr+FDI4aiFlHr3xurvE71te0
 qX8ZXeGXxcF3xar0eM+8nRgNkEn291tIflIVILSi+mJaMH029xeKtT/zfjbKdZke90N9
 dNXwB0spJnOhtssIQOXM5+zdP8owp4S2KNQeu1ijCcZ+z5NAynnXbJtHdOdbi6P76Pur
 rAWA5cLLDlJvo5gjtZNHvZKKtMEDBIc3rg8dhXdraPr6yd189AoUTxfOMCNBfBSDaPUG
 EXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129127; x=1793733927;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YdBLSSiTe0MgT2+483ZQ+q8hsZ2eZLBhIZZ4qN+tQCU=;
 b=QYFAEF4wUdppe1HXVuHAJ53v53IDw22pD/2d9W0YyXMznaxcBQa0YE+0kApeUTZTl0
 cqGTrAv6EY83GgM6xRhXjpsWljxmKE/xVk2d3IuOIePRKrggloWdDORQms2nDpQLejeh
 mccAMwg2YEcYXUFjyHH32iPEI7ZaD2QrXrvxpzDEv+dDAM6VkmigYp2bcy2HVdzKIzWh
 1dghhMQLo0K/K6WFdijkvnNMbLRcKXf8sGdwXNbCMcBTg46u9AwaC1MKGCXQo1okb7o6
 8CD4OtZvQuAj574ozNKzDCR/JAsv/Ue2pt643TJvPil7NA0EVuRPwKgoJMhcjzVH+RKV
 fHqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2rwMJ0oopH7KfNy8v16rkplwHrA+Yg8OiC6VGcMKqTPwFvoJ/FBipVQZcdBpUSmYYXXHTqJYclCY3@nongnu.org
X-Gm-Message-State: AFq9FYJFG2HRRVLkBynkYsagcHG22XlfVKcJ3oLWML5o+cjmSZLK6QJj
 xFFs6tHcZ76Y4P8QzZx0nmh1dOcMr8JQoYPFuXAOp/NvFObiipCi1+7YvJHiY/b/5pr+7bF6J3O
 MGgA5gCQI6QCWWQKwPsYXcMe0QM0UhMu1yFjupiXPJTcHhfbrhye6ynxv2A==
X-Gm-Gg: AYBFou32f7FYmcO9zsESf/g0ooL+iZnbWxp0F/G2MHTgHtCUTrgxK2s2xfpwecsQIDF
 EPAA1xE+sYZgGATM0XEtJu3EqyT+PfYnTZnbIBcT9kUj1hWDXNNqIIs0s3NU4bfOYnTtoajYCQz
 Pin2KFficr7DBTrWP9bS+OVAl6hqWcBWgau+NYFmbYSa0DBt5WU/LZ0PczR8+zaJdLI6VCoZngv
 tLvimkFL2g5WqEExXLrxitcXD6JBBMOn9q4JMqOSQ2Rgb7gyx2OsLFWgJbUdzfazx9HFFmgDE8P
 8AdM2EPkt0Hkp0vzQn5VCBLELIkVL0orVsfDbBFlumN+5dFiytqudPSVOGUeVlYiJ7qRIv7exAd
 xl5aTr7dJDsxSPk4rYFn0zS3qfo+HbByOpeiJ45mQHW9iHA0oeh5WAbJfqa2otehQiLDSfKepXx
 xLLhoHHEccSUx/t4sB5qeRH5w=
X-Received: by 2002:a05:620a:a883:10b0:940:f224:5a69 with SMTP id
 af79cd13be357-940f2245d1emr1185138985a.65.1793129127024; 
 Tue, 27 Oct 2026 12:25:27 -0700 (PDT)
X-Received: by 2002:a05:620a:a883:10b0:940:f224:5a69 with SMTP id
 af79cd13be357-940f2245d1emr1185136885a.65.1793129126548; 
 Tue, 27 Oct 2026 12:25:26 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb9cesm25668611f8f.27.2026.10.27.12.25.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 12:25:25 -0700 (PDT)
Message-ID: <8ee2e12e-e416-4a3c-8351-54d12d3ee640@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 20:25:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/dev-mtp: Fix assert crash on undersized BULK IN
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>
References: <20261012140839.93559-1-tcalifano@redhat.com>
 <55d79d30-cd7b-4673-8fda-434fd701313e@oss.qualcomm.com>
 <4e55719d-647a-4163-87b1-950a89144d48@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <4e55719d-647a-4163-87b1-950a89144d48@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0faa8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=9qUTvQc-AAAA:8 a=CHNY6UcTIWUp0RImMwoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=axOgMmt4Ejcwn1cqzmsR:22
X-Proofpoint-GUID: -9x0oQtR-5ee3fOhghHJ-qe3dKinesz3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX5ch+pZzEMEgV
 zcf6uhygDpUvtO0FEGjtE9M9DRVJDr/t9YgMt4JpjwXX6KmqVrMFVQnxg+6HIcgZ1BTAZo/rtip
 c72kzP9b2oneY4noN8PNP32ryPXPGSs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXyc8jc1vHUf53
 yrv9WuJHJ2wlMRsf8RTSbXTurpvv9MeVHyCt1cRCv7usHQcT9KnifesSV4oGu0avWqTJZsn00EI
 lktq2qOqICMfNKSYbEH0g8J5Wjfivf+qDWB4qY78KKegLYn997aTJJTh2T18TB2mzgUQLynrFAr
 d4yQDtH5C1BwrN2DTWeUKC4EsG7gHvkGeCNJai4AHz4n67JiLoZBxziwbRd28g1Y/2h0GkOojex
 ChIA4xq6szKaVQpx6GkxA1AJAmPRQMlZZKH6fbbgpe2f9J1/dLGSDJ/n28hcaJ/ku96YnKcSEjF
 I3nvRFVs1U8xsByiUYft592YJ/nDhoE2Z3T60QmdAorSMZT2jXeICS27RPc6OVUhcI/78fNJZi/
 Ih3ZhPZIC81cUeouXlz3x8hjE3ruzIFezrOa+yHxzm7Mq+LJm9UlWYdJD7rejZrK56vBhRnvPw8
 5z4HNzFB+ROhtxWBzaQ==
X-Proofpoint-ORIG-GUID: -9x0oQtR-5ee3fOhghHJ-qe3dKinesz3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/10/26 20:10, Michael Tokarev wrote:
> On 10/27/26 21:18, Philippe Mathieu-Daudé wrote:
> ..
>> Committed as b17205f23a9a8661394d30148b2c995ffa932019.
> 
> Curious, why did you send this email?

Hmm I had this patch queued in my hw-misc queue and had to drop it.
I'll update my script to stop bugging the list with unuseful info.

> 
> FWIW, https://lore.kernel.org/qemu-devel/20261026135441.1019505-22- 
> mjt@tls.msk.ru/
> 
> Have you received this one and the similar one for 11.1.x?

In my qemu-stable folder :)

