Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF202C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhPu-0006Pj-SV; Wed, 19 Aug 2026 10:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwhPs-0006Ob-W3
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwhPr-0004rv-Jg
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787150239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fXNfbCFpf0/btftD46HfZgLOMXcrjEx6iGiZ6fM7eF8=;
 b=KMBhSFk5nAVe046DPgdVkV+K/bq35x4RCLaM4Z8+3oPFhLt6W/ciZeH8hH8z1MpYl8c+Ph
 +8LaTsmyOGhs5oQfF5jdUBPrBwwKqK/VzZFn7zi3z0Uq7HWaYpz4w7QapoW5GSfHmseG3F
 brCFLL0tMiqe+h2eHnksDchxEa6kT8c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-HGvoB6X8NcW-wg_Dei_0tg-1; Wed,
 19 Aug 2026 10:37:15 -0400
X-MC-Unique: HGvoB6X8NcW-wg_Dei_0tg-1
X-Mimecast-MFC-AGG-ID: HGvoB6X8NcW-wg_Dei_0tg_1787150234
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0E9319560BB; Wed, 19 Aug 2026 14:37:13 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84DC318005BB; Wed, 19 Aug 2026 14:37:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 03/15] qom/object.c: introduce
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS() macro
From: marcandre.lureau@redhat.com
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 philmd@mailo.com, aurelien@aurel32.net, peter.maydell@linaro.org, 
 pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com, 
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260819133816.3497033-4-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
 <20260819133816.3497033-4-mark.caveayland@nutanix.com>
Date: Wed, 19 Aug 2026 18:35:56 +0400
Message-Id: <178715015698.1965216.9695621141670723616.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=300;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QBUyc8yNKaTsBQULoq4jEuyn4LkAl5i99gkS/gblnro=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhb9QNt4mLTmb4w9LjJb8smS3LprzneHm2JTW7
 avUUXfGlfeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoW/UAAKCRDa6OEJdZac
 5daaD/4ojZfQPLKfpTExvU7onsh1nvoijasFAMJ+JDlAVg1sa+LZESHFpzsq5yXWFZtULJD2cTT
 8n4ae0h4sjdid5GPWqgF02Kv/lOLAwG38pVAC66/KGeEf2+KQqNzeK70NwDE3ZO6i7G+hi5iRNw
 HNoRezAE6trCpGY+FpADsp+fvavOLz/S+rkVQbZ6aiySp17yw4oCpapxVN3uKQcC8sRXaqFjVE7
 3QGnwzEwz5fVkHZcu2g31QHSq0vycMTuxJfwmZYfCQ266KA6PmYVdt8r+oxxGezKrq8TXXePE0I
 pD0AxnQeoMx8V4gcBZAgtiweG0uOHOf5f3Ig5A/lliJN+0zJ/S1IDDp4Zuh6lieyP2MroSDTBWH
 a7iSs70fJW49Yzjgq5rxBSnDCEyJjeVfGsPoeWYTfaAYC4F0MBQ0qg7D/My2kMssf0nMGl6QJgd
 6IlFUgs5SjzI+iV9Op4uqak39vYW/ONuvWtv4KXsKscSuweedOwv8shbt31iCF110l/qROcAn9a
 avi0ERe4RmPTw8FXU/3z0lt0XUralM0VJa/858L2wkxLT4Xt3AlVi32jkXpMj1v9pDd9xEIq4Tc
 fOOdT33HU+AqUYeWQi/jcGt1oTySK5mvuMSXW/ZNgO51iJrSEXQAiHxmFwXszNM56i9MqVQC1N3
 WKU5MYETRe80/zA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Wed, 19 Aug 2026 14:35:42 +0100, Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> This macro defines both the QOM get and set functions for the given scaler
> type.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


