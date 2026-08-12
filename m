Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AFFC5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9as-0000Um-Fw; Wed, 12 Aug 2026 10:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9ao-0000U8-R2
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9al-00036E-Tj
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786543562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vTYhQ5jxeavXQ1JHWeD+rCi6jSxA9zL3MyMImBeDzMs=;
 b=HQmLc9zX+Vyk8AGgjv7781YYywXe+ipRc8HtMYshffcI12ur40iqHNeN2PdXq3W2IeN/3t
 1nL61CPnN5K3fKdUo3MpwoAYlA7SG6UgIsbTtCqTorzDAYKUxp27RiIKkwU9U3H5BJR/xB
 KfVRGe+PAjldNGYOSLkOOX+vKwBbVMM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-Qmu-WgqxNGeISs8K9V-EBA-1; Wed,
 12 Aug 2026 10:05:58 -0400
X-MC-Unique: Qmu-WgqxNGeISs8K9V-EBA-1
X-Mimecast-MFC-AGG-ID: Qmu-WgqxNGeISs8K9V-EBA_1786543557
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E223195604B; Wed, 12 Aug 2026 14:05:56 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0DA0B19560AB; Wed, 12 Aug 2026 14:05:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 02/16] tests/unit: Include 'qemu/main-loop.h' header
 in test-util-sockets.c
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20260812131147.83188-3-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
 <20260812131147.83188-3-philmd@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 18:05:43 +0400
Message-Id: <178654354335.2071945.13654728489164132864.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=575;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=snrmJ5tOWjXeySURB86tKzy7QyX+vpZ036wGj4eFtr4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfH26hJ5StuF8lNlAhMwxr1YEpk4idyXNtFuqu
 FDpXdhFLHaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanx9ugAKCRDa6OEJdZac
 5YwaEACvfev59o42WLj69it+jlmJKG741QEKcyKDflXl+NWxtDANwPUpFAmLIEAjNyLVYwTtaeR
 Tj1K3XzlCY9qTTX+RdtSz7C6orJqGrU6FSXp2/LgX4ca9itta/S3+J/dt8mrs38HQwNNH3WT+hK
 UdAPVJaN1KGLZQO+uvCDz3oWYW4AafrZgzi83DNYp/XdBBwwqot237VNTBiMlAhaMZRuJ8zEGDI
 k+sUgT38wA5bBF2Se6b37OQq32OYA91V7EZq/0HBdPE82OjM3r30Sq+0x5ugoIdyOjRTg0QTfF/
 aRfQHeiBIM6Qq6YulX86vHNAs+G0xzyABk6m1YitTJzinqkcaXefifWEDYXlkJ3OcSzzu59yJWa
 NWCeKtHnr6vO+6vBjjaTH0XnoFmbDOZkEQJS/X4qixJEcpo7ScQEMs8AiZarbZHWQ7/CNP1vssx
 LN/nKhgK84aNq9DO8XkZlDGZALOf3DKXl63BP70C0BwpL9pr9ImAy8zBk7CJxi7fXQC9qI+5tWo
 Tp7nM9d9z1XlL71aIOaCsr2/w1BFnhtXg9HWPnBFRWBlXXopXF+puBbJ29eAYV5QT0vQjNlKWgj
 ZlLOAkQBhn8iHvG6d2yZjFxTyT166pOHDJ22wywstIgbnXt24RbGpaFMSgfyVhino8owoMsunvA
 k6Ms8Cqx3Q0D81A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Wed, 12 Aug 2026 15:11:33 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> test-util-sockets.c calls qemu_init_main_loop(), itself declared in
> the "qemu/main-loop.h" header. Include the latter to avoid when
> refactoring unrelated headers:
> 
>   ../tests/unit/test-util-sockets.c:553:5: error: call to undeclared function 'qemu_init_main_loop'
>   553 |     qemu_init_main_loop(&error_abort);
>       |     ^
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


