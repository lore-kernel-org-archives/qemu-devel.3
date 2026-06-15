Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F267CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZBUT-00022Q-51; Mon, 15 Jun 2026 13:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBUR-00022C-C3
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:52:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBUO-0007J2-UV
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:52:51 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFiAbV1015165
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4zt6UEokVRXyACpVFlnxFTtwY+uj/hc1OiJfL8N1IUE=; b=b/MMaU5lHPgo5EVY
 jtPv/z7sJsaTM4rFMDLwzmq7AZgZARPwy9cNwPaMQVCxcRkgOJZhytTcmCCnX6s5
 zTgOQ4J49AZrURy3YDLS83cIbYyDNzgSLwLkn9jIWy/UZ0PF91aZZhMC8HsoOfrp
 hLHDAtuwoqgvJKjSNZEygvpbISBjsaWZQT6L33yo2kcvy1sShPb26XMO+fe6AfU2
 vgUOTvDqdK/Elrv0Hu//USN91QWJj0Aq9wT/0pJQ4w3LZCZfEGdqECd4pyNFo42H
 2EerEoYqWNdqEBEMKyO7Ke6LOnIfyqAerTyjRy9sWcPdCvrtI2gLSnXfkHPV/3OQ
 kKLpJg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etd2can09-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:52:47 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-307fe856724so2317126eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781545967; x=1782150767; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4zt6UEokVRXyACpVFlnxFTtwY+uj/hc1OiJfL8N1IUE=;
 b=LCIkVLUngUxZ84F2A/DP7GDpw4/bhA/Idi+Ziax5LEMNd+/eZMJY0Iuxj/OngFaXGS
 283JlPXVEx9O5FREG4tJtPBlsTwnBreReBRlfbmR/xf6pyfVfs5Tl+FvW2/COEHkNgbt
 afC8bx6IZi232DpwT+qKQ1SvxjBkpnHccRqpBAlmxJpeGZ6+/nvC6elwp0SYyvxchAE3
 EINR6hrRFiwVeV4R/CpFk7Qsjwj1jn8KJyTdzEVzsj2vQqV3iKCInqQu+KmuCbomPXh4
 CYfjI5WSTbtEbVpr8B3aAk9lPVqe4TXk81RCrYdoz86cj6Ahb1Bt4zatdWcF7R+4MlXK
 zISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781545967; x=1782150767;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4zt6UEokVRXyACpVFlnxFTtwY+uj/hc1OiJfL8N1IUE=;
 b=mYgN1cBnjWfqQliOB8rgYhqc4/4Z7VmI5xpTNmbmqNa+iQgN434ckarFxbiRWU0uVr
 +01CV6dfwH9cC8j166zA2JC4AMaUer1AONUTIareZyHM91HClt1lh35G8eD4cQzzID6c
 dn8kyXSZ6JLcQCqLOxW3REZi5zP4iUhdvYti+lsudASul4zoU4YeITs5l8GcXsMp36GG
 GC77znwOGGkXWre2WZlyYpLh+poAsjSMZ4nt0V0x0Rqe7nofaluknihKKV1Ws6PiBLI8
 IeZbZtqrfaeKL2ycBPh7dcxEOyc87IZRnniKcAhQScZH8Ip1OO1PubmvwRZFnE3z/6LJ
 Cgmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/PGt7l1rR1y8GM9qv1Z3yc/p3C4yc3xVpnNDG4oRArHnECow8Hn1inmBBlAT8OICAjEPagLcWeBR1u@nongnu.org
X-Gm-Message-State: AOJu0Yz9hed2dov1iFf/B2wFkIDZH6JDM1zvSApOO/y6jHivu0vi19HY
 pdRhjUo8ihyQ3Parqa745NBUSmDzws/2cNdfgdTPv8YzV9FyvI2DmsFKVVsnXwOXUQY/E1MaI2b
 bfJcaVonqmJmAeXLPXvq2WYHwCx+L4aXD1XXCJa10wDwx1O0WYT8ocjABEQ==
X-Gm-Gg: Acq92OFusJYE577qMA/N1yM+lHlt4Xnuoh0F9xn6in3vY0mih8sXD6iAUHfTesHsIQ4
 Ta0dk5gKq6mHKlVbmt+FbOWf5VkI7H1fOloX7E+Q06JeLRJtLv+KlB+Si5SVUGgk/byWLjL3VxX
 fUND8K6/LFyCI1iz62vigU50OJklluBjh+YKqLj+ZrjSQl+196YsHsoRxrSZruNwO5WxB1cl6c9
 wvs9iJz37a9kH+bGxqF1OAcUNP/euuCcEgRQvbU0QcOf9zeiNmPc2ojWL79l73eIq/sOQ99fhDi
 m6QIhGsGTBIeYjgcCfbkLxZKZm+ZxvKytmUy6gEWEqkbxQCXTF85Xtn1m1Y9T4EI77f6vrOE0t/
 ooLTPpUVxrdoL8pp1+5EUU3gLJSu3x0Rxb8YzIVMPfqmCl6+fxDa6WnalBXNbAVhaXlXSI1bev8
 bhqi/U/fQvdiW2hw==
