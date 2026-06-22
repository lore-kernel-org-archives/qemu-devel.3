Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C764ACDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbm6x-0007Fo-T3; Mon, 22 Jun 2026 17:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbm6p-0007B8-HC
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:23:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbm6n-0007xY-QX
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:23:11 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZwci1612690
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hHR9ZB7AZl9ok6pLMsVoA2GiSQtmbdk6v0i+v0f6i4U=; b=iUZPNpX3FeZ0UHqw
 FunLZ1t/B6xXX8Vgl+C+TICyyIRSTRBbFGKGP0fgvCm+5mWUZvK7zQzjwdCVkwun
 fHD1xcF0UF603Ft2WhYNJv1AYcj7uJyTw/JP5Pt9LYGaXxGN2OyrihAYlIRS5KTv
 4DPwMgVtxFoJkemasw/8bH7joTVI1LIvCSEXgyGDHIKINkyPQmdFjHPa0l4Gfwzo
 5KmP+iYLXX7cUnwRc5avthwj+X7ywhPoEkRmPu4GTQAF0uPFOMzpGD9k1c3BfOcS
 WaxPUbia6aHKfYPvM6I1xvMP/nmShLVgC2oUS3ZHjy2xDfzyHqJmFk62I7J6GUOt
 io9jVw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yjadbw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:23:07 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ddad618405so110320986d6.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 14:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782163386; x=1782768186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hHR9ZB7AZl9ok6pLMsVoA2GiSQtmbdk6v0i+v0f6i4U=;
 b=Z8llQQrUIWyLDoln+qfWIkP1vseiZKgXYZ2zr4ycJKRWK4LtA5hnZxLwXIjtXY7fkT
 /Sn963OIpErSE1A5MAfjpuPTkn3O5M4w2CPv4sQNZMFDYGoi408FeUeFwsUHGt1yV4Um
 s19Mjj5fOQdRyojN+CtHlVQc8nkGZkbPhxFDci8Agzvr7xd7ZkzZixPHDdFQ7EKZcDG9
 N4sH5L6LKiVEuGu4kemw0sEobuJ8t6KuGUUj/cbzifseSQQH9EJ3zGIs0vLW+9/vkWQ9
 STGpPeE2iY6f6BPCfo93Dh7geE+ARfEYNk3FwRbHBCR1qV/6ubj1P2wHCqjPsD4GFKgY
 OPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782163386; x=1782768186;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hHR9ZB7AZl9ok6pLMsVoA2GiSQtmbdk6v0i+v0f6i4U=;
 b=TvXnEDFgTiJ8v3OkmqN0txYjl0yIQB3gP4X20DR+IGp2qBv9Sb0THQqg3AxUBhHcL2
 Lvnk0F6VdiuLhb3i/3zqLbeEWDJemhQKGo+ITGH2Bpg8Fk7Uu7JXW9MD2pNO6oc82jNi
 aFV+l5T0Hg60GChAkfDV5bCrZTcAbr9bD47VtucmpgKiMu3V+wRgygIQ4ojSqKwmbsAx
 PciIFMmFAa0QqyFTSbMTsiBEbXIlhrXhtruSN3wQL3+iVc1tVGlyZexJ8v0/zs4PbSgV
 vo7FYgc9D9QO5vFoX8aAqqyjQDX2KT45XjcGVgWey7NegLZpRfk6C/wGlEmbeIEx+k+h
 4/bA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xZUwRqsXC56VsPHLc14d2Qk9Dhq442dpohphGo7zRFPvbCqdpqlU7ijNvxfni00uDTe7mIVtkei/x@nongnu.org
X-Gm-Message-State: AOJu0Yzk4NeCSI5cv1s7mo7l5J3M9yTgE8ncCN6si1xbIGi1s3J7v52i
 qjIItb2HLoztK8ngWBpePTiq5l6+g5DE/krMkc56shOKleH6UeR3FVg0iBz/fRQo4QqH7GBRjjo
 8AxcmKlC1eTa6FTzJ55t2INNiC4L1kNV4koJNVwCCiSb8wy33ZzXojPcXVA==
