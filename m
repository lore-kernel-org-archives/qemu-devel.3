Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02615E68145
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 08:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsGYh-0001Rd-6O; Tue, 17 Feb 2026 03:35:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vsGYe-0001R6-Oy; Tue, 17 Feb 2026 03:35:48 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vsGYb-0004ui-Eq; Tue, 17 Feb 2026 03:35:48 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61H8Y4o7076243
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 17 Feb 2026 17:35:08 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=k7zcUx7sKDLi9MNCL8sm6RJcYYsjyZ52XaZwaD6GT78=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1771317309; v=1;
 b=JmpZC2EdeB/w3myaErCgVsbS9iYpTcChJKKypP9B19ADy8oVf0EZNIFGw0NOZ257
 H5G/NmE1HpbSgBhdjYJBaIqTRmlBNZzRCZslW7Pwfzj3M3bT3z/0Io3RtOSvQs9e
 MurB+NTEFDcyjF8fKHbneGzGFMDirBMmWhkZuH0gqhu77avNZRX+Xiim0qqbcxV1
 GiGgu8amuUYuSVnsPNBjOIRXH8Q2zY13KQkWDkq/+2BcLJKcTVVPks3rlOmOFav+
 Wo96yyM8Y0tQ5f5bGndyDKMvAeULSL/9BfySyaJbw6xIwch1z+GdCLrAv8fQCcCA
 2h+Sf+RBcS1qQk/DiTrR6A==
Message-ID: <1b4d7273-b4ca-4f39-b295-706cbf36b565@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 17 Feb 2026 17:34:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/85] audio: cleanups & add a manual test
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Yodel Eldar <yodel.eldar@yodel.dev>, Thomas Huth <thuth@redhat.com>
References: <20260216-audio-v1-0-e676662e4514@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260216-audio-v1-0-e676662e4514@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2026/02/16 20:14, Marc-André Lureau wrote:
> Hi
> 
> This is the combination of the two earlier series:
> [PATCH 00/37] audio: cleanups & add a manual test
> [PATCH 00/43] audio: more cleanups (2/2 for 11.0)
> 
> Patches missing r-b trailers:
> - scripts/modinfo: use argparse
> - scripts/modinfo: make --devices optional
> - scripts/modinfo: add --skip-missing-deps
> - util: add some extra stubs for qemu modules initialization
> - tests: start manual audio backend test
> - audio: use DEFINE_TYPES
> - audio: replace type_init() with DEFINE_TYPES
> - audio: keep a strong reference on the backend
> - replay: remove dependency on audio/
> - audio: fix leak of audio capture name
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

This is a huge but nice cleanup:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

