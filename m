Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA802FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 22:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKOaw-0000fD-Ig; Tue, 05 May 2026 18:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOau-0000f1-R1
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:50:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOas-00074l-QE
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:50:24 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645LYohq3501509
 for <qemu-devel@nongnu.org>; Tue, 5 May 2026 22:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0O4Z36bO5eXhYnWa5fxyITlC4ULuCHCy6Fz05H8UqUU=; b=Cvl6W1+EG4eA+RtM
 NjJVX5moqGY1OhzMHYA8Lt4mpFJPJTsbMr2lL6SwMkFFJVYfV7JUNC+CfZlIiqUn
 wnUvBGCr/+AmY/Zs7jkkvYUAk+eK+NVNIE+WE11hgzBX5x1xQuVnveskd596prRC
 /kOqGj3WkEGX0YyQarcfIpY1sVUV+L++irQOOb4N7MeL3Mt8uJ1b7ZRoJb4pqpup
 KZ/2ff6GfRYe5HR7zdHwHQLdQlQL7CgLsGowD/3OmI2VScibtibJMq5CmnUC/1jN
 jqt6qq8ripGFOEt7nrhs8FWZTSd5+Bp1LI11+nAnxIv2zBybUCB9uVJbkZBszmox
 TV/1Og==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyhqfa2fu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 22:50:21 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ee5b73c5f2so12974434eec.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 15:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778021420; x=1778626220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0O4Z36bO5eXhYnWa5fxyITlC4ULuCHCy6Fz05H8UqUU=;
 b=e5giViQwcWRSsYxdWIj7QQHrR3sHCDT1w+WvGl7NFxeSkq+udsnRjxctHq+f3mPX3n
 lB2LMSR3bJFLZftkDd9prf/aW6fXzNluyM1NP/ovUSgkBg1xfYTRYH1keeKPmXAc5S1P
 cMBBL48PZEbKuZC0TbYVLH2GZayPEoyexkPgani+uCF6PYzODKEkGAPq40pWOGFIdWIX
 V5uPGcGYSMTpyWkdx9dPQRvFx/rl+rEOlOJxExQ1TI868KNgkdb1Bu0hhm/UGXZCu1k/
 YUSHyMotB8dyaAHcGlqZViP7lACtabg+3XHb981bHzXYxbWcUBxkxx+N3BfDQG+DF3no
 b/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778021420; x=1778626220;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0O4Z36bO5eXhYnWa5fxyITlC4ULuCHCy6Fz05H8UqUU=;
 b=YkUq9b+6QAO5XpmiWHTT19X4ZxFIeGThDmqrCZxoT0kMSu9CcX/qsFdgFTxAjmpXKh
 5Qu+GvnbVMeg2+gcEGXtI0EqlncKn8sDF01PV73TzhPE6q9+kAXAq60oGYC5A48Yk/X+
 +e/njZfR2z7p7b2ekdNBw3TMn5H6GBaarhmSyg2Q8AwIflL6afNCSaiPmd9aBEo7l8w3
 DVyVS42V7hgLUY1VJ26nHKqBk/D3we2Owc7yUcpWATmYAUeQpwpBhxSaEndRvEnFtt/l
 RB8qYQ403WhwWvXlcFiK6Nj5ufpr95wwBt0AbOA/jrv+5FpqAR/rjUz6Wwc0V+Bm5646
 v7wg==
X-Gm-Message-State: AOJu0YxlxUICWevoCbaBjrmjDvYeWeA7tgAn3orj3c6AmMxk5PtSKmqv
 iKwv6eCEqV2K9XtDFiNXwICPsMKpMcQoiQmAJj7gX2V694yBulePibumSoDm2ORMh6X5MxaxYiE
 LD1gkneIb/MY/Huag5QZp8Uo161Qf29Ae2So1XZmSfglPiiOddCFAQqRX54RltRhB1RrE
X-Gm-Gg: AeBDieumF+Z3iIyRLEhUikFGLwy+n48jkJB5ACSeVM5lcQoydhg3xSyQVXq/2xC2cjd
 DRtbiZIGZ4DJnf2fhZICluzgE00yaHwATkXuTh5rP8QtiEUGPhRsRnutway3t1I3VbC/TUTU2Xb
 TfoULTX/P608TRQJRzzgr820JU8w64ttj5QIdCBPTtbKsH2c+S3eSYA8/Fi9sGKPXz1AT/rMTzm
 sL/OFgRuP+A8fMMtGxgAzhbP8WvQoHI+9A7rFDkAMchk4xW1cubzh6inn9XmthIlqREykt2g8AK
 q8oGtbvvcKJxeKs2sQtipTWdEqoIdV62M7AB3ZuadD6AbIsT2mkbvUMS/4PuFaGndCt/7g+yET2
 iJg420XeoednhF0Kmook+y/HEFZ3uW2lMQbly1p6Q5E7DkLHdiZD7nlTxF9E6LhL2+9CjH9lcx8
 nSkX+Y2MLCxlLnuf2vWzyOTJxX
