Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A73C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZxe-0003yP-LW; Thu, 27 Aug 2026 09:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wzZxV-0003uW-50; Thu, 27 Aug 2026 09:16:00 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wzZxR-0006ba-93; Thu, 27 Aug 2026 09:15:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id DAB3280FB0;
 Thu, 27 Aug 2026 16:15:49 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:86::1:4] (unknown [2a02:6bf:8080:86::1:4])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with
 ESMTPSA id nFecXY3ZX8c0-AQvnc18K; Thu, 27 Aug 2026 16:15:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787836549;
 bh=5NdSN9ZX/StC4LuqL3BmtbWtLeNIdI7aPDWx7LolOeQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=pYuRRJE6tqbJYokTq12KSP7g7EBETBM6OYRFBQtoHW8mUL/qIOoAh0ubaJ0rUEZs5
 gc4fWdWwwFIV2rl12b1o/mqlP6N5bCLJ8U6FP9cX2AAN0weNjNLCEzZqwWLoOmb/Hf
 yTHSUFoMIqhZrmX75YD818Yc0B65mu4OD4YfQZYY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <190d2826-4053-426e-8bef-99118ee7e239@yandex-team.ru>
Date: Thu, 27 Aug 2026 16:15:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iotests: add coverage for NBD transmission commands
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
References: <20260826165747.3768674-1-den@openvz.org>
 <20260826165747.3768674-2-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260826165747.3768674-2-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 26.08.26 19:57, Denis V. Lunev wrote:
> +
> +    @contextmanager
> +    def open_nbd(self, structured=True, extended=True):
> +        h = nbd.NBD()
> +        h.set_request_structured_replies(structured)
> +        h.set_request_extended_headers(extended)
> +        h.add_meta_context('base:allocation')
> +        h.add_meta_context('qemu:allocation-depth')
> +        # Let the server, not libnbd, reject the out of range requests below
> +        h.set_strict_mode(h.get_strict_mode() &
> +                          ~(nbd.STRICT_BOUNDS | nbd.STRICT_PAYLOAD))
> +        try:
> +            h.connect_uri(nbd_uri)
> +            self.assertEqual(h.get_structured_replies_negotiated(), structured)
> +            self.assertEqual(h.get_extended_headers_negotiated(), extended)
> +            yield h
> +        finally:
> +            h.shutdown()

Why not initialize self.h = nbd.NBD() in setUp(), and call self.h.shutdown()
in tearDown()? This way we get rid of "with self.open_nbd() as h:" and
extra indent in each testcase.

-- 
Best regards,
Vladimir

