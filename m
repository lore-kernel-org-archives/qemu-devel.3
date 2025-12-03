Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E9AD1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQiGh-0007cM-TL; Wed, 03 Dec 2025 03:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1vQiGR-0007Wp-UH
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 03:31:15 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1vQiGK-0007YI-CF
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 03:31:06 -0500
Received: from [192.168.0.111] (unknown [114.241.82.59])
 by APP-01 (Coremail) with SMTP id qwCowAD3i8s39S9pYsHxAg--.10970S2;
 Wed, 03 Dec 2025 16:30:47 +0800 (CST)
Message-ID: <4deadc0f-db5c-4908-a2fb-6af96962ab0e@iscas.ac.cn>
Date: Wed, 3 Dec 2025 16:30:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Add missing termios baud rates
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Luca Bonissi <qemu@bonslack.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251202-linux-user-higher-baud-rates-v1-1-14c49ed2474b@iscas.ac.cn>
 <87tsy9m77l.fsf@igel.home>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <87tsy9m77l.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: qwCowAD3i8s39S9pYsHxAg--.10970S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1rKFy7Zw45Xw4xuFy8Krg_yoW8AF1kpa
 nxXr9rCrWrKFyrAr1fWw1vy3WkJr13Ar4kCFy3uw18Ka4Dur13uwnFkrWa93srJ3s5AF40
 yr18J3Z8t34qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
 82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
 C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
 MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
 IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
 87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07boDGrUUUUU=
X-Originating-IP: [114.241.82.59]
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=wangruikang@iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Andreas,

On 12/2/25 19:52, Andreas Schwab wrote:
> On Dez 02 2025, Vivian Wang wrote:
>
>> The test tst-termios-linux requires termios2, which is provided by [1].
>> After that the test failure reported in [2] should be resolved by this
>> patch.
> I still get a lot of errors with the two patches:
>
> error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:196: c_ispeed = 75, expected 1200
> error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:269: ospeed 75 ispeed 1200: kernel c_ispeed == 75, expected 1200
> error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:274: ospeed 75 ispeed 1200: kernel CIBAUD = __B0 (000000), expected __B1200 (000011)
> error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:196: c_ispeed = 9600, expected 456789
> error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:269: ospeed 9600 ispeed 456789: kernel c_ispeed == 9600, expected 456789
> error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:274: ospeed 9600 ispeed 456789: kernel CIBAUD = __B0 (000000), expected __BOTHER (010000)
> error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:196: c_ispeed = 54321, expected 1234567890
> error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:269: ospeed 54321 ispeed 1234567890: kernel c_ispeed == 54321, expected 1234567890
> error: ../sysdeps/unix/sysv/linux/tst-termios-linux.c:274: ospeed 54321 ispeed 1234567890: kernel CIBAUD = __B0 (000000), expected __BOTHER (010000)
> ...
> error: 8343 test failures
>
Thanks for catching this, and sorry for the mistake. I had apparently
had a dirty version of the test files that missed these split speed tests.

I will fix these in the next version.

Vivian "dramforever" Wang


