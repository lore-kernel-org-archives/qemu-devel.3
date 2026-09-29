Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C92C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZUY-0001ke-Op; Tue, 29 Sep 2026 11:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBZU4-0001X6-7E
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:11:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBZTy-00068D-42
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:11:07 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCqiKN611654
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 15:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t9dAgan/FClYD06WiZJ6Gsw0K8DIxASjxCauWf5/5Xg=; b=fCcljLQYb+alC5Q0
 z9HCd1QG8K2E22vY3l1XLRLCd2M7MAiO+On9fYNkwFnrCfi7fAEjEVZXP+w9R5Tg
 KdlFqxCsLZwgT7Om7m61/BtTVVwvfu6qK+RUeqCxLN9+vMu0a7vMzKJN/olJUBmx
 8OEBJMJtH6GJFqpgCFHi+3PI/Yuzgiw1S83JLHDZDYkol6ktNRi/cx48nxmXDTMu
 MyhdCBKBlMWKABSvwpzNuQaKNS9cNkhnYmpFZKwztlf9Vza7gYR7DBi/PV3wG43k
 9BHviAEENzsJ36SucsVGtlU4V515InkHtC9oD8LnoyejCgKfweUbUIoBBKZC0FyZ
 4mTv/w==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h00s4usrs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 15:10:53 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-986ea272f77so294258241.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790694652; x=1791299452; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t9dAgan/FClYD06WiZJ6Gsw0K8DIxASjxCauWf5/5Xg=;
 b=dlfDiXBrKwuSlSgMwAUV733n8yrG5gf8hhVh/wzpKc3tIg0drmqPbTm4frs7Dy6Gdh
 8BhQnfZslrKLNB9jHzauJotSi7L58gPJBDhTpqaX3wJrjYs/arcTfaEyLuwEijqGVJIs
 F+Wc9qfBKzAJWgpNdmbnbGm12zPgu7tGkdd448dV3Ce45MYwQUWREWhc9RaajjB/R68B
 QwPj4HV5l1hLHNdN983DXhgjN3ACWV/WbcH6kQ3K045HUZ3Wf0yVM+MnUusn9eXZbHQX
 wpiSCYsYfYvwFYn8q0KSkSXI5W5RRfsiB1VLz+VgxqpJFjuB82LBTDEVSrb9phG5dAo9
 2Exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790694652; x=1791299452;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t9dAgan/FClYD06WiZJ6Gsw0K8DIxASjxCauWf5/5Xg=;
 b=vaFgUANyO2n3KcKkTC7qC0UlGKT+u8k8+j1e6ZBAxwP/u2fozrv83U/PEI72DqqUpy
 A2ahSL4pVNbJsQO4qKhBU3VQLfjd1v/c/50jEQxqHd4LgzSA7k8/LS7POrbkNpiBwsnm
 g8dzKjH6dYEKOSw+w+77RDuEwLYOyU8KdPntv6F5P54ZyXKnL2dJhfqV9lvLK/7P278N
 9FU/mezicl70Yg5JAzAsS2+J81/Bp6j+HjIUShsGOHcNvs1P/4No6VNj/UlZ37cJC58M
 x0QCnxQZxJXzKjB/omi4hc3g07FYekoiAKGO38diArUHB3eyJVqVsiVtk0k4Lqb8q4d1
 WVpQ==
X-Gm-Message-State: AFq9FYJMKVP4nEHzyjC+fnNe5u/hGmdolPpP8xghuvh3jNAiAYbD3tLx
 wadD5AoRSH2FH4dARzbqphG+BFHlSB15imaCMw0UQ8y/yBR9DCN4nRms/yhmcpaUcnhWYuAB18o
 gbbyAWfTfTd2LPhWHRmZHhwIiZzJjbtGB8ehxmLptOsL7qKUR4vUP+YhNjQ==
X-Gm-Gg: AYBFou1LVwj5xQC9JX4MVoWO5fhqCqaZPbeo8Qv+ZHXQmzYFWSewxw87uE4T0XEoh4Q
 lF1blsn9fMsiMdn4cE9H8C0BHgiOvqK0evMMlcQ33L9Y3mmyZqTuTbTcvLhT6x85Eeq4dz3H54S
 SsIyAibPCExS09LKo4EqygDS1SBsyz3pnotE1IvGVDl0u0QjJ/isluiNFjYBkYa5zwwfUyURY6c
 CPF6ah8U7UTJgIuB1eGx4isXc6FjU2DR5wp3+U4B1JJi8xiubYiDIT/FirU37JDvdWTWStxzfrD
 1ya7+eatjAzAmVUkgPO5+/WRADky0UTHANkgRpcrrfVhMK6dzksunTQGiBXD5lW46rFpkKoEfnD
 YFe/Dbg3p/6SF9sQlS2eT6hvh3Egg2D/vbQ==
