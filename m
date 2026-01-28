Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA2CD35673
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 04:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkxMd-00017s-0G; Tue, 27 Jan 2026 23:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vkxMa-0000wR-Pv
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 23:41:08 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vkxMZ-00012m-3C
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 23:41:08 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60S4evjD005813
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 28 Jan 2026 13:40:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=x6j4wgpoMQY17jfsxXXV8+z+/JYRt93w90CEV9Kkwng=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1769575259; v=1;
 b=PFKoI/kS7hsw4hLwEsGIA0V2AanZD77eJ9dRLTwwiKVTDTXYoEMySTfuO1fp9vAW
 nIlZ4CIDmdXSN/pcPld6n4Ff4vMLmLDHn1XcCYmppj8PbkXRgTAGgFIxs5cTONqb
 PW2hWU+R1aL1ahONNl68v/aAJnybXO6RlWbEJ7nIazUuXWo6Rrp/ZKzTRhV9C6Z9
 YVpRwh+KA4Y19Zo5bcKra3vRfs0+/qBS6ic7v+OH3q5JQAEcu6/ARpkUSLuoplSR
 9lNIV75F9UevEIVvH4cLA0k8mOX6iJdmpqioEdbrSO1LCjMwNb5BWpWxgCZmuV1i
 FDTpC40tHpaXDcnZ8BSGHg==
Message-ID: <ad9d2cd2-2563-4d68-bb32-13c50967ca14@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 28 Jan 2026 13:40:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/43] audio/coreaudio: replace custom logging with
 error_report
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-20-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260127182516.289834-20-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2026/01/28 3:24, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The CoreAudio backend uses its own logging infrastructure (AUD_log,
> AUD_vlog, dolog) and the AUDIO_CAP macro. This approach is inconsistent
> with the rest of QEMU and makes the output harder to filter and
> configure.
> 
> Replace the custom logging with standard QEMU error reporting:
> - Use error_report() / error_printf() for errors
> - Use warn_report() for non-fatal warnings (buffer frame size
>    adjustments)
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

