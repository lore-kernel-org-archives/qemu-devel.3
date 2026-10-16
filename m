Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82058CCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 20:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHoUp-00060z-7E; Fri, 16 Oct 2026 16:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHoUg-0005yL-Jz
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 16:25:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHoUe-0000Td-Vf
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 16:25:34 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GJeXP32873508
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 20:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FWxctqBBVZJ2C+PVBQJ7jKuoiDSTWA3txT8eaEtBkGQ=; b=g0UisS9uduXlG+88
 qTfDfpksVjfNMZOaUQ3YZPocmgBiUrwugnyN0NHLObcBdOT2RRN3nCT/Xot6w7pC
 r8LQCWgItJIRtWM4xpb7hLxTcJcrk3NpGa0ipfarvfNgakLjjRdU3ouPOsQiGJi8
 9xFsPy/ddfPVzacuzGfZa7L+RJ1Qcfof2K23FvOV1eefKLW1Or419TlsPzDT2Ce+
 k38Sh7BabWVZaA/ybEW7LqdhNfmoXnvL4XviR4lnFfW6OHqoHV0QAHFXMdZDEOQo
 /l6umWc2cMt3qp5LSHcnQDTRSJ5J9hvsvGbf9L09V77piKF+Y5BdSxGv1JUy9x/l
 G3qYIg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhumt7h2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 20:25:31 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb71b1443so62520185a.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 13:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792182331; x=1792787131; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FWxctqBBVZJ2C+PVBQJ7jKuoiDSTWA3txT8eaEtBkGQ=;
 b=bmnmdx9Qg1GrbfiVMVTMnBCpyj9cQXELXenMZbVddmIFqHiYN6gDpwkoJ7k3TfjtZz
 +O5poYpSksO3zkgIfIwSwD/upLuLMA5L9vyTO40kuZ0LSFCh5CwWQv8VJL+P940sS5oX
 /itkbblNkvs+Ip/58D9HTQdDqz9iiF0w9lTLyZ1XpxYbRvfeur7kLxLY7lx2afpEeya8
 Xi5UN1v5zjOLH11UcG7S8MxUVRURvItjih1A05ikBR6up+C3e5f58zbRf+wlGkoJd0o3
 KVorSYgmtaYTTf6qlaqFOQlHaypSrRD5LNrjLG1ijFM3U6hIrEA9/jVMDZOAyYUav8Aw
 eKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792182331; x=1792787131;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FWxctqBBVZJ2C+PVBQJ7jKuoiDSTWA3txT8eaEtBkGQ=;
 b=0iG7j3NIsOQ7egwjM/zNLyCKlWOYeqX8tUh8P5kfS60o2jpq7ic2iG8C+/2NR+rKpE
 hZ+RWTELGRSeWYdPz6GcZYIgeoWvTkFyRvJneTlNhfXuF46mGKJ1lQbB4CHZhQZlSvUv
 oEbRi3lPF/ZG8f00I2KZF6fQKK9UnW2YeEr+Xwleb6RLo9JmC1I3+Cy+8v+mK0287DPc
 dk12ebnQoZPRE6JeYx5vG5ftbP0fQYvAVUjk1HKz2E/s4omRd8olB59algoSWXIRt9yy
 jce0m8caKGlznEwkblWh1f+Xp/CANjsPgnHDq2ppQAZg0BWF1yCw0fOymfCTk10uTXiP
 UbtQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx10UN3Wqw1XfRD5JMJVVSpdTPfn6eAXIhl3ZQrZpoKzFfeNEmqUHKt38Uqavkq/q+wnKUOimMleGYs@nongnu.org
X-Gm-Message-State: AFq9FYKjPPL7QvVmPPM5XivyihzQux6Pvfg60Poc9JwIq4D/zeX5WCnq
 v5YmeSsZtC4sEUQQuT/GUJBQADhfYoIA3Na2/9/SA5DAKjd4XKfQu4/Xskl4nlHUlriNy1sz6VN
 PkrP3EsjYbzeNiyI8Tuaq0pqr/WNWVIKsYRHFZtxwSOAkhW/Ga4k0uiNp47S9cz9jzA==
