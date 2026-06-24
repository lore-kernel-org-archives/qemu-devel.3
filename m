Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A99DCDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcIEf-00018J-Cw; Wed, 24 Jun 2026 03:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wcIEd-00017R-0n
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:41:23 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wcIEb-0000dQ-3V
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:41:22 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65O7f65H059464
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Jun 2026 16:41:06 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=hhAKbCOpv2zkXc0CoiBXXyfJIR94clyf45uwMI3Akto=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1782286866; v=1;
 b=DKgl2PuTdv101M8qSqXMNzIb6L90fopLnd5dOnlNVVXZmNp2F1DEPLd2kLoWf/yB
 C8ZzeB2F+nZBCV4hvd1tQ5E7sGu8yDHJwNcxu0A8g9ysU8K9dLKNBWyW1a2ho9WD
 xHerfZci0wCtZmaMbSz8bwbQWpqxU94TsVUxP4l1kNiwieltO/yaFQTYCmOfHJd8
 WTw0rAsRELzKeMf06JM98dBFRJfqCHjeVvC1KreSqKf9zBQNVKlS3zf0xQSLBALO
 5D5aw5K+ml1aDZvZz3VxCHf3wPeOQxDj9TFOj4ba+fpSBpbir1xGUy+GUbEQsr5n
 yVHmFpONf1sQhOMRvtTuKQ==
Message-ID: <68c31f1b-c71c-4260-a9b2-33c2bf51f3bf@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 24 Jun 2026 16:41:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/34] ui/cocoa: implement display cleanup
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
 <20260623-b4-ui-v4-20-4656aec3398d@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260623-b4-ui-v4-20-4656aec3398d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/06/23 16:44, Marc-André Lureau wrote:
> Move cbowner release from QemuCocoaAppController -dealloc to
> cocoa_display_cleanup(), since cbowner is allocated in
> cocoa_display_init() and cleanup is the symmetric teardown path.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

I confirmed the teardown won't crash with -display cocoa

Tested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

