Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35090C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjJPA-0006AI-SK; Mon, 13 Jul 2026 12:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjJP9-0006A1-M0
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:21:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjJP7-0000bS-P4
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:21:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DF8Kks1803547
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 16:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Krn3tzVrZJ4N/DCZB1Q68dPT9Olm1TwknBosVKTxMO0=; b=mtk935J8IcWKhOS5
 xPVztX3U+PwcrCn5d8OORte7TTUkTnokq7mSt6hzHUoGWlD4TichwtDmFFgLdLAG
 iFo+cLGSZfPyClZtII3NyyDkJA3rABGqEiYbDO/PowBq5TpUsMWgMK1gh9YnktMo
 E7oK3jqI2md2aJQafNeZbn3WjK4YU1FGHs+XJ/yUI1XdKi0RZXCTkCexzwwoXIEu
 w8Jdk5sv8mSkCyyk9zhOD1KgDKH4PCGjPK9Vfw2uhKXSA2jGF3CCzFAZIi/JO2Le
 PxEvQpsCTanQgXKdI4ltK1/MxOy56RN7+nHEBakrppkSpTlyZmxpHduNuPkzlRSC
 SGB9fw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwu4shcx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 16:21:12 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so127860a91.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 09:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783959671; x=1784564471; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Krn3tzVrZJ4N/DCZB1Q68dPT9Olm1TwknBosVKTxMO0=;
 b=DIpKCvnehhFydwpT16v1V9hCASD3+AB0nOfTwCdFjgBLjEuI03JE960EQxb7yB9wyX
 jgskXvOe4+XwkghTXtAkmnEcVLuuC4kFwJSciXrskdSCwMm1+eofAciqTBnGl4ETHqU8
 gkkvQFd202+W7xGMr0d3dl7+wmN6214c4HGnIe46VJmn0l7IercaOvXZCBNpoRGyd27f
 jdNgw35cFykNF/6peW25bPBGc5Tl6HAQ8cUJdZacP2cjfspDf1k9b/8N4FL/3FCKo5uU
 mXy4/WdIsU1P9Y3DpJ1xo2wkAveufDPeQ/LPdz2Kk7ojJYWKJZcvDzYbyKkz12ipGFSC
 N43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783959671; x=1784564471;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Krn3tzVrZJ4N/DCZB1Q68dPT9Olm1TwknBosVKTxMO0=;
 b=KzLA6lOM3HDfRttBqKytVlVq9P/FcW1xFWflrYGB/p/SQISh7qvMchbJ9dU5YloFby
 pbi3TQg/LZVpKbyjkWkNW+SH7VuFMqSJdnetsUzOMpy2swi1G4IsYJtVXFGmaxTEy9Qf
 eD803UrwFQppg82S+nfvDyIIbJp6w1TApoQtiwvXpbveos4Wkh4nSJyvSUaxxlACJv66
 Jx1X3LGylfbexeRlv0SLt5wszx9Dtzd6aFRvGBuNPw+3tFDPQhBpDeWtpCuEQb0bnRiB
 em83zu5aX2nZq8iiMB76vNo4MwONpdJbZ/agSGt7OhmWrsYbqHoon91JkiA+IWBCF/R4
 dslQ==
X-Gm-Message-State: AOJu0Yw14m0jSGXdtolAg6S7szlH3tQDuLdl52+lM8ThlPWXa+1Otp7C
 +MnHoh3lvhDy/P8uRLOXsHjXvvE3Mrj0Lk6oVZCsws0ycNZccTdR7ET2D3H4NLNp2+GkWjrPJ3H
 WEGOfvo9CgawTtQpwAHCNAll7jxH1UNgqclviSVDzZjm5fQVPeLeUaUAV8A==
X-Gm-Gg: AfdE7cnkRcW8X0+lcCKLzfH+YEllQ1yVZpNDRmgB2tnWZ+5vWoVmDIzDsbeHViWi9Ip
 4Z37J1sgUENQYqcsEiUxavam+wNwxrl821yRB2Ygy9pSwauc7RjZBWijjmqfn0RxxGi3dgjmlQQ
 NTRWCExbXmSaH22ccBDlOaUyYixc2frbUoZfXcKNzQzjIEuV2ME/fUlkti1GHVdq1NSMm1uZ4qf
 vyth5F+0vBAOQGzOBqhA8Z4SsSMXqro2dBJ1DP3TM+XKm+pnG2OSl9U0beaO2SwgvF68y05YI04
 i2sO0GVL1O0TWxOLtotN52Z5WUKDXw1WTD9lW2kIUbwuEMS3N3sFSUKSrrSIYKEQnDuCKvsomze
 +J4P6cIOii1BaeIxd7FA7ZHXTtQBfKvB6yBEmMklsMs9eLyEUJk4DLulo/SeIabeZSFle8soNP7
 ORzq8=
X-Received: by 2002:a17:90b:3b89:b0:387:e0db:3fad with SMTP id
 98e67ed59e1d1-38dc7778aedmr9114810a91.38.1783959671440; 
 Mon, 13 Jul 2026 09:21:11 -0700 (PDT)
X-Received: by 2002:a17:90b:3b89:b0:387:e0db:3fad with SMTP id
 98e67ed59e1d1-38dc7778aedmr9114784a91.38.1783959671001; 
 Mon, 13 Jul 2026 09:21:11 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313b4b97661sm39477855eec.7.2026.07.13.09.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 09:21:10 -0700 (PDT)
