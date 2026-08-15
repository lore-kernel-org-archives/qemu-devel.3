Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FAFC5AD5A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 12:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvDPF-0006Wl-5r; Sat, 15 Aug 2026 08:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvDP9-0006Re-Gi
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 08:22:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvDP6-0000z2-44
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 08:22:26 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67FAc73M328697
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 12:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mtgMMqt1jTJmfCJPuHyJdTvk+UP0CLPKh8VvFGPCUwo=; b=lu0+oFtE8l8Wtqc3
 hi1+bVmIBgoErv2OeWqBWoh7q56Dh8qiaz14/H9/RAqJxx8asjMgZ5Tmcqyqv5a7
 KdTcdme4tMZcbOBQi+Cr94kcx6RK95OHaMvTQVTjA74i2LcN9y2vQ79hqRNm0aZb
 dKZJc6XTE7Sfh+Qw66A++K/otP+6sYjJt8tvasqTJocTW4rldd8usn7cTpT5w29J
 UEFsXesJ494n/1qaig8AJl8cnBKBZAJkPjmT7uOIPQxyzt7DHv8E+zvmtxOThA3U
 0ae1y1jUr1Xkv1RAmWANL0wtjMbLXFS5vCewHM89C9+zgVGsSqz+Fd3z7em+rf30
 KcQDAw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghegxw2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 12:22:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso33688331cf.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 05:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786796539; x=1787401339; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mtgMMqt1jTJmfCJPuHyJdTvk+UP0CLPKh8VvFGPCUwo=;
 b=ghuEA9R5m0L6z+UfILgTPSQebnno1xDrU/TRxzjbAoLyGB5y8SvqOc5XvukhySi6Xr
 TB/+5IJTJNKFsqPtncyCnWEsXyZrjYh+YqJxj00FOusPblDngQDMiOPHX74gq27ahIRf
 arYqU69EOZWkT9FcQEd7GWe88WVUOMuPNB6vNzDcADjFC9rfj38pjcCvara6Koxyok4B
 ry1od4JG0cE4DDV0hR2OsYVQ3nO8JYwxsXNCj7KKa/w0D0vgAvkDRN94ceMwIsIN3wsg
 qQrBqyjtUUjtmeZP9udbpFCzgxOZqwg3by3x+0LPm5nhtyFglnQzf49WJhmyYPs72zAH
 6t/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786796539; x=1787401339;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mtgMMqt1jTJmfCJPuHyJdTvk+UP0CLPKh8VvFGPCUwo=;
 b=auKDwXS6+bh47svP5zfVPvCfyGk16uETyUGr6PaOLxxfIl8cxfHEUPK4XXSN5F3Pic
 wejcHPfGy8WVs4XOJx+43sJ4rtkjfX9nM5La7jqg0C9csH4HF5Uywf6Jvma50xHg7dCO
 BqhOrMjRTYeCcYq7ALqMz3JdYZGWwLYuP6i2rzCZP3p4CrA5O15BcoXMSkzxV9n+p50h
 vgSGlThLeNLm/y5sgLHcdXnFcGlXlNuizZLX6RF4ynJt0JI/Rtji6U0NqG1aFlOM3rbw
 HEu2ivZ4IloOKG/gwM7+jQm0ITcIo7TfaNyf+mmGDA8i32Gfyyt1m/EFHJ25Tx7dhDn1
 vb/Q==
X-Gm-Message-State: AOJu0Yy2VWYtm9fPi+vGhBTNjJn6Rrxa0hl94FleV6UeOIh+Ksr5zo8i
 D/VgERn0MT4l7OELqxaE3YMh06hYyo1t6VtUGDtWtbNISPmt4pnFIwSb3G8x8j4gw99CGJYNeV8
 rGsK9uB0t00M4ARmlwEUaG4i+87qskoKbrRlCrOj3OAG46dFd/9SOkpNxtl2SrsZNlKDc
X-Gm-Gg: AR+sD13/8Qt6dMZ79h4yIqlVKisuzFuknKZqSkunbwLEjWC3edxZ9RthUiEjHA04NN7
 Ngkwp+f/YjLd5p16YMMWl/yKLesXAh+JgjjeMhe7CU2cvAJoQ+DCyufjUHcSwR44NCD9WX2mC7B
 Y6xYZ7iIWp2M0Oct3U6SXuGkL3lkA8Au3kcnayf4v/yK7Bljhm5iiVlkOMHN8klC88aDjvAeGX2
 B4vjO/ifoRpGH1cftQ+oH7XNvbCd/esRoEJHWe/FwRVITYMj8Fz9aGRNaf+8cGxRvk0EmjUna9I
 4Sd1dSaJKWw6ddrEra69ggWga4aH6ElpqTu67EVXpVY6xqBo5FqAKBJr/mDgIOkDb1Rc6G0joTv
 +457B5W8bR2FdXYTDj31gTR99W8aB3Igpdyk=
