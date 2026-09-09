Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71992C79FB9
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4OmF-00047f-Um; Wed, 09 Sep 2026 16:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4OmE-00047B-Ap
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4OmC-0006ut-Uy
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788985212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NTZWRYVq1kWq7QqQTqnVT1M/i/zNE+Bczam4aYbzrJo=;
 b=VoeP4GAY3Dy6XUS0cD+laetIIlSN6rbMUyTZZFPyYIJtYslfqrngyWpDILrHTcs4i3TsGI
 In0dD2D0tlC+OW5NHNwYA4HRWPmZ0t9HH8HrPst9KTB0xCaFed1DDuI6FQX4H47tO9oYh9
 zqfitjWEWbxex8VbsqEUfCCZDXk0d8o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-R0tyreGaP32bEixP8juCmA-1; Wed,
 09 Sep 2026 16:20:09 -0400
X-MC-Unique: R0tyreGaP32bEixP8juCmA-1
X-Mimecast-MFC-AGG-ID: R0tyreGaP32bEixP8juCmA_1788985208
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DAFD1955BCE; Wed,  9 Sep 2026 20:20:08 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EBAB330001A2; Wed,  9 Sep 2026 20:20:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 09/14] system: report device security status in help output
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20260909175656.1572689-10-berrange@redhat.com>
References: <20260909175656.1572689-1-berrange@redhat.com>
 <20260909175656.1572689-10-berrange@redhat.com>
Date: Thu, 10 Sep 2026 00:19:30 +0400
Message-Id: <178898517058.2613908.7284521337966872458.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=321;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7N1TGbtcUvo37KLntzEUZdMnSV/pKTzy4vTQqKJ1wYU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqob9WqVlslnhT7oIDAqgGf5x9iIBb5qcSYorN1
 Un7CggumZyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqG/VgAKCRDa6OEJdZac
 5bxID/9wWnhd2HZ9DgbbYyooMGZ3cuEn/MJzUTyrLU0fUZO/cvMCpAnZBfw+0WNggePwc0p+UZe
 FakJfgEUp8u9c1XVhgqOe2U7FIs++ewC3XPTlPPMT1V+eN9f0cdR1NA2mzF7Ue3zPG4sl3N+xfH
 LhjNoGKnTTBzBtwmY9UycVOS7nxGuQcJzZutw10480cRWY1BRyiyY9XAfU7rA0E7/3+Fk/XecXY
 z5p7GpPw4rKSv9veLaLlIZiRC9ImQz3YDFGPPJYV8hKuDXZVtOCECXfos+mWKECgZg8YLRnO2t2
 UIrXh7L2cnSn6jCV4krHEzEnbhlXbGS1tWg13kSwyx5gFcccpSfJIywdCGfyhs3JU8112Hxw6E1
 SYX2l9VJoYHBL6FCGmHjyx88JyV5uZZKoQ7ygcX3o33vW6gg4SILWliMNpukaz3L5nmOEusftBq
 1ZUwnL8CSgvzCsOMXGOExZQHub3lGEGLc1JyEtTg6lgQvXV4ykI0msqhjFe1FYTlKB0e7QWcrQl
 LTN0+Fd1WPkWd/k0mRp3llq9qoAF+nZu85a+/HWmSGo31c9lL55T6x+DwZ19qFCi3lWX9bUmNsd
 0qHkqdsy6osJR8t0Bcmo5KAm8VIRUSwpVOpqx5JTQ9XOZqv/FmQq4Wj0U1mszl4L4gc1xyORF8q
 S00bsAGoW4ZVlxQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Wed, 09 Sep 2026 18:56:51 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> When '-device help', 'device_add help' and 'info qdm' are used, report
> the security status of each device.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