X-Received: by 2002:a05:7300:6d20:b0:304:df0e:9db2 with SMTP id
 5a478bee46e88-30ba5f01cc6mr132559eec.24.1781545966796; 
 Mon, 15 Jun 2026 10:52:46 -0700 (PDT)
X-Received: by 2002:a05:7300:6d20:b0:304:df0e:9db2 with SMTP id
 5a478bee46e88-30ba5f01cc6mr132537eec.24.1781545966109; 
 Mon, 15 Jun 2026 10:52:46 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5cea89sm16822364eec.8.2026.06.15.10.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 10:52:45 -0700 (PDT)
Message-ID: <6b5ca649-387f-41d7-b570-2ea7b94ff335@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 10:52:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/25] plugins: add userdata to
 qemu_plugin_register_vcpu_init_cb
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-8-pierrick.bouvier@oss.qualcomm.com>
 <tggc72.124075qhyf1jo@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tggc72.124075qhyf1jo@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfX9Yl5DXdeEDn0
 9urdak7AElvpTF2KuNb/uPgti5l19/xsiwo8ZmxLXU0gnBQCBjpicbwv3u3B09GZZBUh6wLKBBw
 nqrZh/rflVBcN7Ak4i1gkiuL4jdSDYmvLrir7ysuvWdVSxoOI340uJnDDlJXfDNXrjrxPuZ74Tw
 I0dpWrYYwYlKONhHAiNgYRJyrdwHSms2mDhQQMDeEoDlgG+GhnOM6A9MgGEsyjizDNMxhjFohot
 ArSfCQcZDgcAGS2mUnlN3hLZCSoZr/uWbIClZeg0nfG1r2xpO2nVsk9fdIuZQzexEcySKxd02FS
 L5lolNu/PMeOPqA5DV5fyvgSSjFRS9kTfAU3GjD8h+efn9aGpYImtamdG/8DzfxW97E4YkyXSUq
 yP5PAJS0niWwyy9C0Ol4pLa2rqzk9BeCL3yvvigRpDmPpzaRYLfN56e4cL2HTnhxxM0ViFMatsK
 Bk6pY40uT1pCTaqKslA==
X-Proofpoint-ORIG-GUID: J-ZKMS8i8TF5-bTa7mocmH3IMDNq-77n
X-Proofpoint-GUID: J-ZKMS8i8TF5-bTa7mocmH3IMDNq-77n
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfX7uVoqPbsClkV
 aI8ItsUqJCbWMK67GuFPh6Wt7Qiipq1mOL0EtuyKQwHqaRWP/NT4ytcH8UmuL8mmzFB4VdIXRr8
 anFEZIqdddEOivNeJ+7fV8B5yEiJwH0=
X-Authority-Analysis: v=2.4 cv=MsRiLWae c=1 sm=1 tr=0 ts=6a303bef cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=hoSYicnPhkKnheYg-tsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150189
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

