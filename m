Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142C0CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 13:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vESil-0001Vm-MS; Thu, 30 Oct 2025 09:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1vESij-0001Vb-2P
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:29:41 -0400
Received: from smtp233.sjtu.edu.cn ([202.120.2.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1vESiZ-0006Fq-4W
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:29:40 -0400
Received: from mta91.sjtu.edu.cn (unknown [10.118.0.91])
 by smtp233.sjtu.edu.cn (Postfix) with ESMTPS id 03A7311B8DCBD;
 Thu, 30 Oct 2025 21:29:11 +0800 (CST)
Received: from mstore136.sjtu.edu.cn (unknown [10.118.0.136])
 by mta91.sjtu.edu.cn (Postfix) with ESMTP id AA4B237C903;
 Thu, 30 Oct 2025 21:29:10 +0800 (CST)
Date: Thu, 30 Oct 2025 21:29:10 +0800 (CST)
From: Ziyang Zhang <functioner@sjtu.edu.cn>
To: richard henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, 
 Laurent Vivier <laurent@vivier.eu>, alex bennee <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>, 
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
Message-ID: <1366034969.7416052.1761830950658.JavaMail.zimbra@sjtu.edu.cn>
In-Reply-To: <0359cbb1-d6ec-4d65-9ef1-2dc9fca6c038@linaro.org>
References: <1341969682.5812455.1761115945695.JavaMail.zimbra@sjtu.edu.cn>
 <1236223604.5812631.1761116021855.JavaMail.zimbra@sjtu.edu.cn>
 <80029288-4571-4e5a-ab99-b3c5c8daf8b6@linaro.org>
 <881d4aaf-2a75-4941-869a-076334650bf7@linaro.org>
 <0359cbb1-d6ec-4d65-9ef1-2dc9fca6c038@linaro.org>
Subject: Re: [RFC PATCH V2 1/2] linux-user: add a plugin API to filter syscalls
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.120.40.100]
X-Mailer: Zimbra 10.0.14_GA_4767 (ZimbraWebClient - GC141
 (Win)/10.0.15_GA_4781)
Thread-Topic: linux-user: add a plugin API to filter syscalls
Thread-Index: ykudHTIqI1XYIPIEkBIGxaWO5ZH7iA==
Received-SPF: pass client-ip=202.120.2.233;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp233.sjtu.edu.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/28/25 19:17, Richard Henderson wrote:
>>
>> Thanks for the review.
>> Beyond the code style, are you open to accept such a functionality as part of API plugins?
>
> Yes.

Thank you for your agreement!

Considering that our ultimate goal is to enable QEMU to support all features
of Lorelei, the current syscall filter can only play a limited role.

Here are some features currently required by Lorelei:

1. We need to bypass checks such as `pageflags` in `accel/tcg/user-exec.c`.
This is because the host library may provide memory blocks to the guest
program, and these memory blocks cannot be recorded by the page tables
emulated by `qemu-user`. As a result, errors may occur when invoking syscalls
like `read/write`.

2. The `cpu_loop` should support recursive invocation and exit. This is
necessary when the host library needs to execute guest callbacks, and the
recursively invoked `cpu_loop` should be able to return after the
callback finishes.

3. Since the host library may create new threads and execute guest callbacks
within those threads, the `thread_cpu` is `NULL` when the callback is first
executed. Therefore, a mechanism is required to create a `CPUState` when
`thread_cpu` is NULL.

Do you have any suggestions about how to implement these features?

