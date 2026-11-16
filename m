Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15A2606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eMdLA73A;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b2rnyh2s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSsnq-000071-Av; Mon, 16 Nov 2026 04:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xSsnk-00006G-1v
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 04:15:01 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xSsng-00069E-PV
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 04:14:58 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AG97OTk1160926
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 09:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 htq+umdwZBhcIeClQiyw8v+1LA9ih+6x8KWVsZfhwqI=; b=eMdLA73Arcw9LnNH
 Bl0iHK9c2WcgfGHcIf643/5JxC2RxcSYvoS+XpWkzbfpEH82U6l4mjIkEaAgcNZS
 6etnDamSGXhCGJ5ZECkKgQZsj2Wvh2cvsdLDmo4OIhCKlNzio3xMFtFQKVG28oDQ
 kb0Vh3tblXQ2aTGIzE4zlkJLtAnxTfk4Eac2/4R7zm5WXOHZJ3chNsv0XObwpMG1
 74gt/U4d3SFPs+inRDYGOa+E4JyGdBmLpEgcHWcNUB9kpi/bKAS+Fu9m3RrPNNfM
 PgGYbA2tk5tUBukRnwY5bBVwtQR7cQinaG3JCVEWTGI4TgRQfwXu+eL4QIPJD+y3
 +ltFTw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyxx2g106-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 09:14:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f33438950so191282585a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 01:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794820493; x=1795425293; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=htq+umdwZBhcIeClQiyw8v+1LA9ih+6x8KWVsZfhwqI=;
 b=b2rnyh2sVWb8CQXDUWymi3SCFWV78VLNTFrYExzq4J48JfavSG/2A21lpp0yqjCZDj
 cIZVbSW4a0Ae1BoV5SgvQoamt4Nvr8O9aCO1DlD7wONXE9ZGz5l2aDHqDDTRxXDHM2Sc
 XgIhP9xCDwAwhLk6MtNa+nA6yquzvjWy7z52/d0L1PaIVXHfcjv4XJ+LrrqtX486YWd8
 07J+/snTgbw+RlmqzT0A3FpBojoPN2aNA+yTj7Nz3/lGliE0//6Pp1MiJJz0Ka3xj2UV
 MvHIhedPFufnBat5zgddzHu3IqgEikI/3u0K0bOQe3BOEKYB5SloB6+oFiLUi1JqtoI2
 bKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794820493; x=1795425293;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=htq+umdwZBhcIeClQiyw8v+1LA9ih+6x8KWVsZfhwqI=;
 b=gMV64owB331UR4HCMsMIHyQHXzzlBfCzVpzvDN0++qKzZxPAjRIycZoeiTNgm1mifV
 cWdKrYr8L3Su28FJywVqQyJ7Q5Ci7bjxQUGrTSrONhfCxVibwIWPtIBYJAL2SlGjFkqj
 /cIK1zKX3nOoXD1xyBADUQAzEZqDZmeFdDwzhD0/tz0OmMVfqcx0VfmnLeT+JmVjixf6
 wQ/qKtWWDVCiNcHMKqX6N13XWy/JnFFCaE/lCq7iA+gvmxJvcKCRvAmiel8sEt8PWfjw
 sZ6Xmk7OaqUo6sIdPyjuXavHrmBiopUlkDPFkVectKhUsXkwiPsZtlkIq05QcmBTNbLS
 AQow==
X-Forwarded-Encrypted: i=1;
 AL+hErHkktTg/u3lUTOfcn9jEp9c9T+R2Hdb2pOxL96GXv7r/IrPAAnxr/34pQ3OshEZhNEkzkCmnK/uhG9D@nongnu.org
X-Gm-Message-State: APuU4Z9eAqGjn6cLmQq0jYfLpuiebDLDL0frTMJMJDh9NtxIPCHdIR9o
 MtwqcEHJJ0MYG8xTCY4IaqBqgaYb/MuNxuYJQgL+C4+0XDT4/gmzjE78VghVxVpo6+rbJ237B+E
 wjRYGlYm6lPx1RNbFVmGbYqP8b0CFJr6Uz5EmOAXjtXP8d0aJorhIXBo29Q==
X-Gm-Gg: AYBFou3cc4qFHNuYQmVHQzRvcRaUbwuoW6rq6I6ZixM9Q9ETS4Cy3VH1IbPX9G9B4V0
 Ns4qkowHjrO6GrdC+PilRwoJr9WFnfnisSlQKoCgAECLfC+YdNSKVcfw4uj/0pS5rgUU6p2+Km9
 UbyxYUOMxkHHCen5ZAfdtP8JYpHMoEGgktPopk/aXqrev1mnPSDUFxHUT8Ue/ZuBQvEmJHPrU4g
 qUzK8jyDlV8YtXj3IEjwgL116InGuMcwo5pD+VRkIE02UFaGu5CcOxj8JXo6gnJcWu/gpoXHfCL
 7Ao/d3uutmEYUan+ypkIRY0fBLvLHIDk0YkgN0jeQVhDPj7s9niBWA1Sw+1M3qs1ASU1/BvnqQT
 ZUI01BS9hSXzoZHXxzJqX/emhAXrhdfi5r11azDUaHSQclxq35OYVLgWyZiwyDhNvgr8O9QPhdL
 qS7E3WdTc=
X-Received: by 2002:a05:620a:17a3:b0:93e:e425:229f with SMTP id
 af79cd13be357-9494bb957d2mr1730446085a.77.1794820493361; 
 Mon, 16 Nov 2026 01:14:53 -0800 (PST)
