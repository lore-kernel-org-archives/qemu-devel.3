Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F2BC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x16Sf-0005An-M3; Mon, 31 Aug 2026 14:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16Sd-00059a-EU
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:10:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16Sb-0004UW-7y
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:10:23 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VFpowf3477003
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 18:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hUwEf7jq5Sm0abLvlkYo5E24NRuiHoEp2k61skRKTNg=; b=Nyo8oPBanHBlOI1y
 /kldJh3UHq9SszSZIUOWOye0uIcsu5K/4f48/UCZ6wv2L2oQDtdRjGFFey8+S3OE
 AENNj1Xz1EsjY9vOA9ekVMsGiRPLbnAavh+3LoWWV2NYK3g50uGt5AXl1xnffIT7
 D7Epu0eGZg1zg3Pw+fayX5osQRwb9sLybLHXalEwFAy7xzkUVMCG3A7OsWLd2rij
 wbluwhSlDJFVyBDLm2R1GPwrIKOWSi5goG4h5PRs9cEj2xRt9AtZCjjm7N/nw/W4
 GTVHzBJOazzqCQhYCf8GR17ajuK3RirVKq2UYKZfvwhSsJflQgawDQHcn40Zg4Qd
 qbgjsQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6ayjjt7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 18:10:19 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbee6bb8408so5129027a12.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 11:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788199819; x=1788804619; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hUwEf7jq5Sm0abLvlkYo5E24NRuiHoEp2k61skRKTNg=;
 b=LInSN05oflhz8IxNd8mfeasSz6AskVTy11ix6bLvLpWiitbzAXsfXSMqp8LIT8uxkd
 eo15/0JJtFxg4mjtBiYf9ppUXWNb8q2iiFcg2JSHLD8zqj2WfsjwPeaCtG18/mnVvVpf
 z+TZEN0Bl7mWI4g+l3HZptmuNiahJp/LjIHgObiStrS3qSL+sNghAMSxR1oivXcipgsw
 rY6ICvKbl3hEDHqlKEOascy4e7vmJO7l4QnC3I/t57DLKYPtFzmam1loxMLspOzJSvXS
 T81JvNgMlU+oyjgw/cDEffqHDHt9vrZwvDNcyjCWTH3wVV25t4sWaHuKNGr+EbBx4sq6
 nkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788199819; x=1788804619;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hUwEf7jq5Sm0abLvlkYo5E24NRuiHoEp2k61skRKTNg=;
 b=AGSdSFFTk6/XlrVZZrTts6q9HJAKLkjCxuHTdvfVV1Bj6LA8DhUUNAB7iozC/la+EJ
 vcoI/x/nQYklKNg///ueUoxb3bg54xbnmMBI+agry1JrpEfoytdiqLU0RtkBHbPBJ61M
 2Y4CI+ugzgDU7zLGnvnTpDlgGkGTfmzYk7iH2mpd19nWhDLZHBxmYhOeqM6FPYunQ0td
 f5ea/ZN19XI9GJJXvRR4jX0S5VW5MopxNRM34tctl6D7+M20BuK3Au7x0O7uy4Ft8+gr
 rCxt3R4ECRWcKLqgzmx+qqkGkcpgdpaJSEolOtwpy9pNbVEDrnT+Ineyd5MBSjicn9FK
 4BQA==
X-Gm-Message-State: AFuF++nDBUsKPoMJsa64DIT3mqS1HN88WotHz7osl4vtWaBI/qrxmaPE
 rqhEk/naeNchcZYcIILcDVKP+eO+eTCt//Cd0Csu85fmKftu4EAcD58P5hp+seukCNY3iUx1f4d
 yMpW+dY3rRIAUyCU5NBTvmmBjY/itFAY5EQYxJGVA1CGGNII84HjUUxm2mw==
