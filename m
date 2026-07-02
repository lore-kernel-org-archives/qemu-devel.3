Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB172C43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHJ7-0003VI-FC; Thu, 02 Jul 2026 09:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHJ5-0003UL-DG
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:18:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHJ3-0000N3-LW
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:18:19 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0bmM522233
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ekeibePJA1tuIciWK1vOIq4cWRpgpMpGAg0INCGviIk=; b=H7/7FFwnsrwCgkO5
 ZgdidvGork6AOt9XWKFPP+TCbRWqR45Cs7OgdW++0s2pFxKoDvG6mJ9eJ59C8wyH
 Suv5kQJCUv5Q1NmXsYqHObbuMKm9Gap/SA0xmBS2f5GoCxpMhkiNoSBOt6xAbSms
 YIlxUUwyhYJBQgEYVHVR9oAGsD9H5ptCjCXwuBl07uaIInebkKnMsGR9guvBuvFY
 msgbGyYH1hOrAcVEeR/n3zBlXEn8vKhAJai/l+eIApPIvoeex95++lBWbZkKpsC3
 4toQYXu1fRBHDgvE9vjDR2wpNx5VSxry5UGjO+d+IwXL7SQymxaOFjl73N3WNgf3
 yY3f3w==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5knc1c05-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:18:16 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5ab02fb3054so624933e0c.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782998296; x=1783603096; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ekeibePJA1tuIciWK1vOIq4cWRpgpMpGAg0INCGviIk=;
 b=aNmtVhtnMxOj2yN3Aeev7r3OACac3gsWjdlPLpUXD43A+24yX18P/J1bY7koyKv9r0
 BFtwjPh9hEjxTgCXwBsDiipEp/3csrahc3OmYYprQATMlKW11iKpsJO4qao9UEX/9ryJ
 2DsGdfOrbyOYxvLsB+kiwOkzhIn2+w5N6Jwsqx1Bp1Q0sjlKysqUww4Md0ypICrw7uto
 KzieYTghscPljlf6JB5dswtABb0StgobX34zVj1M5SGwuyBPMafqrWDah5ZS7rFRxoBa
 fD6oec1eqhe1kHTKrZbLRJDK8OAM3Cl815za8XdAtwqT6ICVITUKqxGYcK9s+A2KLXfz
 G+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782998296; x=1783603096;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ekeibePJA1tuIciWK1vOIq4cWRpgpMpGAg0INCGviIk=;
 b=a/M/IkDGIQ2oA3WSoXa0Z/IO793ZSzmWzt63wg0oFBNZtwkth5eCenJ+T3oXqUulGa
 xalKMgnEvWz/nhiCpRQDuo5TsGX1in60jpFCa9hclc0jrIlHacIYMM2Zs0ktW9vKhQ54
 0vFQOh0u7g73YZYbfRoWXbf9IGdbu/jTD4+ZW5+7edAnmGmcI/4RX9baC08ZjA44+WU/
 wELbNIS1JzO2nFvBjf3kk9m53VUXjlfd8dep6XyGozpRhP7+DKrzUbKBmpcZUeYB+Ir8
 wFTO1UFqMmote1QuMXAB9+pjNb84s3E2hchLQbmcFrNcWEYRscWhSpPLvjWxfHpqISSn
 izug==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGz8zx+wTdU3WcqlcyxuZcjHlhm0+Xbgn9pLtqDXCr0PcZSMUpiTFXLYuU2aB5KDMnW3yRr1yVDd5P@nongnu.org
X-Gm-Message-State: AOJu0YzUMDIPPJYfAOA13y/WLzPq1OQa6rY/3TCgjEhoIOctkACSYLKG
 8Zy2SvA+EAkCBxaGQKT6L2fTcf6ru5++g3yQT3OBT5hvHR70r04DF4+khTL8f7X6ern3iCW6KhD
 3x5acQIBO+c+BUoswC1+niC2EjJfXEb0do4w2H4pk3C2XDpnBIRoKMW8mKw==
