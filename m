Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35482CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQIA-0001CO-Om; Wed, 10 Jun 2026 17:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQI6-0000zy-Me
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQI5-0007MK-7H
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VvEPChZ155x1NJdWQu98uRjmdrKZGF6eCimVuLDplAQ=;
 b=g0iVvckDj1//Qd6CvNENj1kG76c7hk5WRIdPWV7I2Nlq7nSqxHunvd0/MlGMlj8t68ZqGF
 GqGjZrBP7DNQC/qnwJVxRW1BVgCG5bW1nbCwDx4S5/wKwdhLIH+UHuF4MWoRKvr5wi2dMb
 8h8PZauzIWuEChUj6dI6qi1AHh6M/88=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-O9N25UDwNdKa4dA0OiRP4Q-1; Wed,
 10 Jun 2026 17:16:44 -0400
X-MC-Unique: O9N25UDwNdKa4dA0OiRP4Q-1
X-Mimecast-MFC-AGG-ID: O9N25UDwNdKa4dA0OiRP4Q_1781126203
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5592C18601F6; Wed, 10 Jun 2026 21:16:43 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0DA761954B06; Wed, 10 Jun 2026 21:16:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 32/35] qom: add trace events for user creatable
 create/delete APIs
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
In-Reply-To: <20260610123415.2883603-33-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-33-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:24 +0400
Message-Id: <178112600402.209622.3204230739046437579.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=214;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7SjlH1bQz2/9Il7ARFALmdI5RJ+r1oYDLUNVO6gd+Qk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdOGyl18+ynDFZ8in/5XI1hC+9m+gA6wVX5iB
 Jmvvon8Ip+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainThgAKCRDa6OEJdZac
 5VxTD/wMzK0hQwP6QK/9v0i0NgJprV6LN/Ow+ZtIqnrJtq0LdrjUsMVN7pLPmKfpJuMHXZr9Qav
 P1NL05YDiUbyMvPMITdIBxkhH5M+m9zeJfk0IWPney/A5/I0DCbkSXf+y8KsJFj/ewA4TVgHwg9
 6q/P8IdSf9sL5YKZbp/3Rcj9JNWuRYWjwU3cmWu6vGij86qeTEnK+pATcO8sfWBuwItb5tYLrZT
 oNA309gRpnz4MBfRSzgbQQltDiVdwoVNJt2H+rpiUMQyk9QCgaR2Gp3OQ6WPrYgIJXyoq65oTe7
 jMiQGLpb9lR4WqrTX0l2S7u4twu+sGWZRsvhjfuvn+z7cRX6MEu0V9cvn9xKH/6f2tox4w/7j2J
 NBDb+nKjmEqv4is0n+j4Y0I+r5tSbJ12OB/JtBOIUEySrcybM7QIJLqTNIYV3XN/t62qFUPRuGB
 pkWfmJ5ZrQWsVnQj+QPRAUQ3sG9AqcfE/HZsEnaDmIsOUYoMgYH8IQdq9bVzg6Avs027pUvbJvT
 jYf573M6IIqy89S0W7GcOj75N2eOZ0I9g4URrFSC6OfA82eXvOTqCJqH6JuqwK7H10T0yyV6iHT
 5+Ju451n+LG5dAvev010uRibqhIVpconXZ3B1quoq8nObxN5iNHiL7UA8lFrwvbthnFupGYnC6N
 YKLZXXfzlwCbRbQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Wed, 10 Jun 2026 13:34:12 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> 


Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


