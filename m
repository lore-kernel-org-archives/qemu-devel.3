Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D3AC5DF64
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 06:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuOqA-00088y-4x; Thu, 13 Aug 2026 02:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wuOq8-00088a-Jl
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 02:22:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wuOq6-0002rZ-Kh
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 02:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786602172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NbLCeB92M+oN0DnNUQhS+lkcQrxoVw0x22qwimerLB4=;
 b=D9dL4R0i0N0hbFbicGAtvhMXL6RNae0tuVuStbSr0dnGb87NN/bK4MD/ZWV/vjZC6x8IiX
 em4Ffa7geECIr6GAzUUsEkYfK9eTEgMfSWqU0/l98rbTxVq8ZQ8xfiY/c7cs42tnL4vxIY
 CdQXT8fX9N3LXEX1wOzlY/R5R7YS52s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-CN9Pp6w4M7GdnXt61Zx02A-1; Thu,
 13 Aug 2026 02:22:36 -0400
X-MC-Unique: CN9Pp6w4M7GdnXt61Zx02A-1
X-Mimecast-MFC-AGG-ID: CN9Pp6w4M7GdnXt61Zx02A_1786602155
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C72C61800471; Thu, 13 Aug 2026 06:22:34 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7300F423; Thu, 13 Aug 2026 06:22:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 02/23] net/vhost-vdpa: Include missing 'qemu/iov.h'
 header
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowangio@gmail.com>
In-Reply-To: <20260812211708.92824-3-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
 <20260812211708.92824-3-philmd@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 10:22:28 +0400
Message-Id: <178660214824.3552881.7884123985702160626.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HNDV9dCRDDop8rWMYAmpfifWn9leTbsAF8DSY2HyGH0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfWKm5/hCZE9dsKJrTOYaN1B87wgbdjjgQZ2Pm
 x6Jxv6guriJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCan1ipgAKCRDa6OEJdZac
 5YWYD/9h3bB3qIaflmohNoxR7DAPs7RZbmShBui5Q8Erz7UcDAj0+woX6jrt6Si06iEkVeqZZhN
 QiqLhg94fJmQ1nq337G84W6uc8ust6pQttI7AtDwv2Ja01r5qVkvjOxYSmKzgjFJ7p4SwCHq2/1
 AI0wRu5YPmriNxwvcSeNmJvx71KsBNL13woRYtMUIFmrUBABAaQDpyzpuPkv1gwdm8vg0nHdHj/
 a2Jv/QROMEIWLh+3fVOctkNMFFN3ki2YaPPf5TWUzkNIQKB6pJLE/HUci0OERFhuxEiX9g+UQCA
 bOmGet33iIiTNoxpd2G8vR5ETMLZNMpJK60uoK5TO2e3xxyO4a81VORls7pXaVhb4ry+ZhnmDXH
 MruqSnr4Mj4deEt+rc4rn2cxB+6Iosunq2VseHdSHSRYZY10Ftf8F6B/9YmtK3pG0ZQVX8jDgxR
 dTGCl7F6Rt69xkdPRSgvXsE1DdqU9+zoQd1cKo7kbK1ColgAOA0FXziAyNgOsmjqUoXqpDc3vp6
 xQA7pouicsOA6EA7MZkQkWs2F4UpC3yCv4zErrl35mLN3wCym+bSdW65VZGiXDw9pYIVQmvo8zf
 wtdB8niIKnQYijikyE/igzUw6Dx3nx9CpyJCzfKQ8k7gYjA+RwyDa38MowRlkObIFBJm7x2dHrB
 M+QrasCag3VWMxA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 12 Aug 2026 23:16:46 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> vhost-vdpa.c uses methods declared in the "qemu/iov." header.
> Include it otherwise we get when refactoring unrelated headers:
> 
>   ../net/vhost-vdpa.c: In function ‘vhost_vdpa_net_load_cmd’:
>   ../net/vhost-vdpa.c:714:24: error: implicit declaration of function ‘iov_size’
>     714 |     size_t data_size = iov_size(data_sg, data_num), cmd_size;
>         |                        ^~~~~~~~
>   ../net/vhost-vdpa.c:714:24: error: nested extern declaration of ‘iov_size’
>   ../net/vhost-vdpa.c:742:5: error: implicit declaration of function ‘iov_from_buf’
>     742 |     iov_from_buf(out_cursor, 1, 0, &ctrl, sizeof(ctrl));
>         |     ^~~~~~~~~~~~
>   ../net/vhost-vdpa.c:742:5: error: nested extern declaration of ‘iov_from_buf’
>   ../net/vhost-vdpa.c:744:5: error: implicit declaration of function ‘iov_to_buf’
>     744 |     iov_to_buf(data_sg, data_num, 0,
>         |     ^~~~~~~~~~
>   ../net/vhost-vdpa.c:744:5: error: nested extern declaration of ‘iov_to_buf’
>   ../net/vhost-vdpa.c:748:5: error: implicit declaration of function ‘iov_copy’
>     748 |     iov_copy(&out, 1, out_cursor, 1, 0, cmd_size);
>         |     ^~~~~~~~
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