X-Received: by 2002:a05:6102:4428:b0:7a7:198a:c2c4 with SMTP id
 ada2fe7eead31-7b1d74b3a9dmr3685553137.34.1790694652092; 
 Tue, 29 Sep 2026 08:10:52 -0700 (PDT)
X-Received: by 2002:a05:6102:4428:b0:7a7:198a:c2c4 with SMTP id
 ada2fe7eead31-7b1d74b3a9dmr3685525137.34.1790694650764; 
 Tue, 29 Sep 2026 08:10:50 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af50abad2sm4239206f8f.37.2026.09.29.08.10.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 08:10:50 -0700 (PDT)
Message-ID: <20610c52-5cd5-4ef1-b025-ed477e8de42a@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 17:10:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iotests: remove unused 'owner=' variable assignment
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>
References: <20260810141206.525581-1-berrange@redhat.com>
 <arvNgvmyp69UYcGD@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <arvNgvmyp69UYcGD@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2MCBTYWx0ZWRfX77esCymReMG/
 mZc9APywFv+lFTnTja75TpAsWdGO8MCxbxD8SmmDpIZ/hRdC7/iw6Y4yZiCNbBsfYfqLSpwpljV
 UeZoPJEs5RgsX6gWNbMthPSlFJMLCv4=
X-Authority-Analysis: v=2.4 cv=ALbfqNVA c=1 sm=1 tr=0 ts=6abbd4fd cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=0qrXtdWqIBmr4_x4gesA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2MCBTYWx0ZWRfX5rOiTcMzZX7U
 XTp1rBsfeqa5fwbAw0/Nem2eYshpPFKWxxM/8DIr1WbTcXlJ54Vo23/rJFkknBU04vhGem4o64r
 FqXGBMe0ZoKiA40EyYO2y8kqM2u6dVZqCto4P72Eci4cFsjpHJSTqzx+Wvl2tvhNxjJPwtvtxGK
 9PvASTJpvvSjU7qtyyup2XiAa1x4HofczEK20NsSN61JAzKr7Mwe9HjBCvA3uOyerflpnz1MCGd
 xdT2qkTKy8sCzoYTkOULGK2X4QXE2JW9FXMZrJJvfybXmVx4VQ+AOcrR18uZW3eyCrIwmMcFfWH
 ofHmw4UR9X2d28KQ5K14NAaXmSXj5nv5L5idRU1zEtqkfuJHNuZZ5m/IkXtuLMLWs8P7m4KfZA2
 16vssZ92uWMWNfYubNN84y8Xly+LNMoVv1jzRh7ex8gldfYs5aqXcpFxDg0kO1eg6dk4aUxf9DU
 m6Keoye2q1Ffhsp/S6Q==
X-Proofpoint-GUID: aNPlhc_GCYh7xEmzqjZrDhU7skLw0X3Z
X-Proofpoint-ORIG-GUID: aNPlhc_GCYh7xEmzqjZrDhU7skLw0X3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290060
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 29/9/26 16:38, Kevin Wolf wrote:
> Am 10.08.2026 um 16:12 hat Daniel P. Berrangé geschrieben:
>> Most, but not all, of the shell I/O tests assign an email address to
>> the 'owner' shell variable. This variable is never used for anything
>> so gets reported as a dead assignment by shellcheck. The same is also
>> not done for the python I/O tests, though some include owner= in a
>> comment.
>>
>> Mostly the 'owner=' variable seems to be an alternative to expressing
>> an "Author: NAME <EMAIL>" comment, but without the NAME. While they
>> could be converted to Author comments, this does not have a benefit
>> over using Git history and are not widely used in QEMU source code.
>> Git records activity over time so is more representative than the
>> initial author. Meanwhile the MAINTAINERS file, also expresses a
>> notion of ownership over the maint of files.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Ok, why not. I don't think I ever looked at the line to figure out who
> to contact.

Maybe you didn't had to because these iotests already reached code 
perfection :)


