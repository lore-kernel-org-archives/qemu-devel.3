Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66F8CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 16:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyC3X-0002ie-IV; Mon, 15 Sep 2025 12:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1uyC3O-0002fk-Pz
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:27:48 -0400
Received: from m204-227.eu.mailgun.net ([161.38.204.227])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1uyC2i-0006EO-U6
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:27:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1757953611; x=1757960811; 
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: References:
 In-Reply-To: Message-ID: Date: Subject: Subject: Cc: To: To: From: From:
 Sender: Sender; 
 bh=4cCgfXPg/GiSGM6JuJ+mBID321dlmOy90lxpfCkneQw=;
 b=Fef/UqUJde96CbQO8+L6yvHx/uI+ilbxFBie6iW/1cuUQhcNOYoC7rgWUvi6RZFD6QYBRGrsrGc65fNvGNuLgOoK7CGofpmmKzA/OgsHLkn71D5+9zQZVJ1G11D72V7J4OyTjsFJDyLb0XYlADKEGlPw6lhcDplVitplQBhw70WzoUSzjuKHJEe9nbYNBlDUbHvdrRXldsvfBYyumx8ji94hHoVS8MKw+wOTSlcUjRxmmmDH1He2AvloXQLk6BzvyrnuH9RQbGHqBm8XHQxSvqkYkwFpDpaQ03FkU2Dy/Zc5vv+y8eajfV3rkPpwZ3cnRUZUlTSNeZsbAHM2NqHJJA==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 1359f3db7b55b86d05c746cc51c576b61417a5d3a5bbf366fd442f5a78e413fd with SMTP id
 68c83e4be845e547b324fd9b; Mon, 15 Sep 2025 16:26:51 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
From: Alessandro Ratti <alessandro@0x65c.net>
To: alex.bennee@linaro.org
Cc: alessandro.ratti@gmail.com, alessandro@0x65c.net, philmd@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: Re: [PATCH] virtio: Add function name to error messages 
Date: Mon, 15 Sep 2025 18:19:37 +0200
Message-ID: <20250915162643.44716-1-alessandro@0x65c.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <87a52wqa03.fsf@draig.linaro.org>
References: <87a52wqa03.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=161.38.204.227;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=m204-227.eu.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


> For completeness you could also fixup:
> 
>   virtio_error(vdev, "%s: %d reason unknown", __func__, pnd->reason);
> 
> for virtio-ballon. Otherwise:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thank you for your review.
I've missed that. For completeness, I've sent out a v2 that removes the
manual __func__ usage in virtio-balloon to avoid duplicate function names,
as you suggested.


Thank you for your time and consideration.

Best regards,
Alessandro Ratti


