Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8049BC55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrdwX-0005Tq-Ht; Wed, 05 Aug 2026 11:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wrdwW-0005T1-6T
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:54:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wrdwU-00031Z-7z
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:54:07 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675FV8ZR3019229
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 15:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sGV45owI9//tALzFPN8e2wNqcuGq0RZ8Qr15hfhg4P0=; b=UIOqCYTw3sbQWABY
 1TdCVXD7eTbYCA0ppayw1h8fJNkE1WjXHlokYN91H3Y+/9ndI23vXqy5DWC/BnWN
 jNDFiTOkWoexmCnLQD/gcs8AuFAjSypq7ZUExEZL8D/LcJXQ9iYS3qmo4X+byT2p
 wWY31siFewOVJDQX1U76/U/AOWSx1W2X3XwhZi1VTVlV19dNUnB1dm9wfPG+KwT+
 LTXPKTSjRiscEZhrpa6o9eCuWFftpDUHNg/b3jcviCsN6tyC4GO4oWs/wKThK2xn
 Flc15Ueyq5hcrw/YCxE2udJOkw8D7wbOsqSDHntHkAWAWY/d2f6SruJtiKQ8WcPH
 FcWg0Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x5gusb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 15:54:03 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c01ff996dso11948041cf.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 08:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785945243; x=1786550043; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sGV45owI9//tALzFPN8e2wNqcuGq0RZ8Qr15hfhg4P0=;
 b=BNOws+FjbJZpEbBESMHhGWB1h09BIGQkA1QX9wPKjod6uEbu5Rq+O8N3MWm5h8+Eif
 y1Ql3ZrAPpa/BQzujvj/7jGBYa8zQ8V33rZWKqRqz2DzYaXPyy33AUBD9G1jC6f+rco2
 ONMjzz+tW1Wmtsdmv6NUXz6mxK45YcTF12hB6ixpGir/lXjQKcgcPCmGLyw26HWZlhuB
 R7Ofrc5FjHqOETMpaSqmYvmFnNmLn1fdp4ty6mkUntGcEj9v4MWn4ENr3XPNgG6YXZjw
 Fu9pWtni3Mn5NP+SPWlnKlMgc4Yj8aWlfuEWEPbBus2+S++fY5tMAgzOd4wxHf5KzuGg
 rxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785945243; x=1786550043;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sGV45owI9//tALzFPN8e2wNqcuGq0RZ8Qr15hfhg4P0=;
 b=aBxiY+I5DaOfx6PkkwuqLENuhRTnvWCT11xKWwCDfARiStxyMYwqhtQcBlgX2P9Uko
 n9QayQv6zQbq7+8S0P/3s/ET+tkU0UjuHs39hFHpkL5iDBxvyBosUtHQXT7e8iWek5JO
 y692OaLMvezn/nw796FRF3vyWTYLhR1cdmPWCMPAQm61HO/0AilJWAC+Quz7NppC6KJn
 mOZR2iZaK9yYHp8r9va36j6ekafneaqlI9DD9y+P7/Kd2SaVY/7NndkTDzc2f+f/F87s
 EBhp8yl9I/waXd7+G8huFSm9XBv7kajk44sBQQ67kliQtcerfg9pJzgRBBw0VtZ6TyVH
 P88A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2Sdqcq1wPpPPsCPFFwEHTecFNMlLgUD2iPGnlQQLdWF9dThElW5oHZClDDI1S//vWpOxenjUIlKKA@nongnu.org
X-Gm-Message-State: AOJu0Yw8vF+ZDKSUetjoPwzzTSdVB7qSlyc8mS6LOl17Ph1/n63fEd3O
 F5diFKfBmBweiXfjvPEws8R8L+hSwdtsx5jKzDajoHuVRjAXPhRv2TRq5VzrktlYUHhODHle2Hv
 Pt94+/gukApnnZ/62oXu/DLzPF0p5l8NSHT/v4MO09+lQtDUpPYZGHQqafA==
X-Gm-Gg: AR+sD10O5YDYAIrX4dcKeVgm8PUT1365SNgOiehv16R7W6FJyyJaaJO5sRTafQHM+9I
 hK3ZLLQdWXhBY44elykQvs1g84nMjWrYMMhs7Nxkt7BlLjnBUx/wfMtlN+ynP7msoJO+256Y4ul
 Bn0BZk9SzkSBws/lrUY17xdvzIkKU4/9Zrg3meVTd408dErN8zQ9tQ+ZSn/2P1PFeffMuqDp7Fz
 kacDVcMcUpAIomfyDdVOzwHjbbC9twnQtDP0/mrrfXrdQXlAMY/3cNjeSQhglcmjTzzYsrBgtTq
 MKGnCL2Ii/35T91MSLAVEGJCV0HAdCDQEsy2LoL6/whLqrB5QWKWvZXRV3zO6kNSgYWgIgGfWNW
 1Gx629+8AOraHOIRTQ8VkLKzlviqkELYc0E0=