X-Received: by 2002:a05:7022:4384:b0:124:9acd:328d with SMTP id
 a92af1059eb24-1318e91762bmr596654c88.22.1778021420374; 
 Tue, 05 May 2026 15:50:20 -0700 (PDT)
X-Received: by 2002:a05:7022:4384:b0:124:9acd:328d with SMTP id
 a92af1059eb24-1318e91762bmr596644c88.22.1778021419814; 
 Tue, 05 May 2026 15:50:19 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f57057bd00sm717939eec.30.2026.05.05.15.50.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 15:50:19 -0700 (PDT)
Message-ID: <7ff5898a-3550-4c58-b3ec-ba90fbe77148@oss.qualcomm.com>
Date: Tue, 5 May 2026 15:50:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] single-binary: deduplicate target_info()
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIyMiBTYWx0ZWRfXycU3rH9DRMTD
 /HF8onIW2nvhdkzIZ+0hobT4/oJFOWMaAS+HrrkOKkzlg4JJXm2CBBJc1hr/BKS5cDfwn5OTSBx
 xRZWgbWQKXZgLctOyP4PBbciYFGUpHXrFkyIKU5/Ou/S1PfGoVi+TsvZHGdBWzbtOWDPO0OLCuF
 XnZ8M4jGCUaHrUllUWXWOdDK/BBwveMSrrtyNMJ24jzRuP0RvRBHBUMdnJgU8f9ZHSTtgAJ/VYQ
 7KxuprCPTe2qwc4lv0gxCYSoCVyIkFGQmrZKbWgQCDIChVZ4oMKJdWdYZouum0o0A3xrgRon+hz
 1tfMZniF80Co/ruzSLYGnCWJMBrfHyL5yj0Vb7zQBYnan5xUrE6WakDYwVcdtSvHGTs6/b2+twh
 0SCjvtHXNr9U9xnJMo9eXXe3XxshD9cvfDhJVVh0QUM4M4eJGO0/VTBBxRd4QazgujQq16gDBdK
 zq0SBOqwIqCrbVK5iqQ==
X-Proofpoint-ORIG-GUID: Szi143TZVofJOId_Q3SkRKMuW-VIPUt7
X-Proofpoint-GUID: Szi143TZVofJOId_Q3SkRKMuW-VIPUt7
X-Authority-Analysis: v=2.4 cv=NPvlPU6g c=1 sm=1 tr=0 ts=69fa742d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=XIzWTw6YZetuqCkg7OgA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050222
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

