Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F1CCA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxG1-0004hM-DW; Wed, 30 Sep 2026 12:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxFy-0004gu-Pb
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:34:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxFx-0001mz-8D
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:34:10 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UEvEIK273296
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ra0SRpGg6bQV/f5FcILsvwfqNXSqGseoNaKGjqecKT4=; b=aVdQcNxjYwLTYoW9
 koLekVkiVUldTxxDxkKfmPfe8NVM9mlZMf0ETqMw+Atc65dRTcVuGLDO9e998m0Y
 sKTHeN4YANmsVCgvfl1XYbG9bgkiyS5gW6ktD8DBNiHZJfWcWdkahbdwcKIVhWt1
 cyH6luNv8sAjcNYHr9RV6qZy+WVKbtNkYGEuDhcKu6HN87eW5UXOd0TtlgEZoO2N
 OhnLbGgliiOSToWlcpFLe1HmM7S2fgtP/b/iyRJpGY6y7W71iMJnSAhqfombEW06
 tTTtamEq3O5U/qkPMkROeztPZcBjh4Con8dn7zTl8G+F9gloFpV2z3aF41ARBLQ2
 6oGb+Q==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h14n20fag-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:34:07 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-980c3b71002so4287552241.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790786046; x=1791390846; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ra0SRpGg6bQV/f5FcILsvwfqNXSqGseoNaKGjqecKT4=;
 b=RPxOLoVW4Q5S2m5qCrFPStXjrgm0BCrd1JTSSo5F0NaMkV+Cnm758VW5Koj4WEfMrH
 PVmsVZ/Fl8JZw4+ISX6+zfc39VwRscF7gj/0SNHwugzIvoUbO/Opz3Q4AByA0IQQndxU
 MZGWi3lxWTHqdfYdZQzPiXVJPsIU2JGGlek3Fbz5Dqs20BOMVbExx4R49STnZQeCoECo
 Vgnzl0tO6NVmh2q/fU5clOz9FVov/f17DBEx5U3QIuxFHRNLpAFCWcM5uZjOaIBamFB+
 HKziYX4gJ7u8mHP89U7G/+UTmAo1AmJ+XQ298AdUB8ZXRUnYSbsK0sSBYuLWvqPiHbpv
 StTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786046; x=1791390846;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ra0SRpGg6bQV/f5FcILsvwfqNXSqGseoNaKGjqecKT4=;
 b=VrfJ3kmPLc2mdVTMuRzSOtUz+6bklLlHba+kY7PHoOLUW5UKJ//u6tprscRqk/lqKz
 N+9+IIwrLI1tVBf9GC5kv0aQupLXXjxYKcCPWDL1b7uuVxNieru5ijzgff5v2rjxBKkU
 JqZJu9/dtXYqKsybwlAqRl/oVX/PZkLmm+Gi26yN4/0VAbSmO1sXU4QblGCRT0ku1qdl
 W7Q/lb8BQMPsGsTxx2i+Dx+2A9PnO43K27YzH37uWMXURAbUQleRKtAXwEwtHbbMp3lM
 IXH+uEl4cxzIpCN23eJuTWT3GodeaL/XLqw6XZlkQmxjFFh1nWHOixWxSriQ7FrcoXN3
 72Vw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhMRrjjLiP44neScXLWqHf+7R7rZiXX6ko69bGa4GxqdGKu6TVuGS5sBjK4g+AYwd0+0XV0q9lISNa@nongnu.org
X-Gm-Message-State: AFq9FYKXEp2VZCFjEGj7pOal02ag3gvsKuuI2qq/MsOdlT//2pXWMlTg
 0FG7UmdqbBQzsr6QJ0LqWXy5anWhyq+IbZ438jgsfGaofpLORA5zNlh8fXBfDCn6kHT+xdNTC+d
 WqlREyWoxRo928c/W31YQI0Vy3WqdwXTLJTsQlsdWvFT5C1EJt7ReqooxbQ==
X-Gm-Gg: AYBFou15FJoGuPEtIOXm0Oi3a310uCIuAJCBesa//XqZ6ZrAnmhyJaTtsbSLrRs2/4l
 l8UhSm894tNFV4pw+S5W6aKJzxdJ/4XBWCes2JpBBPqcTfhqWwskKihXLWFFA7qHoYvStbXgo3L
 Y59vh/z2A7ARW6l6Dzyw/wukTjUplSOInui7cKTxitXBfRsvUGekM2y8njfPPxfD/4bQeUBhAyn
 mRm7ffo4RM+5rtjNp7sLwn8sjmuCr5qIef4fPGMbzr1r3A7VtjGHSHIV+su2KG0PCcNykwbZeBk
 TbVQTvot0IXWwVFOihk/HZ5aQNM0CcRMtRWOvRAbwQ6epCgkMwx611EE/eeuUtVublZWlH304Qs
 yiJ2qsaARGaUhktkekx4=
