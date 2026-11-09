Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD3F606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 21:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c1UNsoNt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fH9/ruRF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQX59-0001cP-H5; Mon, 09 Nov 2026 16:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQX53-0001Zi-RO
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 16:39:09 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQX4w-0006Ry-TI
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 16:39:08 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9LA5lI870443
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 21:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hupHSXtTU0UxRz27qZwjOmHLJdTqw5YmiXGEcEGqqHU=; b=c1UNsoNtBG0dCJ31
 8ow8jAR0sZ9PMBgQTQKKdIxK7BU+pWYm1Hzgh6lwaR6OiuCSMhW06qGsAW4t+PL8
 tOLQgvspiRdvdosC1KXZocv7JPk0TyF7Xiojh1siBYiI+d3MFyTKMs//xSyJ7D62
 kKWwgG+4RufpMOO/rp4Lf0NV44jLCTDr32rx8xy3s5e78CStzaz93IziyQvulUdL
 K5BQSUifid5t5jv+riJcDnJ1WKx+lZlNdiULWzMldJ8yXNS1Nr++xPibyAclbgR1
 2rAnSBlghpGiVf5Ltqr+ZSCm2PF8Xj+0lespNXJE+Ly2IubKHFd2c38UXELvOcaZ
 qosPbQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hua58avn9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 21:38:59 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7d27e34c97dso138307137.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 13:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794260339; x=1794865139; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hupHSXtTU0UxRz27qZwjOmHLJdTqw5YmiXGEcEGqqHU=;
 b=fH9/ruRFYJTiZuddhNJGQvlt97W+IN0Y1izSppLxjLkf2JmXY6NKuL4kXnS6u6c1tB
 20iymAIsGgvWCq0eqwqqse40dHxMkrEa2cMx4G55Z3vRrmoFzUmBPVPyiBVGSwlQktHs
 R5Rd/MkmnCwAQlPHhatBUpHJibmGqYAUCLosXjmMLR6JGNU4LwoLOaXMtQvFF19vb0Y2
 JDUyDgpRAl98DcJh1cDCYUJy1batfWiuJagi4UeCCmjpeQvejBrKh5CAWliGJsprVqEg
 VDc6UISzY/dKjd3sRbWvorC/oSEfGKNFVjdGLJ5E7xJ0Rlfk8QK9r5/ZIDue35j1cGm8
 LkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794260339; x=1794865139;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hupHSXtTU0UxRz27qZwjOmHLJdTqw5YmiXGEcEGqqHU=;
 b=yZ1/oVyT2//tA78CjGsFp6cMBzsbx2cE8IQBLdneHK4ofa7GroZ8OqbHszt0ygnS7Z
 hdC8tBllj78BKzpoJtf8znVpZFccjlHAjAyMqRLwrSvohKlaOKNHAbATWzqiU69gKbFA
 XnclcuY+dpX0K7ChTzKouDXBVwpGtc84JRliBCd1SmBxAZWEaUeg2JM44T+YXTDfGETC
 v0z7YLa5eZOcFgKhczKFQxbOm4mugykFQenDrV8FP76uf7U69YdBa4LuaqsqCsR9UoH0
 U9lPUTSPaQN0e1fDTRncmO5KIjsXClGuRuTEujEokAANJ2e3vqmy5rJpaAC3+xuBzuMM
 7rhg==
X-Forwarded-Encrypted: i=1;
 AL+hErHlzHvJZw2IzsgE/nAHh4+yo2FE3qjdO/Av2IImqBlGBGxjJqrvfaweiV9rEDYsJCuvKGEBmEf9OC3E@nongnu.org
X-Gm-Message-State: APuU4Z8znPrQttg9ifVSCR15Oqam9ZIiRkWbHLZafiU3U3oYP0BCrsTE
 VJ1+TCmMPB3UFwbQ6n0oQZNAQoNb4jVfgXvJ+yjDs4/zUUHpe6IGpuDwDyvtAkzl6yqKYBq/Boo
 eKKRHFgEFpOy8xV9ot0sbvGhy0j458KgWkyLsIbxJEB8y6iEWaaLPzS4OiA==
