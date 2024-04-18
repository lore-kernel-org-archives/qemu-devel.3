Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C894BC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 12:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxRGZ-00011N-GR; Thu, 18 Apr 2024 08:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marex@denx.de>) id 1rxRGU-0000ze-D3
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 08:53:23 -0400
Received: from phobos.denx.de ([2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marex@denx.de>) id 1rxRGS-0000qx-2h
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 08:53:21 -0400
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E10FC88606;
 Thu, 18 Apr 2024 14:53:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713444795;
 bh=aXlTu9n43PjlP+ztKoRn3YAP4AKQDjREGqwjd6iLUK4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TlYykysLmxC0+nX/FymjfbI5A/Mwcw1ajPoh7PP8GijgviNLBDiaozknS3+2RMHva
 4oB/OJqfpNRsgLISvTzypD3tkUBdtnvgaFJiNnO33b/EtVaHOv1SFdmJoLyFkZz/GS
 sMGAyKVRH9Z5WS99JvyD9BDS47BGn/JN/bZlcVZY4mYHKQUdzJqXh9iicHVOZjmWtN
 bIAv/N0jmQrq5j6vK4QxkL0VEUUpej3C295uFy1cCptj64CLf3uJPfqZGJkNX8fDCA
 j1zwWxFoLL8YhJh0ES/cJz3fTGrbQTTzQFtsPe7Y+1yduhOJ1Cjda+kkXFBeFAu3SJ
 NoNiS4WSmr6+A==
Message-ID: <892a0a7d-5f74-4207-90e0-e747be0b3df1@denx.de>
Date: Thu, 18 Apr 2024 14:04:11 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <fd68f7e5-11ed-4459-96ac-b4a417dc9aa0@linaro.org>
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

On 4/18/24 1:10 PM, Philippe Mathieu-Daudé wrote:
> On 27/3/24 15:48, Philippe Mathieu-Daudé wrote:
>> The Nios II target is deprecated since v8.2 in commit 9997771bc1
>> ("target/nios2: Deprecate the Nios II architecture").
>>
>> Remove:
>> - Buildsys / CI infra
>> - User emulation
>> - System emulation (10m50-ghrd & nios2-generic-nommu machines)
>> - Tests
>>
>> Cc: Marek Vasut <marex@denx.de>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thank you

