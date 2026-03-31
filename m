Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF69109B493
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7bO2-0007B4-1t; Tue, 31 Mar 2026 11:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w7bNz-0007AS-8K; Tue, 31 Mar 2026 11:52:11 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w7bNw-0000Wi-Vl; Tue, 31 Mar 2026 11:52:11 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwA3PqKi7ctpBPpBAA--.21810S2;
 Tue, 31 Mar 2026 23:52:02 +0800 (CST)
Received: from [192.168.31.119] (unknown [222.244.182.203])
 by mail (Coremail) with SMTP id AQAAf8DwjJSg7ctp0dQHAA--.20796S2;
 Tue, 31 Mar 2026 23:52:01 +0800 (CST)
Message-ID: <02d7e299-d668-4f08-b204-edb80b648360@phytium.com.cn>
Date: Tue, 31 Mar 2026 23:51:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tests/qtest: Add attrs support to qtest server memory
 commands
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260331040659.401397-1-tangtao1634@phytium.com.cn>
 <20260331040659.401397-2-tangtao1634@phytium.com.cn>
 <CAFEAcA-mePyVgVMUy6LDC3E=3HqCyFZVWP78=gY=h_x+_nocVg@mail.gmail.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <CAFEAcA-mePyVgVMUy6LDC3E=3HqCyFZVWP78=gY=h_x+_nocVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwjJSg7ctp0dQHAA--.20796S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQALBWnKzfEFuwAAsu
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxAFyrZr47Aw4DGFW8JrW8JFb_yoW5WF1Upr
 WkJFnF9ryqyF4xXwnxGw1UX34j9r17Jw4UGrWktFyDCrs8Aw1SqryjgryY9F1DZrWfWw45
 uayDXa9xZrnxJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Peter,

On 2026/3/31 16:19, Peter Maydell wrote:
> On Tue, 31 Mar 2026 at 05:07, Tao Tang <tangtao1634@phytium.com.cn> wrote:
>> Extend qtest memory access commands to accept an optional attrs argument.
>>
>> Supported attrs:
>> - secure (x86/Arm)
>> - space=non-secure|secure|root|realm (Arm-only)
>>
>> For memory commands, parse attrs, select the corresponding AddressSpace
>> with cpu_asidx_from_attrs(), and issue accesses with the matching
>> MemTxAttrs.
>>
>> Cover scalar and bulk memory commands, including:
>> - read{b,w,l,q} / write{b,w,l,q}
>> - read / write
>> - b64read / b64write
>> - memset
>>
>> Also reject invalid attrs and excessive arguments, and document the new
>> command forms in qtest.c, and use qtest_send_memtx_error() to return
>> ERR for memory access failures.
>>
>> Preserve legacy no-attrs semantics for compatibility: those commands
>> continue to ignore MemTxResult and return OK.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> @@ -510,33 +684,38 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
>>                  strcmp(words[0], "writeq") == 0) {
>>           uint64_t addr;
>>           uint64_t value;
>> +        bool has_attrs;
>> +        MemTxResult result;
>> +        MemTxAttrs attrs;
>> +        AddressSpace *as;
>>           int ret;
>>
>>           g_assert(words[1] && words[2]);
>> +        if (words[3] && words[4]) {
>> +            qtest_send(chr, "ERR too many arguments\n");
>> +            return;
>> +        }
>>           ret = qemu_strtou64(words[1], NULL, 0, &addr);
>>           g_assert(ret == 0);
>>           ret = qemu_strtou64(words[2], NULL, 0, &value);
>>           g_assert(ret == 0);
>> +        has_attrs = words[3] != NULL;
>> +        if (!has_attrs) {
>> +            qtest_write_sized(first_cpu->as, addr,
>> +                              MEMTXATTRS_UNSPECIFIED,
>> +                              value, words[0][5]);
>> +            qtest_send(chr, "OK\n");
>> +            return;
>> +        }
> You don't need has_attrs and this if() statement at all:
> you've written qtest_parse_mem_attrs() to correctly return
> MEMTXATTRS_UNSPECIFIED for the "attrs argument is a NULL pointer"
> case, so the codepath below will handle that correctly. Similarly
> for all the other similar places below.
>
> thanks
> -- PMM


Yes. has_attrs is redundant here, so I'll fold the no-attrs case into 
the common parse&get-AS path and keep only the legacy MemTxResult 
handling difference for the no-attrs form. It will look roughly like:

         ret = qemu_strtou64(words[2], NULL, 0, &value);
         g_assert(ret == 0);
         if (!qtest_parse_mem_attrs(chr, words[3], &attrs) ||
             !qtest_get_mem_as(chr, attrs, &as)) {
             return;
         }

         result = qtest_write_sized(as, addr, attrs, value, words[0][5]);
         if (words[3] && result != MEMTX_OK) {
             qtest_send_memtx_error(chr, result);
             return;
         }
         qtest_send(chr, "OK\n");


Thanks,

Tao



