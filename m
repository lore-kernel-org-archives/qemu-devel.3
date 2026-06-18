Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FBBCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 11:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBLN-00011W-Ev; Thu, 18 Jun 2026 07:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1waBLJ-0000wv-D4
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:55:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1waBLB-0001SD-QA
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781783725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KylV9vv8vL/tf1ImZMvpvoxo3f0SsmUxsyL/R1Hl6qs=;
 b=I0wHiJKZhE1CK2YbR6VQPy30MXdbCl7eWbJbNW6L36Yx/3Q6K4Emsde8wDa245VHNC01lH
 ynoZDyz78QUEI9vNLdf8+q/ilEc5xV22WLDg988ypNoVZODTIPnXvDBPkCWIvA55cQtnIB
 QI42Je4BmHopX2q2p/KI2H7fPmfNbvA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-c8EdTsKiNpmL5yjtMCPhIg-1; Thu,
 18 Jun 2026 07:55:15 -0400
X-MC-Unique: c8EdTsKiNpmL5yjtMCPhIg-1
X-Mimecast-MFC-AGG-ID: c8EdTsKiNpmL5yjtMCPhIg_1781783710
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7CCF1956049; Thu, 18 Jun 2026 11:55:09 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C64330001A1; Thu, 18 Jun 2026 11:55:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 34/35] qemu-options: document new monitor-hmp and
 monitor-qmp objects
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
In-Reply-To: <20260618105836.991609-35-berrange@redhat.com>
References: <20260618105836.991609-1-berrange@redhat.com>
 <20260618105836.991609-35-berrange@redhat.com>
Date: Thu, 18 Jun 2026 15:54:32 +0400
Message-Id: <178178367256.2477794.17975070577719761677.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=379;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TYFr8zQYEhyjFZYl2lMBqbfsOzazWFwk8I1aRWDPtR0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqM9x7ynjsTOwV0EfhPEHRYnRU2TEjNSJBe17C5
 iZjZf7/nkyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajPcewAKCRDa6OEJdZac
 5QaqD/0X2M/RMLI6wV6wYnpO98Nm0Nqur0WF+0MwLXgqoMWOXrnpldvQDVpLJdRiOqojbYb1aFh
 r/jYXVqSY4LkuAYTgv+5jo++cVSVWa8YccNOqR2EwdtJoxkOQab9EWWyFJBJ9R5bRzW+AfdDLpS
 HXQjUkjqiUGHJNADzltvY6BBu285vdrx5IiVWmLyiNaD9XoCxSeDrXP17Ll+rtolXzVRelE6R+z
 hQQXyBwRTyxFsEnZwRuMP3hQA2h6yF7cbjEFXwopFEJF7y5ioLbbVOd+jWWPfmTTvwjAa3mtv8R
 76D+cjAgIs7nzOmG8CamKISsHmYjycMbHnE72uzZZKWbHCvysMgXOjBMwCxnrN7/YRasUmImK1q
 O2FWIvy+LWCK75vMu7BTDZ+UwZDupiM9TVF0TbuhGFZ96r7588zRc4DkAf+CQX9DSATwB3KaDsW
 iekoACSSY5hEU6UHMjGC7zXxG8hfUNAmghId7dV4oAmcCjo/NSZG8kjMmlG0eYXTt02dmp7oUNH
 yAl2bcM9Z/pWy1Zg00eJDflND+1y8XVKqPb30BH+m+kYvzx5WQ5QJ4D8zRE0GRBrX7uwazCqSUw
 toigpOjhKB/nznT+yGKfnEKEZe9pqFcVfX2x4EnapfC4PhBq4Wowtuba3IV83KHkZZS1b2/tZ/W
 hc8bIbc6ZWPrvaw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Thu, 18 Jun 2026 11:58:35 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> Add new docs for the `-object monitor-hmp` and `-object monitor-qmp`
> options, updating `-mon` to state that it is legacy syntax sugar
> for the new `-object` args.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


