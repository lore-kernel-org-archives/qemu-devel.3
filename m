Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AB9C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 02:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgZ9x-0001Cx-J8; Sun, 05 Jul 2026 22:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <17746591750@163.com>)
 id 1wgZ9v-0001Bd-CV
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 22:34:11 -0400
Received: from m16.mail.163.com ([220.197.31.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <17746591750@163.com>)
 id 1wgZ9s-0006b5-T0
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 22:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:To:From:Message-ID:Date:MIME-Version:
 Content-Type; bh=4EEJ0WmsjuwzKBYxRHztNtnGyQsc+Ilb7majJ8PQcn8=;
 b=aEvDlEqsrT8MLfnMV8SGWcYLNzjToWmEjM4W4BOA1lFGPcl0anw/UWuX/TbTKc
 cQ21gnHKK8BVNU1kye4fS9dadPq0hKtD6jX0WA2zFzQw60xudAc4iS5vL7qZ4gPy
 +J7wIhONhXet6Solk2G2HzjZsO6SDsl2A2C8l2L4Z1en4=
Received: from [10.2.10.30] (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wBXX8xdE0tqv5MrHw--.35710S2; 
 Mon, 06 Jul 2026 10:30:54 +0800 (CST)
Subject: Re: [PATCH 1/2] MAINTAINERS: update Song Gao's email address
To: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, lixianglai@loongson.cn
References: <20260703095538.3211983-1-gaosong@loongson.cn>
 <20260703095538.3211983-2-gaosong@loongson.cn>
 <a5f5c914-9e76-44a3-642d-2008c9067652@loongson.cn>
From: Song Gao <17746591750@163.com>
Message-ID: <7d30c98f-2d74-f12c-65e1-dc7d76139e45@163.com>
Date: Mon, 6 Jul 2026 10:30:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a5f5c914-9e76-44a3-642d-2008c9067652@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: _____wBXX8xdE0tqv5MrHw--.35710S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW3Xr1xur47Zr4DXrW5Wrg_yoW8CF4Upa
 yfGa1FkFy0qw1UAr1YgFyDKrnrJ395KFn7XryDt34jqr98Zw1rXr15t3WIkF97Xa4rCayj
 v3s29a4av3WDAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRbVy3UUUUU=
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: jprxlkywvzilivq6il2tof0z/xtbC0B5JUmpLE17NIQAA3V
Received-SPF: pass client-ip=220.197.31.2; envelope-from=17746591750@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, NICE_REPLY_A=-2.97, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


在 2026/7/6 上午10:27, gaosong 写道:
> 在 2026/7/3 下午5:55, Song Gao 写道:
>> Update maintainer email from gaosong@loongson.cn to
>> 17746591750@163.com and add corresponding .mailmap entries.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   .mailmap    | 1 +
>>   MAINTAINERS | 4 ++--
>>   2 files changed, 3 insertions(+), 2 deletions(-)
> Reviewed-by: Song Gao <gaosong@loongson.cn>
>
Reviwed-by:  Song Gao <17746591750@163.com>

Thanks.
Song Gao
> Thanks.
> Song Gao
>> diff --git a/.mailmap b/.mailmap
>> index 8ade2eed66..593b6c2c53 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -119,6 +119,7 @@ Roman Bolshakov <rbolshakov@ddn.com> 
>> <r.bolshakov@yadro.com>
>>   Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> 
>> <sriram.yagnaraman@est.tech>
>>   Stefan Brankovic <stefan.brankovic@syrmia.com> 
>> <stefan.brankovic@rt-rk.com.com>
>>   Stefan Weil <sw@weilnetz.de> Stefan Weil <stefan@weilnetz.de>
>> +Song Gao <17746591750@163.com> <gaosong@loongson.cn>
>>   Taylor Simpson <ltaylorsimpson@gmail.com> <tsimpson@quicinc.com>
>>   Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
>>   diff --git a/MAINTAINERS b/MAINTAINERS
>> index 97dcc78ded..ef4c3b5c5b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -280,7 +280,7 @@ F: disas/hppa.c
>>   F: tests/tcg/hppa/
>>     LoongArch TCG CPUs
>> -M: Song Gao <gaosong@loongson.cn>
>> +M: Song Gao <17746591750@163.com>
>>   S: Maintained
>>   F: target/loongarch/
>>   F: tests/docker/dockerfiles/debian-loongarch-cross.docker
>> @@ -1360,7 +1360,7 @@ F: docs/devel/hexagon-sys.rst
>>   LoongArch Machines
>>   ------------------
>>   Virt
>> -M: Song Gao <gaosong@loongson.cn>
>> +M: Song Gao <17746591750@163.com>
>>   M: Bibo Mao <maobibo@loongson.cn>
>>   R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>   S: Maintained


