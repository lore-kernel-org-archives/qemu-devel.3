Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9C3C61CE4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyPHB-0006TG-Rc; Mon, 24 Aug 2026 03:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPH7-0006T0-C5
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPH5-0006FP-NZ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787557158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A0rJEd+prsIAbeIg0gLfipR6SjbPODwU+47EpvUlYfA=;
 b=SPFjaC94EPkurQfYuALcg2gaTmhvYRLxiPkqvKrcwT33ogceIa4ga85qymJBFUoQ7g+YoH
 PVLOtzQquIUOgzfyucpKVXUSmUS4v8QvpdCCrNaAf67TFUeWQ97MeYgGswZvY0JDvuZT6f
 fZQdI5Fr/e8zhjZcllZvCrwqVPAGJSI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-U97sTUOaPeSbMSNIWf-PMg-1; Mon,
 24 Aug 2026 03:39:15 -0400
X-MC-Unique: U97sTUOaPeSbMSNIWf-PMg-1
X-Mimecast-MFC-AGG-ID: U97sTUOaPeSbMSNIWf-PMg_1787557153
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 741461944E42; Mon, 24 Aug 2026 07:39:13 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4AD1C1800348; Mon, 24 Aug 2026 07:39:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 06/12] python: fix license configuration
From: marcandre.lureau@redhat.com
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Cleber Rosa <crosa@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260824052859.880475-7-jsnow@redhat.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-7-jsnow@redhat.com>
Date: Mon, 24 Aug 2026 11:38:46 +0400
Message-Id: <178755712686.3526866.8369853978838398087.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=339;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=PnwRQtZl808v5ryLU6z/Xt8uJHvC9zdSqZ+ZveiKaQo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqi/UKS+FdcemjDrUgUSCW2vR5AP9WdftrWfdRq
 Li2hLovltKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaov1CgAKCRDa6OEJdZac
 5aVdEACwI2jgXeK61bBnrK+bRABIXGDJDDrf4m0BiPkryR/dY2tVsl8YkyKQo1CjOrjF3ztJq2Y
 Oj8NfaAJYXtcO9hhFxlxbdqBE7NpPWZF9iCCCT9QYkTDYOcpOw6/9/Kask62c+QYN8a/F2qtm/A
 Wfrtk7oGF8IkvKqgdn3y0zBtxU9wLqqyUsqBf1Y8hL6Rl6EQOejxDU4nmUp1B8vlGqld6dLh19R
 2LMMsZ1D+54UkDlnnR2QteB4MJiyDeHpAHG97DDRrVX8IH0pYKvhgpxIMh5KUxmGBppg1Jfj2WF
 5IM+ZiOyIilOE5U8Z/LPd6K/N4DLXGQqZho3tQK/jrvU4TFnlFgHTVuGt4BJszfq9L1/lIlKsFc
 AtsbPs3ocxxOzygbEyu51tScju85SKvgYaTWuPdorv8beQmUg+b8HZKYGCYt7qvXlPeIHT8tunE
 UvL+bisC2C2VvSw0XR6HDmnCku4NMyKZKa1lyr90aTyXBViee7wdK14MI7LxgKtBJms7993RIP3
 1Aj3OCQ5kkml3hjxg5TBHD87EGZlWCeQfDh0H7Wn+DQCatKQNJsm+Z9xy1RAx7AC+GOKybr5kxb
 kSMY98/Nuf0CbijUs8IwSXz9vEwh4T5aypVXRPKjd84DQnxuzUkgQCYGQQV9yY2R7UmC30ufEGx
 xDcyIHQNuF8RTOg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, 24 Aug 2026 01:28:52 -0400, John Snow <jsnow@redhat.com> wrote:
> License trove identifiers were deprecated in favor of SPDX
> identifiers, correct this to stop some whining from various python
> tooling.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


