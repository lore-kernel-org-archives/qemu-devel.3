Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B832606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k29E+g64;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bT2N9JsB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOs4a-0006bN-KP; Thu, 05 Nov 2026 02:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xOs4X-0006b4-V6
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 02:39:46 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xOs4V-0006M7-H4
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 02:39:45 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A56U5X34139280
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 07:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TtZ17adkWEPtYPBlZzHTKU3mXgNNZcQWkOYQqAD5oGk=; b=k29E+g64f5ImWpDg
 L3VQzFYPdREH5cly13rhstBK3ZWeShI5kNcIo9ZXsYs+yoa87TUbfkW5U+GKJzCA
 dvuvlWE0wdezZ2CWsLkkir1J1bhr3W4FaUXWsKCxbP7z7xqyCGX9K2NtLNYshPVi
 Cqyz7eGoSX2CS0mex7k/kvIlcttroNeyw0DwY1kwAyJArZz4H/73Vtxj5Tg0KlbX
 wnMXbOZWJmTvXFdbtDA2k2E03Vrmz0y3XAp0acRxR0Wztw4v5VSJyych9MTZDF6k
 Ewtgnh7XwamuzjHVldpoiDkmgTaeN5ReN2EEzAzRx0E6YYtw77BxJGNtUOqPqC2K
 XYUqrQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrm9v0apf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 07:39:40 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36d2d353a5aso499834eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 23:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793864380; x=1794469180; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TtZ17adkWEPtYPBlZzHTKU3mXgNNZcQWkOYQqAD5oGk=;
 b=bT2N9JsBNsoaH9goHT3yBwohPZus094K3eQticCBpRGICpmn94fi7VRiM6lEcqMCY5
 CEyk+V19ZSCaiAkZDU+SCNqblqwGk6PiUn9g/Z4fnyxFQsI8/ZBilqMFVt9uHGNNtxr0
 PQK/pWmA4+5lLrt6cp9YlF0asO7x9j5qf2hTF4HirxLcn641UU4p7CK4RoN1/PMVKRS9
 bXj4Ws0aTNAh3iht6e5EA5y3vLEoa2DOkL6xAQj+VJIHkr0m5CcEb0zJlgM2krPbYxDn
 XCF5clU2nmzpb9s0+mfFdPYnhgjMUtXVK2ho3Bao4O+rj6N2YHFMTDhYzkgLEhp8I2XP
 GoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793864380; x=1794469180;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TtZ17adkWEPtYPBlZzHTKU3mXgNNZcQWkOYQqAD5oGk=;
 b=J/L7zy84dmXrkWrqZk0K9uZJmZY28YhOwjNDMsQGCstgkNBWZ/sTwQSb2zkA0xco/J
 7fH3w7Num3GeeJIZHDlG2uZIB6htt2e9zqPRObOVW2NOO56BA0NbTHkyn3DQnzjncLoa
 9bdRgY/w0DtuYWD75bs/qpADWLf9+oYOYVnP5KKB82wW0aEyD7j7Jua3e9xhQYnqyUDY
 Ynx3cbbCmjN+JimUgRhTQDmnwAhQt1qoNxfVxSPIby0RaiHc4NJQm33z/6Ii0q3gSOgG
 B1+fsmVB4ZjRUX0xS+afX0LB26Km8CoqezQZtCtf9Nk6mXRBskrkjpkmPYPX0BkeH2Bm
 7qLw==
X-Gm-Message-State: APuU4Z9CFd5tF9W4qU3D8vrhfKNImL0NSP3Dq/PS5cO0gg3UM0kxVbMj
 QtqtHbryT2m8QYHLQJFrLrge6QULsfvqKSHSBaIvaYn1HqnBQ4ONdijomiNoL4ZbexNpB9+11eZ
 9KSBuRC/tl0eB2PLAWw+0iR4dslBG86WrXWtfsQmNT6JjLahPWW54JjTE+A==
X-Gm-Gg: AYBFou2PqWlVscNWYXy2bm+06z+mL8ndpySwmvZVAA/6kzxq36CAnyX3LnLRZPvpTUy
 H0/S567fYCRX9IJxYfMqFLwI1db7Bndbcvxz7v+jljKHVuqQFE+xXpostGGgv35yEADd6zQU2u5
 KKH3WlYEzB/nnf2fCvLFCeGMiO4/Fhsrsf1CoXSVBNHTJaucAdyVW3KOqqJEVv8IiPovLiu9DLu
 5w5AR602BDH8Zih0Zo5CdPeCwbOOs1NOfQ6eXHHR3Zbp+P5fTVGKnD6SrjiQ6yIdKNhCQN6fq+O
 V6V/OFZ32uKxAw6j+mo6ROF/l87EHwDcRIDt9z2j9ReHVtDW5FhUaIZeM6vJWVnoRn+SfqCq1nR
 /fF+zTlVm+I3UFLeSUCO4C34O9PzXEhHvVf9Fv2WXCFy3FscOtDwRdSGbno/ccwmgUYmaZjD181
 Pw6iqY9z4m8xvKi+B8ZsJAuvQjA8MNAXX3+utgAg1THw==