X-Received: by 2002:a05:620a:17a3:b0:93e:e425:229f with SMTP id
 af79cd13be357-9494bb957d2mr1730443485a.77.1794820492778; 
 Mon, 16 Nov 2026 01:14:52 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49d673ce75fsm14871072f8f.55.2026.11.16.01.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 01:14:52 -0800 (PST)
Message-ID: <795f7e08-67d0-4544-ba89-f283a0e52339@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 10:14:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/26] target/mips: fix MIPS64 segment access checks
Content-Language: en-US
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261113214926.98536-1-kirill@korins.ky>
 <20261113214926.98536-3-kirill@korins.ky>
 <c0c6e448-bddd-4593-a041-4ba8ad41981d@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <c0c6e448-bddd-4593-a041-4ba8ad41981d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7WWitRX c=1 sm=1 tr=0 ts=6afac98e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=y08-6QJyQ3hCIyo6UTsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX/cCvI4wZMEcH
 qhr41B850ZLgndoIrXZ+CWAmbxhZ4o5Mkr5lN0Hvuh7wpAltJBo1sfRTS0dJ3V93cGVACAeW55d
 SVybThX/jQCB4f3PVkp3e8IR9H3iR6s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX+JcgstViS3ZD
 hsNVc7Uk5DQ9gJhus/PaRRdbRUlLgxpGcTL614gKz5ZEq/FReWb9W9UtjSkG/lXXPlPUVCB8Er5
 ahLx08t61/H5rz5zcm6cMyMLCIegjoFBKSBgzlcSM5MjBygyC59cKGnQ+hhNUJSsS0I/CvYkDMa
 JDPgwbKRn/JMWu0JocsTeys7FixC3qURby1f5VlZQuHxjWoxAgtTa0CY1y0x1++190HxOtJKxZ/
 GUWQKxei5IUQtTKvhKUTtmy2jrHpEgfXq32T/fCaJ3ESa18Vse4MOahZvRUMyTOU+WStyMD/6wY
 I0eHMfKxHBBoN6EyktBHwMm1icPeLlqrRQS8ThVvgIZEiS6V0bgo9Yb502QquBY5RVzdO4jcPrh
 LC160Vu2LWijJus8qysJFFjvIvR7GTOyOnprfs7eGaP68AmuwThlKZ9HfxQqpWqKGE1Lel5U+qu
 h9o+wPPROY3QwVdV5ow==
X-Proofpoint-GUID: ggLhe_VgLqV5BJB9UIiqjtYu3n1-KoJY
X-Proofpoint-ORIG-GUID: ggLhe_VgLqV5BJB9UIiqjtYu3n1-KoJY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160036
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

On 16/11/26 10:13, Philippe Mathieu-DaudÃ© wrote:
> On 13/11/26 22:45, Kirill A. Korinsky wrote:
>> From: "Kirill A. Korinsky" <kirill@korins.ky>
>>
>> The xuseg and xsseg checks only tested UX and SX respectively; kernel
>> and supervisor accesses must instead use the mode bit that applies to
>> the current execution mode.
>>
>> Allow supervisor and kernel mode to use xuseg when SX or KX is set, and
>> allow kernel mode to use xsseg when KX is set.
>>
>> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> Now that I found the Octeon CN71XX manual I couldn't verify this claim
> so I'm putting this patch on hold (along with my R-b).

(I had the description reworded as:)

   target/mips: Fix MIPS64 xuseg/xsseg access checks per mode

   xuseg and xsseg checked only UX and SX, regardless of mode. Check
   the extension bit that matches the current mode: UX for user, SX for
   supervisor, KX for kernel (xuseg), and SX or KX as above for xsseg.

   Commit 480e79aedd32 fixed xkphys but left these two segments
   unchanged.

>> ---
>>   target/mips/system/physaddr.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/mips/system/physaddr.c b/target/mips/system/ 
>> physaddr.c
>> index 523197f020..b9f44c27bc 100644
>> --- a/target/mips/system/physaddr.c
>> +++ b/target/mips/system/physaddr.c
>> @@ -145,7 +145,9 @@ int get_physical_address(const CPUMIPSState *env, 
>> hwaddr *physical,
>>   #if defined(TARGET_MIPS64)
>>       } else if (address < 0x4000000000000000ULL) {
>>           /* xuseg */
>> -        if (UX && address <= (0x3FFFFFFFFFFFFFFFULL & env->SEGMask)) {
>> +        if (((user_mode && UX) || (supervisor_mode && SX) ||
>> +             (kernel_mode && KX)) &&
>> +            address <= (0x3FFFFFFFFFFFFFFFULL & env->SEGMask)) {
>>               ret = env->tlb->map_address(env, physical, prot,
>>                                           real_address, access_type);
>>           } else {
>> @@ -153,8 +155,8 @@ int get_physical_address(const CPUMIPSState *env, 
>> hwaddr *physical,
>>           }
>>       } else if (address < 0x8000000000000000ULL) {
>>           /* xsseg */
>> -        if ((supervisor_mode || kernel_mode) &&
>> -            SX && address <= (0x7FFFFFFFFFFFFFFFULL & env->SEGMask)) {
>> +        if (((supervisor_mode && SX) || (kernel_mode && KX)) &&
>> +            address <= (0x7FFFFFFFFFFFFFFFULL & env->SEGMask)) {
>>               ret = env->tlb->map_address(env, physical, prot,
>>                                           real_address, access_type);
>>           } else {
> 
> 


