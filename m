Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6387BCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 11:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBLG-0000tc-SG; Thu, 18 Jun 2026 07:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1waBL7-0000tE-Ik
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:55:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1waBL6-0001Eh-5U
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781783719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S5WOwJgd4qzqW2o2LRdH87eS16abPk0Q5oAHkBXlH3s=;
 b=EcBoAOWnNBje7Ya2Ao9Ev6TX6cK0oVmcO012K5GJ5CDR+DCvv20G/RMtTIlTtZkEmjViDe
 UC72m7rWTFrrV1IbW1Ga8YDheVZXmtKg5YoEp2wWTrsxkcBSd1vg9gs5bFic+Ngiboa4JU
 A1noAOwFoNeaCaakfrZtl8EIP/ukG2k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-W0XKl70-NX6GHWnu1Be50w-1; Thu,
 18 Jun 2026 07:55:16 -0400
X-MC-Unique: W0XKl70-NX6GHWnu1Be50w-1
X-Mimecast-MFC-AGG-ID: W0XKl70-NX6GHWnu1Be50w_1781783715
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B8E418007D2; Thu, 18 Jun 2026 11:55:15 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4E491688; Thu, 18 Jun 2026 11:55:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 35/35] docs: mark '-mon' as deprecated in favour of
 -object
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260618105836.991609-36-berrange@redhat.com>
References: <20260618105836.991609-1-berrange@redhat.com>
 <20260618105836.991609-36-berrange@redhat.com>
Date: Thu, 18 Jun 2026 15:54:32 +0400
Message-Id: <178178367257.2477794.7323633662644773385.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=419;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hLUnmWGYxznB3nueSGUz5Ck2Yx+GcltQYXDcj3lreCk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqM9x7Rz1m2XCtbO3TEr+x047UXKT+e6zZIOhum
 whCJUN/PceJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajPcewAKCRDa6OEJdZac
 5cklEACRGsIuLgyuoFr5HDbvYcRmUsz4J6JhLfYetfiCPAy3iM/fq80XJICJvrdX0raC1I4Kq/L
 9BHZBHUwlOLjUN/+swqhMNkveQtp10jbIZj3+FAmrSb/5GHkoB1FZz5XraDsYdAFlzUN3uQqa2O
 gqhcy3GzOpKwuqgzEWUqK6Y+Kju80gnFZ/Pdh8Aa2FtiMm+Epa71RqyP0szC6dFeJQYaHN+PmGK
 WijM+sNQxkGmKECDouPNfzV2PY3Gj85jiH9qKtkleDZ+NiROFgBekJCY04W0b8hRtM16il+qBh0
 rlYLda45oTEUnAbeyHTLEmcYDWhO4uGk6ekDGr7r6AbJnBG/OYVQl9EaV8xpGGe+MQuHKsddu+0
 EDc6icGAbWrUmKY8FKZy8UJcPAOEv53z/u0UbhZiZypJIgLWoGMn00KbgjoT0VnCNRYgeRSZXqn
 DGFSVnDjCMrSPNaffoNjkx64kN4E1yXLc1Sj8fqNl4ZSyhKv5EodjBcXFUtlqyDZm19His1dsjo
 +iKjk/YOeHCpM2P6BfqnYdts7XAIFRnDtlTx40yhfXLn4BOlJmNiav9PaHL36szmaYllYsRBhZk
 tr7ivK1RaQVqOo1oiU5rg5lX44LiK+da4z7c+jkNaYT/AQPsZy38MG7rC9gLM36uZZKA+Ljg/d2
 yL1eQ+xu7pl8AoQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 18 Jun 2026 11:58:36 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> The high level `-qmp` and `-monitor` options can remain as convenience
> wrappers, but the low level `-mon` is completed obsoleted by the new
> `-object` support with 'monitor-qmp' and 'monitor-hmp' types.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


