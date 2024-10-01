Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA0BCEACEA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 17:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svgIZ-0006Ap-0T; Tue, 01 Oct 2024 13:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1svgIU-00069u-Ks
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 13:04:26 -0400
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1svgIS-0000d5-S8
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 13:04:26 -0400
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mzhzd-1s0yw615yz-00tcT4; Tue, 01 Oct 2024 19:04:19 +0200
Message-ID: <da948684-bb75-44f3-8802-e771e7abfeac@vivier.eu>
Date: Tue, 1 Oct 2024 19:04:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/2] linux-user: add openat2 support in linux-user
To: Michael Vogt <mvogt@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Vogt <michael.vogt@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <cover.1727795334.git.mvogt@redhat.com>
 <1c2c8c9db3731ed4c6fd9b10c63637c3e4caf8f5.1727795334.git.mvogt@redhat.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <1c2c8c9db3731ed4c6fd9b10c63637c3e4caf8f5.1727795334.git.mvogt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tW9glaNc5kFRgSJFcKueeeGkTbNfboF8OYklhuiBR8oZVcVySyV
 uhoa5oMreOWHlTHT2ajJfNCradSmCcj7gMJyFCgfN1uAmedPmVu/6LVyBihE4Yd2PxteyAp
 hpROvZ+74hzsxDdK7DIwj3/nU0PNVhn5r9CUUYEFoW3Z78/B4Fn6uWicNwsQaXLW4dMUXp4
 kqPbnCBt21EFg7iU/m8dA==
UI-OutboundReport: notjunk:1;M01:P0:wcOwEtzRGOE=;3PFPAveyR37NgdreYNLS8aMCQ0z
 vIIpS5Uzc4nLxftld1DkEPvYyU/G3Fu9/pIgtFCOpcPH+47IzniTreexWnV2sb4zxgkPahDEw
 2ZkQUE8gnJ5ojsarEqcDcgcfVm9QuOju5w6D5r7EPoB0eMz50xaAd+4lRPjaH4jtooWlNDHI0
 6yAf4F2qyKd/YM0lUlZsZtUBM5PYelRoqeWds7fHAu+dqhzcsaum2ij3ti1Jk9iQWqIOAG/Yw
 T0LdZz/HwtAU6H6w5wq6vcL5OhSIjuFaSU0hyAWXfgdTD3pBsFkLyNJfNMI7qFXk0oDCnq2RV
 MCEcUfsFUrCQl4jO9LM6/FET5VsRxJBqKi3W0j+A72XhXudzPv7PSpKhj4Fs6hK/0hVGCUs+z
 aCRAslYsjAvu4nKNC72lzZvVUHpdDaxYlcg3tPKZoMMYQYkHxnkc4auYO3gbgR7Y2xRwbL4yh
 CCwXI5iVF43A1iD0aR1FVpaXuJCFzT279SdwMA/EEsb3MPK2LB/ZSVXieqJDeKOp0NijoBWOE
 4lYTlMPTts5FbZj88Wrtt/ZQTtYG0xOsdyO9Rmi6HsdS7xwfDU3K/+gq1wt4viS7wJwVLzbrf
 T7gTVB0voKV5yWwiSpCVMV3e4AmUr0+CDUGe6E278lV6h92BZef5ZumloAJV1X01Y+mP30Ev4
 OQ5IMr7IAuUSvunZI2nrR9YXXd4keKEFNgePbfCgwxb1c/hEW1736j/uWOL3HJISr1TJizGnw
 nlu/qnF7b4bgnDdzIFGdzW0+LZ8EhC8aw==
Received-SPF: pass client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Le 01/10/2024 à 17:14, Michael Vogt a écrit :
> This commit adds support for the `openat2()` syscall in the
> `linux-user` userspace emulator.
> 
> It is implemented by extracting a new helper `maybe_do_fake_open()`
> out of the exiting `do_guest_openat()` and share that with the
> new `do_guest_openat2()`. Unfortunately we cannot just make
> do_guest_openat2() a superset of do_guest_openat() because the
> openat2() syscall is stricter with the argument checking and
> will return an error for invalid flags or mode combinations (which
> open()/openat() will ignore).
> 
> The implementation is similar to SYSCALL_DEFINE(openat2), i.e.
> a new `copy_struct_from_user()` is used that works the same
> as the kernels version to support backwards-compatibility
> for struct syscall argument.
> 
> Instead of including openat2.h we create a copy of `open_how`
> as `open_how_ver0` to ensure that if the structure grows we
> can log a LOG_UNIMP warning.
> 
> Note that in this commit using openat2() for a "faked" file in
> /proc will honor the "resolve" flags for
> RESOLVE_NO_{MAGIC,SYM}LINKS for path based access to /proc/self/exe
> (which is the only magic link we support for faked files).
> Note it will not catch special access via e.g. dirfd. This is not
> great but it seems similar to the exiting behavior when openat()
> is called with a dirfd to "/proc". Here too the fake file lookup
> may not catch the special file because no dirfd is used to
> determine if the path is in /proc.
> 
> Signed-off-by: Michael Vogt <mvogt@redhat.com>
> Buglink: https://github.com/osbuild/bootc-image-builder/issues/619
> ---
>   linux-user/syscall.c      | 105 +++++++++++++++++++++++++++++++++++++-
>   linux-user/syscall_defs.h |  13 +++++
>   2 files changed, 116 insertions(+), 2 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