X-Received: by 2002:a05:6102:8098:b0:7a5:2792:32d0 with SMTP id
 ada2fe7eead31-7be72cb3015mr663954137.15.1790786046388; 
 Wed, 30 Sep 2026 09:34:06 -0700 (PDT)
X-Received: by 2002:a05:6102:8098:b0:7a5:2792:32d0 with SMTP id
 ada2fe7eead31-7be72cb3015mr663936137.15.1790786045825; 
 Wed, 30 Sep 2026 09:34:05 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068bcb8fsm243838f8f.1.2026.09.30.09.34.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 09:34:04 -0700 (PDT)
Message-ID: <28911704-879c-4d76-bc9d-b95d4664bae0@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:34:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/27] hw/usb/dev-smartcard-reader: fix OOB read from
 pending bulk-in ring
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Warisjeet Singh <sinxx198@gmail.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
 <20260805-smartcard-fixes-v1-2-187ee9122441@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260805-smartcard-fixes-v1-2-187ee9122441@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6abd39ff cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=7g8aA7A78AY7OC82r+w+4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=20KFwNOVAAAA:8 a=rtjhPt-S68vU0-CQRsMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfX22a7mUuX4JpP
 JTOycuPPvtig2zKakhZyZSABNLpVS94wkSTTLOR+ttbEMfE9H2jCTUCWdSBiikAh5LulVXVVcN/
 MwMxDU7NQxFtlgkDMk3EzJ6rJAziSHU=
X-Proofpoint-GUID: goeV886zsP9o3daD3DfgmOSKRtlpiAFO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfX/30gwZvCPdS3
 C8x+QPJIoxadNkYTEpx7+UxOK0aKuMduYsJd6IRrP3gBdODbMahUOIIDrHj+UGPZnS2I3KZxj+h
 S1WZlEFM8FJXW3jVjj1l3bTcfXSMAvV5PhcJJR7gmrFWjZKHEGlXTNvwm6tKoT48lhaa0xXNwFK
 mKHtbMvj8llAaSEaDQlkdtRzyfG41UVKjZJ5of8oqcwVCjmG7ViP+r6YIk41654MBuLLJQX/m79
 ftF8hQldjwswhqU01n3GRPhJ0hdx/VfGT+6OzUxu5W0rDQ4uxKqphTiRsD0Pp5tHvJzJI3s6/MX
 NWMVV3IsqixHflfGwpdTjIIp7sywAFpU8C/QbAlMenQLLBlaBPDWWZhfo/eXv172PAYLeq4a12R
 iPSnm08pMOSlclecYax14SCssmD9USclDHoqJQ7EiOjjMqT7V4cf4r7WCR7g+inJCoiG/C3JLT/
 JbJHR7zoN6kR+ipmeaQ==
X-Proofpoint-ORIG-GUID: goeV886zsP9o3daD3DfgmOSKRtlpiAFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300066
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

On 2026-08-05 13:50, Marc-AndrÃ© Lureau wrote:
> ccid_bulk_in_get() decrements bulk_in_pending_num when a slot becomes
> active, but the slot is only truly free after ccid_bulk_in_release().
> A guest can fill all 8 ring slots, partially read one (leaving pos
> non-zero), then send another command whose response reuses the active
> slot. The stale pos > new len makes the uint32_t subtraction in
> ccid_bulk_in_copy_to_guest() wrap, reading past data[].
> 
> Move the decrement to ccid_bulk_in_release() so the slot stays busy
> until then. Add an assert(pos <= len) before the subtraction.
> 
> In practice, the device advertises bMaxCCIDBusySlots=1, so a conforming
> host never has more than one command in flight and the ring never fills.
> 
> Fixes: CVE-2026-18204
> Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4086
> Reported-by: Warisjeet Singh <sinxx198@gmail.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/usb/dev-smartcard-reader.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

See my comments on previous version:
https://lore.kernel.org/qemu-devel/9ecf7231-b4f9-4db8-aded-818fd7a79df5@oss.qualcomm.com/

