Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375C7C5DF88
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx20h-000686-Fv; Thu, 20 Aug 2026 08:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx20f-000663-MU
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx20d-0006Wp-KW
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787229398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SyIrUJ4ZEGH644EnpJSVW4AfShdefM3b8kTGXEQDYyY=;
 b=BlCyLoxQ0Mbc8Vk0NE/XrKGRqU9eAX+CFaU+S0jnjBa9H6k+6svdYeq+FoPQy/NtPxE9ZM
 Jpmc6VnZ9I1KEzKKmqPb5j01ClQOoBhFN3YHtMwKK404Lol1ed9yiaRG4QEAHGlu48jL/r
 3qmTyu6R9zoOtRpkaIbGE06pDfYnUVw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-_nTvX7Z3Owey1dnvOZxVBA-1; Thu,
 20 Aug 2026 08:36:29 -0400
X-MC-Unique: _nTvX7Z3Owey1dnvOZxVBA-1
X-Mimecast-MFC-AGG-ID: _nTvX7Z3Owey1dnvOZxVBA_1787229387
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 876101956057; Thu, 20 Aug 2026 12:36:26 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D149180049F; Thu, 20 Aug 2026 12:36:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/13] target/avr: Constify CPUAVRState for some
 cpu_*() getters
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-arm@nongnu.org, Michael Rolnik <mrolnik@gmail.com>
In-Reply-To: <20260820104730.25462-2-philmd@oss.qualcomm.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-2-philmd@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 16:36:07 +0400
Message-Id: <178722936782.2678991.14256057558241529411.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=313;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=AWe1gsODmirYPJ+eCGKDjH8WgmFj69kReYCj1l19Cak=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhvS6RnzpNppwMofNiXE8GNy8MVmXtYQ0G/Ikr
 D78U2DCJB+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaob0ugAKCRDa6OEJdZac
 5SVLD/oD6TMt7O53yyYzjMzvZer+oJC71/9tHj/zLbSjgffTdeY3RCQp9i8u9jZ9uKs+WDSn6LP
 0PWBtswNb0smRZQyG1EcNl/sHOfnJ4dKKIQy/tzYRLT1RyJWmc+Wli+VVxCpYC03sws1yF0Thp4
 NTUqBgDlsOBg9f/AN6qhseN+97oeVLJg/QNV5mzKSwnhWwfVeR+mcrJAHeh69rUFfrqbKqn45jN
 oJQEZKXtNHAX3LlS85fGmcyk2eHQ5excLP+H5nEI8MI+jR0CA4JIN37x9QZfk10ZYKE4U+e5CwN
 EORjktyC/j/1EFrA48rBk+mRwgn7bIoNuC963zqXVX8HgSqd4VU4QoSQDfgrafGJEEG+Uo7Q4X2
 on+CvXCMZr8wfyQMO3u20FK7/yNaXdYDR8nGKMp1YENi9XDuMCGpCIkU0jZS+BCRwhn+R0lwy3+
 as6f79wsBMlDEOi3LDxtqRQXbGfPT6vs605lHD8rGizsqkDjSENfUXxxupOx/Vecnz48FyI+x1k
 +CrfIBSbm3kFlIp3XJPLIuvgZo5hLG5s4WS4GQIF9vWONEGTNw8vKnLuW1ijUpsH8LAD0p8LmK+
 L+P1rVfefSeRnlNoSvsCtEjfK7+KqFFqPlcF2uheOBmrIk5Cgp5LB3dZMg4c6hbaSE0D2p3Gwqt
 vPz2Bd3MHc8O3zg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Thu, 20 Aug 2026 12:47:17 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> Add the const qualifier to CPUAVRState when the
> argument is accessed without modification.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


