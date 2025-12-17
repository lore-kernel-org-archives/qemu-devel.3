Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D918CD64076
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 06:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVl2K-0004h2-VV; Wed, 17 Dec 2025 01:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1vVl2I-0004gX-6t
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 01:29:22 -0500
Received: from smtp84.cstnet.cn ([159.226.251.84] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1vVl2E-0004Sz-Oz
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 01:29:21 -0500
Received: from [192.168.0.103] (unknown [114.241.82.59])
 by APP-05 (Coremail) with SMTP id zQCowABX7A+tTUJphwTyAA--.61294S2;
 Wed, 17 Dec 2025 14:29:02 +0800 (CST)
Message-ID: <5cb9dfb6-7ab9-4c3d-9574-3a1f3e5432e3@iscas.ac.cn>
Date: Wed, 17 Dec 2025 14:29:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] Add termios2 support to ppc target
To: Luca Bonissi <qemu@bonslack.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Icenowy Zheng <uwu@icenowy.me>
References: <ab68ba71-acd1-4ef1-bdde-f72a9e8e3152@bonslack.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <ab68ba71-acd1-4ef1-bdde-f72a9e8e3152@bonslack.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABX7A+tTUJphwTyAA--.61294S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryrur1xXr4rXr1ktFy3XFb_yoW5Wr1Dpa
 4kGw15GF4DtrW3CFs3KF4YvF4Ygr1fJr4DCr1fGrW0y3WSqFyUWFn2kr4YvF1jqF1ru34a
 qFZxuw12kw4UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k2
 0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
 AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5L18JUUUUU==
X-Originating-IP: [114.241.82.59]
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.84;
 envelope-from=wangruikang@iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

As Icenowy has pointed out, there is no termios2 for ppc. The TCGETS2
constant for ppc in glibc is not actually usable in user code. However,
this gave me an idea...

On 10/31/25 21:26, Luca Bonissi wrote:
> >From 2aa0a13da0da6e3a804359f24cc1298b97cda45c Mon Sep 17 00:00:00 2001
> From: Luca Bonissi <qemu@bonslack.org>
> Date: Fri, 31 Oct 2025 13:31:36 +0100
> Subject: [PATCH 5/7] Add termios2 support to ppc target
>
> Signed-off-by: Luca Bonissi <qemu@bonslack.org>
> ---
>  linux-user/ppc/termbits.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/linux-user/ppc/termbits.h b/linux-user/ppc/termbits.h
> index eb226e0999..ae6ee8897c 100644
> --- a/linux-user/ppc/termbits.h
> +++ b/linux-user/ppc/termbits.h
> @@ -20,6 +20,28 @@ struct target_termios {
>      target_speed_t c_ospeed;               /* output speed */
>  };
>  
> +struct target_termios2 {
> +    target_tcflag_t c_iflag;               /* input mode flags */
> +    target_tcflag_t c_oflag;               /* output mode flags */
> +    target_tcflag_t c_cflag;               /* control mode flags */
> +    target_tcflag_t c_lflag;               /* local mode flags */
> +    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
> +    target_cc_t c_line;                    /* line discipline */
> +    target_speed_t c_ispeed;               /* input speed */
> +    target_speed_t c_ospeed;               /* output speed */
> +};
> +

The "nonsensical" target_termios2 here is identical to target_termios.
So, can we simply *rename* target_termios into target_termios2, and also
rename the constants like these to add a "2":

#define TARGET_TCGETS		TARGET_IOR('t', 19, struct target_termios)
#define TARGET_TCSETS		TARGET_IOW('t', 20, struct target_termios)
#define TARGET_TCSETSW		TARGET_IOW('t', 21, struct target_termios)
#define TARGET_TCSETSF		TARGET_IOW('t', 22, struct target_termios)

So that we repurpose the generic termios2 code to handle termios for
ppc? This would look like we're translating ppc guest TCGETS into host
TCGETS2, but the code would be written like it's doing a straight ppc
guest fake-TCGETS2 to host TCGETS2 translation.

Essentially, instead of thinking of ppc as "termios is different, and
there's no termios2", we can think of it as "termios2 only, no termios".
This would be ABI compatible with user programs and support the
non-standard baud rates use case that are checked in the glibc test
suite on ppc guest. 

Icenowy's suggestion [1] to fix ppc host support basically does the
corresponding thing on the ppc host side. This looks slightly less
cursed than my idea but is basically the same deal.

Some extra handling may be needed to print the correct words in syscall
trace output.

Vivian "dramforever" Wang

[1]: https://lore.kernel.org/qemu-devel/4403eb94ddbb2934f1f75d94ce921f0f1078ad9f.camel@icenowy.me/


