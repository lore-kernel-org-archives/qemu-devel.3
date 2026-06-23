Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1F6CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbxkV-0002Ng-UB; Tue, 23 Jun 2026 05:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbxkU-0002NL-M6
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 05:48:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbxkS-00027E-U5
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 05:48:54 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N7kn6r3228431
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 09:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F5AFpzWujmChxvA0hg3bh2AQb6hFPXtAkXxhemqr1tU=; b=nsDf2AC+Mj8/UCJ/
 1e5wClZKd75A+QJdjOQPpeYy7JB44NZ3eoEXixozSz70+CaIm5yVrzaUn10HJDnm
 GlauRfpxdOOkk+bB1FYa/qJXXnjPiw1umBG1jj9QOhsi6VWZV1VL6Jthg+6dkQRb
 /360GKObQMBihoJIAcSsMdr6gFw/NFb2THupg+B335qnRDeAyEp+56o8PvgYzR0R
 z1U4ZPJGustB2U6HJi2OXM6RBqZqSUX99KaXbiJP+NpNVrzv4D82a+9H0GoPjr/3
 nbpcbAqTmlDAPI8bXXQrvdcmEHkgHTiyK5e0uK2P/perjhXA/AfClkfNRY9imDXE
 fyf5QQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp29gh60-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 09:48:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91579011fd1so792994485a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 02:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782208129; x=1782812929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F5AFpzWujmChxvA0hg3bh2AQb6hFPXtAkXxhemqr1tU=;
 b=Wj+A2+5yRiE3vsg/hjyn/w72iFyIZV2CvQniTEUSO2flKQma4WG5vtTU5RFU4E9Ecm
 dbOc9tFwvAgL/56gNSAXAeF7M55woZBSpc973GkPmSwuhNUX20C2tbekiNtKU9v0IxMo
 ofJdgM5U/4TPiokxUC/RPPFUBPFFE1y/VbmlhCzjkThW0Q8WNpj13LMqRY7O4rZm+Dyt
 9S2c7nhp9uRSf+ePLXDe4Jm8c7SeQMTptWN+lLntQ/yiDTixDGxTh3T276lzxiBDWLqH
 tJ4/9ls9Otjjxo92f7NFBzF7M3oI03Bpt4DNg3q30ikjz5/BUv0NBwvL08bQCekkhBRw
 ePiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782208129; x=1782812929;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F5AFpzWujmChxvA0hg3bh2AQb6hFPXtAkXxhemqr1tU=;
 b=MpF+Hyh59diHuZR2x0yIzORGSDZjRJKd3ZL73/3+PqAB0HwaqhLSHL82QywIXMI68p
 yIK8aUQdBFJzmLiYnL5PFh0kf2tc+52N3ay0PpkmEcl/IMTZDPClwRaVMSRDdjuwEQBf
 dqpK09VV8sJggn2R4JR37XV8eAqiQ9IZtscLSDQuWevmKBhOo+0NfCNUcS4qifymo2zs
 HeXxSYa4tacpLJm8csUn1j8YIhTEQBzcSXKxH8l3Qb7cEq0SwVQgv/udchQkTgdO9phy
 fJl+3KxQw6l8SMneDdxJVzywzSq8Ds35IuBYoR21y1PHGJbGpoh1CoJdMX4lAQ2jtI2L
 SKww==
X-Forwarded-Encrypted: i=1;
 AFNElJ86Puxb3xqJazz8mPJ78HsDoz9qYUILkTj39hwbJqij7PLyX2TSlRrb+R/BkeHz1TOP0BASGE4ZXxLP@nongnu.org
X-Gm-Message-State: AOJu0Yy3+3XK6tsA+w8KO/PvMYsWdA2w8+lvvJMCJUIQftMZAoa2Xud4
 I4kUVvCg6v4V2Vh0vrr98SrFTsBsoDxYGlMZkYDldLvaNZ9A8fbzsW0j06QPlYy9qexMUPYuMaw
 qF3Ak0hZ+bYodC/0wOlafDk8qW2/8gxpp6xu0CrCKvYK9WTDy1Lmjyji8WQ==
