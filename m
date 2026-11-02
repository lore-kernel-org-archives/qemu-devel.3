Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2333606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WvjwvOxe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNskX-0002cU-L4; Mon, 02 Nov 2026 09:11:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNsi1-0007w8-Hj
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNsi0-0005Ei-7R
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793628502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oRYFyhvztTbkAukZo7KAzMM/k2TGcsNGgppNT+XfV2o=;
 b=WvjwvOxevSq/bgltVoUiE8I3N59JVAP9lPhEa7IpVgsWtwNQOkaAWydQDfIoiUufVsqcTf
 I8I4jCKpie8052ueJa5KLfmNORaGWpfeUn1h//JtrsuduOfYOBWLtPYLE/QFuTCy6+OME1
 +2P05a6iFz+6FDNjL4Fyi/LC44zj3t0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-ifbzGeCfMVW4F7APk82Ang-1; Mon,
 02 Nov 2026 09:08:17 -0500
X-MC-Unique: ifbzGeCfMVW4F7APk82Ang-1
X-Mimecast-MFC-AGG-ID: ifbzGeCfMVW4F7APk82Ang_1793628493
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AB6119344AC; Mon,  2 Nov 2026 14:08:11 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CF589433; Mon,  2 Nov 2026 14:08:09 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 09/18] hw/arm/npcm7xx: Keep the automatic hub
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, junjie.cao@intel.com, 
 junjie.cao@linux.dev, clg@kaod.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-10-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-10-jamin_lin@aspeedtech.com>
Date: Mon, 02 Nov 2026 18:07:30 +0400
Message-Id: <179362845015.3960472.7956229698285370567.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=651;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=F1IrbKA0eXHyGj63rZO602lR1wmaDvVNygpKzIbsQX0=;
 b=owEBbAKT/ZANAwAKAdro4Ql1lpzlAcsmYgBq6JkkeaLYF+AtHQBBK7iTU+SkFbe1mwtPh4elo
 swuBjx87TyJAjIEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauiZJAAKCRDa6OEJdZac
 5SL/D/dEgMfDef1nufgtacHeM88sqlRC+DndeOTQhU+jJEmw5Jl465vxJWDG1uMDBnu9zRSiVRp
 iGwEI8+ROjB7aGGdaREGVUlaSDL44AOBVsBgrK9QywI4KydZs6E9u9nI9IPcqHaUkQgNpku5/C8
 q8pk+c9VLHEV60NjWH9Ya6YVqfjDSZjcvmJUz3aArt2tCkLHemIFPSF6FgYqOv+wGAVeGoJHks3
 +qSJR/FAknrfwg0y9zi4FYc2I3B4AWCeNY0mh+8GQCHNidCwuhmAY0X7ePAUW2hALVcYr6FyXQN
 OVrqxFvsZ8xIecbayAUjXqqqVJ5oFz1lJwoOIyB4k03s6nxMrgB/dlA4HUyaGjPJQeLoOr6+5DL
 tpUkRHegrPCLQiMqkpg363qgtkKeLMNvTifN6PqveL6TtD5rm0DAGakKYVBimKlv+sPWlYgubtv
 hVhsfcFnvNg+sAmsdwbpEclwiUtfNNEU5T9eCRCcZ3CZkDWjF1BL7+cpAm4JaY4YOa6Y40QN6uv
 0xiRH7UPu1P32e0QJFrEGzczet9k6qVatluWoEdG1eyDNLSz9lsF8qAviXZkjBwS2xNczzlFFGP
 pE3cEuae9dtzJiTw2yDqyP1YoBc/6aYdgecqa646ZGdczk7lzFoxulYYUBWxRMQNgCi/XaLDfaq
 eKQ6YpIiTytZ9
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The OHCI companion has one port, so a second device only fits behind
> the hub.
> 
> npcm7xx has no versioned machine type, so compat cannot reach it. Turn
> the property on here instead. The companion shares the EHCI bus, so
> the EHCI carries the property.
> 
> Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Message-ID: <20261102092201.1729245-10-jamin_lin@aspeedtech.com>

Place this patch before the previous one, turning the default to false.
otherwise
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


