Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C7F606A330
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l/1K7aeO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GDABn6/l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUBjk-0005vo-87; Thu, 19 Nov 2026 18:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUBjT-0005uu-K8
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:40:00 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUBjR-0006YB-FP
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:39:59 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJUYBd3367505
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pbP4Bx4YRDX/J60Vc6ZyGaG4PJrq8lqF3UIy84eGH28=; b=l/1K7aeOLHcUDBDh
 5Afu1y3d4eRfgnuHTBidJ+sY4YASYD/gPlXXXb89XLDDjXyprxSRpH/UyS8gaWlq
 xB42TFW22x6NxAZjasR7SwK2rH/FQRckcqgs/Kwr+Q7bVTu0DROCnojSoJdpToqZ
 QZbuuircDvIELoLTJF1RRsDQYu3PxlUBD3UbP/fSSfVWhj6KosmiUaQsO953nufL
 gvbOpNBRggbsQ63ehlzQV2i6lnJ/Pfjs5Bs0Ju+MdtPr0qtQJ64IhtZ55dyLRqB1
 r4g+KCZpWO94+N11D3Waj1CjLf4fq1ZHBo5cYzlrV/c0W3yzoiy1mQ38JGkgCl2o
 renwqA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27b5rxrc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:39:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94961511b61so66484685a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 15:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795131593; x=1795736393; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pbP4Bx4YRDX/J60Vc6ZyGaG4PJrq8lqF3UIy84eGH28=;
 b=GDABn6/lKRgK4m1uCx+eVsb/kJ4NZaf3AesbGNpx2F2GoxtQg+97L9oJ9iuF1QKudS
 QwTN1vHZRD9LaXp8jHOnAGB7mgqI8DdFwMZlThmRVhCAdQ3gO62KTYYJyVz6HGy3p8A4
 TreTngSy7z4gKa3oP89kBkUevhoK2H1bJB1+FgAyPCC7cjWWkDTJrrQ2E+ueSJ79RTGc
 Mkh8nxx0pGq9va7ujBxWMtW5j67XNflEUcFcWgx/xRyiatZZFms3xzf2aJssCAyERViU
 rxR3bttB6C2tvQdg6Ud60h9bDY414clDqhMcnXtKSWQvlvv4DqG6SHWwH/0EKXKV3Vzr
 eX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795131593; x=1795736393;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pbP4Bx4YRDX/J60Vc6ZyGaG4PJrq8lqF3UIy84eGH28=;
 b=pJS0rVk9laM9ubkRp4FJQ2iyPTSP2TcJ0MptduG9J7k94awGr4VcIrAljtjWwWECxW
 mHwMHPndQtFfbe+JAtmnoOiJidy4OTMfSf4heTXHS31Ezc8Ac933u1gzdz22yUjhH0eh
 rzEP8EMRzvSKe94mMBQDNItlEkIvqEsXeWu70E9AguxpW7zBbCXGXBwi8+/oxusHje3L
 d+/vKXuKbRAaum31/4V/6fBVPtBD0ZvnWLswcp7TsrMg/5cy54Dn/Zos/1js85NsZc2C
 ebqhr9SexuSa2K1/Q3hPlf6o9nPdAM/9mFx11Vqw53lfY4QuNmK7A5jwbaL5QtTXxLmX
 Q0PA==
X-Forwarded-Encrypted: i=1;
 AL+hErFf19HBa1dfM7NmHUiJ9W+mtqjnUSb/H7AYMMTSruK7myOPtPUKl8V6TpZ8AwJh0IlblsjUMhXYb3R8@nongnu.org
X-Gm-Message-State: APuU4Z8OkDkomkbqm4pYSCev4q52ijtaqQAVTJJiR6v0wjIYqgbSySFc
 a5HpWIKC3obR9CVeTPKJGsO1WfaPaD1HVNb9UBYUxsjSjj+y/BSLS35AZKKHb+c80DEvDzFuaAz
 YWuTY/gUOmgBBZS3VTfQbXkx8UIAheFQsha3oyapntS8/xFos8SFsdldU3A==
