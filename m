Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DA3CD98CF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQHZ-0005lb-Ha; Wed, 10 Jun 2026 17:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQH8-0004hu-J8
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQH2-0006xg-7a
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bok2mww4XqC04KeZBDBQ+FmH/6iSu9mJoAIfO3tDkCQ=;
 b=iWxGuJT52LV5dvb3e2V7qateAUx6I6AGBT8yLqVsz3n1yxw8Dcns22gJC6bCRc9VFbNAVe
 IFfBrukPy6A4Z/5j1NiUJZXDEUAd7lhbwWQDqvQQ7et9IUv01k9GVKXsbrKdOLTBmxjvX8
 e6OKsNTzs5frmhbzH7GGKRvWGMbWbI4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-QG8og_i6PRabOe7pVk-OOw-1; Wed,
 10 Jun 2026 17:15:39 -0400
X-MC-Unique: QG8og_i6PRabOe7pVk-OOw-1
X-Mimecast-MFC-AGG-ID: QG8og_i6PRabOe7pVk-OOw_1781126137
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2B17188EB65; Wed, 10 Jun 2026 21:15:37 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B4D2F3008B36; Wed, 10 Jun 2026 21:15:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 20/35] monitor: drop unused monitor_is_qmp method
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260610123415.2883603-21-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-21-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600363.209622.5927278200403911938.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=283;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=z28vsgZiWN2QZPmA/uXx7UoZGTMvkIZzd3NjcQR5BBM=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGop04LI/ECtHz1XSVLfBWqhGVycG6DQNAm/yDPvkC+hatLqT
 IkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqKdOCAAoJENro4Ql1lpzlSZMP/AsY
 jNLLFima8/yHnYdFjbMTOdp6OK94bOH9zhRjD+f0cY3oiiqicw+jGduqNvfbkZjVOY9r361UHGl
 B9AaFdRooXlJrNrY1rLiGMrpF68xrIk2ogTM6HQ+6dD3mSYOtAjmWxazrREVjc9+8PxZqIIdmnN
 Au/nPpt6O8Nn8qGLQm/zodmCp/qEFnumE/ikC22MJGwX1O/sCAA8mXhw/XnqtFPpdprFv2+8SHo
 tIBViDfA5k5Y+erWOhTEx7E/iGADnk32fGHEAKVAd3Kmpraw+dm5itHeZ05oV38mx3pymFPNOnd
 tmofELhwKREkoQ5SyNHLGMfSejUDlPBlDQlIJghYAEffD7BazYHKUPHlO1dbsFPn1iRqawPNOy3
 zAzUAL+6ZdVHxQshWvLlPBlEHHXTzbz6uIin7B/WXJDsqsfxcEjGaGY+e1y1/rX5O7QOFnulODQ
 oa5pJWTRz6FyK+Rfn4tboBHru9YL2ZNQEkE9Z6mYUl5CPMPFo0av3dJDw+IIpcvI/J13jnIK7wi
 jqFL7kpGZP79eDB579NvFzOV23mnF4JXZfn8unvrJr6c4HwUqd1ifELygsYak0YC9X1kPLo2kC9
 0N0oM+nXkF+GIoZKQMC9eGf4pgdxGq0P6UwIyaKpfN1hxTJYrq+UYTnfR2NnZ/chvtoOiUxKyNh
 bgToX
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

On Wed, 10 Jun 2026 13:34:00 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> The previous patch dropped the only remaining use of
> monitor_is_qmp.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