X-Gm-Gg: AR+sD110HZ+FsJgalip2LD3XIVxh5y3t/op+D6ooIkLR9D+uCTrdFH1vrGMSzWOeQwK
 +EzdavFH352p/KvryJSxWjREWIdn889H7x89n3IK0MFRucqDHETdSChVNPP1hQ5jmWyIfFpTn7v
 NE8JvMpxgqv/rX/aQNk9JP+8at49AQOxojoAur71pkKYXN2auRT/2e10uQBXw4jBZvSRM1K63mf
 oizCUd9HeEve8c7j2tinFwmDnz3/HjW3EQ7iiyW7Jvhgs20dENV7UzgTjk9EO9BtKuyUqlHX5ro
 Qge+bp87DJS1vrm9+SHwFjrxGob9+hhpsWnqVW6JFIdZx96j7gexH1wdqCwp+FxdoZIYI6+q5RA
 U6BNK9P05BDb+2GKft54mefxx3/X0bHy36rpTnHrsGMt14I6aih+Pq0W+ajaFgVwRx5Ga
X-Received: by 2002:a05:6a20:3c89:b0:3d3:ae40:51e2 with SMTP id
 adf61e73a8af0-3d3ae40571bmr30072767637.22.1788199818586; 
 Mon, 31 Aug 2026 11:10:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:3c89:b0:3d3:ae40:51e2 with SMTP id
 adf61e73a8af0-3d3ae40571bmr30072693637.22.1788199817944; 
 Mon, 31 Aug 2026 11:10:17 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32b4bc05416sm17099512eec.6.2026.08.31.11.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 11:10:17 -0700 (PDT)
Message-ID: <144ee2dd-371d-4508-9cdb-be6e9c52e657@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 11:10:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/47] system/vl: add new option -target
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, anjo@rev.ng,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-34-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE8sGoz9pJcPgqDVKgWa=WbZ1eMk91u6AkEZ4BcRVyyNew@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE8sGoz9pJcPgqDVKgWa=WbZ1eMk91u6AkEZ4BcRVyyNew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE1NiBTYWx0ZWRfX3O+m+mWKXwTY
 vHcbT4xCgqbh1sm8BwzylQ8aPsb+tvVYqwbWORgxJm9ZsNpxAohrqD0IyCo0xlxrMbW7jYbfo81
 6HrNFjR3gftYNKHJicNfz0WsxhodDik=
X-Proofpoint-GUID: qRljoBV8dOuJa6AsEcMwBy10K8bjls06
X-Authority-Analysis: v=2.4 cv=CYE4Irrl c=1 sm=1 tr=0 ts=6a95c38b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=kjcY-9TC6gs_KvjyH7UA:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: qRljoBV8dOuJa6AsEcMwBy10K8bjls06
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE1NiBTYWx0ZWRfX4Ww/f6VSeADx
 MZBystj2NvKMDMJRlFeaMIKAqJKCq3HlfW3+Ebp/3C1YKBfJvc4RGVCqY/ETlTiaZDsmr3UxtPj
 Gdz3iqbxWHWeO7HG+5Fearufthp93sRCWquMKVQI3PLl+0+p0qCoRUh1OOrx9RKDl5JnTLgelnw
 59wlpBkApr/7pq9oMOSx6MbuFbmZaRhNapk/sTNisaM5HsZvYyBDqm75oLn0XQRyyttMVYY6B0e
 tyxT+dJSDj52tjofrDH9RuBypVUrhE85AhzpDTUBGxIwcQRCHj0ZYYJShWIXp+8QGSlYezLl12l
 FNwP0Na8sKfQbscT0Tfarc72NUrQNmook2HI0xoGBlR7ILry+DZQHlofeLA1qFuLBnSjLdpESKR
 Dt19+oBElpYSMy2fAJVhvRxmJRMqMqr71iOhx3cLAB0lsizIgF8k2xGT+ZR2kzA2J6NhJrhlT9+
 kXfzDzzAyYGG3vVyZKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310156
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

