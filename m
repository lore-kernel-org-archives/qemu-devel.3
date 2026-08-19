Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4D5C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhQh-0007IS-CT; Wed, 19 Aug 2026 10:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwhQS-00077K-Q5
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwhQQ-0004yN-FV
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787150272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ttaXirmzPa+aWwS7B2UxUXZy8nxtN9GfM5w1E1BM4oA=;
 b=OiunxkecrJ+dHKi3WxFB+F09k610/RyCCT3SneJwQrrpqYzX9fJ9wTzB9N9qzw3CftHrS9
 jw2KdE8qovLwiWuVQmVrRMvLlsGH95P3U/S6/rU37XnfriWkA42cL0PI38DD8E8XTYNPjF
 eaDZgVaXsTY5K/olUimOepaXDZAF0M0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-FijkyYWfMAOXCHr80iWfCg-1; Wed,
 19 Aug 2026 10:37:49 -0400
X-MC-Unique: FijkyYWfMAOXCHr80iWfCg-1
X-Mimecast-MFC-AGG-ID: FijkyYWfMAOXCHr80iWfCg_1787150268
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 489A81801355; Wed, 19 Aug 2026 14:37:47 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 55C29195608A; Wed, 19 Aug 2026 14:37:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 04/15] qom/object.c: add
 object_class_property_add_uint8_ptr()
From: marcandre.lureau@redhat.com
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 philmd@mailo.com, aurelien@aurel32.net, peter.maydell@linaro.org, 
 pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com, 
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260819133816.3497033-5-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
 <20260819133816.3497033-5-mark.caveayland@nutanix.com>
Date: Wed, 19 Aug 2026 18:35:56 +0400
Message-Id: <178715015699.1965216.16761379017268314159.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=614;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DlAkU1FX6TFO9k550grFID3Jik0DNKA8gjp1evbCuFc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhb9QMHrZWZTMwe31cDp1UFEjPi2w5s6XqtlQI
 18fg43PA+2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoW/UAAKCRDa6OEJdZac
 5f+ED/9LVIoBQy97sc9JfWlIH9uiqSeGFoXaClOXd3xsofsFWyDOJkraLvrvsQrzFvcIddsWAzN
 /oyi1CgSnsMTsxj/+kximIwLedrCYdavqtiGwvC22lYxp8HFgI/J5HQz4oWQANTPIE/jpRYjIn0
 kO1Kw9Kfe0gAf9yKcZiRWcZFgpHZFifgG6Say5/0P9tOUN5SVTFvXKg2Az2T/Ykcc5sa0eQG2AK
 Zh9Y+1FuAm8em9uliTZYurIboVYOfXRIsMa6b3YeHaMhbvrgrDnewLS0S14xCbvUu7EwBhHQPje
 skLwQd13GX41wjP6zD2JIEnR4rXyvmq9O6fFHckNqdLjgSnIy6wrx2sq+roKXuTQ8fK0mf5d3/6
 oeYmkwbltph8794d91Zgz6ui/1ktGGIw3eX9I746DJiRXuxgHrOVnVLvhKI+ZPMVn2DtlCL4xpl
 x8K/DgU6f616RgSlkFsWO5C+t2QKarGdbvMqthmrY4e/TBhTzXAf6kLr3L/HHJkp38rTW+H66Zo
 m2ZtnkeJmhz0V4Deg4/x9SQ7r68wGtSlK3aHZL2M9WMHtR4+hUSNRphKEH1Fu9syXjl6gav9Oa3
 ZkiT8y6zyUsFWwpBQyMHhLnagbn2gL1bflMqQxoXepCT4WxjYcXPcBGsWPG/3bvJ6eOcQ2ddgyR
 6BcSpCRTpjgLP6w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Wed, 19 Aug 2026 14:35:43 +0100, Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> This adds a class property that references a uint8_t within the object instance
> and is intended to be a replacement for object_property_add_uint8_ptr().
> 
> This commit also removes the __attribute__((unused)) annotation from
> object_class_prop_ptr() which is no longer required now that the previous defined
> DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS() is now being used.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


