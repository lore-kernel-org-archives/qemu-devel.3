Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A4ACD37B5
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 06:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLxEP-00088c-R2; Sun, 10 May 2026 02:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLxEO-00088B-La
 for qemu-devel@nongnu.org; Sun, 10 May 2026 02:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLxEM-0003fj-Ls
 for qemu-devel@nongnu.org; Sun, 10 May 2026 02:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778392893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixj1vF1AGo1FaAwECSFF79oQzYhmCrz7FgbKu5Wch8k=;
 b=U0fHJ+KZpQ2S//s0F1csmbZUbBouEIbGnRJW6ghhWEi95h4aLiOoGggheF/9guTKOnoDZM
 35p5iz1ahowva5G3FYZYVXponW/l0hEMwvSWcDDbxY1Q/RmqOqO6BTk/L0fGgYPd6Zw1aY
 Z6ZOtcffw05DlMiyxCjktxx8mNRxzMQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-JKPGm1VaM0egIUmVsMc5qw-1; Sun,
 10 May 2026 02:01:27 -0400
X-MC-Unique: JKPGm1VaM0egIUmVsMc5qw-1
X-Mimecast-MFC-AGG-ID: JKPGm1VaM0egIUmVsMc5qw_1778392886
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29A6019560B5; Sun, 10 May 2026 06:01:25 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F2E218004A3; Sun, 10 May 2026 06:01:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RFC 02/28] ui/input: Remove QAPI wrappers from
 QemuInputEvent
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
In-Reply-To: <20260509-input-v1-2-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
References: <20260509-input-v1-0-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
 <20260509-input-v1-2-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 10 May 2026 10:01:15 +0400
Message-Id: <177839287566.1301060.6783840665482202851.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=682;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LPRdJOJP8wF8ondE9nUpbJJZgrXGhf9oSbF5IMTegGc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAB8tl476ExUr5BgzOhown3jRMVLpTOCjXDWta
 N07VLGZ6qGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagAfLQAKCRDa6OEJdZac
 5RAHD/0VsCiS7UOV42IZnfTU3VzHukdLko2I2jHTTDVMREP6XSTeiHh12RZw+gcZcq6fyE77HwW
 0x4NHDj1sY50lL0pK+w3X2OEwXfKjBo6acEDOkfgiBaAZi1SELpJVqL7EfIXJWThm0uuk6DkuS1
 Cnsp67qql9JEP6Ri0x3WkGphxoK8e6vx0ASE8TYsnF+oEqpeYSiHJVIHIrjYytGM74B5+uCrmSn
 /h0oauRTbsD/ewmZXSUNB/5Ax1HoAOEyU8+zJSyzzOFPhZFpYVNxXGkqhxhIFjpXIm3CloIUv2R
 +1AOMugCkc8mo11qOO3JAEG+faPbEG26A4PNyRUDgJalLxZHlAAsruKXce3EuxJ7Kox16vyOWyT
 g5b2pAriftNZqjRedFnf6kXSOEOMi4FVrCi3H8eLgCmq4nH8SxWjy8AiINQgVOiYVZnKEiVjlt4
 Ii0wwe68pjNYZ/X3dUVKRpJkluqBbSGZVctrtgU1brKO3TIqPxURzY3+M/0NhaopoGroxbOJ1AR
 WysZWgp5cAk0cv2jVvtotGshCAOf15jUKdkZfe7VhonjGMwwbbWUxTV/6Nu0InRnqoiwR8FhAN7
 R+p8CE0qn7/mhNGyeumnfBF32Buf8OQINOKDwI11mJbpRcvDPH31Z5Duw+LOdBwFXS6S3/PnjvP
 e3/z6OaNPrUlwZw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Sat, 09 May 2026 19:34:14 +0900, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:

Hi,

>
> diff --git a/ui/input.c b/ui/input.c
> index 52ab7beb942..a3ced08429e 100644
> --- a/ui/input.c
> +++ b/ui/input.c
> @@ -159,16 +159,55 @@ void qmp_input_send_event(const char *device,
> [ ... skip 30 lines ... ]
> +                g_assert_not_reached();
> +            }
> +
> +            evt.key.key.type = KEY_VALUE_KIND_QCODE;
> +            evt.key.key.u.qcode.data = code;
> +            evt.key.key = *qapi->u.key.data->key;

You are overwriting the QCODE/code with this assignment. Swap the lines?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


