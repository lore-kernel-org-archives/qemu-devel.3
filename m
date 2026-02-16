Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE44E7BD98
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrweG-0002pI-BE; Mon, 16 Feb 2026 06:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwaW-00054u-Kg
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwaS-0007N7-Cf
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DcRkDt70bkO+YZQKmaJcDHMEi8MiUA3/dOJCPeTuVkU=;
 b=Jnh6sMHAnKB7jCvOJxYFIMC9T6BsHl9EHaEF8e+egZfBYiW55v3mU/lYdhXv1p7IeaQi6h
 8zc30R/CI0Oo6UQz4xMhDex5VqWmdFEQi+oQ47M9iNOmHUvGPJRjrb7A6+2O0rTtd/96oZ
 fxmM7Ai2hmbPmJ07dCopGtUbpfmltwk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-5RHoLEh0MVaTojp4SucqNA-1; Mon,
 16 Feb 2026 06:16:12 -0500
X-MC-Unique: 5RHoLEh0MVaTojp4SucqNA-1
X-Mimecast-MFC-AGG-ID: 5RHoLEh0MVaTojp4SucqNA_1771240570
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F31A9195FDC6; Mon, 16 Feb 2026 11:16:09 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A12119560AD; Mon, 16 Feb 2026 11:16:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:00 +0100
Subject: [PATCH 11/85] scripts/modinfo: remove trailing ;
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-11-e676662e4514@redhat.com>
References: <20260216-audio-v1-0-e676662e4514@redhat.com>
In-Reply-To: <20260216-audio-v1-0-e676662e4514@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=821;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=jO/uS3zWPerDiKB55gGBffN+gslwk9TYddoo2IYcEn0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxOKyLebB9dbA3Yi+pm+Doa+X12WYuX0NNY/
 hGeM5Wu3TCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TgAKCRDa6OEJdZac
 5WYcD/9vGApJuOEWdD41azeS31nK7v5bhC6ySe5LF8ffctZu2LbZjH2c+AjAwHxKIYd8DtVAjR7
 za6jHia2oL32mOgpksPgZ++Vw2pGLQn4HKF6abfZUdi7juoaOqnSUeWo9ubms40NtKiYUCN6SaW
 qr9WrqxBD4tBZgRfg2mrIt1ZKn/Wle8r9fEgevNihwJV/BWuovNQOTXAK387dpurpEK/30RiNQ+
 oWrnt1qH0fccEEZQgkwwXwwdALYXxWzeokvILph2HLzGBNPiFlMTKp987XayrNjGl4Ck8DOXKDd
 AuvbSoyOXTtfZX987YM4qKp0LW7nx/IxPrNjtKB10ZoNhmp7mQ531YZrpwM+1WVy82flyBeb7t6
 nb5MhxjyzBgFmsSEmW79uZAHteuy7Hs3BQOJv90gwjpmGOzOh5R7AsSZYrZs4lmm+D+0OEULn9c
 nEg7VayUaLGHTMWdKUa21jWGFrTP9y+fXHj0vffRq0aenUgRpT2zLyrrnYOF/33mZ7E5DriktCV
 Vg0O5bWAOHVer1x+l87LGcf9LJmISkLcA3ck1lcBCwhyJt+K9A/kn+9cIot2Ez3cvFwD7jRDjmd
 uHOQ6zpFVjYlCFWVRXQ8JBWhDDYT3pONYo8klZ2qHPg0HrZ/yvRPTwZERsfOsuHIRmhLPSCp3yl
 nIdi4inmHOfbb4w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 scripts/modinfo-generate.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
index 5a8abcae5d3..83ffa4a7c52 100644
--- a/scripts/modinfo-generate.py
+++ b/scripts/modinfo-generate.py
@@ -48,7 +48,7 @@ def generate(name: str, lines: list[str], enabled: set[str]) -> Optional[set[str
             elif kind == 'opts':
                 opts.append(data)
             elif kind == 'arch':
-                arch = data;
+                arch = data
             elif kind == 'kconfig':
                 # don't add a module which dependency is not enabled
                 # in kconfig

-- 
2.53.0


