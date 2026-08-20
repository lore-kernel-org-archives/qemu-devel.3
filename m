Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E24C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx21L-0006aJ-R6; Thu, 20 Aug 2026 08:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx21J-0006Wq-OA
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx21I-0006oB-D9
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787229439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aD3WSlz17gRUXu5VRUGo784GvTHxsl5ywiBiwJn/QNU=;
 b=OKibIv8MTAYcCBBFA/R9rQltxt6GUAexK90jS6j6qNpPJ78bftayzHGBSbVLKy8gPyH8oB
 /E24RLiqE75cA30gaAVyEn9vBjrJLKmzHic+YAg4FBePBvEgvei5tNM/Z36ZeyjILId430
 WavjshsDJhH1W6rDoL14hcuGL2hOQEA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-gIIxu6JUMH6BS7vt01IcLA-1; Thu,
 20 Aug 2026 08:37:15 -0400
X-MC-Unique: gIIxu6JUMH6BS7vt01IcLA-1
X-Mimecast-MFC-AGG-ID: gIIxu6JUMH6BS7vt01IcLA_1787229434
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92B881956096; Thu, 20 Aug 2026 12:37:13 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F8163001DAF; Thu, 20 Aug 2026 12:37:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 04/13] target/mips: Constify CPUMIPSState for various
 cpu_*() getters
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-arm@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>
In-Reply-To: <20260820104730.25462-5-philmd@oss.qualcomm.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-5-philmd@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 16:36:07 +0400
Message-Id: <178722936785.2678991.13883422805821533744.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=314;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/a5AwAxdbCNPtizKuzkDgyOXHlA8Gds00D3yfIgUYh4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhvS7zPMODv3T/ZVy8k3QV8DKdrd3FIO0Kr7JG
 pGOYPjnKgiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaob0uwAKCRDa6OEJdZac
 5Ub0D/9zCl/A4yQ0UeadcsgZ+KY9aMmIbuve1KolizSYwF1vSy2oPsDDN3o8xPUm7VKh/8dsNq+
 ISrcbCUWjm8vT6UFnpBFG0anQZNFDHf2FSo1ZDJRtqdhmNVlKOE7mkw0+Adhi3oPJxBxo0KM+WY
 emAh/VqR+XgA4q1OHdD3ur89SSF1eyGQxh/yfuC6IjwqSUg1n7uO/6ouP8ynBbiOtHO3CQLe8I/
 7mFFEL8Qd7csooMcov7MNoLwYun8CNNI0A4v8g32OoZAak6ajsh7o5Vl1J/0uzlfnQ1HQcvOKTt
 +D2ZuClz+UcODb/GZJX6OdPIlteck33OqwyxyY2rOjw9oB18F8xnmkBRox47nIGvtF2twetEDVk
 bps/Zoq57rV6Y3c3OK1frLdpDQErYVS7R7HhTku2LkEXArTHUAKS2zrgrFeXsNFYXPES1/PrqOx
 TbihuMXNmdtDQOMacASkq7djCzpRXop9oDCOdD7t50boZ8+He2HBt+1i32ni3H0AH4mmT4DRNR5
 OTRgGoVxXL0567hswjcLEbKz60OlMbMDa6C/5T2kT0qGPBH8VkRWmooDqbfkbvR3RaoevXM20Pu
 xBMSRXnVomkEX6UHO5/nFnJSAxfU65VfuZnMwhhya9W+yJYIQ+ryrlovLZ3CqP24pqVLVbCbjgr
 PWHjesh5XvMfi4A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Thu, 20 Aug 2026 12:47:20 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> Add the const qualifier to CPUMIPSState when
> the argument is accessed without modification.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


