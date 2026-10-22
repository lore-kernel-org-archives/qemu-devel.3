Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24B4606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XAQ8DvVZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJrcZ-0008Uw-7g; Thu, 22 Oct 2026 08:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrcT-0008NW-Kb
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJrcQ-000232-FM
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792671000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8SAVu/4rGyygaZrEUpFPxbLNf0DlryR7dYh8Ja8YdBk=;
 b=XAQ8DvVZDVMZIgQThyavxtKaHF90+P//WjOC5GPhiIACv/vUOtLLW0rquzHLGCnwh8tEW5
 MmuUEk/pb8oHcqj7vlII8hpmLcD5QS2WFhlaKjTksMXFjPe8fX6T3zQzu7gbOCnsbJFzIa
 Z/mRnMuyM3EXV5ksrRET2XG+3t1ylo4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-5-0Qq2zFOvuCIceS3vr2Ig-1; Thu,
 22 Oct 2026 12:09:51 +0000
X-MC-Unique: 5-0Qq2zFOvuCIceS3vr2Ig-1
X-Mimecast-MFC-AGG-ID: 5-0Qq2zFOvuCIceS3vr2Ig_1792670990
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8100618011C8; Thu, 22 Oct 2026 12:09:50 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 711C81956089; Thu, 22 Oct 2026 12:09:49 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] baum: send device identity and cell count on protocol
 off/on
From: marcandre.lureau@redhat.com
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com
In-Reply-To: <20261021230736.1451533-1-samuel.thibault@ens-lyon.org>
References: <20261021230736.1451533-1-samuel.thibault@ens-lyon.org>
Date: Thu, 22 Oct 2026 16:09:45 +0400
Message-Id: <179267098536.3250908.6929134299379237877.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2357;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=FApWydZRnMm7c22NQSxeGFYzcROOvccyF2pWCC+ojWM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2f0KNY2HJQVOOD6wGEWY8XWD0SlicvYEA5q5N
 AvqzkR/9puJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatn9CgAKCRDa6OEJdZac
 5fSKEACw6RxT/vPh84ZnZB4dPQ18zsZ68lNe5jvp4OJSau+HonDI6AHmey01t0OGRrhrd637f5L
 fQhpuKHJDJeV0ysk9urIVudsyCFGCibmy/bdAlDt0T+gE/sGFRhM9GtOALWcKrtZTnIwEU4zDRP
 O4nDb+XdIiIhJV3htMXSxVAVVDHvmjC3Z+Rxffps5ej8Wv3fagxdg0AIMFNwH/nH7iDt45bnDup
 cKazQphsFXxYGUoYJF5FDJFc5bxFg7GocgV5NFue5uqgHFYz3nl4iGU98IMoqUJtkih71BnqOHr
 L8gWF+uFF/NzmWJDdxhw46RtcxyfPbh31yKNm1wDTv4ZiunzOFMnUP9rr0pAN9yWpfaq9DB4WWp
 +11QfMn9xZjMeub+vS2jBgNmNM5/P64P6IGGTD7w2if0fX1O07Gg9zKSvaqebHI8Yw9E+TupkWk
 qc8Tuk2ZAqJy72ulkf7megOknqdfmILcJdI7tkZobUmunTS7JUCB+mp4ZZvPTChxN+b+rcPUZeM
 UKg5TvATeD1suTHGF2rF8S5JtYMk4l9LiVWfWZ3XXwlv1yUoWxj6nYSpJeSR3NIMwzKtpGRgC5m
 sKiWRbi4gCWCPMxncF/5gxbqk4GFZ0DREoW1mJe0kROPSMGg0hC9mjDtuITT3DWuGfxilqFnsT1
 uOjhe7zs6gfzwtg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The hardware devices do identify themselves when the driver turns the
> protocol off and on again. NVDA expects to get it.
> Message-ID: <20261021230736.1451533-1-samuel.thibault@ens-lyon.org>

Missing required Signed-off-by

> ---
>  chardev/baum.c | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/chardev/baum.c b/chardev/baum.c
> index ac1e535ba8e9..e60fb628e0ff 100644
> --- a/chardev/baum.c
> +++ b/chardev/baum.c
> @@ -97,6 +97,7 @@ struct BaumChardev {
>      brlapi_fileDescriptor brlapi_fd;
>      unsigned int x, y;
>      bool deferred_init;
> +    bool protocol_on;

reset it alongside deferred_init? or document if it's intentional

>  
>      uint8_t in_buf[BUF_SIZE];
>      uint8_t in_buf_used;
> @@ -337,13 +338,27 @@ static void baum_write_packet(BaumChardev *baum, const uint8_t *buf, int len)
>      }
>  }
>  
> +static void baum_send_cell_count(BaumChardev *baum)
> +{
> +    uint8_t cell_count[] = { BAUM_RSP_CellCount, baum->x * baum->y };
> +    baum_write_packet(baum, cell_count, sizeof(cell_count));
> +}
> +
> +static void baum_send_device_identity(BaumChardev *baum)
> +{
> +    uint8_t identity[17] = { BAUM_RSP_DeviceIdentity,
> +        'B','a','u','m',' ','V','a','r','i','o' };
> +    identity[11] = '0' + baum->x / 10;
> +    identity[12] = '0' + baum->x % 10;
> +    baum_write_packet(baum, identity, sizeof(identity));
> +}
> +
>  /* Called when the other end seems to have a wrong idea of our display size */
>  static void baum_cellCount_timer_cb(void *opaque)
>  {
>      BaumChardev *baum = BAUM_CHARDEV(opaque);
> -    uint8_t cell_count[] = { BAUM_RSP_CellCount, baum->x * baum->y };
>      DPRINTF("Timeout waiting for DisplayData, sending cell count\n");
> -    baum_write_packet(baum, cell_count, sizeof(cell_count));
> +    baum_send_cell_count(baum);
>  }
>  
>  /* Try to interpret a whole incoming packet */
> @@ -441,17 +456,18 @@ static int baum_eat_packet(BaumChardev *baum, const uint8_t *buf, int len)
>          uint8_t protocol;
>          DPRINTF("SetProtocol\n");
>          EAT(protocol);
> -        /* ignore */
> +        if (!baum->protocol_on && protocol) {

Maybe it should respond on all ->on "if (protocol)"?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


