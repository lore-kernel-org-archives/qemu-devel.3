Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9753CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 01:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEccc-0004EI-Sm; Wed, 07 Oct 2026 21:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEccb-0004E6-Dj
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 21:08:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEccZ-000282-5a
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 21:08:33 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69810R8M1245562
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 01:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XL44DljllqN/eMC+l69ZVdArlShb6M2zdQPUGOZ9ZHE=; b=CwzmdyZdTENlgjEJ
 IHmzHk8GD9Py6GK8VQ803+FoujDDkoOAeZHWdnVlJLjFRMxMzlX9qrG0FcUmyWSy
 od7N2HpDGrNJqHqP+s11Tl4+hlX6MhBmkv52rtlUyEtqK8Dy4QiicEn+tpk/nZ6I
 FmQEHw1LRrGHOqdNWyirIko3e7CwXydUqtaJ3WEV8j3wZZB/b9Tiza3+mCRmn99a
 4GPgHoG/rTE0pH7YzVh55owPh8tRhtt63+6o3F8NFANp4+TKyiZgX10bp6Bf+YIU
 fImMy4IbAKJO86qblehBno3dRrh7kLZ3cMf3BpXnOEix2zh7dp0pT68Rvi+9D2YN
 O/86PQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3ghyc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 01:08:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3510a481ae9so9027986eec.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 18:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791421708; x=1792026508; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XL44DljllqN/eMC+l69ZVdArlShb6M2zdQPUGOZ9ZHE=;
 b=dtG6ANa/FSRLqdq6JtCOjLEvfjzMk3wERM/D3MYKeYnFT7TDWvvgV0AZb9k/A+PgYC
 BwD5nIlchg3GY7UEYqAyKzTYmGSFE2UH7FX/x+yW9HIniTSR/bUk/UsyCqRvvHdzsSu3
 yZ3qvZKFSsQIi6akpgRWwUY6HTT2vcQe3FVa57HjB6XZ4aUTsPKg/s4ZV+lnu3SDWOpu
 iNjYd9D6QUJiOSR/6Hgr81pVBj20yOw3EFGqb+Bau7aETj/mtK3bsZTp5isfb/yH2yHh
 1UE3bRXeAY0XO5CB3GPzWkNsZrXHHLIBHl7kfXN7CHXkAELWu2aphMtFSUBlPqEG+s94
 QqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791421708; x=1792026508;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XL44DljllqN/eMC+l69ZVdArlShb6M2zdQPUGOZ9ZHE=;
 b=w+voKq+LL29kpbuw8apA1Xl9k6FFXKmoDISG/Z+vE0oo661FqtgvrIA3SVrKkcxCxB
 +hfLhWzMIgrenQr9brPp0AkmVG6FenVSpc6mwqQQpebo++LWptOLmnnJYnBN97BCfWpF
 SXgBt2ZrxUvMG91zsCYJ7kNb4Nq/lPcXdYguufQMnK5wi7NsmuGaZLtyxGkpyjP+saX7
 1zYalywELIcNv0HSpHG+oTPRXPVlB83XoKqu9yZvGziZwt92ag8iloCyoREbM7dsGeuh
 XJL0UsD9sUzCHTd+uKkWd8HqIUJDmqGt6jxwGLWfypySd57AiMmUEWvt+B6SJcTPxyTk
 TgXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWXoiR1PR1ye1fat9KFeyS1Hh3xgzP2u2gJZnYisBB6mNyc5G9oszKPvRDpDREtT6oOF9goM/3n22L@nongnu.org
X-Gm-Message-State: AFuF++kJdTo5ha9rMQf1Af9GyTDZyNGMj+10vinGel7WBsrPCkcLE6Ca
 dmuHkGSV0pLGjiYkxW+mD/ryfCek0NwEnyUCWxYzZNlL/+9gGx6xQw3MmArhtb53lAxRm8LYTCw
 URNL7ab3vKGCv2efsPAJB4ezqLxfZtWw9kFkR3TQkiV6UrzPpaN6ozqpYsw==
