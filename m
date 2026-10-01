Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2462CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCDJW-0005xD-Db; Thu, 01 Oct 2026 05:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDJU-0005wY-PX
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:42:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDJT-0003M8-Cs
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790847770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hPKGmgIpypvJqTYFQlYI1MgObW0+uwEUi9gTp0iJdm4=;
 b=hQ7CVchdVUl/5U9m1mZdMzrReD+t7MsrWdFjsCle6m5+rRZIOjF46zJbrN9gxZVEQtQztB
 aHLY40ERgRaexI+DaHLYyuP9UEe7dkuWYXeptXvmh5X2Uytgk4XnA86fXCp6zmLkTVN0GX
 bgANwavipIIPuQFFe/72EWUQqhwBVR4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-4r_LSfWyP1mznY4jGxMBRg-1; Thu,
 01 Oct 2026 05:42:47 -0400
X-MC-Unique: 4r_LSfWyP1mznY4jGxMBRg-1
X-Mimecast-MFC-AGG-ID: 4r_LSfWyP1mznY4jGxMBRg_1790847766
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 852F01955DBF; Thu,  1 Oct 2026 09:42:46 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B538B180029C; Thu,  1 Oct 2026 09:42:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 02/11] tests/unit/test-qemu-opts: Validate help=foo
 options
From: marcandre.lureau@redhat.com
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-Reply-To: <20260930221105.2262063-3-farosas@suse.de>
References: <20260930221105.2262063-1-farosas@suse.de>
 <20260930221105.2262063-3-farosas@suse.de>
Date: Thu, 01 Oct 2026 13:42:36 +0400
Message-Id: <179084775650.2086187.10493817396795815472.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=569;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=I60qRHQ97Y/uSerEuEQMBM3PDHEY9mb/4fA7+RJ8q1A=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvisPi5GAmL5arjiOTAhk7o/5PKziCXLd8glfH
 WpWPoQ0RPWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar4rDwAKCRDa6OEJdZac
 5RtID/9EhNr3OWigrJg82rfOg4vCwn28uVcFGgJpeDwJ7dXd1w1DHQDGpHpUbUIQRLHLUFAmEG3
 1QQ/D4OXMUXoyK5yGlLmYvByf4Q6c1j9SixZ/IhM5eiThWfU8nqx99aCHLqQjaHzcRpB6XbxSpQ
 Ii0QmK6HhTdEUmVQaiyJ9dm7v3FhbeIzsRxhUZ6kM5/mmQgqDyaMPjxy1N0MgvquaY1c2OKnk6A
 rOvYdC0mnPxn4FSU1m4mBuDdMGq5MZdfYK78bh7Oz6QiuX35w3I/2PBny35p9fJtI66ynmFWpzH
 tLv7+pvY9iSr4A4on4907ATDxkYITLvW0CJLZfYHy5Qn1m9Va5q3ngVi6s+3YrB1eLpkc4Oj351
 7dLV5OLbQl0Jm4GVsf0YZI3YcK9Te9uAHTobeXYEt0MnEO00k5R4kAmqrVbH+qoBzxbYYJ9tQw0
 aeQF/ztleUJaBMPNOi3pcUpuwyAVtTVNU6Z0lvMEOwMYyMAYTp5+nAHlylTb+4awLaoQULLM7Hh
 CkVBWfsJOtTeiiaYPjY1enidmbVZur1uWu6EHXJzVEYdIkrY24GE2rVMRhliJcmukoK+1GZNmvC
 hJirRS4J+VoZoosJaLuXASylvbJ5t5K1qXQRuE83uiOCFyOaTdskN36vTqg+5v0ps9bh0vKnR4E
 gWUhuOOXLuyKlyQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Wed, 30 Sep 2026 19:10:56 -0300, Fabiano Rosas <farosas@suse.de> wrote:
> The test_has_help_option currently tests two functions:
> has_help_option() and qemu_opt_has_help_opt(). The former is only used
> by qemu-img and has a significant difference from the latter, which is
> used by QOM and qdev:
> 
> - has_help_option() REJECTS help=on and all variants that provide a
> value, including invalid ones such as help=foo.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


