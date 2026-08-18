Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F036C5DF67
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwCPO-000535-Jw; Tue, 18 Aug 2026 01:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwCPN-00052f-29
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:30:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwCPL-00007n-Bn
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:30:44 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I45ltm4187015
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 05:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cB+wz7O4ClA9R637DLsyd5ih+xAPxFSqY4i8ecv7WdA=; b=LMVYI+PzJ5Ux2W5B
 K3PrpSIi0GEgqzoFdnD+sFkZAJMc12xw1Cgw0SoMfo9LBtPxBeOnRfPWbIqEkrE6
 VN79u9wLcjWUPTjLCuXSLosBSzpfUOGaBWujvH+a6an7JPTW4ektnaRkj3BRHQJW
 dSlDBp3PUe3IgBKbrCOp1rQYC+pxsiqrgjj7vn/sa0p+OU0ImhgyU0oMLEpGyLXf
 E9c1T2pc5uLA+0IKY3THjP4J+GpRxvKKFz16QPmGedhpGQVhee5lyeQ9w/9tOkJV
 6yQCpIn71VH8ciUbQYzKWt8PB8rAspukZPXQZqyui43K7znIaYBib7RwdMC87lA9
 jELyrw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4g2p0ar7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 05:30:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e820609d9so413081585a.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 22:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787031040; x=1787635840; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cB+wz7O4ClA9R637DLsyd5ih+xAPxFSqY4i8ecv7WdA=;
 b=hNGtr8j9cE3XrJ6NT6XqlARFNBl7z8uG+uLyAmx4Ya0KrRmBePaX/Vbv1mCya1ytiI
 9lHWbeh9003Dpz1zHTPbJGzn+KupAkTdJIZODD2+bpNI1lfDefqdf3ntrYCK17RM+Bpk
 Dg+qzYcTTZ2hJvEmvXBRc1C2aMiIxmXVQwskzbHxbI5gjIZ+lvuzD/tRxMR51uEgTq1i
 7G+sWtBljro3ndgFQZaW2AA28OYYZdSwtVbwalph0b8BeM1Th1vXufvnDFr5rHFqikRf
 1iZ3nDzEYO8FAJ76vq8iC36227ZQLdEDSJ+hzyXrLUZrWSNVQelnvkup1+MunmFIkQEq
 yBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787031040; x=1787635840;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cB+wz7O4ClA9R637DLsyd5ih+xAPxFSqY4i8ecv7WdA=;
 b=lnFZu2nAoJ7m41ItqbUFiEyPr1cWIsXYZuZ94bn6kDm2zfbSvAjY6iJGRZEkVAI6oX
 QaLYLevFP9zU+7CbngZS2VKNE1QMWblxGu8f3Oo5FlYodrQL8HjGQM14aax4HdjFruLI
 G/oom17fkGRpd20ET0HJs1eY/CgtZ8MfiRSJzOIG1i/RwxVWU0wKgIYVDBHggmLVxptc
 VYSHIMEoqm3uz+Vf558Q18Cn5Wr0madQPAuTzK52wpGWelbz92YPcRsZ/R04Th1BUqjG
 xog5opxwCHk6Bp01mVgCP+gFi89cUHBIGCtOWm1ZrOxhS9jgmKoBJTBtiCxiR/kCbhi4
 1nXw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqseqhEJQfRbQxXjetL+k5LQ0bEIQnhCWA7LMQhlhVLIljLTdQrdoGB78C4VIiJC+P6GGpkTeX6JGA2@nongnu.org
X-Gm-Message-State: AOJu0YzHioBuFmLHSTOHiJfILXg2tHyLlSi7H//10kjshN3GpbuJqWII
 A68X/UsZlzAjK2/xXH7nu/ZNM00xExcOHiq6uKBxgcedjIcx0OcqtpNxyVvta4mg3z/ShZ1tgJ/
 cWt4fDbyzUWh5z710NeobgyNS1/jRox+xsQcLiWlamXKduFp7xfiGJnk3eg==
X-Gm-Gg: AR+sD11ZYoswXgrju9RUJlyax5N7IIgXsSgFSA+dOoQNbeExe8QNHO0odPwCCCzE25N
 z2rdutnxb0Mxho5cVk4Jys86SWxQI0tXn9oJ5Nhb3EOA2QNg1LNPOd94Zo/KLnHiSNcPyIrJmfZ
 FyPmbVUlRlY0OA9R1/OrhrfcRQixfZhFvLV+6JK0XhcyXqAn6WTxy92NVjvnsQXCzWR42jU7V55
 w6BrTKDZ/vu4qbHGRX24WvszFXG0uz5I8PZpON+V89izhCGcg524XgGRLwTzqTu6kYdOYpX3iue
 0DGG0ToY8UTeRtQ0+MU28Om9iCy4O4Y564gbMq22xPkm+yl0QLp6HZozDW0mBon2GpFrWdX5UVI
 8yk6Sn/EiRmp7VHuwScIFTq7cFh9MvrH0i3s=
