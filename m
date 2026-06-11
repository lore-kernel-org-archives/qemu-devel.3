Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F4BCD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXe9e-0001o1-0z; Thu, 11 Jun 2026 08:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXe9X-0001lD-NT
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:04:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXe9U-0006Gu-NP
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:04:54 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B9xTX6174218
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ERxTYedAuezs5cwoqs3WIu2N6PL3h70KNlsKrDOuXJ0=; b=TrbI4wx5SJRJkSq4
 dVCE9xiMAeSJ4A3l/fMzVCsCw4lhzuaHK35xUZWABB43L4XbeI8zykHWlYhb+pJ+
 nCX5b5CjrM6LxiZegLETkN74PN7nixB6WAIooEGWPhmr90deYyh5EDgjbB/7MQbd
 yiPQ3DuUD+73DV9fDFaMuM8iiRRia/KGNtj9/EKhmqBvlOqWD3kh0w4TTeeA8Ohr
 SWd+rQpCDL4P8f8d7HuBmwUeqZFuSxkAs2OeIWZqsKyPpRwYLyldVc/9dt/daKFI
 +Xbg8tLXQz7lFZxMSL5d7igqPKODhGbzKuY4SthYZ4XTY4q2nTCMubXwkZRRrV4S
 kDo1Dg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6vb77h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:04:50 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6cfc66167c4so2968219137.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781179489; x=1781784289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ERxTYedAuezs5cwoqs3WIu2N6PL3h70KNlsKrDOuXJ0=;
 b=eTWQsudpStY3ogOuXT4vPDqUEWclz6Uc5NadR/cBtBxdm5vyUS2Yd0JwliuFAYtXjf
 FXuOVtP2zYDvBtp4TxdZq3bq7W6QVB0kmH/iQsqkpa7cnAd+c74pr8JWoc+Dsv+6QO9C
 fZ0U7kSY6OfVrZf+XtnbcaxQcrSuhJWnIfU7IdkgWyq+a9WptWr/6c+O5nXlRLpZJA8C
 inadm4dKGdd+mVJn8m6VDVpm31dmE9n37MZzwd8exBXDIcxkWcohFb90iSZ72MTQMxWD
 ajWmUz6LlEer3YaAsuFQR/3brcrFQFuAKywW4/7ELkcVOvurlE1yaVXT9zEkYgnMbCdr
 0hvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781179489; x=1781784289;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ERxTYedAuezs5cwoqs3WIu2N6PL3h70KNlsKrDOuXJ0=;
 b=XyzPcdqzssmuCpduIPjOUZGKYXvSVfi+VqH2/jdAUnK8lajVSDD3OV6UM1OT6FM7Mc
 RTHaOcn3XxRjN/eiP3ImMIZcLuXmNRrd3FJd7e7maYy9yZOkwVJaOpuIskr8fmQgdP0h
 M2IDbLz+9iCC+z4fG9ASdWdNzZLSPOrp548WEaNVVI/xaYDQr+9iBH/xKh9xAzK35GPM
 HGkgOsZAwim9+wEoRBd0iFVa805teQDd90ISsxqPQGTNf4+P6JGyYpgUtOb2tWbHT/FO
 +RojqQeHksQPTAtQ4TbHKmZXtFfAQ2G2r+uLoJszy5RBFRIEJINjWQA9R0Rwao6EQU9y
 6DyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Te+oxxFtge5RqBpqC3CuF9LTwuUbe8qDJ4IlMMtMm0Tj/qIVIwkxFz/d+Jm8uXrvF9+O6IjeRObfZ@nongnu.org
X-Gm-Message-State: AOJu0Yz2zfaoMCq7VosS8epNp7WMHCQVdgh4+/IwmJ3Mp5IVWacwJvrF
 msVdPeNv7AknxQwPVmjJaj7p5V+iRve+JKjt0PxJi/zaADRT6/56GO7NJ7OSXScbspmlj0MOe69
 Rl7jpFUHHZd0M03hClyWStgYqo1Z+/bI7GKIWfzugFtFERBdNq6dvEiI4Jg==