On 6/10/2026 10:19 PM, Manos Pitsidianakis wrote:
> On Wed, 03 Jun 2026 23:51, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>> contrib/plugins/bbv.c         |  4 ++--
>> contrib/plugins/execlog.c     |  4 ++--
>> contrib/plugins/ips.c         |  4 ++--
>> contrib/plugins/uftrace.c     |  4 ++--
>> include/plugins/qemu-plugin.h |  4 +++-
>> plugins/api.c                 |  5 +++--
>> plugins/core.c                | 26 +++++++++++++++++++++++---
>> tests/tcg/plugins/insn.c      |  4 ++--
>> tests/tcg/plugins/registers.c |  4 ++--
>> 9 files changed, 41 insertions(+), 18 deletions(-)
>>
>> diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
>> index 72cc896a0a6..0ad1301a1de 100644
>> --- a/contrib/plugins/bbv.c
>> +++ b/contrib/plugins/bbv.c
>> @@ -60,7 +60,7 @@ static qemu_plugin_u64 bb_count_u64(Bb *bb)
>>     return qemu_plugin_scoreboard_u64(bb->count);
>> }
>>
>> -static void vcpu_init(unsigned int vcpu_index)
>> +static void vcpu_init(unsigned int vcpu_index, void *userdata)
>> {
>>     g_autofree gchar *vcpu_filename = NULL;
>>     Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
>> @@ -156,7 +156,7 @@ QEMU_PLUGIN_EXPORT int
>> qemu_plugin_install(qemu_plugin_id_t id,
>>     bbs = g_hash_table_new_full(g_int64_hash, g_int64_equal, NULL,
>> free_bb);
>>     vcpus = qemu_plugin_scoreboard_new(sizeof(Vcpu));
>>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>> -    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
>>     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>>
>>     return 0;
>> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
>> index 398aa4a1f3f..2d02816a184 100644
>> --- a/contrib/plugins/execlog.c
>> +++ b/contrib/plugins/execlog.c
>> @@ -382,7 +382,7 @@ static GPtrArray *registers_init(int vcpu_index)
>>  * As we could have multiple threads trying to do this we need to
>>  * serialise the expansion under a lock.
>>  */
>> -static void vcpu_init(unsigned int vcpu_index)
>> +static void vcpu_init(unsigned int vcpu_index, void *userdata)
>> {
>>     CPU *c;
>>
>> @@ -481,7 +481,7 @@ QEMU_PLUGIN_EXPORT int
>> qemu_plugin_install(qemu_plugin_id_t id,
>>     }
>>
>>     /* Register init, translation block and exit callbacks */
>> -    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
>>     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>>
>> diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
>> index 32fd86c87ac..1290a624489 100644
>> --- a/contrib/plugins/ips.c
>> +++ b/contrib/plugins/ips.c
>> @@ -89,7 +89,7 @@ static void update_system_time(vCPUTime *vcpu)
>>     g_mutex_unlock(&global_state_lock);
>> }
>>
>> -static void vcpu_init(unsigned int cpu_index)
>> +static void vcpu_init(unsigned int cpu_index, void *userdata)
>> {
>>     vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
>>     vcpu->total_insn = 0;
>> @@ -207,7 +207,7 @@ QEMU_PLUGIN_EXPORT int
>> qemu_plugin_install(qemu_plugin_id_t id,
>>     g_assert(time_handle);
>>
>>     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>> -    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
>>     qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit);
>>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>>
>> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>> index 438cebf2831..8be8409dce2 100644
>> --- a/contrib/plugins/uftrace.c
>> +++ b/contrib/plugins/uftrace.c
>> @@ -874,7 +874,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id,
>> struct qemu_plugin_tb *tb)
>>     }
>> }
>>
>> -static void vcpu_init(unsigned int vcpu_index)
>> +static void vcpu_init(unsigned int vcpu_index, void *userdata)
>> {
>>     Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
>>     cpu->ops = arch_ops;
>> @@ -985,7 +985,7 @@ QEMU_PLUGIN_EXPORT int
>> qemu_plugin_install(qemu_plugin_id_t id,
>>     }
>>
>>     score = qemu_plugin_scoreboard_new(sizeof(Cpu));
>> -    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
>>     qemu_plugin_register_atexit_cb(id, at_exit, (void *) info-
>> >system_emulation);
>>     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>>
>> diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-
>> plugin.h
>> index 8aaf404504b..bb4569a2291 100644
>> --- a/include/plugins/qemu-plugin.h
>> +++ b/include/plugins/qemu-plugin.h
>> @@ -242,6 +242,7 @@ void qemu_plugin_reset(qemu_plugin_id_t id,
>> qemu_plugin_udata_cb_t cb,
>>  * qemu_plugin_register_vcpu_init_cb() - register a vCPU
>> initialization callback
>>  * @id: plugin ID
>>  * @cb: callback function
>> + * @userdata: any plugin data to pass to the @cb
>>  *
>>  * The @cb function is called every time a vCPU is initialized.
>>  *
>> @@ -249,7 +250,8 @@ void qemu_plugin_reset(qemu_plugin_id_t id,
>> qemu_plugin_udata_cb_t cb,
>>  */
>> QEMU_PLUGIN_API
>> void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
>> -                                       qemu_plugin_vcpu_simple_cb_t cb);
>> +                                       qemu_plugin_vcpu_udata_cb_t cb,
>> +                                       void *userdata);
>>
>> /**
>>  * qemu_plugin_register_vcpu_exit_cb() - register a vCPU exit callback
>> diff --git a/plugins/api.c b/plugins/api.c
>> index 91c9a24a6b2..68b564bb9c2 100644
>> --- a/plugins/api.c
>> +++ b/plugins/api.c
>> @@ -71,9 +71,10 @@ void qemu_plugin_reset(qemu_plugin_id_t id,
>> qemu_plugin_udata_cb_t cb,
>>  */
>>
>> void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
>> -                                       qemu_plugin_vcpu_simple_cb_t cb)
>> +                                       qemu_plugin_vcpu_udata_cb_t cb,
>> +                                       void *userdata)
>> {
>> -    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INIT, cb);
>> +    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_INIT, cb,
>> userdata);
>> }
>>
>> void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
>> diff --git a/plugins/core.c b/plugins/core.c
>> index 217d6608c1d..1d5692b3f41 100644
>> --- a/plugins/core.c
>> +++ b/plugins/core.c
>> @@ -89,7 +89,6 @@ static void plugin_vcpu_cb__simple(CPUState *cpu,
>> enum qemu_plugin_event ev)
>>     struct qemu_plugin_cb *cb, *next;
>>
>>     switch (ev) {
>> -    case QEMU_PLUGIN_EV_VCPU_INIT:
>>     case QEMU_PLUGIN_EV_VCPU_EXIT:
>>     case QEMU_PLUGIN_EV_VCPU_IDLE:
>>     case QEMU_PLUGIN_EV_VCPU_RESUME:
>> @@ -104,6 +103,28 @@ static void plugin_vcpu_cb__simple(CPUState *cpu,
>> enum qemu_plugin_event ev)
>>     }
>> }
>>
>> +/*
>> + * Disable CFI checks.
>> + * The callback function has been loaded from an external library so
>> we do not
>> + * have type information
>> + */
>> +QEMU_DISABLE_CFI
>> +static void plugin_vcpu_cb__udata(CPUState *cpu, enum
>> qemu_plugin_event ev)
>> +{
>> +    struct qemu_plugin_cb *cb, *next;
>> +
>> +    switch (ev) {
>> +    case QEMU_PLUGIN_EV_VCPU_INIT:
>> +        QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>> +            qemu_plugin_vcpu_udata_cb_t func = cb->f.vcpu_udata;
>> +            func(cpu->cpu_index, cb->udata);
>> +        }
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
>> /*
>>  * Disable CFI checks.
>>  * The callback function has been loaded from an external library so
>> we do not
>> @@ -145,7 +166,6 @@ static void plugin_cb__udata(enum
>> qemu_plugin_event ev)
>>     case QEMU_PLUGIN_EV_FLUSH:
>>         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>>             qemu_plugin_udata_cb_t func = cb->f.udata;
>> -
> 
> Accidental or something missing?
>

Accidental delete I would say :)

> LGTM though:
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> 
> 
>>             func(cb->udata);
>>         }
>>         break;
>> @@ -271,7 +291,7 @@ static void qemu_plugin_vcpu_init__async(CPUState
>> *cpu, run_on_cpu_data unused)
>>     qemu_rec_mutex_unlock(&plugin.lock);
>>
>>     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
>> -    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
>> +    plugin_vcpu_cb__udata(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
>>     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>> }
>>
>> diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
>> index 80f7cbb2967..d9f94888d6f 100644
>> --- a/tests/tcg/plugins/insn.c
>> +++ b/tests/tcg/plugins/insn.c
>> @@ -84,7 +84,7 @@ static Instruction * get_insn_record(const char
>> *disas, uint64_t vaddr, Match *m
>> /*
>>  * Initialise a new vcpu with reading the register list
>>  */
>> -static void vcpu_init(unsigned int vcpu_index)
>> +static void vcpu_init(unsigned int vcpu_index, void *userdata)
>> {
>>     g_autoptr(GArray) reg_list = qemu_plugin_get_registers();
>>     g_autoptr(GByteArray) reg_value = g_byte_array_new();
>> @@ -296,7 +296,7 @@ QEMU_PLUGIN_EXPORT int
>> qemu_plugin_install(qemu_plugin_id_t id,
>>         qemu_plugin_scoreboard_new(sizeof(uint64_t)));
>>
>>     /* Register init, translation block and exit callbacks */
>> -    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
>>     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>>     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>>     return 0;
>> diff --git a/tests/tcg/plugins/registers.c b/tests/tcg/plugins/
>> registers.c
>> index 94776d887fe..0e41734435f 100644
>> --- a/tests/tcg/plugins/registers.c
>> +++ b/tests/tcg/plugins/registers.c
>> @@ -21,7 +21,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version =
>> QEMU_PLUGIN_VERSION;
>>  * registers that cannot be written to, which would fail the test.
>>  * See: https://lists.gnu.org/archive/html/qemu-devel/2026-02/
>> msg07025.html
>>  */
>> -static void vcpu_init_cb(unsigned int vcpu_index)
>> +static void vcpu_init_cb(unsigned int vcpu_index, void *userdata)
>> {
>>     g_autoptr(GArray) regs = qemu_plugin_get_registers();
>>     g_assert(regs != NULL);
>> @@ -74,6 +74,6 @@ QEMU_PLUGIN_EXPORT int
>> qemu_plugin_install(qemu_plugin_id_t id,
>>                                            const qemu_info_t *info,
>>                                            int argc, char **argv)
>> {
>> -    qemu_plugin_register_vcpu_init_cb(id, vcpu_init_cb);
>> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init_cb, NULL);
>>     return 0;
>> }
>> -- 
>> 2.43.0
>>
>>


