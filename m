Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128A0C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Om3-0003qQ-4A; Wed, 09 Sep 2026 16:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Om2-0003q9-4z
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Om0-0006rD-0z
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788985199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EkZUJZ8PmlyFrAysaJ9OhPHahuo7eVVpgDehYGSOKXs=;
 b=DXYK9952Rku9xutGL7ZjmtumK8Yt6dSBNzOn5Z+wYfMbRIRJgEP/U0YroN95nYS1x/8KGw
 VcBbLFdMDWqAMZ47AVPUe+q0vKi86sN5FbIKrXfxhOsfQvxwfRpghuPaxBzkUCHu9Rvwnv
 8x2Dee5oqPd3mTd+nurFYyLcUx/RwNY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-OOZRVBvuOWKnP4twCURdjg-1; Wed,
 09 Sep 2026 16:19:53 -0400
X-MC-Unique: OOZRVBvuOWKnP4twCURdjg-1
X-Mimecast-MFC-AGG-ID: OOZRVBvuOWKnP4twCURdjg_1788985193
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B79B118004A9; Wed,  9 Sep 2026 20:19:52 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB79818005B3; Wed,  9 Sep 2026 20:19:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 05/14] system: report acclerator security status in
 help output
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
In-Reply-To: <20260909175656.1572689-6-berrange@redhat.com>
References: <20260909175656.1572689-1-berrange@redhat.com>
 <20260909175656.1572689-6-berrange@redhat.com>
Date: Thu, 10 Sep 2026 00:19:30 +0400
Message-Id: <178898517055.2613908.17869724331256677914.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=291;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=euEHKVyeEEKZhGE5I/9oUiqwP/YlIcGCciDn1J1SDMg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqob9V3Uah14Wg4y6bVS53twWRVzLymEZGgsA8r
 P+iSNIygYyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqG/VQAKCRDa6OEJdZac
 5TS+EACgHOpuE6GU67kZGRffUg9RoWEpSVAI1J8EI45mGA/or57Iy6NWHdXyiuFaL2HT2xdg22W
 b9vTcHTqwr3u/F0Cew3tZWEKmpPEMbJWkFRLw0Al0+v7yh8FRlP2500dT7h88ObB6uMHTeKY4C/
 o/F+YpyPedRy+nvxublLnzi8f/N5gqhqLRaFCgFuL8dUoGEYlYXTDAa5uTgB3YvPfdZH2YDmNrO
 Q83SQ/ZpS4YnxaYTl/v4j18k7W0wNJ9lZrIS7qP5tRYt/UwszalXLW+1J7cYCd0SURMKYe2tm4M
 HIEEvdNAkUEIgwipVPfhtHl8MNBJ7gp+FnB6PM4wLBHUIUGH3GDGypI2qs8C1E7gzk29wkR2mJY
 wUL3JSKiko2GVl4v8IBgRF6ug6tez8MKRATwzwDSfKfyf0//V3cN2p/O2CuLnCIE65v7KZBNw9X
 /wGJNP8ffSIitkNdajJZUsv2D17hdfETRg//QICkFAPkFJ+hbbIsreRVvsuz9AG26I0EXmjpkJi
 AcNHP8KsmP33XATev/UWFLDmwMFmy1yeTifG54/VilohD5F3wys12ZCRajyPezsWQCUcUqwkl+f
 kS8Argci6oHo88olEowIig2kCPK9QurmKLAJbXf/LJiYFKq8TlfR5ovUoA5h0XE/VAyKuCc33dZ
 j0tGqd0cBOm9E+Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, 09 Sep 2026 18:56:47 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> When '-accel help' is given, report the security status of each
> accelerator.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