X-Received: by 2002:a05:7301:5412:b0:36d:158c:e31d with SMTP id
 5a478bee46e88-36de6d4cca9mr2758800eec.18.1793864379897; 
 Wed, 04 Nov 2026 23:39:39 -0800 (PST)
X-Received: by 2002:a05:7301:5412:b0:36d:158c:e31d with SMTP id
 5a478bee46e88-36de6d4cca9mr2758751eec.18.1793864379130; 
 Wed, 04 Nov 2026 23:39:39 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36dad72dc52sm6848933eec.0.2026.11.04.23.39.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 23:39:38 -0800 (PST)
Message-ID: <774f3355-886b-4dbc-ae18-23327d368d8e@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 23:39:37 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gdbstub: reset supported features on Supported request
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, brian.cain@oss.qualcomm.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Justin Sapp <jsapp@qti.qualcomm.com>
References: <20261030222146.558366-1-pierrick.bouvier@oss.qualcomm.com>
 <CAJ+KCYNmsGqnF6_wYxukntNO00sALXwvFGhEKU4NVBh6EbM=SA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAJ+KCYNmsGqnF6_wYxukntNO00sALXwvFGhEKU4NVBh6EbM=SA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMCBTYWx0ZWRfX/hzlEnBz/9uq
 N6joes1zvAxVA6ZkTEeJNPzA9PP5BWZO5598Iosm/Hqys3VnEjiI7Hfi1UI1jQrgyMjI2F8scnT
 MwhMCRa47B7tkDXCF3cWzrOw0fSB1ek=
X-Authority-Analysis: v=2.4 cv=KrHYSmWN c=1 sm=1 tr=0 ts=6aec32bc cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=CCpqsmhAAAAA:8 a=EUspDBNiAAAA:8 a=sfECMvQP9NT3YPG-6TAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMCBTYWx0ZWRfXxRHm8nFV/nZa
 HJOHOE87a33JNF7Ber22LEaRhXQnK/CRyOaCN08Tw4T0XKvxLvhIeNOtXiRaIYS+zvHkp6uQuWf
 DyJjC2/uGbQR7ejb0AS5vqGch3o+VgLNHSzUhmAxnbw+cF3gCfQ2rcphPLmjbJYQoUNkMIxt3N2
 NwMNoUVgOSaXh0KNv3tuq9pB8kqdIZaghLVYDmc3KtQ7+mn40lN317ZPdg4E3fAZi8r+DgvSigg
 WLKQZkqsaIm26um4/abZqns5lveP8rnW32aRzwGSKpJt8+PzJ1O66d440DWuH3yj5+8y7hHcMN0
 QW7wW/0qIbwyFl3ZsjwfGu4GAQvZuEOSntUdl/HSnWaCuJSOndnxG74sBdIlACmtTseZ/twT0xo
 O2+ns7B12nVLO9Lrs58f0fjTMIEy5O9YHmaYSkbYiRRihF57sAC7MgAg05u9G1AmDSZmpsg4RMk
 sRpIkA8FxRtX/mV8bYQ==
X-Proofpoint-GUID: MaanmHoS4OdDp3Fijd0BqDeaxQSRxqB5
X-Proofpoint-ORIG-GUID: MaanmHoS4OdDp3Fijd0BqDeaxQSRxqB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050030
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 11/4/2026 11:09 AM, Marco Liebel wrote:
> On Fri, Oct 30, 2026 at 5:21 PM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> From: Justin Sapp <jsapp@qti.qualcomm.com>
>>
>> https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Packets.html#qSupported
>> ```
>> Whenever the stub receives a ‘qSupported’ request, the supplied set
>> of GDB features should override any previous request. This allows GDB to
>> put the stub in a known state, even if the stub had previously been
>> communicating with a different version of GDB.
>> ```
>>
>> We exposed this by connecting to gdbstub using a gdb client first, and
>> then WinDbg (EXDI) for windows kernel debugging. Since they both
>> differ in their multiprocess support, this was confusing EXDI.
>>
>> While we are here, fix the same for fork_events in user mode.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  gdbstub/gdbstub.c | 6 ++++++
>>  gdbstub/user.c    | 1 +
>>  2 files changed, 7 insertions(+)
>>
> 
> IIUC, in user mode a bare qSupported doesn't clear fork_events,
> so a previous client's fork-events+ stays active for the next client.
> 
> E.g. GDB connects with fork-events+ and disconnects, then a client
> sends a bare qSupported. On fork() the stub stops the parent and
> reports the fork to the client, but it should not report it and the
> parent should keep running.

Thanks, that's a good catch Marco. I'll move the fork-events reset at
beginning of handle_query_supported instead.

Regards,
Pierrick

