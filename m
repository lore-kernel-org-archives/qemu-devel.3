Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111ACC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4OmU-0004KV-5D; Wed, 09 Sep 2026 16:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4OmS-0004Jy-7Y
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4OmQ-0006zU-Nv
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788985226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOjKUIWGS7EMXjEK4vfBh3YgWIdpDFeSEbc/YdRceKU=;
 b=H2oB4CTwUsZHq2XZDB/+8esdX84Ylg0NE8Orp3gy3DyuFH8NwD2S7mCT8pR09GtUEh4FeR
 zNHvEITFUnsdQMrYtLsjxUvWoCIloOB7SDLCtUmwJHGXcMU+yv0N3SN3cdUDSJTNXbH84Z
 ml1URtjpWbSFQiGQWEPyC+MlQvRlZDY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-1mbMezGJMOKj3SxQ11Bm2Q-1; Wed,
 09 Sep 2026 16:20:22 -0400
X-MC-Unique: 1mbMezGJMOKj3SxQ11Bm2Q-1
X-Mimecast-MFC-AGG-ID: 1mbMezGJMOKj3SxQ11Bm2Q_1788985221
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0A281800607; Wed,  9 Sep 2026 20:20:21 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C3EEA1800576; Wed,  9 Sep 2026 20:20:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 13/14] docs: expand security docs with info about
 security status
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
In-Reply-To: <20260909175656.1572689-14-berrange@redhat.com>
References: <20260909175656.1572689-1-berrange@redhat.com>
 <20260909175656.1572689-14-berrange@redhat.com>
Date: Thu, 10 Sep 2026 00:19:30 +0400
Message-Id: <178898517060.2613908.15131154996375871968.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=539;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HT4YIPDPiyhDDC4rSfv1uorbXEPVBpd/Uoh1GU2i83o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqob9W44GGIJ4A3fSppoc08th1b6DWFliaFdRgM
 FExICO7sIiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqG/VgAKCRDa6OEJdZac
 5VTGEACwmQ3+3LaR+Y+YlUcM4riSGc+cG3w18lBTftpIenacsstaLdODUYHltiNE1QSBB3qTRMF
 8TO7dPzGu1Kgc78zCT4ibBiowTvPH7YLMgY1oKChLe6sBpONoTGutrUGpVxdv5GfPTYXRvtQnvM
 devhoIbWEnLGzyAB6D3TbAxY2gBHY76YfJz7Y9GuArb9wVaiUtWHG0wnld7nfeAj1Th71a2epCm
 M5iQFm7cee4RHvEiAyq0sFFHxFZSSlowbV9QRxdHeWM/TURlS0rne8bbH2b4cdhG9Ql4y2HbObS
 ZSFpWaxwtwQjLh5E//FeZdoW8XXTGuwkjkhhbEZ4cqy3Q63ISehpPDovEEnzeqOFrmLjiRtQ1AI
 DpH04s47JCVDc2v2Zuvd9pBunV7gJE38VFVIXubZuNzjAZwSMkUzhc2i2py85DtYgXpCkY4zRhj
 nGNj2gdGhdmIVKPcUKUye72renZlDiJZ8B2sIJ5X964r8Qswfn7e0VbTpfSEt0jW3DlF3dmfVoP
 1HfTPFquDHIeNyBcJ33TfbmAlYAUwZkYJwi1Nksfh0kBwwpxzBAf2YQjkQMf6aNK7zDyK3+1QHx
 k7EjXqqL+C0qOdLDwNsgVqZD57PKl0bELN8fwCNQu//+ziaQdxt6oW7eBcnqAxbjBlgt3ABPDGR
 Btq/h6/85gp4kVg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, 09 Sep 2026 18:56:55 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> The description of virtualization vs non-virtualization use
> cases is a crude approximation of the security characteristics
> of QEMU devices.
> 
> Document how QEMU can be probed to obtain information on the
> security status of type classes, and how policies can be set
> to inform or control their usage.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