X-Received: by 2002:a05:620a:4047:b0:934:8232:ed2b with SMTP id
 af79cd13be357-93704bd0fa1mr612708985a.28.1787031040462; 
 Mon, 17 Aug 2026 22:30:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4047:b0:934:8232:ed2b with SMTP id
 af79cd13be357-93704bd0fa1mr612706585a.28.1787031040072; 
 Mon, 17 Aug 2026 22:30:40 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b896sm9442550f8f.16.2026.08.17.22.30.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 22:30:39 -0700 (PDT)
Message-ID: <9b57f2d6-de38-4d5f-a4ea-cf57ba45c725@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 07:30:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] hw/ide: reject an unsupported CHS translation
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zheyu Ma <zheyuma97@gmail.com>
References: <20260817205242.1199851-1-den@openvz.org>
 <20260817205242.1199851-2-den@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260817205242.1199851-2-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _sIKS85fskxx5mmD8TlbiT59KVeIkjbi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzOCBTYWx0ZWRfXwneiBWHzJkbx
 HahPLrcx1hVL6rEbKSlJ9TkX+VyDv1Kf9j5Q13vS/AgKu9KxrAOMJrI2hHK+COP9mNl0Br8rX+Q
 c5QyH7aEzR+48Mn7z+WveA24EEJUk3g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzOCBTYWx0ZWRfX//Diy5p3dj+0
 IO4z9EYegHebrq7nsBY+SIsqKy9pbqG7gnw9SqtsKQyGDCP3VsEjmntAmLF0DkyYNwLww/DSxll
 mATWqMAiYh/RW3r2flDLqdRrr0RROqLAnkIecRMx3ouwMjnfXBFSESzTirBw7uTcJplgwGKuCex
 YPtzhRCwqWTsF8ofP7NL8wZ6B8w+Rd4qjYZwzFbrz6BNBcoz268iThYclBFJ10SCDTir4+YRX+t
 FC+/+8GDZm6ilNyQzRCurE9VYI42e4Z1QcOw4reDv76JP3BgD6gGzSuuwtpPWYmlkgBKIrAP0Ip
 6t9ebjeQdADpqRhxZMg4wEPpLCSe/sxSZwcH3DQnA2VqOEEX97D9DTc4T2myrIKY1q3xI52ctkO
 KODyPZYVQWBCGHgY+F9IwVtlCshU9hpzAwfK1mY7hm+u52l9eynBkltQzCUI4Bi1cT3wgPd+74G
 9s59D0U2Elgc/4rqDLQ==
X-Proofpoint-ORIG-GUID: _sIKS85fskxx5mmD8TlbiT59KVeIkjbi
X-Authority-Analysis: v=2.4 cv=bfRbluPB c=1 sm=1 tr=0 ts=6a83ee01 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=6rqHouBjAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=Hx1yvPaMooE3kwe23bt7:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180038
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 17/8/26 22:52, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> ide_set_sector() divides by (s->heads * s->sectors) when the drive is
> addressed in CHS mode. Both come from the guest via INITIALIZE DEVICE
> PARAMETERS, and cmd_specify() stored them without any check, so a guest
> asking for zero sectors per logical track killed QEMU with SIGFPE on the
> completion of the first CHS read or write. s->heads is safe, as the
> command passes a heads-1 value.
> 
> The count has an upper bound as well. The legacy sector count register is
> eight bits wide, but handle_cmd() takes the count from a 16 bit field of
> the register FIS, so an AHCI guest can ask for up to 65535 sectors per
> track, and the CHS branch of ide_get_sector() then overflows the int it
> multiplies cylinder, heads and sectors in.
> 
> ATA-5 6.2 numbers CHS sectors from one and ATA-2 D.2.8 limits IDENTIFY
> DEVICE word 56 to 1 through 255, so neither end is a translation a device
> may accept. ATA-5 8.16.6 requires an unsupported one to be reported as an
> aborted command: do that, leave the translation in effect alone, and
> refuse the value rather than checking it at every use.
> 
> Cc: John Snow <jsnow@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2399
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   hw/ide/core.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)

Cc: qemu-stable@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