Message-ID: <3b076336-95e0-47bf-8eb0-37a54e594ee0@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 09:21:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] uftrace: riscv privilege level
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Yanfeng Liu <yfliu2008@qq.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, erdnaxe@crans.org
References: <tencent_E17E8F6494EE130F71527C6BCE481AF33E08@qq.com>
 <ae18fa27-a1c7-42d1-864e-5a9a30c1215f@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ae18fa27-a1c7-42d1-864e-5a9a30c1215f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FMErAeos c=1 sm=1 tr=0 ts=6a551078 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=dZbOZ2KzAAAA:8 a=EUspDBNiAAAA:8 a=qEAdaA6whk2plPOlQVsA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE2OSBTYWx0ZWRfX923hOaAP2gQd
 a4X8lzDCYoWVN8O//mvodDh85qHtTvgHaVuKpijAHTEfqpcQea6Hmz3X3gTt/g3oIGG6YN3XCJZ
 gQhrpG7Pvd7l/VxNehSqGH0fclNc2wQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE2OSBTYWx0ZWRfX3bqSAxZg2rQb
 dQW7PHGjNe7/V08i43LbtLxxI7Kny7vIGW2SUofQSg9imKB55pl9p9JON6Jj/9oHkbPdVGVvZNp
 up1inRXd348WpFW36ndpF8LJxNeSVqcJ8ps2ngSZ45k78QAQREYw0QwKq7qSwV/FagNETL8RvX4
 /VnscWPOar4Iz3lcBLi1cEcOm5Ho8qD32CpivJp0L6qZtxvYSnIwgIld5nEVBt8P7XBZkQ36Qhu
 AoFk+IJDt34wiUFU666JESa4UnKcaf9K8JF7K6owam3SFX8zWMLsR0zHmql05qLl/+Ax3wU4sQc
 AxdPswBfkQEPvxGAtjZzlaVYf4gKiMwj/x/P7gycfp+AYwjpIdIaxAHpLuOAx5Iyj+DdfXdoB+Y
 MhUL2RGql0aoXyAxnrxoTuCh1h58g4Kv97gB/okfLxDYKVYV4HwTf4BYr+YWxHhBSX9YqbWWcOp
 lRmDx/oyj5KzORVBvZg==
X-Proofpoint-ORIG-GUID: Ht8YOrqCb5ssUSduUFzhTfdTcdN9nxkd
X-Proofpoint-GUID: Ht8YOrqCb5ssUSduUFzhTfdTcdN9nxkd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130169
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

On 7/13/2026 8:59 AM, Pierrick Bouvier wrote:
> Hi,
> 
> On 7/12/2026 1:45 AM, Yanfeng Liu wrote:
>> This adds RiscV virtual user and supervisor privilege levels to
>> uftrace plugin to avoid crashing with H extension guests.
>>
>> Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
>> ---
>>  contrib/plugins/uftrace.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>> index 9b0a4963ae..063e32220b 100644
>> --- a/contrib/plugins/uftrace.c
>> +++ b/contrib/plugins/uftrace.c
>> @@ -109,6 +109,8 @@ typedef enum {
>>      RISCV64_SUPERVISOR,
>>      RISCV64_RESERVED,
>>      RISCV64_MACHINE,
>> +    RISCV64_VUSER,
>> +    RISCV64_VSUPERVISOR,
>>      RISCV64_PRIVILEGE_LEVEL_MAX,
>>  } Riscv64PrivilegeLevel;
>>  
>> @@ -153,8 +155,10 @@ static void uftrace_write_map(bool system_emulation)
>>      const char *path = "./uftrace.data/sid-0.map";
>>  
>>      if (system_emulation && access(path, F_OK) == 0) {
>> -        /* do not erase existing map in system emulation, as a custom one might
>> -         * already have been generated by uftrace_symbols.py */
>> +        /*
>> +         * do not erase existing map in system emulation, as a custom one might
>> +         * already have been generated by uftrace_symbols.py
>> +         */
>>          return;
>>      }
>>  
>> @@ -706,6 +710,8 @@ static const char *riscv64_get_privilege_level_name(uint8_t pl)
>>      case RISCV64_SUPERVISOR: return "Supervisor";
>>      case RISCV64_RESERVED: return "Unknown";
>>      case RISCV64_MACHINE: return "Machine";
>> +    case RISCV64_VUSER: return "VUser";
>> +    case RISCV64_VSUPERVISOR: return "VSupervisor";
>>      default:
>>          g_assert_not_reached();
>>      }
>> @@ -986,7 +992,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>  
>>      score = qemu_plugin_scoreboard_new(sizeof(Cpu));
>>      qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
>> -    qemu_plugin_register_atexit_cb(id, at_exit, (void *) info->system_emulation);
>> +    qemu_plugin_register_atexit_cb(id, at_exit,
>> +                                   (void *) info->system_emulation);
>>      qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>>  
>>      return 0;
> 
> 
> Is that something we have implemented in upstream QEMU for riscv64
> target? From what I can see, priv register only can have M,S,U values.
>

Found the answer here:
https://gitlab.com/qemu-project/qemu/-/blob/master/target/riscv/gdbstub.c?ref_type=heads#L213

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

I'll pull this, thanks.
Pierrick