On 8/31/2026 5:39 AM, Yonggang Luo wrote:
> I would suggest to handle the condition and argv0 and target name
> consitencely, here is my patch summary:
> - Parse -target with QEMU_OPTION_nouserconfig, right after
>   MODULE_INIT_TARGET_INFO, because later init depends on TargetInfo.
> - target_info_qom_set_target() takes Error **errp. A name comes from
>   -target or from argv0 (qemu-system-aarch64).
> - Define SYS_EMU_TARGET_UNSPECIFIED as SYS_EMU_TARGET__MAX. Bare
>   qemu-system with no suffix and no -target binds a dummy TargetInfo.
>   qemu-system-* still selects from the argv[0] suffix.
> - -M help lists the union. Starting a real board without a target
>   errors; -M none is allowed.
> - qemu_arch_available() is true when unspecified. query-target errors
>   instead of emitting an invalid SysEmuTarget.
> - Fuzz passes TARGET_NAME instead of relying on a unique TargetInfo.
> 
> and patch is attached to replace this commit and next commit
>

For now, I'll focus the efforts on the filtering mechanism for this
series. Once we agree, we can debate the details of single-binary itself.

> 
> 
> On Sat, Aug 29, 2026 at 7:04 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com
> <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
>>
>> This commit adds a new option -target, which can be allowed to set
>> current target, or retrieve list of targets available with 'help'.
>>
>> This option is the first we need to handle, as all the rest of
>> initialization depends on it.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com
> <mailto:pierrick.bouvier@oss.qualcomm.com>>
>> ---
>>  include/qemu/target-info-qom.h |  1 +
>>  qemu-options.hx                |  8 ++++++++
>>  system/vl.c                    | 34 +++++++++++++++++++++++++++++++++-
>>  target-info-qom.c              | 33 ++++++++++++++++++++++++++++++++-
>>  4 files changed, 74 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-
> info-qom.h
>> index 91be415ed33..87f3a51ccd4 100644
>> --- a/include/qemu/target-info-qom.h
>> +++ b/include/qemu/target-info-qom.h
>> @@ -26,5 +26,6 @@ typedef struct TargetInfoQomClass {
>>  OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
>>
>>  void target_info_qom_set_target(void);
>> +void target_info_qom_set_target_from_name(const char *name);
>>
>>  #endif /* QEMU_TARGET_INFO_QOM_H */
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 562c4c2b035..68d0c1d42da 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -24,6 +24,14 @@ SRST
>>      Display version information and exit
>>  ERST
>>
>> +DEF("target", HAS_ARG, QEMU_OPTION_target, \
>> +    "-target target  selects the target architecture ('-target help'
> for list)\n",
>> +    QEMU_ARCH_ALL)
>> +SRST
>> +``-target target``
>> +    Selects target architecture ('-target help' for list)
>> +ERST
>> +
>>  DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>>      "-machine [type=]name[,prop=value[,...]]\n"
>>      "                selects emulated machine ('-machine help' for
> list)\n"
>> diff --git a/system/vl.c b/system/vl.c
>> index f7f8aabd122..60c5ce85580 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -281,6 +281,15 @@ static QemuOptsList qemu_accel_opts = {
>>      },
>>  };
>>
>> +static QemuOptsList qemu_target_opts = {
>> +    .name = "target",
>> +    .implied_opt_name = "target",
>> +    .head = QTAILQ_HEAD_INITIALIZER(qemu_target_opts.head),
>> +    .desc = {
>> +        { /* end of list */ },
>> +    },
>> +};
>> +
>>  static QemuOptsList qemu_boot_opts = {
>>      .name = "boot-opts",
>>      .implied_opt_name = "order",
>> @@ -2891,6 +2900,7 @@ void qemu_init(int argc, char **argv)
>>      qemu_add_opts(&qemu_semihosting_config_opts);
>>      qemu_add_opts(&qemu_fw_cfg_opts);
>>      qemu_add_opts(&qemu_action_opts);
>> +    qemu_add_opts(&qemu_target_opts);
>>      qemu_add_run_with_opts();
>>      module_call_init(MODULE_INIT_OPTS);
>>
>> @@ -2900,7 +2910,26 @@ void qemu_init(int argc, char **argv)
>>      os_setup_limits();
>>
>>      module_call_init(MODULE_INIT_TARGET_INFO);
>> -    target_info_qom_set_target();
>> +
>> +    /*
>> +     * Identify target: first from option, then from argv[0].
>> +     * This happens even before handling --help option, because it
> may contain
>> +     * entries that are target specific.
>> +     */
>> +    for (int idx = 1; idx < argc;) {
>> +        if (argv[idx][0] != '-') {
>> +            idx++;
>> +        } else {
>> +            const QEMUOption *popt = lookup_opt(argc, argv, &optarg,
> &idx);
>> +            if (popt->index == QEMU_OPTION_target) {
>> +                target_info_qom_set_target_from_name(optarg);
>> +                break;
>> +            }
>> +        }
>> +    }
>> +    if (!target_info()) {
>> +        target_info_qom_set_target();
>> +    }
>>
>>      module_init_info(qemu_modinfo);
>>      module_allow_arch(target_name());
>> @@ -2948,6 +2977,9 @@ void qemu_init(int argc, char **argv)
>>                  exit(1);
>>              }
>>              switch(popt->index) {
>> +            case QEMU_OPTION_target:
>> +                /* handled previously, ignore it here */
>> +                break;
>>              case QEMU_OPTION_cpu:
>>                  /* hw initialization will check this */
>>                  cpu_option = optarg;
>> diff --git a/target-info-qom.c b/target-info-qom.c
>> index 6965e4d1169..a2f506c15ef 100644
>> --- a/target-info-qom.c
>> +++ b/target-info-qom.c
>> @@ -9,6 +9,7 @@
>>  #include "qemu/osdep.h"
>>  #include "qapi/error.h"
>>  #include "qom/object.h"
>> +#include "qemu/error-report.h"
>>  #include "qemu/target-info-impl.h"
>>  #include "qemu/target-info-init.h"
>>  #include "qemu/target-info-qom.h"
>> @@ -50,6 +51,36 @@ void target_info_qom_set_target(void)
>>                                   "no target-info is available" :
>>                                   "more than one target-info is
> available");
>>      }
>> -
>>      target_info_ptr = TARGET_INFO_CLASS(targets->data)->target_info;
>>  }
>> +
>> +static void list_targets_available(void)
>> +{
>> +    printf("List of targets available:\n");
>> +    g_autoptr(GSList) targets =
> object_class_get_list_sorted(TYPE_TARGET_INFO, false);
>> +    for (GSList *elem = targets; elem; elem = elem->next) {
>> +        const TargetInfo *ti = TARGET_INFO_CLASS(elem->data)-
>>target_info;
>> +        printf("- %s\n", ti->target_name);
>> +    }
>> +}
>> +
>> +void target_info_qom_set_target_from_name(const char *name)
>> +{
>> +    if (!strcmp(name, "help")) {
>> +        list_targets_available();
>> +        exit(0);
>> +    }
>> +
>> +    g_autoptr(GSList) targets =
> object_class_get_list(TYPE_TARGET_INFO, false);
>> +    for (GSList *elem = targets; elem; elem = elem->next) {
>> +        const TargetInfo *ti = TARGET_INFO_CLASS(elem->data)-
>>target_info;
>> +        if (!strcmp(name, ti->target_name)) {
>> +            target_info_ptr = ti;
>> +            return;
>> +        }
>> +    }
>> +
>> +    error_report("target '%s' is not available", name);
>> +    list_targets_available();
>> +    exit(1);
>> +}
>> --
>> 2.43.0
>>
>>
> 
> 
> --
>          此致
> 礼
> 罗勇刚
> Yours
>     sincerely,
> Yonggang Luo


