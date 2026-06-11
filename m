Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B82CD8CB9
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXZa4-0005sH-8D; Thu, 11 Jun 2026 03:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXZa1-0005ru-CS
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 03:11:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXZZz-00047c-PJ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 03:11:57 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GPNI3712057
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 07:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kPDQTWPZXD9meNkKHM237Ej4RJDreylbxJrul+rDyTw=; b=Igxs9ih4632u6NPP
 Rf2B4xUNpQHknrWPi8U7grfOw4l+jm75HMEEM7E/qkA6QW/MoC5F168ZT37VKoAg
 TPROqreqAD7NTM8a7JM8FbG4ME8Xqv0VbqC16kQrC4x7hpRrAZ+hGqtDNsnzeRmm
 2lP/zCtFGCkHf5OBKIACw4zYfY/rZMfnOZJ01fnN9RjdwZVKdrixk+uxJWG+dTwI
 GbyNnsuBwDnR2YhyfTyeQO5t/Fsu4UvTUS/6bzPxE5dZSObdL5qkETHYsiKaPchF
 mwFhM6l/F3kMrBpww6FZSZfKVcfS20RX4BOxwNNcp9zSwsshA3Ls8sCy+m23ZCdg
 ny4sIw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6ua4qj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 07:11:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-517b75c1ee3so76877911cf.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 00:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781161914; x=1781766714; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kPDQTWPZXD9meNkKHM237Ej4RJDreylbxJrul+rDyTw=;
 b=MWydQqdw3O3ZL6VXth2aeWIrWbWNEou3lw0efxIcSXHh5/u15U9mIjME6x8fwy8hgQ
 97tM0wvFH4Hq/CQtQbXPrsRCcgiR23d4MuxkWzk+6ouiJya8iH95XxP170s9t3QVLmLC
 A3Gig5lgtpy3LXODoY5iZNXKBs3QTWf9KMRHztfV/BjMLKkZGOYBtzMxfa/53GXBD72x
 RzhzrLnO7/fJ3SpGijVvP8D13e8hHqU2Sytj9HfXtAObGuNxcN+0o1I9IXuKmj5DfbNu
 Jkcj1kiiJU9xmxujGnV97bAJtjegiz+wTdVKLhSFech3FUkLPHI33Qi/SHQ4dmPTymSI
 jGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781161914; x=1781766714;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kPDQTWPZXD9meNkKHM237Ej4RJDreylbxJrul+rDyTw=;
 b=cvRO3CU4RMuD6t7W7nWx1QW0f38gyOsaDTzWjNLUQXWh5Dgx1KWs6SExYmrGuZdfGg
 5EnsbfgI/YgUVcJMYvcW3BtxSRNViR+amv+km6YGkusQJ7Tkx1nkO6FcJucTfmGkrz/4
 MNj0oB/KmUAkAGPWlJSYAbesFt8GCp9+98SGNapNWWhmWsQNQ0SlfsxYI16atP7ZJ+AI
 S09v5cyDINATrCgSQ8dGAZSh3DyYN/DCYY49nCIqr7jHdqttOEqDSGzkjrgLxPTf8v5V
 iA+o3ia+qe8lyf+PK8TkzlYrev1em+iy1ddEBOQa17SpjB7NIX08rKCv3wnm2Ps/zamE
 5cPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+Xp8reAMYyGpyarIRszFg6Qh64Rk1C2AdQqD6R/texADBMcZ+8ntAsHKR0HO02yexyDzFXuhl7rsv@nongnu.org
X-Gm-Message-State: AOJu0YzSYbF7vcmxSN7YK5OM3AEIZakGmAXu7diQ2Wj1U1VeAxEsmLSi
 BYE+GV1pM/At7hwCJ5wBE7hkdIL1jb3+Uo8Rd9k4Qrjt/10loOxPmiKZpzOEi50djq55GN7BNpJ
 t1ZRA8bOTqkARgeygLQWSZByrKc+PxVxBTCpnH3E2NB5cfJP9xbfyicAC7w==
X-Gm-Gg: Acq92OGfHeGln3tmk3r0zCiiHH8Z4VU1kD1Cksdnb1tGxhNKCxN1liBh5WLvA/FYXv9
 jxOKe24lPgzNLXoY8gwrqyr7UdNWSBfKDeGhnO7LB0w8qoYFEW9QWmw0lYBIOASnWTvARU7MX3V
 Km3FFhzhOJBwpw9rmh6Cl4L+17zt60Y0O1JdVX384KNY7r+FtX1YexJQ0CZWZc3kpjVcm12qhSJ
 Oxa2Hl73RuWwbx6dBYnP6Ithb7ykSTPEZ6VHPoGBBF3HRFpLSFCpakgXoSOWCD0C+SAClpnfUiT
 e6+dK3tGvMHiEkzY2fIzz2AspheQ9iAqMqC1KvkuHfQwIlRVKJ70vze6ueox1irATkr34j4/IdD
 dcF276cmThNuhbRD6/XYGcXDC8TfkJtwwXIGbFWOHfPZMetv0vU1Euak3x3GC8P3w8sU2Ej5rVA
 E6
