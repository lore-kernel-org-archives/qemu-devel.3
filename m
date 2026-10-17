Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE566CCA462
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI00u-0001SX-2G; Sat, 17 Oct 2026 04:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00r-0001Rt-EH
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00q-0007Ap-1U
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BiyZbVdy8aVVLG4+4ZntNDQR9SYYFnSEd/69fmnKGE0=;
 b=hZk5LQ43VeH9TcATCsyGVhNrAjs7kGFXAD2445NGvW2Y9+pLg/YmfsDAZLMP4qmqXs6Gf8
 hSi3YiGPhjOAtcO8/I4JtYdrBWZPviCmy0TtklhC0O1GmQKe/j7x0uT6jhPdR6iz+df5ek
 P9nGokQLMJbWRr95R14fBy3Nc4GDCZU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-oowNEegbOKK6uqkKVssf2w-1; Sat,
 17 Oct 2026 08:43:24 +0000
X-MC-Unique: oowNEegbOKK6uqkKVssf2w-1
X-Mimecast-MFC-AGG-ID: oowNEegbOKK6uqkKVssf2w_1792226603
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA400180064C; Sat, 17 Oct 2026 08:43:23 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0D471800495; Sat, 17 Oct 2026 08:43:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 08/23] target/ppc/cpu: constify cpu parameter for
 ppc_interrupts_little_endian
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-9-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-9-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:49 +0400
Message-Id: <179222656900.1619676.8061523284636052973.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=225;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lpSX1Ek06FyXlbXBls8HYr/gvJUUiTvOwn0BBiIpECw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zUMPr6UXqqcEajFKKD5Eq+D3KolsYaOwy1TB
 6GUdOu1aP6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1DAAKCRDa6OEJdZac
 5dcBEACJBH854lW2Hwz+ohbD5KNo6Ily8aBJsTDAMKZSUr2/xwtUinRgr3yrNV+IOlQgpS9t4Zs
 p0fMhruwdnCN0qQoBo3posI9HvI3C2t4i9JY4p32pU2PuSC3yi0gPN6wi1/DxyoTUQh0wtyph7c
 65nhx3JipmTxWISabYzZ2n9oEamJ19lfAWWkxoFlITWhKrzIjadC1r66iiIPoHb71A1FKomiA8e
 ebCVLBqViuS02jJ9WKJwHkQKTox5INghQrDDk1uJoIKkRE7F5ytc9ApmIRIpKxNlnUv5vu+E98D
 fotgaAm5mFdha/Nz1iEhh8RumAG3TXILCIhmt+0351AuOWl+ZTXR99XN4xCoCUxL7g9oB+cwV8z
 lTqhWrSTOeYtA8aDRO6FZBqE/tEwcpNOSTAs95fV7LgfpAE/eNuN/v1b8cdE+5S8JeAErJQGXtF
 ZDFpT2PiTLDidZFGBfq6eKChVLq0A8pD8s+851HbxQRcdT+YOG3KpaZnofmQxhe2fjg/NPJoH/l
 w4HAMeIdOznVSs2A3+d5hHeOeatTvMp5i3gtJPmxqj6FVK+KCla/oMu7Y9PiGrJ6WcMTVShSPKZ
 KMAoWw/kqk95zVC6mgTsPXloqxGA+LEGQmRmOYLFhrP8OqqWSCmpzNuxhV5HxcK2ZbGxvm2IePl
 byj53ZrgW9O9U/A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Fri, 16 Oct 2026 11:13:55 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> 


Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


