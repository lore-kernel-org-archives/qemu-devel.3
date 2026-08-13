Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC9DC5DF65
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 06:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuOqA-00089I-No; Thu, 13 Aug 2026 02:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wuOq8-00088Z-Hd
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 02:22:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wuOq6-0002s4-L9
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 02:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786602173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J6JxmQz2eb1kFvFv4T3fZe3K08Sc5nnUziiWAlQli88=;
 b=J3olmNrO6b+WAIFx/E7UGCqXG0NQnjX3X/ynRgmgO/1lwKWt9mGVz7Icu+QFxtxFj6hWm+
 s7EjY2RsUkm/t1xHJv1Lmev8kq7DTTH/KlpWA54zDoYG0gETFmGyGGGGWQBgyScEpPKyKy
 ZjsYrpjkvTqvTotm2uYbCaYl4B8O4x8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-tmRVzgiGMbaNPZpIxIQOsQ-1; Thu,
 13 Aug 2026 02:22:44 -0400
X-MC-Unique: tmRVzgiGMbaNPZpIxIQOsQ-1
X-Mimecast-MFC-AGG-ID: tmRVzgiGMbaNPZpIxIQOsQ_1786602163
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D6BE1955F39; Thu, 13 Aug 2026 06:22:43 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3258F195608A; Thu, 13 Aug 2026 06:22:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 17/23] monitor: Rename MonitorQMP @mon -> @qmon
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20260812211708.92824-18-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
 <20260812211708.92824-18-philmd@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 10:22:28 +0400
Message-Id: <178660214825.3552881.16834360265143429528.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=550;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TyThmU+Oyc/U0SeMOkG+GJdnqNiZGUFs6I1hObJYVmM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfWKm3oqRT5b5mM/H9HcjZxHO1DgzRWyJGFl6d
 huMxzIM5v+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCan1ipgAKCRDa6OEJdZac
 5Rg4EACYiLp7Ukc5EnxJ1AJWkxMBKoMXO8O34b4s0c3CNtiQkp3JbkdQqXDZdSlrIsUfEd3ZVRz
 +pNZslq+Qvx38H+NBKNb4uXD2f7LlA4mwD0BwnS7f+B4T1QDIdYFtlvcbwvY1Jix3fudypxyXKm
 SASHnci9Cj/jUC5smk+h9Rk/O/lTM+k35FL1JuAByg58W94xjM4ZvnuFOIDKl7hrUDDvaFxeXQj
 yXeVlPqQ51o5EbfWDOlQQY2poO0Xb6vcZkqxICgeIQP16QpoyBkIbS462HG0ITU6+BZrnUaFe+P
 YiSiu8a8LMBe5mzWCjm1ONvJaz1XMSlIRpT3QMC2nNewooazCn5uv+tIeQUlUY2FL1gkYGSx+VE
 noBlA6eeb2cCVj3cuKXi6CV1VvPXuE6zRfRq+opgHPWMItjT2eJA4jxHws/tpUnO2hn/5u0ka8G
 3RyOokPGwWeAPv/jS1/pP0CiI5CScRK8mHEjEbKypqL4nEOyAsIcZIMWZhNOMDzkuG9kEgSDiNb
 oazhCCXe9YUhcsYyqvlKCLaaVkPDe8Vlj36JQgLl3rRXCkpP8hk7WkOkhIiN3TEufpTJ4T0IPaA
 eo2PDA26s4HycDr/bWqPMVZ1s+LOWUNDsxdCiPsXsEaNZoTc50rbQ0wEKWjBq5vLrYljWdKsZDQ
 DPOol57FjpAX4hg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

> Mechanical change to sanitize using the following patterns:
> 
>   MonitorQMP *qmon  (this patch)
>   MonitorHMP *hmon  (following one)
>   Monitor *mon
> 
> Rename @mon (and @qmp_mon) as @qmon when the type is MonitorQMP.

This patch and the following are conflicting quite directly with
the work I have for --disable-hmp.
(https://gitlab.com/marcandre.lureau/qemu/-/tree/no-hmp)

Can we delay them?

fwiw, I picked Monitor *mon, MonitorHMP *hmp. I didn't touch MonitorQMP*.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


