Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E09606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CFnjsenY;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BwqSJ80b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT65h-0000NO-FQ; Mon, 16 Nov 2026 18:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT65f-0000FP-CZ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:26:23 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT65d-0000xi-IC
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:26:23 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGNPm533211213
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L3gRUxaU7+J9rICz8CpKtnuNVQuuYC+Z2MjUNOJiB3g=; b=CFnjsenYAOl8XlvG
 I44qov3kZTe2un41+fRtEoGD5k4plwi6/P34+djMWTpsPfqqvgXWePPBv4eIOni1
 qG939PI05i8z6NVE1cYEKRrdfhMJTVuejVncsHr6ZpzNATa8XUMTqk8VuklRzyFy
 cs0TXbvUYQJUCbcC5r9nwBV64a4PaHxo2qbUj8hC+piUgRsiGzvcoEILRX+QxkHR
 YnhG49P2CD7neMOY8a1YXatQuC0bP8+qjYGghunFznXHuLytx0SUsBy5aYT2GrTy
 u1em5MnlIKrfq2aJCe57SLnjMV+ag6FtO/wqy7dljJSJDgAjLtTUz1D13y/xeqyC
 csttoQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j07regv6b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:26:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93909014c85so367038985a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871579; x=1795476379; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L3gRUxaU7+J9rICz8CpKtnuNVQuuYC+Z2MjUNOJiB3g=;
 b=BwqSJ80bHyiFYkCteDH7Vl7H8//g8WXh8DyURgkDLFUTE58KgWP2PEi+9QyJeCnPox
 UqkPDJLuazgGiAFz6RfiWH60/XXPYZ3O5QlvsgV2LBdkOtAd8rVZ7HcZA2cvZozsXF/a
 RFyRuvaIw4VW07oBt4hAcQqj4BaT3s0mBvsHRjswG+QMBh2gZ8pBcks6gzy4eH4jl3VQ
 PCMXpmKg06oYh7hB41fPGPh+NXcRIDJFlHKjEbnDrScvEJ8Feetvvwg5ihEDLGM/9bNW
 3ZCOIlBCGVxlDdAwZP8pUjaOrj7kjdbMTUxtUciAIxJ3prrcgoponrt/qWrj6hJOb3px
 th8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871579; x=1795476379;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L3gRUxaU7+J9rICz8CpKtnuNVQuuYC+Z2MjUNOJiB3g=;
 b=uJId1qJ+q+GFyawaGd0PBErjDlLYdHC4BGG69z7MZ0pr6KcCs8x5J+hOHEBCXtJ4sN
 le5F0r89HUxlWO5oDLgVNEFlrpna5MkM1koVLbQltm9mFXEL9X53nXaRVSVdB5PhehLP
 3i+JrMU7i1oUzFC7OLeW/lOts5AFOQ8tYZeNbfQrYISpozq50LaeZ7iZCqpZEMhybhMT
 5r806RdyJZojOXTW+nXzjlK/CRUYFDjIXzWxwkbsImIv88WQQo/k8zvrKXkm1YLz4gyu
 klUXsRJdngsCsP4/VeQXgqEmqXDEmXwcGxCflsbvwpvKkDhLJwUZtC2z55jVCj7m1nGW
 I44A==
X-Forwarded-Encrypted: i=1;
 AL+hErH6QqGoPa5apnxv+6DsKMIkvpz0hXLLRbTbLAxAztqRYQ5PRAtfKG6yVigDmT4hLicuB6REDQtCSqJW@nongnu.org
X-Gm-Message-State: APuU4Z/UANetvX/3g5mMyG4rgwKjJtJNP0SkfNwKoBWtvmISeoQ8rgAF
 THiVihtMoUXBCcyA4UJz24NlJrfZiCnJXZ/O4qJWMQSMTBFSIeslY44+csBL+V3sY9NB15vE9Yv
 UvMr80SJ+X2HrgK+BEwS+ppIa5M80pOxzkylmbT6eJ5i4Ki/SgckIdlGKhA==
