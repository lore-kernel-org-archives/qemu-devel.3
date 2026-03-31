Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B3910F92E5
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 16:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7bhN-00018d-2v; Tue, 31 Mar 2026 12:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w7bhK-00017y-Ac; Tue, 31 Mar 2026 12:12:10 -0400
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net ([162.243.161.220])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w7bhH-0003do-Sf; Tue, 31 Mar 2026 12:12:10 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAnLaFP8stp4AxCAA--.22358S2;
 Wed, 01 Apr 2026 00:11:59 +0800 (CST)
Received: from [192.168.31.119] (unknown [222.244.182.203])
 by mail (Coremail) with SMTP id AQAAf8DwW5JI8stpr9UHAA--.16737S2;
 Wed, 01 Apr 2026 00:11:53 +0800 (CST)
Message-ID: <2b776067-fbcc-429a-ac47-dd17350f504a@phytium.com.cn>
Date: Wed, 1 Apr 2026 00:11:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tests/qtest: Add qtest-attrs-test for memory access
 attrs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260331040659.401397-1-tangtao1634@phytium.com.cn>
 <20260331040659.401397-4-tangtao1634@phytium.com.cn>
 <CAFEAcA_h+eK3TZSipQCKEFEEqZA1dFPFxYT-V2MK5h57wPDQwA@mail.gmail.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <CAFEAcA_h+eK3TZSipQCKEFEEqZA1dFPFxYT-V2MK5h57wPDQwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwW5JI8stpr9UHAA--.16737S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQALBWnKzfEFuwACss
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCrWDWrWUAF1xJrWrGw1xXwb_yoW5XFWrpF
 Z5Xana9F4DXFyxJayIqw4Uu3WYvws3ArnFvr4qq3WUArs8CryaqFWjk3W5Wr97u397X34F
 9w4qqr9rXF1qqaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.161.220;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjeumjiw.icoremail.net
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

On 2026/3/31 18:36, Peter Maydell wrote:
> On Tue, 31 Mar 2026 at 05:07, Tao Tang <tangtao1634@phytium.com.cn> wrote:
>> Add qtest-attrs-test to exercise qtest memory access commands with attrs
>> on both aarch64 and x86.
>>
>> The test covers:
>> - Arm virt,secure=on: scalar and bulk accesses across non-secure,
>>    secure, and root spaces, plus negative coverage for realm and for
>>    non-secure accesses into secure-only RAM
>> - x86 q35: normal accesses
>> - libqtest-single *_attrs shortcut wrappers
>>
>> For negative cases, use qtest_raw_cmd() to check that accesses which
>> miss the intended AddressSpace fail with ERR responses emitted via
>> qtest_send_memtx_error().
>>
>> On Arm, the test targets the virt machine's secure-only RAM window so
>> that the requested attrs must select the correct address space.
>>
>> Also wire qtest-attrs-test into the aarch64 and i386/x86_64 qtest
>> builds.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>
>> +static void G_GNUC_PRINTF(3, 4) assert_qtest_response(QTestState *qts,
>> +                                                      const char *expected,
>> +                                                      const char *fmt, ...)
>> +{
>> +    va_list ap;
>> +    g_autofree gchar *cmd = NULL;
>> +    g_autofree gchar *line = NULL;
>> +    g_auto(GStrv) response = NULL;
>> +
>> +    va_start(ap, fmt);
>> +    cmd = g_strdup_vprintf(fmt, ap);
>> +    va_end(ap);
>> +
>> +    response = qtest_raw_cmd(qts, "%s", cmd);
>> +    line = g_strjoinv(" ", response);
>> +    g_assert_cmpstr(line, ==, expected);
>> +}
>> +
>> +static void G_GNUC_PRINTF(2, 3) assert_qtest_error_prefix(QTestState *qts,
>> +                                                          const char *fmt, ...)
>> +{
>> +    va_list ap;
>> +    g_autofree gchar *cmd = NULL;
>> +    g_auto(GStrv) response = NULL;
>> +
>> +    va_start(ap, fmt);
>> +    cmd = g_strdup_vprintf(fmt, ap);
>> +    va_end(ap);
>> +
>> +    response = qtest_raw_cmd(qts, "%s", cmd);
>> +    g_assert_cmpstr(response[0], ==, "ERR");
>> +}
> These seem more generally useful and not specific to this test.
> If this is the API we want for "send a qtest command we expect
> might fail and check what it told us the error was", then we
> should define these in libqtest.

Thanks for the feedback.

These two generic error-response checking helpers will be moved to 
libqtest in V5.


> More generally, if a test case is having to use qtest_raw_cmd()
> to directly send a qtest command and parse the response for
> something, that suggests that we don't have the API for
> the "non-raw" qtest functions right.
>
> -- PMM


I'll add libqtest negative helpers for memory commands with attrs, so 
tests can check expected ERR paths without open-coding raw qtest 
protocol str, and keep qtest_raw_cmd() available for the few 
protocol-level cases that the structured API can't express.

Thanks again for your time on this series.

Tao


