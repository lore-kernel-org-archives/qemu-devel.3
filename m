Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F3DCD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 06:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLxEl-0008FD-Q2; Sun, 10 May 2026 02:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLxEk-0008F2-VO
 for qemu-devel@nongnu.org; Sun, 10 May 2026 02:01:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLxEj-0003ms-8S
 for qemu-devel@nongnu.org; Sun, 10 May 2026 02:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778392916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lAL2krhhqEYSA9+CZBvm4KCNTUX57xTgDRG/jLtOhUI=;
 b=ZwkVq5l6hDJRkG0h44AK23gAKt7ydyaPI2deK6CNEG/gwfFU1RFuAZUWYlmGqv7Ne9nDD+
 l4M8vA61aJSAjZbrQ0O+MmOCOVbqW7i+odxCZi6cxrJ7ENRk2WzdRcA+sF9UPqpMdbnLaw
 ARgKQ8Rdv96uX/HnR0BfcgDw1Q2p8xM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-GoJvEuwHPQWZO8alba3XPQ-1; Sun,
 10 May 2026 02:01:52 -0400
X-MC-Unique: GoJvEuwHPQWZO8alba3XPQ-1
X-Mimecast-MFC-AGG-ID: GoJvEuwHPQWZO8alba3XPQ_1778392910
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED54E180056E; Sun, 10 May 2026 06:01:49 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 915C83002D30; Sun, 10 May 2026 06:01:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RFC 25/28] ui/vnc: Use Linux key codes
From: marcandre.lureau@redhat.com
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@web.de>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org, 
 xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260509-input-v1-25-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
References: <20260509-input-v1-0-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
 <20260509-input-v1-25-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 10 May 2026 10:01:15 +0400
Message-Id: <177839287568.1301060.9018609039560333375.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=961;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bd3mWxPh4mDaJp+eUJo9ZZBxdMheLEoa8b+tzV4vQ1k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAB8uedONUI5WfK743MuZDf7khD4BdZFdIQIrX
 Jo1YJDM1/SJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagAfLgAKCRDa6OEJdZac
 5SBPD/9KTXyIfUfaXqB5OIG/wuaB1PGhQQSQXJsH7i9h4E93CwpO5blhYzarUMqGHPF8SlLeS7N
 2y4mTiV1I7PdYEGcx36tVcrVGB3rNT59HUHylXBHQuVUPP8aduBPJ1T6AsqAIKToAjXI1IH7R7F
 iU51tRgpAgBV6AM7M6CCBzxzSY/vqeoTtV5+tUUrh1UUqBFTxoQ0E48dz4eqTBD6PNlAkgf8LDR
 o14NFVLjRn4jLmCaTVSeRewXTLVXNYMxXCXDZ3UgrO4DSR0rlTTAgEFOZhbzXdAYL4LO8nWP1rJ
 oipr8sF0L1A0EmAYbKObClMGsYWpmnqdG6oFuytqIllGBG0Rq1JTuIo7woiC+3X834J3ty3r3ox
 NRx3Q2J1uB0WmT30nNPjUAhsZYTLQeDTKgjIvkfKmrsB+xTq+oarUvkMUYd0rjAhv1coLYO8X0T
 imP7ZbN/X5nRqRm3CzydpZ4wxfL5cYeQyOZ3cHBnn3q0OWAo+JnVFA1u7GZWDatBZQWzhorHUkb
 N9QSmHEGoI8WsR4f2VqQTRExpWCbmuL6psX3/ObiL1NnvXJjjGZs3LN8vqx6fKw3OvZ47b9Andx
 ppnHUGUXNAnm0pD5ASbYTMMIrQYmLeP3yqoNJU4Kgwdro1kvpopLcFNPFLnwRQmen8tqOd5ZeUN
 bfPZKi83irVZimQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 09 May 2026 19:34:37 +0900, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 940dae1a001..8ad24f82f77 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1805,13 +1806,10 @@ static void pointer_event(VncState *vs, int button_mask, int x, int y)
>      qemu_input_event_sync();
>  }
>  
> -static void press_key(VncState *vs, QKeyCode qcode)
> +static void press_key(VncState *vs, QKeyCode lnx)

Should be:

    static void press_key(VncState *vs, unsigned int lnx)

> @@ -1852,15 +1850,15 @@ static void kbd_leds(void *opaque, int ledstate)
>  
>  static void do_key_event(VncState *vs, int down, int keycode, int sym)
>  {
> -    QKeyCode qcode = qemu_input_key_number_to_qcode(keycode);
> +    QKeyCode lnx = qemu_input_key_number_to_linux(keycode);

Should be:

    unsigned int lnx = qemu_input_key_number_to_linux(keycode);

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


