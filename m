Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45C1C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 12:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzbgE-0003jt-8U; Wed, 24 Apr 2024 08:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marex@denx.de>) id 1rzbg8-0003ja-Og
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:24:48 -0400
Received: from phobos.denx.de ([2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marex@denx.de>) id 1rzbg6-0002RO-7S
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:24:48 -0400
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6C1AA88732;
 Wed, 24 Apr 2024 14:24:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713961478;
 bh=zBL6N2B38S9vuAjXt9/1WLPZ4tY/SD7adXgpqaQMljM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RGTjwsTl5mXNHIyxfaAyJQryCdIyce+3Yv30P9iN3SCAXJDqD66kFG6HKYZddp07I
 a5zzut2za3Lz6zklKbq0wST5W/qbLE9yJ2nAwSw78oAH0TGwIAHBY18YDNLveomoQ7
 KNXjkxDVTWkHYR4pzRtXBdxTOBnmbCWYhfH0ZYnHYXvoJeYdA0sNj28OdwH2oLoGtd
 GjEFHMpV7S7pywcVNbIRaidAyX8UEoe1imuiIxjTE9KuMlEM9YvuJyb5TOGJVcOWt2
 KF7Rj+SLGFa1VlVoDe8krgdf8aR6/+giVmVGBmzrBRp3cpqmNY2kBttCs2Mj/84VzK
 JU64qLQDf9A0A==
Message-ID: <10b51e4b-c55b-445a-a0b3-05d0e3f6ffd7@denx.de>
Date: Wed, 24 Apr 2024 13:39:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 2/3] target/nios2: Remove the deprecated Nios
 II target
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Sandra Loosemore <sloosemore@baylibre.com>,
 Chung-Lin Tang <cltang@baylibre.com>, andrew@reenigne.org,
 Yao Qi <qiyaoltc@gmail.com>
Cc: devel@lists.libvirt.org, Laurent Vivier <laurent@vivier.eu>,
 Chris Wulff <crwulff@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20240327144806.11319-1-philmd@linaro.org>
 <20240327144806.11319-3-philmd@linaro.org>
 <fd68f7e5-11ed-4459-96ac-b4a417dc9aa0@linaro.org>
 <892a0a7d-5f74-4207-90e0-e747be0b3df1@denx.de>
 <3688d32a-a265-4d00-b698-ca2bd71d3342@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <3688d32a-a265-4d00-b698-ca2bd71d3342@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Received-SPF: pass client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01;
 envelope-from=marex@denx.de; helo=phobos.denx.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/24/24 10:50 AM, Philippe Mathieu-Daudé wrote:
> Hi Marek,
> 
> On 18/4/24 14:04, Marek Vasut wrote:
>> On 4/18/24 1:10 PM, Philippe Mathieu-Daudé wrote:
>>> On 27/3/24 15:48, Philippe Mathieu-Daudé wrote:
>>>> The Nios II target is deprecated since v8.2 in commit 9997771bc1
>>>> ("target/nios2: Deprecate the Nios II architecture").
>>>>
>>>> Remove:
>>>> - Buildsys / CI infra
>>>> - User emulation
>>>> - System emulation (10m50-ghrd & nios2-generic-nommu machines)
>>>> - Tests
>>>>
>>>> Cc: Marek Vasut <marex@denx.de>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> Thank you
> 
> Thank you for adding NiosII user emulation and the
> 10M50 board to QEMU :)
> 
> Can I use your Ack-by tag on this commit?

Acked-by: Marek Vasut <marex@denx.de>