X-Gm-Gg: AfdE7ckeS1dGezHotIWxddKp/UtHcIOsRTlyJeT+BYObSbmwih1yR4U34uVtrP9BjvW
 064zb3SSYPZcNUyGZOlBC9+Ie1vLzLqcXxJinvQYDA33F+wGUAfjzgklNLc0p3sUftItsQVB3dz
 rE9fqt8IsqkI4UVkjGh0hiT3Djn619u0bViws8ra6z/3OvcNt/Dv49aq5tX5Bs+danDlhCiUdqG
 ZbCQ5C/VweORpqRFu+u5YkznZRnE7YknT5h8N8YF/enfo73yxVK+aqT1sDxwY50W2i7cxdFiqvH
 bmhvTAuoE43kSbag7EgQy9Ejp5QssKWYH9XQmrH2e9bKP3iMcEfm8L+NzcqOf+iB/dp3FgYAqHL
 n6GGudhHHgc56g8hbQR0Z3D4KrdRCgx1nifpRv1/0g9w8
X-Received: by 2002:a05:620a:408c:b0:915:b852:4342 with SMTP id
 af79cd13be357-9208f832fc4mr2954554485a.18.1782208128703; 
 Tue, 23 Jun 2026 02:48:48 -0700 (PDT)
X-Received: by 2002:a05:620a:408c:b0:915:b852:4342 with SMTP id
 af79cd13be357-9208f832fc4mr2954551985a.18.1782208128189; 
 Tue, 23 Jun 2026 02:48:48 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-925fa56463dsm241922985a.0.2026.06.23.02.48.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 02:48:47 -0700 (PDT)
Message-ID: <9d2737e3-34f0-4f68-813b-37059615bced@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 06:48:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] target/riscv: move TCG files and fix --disable-tcg
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <52c3605c-345f-43d2-8cc6-794980c805fa@oss.qualcomm.com>
 <50ce1e98-2c1f-4cbd-b191-1eac324b71b6@oss.qualcomm.com>
 <704cfba3-e92a-498d-928b-877f7f7641fe@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <704cfba3-e92a-498d-928b-877f7f7641fe@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LdAMLDfi c=1 sm=1 tr=0 ts=6a3a5681 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=2fsAhj1rYWLWnCpaf1MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: QZY0ENcXe2KjA_c3fxhaadmQOnMMf9Cs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3OSBTYWx0ZWRfXxShh/FT/UN3L
 36qJ+shZHRQi9cJu5nsDo25EJwITl7IWxc/bGRbeZI1897tRWXAovX0fNJvN7e8kSYQKpdpBhQW
 oQK7PtMbphCVvkxSEZnrqv59YCop6e4=
X-Proofpoint-ORIG-GUID: QZY0ENcXe2KjA_c3fxhaadmQOnMMf9Cs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3OSBTYWx0ZWRfX8w792ab27rpZ
 AGv7/vsXpqDE5AhRsGbVqfc0Qjho/HszMbKfSPbTu26zr2PkhGfm7mhWwWik6MNvYHNImFr/y0a
 MQXzZbXe2mGk7dMKUebiTrks1zKknf9DPJHWa+jHyNddRcYFraK559RPKS9BFRoHwiudEw0zUR7
 1e4EMoWhadeNnSa5CzgdUZZkIQEbexr46qyHP6360WkWdnzuV3WR3MaTRdWAcl9BXzIPacVDpDR
 SYRo8ScE431Vm8RFdNFThe1K5nyjBSTRw6ykb9Qf999S5WpsIjV6i6xtmzmJhAkSmroRdzY0MYV
 sl2jt68dtoty3JOyT9YjORz3SGlXpmNsyWeJq55zeiZSPcMWHz8ffCsJluho7OnZGDPF1MZZos+
 J3zLwMHz+g4s+QCdVCShGeUSo4eN3pByqE7UIcbSl5uC0LUlhkuxws+ShV+1jbS19060tzBqUPV
 mIkk6pq6ktKCyZ0OR4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230079
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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



On 6/22/2026 6:34 PM, Pierrick Bouvier wrote:
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

Don't we have ways of saying in the commit message "these patches applies
on top of these other patches" and then the tooling would deal with it?
I remember patchew doing stuff like that with that "Based-on: <message-id>"
tag.

At this point I would expect automatic tooling being able to understand
some form of "this gitlab/github branch contains the patches" and do their
thing.  Maybe there's stuff out there to help us out.


Thanks,
Daniel



