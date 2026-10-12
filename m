Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0470FCA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGNx9-0000Sh-Tn; Mon, 12 Oct 2026 17:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGNx7-0000Rf-U8
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGNx6-0006P6-Ki
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791841979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zm4s2/L2v/mAmbAkLadyNmNJBfbwJnH2UoGTTxsbRVw=;
 b=A+qOo87mn4STJiVQMQFZ5OLJe99fAEtipfMcWGiO1wgk3/N7w/nu/qsy5MTqck1Wn4pmvE
 yDEYW7oXoKU/kt+2OCD+V4rCz2q0iU9DJhu3tokMySuZnJBhPAw/A5edQG39q2ubZUSdYq
 nFo2+ixguZT9KGKxdvfrCzoc1QPB490=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-_HbQCnGWMN6cilrJ1X7_Rw-1; Mon,
 12 Oct 2026 21:52:54 +0000
X-MC-Unique: _HbQCnGWMN6cilrJ1X7_Rw-1
X-Mimecast-MFC-AGG-ID: _HbQCnGWMN6cilrJ1X7_Rw_1791841971
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F73718004BB; Mon, 12 Oct 2026 21:52:51 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C354E30000E7; Mon, 12 Oct 2026 21:52:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 12/16] tests/functional: update arm64 tuxrun images
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Anders Roxell <anders.roxell@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>, 
 Klaus Jensen <its@irrelevant.dk>, Song Gao <gaosong@loongson.cn>, 
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261012170330.1144446-13-alex.bennee@linaro.org>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
 <20261012170330.1144446-13-alex.bennee@linaro.org>
Date: Tue, 13 Oct 2026 01:52:29 +0400
Message-Id: <179184194932.2190936.11219843257839761006.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=362;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6uLzsZS2mrHrMS0CRvtV0tVxsn8GSfzMnKfMuNuEe7w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzVafWl/bz8btFKUl1d+lYNNHr2ID2OptcDqJw
 PBaly6TP9WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas1WnwAKCRDa6OEJdZac
 5a52D/0Sea1n0+KieB2LMuKBnPNwqwCn0KENlbkta7NaFf6MznJAP/TvgjbtX5W3HRQUhxFQixl
 GdZdSG6wiMLStOwiXmYW1UbIgmxQ06BuHpKTcYJQQ3a3cfTHHO0nfK3Znibx8lgqX3Gz68oCfgf
 B4d+3EkGRwpnJ+6e35zDHwAnzTD7iHTBH2jpSORf0kiAI34ylEwWpKcGCEiScctzfau8PaOqp47
 GnX+NryobI18F5UlhdLFcS5e7byDdOykngY4gJNyEKsZomWgiZI+UZv8aT8vwNBOGsvZJ9DDq18
 cQzpfU3xQjTLA4dJaRWjI4IBsXJYnNHcwPD3Pgmlc7zxIIU1A5LKb6Rq8WMTATbeDHIkJYRoICU
 AjLdJtjoG/J8ZJEsOjO/+mR/kAIWZa2Z7zsAAry1S0/eDFo+GzwDG07NmnHMgnEmKSF/Ibttfmy
 3wdAOuvKvE5L6+LnCD0Lv2LKZfxMUBSz9uM4fYKK469/mxMsZsGEiFTZIiMQINOzXdP1bhPfqmA
 fW7oAE3tyMD1hVjSu1fT8mw6PPCtRmrVSO2IiU2rB+366W0lC17d7cRFJH5aLgFYnhIQ5XMHJcX
 QZ2XgBbBsU+6e+FdbJmVzG4YSJrQU/t5fPLSnQTsfAGfuIzWm9Q2ppBlk4MBMI+1hV0wTZRIF6o
 N/Fte9b11DioZtw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 12 Oct 2026 18:03:26 +0100, Alex Bennée <alex.bennee@linaro.org> wrote:
> We now split the fetching of the buildroot image from the kernel
> itself. This is because we will want to access additional metadata in
> future tests.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


