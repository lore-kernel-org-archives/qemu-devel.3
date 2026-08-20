Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A92CC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx21J-0006V9-0X; Thu, 20 Aug 2026 08:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx21H-0006Uj-Cm
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx21F-0006nH-Qw
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787229437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pHfgwLFHYIsIWGzCZazqd0r9XHzvoPEgYeF9/YSPK5Y=;
 b=Ncm18ZTxG4gr9k9o6z49yEts3AWU1251atXupAHTIvlKcLH5Ydws+ZM+UeJvICaqhojDlD
 eZGiWQY69fMIhNcOlE2c1Ys6D5pqrbylApfUsCT039ZrNZVE7HIyLpmYuWHs5Q0OgdWkVw
 nAeRGFogwgfkf+duzgGfkp4pw71ivO0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-YhHl9vEdO2e5-q4-l2qEKw-1; Thu,
 20 Aug 2026 08:37:07 -0400
X-MC-Unique: YhHl9vEdO2e5-q4-l2qEKw-1
X-Mimecast-MFC-AGG-ID: YhHl9vEdO2e5-q4-l2qEKw_1787229424
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C46F51956067; Thu, 20 Aug 2026 12:37:03 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 431521955F03; Thu, 20 Aug 2026 12:36:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 03/13] target/loongarch: Constify CPULoongArchState for
 various cpu_*() getters
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-arm@nongnu.org, Song Gao <17746591750@163.com>, 
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>
In-Reply-To: <20260820104730.25462-4-philmd@oss.qualcomm.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-4-philmd@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 16:36:07 +0400
Message-Id: <178722936784.2678991.4872963525375256180.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=331;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rKxCgpAfixD1HqOmJPmDZGGAB99eLikzfSaSRqxa3aI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhvS71rnR6WCxLwWg6hOOnLhUyMCL3ltOOfmCm
 zj2EERTxPSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaob0uwAKCRDa6OEJdZac
 5ZdeEAC6teocZ947VPiKbjLaM4T1tz4HLt4OxW9TaegWxR3gw4Bjt/4jbuh3JvVtIR3FO1zFZw3
 Nlpn50KcKn+/PfusRZuzSuFekICIjFrluAFWcWspCj3Oa7sB3SwDe7mzrhQMvj1gS7CDR1/qk29
 ITj9AomPPktTOuzaAVmk47ZAm/ju09Hr9g2TcxN3ahW4BviHrVcSRtL+yBSlbaq2aynw/lfDlPa
 kjRW7y5CaNwxzX7NMeQVUYxGVuS4d9+JBp6zjzM3Fcr3SCAy1SHoveNv0i2iusR1qG6+H4h6IZ1
 qd6P0Co9+ug6rUvWZMere69ImhdIQe9HeHQL0U9TfwkQalcHQjqFz65sgMm5TxTTIzQ6DoP7l8H
 S7wErxkoKBiCpui3k50/TMs5UETLT0ndT5VKKTuuqenUYg9ZkoWe0OXMt807Tap/oTNy24ZjNCf
 +g6eLgrRLHUu0yXeOBU12bnvnWpLsP8Ui9h32dsMR+KAquTv2wZOKoH8Zxu/Vf2PIOvQwv0Ke5C
 Dy+FrgCp/PMLbl9xQh9SFackEfqjMNDmEkisODWVQFThjTFYI5kn96kdcXaG5QBK9Vlx9DBAc3P
 3w8RQ9ERGykngypHK4hiHWFCqiN+1cp26nL0J/dGqh0WZumn88ApTBfMAKVvCafPwezUGijDVED
 gQ/nap7cTIvsZyA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 20 Aug 2026 12:47:19 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> Add the const qualifier to CPULoongArchStatCPUMIPSStatee when
> the argument is accessed without modification.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


