Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6414606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=as0vE65k;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Dh8ff2VK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFBE-0001PX-BC; Tue, 20 Oct 2026 15:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFBB-0001LH-8C
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:07:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFB9-0006AR-Iu
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:07:21 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KJ5xMQ2511584
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kmGRg8YEV+KuHNVsmJvei7Pd9jtJTLCBHcAHsqQjr1o=; b=as0vE65kVsDGHNe1
 mSjGD4lxGIeV4AiE7Smc12NnWBw7IYX0cD5nnXmxyrUii5RJ3QRSg1OOTUvBrFb9
 t+fNDV/SuwxmhX45NBr6+uVjZMWWtfbrMEZczCAEBXYmrxtxcICQ+v2hANcFx4aw
 sOWeklbJBEU5kelMEC3j+/pPMI4C16lwwS61j177zB/F6kRrXyGd4JEDWS0UeGpR
 ECDBhJU+gbtbakWwdwlQZH8ZO0yZWvRuc5O6LfnM9mEYy0T9jLO5zx3Cs+oURad5
 YE1sCJ0jTSFG2Zj9LDQM960LosnaFH/fGOtAW/B1JSOIDmNKHUreAqHJ6QUtdXTa
 dcZVAg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n43x9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:07:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36637676140so1709580eec.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523236; x=1793128036; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kmGRg8YEV+KuHNVsmJvei7Pd9jtJTLCBHcAHsqQjr1o=;
 b=Dh8ff2VKoUDaWlP13fEvw6LySwmTvWZ1J1haaDwFDIDOuQauop5vnYArtSXgvuPw3B
 i82CBpHZllMnl+jLTnIoUqs1J3v9cgGbalTGnB5Nh4IxvvdV4alONPu7QoQRZTgcUiy+
 DlDmD/7Pz/9RaxgbeFOvhB+Erph75QEm9v0LMhkjVcb9X5RCaFVA8BZJohxYz6uXy2hT
 CtleIflDkOF/897xFgh58w/38QS8/9Rl5lKWzW6gEvB3hsozngMju3tUW1pa4kyTLupa
 QsbQnFDjs/S85h4pqNWl2Giinn87Eeb+0JDdTHx+sfdLJ4OPnQsLOmZjz8OeL0jJkPrA
 uV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523236; x=1793128036;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kmGRg8YEV+KuHNVsmJvei7Pd9jtJTLCBHcAHsqQjr1o=;
 b=KNaPX/5j4fdVq3hN2fG/LSElp3l7ZzPnoxzIF6iT7v8PknTr9+pcRCJaOQQpKCKyuX
 H4hq2drKFHXU1BWm03A1hpvh3RM0YRgWtBh9nuek1MJwaKLL8RTArcrwBmskjU1BAtcH
 45y4QcB8eufZN2wT0FzBE86HWgnQfefH/FoVEQhkmkzbAqzhFX8B5YIk8I5BaZ0t8xy0
 NSYdGNGarWmhWJE4TAN/hv+XCsGWUmp/hQl4161M/6D0kJ6iCl1bf5pmMBj8ImlgQy60
 GU21B+x6UMFG6CmJ8XqTbt1rCsfWWUQu5jtxpmsir0DMHCTJyYuZi8C5ZGDfVUxzr0aw
 wPYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfYFYNOfpY6oSk6y4K2OM6UQW8AXmFxrkK4JNKoHK5pxzHh8N32THN4Kd2RvxjgX1FEEw1EVwzbWJw@nongnu.org
X-Gm-Message-State: AFq9FYLMxtYSmLHmScPRaWOWkL0ImiWyN5jBAtS7D3O16dPNQEiWeAla
 QdIYDSvsa0CpXd2bKZvxZRCcqB9bSe1l696htovxE9Tz3lLTxbgcHOBUbvxFwq4+DhrUkmwyW/b
 3/4KtxCe/K81bCr1FzN3do0LvNo1t9baFFMuJJj1tRRdENAmbDQCYf6/Bqg==
