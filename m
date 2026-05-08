Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5897CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMyr-00064P-W2; Fri, 08 May 2026 11:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLMyf-00060q-6M
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:18:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLMyd-0003aB-0e
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778253532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ATtTb+vg+vykJJCrOjkPUj2ewX44xuBIRSAVUuv4Ryo=;
 b=bQY7UmiI7znEq5r0nOWLr6odbqL7nawsAMeC6Ubh+0iID6WySbbytQGmteysNZFUyuT7gX
 IYKNR0Rnp9gsGZ7u7LZiB7J9DjWT1VAb3JouM3u76L+ffW7U1QA4/AknCTddEW9tw5JDF0
 ouSryRc9myDlR75vJYTl78ey2H+uK3g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-2h3hemBUOVWWaODGTQ0Vxw-1; Fri,
 08 May 2026 11:18:48 -0400
X-MC-Unique: 2h3hemBUOVWWaODGTQ0Vxw-1
X-Mimecast-MFC-AGG-ID: 2h3hemBUOVWWaODGTQ0Vxw_1778253528
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7D0D1956095; Fri,  8 May 2026 15:18:47 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 876F61944B20; Fri,  8 May 2026 15:18:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 07/10] qom: add object_new_with_props_from_qdict
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20260508112429.643360-8-berrange@redhat.com>
References: <20260508112429.643360-1-berrange@redhat.com>
 <20260508112429.643360-8-berrange@redhat.com>
Date: Fri, 08 May 2026 19:18:29 +0400
Message-Id: <177825350909.389613.8952282324650958656.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=768;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=in3vxxhI2DLxxqobJIjXi1x/IpPUkNXiXLkHA5eGjbg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp/f7J9tNPHQhQMH1LEVuj/urDCJuDin9ofZjjf
 Pwu8nI1rE6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaf3+yQAKCRDa6OEJdZac
 5ZfyD/45VypXyZTGYM47swSE7AY5lctHnrwFJtdKYDLxuSjE4D7DRg59SyVZPg1rqUUPYHTP3+Y
 ufZB9cZkLlR35/1/EWJpmziwdx08QKPnrejqvXefftgkvCU7KYkU5qYcTkugP/DDu0dEYm42DZ6
 RndX/f149tSb2LyTD/ivgJ5durZP97oNouPDHxRSQItvBdtiYAs8J3/dtfcwoqxKwQHHACt1mZm
 92MhpnqT0VI1YDjICBVAw3wO/mupni9G0lD+RPV7u897pPkzOjp7/NJTpghliy2kYWVu5rt5zF6
 RMw5AxG1v/OlJt9RoddF5ce5DIcvHgwjupMO9lHKelwhoWAexBavcOQCX7KGdRrGyOEJHM5+fBz
 5Zsu3nppjcKA0MB180rRLU1RYZwVgVTgv6LWWrgw3rj2qsdvWb6e2wgyZoW6Z1rz9p7cpq0ECSa
 uz7IhSELnUo79GgVh4QfZ+d/DvOq2s1ac1MY4gXu337flBK7sBnLWYLJRZ0GECtyXqjl96uJpVB
 z/sTGkmapAUDTeYv14fbaT8QvnkKROXkmdIP9iq+W8hTgtTVAvN5cx3ECa7BDpb1GmcIn7jQBqb
 e6R49bAOgEdS9f85CBobyA0xrf3e5xt44Ka2p+X59QWM0vp89Cy/r0Ti0xbvtlyELs97qf0D24j
 P8i6ejHmn2NATYA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 08 May 2026 12:24:26 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 1b2b2702fc9..cd59f1f1718 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -700,6 +700,25 @@ Object *object_new_with_propv(const char *typename,
> [ ... skip 13 lines ... ]
> + * properties in a QDict.
> + */
> +Object *object_new_with_props_from_qdict(const char *typename,
> +                                         Object *parent,
> +                                         const char *id,
> +                                         QDict *props,

This should take a const QDict, same for the _parentless added later.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