X-Gm-Gg: Acq92OEgH1IB+DcEydSFyvHlJRzeE9aVOwEUqA9vh+i1PV68OkeyLuFyjsx+uxtxa07
 DtS7ieTH5yL5VgAJ9KLB+4rUjNLOKkTbX6jxB0kBibHIZK+CcKEQiqwiP5J9A3oInfG6iPHtQLu
 T532f2A9ojycOwblAtY/j4pcGcfuKc4X3N+MMopld+fnCnXNSMHdJ/s7O+SfymiGyNusXlymS/x
 /vIyEu9NBp13/X0G5I8Bs0vc72f7pyQyzlt5E6J6q7w12r0poYzuENGthsqE8rHWfq62u/U0//6
 HAxvjKEWj6SmrXfqjYH/cY3ay8/xohScRXavB+fwAe5k5XaiF2cDa2ra6ALh4TcSSDJgQ9TqWw9
 hpN4bfM/oB4CB3aCkp85fzAb3xj7w+odrTYSP+N++ROhEjW2S5HBAefemgh+G5O2g7H2+/5YRFK
 FVq6VNSug=
X-Received: by 2002:a05:6102:5086:b0:6e0:3d72:3044 with SMTP id
 ada2fe7eead31-71d601cffb2mr716473137.28.1781179489639; 
 Thu, 11 Jun 2026 05:04:49 -0700 (PDT)
X-Received: by 2002:a05:6102:5086:b0:6e0:3d72:3044 with SMTP id
 ada2fe7eead31-71d601cffb2mr716408137.28.1781179489035; 
 Thu, 11 Jun 2026 05:04:49 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e64c2d2fasm11079451a12.3.2026.06.11.05.04.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 05:04:47 -0700 (PDT)
Message-ID: <7ac5c98b-1840-4735-b30a-2c4707e4233b@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 14:04:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu-options: fix typo in spelling of 'scheduler'
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20260611113547.651075-1-f.ebner@proxmox.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260611113547.651075-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aM-z2hlATjO1W2REhD6-SWmkBYGjLbn_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyMSBTYWx0ZWRfXwrYiukyCkgE/
 N134FqH/+c2oCx8xIpPyc0urhwKoSPssMEfr9zTSdVDPmD3Vmu6iWh5v9/BG19OMcAu8V8TNohc
 GuQd4zf0Z4SE6NlUVnp9MN6NrOw3EdY=
X-Proofpoint-GUID: aM-z2hlATjO1W2REhD6-SWmkBYGjLbn_
X-Authority-Analysis: v=2.4 cv=UsRT8ewB c=1 sm=1 tr=0 ts=6a2aa462 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Qm8iP6mkAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=aoPmF-vobCUA:10 a=ODZdjJIeia2B_SHc_B0f:22
 a=kDhhxE42lZnxL3pOKqYK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyMSBTYWx0ZWRfX0rB3Ev5HkmHl
 qw7kujYqLxJHLHJvo/6hPNYL4xrF74nRojUPSUuCFvYgylNC2Tku7uvY3r0BHmMnmLQ8TcldRv+
 JZP6vXCkXEdZuG5TgMUdhsW0HRi1chpXCZ0riIZlgpIcatZApiSrWmARtFi+UC8vhtEfQc4ik1D
 mhrVTqq/FZ+ZMKIWS3uaTcbqh3OuIK9G+yHFYhZoxw38ijQ8rjkLuVurHWD1BJr1LPYkzYJ4qfx
 4ks1lu98XVYMDxS5DwEEMqrFk8aYOuO/MZfhhNidUgGPk2zilBpBjG1KKYjcaDOdr6ljh9dENdJ
 t2+62YdGhTa5Wg+JikVWQDaWg5F9R6rEuSpaVhGVraISk8cBt4X9rrFNiho3cYNHHu4n7ZzDLZO
 uoxhifdPs51PwJkDTrj/cj8iZhTnEZno5d1FCTUj1IsLcwjoh/NvaySZO8b4esgz/2KTxfcnN2e
 8dYStIEUHEQ9+WvVXzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110121
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 11/6/26 13:34, Fiona Ebner wrote:
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   qemu-options.hx | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