X-Gm-Gg: AYBFou3NCWrs3JHZ2CoZNHuB2co3Si6GQlIF83SkPmBeOSEdbug3G4Gd6mHk5jRVUw3
 bGx5GAZwaie8DK2SUAodiVjg5W6g5QcPh3HK2JF8woYNc9gYRystTXQbPdRLBtkczGLG2GbqxZa
 CClkgmjT6ibeWLUsLk1r/h9bBhZu780nzU7ZQ6sfXHPjEmns80kouAIUbn/XN3JYr0g5/QLYOIS
 Jh33FQOh4wW+j4BBKbYqF0lWSQYRT8LN0sBEzHyRVNIU15JIbboEh1qwYEBt/gLb0VDf1mSBr4a
 fiyXGzPuWUYAyim24JyaNnuJPj/1HDz8A9uGwyrO3NnhU5pk7gHCF/stgslrbwk0O9dqO1fGxoP
 UAqaRx6l7GDyKLt/lwwJsSEDz7YXC0NPlOgOSxuktF0IfBCkw+X7CmyElFBoEymCpnxCzLA==
X-Received: by 2002:a05:693c:8110:b0:351:1aac:31c0 with SMTP id
 5a478bee46e88-3515dda8974mr4263075eec.17.1791421706897; 
 Wed, 07 Oct 2026 18:08:26 -0700 (PDT)
X-Received: by 2002:a05:693c:8110:b0:351:1aac:31c0 with SMTP id
 5a478bee46e88-3515dda8974mr4263032eec.17.1791421706165; 
 Wed, 07 Oct 2026 18:08:26 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515aeb5c2esm10095696eec.10.2026.10.07.18.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 18:08:25 -0700 (PDT)
Message-ID: <4eec19e6-db40-4658-b5b3-bc342473cffd@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 18:08:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] contrib/plugins/bbv.c: Allow selecting ROI
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20261007-bbv-v1-0-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
 <20261007-bbv-v1-2-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007-bbv-v1-2-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NchzRGD4 c=1 sm=1 tr=0 ts=6ac6ed0c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KkNxjLnhI8JSR-4J52UA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAwNCBTYWx0ZWRfX4ScAWItn5iWm
 Ab6SAI9HlCIUfpwLaVt7mmmVKzDKSL9w6ysVRENSfQFAjWrwdQclEf/0bCFSDaKs4A+y+yStBHC
 ynHeama2CBUJznV0pzxqRmlRegk9HZ4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAwNCBTYWx0ZWRfX+/8NNOKivLcp
 V9VHd5pDYZMXk0VbyS0OUHDDk3SV+PIN0wcjTpx9k5nyarUjo6gef+kxeoDuibe9EXCvu2mCTDN
 cp8lJeeAgn4Xsm+xYexLq/RzG8467l6s5LZrrXpxFRTFrj9L9dO2upzkUAJDei/EhxE0H0l6buX
 G/LKhpHmewr5VS0aPyGNJTSFpifmVLyXAzqY2XVpiZ6bmUUQOdA9v2Taz6Ifopxrt0AMjdtdOsj
 rxoz9Mi43Uvxk42ZBpEvsARbS/rneRscXS0nFmk11joT1bca/2PHfise7EsitQ8JsdVaWEwMA1h
 pCtwbsiU08oKLa411aNOiAFvetZUg5wpCdHRlzqr8+IIPAgoK58SiGsHMr7EGdhflarJw65EamZ
 x4PqdYmyoaDz4buV4WCC9kosAfbXaHEaKLEGAn4rIe7EoWJry5fc1Jeg/6HHPXA2JaeweBUgPSs
 0snTr0xBC+xWZZVvzcg==
X-Proofpoint-ORIG-GUID: U34y_DTxakDp__TsZAA7RCN9Ii_bxPb9
X-Proofpoint-GUID: U34y_DTxakDp__TsZAA7RCN9Ii_bxPb9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_01,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080004
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

On 10/6/2026 11:01 PM, Akihiko Odaki wrote:
> A region of interest (ROI) often excludes the program startup and exit.
> For example, a benchmark may parse a large input and then run a
> computation kernel and the former may take longer than the latter;
> basic block vectors generated for the whole execution will not properly
> represent the latter.
> 
> Add options to specify the beginning and the end of the ROI to bound
> basic block vector generation to the ROI.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  docs/about/emulation.rst |  8 +++++
>  contrib/plugins/bbv.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 86 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index c58149086cdd..0566171b517b 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -284,6 +284,14 @@ The bbv plugin allows you to generate basic block vectors for use with the
>  
>    * - Option
>      - Description
> +  * - begin=A
> +    - The virtual address of the instruction that starts basic block vector
> +      generation. Generation starts from the beginning of the execution if
> +      not specified.
> +  * - end=A
> +    - The virtual address of the instruction that ends basic block vector
> +      generation. Generation continues until the endo of the execution if

small typo here: s/endo/end