On 4/30/2026 1:38 PM, Pierrick Bouvier wrote:
> We are getting close to be able to link several targets in a single QEMU system
> binary, and the last obstacle on the road is to embed several TargetInfo in the
> same binary. The end result of this series is to have a single definition for
> target_info symbol.
> 
> This series adds TargetInfo types in QOM, and retrieve them dynamically(). At
> the moment, we don't deal yet with multiple TargetInfo selection, but install
> all that is needed to be able to do it easily.
> 
> Because TargetInfo data is set through class_init, it creates an issue at
> startup, where we may try to instantiate additional (unrelated) types just to
> retrieve the list of "target-info-X" types. Those other types class_init may be
> using target information, to add target specific properties for instance.
> This issue has been fixed by adding a new object_class_get_list_by_name_prefix
> that does not force instantiation of all QOM types, but only those matching a
> specific pattern. This way, we first initialize and retrieve target-info types
> before others.
> 
> An alternative would be to leave all this out of QOM, and use startup
> initializer to add them in a single list. However, because all the single-binary
> work has been using QOM where possible, it would be really sad to not use it for
> this final step. Comments are welcome!
> 
> Finally, sticking to our promise not create a special "single-binary
> configuration", the goal is to use the *exact* same codepath for normal binaries
> also. It means that even for existing system binaries, the goal will be to use
> QOM to retrieve current target, even if there is only one.
> 
> v3
> --
> 
> - fix rebase mistake for one header guard
> - remove MODULE_INIT_TARGET_INFO and introduce MODULE_INIT_QOM_EARLY, as
>   requested by Daniel
> 
> v2
> --
> 
> - fix header guards
> - introduce new module init step (MODULE_INIT_TARGET_INFO)
> - as a consequence of item above, we need to register TYPE_OBJECT before startup
> - fix xtensa core type registration using type_init instead of static ctor
> 
> Pierrick Bouvier (8):
>   qemu/module: add a new QOM_EARLY init step
>   qom/object: init OBJECT and INTERFACE type early
>   target/xtensa/core: register types using type_init
>   target-info: extract target_info() definition in target-info-init.h
>   target-info: introduce TargetInfo in QOM
>   system/vl: init module QOM_EARLY earlier than QOM
>   target-info-qom: detect target from QOM
>   target-info: replace target_info() in system-mode
> 
>  bsd-user/main.c                         |  1 +
>  configs/targets/aarch64-softmmu.c       |  6 +-
>  configs/targets/arm-softmmu.c           |  6 +-
>  include/qemu/module.h                   |  2 +
>  include/qemu/target-info-init.h         | 73 +++++++++++++++++++++++++
>  include/qemu/target-info-qom.h          | 30 ++++++++++
>  linux-user/main.c                       |  1 +
>  qemu-img.c                              |  1 +
>  qemu-io.c                               |  1 +
>  qemu-nbd.c                              |  1 +
>  qom/object.c                            |  2 +-
>  rust/hw/core/tests/tests.rs             |  1 +
>  scsi/qemu-pr-helper.c                   |  1 +
>  storage-daemon/qemu-storage-daemon.c    |  1 +
>  system/vl.c                             |  5 ++
>  target-info-qom.c                       | 35 ++++++++++++
>  target-info-stub.c                      |  6 +-
>  target/xtensa/overlay_tool.h            |  5 +-
>  tests/audio/test-audio.c                |  1 +
>  tests/qtest/bios-tables-test.c          |  1 +
>  tests/qtest/fuzz/fuzz.c                 |  1 +
>  tests/qtest/migration-test.c            |  1 +
>  tests/qtest/qos-test.c                  |  1 +
>  tests/qtest/tpm-crb-swtpm-test.c        |  1 +
>  tests/qtest/tpm-crb-test.c              |  1 +
>  tests/qtest/tpm-tis-device-swtpm-test.c |  1 +
>  tests/qtest/tpm-tis-device-test.c       |  1 +
>  tests/qtest/tpm-tis-i2c-test.c          |  1 +
>  tests/qtest/tpm-tis-swtpm-test.c        |  1 +
>  tests/qtest/tpm-tis-test.c              |  1 +
>  tests/unit/check-qom-interface.c        |  1 +
>  tests/unit/check-qom-proplist.c         |  1 +
>  tests/unit/test-authz-list.c            |  1 +
>  tests/unit/test-authz-listfile.c        |  1 +
>  tests/unit/test-authz-pam.c             |  1 +
>  tests/unit/test-authz-simple.c          |  1 +
>  tests/unit/test-char.c                  |  1 +
>  tests/unit/test-crypto-block.c          |  1 +
>  tests/unit/test-crypto-secret.c         |  1 +
>  tests/unit/test-crypto-tlscredsx509.c   |  1 +
>  tests/unit/test-crypto-tlssession.c     |  1 +
>  tests/unit/test-io-channel-buffer.c     |  1 +
>  tests/unit/test-io-channel-command.c    |  1 +
>  tests/unit/test-io-channel-file.c       |  1 +
>  tests/unit/test-io-channel-null.c       |  1 +
>  tests/unit/test-io-channel-socket.c     |  1 +
>  tests/unit/test-io-channel-tls.c        |  1 +
>  tests/unit/test-io-task.c               |  1 +
>  tests/unit/test-qdev-global-props.c     |  1 +
>  tests/unit/test-qdev.c                  |  1 +
>  tests/unit/test-smp-parse.c             |  1 +
>  tests/unit/test-throttle.c              |  1 +
>  tests/unit/test-vmstate.c               |  1 +
>  tests/unit/test-xs-node.c               |  1 +
>  tests/unit/test-yank.c                  |  1 +
>  tools/i386/qemu-vmsr-helper.c           |  1 +
>  56 files changed, 201 insertions(+), 15 deletions(-)
>  create mode 100644 include/qemu/target-info-init.h
>  create mode 100644 include/qemu/target-info-qom.h
> 

sent v4:
https://lore.kernel.org/qemu-devel/20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com

