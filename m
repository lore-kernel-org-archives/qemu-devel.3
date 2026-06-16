Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C82ACD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZXmq-0000p8-Od; Tue, 16 Jun 2026 13:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZXml-0000ng-5J
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:41:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZXmi-00071W-MP
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:41:13 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GH9hwm166681
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 17:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5dFWKfPZL/U++mtzy84VIXJCcKK0jTa6qTRmhXPyG4Q=; b=QH1q0h0lhPznFlWb
 N9EEYfTsa3sffSy8PqKM2NT786UkGyr1FLILQEmsv4/hHrgNBcZK1+rTp5Bh+lQC
 9lUNzWUcfRD430gPWZ3ZFXl8XV0MKuuv8wdQ9TCby9Y32c+g7LGROqDC/KrF1xnn
 t5XnqKIcG1kMQKmOhSENVx9u861v6wBOOPMSzKYJt/i2qBJra45B2QzF4ne7Dhne
 PWvNRV47iVOoAhoIGfHdvUPJwDJvEDjw9X0pfa/17tBVcq6xuvd2aoRDx3/anOu5
 S2C5iHNvQ3YjDBmPLz6Dhr9KK0AFA3uAFkjf4CUjIChirMWZG79Z2+7COkEvNDRY
 sdm2gQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09gb9ps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 17:41:09 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcc14b232so27571eec.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 10:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781631669; x=1782236469; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5dFWKfPZL/U++mtzy84VIXJCcKK0jTa6qTRmhXPyG4Q=;
 b=bFSlDRRkY/6ezah/6AYuwwuYzIhT1kW61kUVEV2V6JBpaz77/2P8cL1c40zJ61C930
 K4DF4IAKKiXzAIDK4aZvgkD0ADdGOS5I96Dp9rkSlc/h9LPZJtpO2EP2dVspYyM5klaZ
 haPoX9vtUkbGT7VObP2fN/qe/35WH8XLB8lQBfldSn+BZBYMt6pskXVwyS8alujro14D
 97ToqQE4qeObl3Q7wEO7priONLbHiGXBLDOrF4hUQnwHgWmVckxMFX1wP+jzASq58a4s
 peTUGuJScPuOxaeZve/8zQJXT4PwtSM/NexjCsCTXblfU819dsjiwPNTtC5myc6due15
 WQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781631669; x=1782236469;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5dFWKfPZL/U++mtzy84VIXJCcKK0jTa6qTRmhXPyG4Q=;
 b=hUcbjU5Z6osp5QqK1pvezxpU42vZCu9S28TH8w7QGFBFmzYebwWajD1iNL0Nq20hML
 jFdl0mTOBiAE8nemb59AizESseNXJXEwf9FUhBt01eQ5dDoHU4FqUEkCyuOZ4/LOS8UD
 bqsDDoBFNsDspLEDCpbwUqf/nwEv8LlMKmc/qlEdYhNCkPz/T14nwQ55PSrjENNszKjo
 HcWIK+5OU4v3JNMOBd+7ET3GOlVmISkwvt41Wwkbem/8aW09jDixA05VEMW1OkSROa+F
 FQEtlIImiYX4ShS4RCC0a6REjrLUm4QbdZpaFqatyr2P+lHh24rK7AReSuCGjaScjxXk
 nnng==
X-Gm-Message-State: AOJu0YxmW73lPnl+iDlDytDbMkHQ88OQ6wLaEHfwplZzrVWCQRykFoNH
 IkBDx4zKmMypn4D46qHgmTVQ3ELGYPN6sd82/1Ie/0R8W+LrSvUrRKcA5nuKO2+SO7OQ4Oynru4
 bg5QcAV/qfOJcNHulDBE0n4ilCyQAqJ5rYengz1V3/fPA/CqEYwKetpPUfg==
X-Gm-Gg: Acq92OHQjVXLnd93BTNSezCMAYsm0Sk56xU+8ITmBEnRqEkvhkcPbn3EgkCbNstuQ7X
 KyWmI2nPyn64kIQZoCQfHYmUTDDjEDhlDb6Wr/lHqz4DEGrIGdVuL3hYotOrlMS2rjuDVIDqLEm
 JK6M7JU91ZAlMRs7RYBy1cXkGpcg/pB9gRhQttDFsAPbMyivLgX+dJaRJFv7goEGZcaH+uhA6WB
 T0v4HDRqVuJra4cx/aA4Bjr3klKqvi93d+aNTqYcisCBFJynkx84Sl13v+sGEgJUolkqv3BlBlE
 UTvcr/h3SCZNDLBavZ2SypSGXsE/HYELzCC3EcPRrODOuvzbsvxoVMJO8YK2v+oEpmwqV2WR9Rj
 ksga0wtpaB/E4mFCPfn+1s231AOOvCP2kBG0kOW5NTYjAuoggEpQeBLxe9Qo/a8YH4IpiR9Yj+9
 4cGV+EmxGisvosxQ==