> +      not specified.
>    * - interval=N
>      - The interval to generate a basic block vector specified by the number of
>        instructions (Default: N = 100000000)
> diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
> index e5caf5d9543b..a2a779f7639e 100644
> --- a/contrib/plugins/bbv.c
> +++ b/contrib/plugins/bbv.c
> @@ -5,6 +5,8 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
> +#include <stdbool.h>
> +#include <stdint.h>
>  #include <stdio.h>
>  #include <glib.h>
>  
> @@ -26,6 +28,10 @@ static GHashTable *bbs;
>  static GRWLock bbs_lock;
>  static char *filename;
>  static struct qemu_plugin_scoreboard *vcpus;
> +static bool begin_present;
> +static uint64_t begin;
> +static bool end_present;
> +static uint64_t end;
>  static int64_t interval = 100000000;
>  
>  static void plugin_exit(void *p)
> @@ -66,6 +72,7 @@ static void vcpu_init(unsigned int vcpu_index, void *userdata)
>      Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
>  
>      vcpu_filename = g_strdup_printf("%s.%u.bb", filename, vcpu_index);
> +    vcpu->count = begin_present ? INT64_MIN : -interval;

Not sure which semantic we are trying to achieve with -interval here.

The original logic was to increment this count, until reaching interval,
after what we would reset it by using vcpu_count -= interval, to keep
the extra insn that went in after the threshold.

>      vcpu->file = fopen(vcpu_filename, "w");
>  }
>  
> @@ -102,6 +109,22 @@ static void vcpu_interval_exec(unsigned int vcpu_index, void *udata)
>      fputc('\n', vcpu->file);
>  }
>  
> +static void vcpu_begin_insn_exec(unsigned int vcpu_index, void *userdata)
> +{
> +    GHashTableIter iter;
> +    void *value;
> +
> +    g_rw_lock_reader_lock(&bbs_lock);
> +    g_hash_table_iter_init(&iter, bbs);
> +
> +    while (g_hash_table_iter_next(&iter, NULL, &value)) {
> +        qemu_plugin_u64_set(bb_count_u64(value), vcpu_index, 0);
> +    }
> +
> +    g_rw_lock_reader_unlock(&bbs_lock);
> +    qemu_plugin_u64_set(count_u64(), vcpu_index, -interval);
> +}
> +
>  static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
>  {
>      uint64_t n_insns = qemu_plugin_tb_n_insns(tb);
> @@ -119,6 +142,19 @@ static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
>      }
>      g_rw_lock_writer_unlock(&bbs_lock);
>  
> +    for (size_t idx = 0; idx < n_insns; idx++) {
> +        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
> +        uint64_t insn_vaddr = qemu_plugin_insn_vaddr(insn);
> +
> +        if (begin_present && insn_vaddr == begin) {
> +            qemu_plugin_register_vcpu_insn_exec_cb(
> +                insn, vcpu_begin_insn_exec, QEMU_PLUGIN_CB_NO_REGS, NULL);
> +        } else if (end_present && insn_vaddr == end) {
> +            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
> +                insn, QEMU_PLUGIN_INLINE_STORE_U64, count_u64(), INT64_MIN);
> +        }
> +    }
> +
>      qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
>          tb, QEMU_PLUGIN_INLINE_ADD_U64, count_u64(), n_insns);
>  
> @@ -127,7 +163,32 @@ static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
>  
>      qemu_plugin_register_vcpu_tb_exec_cond_cb(
>          tb, vcpu_interval_exec, QEMU_PLUGIN_CB_NO_REGS,
> -        QEMU_PLUGIN_COND_GE, count_u64(), interval, NULL);
> +        QEMU_PLUGIN_COND_LT, count_u64(), INT64_MIN, NULL);
> +}

is INT64_MIN used as an arbitrary large value when interpreted as
unsigned immediate? If yes, that's confusing to the reader.
It would be better to choose something like:
UINT64_MAX - 1024, and assert than no tb has more than 1024 insn.

From that and code above, it seems like we're trying to introduce a "run
forever" logic as an arbitrary big interval when using begin/end features.

Maybe it would be more obvious to use:
- leave count initialization to 0
- if using begin/end, set an arbitrary large interval (which will never
be "fullfilled" by normal execution), like UINT64_MAX - 1024.

Normal path is unmodified, and you can insert the begin/end logic
accordingly.

Maybe I missed the clever way it's supposed to work, but at this time of
the day, my brain can't see it :). Feel free to explain if I missed
anything obvious.

Regards,
Pierrick