X-Gm-Gg: AYBFou3ItIdyt+AElrk3ffZuQd0/JXfa4DwLAqslJJ7Njf6LRJThGMpQMTrqjo4juFU
 oEH5VouEpOaRvao+R+/79JOAizkGfbiCra92dVk8GTqvfpVIN6832uyAhk3APfJDO0LosxV78fC
 07w/ewvsWtvI3zblZb3DGAeiGTM8fh5gLiv4kOwWHH58Qrpo6qadvr8wAr/oSYtdv2EIKxHD1iH
 PINwNx8V3trF1pUgfak7lkb7034uE9KTaZU9N9ZJUneVOlum3X4cQvf31ELPzks5/qLkq1qeZWq
 /kztLuN1gzWX+VdSOZdbawP4Zvcx4xGbcp0cxJx3FXRF7/p+/b1lnFjoXtM4YfIzQT33J752tvG
 GNYiHmOhSa0ANNdCDl1FJPxSemd2hTrzPf0+Vv5JFSGHPkhWDjnZTI2OK6MXSTEPWzB7tdarMpo
 tmSLi5e+M=
X-Received: by 2002:a05:620a:17ab:b0:949:7f50:29d7 with SMTP id
 af79cd13be357-949ba9555cdmr221154585a.25.1795131593206; 
 Thu, 19 Nov 2026 15:39:53 -0800 (PST)
X-Received: by 2002:a05:620a:17ab:b0:949:7f50:29d7 with SMTP id
 af79cd13be357-949ba9555cdmr221152485a.25.1795131592838; 
 Thu, 19 Nov 2026 15:39:52 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf61e8sm2041941f8f.11.2026.11.19.15.39.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 15:39:51 -0800 (PST)
Message-ID: <37f422f9-bb94-4eae-826c-56fed883812c@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 00:39:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] nc53c710 rewrite
Content-Language: en-US
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Fam Zheng <fam@euphon.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Keith Monahan <keith@techtravels.org>
References: <20261119233235.32808-1-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261119233235.32808-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA5NCBTYWx0ZWRfXzUF5e8ILjiea
 7pX27q8W/nUasnJTyjXIUG+DWMshtSEKJC0p1Db82w0RQHAo+xS7Srv87YpvebJ/CJKJkrgLlZq
 NdNCeyEWziUP//iLx5GzUuzqIykK+ow=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA5NCBTYWx0ZWRfX6TFpJteu6SG5
 9JPz+rQ45ehRo1ol+8AQS1eZGDdibcNJHC1ca4AIul9N4wcRFGp9VluK0vHYE5Ekq5mnlwmWtE3
 BlNgZOF6s3UzcQJjK2TR8t2pt8k7y272KBa+S3nNMXIvFhrCM8phpYnznOkAY+TS7+s2AWbL0xv
 K4o2vgLiCZ2+pqch6qmk4fIFBACWfLajCxdWLbIrVNYc/c96/gJlr5q3HQDKWWizP0n+SLnP0VO
 CCS5LIAqsp5bZMIWKyzPneZ96ggZb694QDl7ulr8X4DuLFkLoO5YyO9b1dqfUFoWllMbqi+U+NE
 +W/UnzQICMscT09gjoMdRYdJlFsZaK6kYWrfcz/id8BHfYgzgxRPy+OFlAcKT/VKAR4yZBIdg8p
 opNSBRUzj4+TiQQAf69Y8SpY5pHRqpveDSnnvYA2cvTzHnjI0M2o/18jNvBzUaurjJUt8ks8g52
 ibwDxN4CUGhN4FW1o8g==
X-Proofpoint-GUID: izXQ8Gf8VJ_Vm0TVCyZefuVkufraiK47
X-Proofpoint-ORIG-GUID: izXQ8Gf8VJ_Vm0TVCyZefuVkufraiK47
X-Authority-Analysis: v=2.4 cv=LPTz05W9 c=1 sm=1 tr=0 ts=6aff88c9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=CsamVdHF0fg13M1g-BEA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190094
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/11/26 00:32, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> This is the third attempt to replace the existing 53c710 driver by
> a new driver based on the code of the lsi53c895a.c.
> Patch #1 is not meant to be reviewed, as it basically just replaces
> the existing driver by a new one.

"Please do not review, simply accept".

  hw/scsi/ncr53c710.c   | 3042 +++++++++++++++++------------------------

> Please review.

.

> It would be great if this series can be included for qemu v11.2, as the current
> driver does not work stable for any guest OS.

  11 files changed, 1426 insertions(+), 2215 deletions(-)

IIUC even v11.1 driver "does not work stable for any guest OS", right?