X-Gm-Gg: AfdE7ck1KkI840Kq6g5fgt0//DsNV0sB1uVdizyONNze3xkQCZDI+QkLhNzUQnwVAH1
 8brucZ2SsidDPntYsbzAXjMX6NbRR/0sc+BI9V3GxhZkIcUZp/JPSkciVyPOjYdXIJgOU7B6KDv
 w9DsCHr3TsYheafN16PBFQwa65KlsZXotMtVlZ9Far1GVELswfHTlWAWuZBkRk2UaQZW3YyBRUI
 eMKXzG2GLo64MAAUzUnpxcsDanCGbyR1O9gPg9bLoav/A7BxCw8Az2hsv5OIBsTzQs7apr08QaR
 ACaaIvk7LJhUIAhIAm+s51PLGXdA71t4mkdoiO4PnPuKAiXgiiwambfOGOK6S6QinYocj6LeHGt
 Q6S6Qk7gIy57Ouza64Y97LwENABoI+vuQHPvVWjZtTaMKdI0p6SJIVl0nSAdCLg==
X-Received: by 2002:a05:620a:628e:b0:90f:5da3:950e with SMTP id
 af79cd13be357-92644335417mr43844685a.9.1782163386434; 
 Mon, 22 Jun 2026 14:23:06 -0700 (PDT)
X-Received: by 2002:a05:620a:628e:b0:90f:5da3:950e with SMTP id
 af79cd13be357-92644335417mr43839785a.9.1782163386021; 
 Mon, 22 Jun 2026 14:23:06 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240ee9bc2sm229929305e9.1.2026.06.22.14.23.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 14:23:05 -0700 (PDT)
Message-ID: <50ce1e98-2c1f-4cbd-b191-1eac324b71b6@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 23:23:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] target/riscv: move TCG files and fix --disable-tcg
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <52c3605c-345f-43d2-8cc6-794980c805fa@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <52c3605c-345f-43d2-8cc6-794980c805fa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RUAmpoGIvXdExMJomEMbIoiMVv9BZVQd
X-Proofpoint-GUID: RUAmpoGIvXdExMJomEMbIoiMVv9BZVQd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwNyBTYWx0ZWRfXxNc43gtJdT7r
 AZbuYGoSNRjR6connfIrjYXr0YYAMUKncPKHkEabWi/1vpJF11NYBNZqW/AT5A/DY5zOoNh+pS8
 6yzdhDjl63xGzOvSY1KQbrpcgEhxm4U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwNyBTYWx0ZWRfXyW/tCFB7Clnf
 jNFLkrWUmTHuhgeDWyWh70mlFg82zuCxmLkWF+tyTkDzd+LYPUSO6aoINVVal4VzgCpcghDvJ8C
 iA5WJ2Bya7H4JU5XVkEiAW1rScbeMEaZgsQXgpJQY/8LIGSGTI/RwiBQ/WcQh0lk/xWM62gUOT8
 mRah1f/La3C2QUoVjOgsRHgtzNksB7AE4Cp3ME8Z/LDvWNJVwhqdBPcF1FnWI/z+nzV+BlMwZZu
 ucfkYRWC7nbDHgo3mHnmVUZEW0uI/NPwTi9ezRy+PPHkqxkrR+o44SAy7xj0hU193H2uGJnxFl6
 GlS4nHRApDrABNBPU4FcIpzpwqwVLGaGBxai2ELZRYsk1WB43ScNbqkc0aS8OOy2zCm1uN2wrhz
 ipsfeKHtiEwY9wtVeErW23ntOUCkcscVcoZbBCmzeXvJixfLeX7b1V/dKxeHX9uPKhzDkoO2dSS
 JddnZEsANEoW4pUaPbA==
X-Authority-Analysis: v=2.4 cv=YLSvDxGx c=1 sm=1 tr=0 ts=6a39a7bb cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=eW241_jYEfq5I0jrBXIA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220207
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 22/6/26 22:52, Pierrick Bouvier wrote:
> On 6/22/2026 12:31 PM, Daniel Henrique Barboza wrote:
>> Hello,
>>
>> This series looks scary but it's mostly trivial and mechanical work.
>>
>> It is yet another attempt at fixing --disable-tcg.  We have a recent
>> work sent to the ML [1] and we had Phil's attempt back in 2023 [2].
>> Phil's work didn't get merged and it's now too hard to rebase and
>> revive, the most recent attempt got misled into the 'what is common code
>> between TCG and KVM' dungeon.


> It seems like series does not apply on top of master, would that be
> possible to rebase it?

For some reason the RISC-V series are handled distinctly than the
rest of QEMU, Alistair queues work on his repository and developers
are custome to base their series on top of it (otherwise Alistair
can not apply them on his tree and asks for reposts), see the
riscv-to-apply.next branch on https://github.com/alistair23/qemu.

