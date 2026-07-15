Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962EDC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk4VI-00042m-Hv; Wed, 15 Jul 2026 14:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk4VG-00042Z-NW
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 14:38:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk4VE-0003F2-KN
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 14:38:42 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FHBACc342945
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 18:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1oihpgowunOkzF3r9cocDxIy3BKc6smI40Uco8zUa6U=; b=Ad/HzUtOEChR+vhR
 ZFNDHREQWmgpBb8PhecXOmJ7FlnTFwg6PX7fQkLPy2jaujMEAq0qicRVoyXwgfm0
 sQW/vaewgeOUho0v8819cYldjPJr/tgpgFOQGWt1ZTAQIIR63nz89/qVNLWyoluV
 XzpdG57RP3W4SQCIBqDJw3GDv3gx9+Oco78dgm+xK6L3WL2SRDWzyHOW5d0U2UmK
 23F0BJIDJC0pLBtky7Bg+wfagrsHgIhSpvQ5S3LLUhO3ZgyJHePeE0C3qMQeNeRN
 U3PVzFl3cb5sL1dZK/tKcyVE3Bk4IZESCrun7lGN6aiXiNPCO2jUEW4hYx/WkZbc
 N0qVVQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe855a8un-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 18:38:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cce14a21faso45262475ad.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 11:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784140717; x=1784745517; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1oihpgowunOkzF3r9cocDxIy3BKc6smI40Uco8zUa6U=;
 b=Q1pLY46E3+wrszZf++d3v47FqNvc5qj4/BVVVfhV8r4fy5v6ytswQXV/MEU0r/ZNeZ
 t6wxcYcscngKViEOaFk+6Jl6QnDofbP/khOj/ZJzpk0DEF3kX92bhNJMk1Z8zBFOCsQB
 4YkBmXu8se+K7zPQpvdZOOIHbCo5lkzxuKaeA4N3abnGAELPb9Gvu66I8g0U/111TvjO
 vc+KPyWjVYUPm3XanhdFR5mh4rtZzkUiKIe+sHRmDEvWNjpGuMbMnF435gVJqBUribbL
 1WetmB4VpuLJ0b1f+100bOGkpQ59sxk/xE62PWo+G1ckMdcVq2kRiAn01gnTYTFNJT8d
 kLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784140717; x=1784745517;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1oihpgowunOkzF3r9cocDxIy3BKc6smI40Uco8zUa6U=;
 b=l5f6VPmTsu/etpJTVPyNdb8Xt/u+Hgisc5WkuLCnMVDZuMH8qsuA5U+H8g7JdyJVDn
 1WQFeNN1+YDpLrqAQ3oetwUIeP5AIWwSjaTMoohc5paBK/DsQlA9HBqBDMGlc91LY3ET
 tzvan/8AqzBHL0zlC9Yn0CXpA34VAr0xCarVC5RyER8sRp9eWKd0VKkScUh3OV1XvzBB
 RDrSH0ksl0fgkwdoiJcmLweDpEq/C2fVLXl7ZUODBiQj1SQHvsOy13Gv6nPchfBQkued
 OJ2v+K8XEnSEvymIRVQWBi3ncxrAdsvYg37zYY9z9MHqagOvYrBotJfIfeWvGNLj3Epu
 jenA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1Ghmhy03i0/jnTZDXDvIIpDCnAz2upC5UdSNitABk9e7VWuKAf8h90vmaCa9znyVXx+dgQkMRmuy8@nongnu.org
X-Gm-Message-State: AOJu0YxSo0ZRvSmEg5Wt3wk9UksV2pogg6oPCxsnxHHXV78TOZeeUaoD
 8sqkcp7TMsW1XemzEwSa5L8Bs2WhnxGA8+p4Ukt7fVCCoKJHpTv3RiQqulLuuXtpXA8pr4qsuDN
 DI+6z0myFzT5Tbqc0jvVPJSXEwyUS5qj5tnvnkJR8DFwwE/A3aMV1qyKhPw==
