Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAF9607672A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SeYTfSWs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IS9HdAu/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtKa-0001Qy-4z; Mon, 02 Nov 2026 09:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xNtKK-00019I-5e
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:48:00 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xNtKI-0000uh-8O
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:47:59 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2DpLwJ3102602
 for <qemu-devel@nongnu.org>; Mon, 2 Nov 2026 14:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n/P2iOdb0jINem5K75eMkS3AQWzJRG8TxkYIoRnD1N8=; b=SeYTfSWsp/dmVTgK
 GcEFV+3HH7btx+qxxihgZnmvdROHkwB8LBLqSeuOP9CR6On3HcUa844vIcMUHwRq
 Mwc/jIYCERLioDraNLqj33LVk5JaGhDYJ3jwKAsqF7qIj6aiqDCp/q3vu3hbf4sL
 BWgyK8GAyhlmISGtz4GRCLQn/4C1U1WwMXpzdhw5cH86hczdd+UeGOK9w08Z1iD+
 87srPJWsudrsU/8P3pXXIxiGhcUuw4iG6kVT0JdwS33N1m7nGz0bnmfPhvPN450p
 14TFmaUCOmUIGu3KaOgIJZHDLnxT6yYsOcZP/hKs/JIaRLxH4ofq9O+NncSRO6H7
 Mh2XFA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpk9rjax8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 14:47:54 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-98c6374b678so2944909241.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 06:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793630874; x=1794235674; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n/P2iOdb0jINem5K75eMkS3AQWzJRG8TxkYIoRnD1N8=;
 b=IS9HdAu/PRmqSp11A92dsfZ9rnNCEVrK8fHi+TuLpuXvDEhjPCmGyfwGS7NsM1Xccp
 vyLRo8A1njfCFXv27ITeRsnL0k3wmDWrBANqIloRLNgm5PYp2qCIHiOMwYuz6K6VuivR
 LKg5+cKu0p4LIfu+O5MGjIiPSS3Sv9f0h8GtM6L/yR5eiTw0uTHPVZ33EiRYydUoigH9
 +zMK2eVEhKg6jtJwf3DZLQVj69oWRFIH5+c4GvCoQmzRnLA9IM7vPaferQgAsh2wmDTB
 WjG+XmSlw/JqB1HgQD0oSCtf4ylRRSFseWREeE/0t/xsbh/xc+esWyJdnyr7sAFh73Lv
 jh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793630874; x=1794235674;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n/P2iOdb0jINem5K75eMkS3AQWzJRG8TxkYIoRnD1N8=;
 b=lIdiegQ3eJcaodHW6p611szpkxyV4S0EET+ogAXq+YxJA+SPMGoIC2oGwfGndtUbUK
 fQ9hu5AJ7n6SPh6RGwaOLfebBKSKe15rGJbI7GwJjSozX4PGrc5oisfFbkLcMXhP7YYt
 ulHFXj5iQGllrUeSM7ajP4lfZif+E8/rka/3axYgEummeHRQ0ICAFgakMaVR/OMGGbbL
 Y5FsPEyYekilCnXrGy4vU+NIfv1B9LlMbWS23cmuTNEv7wgTzrjifpthOm9y5e+Xxu/x
 ZV2t+YrEIvHajYUT+s/tX3GAGCbx///J8kiWaS9cFFNK1oqfQjmwC3qR/B0IjTa1Lx0L
 904Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEtthFwJemFWeK8MJWAyGa1yP3PjS3Lo9G7NMgSXesAyTJAUmKAgEiG3jdyXF+nmjeWckwjCxSmj8q@nongnu.org
X-Gm-Message-State: APuU4Z99np+zicXyLqB6o4j4ArFlTNYFoA6kjjwyh+yOx2ILE+FchjYm
 T5EumzNG8/2hRldudh016YqQl0JHsuvLISIhiGFmp5s/R32C8h82aXe/L8FgbSblhPHZjZpZwaP
 W8yLZuePdc6eBO7nnQopOpmfz2CVG/MCrVfkohThih62LK5X2yu7x5EwPwQ==
X-Gm-Gg: AYBFou0GIj+WQ2Ppu6aZARU2Vgaol3SbqVWbOhUHvTQnX3AuO1kt6itAQYm73HlRAiF
 8WZX/8xjspaUaMmGWtxD0CtmsRZzloUnunD7h0uCXauxr6DpNvB8bLZBdPd9glkh8OkotjULegZ
 u6oL1HDoF+XHLHVXaACAM3PRWc4GSjlA07txM7NRSSRqlsVqZblpOg9ghKrAwafN9lbc3yM5Wzk
 NtM+Npln0t3dEA23mF+WeKlhDR9maZT0B5LbGAbv7systn+uy52OSdhnKiduYYXiHzZSbWf0XqQ
 lzywqTbNEdiazitsqcXHftBYA5VqeuYbpGbi2QUWawlY7egdMXCYUEP9jzbsJ5iHCJSdjDti3fx
 EHeyOxy5jTemJFSS68r7Nfzqp9r1gYow+OdIK2IsGIS2t5RFJyhUty/xQwk//SpzKzLv5XUECZq
 4RbdQ6uvqqCecqhQHWP2S/2Q==
