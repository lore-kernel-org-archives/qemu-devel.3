Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360A2C2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 06:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcdqU-0005Wa-EF; Mon, 05 Jan 2026 01:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1vcdqR-0005WN-1d
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 01:13:35 -0500
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1vcdqN-000562-Aa
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 01:13:34 -0500
Received: from [192.168.0.121] (unknown [114.241.82.145])
 by APP-03 (Coremail) with SMTP id rQCowADH4dh+Vltpmcx+Aw--.11847S2;
 Mon, 05 Jan 2026 14:13:18 +0800 (CST)
Message-ID: <f3ca72d8-5df3-4b20-b171-cb326a3976ae@iscas.ac.cn>
Date: Mon, 5 Jan 2026 14:13:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] linux-user: Add missing termios baud rates
To: =?UTF-8?Q?Andreas_K=2E_H=C3=BCttel?= <dilfridge@gentoo.org>,
 qemu-devel@nongnu.org
References: <20260103153239.15787-1-dilfridge@gentoo.org>
 <20260103153239.15787-8-dilfridge@gentoo.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20260103153239.15787-8-dilfridge@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADH4dh+Vltpmcx+Aw--.11847S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFWUXr48Cw47Ww4xGF4kJFb_yoWxKFg_uF
 s7AFZ5CryxGFnrKFnxtFsxCF1rt34kWa15ur9Fqrsak34fZF9Igan7GFn5uF15Xw48Zrn3
 K34j93yfXrnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbrxYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
 s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
 1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
 JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
 1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
 cSsGvfC2KfnxnUUI43ZEXa7IU8v_M3UUUUU==
X-Originating-IP: [114.241.82.145]
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.81;
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

On 1/3/26 23:25, Andreas K. Hüttel wrote:

> From: Vivian Wang <wangruikang@iscas.ac.cn>
>
> Add several missing baud rates and inputs baud rates in cflag_tbl.
>
> Add these missing definitions in termbits.h:
>
> - TARGET_BOTHER for alpha, hppa, ppc, sh4, sparc
> - TARGET_IBSHIFT for hppa, mips, ppc, sh4, sparc
> - Missing standard baud rates for hppa
>
> These are required for the glibc test tst-termios-linux.
>
> Link: https://lore.kernel.org/qemu-devel/20251203-linux-user-higher-baud-rates-v2-1-e45b35224437@iscas.ac.cn
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

I'm not sure how this kind of situations usually goes, but in case this
matters: I am OK with my patch being here.


