Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C74C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCz2I-0002im-BX; Fri, 31 May 2024 05:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sCz2F-0002iQ-TE
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:58:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sCz2D-0004y1-3t
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:58:55 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxnOpZn1lmphkCAA--.8806S3;
 Fri, 31 May 2024 17:58:49 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx08RUn1lmqzsPAA--.29780S3; 
 Fri, 31 May 2024 17:58:47 +0800 (CST)
Subject: Re: [PATCH] tests/qtest: Add numa test for loongarch system
To: Bibo Mao <maobibo@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240528082155.938586-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <62e97f41-a768-d7d4-86e9-186a6efb220a@loongson.cn>
Date: Fri, 31 May 2024 17:58:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240528082155.938586-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bx08RUn1lmqzsPAA--.29780S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF45GryfGrW7WrWfXF4DJrc_yoW5Aw13pF
 W5u3WSyFWxCF1IvwsxGF1UWr4rWrn3uF4DZF42kr18Can8Grs8Xr1xKFWFgrs7J3yvqr1f
 u3WFkrnxKaykJabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5
 WrAUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-4.299, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ÔÚ 2024/5/28 ÏÂÎç4:21, Bibo Mao Ð´µÀ:
> Add numa test case for loongarch system, it passes to run
> with command "make check-qtest".
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   tests/qtest/meson.build |  2 +-
>   tests/qtest/numa-test.c | 53 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 54 insertions(+), 1 deletion(-)

Tested-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index b98fae6a6d..12792948ff 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -140,7 +140,7 @@ qtests_hppa = ['boot-serial-test'] + \
>     (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : [])
>   
>   qtests_loongarch64 = qtests_filter + \
> -  ['boot-serial-test']
> +  ['boot-serial-test', 'numa-test']
>   
>   qtests_m68k = ['boot-serial-test'] + \
>     qtests_filter
> diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
> index 7aa262dbb9..5518f6596b 100644
> --- a/tests/qtest/numa-test.c
> +++ b/tests/qtest/numa-test.c
> @@ -265,6 +265,54 @@ static void aarch64_numa_cpu(const void *data)
>       qtest_quit(qts);
>   }
>   
> +static void loongarch64_numa_cpu(const void *data)
> +{
> +    QDict *resp;
> +    QList *cpus;
> +    QObject *e;
> +    QTestState *qts;
> +    g_autofree char *cli = NULL;
> +
> +    cli = make_cli(data, "-machine "
> +        "smp.cpus=2,smp.sockets=2,smp.cores=1,smp.threads=1 "
> +        "-numa node,nodeid=0,memdev=ram -numa node,nodeid=1 "
> +        "-numa cpu,node-id=0,socket-id=1,core-id=0,thread-id=0 "
> +        "-numa cpu,node-id=1,socket-id=0,core-id=0,thread-id=0");
> +    qts = qtest_init(cli);
> +    cpus = get_cpus(qts, &resp);
> +    g_assert(cpus);
> +
> +    while ((e = qlist_pop(cpus))) {
> +        QDict *cpu, *props;
> +        int64_t socket, core, thread, node;
> +
> +        cpu = qobject_to(QDict, e);
> +        g_assert(qdict_haskey(cpu, "props"));
> +        props = qdict_get_qdict(cpu, "props");
> +
> +        g_assert(qdict_haskey(props, "node-id"));
> +        node = qdict_get_int(props, "node-id");
> +        g_assert(qdict_haskey(props, "socket-id"));
> +        socket = qdict_get_int(props, "socket-id");
> +        g_assert(qdict_haskey(props, "core-id"));
> +        core = qdict_get_int(props, "core-id");
> +        g_assert(qdict_haskey(props, "thread-id"));
> +        thread = qdict_get_int(props, "thread-id");
> +
> +        if (socket == 0 && core == 0 && thread == 0) {
> +            g_assert_cmpint(node, ==, 1);
> +        } else if (socket == 1 && core == 0 && thread == 0) {
> +            g_assert_cmpint(node, ==, 0);
> +        } else {
> +            g_assert(false);
> +        }
> +        qobject_unref(e);
> +    }
> +
> +    qobject_unref(resp);
> +    qtest_quit(qts);
> +}
> +
>   static void pc_dynamic_cpu_cfg(const void *data)
>   {
>       QObject *e;
> @@ -593,6 +641,11 @@ int main(int argc, char **argv)
>                               aarch64_numa_cpu);
>       }
>   
> +    if (!strcmp(arch, "loongarch64")) {
> +        qtest_add_data_func("/numa/loongarch64/cpu/explicit", args,
> +                            loongarch64_numa_cpu);
> +    }
> +
>   out:
>       return g_test_run();
>   }