X-Gm-Gg: AfdE7clBe8IgzZFq+g3HuWFyoRiE61VFd6hJXEIGya3PswZR4IuuZU8WiImBY5oMx+Q
 RpPPmscdeOE/c2HVsXl9kJzV1nall0gjbtGFYSRYT6HWyitJXAO7FIb6pB1O1ANQcP7t0IMSdtt
 GdGvP173vP5iZ1x9MVWpY9Amdozc3Uwlq5LB4RX6e6YZHW9mIHrj1f4ZlYjKP4VYzyNTR6l3ivT
 g+4xxzOYdyTKeLpggQ2O2eTR/0nh12262rPAwuQdmZS+ByXKoN1VZXMgLORNNAumcyCZGh2osFZ
 fzAjAD31QFfs7ifEUDICno28FtC9tfKmhzP+KSpjDQEDiWNfTh4Ubyva8o1igX4R0IVaBCb9Wto
 AQUFP1Y/CLvZMmyUvj0gEEDFRhrbm5vngIu80+q6feyH81zemO13SIwVTc4Afu3x4waYWMflxCr
 VnbIE=
X-Received: by 2002:a17:902:da8e:b0:2cc:db7a:251 with SMTP id
 d9443c01a7336-2cf177c78dfmr5610105ad.2.1784140716781; 
 Wed, 15 Jul 2026 11:38:36 -0700 (PDT)
X-Received: by 2002:a17:902:da8e:b0:2cc:db7a:251 with SMTP id
 d9443c01a7336-2cf177c78dfmr5609715ad.2.1784140716173; 
 Wed, 15 Jul 2026 11:38:36 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13cd4284a92sm2710384c88.4.2026.07.15.11.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 11:38:35 -0700 (PDT)
Message-ID: <943b7ca7-dcd3-4702-b6e3-5ddcb04000e8@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 11:38:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] plugins/execlog: fix execlog vcpu_exit execution
 print loss
To: Harry van Haaren <harry.vanhaaren@openchip.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "erdnaxe@crans.org" <erdnaxe@crans.org>
References: <20260616161242.267315-1-harry.vanhaaren@openchip.com>
 <20260616161242.267315-2-harry.vanhaaren@openchip.com>
 <e7edbf3f-55e1-42a4-8101-0a1c273c7587@oss.qualcomm.com>
 <GV2P192MB3464B1F78D8F38D1574A8D9185F82@GV2P192MB3464.EURP192.PROD.OUTLOOK.COM>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <GV2P192MB3464B1F78D8F38D1574A8D9185F82@GV2P192MB3464.EURP192.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OGkhRlcKwfpSf6EE2zrf9YdvPPIqVGp-
X-Authority-Analysis: v=2.4 cv=KOlqylFo c=1 sm=1 tr=0 ts=6a57d3ad cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=OZcmDFxvAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8
 a=dGsWvjqBAAAA:8 a=J1OKBGARc6P9ThM_kiQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=liPxxeoTYnb3ClP5OJlV:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=EwAE0RQWx3bH85eTCWcH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE4NSBTYWx0ZWRfX2xvjeBVmMqaV
 UiX4FDvNrolhscgr4IVpSY5/l0GdIRDgawMcaRQPa11zNf0cj/jRm5lJaFcmbuDmQt7T3kMr/Xj
 4ahEmu9n6XBP5KC9+dBJToVSfNkIkrfBPfwu7165wqQmwLD++j0IPZ/F9X9EzYXECKUfMh1TSx1
 K854WiG03CiB28lrYG/HYCmenfs907sosg4Hp4wBtqIrWkP+n/T77GyYalf1vpOfFcrqdNR5siI
 UGRKbO3EZ8PDSHvWDCASF4e/dkvjxmV1FbiptUEespdRZnVtYuK4ImdTso4ErHBYqmw0g3xyM8Z
 Dq7RgGpS03STV7KKyKRSmqlcSa7E+/r2MBNd6rlmXLV1M/5XFTUg9II8IOltIerBUkyqHuKoDaU
 k++DGomYJkaqymMNbWZEjIE3sK8EmM0jpXwkOHRp1+EMWH3sIbDLzQ98g+iGzCnZH7rNg6jelH3
 2eg6O68dV1gYNSJOduA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE4NSBTYWx0ZWRfX9iHzSmCZwV7n
 480e7mSDVTfCfVwSIqE8+S7iqZ/PHxqABWVqM+XXkiWLWwW7BC356ayre4VHvZIq0zc2l4n+CX5
 hAYKew6qwu1ll7fuqXCq1qYrcRRweqM=
