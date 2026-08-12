Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52E6C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9b9-0000eP-KL; Wed, 12 Aug 2026 10:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9b4-0000Zc-On
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9az-00038U-NV
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786543576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qzDUIG74uU0vAWs3O6UiJzXkZCpT+QFFH6nho+Jwf+s=;
 b=cCCCfNYJl12Rd4Wwyhw0C+be2iIVeU5CVKqZMTvlq4c3RnLa/dpw6p/Nyplk1Qw6IDJRgv
 ffYBQLTkYhJkVvhS9LEh0qDp8xwPtrjLDadWKLA4E4ud/NEuAKmtCZ5nlL2zLooXYl5Ki7
 gpo0HTcEz42MG1tRAX4+3nxarB/8RMI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330--DpGi4_GO3GQfppwVcKp6Q-1; Wed,
 12 Aug 2026 10:06:13 -0400
X-MC-Unique: -DpGi4_GO3GQfppwVcKp6Q-1
X-Mimecast-MFC-AGG-ID: -DpGi4_GO3GQfppwVcKp6Q_1786543569
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86E091956069; Wed, 12 Aug 2026 14:06:08 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 617CD1800346; Wed, 12 Aug 2026 14:06:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 05/16] migration/hmp-cmds: Include
 'block/block-global-state.h' header
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
In-Reply-To: <20260812131147.83188-6-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
 <20260812131147.83188-6-philmd@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 18:05:43 +0400
Message-Id: <178654354338.2071945.8594195282500919.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=752;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=avTjAe/7BI6jnXIPq4SvkmL7sVh+vWS96J+jt8ykSi8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfH26eGp5BtXnsnrWfPJHx1QpoY6EglVz5PvHg
 X/ZPfXCo8GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanx9ugAKCRDa6OEJdZac
 5cXuD/4zJrg/wmHxE4iW2Vry5qFcYr1wGaYhJQErs2YAiDNQpSrSzRfkbOHUAEJXNK4rQ9uUcuO
 JgTXYV4h2z04dFEGgRppVOv5zLabh0ebR7bIknbSi0W0QzaSxWWjA6KwLm5/7rvljxxA5vwWAv6
 IzTMvqK7hlD4TpSrue0tnE4N06N5/f2upNW40fbZpq9BRHtlKlIC4Ab9NfcgVi+WL3tpS39BGpe
 8s2oyG5++JNsSRdMYt71G7mA1T6TXPBKO5BHFy2wyGGV/RCIq4/xu0HhdnOQ3cM7ZE37EczSrEf
 GV1r7yUiynrWSn7yMA+/a0v+KcFGnEPVy1d3rzYNdxUbXVk2DquhK4fxzAG6vS2oETYWUNox2bN
 DdfVSiwVx2jP4qTzq0mTk/7a9LBf8aBgjnyOR5IYNUx5KFiN6AIub1pYbiXrEVs76ZWB4dI409t
 IRG0379ocP03UFW4u+cZL/ICFpso+6zNR0CLlSymUacgdPXillp2CPNZ25TeDFaRiGNhxOCnjc5
 QJJAvlexdFH5cyNRYb8oGiCD3zD8ZFuUKoM7OUh+5lse/AWRe6wPOsKyuF1BxrXCU0nafawDCuV
 /I++FVd1YCOg4v2P96pCeOjSpG+WMN4e0H12EhzvvncPGZCbBiWo/IxV2Kg3/5VOXpW2WtqRZbS
 eDXeL3eIKvBsWxg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Wed, 12 Aug 2026 15:11:36 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> migration-hmp-cmds.c uses types / methods declared in
> "block/block-global-state.h".  Include the latter otherwise
> we get when refactoring unrelated headers:
> 
>   ../migration/migration-hmp-cmds.c:911:5: error: use of undeclared identifier 'BdrvNextIterator'
>     911 |     BdrvNextIterator it;
>         |     ^
>   ../migration/migration-hmp-cmds.c:918:15: error: call to undeclared function 'bdrv_first'
>     918 |     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
>         |               ^
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


