Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81392C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkU6-0007pV-Ex; Wed, 19 Aug 2026 13:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwkU1-0007lp-Og
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:53:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwkTw-0005Vl-Ob
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787162024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HqzhziJbLg9Beg70CfNjj/e2f0HBCUSeKhDmA25tSlc=;
 b=QkP3fhbXmoV6om1wFRAwyqEGhXG1L8dm1d39iqQvlbv4jBj4MAIFNkypmXdSZCW3Egmhym
 ESHJXDyZ9EXY8zGSxHXukrYLby8BPrMMHHdS0xbY6ZWvroiCKpFmFkDsFLq7v5dBt2rNxi
 zOGXZN48p6yimd2qy3af1v0HyrH6xAI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-olAFkFWcOmy4gInyttDf1g-1; Wed,
 19 Aug 2026 13:53:39 -0400
X-MC-Unique: olAFkFWcOmy4gInyttDf1g-1
X-Mimecast-MFC-AGG-ID: olAFkFWcOmy4gInyttDf1g_1787162018
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38C1E1956088; Wed, 19 Aug 2026 17:53:38 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 643A31944D02; Wed, 19 Aug 2026 17:53:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 15/15] hw/acpi/piix4.c: convert
 ACPI_PM_PROP_PM_IO_BASE to a class prop
From: marcandre.lureau@redhat.com
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 philmd@mailo.com, aurelien@aurel32.net, peter.maydell@linaro.org, 
 pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com, 
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260819133816.3497033-16-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
 <20260819133816.3497033-16-mark.caveayland@nutanix.com>
Date: Wed, 19 Aug 2026 21:52:43 +0400
Message-Id: <178716196337.2018258.4608435354854121649.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=365;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=m9+EguUJSWsU1WGvTCalrkP2HDKHXuG8wytilcQIX7o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhe1+Ob1Xqdn4bO36lPKVZj5WpdxAZ+e4n7Zjz
 Mg2NaN9uz2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoXtfgAKCRDa6OEJdZac
 5f21D/4gorjFZpH53kOCnoRgu3PmYAonyAzrGxlQvxayd+zr7nmj1DUOzpuvRiUk3rorIamzqeC
 Q0sMnWP/WihqX5RLf2uaL60YFv9SXKliyEdR87iN1ThRHCTrSQwmMHG1pmquEqhsy/snbixH+2J
 K3ZvMDGjJqSoaIKt0aPwTZDxIFmtIqrey+xPCOI5ei59cMxFR57oZMgXjqvpghZ79xWLRFt3oMj
 XMUe8lEvWZKdwW9/pGXX5TgtibLtPo1ZlE/OB6piZpTtUIlRutyHPihi6HwBR9tUybVsuaiCrk7
 mShO7DtVO3sQ5zXS3iFXJ79Jz4K5YRjgLRx4Lm3/TLQlS7m8jykL5kf5FZbolDCt+24Ppx+jf3P
 zCE5FOAwZixTiLBbAlth/hwT+wDhwPCCDEQ9Q+ZJym9Iu52K5bTWNLD+FBjVBPDU5ItMgCREMoK
 +pFP4/celsb9lDoBLNBZurgxBGlOYfjovAx9gpcsXhZ66F5d72LZUsq7NSVQCTXDNKOlSJ60tJt
 alnyHzQLJCaQygCKvijl9IYxt9FO6SV6Y+nKwpcUK/U26oE+aGNdgKEDGBaCPpihG7eDVUxr4zl
 cBpZ7iNGwBZMuWeqvbzt247Z25IoL/Xs9DlJXVcGIzPOv8Bdr0r0I1zd5Bqd5AVinqNINGW71Bs
 N8lBw2pCzShiXlg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 19 Aug 2026 14:35:54 +0100, Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> ACPI_PM_PROP_PM_IO_BASE can be converted to use object_class_property_add_uint32_ptr().
> Remove the now unused piix4_pm_add_properties() function.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