X-Proofpoint-ORIG-GUID: OGkhRlcKwfpSf6EE2zrf9YdvPPIqVGp-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150185
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/15/2026 10:05 AM, Harry van Haaren wrote:
>> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Sent: Tuesday 16 June 2026 7:40 pm
>> To: Harry van Haaren | OPENCHIP <harry.vanhaaren@openchip.com>; qemu-devel@nongnu.org <qemu-devel@nongnu.org>
>> Cc: alex.bennee@linaro.org <alex.bennee@linaro.org>; erdnaxe@crans.org <erdnaxe@crans.org>
>> Subject: Re: [PATCH 2/2] plugins/execlog: fix execlog vcpu_exit execution print loss
>>  
>> On 6/16/2026 9:13 AM, Harry van Haaren | OPENCHIP wrote:
>>> From: Harry van Haaren <harry.vanhaaren@openchip.com>
>>>
>>> Executed instructions are cached in string format inside the
>>> execlog plugin. These strings are flushed on exit of a TB, improving
>>> performance. This causes executed instructions to be lost when an
>>> 'ecall' (riscv system call) occurs that causes the thread to terminate.
>>>
>>> The fix in this patch registers an 'on_exit()' callback, and flushes
>>> any content in the c->last_exec buffer, to ensure all instructions are
>>> present in the final instruction log.
>>>
>>> A mutex lock/unlock is added around the plugin exit, to ensure the
>>> lines are not corrupted.
>>>
>>> Signed-off-by: Harry van Haaren <harry.vanhaaren@openchip.com>
> 
> <snip>
> 
>>> +/**
>>> + * On plugin exit, flush any remaining cached instructions and free state.
>>>    */
>>>   static void plugin_exit(qemu_plugin_id_t id, void *p)
>>>   {
>>> @@ -396,8 +417,10 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>>>       for (int i = 0; i < n; i++) {
>>>           CPU *c = qemu_plugin_scoreboard_find(cpus, i);
>>>           if (c->last_exec && c->last_exec->len) {
>>> +            g_mutex_lock(&execlog_output_mutex);
>>>               qemu_plugin_outs(c->last_exec->str);
>>>               qemu_plugin_outs("\n");
>>> +            g_mutex_unlock(&execlog_output_mutex);
>>>           }
>>>       }
>>>       qemu_plugin_scoreboard_free(cpus);
>>> @@ -467,6 +490,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>>
>>>       /* Register init, translation block and exit callbacks */
>>>       qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>>> +    qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit);
>>>       qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>>>       qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>>>
>>
>> Why not simply make this flush in atexit callback?
> 
> I think on guest-thread join, the pthread stops, and qemu calls vcpu exit callback.
> At that point in time, its nice to flush the "ecall" (to printf or disk or whatever the output is) so the user sees it immidiately.
> 
> The risk of not flushing here, is we wait until:
> A) the plugin (not thread) exits, which could cause other threads to interleave/finish first (confusing, interleaved and delayed output)

Taking a look here, I can see that we have two different mechanic for
atexit: one for system (relies on libc atexit), and one for user, which
indeed can race between threads.

It should be refactored, I'll take a look to remove the need to use any
lock in atexit handlers for plugins.

> or
> B) a new thread is spawned by the guest, and the vcpu is re-used. This will correctly flush the previous-thread final instruction, but after an application-dependent delay.
>

That's a good concern, and fixing it with vcpu_exit seems like a good
idea given this argument.

> Given that thread-exit is already heavy-weight and rare, I think the best for the user that the final instruction flushes immediately when a thread is finished.
> Unless I get strong feedback for a different approach, I'll respin the patchset and send (with git-publish, with footer removed, and "| Openchip" fixed... hopefully!)
> 
> Regards, -Harry

Yes, you can keep the current approach.

Thanks,
Pierrick