X-Gm-Gg: AYBFou0pAz4k+SD/mu4LwdPkxo6bNGfMV28UxMFRpfl8VTWgLsVk8vkslWH67wDRiPV
 I6eb4hYCtcgjqCLRGJUQtQeh86BL3/O1yKLloMPNZGcwDs0YYHTG5ja61Oz8sKMAlhFYeX6g9FS
 Y/QfqC0qKB8MIKzqqblDbIkxL3FVhNzgOM+gNvZKEE45oMen+8Gy0YhGclKTpBNc2VlZw5VbY04
 8zXFKRYA1JBE9ui0auryy8g8m7hgcUhTR9jHhrIwSQLf8gbnZG2eaH/vZkOxXz8cQ2StWKohTHf
 A6k8LX8T6mpki+22fpnC4psy7Lhlooshxk224i7ABm2JYRV5AYeMpH6/64/QUGmQmJXR5AMPi2P
 CP0K1EKpcSBB4/e+6wRp+X50zHGYsg+DbzOk3Nje9z1kyqGon1UwDJiCRw+MblyDDpxCHjU91+m
 NS7DSzxQ==
X-Received: by 2002:a05:6102:3f8f:b0:7d0:56e8:d146 with SMTP id
 ada2fe7eead31-7d301b9d300mr186147137.12.1794260338757; 
 Mon, 09 Nov 2026 13:38:58 -0800 (PST)
X-Received: by 2002:a05:6102:3f8f:b0:7d0:56e8:d146 with SMTP id
 ada2fe7eead31-7d301b9d300mr186137137.12.1794260338259; 
 Mon, 09 Nov 2026 13:38:58 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498367ba82csm1250507f8f.50.2026.11.09.13.38.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 13:38:57 -0800 (PST)
Message-ID: <e9317931-6d8d-436f-b250-0c0a9429dd84@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 22:38:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/ccid-card-emulated: Use QemuSemaphore rather than
 QemuCond
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20261109203817.1683717-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261109203817.1683717-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4NiBTYWx0ZWRfX7l5lgtQaoMzS
 W1wp8EK4fZ/yLK+XC/R56O5hTbMDfSJoRai2gQ71fYuUrke+S0fNBBMo62VH6xxJnY+5lqs2Bwg
 XwO8Xqwp1c2Sof7SUJp11yQNFYDiTODp306jlgEeicwfWqC9neKtC2hk/hTNeYhhwWpgIobIx71
 3jVTKcxYa5WKcF+rEdHDJ3aIo28IvpuhhyEX9IhRMdDVlLL3g+pDndgXBmR9cQMT7jyVohdBKi7
 jnhmAtTdIcKtz6eOo9TXGfhfsdwcNYksaKaIpp0m3+5A64UMCV4ZkHknrj3sANL/DpDnaBieyg8
 a+mM1BLmR2Yoxess4VYCnAJp8/64M2WOUtNwz1DLlApkaGL9bbDn6LElkQu8hoizy4+VnVXRrb8
 HPJfVGKZ58jY8sbgFVH6Gyg8F7Hux96GVS6hAUjrYESHOUUZ3fa4v/nqyq1l9KS9fiIn4ce9EY6
 dtOA7Qmk1zl9TPDzghA==
X-Proofpoint-ORIG-GUID: UlzkQTQq3n_cfHIM5PnvbRRgqTuJL1f-
X-Proofpoint-GUID: UlzkQTQq3n_cfHIM5PnvbRRgqTuJL1f-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4NiBTYWx0ZWRfX9csad97XAUUi
 pkm2OR5/Eam69lt8Bj9Go4JkMh8ziSWPUE6HhSvPNsCgDRJWQuZrEuz6cI3QbgsDIWsK6w/GOFg
 GtzFirX4krdIMVGFV+M1//jcIX0anv8=
X-Authority-Analysis: v=2.4 cv=C9V8WgP+ c=1 sm=1 tr=0 ts=6af23d73 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=cLLmnN-Y53T6JjFh5vMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=gYDTvv6II1OnSo0itH1n:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090086
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9/11/26 21:38, Peter Maydell wrote:
> The emulated CCID card uses a QemuMutex and QemuCond to communicate
> with its helper thread, but all it's trying to do here is "make the
> helper thread loop wait until is signalled that it has more work to
> do".  The existing code functions correctly, but "wait until the
> other thread signals you" is more simply implemented with a
> QemuSemaphore.
> 
> This avoids a Coverity complaint that we're not using the condition
> variable in the standard
> 
>     lock mutex;
>     while (!some_predicate) {
>         cond_wait(condvar, mutex);
>     }
>     do stuff;
>     unlock mutex;
> 
> pattern.
> 
> Resolves: Coverity CID 1547639
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---


> ---
>   hw/usb/ccid-card-emulated.c | 22 +++++++---------------
>   1 file changed, 7 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