X-Received: by 2002:a05:622a:4d4c:b0:51b:fd82:22dd with SMTP id
 d75a77b69052e-52d853621dcmr148182411cf.15.1786796538798; 
 Sat, 15 Aug 2026 05:22:18 -0700 (PDT)
X-Received: by 2002:a05:622a:4d4c:b0:51b:fd82:22dd with SMTP id
 d75a77b69052e-52d853621dcmr148181931cf.15.1786796538335; 
 Sat, 15 Aug 2026 05:22:18 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1a91sm15318866f8f.21.2026.08.15.05.22.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 05:22:17 -0700 (PDT)
Message-ID: <97466527-ef4a-4941-aa05-8c99b60d5b1f@oss.qualcomm.com>
Date: Sat, 15 Aug 2026 14:22:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] hw/nmi: Disconnect of vCPU and disentangle Monitor
 code
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
References: <20260812121232.71958-1-philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260812121232.71958-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EKc2FVZC c=1 sm=1 tr=0 ts=6a8059fb cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=nvOcmWztkU8EsUnM25sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDA4OCBTYWx0ZWRfX1KiZnGHypKH4
 4b2G9iGE7K2SjXI3ctYQh0qc4roC8f3Krqo8REInC24QjvocRb8roT/g7gCJ0Eeh1r/ZnzMdCRA
 OaSYYXF2QGI53HTi6xCEuHIyxixlOa4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDA4OCBTYWx0ZWRfX9VEy4KmF31JN
 Ekz++szch1a02x+jKzP4J5ooipotCr36zqODfCLDykqFNl540/4KP82uSBgqfcwL7+hahDM0410
 hCKhRFVKXafn1maWN/mKGyKrX9FWUBiQVX2/oNxJ6pwmsAI4rmD+D4L4FQ6ZopWz9G3igNZ1ODr
 8WLFSRSNL6jlxMi23vA0WMEfyjhZJub3wufvyEHZaHMW8C93qXDZXpVUGMLItSPCKGjIOpglVS9
 sd5bE5FIvw4Q6ZNJfpRhe2NhQgsSYWRdwY8m1l8/4adpMCtsLZ9dH5/AaTUr8XA+aUm8OAojU7y
 MdtpihU/NdN+aUAu2nBagkdzHquJQRoUOvzeeF/8Fvmm80QTol2AOYeIX6IHKGd1ic3CNYq1DCW
 OkBBGiDJafeGO+ZvTJ0kNxMyHh48NTB0GFiUHMWWClh/hZ6oOgso0SKXMc+Xh++hVY6Lda6MtAI
 mzNyxlwy9g6Cb8mQD1g==
X-Proofpoint-GUID: lUG8V_M9g_p6snuCU0HKISJHmi7zsRPb
X-Proofpoint-ORIG-GUID: lUG8V_M9g_p6snuCU0HKISJHmi7zsRPb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608150088
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

On 12/8/26 14:12, Philippe Mathieu-DaudÃ© wrote:
> Series fully reviewed. I plan to queue/pull via my hw-misc tree.
> 
> Since v4:
> - Fixed typos reported in v3
> 
> Since v3:
> - Rename trigger -> inject (API entry point)
> - Rename deliver -> raise (machine-specific handler)
> - Do not mention 'cpu' in HMP doc
> 
> Cover:
> 
> - Have s390x always deliver NMI to the first CPU.
> - Remove the @cpu_index / @errp arguments from handler.
> - Rename API as nmi_trigger() (since not monitor specific).
> - Only deliver NMI once
> 
> Rationale described by Peter in v1 [*]:
> 
>> The current hw/core/nmi.c code is a bit odd because it's partly
>> working with a cpu_index and partly not: the code passes cpu_index
>> around, but in practice for the QMP command the user can't set
>> which CPU to operate on, and for everything except s390 the
>> implementation doesn't care anyway. My impression from the IRC
>> discussion is that it's not really necessary for the S390 that
>> the monitor user be able to specify which CPU to NMI (and in any
>> case you can only do that from the HMP command, not the QMP
>> command, AIUI), so getting rid of that weird inconsistency makes
>> sense to me: and that's what this patchset is doing.
> 
> [*] https://lore.kernel.org/qemu-devel/CAFEAcA_0qUFW0MewHC+v+pSOisE-kQDt9Wv4F3RafEkyQ0DGJA@mail.gmail.com/:
> 
> Philippe Mathieu-Daudé (7):
>    hw/nmi: Use object_child_foreach_recursive() in nmi_children()
>    hw/s390x/virtio-ccw: Always inject NMI to first CPU
>    hw/nmi: Remove @cpu_index argument from
>      NMIClass::nmi_monitor_handler()
>    hw/nmi: Remove @cpu_index argument from nmi_inject()
>    hw/nmi: Rename nmi_monitor_handler() -> raise_nmi()
>    hw/nmi: Remove unused @errp argument from raise_nmi()
>    hw/nmi: Raise NMI line only once

Series queued, thanks.