X-Gm-Gg: AYBFou0dQyQGJjFBPy2RJkh0rUEIXrVXIVirNcAWW+jhM6jB6LTiI3qTRUDKpwAKOSL
 uDJfboFtdBeX8yRlX4LC+LQWpsn99+EELDLCj6WvJLSG+mtg8ih/zO5jTyM6BVI8mXDTMYjNE64
 HalaZFgs/TWmtIBrytCAZ2meUNH5+BQIrVMmrCghaqT8BfQi7+Lh4NdjMTvGCjM4lAf+J7Xp1a+
 3o0as0YhZ6824CxyG8KUwJV0KKt45uCYQv0uE9ZMPISj6QknQOP/pXjNE3q557/hBnbPjYQC6hg
 zeP25XO7npCKo9t5LyWZuzQLJGo+yqM+cIgDUUE9EZE3adYfea2sQXYH9ahyh23+N9zRLk1/CcF
 uGHplw425jGgiE2hAe9KoQqvzm3tpJZl13EY=
X-Received: by 2002:a05:620a:7102:b0:93f:1ea2:350a with SMTP id
 af79cd13be357-93f29b6313amr185283985a.8.1792182330968; 
 Fri, 16 Oct 2026 13:25:30 -0700 (PDT)
X-Received: by 2002:a05:620a:7102:b0:93f:1ea2:350a with SMTP id
 af79cd13be357-93f29b6313amr185281685a.8.1792182330526; 
 Fri, 16 Oct 2026 13:25:30 -0700 (PDT)
Received: from [192.168.68.103] ([152.234.126.58])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f1a16c21esm298927185a.16.2026.10.16.13.25.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 13:25:29 -0700 (PDT)
Message-ID: <0717980e-2f06-4667-ad13-efb8543ba28f@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 17:25:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] target/riscv/tcg: restrict tcg-accel-riscv-cpu to
 riscv targets
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>
References: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016182751.264704-6-pierrick.bouvier@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261016182751.264704-6-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA4MSBTYWx0ZWRfXxfPhSOo4V6c8
 3UzrXz0EF3I1roM5fpL53H5ZXi5ytIpGyqBlxzrrX7FKrmzZM5l2nWUJLYCnc9TSMa0i3ChpEVi
 hsXwFWwL3u78SY17GVXu/vwIO/L6tvk=
X-Authority-Analysis: v=2.4 cv=H+BOUOYi c=1 sm=1 tr=0 ts=6ad2883b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=XIBTAJF/fpiF5bhQ2IRv1g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=aQspc1NLAxrKR92CIUgA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: dl7aMDj235P24x0uOLO3dX-t8G6_4kko
X-Proofpoint-ORIG-GUID: dl7aMDj235P24x0uOLO3dX-t8G6_4kko
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA4MSBTYWx0ZWRfX1By1VuoTmTpr
 KTxvyeq02DJWd6e4z8Z9EB20md6BMD9V6K7RL/tNxb6lYYIcWfvJhj6d6MdU4u7dOhGQvdg2wbl
 apzxnHz4PC6/mMo2RZWqMVyWaGQNJTQv9uVxXm/haaS+Dcvsn4R4DemxJqsDeU4iN+t+abrbaMM
 BYioamtUFEIdDF8gfJB3EQfwBGiVeA39CYTaq/IWl+q3BsqOM2E+9qAp5RV5GRWl/x3UnikCdQp
 gfTCLfJFy/7sBX55nEsGreRczpt/nGbvZlCKg0/5ZDbAOSYpouTjW49LonguAfOf9ZDnUDF2zVb
 FQ+PKkxj9kYIs0F/I3DE66wOy4/XMjLmjVC0VTb0ttXPx3imLOu3GUkxwHCVYaIYS0DShrL3dWv
 YvAyJPWaqZkPRSAgltLGOD8RLutq3QONFL/GZkGpZ3z8vSN//oO+LhPxsCaVbJIJ+UTrMy61V+8
 9XWBHXXaifYomdRch1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 10/16/2026 3:27 PM, Pierrick Bouvier wrote:
> $ ./build/tests/unit/test-multi-target
> Type 'tcg-accel-riscv-cpu' is missing its parent 'accel-riscv-cpu'
> Aborted
> 
> Parent type is conditionally registered from current target:
> register_accel_target_type uses '"accel-" + target_cpu_type()' as type
> name. Multi-target test takes the first target available, which is not
> riscv in current state.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/tcg-cpu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index e07ca95e49b..be913602489 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1749,6 +1749,7 @@ static const TypeInfo riscv_tcg_cpu_accel_type_info = {
>   
>       .parent = TYPE_ACCEL_CPU,
>       .class_init = riscv_tcg_cpu_accel_class_init,
> +    .is_available = target_base_riscv,
>       .abstract = true,
>   };
>   