X-Gm-Gg: AYBFou1DJLIqXlYlsUZzuxkAVPIk/+yEzSrggt+P37EAWPinDTFO2UGrtBbuVy7arkJ
 i/f/3KJAcetzM7e6cCvYAhz5ku+7oJI0D+v2xZE5ocugmhCuQhE6tKFc/eVkIBRMEVfPaG6PxWh
 rQkdxt2czoUD3CwuKjvUx2aCZyZFJtCrDjr+XEs2wnimMRvy6ZWHypYgY5Np8hmCbbuA/BBJ/4q
 VoYyOJaqbO/0LuF3AGXK4mEo5vbtRwdv1SgxxptOGsg89myULfibzu7SoJNZ1GnwH3YMp0vFSJB
 dBXI+UeQ9HH7LPS9MaNRIy8JPNUvZ/AKs/qY8YEPgNIHHN88Jius4cCyXlbjxBHlYHYJV1fLAie
 6DnhjOw0ulQ09bZI2N2oNO1/vUPHC6rJyqguRLN7243Zm0ck6wQes1iucymlYHo7Pxj/8nGgdAc
 DDl/a5qrI=
X-Received: by 2002:a05:620a:4693:b0:949:6e15:e1d7 with SMTP id
 af79cd13be357-9498b875da9mr207359485a.25.1794871579195; 
 Mon, 16 Nov 2026 15:26:19 -0800 (PST)
X-Received: by 2002:a05:620a:4693:b0:949:6e15:e1d7 with SMTP id
 af79cd13be357-9498b875da9mr207355385a.25.1794871578734; 
 Mon, 16 Nov 2026 15:26:18 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c888b90d4sm24595241f8f.9.2026.11.16.15.26.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 15:26:17 -0800 (PST)
Message-ID: <9b65adf5-f208-4e3c-966c-e17f7228a284@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 00:26:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tcg-tests: detect redundant exe_name/test_name
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20261116232140.2758664-1-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261116232140.2758664-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX633cklV60Ajp
 a2QHxsjuRMNXJqJZmHmQ69nVPn+FzC0epRAxr1DkhLmyTEVK+kB1C/xGM7/4u12zAcqtox2v31E
 CWvQgvuECRsbXKSM6GP5Zre35DJuD0o=
X-Proofpoint-ORIG-GUID: 2DQ4EsicYVho2gAHVNUd8_hVjkR6Y1xA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfXwW0Kp4irk6iB
 CpLk5I+kk4HXnUxeVxoJGUdw82rTh9ZIDnp9MBPXEE0+WDHykUFfHpB0LCVdP0AUVYe7ZV/lCPz
 gyn/fiRMBOpchuyVWsIZk09j2ph7XqwpuuJFKqKnLpBsEEeJZ+JA4354tCZf7OGWeWp55grf9fq
 dvYm9BfQiAwTRl/ZaFz2X3ZaM4S33K1POwm4h3tq8rZ4M7jBPYTQbqGUHnFSvGzGkVFwVuvaPxm
 ntq+C1wyJirtwXv3SQup57YaNQ5gTS1wLiVwUOSG59Oz8qKUzJYmfYZC9gZ1BTXTW5y7QqODS82
 gajGmwqIqxsxstM0iqgolweoiRxb/ClCfsCENZe/IaLD+CLUnXc6NcmIZaYIXyn6NVp7mBgur2S
 efPir5ZnYi84J7c/uQfdDVYuMwG2V5fxToIKB0PqOgy9ochsQvsho6SBzsqK3zwMc0/uk5hQOt0
 NpUAb5V5Bowke4ScvAA==
X-Proofpoint-GUID: 2DQ4EsicYVho2gAHVNUd8_hVjkR6Y1xA
X-Authority-Analysis: v=2.4 cv=R9uWitRX c=1 sm=1 tr=0 ts=6afb911c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17/11/26 00:21, Pierrick Bouvier wrote:
> Detect and report an error if set exe_name/test_name matches the default one,
> thus explaining to developer it's not needed to set it.
> 
> Pierrick Bouvier (2):
>    tests/tcg/riscv64/system: remove exe_name as it's already the default
>      one
>    tests/tcg: detect redundant exe_name/test_name
> 
>   tests/tcg/meson.build                | 8 ++++++++
>   tests/tcg/riscv64/system/meson.build | 1 -
>   2 files changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