X-Gm-Gg: AYBFou2mqIom6wCqytpYYJZHGwnIMDFwxTEzPgc1BX4qcmFsrwBwVj1vJXdBHelVEJp
 roPp+1tMwVoZ9faUYJRylvqi3cEhLlcBNNBm58UsHDkABqKZgVY1r2imxgyIOahuoAisEEfJx+T
 PD4X+DWY33nuPe11GSxIpuFCbugptCuzEltVkeqtJywgopQYN3kWo2EOkUGmZQZI5hG75TdGF+H
 cAY1I8YUx9c8QbLq+1nv+JnWNjIShK87bBHvtDUtpT/ATu354KFqg5PCwKftzZaNnynjeN0tE2j
 oq7tnlW2BybKy7MWva7fkiqIG+mN3uTiucnbypUF7u3HY73TrIM7FCWbJCb4Mc5zJqedI1+d4Mp
 6gbeGmDuMAjHih71LrnkOJbXIcXZrghZYD3gUV9b2cQE12D1T+qRB8Oe/E1CuLl3mnf9zxA==
X-Received: by 2002:a05:693c:638d:10b0:35f:2858:aa4b with SMTP id
 5a478bee46e88-3675201400emr139752eec.30.1792523236442; 
 Tue, 20 Oct 2026 12:07:16 -0700 (PDT)
X-Received: by 2002:a05:693c:638d:10b0:35f:2858:aa4b with SMTP id
 5a478bee46e88-3675201400emr139723eec.30.1792523235731; 
 Tue, 20 Oct 2026 12:07:15 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3673e24933csm594137eec.1.2026.10.20.12.07.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:07:15 -0700 (PDT)
Message-ID: <fc02b849-88f4-4a23-a762-7549e8b96e6d@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:07:14 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/27] target/hppa: Register CPUClass::exception_name()
 handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-8-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-8-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Wdk92RRpbXYDeEVPmIu-e25ixwXmj6rE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX9iQ/cF4TXi4A
 4KNccsuQ0FaOwo6ZXlHM90nir4zso7Fu1V9QCxczbxj/1CISo01Ls4ruj35j9dcYsp1qv80B6sd
 hCkRJbdQmqfufPCTC8ZgcrnLNJTtZ3o=
X-Proofpoint-ORIG-GUID: Wdk92RRpbXYDeEVPmIu-e25ixwXmj6rE
X-Authority-Analysis: v=2.4 cv=A5z5rKWG c=1 sm=1 tr=0 ts=6ad7bbe5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=a8Mp81SfjXcjMj-yskAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX2jk4924W/VZu
 Q6OXBfmZdJgIZA5yG0Ts0XT4CasE3llhCcWEVrpF788OHrKt3Zu/wc9JV4oCKWS+YJoJHtThiCV
 9qaXY3wmIHUT5Kafgm6gIpkS3cuc5xJT+QnSpzaTTyi3Qtnjz89zV2v+Xh5julbtWEWzNejPhUv
 aYLjZrKxMpEsR+1Hi1k/zpUhSWK1l2unuxSi7wnnK77J21C5WuQc5Mb+n8t7N6xT/V15Kd0LBJ+
 8+j/9vOhunT6rRP71YOL9KDukRtLwZNfSS0SsxHrJHRyAghOfMP7JmA5fs67IMIugvKEe+bSrk6
 jBZ+/Dp51hLmVnc0ykR+Hg+Cl9uPq7Gjy/Eo/urwt9gwFGjLkAmu1zVox4CeDAuJW9jbZlyPDbQ
 bMjqnYEIqfoontHdtJy8gzbHq6o7+m5u8g1R99sQMS8huJX/KpOyfuDnNHoH4OZJz3o400g14B/
 AAXm3oWQD37DnrbgICQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200076
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

On 10/7/2026 2:44 AM, Philippe Mathieu-Daudé wrote:
> Factor hppa_exception_name() out of hppa_cpu_do_interrupt()
> and register it as the CPUClass::exception_name() handler,
> so the common exception logging can resolve HPPA exception
> codes to names.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/hppa/cpu.h        |  2 +
>  target/hppa/int_helper.c | 91 ++++++++++++++++++++--------------------
>  2 files changed, 48 insertions(+), 45 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