X-Gm-Gg: AfdE7cm081KvsbRxrwflsWeUdroWv29dDj3ssa5HSrNCRRdh6R94AR4ggEpA0yC1i1p
 2CRGDrqjEQewnOSnAgF5WCfBf0tnekk3jD/D4U3g3xPCp6hWlbyuuy5Bf5R9VVX4BkH5jUtMrYu
 t0ngV2nyIoxAGnDJRr0mmdkuGGmtKQvDPnqNtDj5hQyBNGdKg+MwkWpOvXY2QkYXhq8/THl5Hmh
 I6bHqz/nze2RHAelALjtHdshHkQyPjd/EtiAYALl1dyHujD1nyc0X6S2IBLOwLyWQxn8ms2/2++
 h+aa8MJmeG+njn8LEeTHq2BYQkK++8sGLkI6avIN+I17roGEwOiZwRXfPofsv0EoZ1OC7oCKiB/
 mWjcs/xnieBS7I474MI1HryFFUaJZ0LBUUsIU8+Vj4Ujb
X-Received: by 2002:a05:6122:17a4:b0:56d:b639:5c0d with SMTP id
 71dfb90a1353d-5bde3b710bemr2041744e0c.13.1782998296136; 
 Thu, 02 Jul 2026 06:18:16 -0700 (PDT)
X-Received: by 2002:a05:6122:17a4:b0:56d:b639:5c0d with SMTP id
 71dfb90a1353d-5bde3b710bemr2041736e0c.13.1782998295499; 
 Thu, 02 Jul 2026 06:18:15 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bdec83faaesm866394e0c.18.2026.07.02.06.18.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:18:15 -0700 (PDT)
Message-ID: <adb0da96-9eb6-428b-a7e8-b4824cbe9a91@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:18:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/33] gdbstub: Add trace event for STEP packet handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-7-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-7-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KbwGNO-4qZCuBYvn4OizCaT50gEZxCNL
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a466518 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=aj28dWTF0POQwHUj68UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzOSBTYWx0ZWRfX3nv9jzcuiAuv
 Mst3dU4KWnqkF6eJsbH+mksHzp5dbjwgxepv1E093OgkhRgAKvphb0NHAzKyM+125JiqCDHt+EX
 8d247jg44NsUGrpWtSeENza4tLPrmXfs4E+wle/i70EILzxElQaRlsv+6Pzz44eQzSyRYMfcqRR
 Lff7aKnqFpbgNVjCv5qkLSOKSjFkMGOKUgdSz/snp3Cl9Jr6jtUdwbCVcvMM4eLufvAscV9eDrs
 4aRxtuvM6e5OpDGC3C914N+/tpQ37A0ZZk7FJ4CrtPjVpOwOZu9lACEEABVU/4znCOI0yhN5ksI
 cc/WJiLBrvZiAKh4+v1rUI02Z/fADvz+5SZ4T1Csq2oUBTf84S7rrUJDc4Bsr9sHKHRf1h7iR4/
 uFAqPKzFMJ5SrOPiUDMpCQ2H5Im/QRLeTjuCN2M9W/+xrQZLjPGzb974uHGYJmpCBKa8N+zRiCQ
 hsSDduX8vfqHNgjIy8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzOSBTYWx0ZWRfX3f1Qcso2AtmN
 xS4btPWc0wj5TIbRdw8iv024mj5SDuymeJk3anQJKZ7dgRvPrADfsOnt9vwKCdTUXre9t3hqh16
 BYcChpAkSF/0DHoFIGaM9pgaWhezWEs=
X-Proofpoint-GUID: KbwGNO-4qZCuBYvn4OizCaT50gEZxCNL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020139
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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



On 6/30/2026 7:00 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   gdbstub/gdbstub.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 26366acb674..246e7746300 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1369,6 +1369,7 @@ static void handle_step(GArray *params, void *user_ctx)
>           gdb_set_cpu_pc(gdb_get_cmd_param(params, 0)->val_ull);
>       }
>   
> +    trace_gdbstub_op_stepping(gdbserver_state.c_cpu->cpu_index);
>       cpu_single_step(gdbserver_state.c_cpu, gdbserver_state.sstep_flags);
>       gdb_continue();
>   }


