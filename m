Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7844ECDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbwK7-0006Ia-Sl; Tue, 23 Jun 2026 04:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwK7-0006IK-7n
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:17:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwK1-0005Us-Ks
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:17:34 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6dNew3631274
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dr2LDoW3iAmsP8NUrwaKt5ix9brmaRWn6b21BVffwec=; b=Jye/m0bYuwnvzOJm
 m8DwIeEP9ow/cyMXA1rxb5zDhUcyBRgV1jf4crIiwsrwxDs3sGXdaByY6P5A7duL
 HE5rihdSjw65T7r5IzC4+CaEbnzmNyjYytYpGjnur+17f5l7ZtpUmNr5rerBZChH
 SYfiTPIK6BxxgdGh2uwaITfmMBPLrJIdYzZC/OFLdSnKEXw1KSVaXbrkhUyTYV7Z
 9NELaew8GG63/BleV8ffad7FIGwP3ONeYoZNxR7/RS2GvIZdOSFoBlkFAlClgJm/
 EaMf6hD+oX/YduKyegfnKFo2tZcaPj6fCHUBmypURkqnRFkh8n03bP4DMUZoh4mv
 GhwOIA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eymnvrexf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:17:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-921634eebdbso712903385a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 01:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782202646; x=1782807446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dr2LDoW3iAmsP8NUrwaKt5ix9brmaRWn6b21BVffwec=;
 b=Ln8PCq0uui0GkxZ55vuVSB4xRo6qKtiUHNGjcVkgpb2xtqQBAcL6TG/uJ1HvHN9ruB
 Vklrlm0lywTFVV/9qnHu/urPnjg/aD9PI6Mtn8n5WQDoolBsg2ABZY+u5gs+CxProC0h
 lBi/+NSSI09R3WNHCmiW/+UIl5uCiqW4Uvwpnd0aocU/A2RksFhsbNbNKbej5sKyedPl
 rqY3zb627KKXnA5uwXFnk8SLnThuaMARxr+dDj5kCc+tQ/GUrhGrhuVQI8GmNg/Khxu7
 bvzhkQ5GZf/T7doylzqh8Os+rT/CDVqdkBca3NmBofVPOBLIpzZzHgJokU2r68U1GdmW
 +rGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782202646; x=1782807446;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dr2LDoW3iAmsP8NUrwaKt5ix9brmaRWn6b21BVffwec=;
 b=s7978nhjDGb6SmMQf8nZNzt27hu+25H2FN8Bb+cGliO6zOgC/M3g84CfeOn7s0G/JE
 p8/wh8IbsOdMQNe2g45GSBrnvLoMdkSgPDIaqhtdylJQVVSc/QRiRbZadqaQEPNya1vJ
 bAe1LlvN53fszx0ViFNbIH1pPq+kFgPtAJlHyr+Hccx2IQJH+G/gpM8jpiQQUl8AWkt6
 SW2fXT+z6I8AE8ftgYsxfbijsi1EnOgFTDlcQcz4oJnwXaE3oZ2msdGXAInlssByVrQl
 r23/OPA5h0BsxgskZo3FZV6HybntrsV8BwK/paj0aC78SntE6tqTeRzZVJjp3c/DMUNV
 F0sQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EAplHScavKdMGqE21kMqUtWW3Tv5wkPqIWypZy99I2gj+40svqKIz7BctQDT/X7tjxZifhac0qpT7@nongnu.org
X-Gm-Message-State: AOJu0YxDY+G0qieMR+UPgZCX3AXTdh/3uzvYT7UyRqjUXowonpZM0cVF
 ooWuzmPHuBHz+pBXkLV+tY9cCEihJbSwuJHEzIFjEultUSY0Sd1jytUFX3up4iTDOjHI3k+Ostm
 A4WVuhkhbrcPtFP7a5PLDYQAZGfRT+mc7oKBbAyjYCwTfSSoj/GSIibmAKg==
X-Gm-Gg: AfdE7clUsbLxO0q9S7FwAtqN/3KCstQ3Dkac43BvF914l8o/KijPVQXlbg2pN5gxBYk
 RMc3eD3HrGwrC9l4/njkL7irWDUf5RWF9ZGUESfhE3IddnjzVvjRDXSNx8vRZ8ajZjvi/JSqeGS
 oWNJojgTa0kBshJZ1Tq9WkXCJjSFS6sOkg6VFI/utaSTNvEXIrNr9penyry3u9NfgtHBMyiDAJ5
 Onp8Py1S9fgugBvvydU9//2o7d85TMc6d4hD3kOcPpxyR7ixJYHOoxx8tFUgOTYBbfoGGQS7ZGN
 XMEnyVNK63/VEIczs9x2mgrCH01cHlw5YfzGIunoxVLZWoCUhq31cTLY/iEzMv2Xt3dKGh6dufv
 j7Ko2fjham/VFx17tGO8BiJb701o8C9mg4tlNoWshoIGVumjyAXjKBYZGjIFTrA==
