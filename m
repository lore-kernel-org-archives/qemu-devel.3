Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83B3CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGF3s-0004lo-Ez; Mon, 12 Oct 2026 08:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGF3j-0004kQ-9T
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 08:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGF3h-0007Ly-LY
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 08:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791807792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v/1/c31Aq5rNy3qIOO9d8LOueiJAD7Zc1q7yEWhdRAM=;
 b=Pd3e8hG0RBoYnf00BUz8A4oF1we8kUXwVcWofM++kLsF7K9S5GGzUQW2TGQIaysb5qnTln
 35SuNvgTQ70KPOhWsdX1VRj6M4AwSUrESLSnO//5ZE4ov5e4ZMFaRJG0nniCVAQpq58BuC
 MW6BOB+Wc+IY15i0HMJuTzPrERcTLpA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-UOXz2K0dPPW2pOJR2Mg_Pg-1; Mon,
 12 Oct 2026 12:23:09 +0000
X-MC-Unique: UOXz2K0dPPW2pOJR2Mg_Pg-1
X-Mimecast-MFC-AGG-ID: UOXz2K0dPPW2pOJR2Mg_Pg_1791807787
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CCD618011FF; Mon, 12 Oct 2026 12:23:07 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 451C441D; Mon, 12 Oct 2026 12:23:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 10/12] qmp: add chardev-window-size-changed command
From: marcandre.lureau@redhat.com
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
In-Reply-To: <20261012-console-resize-v9-10-8db78320ba81@gmail.com>
References: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
 <20261012-console-resize-v9-10-8db78320ba81@gmail.com>
Date: Mon, 12 Oct 2026 16:22:47 +0400
Message-Id: <179180776718.1821755.3050993961391794671.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2890;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QOb0ExEvAAevrC5kS1LMOgUOPbz78rr8BAKxA7hAp/8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzNEbmUAPEytymuFuQlJW2+N3tB+MC12mTit3B
 x3jNfz3KfmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaszRGwAKCRDa6OEJdZac
 5dD0D/4lWRqE96s0hA9T19RMASjkoG3+AfTlLqTPc6ANvavyvIDk33j68ASM3ql0wJ53GqSsezM
 2IE69tOh6PrY6y+khrhxOt1QV3YBTEvdNts29eYZhQ+h6iPw0+HMy0vjtGN2pEMAkUn7p1byjBY
 Itm3jKdChADHKC/iEbCgT1uVu8NrJAB5ZmUFbRN+1f3/Wn1O759IZGxqN0XAsYjqXOhbh7zY1o4
 tPWi3M04bzaeMZX5sUJ/zfFIbN6mLBbwO49cEgONcxolkOZifX2ErLgTaT4IPjDBU3b7LRvYK2d
 WDW0B/bfCGADFIQFU6M/aGASvRKFOaQzGDK2x1nvgo/DzMt/YZft2tYBLRBx/KyE0iFsaMMw47r
 1/X6/EnFmOCYsDCuSk7qDf2kZkoBWptkrmExVv7rqHaNFlaDCdtYbM7+YNLkLg05iYzg9V+LWWc
 joFkhnDuYtqw5yFDRPzSYgaIiTP08GlsxHqpQysVM9JAiHArklQNcA3ZxVCVtwoVdlqwRo2XJ6V
 IZO5gsL1L0Ke95gRduieME8aPoOUmSsxFLmbkWhN27qlKmh8LKnbpM/Hy1VeUrlwW8pN/dedMXJ
 gnYuim89AiX0lGwVvU+S4LhtL3M62qrYXsmpMg4L0KhOlEY3BJ2X1VjwsWQKrKthkXddMB4wsA7
 B9v+OKTUU8lJcjQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

> The managment software can use this command to notify QEMU about the

management

> size of the terminal connected to a chardev, QEMU can then forward this
> information to the guest if the chardev is connected to a virtio console
> device.
> 
> Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> [Filip: rename command, change documentation]
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> Message-ID: <20261012-console-resize-v9-10-8db78320ba81@gmail.com>
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 8c8386e5b51b..fe513ae9621a 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -1347,6 +1347,20 @@ bool qmp_add_client_char(int fd, bool has_skipauth, bool skipauth,
>      return true;
>  }
>  
> +void qmp_chardev_window_size_changed(const char *id, uint16_t cols,
> +                                     uint16_t rows, Error **errp)
> +{
> +    Chardev *chr;
> +
> +    chr = qemu_chr_find(id);
> +    if (chr == NULL) {
> +        error_setg(errp, "Chardev '%s' not found", id);
> +        return;
> +    }
> +
> +    qemu_chr_resize(chr, cols, rows);
> +}
> +
>  /*
>   * Add a timeout callback for the chardev (in milliseconds), return
>   * the GSource object created. Please use this to add timeout hook for
> diff --git a/qapi/char.json b/qapi/char.json
> index 7ae67eedff8e..842e00319488 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -862,6 +862,37 @@
>  { 'command': 'chardev-send-break',
>    'data': { 'id': 'str' } }
>  
> +##
> +# @chardev-window-size-changed:
> +#
> +# Notifies a chardev about the current size of the terminal connected
> +# to this chardev.  The information will be forwarded to the guest if
> +# the chardev is connected to a virtio console device.
> +#
> +# The initial size is 0x0, which should be interpreted as an unknown
> +# size.
> +#
> +# Some backends detect the terminal size automatically, in which case
> +# the size may unpredictably revert to the detected one at any time.
> +#
> +# @id: the chardev's ID
> +#
> +# @cols: the number of columns
> +#
> +# @rows: the number of rows
> +#
> +# Since: 11.2
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "chardev-window-size-changed", "arguments": { "id": "foo", "cols": 80, "rows": 24 } }
> +#     <- { "return": {} }
> +##
> +{ 'command': 'chardev-window-size-changed',
> +  'data': { 'id': 'str',
> +            'cols': 'uint16',
> +            'rows': 'uint16' } }
> +
>  ##
>  # @VSERPORT_CHANGE:
>  #     Emitted when the guest opens or closes a virtio-serial port.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