X-Received: by 2002:a05:622a:2c4:b0:517:b58e:a1e3 with SMTP id
 d75a77b69052e-517ee26715amr25442791cf.50.1781161914010; 
 Thu, 11 Jun 2026 00:11:54 -0700 (PDT)
X-Received: by 2002:a05:622a:2c4:b0:517:b58e:a1e3 with SMTP id
 d75a77b69052e-517ee26715amr25442471cf.50.1781161913474; 
 Thu, 11 Jun 2026 00:11:53 -0700 (PDT)
Received: from [10.156.84.244] (218.170.88.92.rev.sfr.net. [92.88.170.218])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfcb53c3435sm20061566b.39.2026.06.11.00.11.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 00:11:52 -0700 (PDT)
Message-ID: <0d879628-5250-460d-aa22-021085ebff7b@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 09:11:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/riscv: add 'num-triggers' debug property
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260610205457.1868701-1-daniel.barboza@oss.qualcomm.com>
 <20260610205457.1868701-3-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610205457.1868701-3-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA2OSBTYWx0ZWRfX91XGEEp48ORY
 X8WbWxpeo2v+x8v4LT6ft7Z06EStfsIMhjHkbt5/6H6FZd2JWg30IjlBPl6SVIUKXIdCwlRfi3k
 Wdu+8w2YbA9QusJQVvklbh0p/GYGZ8A=
X-Authority-Analysis: v=2.4 cv=atOCzyZV c=1 sm=1 tr=0 ts=6a2a5fba cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=/nYmEve+L4YsDi96RCWAbw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=kD1aHXNoiUmW-fgF_RsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA2OSBTYWx0ZWRfX7CJEMGxWxWh9
 aY6qCZqvk/IvD0LnwWJ1HbtGpArVZnx6GVxFnHJ0rulPnlMCvh5mV/JBKrjjZa2nvYbWFAO2U9T
 kHal9U8/oC1nIAGnnUvG4JQzHu26jfHvUGQMKq/+lEpBwQc59VomlPhGRSDCz+yJZEJ54E90qqK
 BCLupJNgrFaaCyFCXxcR56Uihb6mDM2gGASy/vW5RsAZwSWDKL0eHzsfkcIqGv9t35mGkREA40Q
 kXDCO7BEhj9iTJYLTDmhy6qCW+Z9oUdq9O6oY9CGR1zUNlPeT81EJX67RHSuqTVtRazvswcyHdG
 KlS8y18WhclLbpAv5joonVeDVS8dUYbPa4GllTvBfg45cKxBicmJcCzkCMrBd/nWn6YUY/ZBN80
 iAjAj5xFw8nq5r58Ox47MbqiYjf6v6OLENdqUphlttO7n9G7jTuLDvQXumTDDgcnP14u44N+mX2
 ClGxqaVYwiBrZE772Jg==
X-Proofpoint-GUID: 1qvJgcOB-mxGC5q4QbdjXldep8kgOkNW
X-Proofpoint-ORIG-GUID: 1qvJgcOB-mxGC5q4QbdjXldep8kgOkNW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110069
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 10/6/26 22:54, Daniel Henrique Barboza wrote:
> All CPUs have the same amount of triggers: 2 triggers per hart, set via
> RV_MAX_TRIGGERS.  This is not enough anymore: we'll have at least one
> future CPU that will demand more triggers per hart when implementing the
> RISC-V Server Ref Platform, requiring at least 11 triggers per hart.
> 
> Parametrize the trigger amount using a new 'num_triggers' property.  The
> default amount is kept at 2 for backwards compatibility.  The new
> maximum is bumped to a generous 1024 triggers per hart, which hopefully
> will be enough for the foreseeable future.
> 
> The property can be set in two ways:
> 
> - a '.num_triggers' CPU definition flag, allowing CPUs to set a custom
>    amount inside the CPU def in DEFINE_RISCV_CPU();
> - a new 'num-triggers' user property.  The user property has a higher
>    priority than an existing '.num_triggers' CPU def setting.
> 
> Assuming a hypothetical case where a CPU 'X' is defined with
> '.num_triggers = 8':
> 
> - -cpu X,num-triggers=30 => num_triggers set to 30
> - -cpu X (...)           => num_triggers set to 8
> 
> For a CPU that doesn't set '.num_triggers':
> 
> - -cpu rv64,num-triggers=30 => num_triggers set to 30
> - -cpu rv64 (...)           => num_triggers set to 2
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/cpu.c     | 11 +++++++++++
>   target/riscv/cpu.h     | 19 ++++++++++++++++++-
>   target/riscv/debug.c   | 16 ++++++++--------
>   target/riscv/machine.c |  4 ++--
>   4 files changed, 39 insertions(+), 11 deletions(-)


> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index b6b53a4840..ba96ceceef 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -240,8 +240,8 @@ static int debug_post_load(void *opaque, int version_id)
>   
>   static const VMStateDescription vmstate_debug = {
>       .name = "cpu/debug",
> -    .version_id = 3,
> -    .minimum_version_id = 3,
> +    .version_id = 4,
> +    .minimum_version_id = 4,

This change belong to the previous patch, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