X-Received: by 2002:a05:622a:1448:b0:517:8f2e:5d97 with SMTP id
 d75a77b69052e-52ce60c07dcmr72710521cf.22.1785945242516; 
 Wed, 05 Aug 2026 08:54:02 -0700 (PDT)
X-Received: by 2002:a05:622a:1448:b0:517:8f2e:5d97 with SMTP id
 d75a77b69052e-52ce60c07dcmr72710021cf.22.1785945242019; 
 Wed, 05 Aug 2026 08:54:02 -0700 (PDT)
Received: from [192.168.69.212] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec232d74sm10126824f8f.17.2026.08.05.08.54.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 08:54:01 -0700 (PDT)
Message-ID: <19c3ff9e-6559-491d-a3f5-b1786db6b9da@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 17:53:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci-host/pnv_phb4: fix guest-triggerable abort on
 8-byte config access
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: qemu-stable@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, harshpb@linux.ibm.com
References: <20260805090530.1333997-1-nikhilks@linux.ibm.com>
 <501df67e-28d0-4630-b98a-769abb41086b@oss.qualcomm.com>
 <c21c72fc-672a-4674-a8d6-0b999502b4ad@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c21c72fc-672a-4674-a8d6-0b999502b4ad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEyOSBTYWx0ZWRfX32NhuAbLwvzd
 vJLffswzL0b8IXmMTDpxoDwp5I5SEwIt9+3qswUY6qHh1hpsjMnlELBud+02v9w4gOTF3JYnHRE
 PzeFtnJji131swKoZb3C62gy4HJNG4hpmCbH1a24qc8H+gtFaM1mJr/xkwh3yNcPRGsOmGwqMSK
 RKQPrE7jHOZ1DXNyqWzBneIAYSu4ZjVu/1TYVGJFgjt7xSqcd3w6JcqJCH3LE5/G6/18T0VfW6g
 mHSa6dEBrpDpk/926Q2/BuLiqQ1sOmkmlq25FZfFYfBif7IvijuyzNSrFA7BzSh2QBLbNXE1cmn
 Uu1c0cHNdwvdbl4RD+XpcczbntktvQvaUOozYqst6kma62YMHxpFxJnZh1SiqKDwvSNs5CubMeG
 LA0Gt7A7YODWgEOIG4l2bB/HTqRasqf4fzgPyP+aucqgZFohwUKalgNFTsVL0FDA7cAIVRRWT/Q
 h0P0pGvwc8syPiscmdw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEyOSBTYWx0ZWRfX36E/xtHrL43P
 +MIYNtIn/7hVOl3UwLkvqyHsVX67EBxhQbkvCjeTrsc/qNtFjYP3f5xhM1gxicffHwuXddYHisS
 F9eKCEnXYgzY9kGL0bw0wJZWS9fi8xw=
X-Proofpoint-GUID: woL-P-s5-l3LjN6wWWCJRS1whXNoH4L4
X-Authority-Analysis: v=2.4 cv=cIbQdFeN c=1 sm=1 tr=0 ts=6a735c9b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=ezAqKj2UyEBNTGy44rcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: woL-P-s5-l3LjN6wWWCJRS1whXNoH4L4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050129
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

On 5/8/26 15:53, Nikhil Kumar Singh wrote:
> Hi Philippe,
> 
> Thanks for the review.
> 
> 1. Regarding MIN(size, 4): I avoided this because silently truncating an 
> 8-byte guest read to 4 bytes leaves the upper 32 bits unpredictable, 
> which might mask guest OS bugs. Returning ~0ull explicitly matches 
> standard PCI behaviour for invalid reads and is safer.

OK.

> 2. Regarding pci_host_data_le_ops: I agree this is the right way to 
> handle it. However, PHB_CONFIG_DATA is currently interleaved inside the 
> larger big-endian PHB4 MMIO region. Moving it to generic little-endian 
> ops requires a memory region refactor using overlays.

Yeah, "if it ain't broke, don’t fix it", so let's keep maintaining
something old and different.

> Since this patch addresses an immediate DoS crash, I kept the scope 
> minimal.

OK, no objection to your patch, just my 2 cents ;)

> Memory region refactoring can be picked up as a separate 
> follow-up patch.
> 
> Regards,
> ~ Nikhil
> 