X-Received: by 2002:a05:6102:2d0e:b0:7cc:174b:f7d8 with SMTP id
 ada2fe7eead31-7d072247ab2mr4194017137.1.1793630873642; 
 Mon, 02 Nov 2026 06:47:53 -0800 (PST)
X-Received: by 2002:a05:6102:2d0e:b0:7cc:174b:f7d8 with SMTP id
 ada2fe7eead31-7d072247ab2mr4194007137.1.1793630873040; 
 Mon, 02 Nov 2026 06:47:53 -0800 (PST)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bab1a8sm20252648f8f.57.2026.11.02.06.47.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 06:47:51 -0800 (PST)
Message-ID: <aaf723ac-e2b6-427f-9ca7-9de88c3488b1@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 15:47:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] tests/docker: Add the mips32r6el toolchain on
 Debian cross container
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Aurelien Jarno
 <aurelien@aurel32.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261030182546.2508-1-philmd@oss.qualcomm.com>
 <20261030182546.2508-2-philmd@oss.qualcomm.com>
 <8c57a107-c87a-480e-b946-1fb02a500a52@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8c57a107-c87a-480e-b946-1fb02a500a52@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kb__2Rt5o-FE4HGD1iZXJcV23iF3zih5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1OCBTYWx0ZWRfX61/Pg97Cfwj0
 9DuFwIIA8B/JEHahsWwZ7fZ3PJmFjuzH7fyDsGhyWVOfLOQ8IDHghv8IlJpLwa0J05SkTAg5T3r
 7rc7TFZ8JEtbxpv78Dpx1Zrg6W4A0jj27kyhqynkWECnO9XoP/dcrOICbWzKGcJhy7YFMxlprFK
 J8HPkXx4jLehHl39ZmXclb+ecKhAyOMgWS5bCxnxC6OYJ5ZfzUvV3v0//os5gYf/VV1Sr2ohEwv
 FA9EzmWq/C0M6/x/n/iOl19QZXO+IPXiGI2/j/ABj2/fzHTGp/6s3IihFhLvp230N7EisgTx9Cx
 CMiYvM+TJeyqvypBpYmetpUUwvyXVwM8zL1G9ZTDntWNTMoNREX/rI8rcyRJ9qRXMI02eWI7rUN
 dOjeysHDXzePJF6YPxrCo2w9wHVo3n6JSzh8ePfIlYLgOQNrqxC7UXxb3UlVy44xDK68bwBUqRv
 qVqDrDDzJi+zZrvzyHg==
X-Proofpoint-GUID: kb__2Rt5o-FE4HGD1iZXJcV23iF3zih5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1OCBTYWx0ZWRfX5AoNwoh8jma/
 s+z0elNN1khOgAGgR+TtvfoyP/rlgfB7kkg2N7KofsdKIeietm8yydkzxSCdhtupDvA7/m5Dh4g
 NB4nUn0jH9buTJvwkO5KBdefXhCgAQ4=
X-Authority-Analysis: v=2.4 cv=LvwHWXdc c=1 sm=1 tr=0 ts=6ae8a29a cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=0XoTFN-cgOzZZG-M224A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020058
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

On 30/10/26 20:18, Pierrick Bouvier wrote:
> On 10/30/2026 10:25 AM, Philippe Mathieu-Daudé wrote:
>> Use mipsisa32r6el-linux-gnu-gcc for the little-endian MIPS32R6
>> tests and install its compiler, binutils and libc development
>> packages in the shared Debian cross image.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   tests/docker/dockerfiles/debian-all-test-cross.docker | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
>> index eefc03c49a4f..4bbed2cdf08c 100644
>> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
>> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
>> @@ -89,6 +89,9 @@ RUN apt update && \
>>     libc6-dev-mips64el-cross \
>>     gcc-mipsel-linux-gnu \
>>     libc6-dev-mipsel-cross \
>> +  gcc-mipsisa32r6el-linux-gnu \
>> +  binutils-mipsisa32r6el-linux-gnu \
> 
> Any reason you need binutils?
> Seems like it's not required for other mips variant.

Not needed indeed.

> 
>> +  libc6-dev-mipsr6el-cross \
>>     gcc-mipsisa64r6-linux-gnuabi64 \
>>     libc6-dev-mips64r6-cross \
>>     gcc-mipsisa64r6el-linux-gnuabi64 \
> 
> 