X-Received: by 2002:a05:620a:2b9b:b0:915:94c7:5841 with SMTP id
 af79cd13be357-921d0b34d37mr2323891985a.12.1782202646094; 
 Tue, 23 Jun 2026 01:17:26 -0700 (PDT)
X-Received: by 2002:a05:620a:2b9b:b0:915:94c7:5841 with SMTP id
 af79cd13be357-921d0b34d37mr2323888685a.12.1782202645633; 
 Tue, 23 Jun 2026 01:17:25 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6977be63fc0sm4549939a12.27.2026.06.23.01.17.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 01:17:24 -0700 (PDT)
Message-ID: <edaa0cb0-06c7-4d4b-9126-2953b3315136@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 10:17:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] target/riscv: move TCG files and fix --disable-tcg
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <52c3605c-345f-43d2-8cc6-794980c805fa@oss.qualcomm.com>
 <50ce1e98-2c1f-4cbd-b191-1eac324b71b6@oss.qualcomm.com>
 <704cfba3-e92a-498d-928b-877f7f7641fe@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <704cfba3-e92a-498d-928b-877f7f7641fe@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dOWWXuZb c=1 sm=1 tr=0 ts=6a3a4116 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=2fsAhj1rYWLWnCpaf1MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA2NSBTYWx0ZWRfX3mBp0kLRcpoR
 PI5kNTc+x9av1UvRtBheNXaCkfekVJLC7dOkXn+KK169odzBov5/sMwy67r5PNdpXxf9kF+S+MY
 eihQ79A+HQi2gij6mVnkXxjLj5j6VkY=
X-Proofpoint-ORIG-GUID: orLfP_UXTukXiACbhBvxXFJErGAMB4Dx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA2NSBTYWx0ZWRfXz0uyFPi3Rla7
 YW8x37EbSIVyujTy0eAo4kofSWKfdrXemtsxU6xcEg1/GFt20b3IHKTuM2mCAHoIKdAO6Blv+l0
 yDA2A5TqDJZXI6EN1ThdHi/MzPDGxDdjkUPq+1CimllJsAhaiUNyYxMS1k9zEw0hKZ7HhircB89
 0/ndmyG3jk4npPjI1hp0P3V5MgxSRlsepOctT488eSL+OhtKXuCwP2TZgXjZQx5ikgdNBI94VER
 8T/8J1G+fMDFO4MZokQ/R4s7ee7H0U8Qp6hKJSzrzQB1lErZjldgcY4iwbGs0Ywv/aqexVEBFSf
 jH6HZ2HwzmYgjqMZp1AOmFbhFE0VgNIzD0w4C0Oh78UKOrFi7mcHbgyenfTNM3DHiDqcTAaxG0T
 lYeZMQoFcgjq7WAFNyPFfwyXz1+GkDqrHEzK0pp+x/C0EdIUouugZwESoy9RsmiDlBCDU4ZsuqL
 Vg1Om5VMvWCxA6jN0jA==
X-Proofpoint-GUID: orLfP_UXTukXiACbhBvxXFJErGAMB4Dx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230065
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

On 22/6/26 23:34, Pierrick Bouvier wrote:
> On 6/22/2026 2:23 PM, Philippe Mathieu-Daudé wrote:
>> On 22/6/26 22:52, Pierrick Bouvier wrote:
>>> On 6/22/2026 12:31 PM, Daniel Henrique Barboza wrote:
>>>> Hello,
>>>>
>>>> This series looks scary but it's mostly trivial and mechanical work.
>>>>
>>>> It is yet another attempt at fixing --disable-tcg.  We have a recent
>>>> work sent to the ML [1] and we had Phil's attempt back in 2023 [2].
>>>> Phil's work didn't get merged and it's now too hard to rebase and
>>>> revive, the most recent attempt got misled into the 'what is common code
>>>> between TCG and KVM' dungeon.
>>
>>
>>> It seems like series does not apply on top of master, would that be
>>> possible to rebase it?
>>
>> For some reason the RISC-V series are handled distinctly than the
>> rest of QEMU, Alistair queues work on his repository and developers
>> are custome to base their series on top of it (otherwise Alistair
>> can not apply them on his tree and asks for reposts), see the
>> riscv-to-apply.next branch on https://github.com/alistair23/qemu.
> 
> Unfortunately, it makes it hard to run any kind of automated testing,
> especially for series like this that target specific configs.

I agree, I was just explaining this special workflow. Peter also
told Cédric his preference for not using distinct workflow for VFIO:
https://lore.kernel.org/qemu-devel/CAFEAcA9HGWgJYvU_GVZCsxM7-WaR5QuwLES8aetPqD9jaLKr_A@mail.gmail.com/