X-Received: by 2002:a05:7300:e80f:b0:2f0:c8b5:3dc7 with SMTP id
 5a478bee46e88-30bca066ca2mr191515eec.22.1781631668716; 
 Tue, 16 Jun 2026 10:41:08 -0700 (PDT)
X-Received: by 2002:a05:7300:e80f:b0:2f0:c8b5:3dc7 with SMTP id
 5a478bee46e88-30bca066ca2mr191488eec.22.1781631668157; 
 Tue, 16 Jun 2026 10:41:08 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081ddaf69asm20747397eec.0.2026.06.16.10.41.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 10:41:07 -0700 (PDT)
Message-ID: <889f624b-f830-469d-93f9-0af5aaba35ba@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 10:41:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] add a note on -shim to direct kernel boot docs
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260612161707.158029-1-kraxel@redhat.com>
 <CAFEAcA81cWOuu7QkC-8A2ze6MKgz0h21T442oNuDvw9uWv7UgQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA81cWOuu7QkC-8A2ze6MKgz0h21T442oNuDvw9uWv7UgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE4MSBTYWx0ZWRfX58ZjpQpGkcLZ
 F3rE6KySAsRpMb8aQ9knjvMb6XjxKaNehndqzSeFLjVslXphbQ5H1hLuxW6YonKqLpQrrLKoHTm
 r23R2bUiLYJeLGHdEzQriOTcpd4uR8QaYCUdL9xLcU6FNGiBzTiIulRD8ZV25fZ3rxYtEsUbow1
 fiXZDBYHjqAZ9zp1sFrx2YKuZkBsfzp3Qe4y7xj9kul/zldy+ql3WDuBLRvWx9Qbbf9fHtvOkem
 Tx/gCXmHAi6Dki3Zt0mym06BIcvvrOMb0pjiAMeCSPYOSSdAQKlzEm9KDHxwAhtBYYFkidBNb7D
 r9eDxIcZE1aDZpsWxeU/q0fcDXaGPSucmOfPRGF2Yf2BWm+KsW8Nqxsyeued9Og+U6B7ILuUXFH
 ZEZEoqHSNT6M36L4RX++onUtDGWoIt8fzNfV+QuNhydR78DJTf1t4DaOCh6q+KLT69vZ0QPl2Fl
 rrzSw0kFpzG/RcI1A8A==
X-Proofpoint-ORIG-GUID: CCKlyBWRuSul3VSInEcY9QCE2MMV_n17
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE4MSBTYWx0ZWRfX9FuT2OA9JHJD
 t0KhWH1PpVuFP6nMfzjWAzKsye0QPu6XwJ0X+7yIltY+Me7Gj+CWVX/qraa9z6MV7cv9hM/F6LA
 u3bxxkuUwIfk2dqvxD+YbPPZOC4s3UM=
X-Authority-Analysis: v=2.4 cv=DLa/JSNb c=1 sm=1 tr=0 ts=6a318ab5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=wLZQiVpf1cABdgcX:21 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=NO0J7Mt9X6gItusbdxwA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: CCKlyBWRuSul3VSInEcY9QCE2MMV_n17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 6/16/2026 1:21 AM, Peter Maydell wrote:
> On Fri, 12 Jun 2026 at 17:17, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  docs/system/linuxboot.rst | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/docs/system/linuxboot.rst b/docs/system/linuxboot.rst
>> index f7573ab80a..c787481ccc 100644
>> --- a/docs/system/linuxboot.rst
>> +++ b/docs/system/linuxboot.rst
>> @@ -17,6 +17,23 @@ Use ``-kernel`` to provide the Linux kernel image and ``-append`` to
>>  give the kernel command line arguments. The ``-initrd`` option can be
>>  used to provide an INITRD image.
>>
>> +The ``-shim`` option specifies the ``shim.efi`` binary.  This is needed
>> +when you are booting UEFI firmware and using the ``-kernel`` option to
>> +tell UEFI to boot a specific kernel image, and the UEFI firmware you
>> +are booting has UEFI secure boot enabled.
>> +
>> +When this option is specified, the guest UEFI firmware will first
>> +load, verify and run the shim binary, which is typically signed by
>> +Microsoft so the firmware accepts it.  The shim binary in turn will
>> +load and verify the Linux kernel.  The kernel is typically signed by
>> +the distro and the certificates needed to verify them are compiled
>> +into the shim binary, so shim + kernel must come from the same Linux
> 
> extremely minor nit, I think I would say "and" rather than "+" here.
> 
> Anyway
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM

Thanks Peter, I'll pull this and add the change you suggested.

Regards,
Pierrick

