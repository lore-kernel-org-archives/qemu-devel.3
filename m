Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD07FCFC278
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 08:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0dBk-0004RI-04; Tue, 15 Oct 2024 04:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1t0dBe-0004QJ-3I; Tue, 15 Oct 2024 04:45:51 -0400
Received: from mout.kundenserver.de ([212.227.17.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1t0dBb-0007Jj-Ko; Tue, 15 Oct 2024 04:45:49 -0400
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MUGNZ-1tQmlh1WnD-00Ut7k; Tue, 15 Oct 2024 10:45:34 +0200
Message-ID: <4ca0b8b3-c670-421d-b3fa-4891e225398e@vivier.eu>
Date: Tue, 15 Oct 2024 10:45:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Emulate /proc/self/maps under mmap_lock
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20241014203441.387560-1-iii@linux.ibm.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20241014203441.387560-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rdFpC/KK9SpUMyCmLdOAasmMMI8bgvfqbLgf0VpTkIBEYxpqhud
 7UgpgH37QiE9FLxd9ntuPi4UD9BVcntyOdwq9M5oZqCvaFy4gqJ84lViv5Yr+tvMiOKQQSr
 uvIELuJx7lC2tJJyqcbU6Z2muadd90Nl8l9c3V863AS6Fedr6VHCW5EZkqpc3CxcDnTK4Fv
 iBRTf+uHIEYVtaTDjQbLg==
UI-OutboundReport: notjunk:1;M01:P0:NXJqbmh9hdY=;K8jchcEJxfZ4ibeXewDKC9QHeoG
 8xLs2HwNRjnvgqfRE1bshDCnBOOWBUpk+i+pZkODgQUOQZsKGKrfpISZEKAfMZKXG859xVedY
 S0vIYiYglGlincz8Zywr09FCxar86z6hynY7Au4YiZ0oH2UltPDJQB1+MjAvjy8x+9d/ACCPI
 KIU6Oj+w+VW30UfPQH9dNStGrvcO8oKlWgqd+K1IcisVGgNpT8duShZ9rUNCzjILvqdgE45zP
 QK1sWinz+bt3KTB2LyVUZT5HWPWvJB0TsZe1wPQFpt48CZG+dhevSnkyJZdJJAUQhdkXwTZf6
 vyGbAJ3MbqmEhc8bld9moU0+BNOCxZQK7akkc9b1bjBSQZfGZNCH85Lg6vokdYYM4Oxh1QrEH
 OApvMpSovxoRABfyw/auZBwbNpTNCexsXWS7e8Oi0NO80BZwi/C+vPtR3jJyzF4bk/pyWJ/Ka
 sZX72VGD31f/1d9LGUgPBMT54ZVCGdIZVseqHT5zY2b7FFuG97G3qvHzrNm4dkFu8CV09ODzk
 xjFjKYP0OjnDZ4WjMCD80vtVeKB7LabL5uYlWHyrezF1cw6S8O+W3g0hYUCe4m/PqDAJEc5in
 NAuTADbYs+wrVuwMUUNsOS3Yjr0+3ClcDwOCH01/iF69YK1YDWDSMG6Pf9TvF3pDeFyw52W95
 vkHWZO3sg5gTxr540AqhWL/XF7BiHnCK9mU3Rmw7cEXXweRqrsljEwT7RgoNmi4zq+e5hMxXQ
 ZfRPv7edMNiuxyKCvAYG9+boHDZGlz6PQ==
Received-SPF: pass client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Le 14/10/2024 à 22:34, Ilya Leoshkevich a écrit :
> If one thread modifies the mappings and another thread prints them,
> a situation may occur that the printer thread sees a guest mapping
> without a corresponding host mapping, leading to a crash in
> open_self_maps_2().
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 7b7a3366e142 ("linux-user: Use walk_memory_regions for open_self_maps")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   linux-user/syscall.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1354e756941..dd2ec0712b8 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8151,17 +8151,19 @@ static int open_self_maps_1(CPUArchState *env, int fd, bool smaps)
>   {
>       struct open_self_maps_data d = {
>           .ts = get_task_state(env_cpu(env)),
> -        .host_maps = read_self_maps(),
>           .fd = fd,
>           .smaps = smaps
>       };
>   
> +    mmap_lock();
> +    d.host_maps = read_self_maps();
>       if (d.host_maps) {
>           walk_memory_regions(&d, open_self_maps_2);
>           free_self_maps(d.host_maps);
>       } else {
>           walk_memory_regions(&d, open_self_maps_3);
>       }
> +    mmap_unlock();
>       return 0;
>   }
>   

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

